package com.dm.ais.service;

import com.dm.ais.model.DlmEntity;
import com.dm.ais.model.ReportEntity;

public interface DlmService {
	public void insert(DlmEntity entity);
	public void update(DlmEntity entity);
	public DlmEntity getEntityBySiteInfoId(String id);
	public DlmEntity getEntityBySiteInfoIdAndChannelTypeAndReservation(String siteInfoId, String channelType, String reservation);
	public DlmEntity getEntityBySiteInfoIdAndChannelTypeAndSeqNumber(String siteInfoId, String channelType, String seqNumber);
	public void save(DlmEntity entity);
}
