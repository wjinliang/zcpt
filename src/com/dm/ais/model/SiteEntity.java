package com.dm.ais.model;

import java.io.Serializable;
import java.util.List;

public class SiteEntity implements Serializable {

	private static final long serialVersionUID = 4118759713522450405L;
	private String sitename;  //基站名称
	private String siteLat;   //纬度
	private String siteLatType;  //纬度类型
	private String siteLon;   //经度
	private String siteLonType;  //经度类型
	private String agreementId;  //协议Id
	private String sitestate; //基站状态
	private String connstate;  //连接状态
	private String url;  //URL地址
	private String mmsi; //mmsi
	private List<LineEntity> line;

	
	public String getSitename() {
		return sitename;
	}
	public void setSitename(String sitename) {
		this.sitename = sitename;
	}
	public String getSiteLat() {
		return siteLat;
	}
	public void setSiteLat(String siteLat) {
		this.siteLat = siteLat;
	}
	public String getSiteLatType() {
		return siteLatType;
	}
	public void setSiteLatType(String siteLatType) {
		this.siteLatType = siteLatType;
	}
	public String getSiteLon() {
		return siteLon;
	}
	public void setSiteLon(String siteLon) {
		this.siteLon = siteLon;
	}
	public String getSiteLonType() {
		return siteLonType;
	}
	public void setSiteLonType(String siteLonType) {
		this.siteLonType = siteLonType;
	}
	public String getAgreementId() {
		return agreementId;
	}
	public void setAgreementId(String agreementId) {
		this.agreementId = agreementId;
	}
	public String getSitestate() {
		return sitestate;
	}
	public void setSitestate(String sitestate) {
		this.sitestate = sitestate;
	}
	public String getConnstate() {
		return connstate;
	}
	public void setConnstate(String connstate) {
		this.connstate = connstate;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public List<LineEntity> getLine() {
		return line;
	}
	public void setLine(List<LineEntity> line) {
		this.line = line;
	}
	public String getMmsi() {
		return mmsi;
	}
	public void setMmsi(String mmsi) {
		this.mmsi = mmsi;
	}

	
}
