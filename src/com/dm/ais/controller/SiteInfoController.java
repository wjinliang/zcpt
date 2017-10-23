package com.dm.ais.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.util.DateUtil;
import org.apache.commons.validator.Msg;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.DlmEntity;
import com.dm.ais.model.ReferenceEntity;
import com.dm.ais.model.ReportEntity;
import com.dm.ais.model.SettingEntity;
import com.dm.ais.service.DlmService;
import com.dm.ais.service.ReferenceService;
import com.dm.ais.service.ReportService;
import com.dm.ais.service.SettingService;
import com.dm.ais.service.SiteInfoService;
import com.dm.ais.util.AisPropertiesUtil;
import com.dm.ais.util.WebServiceTemplate;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.model.DictItem;
import com.dm.platform.service.DictService;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping("/siteinfo")
public class SiteInfoController extends DefaultController {
	
	@Resource
	public SiteInfoService siteInfoService;
	@Resource
	public SettingService settingService;
	@Resource
	public ReportService reportService;
	@Resource
	public ReferenceService referenceService;
	@Resource
	public DlmService dlmService;
	 @Resource
	 DictService dictService;

	//查询所有的基站信息
	@RequestMapping("/list")
	public ModelAndView list(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			AisSiteInfo siteInfo) {
		if (pagesize == null) {
			pagesize = 6;
		}
		if (thispage == null) {
			thispage = 0;
		}
		List<Order> orders = new ArrayList<Order>();
		orders.add(new Order(Direction.DESC, "createTime"));
		List<AisSiteInfo> siteList = siteInfoService.listByPage(siteInfo,thispage,
				pagesize, orders);
		Long totalcount = siteInfoService.count(siteInfo);
		if ((thispage) * pagesize >= totalcount && totalcount > 0) {
			thispage--;
		}
		model.addObject("siteList", siteList);
		model.addObject("siteinfo",siteInfo);
		model.addObject("totalcount", totalcount);
		model.setViewName("/pages/ais/siteinfo/siteinfolist");
		return Model(model, thispage, pagesize, totalcount);
	}

