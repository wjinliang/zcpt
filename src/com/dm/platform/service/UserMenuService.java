package com.dm.platform.service;

import java.util.List;

import com.dm.platform.model.UserMenu;
public interface UserMenuService {
	public List<UserMenu> listUserMenu(); 
	public void insertUserMenu(UserMenu entity);
	public void updateUserMenu(UserMenu entity);
	public void deleteUserMenu(UserMenu entity);
	public void refreshService();
}
