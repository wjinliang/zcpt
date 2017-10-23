package com.dm.platform.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dm.platform.model.UserAttrEntity;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.service.UserAttrService;

@Controller
@RequestMapping("/userAttr")
public class UserAttrController extends DefaultController {
	@Resource
	UserAccountService userAccountService;
	@Resource
	UserAttrService userAttrService;

	@RequestMapping("/saveLayout/{userId}")
	public void saveAttr(ModelAndView model, @PathVariable String userId,
			String layoutType, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			UserAttrEntity userAttr = userAttrService.findOne(userId);
			if (userAttr != null) {
				userAttr.setLayoutType(layoutType);
				userAttrService.update(userAttr);
			} else {
				userAttr = new UserAttrEntity();
				userAttr.setUserId(userId);
				userAttr.setLayoutType(layoutType);
				userAttrService.insert(userAttr);
			}
			out.write("y");
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			out.write("n");
			out.flush();
			out.close();
		}
	}
}
