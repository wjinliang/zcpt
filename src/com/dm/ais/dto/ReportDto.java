package com.dm.ais.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
/**
 * @author yinhui
 *
 */
public class ReportDto implements Serializable{

	private static final long serialVersionUID = 3515211265531976238L;
	
	private String agreementid;
	
	/** 4号报文 */
	private String id4;
	private String uid4;
	private String msgId4;
	private String siteInfoId4;
	private String msgType4;
	private Integer chAutcMinute4;
	private Integer chASlot4;
	private Integer chAIncrement4;
	private Integer chButcMinute4;
	private Integer chBSlot4;
	private Integer chBIncrement4;
	
	/** 17号报文 */
	private String id17;
	private String uid17;
	private String msgId17;
	private String siteInfoId17;
	private String msgType17;
	private Integer chAutcMinute17;
	private Integer chASlot17;
	private Integer chAIncrement17;
	private Integer chASlotsNum17;
	private Integer chButcMinute17;
	private Integer chBSlot17;
	private Integer chBIncrement17;
	private Integer chBSlotsNum17;
	
	/** 20号报文 */
	private String id20;
	private String uid20;
	private String msgId20;
	private String siteInfoId20;
	private String msgType20;
	private Integer chAutcMinute20;
	private Integer chASlot20;
	private Integer chAIncrement20;
	private Integer chButcMinute20;
	private Integer chBSlot20;
	private Integer chBIncrement20;
	
	/** 22号报文 */
	private String id22;
	private String uid22;
	private String msgId22;
	private String siteInfoId22;
	private String msgType22;
	private Integer chAutcMinute22;
	private Integer chASlot22;
	private Integer chAIncrement22;
	private Integer chButcMinute22;
	private Integer chBSlot22;
	private Integer chBIncrement22;
	
	/** 23号报文 */
	private String id23;
	private String uid23;
	private String msgId23;
	private String siteInfoId23;
	private String msgType23;
	private Integer chAutcMinute23;
	private Integer chASlot23;
	private Integer chAIncrement23;
	private Integer chButcMinute23;
	private Integer chBSlot23;
	private Integer chBIncrement23;

