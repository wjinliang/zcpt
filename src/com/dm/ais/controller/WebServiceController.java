package com.dm.ais.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.JurisdictionAndSites;
import com.dm.ais.model.JurisdictionEntity;
import com.dm.ais.model.LineEntity;
import com.dm.ais.model.SettingEntity;
import com.dm.ais.model.SiteEntity;
import com.dm.ais.service.JurisdictionService;
import com.dm.ais.service.SettingService;
import com.dm.ais.service.SiteInfoService;
import com.dm.ais.util.AisPropertiesUtil;

@Controller
@RequestMapping("/siteinfo")
public class WebServiceController {

	@Resource
	public SiteInfoService siteInfoService;
	@Resource
	public SettingService settingService;
	@Resource
    public JurisdictionService jurisditionService;
	public final static String tjip = AisPropertiesUtil.getInstance().getProperty("tjip");
	@RequestMapping("/webService/getSiteInfo")
	public @ResponseBody JSONArray getSiteInfo() throws Exception {
		List<Order> orders = new ArrayList<Order>();
		List<JurisdictionAndSites> tempList = new ArrayList<JurisdictionAndSites>();
		List<AisSiteInfo> aisSiteList = siteInfoService.listAll(orders);
		List<SettingEntity> settingEntityList = settingService.listAll(orders);
		List<JurisdictionEntity> jurisdictionEntityList = jurisditionService.listAll(orders);
		System.out.println(tjip+"/ReformData/AIS_Monitor/?cmd=DeptInfo");
		String json1 = getHtml(tjip+"/ReformData/AIS_Monitor/?cmd=DeptInfo");
		JSONArray jsonArr = JSONArray.fromObject(json1);
		List lst = jsonArr.toList(jsonArr);
		
		if(settingEntityList.size()>0) {
			for(int i=0; i<jurisdictionEntityList.size(); i++) {
				JurisdictionEntity jurisdictionEntity = jurisdictionEntityList.get(i);
				String jurisdictionId = jurisdictionEntity.getId();
				JurisdictionAndSites jurisdictionAndSiteEntity = new JurisdictionAndSites();
				jurisdictionAndSiteEntity.setJurisdictionId(jurisdictionEntity.getId());    //设置辖区ID
				jurisdictionAndSiteEntity.setJurisdictionName(jurisdictionEntity.getName());  //设置辖区名字
				jurisdictionAndSiteEntity.setJurisdictionLat(jurisdictionEntity.getLat());  //设置辖区纬度
				jurisdictionAndSiteEntity.setJurisdictionLon(jurisdictionEntity.getLon());  //设置辖区经度
				String url2 =tjip+"/ReformData/AIS_Monitor/?cmd=GetTopologyURL&StationID="; 
				String jid = jurisdictionEntity.getId();
				String jurl = getHtml(url2+jid).replace("\"","" ).replace("\\", "");
				jurisdictionAndSiteEntity.setJurl(jurl);     //设置辖区URL
				List<SiteEntity> listSites = new ArrayList<SiteEntity>();
				for(int j=0;j<lst.size();j++){
					SiteEntity siteEntity = new SiteEntity();
					JSONObject info=jsonArr.getJSONObject(j);
		            String StationID=info.getString("StationID");
		            String StationIDshort = StationID.substring(0, 6);
		            if (StationIDshort.equals(jurisdictionEntity.getId().substring(0, 6))) {
		            	for (int k = 0; k < aisSiteList.size(); k++) {
			            	AisSiteInfo aisSiteInfo = aisSiteList.get(k);
			            	  if (StationID.equals(aisSiteInfo.getAgreementId())) {  //拿到接口1基站ID 匹配ais_site_info的协议ID。（接口传过来的基站和本地匹配）
			            		  String id = aisSiteInfo.getId();
			            		  String url =tjip+"/ReformData/AIS_Monitor/?cmd=GetTopologyURL&StationID="; 
			            		  String urlTest = getHtml(url+StationID).replace("\"","" ).replace("\\", "");
			            		  siteEntity.setSitename(info.getString("name"));   //基站名字 11
			            		  siteEntity.setUrl(urlTest);
			            		  for (int l = 0; l < settingEntityList.size(); l++) {
			            			  SettingEntity settingEntity = settingEntityList.get(l);
										if (id.equals(settingEntity.getSiteInfoId())) {   //拿基站 长ID 匹配 ais_setting的site_info_id （基站匹配完之后，通过ID匹配经纬度）
											siteEntity.setSiteLat(settingEntity.getLat());   //经度 22
						  					siteEntity.setSiteLatType(settingEntity.getLatType());    //经度类型 33
						  					siteEntity.setSiteLon(settingEntity.getLon());   //纬度 44
						  					siteEntity.setSiteLonType(settingEntity.getLonType());  //纬度类型 55
						  					siteEntity.setMmsi(settingEntity.getMmsi()); //mmsi
										}
			            		  	}
			  						siteEntity.setAgreementId(aisSiteInfo.getAgreementId());//协议ID 66
			  						
			  						//处理接口2  基站状态和基站辖区连接状态
			  					//可以对每个时间域单独修改
			  						Calendar c = Calendar.getInstance();
			  						String month2 = "";
			  						String date2 = "";
			  						String hour2 = "";
			  						String minute2 = "";
			  						String second2 = "";
			  						int year = c.get(Calendar.YEAR); 
			  						int month = c.get(Calendar.MONTH)+1; 
			  						if (month < 10) {
										month2 = "0" + month;
									}else {
										month2 = ""+month;
									}
			  						int date = c.get(Calendar.DATE); 
			  						if (date < 10) {
			  							date2 = "0" + date;
									}else {
										date2 = ""+date;
									}
			  						int hour = c.get(Calendar.HOUR_OF_DAY); 
			  						if (hour <10) {
										hour2 = "0"+hour;
									}else {
										hour2 = ""+hour;
									}
			  						int minute = c.get(Calendar.MINUTE); 
			  						if (minute < 10) {
										minute2 = "0" + minute;
									}else {
										minute2 = "" + minute;
									}
			  						int second = c.get(Calendar.SECOND); 
			  						if (second < 10) {
										second2 = "0"+second;
									}else {
										second2 = ""+second;
									}
			  						String time = year + "-" + month2 + "-" + date2 + "%20" +hour2 + ":" +minute2 + ":" + second2;
			  						String html = tjip+"/ReformData/AIS_Monitor/?cmd=RunState&Time="+time;
			  						String json2 = getHtml(html);
			  						if(!json2.equals("")){
			  							JSONObject json=JSONObject.fromObject(json2) ;  
		  								JSONArray  jsonArr2=json.getJSONArray("StationInnerState");
				  						List lst2 = jsonArr2.toList(jsonArr2); //获取长度
				  						JSONArray  jsonArr3=json.getJSONArray("StationConnState");
				  						List lst3 = jsonArr3.toList(jsonArr3);
				  						
				  						for (int l = 0; l < lst2.size(); l++) {
				  							JSONObject info2=jsonArr2.getJSONObject(l);
				  							if (StationID.equals(info2.getString("StationID"))) {
				  								siteEntity.setSitestate(info2.getString("StationState"));//基站状态 77
											}
										}
				  						
				  						for (int l = 0; l < lst3.size(); l++) {
				  							JSONObject info3=jsonArr3.getJSONObject(l);
				  							if (StationID.equals(info3.getString("StationID2"))) {
				  								siteEntity.setConnstate(info3.getString("ConnState"));//连接状态 88
											}
										}
				  						
			  						}
			  						
			  						//添加辖区和基站之间连线的信息
			  						String lineurl = tjip+"/ReformData/AIS_Monitor/?cmd=LineState&StationID1=";
			  						lineurl = lineurl+jid+"&StationID2="+aisSiteInfo.getAgreementId()+"&Time="+time;
			  						System.out.println(lineurl);
			  						String json3 = getHtml(lineurl);
			  						json3 = json3.substring(1, json3.length()-1);
			  						System.out.println(json3);
			  						List<LineEntity> lineList = new ArrayList<LineEntity>();
			  						LineEntity lineEntity = new LineEntity();
			  						if(!json3.equals("")){
			  							JSONObject linejson=JSONObject.fromObject(json3) ;
				  						//System.out.println(linejson.getString("DevName2"));
				  						
				  						lineEntity.setConnState(linejson.getString("ConnState"));
				  						lineEntity.setDevName1(linejson.getString("DevName1"));
				  						lineEntity.setDevName2(linejson.getString("DevName2"));
				  						lineEntity.setPortName1(linejson.getString("PortName1"));
				  						lineEntity.setPortName2(linejson.getString("PortName2"));
				  						lineEntity.setTotalFlux(linejson.getString("TotalFlux"));
				  						lineEntity.setUsageRate(linejson.getString("UsageRate"));
				  						
				  						
			  						}
			  						
			  						lineList.add(lineEntity);
			  						siteEntity.setLine(lineList);
			  						
			  						listSites.add(siteEntity);
								}
						}
					}
				}
				jurisdictionAndSiteEntity.setListSites(listSites);   //设置辖区包含基站
				tempList.add(jurisdictionAndSiteEntity);
			}
		}
		JSONArray jsonArray = new JSONArray();
		jsonArray.addAll(tempList);
		
		return jsonArray;
	}
	
