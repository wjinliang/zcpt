package com.dm.example.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "T_EXAMPLE")
public class ExampleEntity implements Serializable {

	/**
	 * CHENGJ
	 */
	private static final long serialVersionUID = -3894220609107521829L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(name = "NAME", length = 50)
	private String name;

	@Column(name = "password", length = 20)
	private String password;

	@Column(name = "textarea", length = 225)
	private String textarea;

	@Column(name = "checkbox", length = 225)
	private String checkbox;

	@Column(name = "radio", length = 32)
	private String radio;

	@Column(name = "selector", length = 32)
	private String selector;

	@Column(name = "datepicker", length = 32)
	private String datepicker;

	@Column(name = "node", length = 32)
	private String node;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTextarea() {
		return textarea;
	}

	public void setTextarea(String textarea) {
		this.textarea = textarea;
	}

	public String getCheckbox() {
		return checkbox;
	}

	public void setCheckbox(String checkbox) {
		this.checkbox = checkbox;
	}

	public String getRadio() {
		return radio;
	}

	public void setRadio(String radio) {
		this.radio = radio;
	}

	public String getSelector() {
		return selector;
	}

	public void setSelector(String selector) {
		this.selector = selector;
	}

	public String getDatepicker() {
		return datepicker;
	}

	public void setDatepicker(String datepicker) {
		this.datepicker = datepicker;
	}

	public String getNode() {
		return node;
	}

	public void setNode(String node) {
		this.node = node;
	}

	@Column(name = "CREATOR", length = 50)
	private String creator;

	@Column(name = "CREATETIME", length = 50)
	private String createTime;

	@Column(name = "MODIFIER", length = 50)
	private String modifier;

	@Column(name = "UPDATETIME", length = 50)
	private String updateTime;

	@Column(name = "VALIDFLAG", length = 5)
	private String validFlag;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getModifier() {
		return modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
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

}
