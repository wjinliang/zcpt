package com.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.ApplicationInfo;
import com.app.model.SynUser;
import com.app.service.AsyncService;
import com.app.service.SynService;
import com.app.util.SimpleCrypto;
import com.app.util.SynUtil;
import com.app.util.TimeUtil;
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
@RequestMapping({ "/synuseraccount" })
public class SynUserAccountController extends DefaultController {

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
	
	@Resource
	private AsyncService asyncService;

	@RequestMapping({ "/save" })
	@FormToken(remove=true)
	public ModelAndView save(ModelAndView model, UserAccount useraccount,
			HttpServletRequest request,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "imgid", required = false) String imgid,
			@RequestParam(value = "isadmin", required = false) Boolean isadmin) {
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
				model.addObject("orgid", orgid);
				return NewRedirect(model, "/orgAndUser/listUsers");
			} else {
				UserAccount currentUserAccount = UserAccountUtil.getInstance()
						.getCurrentUserAccount();
				String code = String.valueOf(System.currentTimeMillis());
				useraccount.setCode(code);
				ShaPasswordEncoder sha = new ShaPasswordEncoder();
				sha.setEncodeHashAsBase64(false);
				String password = useraccount.getPassword();
				useraccount.setPassword(sha.encodePassword(password, null));
				String encryptPassword = SimpleCrypto.encrypt("zcpt@123456",
						password);
				useraccount.setSynPassword(encryptPassword);
				useraccount.setLocked(false);
				useraccount.setAccountExpired(true);
				useraccount.setPasswordExpired(true);
				//System.out.println(orgid + "---------------");
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
				useraccount.setCreateUser(currentUserAccount.getName());
				useraccount.setCreateDate(TimeUtil
						.getTheDateOfToday("yyyy-MM-dd HH:mm:ss"));
				SynUtil syn = new SynUtil();
				String roleId = syn.getSynInfo("roleId");
				UserRole userRole = this.commonDAO.findOne(UserRole.class, roleId);
				Set<UserRole> roleSet =new HashSet<UserRole>();
				roleSet.add(userRole);
				if(isadmin!=null && isadmin){
					UserRole r =this.commonDAO.findOne(UserRole.class, syn.getSynInfo("zzjgRoleId"));
					roleSet.add(r);
				}
				useraccount.setRoles(roleSet);
				this.userAccountService.insertUser(useraccount);
				model.addObject("orgid", orgid);
				model.addObject("useraccountid", useraccount.getCode());
				return NewRedirect(model, "/useraccount/form/edit");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping({ "/resetPassword" })
	public void resetPassword(
			HttpServletResponse response,
			@RequestParam(value = "useraccountid", required = true) String useraccountid,
			@RequestParam(value = "p", required = true) String p)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			UserAccount user = new UserAccount();
			user = this.userAccountService.findOne(useraccountid);
			String newPassword = p;
			ShaPasswordEncoder sha = new ShaPasswordEncoder();
			sha.setEncodeHashAsBase64(false);
			String jiamicode = sha.encodePassword(newPassword, null);
			String encryptPassword = SimpleCrypto.encrypt("zcpt@123456",
					newPassword);
			user.setSynPassword(encryptPassword);
			user.setPassword(jiamicode);
			this.userAccountService.updateUser(user);
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

	private String getRandomString(int length) {
		String base = "abcdefghijklmnopqrstuvwxyz0123456789";
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int number = random.nextInt(base.length());
			sb.append(base.charAt(number));
		}
		return sb.toString();
	}

	@RequestMapping({ "/http" })
	public void httpText(HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			String parameter = request.getParameter("infoCode");
			System.out.println(parameter);
			PrintWriter writer = response.getWriter();
			ApplicationInfo applicationInfo = this.commonDAO.findOne(
					ApplicationInfo.class, "402883f752535f13015253c137a80017");
			writer.write(applicationInfo.getAppName());
			writer.flush();
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping({ "/ssoLogin" })
	public ModelAndView ssoLogin(ModelAndView model, HttpServletRequest request) {
		try {
			request.getSession().removeAttribute("validateCode");
			String uuid = request.getParameter("AUTH_TICKET");
			String masterPassword = "zcpt@123456";
			uuid = SimpleCrypto.decrypt(masterPassword, uuid);
			UserAccount userAccount = this.commonDAO.findOne(UserAccount.class,
					uuid);
			String loginname = "";
			String password = "";
			if (userAccount != null) {
				loginname = userAccount.getLoginname();
				String synPassword = userAccount.getSynPassword();
				password = SimpleCrypto.decrypt("zcpt@123456", synPassword);
			}
			String action = "/j_spring_security_check?j_username=" + loginname
					+ "&j_password=" + password;
			return NewRedirect(model, action);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}

	}

	@RequestMapping({ "/ssoService" })
	public ModelAndView ssoService(ModelAndView model,
			HttpServletRequest request) {
		try {
			String xtbs = request.getParameter("xtbs");
			String uuid = request.getParameter("uuid");
			String param = request.getParameter("param");
			if (xtbs == null || xtbs.equals("") || uuid == null
					|| uuid.equals(""))
				return Error("访问连接错误！");
			List<ApplicationInfo> applicationInfoList = this.commonDAO
					.findByPropertyName(ApplicationInfo.class, "appCode", xtbs);
			if (applicationInfoList != null && applicationInfoList.size() > 0) {
				ApplicationInfo app = applicationInfoList.get(0);
				if (!app.getStatus().equals("1")) {
					return Error("该系统已被禁用，请联系管理员！");
				}
				UserAccount user = this.commonDAO.findOne(UserAccount.class,
						uuid);
				if (user == null) {
					return Error("你不具备访问此系统的权限！");
				}
				String mergeUuid = user.getMergeUuid();
				if (mergeUuid != null && !mergeUuid.equals("")) {
					String hql = " from SynUser u where u.appId= '"
							+ app.getId()
							+ "' and u.userId in (select u.code from UserAccount u where u.mergeUuid = '"
							+ mergeUuid + "')";
					List<SynUser> synList = this.commonDAO.find(hql);
					if (synList == null || synList.size() == 0) {
						return Error("你不具备访问此系统的权限！");
					}
					for (SynUser synUser : synList) {
						String userId = synUser.getUserId();
						if (userId.equals(uuid)) {
							break;
						} else {
							uuid = userId;
						}
					}
				} else {
					String hql = " from SynUser u where u.appId= '"
							+ app.getId() + "' and u.userId = '" + uuid + "'";
					List synList = this.commonDAO.find(hql);
					if (synList == null || synList.size() == 0) {
						return Error("你不具备访问此系统的权限！");
					}
				}
				String masterPassword = "zcpt@123456";
				uuid = SimpleCrypto.encrypt(masterPassword, uuid);
				String appPath = app.getAppPath();
				if (appPath != null && !appPath.equals("")) {
					if (appPath.indexOf("?") >= 0) {
						appPath = appPath + "&AUTH_TICKET=" + uuid;
					} else {
						appPath = appPath + "?AUTH_TICKET=" + uuid;
					}
					Enumeration<String> parameterNames = request
							.getParameterNames();
					while (parameterNames.hasMoreElements()) {
						String string = (String) parameterNames.nextElement();
						if (string != null && !string.equals("")
								&& !string.equals("xtbs")
								&& !string.equals("uuid")) {
							String parameter = request.getParameter(string);
							appPath = appPath + "&" + string + "=" + parameter;
						}
					}
					System.out.println(appPath);
					return NewRedirect(model, appPath);
				} else {
					return Error("该系统单点地址为空，请联系管理员！");
				}
			} else {
				return Error("系统尚未注册！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}

	}

	@RequestMapping({ "/ssoServiceBySession" })
	public ModelAndView ssoServiceBySession(ModelAndView model,
			HttpServletRequest request) {
		try {
			String xtbs = request.getParameter("xtbs");
			//String type = request.getParameter("param");//20170208 修改根据IP区分移动联通 -
			UserAccount currentUserAccount = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			List<ApplicationInfo> applicationInfoList = this.commonDAO
					.findByPropertyName(ApplicationInfo.class, "appCode", xtbs);
			if (applicationInfoList != null && applicationInfoList.size() > 0) {
				ApplicationInfo app = applicationInfoList.get(0);
				if (!app.getStatus().equals("1")) {
					return Error("该系统已被禁用，请联系管理员！");
				}
				String mergeUuid = currentUserAccount.getMergeUuid();
				String uuid = currentUserAccount.getCode();
				if (mergeUuid != null && !mergeUuid.equals("")) {
					String hql = " from SynUser u where u.appId= '"
							+ app.getId()
							+ "' and u.userId in (select u.code from UserAccount u where u.mergeUuid = '"
							+ mergeUuid + "')";
					List<SynUser> synList = this.commonDAO.find(hql);
					if (synList == null || synList.size() == 0) {
						return Error("你不具备访问此系统的权限！");
					}
					for (SynUser synUser : synList) {
						String userId = synUser.getUserId();
						if (userId.equals(uuid)) {
							break;
						} else {
							uuid = userId;
						}
					}
				} else {
					String hql = " from SynUser u where u.appId= '"
							+ app.getId() + "' and u.userId = '" + uuid + "'";
					List synList = this.commonDAO.find(hql);
					if (synList == null || synList.size() == 0) {
						return Error("你不具备访问此系统的权限！");
					}
				}
				String masterPassword = "zcpt@123456";
				uuid = SimpleCrypto.encrypt(masterPassword, uuid);
				//String appPath = (type==null||type.equals(""))? app.getAppPath():app.getAppPath1();//20170208 修改根据IP区分移动联通 -
				String appPath = getAppPath(request,app);//20170208 修改根据IP区分移动联通 +
				if (appPath != null && !appPath.equals("")) {
					if (appPath.indexOf("?") >= 0) {
						appPath = appPath + "&AUTH_TICKET=" + uuid;
					} else {
						appPath = appPath + "?AUTH_TICKET=" + uuid;
					}
					Enumeration<String> parameterNames = request
							.getParameterNames();
					while (parameterNames.hasMoreElements()) {
						String string = (String) parameterNames.nextElement();
						if (string != null && !string.equals("")
								&& !string.equals("xtbs")) {
							String parameter = request.getParameter(string);
							appPath = appPath + "&" + string + "=" + parameter;
						}
					}
					//System.out.println(appPath);
					return NewRedirect(model, appPath);
				} else {
					return Error("该系统单点地址为空，请联系管理员！");
				}
			} else {
				return Error("系统尚未注册！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}

	}

	private String getAppPath(HttpServletRequest request, ApplicationInfo app) {//20170208 修改根据IP区分移动联通
		String path1 =  app.getAppPath1();
		if(path1==null || path1.equals("")){
			return app.getAppPath();
		}
		String type = null;
		try {
			type = new SynUtil().getIPType(request);
		} catch (IOException e) {
			System.err.println("获取IP失败:"+e.getMessage());
			e.printStackTrace();
		}
		if(type == null){
			return app.getAppPath();
		}
		if(type.equals(SynUtil.DIANXIN)){
			return app.getAppPath1();
		}
		if(type.equals(SynUtil.LIANTONG)){
			return app.getAppPath();
		}
		return app.getAppPath();
	}

	@RequestMapping("/savepassword")
	public ModelAndView savepassword(
			ModelAndView model,
			@RequestParam(value = "useraccountid", required = false) String useraccountid,
			@RequestParam(value = "oldpassword") String oldpassword,
			@RequestParam(value = "newpassword") String newpassword) {
		try {
			UserAccount mg = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
			ShaPasswordEncoder sha = new ShaPasswordEncoder();
			sha.setEncodeHashAsBase64(false);
			String opsw = sha.encodePassword(oldpassword, null);
			if (mg.getPassword().equals(opsw)) {
				mg.setPassword(sha.encodePassword(newpassword, null));
				String encryptPassword = SimpleCrypto.encrypt("zcpt@123456",
						newpassword);
				mg.setSynPassword(encryptPassword);
				userAccountService.updateUser(mg);
				String targetUrl = "";
				Set<UserRole> roles = mg.getRoles();
				for (UserRole userRole : roles) {
					targetUrl = userRole.getHomePage();
					if (targetUrl != null && !targetUrl.equals("")) {
						break;
					}
				}
				asyncService.asyncUser(mg.getCode());
				return Redirect(model, getRootPath() + targetUrl, "修改密码成功");
			} else {
				return RedirectError(model, getRootPath() + "/login?error=pwd",
						"修改失败：旧密码不正确！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
}
