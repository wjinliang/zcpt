package com.app.service.impl;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.xml.namespace.QName;
import javax.xml.rpc.ParameterMode;
import javax.xml.rpc.ServiceException;

import net.sf.json.JSONObject;

import org.apache.axis.client.Call;
import org.apache.axis.encoding.XMLType;
import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.Options;
import org.apache.axis2.rpc.client.RPCServiceClient;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.app.model.ApplicationInfo;
import com.app.model.SynLog;
import com.app.service.SynService;
import com.app.util.SynUtil;
import com.dm.ais.dao.CommDAO;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;

@Service
public class SynServiceImpl implements SynService {
	@Resource
	private CommonDAO commonDAO;
	@Resource
	private CommDAO commDAO;
	private String webServiceURL;
	private String qName;
	@Override
	@Transactional
	public Long countAppAccount(UserAccount currentUserAccount) {
		currentUserAccount = commonDAO.findOne(UserAccount.class,
				currentUserAccount.getCode());// 20160603
		Division division = currentUserAccount.getOrg().getDivision();
		String hql = "select count(*) from ApplicationInfo app where app.opLevel >="
				+ division.getLevel();
		Long count = this.commonDAO.count(hql);
		return count;
	}

	@Override
	@Transactional
	public List<ApplicationInfo> listAppAccount(UserAccount currentUserAccount,
			int thispage, int pagesize) {
		currentUserAccount = commonDAO.findOne(UserAccount.class,
				currentUserAccount.getCode());// 20160603
		Division division = currentUserAccount.getOrg().getDivision();
		String hql = " from ApplicationInfo app where app.opLevel >="
				+ division.getLevel();
		List<Order> orders = new ArrayList<Order>();
		orders.add(new Order(Direction.ASC, "seq"));
		List<ApplicationInfo> appList = this.commonDAO.findByPage(hql,
				thispage, pagesize, orders);
		return appList;
	}

	@Override
	public void deleteApp(ApplicationInfo findOne) {
		this.commonDAO.delete(findOne);
	}

	public String synStart(String appId, String infoCode, String opType) {
		String hql = "";
		ApplicationInfo applicationInfo = this.commonDAO.findOne(
				ApplicationInfo.class, appId);
		ServletRequestAttributes srAttrs = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = srAttrs.getRequest();
		//HttpServletRequest request =  // RequestUtils.getRequest();
		if (applicationInfo != null) {
			String synType = applicationInfo.getSynType();
			if (synType.equals("axis1")) {
				return synAxis1(request,applicationInfo, infoCode, opType);
			} else if (synType.equals("axis2")) {
				return synAxis2(request,applicationInfo, infoCode, opType);
			} else if (synType.equals("http")) {
				return synHttp(request,applicationInfo, infoCode, opType);
			}
			return "此系统同步借口尚未实现！";
		} else {
			return "此系统尚未注册！";
		}
	}

	private String synHttp(HttpServletRequest request,ApplicationInfo applicationInfo, String infoCode,
			String opType) {
		String notReadNum;
		// 1.构造HttpClient的实例
		HttpClient httpClient = new HttpClient();
		httpClient.getParams().setContentCharset("GBK");

		//String url = applicationInfo.getSynPath();//20170208 修改根据IP区分移动联通 -
		String url = getSynPath(request,applicationInfo);//20170208 修改根据IP区分移动联通 +

		// 2.构造PostMethod的实例
		PostMethod postMethod = new PostMethod(url);

		// 3.把参数值放入到PostMethod对象中
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("opType", opType);
		jsonObject.put("infoCode", infoCode);
		String jsonStr = jsonObject.toString();
		postMethod.addParameter("jsonStr", jsonStr);

		try {
			// 4.执行postMethod,调用http接口
			httpClient.executeMethod(postMethod);// 200
			// 5.读取内容
			notReadNum = postMethod.getResponseBodyAsString().trim();
			if (!notReadNum.equalsIgnoreCase("000")) {
				notReadNum = swtichError(notReadNum);
			}
		} catch (HttpException e) {
			e.printStackTrace();
			return "远程服务调用异常";
		} catch (IOException e) {
			e.printStackTrace();
			return "远程服务调用异常";
		} finally {
			// 7.释放连接
			postMethod.releaseConnection();
		}
		return notReadNum;

	}

