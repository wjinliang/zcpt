package com.dm.platform.service;

import java.util.List;

import com.dm.platform.model.Division;
import com.dm.platform.model.Org;

public interface DivisionService {
	public List<Org> listOrg(int thispage,int pagesize);
	public Division findOne(String id);
	public void insertOrg(Division entity);
	public void updateOrg(Division entity);
	public void deleteOrg(Division o);
	public Long countMenuGrou();
	public List initDivisionTree();
}
