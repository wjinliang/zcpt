package com.dm.ais.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Sort.Order;

import com.dm.ais.model.SettingEntity;

public interface SettingService {
	public void insert(SettingEntity entity);
	public void update(SettingEntity entity);
	public void save(SettingEntity entity);
	public SettingEntity getEntityBySiteInfoId(String id);
	public List<SettingEntity> listAll(List<Order> orders);
	public List<SettingEntity> listByJurisdictionId(String jurisdictionId, List<Order> orders);
	public List<Map<String, Object>> listAllSitesByJruisdictionId(String id);
}
