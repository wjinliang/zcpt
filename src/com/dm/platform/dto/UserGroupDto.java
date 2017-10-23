package com.dm.platform.dto;

import java.util.Set;

import com.dm.cms.model.ChannelEntity;
import com.dm.cms.model.SiteEntity;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserGroup;

public class UserGroupDto {
	public UserGroupDto(){
		
	}
	
	
	private String id;
	private String name;
	private Long seq;
	private String userIds;
	private String siteChannelIds;
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

	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}

	public String getSiteChannelIds() {
		return siteChannelIds;
	}

	public void setSiteChannelIds(String siteChannelIds) {
		this.siteChannelIds = siteChannelIds;
	}

	
}
