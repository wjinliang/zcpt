package com.dm.platform.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.app.service.SynService;
import com.app.util.SynUtil;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.FileEntity;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserAttrEntity;
import com.dm.platform.model.UserRole;
import com.dm.platform.service.FileService;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.service.UserAttrService;
import com.dm.platform.target.FormToken;
import com.dm.platform.util.MailUtil;
import com.dm.platform.util.ReadProperties;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping("/useraccount")
public class UserAccountController extends DefaultController {
	@Resource
	UserAccountService userAccountService;

	@Resource
	UserAttrService userAttrService;

	@Resource
	FileService fileService;

	@Resource
	CommonDAO commonDAO;
	@Resource
	private SynService synService;

	@Resource
	private SessionRegistry sessionRegistry;
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

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/list")
	public ModelAndView list(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "orgids", required = false) String orgids,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = 10;
			}
			if (thispage == null) {
				thispage = 0;
			}
			Long totalcount = userAccountService
					.countUserAccount(orgid, orgids);
			if ((thispage) * pagesize >= totalcount && totalcount > 0) {
				thispage--;
			}
			List ml = new ArrayList();
			Map root = new HashMap();
			root.put("id", "");
			root.put("name",
					"全部用户" + "(" + commonDAO.count(UserAccount.class, "", null)
							+ ")");
			root.put("pId", null);
			root.put("open", true);
			ml.add(root);
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			List<Org> olist = commonDAO.findAll(Org.class, orders);
			for (Org org : olist) {
				Map m = new HashMap();
				m.put("id", org.getId());
				String ids = UserAccountUtil.getInstance().getDownOrgidsStrs(
						String.valueOf(org.getId()));
				List<Long> orglist = new ArrayList<Long>();
				for (String id : ids.split(",")) {
					orglist.add(new Long(id));
				}
				String sql = "select count(loginname) from UserAccount u where u.org.id in (:orgids) and u.delete=false";//--20161013用户假删除
				Map argsMap = new HashMap();
				argsMap.put("orgids", orglist);
				Long count = userAccountService.countByOrgIds(sql, argsMap);
				m.put("name", org.getName() + "(" + count + ")");
				if (org.getParent() != null) {
					m.put("pId", org.getParent().getId());
				} else {
					m.put("pId", "");
				}
				if (org.getChildren().size() != 0) {
					m.put("open", true);
				}
				ml.add(m);
			}
			JSONArray json = JSONArray.fromObject(ml);
			model.addObject("orgStr", json.toString());
			model.addObject("orgid", orgid);
			model.addObject("orgids", orgids);
			model.addObject("useraccounts", userAccountService.listUserAccount(
					orgid, orgids, thispage, pagesize));
			model.setViewName("/pages/admin/useraccount/list");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/listActiveUsers")
	public ModelAndView listActiveUsers(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = 20;
			}
			if (thispage == null) {
				thispage = 0;
			}
			List<Map<String, String>> list = UserAccountUtil.getInstance()
					.listActiveUsers(sessionRegistry);
			Long totalcount = Long.valueOf(list.size());
			model.addObject("lusers", list);
			model.setViewName("/pages/admin/useraccount/activity_list");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/kickUser")
	public void kickUser(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "sessionId", required = false) String sessionId)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			UserAccountUtil.getInstance().kickUser(sessionRegistry, sessionId);
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

	@RequestMapping("/form/{mode}")
	@FormToken(save=true)
	public ModelAndView form(
			HttpServletRequest request,
			ModelAndView model,
			@PathVariable String mode,
			@RequestParam(value = "useraccountid", required = false) String useraccountid,
			@RequestParam(value = "orgid", required = false) String orgid) {
		
		try {
		model.addObject("isadmin",false);
		SynUtil syn = new SynUtil();
		String jigouRoleId = syn.getSynInfo("zzjgRoleId");
			UserAccount ua = new UserAccount();
			if (mode != null && !mode.equals("new")) {
				if (useraccountid != null) {
					ua = userAccountService.findOne(useraccountid);
					Set<UserRole> set =  ua.getRoles();
					for(UserRole r:set){
						if(r.getCode().equals(jigouRoleId)){
							model.addObject("isadmin",true);
							break;
						}
					}
					model.addObject("useraccount", ua);
					if (mode.equals("view")) {
						model.setViewName("/pages/admin/useraccount/view");
						return Model(model);
					}
				}
			} else {
				if (orgid != null && !orgid.equals("")) {
					/*ua.setSeq(commonDAO
							.count("select count(loginname) from UserAccount u where u.org.id="
									+ orgid) + 1);*/
					Org org = this.commonDAO.findOne(Org.class,
							Long.valueOf(orgid));
					ua.setOrg(org);
					String code = org.getCode();
					// String userLshSql =
					// " select max(u.loginname) from UserAccount u where u.org.id="+
					// orgid;
					String userLshSql = " select max(u.loginname) from UserAccount u where u.org.id="
							+ orgid
							+ " and u.createDate > '2016-05-12 00:00:00'";
					String max = this.commonDAO.max(userLshSql);
					if (max != null && !max.equals("")) {
						Long lsh = Long.valueOf(max) + 1;
						ua.setLoginname(String.valueOf(lsh));
					} else {
						ua.setLoginname(code + "001");
					}
				} else {
//					ua.setSeq(commonDAO
//							.count("select count(loginname) from UserAccount") + 1);
				}
				ua.setEnabled(true);
				model.addObject("useraccount", ua);
			}
			int thispage=0;
			int pagesize = 20;
			UserAccount currentUserAccount = UserAccountUtil.getInstance()
					.getCurrentUserAccount();
//			List<ApplicationInfo> appList = this.synService.listSynUserApp(
//					currentUserAccount, thispage, pagesize);
//			model.addObject("appList", appList);
			model.addObject("currentUser",currentUserAccount);
			model.addObject("mode", mode);
			model.addObject("orgid", orgid);
			model.setViewName("/pages/admin/useraccount/form");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/changepassword")
	public ModelAndView changepassword(
			HttpServletRequest request,
			@RequestParam(value = "useraccountid", required = false) String useraccountid,
			ModelAndView model) {
		try {
			model.addObject("useraccountid", useraccountid);
			model.setViewName("/pages/admin/useraccount/passwordform");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/savepassword")
	public ModelAndView savepassword(
			ModelAndView model,
			@RequestParam(value = "useraccountid", required = false) String useraccountid,
			@RequestParam(value = "oldpassword") String oldpassword,
			@RequestParam(value = "newpassword") String newpassword) {
		try {
			UserAccount mg = new UserAccount();
			mg = userAccountService.findOne(useraccountid);
			ShaPasswordEncoder sha = new ShaPasswordEncoder();
			sha.setEncodeHashAsBase64(false);
			String opsw = sha.encodePassword(oldpassword, null);
			if (mg.getPassword().equals(opsw)) {
				mg.setPassword(sha.encodePassword(newpassword, null));
				userAccountService.updateUser(mg);
				// model.setViewName("/pages/content/success");
				return Redirect(model, getRootPath() + "/infoCenter", "修改密码成功");
			} else {
				return RedirectError(model, getRootPath() + "/infoCenter",
						"修改失败：旧密码不正确！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/resetPassword")
	public void resetPassword(
			HttpServletResponse response,
			@RequestParam(value = "useraccountid", required = true) String useraccountid)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			UserAccount user = new UserAccount();
			user = userAccountService.findOne(useraccountid);
			String newPassword = getRandomString(12);
			ShaPasswordEncoder sha = new ShaPasswordEncoder();
			sha.setEncodeHashAsBase64(false);
			String jiamicode = sha.encodePassword(newPassword, null);
			user.setPassword(jiamicode);
			userAccountService.updateUser(user);
			MailUtil.getInstance().sendMail(user.getEmail(), "重置密码",
					"新的密码：" + newPassword + "请妥善保管！");
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
		}
	}

	private String getRandomString(int length) { // length表示生成字符串的长度
		String base = "abcdefghijklmnopqrstuvwxyz0123456789";
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int number = random.nextInt(base.length());
			sb.append(base.charAt(number));
		}
		return sb.toString();
	}

	@RequestMapping("/savepasswordm")
	public ModelAndView savepasswordm(
			ModelAndView model,
			@RequestParam(value = "useraccountid", required = false) String useraccountid,
			@RequestParam(value = "oldpassword") String oldpassword,
			@RequestParam(value = "newpassword") String newpassword) {
		try {
			UserAccount mg = new UserAccount();
			mg = userAccountService.findOne(useraccountid);
			ShaPasswordEncoder sha = new ShaPasswordEncoder();
			sha.setEncodeHashAsBase64(false);
			String opsw = sha.encodePassword(oldpassword, null);
			model.addObject("redirect", getRootPath() + "/mainpage");
			if (mg.getPassword().equals(opsw)) {
				mg.setPassword(sha.encodePassword(newpassword, null));
				userAccountService.updateUser(mg);
				model.setViewName("/pages/content/redirect");
			} else {
				model.setViewName("/pages/content/fail");
			}
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/save")
	@FormToken(remove=true)
	public ModelAndView save(ModelAndView model, UserAccount useraccount,
			HttpServletRequest request,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "imgid", required = false) String imgid,
			@RequestParam(value="isadmin",required=false)Boolean isadmin) {
		try {
			UserAccount user = new UserAccount();
			if (useraccount.getCode() != null
					&& !useraccount.getCode().equals("")) {
				user = userAccountService.findOne(useraccount.getCode());
				user.setEnabled(useraccount.isEnabled());
				user.setName(useraccount.getName());
				user.setSeq(useraccount.getSeq());
				user.setEmail(useraccount.getEmail());
				user.setMobile(useraccount.getMobile());
				if (imgid != null && !imgid.equals("")) {
					if (user.getHeadphoto() == null) {
						FileEntity f = new FileEntity();
						f = commonDAO.findOne(FileEntity.class, imgid);
						user.setHeadphoto(f);
						user.setHeadpic(f.getUrl());
						f.setSaveFlag("1");
						f.setUserObject("UserAccount");
						f.setObjField("headphoto");
						f.setUrlField("headpic");
						fileService.update(f);
					} else {
						if (!user.getHeadphoto().getId().equals(imgid)) {
							// 将旧文件逻辑删除
							FileEntity oldfile = user.getHeadphoto();
							oldfile.setSaveFlag("0");
							fileService.update(oldfile);
							// 添加新文件
							FileEntity f = new FileEntity();
							f = commonDAO.findOne(FileEntity.class, imgid);
							user.setHeadphoto(f);
							user.setHeadpic(f.getUrl());
							f.setSaveFlag("1");
							f.setUserObject("UserAccount");
							f.setObjField("headphoto");
							f.setUrlField("headpic");
							f.setObjId(useraccount.getCode());
							fileService.update(f);
						}
					}
				}
				userAccountService.updateUser(user);
			} else {
				String code = String.valueOf(System.currentTimeMillis());
				useraccount.setCode(code);
				ShaPasswordEncoder sha = new ShaPasswordEncoder();
				sha.setEncodeHashAsBase64(false);
				useraccount.setPassword(sha.encodePassword(
						useraccount.getPassword(), null));
				useraccount.setLocked(false);
				useraccount.setAccountExpired(true);
				useraccount.setPasswordExpired(true);
				if (orgid != null && !orgid.equals("")) {
					Org o = new Org();
					o = commonDAO.findOne(Org.class, Long.valueOf(orgid));
					useraccount.setOrg(o);
				} else {
					useraccount.setOrg(null);
				}
				if (imgid != null && !imgid.equals("")) {
					FileEntity f = new FileEntity();
					f = commonDAO.findOne(FileEntity.class, imgid);
					useraccount.setHeadphoto(f);
					useraccount.setHeadpic(f.getUrl());
					f.setSaveFlag("1");
					f.setUserObject("UserAccount");
					f.setObjField("headphoto");
					f.setUrlField("headpic");
					f.setObjId(code);
					fileService.update(f);
				}
				userAccountService.insertUser(useraccount);
			}
			model.addObject("redirect", getRootPath() + "/useraccount/list");
			model.setViewName("/pages/content/redirect");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/savem")
	public ModelAndView savem(ModelAndView model, UserAccount useraccount,
			HttpServletRequest request,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "imgid", required = false) String imgid) {
		try {
			UserAccount user = new UserAccount();
			if (useraccount.getCode() != null
					&& !useraccount.getCode().equals("")) {
				user = userAccountService.findOne(useraccount.getCode());
				if (useraccount.getName() != null)
					user.setName(useraccount.getName());
				if (orgid != null && !orgid.equals("")) {
					Org o = new Org();
					o = commonDAO.findOne(Org.class, Long.valueOf(orgid));
					user.setOrg(o);
				}
				if (imgid != null && !imgid.equals("")) {
					if (user.getHeadphoto() == null) {
						FileEntity f = new FileEntity();
						f = commonDAO.findOne(FileEntity.class, imgid);
						user.setHeadphoto(f);
						user.setHeadpic(f.getUrl());
						f.setSaveFlag("1");
						f.setUserObject("UserAccount");
						f.setObjField("headphoto");
						f.setUrlField("headpic");
						f.setObjId(useraccount.getCode());
						fileService.update(f);
					} else {
						if (!user.getHeadphoto().getId().equals(imgid)) {
							// 将旧文件逻辑删除
							FileEntity oldfile = user.getHeadphoto();
							oldfile.setSaveFlag("0");
							fileService.update(oldfile);
							// 添加新文件
							FileEntity f = new FileEntity();
							f = commonDAO.findOne(FileEntity.class, imgid);
							user.setHeadphoto(f);
							user.setHeadpic(f.getUrl());
							f.setSaveFlag("1");
							f.setUserObject("UserAccount");
							f.setObjField("headphoto");
							f.setUrlField("headpic");
							f.setObjId(useraccount.getCode());
							fileService.update(f);
						}
					}
				}
				userAccountService.updateUser(user);
			}
			model.addObject("redirect", getRootPath() + "/mainpage");
			model.setViewName("/pages/content/redirect");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/infoCenterUpdate")
	public ModelAndView infoCenterUpdate(ModelAndView model,
			UserAccount useraccount, HttpServletRequest request,
			UserAttrEntity userAttr,
			@RequestParam(value = "imgid", required = false) String imgid) {
		UserAccount entity = userAccountService.findOne(useraccount.getCode());
		UserAttrEntity userExt = userAttrService.findOne(useraccount.getCode());
		if (userExt == null) {
			userAttr.setUserId(useraccount.getCode());
			userAttrService.insert(userAttr);
		} else {
			userExt.setGender(userAttr.getGender());
			userExt.setIntroduce(userAttr.getIntroduce());
			userExt.setBirthDate(userAttr.getBirthDate());
			userAttrService.update(userExt);
		}
		entity.setName(useraccount.getName());
		entity.setMobile(useraccount.getMobile());
		entity.setEmail(useraccount.getEmail());
		entity.setAddress(useraccount.getAddress());
		if (imgid != null && !imgid.equals("")) {
			if (entity.getHeadphoto() == null) {
				FileEntity f = new FileEntity();
				f = commonDAO.findOne(FileEntity.class, imgid);
				entity.setHeadphoto(f);
				entity.setHeadpic(f.getUrl());
				f.setSaveFlag("1");
				f.setUserObject("UserAccount");
				f.setObjField("headphoto");
				f.setUrlField("headpic");
				f.setObjId(useraccount.getCode());
				fileService.update(f);
			} else {
				if (!entity.getHeadphoto().getId().equals(imgid)) {
					// 将旧文件逻辑删除
					FileEntity oldfile = entity.getHeadphoto();
					oldfile.setSaveFlag("0");
					fileService.update(oldfile);
					// 添加新文件
					FileEntity f = new FileEntity();
					f = commonDAO.findOne(FileEntity.class, imgid);
					entity.setHeadphoto(f);
					entity.setHeadpic(f.getUrl());
					f.setSaveFlag("1");
					f.setUserObject("UserAccount");
					f.setObjField("headphoto");
					f.setUrlField("headpic");
					f.setObjId(useraccount.getCode());
					fileService.update(f);
				}
			}
		}
		userAccountService.updateUser(entity);
		return Redirect(model, getRootPath() + "/infoCenter", "更新成功！");
	}

	@RequestMapping(value = "/upload", method = { RequestMethod.POST })
	public void upload(HttpServletResponse response,
			@RequestParam(value = "file", required = false) MultipartFile file) {
		try {
			String id = "";
			String path = ReadProperties.getInstance().getProperties(
					"imagePath");
			String realfileName = file.getOriginalFilename();
			String fileName = String.valueOf(System.currentTimeMillis())
					+ realfileName.substring(realfileName.lastIndexOf("."));
			File targetFile = new File(path);
			if (!targetFile.exists()) {
				targetFile.mkdirs();
			}
			SaveFileFromInputStream(file.getInputStream(), path, fileName);
			String url = ReadProperties.getInstance().getProperties("imageUrl")
					+ "/" + fileName;
			id = String.valueOf(System.currentTimeMillis());
			fileService.insertFile(id, url, String.valueOf(file.getSize()),
					realfileName, file.getContentType(), path + "/" + fileName,
					"0");
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(url + "," + id);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void SaveFileFromInputStream(InputStream stream, String path,
			String filename) throws IOException {
		FileOutputStream fs = new FileOutputStream(path + "/" + filename);
		byte[] buffer = new byte[1024 * 1024];
		int byteread = 0;
		while ((byteread = stream.read(buffer)) != -1) {
			fs.write(buffer, 0, byteread);
			fs.flush();
		}
		fs.close();
		stream.close();
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/selectuserroles/{useraccountid}")
	public ModelAndView menuLoad(ModelAndView model,
			@PathVariable String useraccountid) {
		if(useraccountid.equals(UserAccountUtil.getInstance().getCurrentUserId())){
			model.addObject("msg", "不能修改自己的权限,请联络上级管理员!");
			model.setViewName("/pages/back/err");
			return model;
		}
		try {
			UserAccount mg = new UserAccount();
			mg = userAccountService.findOne(useraccountid);
			List mlist = new ArrayList();
			List<UserRole> urlist = (List<UserRole>) commonDAO
					.findAll(UserRole.class);
			for (UserRole userRole : urlist) {
				if(userRole.getDetial()!=null && userRole.getDetial().equals("0")){
					continue;
				}
				Map m = new HashMap();
				m.put("id", userRole.getCode());
				m.put("name", userRole.getName());
				m.put("pId", 0);
				if (mg.getRoles().contains(userRole)) {
					m.put("checked", true);
				}
				mlist.add(m);
			}
			JSONArray json = JSONArray.fromObject(mlist);
			model.addObject("roleStr", json.toString());
			model.addObject("useraccountid", useraccountid);
			model.addObject("orgid", mg.getOrg().getId());
			model.setViewName("/pages/admin/useraccount/userroles");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	/*
	 * @SuppressWarnings({ "unchecked", "rawtypes" })
	 * 
	 * @RequestMapping("/selectorg/{useraccountid}") public ModelAndView
	 * selectorg(ModelAndView model,
	 * 
	 * @PathVariable String useraccountid) { try { UserAccount mg = new
	 * UserAccount(); mg = userAccountService.findOne(useraccountid); List ml =
	 * new ArrayList(); List<Order> orders = new ArrayList<Order>();
	 * orders.add(new Order(Direction.ASC, "seq")); List<Org> olist =
	 * commonDAO.findAll(Org.class, orders); for (Org org : olist) { Map m = new
	 * HashMap(); m.put("id", org.getId()); m.put("name", org.getName()); if
	 * (org.getParent() != null) { m.put("pId", org.getParent().getId()); } else
	 * { m.put("pId", 0); } if (org.getChildren().size() != 0) { m.put("open",
	 * true); } if (mg.getOrg() != null) { if (mg.getOrg().getId().intValue() ==
	 * org.getId() .intValue()) { m.put("checked", true); } } ml.add(m); }
	 * JSONArray json = JSONArray.fromObject(ml); model.addObject("orgStr",
	 * json.toString()); model.addObject("useraccountid", useraccountid);
	 * model.setViewName("/pages/admin/useraccount/orgs"); return Model(model);
	 * } catch (Exception e) { e.printStackTrace(); return Error(e); } }
	 */
	@RequestMapping("/selectorg/{useraccountid}")
	public ModelAndView selectorg(
			ModelAndView model,
			@PathVariable String useraccountid,
			@RequestParam(value = "thispage", required = false, defaultValue = "0") Integer thispage,
			@RequestParam(value = "pagesize", required = false, defaultValue = "10") Integer pagesize,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "tj", required = false) String name) {
		try {
			Long totalcount = 0l;
			if (orgid != null&&!orgid.equals("")) {
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
						totalcount = this.orgAndUserService.countOrg(sonids, name);
					}

				/*} else {// 其他系统
					totalcount = this.orgAndUserService.countSonOrg(orgid, name);
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
				model.addObject("orgList", orgList);
			} else {
				orgid=null;
				totalcount = this.orgAndUserService.countOrg(null,
						name);

				if ((thispage.intValue() * pagesize.intValue() >= totalcount
						.longValue()) && (totalcount.longValue() > 0L)) {
					thispage = Integer.valueOf(thispage.intValue() - 1);
				}
				List<Org> orgList = this.orgAndUserService.listOrgs(null,
					name, thispage, pagesize);
				model.addObject("orgList", orgList);
			}
			/*List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			List<ApplicationInfo> appList = this.commonDAO
					.findAll(ApplicationInfo.class,orders);
			model.addObject("appList", appList);*/
			model.addObject("parentid", orgid);
			model.addObject("useraccountid", useraccountid);
			model.setViewName("/pages/admin/useraccount/orgs");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/setorg")
	public void setOrg(
			@RequestParam(value = "orgid") String orgid,
			@RequestParam(value = "useraccountid", required = false) String useraccountid,
			HttpServletResponse response) {
		try {
			UserAccount mg = new UserAccount();
			Org o = new Org();
			if ((orgid != null) && (!orgid.equals(""))) {
				o = commonDAO.findOne(Org.class, Long.valueOf(orgid));

			} else {
				o = null;
			}
			mg = userAccountService.findOne(useraccountid);
			mg.setOrg(o);
			userAccountService.updateUser(mg);
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@RequestMapping("/setuserroles")
	public void setMenus(
			@RequestParam(value = "roleids") String roleids,
			@RequestParam(value = "useraccountid", required = false) String useraccountid,
			HttpServletResponse response) {
		try {
			UserAccount user = new UserAccount();
			Set<UserRole> urset = new HashSet<UserRole>();
			if ((roleids != null) && (!roleids.equals(""))) {
				String ids[] = roleids.split(",");
				for (String roleid : ids) {
					UserRole ur = new UserRole();
					ur = commonDAO.findOne(UserRole.class, roleid);
					urset.add(ur);
				}
			} else {
				urset = null;
			}
			user = userAccountService.findOne(useraccountid);
			user.setRoles(urset);
			userAccountService.updateUser(user);
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
	public void delete(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "userid", required = false) String userid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (userid != null) {
				String[] rid = userid.split(",");
				for (String str : rid) {
					UserAccount ua = new UserAccount();
					ua = userAccountService.findOne(str);
					ua.setOrg(null);
					ua.setHeadphoto(null);
					ua.setRoles(null);
					userAccountService.updateUser(ua);
					userAccountService.deleteUser(ua);
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

	@RequestMapping("/uploadHeadPic")
	public ModelAndView uploadPic(ModelAndView model,
			@RequestParam(value = "userId", required = true) String userId) {
		try {
			String url = getRootPath() + "/useraccount/saveUploadPic?userId="
					+ userId;
			model.addObject("url", url);
			model.setViewName("/pages/admin/upload/upload_pic");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	public FileEntity upload(MultipartFile file) throws IOException {
		String id = "";
		String path = ReadProperties.getInstance().getProperties("imagePath");
		String realfileName = file.getOriginalFilename();
		String fileName = String.valueOf(System.currentTimeMillis()) + ".jpg";
		File targetFile = new File(path);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		SaveFileFromInputStream(file.getInputStream(), path, fileName);
		String url = ReadProperties.getInstance().getProperties("imageUrl")
				+ "/" + fileName;
		id = String.valueOf(System.currentTimeMillis());
		fileService
				.insertFile(id, url, String.valueOf(file.getSize()),
						realfileName, file.getContentType(), path + "/"
								+ fileName, "1");
		FileEntity resultFile = fileService.findOne(id);
		return resultFile;
	}

	@RequestMapping("/saveUploadPic")
	public void saveUploadPic(
			HttpServletResponse response,
			@RequestParam(value = "userId", required = true) String userId,
			@RequestParam(value = "__source", required = false) MultipartFile __source,
			@RequestParam(value = "__avatar1", required = false) MultipartFile __avatar1,
			@RequestParam(value = "__avatar2", required = false) MultipartFile __avatar2,
			@RequestParam(value = "__avatar3", required = false) MultipartFile __avatar3)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			UserAccount ua = new UserAccount();
			ua = userAccountService.findOne(userId);
			FileEntity source = upload(__source);
			FileEntity avatar1 = upload(__avatar1);
			ua.setHeadpic(avatar1.getUrl());
			ua.setHeadphoto(avatar1);
			userAccountService.updateUser(ua);
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("success", true);
			result.put("sourceUrl", source.getUrl());
			result.put("avatarUrls", "");
			JSONObject jsonOject = JSONObject.fromObject(result);
			out.write(jsonOject.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("success", false);
			result.put("msg", "异常");
			JSONObject jsonOject = JSONObject.fromObject(result);
			out.write(jsonOject.toString());
			out.flush();
			out.close();
		}
	}

	@RequestMapping("/loadUsers")
	public ModelAndView loadUsers(ModelAndView model) {
		try {
			List<UserAccount> users = userAccountService.listAllUser();
			String userStrs = "";
			int i = 1;
			for (UserAccount userAccount : users) {
				userStrs += userAccount.getName() + " ["
						+ userAccount.getEmail() + "]";
				if (i < users.size()) {
					userStrs += ",";
				}
				i++;
			}
			model.addObject("users", userStrs);
			model.setViewName("/pages/admin/useraccount/load_users");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

}