	public static JSONArray getJson() throws IOException {
		
		String json1 = getHtml("http://111.160.243.126:12345/ReformData/AIS_Monitor/?cmd=DeptInfo");
		JSONArray jsonArr = JSONArray.fromObject(json1);
		List lst = jsonArr.toList(jsonArr);
		/*
		 * 测试 测试 以天津接口为基本信息，将本地信息添加到基本信息。   
		 * */
		List<JurisdictionAndSites> tempList2 = new ArrayList<JurisdictionAndSites>();
		//System.out.println("长度为"+lst.size());
		for (int i = 0; i < 5; i++) {
			JurisdictionAndSites jurisdictionAndSiteEntity2 = new JurisdictionAndSites();
			JSONObject info=jsonArr.getJSONObject(i);
			String name=info.getString("name");
			
			//jurisdictionAndSiteEntity2.setCeshi(info.getString("name"));
			tempList2.add(jurisdictionAndSiteEntity2);
		}
		JSONArray jsonArray2 = new JSONArray();
		jsonArray2.addAll(tempList2);
		//System.out.println(jsonArray2);
		return jsonArray2;
	}
	
	public static String getHtml(String url) throws IOException {
		String source ="";
		String line ="";
		URL _url = new URL(url);
		InputStream inStream = _url.openStream();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inStream,"UTF-8"));
		while((line = bufferedReader.readLine())!=null) {
			source += line;
		}
		//System.out.println("source="+source);
		return source;
	}
	
	
	public static void main(String[] args) throws IOException {
		HttpClient client = new HttpClient();
		//ceshi
		getJson();
		// 封装表单数据
		PostMethod post = new PostMethod("http://127.0.0.1:8080/DM/siteinfo/webService/getSiteInfo");
		
		// 执行请求
		int status;
		try {
			status = client.executeMethod(post);
			String body = post.getResponseBodyAsString();
			System.out.println(body);
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
