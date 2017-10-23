package com.dm.ais.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.DlmEntity;
import com.dm.ais.service.DlmService;
import com.dm.ais.service.SiteInfoService;
import com.dm.ais.util.WebServiceTemplate;
import com.dm.platform.controller.DefaultController;

@Controller
@RequestMapping("/siteinfo")
public class DlmController extends DefaultController {

	@Resource
	public SiteInfoService siteInfoService;
	@Resource
	public DlmService dlmService;
	
	@RequestMapping("/setting/dlmForm/{siteInfoId}")
	public ModelAndView asnForm(ModelAndView model, @PathVariable String siteInfoId) throws Exception {
		DlmEntity entity = new DlmEntity();
		if (siteInfoId != null && !siteInfoId.equals("")) {
			String tempChannelType = "AB";
			for(int i=1; i<=tempChannelType.length(); i++) {
				String channelType = tempChannelType.substring(i-1,i);
				for(int j=1; j<=4; j++) {
					entity = dlmService.getEntityBySiteInfoIdAndChannelTypeAndReservation(siteInfoId, channelType, j+"");
					model.addObject("entity" + channelType + j, entity);
				}
			}
		}
//		if (siteInfoId != null && !siteInfoId.equals("")) {
//			entity = dlmService.getEntityBySiteInfoId(siteInfoId);
//		}
//		model.addObject("entity", entity);
		model.addObject("siteInfoId", siteInfoId);
		model.setViewName("/pages/ais/dataLinkManagement");
		return Model(model); 
	}

	@RequestMapping("/dlm/saveSetting")
	public ModelAndView asnSaveSetting(ModelAndView model, DlmEntity entity) throws Exception {
		if (entity.getId() != null && !entity.getId().equals("")) {
			dlmService.update(entity);
		} else {
			dlmService.insert(entity);
		}
		return Redirect(model, getRootPath() + "/siteinfo/setting/dlmForm/" + entity.getSiteInfoId(), "更新设置成功！");
	}
	
//===============================================
	@RequestMapping("/setting/advanced/dlmForm/{siteInfoId}")
	public ModelAndView dlmForm(ModelAndView model, @PathVariable String siteInfoId) throws Exception {
		DlmEntity entity = new DlmEntity();
		String tempChannelType = "AB";
		for(int i=1; i<=tempChannelType.length(); i++) {
			String channelType = tempChannelType.substring(i-1,i);
			for(int j=1; j<=40; j++) {
				entity = dlmService.getEntityBySiteInfoIdAndChannelTypeAndSeqNumber(siteInfoId, channelType, j+"");
				if(entity!=null) {
					model.addObject("entity" + channelType + j, entity);
				}
			}
		}
		model.addObject("siteInfoId", siteInfoId);
		model.setViewName("/pages/ais/advanced/dataLinkManagement");
		return Model(model); 
	}

	@RequestMapping("/advanced/dlmForm/saveSetting")
	public ModelAndView dlmSaveSetting(ModelAndView model, DlmEntity entity) throws Exception {
		String info = "保存成功!";
		DlmEntity tempEntity = new DlmEntity();
		if(!entity.equals(null) && entity!=null) {
			tempEntity = dlmService.getEntityBySiteInfoIdAndChannelTypeAndSeqNumber(entity.getSiteInfoId(), entity.getChannelType(), entity.getSeqNumber());
			if(tempEntity!=null) {
				entity.setId(tempEntity.getId());
				dlmService.update(entity);
				info = "更新成功!";
			} else {
				dlmService.insert(entity);
			}
		}
		return Redirect(model, getRootPath() + "/siteinfo/setting/advanced/dlmForm/" + entity.getSiteInfoId(), info);
	}
	
	@RequestMapping("/advanced/showDlmEntity")
	public void selectDlmEntity(HttpServletResponse response, String siteInfoId, String channelType,
			String seqNumber) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		DlmEntity entity = new DlmEntity();
		try {
			entity = dlmService.getEntityBySiteInfoIdAndChannelTypeAndSeqNumber(siteInfoId, channelType, seqNumber);
			Map<String, Object> map=new HashMap<String, Object>();//传递Map
			map.put("entity", entity);
			JSONObject jsonEntity = JSONObject.fromObject(map);
			out.println(jsonEntity);
			out.flush();
			out.close();
		} catch (Exception e) {
			out.write("error");
			out.flush();
			out.close();
		}
	}
	