	//添加，查看，修改基站信息
	@RequestMapping("/form/{mode}")
	public ModelAndView toSave(
			ModelAndView model, 
			@PathVariable String mode,
			@RequestParam(value = "siteid", required = false) String siteid) {
		try {
			AisSiteInfo entity = null;
			if (mode != null && !mode.equals("new")) {
				if(siteid != null) {
					entity = siteInfoService.findById(siteid);
					model.addObject("siteInfo", entity);
					if(mode.equals("view")){
						model.setViewName("/pages/ais/siteinfo/siteinfoview");
						return Model(model);
					}
				}
			}
			model.setViewName("/pages/ais/siteinfo/siteinfoform");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	
	//(批量)删除基站
	@RequestMapping("/delete")
	public void delete(HttpServletResponse response,
			@RequestParam(value = "siteid", required = false) String siteid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (siteid != null) {
				AisSiteInfo entity = null;
				String[] ids = siteid.split(",");
				for (String str : ids) {
					entity = siteInfoService.findById(siteid);
					JSONObject jsonObject = WebServiceTemplate.getInstance().testDelete(entity.getAgreementId());
					if(jsonObject.getInt("code")==0) {
						siteInfoService.deleteById(str);
					}
				}
			}
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			out.write("error");
			out.flush();
			out.close();
		}
	}
	
	//建立连接---即创建基站，1并对基站进行隐式智能配置,即修改一个变量值 0:未连接 1:已连接
	@RequestMapping("/setConnect")
	public void setConnect(HttpServletResponse response, 
			@RequestParam(value = "siteid", required = false) String siteid,
			@RequestParam(value = "connectFlag", required = false) String connectFlag) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			AisSiteInfo entity = null;
			if (siteid != null) {
				entity = siteInfoService.findById(siteid);
				JSONObject jsonObject = WebServiceTemplate.getInstance().testAdd(entity);  //ceshi4
				System.out.println("调用接口4");
				if(jsonObject.getInt("code")==0) {
					System.out.println("调用接口4成功");
					siteInfoService.setConnect(siteid, connectFlag);
					//取得当前基站的协议ID
					String id = entity.getId();
					String agreementid = entity.getAgreementId();
					String uid = entity.getSitename();
					String ds = entity.getSiteType();
					GetAddress(id,agreementid,uid,ds);     //开始获取基站的地址信息
					out.write("ok");
				} else {
					String msg = jsonObject.getString("data");
					String msg1 = msg.substring(msg.length()-4, msg.length());
					if (msg1.equals("已经存在")) {
						out.write(msg1);
					}else {
						out.write("error");
					}
				}
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			out.write("error");
			out.flush();
			out.close();
		}
	}
	//根据协议ID 调用接口 获取基站配置信息。计算报文。存库。
	//id 关联基础表
	// agreementid  匹配接口，获取信息。
	//uid 第一步录入的名字，在这里是UID
	public final static String cfd9 = AisPropertiesUtil.getInstance().getProperty("cfd9");
	public final static String cfd10 = AisPropertiesUtil.getInstance().getProperty("cfd10");
	public final static String hh9 = AisPropertiesUtil.getInstance().getProperty("hh9");
	public final static String hh10 = AisPropertiesUtil.getInstance().getProperty("hh10");
	public final static String dy9 = AisPropertiesUtil.getInstance().getProperty("dy9");
	public final static String dy10 = AisPropertiesUtil.getInstance().getProperty("dy10");
	public final static String dtd9 = AisPropertiesUtil.getInstance().getProperty("dtd9");
	public final static String dtd10 = AisPropertiesUtil.getInstance().getProperty("dtd10");
	public void GetAddress(String id,String agreementid,String uid,String ds){
		SettingEntity entity = new SettingEntity();
		//agreementid 用来调用借口获取信息。目前先用测试信息。
		entity.setId("1");  //自动生成
		entity.setSiteInfoId(id);  //用来关联基础表
		/*double AOM5 = 36;
		double AON5 = 53.837;
		double AOM6 = 122;
		double AON6 = 30.8598; 
		DecimalFormat df=new DecimalFormat("0.000000");
		double AOM9 =  new Double(df.format(AOM5+AON5/60).toString()); 
		double AOM10 = new Double(df.format(AOM6+AON6/60).toString()); */
		double AOM9 = 0;
		double AOM10 = 0;
		if (agreementid.equals("00010401")) {  //曹妃甸
			AOM9 = Double.valueOf(cfd9);
			AOM10 = Double.valueOf(cfd10);
		}else if (agreementid.equals("00010402")) { //黄骅
			AOM9 = Double.valueOf(hh9);
			AOM10 = Double.valueOf(hh10);
		}else if (agreementid.equals("00010403")) {  //东营
			AOM9 = Double.valueOf(dy9);
			AOM10 = Double.valueOf(dy10);
		}else if (agreementid.equals("00010405")) {   //东突堤  北京
			AOM9 = Double.valueOf(dtd9);
			AOM10 = Double.valueOf(dtd10);
		}else {
			AOM9 = 36.371745;
			AOM10 = 120.854105;
		}
		getReport(id,AOM9,AOM10,uid,ds,agreementid);
		String AOM9S = Double.toString(AOM9); //转换 只用于存储。AOM9用来计算
		String AOM10S = Double.toString(AOM10);//转换 只用于存储。AOM10用来计算
		entity.setLat(AOM9S);
		entity.setLon(AOM10S);
		//entity.setMmsi("ceshi");
		entity.setHighAccuracy(0);   //1=高 0=低
		entity.setPositionSource(0);  //0=surveyed
		entity.setHighPowerA(0);
		entity.setHighPowerB(0);
		entity.setRetriesNumber(3);  //0-3
		entity.setRepeatIndicator(3);  //0-3
		entity.setLatType("N");
		entity.setLonType("E");
		entity.setRxChannelA(2087);
		entity.setRxChannelB(2088);
		entity.setTxChannelA(2087);
		entity.setTxChannelB(2088);
		entity.setUid(uid);
		entity.setAgreementid(agreementid);
		settingService.save(entity);
	}
	
