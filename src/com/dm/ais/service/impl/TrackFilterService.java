package com.dm.ais.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.dm.ais.dto.ShipTrackInfo;



@Service
public class TrackFilterService {
	private static final Logger log = LoggerFactory.getLogger(TrackFilterService.class);
	
	public List<ShipTrackInfo> FilterByTime(String[] strack,int scale){
		System.out.println("11111111111");
		List<ShipTrackInfo> lsttrackinfo = new ArrayList<ShipTrackInfo>();
		int maxnum = 10000;
		double iscale = 1;
		double dcount  = Math.floor(strack.length/scale);
		iscale = scale;
		if (dcount>maxnum){
			double tscale = Math.floor(dcount/maxnum);
			iscale = iscale*tscale;
		}
		 int step = 1;
	     if(scale<5)
	     {
	    	 step =  strack.length/1000;
	     }
	     else if(scale>5 && scale<8)
	     {
	    	 step =  strack.length/5000;
	     }
	     else if(scale>8 && scale<10)
	     {
	    	 step =  strack.length/7000;
	     }
	     else if(scale>10)
	     {
	    	 step =  strack.length/10000;
	     }
		for(int i=0;i<strack.length;i=i+step){
			String strline = strack[i];
			System.out.println(strline);
			//strline = strline.substring(1, strline.length()-1);			
			String[] infos = strline.split("\\|");
			//ShipTrackInfo trackinfo = new ShipTrackInfo();
			ShipTrackInfo trackinfo = new ShipTrackInfo(Double.parseDouble(infos[1]),Double.parseDouble(infos[2]),
					i,infos[3],infos[4],infos[5],infos[12],infos[13],infos[14],infos[15],infos[17]);
			/*trackinfo.setLon(infos[1]);
			trackinfo.setLat(infos[2]);
			trackinfo.setDatetime(infos[3]);
			trackinfo.setAzimuth(infos[4]);
			trackinfo.setSpeed(infos[5]);
			trackinfo.setStatus(infos[12]);
			trackinfo.setMmsi(infos[13]);
			trackinfo.setImo(infos[14]);
			trackinfo.setShipname(infos[15]);
			trackinfo.setCallid(infos[17]);*/
			lsttrackinfo.add(trackinfo);
			
			//i=(int) (i+iscale);
			/*for (int j=0;j<iscale;j++){
				i++;
				//continue;
			}		*/	
		}
		System.out.println(lsttrackinfo.size());
		return lsttrackinfo;
	}
	
	public List<ShipTrackInfo> FilterByDP(String[] strack,double depsilon){
		List<ShipTrackInfo> lsttrackinfo = new ArrayList<ShipTrackInfo>();
		for(int i=0;i<strack.length;i++){
			String strline = strack[i];
			String[] infos = strline.split("|");
			ShipTrackInfo trackinfo = new ShipTrackInfo(Double.parseDouble(infos[1]),Double.parseDouble(infos[2]),
							i,infos[3],infos[4],infos[5],infos[12],infos[13],infos[14],infos[15],infos[17]);
			/*trackinfo.setX(Double.parseDouble(infos[1]));
			trackinfo.setY(Double.parseDouble(infos[2]));
			trackinfo.setIndex(i);
			trackinfo.setDatetime(infos[3]);
			trackinfo.setAzimuth(infos[4]);
			trackinfo.setSpeed(infos[5]);
			trackinfo.setStatus(infos[12]);
			trackinfo.setMmsi(infos[13]);
			trackinfo.setImo(infos[14]);
			trackinfo.setShipname(infos[15]);
			trackinfo.setCallid(infos[17]);*/
			lsttrackinfo.add(trackinfo);		
		}
		Douglas d = new Douglas();  
		d.initPoint(lsttrackinfo,depsilon);
		d.compress(lsttrackinfo.get(0), lsttrackinfo.get(lsttrackinfo.size()-1));
		return lsttrackinfo;
	}
}
 