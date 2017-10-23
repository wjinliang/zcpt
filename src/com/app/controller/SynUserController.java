package com.app.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
import net.sf.json.JSONObject;

import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.ApplicationInfo;
import com.app.model.SynLog;
import com.app.model.SynUser;
import com.app.service.SynService;
import com.app.util.SimpleCrypto;
import com.app.util.SynUtil;
import com.app.util.TimeUtil;
import com.app.util.UUIDUtil;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.FileEntity;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserRole;
import com.dm.platform.service.FileService;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.service.UserAttrService;
import com.dm.platform.target.FormToken;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping({ "/synuser" })
public class SynUserController extends DefaultController {

	@Resource
	private UserAccountService userAccountService;

	@Resource
	private UserAttrService userAttrService;

	@Resource
	private FileService fileService;

	@Resource
	private CommonDAO commonDAO;

	@Resource
	private SessionRegistry sessionRegistry;

	@Resource
	private SynService synService;

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
			@RequestParam(value = "userid", required = false) String userid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		UserAccount currentUser = UserAccountUtil.getInstance()
				.getCurrentUserAccount();
		try {
			String synResult = "";
			if (userid != null) {
				String[] rid = userid.split(",");
				for (String str : rid) {
					UserAccount ua = new UserAccount();
					ua = this.userAccountService.findOne(str);
					try {
						List<SynUser> synList = this.commonDAO
								.findByPropertyName(SynUser.class, "userId",
										str);
						for (int i = 0; i < synList.size(); i++) {
							SynUser synUser = synList.get(i);
							String appId = synUser.getAppId();
							String result = this.synService.synStart(appId,
									str, "13");
							ApplicationInfo applicationInfo = this.commonDAO
									.findOne(ApplicationInfo.class, appId);
							String today = TimeUtil
									.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
							if (result != null && result.equals("000")) {
								synResult += "true,";
								result = "同步成功";
								String synSql = "from SynUser u where u.appId='"
										+ appId
										+ "' and u.userId='"
										+ str
										+ "'";
								List<SynUser> synUserList = this.commonDAO
										.find(synSql);
								if (synUserList != null
										&& synUserList.size() > 0) {
									for (int j = 0; j < synUserList.size(); j++) {
										this.synService.delete(synUserList
												.get(j));
									}
								}
								// 添加记录日志的操作
								SynLog synLog = new SynLog();
								synLog.setId(UUIDUtil.getUUID());
								synLog.setAppId(appId);
								synLog.setAppName(applicationInfo.getAppName());
								synLog.setSynTime(today);
								synLog.setSynResult("用户(" + ua.getName()
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
								synLog.setSynResult("用户(" + ua.getName()
										+ ")删除操作：" + result);
								synLog.setSynUserId(currentUser.getCode());
								synLog.setSynUserName(currentUser.getName());
								this.synService.save(synLog);
							}
						}
					} catch (Exception e) {
						synResult += "false,";
						e.printStackTrace();
					}
					if (!synResult.contains("false")) {
						/*
						 * ua.setOrg(null); ua.setHeadphoto(null);
						 * ua.setRoles(null);
						 * this.userAccountService.updateUser(ua);
						 */
						 this.userAccountService.deleteUser(ua);
						/*ua.setDelete(true);
						this.userAccountService.updateUser(ua);*/

					}
				}
			}
			if (!synResult.contains("false")) {
				out.write("ok");
			} else {
				out.write("false");
			}
			out.flush();
			out.close();
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
			@RequestParam(value = "usercode", required = true) String usercode) {
		UserAccount user = this.commonDAO.findOne(UserAccount.class, usercode);
		String hql = "from ApplicationInfo t where t.status='1' order by seq";
		List applist = this.commonDAO.find(hql);
		boolean isAppUserTongBu;
		boolean isAppUserChecked;
		List resultlist = new ArrayList();
		for (int i = 0; i < applist.size(); i++) {
			ApplicationInfo applicationInfo = (ApplicationInfo) applist.get(i);
			isAppUserTongBu = isAppUserTongBu(applicationInfo.getId(), usercode);
			isAppUserChecked = isAppUserChecked(applicationInfo.getId(),
					appCheckList);
			String appId = applicationInfo.getId();
			String[] s = new String[3];
			s[0] = appId;
			s[1] = applicationInfo.getAppName();
			if (isAppUserTongBu == false && isAppUserChecked == false) {
				System.out.println(user.getName() + "--"
						+ applicationInfo.getAppName() + "什么也不操作");
				s[2] = "无";
			} else if (isAppUserTongBu == false && isAppUserChecked == true) {
				System.out.println(user.getName() + "--"
						+ applicationInfo.getAppName() + "执行新增操作");
				int CREATEUSER = 11;
				// System.out.println("!!!!!!!!!!!!!!!!!!!!"+getUser().getRoles().size());
				s[2] = "新增";
				// 执行新增操作
			} else if (isAppUserTongBu == true && isAppUserChecked == false) {
				System.out.println(user.getName() + "--"
						+ applicationInfo.getAppName() + "执行删除操作");
				int DELETEUSER = 13;
				s[2] = "删除";
			} else if (isAppUserTongBu == true && isAppUserChecked == true) {

				int UPDATEUSER = 12;
				s[2] = "更新";
			} else {
				System.out.println("同步判断出现异常！！");
			}
			resultlist.add(s);
		}
		model.addObject("resultlist", resultlist);
		model.addObject("appCheckList", appCheckList);
		model.setViewName("/pages/syn/synUserInfo");
		return Model(model);

	}

	/**
	 * 判断用户是否同步
	 * 
	 * @param appid
	 * @param userCode
	 * @return
	 */
	public boolean isAppUserTongBu(String appid, String userCode) {
		boolean result = true;
		String hql = "select count(*) from SynUser t where t.appId='" + appid
				+ "' and t.userId='" + userCode + "'";
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
	 * 判断是否向应用同步该用户
	 * 
	 * @param appid
	 * @param appcheckedList
	 * @return
	 */
	public boolean isAppUserChecked(String appid, String appcheckedList) {
		boolean result = false;
		result = appcheckedList.contains(appid);
		return result;
	}

	@RequestMapping({ "/ajaxsave" })
	@FormToken(remove=true)
	public void ajaxsave(
			UserAccount useraccount,
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "imgid", required = false) String imgid,
			@RequestParam(value = "isadmin",required = false) Boolean isadmin,
			@RequestParam(value = "appCheckList", required = true) String appCheckList) {
		try {
			UserAccount user = new UserAccount();
			if ((useraccount.getCode() != null)
					&& (!useraccount.getCode().equals(""))) {
				user = this.userAccountService.findOne(useraccount.getCode());
				SynUtil syn = new SynUtil();
				String roleId = syn.getSynInfo("roleId");
				UserRole userRole = this.commonDAO.findOne(UserRole.class, roleId);
				Set<UserRole> roleSet =new HashSet<UserRole>();
				roleSet.add(userRole);
				if(isadmin!=null && isadmin){
					UserRole r =this.commonDAO.findOne(UserRole.class, syn.getSynInfo("zzjgRoleId"));
					roleSet.add(r);
				}
				user.setRoles(roleSet);
				user.setEnabled(useraccount.isEnabled());
				user.setName(useraccount.getName());
				user.setSeq(useraccount.getSeq());
				user.setEmail(useraccount.getEmail());
				user.setMobile(useraccount.getMobile());
				user.setAddress(useraccount.getAddress());
				user.setBirthday(useraccount.getBirthday());
				user.setBizPhoneNo(useraccount.getBizPhoneNo());
				user.setDuty(useraccount.getDuty());
				user.setFaxno(useraccount.getFaxno());
				user.setGender(useraccount.getGender());
				user.setSchoolAge(useraccount.getSchoolAge());
				user.setSpeciality(useraccount.getSpeciality());
				user.setSystemId(useraccount.getSystemId());
				user.setTitle(useraccount.getTitle());
				user.setUserType(useraccount.getUserType());
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
			// System.out.println(appCheckList + "----------------");
			String hql = "from ApplicationInfo t where t.status='1' order by seq";
			List applist = this.commonDAO.find(hql);
			boolean isAppUserTongBu;
			boolean isAppUserChecked;
			List resultlist = new ArrayList();
			Map status = new HashMap();
			status.put("status", "1");
			status.put("resultList", resultlist);
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			for (int i = 0; i < applist.size(); i++) {
				ApplicationInfo applicationInfo = (ApplicationInfo) applist
						.get(i);
				isAppUserTongBu = isAppUserTongBu(applicationInfo.getId(),
						useraccount.getCode());
				isAppUserChecked = isAppUserChecked(applicationInfo.getId(),
						appCheckList);
				String appId = applicationInfo.getId();
				Map u = new HashMap();
				u.put("appName", applicationInfo.getAppName());
				if (isAppUserTongBu == false && isAppUserChecked == false) {
					u.put("opType", "无");
					u.put("result", "无操作");
				} else if (isAppUserTongBu == false && isAppUserChecked == true) {
					u.put("opType", "新增");
					String result = this.synService.synStart(appId,
							useraccount.getCode(), "11");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						SynUser synUser = new SynUser();
						String uuid = UUIDUtil.getUUID();
						synUser.setAppId(appId);
						synUser.setId(uuid);
						synUser.setUserId(useraccount.getCode());
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
						synLog.setSynResult("用户(" + useraccount.getName()
								+ ")新增操作：" + result);
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
						synLog.setSynResult("用户(" + useraccount.getName()
								+ ")新增操作：" + result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
						u.put("result", result);
						status.put("status", "0");
					}
					// 执行新增操作
				} else if (isAppUserTongBu == true && isAppUserChecked == true) {
					u.put("opType", "更新");
					String result = this.synService.synStart(appId,
							useraccount.getCode(), "12");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						String synSql = "from SynUser u where u.appId='"
								+ appId + "' and u.userId= '"
								+ useraccount.getCode() + "'";
						List<SynUser> synUserList = this.commonDAO.find(synSql);
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
						synLog.setSynResult("用户(" + useraccount.getName()
								+ ")更新操作：" + result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
					} else {
						SynLog synLog = new SynLog();
						synLog.setId(UUIDUtil.getUUID());
						synLog.setAppId(appId);
						synLog.setAppName(applicationInfo.getAppName());
						synLog.setSynTime(today);
						synLog.setSynResult("用户(" + useraccount.getName()
								+ ")更新操作：" + result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
						status.put("status", "0");
					}
					u.put("result", result);
				} else if (isAppUserTongBu == true && isAppUserChecked == false) {
					u.put("opType", "删除");
					String result = this.synService.synStart(appId,
							useraccount.getCode(), "13");
					String today = TimeUtil
							.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
					if (result != null && result.equals("000")) {
						result = "同步成功";
						String synSql = "from SynUser u where u.appId='"
								+ appId + "' and u.userId= '"
								+ useraccount.getCode() + "'";
						List<SynUser> synUserList = this.commonDAO.find(synSql);
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
						synLog.setSynResult("用户(" + useraccount.getName()
								+ ")删除操作：" + result);
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
						synLog.setSynResult("用户(" + useraccount.getName()
								+ ")删除操作：" + result);
						synLog.setSynUserId(currentUser.getCode());
						synLog.setSynUserName(currentUser.getName());
						this.synService.save(synLog);
						status.put("status", "0");
					}
					u.put("result", result);
				} else {
					System.out.println("同步判断出现异常！！");
					status.put("status", "0");
				}
				u.put("appCode", applicationInfo.getAppCode());

				resultlist.add(u);
			}
			String synid = SimpleCrypto.encrypt("zcpt@123456", user.getCode());
			status.put("id", synid);
			status.put("type", "1");
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = response.getWriter();
			JSONArray jsonArray = JSONArray.fromObject(status);
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
		System.out.println(result);
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
		model.setViewName("/pages/syn/synUserResult");
		return Model(model);

	}

	@RequestMapping({ "/synAppList" })
	@ResponseBody
	public Object showSynAppList(String userCode, HttpServletResponse response) {
		Map map = new HashMap();
		String synid = "";
		try {
			synid = SimpleCrypto.encrypt("zcpt@123456", userCode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		UserAccount userAccount = commonDAO
				.findOne(UserAccount.class, userCode);
		List<ApplicationInfo> synAppList = this.synService.listSynUserApp(
				userAccount, 0, 20);
		map.put("status", "1");
		map.put("id", synid);
		map.put("type", "1");
		map.put("list", synAppList);
		return map;
	}

	@RequestMapping({ "/showAppList" })
	public ModelAndView showAppList(ModelAndView model,
			@RequestParam(value = "ids", required = true) String ids,
			@RequestParam(value = "userid", required = false) String userid,
			@RequestParam(value = "orgid", required = false) String orgid) {
		try {
			List<ApplicationInfo> appList = new ArrayList<ApplicationInfo>();
			if (ids != null && !ids.equals("")) {
				String appHql = " from ApplicationInfo a where a.id in (" + ids
						+ ") order by seq";
				// System.out.println(appHql);
				appList = this.commonDAO.find(appHql);
			}
			String id = "";
			String type = "";
			if (userid != null && !userid.equals("")) {
				id = userid;
				type = "1";
			} else if (orgid != null && !orgid.equals("")) {
				id = orgid;
				type = "0";
			}
			String synid = "";
			if (id != null && !id.equals("")) {
				synid = SimpleCrypto.encrypt("zcpt@123456", id);
			}
			model.addObject("appList", appList);
			model.addObject("id", synid);
			model.addObject("type", type);
			String view = "/pages/syn/chooseRole";
			model.setViewName(view);
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
}
