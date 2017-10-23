package com.app.controller;

import java.io.IOException;
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

import com.app.model.ApplicationInfo;
import com.app.model.SynLog;
import com.app.model.SynOrg;
import com.app.model.SynUser;
import com.app.service.SynService;
import com.app.util.TimeUtil;
import com.app.util.UUIDUtil;
import com.dm.ais.dao.CommDAO;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.util.UserAccountUtil;
 
@Controller
@RequestMapping({ "/syn" })
public class SynController extends DefaultController {
	@Resource
	private CommDAO commDAO;
	@Resource
	private SynService synService;

	@Resource
	UserAccountService userAccountService;
	@Resource
	CommonDAO commonDAO;
/*
	String ZSsystemId;

	ReadProperties readProperties = ReadProperties.getInstance();
	{
		try {
			ZSsystemId = readProperties.getProperties("zhuisu.systemId");
		} catch (IOException e) {
			System.err.print("dm.properties 加载  'zhuisu.systemId' 失败!");
			e.printStackTrace();
		}
	}*/

	@RequestMapping({ "/listApp" })
	public ModelAndView listApp(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "opType", required = false) String opType) {
		try {

			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			if (opType != null && !opType.equals("")) {
				UserAccount currentUserAccount = UserAccountUtil.getInstance()
						.getCurrentUserAccount();
				Long totalcount = this.synService
						.countAppAccount(currentUserAccount);
				if ((thispage.intValue() * pagesize.intValue() >= totalcount
						.longValue()) && (totalcount.longValue() > 0L)) {
					thispage = Integer.valueOf(thispage.intValue() - 1);
				}
				List<ApplicationInfo> appList = this.synService.listAppAccount(
						currentUserAccount, thispage, pagesize);
				model.addObject("appList", appList);
				model.setViewName("/pages/syn/synAppList");
				return Model(model, thispage, pagesize, totalcount);
			} else {
				Long totalcount = this.synService.countAppAccount();
				if ((thispage.intValue() * pagesize.intValue() >= totalcount
						.longValue()) && (totalcount.longValue() > 0L)) {
					thispage = Integer.valueOf(thispage.intValue() - 1);
				}
				List<ApplicationInfo> appList = this.synService.listAppAccount(
						thispage, pagesize);
				model.addObject("appList", appList);
				model.setViewName("/pages/syn/appList");
				return Model(model, thispage, pagesize, totalcount);
			}
		} catch (Exception e) {
			return Error(e);
		}
	}

	@RequestMapping({ "/listSynsApp" })
	public ModelAndView listSynsApp(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "opType", required = false) String opType) {
		try {

			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			if (opType != null && !opType.equals("")) {
				UserAccount currentUserAccount = UserAccountUtil.getInstance()
						.getCurrentUserAccount();
				Long totalcount = this.synService
						.countAppAccount(currentUserAccount);
				if ((thispage.intValue() * pagesize.intValue() >= totalcount
						.longValue()) && (totalcount.longValue() > 0L)) {
					thispage = Integer.valueOf(thispage.intValue() - 1);
				}
				List<ApplicationInfo> appList = this.synService.listAppAccount(
						currentUserAccount, thispage, pagesize);
				model.addObject("appList", appList);
				model.setViewName("/pages/syn/synAppList");
				return Model(model, thispage, pagesize, totalcount);
			} else {
				Long totalcount = this.synService.countAppAccount();
				if ((thispage.intValue() * pagesize.intValue() >= totalcount
						.longValue()) && (totalcount.longValue() > 0L)) {
					thispage = Integer.valueOf(thispage.intValue() - 1);
				}
				List<ApplicationInfo> appList = this.synService.listAppAccount(
						thispage, pagesize);
				model.addObject("appList", appList);
				model.setViewName("/pages/syn/appList");
				return Model(model, thispage, pagesize, totalcount);
			}
		} catch (Exception e) {
			return Error(e);
		}
	}

	@RequestMapping({ "/form/{mode}" })
	public ModelAndView gotoCreateAppPage(ModelAndView model,
			@PathVariable String mode,
			@RequestParam(value = "appid", required = false) String appid) {
		if ((mode != null) && (!mode.equals("new"))) {
			ApplicationInfo appInfo = this.synService.findAppById(appid);
			model.addObject("appInfo", appInfo);
			model.setViewName("/pages/syn/viewAppPage");
		} else {
			model.setViewName("/pages/syn/createAppPage");
		}
		return Model(model);
	}

	@RequestMapping({ "/saveApp" })
	public ModelAndView saveApp(ModelAndView model, ApplicationInfo app) {
		String uuid = UUIDUtil.getUUID();
		app.setId(uuid);
		app.setStatus("1");
		this.synService.save(app);
		return NewRedirect(model, "/syn/listApp");
	}

	@RequestMapping({ "/updateApp" })
	public ModelAndView updateApp(ModelAndView model, ApplicationInfo app) {
		ApplicationInfo one = this.synService.findAppById(app.getId());
		one.setAppCode(app.getAppCode());
		one.setAppName(app.getAppName());
		one.setAppPath(app.getAppPath());
		one.setDescription(app.getDescription());
		one.setOpLevel(app.getOpLevel());
		one.setUserLevel(app.getUserLevel());
		one.setPackageName(app.getPackageName());
		one.setParamName(app.getParamName());
		one.setSynType(app.getSynType());
		one.setSynPath(app.getSynPath());
		this.synService.update(one);
		return NewRedirect(model, "/syn/listApp");
	}

	@RequestMapping({ "/checkunique" })
	public void checkunique(HttpServletResponse response,
			@RequestParam(value = "param", required = true) String param,
			@RequestParam(value = "name", required = true) String name,
			@RequestParam(value = "id", required = false) String id) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			PrintWriter out = response.getWriter();
			List<ApplicationInfo> list = this.synService.findAppByPropertyName(
					name, param);
			if (id != null && !id.equals("")) {
				if (list.size() > 1) {
					out.write("n");
				} else if (list.size() == 1) {
					ApplicationInfo applicationInfo = list.get(0);
					if (applicationInfo.getId().equals(id)) {
						out.write("y");
					} else {
						out.write("n");
					}
				} else {
					out.write("y");
				}
			} else {
				if (list.size() > 0) {
					out.write("n");
				} else {
					out.write("y");
				}
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping({ "/delete" })
	public void delete(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "appid", required = false) String appid)
			throws Exception {
		String requestIp = UserAccountUtil.getInstance().getRequestIp(request);
		// System.out.println(requestIp);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (appid != null) {
				String[] rid = appid.split(",");
				for (String str : rid) {
					ApplicationInfo findOne = this.synService.findAppById(str);
					this.synService.deleteApp(findOne);
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

	@RequestMapping({ "/startApp" })
	public void startApp(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "appid", required = true) String appid)
			throws Exception {
		String requestIp = UserAccountUtil.getInstance().getRequestIp(request);
		System.out.println(requestIp);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (appid != null) {
				ApplicationInfo findOne = this.synService.findAppById(appid);
				findOne.setStatus("1");
				this.synService.update(findOne);
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

	@RequestMapping({ "/stopApp" })
	public void stopApp(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "appid", required = true) String appid)
			throws Exception {
		String requestIp = UserAccountUtil.getInstance().getRequestIp(request);
		System.out.println(requestIp);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (appid != null) {
				ApplicationInfo findOne = this.synService.findAppById(appid);
				findOne.setStatus("0");
				this.synService.update(findOne);
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

	@RequestMapping({ "/redirect" })
	public ModelAndView redirect(ModelAndView model) {
		return NewRedirect(model, "https://www.baidu.com/");
	}

	@RequestMapping({ "/listSynUser" })
	public ModelAndView listSynUser(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "flag", required = false) Integer flag,
			@RequestParam(value = "result", required = false) String result,
			@RequestParam(value = "successCount", required = false) Integer successCount,
			@RequestParam(value = "errorCount", required = false) Integer errorCount) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			String userSql = "SELECT u.CODE,u.NAME,u.LOGINNAME,s.syn_time FROM t_user_account  u LEFT JOIN syn_user s ON u.CODE = s.user_id WHERE s.app_id='"
					+ appId + "' AND s.id is NOT NULL ORDER BY s.syn_time DESC";
			List userList = this.commDAO
					.findByPage(userSql, thispage, pagesize);
			String countSql = "SELECT count(*) FROM t_user_account  u LEFT JOIN syn_user s ON u.CODE = s.user_id WHERE s.app_id='"
					+ appId + "' AND s.id is NOT NULL ORDER BY s.syn_time DESC";
			Long totalcount = this.commDAO.count(countSql);
			model.addObject("appId", appId);
			if (flag != null) {
				if (flag == 0) {
					model.addObject("flag", flag);
					model.addObject("result", result);
				}
				if (flag == 1) {
					model.addObject("flag", flag);
					model.addObject("successCount", successCount);
					model.addObject("errorCount", errorCount);
				}
			}
			ApplicationInfo app = this.synService.findAppById(appId);
			if (app != null) {
				model.addObject("state", app.getStatus());
			}
			model.addObject("userList", userList);
			model.setViewName("/pages/syn/userList");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping({ "/listSynOrg" })
	public ModelAndView listSynOrg(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "flag", required = false) Integer flag,
			@RequestParam(value = "result", required = false) String result,
			@RequestParam(value = "successCount", required = false) Integer successCount,
			@RequestParam(value = "errorCount", required = false) Integer errorCount) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}

			String orgSql = "SELECT o. id,o. NAME,o.CODE,s.syn_time FROM t_org o LEFT JOIN syn_org s ON o.id = s.org_id WHERE	s.app_id = '"
					+ appId + "' AND s.id IS NOT NULL ORDER BY	s.syn_time DESC";
			List orgList = this.commDAO.findByPage(orgSql, thispage, pagesize);
			String countSql = "SELECT count(*) FROM t_org o LEFT JOIN syn_org s ON o.id = s.org_id WHERE s.app_id = '"
					+ appId + "' AND s.id IS NOT NULL ORDER BY	s.syn_time DESC";
			Long totalcount = this.commDAO.count(countSql);
			model.addObject("appId", appId);
			if (flag != null) {
				if (flag == 0) {
					model.addObject("flag", flag);
					model.addObject("result", result);
				}
				if (flag == 1) {
					model.addObject("flag", flag);
					model.addObject("successCount", successCount);
					model.addObject("errorCount", errorCount);
				}
			}
			ApplicationInfo app = this.synService.findAppById(appId);
			if (app != null) {
				model.addObject("state", app.getStatus());
			}
			model.addObject("orgList", orgList);
			model.setViewName("/pages/syn/orgList");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping({ "/listSynDivision" })
	public ModelAndView listSynDivision(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "flag", required = false) Integer flag,
			@RequestParam(value = "result", required = false) String result,
			@RequestParam(value = "successCount", required = false) Integer successCount,
			@RequestParam(value = "errorCount", required = false) Integer errorCount) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}

			String orgSql = "SELECT d1.ID,d1.NAME,d1.CODE,d.syn_time FROM syn_division d LEFT JOIN t_division d1 ON d.division_id=d1.ID WHERE	d.app_id = '"
					+ appId + "' AND d.id IS NOT NULL ORDER BY	d.syn_time DESC";
			List orgList = this.commDAO.findByPage(orgSql, thispage, pagesize);
			String countSql = "SELECT count(*) FROM syn_division d LEFT JOIN t_division d1 ON d.division_id=d1.ID WHERE	d.app_id = '"
					+ appId + "' AND d.id IS NOT NULL ORDER BY	d.syn_time DESC";
			Long totalcount = this.commDAO.count(countSql);
			model.addObject("appId", appId);
			if (flag != null) {
				if (flag == 0) {
					model.addObject("flag", flag);
					model.addObject("result", result);
				}
				if (flag == 1) {
					model.addObject("flag", flag);
					model.addObject("successCount", successCount);
					model.addObject("errorCount", errorCount);
				}
			}
			ApplicationInfo app = this.synService.findAppById(appId);
			if (app != null) {
				model.addObject("state", app.getStatus());
			}
			model.addObject("orgList", orgList);
			model.setViewName("/pages/syn/divisionList");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	/*
	 * @RequestMapping({ "/gotoSynUser" }) public ModelAndView
	 * gotoSynUser(ModelAndView model,
	 * 
	 * @RequestParam(value = "appId", required = true) String appId) { try {
	 * String orgHql = " from Org o where o.parent.id is null"; List<Org>
	 * orgList = this.synService.findByHql(orgHql); List ml = new ArrayList();
	 * for (int i = 0; i < orgList.size(); i++) { Map m = new HashMap(); Org org
	 * = orgList.get(i); m.put("id", org.getId()); m.put("name", org.getName());
	 * if (org.getParent() != null) { m.put("pId", org.getParent().getId()); }
	 * else { m.put("pId", ""); } m.put("isParent", "true"); ml.add(m); } String
	 * userSql =
	 * "SELECT u.CODE,u.NAME,u.org_id,CASE WHEN s.id is NULL THEN 0 ELSE 1 END sys_status FROM t_user_account  u LEFT JOIN (SELECT * FROM syn_user WHERE app_id='"
	 * + appId + "') s ON u.CODE = s.user_id where u.org_id is null"; List
	 * userList = this.commDAO.getListbySql(userSql); for (int j = 0; j <
	 * userList.size(); j++) { Map u = new HashMap(); Object[] object =
	 * (Object[]) userList.get(j); String userId = object[0].toString(); String
	 * userName = null; String orgId = null; if (object[1] != null) { userName =
	 * object[1].toString(); } if (object[2] != null) { orgId =
	 * object[2].toString(); } else { orgId = ""; } String synStatus =
	 * object[3].toString(); u.put("id", userId); u.put("pId", orgId);
	 * u.put("name", userName); if (synStatus.equals("1")) { u.put("nocheck",
	 * "true"); } else { u.put("nocheck", "false"); } ml.add(u); } JSONArray
	 * jsonArray = JSONArray.fromObject(ml); model.addObject("orgStr",
	 * jsonArray.toString()); model.addObject("appId", appId);
	 * System.out.println(jsonArray.toString());
	 * model.setViewName("/pages/syn/user"); return Model(model); } catch
	 * (Exception e) { e.printStackTrace(); return Error(e); } }
	 */
	@RequestMapping({ "/gotoSynUser" })
	public ModelAndView gotoSynUser(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false, defaultValue = "0") Integer thispage,
			@RequestParam(value = "pagesize", required = false, defaultValue = "10") Integer pagesize,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "orgId", required = false) String orgId,
			@RequestParam(value = "jt", required = false) String name) {
		try {

			Long totalcount = this.orgAndUserService.countUser(orgId, null,
					name);

			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			List<UserAccount> userList = this.orgAndUserService.listUsers(
					orgId, null, name, thispage, pagesize);
			userList = checkSynUser(userList, appId);
			model.addObject("userList", userList);
			model.addObject("appId", appId);
			model.addObject("orgId", orgId);
			model.setViewName("/pages/syn/user");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	private List<UserAccount> checkSynUser(List<UserAccount> userList,
			String appId) {
		String orgIds = "";
		for (UserAccount org : userList) {
			orgIds += "'" + org.getCode() + "',";
		}
		if (orgIds.equals("")) {
			return userList;
		}
		orgIds = orgIds.substring(0, orgIds.length() - 1);
		String sql = "select * from syn_user where app_id = '" + appId
				+ "' and user_id in (" + orgIds + ") order by user_id";
		List<SynUser> list = this.commDAO.getListbySql(SynUser.class, sql);
		List<UserAccount> myOrg = new ArrayList<UserAccount>();
		int j = 0;
		for (int i = 0; i < userList.size(); i++) {
			UserAccount o = userList.get(i);
			UserAccount e = new UserAccount();
			e.setLoginname(o.getLoginname());
			e.setCode(o.getCode());
			e.setName(o.getName());
			e.setSystemId(o.getSystemId());
			e.setOrg(o.getOrg());
			myOrg.add(e);
			if (j >= list.size()) {
				continue;
			}
			SynUser s = list.get(j);
			if (o.getCode().equals(s.getUserId())) {
				e.setUserType("checked");
				j++;
			}
		}
		return myOrg;
	}

	@RequestMapping({ "/loadSonOrgAndUser" })
	public void loadSonOrgAndUser(ModelAndView model,
			HttpServletResponse httpServletResponse,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "appId", required = true) String appId) {
		try {
			httpServletResponse.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = httpServletResponse.getWriter();
			String orgHql = " from Org o";
			if (orgid != null && !orgid.equals("")) {
				orgHql += "  where o.parent.id =" + orgid;
			} else {
				orgHql += "  where o.parent.id is null";
			}
			List<Org> orgList = this.synService.findByHql(orgHql);
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
			String userSql = "SELECT u.CODE,u.NAME,u.org_id,CASE WHEN s.id is NULL THEN 0 ELSE 1 END sys_status FROM t_user_account  u LEFT JOIN (SELECT * FROM syn_user WHERE app_id='"
					+ appId + "') s ON u.CODE = s.user_id ";
			if (orgid != null && !orgid.equals("")) {
				userSql += " where u.org_id =" + orgid;
			} else {
				userSql += " where u.org_id is null";
			}
			List userList = this.commDAO.getListbySql(userSql);
			for (int j = 0; j < userList.size(); j++) {
				Map u = new HashMap();
				Object[] object = (Object[]) userList.get(j);
				String userId = object[0].toString();
				String userName = null;
				String orgId = null;
				if (object[1] != null) {
					userName = object[1].toString();
				}
				if (object[2] != null) {
					orgId = object[2].toString();
				} else {
					orgId = "";
				}
				String synStatus = object[3].toString();
				u.put("id", userId);
				u.put("pId", orgId);
				u.put("name", userName);
				if (synStatus.equals("1")) {
					u.put("nocheck", "true");
				} else {
					u.put("nocheck", "false");
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

	/*
	 * @RequestMapping({ "/gotoSynOrg" }) public ModelAndView
	 * gotoSynOrg(ModelAndView model,
	 * 
	 * @RequestParam(value = "orgid", required = false) String orgid,
	 * 
	 * @RequestParam(value = "appId", required = true) String appId) { try {
	 * List ml = new ArrayList(); String orgSql = ""; if (orgid != null &&
	 * !orgid.equals("")) { orgSql =
	 * "SELECT o.id,o.NAME,o.parent_id,CASE WHEN s.id is NULL THEN 0 ELSE 1 END sys_status,count(t.id) sonSum FROM t_org  o LEFT JOIN (SELECT * FROM syn_org WHERE app_id='"
	 * + appId +
	 * "') s ON o.id = s.org_id LEFT JOIN t_org t ON  o.id=t.parent_id  where o.parent_id ="
	 * + orgid + " GROUP BY o.id"; } else { orgSql =
	 * "SELECT o.id,o.NAME,o.parent_id,CASE WHEN s.id is NULL THEN 0 ELSE 1 END sys_status,count(t.id) sonSum FROM t_org  o LEFT JOIN (SELECT * FROM syn_org WHERE app_id='"
	 * + appId +
	 * "') s ON o.id = s.org_id LEFT JOIN t_org t ON  o.id=t.parent_id  where o.parent_id is null  GROUP BY o.id"
	 * ; } List orgList = this.commDAO.getListbySql(orgSql); for (int j = 0; j <
	 * orgList.size(); j++) { Map u = new HashMap(); Object[] object =
	 * (Object[]) orgList.get(j); String orgId = object[0].toString(); String
	 * orgName = null; String parentId = null; if (object[1] != null) { orgName
	 * = object[1].toString(); } if (object[2] != null) { parentId =
	 * object[2].toString(); } else { parentId = ""; } String synStatus =
	 * object[3].toString(); String sonSum = object[4].toString(); u.put("id",
	 * orgId); u.put("pId", parentId); u.put("name", orgName); if (sonSum !=
	 * null && !sonSum.equals("0")) { u.put("isParent", "true"); } if
	 * (synStatus.equals("1")) { u.put("nocheck", "true"); } else {
	 * u.put("nocheck", "false"); } ml.add(u); } JSONArray jsonArray =
	 * JSONArray.fromObject(ml); model.addObject("orgStr",
	 * jsonArray.toString()); System.out.println(jsonArray.toString());
	 * model.addObject("appId", appId); model.setViewName("/pages/syn/org");
	 * return Model(model); } catch (Exception e) { e.printStackTrace(); return
	 * Error(e); } }
	 */
	@RequestMapping({ "/gotoSynOrg" })
	public ModelAndView gotoSynOrg(
			ModelAndView model,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "thispage", required = false, defaultValue = "0") Integer thispage,
			@RequestParam(value = "pagesize", required = false, defaultValue = "10") Integer pagesize,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "tj", required = false) String name) {
		try {
			Long totalcount = 0l;
			if (orgid != null && !orgid.equals("")) {
				Org org = this.commonDAO
						.findOne(Org.class, Long.valueOf(orgid));
				List<Division> sonDivisionList = new ArrayList<Division>();
				String sonids = "";
				//if (org.getSystemId().equals(ZSsystemId)) {// 追溯系统
					sonDivisionList = orgAndUserService
							.getSonLevelDivisionList(org.getDivision().getId());
					for (Division d : sonDivisionList) {
						sonids += "'" + d.getId() + "',";
					}
					if (sonids.endsWith(",")) {
						sonids = sonids.substring(0, sonids.length() - 1);
					}
					if (!sonids.equals("")) {
						/*totalcount = this.orgAndUserService.countOrgSyn(sonids,
								org.getSystemId(), name, appId);*/
						totalcount = this.orgAndUserService.countOrg(sonids, name);
					}

				/*} else {// 其他系统
					totalcount = this.orgAndUserService.countSonOrg(orgid,
							 name);
				}*/
				if ((thispage.intValue() * pagesize.intValue() >= totalcount
						.longValue()) && (totalcount.longValue() > 0L)) {
					thispage = Integer.valueOf(thispage.intValue() - 1);
				}
				List<Org> orgList = new ArrayList();
				//if (org.getSystemId().equals(ZSsystemId)) {// 追溯系统
					if (!sonids.equals("")) {
						orgList = this.orgAndUserService.listOrgs(sonids, name, thispage, pagesize);
					}
				/*} else {// 其他系统
					orgList = this.orgAndUserService.listSonOrgs(orgid,name, thispage, pagesize);
				}*/
				orgList = checkSynOrg(orgList, appId);
				model.addObject("orgList", orgList);
			} else {
				orgid = null;
				totalcount = this.orgAndUserService.countOrg(null, 
						name);

				if ((thispage.intValue() * pagesize.intValue() >= totalcount
						.longValue()) && (totalcount.longValue() > 0L)) {
					thispage = Integer.valueOf(thispage.intValue() - 1);
				}
				List<Org> orgList = this.orgAndUserService.listOrgs(null,
						name, thispage, pagesize);
				orgList = checkSynOrg(orgList, appId);
				model.addObject("orgList", orgList);
			}
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			List<ApplicationInfo> appList = this.commonDAO
					.findAll(ApplicationInfo.class,orders);
			model.addObject("appList", appList);
			model.addObject("parentid", orgid);
			model.addObject("appId", appId);
			model.setViewName("/pages/syn/org");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	private List<Org> checkSynOrg(List<Org> orgList, String appId) {
		String orgIds = "";
		for (Org org : orgList) {
			orgIds += "'" + org.getId() + "',";
		}
		if (orgIds.equals("")) {
			return orgList;
		}
		orgIds = orgIds.substring(0, orgIds.length() - 1);
		String sql = "select * from syn_org where app_id='" + appId
				+ "' and org_id in(" + orgIds + ") order by org_id";
		List<SynOrg> list = this.commDAO.getListbySql(SynOrg.class, sql);
		int j = 0;
		List<Org> myOrg = new ArrayList<Org>();
		for (int i = 0; i < orgList.size(); i++) {
			Org o = orgList.get(i);
			Org e = new Org();
			e.setDivision(o.getDivision());
			e.setCode(o.getCode());
			e.setName(o.getName());
			e.setParent(o.getParent());
			e.setId(o.getId());
			e.setSystemId(o.getSystemId());
			myOrg.add(e);
			if (j >= list.size()) {
				continue;
			}
			SynOrg s = list.get(j);
			if (o.getId().toString().equals(s.getOrgId())) {
				e.setType("checked");
				j++;
			}
		}
		return myOrg;
	}

	@RequestMapping({ "/gotoSynOrgUser" })
	public ModelAndView gotoSynOrgUser(
			ModelAndView model,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "thispage", required = false, defaultValue = "0") Integer thispage,
			@RequestParam(value = "pagesize", required = false, defaultValue = "10") Integer pagesize,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "tj", required = false) String name) {
		try {
			Long totalcount = 0l;
			if (orgid != null && !orgid.equals("")) {
				Org org = this.commonDAO
						.findOne(Org.class, Long.valueOf(orgid));
				List<Division> sonDivisionList = new ArrayList<Division>();
				String sonids = "";
				//if (org.getSystemId().equals(ZSsystemId)) {// 追溯系统
					sonDivisionList = orgAndUserService
							.getSonLevelDivisionList(org.getDivision().getId());
					for (Division d : sonDivisionList) {
						sonids += "'" + d.getId() + "',";
					}
					if (sonids.endsWith(",")) {
						sonids = sonids.substring(0, sonids.length() - 1);
					}
					if (!sonids.equals("")) {
						totalcount = this.orgAndUserService.countOrgSyn(sonids,
								org.getSystemId(), name, appId);
					}

				/*} else {// 其他系统
					totalcount = this.orgAndUserService.countSonOrg(orgid,
							 name);
				}*/
				if ((thispage.intValue() * pagesize.intValue() >= totalcount
						.longValue()) && (totalcount.longValue() > 0L)) {
					thispage = Integer.valueOf(thispage.intValue() - 1);
				}
				List<Org> orgList = new ArrayList();
				//if (org.getSystemId().equals(ZSsystemId)) {// 追溯系统
					if (!sonids.equals("")) {
						orgList = this.orgAndUserService.listOrgs(sonids,
								 name, thispage, pagesize);
					}
				/*} else {// 其他系统
					orgList = this.orgAndUserService.listSonOrgs(orgid,
							 name, thispage, pagesize);
				}*/
				orgList = checkSynOrg(orgList, appId);
				model.addObject("orgList", orgList);
			} else {
				orgid = null;
				totalcount = this.orgAndUserService.countOrg(null, 
						name);

				if ((thispage.intValue() * pagesize.intValue() >= totalcount
						.longValue()) && (totalcount.longValue() > 0L)) {
					thispage = Integer.valueOf(thispage.intValue() - 1);
				}
				List<Org> orgList = this.orgAndUserService.listOrgs(null, name, thispage, pagesize);
				orgList = checkSynOrg(orgList, appId);
				model.addObject("orgList", orgList);
			}

			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			List<ApplicationInfo> appList = this.commonDAO
					.findAll(ApplicationInfo.class,orders);
			model.addObject("appList", appList);
			model.addObject("parentid", orgid);
			model.addObject("appId", appId);
			model.setViewName("/pages/syn/userOrg");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	/*
	 * @RequestMapping({ "/loadSonOrg" }) public void loadSonOrg(ModelAndView
	 * model, HttpServletResponse httpServletResponse,
	 * 
	 * @RequestParam(value = "orgid", required = false) String orgid,
	 * 
	 * @RequestParam(value = "appId", required = true) String appId) { try {
	 * httpServletResponse.setContentType("text/html;charset=UTF-8");
	 * PrintWriter writer = httpServletResponse.getWriter(); List ml = new
	 * ArrayList(); String orgSql = ""; if (orgid != null && !orgid.equals(""))
	 * { orgSql =
	 * "SELECT o.id,o.NAME,o.parent_id,CASE WHEN s.id is NULL THEN 0 ELSE 1 END sys_status, count(t.id) sonSum FROM t_org  o LEFT JOIN (SELECT * FROM syn_org WHERE app_id='"
	 * + appId +
	 * "') s ON o.id = s.org_id LEFT JOIN t_org t ON  o.id=t.parent_id where o.parent_id ="
	 * + orgid + " GROUP BY o.id"; } else { orgSql =
	 * "SELECT o.id,o.NAME,o.parent_id,CASE WHEN s.id is NULL THEN 0 ELSE 1 END sys_status,count(t.id) sonSum FROM t_org  o LEFT JOIN (SELECT * FROM syn_org WHERE app_id='"
	 * + appId +
	 * "') s ON o.id = s.org_id LEFT JOIN t_org t ON  o.id=t.parent_id where o.parent_id is null   GROUP BY o.id"
	 * ; } List orgList = this.commDAO.getListbySql(orgSql); for (int j = 0; j <
	 * orgList.size(); j++) { Map u = new HashMap(); Object[] object =
	 * (Object[]) orgList.get(j); String orgId = object[0].toString(); String
	 * orgName = null; String parentId = null; if (object[1] != null) { orgName
	 * = object[1].toString(); } if (object[2] != null) { parentId =
	 * object[2].toString(); } else { parentId = ""; } String synStatus =
	 * object[3].toString(); String sonSum = object[4].toString(); u.put("id",
	 * orgId); u.put("pId", parentId); u.put("name", orgName); if (sonSum !=
	 * null && !sonSum.equals("0")) { u.put("isParent", "true"); } if
	 * (synStatus.equals("1")) { u.put("nocheck", "true"); } else {
	 * u.put("nocheck", "false"); } ml.add(u); } JSONArray jsonArray =
	 * JSONArray.fromObject(ml); writer.write(jsonArray.toString());
	 * writer.flush(); writer.close(); } catch (Exception e) {
	 * e.printStackTrace(); } }
	 */

	/**
	 * 批量同步用户--新增
	 * 
	 * @param model
	 * @param appId
	 * @param userIds
	 * @return
	 */
	@RequestMapping({ "/synCreateUser" })
	public ModelAndView synCreateUser(ModelAndView model,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "userIds", required = true) String userIds) {
		try {
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			ApplicationInfo appInfo = this.synService.findAppById(appId);
			String[] userIdArray = userIds.trim().split(",");
			String result = null;
			int successCount = 0;
			int errorCount = 0;
			for (int i = 0; i < userIdArray.length; i++) {
				String infoCode = userIdArray[i];
				result = this.synService.synStart(appId, infoCode, "11");
				String today = TimeUtil
						.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
				UserAccount userAccount = this.synService
						.findUserById(infoCode);
				if (result != null && result.equals("000")) {
					result = "同步成功";
					SynUser synUser = new SynUser();
					String uuid = UUIDUtil.getUUID();
					synUser.setAppId(appId);
					synUser.setId(uuid);
					synUser.setUserId(infoCode);
					synUser.setSynTime(today);
					this.synService.save(synUser);
					successCount++;
					/*
					 * 添加记录日志的操作
					 */
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("用户(" + userAccount.getName()
							+ ")新增操作：" + result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				} else {
					errorCount++;
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("用户(" + userAccount.getName()
							+ ")新增操作：" + result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				}
			}
			model.addObject("appId", appId);
			if (userIdArray.length == 1) {
				model.addObject("flag", 0);
				model.addObject("result", result);
			} else {
				model.addObject("flag", 1);
				model.addObject("successCount", successCount);
				model.addObject("errorCount", errorCount);
			}
			return NewRedirect(model, "/syn/listSynUser");
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	/**
	 * 批量同步用户--修改
	 * 
	 * @param model
	 * @param appId
	 * @param userIds
	 * @return
	 */
	@RequestMapping({ "/synUpdateUser" })
	public ModelAndView synUpdateUser(ModelAndView model,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "userIds", required = true) String userIds) {
		try {
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			ApplicationInfo appInfo = this.synService.findAppById(appId);
			String[] userIdArray = userIds.trim().split(",");
			String result = null;
			int successCount = 0;
			int errorCount = 0;
			for (int i = 0; i < userIdArray.length; i++) {
				String infoCode = userIdArray[i];
				result = this.synService.synStart(appId, infoCode, "12");
				UserAccount userAccount = this.synService
						.findUserById(infoCode);
				String today = TimeUtil
						.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
				if (result != null && result.equals("000")) {
					result = "同步成功";
					String synSql = "from SynUser u where u.appId='" + appId
							+ "' and u.userId='" + infoCode + "'";
					List<SynUser> synUserList = this.synService
							.findByHql(synSql);
					if (synUserList != null && synUserList.size() > 0) {
						for (int j = 0; j < synUserList.size(); j++) {
							synUserList.get(j).setSynTime(today);
							this.synService.update(synUserList.get(j));
						}
					}
					successCount++;
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("用户(" + userAccount.getName()
							+ ")更新操作：" + result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				} else {
					errorCount++;
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("用户(" + userAccount.getName()
							+ ")更新操作：" + result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				}
			}
			model.addObject("appId", appId);
			if (userIdArray.length == 1) {
				model.addObject("flag", 0);
				model.addObject("result", result);
			} else {
				model.addObject("flag", 1);
				model.addObject("successCount", successCount);
				model.addObject("errorCount", errorCount);
			}
			return NewRedirect(model, "/syn/listSynUser");
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	/**
	 * 批量同步用户--删除
	 * 
	 * @param model
	 * @param appId
	 * @param userIds
	 * @return
	 */
	@RequestMapping({ "/synDeleteUser" })
	public ModelAndView synDeleteUser(ModelAndView model,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "userIds", required = true) String userIds) {
		try {
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			ApplicationInfo appInfo = this.synService.findAppById(appId);
			String[] userIdArray = userIds.trim().split(",");
			String result = null;
			int successCount = 0;
			int errorCount = 0;
			for (int i = 0; i < userIdArray.length; i++) {
				String infoCode = userIdArray[i];
				result = this.synService.synStart(appId, infoCode, "13");
				UserAccount userAccount = this.synService
						.findUserById(infoCode);
				String today = TimeUtil
						.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
				if (result != null && result.equals("000")) {
					result = "同步成功";
					String synSql = "from SynUser u where u.appId='" + appId
							+ "' and u.userId='" + infoCode + "'";
					List<SynUser> synUserList = this.synService
							.findByHql(synSql);
					if (synUserList != null && synUserList.size() > 0) {
						for (int j = 0; j < synUserList.size(); j++) {
							this.synService.delete(synUserList.get(j));
						}
					}
					successCount++;
					// 添加记录日志的操作
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("用户(" + userAccount.getName()
							+ ")删除操作：" + result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				} else {
					errorCount++;
					// 添加记录日志的操作
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("用户(" + userAccount.getName()
							+ ")删除操作：" + result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				}
			}
			model.addObject("appId", appId);
			if (userIdArray.length == 1) {
				model.addObject("flag", 0);
				model.addObject("result", result);
			} else {
				model.addObject("flag", 1);
				model.addObject("successCount", successCount);
				model.addObject("errorCount", errorCount);
			}
			return NewRedirect(model, "/syn/listSynUser");
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	/**
	 * 批量同步组织--新增
	 * 
	 * @param model
	 * @param appId
	 * @param orgIds
	 * @return
	 */
	@RequestMapping({ "/synCreateOrg" })
	public ModelAndView synCreateOrg(ModelAndView model,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "orgIds", required = true) String orgIds) {
		try {
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			ApplicationInfo appInfo = this.synService.findAppById(appId);
			String[] orgIdArray = orgIds.trim().split(",");
			String result = null;
			int successCount = 0;
			int errorCount = 0;
			for (int i = 0; i < orgIdArray.length; i++) {
				String infoCode = orgIdArray[i];
				result = this.synService.synStart(appId, infoCode, "41");
				String today = TimeUtil
						.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
				Org org = this.synService.findOrgById(Long.parseLong(infoCode));
				if (result != null && result.equals("000")) {
					result = "同步成功";
					SynOrg synOrg = new SynOrg();
					String uuid = UUIDUtil.getUUID();
					synOrg.setAppId(appId);
					synOrg.setId(uuid);
					synOrg.setOrgId(infoCode);
					synOrg.setSynTime(today);
					this.synService.save(synOrg);
					successCount++;
					// 添加记录日志的操作
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("组织(" + org.getName() + ")新增操作："
							+ result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				} else {
					errorCount++;
					// 添加记录日志的操作
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("组织(" + org.getName() + ")新增操作："
							+ result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				}
			}
			model.addObject("appId", appId);
			if (orgIdArray.length == 1) {
				model.addObject("flag", 0);
				model.addObject("result", result);
			} else {
				model.addObject("flag", 1);
				model.addObject("successCount", successCount);
				model.addObject("errorCount", errorCount);
			}
			return NewRedirect(model, "/syn/listSynOrg");
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	/**
	 * 批量同步组织--修改
	 * 
	 * @param model
	 * @param appId
	 * @param userIds
	 * @return
	 */
	@RequestMapping({ "/synUpdateOrg" })
	public ModelAndView synUpdateOrg(ModelAndView model,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "orgIds", required = true) String orgIds) {
		try {
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			ApplicationInfo appInfo = this.synService.findAppById(appId);
			String[] orgIdArray = orgIds.trim().split(",");
			String result = null;
			int successCount = 0;
			int errorCount = 0;
			for (int i = 0; i < orgIdArray.length; i++) {
				String infoCode = orgIdArray[i];
				result = this.synService.synStart(appId, infoCode, "42");
				String today = TimeUtil
						.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
				Org org = this.synService.findOrgById(Long.parseLong(infoCode));
				if (result != null && result.equals("000")) {
					result = "同步成功";
					String synSql = "from SynOrg u where u.appId='" + appId
							+ "' and u.orgId='" + infoCode + "'";
					List<SynOrg> synOrgList = this.synService.findByHql(synSql);
					if (synOrgList != null && synOrgList.size() > 0) {
						for (int j = 0; j < synOrgList.size(); j++) {
							synOrgList.get(j).setSynTime(today);
							this.synService.update(synOrgList.get(j));
						}
					}
					successCount++;
					// 添加记录日志的操作
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("组织(" + org.getName() + ")修改操作："
							+ result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				} else {
					errorCount++;
					// 添加记录日志的操作
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("组织(" + org.getName() + ")修改操作："
							+ result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				}
			}
			model.addObject("appId", appId);
			if (orgIdArray.length == 1) {
				model.addObject("flag", 0);
				model.addObject("result", result);
			} else {
				model.addObject("flag", 1);
				model.addObject("successCount", successCount);
				model.addObject("errorCount", errorCount);
			}
			return NewRedirect(model, "/syn/listSynOrg");
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	/**
	 * 批量同步组织--删除
	 * 
	 * @param model
	 * @param appId
	 * @param userIds
	 * @return
	 */
	@RequestMapping({ "/synDeleteOrg" })
	public ModelAndView synDeleteOrg(ModelAndView model,
			@RequestParam(value = "appId", required = true) String appId,
			@RequestParam(value = "orgIds", required = true) String orgIds) {
		try {
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			ApplicationInfo appInfo = this.synService.findAppById(appId);
			String[] orgIdArray = orgIds.trim().split(",");
			String result = null;
			int successCount = 0;
			int errorCount = 0;
			for (int i = 0; i < orgIdArray.length; i++) {
				String infoCode = orgIdArray[i];
				result = this.synService.synStart(appId, infoCode, "43");
				String today = TimeUtil
						.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
				Org org = this.synService.findOrgById(Long.parseLong(infoCode));
				if (result != null && result.equals("000")) {
					result = "同步成功";
					String synSql = "from SynOrg u where u.appId='" + appId
							+ "' and u.orgId='" + infoCode + "'";
					List<SynOrg> synOrgList = this.synService.findByHql(synSql);
					if (synOrgList != null && synOrgList.size() > 0) {
						for (int j = 0; j < synOrgList.size(); j++) {
							this.synService.delete(synOrgList.get(j));
						}
					}
					successCount++;
					// 添加记录日志的操作
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("组织(" + org.getName() + ")删除操作："
							+ result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				} else {
					errorCount++;
					// 添加记录日志的操作
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(appId);
					synLog.setAppName(appInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("组织(" + org.getName() + ")删除操作："
							+ result);
					synLog.setSynUserId(currentUser.getCode());
					synLog.setSynUserName(currentUser.getName());
					this.synService.save(synLog);
				}
			}
			model.addObject("appId", appId);
			if (orgIdArray.length == 1) {
				model.addObject("flag", 0);
				model.addObject("result", result);
			} else {
				model.addObject("flag", 1);
				model.addObject("successCount", successCount);
				model.addObject("errorCount", errorCount);
			}
			return NewRedirect(model, "/syn/listSynOrg");
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping({ "/listSynLog" })
	public ModelAndView listSynLog(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "mhss", required = false) String mhss) {

		if (pagesize == null) {
			pagesize = Integer.valueOf(10);
		}
		if (thispage == null) {
			thispage = Integer.valueOf(0);
		}
		Long totalcount = this.synService.countSynLogAccount(mhss);
		if ((thispage.intValue() * pagesize.intValue() >= totalcount
				.longValue()) && (totalcount.longValue() > 0L)) {
			thispage = Integer.valueOf(thispage.intValue() - 1);
		}
		List<SynLog> synLogList = this.synService.listSynLogAccount(thispage,
				pagesize, mhss);
		model.addObject("mhss", mhss);
		model.addObject("synLogList", synLogList);
		model.setViewName("/pages/syn/synLogList");
		return Model(model, thispage, pagesize, totalcount);
	}

	@RequestMapping({ "/loadAppInfo" })
	public void loadAppInfo(
			HttpServletResponse response,
			@RequestParam(value = "userAccountCode", required = true) String userAccountCode) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			UserAccount currentUserAccount = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			Org org = currentUserAccount.getOrg();
			Division division = new Division();
			if (org != null) {
				division = org.getDivision();
			}
			Division userDivision = new Division();
			UserAccount userAccount = this.synService
					.findUserById(userAccountCode);
			if (userAccount.getOrg() != null) {
				userDivision = userAccount.getOrg().getDivision();
			}
			PrintWriter out = response.getWriter();
			String sql = "SELECT app.id,app_name,CASE WHEN syn.id is NULL THEN 0 ELSE 1 END sys_status,app.op_level,app.user_level FROM app_applicationinfo app LEFT JOIN (SELECT * from syn_user where user_id='"
					+ userAccountCode
					+ "') syn on app.id = syn.app_id  where app.status='1' order by seq";
			List appInfoList = this.commDAO.getListbySql(sql);
			/*String mergeUuid = currentUserAccount.getMergeUuid();
			String userSql = "";
			if(mergeUuid!=null && !mergeUuid.equals("")){
				userSql = "SELECT t1.id,app_name,CASE WHEN syn.id is NULL THEN 0 ELSE 1 END sys_status,t1.op_level,t1.user_level "
						+ "FROM (SELECT * FROM 	app_applicationinfo app LEFT JOIN (SELECT syn.app_id FROM ( SELECT u. CODE "
						+"FROM t_user_account u WHERE u.merge_uuid = '"+mergeUuid+"' ) a "
						+ "LEFT JOIN syn_user syn ON a.CODE = syn.user_id) t  on app.id = t.app_id "
						+"WHERE app.STATUS = '1' ) t1 LEFT JOIN (SELECT * from syn_user where user_id='"
					+ userAccountCode
					+ "') syn on t1.id = syn.app_id WHERE t1.app_id is not null ";
			}else{
				userSql =" select app.id,app_name,CASE WHEN syn.id is NULL THEN 0 ELSE 1 END sys_status,app.op_level,app.user_level from app_applicationinfo app LEFT JOIN (SELECT * from syn_user where user_id='"
					+ userAccountCode
					+ "') syn on app.id = syn.app_id  WHERE app.id in(SELECT app_id FROM syn_user u  WHERE u.user_id = '" +currentUserAccount.getCode()+"')  and app.status = '1'";
			}
			List appInfoList = this.commDAO.getListbySql( userSql);*/
			List appList = new ArrayList();
			for (int i = 0; i < appInfoList.size(); i++) {
				Map u = new HashMap();
				Object[] object = (Object[]) appInfoList.get(i);
				String appId = object[0].toString();
				String appName = object[1].toString();
				String status = object[2].toString();
				String opLevel = object[3].toString();
				String userLevel = object[4].toString();
				int op = Integer.parseInt(opLevel);
				boolean hidden =false;
				if (division != null) {
					if (division.getLevel() > op) {
						/*continue;*/
						hidden =true;
					}
				}
				int user = Integer.parseInt(userLevel);
				if (userDivision != null) {
					if (userDivision.getLevel() > user) {
						//continue;
						hidden = true;
					}
				}
				u.put("appId", appId);
				u.put("appName", appName);
				u.put("status", status);
				u.put("hidden",hidden);
				appList.add(u);
			}
			JSONArray jsonArray = JSONArray.fromObject(appList);
			out.write(jsonArray.toString());
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping({ "/listSynApp" })
	public ModelAndView listSynApp(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		UserAccount currentUserAccount = UserAccountUtil.getInstance()
				.getCurrentUserAccount();
		if (pagesize == null) {
			pagesize = Integer.valueOf(10);
		}
		if (thispage == null) {
			thispage = Integer.valueOf(0);
		}
		Long totalcount = this.synService.getSynUserApp(currentUserAccount);
		// System.out.println(totalcount);
		if ((thispage.intValue() * pagesize.intValue() >= totalcount
				.longValue()) && (totalcount.longValue() > 0L)) {
			thispage = Integer.valueOf(thispage.intValue() - 1);
		}
		List<ApplicationInfo> synAppList = this.synService.listSynUserApp(
				currentUserAccount, thispage, pagesize);
		model.addObject("synAppList", synAppList);
		model.setViewName("/back/index");
		return Model(model, thispage, pagesize, totalcount);
	}
}
