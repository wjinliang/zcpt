package com.dm.ais.util;

import javax.annotation.Resource;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;


import com.dm.ais.service.SiteInfoService;

public class CacheUtil {

	
	@Resource
	SiteInfoService siteInfoService;
	@Resource
	Cache myCache;
	
	
	public void put()
	{
		System.out.println(siteInfoService);
		Long count = 67L;
		Element element = new Element("sitecount", "1111"); 
		myCache.put(element);
	}
	public Object get(Object key)
	{
		Element el = myCache.get(key);
		return el.getObjectValue();
	}
}
