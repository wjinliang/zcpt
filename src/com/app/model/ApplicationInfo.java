package com.app.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name="app_applicationinfo")
public class ApplicationInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5944154778495149035L;
	
	private String id;
	private String appName;//系统名称
	private String appCode;//系统编号（唯一）
	private String appPath;//系统单点地址 默认 (联通)
	private String appPath1;//系统单点地址 (电信)
	private String synType;//系统同步类型（axis1、axis2、http）
	private String packageName;//命名空间
	private String synPath;//系统同步地址 (联通)
	private String synPath1;//系统同步地址(电信)//20170208
	private String status;//系统状态
	private String opLevel;//同步操作级别（部、省、市、县...）
	private String userLevel;//同步用户级别（部、省、市、县...）
	private String description;//系统描述status
	private String paramName;
	
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
	@Column(name = "app_name", nullable = false, length = 100)
	public String getAppName() {
		return appName;
	}
	public void setAppName(String appName) {
		this.appName = appName;
	}
	@Column(name = "app_code", nullable = false, length = 100)
	public String getAppCode() {
		return appCode;
	}
	public void setAppCode(String appCode) {
		this.appCode = appCode;
	}
	@Column(name = "app_path", nullable = false, length = 200)
	public String getAppPath() {
		return appPath;
	}
	public void setAppPath(String appPath) {
		this.appPath = appPath;
	}
	@Column(name = "syn_type", nullable = false, length = 10)
	public String getSynType() {
		return synType;
	}
	public void setSynType(String synType) {
		this.synType = synType;
	}
	@Column(name = "syn_path",  nullable = false, length = 200)
	public String getSynPath() {
		return synPath;
	}
	public void setSynPath(String synPath) {
		this.synPath = synPath;
	}
	@Column(name = "syn_path1",  nullable = true, length = 200)
	public String getSynPath1() {
		return synPath1;
	}
	public void setSynPath1(String synPath1) {
		this.synPath1 = synPath1;
	}
	@Column(name = "description", nullable = true, length = 500)
	public String getDescription() {
		return description;
	}
	@Column(name = "param_name", nullable = true, length = 20)
	public String getParamName() {
		return paramName;
	}
	public void setParamName(String paramName) {
		this.paramName = paramName;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Column(name = "packagename", nullable = true, length = 100)
	public String getPackageName() {
		return packageName;
	}
	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	@Column(name = "status", nullable = true, length = 2)
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Column(name = "op_level", nullable = true, length = 2)
	public String getOpLevel() {
		return opLevel;
	}
	public void setOpLevel(String opLevel) {
		this.opLevel = opLevel;
	}
	@Column(name = "user_level", nullable = true, length = 2)
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	@Column(name = "app_path1", nullable = true, length = 200)
	public String getAppPath1() {
		return appPath1;
	}
	public void setAppPath1(String appPath1) {
		this.appPath1 = appPath1;
	}
	
}
