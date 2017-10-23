package com.dm.platform.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name = "T_MESSAGE")
public class Message implements Serializable{

	/**
	 * CHENGJ
	 * 消息表
	 */
	private static final long serialVersionUID = 620481978274879456L;
	
	private String messageId;//站内信id
	private String messageSubject;//主题
	private String messageContent;//内容
	private String messageLink;//快捷链接
	private String messageFromUserId;//发件人id
	private String messageDate;//发送时间
	private String hasAttach;//是否有附件
	private String to;//接收人字符串
	private String from;//发送人字符串
	
	@Id
	@Column(name="MESSAGE_ID",length=32)
	public String getMessageId() {
		return messageId;
	}
	public void setMessageId(String messageId) {
		this.messageId = messageId;
	}
	@Column(name="MESSAGE_SUBJECT",length=400)
	public String getMessageSubject() {
		return messageSubject;
	}
	public void setMessageSubject(String messageSubject) {
		this.messageSubject = messageSubject;
	}
	@Lob
	@Column(name="MESSAGE_CONTENT")
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	@Column(name="MESSAGE_LINK",length=400)
	public String getMessageLink() {
		return messageLink;
	}
	public void setMessageLink(String messageLink) {
		this.messageLink = messageLink;
	}
	@Column(name="MESSAGE_FROM_USER_ID",length=32)
	public String getMessageFromUserId() {
		return messageFromUserId;
	}
	public void setMessageFromUserId(String messageFromUserId) {
		this.messageFromUserId = messageFromUserId;
	}
	@Column(name="MESSAGE_DATE",length=20)
	public String getMessageDate() {
		return messageDate;
	}
	public void setMessageDate(String messageDate) {
		this.messageDate = messageDate;
	}
	@Column(name="HAS_ATTACH",length=2)
	public String getHasAttach() {
		return hasAttach;
	}
	public void setHasAttach(String hasAttach) {
		this.hasAttach = hasAttach;
	}
	@Lob
	@Column(name="TO_STR")
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	@Column(name="FROM_STR",length=200)
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	
	
}
