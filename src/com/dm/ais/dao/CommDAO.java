package com.dm.ais.dao;

import java.util.List;
import java.util.Map;

public abstract interface CommDAO {

	public abstract <T> List<T> findByPropertyName(Class<T> paramClass,
			String paramString, Object paramObject);

	public abstract <T> List<T> findByPropertyName(Class<T> paramClass,
			String[] paramArrayOfString, Object[] paramArrayOfObject);

	public abstract List getListbySql(final String queryString);
	
	public abstract List findByPage(final String queryString, final int thispage, final int pagesize);
	
	public abstract <T> Long count(final String queryString);

	public abstract <T> List<T> getListbySql(Class<T> paramClass, String sql);

	public abstract <T> List<T> findByPage(
			Class<T> class1, String sql, Integer thispage,
			Integer pagesize);
	public abstract List<Map> findByPageToMap(String sql, Integer thispage,
			Integer pagesize);

}
