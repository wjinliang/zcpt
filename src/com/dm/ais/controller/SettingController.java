package com.dm.ais.controller;

import java.io.IOException;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.SettingEntity;
import com.dm.ais.service.SettingService;
import com.dm.ais.service.SiteInfoService;
import com.dm.ais.util.AisPropertiesUtil;
import com.dm.ais.util.WebServiceTemplate;
import com.dm.platform.controller.DefaultController;

@Controller
@RequestMapping("/siteinfo")
public class SettingController extends DefaultController {

	// 服务器地址
	private static String host = AisPropertiesUtil.getInstance().getProperty("host");
	
	/**
	 * 包装请求地址
	 * 
	 * @param path
	 * @return
	 */ 
	private static String createUrl(String path) {
		return host + path;
	}
	
	@Resource
	public SiteInfoService siteInfoService;
	@Resource
	public SettingService settingService;
	
	//智能配置还是高级配置的走向
	@RequestMapping("/setting/form/{siteInfoId}/{type}")
	public ModelAndView settingForm(ModelAndView model,
			@PathVariable String siteInfoId, 
			@PathVariable String type) throws Exception {
		SettingEntity entity = new SettingEntity();
		if (siteInfoId != null && !siteInfoId.equals("")) {
			entity = settingService.getEntityBySiteInfoId(siteInfoId);
		}
		model.addObject("entity", entity);
		model.addObject("siteInfoId", siteInfoId);
		if("0".equals(type)) {
			model.setViewName("/pages/ais/intelligent/settingform");
		} else {
			model.setViewName("/pages/ais/advanced/general");
		}
		return Model(model);
	}
	
	//智能配置基站信息 的下一步  
	@RequestMapping("/setting/nextConfigure")
	public ModelAndView nextConfigure(ModelAndView model, 
			SettingEntity entity) throws Exception {
		try {
			if (entity.getId() != null && !entity.getId().equals("")) {
				SettingEntity settingEntity = settingService.getEntityBySiteInfoId(entity.getSiteInfoId());
				String mmsivalue = StringUtils.leftPad(entity.getMmsi(), 9, "0");
				settingEntity.setMmsi(mmsivalue);
					settingService.update(settingEntity);
			} else {
				SettingEntity settingEntity = settingService.getEntityBySiteInfoId(entity.getSiteInfoId());
				String mmsivalue = StringUtils.leftPad(entity.getMmsi(), 9, "0");
				settingEntity.setMmsi(mmsivalue);
					settingService.insert(settingEntity);
			}
			model.addObject("siteInfoId", entity.getSiteInfoId());
			return Redirect(model, getRootPath() + "/siteinfo/report/intelligent/form/" + entity.getSiteInfoId(), "");
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	
	//直接点击高级配置进入配置页面
	@RequestMapping("/general/form/{siteInfoId}")
	public ModelAndView generalForm(ModelAndView model,
			@PathVariable String siteInfoId) throws Exception {
		SettingEntity entity = new SettingEntity();
		if (siteInfoId != null && !siteInfoId.equals("")) {
			entity = settingService.getEntityBySiteInfoId(siteInfoId);
		}
		model.addObject("entity", entity);
		model.addObject("siteInfoId", siteInfoId);
		model.setViewName("/pages/ais/advanced/general");
		return Model(model);
	}
	
	//直接点击高级配置保存数据
	@RequestMapping("/setting/generalSetting")
	public ModelAndView generalSetting(ModelAndView model,
			SettingEntity entity) throws Exception {
		String info = "设置成功！";
		System.out.println("高级配置-General调用1-1");
		System.out.println("传递的数据ID="+entity.getSiteInfoId());
		AisSiteInfo aisSiteInfo = siteInfoService.findById(entity.getSiteInfoId());
		//SettingEntity settingEntity = settingService.getEntityBySiteInfoId(entity.getSiteInfoId());
		String mmsivalue = StringUtils.leftPad(entity.getMmsi(), 9, "0");
		entity.setMmsi(mmsivalue);
		if (entity.getId() != null && !entity.getId().equals("")) {
				JSONObject jsonObject = WebServiceTemplate.getInstance().testBCFSetFull(entity,aisSiteInfo);
				if(jsonObject.getInt("code")==0) {
					settingService.update(entity);
				}else {
					info = "设置失败！";
				}
		} else {
				JSONObject jsonObject = WebServiceTemplate.getInstance().testBCFSetFull(entity,aisSiteInfo);
				if(jsonObject.getInt("code")==0) {
					settingService.insert(entity);
				}else {
					//info = "设置失败！";
				}
		}
		return Redirect(model, getRootPath() + "/siteinfo/general/form/" + entity.getSiteInfoId(), info);
	}
	
	/**
	 * 基站设置
	 * @param settingEntity
	 * @return
	 * @throws HttpException
	 * @throws IOException
	 */
	public JSONObject executeSetting(SettingEntity settingEntity, String idCode) throws HttpException, IOException {
		// 创建 Http client
		HttpClient client = new HttpClient();
		
		// 封装表单数据
		PostMethod post = new PostMethod(createUrl(AisPropertiesUtil.getInstance().getProperty("site_position_url")));
		post.addParameter("idCode", idCode);
		post.addParameter("mmsi", settingEntity.getMmsi()+"");
		post.addParameter("positionSource", settingEntity.getPositionSource()+"");
		post.addParameter("lat", settingEntity.getLat());
		post.addParameter("latType", settingEntity.getLatType());
		post.addParameter("lon", settingEntity.getLon());
		post.addParameter("lonType", settingEntity.getLonType());
		post.addParameter("highAccuracy", settingEntity.getHighAccuracy()+"");
		post.addParameter("rxChannelA", settingEntity.getRxChannelA()+"");
		post.addParameter("rxChannelB", settingEntity.getRxChannelB()+"");
		post.addParameter("txChannelA", settingEntity.getTxChannelA()+"");
		post.addParameter("txChannelB", settingEntity.getTxChannelB()+"");
		post.addParameter("highPowerA", settingEntity.getHighPowerA()+"");
		post.addParameter("highPowerB", settingEntity.getHighPowerB()+"");
		post.addParameter("retriesNumber", settingEntity.getRetriesNumber()+"");
		post.addParameter("repeatIndicator", settingEntity.getRepeatIndicator()+"");
		post.addParameter("talkerID", settingEntity.getTalkerID());
		
		// 执行请求
		int status = client.executeMethod(post);
		
		// 判断返回状态
		Assert.isTrue(HttpStatus.SC_OK == status);

		// 将返回值转换为string json串
		String body = post.getResponseBodyAsString();
		
		System.out.println(body);
		
		JSONObject jo = JSONObject.fromObject(body);
		
		return jo;
	}
	
}
