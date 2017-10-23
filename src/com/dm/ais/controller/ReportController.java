package com.dm.ais.controller;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.dto.ReportDto;
import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.ReportEntity;
import com.dm.ais.model.SettingEntity;
import com.dm.ais.service.ReportService;
import com.dm.ais.service.SettingService;
import com.dm.ais.service.SiteInfoService;
import com.dm.ais.util.WebServiceTemplate;
import com.dm.platform.controller.DefaultController;
import com.sun.xml.internal.ws.resources.ModelerMessages;

@Controller
@RequestMapping("/siteinfo")
public class ReportController extends DefaultController{
	
	@Resource
	public SiteInfoService siteInfoService;
	@Resource
	public ReportService reportService;
	@Resource
	public SettingService settingService;
	
	//智能配置 4号和20号报文
	@RequestMapping("/report/intelligent/form/{siteInfoId}")
	public ModelAndView reportIntelligentForm(ModelAndView model,
			@PathVariable String siteInfoId) throws Exception {
		ReportEntity entity = new ReportEntity();
		if (siteInfoId != null && !siteInfoId.equals("")) {
			String tempReportRatesForMsgType = "13";
			for(int i=1; i<=tempReportRatesForMsgType.length(); i++) {
				String reportRatesForMsgType = tempReportRatesForMsgType.substring(i-1,i);
				entity = reportService.getEntityBySiteInfoIdAndReportRatesForMsgType(siteInfoId, reportRatesForMsgType);
				model.addObject("entity" + reportRatesForMsgType, entity);
			}
		}
		model.addObject("siteInfoId", siteInfoId);
		model.setViewName("/pages/ais/intelligent/reportForm");
		return Model(model);
	}
	
	//高级配置 4号 17号 20号报文
	@RequestMapping("/report/advanced/form/{siteInfoId}")
	public ModelAndView reportAdvancedForm(ModelAndView model,
			@PathVariable String siteInfoId) throws Exception {
		ReportEntity entity = new ReportEntity();
		if (siteInfoId != null && !siteInfoId.equals("")) {
			String tempReportRatesForMsgType = "123";
			for(int i=1; i<=tempReportRatesForMsgType.length(); i++) {
				String reportRatesForMsgType = tempReportRatesForMsgType.substring(i-1,i);
				entity = reportService.getEntityBySiteInfoIdAndReportRatesForMsgType(siteInfoId, reportRatesForMsgType);
				model.addObject("entity" + reportRatesForMsgType, entity);
			}
		}
		AisSiteInfo aisSiteInfo = new AisSiteInfo();
		aisSiteInfo = siteInfoService.findById(siteInfoId);
		String agreementid = aisSiteInfo.getAgreementId();
		model.addObject("agreementid", agreementid);
		model.addObject("siteInfoId", siteInfoId);
		model.setViewName("/pages/ais/advanced/reportingRate");
		return Model(model);
	}

	//智能保存
	@RequestMapping("/report/intelligent/saveSetting")
	public ModelAndView reportIntelligentSaveSetting(ModelAndView model,
			ReportDto entity) throws Exception {
		
		ReportEntity reportEntity4 = new ReportEntity();
		reportEntity4 = reportService.getEntityBySiteInfoIdAndReportRatesForMsgType(entity.getSiteInfoId4(), "1");
		
		ReportEntity reportEntity20 = new ReportEntity();
		reportEntity20 = reportService.getEntityBySiteInfoIdAndReportRatesForMsgType(entity.getSiteInfoId20(), "3");
		
		AisSiteInfo aisSiteInfo = new AisSiteInfo();
		SettingEntity settingEntity = new SettingEntity();
		aisSiteInfo = siteInfoService.findByAgreementId(entity.getAgreementid());
		settingEntity = settingService.getEntityBySiteInfoId(entity.getSiteInfoId4());
		String info = "智能分配基站报文报告率设置成功！";
		JSONObject jsonObject1 = WebServiceTemplate.getInstance().testBCFSetFull(settingEntity,aisSiteInfo);  //ceshi1-4
		JSONObject jsonObject2 = WebServiceTemplate.getInstance().testECBSetFull(reportEntity4);
		JSONObject jsonObject3 = WebServiceTemplate.getInstance().testECBSetFull(reportEntity20);
		
		if(jsonObject1.getInt("code")==0) {
			if (jsonObject2.getInt("code")==0) {
				if (jsonObject3.getInt("code")==0) {
					info = "智能分配基站报文报告率设置成功！";
				}else {
					info = "智能分配基站报文报告率设置失败！";
				}
			}else {
				info = "智能分配基站报文报告率设置失败！";
			}
		}else {
			info = "智能分配基站报文报告率设置失败！";
		}
		return Redirect(model, getRootPath() + "/siteinfo/list", info);
	}
	
	//高级保存设置  ceshi1-4
	@RequestMapping("/report/advanced/saveSetting")
	public ModelAndView reportAdvancedSaveSetting(ModelAndView model,
			ReportEntity entity) throws Exception {
		System.out.println("高级管理Reporting Rates 调用1-4");
		String info = "更新设置成功！";
		AisSiteInfo siteInfo = null;
		if (entity.getId() != null && !entity.getId().equals("")) {
			siteInfo = siteInfoService.findById(entity.getSiteInfoId()) ;
			entity.setUid(siteInfo.getSitename());   //sitename == uid
				JSONObject jsonObject = WebServiceTemplate.getInstance().testECBSetFull(entity);
				if(jsonObject.getInt("code")==0) {
					reportService.update(entity);
				}else
					info = "更新设置失败！";
		} else {
			siteInfo = siteInfoService.findById(entity.getSiteInfoId()) ;
			entity.setUid(siteInfo.getSitename());   //sitename == uid
				JSONObject jsonObject = WebServiceTemplate.getInstance().testECBSetFull(entity);
				if(jsonObject.getInt("code")==0) {
					reportService.insert(entity);
				}else {
					//info = "更新设置失败！";
				}
		}
		return Redirect(model, getRootPath() + "/siteinfo/report/advanced/form/" + entity.getSiteInfoId(), info);
	}

}
