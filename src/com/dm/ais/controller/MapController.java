package com.dm.ais.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.ehcache.Cache;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.dto.ShipTrackInfo;
import com.dm.ais.dto.SiteInfoDto;
import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.JurisdictionAndSites;
import com.dm.ais.service.SiteInfoService;
import com.dm.ais.service.impl.TrackFilterService;
import com.dm.ais.util.FileSaveAndLoad;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.util.ReadProperties;

@Controller
@RequestMapping("/siteinfo")
public class MapController extends DefaultController {
	
	@Resource
	Cache myCache;
	
	@Inject 
	TrackFilterService trackFilterService;
	
	ReadProperties readProperties = ReadProperties.getInstance();
	FileSaveAndLoad fileSaveAndLoad = FileSaveAndLoad.getInstance();
	
	@RequestMapping("/map")
	public ModelAndView mapForm(ModelAndView model) throws Exception {
		String dftIpAddress = readProperties.getProperties("dongfangtongIpAddress");
		model.addObject("dftIpAddress", dftIpAddress);
		model.setViewName("/pages/ais/mapiframe");
		System.out.println(getRootPath());
		return Model(model);
	}
	@RequestMapping("/sitemonitor")
	public ModelAndView siteMonitro(ModelAndView model) throws Exception {
		String dftIpAddress = readProperties.getProperties("dongfangtongIpAddress");
		model.addObject("dftIpAddress", dftIpAddress);
		model.setViewName("/pages/ais/sitemapiframe");
		return Model(model);
	}
	@RequestMapping("/showmap")
	public ModelAndView showmap(ModelAndView model) throws Exception {
		model.setViewName("/pages/map/index");
		return Model(model);
	}
	@RequestMapping("/tracewindow")
	public ModelAndView tracewindow(ModelAndView model) throws Exception {
		model.setViewName("/pages/map/tracewindow");
		return Model(model);
	}
	
