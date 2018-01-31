package com.dm.platform.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Division;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;
import com.dm.platform.service.OrgAndUserService;
import com.dm.platform.util.UserAccountUtil;

@Service
public class OrgAndUserServiceImpl implements OrgAndUserService {
	@Resource
	private CommonDAO commonDAO;

	@Override
	public Long countOrg(String divisionid, String name) {
		if(divisionid!=null){
			String hql = "select count(*) from Org o where o.division.id in ("
					+ divisionid + ")";
			if (name != null && !name.equals("")) {
				hql += " and o.name like '%" + name + "%'";
			}
			return this.commonDAO.count(hql);
		}
//		UserAccount currentUserAccount = UserAccountUtil.getInstance()
//				.getCurrentUserAccount();
//		if (currentUserAccount.getOrg() != null
//				&& currentUserAccount.getOrg().getDivision() != null) {
//			Division division = currentUserAccount.getOrg().getDivision();
		//long start = System.currentTimeMillis();
		Division division =UserAccountUtil.getInstance().getCurrentUserAccountOrgDivision();
		//System.out.println("getdivision用时"+ (System.currentTimeMillis()-start));
		if (division != null ) {
			String hql = "select count(*) from Org o where o.division.id = '"
					+ division.getId() + "'";
			if (name != null && !name.equals("")) {
				hql += " and o.name like '%" + name + "%'";
			}
			return this.commonDAO.count(hql);
		} else {
			String hql = "select count(*) from Org o where o.division.id is null";
			if (name != null && !name.equals("")) {
				hql += " and o.name like '%" + name + "%'";
			}
			return this.commonDAO.count(hql);
		}
	}

	@Override
	public List<Org> listOrgs(String divisionid,String name,
			Integer thispage, Integer pagesize) {
		if (divisionid != null && !divisionid.equals("")) {
			String hql = " from Org o where o.division.id in (" + divisionid
					+ ")";
			if (name != null && !name.equals("")) {
				hql += " and o.name like '%" + name + "%'";
			}
			hql +=" order by o.id";
			List<Org> orgList = this.commonDAO.findByPage(hql, thispage,
					pagesize);
			return orgList;
		} else {
//			UserAccount currentUserAccount = UserAccountUtil.getInstance()
//					.getCurrentUserAccount();
//			if (currentUserAccount.getOrg() != null
//					&& currentUserAccount.getOrg().getDivision() != null) {
//				Division division = currentUserAccount.getOrg().getDivision();
			Division division = UserAccountUtil.getInstance().getCurrentUserAccountOrgDivision();
			if(division!=null){
				String hql = " from Org o where o.division.id = '"
						+ division.getId() + "'";
				if (name != null && !name.equals("")) {
					hql += " and o.name like '%" + name + "%'";
				}
				hql +=" order by o.id";
				List<Org> orgList = this.commonDAO.findByPage(hql, thispage,
						pagesize);
				return orgList;
			}
			String hql = " from Org o where o.division.id is null";
			if (name != null && !name.equals("")) {
				hql += " and o.name like '%" + name + "%'";
			}
			hql +=" order by o.id";
			List<Org> orgList = this.commonDAO.findByPage(hql, thispage,
					pagesize);
			;
			return orgList;
		}
	}

	@Override
	public String getParentsIds(String divisionid) {
		List<String> ostring = new ArrayList<String>();
		if (divisionid != null && !divisionid.equals("")) {
			Division division = this.commonDAO.findOne(Division.class,
					divisionid);
			getParentsIds(division, ostring);
		}
		return ostring.toString();
	}

	public void getParentsIds(Division division, List<String> ostr) {
		if (division != null) {
			ostr.add(division.getId());
			Division parent = division.getParent();
			getParentsIds(parent, ostr);
		}
	}

	@Override
	public Long countSonOrg(String orgid, String name) {
		String hql = "select count(*) from Org o where o.parent.id = " + orgid;
		if(name!=null && !name.equals("")){
			hql +=" and o.name like '%" + name + "%'";
		}
		return this.commonDAO.count(hql);
	}

	@Override
	public List<Org> listSonOrgs(String orgid, String name,
			Integer thispage, Integer pagesize) {
		String hql = " from Org o where o.parent.id = " + orgid;
		if(name!=null && !name.equals("")){
			hql +=" and o.name like '%" + name + "%'";
		}
		hql +=" order by o.id";
		return this.commonDAO.findByPage(hql, thispage, pagesize);
	}

