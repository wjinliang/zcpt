package com.dm.platform.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dm.platform.util.DmDateUtil;

@Entity
@Table(name = "T_DIVISION_BAK")
public class DivisionBak implements Serializable {
	private static final long serialVersionUID = -7414938471167391613L;

	private String id;

	private String name;

	private String code;

	private Long seq;

	private Integer level;

	private String parent;

	private String createTime;

	private String fullName;

	private String type;

	private String bigDivision;

	private String deleteUser;
	private String deleteDate;

	public DivisionBak() {

	}

	public DivisionBak(Division division, UserAccount currentUser) {
		this.bigDivision = division.getBigDivision();
		this.code = division.getCode();
		this.createTime = division.getCreateTime();
		this.deleteDate = DmDateUtil.Current();
		this.deleteUser = currentUser.getCode();
		this.fullName = division.getFullName();
		this.id = division.getId();
		this.level = division.getLevel();
		this.name = division.getName();
		this.parent = division.getParent() == null ? null : division
				.getParent().getId();
		this.seq = division.getSeq();
		this.type = division.getType();
	}

	
	@Column(name="delete_user")
	public String getDeleteUser() {
		return deleteUser;
	}

	public void setDeleteUser(String deleteUser) {
		this.deleteUser = deleteUser;
	}
	@Column(name="delete_date")
	public String getDeleteDate() {
		return deleteDate;
	}

	public void setDeleteDate(String deleteDate) {
		this.deleteDate = deleteDate;
	}

	@Id
	@Column(name = "id", unique = true, nullable = false, length = 32)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "NAME", nullable = false, length = 100)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "parent_id")
	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	@Column(name = "CODE", nullable = false, length = 10)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "SEQ", nullable = false)
	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}

	@Column(name = "level", nullable = false)
	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	@Column(name = "CREATETIME", nullable = false)
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Column(name = "FULLNAME", nullable = false)
	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	@Column(name = "TYPE", nullable = false)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "BIGDIVISION", nullable = false)
	public String getBigDivision() {
		return bigDivision;
	}

	public void setBigDivision(String bigDivision) {
		this.bigDivision = bigDivision;
	}

	@Override
	public boolean equals(Object obj) {
		DivisionBak s = (DivisionBak) obj;
		return id.equals(s.id);
	}

	@Override
	public int hashCode() {
		String in = id;
		return in.hashCode();
	}
}