//================================================2-4

	@RequestMapping("/advanced/dlmForm/save")
	public ModelAndView dlmSave(ModelAndView model, HttpServletRequest request) throws Exception {
		String siteInfoId = request.getParameter("siteInfoId");
		String status = request.getParameter("status");
		AisSiteInfo aisSiteInfo = siteInfoService.findById(siteInfoId);
		String agreementId = aisSiteInfo.getAgreementId();
		
		int number = Integer.parseInt(request.getParameter("number"));
		String[] idArray = request.getParameterValues("id");
		
		String[] startSlotArray = request.getParameterValues("startSlot");
		String[] incrementArray = request.getParameterValues("increment");
		String[] slotNumberArray = request.getParameterValues("slotNumber");
		String[] ownershipArray = request.getParameterValues("ownership");
		String[] timeoutArray = request.getParameterValues("timeout");
		
		int reservation = 1;
		for(int i=0; i<4; i++) {
			DlmEntity entityA = new DlmEntity();
			entityA.setSiteInfoId(siteInfoId);
			entityA.setId(idArray[i]);
			entityA.setChannelType("A");
			entityA.setReservation(String.valueOf(reservation));
			entityA.setSeqNumber(String.valueOf((number-1)*4+i+1));
			entityA.setStartSlot(Integer.parseInt(startSlotArray[i]));
			entityA.setIncrement(Integer.parseInt(incrementArray[i]));
			entityA.setSlotNumber(Integer.parseInt(slotNumberArray[i]));
			entityA.setOwnership(ownershipArray[i]);
			entityA.setTimeout(Integer.parseInt(timeoutArray[i]));
			
			DlmEntity entityB = new DlmEntity();
			entityB.setSiteInfoId(siteInfoId);
			entityB.setId(idArray[i+4]);
			entityB.setChannelType("B");
			entityB.setReservation(String.valueOf(reservation));
			entityB.setSeqNumber(String.valueOf((number-1)*4+i+1));
			entityB.setStartSlot(Integer.parseInt(startSlotArray[i+4]));
			entityB.setIncrement(Integer.parseInt(incrementArray[i+4]));
			entityB.setSlotNumber(Integer.parseInt(slotNumberArray[i+4]));
			entityB.setOwnership(ownershipArray[i+4]);
			entityB.setTimeout(Integer.parseInt(timeoutArray[i+4]));
			
			if(entityA.getId()!=null && entityA.getId()!="") {
				dlmService.update(entityA);
			} else {
				dlmService.insert(entityA);
			}
			
			if(entityB.getId()!=null && entityB.getId()!="") {
				dlmService.update(entityB);
			} else {
				dlmService.insert(entityB);
			}
			//if(status.equals("1")) {
				if(reservation==1) {
					WebServiceTemplate.getInstance().testSetChADataLinkForReservation1(entityA, agreementId);
					WebServiceTemplate.getInstance().testSetChBDataLinkForReservation1(entityB, agreementId);
				} else if(reservation==2) {
					WebServiceTemplate.getInstance().testSetChADataLinkForReservation2(entityA, agreementId);
					WebServiceTemplate.getInstance().testSetChBDataLinkForReservation2(entityB, agreementId);
				} else if(reservation==3) {
					WebServiceTemplate.getInstance().testSetChADataLinkForReservation3(entityA, agreementId);
					WebServiceTemplate.getInstance().testSetChBDataLinkForReservation3(entityB, agreementId);
				} else if(reservation==4) {
					WebServiceTemplate.getInstance().testSetChADataLinkForReservation4(entityA, agreementId);
					WebServiceTemplate.getInstance().testSetChBDataLinkForReservation4(entityB, agreementId);
				}
			//}
			reservation = reservation + 1;
		}
		
		String info = "保存成功!";
		
		return Redirect(model, getRootPath() + "/siteinfo/setting/advanced/dlmForm/" + siteInfoId, info);
	}
}