	private String synAxis2(HttpServletRequest request,ApplicationInfo applicationInfo, String infoCode,
			String opType) {
		//webServiceURL = applicationInfo.getSynPath().trim(); //20170208 修改根据IP区分移动联通 -
		webServiceURL = getSynPath(request,applicationInfo);//20170208 修改根据IP区分移动联通 +
		qName = applicationInfo.getPackageName().trim();
		String notReadNum;
		try {
			RPCServiceClient serviceClient;
			serviceClient = new RPCServiceClient();
			Options options = serviceClient.getOptions();
			options.setProperty(
					org.apache.axis2.transport.http.HTTPConstants.CONNECTION_TIMEOUT,
					new Integer(480000000));
			EndpointReference targetEPR = new EndpointReference(webServiceURL);
			options.setTo(targetEPR);
			QName opGetAllLegalInfor = new QName(qName, "SynchronizedInfo");
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("opType", opType);
			jsonObject.put("infoCode", infoCode);
			String jsonStr = jsonObject.toString();
			Object[] opGetAllLegalInforArgs = new Object[] { jsonStr };
			Class[] returnTypes = new Class[] { String.class };
			Object[] response = serviceClient.invokeBlocking(
					opGetAllLegalInfor, opGetAllLegalInforArgs, returnTypes);
			notReadNum = (String) response[0];
			serviceClient.cleanupTransport();
			if (!notReadNum.equalsIgnoreCase("000")) {
				notReadNum = swtichError(notReadNum);
			}
		} catch (RemoteException e) {
			e.printStackTrace();
			notReadNum = "远程服务调用异常";
		}
		return notReadNum;
	}

	private String synAxis1(HttpServletRequest request,ApplicationInfo applicationInfo, String infoCode,
			String opType) {
		//webServiceURL = applicationInfo.getSynPath().trim();//20170208 修改根据IP区分移动联通 -
		webServiceURL = getSynPath(request,applicationInfo);//20170208 修改根据IP区分移动联通 +
		String notReadNum;
		// 创建Service实例
		org.apache.axis.client.Service service = new org.apache.axis.client.Service();
		// 通过Service实例创建Call实例
		Call call;
		try {
			call = (Call) service.createCall();
			// 将WebService的服务路径加入到Call实例中，并为Call设置服务的位置

			URL url = new URL(webServiceURL);
			call.setTargetEndpointAddress(url);
			// 调用WebService方法
			if (applicationInfo.getPackageName() != null
					&& !applicationInfo.getPackageName().equals("")) {
				call.setOperationName(new QName(applicationInfo
						.getPackageName(), "SynchronizedInfo"));
				if (applicationInfo.getParamName() != null
						&& !applicationInfo.getParamName().equals("")) {
					call.addParameter(
							new QName(applicationInfo.getPackageName(),
									applicationInfo.getParamName()),
							XMLType.XSD_STRING, ParameterMode.IN);
				}
			} else {
				call.setOperationName("SynchronizedInfo");
				if (applicationInfo.getParamName() != null
						&& !applicationInfo.getParamName().equals("")) {
					call.addParameter(applicationInfo.getParamName(),
							XMLType.XSD_STRING, ParameterMode.IN);
				}
			}
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("opType", opType);
			jsonObject.put("infoCode", infoCode);
			String jsonStr = jsonObject.toString();
			// 调用WebService传入参数
			notReadNum = (String) call.invoke(new Object[] { jsonStr });
			if (!notReadNum.equalsIgnoreCase("000")) {
				notReadNum = swtichError(notReadNum);
			}
		} catch (ServiceException e) {
			e.printStackTrace();
			notReadNum = "服务调用有问题";
		} catch (MalformedURLException e) {
			e.printStackTrace();
			notReadNum = "服务链接格式不对";
		} catch (RemoteException e) {
			e.printStackTrace();
			notReadNum = "远程服务调用异常";
		}
		return notReadNum;
	}