	@Override
	public Long countUser(String orgid, String systemId, String name) {
		String hql = "select count(loginname) from UserAccount u where u.delete=false";
		
		if (systemId != null&& !systemId.equals("all")) {
			hql += " and u.systemId = '" + systemId+"'";
		}
		if (name != null && !name.equals("")) {
			hql += " and u.name like '%" + name + "%'";
			Division division = UserAccountUtil.getInstance().getCurrentUserAccountOrgDivision();
			if(division!=null){
				String dCode = division.getCode();
				String type = division.getType();
				int end = 0;
				switch (type) {
					case "0"://中央
						break;
					case "1"://省级 
					case "2"://直辖市 
					case "3"://计划单列市 
						end = 2;
						if(dCode.length()>=end)
							hql += " and u.loginname like '" + dCode.substring(0,end) + "%'";
						break;
					case "4"://市级 
						end = 4;
						if(dCode.length()>=end)
							hql += " and u.loginname like '" + dCode.substring(0,end) + "%'";
						break;
					case "5"://区县 
					case "6"://乡镇 
					case "7"://村 
						end = 6;
						if(dCode.length()>=end)
							hql += " and u.loginname like '" + dCode.substring(0,end) + "%'";
						break;
					default:
						break;
				}
			}
		}else if (orgid != null && !orgid.equals("")) {
			hql += " and u.org.id =" + orgid;
		}
		return this.commonDAO.count(hql);
	}

	@Override
	public List<UserAccount> listUsers(String orgid, String systemId,
			String name, Integer thispage, Integer pagesize) {
		String hql = " from UserAccount u where u.delete=false";//--20161013用户假删除
		if (systemId != null&& !systemId.equals("all")) {
			hql += " and u.systemId = '" + systemId+"'";
		}
		if (name != null && !name.equals("")) {
			hql += " and u.name like '%" + name + "%'";
			Division division = UserAccountUtil.getInstance().getCurrentUserAccountOrgDivision();
			if(division!=null){
				String dCode = division.getCode();
				String type = division.getType();
				int end = 0;
				switch (type) {
					case "0"://中央
						break;
					case "1"://省级 
					case "2"://直辖市 
					case "3"://计划单列市 
						end = 2;
						if(dCode.length()>=end)
							hql += " and u.loginname like '" + dCode.substring(0,end) + "%'";
						break;
					case "4"://市级 
						end = 4;
						if(dCode.length()>=end)
							hql += " and u.loginname like '" + dCode.substring(0,end) + "%'";
						break;
					case "5"://区县 
					case "6"://乡镇 
					case "7"://村 
						end = 6;
						if(dCode.length()>=end)
							hql += " and u.loginname like '" + dCode.substring(0,end) + "%'";
						break;
					default:
						break;
				}
			}
		}
		else if (orgid != null && !orgid.equals("")) {
			hql += " and u.org.id =" + orgid;
		} 
		return this.commonDAO.findByPage(hql, thispage, pagesize);
	}

	@Override
	public List<Division> getSonDivisionList(String id) {
		List<Division> divisionList = new ArrayList<Division>();
		Division division = commonDAO.findOne(Division.class, id);
		divisionList.add(division);
		getDownOrgids(division, divisionList);
		return divisionList;
	}

	private void getDownOrgids(Division division, List<Division> divisionList) {
		String hql = " from Division d where d.parent.id = '"
				+ division.getId() + "'";
		List<Division> find = this.commonDAO.find(hql);
		if (find != null && find.size() > 0) {
			for (Division org2 : find) {
				divisionList.add(org2);
				getDownOrgids(org2, divisionList);
			}
		}
	}

	@Override
	public Long countMergeUser(String userid) {
		if (userid != null && !userid.equals("")) {
			UserAccount user = this.commonDAO
					.findOne(UserAccount.class, userid);
			if (user != null && user.getMergeUuid() != null
					&& !user.getMergeUuid().equals("")) {
				String countHql = "select count(loginname) from UserAccount u where u.delete=false and  u.mergeUuid='"//--20161013用户假删除
						+ user.getMergeUuid()
						+ "' and u.code <> '"
						+ userid
						+ "'";
				Long count = this.commonDAO.count(countHql);
				return count;
			} else {
				return new Long(0);
			}
		}
		return new Long(0);
	}

