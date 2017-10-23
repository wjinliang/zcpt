package com.dm.ais.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.SiteBaseInfoEntity;
import com.dm.ais.service.SiteInfoService;

@Controller
@RequestMapping("/sitebaseinfo")
public class WebServiceControllerTJ {

	
	@Resource
	public SiteInfoService siteInfoService;
	
	
	@RequestMapping("/webService/getSiteBaseInfo")
	public @ResponseBody JSONArray getSiteInfo() throws Exception {
		List<Order> orders = new ArrayList<Order>();
		List<AisSiteInfo> aisSiteList = siteInfoService.listAll(orders);
		List<SiteBaseInfoEntity> tempList = new ArrayList<SiteBaseInfoEntity>();
		if (aisSiteList.size() > 0) {
			for (int i = 0; i < aisSiteList.size(); i++) {
				AisSiteInfo aissite = aisSiteList.get(i);
				SiteBaseInfoEntity siteBaseInfoEntity = new SiteBaseInfoEntity();
				siteBaseInfoEntity.setAgreementid(aissite.getAgreementId());
				siteBaseInfoEntity.setIp_address_a(aissite.getIpAddressA());
				siteBaseInfoEntity.setIp_address_b(aissite.getIpAddressB());
				siteBaseInfoEntity.setSitename(aissite.getSitename());
				siteBaseInfoEntity.setPort_a(aissite.getPortA());
				siteBaseInfoEntity.setPort_b(aissite.getPortB());
				tempList.add(siteBaseInfoEntity);
			}
		}
		
		JSONArray jsonArray = new JSONArray();
		jsonArray.addAll(tempList);
		
		return jsonArray;
	}
	
	
	
}
