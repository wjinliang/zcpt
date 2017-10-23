package com.app.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.app.model.JKApplicationInfo;
import com.app.service.JkptService;
import com.dm.platform.dao.CommonDAO;

@Service
public class JkptServiceImpl implements JkptService {
	@Resource
	private CommonDAO commonDAO;

	@Override
	public Long countAppAccount() {
		String hql = "select count(*) from JKApplicationInfo app ";
		Long count = this.commonDAO.count(hql);
		return count;
	}

	@Override
	public List<JKApplicationInfo> listAppAccount(int thispage, int pagesize) {
		String hql = " from JKApplicationInfo app ";
		List<JKApplicationInfo> appList = this.commonDAO.findByPage(hql,
				thispage, pagesize);
		return appList;
	}

	@Override
	public void save(JKApplicationInfo app) {
		// TODO Auto-generated method stub
		this.commonDAO.save(app);
	}

	@Override
	public void update(JKApplicationInfo app) {
		// TODO Auto-generated method stub
		JKApplicationInfo t = this.commonDAO.findOne(JKApplicationInfo.class,
				app.getId());
		t.setAppName(app.getAppName());
		t.setAppPath(app.getAppPath());
		t.setDescription(app.getDescription());
		t.setPassWord(app.getPassWord());
		t.setUserName(app.getUserName());
		this.commonDAO.update(t);
	}

	@Override
	public void delete(JKApplicationInfo s, String appid) {
		String[] rid = appid.split(",");
		for (String str : rid) {
			JKApplicationInfo findOne = this.commonDAO.findOne(
					JKApplicationInfo.class, str);
			this.commonDAO.delete(findOne);
		}
	}
}
