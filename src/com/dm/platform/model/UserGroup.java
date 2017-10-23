package com.dm.platform.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
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

import org.codehaus.jackson.annotate.JsonIgnore;

import com.dm.cms.model.ChannelEntity;
import com.dm.cms.model.SiteEntity;
@Entity(name = "UserGroup")
@Table(name = "T_USER_GROUP")

	/**
	 * 
	 */
public class UserGroup implements  Serializable{
	private static final long serialVersionUID = 1553718189176259451L;
	
	@Id
	@Column(name = "ID", nullable = false, length = 32)
	private String id;
	@Column(name = "NAME", nullable = false, length = 50)
	private String name;
	@Column(name = "SEQ")
	private Long seq;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "T_GROUP_CHANNEL", joinColumns = @JoinColumn(name = "GROUP_ID", referencedColumnName = "ID"), inverseJoinColumns = @JoinColumn(name = "CHANNEL_ID", referencedColumnName = "channel_id"))
	@OrderBy("seq asc")
	@JsonIgnore
	private Set<ChannelEntity> channels = new HashSet<ChannelEntity>();
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "T_GROUP_SITE", joinColumns = @JoinColumn(name = "GROUP_ID", referencedColumnName = "ID"), inverseJoinColumns = @JoinColumn(name = "SITE_ID", referencedColumnName = "site_id"))
	@OrderBy("sortSeq asc")
	@JsonIgnore
	private Set<SiteEntity> sites = new HashSet<SiteEntity>();
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getSeq() {
		return seq;
	}
	public void setSeq(Long seq) {
		this.seq = seq;
	}
	public Set<ChannelEntity> getChannels() {
		return channels;
	}
	public void setChannels(Set<ChannelEntity> channels) {
		this.channels = channels;
	}
	public Set<SiteEntity> getSites() {
		return sites;
	}
	public void setSites(Set<SiteEntity> sites) {
		this.sites = sites;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserGroup other = (UserGroup) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}
