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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.dto.UserRoleDto;
import com.dm.platform.model.MenuGroup;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserMenu;
import com.dm.platform.model.UserRole;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.service.UserRoleService;

@Controller
@RequestMapping("/userrole")
public class UserRoleController extends DefaultController {
	@Resource
	UserRoleService userRoleService;
	@Resource
	UserAccountService userAccountService;
	@Resource
	CommonDAO commonDAO;

	@RequestMapping("/list")
	public ModelAndView list(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = 10;
			}
			if (thispage == null) {
				thispage = 0;
			}
			Long totalcount = userRoleService.countUserRole();
			if ((thispage) * pagesize >= totalcount && totalcount > 0) {
				thispage--;
			}
			model.addObject("userroles",
					userRoleService.listUserRole(thispage, pagesize));
			model.setViewName("/pages/admin/userrole/list");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/form/{mode}")
	public ModelAndView form(
			HttpServletRequest request,
			ModelAndView model,
			@PathVariable String mode,
			@RequestParam(value = "userroleid", required = false) String userroleid) {
		try {
			UserRole ur = new UserRole();
			if (mode != null && !mode.equals("new")) {
				if (userroleid != null) {
					long currentTimeMillis = System.currentTimeMillis();
					ur = userRoleService.findOne(userroleid);
					long currentTimeMillis1 = System.currentTimeMillis();
					System.out.println(currentTimeMillis1-currentTimeMillis);
					model.addObject("userrole", ur);
					if (mode.equals("view")) {
						model.setViewName("/pages/admin/userrole/view");
						return Model(model);
					}
				}
			} else {
				ur.setSeq(commonDAO.count("select count(*) from UserRole") + 1);
				ur.setEnabled(true);
				model.addObject("userrole", ur);
			}
			model.setViewName("/pages/admin/userrole/form");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/save")
	public ModelAndView save(ModelAndView model, UserRole userrole) {
		try {
			UserRole ur = new UserRole();
			if (userrole.getCode() != null && !userrole.getCode().equals("")) {
				ur = userRoleService.findOne(userrole.getCode());
				ur.setName(userrole.getName());
				ur.setHomePage(userrole.getHomePage());
				ur.setEnabled(userrole.isEnabled());
				//ur.setDetial(userrole.getDetial());
				ur.setSeq(userrole.getSeq());
				userRoleService.updateUserRole(ur);
			} else {
				ur.setDetial("1");
				userrole.setCode(String.valueOf(System.currentTimeMillis()));
				userRoleService.insertUserRole(userrole);
			}
			userRoleService.refreshService();
			model.addObject("redirect", getRootPath() + "/userrole/list");
			model.setViewName("/pages/content/redirect");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/selectmenus")
	public ModelAndView menuLoad(ModelAndView model,
			@RequestParam(value = "roleid", required = true) String roleid) {
		try {
			UserRole role = new UserRole();
			role = userRoleService.findOne(roleid);
			List mlist = new ArrayList();
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			//UserMenu entity = new UserMenu();
			/*List<UserMenu> umlist = (List<UserMenu>) commonDAO.findAll(
					UserMenu.class, "and t.isShow = '1'", entity, orders)*/;
			List<UserMenu> umlist = (List<UserMenu>) commonDAO.findAll(
					UserMenu.class,orders);
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
				if (role.getMenus().contains(userMenu)) {
					m.put("checked", true);
				}
				mlist.add(m);
			}
			JSONArray json = JSONArray.fromObject(mlist);
			model.addObject("menuStr", json.toString());
			model.addObject("roleid", roleid);
			model.setViewName("/pages/admin/userrole/menus");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/setmenus")
	public void setMenus(ModelAndView model,
			@RequestParam(value = "menuids", required = false) String menuids,
			@RequestParam(value = "roleid", required = true) String roleid,
			HttpServletResponse response) {
		try {
			UserRole role = new UserRole();
			role = userRoleService.findOne(roleid);
			if ((menuids != null) && (!menuids.equals(""))) {
				Set<UserMenu> umset = new HashSet<UserMenu>();
				String ids[] = menuids.split(",");
				for (String menuid : ids) {
					UserMenu u = new UserMenu();
					u = commonDAO.findOne(UserMenu.class, new Long(menuid));
					umset.add(u);
				}
				role.setMenus(umset);
			} else {
				role.setMenus(null);
			}
			userRoleService.updateUserRole(role);
			userRoleService.refreshService();
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/selectmenugroups")
	public ModelAndView selectmenugroups(
			ModelAndView model,
			@RequestParam(value = "userroleid", required = true) String userroleid) {
		try {
			UserRole ur = new UserRole();
			ur = userRoleService.findOne(userroleid);
			List mlist = new ArrayList();
			List<MenuGroup> mglist = (List<MenuGroup>) commonDAO
					.findAll(MenuGroup.class);
			for (MenuGroup menuGroup : mglist) {
				Map m = new HashMap();
				m.put("id", menuGroup.getId());
				m.put("name", menuGroup.getName());
				m.put("pId", 0);
				if (ur.getMenugroups().contains(menuGroup)) {
					m.put("checked", true);
				}
				mlist.add(m);
			}
			JSONArray json = JSONArray.fromObject(mlist);
			model.addObject("menugroupStr", json.toString());
			model.addObject("userroleid", userroleid);
			model.setViewName("/pages/admin/userrole/menugroups");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/setmenugroups")
	public void setMenugroups(
			@RequestParam(value = "menugroupids", required = false) String menugroupids,
			@RequestParam(value = "userroleid", required = true) String userroleid,
			HttpServletResponse response, Model model) {
		try {
			Set<MenuGroup> menuGroupSet = new HashSet<MenuGroup>();
			Set<UserMenu> menuSet = new HashSet<UserMenu>();
			UserRole userRole = new UserRole();
			if ((menugroupids != null) && (!menugroupids.equals(""))) {
				String ids[] = menugroupids.split(",");
				for (String menuid : ids) {
					MenuGroup u = new MenuGroup();
					u = commonDAO.findOne(MenuGroup.class, new Long(menuid));
					menuGroupSet.add(u);
					Set<UserMenu> menuSet1 = new HashSet<UserMenu>();
					menuSet1 = u.getMenus();
					for (UserMenu userMenu : menuSet1) {
						menuSet.add(userMenu);
					}
				}
			} else {
				menuGroupSet = null;
				menuSet = null;
			}
			userRole = userRoleService.findOne(userroleid);
			userRole.setMenugroups(menuGroupSet);
			userRole.setMenus(menuSet);
			userRoleService.updateUserRole(userRole);
			userRoleService.refreshService();
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/delete")
	public void delete(HttpServletResponse response,
			@RequestParam(value = "roleid", required = false) String roleid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (roleid != null) {
				String[] rid = roleid.split(",");
				for (String str : rid) {
					UserRole ur = new UserRole();
					ur = userRoleService.findOne(str);
					String userHql =" from UserAccount u inner join fetch u.roles r  where r.code ='"+ur.getCode()+"'";
					List<UserAccount> uaset = this.commonDAO.find(userHql);
					for (UserAccount userAccount : uaset) {
						userAccount.getRoles().remove(ur);
						commonDAO.update(userAccount);
					}
					ur.setMenugroups(null);
					ur.setMenus(null);
					userRoleService.updateUserRole(ur);
					userRoleService.deleteUserRole(ur);
				}
			}
			userRoleService.refreshService();
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			userRoleService.refreshService();
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
		}
	}

	@RequestMapping("/addUsers/{roleId}")
	public ModelAndView addUsers(ModelAndView model, @PathVariable String roleId) {
		try {
			List<UserAccount> yesUsers = userAccountService.listUserByRoleId(
					roleId, true);
			List<UserAccount> noUsers = userAccountService.listUserByRoleId(
					roleId, false);
			model.addObject("yesUsers", yesUsers);
			model.addObject("noUsers", noUsers);
			model.addObject("roleId", roleId);
			model.setViewName("/pages/admin/userrole/add_users");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	
	@RequestMapping("/jsonlist")
	@ResponseBody
	public Object jsonlist(@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = 10;
			}
			if (thispage == null) {
				thispage = 0;
			}
			Long totalcount = userRoleService.countUserRole();
			if ((thispage) * pagesize >= totalcount && totalcount > 0) {
				thispage--;
			}
			List<UserRole> userRoles = userRoleService.listUserRole(thispage, pagesize);
			List<UserRoleDto> userRoleDto = new ArrayList<UserRoleDto>();
			for(UserRole userRole:userRoles)
			{
				UserRoleDto dto = new UserRoleDto();
				dto.setCode(userRole.getCode());
				dto.setEnabled(userRole.isEnabled());
				dto.setName(userRole.getName());
				for(UserMenu um:userRole.getMenus())
				{
					Map menu = new HashMap();
					menu.put("id", um.getId());
					menu.put("pId", um.getPuserMenu()==null?null:um.getPuserMenu().getId());
					menu.put("name", um.getName());
					dto.getUserMenus().add(menu);
				}
				userRoleDto.add(dto);
			}
			Map map = new HashMap();
			map.put("data", userRoleDto);
			map.put("total",totalcount);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			Map map = new HashMap();
			map.put("msg", "异常");
			return map;
		}
	}
	

	@RequestMapping("/setUsers")
	public ModelAndView setUsers(ModelAndView model,
			@RequestParam(value = "roleId", required = true) String roleId,
			@RequestParam(value = "userIds", required = true) String userIds) {
		try {
			UserRole role = new UserRole();
			role = userRoleService.findOne(roleId);
			Set<UserAccount> userSet = new HashSet<UserAccount>();
			if ((userIds != null) && (!userIds.equals(""))) {
				String ids[] = userIds.split(",");
				for (String userId : ids) {
					UserAccount u = new UserAccount();
					u = commonDAO.findOne(UserAccount.class, userId);
					u.addRole(role);
					userAccountService.updateUser(u);
					userSet.add(u);
				}
			}
			Set<UserAccount> oldUsers = role.getUsers();
			for (UserAccount userAccount : oldUsers) {
				if(!userSet.contains(userAccount)){
					userAccount.getRoles().remove(role);
					userAccountService.updateUser(userAccount);
				}
			}
			userAccountService.refreshService();
			return Redirect(model, getRootPath() + "/userrole/addUsers/"
					+ roleId, "添加成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return RedirectError(model, getRootPath() + "/userrole/addUsers/"
					+ roleId, "添加失败！");
		}
	}
}
