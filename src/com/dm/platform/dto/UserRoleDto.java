package com.dm.platform.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.dm.platform.model.UserMenu;
public class UserRoleDto implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8492280875474685148L;

	private String code;

	private String name;

	private boolean enabled;
    
	private List<Map> userMenus = new ArrayList<Map>(); 
	
	public String getCode() {
		return code;
	}

	public String getName() {
		return name;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public List<Map> getUserMenus() {
		return userMenus;
	}

	public void setUserMenus(List<Map> userMenus) {
		this.userMenus = userMenus;
	}
	
}
