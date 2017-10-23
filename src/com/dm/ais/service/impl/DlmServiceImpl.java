package com.dm.ais.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dm.ais.dao.CommDAO;
import com.dm.ais.model.DlmEntity;
import com.dm.ais.service.DlmService;
import com.dm.platform.dao.CommonDAO;

@Service
public class DlmServiceImpl implements DlmService{
	@Resource
	private CommonDAO commonDAO;
	
	@Resource
	private CommDAO commDAO;
	
	@Override
	public void insert(DlmEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void update(DlmEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public DlmEntity getEntityBySiteInfoId(String id) {
		// TODO Auto-generated method stub
		List<DlmEntity> entityList = commonDAO.findByPropertyName(DlmEntity.class, "siteInfoId", id);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
	}

	@Override
	public DlmEntity getEntityBySiteInfoIdAndChannelTypeAndReservation(
			String siteInfoId, String channelType, String reservation) {
		String[] params = {"siteInfoId", "channelType", "reservation"};
		String[] values = {siteInfoId, channelType, reservation};
		List<DlmEntity> entityList = commDAO.findByPropertyName(DlmEntity.class, params, values);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
	}

	@Override
	public DlmEntity getEntityBySiteInfoIdAndChannelTypeAndSeqNumber(String siteInfoId, String channelType,
			String seqNumber) {
		String[] params = {"siteInfoId", "channelType", "seqNumber"};
		String[] values = {siteInfoId, channelType, seqNumber};
		List<DlmEntity> entityList = commDAO.findByPropertyName(DlmEntity.class, params, values);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
	}

	@Override
	public void save(DlmEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

}
