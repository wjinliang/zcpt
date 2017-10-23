package com.dm.ais.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dm.ais.dao.CommDAO;
import com.dm.ais.model.OutputEntity;
import com.dm.ais.service.OutputService;
import com.dm.platform.dao.CommonDAO;
@Service
public class OutputServiceImpl implements  OutputService{
	
	@Resource
	private CommonDAO commonDAO;
	
	@Resource
	private CommDAO commDAO;
	
	@Override
	public void insert( OutputEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void update( OutputEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public  OutputEntity getEntityBySiteInfoId(String id) {
		// TODO Auto-generated method stub
		List<OutputEntity> entityList = commonDAO.findByPropertyName(OutputEntity.class, "siteInfoId", id);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
	}

	@Override
	public OutputEntity getEntityBySiteInfoIdAndByOutputType(String siteInfoId) {
		// TODO Auto-generated method stub
		String[] params = {"siteInfoId"};
		String[] values = {siteInfoId};
		List<OutputEntity> entityList = commDAO.findByPropertyName(OutputEntity.class, params, values);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
	}

}
