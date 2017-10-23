package com.app.service.impl;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.xml.namespace.QName;

import net.sf.json.JSONObject;

import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.Options;
import org.apache.axis2.rpc.client.RPCServiceClient;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;

import com.app.model.ApplicationInfo;
import com.app.model.SynLog;
import com.app.model.SynUser;
import com.app.service.ClientSynInfoService;
import com.app.service.SynService;
import com.app.util.SimpleCrypto;
import com.app.util.SynUtil;
import com.app.util.TimeUtil;
import com.app.util.UUIDUtil;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserRole;
import com.dm.platform.service.UserAccountService;

@Service("clientSynInfoService")
public class ClientSynInfoServiceImpl implements ClientSynInfoService {
	private static final int CREATEUSER = 11;
	private static final int UPDATEUSER = 12;
	private static final int DELETEUSER = 13;
	private static final int CREATEROLE = 21;
	private static final int UPDATEROLE = 22;
	private static final int DELETEROLE = 23;
	private static final int CREATEDEPT = 41;
	private static final int UPDATEDEPT = 42;
	private static final int DELETEDEPT = 43;

	/** 后加 **/
	private static final int CREATEDIVISION = 51;
	private static final int UPDATEDIVISION = 52;
	private static final int DELETEDIVISION = 53;

	private static final String CREATEDIVISIONNOONE = "1101";
	private static final String CREATEDIVISIONNOPARENT = "1102";
	private static final String CREATEDIVISIONHASNAME = "1103";
	private static final String CREATEDIVISIONHASCODE = "1104";
	private static final String UPDATEDIVISIONNOEXIT = "1201";
	private static final String UPDATEDIVISIONNOPARENT = "1202";
	private static final String UPDATEDIVISIONHASCODE = "1203";

	private static final String UPDATEDIVISIONHASNAME = "1204";
	private static final String DELETEDIVISIONNOEXIT = "1301";
	private static final String DELETEDIVISIONHASCHILD = "1302";
	private static final String DELETEDIVISIONHASDEPT = "1303";

	private static final String CREATEDEPTNOREGION = "104";
	private static final String UPDATEDEPTNOREGION = "304";

	private static final String CENTERNORETURNERROR = "1003";
	/****/

	private static final String SUCCESS = "000";
	private static final String CREATEDEPTNOONE = "101";
	private static final String CREATEDEPTNOPARENT = "102";
	private static final String CREATEDEPTHASNAME = "103";
	private static final String DELETEDEPTNOEXIT = "201";
	private static final String DELETEDEPTHASCHILD = "202";
	private static final String DELETEDEPTHASUSER = "203";
	private static final String DELETEDEPTHASROLE = "204";
	private static final String UPDATEDEPTNOEXIT = "301";
	private static final String UPDATEDEPTNOPARENT = "302";
	private static final String UPDATEDEPTHASNAME = "303";

	private static final String CREATEUSERNOONE = "401";
	private static final String CREATEUSERNOROLE = "402";
	private static final String CREATEUSERNODEPT = "403";
	private static final String DELETEUSERNOEXIT = "601";
	private static final String UPDATEUSERNOEXIT = "501";
	private static final String UPDATEUSERNOROLE = "502";
	private static final String UPDATEUSERNODEPT = "503";

	private static final String CREATEROLENOONE = "701";
	private static final String CREATEROLEHASNAME = "702";
	private static final String CREATEROLENODEPT = "703";
	private static final String DELETEROLENOEXIT = "901";
	private static final String UPDATEROLENOEXIT = "801";
	private static final String UPDATEROLEHASNAME = "802";
	private static final String UPDATEROLENODEPT = "803";
	private static final String CREATEROLENOAPP = "704";

	private static final String FORMATERROR = "1001";
	private static final String OTHERERROR = "1002";

