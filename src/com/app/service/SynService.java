package com.app.service;

import java.util.List;

import com.app.model.ApplicationInfo;
import com.app.model.SynLog;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;

public interface SynService {
	public abstract Long countAppAccount();
	
	public abstract List<ApplicationInfo> listAppAccount( int thispage, int pagesize);

	public abstract void deleteApp(ApplicationInfo findOne);

	public abstract String synStart(String appId, String infoCode, String opType);

	public abstract Long countSynLogAccount(String mhss);

	public abstract List<SynLog> listSynLogAccount(Integer thispage,
			Integer pagesize,String mhss);

	public abstract Long getSynUserApp(UserAccount currentUserAccount);

	public abstract List<ApplicationInfo> listSynUserApp(
			UserAccount currentUserAccount, Integer thispage, Integer pagesize);

	Long countAppAccount(UserAccount currentUserAccount);

	List<ApplicationInfo> listAppAccount(UserAccount currentUserAccount,
			int thispage, int pagesize);

	public abstract void save(Object object);

	public abstract void update(Object object);

	public abstract void delete(Object object);

	public abstract ApplicationInfo findAppById(String appid);

	public abstract List<ApplicationInfo> findAppByPropertyName(String name,
			String param);

	public abstract <T> List<T> findByHql(String orgHql);

	public abstract UserAccount findUserById(String userAccountCode);

	public abstract Org findOrgById(long parseLong);
}
