package com.dm.ais.model;

import java.io.Serializable;

public class SiteBaseInfoEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4192284388020649652L;
	private String sitename;   //基站名称
	private String agreementid;  //协议ID
	private String ip_address_a;  //ip A
	private String ip_address_b; //ip B
	private String port_a;  //端口A
	private String port_b; //端口B
	private String lat;//纬度
	private String lon;//纬度
		
	public String getIp_address_a() {
		return ip_address_a;
	}
	public void setIp_address_a(String ip_address_a) {
		this.ip_address_a = ip_address_a;
	}
	public String getIp_address_b() {
		return ip_address_b;
	}
	public void setIp_address_b(String ip_address_b) {
		this.ip_address_b = ip_address_b;
	}
	public String getSitename() {
		return sitename;
	}
	public void setSitename(String sitename) {
		this.sitename = sitename;
	}
	public String getAgreementid() {
		return agreementid;
	}
	public void setAgreementid(String agreementid) {
		this.agreementid = agreementid;
	}
	public String getPort_a() {
		return port_a;
	}
	public void setPort_a(String port_a) {
		this.port_a = port_a;
	}
	public String getPort_b() {
		return port_b;
	}
	public void setPort_b(String port_b) {
		this.port_b = port_b;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLon() {
		return lon;
	}
	public void setLon(String lon) {
		this.lon = lon;
	}
	
	
}