	/*
	 * public static void main(String[] args) throws AxisFault { String url =
	 * "http://localhost:8080/clientSynInfoService/synchronizedInfo"; String
	 * notReadNum; // 1.构造HttpClient的实例 HttpClient httpClient = new
	 * HttpClient(); httpClient.getParams().setContentCharset("UTF-8"); //
	 * 2.构造PostMethod的实例 PostMethod postMethod = new PostMethod(url);
	 * 
	 * // 3.把参数值放入到PostMethod对象中 JSONObject jsonObject = new JSONObject();
	 * jsonObject.put("opType", "11"); jsonObject.put("infoCode", "1"); String
	 * jsonStr = jsonObject.toString(); postMethod.addParameter("jsonStr",
	 * jsonStr); try { // 4.执行postMethod,调用http接口
	 * httpClient.executeMethod(postMethod);// 200 // 5.读取内容 notReadNum =
	 * postMethod.getResponseBodyAsString().trim();
	 * System.out.println(notReadNum); } catch (HttpException e) {
	 * e.printStackTrace(); } catch (IOException e) { e.printStackTrace(); }
	 * finally { // 7.释放连接 postMethod.releaseConnection(); } }
	 */

	// public static void main(String[] args) {
	// String webServiceURL = "http://localhost:8080/ws/countries.wsdl";
	// String qName="http://www.dexcoder.com/ws";
	// String notReadNum;
	// // 1.构造HttpClient的实例
	// HttpClient httpClient = new HttpClient();
	// httpClient.getParams().setContentCharset("UTF-8");
	// // 2.构造PostMethod的实例
	// PostMethod postMethod = new PostMethod(url);
	//
	// // 3.把参数值放入到PostMethod对象中
	// JSONObject jsonObject =new JSONObject();
	// jsonObject.put("opType", "11");
	// jsonObject.put("infoCode", "22");
	// String jsonStr = jsonObject.toString();
	// postMethod.addParameter("jsonStr", jsonStr);
	// try {
	// // 4.执行postMethod,调用http接口
	// httpClient.executeMethod(postMethod);// 200
	// // 5.读取内容
	// notReadNum = postMethod.getResponseBodyAsString().trim();
	// System.out.println(notReadNum);
	// } catch (HttpException e) {
	// e.printStackTrace();
	// } catch (IOException e) {
	// e.printStackTrace();
	// } finally {
	// // 7.释放连接
	// postMethod.releaseConnection();
	// }
	// }

	/*
	 * public static void main(String[] args) { String webServiceURL =
	 * "http://59.108.117.18:9080/FKYJXT/synInfoService.asmx"; String
	 * qName="http://tempuri.org/"; String notReadNum; try { RPCServiceClient
	 * serviceClient; serviceClient = new RPCServiceClient(); Options options =
	 * serviceClient.getOptions(); options.setProperty(
	 * org.apache.axis2.transport.http.HTTPConstants.CONNECTION_TIMEOUT, new
	 * Integer(48000000)); EndpointReference targetEPR = new
	 * EndpointReference(webServiceURL); options.setTo(targetEPR); QName
	 * opGetAllLegalInfor = new QName(qName, "SynchronizedInfo"); JSONObject
	 * jsonObject =new JSONObject(); jsonObject.put("opType", "41");
	 * jsonObject.put("infoCode", "1459388488382"); String jsonStr =
	 * jsonObject.toString(); System.out.println(jsonStr); Object[]
	 * opGetAllLegalInforArgs = new Object[]{jsonStr};// {"feng"}; Class[]
	 * returnTypes = new Class[] { String.class }; Object[] response =
	 * serviceClient.invokeBlocking( opGetAllLegalInfor, opGetAllLegalInforArgs,
	 * returnTypes); notReadNum = (String) response[0];
	 * System.out.println(notReadNum); serviceClient.cleanupTransport(); } catch
	 * (RemoteException e) { e.printStackTrace(); notReadNum = "远程服务调用异常"; } }
	 */

