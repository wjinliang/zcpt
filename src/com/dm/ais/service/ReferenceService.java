package com.dm.ais.service;

import java.util.List;

import org.springframework.data.domain.Sort.Order;

import com.dm.ais.model.ReferenceEntity;

public interface ReferenceService {
	public List<ReferenceEntity> listAll(List<Order> orders);
}
