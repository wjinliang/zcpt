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

import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.ApplicationInfo;
import com.app.model.SynLog;
import com.app.model.SynOrg;
import com.app.service.SynService;
import com.app.util.SimpleCrypto;
import com.app.util.TimeUtil;
import com.app.util.UUIDUtil;
import com.dm.ais.dao.CommDAO;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.FileEntity;
import com.dm.platform.model.Org;
import com.dm.platform.model.OrgBak;
import com.dm.platform.model.UserAccount;
import com.dm.platform.service.FileService;
import com.dm.platform.service.OrgAndUserService;
import com.dm.platform.service.OrgService;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.service.UserAttrService;
import com.dm.platform.target.FormToken;
import com.dm.platform.util.ReadProperties;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping({ "/synorg" })
public class SynOrgController extends DefaultController {

	@Resource
	private UserAccountService userAccountService;
	@Resource
	OrgAndUserService orgAndUserService;

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

	@RequestMapping({ "/loadAppInfo" })
	public void loadAppInfo(HttpServletResponse response,
			@RequestParam(value = "orgId", required = true) String orgId) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			UserAccount currentUserAccount = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			Org org = currentUserAccount.getOrg();
//			Org org = getOrgByCurrentUserNoSession();
			//String userSql = "";
			//修改为只有改用户有操作权限的才能同步
			/*String mergeUuid = currentUserAccount.getMergeUuid();
			if(mergeUuid!=null && !mergeUuid.equals("")){
				userSql = "SELECT t1.id,app_name,CASE WHEN syn.id is NULL THEN 0 ELSE 1 END sys_status,t1.op_level,t1.user_level "
						+ "FROM (SELECT * FROM 	app_applicationinfo app LEFT JOIN (SELECT syn.app_id FROM ( SELECT u. CODE "
						+"FROM t_user_account u WHERE u.merge_uuid = '"+mergeUuid+"' ) a "
						+ "LEFT JOIN syn_user syn ON a.CODE = syn.user_id) t  on app.id = t.app_id "
						+"WHERE app.STATUS = '1' ) t1 LEFT JOIN (SELECT * from syn_org where org_id='"
					+ orgId + "') syn on t1.id = syn.app_id WHERE t1.app_id is not null ";
			}else{
				userSql =" select app.id,app_name,CASE WHEN syn.id is NULL THEN 0 ELSE 1 END sys_status,app.op_level,app.user_level from app_applicationinfo app LEFT JOIN (SELECT * from syn_org where org_id='"
					+ orgId + "') syn on app.id = syn.app_id  WHERE app.id in(SELECT app_id FROM syn_user u  WHERE u.user_id = '" +currentUserAccount.getCode()+"')  and app.status = '1'";
			}*/
			//List<ApplicationInfo> synAppList = this.commonDAO.findByPage(userHql, thispage, pagesize);
			/*List synAppList = this.commDAO.getListbySql( userSql);*/
			Division division = new Division();
			if (org != null) {
				division = org.getDivision();
			}
			Division userDivision = new Division();
			Org userOrg = this.commonDAO
					.findOne(Org.class, Long.valueOf(orgId));
			if (userOrg != null) {
				userDivision = userOrg.getDivision();
			}
			PrintWriter out = response.getWriter();
			String sql = "SELECT app.id,app_name,CASE WHEN syn.id is NULL THEN 0 ELSE 1 END sys_status,app.op_level,app.user_level FROM app_applicationinfo app LEFT JOIN (SELECT * from syn_org where org_id='"
					+ orgId + "') syn on app.id = syn.app_id where app.status='1' order by seq";
			List appInfoList = this.commDAO.getListbySql(sql);
			List appList = new ArrayList();
			/*for (int i = 0; i < appInfoList.size(); i++) {
				Map u = new HashMap();
				Object[] object = (Object[]) appInfoList.get(i);*/
			for (int i = 0; i < appInfoList.size(); i++) {
				Map u = new HashMap();
				Object[] object = (Object[]) appInfoList.get(i);
				String appId = object[0].toString();
				String appName = object[1].toString();
				String status = object[2].toString();
				String opLevel = object[3].toString();
				String userLevel = object[4].toString();
				int op = Integer.parseInt(opLevel);
				boolean hidden = false;
				if (division != null) {
					if (division.getLevel() > op) {
						//continue;
						hidden = true;
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
				u.put("hidden", hidden);
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
	@RequestMapping({ "/save" })
	//@FormToken(remove=true)
	public ModelAndView save(ModelAndView model, UserAccount useraccount,
			HttpServletRequest request,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "imgid", required = false) String imgid) {
		try {
			UserAccount user = new UserAccount();
			if ((useraccount.getCode() != null)
					&& (!useraccount.getCode().equals(""))) {
				user = this.userAccountService.findOne(useraccount.getCode());
				user.setEnabled(useraccount.isEnabled());
				user.setName(useraccount.getName());
				user.setSeq(useraccount.getSeq());
				user.setEmail(useraccount.getEmail());
				user.setMobile(useraccount.getMobile());
				if ((imgid != null) && (!imgid.equals(""))) {
					if (user.getHeadphoto() == null) {
						FileEntity f = new FileEntity();
						f = (FileEntity) this.commonDAO.findOne(
								FileEntity.class, imgid);
						user.setHeadphoto(f);
						user.setHeadpic(f.getUrl());
						f.setSaveFlag("1");
						f.setUserObject("UserAccount");
						f.setObjField("headphoto");
						f.setUrlField("headpic");
						this.fileService.update(f);
					} else if (!user.getHeadphoto().getId().equals(imgid)) {
						FileEntity oldfile = user.getHeadphoto();
						oldfile.setSaveFlag("0");
						this.fileService.update(oldfile);

						FileEntity f = new FileEntity();
						f = (FileEntity) this.commonDAO.findOne(
								FileEntity.class, imgid);
						user.setHeadphoto(f);
						user.setHeadpic(f.getUrl());
						f.setSaveFlag("1");
						f.setUserObject("UserAccount");
						f.setObjField("headphoto");
						f.setUrlField("headpic");
						f.setObjId(useraccount.getCode());
						this.fileService.update(f);
					}
				}

				this.userAccountService.updateUser(user);
			} else {
				String code = String.valueOf(System.currentTimeMillis());
				useraccount.setCode(code);
				ShaPasswordEncoder sha = new ShaPasswordEncoder();
				sha.setEncodeHashAsBase64(false);
				String password = useraccount.getPassword();
				useraccount.setPassword(sha.encodePassword(password, null));
				String encryptPassword = SimpleCrypto.encrypt("zcpt@123456",
						password);
				useraccount.setSynPassword(encryptPassword);
				useraccount.setLocked(true);
				useraccount.setAccountExpired(true);
				useraccount.setPasswordExpired(true);
				if ((orgid != null) && (!orgid.equals(""))) {
					Org o = new Org();
					o = (Org) this.commonDAO.findOne(Org.class,
							Long.valueOf(orgid));
					useraccount.setOrg(o);
				} else {
					useraccount.setOrg(null);
				}
				if ((imgid != null) && (!imgid.equals(""))) {
					FileEntity f = new FileEntity();
					f = (FileEntity) this.commonDAO.findOne(FileEntity.class,
							imgid);
					useraccount.setHeadphoto(f);
					useraccount.setHeadpic(f.getUrl());
					f.setSaveFlag("1");
					f.setUserObject("UserAccount");
					f.setObjField("headphoto");
					f.setUrlField("headpic");
					f.setObjId(code);
					this.fileService.update(f);
				}
				this.userAccountService.insertUser(useraccount);
			}
			model.addObject("redirect", getRootPath() + "/useraccount/list");
			model.setViewName("/pages/content/redirect");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
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
//		try {
//			if(!currentUser.getOrg().getDivision().getId().equals("1")){
		Division ds = UserAccountUtil.getInstance().getCurrentUserAccountOrgDivision();
		try {
			if(!ds.getId().equals("1")){
				out.write("403");
				out.flush();
				out.close();
				return ;
			}
			String synResult = "";
			if (orgid != null) {
				String[] rid = orgid.split(",");
				for (String str : rid) {
					Org o = new Org();
					o = (Org) this.commonDAO.findOne(Org.class, new Long(str));
					if(o!=null){
						List<UserAccount> uslist = o.getUser();
						if(uslist.size()>0){
							for(UserAccount u:uslist){
								if(!u.isDelete()){
									out.write("hasUser");
									out.flush();
									out.close();
									return ;
								}
							}
						}
					}
					try {
						List<SynOrg> synList = this.commonDAO
								.findByPropertyName(SynOrg.class, "orgId",
										orgid);
						for (int i = 0; i < synList.size(); i++) {
							SynOrg synOrg = synList.get(i);
							String appId = synOrg.getAppId();
							if(appId.equals(ZSsystemId)){
								continue;
							}
							String result = this.synService.synStart(appId,
									str, "43");
							ApplicationInfo applicationInfo = this.commonDAO
									.findOne(ApplicationInfo.class, appId);
							String today = TimeUtil
									.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
							if (result != null && result.equals("000")) {
								synResult += "true,";
								result = "同步成功";
								String synSql = "from SynOrg u where u.appId='"
										+ appId + "' and u.orgId=" + str + "";
								List<SynOrg> synOrgList = this.commonDAO
										.find(synSql);
								if (synOrgList != null && synOrgList.size() > 0) {
									for (int j = 0; j < synOrgList.size(); j++) {
										this.synService
												.delete(synOrgList.get(j));
									}
								}
								// 添加记录日志的操作
								SynLog synLog = new SynLog();
								synLog.setId(UUIDUtil.getUUID());
								synLog.setAppId(appId);
								synLog.setAppName(applicationInfo.getAppName());
								synLog.setSynTime(today);
								synLog.setSynResult("组织(" + o.getName()
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
								synLog.setSynResult("组织(" + o.getName()
										+ ")删除操作：" + result);
								synLog.setSynUserId(currentUser.getCode());
								synLog.setSynUserName(currentUser.getName());
								this.synService.save(synLog);
							}
						}
						if (!synResult.contains("false")) {
							List<UserAccount> ualist = this.commonDAO
									.findByPropertyName(UserAccount.class,
											"org.id", new Long(str));
							for (UserAccount userAccount : ualist) {
								userAccount.setOrg(null);
								this.userAccountService.updateUser(userAccount);
							}
							OrgBak bak = new OrgBak(o,currentUser);
							commonDAO.saveOrUpdate(bak);
							this.orgService.deleteOrg(o);
						}
					} catch (Exception e) {
						synResult += "false,";
						e.printStackTrace();
						/*out.flush();
						out.close();*/
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
	}
	

	@RequestMapping({ "/checkTongBu" })
	public ModelAndView checkTongBu(
			ModelAndView model,
			@RequestParam(value = "appCheckList", required = true) String appCheckList,
			@RequestParam(value = "orgId", required = true) String orgId) {
		Org org = this.commonDAO.findOne(Org.class, Long.parseLong(orgId));
		String hql = "from ApplicationInfo t order by seq";
		List applist = this.commonDAO.find(hql);
		boolean commit =true;
		boolean isAppOrgTongBu;
		boolean isAppOrgChecked;
		List resultlist = new ArrayList();
		for (int i = 0; i < applist.size(); i++) {
			ApplicationInfo applicationInfo = (ApplicationInfo) applist.get(i);
			isAppOrgTongBu = isAppOrgTongBu(applicationInfo.getId(), orgId);
			isAppOrgChecked = isAppOrgChecked(applicationInfo.getId(),
					appCheckList);
			String appId = applicationInfo.getId();
			String[] s = new String[3];
			s[0] = appId;
			s[1] = applicationInfo.getAppName();
			if(appId.equals(ZSsystemId)){
				if (isAppOrgTongBu == false && isAppOrgChecked == true) {
					System.out.println(org.getName() + "--"
							+ applicationInfo.getAppName() + "执行新增操作");
					int CREATEUSER = 11;
					// System.out.println("!!!!!!!!!!!!!!!!!!!!"+getUser().getRoles().size());
					s[2] = "新增";
					commit= false;
				}else{
					System.out.println(org.getName() + "--"
							+ applicationInfo.getAppName() + "什么也不操作");
					s[2] = "不更新";
				}
				resultlist.add(s);
				continue;
			}
			if (isAppOrgTongBu == false && isAppOrgChecked == false) {
				System.out.println(org.getName() + "--"
						+ applicationInfo.getAppName() + "什么也不操作");
				s[2] = "无";
			} else if (isAppOrgTongBu == false && isAppOrgChecked == true) {
				System.out.println(org.getName() + "--"
						+ applicationInfo.getAppName() + "执行新增操作");
				int CREATEUSER = 11;
				// System.out.println("!!!!!!!!!!!!!!!!!!!!"+getUser().getRoles().size());
				s[2] = "新增";
				commit= false;
				// 执行新增操作
			} else if (isAppOrgTongBu == true && isAppOrgChecked == false) {
				System.out.println(org.getName() + "--"
						+ applicationInfo.getAppName() + "执行删除操作");
				int DELETEUSER = 13;
				commit= false;
				s[2] = "删除";
			} else if (isAppOrgTongBu == true && isAppOrgChecked == true) {

				int UPDATEUSER = 12;
				commit= false;
				s[2] = "更新";
			} else {
				System.out.println("同步判断出现异常！！");
			}
			resultlist.add(s);
		}
		/*if(commit){
			return Model(model);
		}*/
		model.addObject("resultlist", resultlist);
		model.addObject("appCheckList", appCheckList);
		model.setViewName("/pages/syn/synOrgInfo");
		return Model(model);

	}

	/**
	 * 判断用户是否同步
	 * 
	 * @param appid
	 * @param userCode
	 * @return
	 */
	public boolean isAppOrgTongBu(String appid, String orgId) {
		boolean result = true;
		String hql = "select count(*) from SynOrg t where t.appId='" + appid
				+ "' and t.orgId='" + orgId + "'";
		System.out.println(hql);
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
	public boolean isAppOrgChecked(String appid, String appcheckedList) {
		boolean result = false;
		result = appcheckedList.contains(appid);
		return result;
	}

	@RequestMapping({ "/ajaxsave" })
	@FormToken(remove=true)
	public void ajaxsave(
			Org org,
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "divisionid", required = false) String divisionid,
			@RequestParam(value = "appCheckList", required = true) String appCheckList) {
		try {

			Org o = this.orgService.findOne(org.getId());
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
			this.orgService.updateOrg(o);
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
				isAppOrgTongBu = isAppOrgTongBu(applicationInfo.getId(), org
						.getId().toString());
				isAppOrgChecked = isAppOrgChecked(applicationInfo.getId(),
						appCheckList);
				String appId = applicationInfo.getId();
				Map u = new HashMap();
				u.put("appName", applicationInfo.getAppName());
				if(appId.equals(ZSsystemId)){
					if (isAppOrgTongBu == false && isAppOrgChecked == true) {
						u.put("opType", "新增");
						String result = this.synService.synStart(appId, org.getId()
								.toString(), "41");
						String today = TimeUtil
								.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
						if (result != null && result.equals("000")) {
							result = "同步成功";
							SynOrg synUser = new SynOrg();
							String uuid = UUIDUtil.getUUID();
							synUser.setAppId(appId);
							synUser.setId(uuid);
							synUser.setOrgId(org.getId().toString());
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
							synLog.setSynResult("组织(" + org.getName() + ")新增操作："
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
							synLog.setSynResult("组织(" + org.getName() + ")新增操作："
									+ result);
							synLog.setSynUserId(currentUser.getCode());
							synLog.setSynUserName(currentUser.getName());
							this.synService.save(synLog);
							u.put("result", result);
						}
					}else{
						u.put("opType", "无");
						u.put("result", "不做操作");
					}
					resultlist.add(u);
					continue;
				}
				if (isAppOrgTongBu == false && isAppOrgChecked == false) {
					u.put("opType", "无");
					u.put("result", "无操作");
				} else if (isAppOrgTongBu == false && isAppOrgChecked == true) {
					u.put("opType", "新增");
					String result = this.synService.synStart(appId, org.getId()
							.toString(), "41");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						SynOrg synUser = new SynOrg();
						String uuid = UUIDUtil.getUUID();
						synUser.setAppId(appId);
						synUser.setId(uuid);
						synUser.setOrgId(org.getId().toString());
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
						synLog.setSynResult("组织(" + org.getName() + ")新增操作："
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
						synLog.setSynResult("组织(" + org.getName() + ")新增操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
						u.put("result", result);
					}
					// 执行新增操作
				} else if (isAppOrgTongBu == true && isAppOrgChecked == true) {
					u.put("opType", "更新");
					String result = this.synService.synStart(appId, org.getId()
							.toString(), "42");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						String synSql = "from SynOrg u where u.appId='" + appId
								+ "' and u.orgId=" + org.getId() + "";
						List<SynOrg> synUserList = this.commonDAO.find(synSql);
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
						synLog.setSynResult("组织(" + org.getName() + ")更新操作："
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
						synLog.setSynResult("组织(" + org.getName() + ")更新操作："
								+ result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
					}
					u.put("result", result);
				} else if (isAppOrgTongBu == true && isAppOrgChecked == false) {
					u.put("opType", "删除");
					String result = this.synService.synStart(appId, org.getId()
							.toString(), "43");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						String synSql = "from SynOrg u where u.appId='" + appId
								+ "' and u.orgId=" + org.getId() + "";
						List<SynOrg> synUserList = this.commonDAO.find(synSql);
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
						synLog.setSynResult("组织(" + org.getName() + ")删除操作："
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
						synLog.setSynResult("用户(" + org.getName() + ")删除操作："
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
	}

	@RequestMapping({ "/synUserResult" })
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
		model.setViewName("/pages/syn/synOrgResult");
		return Model(model);
	}
}
