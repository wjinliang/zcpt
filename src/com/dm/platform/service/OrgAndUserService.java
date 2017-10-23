package com.dm.platform.service;

import java.util.List;

import com.dm.platform.model.Division;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;

public interface OrgAndUserService {

	public Long countOrg(String divisionid,String name);

	public List<Org> listOrgs(String divisionid, String name,Integer thispage, Integer pagesize);

	public String getParentsIds(String divisionid);

	public Long countSonOrg(String orgid,String name);

	public List<Org> listSonOrgs(String orgid,String name,Integer thispage, Integer pagesize);

	public Long countUser(String orgid,String systemId,String name);

	public List<UserAccount> listUsers(String orgid,String systemId, String name, Integer thispage, Integer pagesize);

	public List<Division> getSonDivisionList(String id);

	public Long countMergeUser(String userid);

	public List<UserAccount> listMergeUsers(String userid, Integer thispage,
			Integer pagesize);

	public List<Division> getSonLevelDivisionList(String id);

	public List<Division> getParents(String divisionid);

	public List<Division> findSheng();

	public Org loadOrg(UserAccount currentUserAccount);

	public Long countOrgSyn(String sonids, String systemId, String name,
			String appId);

}
