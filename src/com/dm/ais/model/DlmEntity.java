package com.dm.ais.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "ais_dlm")
public class DlmEntity implements Serializable{

	private static final long serialVersionUID = -8563755302628963230L;
	/** 主键id */
	private String id;
	/** 基站id */
	private String siteInfoId;
	/** 
	 * 基站类型 <br>
	 * 1=A <br>
	 * 2=B <br>
	 */
	private String channelType;
	/** DataLinkForReservation<br>
	 * 对应A/B channel各有 1, 2, 3, 4 */
	private String Reservation;
	/** 
	 * 序列号 1-40 <br>
	 */
	private String seqNumber;
	/** 
	 * ownership string	(L,R,C)	<br>
	 * L=本地权限<br>
	 * R=远程权限<br>
	 * 如果字段设定为“C”，下面的四个字段将被设定为“null” */
	private String ownership;
	/** 启动时隙 0-2249*/
	private Integer startSlot;
	/** 时隙数目  0-5*/
	private Integer slotNumber;
	/** 超时 0-7 */
	private Integer timeout;
	/** 0到1125，2250mod增益=0 */
	private Integer increment;
	
	private String agreementid;
	
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
	
	@Column(name = "channel_type")
	public String getChannelType() {
		return channelType;
	}
	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	
	@Column(name = "Reservation")
	public String getReservation() {
		return Reservation;
	}
	public void setReservation(String reservation) {
		Reservation = reservation;
	}
	
	@Column(name = "seq_number")
	public String getSeqNumber() {
		return seqNumber;
	}
	public void setSeqNumber(String seqNumber) {
		this.seqNumber = seqNumber;
	}
	
	@Column(name = "owner_ship")
	public String getOwnership() {
		return ownership;
	}
	public void setOwnership(String ownership) {
		this.ownership = ownership;
	}
	
	@Column(name = "start_slot")
	public Integer getStartSlot() {
		return startSlot;
	}
	public void setStartSlot(Integer startSlot) {
		this.startSlot = startSlot;
	}
	
	@Column(name = "slot_number")
	public Integer getSlotNumber() {
		return slotNumber;
	}
	public void setSlotNumber(Integer slotNumber) {
		this.slotNumber = slotNumber;
	}
	
	@Column(name = "time_out")
	public Integer getTimeout() {
		return timeout;
	}
	public void setTimeout(Integer timeout) {
		this.timeout = timeout;
	}
	
	@Column(name = "increment")
	public Integer getIncrement() {
		return increment;
	}
	public void setIncrement(Integer increment) {
		this.increment = increment;
	}
	@Column(name = "agreementid")
	public String getAgreementid() {
		return agreementid;
	}
	public void setAgreementid(String agreementid) {
		this.agreementid = agreementid;
	}
	
}
