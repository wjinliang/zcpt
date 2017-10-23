package com.app.service;

import java.util.List;

import com.app.model.JKApplicationInfo;

public interface JkptService {
	public abstract Long countAppAccount();
	
	public abstract List<JKApplicationInfo> listAppAccount( int thispage, int pagesize);

	public abstract void save(JKApplicationInfo app);

	public abstract void update(JKApplicationInfo app);

	public abstract void delete(JKApplicationInfo findOne, String appids);
}
