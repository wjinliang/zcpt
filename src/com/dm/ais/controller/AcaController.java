package com.dm.ais.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.model.AcaEntity;
import com.dm.ais.service.AcaService;
import com.dm.platform.controller.DefaultController;

@Controller
@RequestMapping("/siteinfo")
public class AcaController extends DefaultController {

	@Resource
	public AcaService acaService;
	
	@RequestMapping("/setting/acaForm/{siteInfoId}")
	public ModelAndView acmForm(ModelAndView model, @PathVariable String siteInfoId) throws Exception {
		AcaEntity entity = new AcaEntity();
		if (siteInfoId != null && !siteInfoId.equals("")) {
			entity = acaService.getEntityBySiteInfoId(siteInfoId);
		}
		model.addObject("entity", entity);
		model.addObject("siteInfoId", siteInfoId);
		model.setViewName("/pages/ais/channelManagement");
		return Model(model);
	}

	@RequestMapping("/aca/saveSetting")
	public ModelAndView acmSaveSetting(ModelAndView model, AcaEntity entity) throws Exception {
		if (entity.getId() != null && !entity.getId().equals("")) {
			acaService.update(entity);
		} else {
			acaService.insert(entity);
		}
		return Redirect(model, getRootPath() + "/siteinfo/setting/acaForm/" + entity.getSiteInfoId(), "更新设置成功！");
	}
	
	//==================================================
	@RequestMapping("/setting/advanced/acaForm/{siteInfoId}")
	public ModelAndView channelManagerForm(ModelAndView model, @PathVariable String siteInfoId) throws Exception {
		AcaEntity entity = new AcaEntity();
		if (siteInfoId != null && !siteInfoId.equals("")) {
			entity = acaService.getEntityBySiteInfoIdAndSeqNumber(siteInfoId, "1");
		}
		model.addObject("entity", entity);
		model.addObject("siteInfoId", siteInfoId);
		model.setViewName("/pages/ais/advanced/channelManagement");
		return Model(model);
	}

	@RequestMapping("/advanced/aca/saveSetting")
	public ModelAndView channelSaveSetting(ModelAndView model, AcaEntity entity) throws Exception {
		String info = "保存成功!";
		AcaEntity tempEntity = new AcaEntity();
		if(!entity.equals(null) && entity!=null) {
			tempEntity = acaService.getEntityBySiteInfoIdAndSeqNumber(entity.getSiteInfoId(), entity.getSeqNumber());
			if(tempEntity!=null) {
				entity.setId(tempEntity.getId());
				acaService.update(entity);
				info = "更新成功!";
			} else {
				acaService.insert(entity);
			}
		}
		return Redirect(model, getRootPath() + "/siteinfo/setting/advanced/acaForm/" + entity.getSiteInfoId(), "更新设置成功！");
	}
	
	@RequestMapping("/advanced/showAcaEntity")
	public void selectAcaEntity(HttpServletResponse response, String siteInfoId, String channelType,
			String seqNumber) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		AcaEntity entity = new AcaEntity();
		try {
			entity = acaService.getEntityBySiteInfoIdAndSeqNumber(siteInfoId,seqNumber);
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
}