	@Override
	public List<UserAccount> listMergeUsers(String userid, Integer thispage,
			Integer pagesize) {
		List<UserAccount> userList = new ArrayList<UserAccount>();
		if (userid != null && !userid.equals("")) {
			UserAccount user = this.commonDAO
					.findOne(UserAccount.class, userid);
			if (user != null && user.getMergeUuid() != null
					&& !user.getMergeUuid().equals("")) {
				String userHql = " from UserAccount u where u.delete=false and  u.mergeUuid='"//--20161013用户假删除
						+ user.getMergeUuid() + "' and u.code <> '" + userid
						+ "'";
				userList = this.commonDAO.findByPage(userHql, thispage,
						pagesize);
				return userList;
			} else {
				return userList;
			}
		}
		return userList;
	}

	@Override
	public List<Division> getSonLevelDivisionList(String id) {
		String sonHql = "from Division d where d.parent.id ='" + id
				+ "' order by d.code";
		return this.commonDAO.find(sonHql);
	}

	@Override
	public List<Division> getParents(String divisionid) {
		List<Division> ostring = new ArrayList<Division>();
		if (divisionid != null && !divisionid.equals("")) {
			Division userDivision = UserAccountUtil.getInstance().getCurrentUserAccountOrgDivision();
			Division division = this.commonDAO.findOne(Division.class,
					divisionid);
			getParents(userDivision,division, ostring);
		}
		return ostring;
	}

	public void getParents(Division userDivision,Division division, List<Division> ostr) {
		if (division != null) {
			if(userDivision.getId().equals(division.getId())){
				ostr.add(division);
				return ;
			}
			ostr.add(division);
			Division parent = division.getParent();
			getParents(userDivision,parent, ostr);
		}
	}

	@Override
	public List<Division> findSheng() {
		Division division = this.commonDAO.findOne(Division.class,
				String.valueOf(1));
		List<Division> divisionList = new ArrayList<Division>();
		if (division != null) {
			String shengHql = " from Division d where d.parent.id = '"
					+ division.getId() + "' order by d.code";
			divisionList = this.commonDAO.find(shengHql);
			divisionList.add(division);
		}
		return divisionList;

	}

	@Override
	@Transactional
	public Org loadOrg(UserAccount currentUserAccount) {
		currentUserAccount = commonDAO.findOne(UserAccount.class,
				currentUserAccount.getCode());// 20160603
		Division division = currentUserAccount.getOrg().getDivision();
		return currentUserAccount.getOrg();
	}

	@Override
	public Long countOrgSyn(String divisionid, String systemId, String name,
			String appId) {
		if(divisionid!=null){
			String hql = "select count(*) from Org o where o.division.id in ("
					+ divisionid + ")";
			if (systemId != null && !systemId.equals("")
					&& !systemId.equals("all")) {
				hql += " and o.systemId = '" + systemId + "'";
			}
			if (name != null && !name.equals("")) {
				hql += " and o.name like '%" + name + "%'";
			}
			return this.commonDAO.count(hql);
		}
		/*UserAccount currentUserAccount = UserAccountUtil.getInstance()
				.getCurrentUserAccount();
		if (currentUserAccount.getOrg() != null
				&& currentUserAccount.getOrg().getDivision() != null) {
			Division division = currentUserAccount.getOrg().getDivision();*/
		Division division = UserAccountUtil.getInstance().getCurrentUserAccountOrgDivision();
		if(division!=null){
			String hql = "select count(*) from Org o where o.division.id = '"
					+ division.getId() + "'";
			if (systemId != null && !systemId.equals("")
					&& !systemId.equals("all")) {
				hql += " and o.systemId = '" + systemId + "'";
			}
			if (name != null && !name.equals("")) {
				hql += " and o.name like '%" + name + "%'";
			}
			return this.commonDAO.count(hql);
		} else {
			String hql = "select count(*) from Org o where o.division.id is null";
			if (systemId != null && !systemId.equals("")
					&& !systemId.equals("all")) {
				hql += " and o.systemId = '" + systemId + "'";
			}
			if (name != null && !name.equals("")) {
				hql += " and o.name like '%" + name + "%'";
			}
			return this.commonDAO.count(hql);
		}
	}
}
