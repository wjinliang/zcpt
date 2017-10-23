package com.dm.ais.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
/**
 * 读取properties配置文件
 * @author using
 */
public class AisPropertiesUtil extends Properties {
	
	private static final long serialVersionUID = 4050286969860894155L;
	
	private static  AisPropertiesUtil instance;

    public static AisPropertiesUtil getInstance () {
        if(null != instance) {
            return instance;
        } else {
            makeInstance();
            return instance;
        }
    }

    private static synchronized void makeInstance() {
        if(instance == null) {
            instance = new AisPropertiesUtil();
        }
    }

    private AisPropertiesUtil() {
        InputStream is = getClass().getResourceAsStream("/interface.properties");
        try {
            load(is);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}