package com.dm.platform.model;
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.xwork.builder.HashCodeBuilder;

import com.dm.platform.util.DmDateUtil;

@Entity
@Table(name = "T_ORG_BAK")
public class OrgBak implements Serializable {
	private static final long serialVersionUID = -7414941571167391613L;

	private Long id;

	private String name;
	
	private String code;
	
	private String type;//组织类型(0,1,2,3,4,5)=(中央，省，市，县，镇，村)
	
	private Long seq;
	
	private String parent;

	private String division ;
	
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
	
	private String deleteUser;
	
	private String deleteDate;
	
	
	
	public OrgBak(Org o,UserAccount currentUser) {
		this.code = o.getCode();
		this.createDate = o.getCreateDate();
		this.createUser = o.getCreateUser();
		this.deleteDate = DmDateUtil.Current();
		this.deleteUser = currentUser.getCode();
		this.division = o.getDivision().getId();
		this.divisionCode = o.getDivisionCode();
		this.faxno = o.getFaxno();
		this.id = o.getId();
		this.leadName = o.getLeadName();
		this.linkman =o.getLinkman();
		this.name = o.getName();
		this.originId = o.getOriginId();
		this.parent = o.getParent()==null?null:o.getParent().getId().toString();
		this.phoneno = o.getPhoneno();
		this.postalAddress = o.getPostalAddress();
		this.postalCode =o.getPostalCode();
		this.seq = o.getSeq();
		this.systemId = o.getSystemId();
		this.type = o.getType();
	}
	public OrgBak() {
		// TODO Auto-generated constructor stub
	}


	@Column(name="delete_date")
	public String getDeleteDate() {
		return deleteDate;
	}

	public void setDeleteDate(String deleteDate) {
		this.deleteDate = deleteDate;
	}

	@Column(name="division_id")
	public String getDivision() {
		return division;
	}

	@Column(name="division_code")
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
	
	@Column(name="NAME")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	@Column(name="parent_id")
	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	@Column(name="delete_user")
	public String getDeleteUser() {
		return deleteUser;
	}

	public void setDeleteUser(String deleteUser) {
		this.deleteUser = deleteUser;
	}
	

	public void setDivision(String division) {
		this.division = division;
	}

	@Column(name="CODE")
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
		if (!(other instanceof OrgBak)){
			return false;
		}else{
			OrgBak cast = (OrgBak) other;
			if(cast.getId().longValue()==this.getId().longValue()){
				return true;
			}else{
				return false;
			}
		}
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