	//往ais_report插入报文
	public void getReport(String id,double AOM9,double AOM10,String uid,String ds,String agreementid){
		List<Order> orders = new ArrayList<Order>();
		ReportEntity entity4 = new ReportEntity();
		ReportEntity entity20 = new ReportEntity();
		DlmEntity entitydlm4A = new DlmEntity();
		DlmEntity entitydlm4B = new DlmEntity();
		DlmEntity entitydlm20A = new DlmEntity();
		DlmEntity entitydlm20B = new DlmEntity();
		String result = Integer.toString(ExcelFormula(AOM9,AOM10));
		System.out.println(result+"=="+ds);
		String report4 = "0";
		String report20 = "0";
		if (ds.equals("0")) {     //0表是单基站   匹配_1
			 report4 = result + "_1";
			 report20 = result + "_1";
		}else if (ds.equals("1")) {     //1表示双基站   匹配_2
			 report4 = result + "_2";
			 report20 = result + "_2";
		}
		System.out.println(agreementid);
		List<ReferenceEntity> ExcelList = referenceService.listAll(orders);
		for (int i = 0; i < ExcelList.size(); i++) {
			ReferenceEntity referenceEntity = ExcelList.get(i);
			//System.out.println("report="+report4);
			entity4.setId("1");
			entity4.setMsgId(4);//4号报文
			entity4.setReportRatesForMsgType("1");   //4号报文
			entity4.setUid(uid);
			entity4.setSiteInfoId(id);
			entity4.setAgreementid(agreementid);
			
			entity20.setId("1");
			entity20.setMsgId(20);//20号报文
			entity20.setReportRatesForMsgType("3");  //20号报文
			entity20.setUid(uid);
			entity20.setSiteInfoId(id);
			entity20.setAgreementid(agreementid);
			
			entitydlm4A.setId("1");
			entitydlm4A.setSiteInfoId(id);
			entitydlm4A.setChannelType("A");  //4号A
			entitydlm4A.setReservation("1");   //对应A/B channel各有 1, 2, 3, 4 
			entitydlm4A.setSeqNumber("1");  //1-40
			entitydlm4A.setAgreementid(agreementid);
			
			entitydlm4B.setId("1");
			entitydlm4B.setSiteInfoId(id);
			entitydlm4B.setChannelType("B");  //4号B
			entitydlm4B.setReservation("1");   //对应A/B channel各有 1, 2, 3, 4 
			entitydlm4B.setSeqNumber("1");  //1-40
			entitydlm4B.setAgreementid(agreementid);
			
			entitydlm20A.setId("1");
			entitydlm20A.setSiteInfoId(id);
			entitydlm20A.setChannelType("A");  //20号A
			entitydlm20A.setReservation("2");    //对应A/B channel各有 1, 2, 3, 4 
			entitydlm20A.setSeqNumber("2");   //1-40
			entitydlm20A.setAgreementid(agreementid);
			
			entitydlm20B.setId("1");
			entitydlm20B.setSiteInfoId(id);
			entitydlm20B.setChannelType("B");  //20号B
			entitydlm20B.setReservation("2");    //对应A/B channel各有 1, 2, 3, 4 
			entitydlm20B.setSeqNumber("2");   //1-40
			entitydlm20B.setAgreementid(agreementid);
			//4号报文A
			if (report4.equals(referenceEntity.getReference())&&referenceEntity.getConfiguration().equals("4")) {
				entity4.setChAIncrement(Integer.parseInt(referenceEntity.getIncrementA()));
				entity4.setChASlot(Integer.parseInt(referenceEntity.getStartSlotA()));
				entity4.setChAutcMinute(0);
				entity4.setChBIncrement(Integer.parseInt(referenceEntity.getIncrementB()));
				entity4.setChBSlot(Integer.parseInt(referenceEntity.getStartSlotB()));
				entity4.setChButcMinute(0);
				entitydlm4A.setIncrement(Integer.parseInt(referenceEntity.getIncrementA()));
				entitydlm4A.setStartSlot(Integer.parseInt(referenceEntity.getStartSlotA()));
				entitydlm4A.setTimeout(0);
				entitydlm4A.setSlotNumber(Integer.parseInt(referenceEntity.getBlockSizeA()));
				entitydlm4A.setOwnership("Local");
			}
			//4号报文B
			if (report4.equals(referenceEntity.getReference())&&referenceEntity.getConfiguration().equals("4")) {
				entitydlm4B.setIncrement(Integer.parseInt(referenceEntity.getIncrementB()));
				entitydlm4B.setStartSlot(Integer.parseInt(referenceEntity.getStartSlotB()));
				entitydlm4B.setTimeout(0);
				entitydlm4B.setSlotNumber(Integer.parseInt(referenceEntity.getBlockSizeB()));
				entitydlm4B.setOwnership("Local");
			}
			//20号报文A
			if (report20.equals(referenceEntity.getReference())&&referenceEntity.getConfiguration().equals("20")) {
				entity20.setChAIncrement(Integer.parseInt(referenceEntity.getIncrementA()));
				entity20.setChASlot(Integer.parseInt(referenceEntity.getStartSlotA()));
				entity20.setChAutcMinute(0);
				entity20.setChBIncrement(Integer.parseInt(referenceEntity.getIncrementB()));
				entity20.setChBSlot(Integer.parseInt(referenceEntity.getStartSlotB()));
				entity20.setChButcMinute(0);
				entitydlm20A.setIncrement(Integer.parseInt(referenceEntity.getIncrementA()));
				entitydlm20A.setStartSlot(Integer.parseInt(referenceEntity.getStartSlotA()));
				entitydlm20A.setTimeout(0);
				entitydlm20A.setSlotNumber(Integer.parseInt(referenceEntity.getBlockSizeA()));
				entitydlm20A.setOwnership("Local");
			}
			//20号报文B
			if (report20.equals(referenceEntity.getReference())&&referenceEntity.getConfiguration().equals("20")) {
				entitydlm20B.setIncrement(Integer.parseInt(referenceEntity.getIncrementB()));
				entitydlm20B.setStartSlot(Integer.parseInt(referenceEntity.getStartSlotB()));
				entitydlm20B.setTimeout(0);
				entitydlm20B.setSlotNumber(Integer.parseInt(referenceEntity.getBlockSizeB()));
				entitydlm20B.setOwnership("Local");
			}
		}
		reportService.save(entity4);
		reportService.save(entity20);
		dlmService.save(entitydlm4A);
		dlmService.save(entitydlm4B);
		dlmService.save(entitydlm20A);
		dlmService.save(entitydlm20B);
	}
	
	
	//保存,修改基站信息   1、基本信息。    
	@RequestMapping("/save")
	public ModelAndView save(ModelAndView model, AisSiteInfo entity) {
		try {
			AisSiteInfo temp = new AisSiteInfo();
			if (entity.getId() != null && !entity.getId().equals("")) {
				temp = siteInfoService.findById(entity.getId());
				String userName = UserAccountUtil.getInstance().getCurrentUser();
				String userId = UserAccountUtil.getInstance().getCurrentUserId();
				
				temp.setSitename(entity.getSitename());   //基站名
				temp.setSiteType(entity.getSiteType());     //基站类型
				temp.setIpAddressA(entity.getIpAddressA());//IPA
				temp.setPortA(entity.getPortA()); //端口A
				temp.setIpAddressB(entity.getIpAddressB());//IPB
				temp.setPortB(entity.getPortB());  //端口B
				temp.setPower(entity.getPower()); //POWER
				temp.setTalkerID(entity.getTalkerID()); //Talker ID
				temp.setArea(entity.getArea()); //地区
				temp.setAreaId(entity.getAreaId()); //地区ID  隐藏
				temp.setJurisdictions(entity.getJurisdictions());  //辖区
				temp.setJurisdictionsId(entity.getJurisdictionsId());  //辖区ID 隐藏
				temp.setAddress(entity.getAddress());  //地址
				temp.setAddressId(entity.getAddressId()); //地址ID 隐藏
				temp.setAgreementId(entity.getAgreementId());     // 协议ID   隐藏
				temp.setManufacturer(entity.getManufacturer());    //制造商
				temp.setManufacturerId(entity.getManufacturerId());  //制造商ID 隐藏
//				temp.setConnectFlag(entity.getConnectFlag());
//				temp.setMmsi(entity.getMmsi());
//				temp.setUid(entity.getUid());
				
				temp.setModifier(userName);
				temp.setModifierId(userId);
				temp.setUpdateTime(DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
				siteInfoService.update(temp);
				return Redirect(model, getRootPath() + "/siteinfo/list", "修改成功！");
				//
			} else {
				String userName = UserAccountUtil.getInstance().getCurrentUser();
				String userId = UserAccountUtil.getInstance().getCurrentUserId();
				entity.setCreator(userName);
				entity.setCreateTime(DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
				entity.setCreatorId(userId);
				entity.setConnectFlag("0");
				siteInfoService.save(entity);
				return Redirect(model, getRootPath() + "/siteinfo/list", "添加成功！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return RedirectError(model, getRootPath() + "/example/list","操作失败！");
		}
	}
	
	//判断基站是否存在
	@RequestMapping("/isExist")
	public void isExist(HttpServletResponse response, String agreementId)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			AisSiteInfo entity = siteInfoService.findByAgreementId(agreementId);
			if(entity!=null) {
				out.write("1");  //存在
			} else {
				out.write("0");  //不存在
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			out.write("error");
			out.flush();
			out.close();
		}
	}
	
	//判断协议ID是否存在
	@RequestMapping("/isExist2")
	public void isExist2(HttpServletResponse response, String agreementId)
			throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int finalc = 0;
		String finals = "";
		DictItem uDictItem = new DictItem();
		//System.out.println(agreementId);
		try {
			AisSiteInfo entity = siteInfoService.findByAgreementId(agreementId);
			if(entity!=null) {
				out.write("1");  //存在
			} else {
				if (agreementId.length()>7) {
					if (!agreementId.substring(0, 6).equals("000104")) {
						List<DictItem> dictItem = dictService.listDictItemByPid("402883484c018dc0014c01ce6ac30011");
						//System.out.println("一共有"+dictItem.size());
						int first = 0;  //初始值
						String c = "";  //把aisSiteInfo放进C进行比较
						for (int i = 0; i < dictItem.size(); i++) {
							DictItem aisSiteInfo=dictItem.get(i);
							c=aisSiteInfo.getItemCode();
							int cint = Integer.parseInt(c);
							if (cint>first) {
								first = cint;
							}
						}
						 finalc = first + 1;
						 finals = "000"+finalc;
						 //System.out.println("1="+finals);
					}
				}else {
					List<DictItem> dictItem = dictService.listDictItemByPid("402883484c018dc0014c01ce6ac30011");
					//System.out.println("一共有"+dictItem.size()+"---"+dictItem.size());
					int first = 0;  //初始值
					String c = "";  //把协议id放进C进行比较
					for (int i = 0; i < dictItem.size(); i++) {
						DictItem dictItem2=dictItem.get(i);
						c=dictItem2.getItemCode();
						int cint = Integer.parseInt(c);
						if (cint>first) {
							first = cint;
						}
						if (c.equals(agreementId)) {
							//System.out.println("需要更新");
							uDictItem = dictItem2;  
						}
					}
					 finalc = first + 1;
					 //System.out.println("2="+finalc);
					 finals = "000"+finalc;
					 uDictItem.setItemCode(finals);
					 dictService.updateDictItem(uDictItem);
				}
				out.write(finals);  //不存在
				
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			out.write("error");
			out.flush();
			out.close();
		}
	}
	
	//获取最最最最新的agreementid
	@RequestMapping("/getaid")
	public void getaid(HttpServletResponse response, String name)
			throws Exception{
		DictItem dictItem2 = new DictItem();
		PrintWriter out = response.getWriter();
		try {
			List<DictItem> dictItem = dictService.listDictItemByPid("402883484c018dc0014c01ce6ac30011");
			for (int i = 0; i < dictItem.size(); i++) {
				dictItem2 = dictItem.get(i);
				if (dictItem2.getItemName().equals(name)) {
					out.write(dictItem2.getItemCode());
				}
			}
		} catch (Exception e) {
			
		}
	}
	/**
	 * 跳转信息
	 * @param model
	 * @param response
	 * @param siteId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/quickConfigure")
	public ModelAndView quickConfigure(ModelAndView model, HttpServletResponse response, 
			String siteId) throws Exception {
		try {
			AisSiteInfo aidSiteInfo = null;
			if (siteId != null && !siteId.equals("")) {
				aidSiteInfo = siteInfoService.findById(siteId);
				model.addObject("siteInfo", aidSiteInfo);
			}
			model.setViewName("/pages/ais/QuickConfigure");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	
	//计算公式
	public static int ExcelFormula(double AOM9,double AOM10){
		int AOM12 = 30;
		int AOM13 = 6;
		int AOM17 = 120;
		int AOM19 = 3;
		//double AOM9 = AOM5+AON5/60;    //处理后的纬度
		//double AOM10 = AOM6+AON6/60;  //处理后的经度
		int AOM21 = (int) Math.floor(Math.abs(AOM9)/AOM19);
		double AOM23 =  (AOM21+0.5)*AOM19;
		int AOM25 = (int)Math.floor((Math.cos(AOM23*Math.PI/180)*AOM17));
		int AOM22 = (int)Math.floor(Math.abs(AOM10)/360*AOM25);
		double AOM27 = 360/(double)AOM13/(double)AOM25;
		int AOM29 = (int) Math.floor(((Math.abs(AOM9)*60)/AOM12)-AOM13*AOM21);
		int AOM31;
		if (AOM9 > 0) {
			AOM31 = AOM13-AOM29-1;
		}else {
			AOM31 = AOM29;
		}
		int AOM33 = (int) Math.floor(Math.abs(AOM10)/AOM27);
		int AOM35 = AOM33-((int)Math.floor(AOM33/6))*6;
		int AOM37; 
		if (AOM10<0) {
			AOM37 = (AOM13-1)-AOM35;
		}else {
			AOM37 = AOM35;
		}
		int AOM39 = AOM31*AOM13+AOM37+1;
		return AOM39;
	}

}
