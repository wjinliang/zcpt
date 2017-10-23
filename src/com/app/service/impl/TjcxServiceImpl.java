package com.app.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.app.service.TjcxService;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;

@Service
public class TjcxServiceImpl implements TjcxService {

	@Resource
	private CommonDAO commonDAO;

	@Override
	public Long countSearchUserAccount(String tj, String xtid) {
		String hql = "select count(loginname) from UserAccount u";
		if (tj != null && !tj.equals("")) {
			String orgIds = getOrgIdsByTj(tj);
			hql += " where  u.delete=false and u.name like '%" + tj + "%' or u.loginname like '%"//--20161013用户假删除
					+ tj + "%'";
			if (orgIds != null && !orgIds.equals("")) {
				hql += " or u.org.id in (" + orgIds + ")";
			}
			if (xtid != null && !xtid.equals("") && !xtid.equals("all")) {
				hql += " and u.code in (select s.userId from  SynUser s where s.appId ='"
						+ xtid + "')";
			}
		} else {
			if (xtid != null && !xtid.equals("") && !xtid.equals("all")) {
				hql += " where u.delete=false and u.code in (select s.userId from  SynUser s where s.appId ='"//--20161013用户假删除
						+ xtid + "')";
			}
		}
		Long count = this.commonDAO.count(hql);
		return count;
	}

	@Override
	public String getOrgIdsByTj(String tj) {
		String orgIds = "";
		String sql = "from Org o where o.name like '%" + tj + "%'";
		List<Org> orgList = this.commonDAO.find(sql);
		if (orgList != null && orgList.size() > 0) {
			for (int i = 0; i < orgList.size(); i++) {
				if (i == orgList.size() - 1)
					orgIds = orgIds + orgList.get(i).getId();
				else {
					orgIds = orgIds + orgList.get(i).getId() + ",";
				}
			}
		}
		return orgIds;
	}

	@Override
	public List<UserAccount> listSearchUserAccount(String tj, String xtid) {
		String hql = " from UserAccount u  ";
		if (tj != null && !tj.equals("")) {
			String orgIds = getOrgIdsByTj(tj);
			hql += " where u.delete=false and u.name like '%" + tj + "%' or u.loginname like '%"//--20161013用户假删除
					+ tj + "%'";
			if (orgIds != null && !orgIds.equals("")) {
				hql += " or u.org.id in (" + orgIds + ")";
			}
			if (xtid != null && !xtid.equals("") && !xtid.equals("all")) {
				hql += " and u.code in (select s.userId from  SynUser s where s.appId ='"
						+ xtid + "')";
			}
		} else {
			if (xtid != null && !xtid.equals("") && !xtid.equals("all")) {
				hql += " where u.delete=false and  u.code in (select s.userId from  SynUser s where s.appId ='"//--20161013用户假删除
						+ xtid + "')";
			}
		}
		List<UserAccount> find = this.commonDAO.find(hql);
		return find;
	}

}
