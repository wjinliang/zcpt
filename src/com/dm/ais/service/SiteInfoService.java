package com.dm.ais.service;

import java.util.List;

import org.springframework.data.domain.Sort.Order;

import com.dm.ais.model.AisSiteInfo;

public interface SiteInfoService {

	public List<AisSiteInfo> listByPage(int thispage,int pagesize,List<Order> orders);
	public List<AisSiteInfo> listByPage(AisSiteInfo entity,int thispage,int pagesize,List<Order> orders);
	public List<AisSiteInfo> listAll(AisSiteInfo entity,List<Order> orders);
	public Long count();
	public Long count(AisSiteInfo entity);
	public AisSiteInfo findById(String id);
	public void save(AisSiteInfo entity);
	public void update(AisSiteInfo entity);
	public void deleteById(Object id);
	
	public void setConnect(String siteId,String connectFlag);
	public void setMMSIAndUID(String siteId, String mmsi, String uid);
	public List<AisSiteInfo> listOthers(String siteId);
	public List<AisSiteInfo> listAll(List<Order> orders);
	public List<AisSiteInfo> listByJurisdictionId(String jurisdictionId, List<Order> orders);
	public AisSiteInfo findByAgreementId(String agreementId);
	public List<AisSiteInfo> listByJId(String jid,List<Order> orders);
	
}
