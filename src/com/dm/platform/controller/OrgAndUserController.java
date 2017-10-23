package com.dm.platform.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.ApplicationInfo;
import com.app.util.TimeUtil;
import com.app.util.UUIDUtil;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;
import com.dm.platform.service.OrgAndUserService;
import com.dm.platform.service.OrgService;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.target.FormToken;
import com.dm.platform.util.ExcelExportUtils;
import com.dm.platform.util.ReadProperties;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping({ "/orgAndUser" })
public class OrgAndUserController extends DefaultController {
	@Resource
	CommonDAO commonDAO;
	@Resource
	OrgAndUserService orgAndUserService;
	@Resource
	OrgService orgService;
	@Resource
	UserAccountService userAccountService;
	String ZSsystemId;

	ReadProperties readProperties = ReadProperties.getInstance();
	{
		try {
			ZSsystemId = readProperties.getProperties("zhuisu.systemId");
		} catch (IOException e) {
			System.err.print("dm.properties 加载  'zhuisu.systemId' 失败!");
			e.printStackTrace();
		}
	}

	@RequestMapping({ "/listOrgs" })
	public ModelAndView list(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "divisionid", required = false) String divisionid,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "tj", required = false) String name) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			String divisionidStr = divisionid == null ? null : "'" + divisionid
					+ "'";
			Long totalcount = this.orgAndUserService.countOrg(divisionidStr,
					name);

			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			Org currentorg = getOrgByCurrentUserNoSession();
			JSONArray json = getCurrentDivision(divisionid, currentorg);
			model.addObject("orgStr", json.toString());
			List<Org> orgList = this.orgAndUserService.listOrgs(divisionidStr,
					name, thispage, pagesize);
			model.addObject("orgList", orgList);
			if (divisionid == null) {
				model.addObject("divisionid", currentorg.getDivision().getId());
			} else {
				model.addObject("divisionid", divisionid);
			}
			model.addObject("IsTopDivision","1".equals(currentorg.getDivision().getId()));
			/*
			 * List<ApplicationInfo> appList = this.commonDAO
			 * .findAll(ApplicationInfo.class); model.addObject("appList",
			 * appList);
			 */
			model.setViewName("/pages/admin/orgUser/list");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}


	private JSONArray getCurrentDivision(String divisionid, Org org) {
		List ml = new ArrayList();
		String ids = "";

		List<Division> parentList = this.orgAndUserService
				.getParents(divisionid);
		List<Division> divisionList = new ArrayList<Division>();
		if (divisionid != null && !divisionid.equals("")) {
			Division division = org.getDivision();
			divisionList.add(division);
		} else {
			if (org != null) {
				Division division = org.getDivision();
				if (division != null) {
					divisionList = this.orgAndUserService
							.getSonLevelDivisionList(division.getId());
					divisionList.add(division);
				} else {
					divisionList = this.orgAndUserService.findSheng();
				}
			} else {
				divisionList = this.orgAndUserService.findSheng();
			}
		}
		for (Division division : parentList) {
			ids = ids + division.getId() + ",";
			//if (division.getParent() != null) {
				String hql = " from Division d where d.parent.id ='"
						+ division.getId() + "' order by d.code";
				List<Division> sonList = this.commonDAO.find(hql);
				divisionList.addAll(sonList);
			//}
		}

		for (Division division : divisionList) {
			Map m = new HashMap();
			m.put("id", division.getId());
			m.put("name", division.getName());
			if (division.getParent() != null)
				m.put("pId", division.getParent().getId());
			else {
				m.put("pId", "");
			}
			String hql = "select count(*) from Division d where d.parent.id ='"
					+ division.getId() + "'";
			Long sonList = this.commonDAO.count(hql);
			if (sonList != null && sonList > 0) {
				m.put("isParent", "true");
			}
			if (ids.contains(division.getId())) {
				m.put("open", Boolean.valueOf(true));
			}
			ml.add(m);
		}
		JSONArray json = JSONArray.fromObject(ml);
		return json;
	}

	private Org getOrgByCurrentUserNoSession() {
		/*
		 * UserAccount currentUserAccount = UserAccountUtil.getInstance()
		 * .getCurrentUserAccount(); return
		 * orgAndUserService.loadOrg(currentUserAccount);
		 */
/*		UserAccount currentUserAccount = UserAccountUtil.getInstance()
				.getCurrentUserAccount();
		Org currentOrg = currentUserAccount.getOrg();*/
		Org currentOrg  = UserAccountUtil.getInstance().getCurrentUserAccountOrg();
		return currentOrg;
	}

	@RequestMapping({ "/loadSonDivision" })
	public void loadSonDivision(
			ModelAndView model,
			HttpServletResponse httpServletResponse,
			@RequestParam(value = "divisionid", required = false) String divisionid) {
		try {
			httpServletResponse.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = httpServletResponse.getWriter();
			List ml = new ArrayList();
			if (divisionid == null) {
				List<Division> divisionList = this.orgAndUserService
						.findSheng();
				for (Division d : divisionList) {
					Map u = new HashMap();
					String orgId = d.getId();
					String orgName = d.getName();
					String parentId = d.getParent() != null ? d.getParent()
							.getId() : null;

					u.put("id", orgId);
					u.put("pId", parentId);
					u.put("name", orgName);
					String hql = " from Division d where d.parent.id ='"
							+ d.getId() + "'";
					List<Division> sonList = this.commonDAO.find(hql);
					if (sonList != null && sonList.size() > 0) {
						u.put("isParent", "true");
					}
					ml.add(u);
				}
				JSONArray jsonArray = JSONArray.fromObject(ml);
				writer.write(jsonArray.toString());
				writer.flush();
				writer.close();
				return;
			}
			String divisionHql = " from Division d where d.parent.id='"
					+ divisionid + "' order by d.code";
			List<Division> divisionList = this.commonDAO.find(divisionHql);
			for (int j = 0; j < divisionList.size(); j++) {
				Map u = new HashMap();
				Division division = divisionList.get(j);
				String orgId = division.getId();
				String orgName = division.getName();
				String parentId = divisionid;

				u.put("id", orgId);
				u.put("pId", parentId);
				u.put("name", orgName);
				String hql = " from Division d where d.parent.id ='"
						+ division.getId() + "'";
				List<Division> sonList = this.commonDAO.find(hql);
				if (sonList != null && sonList.size() > 0) {
					u.put("isParent", "true");
				}
				ml.add(u);
			}
			JSONArray jsonArray = JSONArray.fromObject(ml);
			writer.write(jsonArray.toString());
			writer.flush();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/form/{mode}")
	@FormToken(save=true)
	public ModelAndView form(
			HttpServletRequest request,
			ModelAndView model,
			@PathVariable String mode,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "flag", required = true) String flag,
			@RequestParam(value = "divisionid", required = true) String divisionid) {
		try {
			Org o = new Org();
			if (mode != null && !mode.equals("new")) {//编辑
				if (orgid != null) {
					o = orgService.findOne(Long.valueOf(orgid));
					model.addObject("org", o);
					if (flag.equals("1")) {
						if (o.getParent() != null) {
							//System.out.println(o.getParent().getId());
							model.addObject("parentid", o.getParent().getId());
						}
					}
					if (mode.equals("view")) {
						model.setViewName("/pages/admin/org/view");
						return Model(model);
					}
				}
			} else {
				if (orgid != null) {
					
					o.setSeq(commonDAO
							.count("select count(*) from Org o where o.parent.id="
									+ orgid) + 1);
					model.addObject("parentid", orgid);
				} else {
					Division d = UserAccountUtil.getInstance().getCurrentUserAccountOrgDivision();
					
						if(!d.getId().equals("1")){
							model.setViewName("403");
							model.addObject("msg","您没有这个权限,请联系上级管理员!");
							return Model(model);
						}
					o.setSeq(commonDAO
							.count("select count(*) from Org o where o.parent is null and o.division.id='"
									+ divisionid + "'") + 1);
				}
				o.setCode(getOrgCode(divisionid,null));
				o.setDivision(commonDAO.findOne(Division.class,divisionid));
				model.addObject("org", o);
			}
			if (flag.equals("0")) {
				String hql = " from Division d where d.id = '" + divisionid
						+ "' or d.parent.id = '" + divisionid
						+ "' order by d.code";
				List<Division> divisionList = this.commonDAO.find(hql);
				model.addObject("divisionList", divisionList);
			} else {
				String hql = " from Division d where d.id = '" + divisionid
						+ "'  or d.parent.id = '" + divisionid
						+ "' order by d.code";
				List<Division> divisionList = this.commonDAO.find(hql);
				model.addObject("divisionList", divisionList);
			}
			if (orgid != null && !orgid.equals("")) {
				if (o.getDivision() != null) {
					model.addObject("divisionid", o.getDivision().getId());
				}
			} else {
				model.addObject("divisionid", divisionid);
			}
			model.addObject("flag", flag);
			model.addObject("mode", mode);
			model.setViewName("/pages/admin/orgUser/form");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	private String  getOrgCodebak(String divisionid ,String orgid){
		String orgSumHql = "select max(o.code) from Org o where o.division.id='"
				+ divisionid + "'";
		String code = this.commonDAO.max(orgSumHql);
		Division division = this.commonDAO.findOne(Division.class,
				divisionid);
		Org org = new Org();
		if (orgid != null && !orgid.equals("")) {
			org = this.commonDAO.findOne(Org.class, Long.valueOf(orgid));
		}
		// TODO null
		String orgLshCode = org.getCode();
		String orgLsh = division.getCode() + "001";
		if (orgLshCode != null && !orgLshCode.equals("")
				&& orgLshCode.startsWith(division.getCode())) {
			//System.out.println("-------");
			orgLsh = orgLshCode;
		} else {
			if (code != null && !code.equals("")) {
				Long valueOf = Long.valueOf(code);
				orgLsh = String.valueOf(valueOf + 1);
			}
		}
		return orgLsh;
	}
	
	private String  getOrgCode(String divisionid ,String orgid){
		Division division = this.commonDAO.findOne(Division.class,
				divisionid);
		String divisionCode = division.getCode();
		if(divisionCode.length()>6){
			divisionCode = divisionCode.substring(0,6);
		}
		String orgSumHql = "select max(o.code) from Org o where o.code like '"
				+ divisionCode + "%'";
		
		String code = this.commonDAO.max(orgSumHql);
		Org org = new Org();
		if (orgid != null && !orgid.equals("")) {
			org = this.commonDAO.findOne(Org.class, Long.valueOf(orgid));
		}
		// TODO null
		String orgLshCode = org.getCode();
		String orgLsh = divisionCode + "001";
		if (orgLshCode != null && !orgLshCode.equals("")
				&& orgLshCode.startsWith(division.getCode())) {
			//System.out.println("-------");
			orgLsh = orgLshCode;
		} else {
			if (code != null && !code.equals("")) {
				Long valueOf = Long.valueOf(code);
				orgLsh = String.valueOf(valueOf + 1);
			}
		}
		return orgLsh;
	}
	@RequestMapping({ "/chooseDivision" })
	public ModelAndView chooseDivision(ModelAndView model,
			@RequestParam(value = "orgid", required = false) String orgid) {
		try {
			List ml = new ArrayList();
			UserAccount currentUserAccount = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			Org org = currentUserAccount.getOrg();
			List<Division> divisionList = new ArrayList<Division>();
			if (org != null) {
				Division division = org.getDivision();
				if (division != null) {
					divisionList = this.orgAndUserService
							.getSonLevelDivisionList(division.getId());
					divisionList.add(division);
				} else {
					divisionList = this.orgAndUserService.findSheng();
				}
			} else {
				divisionList = this.orgAndUserService.findSheng();
			}
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
				if (division.equals(org.getDivision())) {
					m.put("open", Boolean.valueOf(true));
				}
				ml.add(m);
			}
			JSONArray json = JSONArray.fromObject(ml);
			model.addObject("orgStr", json.toString());
			model.addObject("orgid", orgid);
			model.setViewName("/pages/admin/orgUser/chooseDivision");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/save")
	@FormToken(remove=true)
	public ModelAndView save(
			ModelAndView model,
			Org org,
			@RequestParam(value = "parentid", required = false) String parentid,
			@RequestParam(value = "flag", required = false) String flag,
			@RequestParam(value = "divisionid", required = false) String divisionid,
			@RequestParam(value = "divisionParentid", required = false) String divisionParentid) {
		try {
			Org o = new Org();
			if (org.getId() != null) {
				o = orgService.findOne(org.getId());
				o.setName(org.getName());
				o.setCode(org.getCode());
				o.setSeq(org.getSeq());
				if (divisionid != null && !divisionid.equals("")) {
					Division division = this.commonDAO.findOne(Division.class,
							divisionid);
					o.setDivision(division);
					o.setDivisionCode(division.getCode());
				}
				o.setType(org.getType());
				o.setLeadName(org.getLeadName());
				o.setLinkman(org.getLinkman());
				o.setSystemId(org.getSystemId());
				o.setPostalCode(org.getPostalCode());
				o.setPostalAddress(org.getPostalAddress());
				o.setFaxno(org.getFaxno());
				o.setPhoneno(org.getPhoneno());
				orgService.updateOrg(o);
				model.addObject("divisionid", divisionParentid);
				return NewRedirect(model, "/orgAndUser/listOrgs");
			} else {
				if (parentid != null && !parentid.equals("")) {
					o = orgService.findOne(Long.valueOf(parentid));
					org.setParent(o);
				}
				if (divisionid != null && !divisionid.equals("")) {
					Division division = this.commonDAO.findOne(Division.class,
							divisionid);
					org.setDivision(division);
					org.setDivisionCode(division.getCode());
				}
				UserAccount currentUserAccount = UserAccountUtil.getInstance()
						.getCurrentUserAccount();
				String time = TimeUtil.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
				org.setId(System.currentTimeMillis());
				org.setCreateUser(currentUserAccount.getName());
				org.setCreateDate(time);
				orgService.insertOrg(org);
				model.addObject("divisionid", divisionParentid);
				model.addObject("orgid", org.getId());
				model.addObject("flag", flag);
				return NewRedirect(model, "/orgAndUser/form/edit");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping({ "/listSon" })
	public ModelAndView listSon(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "orgid", required = true) String orgid,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "tj", required = false) String name) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			/*
			 * UserAccount currentUserAccount = UserAccountUtil.getInstance()
			 * .getCurrentUserAccount(); Org currentOrg =
			 * currentUserAccount.getOrg();
			 */
			Org currentOrg = this.getOrgByCurrentUserNoSession();
			Org org = this.commonDAO.findOne(Org.class, Long.valueOf(orgid));
			List<Division> sonDivisionList = new ArrayList<Division>();
			String sonids = "";
			Long totalcount = 0l;
			// if (org.getSystemId().equals(ZSsystemId)) {//追溯系统
			sonDivisionList = orgAndUserService.getSonLevelDivisionList(org
					.getDivision().getId());
			for (Division d : sonDivisionList) {
				sonids += "'" + d.getId() + "',";
			}
			if (sonids.endsWith(",")) {
				sonids = sonids.substring(0, sonids.length() - 1);
			}
			if (!sonids.equals("")) {
				totalcount = this.orgAndUserService.countOrg(sonids, name);
			}

			/*
			 * } else {//其他系统 totalcount =
			 * this.orgAndUserService.countSonOrg(orgid,name); }
			 */
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			String divisionid = org.getDivision().getId();
			JSONArray json = getCurrentDivision(divisionid, currentOrg);
			model.addObject("orgStr", json.toString());
			model.addObject("IsTopDivision","1".equals(currentOrg.getDivision().getId()));
			
			List<Org> orgList = new ArrayList();
			// if (org.getSystemId().equals(ZSsystemId)) {//追溯系统
			if (!sonids.equals("")) {
				orgList = this.orgAndUserService.listOrgs(sonids, name,
						thispage, pagesize);
			}
			/*
			 * } else {//其他系统 orgList =
			 * this.orgAndUserService.listSonOrgs(orgid,name, thispage,
			 * pagesize); }
			 */
			model.addObject("orgList", orgList);
			model.addObject("parentid", orgid);
			if (org.getDivision() != null) {
				model.addObject("divisionid", org.getDivision().getId());
			}
			/*
			 * List<ApplicationInfo> appList = this.commonDAO
			 * .findAll(ApplicationInfo.class); model.addObject("appList",
			 * appList);
			 */
			model.setViewName("/pages/admin/orgUser/sonList");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}


	@RequestMapping({ "/listUsers" })
	public ModelAndView listUsers(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "orgid", required = true) String orgid,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "tj", required = false) String name,
			@RequestParam(value = "xt", required = false) String systemId) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			/*
			 * UserAccount currentUserAccount = UserAccountUtil.getInstance()
			 * .getCurrentUserAccount(); Org currentOrg =
			 * currentUserAccount.getOrg();
			 */
			Org currentOrg = getOrgByCurrentUserNoSession();
			Org org = this.commonDAO.findOne(Org.class, Long.valueOf(orgid));
			Long totalcount = this.orgAndUserService.countUser(orgid, systemId,
					name);
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			/*List ml = new ArrayList();
			String ids = "";
			List<Division> parentList = new ArrayList<Division>();
			if (org.getDivision() != null) {
				parentList = this.orgAndUserService.getParents(org
						.getDivision().getId());
			}
			List<Division> divisionList = new ArrayList<Division>();
			if (currentOrg != null) {
				Division division = currentOrg.getDivision();
				if (division != null) {
					divisionList = this.orgAndUserService
							.getSonLevelDivisionList(division.getId());
					divisionList.add(division);
				} else {
					divisionList = this.orgAndUserService.findSheng();
				}
			} else {
				divisionList = this.orgAndUserService.findSheng();
			}
			for (Division division : parentList) {
				ids = ids + division.getId() + ",";
				if (division.getParent() != null) {
					String hql = " from Division d where d.parent.id ='"
							+ division.getId() + "' order by d.code";
					List<Division> sonList = this.commonDAO.find(hql);
					divisionList.addAll(sonList);
				}
			}
			int i = 0;
			for (Division division : divisionList) {
				// System.out.println(i);
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
				if (ids.contains(division.getId())) {
					m.put("open", Boolean.valueOf(true));
				}
				ml.add(m);
				// System.out.println(division.getId()+"==="+division.getName()
				// +"===="+i++);
			}
			JSONArray json = JSONArray.fromObject(ml);*/
			String divisionid = org.getDivision().getId();
			JSONArray json = getCurrentDivision(divisionid, currentOrg);
			model.addObject("orgStr", json.toString());
			List<UserAccount> userList = this.orgAndUserService.listUsers(
					orgid, systemId, name, thispage, pagesize);
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			List<ApplicationInfo> appList = this.commonDAO
					.findAll(ApplicationInfo.class,orders);
			model.addObject("appList", appList);
			model.addObject("userList", userList);
			model.addObject("orgid", orgid);
			model.setViewName("/pages/admin/useraccount/list");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping({ "/listMergeUsers" })
	public ModelAndView listMergeUsers(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "userid", required = true) String userid,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			// long currentTimeMillis = System.currentTimeMillis();
			Long totalcount = this.orgAndUserService.countMergeUser(userid);
			// long currentTimeMillis2 = System.currentTimeMillis();
			// System.out.println(currentTimeMillis2 - currentTimeMillis);
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			// long currentTimeMillis3 = System.currentTimeMillis();
			List<UserAccount> userList = this.orgAndUserService.listMergeUsers(
					userid, thispage, pagesize);
			// long currentTimeMillis4 = System.currentTimeMillis();
			// System.out.println(currentTimeMillis4 - currentTimeMillis3);
			model.addObject("userid", userid);
			model.addObject("userList", userList);
			model.setViewName("/pages/admin/useraccount/listMergeUsers");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	/*
	 * @RequestMapping({ "/gotoMergeUser" }) public ModelAndView
	 * gotoMergeUser(ModelAndView model,
	 * 
	 * @RequestParam(value = "userid", required = true) String userid) { try {
	 * String orgHql = " from Org o where o.parent.id is null"; List<Org>
	 * orgList = this.commonDAO.find(orgHql); List ml = new ArrayList(); for
	 * (int i = 0; i < orgList.size(); i++) { Map m = new HashMap(); Org org =
	 * orgList.get(i); m.put("id", org.getId()); m.put("name", org.getName());
	 * if (org.getParent() != null) { m.put("pId", org.getParent().getId()); }
	 * else { m.put("pId", ""); } m.put("isParent", "true"); ml.add(m); }
	 * UserAccount userAccount = this.commonDAO.findOne(UserAccount.class,
	 * userid); String userSql = " from UserAccount u where u.org.id is null";
	 * List<UserAccount> userList = this.commonDAO.find(userSql); for (int j =
	 * 0; j < userList.size(); j++) { Map u = new HashMap(); UserAccount user =
	 * userList.get(j); String userId = user.getCode(); String userName =
	 * user.getName(); u.put("id", userId); u.put("pId", ""); u.put("name",
	 * userName); if (userAccount.getMergeUuid() != null && user.getMergeUuid()
	 * != null) { if (userAccount.getMergeUuid().equals(user.getMergeUuid())) {
	 * u.put("nocheck", "true"); } else { u.put("nocheck", "false"); } } else {
	 * u.put("nocheck", "false"); } if
	 * (userAccount.getCode().equals(user.getCode())) { u.put("nocheck",
	 * "true"); } ml.add(u); } JSONArray jsonArray = JSONArray.fromObject(ml);
	 * model.addObject("orgStr", jsonArray.toString());
	 * model.addObject("userid", userid);
	 * System.out.println(jsonArray.toString());
	 * model.setViewName("/pages/admin/useraccount/user"); return Model(model);
	 * } catch (Exception e) { e.printStackTrace(); return Error(e); } }
	 */
	@RequestMapping({ "/gotoMergeUser" })
	public ModelAndView gotoMergeUser(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false, defaultValue = "0") Integer thispage,
			@RequestParam(value = "pagesize", required = false, defaultValue = "6") Integer pagesize,
			@RequestParam(value = "tj", required = false) String name,
			@RequestParam(value = "xt", required = false) String systemId,
			@RequestParam(value = "userid", required = true) String userid) {
		try {
			Long totalcount = this.orgAndUserService.countUser(null, systemId,
					name);
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			List<UserAccount> userList = this.orgAndUserService.listUsers(null,
					systemId, name, thispage, pagesize);
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			List<ApplicationInfo> appList = this.commonDAO
					.findAll(ApplicationInfo.class,orders);
			model.addObject("appList", appList);
			model.addObject("userList", userList);
			model.addObject("userid", userid);
			model.setViewName("/pages/admin/useraccount/user");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping({ "/loadSonOrgAndUser" })
	public void loadSonOrgAndUser(ModelAndView model,
			HttpServletResponse httpServletResponse,
			@RequestParam(value = "orgid", required = true) String orgid,
			@RequestParam(value = "userid", required = true) String userid) {
		try {
			httpServletResponse.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = httpServletResponse.getWriter();
			String orgHql = " from Org o";
			if (orgid != null && !orgid.equals("")) {
				orgHql += "  where o.parent.id =" + orgid;
			} else {
				orgHql += "  where o.parent.id is null";
			}
			List<Org> orgList = this.commonDAO.find(orgHql);
			List ml = new ArrayList();
			for (int i = 0; i < orgList.size(); i++) {
				Map m = new HashMap();
				Org org = orgList.get(i);
				m.put("id", org.getId());
				m.put("name", org.getName());
				if (org.getParent() != null) {
					m.put("pId", org.getParent().getId());
				} else {
					m.put("pId", "");
				}
				m.put("isParent", "true");
				ml.add(m);
			}
			UserAccount userAccount = this.commonDAO.findOne(UserAccount.class,
					userid);
			String userSql = " from UserAccount u where u.org.id =" + orgid;
			List<UserAccount> userList = this.commonDAO.find(userSql);
			for (int j = 0; j < userList.size(); j++) {
				Map u = new HashMap();
				UserAccount user = userList.get(j);
				String userId = user.getCode();
				String userName = user.getName();
				u.put("id", userId);
				u.put("pId", "");
				u.put("name", userName);
				if (userAccount.getMergeUuid() != null
						&& user.getMergeUuid() != null) {
					if (userAccount.getMergeUuid().equals(user.getMergeUuid())) {
						u.put("nocheck", "true");
					} else {
						u.put("nocheck", "false");
					}
				} else {
					u.put("nocheck", "false");
				}
				if (userAccount.getCode().equals(user.getCode())) {
					u.put("nocheck", "true");
				}
				ml.add(u);
			}
			JSONArray jsonArray = JSONArray.fromObject(ml);
			writer.write(jsonArray.toString());
			writer.flush();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping({ "/mergeUser" })
	public ModelAndView mergeUser(ModelAndView model,
			@RequestParam(value = "userid", required = true) String userid,
			@RequestParam(value = "userIds", required = true) String userIds) {
		try {
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			UserAccount user = this.commonDAO
					.findOne(UserAccount.class, userid);
			String[] userIdArray = userIds.trim().split(",");
			String uuid = null;
			if (user.getMergeUuid() != null && !user.getMergeUuid().equals("")) {
				uuid = user.getMergeUuid();
			} else {
				uuid = UUIDUtil.getUUID();
				user.setMergeUuid(uuid);
			}
			for (int i = 0; i < userIdArray.length; i++) {
				String infoCode = userIdArray[i];
				UserAccount mergeUser = this.commonDAO.findOne(
						UserAccount.class, infoCode);
				mergeUser.setMergeUuid(uuid);
				this.userAccountService.updateUser(mergeUser);
			}
			this.userAccountService.updateUser(user);
			model.addObject("userid", userid);
			return NewRedirect(model, "/orgAndUser/listMergeUsers");
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping({ "/deleteMerge" })
	public void deleteMerge(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "userid", required = false) String userid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (userid != null) {
				String[] rid = userid.split(",");
				for (String str : rid) {
					UserAccount findOne = this.commonDAO.findOne(
							UserAccount.class, str);
					findOne.setMergeUuid(null);
					this.userAccountService.updateUser(findOne);
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

	@RequestMapping({ "/getOrgLsh" })
	public void getOrgLsh(
			ModelAndView model,
			HttpServletResponse httpServletResponse,
			@RequestParam(value = "divisionid", required = true) String divisionid,
			@RequestParam(value = "orgid", required = true) String orgid) {
		try {
			httpServletResponse.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = httpServletResponse.getWriter();
			writer.write(getOrgCode(divisionid,orgid));
			writer.flush();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("/excelExport")
	public void excelExport(HttpServletRequest request, HttpServletResponse response,String orgId,
			@RequestParam(value = "tj", required = false) String name,
			@RequestParam(value = "xt", required = false) String systemId)
	{
		String fileName = "";
		Org o = this.orgService.findOne(Long.valueOf(orgId));
		try {
			//fileName = java.net.URLEncoder.encode("报名统计表", "ISO8859_1");
			fileName=new String((o.getName()+"导出用户").getBytes(), "ISO8859_1");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}  
		response.setContentType("application/vnd.ms-excel;charset=ISO8859_1"); 
		response.setHeader("content-disposition", "attachment;filename="+fileName+".xls");  
		OutputStream fOut = null;
		try {
			fOut = response.getOutputStream();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String whereSql = "";
		Map argMap = new HashMap();
		//List<UserAccount> list = this.userAccountService.listUserAccount(orgId, orgId, 0, 1000);
		List<UserAccount> list = this.orgAndUserService.listUsers(
					orgId, systemId, name, 0, 1000);
		String[] fields = {"loginname","name","gender","mobile","bizPhoneNo","schoolAge","address","title","speciality","email","fano","userType","systemId"};
		String[] names = {"登录名","姓名","性别"			,"手机","固话","学历","通讯地址",			"职称","专业","邮箱","传真","用户类型","系统标识"};
		Workbook workbook;
		try {
			workbook = ExcelExportUtils.getInstance().inExcel(list, fields, names);
			workbook.write(fOut);  
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			try {
				fOut.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
