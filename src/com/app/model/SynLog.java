package com.app.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name="syn_log")
public class SynLog implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4419201016980203708L;
	private String id;
	private String appId;//目标系统
	private String appName;
	private String synResult;//同步结果
	private String synTime;//同步时间
	private String synUserId;//操作人ID
	private String synUserName;//操作人
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
	@Column(name = "app_id", nullable = false, length = 32)
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	@Column(name = "syn_time", nullable = false, length = 50)
	public String getSynTime() {
		return synTime;
	}
	public void setSynTime(String synTime) {
		this.synTime = synTime;
	}
	@Column(name = "app_name", nullable = true, length = 100)
	public String getAppName() {
		return appName;
	}
	public void setAppName(String appName) {
		this.appName = appName;
	}
	@Column(name = "syn_result", nullable = false, length = 200)
	public String getSynResult() {
		return synResult;
	}
	public void setSynResult(String synResult) {
		this.synResult = synResult;
	}
	@Column(name = "syn_userid", nullable = false, length = 50)
	public String getSynUserId() {
		return synUserId;
	}
	public void setSynUserId(String synUserId) {
		this.synUserId = synUserId;
	}
	@Column(name = "syn_username", nullable = true, length = 100)
	public String getSynUserName() {
		return synUserName;
	}
	public void setSynUserName(String synUserName) {
		this.synUserName = synUserName;
	}
	
}
