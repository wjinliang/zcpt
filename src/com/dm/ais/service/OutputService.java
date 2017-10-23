package com.dm.ais.service;

import com.dm.ais.model.OutputEntity;

public interface OutputService {
	public void insert(OutputEntity entity);
	public void update(OutputEntity entity);
	public OutputEntity getEntityBySiteInfoId(String id);
	public OutputEntity getEntityBySiteInfoIdAndByOutputType(String siteInfoId);
}
