package com.dm.ais.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Sort.Order;

import com.dm.ais.model.JurisdictionEntity;

public interface JurisdictionService {

	public List<JurisdictionEntity> listAll(List<Order> orders);
	
	public List<Map<String, Object>> listAllSitesByJruisdictionId(String id);
}
