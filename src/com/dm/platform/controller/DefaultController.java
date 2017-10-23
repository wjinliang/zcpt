package com.dm.platform.controller;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.dm.platform.model.UserAccount;
import com.dm.platform.service.MessageService;
import com.dm.platform.service.OrgAndUserService;
import com.dm.platform.service.UserAttrService;
import com.dm.platform.util.CommonStatics;
import com.dm.platform.util.PageUtil;
import com.dm.platform.util.UserAccountUtil;

public class DefaultController {
	@Resource
	SessionRegistry sessionRegistry;
	@Resource
	MessageService messageService;
	@Resource
	UserAttrService userAttrService;
	@Resource
	protected
	OrgAndUserService orgAndUserService;
	
	// 获取根目录
	public String getRootPath() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		return request.getContextPath();
	}
	
	public Map errorJson(final String msg){
		Map map = new HashMap(){{
			put("status",0);
			put("msg",msg);
		}};
		return map;
	}
	public Map successJson(){
		Map map = new HashMap(){{
			put("status",1);
		}};
		return map;
	}
	
	public String getWholePath(){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://"
				+ request.getServerName() + ":" + request.getServerPort()
				+ path + "/";
		return basePath;
	}

	// 不带操作权限传递上下文
	public ModelAndView Model(ModelAndView model, Integer thispage,Integer pagesize,
			Long totalcount) {
		model.addObject("root", getRootPath());
		model.addObject("totalcount", totalcount);
		Integer tp = (int) (totalcount / pagesize);
		if (totalcount % pagesize != 0) {
			tp++;
		}
		model.addObject("totalpage", tp);
		model.addObject("thispage", thispage);
		model.addObject("pagesize", pagesize);
		model.addObject("pagination",
				PageUtil.getInstance().pagination(thispage, tp, totalcount, pagesize));
		model.addObject("dialog_css", "?skin=idialog");
		model.addObject("onlineCount", UserAccountUtil.getInstance()
				.getOnlineCount(sessionRegistry));
		UserAccount user =  UserAccountUtil.getInstance()
				.getCurrentUserAccount();
		user.setOrg(this.orgAndUserService.loadOrg(user));
		model.addObject("currentUser",user);
		return model;
	}
	
	
	public ModelAndView Model(ModelAndView model) {
		model.addObject("root", getRootPath());
		model.addObject("dialog_css", "?skin=idialog");
		model.addObject("onlineCount", UserAccountUtil.getInstance()
				.getOnlineCount(sessionRegistry));
		model.addObject("currentUser", UserAccountUtil.getInstance()
				.getCurrentUserAccount());
		return model;
	}
	
	public ModelAndView Redirect(ModelAndView model,String redirect,String msg) {
		model.addObject("root", getRootPath());
		model.addObject("msg",msg);
		model.addObject("redirect",redirect);
		model.setViewName("/pages/content/redirect");
		return model;
	}
	
	public ModelAndView NewRedirect(ModelAndView model,String redirect) {
		model.setViewName("redirect:"+redirect);
		return model;
	}
	
	

	// 错误页面跳转
	public ModelAndView Error(Exception e) {
		ModelAndView mdl = new ModelAndView();
		mdl.addObject("root", getRootPath());
		mdl.addObject("error", e.toString());
		mdl.setViewName(CommonStatics.ERROR);
		return mdl;
	}

	public ModelAndView Error(String estr) {
		ModelAndView mdl = new ModelAndView();
		mdl.addObject("root", getRootPath());
		mdl.addObject("error", estr);
		mdl.setViewName(CommonStatics.ERROR);
		return mdl;
	}
	
	public ModelAndView RedirectError(ModelAndView model,String redirect,String msg) {
		model.addObject("msg",msg);
		model.addObject("error",true);
		model.addObject("root", getRootPath());
		model.addObject("redirect",redirect);
		model.setViewName("/pages/content/redirect");
		return model;
	}


}
