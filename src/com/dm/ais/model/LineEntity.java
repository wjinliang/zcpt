package com.dm.ais.model;

import java.io.Serializable;

public class LineEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5561944899897777792L;

	
	private String ConnState;
	private String DevName1;
	private String DevName2;
	private String PortName1;
	private String PortName2;
	private String TotalFlux;
	private String UsageRate;
	public String getConnState() {
		return ConnState;
	}
	public void setConnState(String connState) {
		ConnState = connState;
	}
	public String getDevName1() {
		return DevName1;
	}
	public void setDevName1(String devName1) {
		DevName1 = devName1;
	}
	public String getDevName2() {
		return DevName2;
	}
	public void setDevName2(String devName2) {
		DevName2 = devName2;
	}
	public String getPortName1() {
		return PortName1;
	}
	public void setPortName1(String portName1) {
		PortName1 = portName1;
	}
	public String getPortName2() {
		return PortName2;
	}
	public void setPortName2(String portName2) {
		PortName2 = portName2;
	}
	public String getTotalFlux() {
		return TotalFlux;
	}
	public void setTotalFlux(String totalFlux) {
		TotalFlux = totalFlux;
	}
	public String getUsageRate() {
		return UsageRate;
	}
	public void setUsageRate(String usageRate) {
		UsageRate = usageRate;
	}
	
	
}
