package com.app.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

public class SynUtil {
	public static final String LIANTONG= "liantongIP";
	public static final String DIANXIN= "dianxinIP";
	
	public String getSynInfo(String key) throws IOException{
		Properties prop = new Properties();
		InputStream in = SynUtil.class.getResourceAsStream("syn.properties");
		prop.load(in);
		String value = (String)prop.get(key);
		in.close();
		return value;
	}
	public String getIPType(HttpServletRequest request) throws IOException{
		String ip = request.getServerName();
		String liantongIP = getSynInfo(LIANTONG);
		String yidongIP = getSynInfo(DIANXIN);
		if(ip!=null && ip.equalsIgnoreCase(liantongIP)){
			return LIANTONG;
		}
		if(ip!=null && ip.equalsIgnoreCase(yidongIP)){
			return DIANXIN;
		}
		return null;
	}
	public static void main(String[] args) throws IOException {
		SynUtil syn = new SynUtil();
		System.out.println(syn.getSynInfo("messageUrl"));
		String qqq="-@-@";
		String[] split = qqq.split("@");
		System.out.println(split.length);
		System.out.println(split[0]);
	}
}
