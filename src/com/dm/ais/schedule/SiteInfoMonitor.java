package com.dm.ais.schedule;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.httpclient.ConnectTimeoutException;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.http.client.ClientProtocolException;
import org.apache.log4j.Logger;
import org.apache.log4j.spi.LoggerFactory;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.data.domain.Sort.Order;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dm.ais.controller.WebServiceController;
import com.dm.ais.dto.GridShip;
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
import com.dm.platform.aop.LogAspect;
import com.dm.platform.util.ReadProperties;
/**
 * spring 集成 quartz来实现定时功能
 * 定时将网格数据刷新到缓存
 * @author zhao
 * @date 2015-4-24
 */

public class SiteInfoMonitor{
	@Resource
	public SiteInfoService siteInfoService;
	@Resource
	public SettingService settingService;
	@Resource
    public JurisdictionService jurisditionService;
	@Resource
	Cache myCache;
	private  Logger log = Logger.getLogger(SiteInfoMonitor.class);
	public final static String tjip = AisPropertiesUtil.getInstance().getProperty("tjip");
	//@PostConstruct
	public void monitor()
	{
	/**
	 * 天津瑞丰接口  用于日常工作的数据显示
	 */
		System.out.println("siteMonitor…………");
		List<Order> orders = new ArrayList<Order>();
		List<JurisdictionAndSites> tempList = new ArrayList<JurisdictionAndSites>();
		List<AisSiteInfo> aisSiteList = siteInfoService.listAll(orders);
		List<SettingEntity> settingEntityList = settingService.listAll(orders);
		List<JurisdictionEntity> jurisdictionEntityList = jurisditionService.listAll(orders);
		
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
		//JSONArray jsonArray = new JSONArray();
		//jsonArray.addAll(tempList);
		Element htelement = new Element("htelement", tempList);  
		myCache.put(htelement);
		//return jsonArray;
	}
	
