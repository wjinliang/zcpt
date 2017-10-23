package com.dm.ais.controller;

import java.io.IOException;

import javax.annotation.PostConstruct;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dm.ais.util.AisPropertiesUtil;
import com.dm.platform.util.ReadProperties;

@Controller
@RequestMapping("/dataMsg")
public class DataMsgController {
	
	public final String webServiceMEB_setMebForMessage12="/meb/setMebForMessage12";
	@RequestMapping("/twelveSite")
	@ResponseBody
	public Object twelveSite(String idCode,String channel,String mmsi,String messageIDIndex,
			String broadcastBehaviour,String destinationMMSI,String binaryDataFlag,
			String sentenceStatusFlag,String repeatIndicator,String sourceID,
			String sequenceNumber,String destinationID,String retransmitFlag,
			String text
			) throws HttpException, IOException
	{
		PostMethod post = new PostMethod(getIpAddress() + webServiceMEB_setMebForMessage12);
		post.addParameter("idCode", idCode);
		post.addParameter("channel", channel);    //0-3
		post.addParameter("mmsi", mmsi);    //int
		post.addParameter("messageIDIndex",messageIDIndex); //String
		post.addParameter("broadcastBehaviour", broadcastBehaviour);  //0-9 
		post.addParameter("destinationMMSI", destinationMMSI);    //int
		post.addParameter("binaryDataFlag", binaryDataFlag);  //0-1
		post.addParameter("sentenceStatusFlag", sentenceStatusFlag);  //R C
		post.addParameter("repeatIndicator", repeatIndicator);  //0-3
		post.addParameter("sourceID", sourceID);
		post.addParameter("sequenceNumber", sequenceNumber);   //0-3
		post.addParameter("destinationID", destinationID);
		post.addParameter("retransmitFlag", retransmitFlag);  //0-1
		post.addParameter("text", text);  //6位ASCII码 小于6968
		return executePost(post);
	}
	
	@RequestMapping("/forteenSite")
	@ResponseBody
	public Object forteenSite(String idCode,String channel,String mmsi,String messageIDIndex,
			String broadcastBehaviour,String destinationMMSI,String binaryDataFlag,
			String sentenceStatusFlag,String repeatIndicator,String sourceID,
			String sequenceNumber,String destinationID,String retransmitFlag,
			String text
			) throws HttpException, IOException
	{
		PostMethod post = new PostMethod(getIpAddress() + webServiceMEB_setMebForMessage12);
		post.addParameter("idCode", idCode);
		post.addParameter("channel", channel);    //0-3
		post.addParameter("mmsi", mmsi);    //int
		post.addParameter("messageIDIndex",messageIDIndex); //String
		post.addParameter("broadcastBehaviour", broadcastBehaviour);  //0-9 
		post.addParameter("destinationMMSI", destinationMMSI);    //int
		post.addParameter("binaryDataFlag", binaryDataFlag);  //0-1
		post.addParameter("sentenceStatusFlag", sentenceStatusFlag);  //R C
		post.addParameter("repeatIndicator", repeatIndicator);  //0-3
		post.addParameter("sourceID", sourceID);
		post.addParameter("sequenceNumber", sequenceNumber);   //0-3
		post.addParameter("destinationID", destinationID);
		post.addParameter("retransmitFlag", retransmitFlag);  //0-1
		post.addParameter("text", text);  //6位ASCII码 小于6968
		return executePost(post);
	}

	@RequestMapping("/twelveBoat")
	@ResponseBody
	public Object twelveBoat(String idCode,String channel,String mmsi,String messageIDIndex,
			String broadcastBehaviour,String destinationMMSI,String binaryDataFlag,
			String sentenceStatusFlag,String repeatIndicator,String sourceID,
			String sequenceNumber,String destinationID,String retransmitFlag,
			String text
			) throws HttpException, IOException
	{
		PostMethod post = new PostMethod(getIpAddress() + webServiceMEB_setMebForMessage12);
		post.addParameter("idCode", idCode);
		post.addParameter("channel", channel);    //0-3
		post.addParameter("mmsi", mmsi);    //int
		post.addParameter("messageIDIndex",messageIDIndex); //String
		post.addParameter("broadcastBehaviour", broadcastBehaviour);  //0-9 
		post.addParameter("destinationMMSI", destinationMMSI);    //int
		post.addParameter("binaryDataFlag", binaryDataFlag);  //0-1
		post.addParameter("sentenceStatusFlag", sentenceStatusFlag);  //R C
		post.addParameter("repeatIndicator", repeatIndicator);  //0-3
		post.addParameter("sourceID", sourceID);
		post.addParameter("sequenceNumber", sequenceNumber);   //0-3
		post.addParameter("destinationID", destinationID);
		post.addParameter("retransmitFlag", retransmitFlag);  //0-1
		post.addParameter("text", text);  //6位ASCII码 小于6968
		return executePost(post);
	}
	
	
	public Object executePost(PostMethod post) throws HttpException, IOException {
		HttpClient client = new HttpClient();
		HttpMethodParams params = post.getParams();
		params.setContentCharset("utf-8");
		JSONObject jsonObject = new JSONObject();
		int status = client.executeMethod(post);
		if(status!=200) {
			jsonObject.put("status", status);
		} else {
			String body = post.getResponseBodyAsString();
			System.out.println(body);
			jsonObject = JSONObject.fromObject(body);
			jsonObject.put("status", status);
		}
		System.out.println(jsonObject);
		return jsonObject;
	}
	
	public String getIpAddress()
	{
	  return AisPropertiesUtil.getInstance().getProperty("http");
	}
}
