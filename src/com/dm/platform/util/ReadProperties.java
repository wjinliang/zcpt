package com.dm.platform.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ReadProperties {
	private static ReadProperties instance = new ReadProperties();
	public Properties props = null;
	private ReadProperties() { 
		init();
	}  
	
	private void init(){
		props = new Properties();
		InputStream in = ReadProperties.class
				.getResourceAsStream("/dm.properties");
		try {
			props.load(in);
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				in.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public static ReadProperties getInstance() {
		 return instance;
	}
	public String getProperties(String key) throws IOException {
		try {
			if(props==null){
				init();
			}
			if (props.isEmpty()) {
				return null;
			} else {
				return props.getProperty(key).toString();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
