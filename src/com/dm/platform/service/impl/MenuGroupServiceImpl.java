package com.dm.platform.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.MenuGroup;
import com.dm.platform.service.MenuGroupService;

@Service
public class MenuGroupServiceImpl implements MenuGroupService {
	
	@Resource
	private CommonDAO commonDAO;
	
	@Override
	public List<MenuGroup> listMenuGroup(int thispage, int pagesize) {
		// TODO Auto-generated method stub
		String hql = "from  MenuGroup ";
		return commonDAO.findByPage(hql, thispage, pagesize);
	}

	@Override
	public void insertMenuGroup(MenuGroup entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void updateMenuGroup(MenuGroup entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public void deleteMenuGroup(MenuGroup entity) {
		// TODO Auto-generated method stub
		commonDAO.delete(entity);
	}

	@Override
	public Long countMenuGrou() {
		// TODO Auto-generated method stub
		String hql = "select count(*) from  MenuGroup ";
		return commonDAO.count(hql);
	}

	@Override
	public MenuGroup findOne(Long id) {
		// TODO Auto-generated method stub
		return commonDAO.findOne(MenuGroup.class, id);
	}

	@Override
	public void refreshService() {
		// TODO Auto-generated method stub
		
	}

}
