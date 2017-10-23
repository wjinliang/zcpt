package com.dm.platform.service;

import java.util.List;

import com.dm.platform.dto.UserGroupDto;
import com.dm.platform.model.UserGroup;
public interface UserGroupService {
	
	public List<UserGroup> list(int thispage,int pagesize,UserGroupDto arg); 
	public void insert(UserGroup entity);
	public void update(UserGroup entity);
	public void delete(UserGroup entity);
	public UserGroup findOne(String id);
	public Long count(UserGroupDto arg);
	UserGroupDto getDtoFromModel(UserGroup group);
	void insertupdate(UserGroupDto dto);
}
