package com.dm.ais.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "ais_setting")
public class SettingEntity implements Serializable{

	private static final long serialVersionUID = 376025683340210780L;

	/** 主键id */
	private String id;
	/** 基站id */
	private String siteInfoId;
	/** mmsi	Mmsi	Int	9位	0 - 999999999 */
	private String mmsi;
	/** UID */
	private String uid;
	/** positionSource	位置源	Int	0-6	</br>
	 * 0=测量位置（应一直用于固定AIS基站）</br>
	 * 1=内部EPFS使用</br>
	 * 2=外部EPFS使用</br>
	 * 3=内部EPFS使用自动退回到测量位置</br>
	 * 4=内部EPFS使用，当内部EPFS失败时，自动退回到外部EPFS</br> 
	 * 5=外部EPFS使用自动退回到测量位置</br>
	 * 6=外部EPFS使用，当外部位置源失败时，自动退回到内部位置源
	 */
	private Integer positionSource;
	/** 基站纬度  XXXX.XXXX */
	private String lat;
	/** latType	纬度标识 </br>
	 * N=北纬</br>
	 * S=南纬 </br>
	 */
	private String latType;
	/** 基站经度  XXXX.XXXX */
	private String lon;
	/** lonType 经度标识	</br>
	 * E=东经</br>
	 * W=西经 
	 */
	private String lonType;
	/** 位置精确度	</br>	
	 * 0=低＞10米；</br>
	 * 1=高＜10米
	 */
	private Integer highAccuracy;
	/** Rx频道A 1001 - 2287 */
	private Integer rxChannelA;
	/** Rx频道B 1001 - 2287 */
	private Integer rxChannelB;
	/** Tx频道A 1001 - 2287 */
	private Integer txChannelA;
	/** Tx频道B 1001 - 2287 */
	private Integer txChannelB;
	/** A频道功率</br>
	 * 0=高功率（额定为12.5W）</br>
	 * 1=低功率（额定为2W） 
	 */
	private Integer highPowerA;
	/** B频道功率	</br>
	 * 0=高功率（额定为12.5W）</br>
	 * 1=低功率（额定为2W）
	 */
	private Integer highPowerB;
	/** 报文重试	Int	0-3	需要设置的报文重试次数 */
	private Integer retriesNumber;
	/** 重复指示	Int	0-3	需要设置的报文重试指示次数 */
	private Integer repeatIndicator;
	/** 基站对话ID	 (AB,AL,AS,AD,AR)	</br>
	 * AB=AIS基站（默认值）</br>
	 * AL=受限AIS基站</br>
	 * AS=单一中继站</br>
	 * AD=双重中继站</br>
	 * AR=接收站 */
	private String talkerID;
	/** 
	 * 状态status用于判断是保存还是设置的状态位<br>
	 * 0=保存<br>
	 * 1=设置
	 */
	private String status;
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
	@Column(name = "site_info_id", unique = true, nullable = false, length = 32)
	public String getSiteInfoId() {
		return siteInfoId;
	}
	public void setSiteInfoId(String siteInfoId) {
		this.siteInfoId = siteInfoId;
	}
	@Column(name = "mmsi", length=9)
	public String getMmsi() {
		return mmsi;
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
	@Column(name = "position_source")
	public Integer getPositionSource() {
		return positionSource;
	}
	public void setPositionSource(Integer positionSource) {
		this.positionSource = positionSource;
	}
	@Column(name = "lat",length=10)
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	@Column(name = "lat_type",length=10)
	public String getLatType() {
		return latType;
	}
	public void setLatType(String latType) {
		this.latType = latType;
	}
	@Column(name = "lon",length=10)
	public String getLon() {
		return lon;
	}
	public void setLon(String lon) {
		this.lon = lon;
	}
	@Column(name = "lon_type")
	public String getLonType() {
		return lonType;
	}
	public void setLonType(String lonType) {
		this.lonType = lonType;
	}
	@Column(name = "high_accuracy")
	public Integer getHighAccuracy() {
		return highAccuracy;
	}
	public void setHighAccuracy(Integer highAccuracy) {
		this.highAccuracy = highAccuracy;
	}
	@Column(name = "rx_channel_a")
	public Integer getRxChannelA() {
		return rxChannelA;
	}
	public void setRxChannelA(Integer rxChannelA) {
		this.rxChannelA = rxChannelA;
	}
	@Column(name = "rx_channel_b")
	public Integer getRxChannelB() {
		return rxChannelB;
	}
	public void setRxChannelB(Integer rxChannelB) {
		this.rxChannelB = rxChannelB;
	}
	@Column(name = "tx_channel_a")
	public Integer getTxChannelA() {
		return txChannelA;
	}
	public void setTxChannelA(Integer txChannelA) {
		this.txChannelA = txChannelA;
	}
	@Column(name = "tx_channel_b")
	public Integer getTxChannelB() {
		return txChannelB;
	}
	public void setTxChannelB(Integer txChannelB) {
		this.txChannelB = txChannelB;
	}
	@Column(name = "high_power_a")
	public Integer getHighPowerA() {
		return highPowerA;
	}
	public void setHighPowerA(Integer highPowerA) {
		this.highPowerA = highPowerA;
	}
	@Column(name = "high_power_b")
	public Integer getHighPowerB() {
		return highPowerB;
	}
	public void setHighPowerB(Integer highPowerB) {
		this.highPowerB = highPowerB;
	}
	@Column(name = "retries_number")
	public Integer getRetriesNumber() {
		return retriesNumber;
	}
	public void setRetriesNumber(Integer retriesNumber) {
		this.retriesNumber = retriesNumber;
	}
	@Column(name = "repeat_indicator")
	public Integer getRepeatIndicator() {
		return repeatIndicator;
	}
	public void setRepeatIndicator(Integer repeatIndicator) {
		this.repeatIndicator = repeatIndicator;
	}
	@Column(name = "talker_id",length=10)
	public String getTalkerID() {
		return talkerID;
	}
	public void setTalkerID(String talkerID) {
		this.talkerID = talkerID;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Column(name = "agreementid")
	public String getAgreementid() {
		return agreementid;
	}
	public void setAgreementid(String agreementid) {
		this.agreementid = agreementid;
	}
	
}
