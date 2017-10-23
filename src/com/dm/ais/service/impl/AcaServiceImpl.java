package com.dm.ais.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dm.ais.dao.CommDAO;
import com.dm.ais.model.AcaEntity;
import com.dm.ais.service.AcaService;
import com.dm.platform.dao.CommonDAO;

@Service
public class AcaServiceImpl implements AcaService{
	@Resource
	private CommonDAO commonDAO;
	
	@Resource
	private CommDAO commDAO;
	
	@Override
	public void insert(AcaEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void update(AcaEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public AcaEntity getEntityBySiteInfoId(String id) {
		// TODO Auto-generated method stub
		List<AcaEntity> entityList = commonDAO.findByPropertyName(AcaEntity.class, "siteInfoId", id);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
	}

	@Override
	public AcaEntity getEntityBySiteInfoIdAndSeqNumber(String siteInfoId,
			String seqNumber) {
		String[] params = {"siteInfoId", "seqNumber"};
		String[] values = {siteInfoId, seqNumber};
		List<AcaEntity> entityList = commDAO.findByPropertyName(AcaEntity.class, params, values);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
	}

}
