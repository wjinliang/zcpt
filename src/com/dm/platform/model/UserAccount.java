package com.dm.platform.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Pattern;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity(name = "UserAccount")
@Table(name = "T_USER_ACCOUNT")
public class UserAccount implements Serializable, UserDetails {
	private static final long serialVersionUID = 1724450140216701197L;

	private String code;

	/*
	 * 个人登录信息
	 * */
	
	private String loginname;
	private String name;
	private String password;
	//是否失效
	private boolean enabled;
	//是否锁定
	private boolean locked;
	//账号是否过期
	private boolean accountExpired;
	//密码是否过期
	private boolean passwordExpired;
	//排序号
	private Long seq;
	
	private boolean delete;

	/*
	 * 个人基本资料
	 * */
	private String mobile;
	
	private String email;
	
	private String headpic;

	private FileEntity headphoto;

	//角色
	private Set<UserRole> roles=new HashSet<UserRole>();
	
	//组织
	private Org org = new Org();

	
	/*
	 * 登录日志基本信息
	 * */
	private String lastLoginTime;
	
	private String remoteIpAddr;
	
	private Long loginCount;
	
	private String synPassword;
	
	private String mergeUuid;//关联id
	
	private String originId;//源系统id
	
	private String schoolAge;//学历
	
	private String title;//职称

	private String speciality;//专业
	
	private String createDate;//创建日期
	
	private String createUser;//创建人
	
	private String bizPhoneNo;//电话
	
	private String faxno;//传真
	
	private String address;//地址
	
	private String duty;//职务
	
	private String birthday;//生日
	
	private String gender;//性别
	
	private String userType;//用户类型(0-单位用户  1-个人用户)
	
	private String systemId; //系统标示
	
