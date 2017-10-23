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
import com.dm.ais.model.SettingEntity;
import com.dm.ais.model.SiteBaseInfoEntity;
import com.dm.ais.service.SettingService;;

@Controller
@RequestMapping("/sitebaseinfo")
public class WebServiceControllerDFT {

	
	@Resource
	public SettingService settingService;
	
	
	@RequestMapping("/webService/getSiteBaseLocInfo")
	public @ResponseBody JSONArray getSiteInfo() throws Exception {
		List<Order> orders = new ArrayList<Order>();
		List<SettingEntity> aisSiteList = settingService.listAll(orders);
		List<SiteBaseInfoEntity> tempList = new ArrayList<SiteBaseInfoEntity>();
		if (aisSiteList.size() > 0) {
			for (int i = 0; i < aisSiteList.size(); i++) {
				SettingEntity settingEntity = aisSiteList.get(i);
				SiteBaseInfoEntity siteBaseInfoEntity = new SiteBaseInfoEntity();
				siteBaseInfoEntity.setAgreementid(settingEntity.getAgreementid());
				siteBaseInfoEntity.setLat(settingEntity.getLat());
				siteBaseInfoEntity.setLon(settingEntity.getLon());
				siteBaseInfoEntity.setSitename(settingEntity.getUid());
				tempList.add(siteBaseInfoEntity);
			}
		}
		
		JSONArray jsonArray = new JSONArray();
		jsonArray.addAll(tempList);
		
		return jsonArray;
	}
	
	
	
}
