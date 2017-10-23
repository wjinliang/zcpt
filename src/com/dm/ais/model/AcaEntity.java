package com.dm.ais.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "ais_aca")
public class AcaEntity implements Serializable{

	private static final long serialVersionUID = 7541689249067171782L;
	/** 主键id */
	private String id;
	/** 基站id */
	private String siteInfoId;

	private String seqNumber;
	private String nelat;
	private String nelatType;
	private String nelon;
	private String nelonType;
	private String swlat;
	private String swlatType;
	private String swlon;
	private String swlonType;
	private Integer transitionZone;
	private Integer channelA;
	private Integer bandWidthForChA;
	private Integer channelB;
	private Integer bandWidthChB;
	private Integer trxMode;
	private Integer powerLevel;
	private String informationSource;
	private Integer inUseFlag;
	private String inUseChangeTime;
	
	@Id
	@GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Column(name = "site_info_id", unique = false, nullable = false, length = 32)
	public String getSiteInfoId() {
		return siteInfoId;
	}
	public void setSiteInfoId(String siteInfoId) {
		this.siteInfoId = siteInfoId;
	}
	
	@Column(name = "seq_number")
	public String getSeqNumber() {
		return seqNumber;
	}
	public void setSeqNumber(String seqNumber) {
		this.seqNumber = seqNumber;
	}
	
	@Column(name = "nelat")
	public String getNelat() {
		return nelat;
	}
	public void setNelat(String nelat) {
		this.nelat = nelat;
	}
	
	@Column(name = "nelat_type")
	public String getNelatType() {
		return nelatType;
	}
	public void setNelatType(String nelatType) {
		this.nelatType = nelatType;
	}
	
	@Column(name = "nelon")
	public String getNelon() {
		return nelon;
	}
	public void setNelon(String nelon) {
		this.nelon = nelon;
	}
	
	@Column(name = "nelon_type")
	public String getNelonType() {
		return nelonType;
	}
	public void setNelonType(String nelonType) {
		this.nelonType = nelonType;
	}
	
	@Column(name = "swlat")
	public String getSwlat() {
		return swlat;
	}
	public void setSwlat(String swlat) {
		this.swlat = swlat;
	}
	
	@Column(name = "swlat_type")
	public String getSwlatType() {
		return swlatType;
	}
	public void setSwlatType(String swlatType) {
		this.swlatType = swlatType;
	}
	
	@Column(name = "swlon")
	public String getSwlon() {
		return swlon;
	}
	public void setSwlon(String swlon) {
		this.swlon = swlon;
	}
	
	@Column(name = "swlon_type")
	public String getSwlonType() {
		return swlonType;
	}
	public void setSwlonType(String swlonType) {
		this.swlonType = swlonType;
	}
	
	@Column(name = "transition_zone")
	public Integer getTransitionZone() {
		return transitionZone;
	}
	public void setTransitionZone(Integer transitionZone) {
		this.transitionZone = transitionZone;
	}
	
	@Column(name = "channel_a")
	public Integer getChannelA() {
		return channelA;
	}
	public void setChannelA(Integer channelA) {
		this.channelA = channelA;
	}
	
	@Column(name = "band_width_for_cha")
	public Integer getBandWidthForChA() {
		return bandWidthForChA;
	}
	public void setBandWidthForChA(Integer bandWidthForChA) {
		this.bandWidthForChA = bandWidthForChA;
	}
	
	@Column(name = "channel_b")
	public Integer getChannelB() {
		return channelB;
	}
	public void setChannelB(Integer channelB) {
		this.channelB = channelB;
	}
	
	@Column(name = "band_width_chb")
	public Integer getBandWidthChB() {
		return bandWidthChB;
	}
	public void setBandWidthChB(Integer bandWidthChB) {
		this.bandWidthChB = bandWidthChB;
	}
	
	@Column(name = "trx_mode")
	public Integer getTrxMode() {
		return trxMode;
	}
	public void setTrxMode(Integer trxMode) {
		this.trxMode = trxMode;
	}
	
	@Column(name = "power_level")
	public Integer getPowerLevel() {
		return powerLevel;
	}
	public void setPowerLevel(Integer powerLevel) {
		this.powerLevel = powerLevel;
	}
	
	@Column(name = "information_source")
	public String getInformationSource() {
		return informationSource;
	}
	public void setInformationSource(String informationSource) {
		this.informationSource = informationSource;
	}
	
	@Column(name = "inUse_flag")
	public Integer getInUseFlag() {
		return inUseFlag;
	}
	public void setInUseFlag(Integer inUseFlag) {
		this.inUseFlag = inUseFlag;
	}
	
	@Column(name = "in_use_change_time")
	public String getInUseChangeTime() {
		return inUseChangeTime;
	}
	public void setInUseChangeTime(String inUseChangeTime) {
		this.inUseChangeTime = inUseChangeTime;
	}
	
}
