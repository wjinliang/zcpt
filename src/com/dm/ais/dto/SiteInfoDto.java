package com.dm.ais.dto;

public class SiteInfoDto {
	/** 协议Id，即地点Id */
	private String agreementId;
	/** 海区Id */
	private String areaId;
	/** 站点名称  */
	private String sitename;
	public String getAgreementId() {
		return agreementId;
	}
	public void setAgreementId(String agreementId) {
		this.agreementId = agreementId;
	}
	public String getAreaId() {
		return areaId;
	}
	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}
	public String getSitename() {
		return sitename;
	}
	public void setSitename(String sitename) {
		this.sitename = sitename;
	}
}
