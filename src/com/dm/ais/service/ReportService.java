package com.dm.ais.service;

import com.dm.ais.model.ReportEntity;

public interface ReportService {
	public void insert(ReportEntity entity);
	public void update(ReportEntity entity);
	public void save(ReportEntity entity);
	public ReportEntity getEntityBySiteInfoId(String id);
	public ReportEntity getEntityBySiteInfoIdAndReportRatesForMsgType(String siteInfoId, String reportRatesForMsgType);
}
