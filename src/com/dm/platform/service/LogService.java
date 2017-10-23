package com.dm.platform.service;

import java.util.List;

import com.dm.platform.model.LogEntity;

public interface LogService {
	public List<LogEntity> listLogEntity(LogEntity le, int thispage, int pagesize); 
	public Long countLog(LogEntity le);
	public LogEntity findOne(long Id);
	public void insert(LogEntity le);
	public void deleteOne(LogEntity entity);
	public void Log(String user,String ip,String type,String title,String content);
}
