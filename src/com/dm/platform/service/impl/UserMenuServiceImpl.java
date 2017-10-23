package com.dm.platform.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.UserMenu;
import com.dm.platform.service.UserMenuService;

@Service
public class UserMenuServiceImpl implements UserMenuService {
	
	@Resource
	private CommonDAO commonDAO;
	
	@Override
	public List<UserMenu> listUserMenu() {
		// TODO Auto-generated method stub
		return (List<UserMenu>)commonDAO.findAll(UserMenu.class);
	}

	@Override
	public void insertUserMenu(UserMenu entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void updateUserMenu(UserMenu entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public void deleteUserMenu(UserMenu entity) {
		// TODO Auto-generated method stub
		commonDAO.delete(entity);
	}

	@Override
	public void refreshService() {
		// TODO Auto-generated method stub
		
	}
}
