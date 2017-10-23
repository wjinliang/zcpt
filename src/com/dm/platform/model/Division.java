package com.dm.platform.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.apache.commons.lang.xwork.builder.HashCodeBuilder;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.NotNull;

@Entity
@Table(name = "T_DIVISION")
public class Division implements Serializable {
	private static final long serialVersionUID = -7414938571167391613L;

	private String id;

	private String name;

	private String code;

	private Long seq;
	
	private Integer level;

	private Division parent;
	
	private String createTime;
	
	private String fullName;
	
	private String type;
	
	private String bigDivision;
	
	private List<Division> children = new ArrayList<Division>();

	private List<Org> org;

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

	@Column(name = "NAME", nullable = false, length = 100)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH,
			CascadeType.MERGE, CascadeType.PERSIST })
	@JoinColumn(name = "parent_id", insertable = true, updatable = true)
	public Division getParent() {
		return parent;
	}

	public void setParent(Division parent) {
		this.parent = parent;
	}

	@OrderBy("name ASC")
	@OneToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH,
			CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REMOVE })
	@JoinColumn(name = "parent_id")
	public List<Division> getChildren() {
		return children;
	}

	public void setChildren(List<Division> children) {
		this.children = children;
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

	@OneToMany(cascade = { CascadeType.REFRESH, CascadeType.MERGE,
			CascadeType.PERSIST }, fetch = FetchType.LAZY, mappedBy = "division")
	public List<Org> getOrg() {
		return org;
	}

	public void setOrg(List<Org> org) {
		this.org = org;
	}

	@Override
	public boolean equals(Object obj) {
		Division s = (Division) obj;
		return id.equals(s.id);
	}

	@Override
	public int hashCode() {
		String in = id;
		return in.hashCode();
	}
}