	public static void main(String[] args) {
		String webServiceURL = "http://59.108.117.18:9080/FKYJXT/synInfoService.asmx";
		String notReadNum; // 创建Service实例
		org.apache.axis.client.Service service = new org.apache.axis.client.Service(); // 通过Service实例创建Call实例
		Call call;
		try {
			call = (Call) service.createCall(); // 将WebService的服务路径加入到Call实例中，并为Call设置服务的位置

			URL url = new URL(webServiceURL);
			call.setTargetEndpointAddress(url); // 调用WebService方法
			call.setOperationName(new QName("http://tempuri.org/",
					"SynchronizedInfo"));
			// call.setOperationName("SynchronizedUserInfo"); //
			// 调用WebService传入参数
			// call.addParameter("jsonstring", XMLType.XSD_STRING,
			// ParameterMode.IN);
			call.addParameter(new QName("http://tempuri.org/", "jsonstring"),
					XMLType.XSD_STRING, ParameterMode.IN);
			call.setReturnType(XMLType.XSD_STRING);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI("http://tempuri.org/SynchronizedInfo");
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("opType", "41");
			jsonObject.put("infoCode", "1459388488382");
			String jsonStr = jsonObject.toString();
			notReadNum = (String) call.invoke(new Object[] { jsonStr });
			System.out.println("=================" + notReadNum);
		} catch (ServiceException e) {
			e.printStackTrace();
			notReadNum = "服务调用有问题";
		} catch (MalformedURLException e) {
			e.printStackTrace();
			notReadNum = "服务链接格式不对";
		} catch (RemoteException e) {
			e.printStackTrace();
			notReadNum = "远程服务调用异常";
		}
	}