	private static String webServiceURL = "";
	private static String qName = "";
	private static String hlwyh = "";
	private static String roleId = "";
	static {
		SynUtil syn = new SynUtil();
		try {
			webServiceURL = syn.getSynInfo("webServiceURL");
			qName = syn.getSynInfo("qName");
			hlwyh = syn.getSynInfo("hlwyh");
			roleId = syn.getSynInfo("roleId");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@Resource
	private CommonDAO commonDAO;

	@Resource
	private SynService synService;

	@Resource
	UserAccountService userAccountService;

	public String SynchronizedInfo(String jsonStr) {
		System.out.println(jsonStr);
		String result = "";
		JSONObject jsonObject = JSONObject.fromObject(jsonStr);
		String opType = jsonObject.getString("opType");
		String infoCode = jsonObject.getString("infoCode");
		int operateId = Integer.parseInt(opType);
		if (operateId == CREATEDEPT || operateId == UPDATEDEPT
				|| operateId == DELETEDEPT) {
			result = synDept(operateId, infoCode);
		} else if (operateId == CREATEUSER || operateId == UPDATEUSER
				|| operateId == DELETEUSER) {
			result = synUser(operateId, infoCode);

		} else if (operateId == CREATEROLE || operateId == UPDATEROLE
				|| operateId == DELETEROLE) {
			// result = synRole(operateId, infoCode);
		}
		return result;
	}

	public String synUser(int operateId, String userCode) {
		try {
			System.out.println(userCode);
			if (operateId == CREATEUSER || operateId == UPDATEUSER
					|| operateId == DELETEUSER) {
				String hql = "";
				String apphql = "from ApplicationInfo t where t.status='1' order by seq";
				List<ApplicationInfo> appList = this.commonDAO.find(apphql);
				if (operateId == DELETEUSER) {
					hql = "from UserAccount user where user.code='" + userCode
							+ "'";
					List<UserAccount> userList = this.commonDAO.find(hql);
					if (userList.size() == 0) {
						return DELETEUSERNOEXIT;
					}
					UserAccount useraccount = this.userAccountService
							.findOne(userCode);
					useraccount.setOrg(null);
					useraccount.setHeadphoto(null);
					useraccount.setRoles(null);
					this.commonDAO.update(useraccount);
					for (int i = 0; i < appList.size(); i++) {
						ApplicationInfo applicationInfo = appList.get(i);
						String appId = applicationInfo.getId();
						String result = this.synService.synStart(appId,
								useraccount.getCode(), "13");
						String today = TimeUtil
								.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
						if (result != null && result.equals("000")) {
							result = "同步成功";
							String synSql = "from SynUser u where u.appId='"
									+ appId + "' and u.userId= '"
									+ useraccount.getCode() + "'";
							List<SynUser> synUserList = this.commonDAO
									.find(synSql);
							if (synUserList != null && synUserList.size() > 0) {
								for (int j = 0; j < synUserList.size(); j++) {
									this.commonDAO.delete(synUserList.get(j));
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
							synLog.setSynUserId("admin");
							synLog.setSynUserName("门户");
							this.commonDAO.save(synLog);
						} else {
							// 添加记录日志的操作
							SynLog synLog = new SynLog();
							synLog.setId(UUIDUtil.getUUID());
							synLog.setAppId(appId);
							synLog.setAppName(applicationInfo.getAppName());
							synLog.setSynTime(today);
							synLog.setSynResult("用户(" + useraccount.getName()
									+ ")删除操作：" + result);
							synLog.setSynUserId("admin");
							synLog.setSynUserName("门户");
							this.commonDAO.save(synLog);
						}
					}
					this.commonDAO.delete(useraccount);
					System.out.println("业务系统实现删除本地用户信息");
					return SUCCESS;
					// 业务系统实现删除本地用户信息
				} else {
					String userInfo = this.getUserInfo(userCode);
					System.out.println(userInfo);
					JSONObject jsonObject = JSONObject.fromObject(userInfo);
					Object id = jsonObject.get("code");
					Object orgCode = jsonObject.get("orgId");
					Object loginname = jsonObject.get("loginname");
					Object name = jsonObject.get("name");
					Object synPassword = jsonObject.get("synPassword");
					Object seq = jsonObject.get("seq");
					Object mobile = jsonObject.get("mobile");
					Object email = jsonObject.get("email");
					if (operateId == CREATEUSER) {
						// 业务系统根据获取的用户信息，将用户信息存入本地数据库
						hql = "from UserAccount user where user.code='"
								+ userCode + "'";
						List<UserAccount> userList = this.commonDAO.find(hql);
						if (userList.size() > 0) {
							return CREATEUSERNOONE;
						}
						Org org = this.commonDAO.findOne(Org.class,
								Long.parseLong(hlwyh));
						UserAccount user = new UserAccount();
						user.setCode(id.toString());
						if (loginname != null)
							user.setLoginname(loginname.toString());
						if (name != null)
							user.setName(name.toString());
						if (org == null) {
							user.setOrg(org);
						} else {
							user.setOrg(org);
						}
						if (synPassword != null) {
							try {
								String password = SimpleCrypto.decrypt(
										"zcpt@123456", synPassword.toString());
								ShaPasswordEncoder sha = new ShaPasswordEncoder();
								sha.setEncodeHashAsBase64(false);
								user.setPassword(sha.encodePassword(password,
										null));
								user.setSynPassword(synPassword.toString());
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
						if (mobile != null)
							user.setMobile(mobile.toString());
						if (email != null)
							user.setEmail(email.toString());
						user.setEnabled(true);
						user.setLocked(false);
						user.setAccountExpired(true);
						user.setPasswordExpired(true);
						UserRole userRole = this.commonDAO.findOne(
								UserRole.class, roleId);
						Set<UserRole> roleSet = new HashSet<UserRole>();
						roleSet.add(userRole);
						user.setRoles(roleSet);
						this.commonDAO.save(user);
						for (int i = 0; i < appList.size(); i++) {
							ApplicationInfo applicationInfo = (ApplicationInfo) appList
									.get(i);
							String appId = applicationInfo.getId();
							String result = this.synService.synStart(appId,
									user.getCode(), "11");
							String today = TimeUtil
									.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
							if (result != null && result.equals("000")) {
								result = "同步成功";
								SynUser synUser = new SynUser();
								String uuid = UUIDUtil.getUUID();
								synUser.setAppId(appId);
								synUser.setId(uuid);
								synUser.setUserId(user.getCode());
								synUser.setSynTime(today);
								this.commonDAO.save(synUser);
								/*
								 * 添加记录日志的操作
								 */
								SynLog synLog = new SynLog();
								synLog.setId(UUIDUtil.getUUID());
								synLog.setAppId(appId);
								synLog.setAppName(applicationInfo.getAppName());
								synLog.setSynTime(today);
								synLog.setSynResult("用户(" + user.getName()
										+ ")新增操作：" + result);
								synLog.setSynUserId("admin");
								synLog.setSynUserName("门户");
								this.commonDAO.save(synLog);
							} else {
								SynLog synLog = new SynLog();
								synLog.setId(UUIDUtil.getUUID());
								synLog.setAppId(appId);
								synLog.setAppName(applicationInfo.getAppName());
								synLog.setSynTime(today);
								synLog.setSynResult("用户(" + user.getName()
										+ ")新增操作：" + result);
								synLog.setSynUserId("admin");
								synLog.setSynUserName("门户");
								this.commonDAO.save(synLog);
							}
						}
						System.out.println("业务系统根据获取的用户信息，将用户信息存入本地数据库");
						return SUCCESS;
					} else {
						hql = "from UserAccount user where user.code='"
								+ userCode + "'";
						List<UserAccount> userList = this.commonDAO.find(hql);
						if (userList.size() == 0) {
							return UPDATEUSERNOEXIT;
						}
						UserAccount user = (UserAccount) userList.get(0);
						if (loginname != null)
							user.setLoginname(loginname.toString());
						if (name != null)
							user.setName(name.toString());
						if (synPassword != null) {
							try {
								String password = SimpleCrypto.decrypt(
										"zcpt@123456", synPassword.toString());
								ShaPasswordEncoder sha = new ShaPasswordEncoder();
								sha.setEncodeHashAsBase64(false);
								user.setPassword(sha.encodePassword(password,
										null));
								user.setSynPassword(synPassword.toString());
							} catch (Exception e) {
								e.printStackTrace();
								return OTHERERROR;
							}
						}
						if (mobile != null)
							user.setMobile(mobile.toString());
						if (email != null)
							user.setEmail(email.toString());
						this.commonDAO.update(user);
						for (int i = 0; i < appList.size(); i++) {
							ApplicationInfo applicationInfo = (ApplicationInfo) appList
									.get(i);
							String appId = applicationInfo.getId();
							String result = this.synService.synStart(appId,
									user.getCode(), "12");
							String today = TimeUtil
									.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
							if (result != null && result.equals("000")) {
								result = "同步成功";
								String synSql = "from SynUser u where u.appId='"
										+ appId
										+ "' and u.userId= '"
										+ user.getCode() + "'";
								List<SynUser> synUserList = this.commonDAO
										.find(synSql);
								if (synUserList != null
										&& synUserList.size() > 0) {
									for (int j = 0; j < synUserList.size(); j++) {
										synUserList.get(j).setSynTime(today);
										this.commonDAO.update(synUserList
												.get(j));
									}
								}
								SynLog synLog = new SynLog();
								synLog.setId(UUIDUtil.getUUID());
								synLog.setAppId(appId);
								synLog.setAppName(applicationInfo.getAppName());
								synLog.setSynTime(today);
								synLog.setSynResult("用户(" + user.getName()
										+ ")更新操作：" + result);
								synLog.setSynUserId("admin");
								synLog.setSynUserName("门户");
								this.commonDAO.save(synLog);
							} else {
								SynLog synLog = new SynLog();
								synLog.setId(UUIDUtil.getUUID());
								synLog.setAppId(appId);
								synLog.setAppName(applicationInfo.getAppName());
								synLog.setSynTime(today);
								synLog.setSynResult("用户(" + user.getName()
										+ ")更新操作：" + result);
								synLog.setSynUserId("admin");
								synLog.setSynUserName("门户");
								this.commonDAO.save(synLog);
							}
						}
						System.out.println("业务系统根据获取的用户信息，将用户信息更新至本地数据库");
					}
				}
			}
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return OTHERERROR;
		}
	}

	public String synDept(int operateId, String orgCode) {

		try {
			if (operateId == CREATEDEPT || operateId == UPDATEDEPT
					|| operateId == DELETEDEPT) {
				String hql = "";

				if (operateId == DELETEDEPT) {
					hql = "from Org org where org.id=" + orgCode + "";
					List<Org> orgList = this.commonDAO.find(hql);
					if (orgList.size() == 0) {
						return DELETEDEPTNOEXIT;
					}
					Org org = (Org) orgList.get(0);
					if (org.getChildren() != null
							&& org.getChildren().size() != 0) {
						return DELETEDEPTHASCHILD;
					}

					if (org.getUser() != null && org.getUser().size() != 0) {
						return DELETEDEPTHASUSER;
					}
					String deleteSql = " delete Org o where o.id=" + orgCode
							+ "";
					this.commonDAO.execute(deleteSql);
					System.out.println("业务系统实现删除本地组织信息");
					return SUCCESS;
				} else {
					String deptInfo = this.getDeptInfo(orgCode);
					JSONObject jsonObject = JSONObject.fromObject(deptInfo);
					Object id = jsonObject.get("id");
					Object name = jsonObject.get("name");
					Object code = jsonObject.get("code");
					Object seq = jsonObject.get("seq");
					Object parentId = jsonObject.get("parentId");
					if (operateId == CREATEDEPT) {
						System.out.println(deptInfo);
						// 业务系统根据获取的组织信息，将组织信息存入本地数据库
						hql = "from Org org where org.id=" + orgCode + "";
						List<Org> deptList = this.commonDAO.find(hql);
						if (deptList.size() > 0) {
							return CREATEDEPTNOONE;
						}
						List<Org> deptParentList = null;
						if (parentId != null) {
							if (!parentId.toString().equalsIgnoreCase("root")) {
								hql = "from Org org where org.id=" + parentId
										+ "";
								deptParentList = this.commonDAO.find(hql);
								if (deptParentList.size() == 0) {
									return CREATEDEPTNOPARENT;
								}
							}
						}
						Org parent = null;
						if (parentId.toString().equalsIgnoreCase("root")) {
							parent = new Org();
							parent.setId(null);
						} else {
							parent = (Org) deptParentList.get(0);
						}
						Org org = new Org();
						org.setId(Long.valueOf(System.currentTimeMillis()));
						if (name != null)
							org.setName(name.toString());
						org.setParent(parent);
						if (code != null)
							org.setCode(code.toString());
						if (seq != null)
							org.setSeq((Long) seq);
						this.commonDAO.save(org);
						System.out.println("业务系统根据获取的组织信息，将组织信息存入本地数据库");
						return SUCCESS;
					} else if (operateId == UPDATEDEPT) {
						hql = "from Org org where org.id=" + orgCode + "";
						List<Org> deptList = this.commonDAO.find(hql);
						if (deptList.size() == 0) {
							return UPDATEUSERNOEXIT;
						}
						List deptParentList = null;
						if (parentId != null) {
							if (!parentId.toString().equalsIgnoreCase("root")) {
								hql = "from Org org where org.id=" + parentId
										+ "";
								deptParentList = this.commonDAO.find(hql);
								if (deptParentList.size() == 0) {
									return UPDATEDEPTNOPARENT;
								}
							}
						}
						Org parent = (Org) deptParentList.get(0);
						Org org = (Org) deptList.get(0);
						if (name != null)
							org.setName(name.toString());
						org.setParent(parent);
						if (code != null)
							org.setCode(code.toString());
						if (seq != null)
							org.setSeq((Long) seq);
						System.out.println("业务系统根据获取的组织信息，将组织信息更新到本地数据库");
						return SUCCESS;
					}
				}

			}
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return OTHERERROR;
	}

	public static void main(String[] args) {
		try {

			String jsonStr = "";
			JSONObject jsObject = new JSONObject();
			jsObject.put("opType", "11");
			JSONObject jsonObject = JSONObject.fromObject(jsObject.toString());
			String opType = jsonObject.getString("opType");
			System.out.println(opType);
			Object infoCode = jsonObject.getString("infoCode");
			System.out.println(infoCode);
		} catch (Exception e) {
			System.out.println("jsonStr 解析错误，请检查参数");
		}
	}

	// public String synRole(int operateId, String roleInfo) {
	//
	// try {
	// Map map = TestDom4j.getRoleInfoXmlOut(roleInfo);
	// String roleCode = (String) map.get("roleCode");
	// String roleName = (String) map.get("roleName");
	// if (operateId == CREATEROLE || operateId == UPDATEROLE
	// || operateId == DELETEROLE) {
	// String hql = "";
	// if (operateId == DELETEROLE) {
	// hql = "from Role role where role.roleCode='" + roleCode
	// + "'";
	// List roleList = this.find(hql);
	// if (roleList == null || roleList.size() == 0) {
	// return DELETEROLENOEXIT;
	// }
	// for (int i = 0; i < roleList.size(); i++) {
	// Role delrole = new Role();
	// delrole = (Role) roleList.get(i);
	// Set<User> users = delrole.getUsers();
	// if (users != null && users.size() > 0) {
	// for (User u : users) {
	// u.getRoles().remove(delrole);
	// }
	// }
	// }
	// this.batchRemove(roleList);
	// System.out.println("业务系统实现删除本地角色信息");
	// return SUCCESS;
	// // 业务系统实现删除本地角色信息
	// } else {
	// if (operateId == CREATEROLE) {
	// hql = "from Role role where role.roleCode='" + roleCode
	// + "'";
	// List roleList = this.find(hql);
	// if (roleList.size() > 0) {
	// return CREATEROLENOONE;
	// }
	// hql = "from Role role where role.name='" + roleName
	// + "' and role.appId.id='" + appId + "'";
	// List orgList = this.find(hql);
	// if (orgList.size() > 0) {
	// return CREATEROLEHASNAME;
	// }
	// hql = "from  ApplicationInfo a where a.id='" + appId
	// + "' order by org.id";
	// List appList = this.find(hql);
	// ApplicationInfo app;
	// if (appList == null || appList.size() == 0) {
	// return CREATEROLENODEPT;
	// } else {
	// app = (ApplicationInfo) appList.get(0);
	// Org org = app.getOrg();
	// if (org == null) {
	// return CREATEROLENODEPT;
	// }
	// }
	// Role role = new Role();
	// role.setRoleCode(roleCode);
	// role.setName(roleName);
	// TimeUtil util = new TimeUtil();
	// String updateTime = util
	// .getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
	// role.setUpdateTime(updateTime);
	// role.setAppId(app);
	// Org org = app.getOrg();
	// role.setOrg(org);
	// this.save(role);
	// System.out.println("业务系统根据获取的角色信息，将角色信息存入本地数据库");
	// // 业务系统根据获取的角色信息，将角色信息存入本地数据库
	// } else if (operateId == UPDATEROLE) {
	// hql = "from Role role where role.roleCode='" + roleCode
	// + "'";
	// List roleList = this.find(hql);
	// if (roleList.size() == 0) {
	// return UPDATEROLENOEXIT;
	// }
	// hql = "from Role role where role.name='" + roleName
	// + "' and role.appId.id='" + appId + "'";
	// List orgList = this.find(hql);
	// if (orgList.size() > 1) {
	// return UPDATEROLEHASNAME;
	// }
	// hql = "from  ApplicationInfo a where a.id='" + appId
	// + "' order by org.id";
	// List appList = this.find(hql);
	// ApplicationInfo app;
	// if (appList == null || appList.size() == 0) {
	// return UPDATEROLENODEPT;
	// } else {
	// app = (ApplicationInfo) appList.get(0);
	// Org org = app.getOrg();
	// if (org == null) {
	// return UPDATEROLENODEPT;
	// }
	// }
	// Role role = (Role) roleList.get(0);
	// role.setName(roleName);
	// this.update(role);
	// TimeUtil util = new TimeUtil();
	// String updateTime = util
	// .getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
	// role.setUpdateTime(updateTime);
	// role.setAppId(app);
	// Org org = app.getOrg();
	// role.setOrg(org);
	// this.update(role);
	// // 业务系统根据获取的角色信息，将角色信息更新到本地数据库\
	// System.out.println("业务系统根据获取的角色信息，将角色信息更新到本地数据库");
	// }
	// }
	//
	// }
	// return SUCCESS;
	// } catch (Exception e) {
	// e.printStackTrace();
	//
	// }
	// return OTHERERROR;
	// }

	public void setWebServiceURL(String webServiceURL) {
		this.webServiceURL = webServiceURL;
	}

	public void setqName(String qName) {
		this.qName = qName;
	}

	/**
	 * 从支撑平台获取用户信息，返回值为json格式的字符串
	 */
	public String getUserInfo(String userId) {
		RPCServiceClient serviceClient;
		try {
			serviceClient = new RPCServiceClient();
			Options options = serviceClient.getOptions();
			options.setProperty(
					org.apache.axis2.transport.http.HTTPConstants.CONNECTION_TIMEOUT,
					new Integer(48000000));
			EndpointReference targetEPR = new EndpointReference(webServiceURL);
			options.setTo(targetEPR);
			QName opGetAllLegalInfor = new QName(qName, "getUserInfo");
			Object[] opGetAllLegalInforArgs = new Object[] { userId };
			Class[] returnTypes = new Class[] { String.class };
			Object[] response = serviceClient.invokeBlocking(
					opGetAllLegalInfor, opGetAllLegalInforArgs, returnTypes);
			String userInfo = (String) response[0];
			serviceClient.cleanupTransport();
			return userInfo;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return OTHERERROR;
	}

	/**
	 * 从支撑平台获取组织信息，返回值为json格式的字符串
	 */
	public String getDeptInfo(String deptId) {
		try {
			RPCServiceClient serviceClient;
			serviceClient = new RPCServiceClient();
			Options options = serviceClient.getOptions();
			options.setProperty(
					org.apache.axis2.transport.http.HTTPConstants.CONNECTION_TIMEOUT,
					new Integer(48000000));
			EndpointReference targetEPR = new EndpointReference(webServiceURL);// webServiceURL的值是如何获得的ss
			System.out.println(webServiceURL);
			options.setTo(targetEPR);

			QName opGetAllLegalInfor = new QName(qName, "getOrgInfo");
			Object[] opGetAllLegalInforArgs = new Object[] { deptId };
			Class[] returnTypes = new Class[] { String.class };
			Object[] response = serviceClient.invokeBlocking(
					opGetAllLegalInfor, opGetAllLegalInforArgs, returnTypes);
			String deptInfo = (String) response[0];
			serviceClient.cleanupTransport();
			return deptInfo;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return OTHERERROR;
	}

	/**
	 * 从支撑平台获取角色信息，返回值为json格式的字符串
	 */
	public String getRoleInfo(String roleId) {
		try {
			RPCServiceClient serviceClient;
			serviceClient = new RPCServiceClient();
			Options options = serviceClient.getOptions();
			options.setProperty(
					org.apache.axis2.transport.http.HTTPConstants.CONNECTION_TIMEOUT,
					new Integer(48000000));
			EndpointReference targetEPR = new EndpointReference(webServiceURL);
			options.setTo(targetEPR);
			QName opGetAllLegalInfor = new QName(qName, "getRoleInfo");
			Object[] opGetAllLegalInforArgs = new Object[] { roleId };
			Class[] returnTypes = new Class[] { String.class };
			Object[] response = serviceClient.invokeBlocking(
					opGetAllLegalInfor, opGetAllLegalInforArgs, returnTypes);
			String roleInfo = (String) response[0];

			return roleInfo;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return OTHERERROR;
	}
}