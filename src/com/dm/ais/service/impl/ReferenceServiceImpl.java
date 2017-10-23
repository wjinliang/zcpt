package com.dm.ais.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Service;

import com.dm.ais.model.ReferenceEntity;
import com.dm.ais.service.ReferenceService;
import com.dm.platform.dao.CommonDAO;


@Service
public class ReferenceServiceImpl implements ReferenceService{
	
	@Resource
	private CommonDAO commonDAO;

	@Override
	public List<ReferenceEntity> listAll(List<Order> orders) {
		return commonDAO.findAll(ReferenceEntity.class, orders);
	}

	
}