	public  String getHtml(String url){
		String source ="";
		String line ="";
		URL _url = null;
		try {
			_url = new URL(url);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		InputStream inStream = null;
		try {
			inStream = _url.openStream();
		} catch (IOException e) 
		{
			
		}
		
		BufferedReader bufferedReader = null;
		try {
			bufferedReader = new BufferedReader(new InputStreamReader(inStream,"UTF-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			while((line = bufferedReader.readLine())!=null) {
				source += line;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("source="+source);
		return source;
	}
/**
 * 定时把网格数据加载到缓存中	
 * @return
 */
 //@PostConstruct
 public void gridLoad()
 {
	 System.out.println("gridLoading………………");
	 HttpClient client = new HttpClient();
	 String url ="";
	 try {
		url = ReadProperties.getInstance().getProperties("dongfangtongIpAddress")+"/fcgi-bin/AIS_Monitor?cmd=0x0701";
	   System.out.println(url);
	 } catch (IOException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	 GetMethod getMethod = new GetMethod(url);
	
	 String result = null;
	 Map<Integer,GridShip> middleMap = new HashMap<Integer,GridShip>();
	 Map<Integer,GridShip> bigMap = new HashMap<Integer,GridShip>();
		try {
			int status = client.executeMethod(getMethod);
			System.out.println(status);
			result = getMethod.getResponseBodyAsString();
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			System.out.println("11111111");
			getMethod.releaseConnection();
		}
		ObjectMapper objectMapper = new ObjectMapper();
		List<GridShip> gridSmallShip = null;
		try {
			gridSmallShip = objectMapper.readValue(result, new TypeReference<List<GridShip>>(){
			});
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Element elementSm = new Element("gridSmall", gridSmallShip);  
		myCache.put(elementSm);
		Map<Integer,GridShip> gridMiddle = gernerateMiddle(gridSmallShip,middleMap); 
		List<String> gridMiddleShip = new ArrayList(gridMiddle.values()); 
		Element elementMi = new Element("gridMiddle", gridMiddleShip);  
		myCache.put(elementMi);
		Map<Integer,GridShip> gridBig = gernerateBig(gridMiddle,bigMap); 
		List<String> gridBigShip = new ArrayList(gridBig.values()); 
		Element elementBig = new Element("gridBig", gridBigShip);  
		myCache.put(elementBig);
 }
 /**
  * 生成Middle网格数据。
  * @param gridSmall 最小等级网格
  * @return middle 网格
  */
 public  Map<Integer,GridShip> gernerateMiddle(List<GridShip> gridSmall,Map<Integer,GridShip> middleMap)
 {

	 for(GridShip small:gridSmall)
	 {
		 Integer num = small.getNum();
		 Integer middleNum = ((num-1)/144)/2*72+((num-1)%144)/2+1;
		 GridShip gridMiddle = middleMap.get(middleNum);
		 if(gridMiddle!=null)
		 {
			 gridMiddle.setShipnum(gridMiddle.getShipnum()+small.getShipnum());
		 }
		 else{
		 GridShip middle = new GridShip();
		 middle.setNum(middleNum);
		 Map<String, Float> map = computeLngLat(middleNum);
		 middle.setNelat(map.get("neLat"));
		 middle.setNelng(map.get("neLng"));
		 middle.setSwlat(map.get("swLat"));
		 middle.setSwlng(map.get("swLng"));
		 middle.setShipnum(0+small.getShipnum());
		 middleMap.put(middleNum, middle);
		 }
	 }
	return middleMap;
 }
 
 /**
  * 根据编号求得经纬度
  * @param num 网格的编号
  * @return 返回矩形框的经纬度
  */
 public Map<String, Float> computeLngLat(Integer num)
 {
	 int y = (num-1)/72;
	 int x= (num-1)%72;
	 float swLng = -180+x*5;
	 float swLat = 90-(y+1)*5;
	 float neLng = -180 + (x+1) * 5;
	 float neLat = 90-y*5;
	 Map<String, Float> map = new HashMap<String, Float>();
	 map.put("swLng", swLng);
	 map.put("swLat",swLat);
	 map.put("neLng",neLng);
	 map.put("neLat",neLat);
	 return map; 
 }
 
 /**
  * 生成big网格数据。
  * @param gridSmall 最小等级网格
  * @return middle 网格
  */
 public Map<Integer,GridShip> gernerateBig(Map<Integer, GridShip> gridMiddleShip,Map<Integer,GridShip> bigMap)
 {
	 Set<Integer> keys = gridMiddleShip.keySet();
	 for(Integer key:keys)
	 {
		  GridShip middle = gridMiddleShip.get(key);
		 Integer num = middle.getNum();
		 Integer bigNum = ((num-1)/72)/2*36+((num-1)%72)/2+1;
		 GridShip gridBig = bigMap.get(bigNum);
		 if(gridBig!=null)
		 {
			 gridBig.setShipnum(gridBig.getShipnum()+middle.getShipnum());
		 }
		 else{
		 GridShip bigGrid = new GridShip();
		 bigGrid.setNum(bigNum);
		 Map<String, Float> map = computeLngLatBig(bigNum);
		 bigGrid.setNelat(map.get("neLat"));
		 bigGrid.setNelng(map.get("neLng"));
		 bigGrid.setSwlat(map.get("swLat"));
		 bigGrid.setSwlng(map.get("swLng"));
		 bigGrid.setShipnum(0+middle.getShipnum());
		 bigMap.put(bigNum, bigGrid);
		 }
	 }
	return bigMap;
 }
 
 /**
  * 根据编号求得经纬度
  * @param num 网格的编号
  * @return 返回矩形框的经纬度
  */
 public Map<String, Float> computeLngLatBig(Integer num)
 {
	 int y = (num-1)/36;
	 int x= (num-1)%36;
	 float swLng = -180+x*10;
	 float swLat = 90-(y+1)*10;
	 float neLng = -180 + (x+1)*10;
	 float neLat = 90-y*10;
	 Map<String, Float> map = new HashMap<String, Float>();
	 map.put("swLng", swLng);
	 map.put("swLat",swLat);
	 map.put("neLng",neLng);
	 map.put("neLat",neLat);
	 return map; 
 }
}
