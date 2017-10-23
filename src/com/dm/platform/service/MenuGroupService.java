package com.dm.platform.service;


import java.util.List;

import com.dm.platform.model.MenuGroup;

public interface MenuGroupService {
	public List<MenuGroup> listMenuGroup(int thispage,int pagesize); 
	public void insertMenuGroup(MenuGroup entity);
	public void updateMenuGroup(MenuGroup entity);
	public void deleteMenuGroup(MenuGroup entity);
	public Long countMenuGrou();
	public MenuGroup findOne(Long id);
	public void refreshService();
}
