package com.dm.ais.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
/**
 * @author Zero
 *
 */
@Entity
@Table(name = "ais_report")
public class ReportEntity implements Serializable{

	private static final long serialVersionUID = -1065871229798120529L;
	/** 主键id */
	private String id;
	/** 基站id */
	private String siteInfoId;
	/** 报文的播报频率类型
	 * 1=4号报文的播报频率
	 * 2=17号报文的播报频率
	 * 3=20号报文的播报频率
	 * 4=22号报文的播报频率
	 * 5=23号报文的播报频率
	 */
	private String reportRatesForMsgType;
	/** 唯一识别码 */
	private String uid;
	/** 报文ID 
	 * (4、17、20、22、23)
	 *  */
	private Integer msgId;
	/** chAutcMinute 频道A启动时隙的UTC记录
	 * Int	0-59	
	 * 除了报文4是固定值0以外，其他取值为0 – 59。
	 */
	private Integer chAutcMinute;
	/** chASlot	频道A启动时隙 Int 0-2249	
	 * 报文4，启动时隙范围0 - 749,报文17、20、22、23,启动时隙范围0 – 2249，-1 =关闭传输 
	 */
	private Integer chASlot;
	/** chAIncrement	频道A时隙间隔 Int 0-13500
	 * 除了报文4是固定值750以外，其他取值为0到13500的 
	 */
	private Integer chAIncrement;
	/** chASlotsNum	频道A时隙数目 Int 1-4  
	 * 除了报文17以外，这字段符为“null”。报文17的取值范围为1 - 4
	 */
	private Integer chASlotsNum;
	/** chButcMinute 频道B启动时隙的UTC记录 Int 0-59
	 * 除了报文4是固定值0以外，其他取值为0 – 59。 */
	private Integer chButcMinute;
	/** chBSlot	频道B启动时隙	Int	0-2249	
	 * 报文4，启动时隙为固定值-1，报文17、20、22、23的启动时隙范围0 – 2249。 
	 */
	private Integer chBSlot;
	/** chBIncrement	频道B时隙间隔	Int	0-13500	
	 * 除了报文4是固定值750以外，
	 * 其他取值为0到13500的下拉选项框 */
	private Integer chBIncrement;
	/** chBSlotsNum	频道B时隙数目	Int	1-4	
	 * 除了报文17以外，这字段符为“null”。报文17的取值范围为1 - 4 */
	private Integer chBSlotsNum;
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
	@Column(name = "report_rates_for_msg_type")
	public String getReportRatesForMsgType() {
		return reportRatesForMsgType;
	}
	public void setReportRatesForMsgType(String reportRatesForMsgType) {
		this.reportRatesForMsgType = reportRatesForMsgType;
	}
	@Column(name = "u_id", length = 15)
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	@Column(name = "msg_id")
	public Integer getMsgId() {
		return msgId;
	}
	public void setMsgId(Integer msgId) {
		this.msgId = msgId;
	}
	@Column(name = "ch_a_utc_minute")
	public Integer getChAutcMinute() {
		return chAutcMinute;
	}
	public void setChAutcMinute(Integer chAutcMinute) {
		this.chAutcMinute = chAutcMinute;
	}
	@Column(name = "ch_a_slot")
	public Integer getChASlot() {
		return chASlot;
	}
	public void setChASlot(Integer chASlot) {
		this.chASlot = chASlot;
	}
	@Column(name = "ch_a_increment")
	public Integer getChAIncrement() {
		return chAIncrement;
	}
	public void setChAIncrement(Integer chAIncrement) {
		this.chAIncrement = chAIncrement;
	}
	@Column(name = "ch_a_slots_num")
	public Integer getChASlotsNum() {
		return chASlotsNum;
	}
	public void setChASlotsNum(Integer chASlotsNum) {
		this.chASlotsNum = chASlotsNum;
	}
	@Column(name = "ch_b_utc_minute")
	public Integer getChButcMinute() {
		return chButcMinute;
	}
	public void setChButcMinute(Integer chButcMinute) {
		this.chButcMinute = chButcMinute;
	}
	@Column(name = "ch_b_slot")
	public Integer getChBSlot() {
		return chBSlot;
	}
	public void setChBSlot(Integer chBSlot) {
		this.chBSlot = chBSlot;
	}
	@Column(name = "ch_b_increment")
	public Integer getChBIncrement() {
		return chBIncrement;
	}
	public void setChBIncrement(Integer chBIncrement) {
		this.chBIncrement = chBIncrement;
	}
	@Column(name = "ch_b_slots_num")
	public Integer getChBSlotsNum() {
		return chBSlotsNum;
	}
	public void setChBSlotsNum(Integer chBSlotsNum) {
		this.chBSlotsNum = chBSlotsNum;
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
