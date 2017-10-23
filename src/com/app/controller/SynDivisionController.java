package com.app.controller;

import java.io.IOException;
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
import net.sf.json.JSONObject;

import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.ApplicationInfo;
import com.app.model.SynDivision;
import com.app.model.SynLog;
import com.app.service.SynService;
import com.app.util.TimeUtil;
import com.app.util.UUIDUtil;
import com.dm.ais.dao.CommDAO;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.DivisionBak;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;
import com.dm.platform.service.DivisionService;
import com.dm.platform.service.FileService;
import com.dm.platform.service.OrgAndUserService;
import com.dm.platform.service.OrgService;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.service.UserAttrService;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping({ "/syndivision" })
public class SynDivisionController extends DefaultController {

	@Resource
	private UserAccountService userAccountService;
	@Resource
	OrgAndUserService orgAndUserService;
	@Resource
	DivisionService divisionService;

	@Resource
	private UserAttrService userAttrService;

	@Resource
	private FileService fileService;

	@Resource
	private CommonDAO commonDAO;

	@Resource
	private CommDAO commDAO;

	@Resource
	private SessionRegistry sessionRegistry;

	@Resource
	private SynService synService;

	@Resource
	private OrgService orgService;

	@RequestMapping({ "/loadAppInfo" })
	public void loadAppInfo(HttpServletResponse response,
			@RequestParam(value = "divisionId", required = true) String divisionId) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			/*UserAccount currentUserAccount = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			Org org = currentUserAccount.getOrg();*/
			Org org = getOrgByCurrentUserNoSession();
			Division division = new Division();
			if (org != null) {
				division = org.getDivision();
			}
			/*Division userDivision = new Division();
			Org userOrg = this.commonDAO
					.findOne(Org.class, Long.valueOf(orgId));
			if (userOrg != null) {
				userDivision = userOrg.getDivision();
			}*/
			PrintWriter out = response.getWriter();
			String sql = "SELECT app.id,app_name,CASE WHEN syn.id is NULL THEN 0 ELSE 1 END sys_status,app.op_level,app.user_level FROM app_applicationinfo app LEFT JOIN (SELECT * from syn_division where division_id='"
					+ divisionId + "') syn on app.id = syn.app_id where app.status='1' order by seq";
			List appInfoList = this.commDAO.getListbySql(sql);
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
				/*if (division != null) {
					if (division.getLevel() > op) {
						continue;
					}
				}*/
				/*int user = Integer.parseInt(userLevel);
				if (userDivision != null) {
					if (userDivision.getLevel() > user) {
						continue;
					}
				}*/
				u.put("appId", appId);
				u.put("appName", appName);
				u.put("status", status);
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
	private Org getOrgByCurrentUserNoSession() {
		UserAccount currentUserAccount = UserAccountUtil.getInstance()
				.getCurrentUserAccount();
		return orgAndUserService.loadOrg(currentUserAccount);
	}
	@RequestMapping({ "/delete" })
	public void delete(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "orgid", required = false) String orgid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		UserAccount currentUser = UserAccountUtil.getInstance()
				.getCurrentUserAccount();
		try {
			if (orgid != null) {
				String[] rid = orgid.split(",");
				for (String str : rid) {
					Division o = new Division();
					o = commonDAO.findOne(Division.class, str);
					if(o.getChildren().size()>0){
						System.out.println("区划删除失败,有下级节点");
						out.write("区划删除失败,有下级节点\n");
						continue;
					}
					if(o.getOrg().size()>0){
						System.out.println("区划删除失败,下级组织");
						out.write("区划删除失败,下级组织\n");
						continue;
					}
					
					DivisionBak divisionbak = new DivisionBak(o,currentUser);
					commonDAO.saveOrUpdate(divisionbak);
					
					divisionService.deleteOrg(o);
					out.write("区划删除成功\n");
				}
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
	/*@RequestMapping({ "/delete" })
	public void delete(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "orgid", required = false) String orgid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		UserAccount currentUser = UserAccountUtil.getInstance()
				.getCurrentUserAccount();
		try {
			String synResult = "";
			if (orgid != null) {
				String[] rid = orgid.split(",");
				for (String str : rid) {
					Division o = new Division();
					o = commonDAO.findOne(Division.class, str);
					if(o.getChildren().size()>0){
						synResult += "false,";
						System.out.println("区划删除失败,有下级节点");
						continue;
					}
					if(o.getOrg().size()>0){
						synResult += "false,";
						System.out.println("区划删除失败,下级组织");
						continue;
					}
					try {
						List<SynDivision> synList = this.commonDAO
								.findByPropertyName(SynDivision.class, "divisionId",
										str);
						for (int i = 0; i < synList.size(); i++) {
							SynDivision synOrg = synList.get(i);
							String appId = synOrg.getAppId();
							String result = this.synService.synStart(appId,
									str, "53");
							ApplicationInfo applicationInfo = this.commonDAO
									.findOne(ApplicationInfo.class, appId);
							String today = TimeUtil
									.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
							if (result != null && result.equals("000")) {
								synResult += "true,";
								result = "同步成功";
								// 添加记录日志的操作
								SynLog synLog = new SynLog();
								synLog.setId(UUIDUtil.getUUID());
								synLog.setAppId(appId);
								synLog.setAppName(applicationInfo.getAppName());
								synLog.setSynTime(today);
								synLog.setSynResult("区划(" + o.getName()
										+ ")删除操作：" + result);
								synLog.setSynUserId(currentUser.getCode());
								synLog.setSynUserName(currentUser.getName());
								this.synService.save(synLog);
							} else {
								synResult += "false,";
								// 添加记录日志的操作
								SynLog synLog = new SynLog();
								synLog.setId(UUIDUtil.getUUID());
								synLog.setAppId(appId);
								synLog.setAppName(applicationInfo.getAppName());
								synLog.setSynTime(today);
								synLog.setSynResult("区划(" + o.getName()
										+ ")删除操作：" + result);
								synLog.setSynUserId(currentUser.getCode());
								synLog.setSynUserName(currentUser.getName());
								this.synService.save(synLog);
							}
						}
						if (!synResult.contains("false")) {
							List<Org> ualist = commonDAO.findByPropertyName(
									Org.class, "division.id", str);
							for (Org userAccount : ualist) {
								userAccount.setDivision(null);
								orgService.updateOrg(userAccount);
							}
							divisionService.deleteOrg(o);
						}
					} catch (Exception e) {
						synResult += "false,";
					}

				}
				if (!synResult.contains("false")) {
					out.write("ok");
				} else {
					out.write("false");
				}
				out.flush();
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
		}
	}*/

	@RequestMapping({ "/checkTongBu" })
	public ModelAndView checkTongBu(
			ModelAndView model,
			@RequestParam(value = "appCheckList", required = true) String appCheckList,
			@RequestParam(value = "divisionId", required = true) String divisionId) {
		Division org = this.commonDAO.findOne(Division.class, divisionId);
		String hql = "from ApplicationInfo t";
		List applist = this.commonDAO.find(hql);
		boolean isAppOrgTongBu;
		boolean isAppOrgChecked;
		List resultlist = new ArrayList();
		for (int i = 0; i < applist.size(); i++) {
			ApplicationInfo applicationInfo = (ApplicationInfo) applist.get(i);
			isAppOrgTongBu = isAppDivisionTongBu(applicationInfo.getId(), divisionId);
			isAppOrgChecked = isAppDivisionChecked(applicationInfo.getId(),
					appCheckList);
			String appId = applicationInfo.getId();
			String[] s = new String[3];
			s[0] = appId;
			s[1] = applicationInfo.getAppName();
			/*if (isAppOrgTongBu == false && isAppOrgChecked == false) {
				System.out.println(org.getName() + "--"
						+ applicationInfo.getAppName() + "什么也不操作");
				s[2] = "无";
			} else */if (isAppOrgTongBu == false && isAppOrgChecked == true) {
				System.out.println(org.getName() + "--"
						+ applicationInfo.getAppName() + "执行新增操作");
				int CREATEUSER = 11;
				// System.out.println("!!!!!!!!!!!!!!!!!!!!"+getUser().getRoles().size());
				s[2] = "新增";
				// 执行新增操作
			}
			else{
				System.out.println(org.getName() + "--"
						+ applicationInfo.getAppName() + "什么也不操作");
				s[2] = "无";
			}
			/* else if (isAppOrgTongBu == true && isAppOrgChecked == false) {
				System.out.println(org.getName() + "--"
						+ applicationInfo.getAppName() + "执行删除操作");
				int DELETEUSER = 13;
				s[2] = "删除";
			} else if (isAppOrgTongBu == true && isAppOrgChecked == true) {

				int UPDATEUSER = 12;
				s[2] = "更新";
			} else {
				System.out.println("同步判断出现异常！！");
			}*/
			resultlist.add(s);
		}
		model.addObject("resultlist", resultlist);
		model.addObject("appCheckList", appCheckList);
		model.setViewName("/pages/syn/synDivisionInfo");
		return Model(model);

	}

	/**
	 * 判断用户是否同步
	 * 
	 * @param appid
	 * @param userCode
	 * @return
	 */
	public boolean isAppDivisionTongBu(String appid, String divisionId) {
		boolean result = true;
		String hql = "select count(*) from SynDivision t where t.appId='" + appid
				+ "' and t.divisionId='" + divisionId + "'";
		//System.out.println(hql);
		Long count = this.commonDAO.count(hql);
		if (count > 0) {
			result = true;
		} else {
			result = false;
		}
		return result;
	}

	/**
	 * 判断是否向应用同步该组织
	 * 
	 * @param appid
	 * @param appcheckedList
	 * @return
	 */
	public boolean isAppDivisionChecked(String appid, String appcheckedList) {
		boolean result = false;
		result = appcheckedList.contains(appid);
		return result;
	}
	@RequestMapping({ "/ajaxsave" })
	public void ajaxsave(
			Division org,
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "appCheckList", required = true) String appCheckList) {
		try {

			Division o = this.commonDAO.findOne(Division.class, org.getId());
			o.setName(org.getName());
			o.setCode(org.getCode());
			o.setSeq(org.getSeq());
			o.setBigDivision(org.getBigDivision());
			o.setFullName(org.getFullName());
			o.setType(org.getType());
			o.setLevel(org.getLevel());
			this.divisionService.updateOrg(o);
			//System.out.println(appCheckList + "----------------");
			String hql = "from ApplicationInfo t";
			List applist = this.commonDAO.find(hql);
			boolean isAppOrgTongBu;
			boolean isAppOrgChecked;
			List resultlist = new ArrayList();
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			for (int i = 0; i < applist.size(); i++) {
				ApplicationInfo applicationInfo = (ApplicationInfo) applist
						.get(i);
				isAppOrgTongBu = isAppDivisionTongBu(applicationInfo.getId(), org
						.getId().toString());
				isAppOrgChecked = isAppDivisionChecked(applicationInfo.getId(),
						appCheckList);
				String appId = applicationInfo.getId();
				Map u = new HashMap();
				u.put("appName", applicationInfo.getAppName());
				 if (isAppOrgTongBu == false && isAppOrgChecked == true) {
					u.put("opType", "新增");
					String result = this.synService.synStart(appId, org.getCode()
							.toString(), "51");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						SynDivision synUser = new SynDivision();
						String uuid = UUIDUtil.getUUID();
						synUser.setAppId(appId);
						synUser.setId(uuid);
						synUser.setDivisionId(org.getId());
						synUser.setSynTime(today);
						this.synService.save(synUser);
						/*
						 * 添加记录日志的操作
						 */
						SynLog synLog = new SynLog();
						synLog.setId(UUIDUtil.getUUID());
						synLog.setAppId(appId);
						synLog.setAppName(applicationInfo.getAppName());
						synLog.setSynTime(today);
						synLog.setSynResult("区划(" + org.getName() + ")新增操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
						u.put("result", result);
					} else {
						SynLog synLog = new SynLog();
						synLog.setId(UUIDUtil.getUUID());
						synLog.setAppId(appId);
						synLog.setAppName(applicationInfo.getAppName());
						synLog.setSynTime(today);
						synLog.setSynResult("区划(" + org.getName() + ")新增操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
						u.put("result", result);
					}
					// 执行新增操作
				} else{
						u.put("opType", "无");
						u.put("result", "无操作");	
				}
					
				resultlist.add(u);
			}
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = response.getWriter();
			JSONArray jsonArray = JSONArray.fromObject(resultlist);
			writer.write(jsonArray.toString());
			writer.flush();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*@RequestMapping({ "/ajaxsave" })
	public void ajaxsave(
			Division org,
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "appCheckList", required = true) String appCheckList) {
		try {

			Division o = this.commonDAO.findOne(Division.class, org.getId());
			o.setName(org.getName());
			o.setCode(org.getCode());
			o.setSeq(org.getSeq());
			o.setBigDivision(org.getBigDivision());
			o.setFullName(org.getFullName());
			o.setType(org.getType());
			o.setLevel(org.getLevel());
			this.divisionService.updateOrg(o);
			//System.out.println(appCheckList + "----------------");
			String hql = "from ApplicationInfo t";
			List applist = this.commonDAO.find(hql);
			boolean isAppOrgTongBu;
			boolean isAppOrgChecked;
			List resultlist = new ArrayList();
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			for (int i = 0; i < applist.size(); i++) {
				ApplicationInfo applicationInfo = (ApplicationInfo) applist
						.get(i);
				isAppOrgTongBu = isAppDivisionTongBu(applicationInfo.getId(), org
						.getId().toString());
				isAppOrgChecked = isAppDivisionChecked(applicationInfo.getId(),
						appCheckList);
				String appId = applicationInfo.getId();
				Map u = new HashMap();
				u.put("appName", applicationInfo.getAppName());
				if (isAppOrgTongBu == false && isAppOrgChecked == false) {
					u.put("opType", "无");
					u.put("result", "无操作");	
				} else if (isAppOrgTongBu == false && isAppOrgChecked == true) {
					u.put("opType", "新增");
					String result = this.synService.synStart(appId, org.getCode()
							.toString(), "51");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						SynDivision synUser = new SynDivision();
						String uuid = UUIDUtil.getUUID();
						synUser.setAppId(appId);
						synUser.setId(uuid);
						synUser.setDivisionId(org.getId());
						synUser.setSynTime(today);
						this.synService.save(synUser);
						
						SynLog synLog = new SynLog();
						synLog.setId(UUIDUtil.getUUID());
						synLog.setAppId(appId);
						synLog.setAppName(applicationInfo.getAppName());
						synLog.setSynTime(today);
						synLog.setSynResult("区划(" + org.getName() + ")新增操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
						u.put("result", result);
					} else {
						SynLog synLog = new SynLog();
						synLog.setId(UUIDUtil.getUUID());
						synLog.setAppId(appId);
						synLog.setAppName(applicationInfo.getAppName());
						synLog.setSynTime(today);
						synLog.setSynResult("区划(" + org.getName() + ")新增操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
						u.put("result", result);
					}
					// 执行新增操作
				} else if (isAppOrgTongBu == true && isAppOrgChecked == true) {
					u.put("opType", "更新");
					String result = this.synService.synStart(appId, org.getCode()
							.toString(), "52");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						String synSql = "from SynDivision u where u.appId='" + appId
								+ "' and u.divisionId=" + org.getId() + "";
						List<SynDivision> synUserList = this.commonDAO.find(synSql);
						if (synUserList != null && synUserList.size() > 0) {
							for (int j = 0; j < synUserList.size(); j++) {
								synUserList.get(j).setSynTime(today);
								this.synService.update(synUserList.get(j));
							}
						}
						SynLog synLog = new SynLog();
						synLog.setId(UUIDUtil.getUUID());
						synLog.setAppId(appId);
						synLog.setAppName(applicationInfo.getAppName());
						synLog.setSynTime(today);
						synLog.setSynResult("区划(" + org.getName() + ")更新操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
					} else {
						SynLog synLog = new SynLog();
						synLog.setId(UUIDUtil.getUUID());
						synLog.setAppId(appId);
						synLog.setAppName(applicationInfo.getAppName());
						synLog.setSynTime(today);
						synLog.setSynResult("区划(" + org.getName() + ")更新操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
					}
					u.put("result", result);
				} else if (isAppOrgTongBu == true && isAppOrgChecked == false) {
					u.put("opType", "删除");
					String result = this.synService.synStart(appId, org.getCode()
							.toString(), "53");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						String synSql = "from SynDivision u where u.appId='" + appId
								+ "' and u.divisionId=" + org.getId() + "";
						List<SynDivision> synUserList = this.commonDAO.find(synSql);
						if (synUserList != null && synUserList.size() > 0) {
							for (int j = 0; j < synUserList.size(); j++) {
								this.synService.delete(synUserList.get(j));
							}
						}
						// 添加记录日志的操作
						SynLog synLog = new SynLog();
						synLog.setId(UUIDUtil.getUUID());
						synLog.setAppId(appId);
						synLog.setAppName(applicationInfo.getAppName());
						synLog.setSynTime(today);
						synLog.setSynResult("区划(" + org.getName() + ")删除操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
					} else {
						// 添加记录日志的操作
						SynLog synLog = new SynLog();
						synLog.setId(UUIDUtil.getUUID());
						synLog.setAppId(appId);
						synLog.setAppName(applicationInfo.getAppName());
						synLog.setSynTime(today);
						synLog.setSynResult("区划(" + org.getName() + ")删除操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
					}
					u.put("result", result);
				} else {
					System.out.println("同步判断出现异常！！");
				}
				resultlist.add(u);
			}
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = response.getWriter();
			JSONArray jsonArray = JSONArray.fromObject(resultlist);
			writer.write(jsonArray.toString());
			writer.flush();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}*/

	@RequestMapping({ "/synDivisionResult" })
	public ModelAndView synUserResult(ModelAndView model,
			@RequestParam(value = "result", required = true) String result) {
		try {
			result = java.net.URLDecoder.decode(result, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		JSONArray jsonArray = JSONArray.fromObject(result);
		List resultList = new ArrayList();
		for (int i = 0; i < jsonArray.size(); i++) {
			String[] r = new String[3];
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			r[0] = jsonObject.getString("appName");
			r[1] = jsonObject.getString("opType");
			r[2] = jsonObject.getString("result");
			resultList.add(r);
		}

		model.addObject("resultList", resultList);
		model.setViewName("/pages/syn/synDivisionResult");
		return Model(model);
	}
}
