package com.dm.platform.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.MenuGroup;
import com.dm.platform.model.UserMenu;
import com.dm.platform.model.UserRole;
import com.dm.platform.service.UserMenuService;

@Controller
@RequestMapping("/usermenu")
public class UserMenuController extends DefaultController {

	@Resource
	CommonDAO commonDAO;
	@Resource
	UserMenuService userMenuService;

	@RequestMapping("/list")
	public ModelAndView list(ModelAndView model) {
		try {
			// setPagesize(7);
			model.setViewName("/pages/admin/menu/list");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/form/{mode}")
	public ModelAndView form(HttpServletRequest request, ModelAndView model,
			@PathVariable String mode,
			@RequestParam(value = "menuid", required = false) String menuid) {
		try {
			if (mode != null && mode.equals("edit")) {
				if (menuid != null && !menuid.equals("")) {
					UserMenu um = commonDAO.findOne(UserMenu.class, new Long(
							menuid));
					model.addObject("userMenu", um);
					model.addObject("mode", mode);
				}
			} else if (mode != null && mode.equals("view")) {
				if (menuid != null && !menuid.equals("")) {
					UserMenu um = commonDAO.findOne(UserMenu.class, new Long(
							menuid));
					model.addObject("userMenu", um);
					model.setViewName("/pages/admin/menu/view");
					return Model(model);
				}
			} else {
				if (menuid != null && !menuid.equals("")) {
					model.addObject("parentid", menuid);
					UserMenu um = new UserMenu();
					um.setSeq(commonDAO
							.count("select count(*) from UserMenu um where um.puserMenu.id="
									+ menuid) + 1);
					model.addObject("userMenu", um);
				} else {
					UserMenu um = new UserMenu();
					um.setSeq(commonDAO
							.count("select count(*) from UserMenu um where um.puserMenu is null") + 1);
					model.addObject("userMenu", um);
				}
			}
			model.setViewName("/pages/admin/menu/form");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/save")
	public ModelAndView save(ModelAndView model, UserMenu userMenu,
			@RequestParam(value = "parentid", required = false) String parentid) {
		try {
			UserMenu um = new UserMenu();
			if (userMenu.getId() != null) {
				um = commonDAO.findOne(UserMenu.class, userMenu.getId());
				um.setIsShow(userMenu.getIsShow());
				um.setName(userMenu.getName());
				um.setOpen(userMenu.getOpen());
				um.setIcon(userMenu.getIcon());
				um.setSeq(userMenu.getSeq());
				um.setDetail(userMenu.getDetail());
				um.setUrl(userMenu.getUrl());
				um.setIsCommon(userMenu.getIsCommon());
				userMenuService.updateUserMenu(um);
			} else {
				if (parentid != null && !parentid.equals("")) {
					um = commonDAO.findOne(UserMenu.class, new Long(parentid));
					userMenu.setPuserMenu(um);
				}
				userMenu.setId(System.currentTimeMillis());
				userMenuService.insertUserMenu(userMenu);
			}
			userMenuService.refreshService();
			model.setViewName("/pages/admin/menu/success");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/delete")
	public void delete(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "menuid", required = false) String menuid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (menuid != null) {
				UserMenu um = commonDAO.findOne(UserMenu.class,
						new Long(menuid));
				Set<MenuGroup> mset = new HashSet<MenuGroup>();
				mset = um.getMenugroups();
				for (MenuGroup menuGroup : mset) {
					menuGroup.getMenus().remove(um);
					commonDAO.update(menuGroup);
				}

				Set<UserRole> rset = new HashSet<UserRole>();
				rset = um.getRoles();
				for (UserRole userRole : rset) {
					userRole.getMenus().remove(um);
					commonDAO.update(userRole);
				}
				um.setMenugroups(null);
				um.setRoles(null);
				userMenuService.updateUserMenu(um);
				userMenuService.deleteUserMenu(um);

			}
			userMenuService.refreshService();
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			userMenuService.refreshService();
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
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
				UserMenu startum = commonDAO.findOne(UserMenu.class, new Long(
						currentid));
				UserMenu targetum = commonDAO.findOne(UserMenu.class, new Long(
						targetid));
				Long start = startum.getSeq();
				Long limit = targetum.getSeq();
				if (!moveType.equals("inner")) {
					if (moveMode.equals("same")) {
						if (start < limit) {
							Long tl;
							if (moveType.equals("prev")) {
								tl = limit - 1;
							} else {
								tl = limit;
							}
							for (Long i = start + 1; i <= tl; i++) {
								List<UserMenu> ulist = new ArrayList<UserMenu>();
								UserMenu entity = new UserMenu();
								if (startum.getPuserMenu() != null) {
									entity.setPuserMenu(startum.getPuserMenu());
									ulist = commonDAO.findAll(UserMenu.class,
											" and t.puserMenu = :puserMenu and t.seq = "
													+ i, entity);
								} else {
									ulist = commonDAO.findAll(UserMenu.class,
											" and t.puserMenu is null and t.seq = "
													+ i, entity);
								}
								for (UserMenu userMenu : ulist) {
									userMenu.setSeq(i - 1);
									commonDAO.update(userMenu);
								}
							}
							startum.setSeq(tl);
							commonDAO.update(startum);
						} else if (start > limit) {
							Long sl;
							if (moveType.equals("prev")) {
								sl = limit;
							} else {
								sl = limit + 1;
							}
							for (Long i = start - 1; i >= sl; i--) {
								List<UserMenu> ulist = new ArrayList<UserMenu>();
								UserMenu entity = new UserMenu();
								if (startum.getPuserMenu() != null) {
									entity.setPuserMenu(startum.getPuserMenu());
									ulist = commonDAO.findAll(UserMenu.class,
											" and t.puserMenu = :puserMenu and t.seq = "
													+ i, entity);
								} else {
									ulist = commonDAO.findAll(UserMenu.class,
											" and t.puserMenu is null and t.seq = "
													+ i, entity);
								}
								for (UserMenu userMenu : ulist) {
									userMenu.setSeq(i + 1);
									commonDAO.update(userMenu);
								}
							}
							startum.setSeq(sl);
							commonDAO.update(startum);
						}
					} else {
						Long currentcount;
						if (startum.getPuserMenu() != null) {
							currentcount = commonDAO
									.count("select count(*) from UserMenu u where u.puserMenu.id="
											+ startum.getPuserMenu().getId()) + 1;
						} else {
							currentcount = commonDAO
									.count("select count(*) from UserMenu u where u.puserMenu is null") + 1;
						}
						for (Long i = start + 1; i < currentcount; i++) {
							UserMenu entity = new UserMenu();
							List<UserMenu> menulist = new ArrayList<UserMenu>();
							if (startum.getPuserMenu() != null) {
								entity.setPuserMenu(startum.getPuserMenu());
								menulist = commonDAO.findAll(UserMenu.class,
										" and t.puserMenu = :puserMenu and t.seq = "
												+ i, entity);
							} else {
								menulist = commonDAO.findAll(UserMenu.class,
										" and t.puserMenu is null and t.seq = "
												+ i, entity);
							}
							for (UserMenu usermenu : menulist) {
								usermenu.setSeq(i - 1);
								commonDAO.update(usermenu);
							}
						}

						// -------------------------------------------------

						Long targetcount;
						if (targetum.getPuserMenu() != null) {
							targetcount = commonDAO
									.count("select count(*) from UserMenu u where u.puserMenu.id="
											+ targetum.getPuserMenu().getId());
						} else {
							targetcount = commonDAO
									.count("select count(*) from UserMenu u where u.puserMenu is null");
						}
						Long startc;
						if (moveType.equals("prev")) {
							startc = limit;
						} else {
							startc = limit + 1;
						}
						for (Long i = targetcount; i >= startc; i--) {
							UserMenu entity = new UserMenu();
							List<UserMenu> ulist = new ArrayList<UserMenu>();
							if (targetum.getPuserMenu() != null) {
								entity.setPuserMenu(targetum.getPuserMenu());
								ulist = commonDAO.findAll(UserMenu.class,
										" and t.puserMenu = :puserMenu and t.seq = "
												+ i, entity);
							} else {
								ulist = commonDAO.findAll(UserMenu.class,
										" and t.puserMenu is null and t.seq = "
												+ i, entity);
							}
							for (UserMenu usermenu : ulist) {
								usermenu.setSeq(i + 1);
								commonDAO.update(usermenu);
							}
						}
						startum.setPuserMenu(targetum.getPuserMenu());
						startum.setSeq(startc);
						commonDAO.update(startum);
					}
				} else {
					Long currentcount;
					if (startum.getPuserMenu() != null) {
						currentcount = commonDAO
								.count("select count(*) from UserMenu u where u.puserMenu.id="
										+ startum.getPuserMenu().getId()) + 1;
					} else {
						currentcount = commonDAO
								.count("select count(*) from UserMenu u where u.puserMenu is null") + 1;
					}
					for (Long i = start + 1; i < currentcount; i++) {
						UserMenu entity = new UserMenu();
						List<UserMenu> menulist = new ArrayList<UserMenu>();
						if (startum.getPuserMenu() != null) {
							entity.setPuserMenu(startum.getPuserMenu());
							menulist = commonDAO.findAll(UserMenu.class,
									" and t.puserMenu = :puserMenu and t.seq = "
											+ i, entity);
						} else {
							menulist = commonDAO
									.findAll(UserMenu.class,
											" and t.puserMenu is null and t.seq = "
													+ i, entity);
						}
						for (UserMenu usermenu : menulist) {
							usermenu.setSeq(i - 1);
							commonDAO.update(usermenu);
						}
					}
					Long count = commonDAO
							.count("select count(*) from UserMenu u where u.puserMenu.id="
									+ targetum.getId()) + 1;
					startum.setPuserMenu(targetum);
					startum.setSeq(count);
					commonDAO.update(startum);
				}
			}
			userMenuService.refreshService();
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

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/load")
	public void load(HttpServletResponse response) {
		try {
			List ml = new ArrayList();
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			orders.add(new Order(Direction.DESC, "id"));
			UserMenu entity = new UserMenu();
			List<UserMenu> umlist = commonDAO.findAll(UserMenu.class, "",
					entity, orders);
			for (UserMenu userMenu : umlist) {
				Map m = new HashMap();
				m.put("id", userMenu.getId());
				m.put("name", userMenu.getName());
				if (userMenu.getPuserMenu() != null) {
					m.put("pId", userMenu.getPuserMenu().getId());
				} else {
					m.put("pId", 0);
				}
				if (userMenu.getChildren().size() != 0) {
					m.put("open", true);
				}
				m.put("darg", true);
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

}
