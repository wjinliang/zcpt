package com.dm.platform.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dm.cms.service.ChannelService;
import com.dm.cms.service.SiteService;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.dto.UserGroupDto;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserGroup;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.service.UserGroupService;

@Controller
@RequestMapping("/usergroup")
public class UserGroupController extends DefaultController {
	@Resource
	UserGroupService userGroupService;
	@Resource
	UserAccountService userAccountService;
	@Resource
	ChannelService channelService;
	@Resource
	SiteService siteService;
	@Resource
	CommonDAO commonDAO;

	@RequestMapping("/list")
	public ModelAndView list(ModelAndView model){
		try {
			model.setViewName("/pages/admin/usergroup/ajax_list");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	
	@RequestMapping("/ajaxList")
	@ResponseBody
	public Object ajaxList(
			@RequestParam(value = "pageNum", required = false) Integer pageNum,
			@RequestParam(value = "pageSize", required = false) Integer pageSize,
			UserGroupDto searchDto) {
		try {
			if (pageSize == null) {
				pageSize = 5;
			}
			if (pageNum == null) {
				pageNum = 0;
			}
			Long totalcount = userGroupService.count(searchDto);
			/*if ((pageNum) * pageSize >= totalcount && totalcount > 0) {
				pageNum--;
			}*/
			List<UserGroup> list =  userGroupService.list(pageNum-1, pageSize,searchDto);
			/*List<UserGroupDto> dtoList = new ArrayList<UserGroupDto>();
			for (UserGroup userGroup : list) {
				dtoList.add(new UserGroupDto(userGroup));
			}*/
			Map result = new HashMap();
			result.put("status", 1);
			result.put("data", list);
			result.put("total", totalcount);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("内部错误");
		}
	}
	
	
	@RequestMapping("/ajaxLoad")
	@ResponseBody
	public Object ajaxLoad(
			@RequestParam(value = "userGroupId", required = false) String userGroupId) {
		try {
			UserGroupDto dto = new UserGroupDto();
			UserGroup ug = new UserGroup();
			if(!StringUtils.isEmpty(userGroupId)){
				ug = userGroupService.findOne(userGroupId);
				dto = userGroupService.getDtoFromModel(ug);
			}
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("内部错误");
		}
	}
	
	
	@RequestMapping("/ajaxSave")
	@ResponseBody
	public Object ajaxSave(UserGroupDto dto) {
		
		try {
			  userGroupService.insertupdate(dto);
			return successJson();
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("内部错误");
		}
	}


	@RequestMapping("/loadUsers")
	@ResponseBody
	public Object loadUsers() {
		try {
			List<UserAccount> list = userAccountService.listAllUser();
			List<Map> data = new ArrayList<Map>();
			for (UserAccount userAccount : list) {
				Map user = new HashMap();
				user.put("id", userAccount.getCode());
				user.put("name", userAccount.getName()+"("+userAccount.getLoginname()+")");
				user.put("pId", null);
				data.add(user);
			}
			return data;
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("内部错误");
		}
	}
	
	
	
}
