package com.dm.platform.service;

import java.util.List;

import com.dm.platform.model.UserRole;
public interface UserRoleService {
	
	public List<UserRole> listUserRole(int thispage,int pagesize); 
	public void insertUserRole(UserRole entity);
	public void updateUserRole(UserRole entity);
	public void deleteUserRole(UserRole entity);
	public UserRole findOne(String id);
	public Long countUserRole();
	public void refreshService();
}
