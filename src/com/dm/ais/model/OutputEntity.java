package com.dm.ais.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "ais_output")
public class OutputEntity implements Serializable{

	private static final long serialVersionUID = -3567472951186152358L;
	
	/** 主键id */
	private String id;
	/** 基站id */
	private String siteInfoId;
	/** 唯一识别码 */
	private String uid;
	/** 
	 * 输出类型<br>
	 * 1=VSI语句的输出<br>
	 * 2=FSR语句的输出<br>
	 *  */
	private String outputType;
	/** channel	string	(A,B,E,N)<br>
	 * A=频道A（Enable VSI/FSR Sentences About Channel A）<br>
	 * B=频道B（Enable VSI/FSR Sentences About Channel B）<br>
	 * E=每个频道（Enable VSI/FSR Sentences About Every Channel）<br>
	 * N=对任何频道都没有VSI或者FSR语句（No VSI or FSR Sentences About Any Channel */
	private String channel;
	/** signalStrength	Int	0-2	<br>
	 * 0=无输出<br>
	 * 1=连续输出<br>
	 * 2=仅下一帧输出 */
	private Integer signalStrength;
	/** firstSlotNum	Int	0-2	<br>
	 * 0=无输出<br>
	 * 1=连续输出<br>
	 * 2=仅下一帧输出 */
	private Integer firstSlotNum;
	/** msgArriveTime	Int	0-2	<br>
	 * 0=无输出<br>
	 * 1=连续输出<br>
	 * 2=仅下一帧输出 */
	private Integer msgArriveTime;
	/** signalNoiseRatio	Int	0-2	<br>
	 * 0=无输出<br>
	 * 1=连续输出<br>
	 * 2=仅下一帧输出 */
	private Integer signalNoiseRatio;
	/** channelLoad	Int	0-2	<br>
	 * 0=无输出<br>
	 * 1=每一帧输出一次<br>
	 * 2=仅下一帧输出 */
	private Integer channelLoad;
	/** badCRCMsgNum	Int	0-2	<br>
	 * 0=无输出<br>
	 * 1=每一帧输出一次<br>
	 * 2=仅下一帧输出 */
	private Integer badCRCMsgNum;
	/** forecastChannelLoad	Int	0-2	<br>
	 * 0=无输出<br>
	 * 1=每一帧输出一次<br>
	 * 2=仅下一帧输出 */
	private Integer forecastChannelLoad;
	/** avarageNoiseLevel	Int	0-2	<br>
	 * 0=无输出<br>
	 * 1=每一帧输出一次<br>
	 * 2=仅下一帧输出 */
	private Integer avarageNoiseLevel;
	/** signalStrength	Int	0-2	<br>
	 * 0=无输出<br>
	 * 1=每一帧输出一次<br>
	 * 2=仅下一帧输出 */
	private Integer receivedSignalStrength;
	/** vdmSentence	Int	0-1	<br>
	 * 0=关闭，不可用；<br>
	 * 1=开启，可用 */
	private Integer vdmSentence;
	/** vdoSentence	Int	0-1	<br>
	 * 0=关闭，不可用；<br>
	 * 1=开启，可用 */
	private Integer vdoSentence;
	/** fsrSentenceOfAfterFrame	Int	0-1	<br>
	 * 0=关闭，不可用；<br>
	 * 1=开启，可用 */
	private Integer fsrSentenceOfAfterFrame;
	/** 
	 * 状态status用于判断是保存还是设置的状态位<br>
	 * 0=保存<br>
	 * 1=设置<br>
	 * 注意：此值并没有保存到数据库当中，只是一个中间值
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
	@Column(name = "site_info_id", unique = false, nullable = false, length = 32)
	public String getSiteInfoId() {
		return siteInfoId;
	}
	public void setSiteInfoId(String siteInfoId) {
		this.siteInfoId = siteInfoId;
	}
	@Column(name = "u_id", length = 15)
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	@Column(name = "output_type")
	public String getOutputType() {
		return outputType;
	}
	public void setOutputType(String outputType) {
		this.outputType = outputType;
	}
	@Column(name = "channel", length = 10)
	public String getChannel() {
		return channel;
	}
	public void setChannel(String channel) {
		this.channel = channel;
	}
	@Column(name = "signal_strength")
	public Integer getSignalStrength() {
		return signalStrength;
	}
	public void setSignalStrength(Integer signalStrength) {
		this.signalStrength = signalStrength;
	}
	@Column(name = "first_slot_num")
	public Integer getFirstSlotNum() {
		return firstSlotNum;
	}
	public void setFirstSlotNum(Integer firstSlotNum) {
		this.firstSlotNum = firstSlotNum;
	}
	@Column(name = "msg_arrive_time")
	public Integer getMsgArriveTime() {
		return msgArriveTime;
	}
	public void setMsgArriveTime(Integer msgArriveTime) {
		this.msgArriveTime = msgArriveTime;
	}
	@Column(name = "signal_noise_ratio")
	public Integer getSignalNoiseRatio() {
		return signalNoiseRatio;
	}
	public void setSignalNoiseRatio(Integer signalNoiseRatio) {
		this.signalNoiseRatio = signalNoiseRatio;
	}
	@Column(name = "channel_load")
	public Integer getChannelLoad() {
		return channelLoad;
	}
	public void setChannelLoad(Integer channelLoad) {
		this.channelLoad = channelLoad;
	}
	@Column(name = "bad_crc_msg_num")
	public Integer getBadCRCMsgNum() {
		return badCRCMsgNum;
	}
	public void setBadCRCMsgNum(Integer badCRCMsgNum) {
		this.badCRCMsgNum = badCRCMsgNum;
	}
	@Column(name = "forecast_channel_load")
	public Integer getForecastChannelLoad() {
		return forecastChannelLoad;
	}
	public void setForecastChannelLoad(Integer forecastChannelLoad) {
		this.forecastChannelLoad = forecastChannelLoad;
	}
	@Column(name = "avarage_noise_level")
	public Integer getAvarageNoiseLevel() {
		return avarageNoiseLevel;
	}
	public void setAvarageNoiseLevel(Integer avarageNoiseLevel) {
		this.avarageNoiseLevel = avarageNoiseLevel;
	}
	@Column(name = "received_signal_strength")
	public Integer getReceivedSignalStrength() {
		return receivedSignalStrength;
	}
	public void setReceivedSignalStrength(Integer receivedSignalStrength) {
		this.receivedSignalStrength = receivedSignalStrength;
	}
	@Column(name = "vdm_sentence")
	public Integer getVdmSentence() {
		return vdmSentence;
	}
	public void setVdmSentence(Integer vdmSentence) {
		this.vdmSentence = vdmSentence;
	}
	@Column(name = "vdo_sentence")
	public Integer getVdoSentence() {
		return vdoSentence;
	}
	public void setVdoSentence(Integer vdoSentence) {
		this.vdoSentence = vdoSentence;
	}
	@Column(name = "fsr_sentence_of_after_frame")
	public Integer getFsrSentenceOfAfterFrame() {
		return fsrSentenceOfAfterFrame;
	}
	public void setFsrSentenceOfAfterFrame(Integer fsrSentenceOfAfterFrame) {
		this.fsrSentenceOfAfterFrame = fsrSentenceOfAfterFrame;
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
