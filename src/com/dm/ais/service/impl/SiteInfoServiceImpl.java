package com.dm.ais.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Service;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.service.SiteInfoService;
import com.dm.platform.dao.CommonDAO;


@Service
public class SiteInfoServiceImpl implements SiteInfoService{
	
	@Resource
	private CommonDAO commonDAO;

	@Override
	public List<AisSiteInfo> listByPage(int thispage, int pagesize,
			List<Order> orders) {
		String hql = " from AisSiteInfo where 1=1";
		return commonDAO.findByPage(hql, thispage, pagesize,orders);
	}
	
	@Override
	public List<AisSiteInfo> listByPage(AisSiteInfo entity, int thispage,
			int pagesize, List<Order> orders) {
		// TODO Auto-generated method stub
		AisSiteInfo aisSiteInfo=new AisSiteInfo();
		String whereSql="";
		if(entity!=null){
			if(entity.getSitename()!=null&&!entity.getSitename().equals("")){
				whereSql+=" and t.sitename like :sitename ";
				aisSiteInfo.setSitename("%"+entity.getSitename()+"%");
			}
			if (entity.getSiteType()!=null&&!entity.getSiteType().equals("")) {
				whereSql+=" and t.siteType=:siteType ";
				aisSiteInfo.setSiteType(entity.getSiteType());
			}
			if(entity.getConnectFlag()!=null&&!entity.getConnectFlag().equals("")){
				whereSql+=" and t.connectFlag=:connectFlag ";
				aisSiteInfo.setConnectFlag(entity.getConnectFlag());
			}
		}
		return commonDAO.findByPage(whereSql,AisSiteInfo.class,aisSiteInfo,thispage, pagesize,orders);
	}
	
	@Override
	public List<AisSiteInfo> listAll(AisSiteInfo entity, List<Order> orders) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long count() {
		String hql = " from AisSiteInfo where 1=1";
		return commonDAO.count(hql);
	}
	
	@Override
	public Long count(AisSiteInfo entity) {
		Long num = null;
		AisSiteInfo aisSiteInfo=new AisSiteInfo();
		String whereSql="";
		if(entity!=null){
			if(entity.getSitename()!=null&&!entity.getSitename().equals("")){
				whereSql+=" and t.sitename like :sitename ";
				aisSiteInfo.setSitename("%"+entity.getSitename()+"%");
			}
			if (entity.getSiteType()!=null&&!entity.getSiteType().equals("")) {
				whereSql+=" and t.siteType=:siteType ";
				aisSiteInfo.setSiteType(entity.getSiteType());
			}
			if(entity.getConnectFlag()!=null&&!entity.getConnectFlag().equals("")){
				whereSql+=" and t.connectFlag=:connectFlag ";
				aisSiteInfo.setConnectFlag(entity.getConnectFlag());
			}
		}
		return commonDAO.count(AisSiteInfo.class, whereSql, aisSiteInfo);
	}

	@Override
	public AisSiteInfo findById(String id) {
		// TODO Auto-generated method stub
		return commonDAO.findOne(AisSiteInfo.class, id);
	}

	@Override
	public void save(AisSiteInfo entity) {
		commonDAO.save(entity);
		
	}

	@Override
	public void update(AisSiteInfo entity) {
		commonDAO.update(entity);
	}

	@Override
	public void deleteById(Object id) {
		// TODO Auto-generated method stub
		AisSiteInfo entity = new AisSiteInfo();
		entity = findById((String)id);
		commonDAO.delete(entity);
	}

	@Override
	public void setConnect(String siteId,String connectFlag) {
		// TODO Auto-generated method stub
		AisSiteInfo entity = new AisSiteInfo();
		entity = findById(siteId);
		entity.setConnectFlag(connectFlag);
		commonDAO.update(entity);
	}

	@Override
	public void setMMSIAndUID(String siteId, String mmsi, String uid) {
		// TODO Auto-generated method stub
		AisSiteInfo entity = new AisSiteInfo();
		entity = findById(siteId);
		entity.setMmsi(mmsi);
		entity.setUid(uid);
		commonDAO.update(entity);
	}

	@Override
	public List<AisSiteInfo> listOthers(String siteId) {
		String hql = " from AisSiteInfo where 1=1 and id !='" + siteId+"'";
		return commonDAO.find(hql);
	}

	@Override
	public List<AisSiteInfo> listAll(List<Order> orders) {
		return commonDAO.findAll(AisSiteInfo.class, orders);
	}

	@Override
	public List<AisSiteInfo> listByJurisdictionId(String jurisdictionId,
			List<Order> orders) {
		String hql = " from AisSiteInfo where 1=1 and jurisdictionsId = '" + jurisdictionId+"'";
		return commonDAO.find(hql);
	}

	@Override
	public AisSiteInfo findByAgreementId(String agreementId) {
		String hql = " from AisSiteInfo where 1=1 and agreementId = '" + agreementId+"'";
		List<AisSiteInfo> list = commonDAO.find(hql);
		if(list.size()>0) {
			return list.get(0);
		} else {
			return null;
		}
	}
	@Override
	public List<AisSiteInfo>listByJId(String jid,List<Order> orders){
		String hql = " from AisSiteInfo where 1=1 and agreementId like '%" + jid+"%'";
		return commonDAO.find(hql);
	}

}
