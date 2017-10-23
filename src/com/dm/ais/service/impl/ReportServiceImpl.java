package com.dm.ais.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dm.ais.dao.CommDAO;
import com.dm.ais.model.ReportEntity;
import com.dm.ais.service.ReportService;
import com.dm.platform.dao.CommonDAO;

@Service
public class ReportServiceImpl implements ReportService{
	
	@Resource
	private CommonDAO commonDAO;
	
	@Resource
	private CommDAO commDAO;
	
	@Override
	public void insert(ReportEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void update(ReportEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public void save(ReportEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}
	
	@Override
	public ReportEntity getEntityBySiteInfoId(String id) {
		// TODO Auto-generated method stub
		List<ReportEntity> entityList = commonDAO.findByPropertyName(ReportEntity.class, "siteInfoId", id);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
	}

	@Override
	public ReportEntity getEntityBySiteInfoIdAndReportRatesForMsgType(
			String siteInfoId, String reportRatesForMsgType) {
		// TODO Auto-generated method stub
		String[] params = {"siteInfoId", "reportRatesForMsgType"};
		String[] values = {siteInfoId, reportRatesForMsgType};
		List<ReportEntity> entityList = commDAO.findByPropertyName(ReportEntity.class, params, values);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
	}


}
