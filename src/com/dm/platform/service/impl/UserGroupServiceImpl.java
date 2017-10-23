package com.dm.platform.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.dm.cms.model.ChannelEntity;
import com.dm.cms.model.SiteEntity;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.dto.UserGroupDto;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserGroup;
import com.dm.platform.service.UserGroupService;

@Service
public class UserGroupServiceImpl implements UserGroupService {
	
	@Resource
	private CommonDAO commonDAO;
	
	@Override
	public List<UserGroup> list(int thispage,int pagesize,UserGroupDto arg ) {
		// TODO Auto-generated method stub
		String whereSql= "";
		Map argMap = new HashMap();
		if(!StringUtils.isEmpty(arg.getName())){
			whereSql+=" and t.name like :name";
			argMap.put("name", "%"+arg.getName()+"%");
		}
		List<Order> orders = new ArrayList<Order>();
		orders.add(new Order(Direction.DESC, "id"));
		List<UserGroup> userGroups = commonDAO.findByMapArg(UserGroup.class, whereSql, argMap, orders, thispage, pagesize);
		return userGroups;
	}

	@Override
	public UserGroupDto getDtoFromModel(UserGroup group) {
		// TODO Auto-generated method stub
		UserGroupDto dto = new UserGroupDto();
		dto.setId(group.getId());
		dto.setName(group.getName());
		dto.setSeq(group.getSeq());
		Map argsMap = new HashMap();
		argsMap.put("group", group);
		List<UserAccount> userAccounts = commonDAO.findByMap("select distinct u from UserAccount u join u.groups g where g=:group",argsMap);
		Set<UserAccount> users = new HashSet<UserAccount>(userAccounts);
		List<SiteEntity> siteEntities = commonDAO.find("select s from SiteEntity s join s.groups g where g.id="+group.getId());
		Set<SiteEntity> sites = new HashSet<SiteEntity>(siteEntities); 
		String userIds = "";
		String channelIds = "";
		for(UserAccount user:users)
		{
			userIds+=user.getCode()+",";
		}
		if(userIds.endsWith(","))
		{
			userIds.substring(0, userIds.length()-1);
		}
		for(SiteEntity site:sites)
		{
			Map cArgMap = new HashMap();
			cArgMap.put("group", group);
			List<ChannelEntity> channels = commonDAO.findByMap("select c from ChannelEntity c join c.groups g where g=:group",cArgMap);
		    for(ChannelEntity channel:channels)
		    {
		    	channelIds+=channel.getChannelId()+",";
		    }
			channelIds+="-"+site.getSiteId()+",";
		}
		if(channelIds.endsWith(","))
		{
			channelIds.substring(0, channelIds.length()-1);
		}
		dto.setSiteChannelIds(channelIds);
		dto.setUserIds(userIds);
		return dto;
	}
	
	@Override
	public void insert(UserGroup entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void update(UserGroup entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public void delete(UserGroup entity) {
		// TODO Auto-generated method stub
		commonDAO.delete(entity);
	}

	@Override
	public UserGroup findOne(String id) {
		// TODO Auto-generated method stub
		return commonDAO.findOne(UserGroup.class, id);
	}
	@Override
	public Long count(UserGroupDto arg) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from  UserGroup t where 1=1";
		String whereSql= "";
		Map argMap = new HashMap();
		if(!StringUtils.isEmpty(arg.getName())){
			whereSql+=" and t.name like :name";
			argMap.put("name", "%"+arg.getName()+"%");
		}
		return commonDAO.count(hql+whereSql);
	}

	@Override
	public void insertupdate(UserGroupDto dto) {
		
	}

}