	private String oldLoginName; //系统标示
	@Id
	@Pattern(regexp = "[A-Za-z0-9_\\-]+")
	@Column(name = "CODE", nullable = false, length = 50)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "LOGINNAME", nullable = false, length = 50)
	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	@Column(name = "NAME", nullable = false, length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "PASSWORD", nullable = false, length = 64)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "ENABLED", nullable = false)
	public boolean isEnabled() {
		//if(delete) return true;
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@Column(name = "LOCKED")
	public boolean isLocked() {
		return locked;
	}
	
	public void setLocked(boolean locked) {
		this.locked = locked;
	}
	
	@Column(name = "ACCOUNT_EXPIRED")
	public boolean isAccountExpired() {
		return accountExpired;
	}

	public void setAccountExpired(boolean accountExpired) {
		this.accountExpired = accountExpired;
	}
	@Column(name = "PASSWORD_EXPIRED")
	public boolean isPasswordExpired() {
		return passwordExpired;
	}

	public void setPasswordExpired(boolean passwordExpired) {
		this.passwordExpired = passwordExpired;
	}

	@Column(name = "is_delete")
	public boolean isDelete() {
		return delete;
	}

	public void setDelete(boolean delete) {
		this.delete = delete;
	}

	@Column(name = "EMAIL", length = 50)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "LASTLOGINTIME", length = 50)
	public String getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	
	@Column(name = "REMOTEIPADDR", length = 50)
	public String getRemoteIpAddr() {
		return remoteIpAddr;
	}

	public void setRemoteIpAddr(String remoteIpAddr) {
		this.remoteIpAddr = remoteIpAddr;
	}
	
	@Column(name = "LOGINCOUNT",columnDefinition="int default 0")
	public Long getLoginCount() {
		return loginCount==null?0:loginCount;
	}

	public void setLoginCount(Long loginCount) {
		this.loginCount = loginCount;
	}
	
	@Column(name = "HEADPIC")
	public String getHeadpic() {
		return headpic;
	}

	public void setHeadpic(String headpic) {
		this.headpic = headpic;
	}

	@OneToOne(cascade = { CascadeType.REFRESH, CascadeType.MERGE,
			CascadeType.PERSIST })
	@JoinColumn(name = "headphoto_id")
	public FileEntity getHeadphoto() {
		return headphoto;
	}

	public void setHeadphoto(FileEntity headphoto) {
		this.headphoto = headphoto;
	}

	@Column(name = "SEQ")
	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}

	@ManyToMany(cascade = { CascadeType.REFRESH, CascadeType.MERGE,
			CascadeType.PERSIST }, fetch = FetchType.EAGER)
	@JoinTable(name = "T_USER_ACCOUNT_ROLE", joinColumns = @JoinColumn(name = "USER_CODE", referencedColumnName = "CODE"), inverseJoinColumns = @JoinColumn(name = "ROLE_CODE", referencedColumnName = "CODE"))
	@OrderBy("seq asc")
	public Set<UserRole> getRoles() {
		return roles;
	}
	public void setRoles(Set<UserRole> roles) {
		this.roles = roles;
	}
	
	public void addRole(UserRole role){
		Set<UserRole> roleset = getRoles();
		roleset.add(role);
		setRoles(roleset);
	}
	/*wjl@ManyToOne(fetch = FetchType.EAGER, cascade = { CascadeType.REFRESH,
			CascadeType.MERGE, CascadeType.PERSIST })*/
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "org_id")
	@OrderBy("seq asc")
	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}
	
	@Column(name = "MOBILE", length = 50)
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	// ----------------------------------------------------------------------------------------
	@Override
	@Transient
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		Collection<GrantedAuthority> authCol = new ArrayList<GrantedAuthority>();
		Set<UserRole> userRoleSet = this.getRoles();
		for (UserRole ur : userRoleSet) {
			GrantedAuthority ga = new SimpleGrantedAuthority(ur.getCode());
			authCol.add(ga);
		}
		return authCol;
	}

	@Override
	@Transient
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.loginname;
	}

	@Override
	@Transient
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		//账号过期
		return true;
	}

	@Override
	@Transient
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		//账号锁定
		return !(this.locked);
	}

	@Override
	@Transient
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		//密码失效
		return true;
	}

	@Override
	public boolean equals(Object rhs) {
		if (rhs instanceof UserAccount) {
			return getLoginname().equals(((UserAccount) rhs).getLoginname());
		}
		return false;
	}

	/**
	 * Returns the hashcode of the {@code username}.
	 */
	@Override
	public int hashCode() {
		if (getLoginname() != null) {
			return getLoginname().hashCode();
		} else {
			return 0;
		}
	}
	 @Column(name="SYNPASSWORD",nullable=true,length=200)
	  public String getSynPassword() {
		return synPassword;
	}

	  public void setSynPassword(String synPassword) {
		  this.synPassword = synPassword;
	  }
	@Column(name="merge_uuid",nullable=true,length=200)
	public String getMergeUuid() {
		return mergeUuid;
	}

	public void setMergeUuid(String mergeUuid) {
		this.mergeUuid = mergeUuid;
	}
	@Column(name="origin_id",nullable = true)
	public String getOriginId() {
		return originId;
	}

	public void setOriginId(String originId) {
		this.originId = originId;
	}
	@Column(name="school_age",nullable = true)
	public String getSchoolAge() {
		return schoolAge;
	}

	public void setSchoolAge(String schoolAge) {
		this.schoolAge = schoolAge;
	}
	@Column(name="title",nullable = true)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	@Column(name="speciality",nullable = true)
	public String getSpeciality() {
		return speciality;
	}

	public void setSpeciality(String speciality) {
		this.speciality = speciality;
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
	@Column(name="bizphone_no",nullable = true)
	public String getBizPhoneNo() {
		return bizPhoneNo;
	}

	public void setBizPhoneNo(String bizPhoneNo) {
		this.bizPhoneNo = bizPhoneNo;
	}
	@Column(name="fax_no",nullable = true)
	public String getFaxno() {
		return faxno;
	}

	public void setFaxno(String faxno) {
		this.faxno = faxno;
	}
	@Column(name="address",nullable = true)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	@Column(name="duty",nullable = true)
	public String getDuty() {
		return duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}
	@Column(name="birthday",nullable = true)
	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	@Column(name="gender",nullable = true)
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	@Column(name="user_type",nullable = true)
	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}
	@Column(name="system_id",nullable = true)
	public String getSystemId() {
		return systemId;
	}

	public void setSystemId(String systemId) {
		this.systemId = systemId;
	}
	@Column(name="old_loginname",nullable = true)
	public String getOldLoginName() {
		return oldLoginName;
	}

	public void setOldLoginName(String oldLoginName) {
		this.oldLoginName = oldLoginName;
	}
	
}
