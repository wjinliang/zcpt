package com.dm.ais.service;

import com.dm.ais.model.AcaEntity;

public interface AcaService {
	public void insert(AcaEntity entity);
	public void update(AcaEntity entity);
	public AcaEntity getEntityBySiteInfoId(String id);
	public AcaEntity getEntityBySiteInfoIdAndSeqNumber(String siteInfoId, String seqNumber);
}