	private String swtichError(String notReadNum) {
		String errorString = "其他异常";
		if (notReadNum.equalsIgnoreCase("111")) {
			errorString = "同步失败";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("101")) {
			errorString = "增加组织唯一标识重复";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("102")) {
			errorString = "增加组织的上级节点不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("103")) {
			errorString = "增加组织时同级组织名称重复";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("201")) {
			errorString = "组织唯一标识对应的组织不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("202")) {
			errorString = "删除的组织下存在子组织";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("203")) {
			errorString = "删除的组织下存在用户";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("204")) {
			errorString = "删除的组织下存在角色";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("301")) {
			errorString = "组织唯一标识对应的组织不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("301------------")) {
			errorString = "组织组织不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("302")) {
			errorString = "修改组织时上级节点不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("303")) {
			errorString = "修改组织时同级组织名称重复";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("401")) {
			errorString = "增加用户唯一标识重复";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("402")) {
			errorString = "增加用户的角色标识编号不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("403")) {
			errorString = "增加用户的组织标识编号不存在";
			return errorString;
		}

		if (notReadNum.equalsIgnoreCase("501")) {
			errorString = "用户唯一标识对应的用户不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("502")) {
			errorString = "修改用户的角色标识编号不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("503")) {
			errorString = "修改用户的组织标识编号不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("601")) {
			errorString = "用户唯一标识对应的用户不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("701")) {
			errorString = "增加角色唯一标识重复";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("702")) {
			errorString = "增加角色名字重复";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("703")) {
			errorString = "增加角色的组织标识编号不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("801")) {
			errorString = "唯一标识对应的角色不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("802")) {
			errorString = "修改角色名字重复";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("803")) {
			errorString = "修改角色的组织标识编号不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("901")) {
			errorString = "唯一标识对应的角色不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1001")) {
			errorString = "格式错误";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1002")) {
			errorString = "其他错误";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1003")) {
			errorString = "调用中心没有找到返回";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1101")) {
			errorString = "增加区划唯一标识存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1102")) {
			errorString = "增加区划没有对应的父节点";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1103")) {
			errorString = "增加区划名字重复";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1104")) {
			errorString = "增加区划区划编码存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1201")) {
			errorString = "更新区划不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1202")) {
			errorString = "更新区划父节点不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1203")) {
			errorString = "更新区划编码已存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1204")) {
			errorString = "更新区划名字已存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1301")) {
			errorString = "删除区划不存在";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1302")) {
			errorString = "删除区划有子节点";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("1303")) {
			errorString = "删除的区存在组织";
			return errorString;
		}

		if (notReadNum.equalsIgnoreCase("104")) {
			errorString = "新增组织没有区划";
			return errorString;
		}
		if (notReadNum.equalsIgnoreCase("304")) {
			errorString = "更新组织没有区划";
			return errorString;
		}

		return errorString;
	}

	@Override
	public Long countSynLogAccount(String mhss) {
		String hql = "select count(*) from SynLog syn  ";
		if (mhss != null && !mhss.equals("")) {
			hql += " where syn.appName like '%" + mhss
					+ "%' or syn.synResult like '%" + mhss
					+ "%' or syn.synTime like '%" + mhss
					+ "%' or syn.synUserName like '%" + mhss + "%'";
		}
		Long count = this.commonDAO.count(hql);
		return count;
	}

	@Override
	public List<SynLog> listSynLogAccount(Integer thispage, Integer pagesize,
			String mhss) {
		String hql = " from SynLog syn ";
		if (mhss != null && !mhss.equals("")) {
			hql += " where syn.appName like '%" + mhss
					+ "%' or syn.synResult like '%" + mhss
					+ "%' or syn.synTime like '%" + mhss
					+ "%' or syn.synUserName like '%" + mhss + "%'";
		}
		hql += " order by syn.synTime desc";
		List<SynLog> synLogList = this.commonDAO.findByPage(hql, thispage,
				pagesize);
		return synLogList;
	}

	@Override
	public Long getSynUserApp(UserAccount currentUserAccount) {
		String userHql = "";
		String userSql = "";
		String mergeUuid = currentUserAccount.getMergeUuid();
		if (mergeUuid != null && !mergeUuid.equals("")) {
			// if(1==1) return 4L;
			userHql = "SELECT count(*) FROM ApplicationInfo app where app.id in ("
					+ "SELECT syn.appId FROM SynUser syn where  syn.userId in ("
					+ "select u.code from UserAccount u where u.mergeUuid = '"
					+ mergeUuid + "'" + ")" + ") and app.status = '1'";
			/*
			 * userSql =
			 * "select count(*) from app_applicationinfo app  WHERE app.id in(SELECT syn.app_id from (SELECT u.CODE FROM t_user_account u "
			 * + "WHERE u.merge_uuid = '"+mergeUuid+"'"+
			 * ") a LEFT JOIN syn_user syn on a.CODE=syn.user_id)  and app.status = '1'"
			 * ;
			 */
			userSql = "SELECT count(*) FROM (SELECT * FROM 	app_applicationinfo app LEFT JOIN (SELECT syn.app_id FROM ( SELECT u. CODE "
					+ "FROM t_user_account u WHERE u.merge_uuid = '"
					+ mergeUuid
					+ "' ) a "
					+ "LEFT JOIN syn_user syn ON a.CODE = syn.user_id) t  on app.id = t.app_id "
					+ "WHERE app.STATUS = '1' ) t1 WHERE t1.app_id is not null  order by seq";

		} else {
			userHql = "SELECT count(*) FROM ApplicationInfo app where app.id in (SELECT syn.appId FROM SynUser syn where  syn.userId ='"
					+ currentUserAccount.getCode() + "') and app.status = '1'";
			userSql = " select count(*) from app_applicationinfo a  WHERE a.id in(SELECT app_id FROM syn_user u  WHERE u.user_id = '"
					+ currentUserAccount.getCode()
					+ "')  and a.status = '1' order by seq";
		}
		Long count = commDAO.count(userSql);
		// Long count = this.commonDAO.count(userHql);
		return count;
	}

	@Override
	public List<ApplicationInfo> listSynUserApp(UserAccount currentUserAccount,
			Integer thispage, Integer pagesize) {
		String userHql = "";
		String userSql = "";
		String mergeUuid = currentUserAccount.getMergeUuid();
		if (mergeUuid != null && !mergeUuid.equals("")) {
			userHql = " FROM ApplicationInfo app where app.id in (SELECT syn.appId FROM SynUser syn where  syn.userId in(select u.code from UserAccount u where u.mergeUuid = '"
					+ mergeUuid + "')) and app.status = '1'";
			/*
			 * userSql = "SELECT app.* FROM app_applicationinfo app " +
			 * "WHERE app.id in (SELECT syn.app_id from (SELECT u.CODE FROM t_user_account u"
			 * +" WHERE u.merge_uuid = '"+mergeUuid+"'" +
			 * ") a LEFT JOIN syn_user syn on a.`CODE`=syn.user_id) and app.status = '1'"
			 * ;
			 */
			userSql = "SELECT t1.* FROM (SELECT * FROM 	app_applicationinfo app LEFT JOIN (SELECT syn.app_id FROM ( SELECT u. CODE "
					+ "FROM t_user_account u WHERE u.merge_uuid = '"
					+ mergeUuid
					+ "' ) a "
					+ "LEFT JOIN syn_user syn ON a.CODE = syn.user_id) t  on app.id = t.app_id "
					+ "WHERE app.STATUS = '1' ) t1 WHERE t1.app_id is not null  order by seq asc";
		} else {
			userHql = " FROM ApplicationInfo app where app.id in (SELECT syn.appId FROM SynUser syn where  syn.userId='"
					+ currentUserAccount.getCode() + "') and app.status = '1'";
			userSql = " select a.* from app_applicationinfo a  WHERE a.id in(SELECT app_id FROM syn_user u  WHERE u.user_id = '"
					+ currentUserAccount.getCode()
					+ "')  and a.status = '1' order by seq asc";
		}
		// List<ApplicationInfo> synAppList = this.commonDAO.findByPage(userHql,
		// thispage, pagesize);
		List<ApplicationInfo> synAppList = this.commDAO.findByPage(
				ApplicationInfo.class, userSql, thispage, pagesize);
		return synAppList;
	}

	@Override
	public Long countAppAccount() {
		String hql = "select count(*) from ApplicationInfo ";
		Long count = this.commonDAO.count(hql);
		return count;
	}

	@Override
	public List<ApplicationInfo> listAppAccount(int thispage, int pagesize) {
		String hql = " from ApplicationInfo app";
		List<ApplicationInfo> appList = this.commonDAO.findByPage(hql,
				thispage, pagesize);
		return appList;
	}

	@Override
	public void save(Object object) {
		this.commonDAO.save(object);
	}

	@Override
	public void update(Object object) {
		// TODO Auto-generated method stub
		this.commonDAO.update(object);
	}

	@Override
	public void delete(Object object) {
		// TODO Auto-generated method stub
		this.commonDAO.delete(object);
	}

	@Override
	public ApplicationInfo findAppById(String appid) {
		ApplicationInfo appInfo = this.commonDAO.findOne(ApplicationInfo.class,
				appid);
		return appInfo;
	}

	@Override
	public List<ApplicationInfo> findAppByPropertyName(String name, String param) {
		List<ApplicationInfo> list = this.commonDAO.findByPropertyName(
				ApplicationInfo.class, name, param);
		return list;
	}

	@Override
	public <T> List<T> findByHql(String orgHql) {
		return this.commonDAO.find(orgHql);
	}

	@Override
	public UserAccount findUserById(String userAccountCode) {
		return this.commonDAO.findOne(UserAccount.class, userAccountCode);
	}

	@Override
	public Org findOrgById(long userAccountCode) {
		return this.commonDAO.findOne(Org.class, userAccountCode);
	}
	private String getSynPath(HttpServletRequest request, ApplicationInfo app) {//20170208 修改根据IP区分移动联通
		String path1 =  app.getSynPath1();
		if(path1==null || path1.equals("")){
			return app.getSynPath();
		}
		String type = null;
		try {
			type = new SynUtil().getIPType(request);
		} catch (IOException e) {
			System.err.println("获取IP失败:"+e.getMessage());
			e.printStackTrace();
		}
		if(type == null){
			return app.getSynPath();
		}
		if(type.equals(SynUtil.DIANXIN)){
			return app.getSynPath1();
		}
		if(type.equals(SynUtil.LIANTONG)){
			return app.getSynPath();
		}
		return app.getSynPath();
	}
}
