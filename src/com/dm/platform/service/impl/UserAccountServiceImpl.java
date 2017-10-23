package com.dm.platform.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.UserAccount;
import com.dm.platform.service.UserAccountService;

@Service
public class UserAccountServiceImpl implements UserAccountService {

	@Resource
	private CommonDAO commonDAO;

	@Override
	public List<UserAccount> listUserAccount(String orgid, String orgids,
			int thispage, int pagesize) {
		// TODO Auto-generated method stub
		String hql = "from UserAccount ua where ua.delete=false";//--20161013用户假删除
		if (orgid != null && !orgid.equals("")) {
			if (orgids != null && !orgids.equals("")) {
				hql += " and ua.org.id in (" + orgids + ")";
			}
		} else {
			if (orgids != null && !orgids.equals("")) {
				hql += " and (ua.org.id in (" + orgids + ") or ua.org is null)";
			}
		}
		return commonDAO.findByPage(hql, thispage, pagesize);
	}
	
	@Override
	public List<UserAccount> listUserByRoleId(String roleId,boolean mode) {
		// TODO Auto-generated method stub
		String hql ="";
		if(mode){
			hql = "select user from UserAccount user,UserRole role where user in elements(role.users) and role.code=:roleId and user.delete=false order by user.code asc";//--20161013用户假删除
		}else{
			hql = "select user from UserAccount user,UserRole role where user not in elements(role.users) and role.code=:roleId user.delete=false  order by user.code asc";//--20161013用户假删除
		}
		Map argsMap = new HashMap();
		argsMap.put("roleId", roleId);
		return commonDAO.findByMap(hql, argsMap);
	}
	@Override
	public void insertUser(UserAccount entity) {
		// TODO Auto-generated method stub
		commonDAO.save(entity);
	}

	@Override
	public void updateUser(UserAccount entity) {
		// TODO Auto-generated method stub
		commonDAO.update(entity);
	}

	@Override
	public void deleteUser(UserAccount entity) {
		// TODO Auto-generated method stub
		entity.setDelete(true);//--20161013用户假删除
		commonDAO.update(entity);//--20161013用户假删除
		//commonDAO.delete(entity);//--20161013用户假删除
	}

	@Override
	public Long countUserAccount(String orgid,String orgids) {
		// TODO Auto-generated method stub
		String hql = "select count(loginname) from UserAccount ua where ua.delete='0'";//--20161013用户假删除
		if (orgid != null && !orgid.equals("")) {
			if (orgids != null && !orgids.equals("")) {
				hql += " and ua.org.id in (" + orgids + ")";
			}
		} else {
			if (orgids != null && !orgids.equals("")) {
				hql += " and (ua.org.id in (" + orgids + ") or ua.org is null)";
			}
		}
		return commonDAO.count(hql);
	}

	@Override
	public UserAccount findOne(String code) {
		// TODO Auto-generated method stub
		UserAccount ua = commonDAO.findOne(UserAccount.class, code);
		if(ua==null)//--20161013用户假删除
			return null;//--20161013用户假删除
		if(ua.isDelete()){//--20161013用户假删除
			return null;//--20161013用户假删除
		}
		return ua;
	}

	@Override
	public UserAccount findByEmail(String email) {
		// TODO Auto-generated method stub
		if(commonDAO.findByPropertyName(UserAccount.class, "email", email).size()>0){
			UserAccount entity = commonDAO.findByPropertyName(UserAccount.class, "email", email).get(0);
			if(entity==null)//--20161013用户假删除
				return null;//--20161013用户假删除
			if(entity.isDelete()){//--20161013用户假删除
				return null;//--20161013用户假删除
			}
			return entity;
		}else{
			return null;
		}
	}
	
	@Override
	public UserAccount findByLoginName(String loginName) {
		// TODO Auto-generated method stub
		List<UserAccount> list = commonDAO.findByPropertyName(UserAccount.class, "loginname", loginName);
		if(list.size()>0){
		UserAccount ua = list.get(0);
			if(ua==null)//--20161013用户假删除
				return null;//--20161013用户假删除
			if(ua.isDelete()){//--20161013用户假删除
				return null;//--20161013用户假删除
			}
				return ua;
		}else{
			return null;
		}
	}

	@Override
	public Long countByOrgIds(String sql,String orgids,Object[] objects) {
		// TODO Auto-generated method stub
		return commonDAO.count(sql, orgids,objects);
	}
	@Override
	public Long countByOrgIds(String sql,Map argsMap) {
		// TODO Auto-generated method stub
		return commonDAO.count(sql,argsMap);
	}

	@Override
	public List<UserAccount> listAllUser() {
		// TODO Auto-generated method stub
		UserAccount ua = new UserAccount();
		ua.setDelete(false);
		return commonDAO.findAll(UserAccount.class,"delete:delete ",ua);//--20161013用户假删除
	}

	@Override
	public void refreshService() {
		// TODO Auto-generated method stub
		
	}


}
