package com.dm.ais.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.domain.Sort.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.dm.ais.model.SettingEntity;
import com.dm.ais.service.SettingService;
import com.dm.platform.dao.CommonDAO;
@Service
public class SettingServiceImpl implements SettingService{
	@Resource
	private CommonDAO commonDAO;
	@Resource 
	JdbcTemplate jdbcTemplate;
	
	@Override
	public void insert(SettingEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void update(SettingEntity entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public void save(SettingEntity entity) {
		commonDAO.save(entity);
	}
	
	@Override
	public SettingEntity getEntityBySiteInfoId(String id) {
		// TODO Auto-generated method stub
		List<SettingEntity> entityList = commonDAO.findByPropertyName(SettingEntity.class, "siteInfoId", id);
		if(entityList.size()>0){
			return entityList.get(0);
		}else{
			return null;
		}
		
	}
	
	@Override
	public List<SettingEntity> listAll(List<Order> orders) {
		return commonDAO.findAll(SettingEntity.class, orders);
	}
	
	@Override
	public List<SettingEntity> listByJurisdictionId(String jurisdictionId,
			List<Order> orders) {
		String hql = " from SettingEntity where 1=1 and jurisdictionsId = '" + jurisdictionId+"'";
		return commonDAO.find(hql);
	}
	
	@Override
	public List<Map<String, Object>> listAllSitesByJruisdictionId(String jurisdictionid) {
		String sql = "select "+
				"ais_site_info.sitename, ais_site_info.agreement_id agreementId, ais_setting.lat siteLat,ais_setting.lat_type siteLatType, ais_setting.lon siteLon,ais_setting.lon_type siteLonType "+
				"from ais_site_info " +
				"LEFT JOIN ais_setting ON ais_site_info.id = ais_setting.site_info_id "+
				"where ais_site_info.jurisdictions_id='"+ jurisdictionid + "'";
		return jdbcTemplate.queryForList(sql);
	}

}
