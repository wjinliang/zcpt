package com.dm.ais.model;

import java.io.Serializable;
import java.util.List;

public class JurisdictionAndSites implements Serializable{
	private static final long serialVersionUID = 4017529527832696217L;
	private String jurisdictionId;   //辖区id
	private String jurisdictionName; //辖区名称
	private String jurisdictionLat;  //辖区纬度
	private String jurisdictionLon;  //辖区经度
	private String jurl; //辖区URL
	private List<SiteEntity> listSites;  //辖区下的基站信息
	
	public String getJurisdictionId() {
		return jurisdictionId;
	}
	public void setJurisdictionId(String jurisdictionId) {
		this.jurisdictionId = jurisdictionId;
	}
	public String getJurisdictionName() {
		return jurisdictionName;
	}
	public void setJurisdictionName(String jurisdictionName) {
		this.jurisdictionName = jurisdictionName;
	}
	public String getJurisdictionLat() {
		return jurisdictionLat;
	}
	public void setJurisdictionLat(String jurisdictionLat) {
		this.jurisdictionLat = jurisdictionLat;
	}
	public String getJurisdictionLon() {
		return jurisdictionLon;
	}
	public void setJurisdictionLon(String jurisdictionLon) {
		this.jurisdictionLon = jurisdictionLon;
	}
	public List<SiteEntity> getListSites() {
		return listSites;
	}
	public void setListSites(List<SiteEntity> listSites) {
		this.listSites = listSites;
	}
	public String getJurl() {
		return jurl;
	}
	public void setJurl(String jurl) {
		this.jurl = jurl;
	}
}
