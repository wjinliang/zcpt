package com.dm.ais.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * AisSiteInfo entity. 
 * @author yinhui 
 * date:2015-3-6
 */
@Entity
@Table(name = "ais_site_info")
public class AisSiteInfo implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 8972007041220763694L;
	/** siteInfoId 也是主键id  */
	private String id;
	/** MMSI */
	private String mmsi;
	/** UID */
	private String uid;
	/** 站点名称  */
	private String sitename;
	/** 基站类型<br>
	 * 0=单基站<br>
	 * 1=双基站
	 */
	private String siteType;
	/** IP地址A　*/
	private String ipAddressA;
	/** 端口号A */
	private String portA;
	/** IP地址B　*/
	private String ipAddressB;
	/** 端口号B */
	private String portB;
	/** 海区Id */
	private String areaId;
	/** 海区 */
	private String area;
	/** 辖区Id */
	private String jurisdictionsId;
	/** 辖区 */
	private String jurisdictions;
	/** 协议Id，即地点Id */
	private String agreementId;
	/** 地点Id  */
	private String addressId;
	/** 地点名称  */
	private String address;
	/** 厂商Id */
	private String manufacturerId;
	/** 厂商 */
	private String manufacturer;
	/** 基站功率  */
	private Integer power;
	/** 基站对话ID	 (AB,AL,AS,AD,AR) </br>
	 * AB=AIS基站（默认值）</br>
	 * AL=受限AIS基站</br>
	 * AS=单一中继站</br>
	 * AD=双重中继站</br>
	 * AR=接收站 */
	private String talkerID;
	/** 创建人Id */
	private String creatorId;
	/** 创建人 */
	private String creator;
	/** 创建时间 */
	private String createTime;
	/** 修改人Id */
	private String modifierId;
	/** 修改人 */
	private String modifier;
	/** 更新时间 */
	private String updateTime;
	/** 连接状态 <br>
	 * 0=未连接 <br>
	 * 1=已连接 <br>
	 * 3=重新连接
	 */
	private String connectFlag;
	/** 预留字段 */
	private String info1;
	/** 预留字段 */
	private String info2;
	/** 预留字段 */
	private String info3;
	/** 预留字段 */
	private String info4;
	/** 预留字段 */
	private String info5;

	// Constructors

	/** default constructor */
	public AisSiteInfo() {
	}

	/** full constructor */
	

	// Property accessors
	@Id
	@GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "agreement_id", length = 8)
	public String getAgreementId() {
		return this.agreementId;
	}

	public void setAgreementId(String agreementId) {
		this.agreementId = agreementId;
	}

	@Column(name = "mmsi", length = 9)
	public String getMmsi() {
		return this.mmsi;
	}

	public void setMmsi(String mmsi) {
		this.mmsi = mmsi;
	}
	
	@Column(name = "u_id", length = 15)
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	@Column(name = "area", length = 8)
	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Column(name = "jurisdictions", length = 8)
	public String getJurisdictions() {
		return this.jurisdictions;
	}

	public void setJurisdictions(String jurisdictions) {
		this.jurisdictions = jurisdictions;
	}

	@Column(name = "sitename", length = 20)
	public String getSitename() {
		return this.sitename;
	}

	public void setSitename(String sitename) {
		this.sitename = sitename;
	}

	@Column(name = "site_type", length = 2)
	public String getSiteType() {
		return siteType;
	}

	public void setSiteType(String siteType) {
		this.siteType = siteType;
	}

	@Column(name = "ip_address_a", length = 15)
	public String getIpAddressA() {
		return ipAddressA;
	}

	public void setIpAddressA(String ipAddressA) {
		this.ipAddressA = ipAddressA;
	}

	@Column(name = "port_a", length = 5)
	public String getPortA() {
		return portA;
	}

	public void setPortA(String portA) {
		this.portA = portA;
	}

	@Column(name = "ip_address_b", length = 15)
	public String getIpAddressB() {
		return ipAddressB;
	}

	public void setIpAddressB(String ipAddressB) {
		this.ipAddressB = ipAddressB;
	}

	@Column(name = "port_b", length = 5)
	public String getPortB() {
		return portB;
	}

	public void setPortB(String portB) {
		this.portB = portB;
	}

	@Column(name = "manufacturer", length = 8)
	public String getManufacturer() {
		return this.manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	@Column(name = "connect_flag", length = 2)
	public String getConnectFlag() {
		return connectFlag;
	}

	public void setConnectFlag(String connectFlag) {
		this.connectFlag = connectFlag;
	}

	@Column(name = "area_id", length = 8)
	public String getAreaId() {
		return areaId;
	}

	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}

	@Column(name = "jurisdictions_id", length = 8)
	public String getJurisdictionsId() {
		return jurisdictionsId;
	}

	public void setJurisdictionsId(String jurisdictionsId) {
		this.jurisdictionsId = jurisdictionsId;
	}

	@Column(name = "address_id", length = 8)
	public String getAddressId() {
		return addressId;
	}

	public void setAddressId(String addressId) {
		this.addressId = addressId;
	}

	@Column(name = "address", length = 200)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "manufacturer_id", length = 8)
	public String getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}

	@Column(name = "power")
	public Integer getPower() {
		return power;
	}

	public void setPower(Integer power) {
		this.power = power;
	}

	@Column(name = "talker_id",length=10)
	public String getTalkerID() {
		return talkerID;
	}

	public void setTalkerID(String talkerID) {
		this.talkerID = talkerID;
	}

	@Column(name = "creator_id",length=50)
	public String getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}

	@Column(name = "creator", length = 10)
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	@Column(name = "createTime", length = 20)
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Column(name = "modifierId", length = 20)
	public String getModifierId() {
		return modifierId;
	}

	public void setModifierId(String modifierId) {
		this.modifierId = modifierId;
	}

	@Column(name = "modifier", length = 20)
	public String getModifier() {
		return modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	@Column(name = "updateTime", length = 20)
	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "info1", length = 20)
	public String getInfo1() {
		return info1;
	}

	public void setInfo1(String info1) {
		this.info1 = info1;
	}

	@Column(name = "info2", length = 20)
	public String getInfo2() {
		return info2;
	}

	public void setInfo2(String info2) {
		this.info2 = info2;
	}

	@Column(name = "info3", length = 20)
	public String getInfo3() {
		return info3;
	}

	public void setInfo3(String info3) {
		this.info3 = info3;
	}

	@Column(name = "info4", length = 20)
	public String getInfo4() {
		return info4;
	}

	public void setInfo4(String info4) {
		this.info4 = info4;
	}

	@Column(name = "info5", length = 20)
	public String getInfo5() {
		return info5;
	}

	public void setInfo5(String info5) {
		this.info5 = info5;
	}
	
}