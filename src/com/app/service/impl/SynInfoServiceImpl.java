package com.app.service.impl;

import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import com.app.service.SynInfoService;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserRole;

public class SynInfoServiceImpl implements SynInfoService {

	@Resource
	private CommonDAO commonDAO;

	@Override
	public String hello(String username) {
		return "hello " + username;
	}

	@Override
	public String getUserInfo(String userId) {
		UserAccount user = this.commonDAO.findOne(UserAccount.class, userId);
		JsonConfig jConfig = new JsonConfig();
		jConfig.setExcludes(new String[] { "roles", "org", "remoteIpAddr",
				"headphoto", "authorities" });
		JSONObject fromObject = JSONObject.fromObject(user, jConfig);
		if (user!=null && user.getOrg() != null) {
			Long id = user.getOrg().getId();
			fromObject.put("orgId", id);
		}
		System.out.println(fromObject.toString());
		return fromObject.toString();
	}

	@Override
	public String getOrgInfo(String orgId) {
		Org org = this.commonDAO.findOne(Org.class, Long.parseLong(orgId));
		JsonConfig jConfig = new JsonConfig();
		jConfig.setExcludes(new String[] { "children", "user", "parent",
				"division" });
		JSONObject fromObject = JSONObject.fromObject(org, jConfig);
		if(org==null){
			System.out.println(fromObject.toString());
			return fromObject.toString();
		}
		Org parent = org.getParent();
		if (parent != null) {
			fromObject.put("parentId", parent.getId());
		} else {
			fromObject.put("parentId", "root");
		}
		System.out.println(fromObject.toString());
		return fromObject.toString();
	}

	@Override
	public String getRoleInfo(String roleId) {
		UserRole userRole = this.commonDAO.findOne(UserRole.class, roleId);
		JsonConfig jConfig = new JsonConfig();
		jConfig.setExcludes(new String[] { "users", "menus", "menugroups" });
		JSONObject fromObject = JSONObject.fromObject(userRole, jConfig);
		System.out.println(fromObject.toString());
		return fromObject.toString();
	}

	public static void main(String[] args) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("opType", "11");
		jsonObject.put("infoCode", "1452759208330");
		String jsonStr = jsonObject.toString();
		System.out.println(jsonStr);
		JsonConfig jConfig = new JsonConfig();
		jConfig.setExcludes(new String[] { "children", "user", "parent",
				"division" });
		JSONObject fromObject = JSONObject.fromObject(null, jConfig);
	}

	@Override
	public String getDivisionInfo(String divisionCode) {
		List<Division> divisions = this.commonDAO.findByPropertyName(Division.class,"code", divisionCode);
		Division division = new Division();
		if(divisions.size()>0){
			division = divisions.get(0);
		}
		JsonConfig jConfig = new JsonConfig();
		jConfig.setExcludes(new String[] { "children", "parent", "org" });
		JSONObject fromObject = JSONObject.fromObject(division, jConfig);
		if(division==null){
			System.out.println(fromObject.toString());
			return fromObject.toString();
		}
		Division parent = division.getParent();
		Division p = this.commonDAO.findOne(Division.class, parent.getId());
		if (p != null) {
			fromObject.put("parentCode", p.getCode());
		} else {
			fromObject.put("parentCode", "100000");
		}
		System.out.println(fromObject.toString());
		return fromObject.toString();
	}

}
