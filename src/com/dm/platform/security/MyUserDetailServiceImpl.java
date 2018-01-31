package com.dm.platform.security;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.UserAccount;

public class MyUserDetailServiceImpl implements UserDetailsService{

	@Resource
	CommonDAO commonDAO;
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		// TODO Auto-generated method stub
        UserAccount user = null;
        List<UserAccount> users =commonDAO.findByPropertyName(UserAccount.class,  new String[]{"loginname","delete"}, new Object[]{username,false});
        if(users.size()>0){
        	user=users.get(0);
        }else{
        	throw new UsernameNotFoundException("用户名或密码错误！");
        }  
        return user;
	}

}
