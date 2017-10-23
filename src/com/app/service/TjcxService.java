package com.app.service;

import java.util.List;

import com.dm.platform.model.UserAccount;

public interface TjcxService {
	
	public abstract String  getOrgIdsByTj(String tj);

	public abstract Long countSearchUserAccount(String tj,String xtid);

	public abstract List<UserAccount> listSearchUserAccount(String tj,String xtid);

}
