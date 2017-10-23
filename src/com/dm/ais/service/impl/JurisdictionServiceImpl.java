package com.dm.ais.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.domain.Sort.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.dm.ais.model.JurisdictionEntity;
import com.dm.ais.service.JurisdictionService;
import com.dm.platform.dao.CommonDAO;

@Service
public class JurisdictionServiceImpl implements JurisdictionService {

	@Resource
	private CommonDAO commonDAO;
	@Resource 
	JdbcTemplate jdbcTemplate;
	
	@Override
	public List<JurisdictionEntity> listAll(List<Order> orders) {
		// TODO Auto-generated method stub
		return commonDAO.findAll(JurisdictionEntity.class, orders);
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
