package com.dm.ais.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import com.dm.ais.dto.SiteInfoDto;
import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.service.SiteInfoService;
import com.dm.platform.controller.DefaultController;


@Controller
@RequestMapping("/siteinfo")
public class HtmlImportController  extends DefaultController{

	@Resource
	public SiteInfoService siteInfoService;
	
	@RequestMapping("sitesigal")
	public ModelAndView sitesigal(ModelAndView model,String cmd)
	{
		List<Order> orders = new ArrayList<Order>();
		orders.add(new Order(Direction.ASC,"jurisdictionsId"));
		List<AisSiteInfo> AisSiteInfos = siteInfoService.listAll(orders);
		List<SiteInfoDto> siteInfoDtos = new ArrayList<SiteInfoDto>();
		for(AisSiteInfo aisSiteInfo:AisSiteInfos)
		{
			SiteInfoDto siteInfoDto = new SiteInfoDto();
			siteInfoDto.setAgreementId(aisSiteInfo.getAgreementId());
			siteInfoDto.setAreaId(aisSiteInfo.getAreaId());
			siteInfoDto.setSitename(aisSiteInfo.getSitename());
			siteInfoDtos.add(siteInfoDto);
		}
		model.addObject("siteInfoDtos", siteInfoDtos);
		model.addObject("cmd", cmd);
		model.setViewName("/pages/map/sitesigal");
		return Model(model);
	}
	
	@RequestMapping("sitesigalsingle")
	public ModelAndView sitesigalsingle(ModelAndView model,String cmd)
	{
		List<Order> orders = new ArrayList<Order>();
		orders.add(new Order(Direction.ASC,"jurisdictionsId"));
		List<AisSiteInfo> AisSiteInfos = siteInfoService.listAll(orders);
		List<SiteInfoDto> siteInfoDtos = new ArrayList<SiteInfoDto>();
		for(AisSiteInfo aisSiteInfo:AisSiteInfos)
		{
			SiteInfoDto siteInfoDto = new SiteInfoDto();
			siteInfoDto.setAgreementId(aisSiteInfo.getAgreementId());
			siteInfoDto.setAreaId(aisSiteInfo.getAreaId());
			siteInfoDto.setSitename(aisSiteInfo.getSitename());
			siteInfoDtos.add(siteInfoDto);
		}
		model.addObject("siteInfoDtos", siteInfoDtos);
		model.addObject("cmd", cmd);
		model.setViewName("/pages/map/sitesigalsingle");
		return Model(model);
	}
	
	@RequestMapping("sitesendinfo")
	public ModelAndView sitesendinfo(ModelAndView model)
	{
		model.setViewName("/pages/map/sitesendinfo");
		return Model(model);
	}
	
	@RequestMapping("sixMsg")
	public ModelAndView sixMsg(ModelAndView model)
	{
		model.setViewName("/pages/map/six-msg");
		return Model(model);
	}
	
	@RequestMapping("sevenMsg")
	public ModelAndView sevenMsg(ModelAndView model)
	{
		model.setViewName("/pages/map/senven-msg");
		return Model(model);
	}
	
	@RequestMapping("aistable")
	public ModelAndView aistable(ModelAndView model)
	{
		model.setViewName("/pages/map/ais-table");
		return Model(model);
	}
}
