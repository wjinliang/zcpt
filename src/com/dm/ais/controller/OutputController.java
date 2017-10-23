package com.dm.ais.controller;

import java.io.IOException;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.OutputEntity;
import com.dm.ais.service.OutputService;
import com.dm.ais.service.SiteInfoService;
import com.dm.ais.util.AisPropertiesUtil;
import com.dm.ais.util.WebServiceTemplate;
import com.dm.platform.controller.DefaultController;

@Controller
@RequestMapping("/siteinfo")
public class OutputController extends DefaultController {
	
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
	public OutputService outputService;
	
	@RequestMapping("/output/form/{siteInfoId}")
	public ModelAndView outputForm(ModelAndView model,
			@PathVariable String siteInfoId) throws Exception {
		OutputEntity entity = new OutputEntity();
		if (siteInfoId != null && !siteInfoId.equals("")) {
			//String tempOutputType = "12";
			//for(int i=1; i<=tempOutputType.length(); i++) {
				//String outputType = tempOutputType.substring(i-1,i);
				entity = outputService.getEntityBySiteInfoIdAndByOutputType(siteInfoId);
				model.addObject("entity", entity);
			//}
		}
		model.addObject("siteInfoId", siteInfoId);
		model.setViewName("/pages/ais/advanced/vsifsr");
		return Model(model);
	}

	@RequestMapping("/output/saveSetting")
	public ModelAndView outputSaveSetting(ModelAndView model,
			OutputEntity entity) throws Exception {
		AisSiteInfo siteInfo = null;
		if (entity.getId() != null && !entity.getId().equals("")) {
			if(entity.getStatus().equals("0")) {
				outputService.update(entity);
			} else {
				siteInfo = siteInfoService.findById(entity.getSiteInfoId()) ;
				JSONObject jsonStatus = executeSetting(entity, siteInfo);
				if(jsonStatus.getInt("code")==0) {
					outputService.update(entity);
				}
			}
		} else {
			if(entity.getStatus().equals("0")) {
				outputService.insert(entity);
			} else {
				siteInfo = siteInfoService.findById(entity.getSiteInfoId()) ;
				JSONObject jsonStatus = executeSetting(entity, siteInfo);
				if(jsonStatus.getInt("code")==0) {
					outputService.insert(entity);
				}
			}
		}
		return Redirect(model, getRootPath() + "/siteinfo/output/form/" + entity.getSiteInfoId(), "更新设置成功！");
	}
	
	/**
	 * 设置VSI语句的输出,设置FSR语句的输出
	 * @param outputEntity
	 * @param siteInfo
	 * @return
	 * @throws HttpException
	 * @throws IOException
	 */
	public JSONObject executeSetting(OutputEntity outputEntity, AisSiteInfo siteInfo) throws HttpException, IOException {
		// 创建 Http client
		HttpClient client = new HttpClient();
		
		// 封装表单数据
		PostMethod post = null;
		
		String msgId = outputEntity.getOutputType();
		if(msgId!="" && msgId!=null) {
			if("1".equals(msgId)) {
				post = new PostMethod(createUrl(AisPropertiesUtil.getInstance().getProperty("site_vsi_output_url")));
				post.addParameter("idCode", siteInfo.getAgreementId());
				post.addParameter("uid", siteInfo.getUid());
				post.addParameter("channel", outputEntity.getChannel());
				post.addParameter("signalStrength", outputEntity.getSignalStrength()+"");
				post.addParameter("firstSlotNum", outputEntity.getFirstSlotNum()+"");
				post.addParameter("msgArriveTime", outputEntity.getMsgArriveTime()+"");
				post.addParameter("signalNoiseRatio", outputEntity.getSignalNoiseRatio()+"");
				post.addParameter("vdmSentence", outputEntity.getVdmSentence()+"");
				post.addParameter("vdoSentence", outputEntity.getVdoSentence()+"");
				System.out.println("VSI");
			} else if("2".equals(msgId)) {
				post = new PostMethod(createUrl(AisPropertiesUtil.getInstance().getProperty("site_fsr_output_url")));
				post.addParameter("idCode", siteInfo.getAgreementId());
				post.addParameter("uid", siteInfo.getUid());
				post.addParameter("channel", outputEntity.getChannel());
				post.addParameter("channelLoad", outputEntity.getChannelLoad()+"");
				post.addParameter("badCRCMsgNum", outputEntity.getBadCRCMsgNum()+"");
				post.addParameter("forecastChannelLoad", outputEntity.getForecastChannelLoad()+"");
				post.addParameter("avarageNoiseLevel", outputEntity.getAvarageNoiseLevel()+"");
				post.addParameter("signalStrength", outputEntity.getSignalStrength()+"");
				post.addParameter("fsrSentenceOfAfterFrame", outputEntity.getFsrSentenceOfAfterFrame()+"");
				System.out.println("FSR");
			} 
		}

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
	
	//===================================================
	//回显VSI FSR
	@RequestMapping("/advanced/output/form/{siteInfoId}")
	public ModelAndView outputAdvancedForm(ModelAndView model,
			@PathVariable String siteInfoId) throws Exception {
		OutputEntity entity = new OutputEntity();
		if (siteInfoId != null && !siteInfoId.equals("")) {
			//String tempOutputType = "12";
			//for(int i=1; i<=tempOutputType.length(); i++) {
				//String outputType = tempOutputType.substring(i-1,i);
				entity = outputService.getEntityBySiteInfoIdAndByOutputType(siteInfoId);
				model.addObject("entity", entity);
			//}
		}
		AisSiteInfo aisSiteInfo = new AisSiteInfo();
		aisSiteInfo = siteInfoService.findById(siteInfoId);
		String agreementid = aisSiteInfo.getAgreementId();
		model.addObject("agreementid", agreementid);
		model.addObject("siteInfoId", siteInfoId);
		model.setViewName("/pages/ais/advanced/vsifsr");
		return Model(model);
	}

	//保存VSI FSR  	高级配置 调用接口1-7  VSI FSR
	@RequestMapping("/advanced/output/saveSetting")
	public ModelAndView outputAdvnacedSaveSetting(ModelAndView model,
			OutputEntity entity) throws Exception {
		System.out.println("------------------");
		String info = "更新设置成功！";
		if (entity.getId() != null && !entity.getId().equals("")) {
			JSONObject jsonObject = WebServiceTemplate.getInstance().testSPOSetFull(entity);
			if(jsonObject.getInt("code")==0) {
			outputService.update(entity);
			}else {
				info = "更新设置失败！";
			}
		} else {
			JSONObject jsonObject = WebServiceTemplate.getInstance().testSPOSetFull(entity);
			if(jsonObject.getInt("code")==0) {
			outputService.insert(entity);
			}else {
				info = "更新设置失败！";
			}
		}
		return Redirect(model, getRootPath() + "/siteinfo/advanced/output/form/" + entity.getSiteInfoId(), info);
	}
}
