package com.dm.platform.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.UserRole;
import com.dm.platform.service.UserRoleService;

@Service
public class UserRoleServiceImpl implements UserRoleService {
	
	@Resource
	private CommonDAO commonDAO;
	
	@Override
	public List<UserRole> listUserRole(int thispage,int pagesize) {
		// TODO Auto-generated method stub
		String hql = "from  UserRole ";
		return commonDAO.findByPage(hql, thispage, pagesize);
	}

	@Override
	public void insertUserRole(UserRole entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void updateUserRole(UserRole entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public void deleteUserRole(UserRole entity) {
		// TODO Auto-generated method stub
		commonDAO.delete(entity);
	}

	@Override
	public UserRole findOne(String id) {
		// TODO Auto-generated method stub
		return commonDAO.findOne(UserRole.class, id);
	}
	@Override
	public Long countUserRole() {
		// TODO Auto-generated method stub
		String hql = "select count(*) from  UserRole ";
		return commonDAO.count(hql);
	}

	@Override
	public void refreshService() {
		// TODO Auto-generated method stub
		
	}
}
