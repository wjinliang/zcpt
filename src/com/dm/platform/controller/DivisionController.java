package com.dm.platform.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.app.util.UUIDUtil;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.Org;
import com.dm.platform.service.DivisionService;
import com.dm.platform.service.OrgAndUserService;
import com.dm.platform.util.DmDateUtil;

@Controller
@RequestMapping("/division")
public class DivisionController extends DefaultController {
	@Resource
	DivisionService divisionService;
	@Resource
	OrgAndUserService orgAndUserService;
	@Resource
	CommonDAO commonDAO;

	/**
	 * 获取所有区划组织
	 * @param model
	 * @param request
	 * @return
	 */
	/*@RequestMapping("/list")
	public ModelAndView list(ModelAndView model, HttpServletRequest request) {
		try {
			model.addObject("totalcount", divisionService.countMenuGrou());
			model.setViewName("/pages/admin/division/list");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}*/
	@RequestMapping("/list")
	public ModelAndView list(ModelAndView model, HttpServletRequest request) {
		try {
			List ml = new ArrayList();
			List<Division> divisionList = new ArrayList<Division>();
				divisionList = this.orgAndUserService.findSheng();
			for (Division division : divisionList) {
				Map m = new HashMap();
				m.put("id", division.getId());
				m.put("name", division.getName());
				if (division.getParent() != null)
					m.put("pId", division.getParent().getId());
				else {
					m.put("pId", "");
				}
				String hql = " from Division d where d.parent.id ='"
						+ division.getId() + "'";
				List<Division> sonList = this.commonDAO.find(hql);
				if (sonList != null && sonList.size() > 0) {
					m.put("isParent", "true");
				}
				ml.add(m);
			}
			JSONArray json = JSONArray.fromObject(ml);
			model.addObject("orgStr", json.toString());
			//model.addObject("totalcount", divisionService.countMenuGrou());
			model.setViewName("/pages/admin/division/list");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/load")
	public void load(HttpServletResponse response) {
		try {
			List ml = new ArrayList();
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "CODE"));
			List<Division> olist = commonDAO.findAll(Division.class, orders);
			for (Division org : olist) {
				Map m = new HashMap();
				m.put("id", org.getId());
				m.put("name", org.getName());
				if (org.getParent() != null) {
					m.put("pId", org.getParent().getId());
				} else {
					m.put("pId", 0);
				}
				ml.add(m);
			}
			JSONArray json = JSONArray.fromObject(ml);
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(json.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/form/{mode}")
	public ModelAndView form(HttpServletRequest request, ModelAndView model,
			@PathVariable String mode,
			@RequestParam(value = "orgid", required = false) String orgid) {
		try {
			Division o = new Division();
			if (mode != null && !mode.equals("new")) {
				if (orgid != null) {
					o = divisionService.findOne(orgid); 
					model.addObject("org", o);
					if(mode.equals("view")){
						model.setViewName("/pages/admin/division/view");
						return Model(model);
					}
				}
			} else {
				if (orgid != null) {
					o.setSeq(commonDAO
							.count("select count(*) from Division o where o.parent.id='"
									+ orgid+"'") + 1);
					Division division = this.commonDAO.findOne(Division.class, orgid);
					if(division!=null && division.getLevel()!=null){
						o.setLevel(division.getLevel()+1);
					}
					model.addObject("parentid", orgid);
				} else {
					o.setSeq(commonDAO
							.count("select count(*) from Division o where o.parent is null") + 1);
					o.setLevel(0);
				}
				model.addObject("org", o);
			}
			model.setViewName("/pages/admin/division/form");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/save")
	public ModelAndView save(ModelAndView model, Division org,
			@RequestParam(value = "parentid", required = false) String parentid) {
		String id = UUIDUtil.getUUID();
		try {
			Division o = new Division();
			if (org.getId() != null && !org.getId().equals("")) {
				o = divisionService.findOne(org.getId());
				o.setName(org.getName());
				o.setCode(org.getCode());
				o.setSeq(org.getSeq());
				o.setBigDivision(org.getBigDivision());
				o.setFullName(org.getFullName());
				o.setType(org.getType());
				o.setLevel(org.getLevel());
				divisionService.updateOrg(o);
				model.setViewName("/pages/admin/division/success");
			} else {
				if (parentid != null && !parentid.equals("")) {
					o = divisionService.findOne(parentid);
					org.setParent(o);
				}
				org.setCreateTime(DmDateUtil.Current());
				org.setId(id);
				divisionService.insertOrg(org);
				model.setViewName("redirect:form/edit?orgid="+org.getId());
			}
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/setseq")
	public void setseq(
			HttpServletResponse response,
			@RequestParam(value = "currentid", required = false) String currentid,
			@RequestParam(value = "targetid", required = false) String targetid,
			@RequestParam(value = "moveType", required = false) String moveType,
			@RequestParam(value = "moveMode", required = false) String moveMode)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (currentid != null && targetid != null) {
				Division starto = new Division();
				Division targeto = new Division();
				starto = divisionService.findOne(currentid);
				targeto = divisionService.findOne(targetid);
				Long start = starto.getSeq();
				Long limit = targeto.getSeq();
				if (!moveType.equals("inner")) {
					if (moveMode.equals("same")) {
						if (start > limit) {
							Long sl;
							if (moveType.equals("prev")) {
								sl = limit;
							} else {
								sl = limit + 1;
							}
							for (Long i = start - 1; i >= sl; i--) {
								Division entity = new Division();
								List<Division> orglist = new ArrayList<Division>();
								if (targeto.getParent() != null) {
									entity.setParent(targeto.getParent());
									orglist = commonDAO.findAll(Division.class,
											" and t.parent = :parent and t.seq = "
													+ i, entity);
								} else {
									orglist = commonDAO.findAll(Division.class,
											" and t.parent is null and t.seq = "
													+ i, entity);
								}
								for (Division org : orglist) {
									org.setSeq(i + 1);
									divisionService.updateOrg(org);
								}
							}
							starto.setSeq(sl);
							divisionService.updateOrg(starto);
						} else if (start < limit) {
							Long tl;
							if (moveType.equals("prev")) {
								tl = limit - 1;
							} else {
								tl = limit;
							}
							for (Long i = start + 1; i <= tl; i++) {
								Division entity = new Division();
								List<Division> orglist = new ArrayList<Division>();
								if (targeto.getParent() != null) {
									entity.setParent(targeto.getParent());
									orglist = commonDAO.findAll(Division.class,
											" and t.parent = :parent and t.seq = "
													+ i, entity);
								} else {
									orglist = commonDAO.findAll(Division.class,
											" and t.parent is null and t.seq = "
													+ i, entity);
								}
								for (Division org : orglist) {
									org.setSeq(i - 1);
									divisionService.updateOrg(org);
								}
							}
							starto.setSeq(tl);
							divisionService.updateOrg(starto);
						}
					} else {
						Long currentcount;
						if (starto.getParent() != null) {
							currentcount = commonDAO
									.count("select count(*) from Division o where o.parent.id='"
											+ starto.getParent().getId()+"'") + 1;
						} else {
							currentcount = commonDAO
									.count("select count(*) from Division o where o.parent is null") + 1;
						}
						for (Long i = start + 1; i < currentcount; i++) {
							Division entity = new Division();
							List<Division> orglist = new ArrayList<Division>();
							if (starto.getParent() != null) {
								entity.setParent(starto.getParent());
								orglist = commonDAO.findAll(Division.class,
										" and t.parent = :parent and t.seq = "
												+ i, entity);
							} else {
								orglist = commonDAO.findAll(Division.class,
										" and t.parent is null and t.seq = "
												+ i, entity);
							}
							for (Division org : orglist) {
								org.setSeq(i - 1);
								divisionService.updateOrg(org);
							}
						}

						// -------------------------------------------------

						Long targetcount;
						if (targeto.getParent() != null) {
							targetcount = commonDAO
									.count("select count(*) from Division o where o.parent.id='"
											+ targeto.getParent().getId()+"'");
						} else {
							targetcount = commonDAO
									.count("select count(*) from Division o where o.parent is null");
						}
						Long startc;
						if (moveType.equals("prev")) {
							startc = limit;
						} else {
							startc = limit + 1;
						}
						for (Long i = targetcount; i >= startc; i--) {
							Division entity = new Division();
							List<Division> orglist = new ArrayList<Division>();
							if (targeto.getParent() != null) {
								entity.setParent(targeto.getParent());
								orglist = commonDAO.findAll(Division.class,
										" and t.parent = :parent and t.seq = "
												+ i, entity);
							} else {
								orglist = commonDAO.findAll(Division.class,
										" and t.parent is null and t.seq = "
												+ i, entity);
							}
							for (Division org : orglist) {
								org.setSeq(i + 1);
								divisionService.updateOrg(org);
							}
						}
						starto.setParent(targeto.getParent());
						starto.setSeq(startc);
						divisionService.updateOrg(starto);
					}
				} else {
					Long currentcount;
					if (starto.getParent() != null) {
						currentcount = commonDAO
								.count("select count(*) from Division o where o.parent.id= '"
										+ starto.getParent().getId()+"'") + 1;
					} else {
						currentcount = commonDAO
								.count("select count(*) from Division o where o.parent is null") + 1;
					}
					for (Long i = start + 1; i < currentcount; i++) {
						Division entity = new Division();
						List<Division> orglist = new ArrayList<Division>();
						if (starto.getParent() != null) {
							entity.setParent(starto.getParent());
							orglist = commonDAO.findAll(Division.class,
									" and t.parent = :parent and t.seq = " + i,
									entity);
						} else {
							orglist = commonDAO.findAll(Division.class,
									" and t.parent is null and t.seq = " + i,
									entity);
						}
						for (Division org : orglist) {
							org.setSeq(i - 1);
							divisionService.updateOrg(org);
						}
					}
					Long count = commonDAO
							.count("select count(*) from Division o where o.parent.id='"
									+ targeto.getId()+"'") + 1;
					starto.setParent(targeto);
					starto.setSeq(count);
					divisionService.updateOrg(starto);
				}
			}
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
		}
	}

	@RequestMapping("/delete")
	public void delete(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "orgid", required = false) String orgid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (orgid != null) {
				Division o = new Division();
				o = commonDAO.findOne(Division.class, orgid);
				List<Org> ualist = commonDAO.findByPropertyName(
						Org.class, "division.id", orgid);
				for (Org userAccount : ualist) {
					userAccount.setDivision(null);
					commonDAO.update(userAccount);
				}
				commonDAO.delete(o);
				out.write("ok");
				out.flush();
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
		}
	}
}