	@RequestMapping("/tracedownload/{mmsi}")
	public void tracedownload(HttpServletRequest request,HttpServletResponse response,@PathVariable String mmsi) {
		 OutputStream os = null;
		try {
			os = response.getOutputStream();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		    try {  
		    	response.reset();  
		    	response.setHeader("Content-Disposition", "attachment; filename="+mmsi+".txt");  
		    	response.setContentType("application/octet-stream; charset=utf-8");  
		        os.write(fileSaveAndLoad.download(request.getServletContext().getRealPath("/")+"/file/", mmsi+".txt"));  
		        os.flush();  
		    } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {  
		        if (os != null) {  
		            try {
						os.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}  
		        }  
		    }  
	}
	
	@RequestMapping("/traceselect")
	public ModelAndView traceSelect(ModelAndView model,HttpServletRequest request,String mmsi,long startdt,long enddt,int compress) {
		/*http://192.168.3.51:8991/fcgi-bin/AIS_Monitor?cmd=0x0151&mmsi=000000168&startdt=1422261223258&enddt=1422399223258&compress=0*/
		System.out.println(new Date());
		String dftIpAddress = null;
		try {
			dftIpAddress = readProperties.getProperties("dongfangtongIpAddress")+"/fcgi-bin/AIS_Monitor?cmd=0x0151&mmsi="+mmsi+"&startdt="+startdt+"&enddt="+enddt+"&compress="+compress;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			model.addObject("msg", "读取配置文件失败");
		}
		String fileName = mmsi+".txt";
		fileSaveAndLoad.saveFileGet(dftIpAddress, fileName, request.getServletContext().getRealPath("/")+"\\file\\");
		return Model(model);
	}
	
	@RequestMapping("/gridLoad")
	@ResponseBody
	public Object gridLoadIntime(ModelAndView model)
	{
		Map map = new HashMap();
		map.put("small", myCache.get("gridSmall").getValue());
		map.put("middle", myCache.get("gridMiddle").getValue());
		map.put("big",myCache.get("gridBig").getValue());
		return map;
	}
	@RequestMapping("/siteLoad")
	@ResponseBody
	public Object siteLoadIntime(ModelAndView model)
	{
		Map map = new HashMap();
		map.put("siteInfos", myCache.get("siteInfos").getValue());
		return map;
	}
	
	@RequestMapping(value = "/trackfilter", method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public List<ShipTrackInfo> trackFilter(Model model,int scale,String mmsi,String startdt,String enddt,Integer compress,HttpServletRequest request){
		HttpClient httpClient =new HttpClient();
		 List<ShipTrackInfo> strFilter = new ArrayList<ShipTrackInfo>();
		String url = null;
		try {
			url = ReadProperties.getInstance().getProperties("dongfangtongIpAddress")+"/fcgi-bin/AIS_Monitor?mmsi="+mmsi+"&cmd=0x0151&startdt="+startdt+"&enddt="+enddt+"&compress="+compress;
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		//String url =url;"http://192.168.3.51:8991/fcgi-bin/AIS_Monitor?cmd=0x0151&mmsi=000000168&startdt=1422261223258&enddt=1422399223258&compress=0";
		String sResult =null;		
		GetMethod getMethod = null;
		 try
		 {		 
			 getMethod = new GetMethod(url);
			 int statusCode = httpClient.executeMethod(getMethod);
			 if (statusCode != HttpStatus.SC_OK)   
			 {   
				 System.err.println("Method failed: "  
						 + getMethod.getStatusLine());   
			 }	  
			 String[] strTrack=null;
			 String strrestlt = getMethod.getResponseBodyAsString();
			 File file = new File(request.getServletContext().getRealPath("/")+"/file/"+mmsi+".txt");
			    OutputStream opm = null;
				try {
					opm = new FileOutputStream(file);
					opm.write(strrestlt.getBytes("UTF-8"));
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					
				}
				finally{
					try {
						opm.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
					}
				}
			 strrestlt = strrestlt.substring(1, strrestlt.length()-1).replaceAll("\"", "");
			 strTrack = strrestlt.split(",");
			 //lstshiptrackinfo = trackFilterService.FilterByTime(strTrack,scale);
			 /*InputStream txtresponse= getMethod.getResponseBodyAsStream();
			 BufferedReader br = new BufferedReader(new InputStreamReader(txtresponse)); 
			 StringBuffer strbuffer = new StringBuffer();
			 String tempbf; 
			 while((tempbf=br.readLine())!=null){ 
			   strbuffer.append(tempbf); 
			 } 
			 String[] strTrack=null;
			 String strrestlt = strbuffer.toString();
			 strrestlt = strrestlt.substring(1, strrestlt.length()-1);
			 strTrack = strrestlt.split(",");*/
			 
			 
			int step = 1;
		     if(scale<5)
		     {
		    	 step =  strTrack.length/50;
		     }
		     else if(scale>=5 && scale<8)
		     {
		    	 step =  strTrack.length/100;
		     }
		     else if(scale>=8 && scale<10)
		     {
		    	 step =  strTrack.length/150;
		     }
		     else if(scale>=10)
		     {
		    	 step =  strTrack.length/200;
		     }
		     if(step==0)
		     {
		    	 step=step+1;
		     }
		     for(int i=0;i<strTrack.length;i=i+step)
		     {
		    	 String[] infos = strTrack[i].replaceAll("\"", "").split("\\|");
					//ShipTrackInfo trackinfo = new ShipTrackInfo();
					/*ShipTrackInfo trackinfo = new ShipTrackInfo(Double.valueOf(infos[1]),Double.valueOf(infos[2]),
							infos[3],infos[4],infos[5],infos[6],infos[13]);*/
		    	 ShipTrackInfo trackinfo = new ShipTrackInfo(Double.parseDouble(infos[1]),Double.parseDouble(infos[2]),
							i,infos[3],infos[4],infos[5],infos[12],infos[13],infos[14],infos[15],infos[17]);
		    	 strFilter.add(trackinfo);
		     }
		 }	 	
		 catch (HttpException e)   
		 { 	  
			 e.printStackTrace();   
			 //sResult ="sessionExpires:true";
		 } catch (IOException e)   
		 {   
		   e.printStackTrace();   
		 } catch (Exception e)   
		 {   
			 e.printStackTrace();   
			// sResult = "";  
		 }		
		 finally  
		 {			 
			 getMethod.releaseConnection();
		 }
		return  strFilter;
	}
	
	
	@RequestMapping(value = "/areatrackfilter", method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public Map areatrackFilter(Model model,int scale,String startdt,String enddt,String area,HttpServletRequest request){
		long compress =(Long.valueOf(enddt) - Long.valueOf(startdt))/1000/60/50;
		Map<String, List<ShipTrackInfo>> map = new HashMap<String, List<ShipTrackInfo>>();
		HttpClient httpClient =new HttpClient();
		String url = null;
		try {
			url = ReadProperties.getInstance().getProperties("dongfangtongIpAddress")+"/fcgi-bin/AIS_Monitor?cmd=0x011a&area="+area+"&startdt="+startdt+"&enddt="+enddt+"&compress="+100;
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			url=url.replaceAll("\\|", URLEncoder.encode("|","utf-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		//String url =url;"http://192.168.3.51:8991/fcgi-bin/AIS_Monitor?cmd=0x0151&mmsi=000000168&startdt=1422261223258&enddt=1422399223258&compress=0";
		String sResult =null;		
		GetMethod getMethod = null;
			 getMethod = new GetMethod(url);
			 int statusCode;
			try {
				statusCode = httpClient.executeMethod(getMethod);
			} catch (HttpException e) {
				// TODO Auto-generated catch block
				System.out.println("http");
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println("io");
				e.printStackTrace();
			}
			 String[] strTrack=null;
			 String strrestlt = null;
			try {
				strrestlt = getMethod.getResponseBodyAsString();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println("io");
				e.printStackTrace();
			}
			 strrestlt = strrestlt.substring(1, strrestlt.length()-1).replaceAll("\"", "");
			 if(strrestlt.replaceAll(" ", "").equals(""))
			 {
				 Map mapMsg = new HashMap();
				 List<String> list = new ArrayList<String>();
				 list.add("未找到数据！");
				 mapMsg.put("status",list);
				 return mapMsg;
			 }
			 strTrack = strrestlt.split(",");
			 //lstshiptrackinfo = trackFilterService.FilterByTime(strTrack,scale);
			 /*InputStream txtresponse= getMethod.getResponseBodyAsStream();
			 BufferedReader br = new BufferedReader(new InputStreamReader(txtresponse)); 
			 StringBuffer strbuffer = new StringBuffer();
			 String tempbf; 
			 while((tempbf=br.readLine())!=null){ 
			   strbuffer.append(tempbf); 
			 } 
			 String[] strTrack=null;
			 String strrestlt = strbuffer.toString();
			 strrestlt = strrestlt.substring(1, strrestlt.length()-1);
			 strTrack = strrestlt.split(",");*/
			 int step = 1;
		     if(scale<5)
		     {
		    	 step =  strTrack.length/200;
		     }
		     else if(scale>=5 && scale<8)
		     {
		    	 step =  strTrack.length/400;
		     }
		     else if(scale>=8 && scale<10)
		     {
		    	 step =  strTrack.length/600;
		     }
		     else if(scale>=10)
		     {
		    	 step =  strTrack.length/1000;
		     }
		     if(step==0)
		     {
		    	 step=step+1;
		     }
		     for(int i=0;i<strTrack.length;i=i+step)
		     {
		    	 String[] infos = strTrack[i].replaceAll("\"", "").split("\\|");
					//ShipTrackInfo trackinfo = new ShipTrackInfo();
					/*ShipTrackInfo trackinfo = new ShipTrackInfo(Double.valueOf(infos[1]),Double.valueOf(infos[2]),
							infos[3],infos[4],infos[5],infos[6],infos[13]);*/
		    	 ShipTrackInfo trackinfo = new ShipTrackInfo(Double.parseDouble(infos[1]),Double.parseDouble(infos[2]),
							i,infos[3],infos[4],infos[5],infos[12],infos[13],infos[14],infos[15],null);
		    	 if(map.get(infos[13].toString())!=null)
		    	 {
		    		 map.get(infos[13].toString()).add(trackinfo);
		    	 }
		    	 else
		    	 {
		    		 List<ShipTrackInfo> strFilter = new ArrayList<ShipTrackInfo>();
		    		 strFilter.add(trackinfo);
		    		 map.put(infos[13].toString(), strFilter);
		    	 }
		    	
		     }
		     System.out.println(map);
		return  map;
	}
	@RequestMapping("/htLoad")
	@ResponseBody
	public Object htLoadIntime(ModelAndView model)
	{
		List<JurisdictionAndSites> htlist=(List<JurisdictionAndSites>) myCache.get("htelement").getValue();
		return htlist;
	}
}
