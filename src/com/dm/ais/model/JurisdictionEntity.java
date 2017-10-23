package com.dm.ais.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "ais_jurisdiction")
public class JurisdictionEntity implements Serializable {

	private static final long serialVersionUID = 5093549816022238663L;
	/** 主键id */
	private String id;
	/** 辖区名称 */
	private String name;
	/** 辖区纬度 */
	private String lat;
	/** 辖区经度 */
	private String lon;
	
	@Id
	@Column(name = "id", unique = true, nullable = false, length = 8)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Column(name = "name")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Column(name = "lat")
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	@Column(name = "lon")
	public String getLon() {
		return lon;
	}
	public void setLon(String lon) {
		this.lon = lon;
	}
}
