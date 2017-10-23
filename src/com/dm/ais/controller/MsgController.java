package com.dm.ais.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.model.ReportEntity;
import com.dm.ais.service.ReportService;
import com.dm.ais.service.SiteInfoService;
import com.dm.platform.controller.DefaultController;

@Controller
@RequestMapping("/siteinfo")
public class MsgController extends DefaultController{
	
	@Resource
	public SiteInfoService siteInfoService;
	@Resource
	public ReportService reportService;
	
	//智能配置还是高级配置的走向
	@RequestMapping("/msg/form/{siteInfoId}/{type}")
	public ModelAndView msgForm(ModelAndView model,
			@PathVariable String siteInfoId,
			@PathVariable String type) throws Exception {
		ReportEntity entity = new ReportEntity();
		
		if (siteInfoId != null && !siteInfoId.equals("")) {
			entity.setStatus("11");
			entity.setId("22");
			entity.setSiteInfoId("33");
		}
		model.addObject("entity", entity);
		model.addObject("siteInfoId", siteInfoId);
		if("2".equals(type)) {
			model.setViewName("/pages/ais/advanced/reportingRate");
		} else {
			model.setViewName("/pages/ais/intelligent/reportForm");
		}
		return Model(model);
	}

	@RequestMapping("/msg/saveSetting")
	public ModelAndView msgSaveSetting(ModelAndView model,
			ReportEntity entity) throws Exception {
		
			return Redirect(model, getRootPath() + "/siteinfo/list", "智能分配基站报文报告率设置成功！");
	}

}