	public String getId4() {
		return id4;
	}
	public void setId4(String id4) {
		this.id4 = id4;
	}
	public String getId17() {
		return id17;
	}
	public void setId17(String id17) {
		this.id17 = id17;
	}
	public String getId20() {
		return id20;
	}
	public void setId20(String id20) {
		this.id20 = id20;
	}
	public String getId22() {
		return id22;
	}
	public void setId22(String id22) {
		this.id22 = id22;
	}
	public String getId23() {
		return id23;
	}
	public void setId23(String id23) {
		this.id23 = id23;
	}
	public String getUid4() {
		return uid4;
	}
	public void setUid4(String uid4) {
		this.uid4 = uid4;
	}
	public String getMsgId4() {
		return msgId4;
	}
	public void setMsgId4(String msgId4) {
		this.msgId4 = msgId4;
	}
	public String getSiteInfoId4() {
		return siteInfoId4;
	}
	public void setSiteInfoId4(String siteInfoId4) {
		this.siteInfoId4 = siteInfoId4;
	}
	public String getMsgType4() {
		return msgType4;
	}
	public void setMsgType4(String msgType4) {
		this.msgType4 = msgType4;
	}
	public Integer getChAutcMinute4() {
		return chAutcMinute4;
	}
	public void setChAutcMinute4(Integer chAutcMinute4) {
		this.chAutcMinute4 = chAutcMinute4;
	}
	public Integer getChASlot4() {
		return chASlot4;
	}
	public void setChASlot4(Integer chASlot4) {
		this.chASlot4 = chASlot4;
	}
	public Integer getChAIncrement4() {
		return chAIncrement4;
	}
	public void setChAIncrement4(Integer chAIncrement4) {
		this.chAIncrement4 = chAIncrement4;
	}
	public Integer getChButcMinute4() {
		return chButcMinute4;
	}
	public void setChButcMinute4(Integer chButcMinute4) {
		this.chButcMinute4 = chButcMinute4;
	}
	public Integer getChBSlot4() {
		return chBSlot4;
	}
	public void setChBSlot4(Integer chBSlot4) {
		this.chBSlot4 = chBSlot4;
	}
	public Integer getChBIncrement4() {
		return chBIncrement4;
	}
	public void setChBIncrement4(Integer chBIncrement4) {
		this.chBIncrement4 = chBIncrement4;
	}
	public String getUid17() {
		return uid17;
	}
	public void setUid17(String uid17) {
		this.uid17 = uid17;
	}
	public String getMsgId17() {
		return msgId17;
	}
	public void setMsgId17(String msgId17) {
		this.msgId17 = msgId17;
	}
	public String getSiteInfoId17() {
		return siteInfoId17;
	}
	public void setSiteInfoId17(String siteInfoId17) {
		this.siteInfoId17 = siteInfoId17;
	}
	public String getMsgType17() {
		return msgType17;
	}
	public void setMsgType17(String msgType17) {
		this.msgType17 = msgType17;
	}
	public Integer getChAutcMinute17() {
		return chAutcMinute17;
	}
	public void setChAutcMinute17(Integer chAutcMinute17) {
		this.chAutcMinute17 = chAutcMinute17;
	}
	public Integer getChASlot17() {
		return chASlot17;
	}
	public void setChASlot17(Integer chASlot17) {
		this.chASlot17 = chASlot17;
	}
	public Integer getChAIncrement17() {
		return chAIncrement17;
	}
	public void setChAIncrement17(Integer chAIncrement17) {
		this.chAIncrement17 = chAIncrement17;
	}
	public Integer getChASlotsNum17() {
		return chASlotsNum17;
	}
	public void setChASlotsNum17(Integer chASlotsNum17) {
		this.chASlotsNum17 = chASlotsNum17;
	}
	public Integer getChButcMinute17() {
		return chButcMinute17;
	}
	public void setChButcMinute17(Integer chButcMinute17) {
		this.chButcMinute17 = chButcMinute17;
	}
	public Integer getChBSlot17() {
		return chBSlot17;
	}
	public void setChBSlot17(Integer chBSlot17) {
		this.chBSlot17 = chBSlot17;
	}
	public Integer getChBIncrement17() {
		return chBIncrement17;
	}
	public void setChBIncrement17(Integer chBIncrement17) {
		this.chBIncrement17 = chBIncrement17;
	}
	public Integer getChBSlotsNum17() {
		return chBSlotsNum17;
	}
	public void setChBSlotsNum17(Integer chBSlotsNum17) {
		this.chBSlotsNum17 = chBSlotsNum17;
	}
	public String getUid20() {
		return uid20;
	}
	public void setUid20(String uid20) {
		this.uid20 = uid20;
	}
	public String getMsgId20() {
		return msgId20;
	}
	public void setMsgId20(String msgId20) {
		this.msgId20 = msgId20;
	}
	public String getSiteInfoId20() {
		return siteInfoId20;
	}
	public void setSiteInfoId20(String siteInfoId20) {
		this.siteInfoId20 = siteInfoId20;
	}
	public String getMsgType20() {
		return msgType20;
	}
	public void setMsgType20(String msgType20) {
		this.msgType20 = msgType20;
	}
	public Integer getChAutcMinute20() {
		return chAutcMinute20;
	}
	public void setChAutcMinute20(Integer chAutcMinute20) {
		this.chAutcMinute20 = chAutcMinute20;
	}
	public Integer getChASlot20() {
		return chASlot20;
	}
	public void setChASlot20(Integer chASlot20) {
		this.chASlot20 = chASlot20;
	}
	public Integer getChAIncrement20() {
		return chAIncrement20;
	}
	public void setChAIncrement20(Integer chAIncrement20) {
		this.chAIncrement20 = chAIncrement20;
	}
	public Integer getChButcMinute20() {
		return chButcMinute20;
	}
	public void setChButcMinute20(Integer chButcMinute20) {
		this.chButcMinute20 = chButcMinute20;
	}
	public Integer getChBSlot20() {
		return chBSlot20;
	}
	public void setChBSlot20(Integer chBSlot20) {
		this.chBSlot20 = chBSlot20;
	}
	public Integer getChBIncrement20() {
		return chBIncrement20;
	}
	public void setChBIncrement20(Integer chBIncrement20) {
		this.chBIncrement20 = chBIncrement20;
	}
	public String getUid22() {
		return uid22;
	}
	public void setUid22(String uid22) {
		this.uid22 = uid22;
	}
	public String getMsgId22() {
		return msgId22;
	}
	public void setMsgId22(String msgId22) {
		this.msgId22 = msgId22;
	}
	public String getSiteInfoId22() {
		return siteInfoId22;
	}
	public void setSiteInfoId22(String siteInfoId22) {
		this.siteInfoId22 = siteInfoId22;
	}
	public String getMsgType22() {
		return msgType22;
	}
	public void setMsgType22(String msgType22) {
		this.msgType22 = msgType22;
	}
	public Integer getChAutcMinute22() {
		return chAutcMinute22;
	}
	public void setChAutcMinute22(Integer chAutcMinute22) {
		this.chAutcMinute22 = chAutcMinute22;
	}
	public Integer getChASlot22() {
		return chASlot22;
	}
	public void setChASlot22(Integer chASlot22) {
		this.chASlot22 = chASlot22;
	}
	public Integer getChAIncrement22() {
		return chAIncrement22;
	}
	public void setChAIncrement22(Integer chAIncrement22) {
		this.chAIncrement22 = chAIncrement22;
	}
	public Integer getChButcMinute22() {
		return chButcMinute22;
	}
	public void setChButcMinute22(Integer chButcMinute22) {
		this.chButcMinute22 = chButcMinute22;
	}
	public Integer getChBSlot22() {
		return chBSlot22;
	}
	public void setChBSlot22(Integer chBSlot22) {
		this.chBSlot22 = chBSlot22;
	}
	public Integer getChBIncrement22() {
		return chBIncrement22;
	}
	public void setChBIncrement22(Integer chBIncrement22) {
		this.chBIncrement22 = chBIncrement22;
	}
	public String getUid23() {
		return uid23;
	}
	public void setUid23(String uid23) {
		this.uid23 = uid23;
	}
	public String getMsgId23() {
		return msgId23;
	}
	public void setMsgId23(String msgId23) {
		this.msgId23 = msgId23;
	}
	public String getSiteInfoId23() {
		return siteInfoId23;
	}
	public void setSiteInfoId23(String siteInfoId23) {
		this.siteInfoId23 = siteInfoId23;
	}
	public String getMsgType23() {
		return msgType23;
	}
	public void setMsgType23(String msgType23) {
		this.msgType23 = msgType23;
	}
	public Integer getChAutcMinute23() {
		return chAutcMinute23;
	}
	public void setChAutcMinute23(Integer chAutcMinute23) {
		this.chAutcMinute23 = chAutcMinute23;
	}
	public Integer getChASlot23() {
		return chASlot23;
	}
	public void setChASlot23(Integer chASlot23) {
		this.chASlot23 = chASlot23;
	}
	public Integer getChAIncrement23() {
		return chAIncrement23;
	}
	public void setChAIncrement23(Integer chAIncrement23) {
		this.chAIncrement23 = chAIncrement23;
	}
	public Integer getChButcMinute23() {
		return chButcMinute23;
	}
	public void setChButcMinute23(Integer chButcMinute23) {
		this.chButcMinute23 = chButcMinute23;
	}
	public Integer getChBSlot23() {
		return chBSlot23;
	}
	public void setChBSlot23(Integer chBSlot23) {
		this.chBSlot23 = chBSlot23;
	}
	public Integer getChBIncrement23() {
		return chBIncrement23;
	}
	public void setChBIncrement23(Integer chBIncrement23) {
		this.chBIncrement23 = chBIncrement23;
	}
	public String getAgreementid() {
		return agreementid;
	}
	public void setAgreementid(String agreementid) {
		this.agreementid = agreementid;
	}
	
}
