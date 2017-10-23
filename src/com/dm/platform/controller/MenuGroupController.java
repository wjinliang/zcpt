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
import com.dm.platform.service.MenuGroupService;

@Controller
@RequestMapping("/menugroup")
public class MenuGroupController extends DefaultController {
	@Resource
	MenuGroupService menuGroupService;

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
			Long totalcount = menuGroupService.countMenuGrou();
			if ((thispage) * pagesize >= totalcount && totalcount > 0) {
				thispage--;
			}
			model.addObject("menugroups",
					menuGroupService.listMenuGroup(thispage, pagesize));
			model.setViewName("/pages/admin/menugroup/list");
			return Model(model, thispage,pagesize, totalcount);
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
			@RequestParam(value = "menugroupid", required = false) String menugroupid) {
		try {
			MenuGroup mg = new MenuGroup();
			if (mode != null && !mode.equals("new")) {
				if (menugroupid != null) {
					mg = menuGroupService.findOne(Long.valueOf(menugroupid));
					model.addObject("menugroup", mg);
					if(mode.equals("view")){
						model.setViewName("/pages/admin/menugroup/view");
						return Model(model);
					}
				}
			} else {
				mg.setSeq(commonDAO.count("select count(*) from MenuGroup") + 1);
				model.addObject("menugroup", mg);
			}
			model.setViewName("/pages/admin/menugroup/form");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/save")
	public ModelAndView save(ModelAndView model, MenuGroup menugroup) {
		try {
			MenuGroup mg = new MenuGroup();
			if (menugroup.getId() != null) {
				mg = menuGroupService.findOne(menugroup.getId());
				mg.setName(menugroup.getName());
				mg.setSeq(menugroup.getSeq());
				menuGroupService.updateMenuGroup(mg);
			} else {
				menugroup.setId(System.currentTimeMillis());
				menuGroupService.insertMenuGroup(menugroup);
			}
			menuGroupService.refreshService();
			model.addObject("redirect",getRootPath()+"/menugroup/list");
			model.setViewName("/pages/content/redirect");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/selectmenus")
	public ModelAndView menuLoad(
			ModelAndView model,
			@RequestParam(value = "menugroupid", required = false) String menugroupid) {
		try {
			MenuGroup mg = new MenuGroup();
			mg = menuGroupService.findOne(new Long(menugroupid));
			List mlist = new ArrayList();
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			UserMenu entity = new UserMenu();
			List<UserMenu> umlist = (List<UserMenu>)  commonDAO.findAll(UserMenu.class,"and t.isShow = '1'", entity, orders);;
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
				if (mg.getMenus().contains(userMenu)) {
					m.put("checked", true);
				}
				mlist.add(m);
			}
			JSONArray json = JSONArray.fromObject(mlist);
			model.addObject("menuStr", json.toString());
			model.addObject("menugroupid", menugroupid);
			model.setViewName("/pages/admin/menugroup/menus");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/setmenus")
	public void setMenus(
			ModelAndView model,
			@RequestParam(value = "menuids", required = false) String menuids,
			@RequestParam(value = "menugroupid", required = true) String menugroupid,
			HttpServletResponse response) {
		try {
			Set<UserMenu> umset = new HashSet<UserMenu>();
			MenuGroup mg = new MenuGroup();
			mg = menuGroupService.findOne(new Long(menugroupid));
			if ((menuids != null) && (!menuids.equals(""))) {
				String ids[] = menuids.split(",");
				for (String menuid : ids) {
					UserMenu u = new UserMenu();
					u = commonDAO.findOne(UserMenu.class, new Long(menuid));
					umset.add(u);
				}
				mg.setMenus(umset);
			}else{
				mg.setMenus(null);
			}
			menuGroupService.updateMenuGroup(mg);
			menuGroupService.refreshService();
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
	public void delete(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "menugroupid", required = false) String menugroupid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (menugroupid != null) {
				String[] rid = menugroupid.split(",");
				for (String str : rid) {
					MenuGroup mg = new MenuGroup();
					mg = menuGroupService.findOne(new Long(str));
					Set<UserRole> urset = new HashSet<UserRole>();
					urset = mg.getRoles();
					for (UserRole userRole : urset) {
						userRole.getMenugroups().remove(mg);
						commonDAO.update(userRole);
					}
					mg.setRoles(null);
					menuGroupService.updateMenuGroup(mg);
					menuGroupService.deleteMenuGroup(mg);
				}
			}
			menuGroupService.refreshService();
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			menuGroupService.refreshService();
			out.write("error");
			out.flush();
			out.close();
		}
	}

}
