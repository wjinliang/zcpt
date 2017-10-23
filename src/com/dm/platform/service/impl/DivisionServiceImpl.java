package com.dm.platform.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Service;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.Org;
import com.dm.platform.service.DivisionService;
import com.dm.platform.service.OrgService;

@Service
public class DivisionServiceImpl implements DivisionService {
	
	@Resource
	private CommonDAO commonDAO;
	
	@Override
	public List<Org> listOrg(int thispage,int pagesize) {
		// TODO Auto-generated method stub
		String hql = "from  Division ";
		return commonDAO.findByPage(hql, thispage, pagesize);
	}

	@Override
	public void insertOrg(Division entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void updateOrg(Division entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public void deleteOrg(Division entity) {
		// TODO Auto-generated method stub
		commonDAO.delete(entity);
	}

	@Override
	public Long countMenuGrou() {
		String hql = "select count(*) from  Division ";
		return commonDAO.count(hql);
	}

	@Override
	public Division findOne(String id) {
		// TODO Auto-generated method stub
		return commonDAO.findOne(Division.class, id);
	}

	@Override
	public List initDivisionTree() {
		List ml = new ArrayList();
		List<Order> orders = new ArrayList<Order>();
		orders.add(new Order(Direction.ASC, "seq"));
		orders.add(new Order(Direction.DESC, "id"));
		List<Division> olist = commonDAO.findAll(Division.class, orders);
		for (Division org : olist) {
			Map m = new HashMap();
			m.put("id", org.getId());
			m.put("name", org.getName());
			if (org.getParent() != null) {
				m.put("pId", org.getParent().getId());
			} else {
				m.put("pId", 0);
			}
			if (org.getChildren().size() != 0) {
				m.put("open", true);
			}
			ml.add(m);
		}
		return ml;
	}
}
