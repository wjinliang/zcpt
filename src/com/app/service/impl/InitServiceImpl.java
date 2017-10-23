package com.app.service.impl;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.app.service.InitService;
import com.dm.platform.model.Org;

@Service("initService")
public class InitServiceImpl implements InitService {

	@Override
	public String InitOrg(String opType, String jsonStr) {
		try {
			if (opType.equals("41")) {
				JSONObject jsonObject = JSONObject.fromObject(jsonStr);
				Object orgName = jsonObject.get("orgName");
				Object parentId = jsonObject.get("parentId");
				Object orgSeq = jsonObject.get("orgSeq");
				Object qhdm = jsonObject.get("qhdm");
				Org org = new Org();
				long currentTimeMillis = System.currentTimeMillis();
				org.setId(currentTimeMillis);
				return Long.toString(currentTimeMillis);
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public String InitUser(String opType, String jsonStr) {
		return null;
	}

}
