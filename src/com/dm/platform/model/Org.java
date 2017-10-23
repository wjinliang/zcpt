package com.dm.platform.model;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.apache.commons.lang.xwork.builder.HashCodeBuilder;
import org.hibernate.validator.NotNull;

@Entity
@Table(name = "T_ORG")
public class Org implements Serializable {
	private static final long serialVersionUID = -7414938571167391613L;

	private Long id;

	private String name;
	
	private String code;
	
	private String type;//组织类型(0,1,2,3,4,5)=(中央，省，市，县，镇，村)
	
	private Long seq;
	
	private Org parent;

	private List<Org> children = new ArrayList<Org>();
	
	private List<UserAccount> user;
	
	private Division division =new Division();
	
	private String divisionCode;
	
	private String originId;//原系统id
	
	private String leadName;//主管人姓名
	
	private String linkman;//联系人名称
	
	private String createDate;//创建日期
	
	private String createUser;//创建人
	
	private String systemId; //系统标示
	
	private String postalCode;//邮编
	
	private String postalAddress;//邮编地址
	
	private String faxno;//传真
	
	private String phoneno;//电话号码
	
	@Column(name="division_code",nullable = true, length = 10)
	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	@Id
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name="NAME",nullable = false, length = 32)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@ManyToOne(fetch = FetchType.EAGER,cascade = { CascadeType.REFRESH, CascadeType.MERGE,CascadeType.PERSIST })
	@JoinColumn(name = "parent_id", insertable = true, updatable = true)
	public Org getParent() {
		return parent;
	}

	public void setParent(Org parent) {
		this.parent = parent;
	}

	@OrderBy("name ASC")
	@OneToMany(fetch = FetchType.EAGER,cascade = { CascadeType.REFRESH, CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REMOVE })
	@JoinColumn(name = "parent_id")
	public List<Org> getChildren() {
		return children;
	}

	public void setChildren(List<Org> children) {
		this.children = children;
	}

	@OneToMany(cascade = { CascadeType.REFRESH, CascadeType.MERGE,CascadeType.PERSIST }, fetch = FetchType.LAZY, mappedBy = "org")
	public List<UserAccount> getUser() {
		return user;
	}

	public void setUser(List<UserAccount> user) {
		this.user = user;
	}

	@Column(name="CODE",nullable = false, length = 32)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Column(name="SEQ",nullable = false)
	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}


	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).toHashCode();
	}
	
	@Override
	public boolean equals(Object other) {
		if (!(other instanceof Org)){
			return false;
		}else{
			Org cast = (Org) other;
			if(cast.getId().longValue()==this.getId().longValue()){
				return true;
			}else{
				return false;
			}
		}
	}
	@ManyToOne(fetch = FetchType.EAGER,cascade = { CascadeType.REFRESH, CascadeType.MERGE,CascadeType.PERSIST })
	@JoinColumn(name = "division_id", insertable = true, updatable = true)
	public Division getDivision() {
		return division;
	}

	public void setDivision(Division division) {
		this.division = division;
	}
	@Column(name="type",nullable = true)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	@Column(name="origin_id",nullable = true)
	public String getOriginId() {
		return originId;
	}

	public void setOriginId(String originId) {
		this.originId = originId;
	}
	@Column(name="lead_name",nullable = true)
	public String getLeadName() {
		return leadName;
	}

	public void setLeadName(String leadName) {
		this.leadName = leadName;
	}
	@Column(name="link_man",nullable = true)
	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	@Column(name="create_date",nullable = true)
	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	@Column(name="create_user",nullable = true)
	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	@Column(name="system_id",nullable = true)
	public String getSystemId() {
		return systemId;
	}

	public void setSystemId(String systemId) {
		this.systemId = systemId;
	}
	@Column(name="postal_code",nullable = true)
	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	@Column(name="postal_address",nullable = true)
	public String getPostalAddress() {
		return postalAddress;
	}

	public void setPostalAddress(String postalAddress) {
		this.postalAddress = postalAddress;
	}
	@Column(name="fax_no",nullable = true)
	public String getFaxno() {
		return faxno;
	}

	public void setFaxno(String faxno) {
		this.faxno = faxno;
	}
	@Column(name="phone_no",nullable = true)
	public String getPhoneno() {
		return phoneno;
	}

	public void setPhoneno(String phoneno) {
		this.phoneno = phoneno;
	}
	
	
}
