package com.dm.example.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="T_STUDENT")
public class StuEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5761592039656106511L;
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	
	@Column(name="STUNAME",length=50)
	private String stuname;
	
	@Column(name="password",length=20)
	private String password;
	
	@Column(name="hobbies",length=225)
	private String hobbies;
	
	@Column(name="address",length=100)
	private String address;
	
	@Column(name="sex",length=20)
	private String sex;
	
	@Column(name = "CREATOR", length = 50)
	private String creator;
	
	@Column(name="MODIFIER",length=50)
	private String modifier;
	
	@Column(name = "CREATETIME", length = 50)
	private String createTime;

	@Column(name = "UPDATETIME", length = 50)
	private String updateTime;

	@Column(name = "VALIDFLAG", length = 5)
	private String validFlag;
	
	@Column(name="selector",length=32)
	private String selector;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getStuname() {
		return stuname;
	}

	public void setStuname(String stuname) {
		this.stuname = stuname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getHobbies() {
		return hobbies;
	}

	public void setHobbies(String hobbies) {
		this.hobbies = hobbies;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getModifier() {
		return modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getValidFlag() {
		return validFlag;
	}

	public void setValidFlag(String validFlag) {
		this.validFlag = validFlag;
	}

	public String getSelector() {
		return selector;
	}

	public void setSelector(String selector) {
		this.selector = selector;
	}
	
}
