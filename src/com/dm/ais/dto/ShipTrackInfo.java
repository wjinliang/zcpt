package com.dm.ais.dto;

public class ShipTrackInfo {
	private double y;
	private double x;
	private int index;
	private String datetime;
	private String azimuth;
	private String speed;
	private String status;
	private String mmsi;
	private String imo;
	private String shipname;
	private String callid;	
	
	public double getY() {
		return y;
	}
	public void setY(double y) {
		this.y = y;
	}
	public double getX() {
		return x;
	}
	public void setX(double x) {
		this.x = x;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	
	
	
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String infos) {
		this.datetime = infos;
	}
	public String getAzimuth() {
		return azimuth;
	}
	public void setAzimuth(String azimuth) {
		this.azimuth = azimuth;
	}
	public String getSpeed() {
		return speed;
	}
	public void setSpeed(String speed) {
		this.speed = speed;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMmsi() {
		return mmsi;
	}
	public void setMmsi(String mmsi) {
		this.mmsi = mmsi;
	}
	public String getImo() {
		return imo;
	}
	public void setImo(String imo) {
		this.imo = imo;
	}
	public String getShipname() {
		return shipname;
	}
	public void setShipname(String shipname) {
		this.shipname = shipname;
	}
	public String getCallid() {
		return callid;
	}
	public void setCallid(String callid) {
		this.callid = callid;
	}
	
	public ShipTrackInfo(double x, double y, int index,String datetime,String azimuth,
	String speed,String status,String mmsi,	String imo,String shipname,	String callid) 
	{  
        this.x = x;  
        this.y = y;  
        this.index = index;  
        this.datetime = datetime;
        this.azimuth = azimuth;
        this.speed = speed;
        this.status = status;
        this.mmsi = mmsi;
        this.imo = imo;
        this.shipname = shipname;
        this.callid = callid;
    } 
	
}
