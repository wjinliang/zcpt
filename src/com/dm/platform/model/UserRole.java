package com.dm.platform.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.validation.constraints.Pattern;

import org.apache.commons.lang.xwork.builder.HashCodeBuilder;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

@Entity(name = "UserRole")
@Table(name = "T_USER_ROLE")
public class UserRole implements Serializable {

	private static final long serialVersionUID = 5751949149570819173L;

	private String code;

	private String name;

	private Long seq;

	private boolean enabled;

	private Set<UserAccount> users;

	private Set<UserMenu> menus;

	private String homePage;

	private String detial;

	private Set<MenuGroup> menugroups;

	@Id
	@Length(min = 2)
	@Pattern(regexp = "[A-Za-z0-9_\\-]+")
	@Column(name = "CODE", nullable = false, length = 50)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@NotEmpty
	@Length(min = 2)
	@Column(name = "NAME", nullable = false, length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	//@ManyToMany(mappedBy = "roles", fetch = FetchType.EAGER)
	@ManyToMany(mappedBy = "roles", fetch = FetchType.LAZY)
	public Set<UserAccount> getUsers() {
		return users;
	}

	public void setUsers(Set<UserAccount> users) {
		this.users = users;
	}

	@Column(name = "ENABLED", nullable = false)
	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@Column(name = "HOMEPAGE")
	public String getHomePage() {
		return homePage;
	}

	public void setHomePage(String homePage) {
		this.homePage = homePage;
	}

	@Column(name = "SEQ")
	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}

	@Column(name = "DETAIL")
	public String getDetial() {
		return detial;
	}

	public void setDetial(String detial) {
		this.detial = detial;
	}

	/*@ManyToMany(fetch = FetchType.EAGER, cascade = { CascadeType.REFRESH,
			CascadeType.MERGE, CascadeType.PERSIST })
	@JoinTable(name = "T_USER_ROLE_MENU_GROUP", joinColumns = @JoinColumn(name = "ROLE_CODE", referencedColumnName = "CODE"), inverseJoinColumns = @JoinColumn(name = "MENU_GROUP_ID", referencedColumnName = "ID"))
	@OrderBy("seq asc")*/
	@ManyToMany(fetch = FetchType.EAGER, cascade = { CascadeType.REFRESH,
			CascadeType.MERGE, CascadeType.PERSIST })
	@JoinTable(name = "T_USER_ROLE_MENU_GROUP", joinColumns = @JoinColumn(name = "ROLE_CODE", referencedColumnName = "CODE"), inverseJoinColumns = @JoinColumn(name = "MENU_GROUP_ID", referencedColumnName = "ID"))
	@OrderBy("seq asc")
	public Set<MenuGroup> getMenugroups() {
		return menugroups;
	}

	public void setMenugroups(Set<MenuGroup> menugroups) {
		this.menugroups = menugroups;
	}

	@ManyToMany(fetch = FetchType.EAGER, cascade = { CascadeType.REFRESH,
			CascadeType.MERGE, CascadeType.PERSIST })
	@JoinTable(name = "T_ROLE_MENU", inverseJoinColumns = @JoinColumn(name = "MENU_CODE", referencedColumnName = "ID"), joinColumns = @JoinColumn(name = "ROLE_CODE", referencedColumnName = "CODE"))
	@OrderBy("seq asc")
	public Set<UserMenu> getMenus() {
		return menus;
	}

	public void setMenus(Set<UserMenu> menus) {
		this.menus = menus;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getCode()).toHashCode();
	}

	@Override
	public boolean equals(Object other) {
		if (!(other instanceof UserRole)) {
			return false;
		} else {
			UserRole cast = (UserRole) other;
			if (getCode()!= null) {
				if (cast.getCode().equals(getCode())) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		}
	}

}
