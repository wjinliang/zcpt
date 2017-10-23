package com.dm.platform.controller;

import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dm.platform.model.LogEntity;
import com.dm.platform.service.LogService;

@Controller
@RequestMapping("/log")
public class LogController extends DefaultController {
	
	@Resource
	LogService logService;
	
	@RequestMapping("/list")
	public ModelAndView list(ModelAndView model,LogEntity log,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if(pagesize==null){
				pagesize=30;
			}
			if (thispage == null) {
				thispage = 0;
			}
			Long totalcount = logService.countLog(log);
			if((thispage)*pagesize>=totalcount&&totalcount>0){
				thispage--;
			}
			model.addObject("logs", logService.listLogEntity(log,thispage, pagesize));
			model.addObject("log", log);
			model.setViewName("/pages/admin/log/list");
			return Model(model, thispage,pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	
	@RequestMapping("/delete")	
	public void delete(HttpServletRequest request,
			HttpServletResponse response,
			ModelAndView model,
			@RequestParam(value = "logid", required = false) String logid) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (logid != null) {
				String[] lid = logid.split(",");
				for (String str : lid) {
					LogEntity l = new LogEntity();
					l = logService.findOne(new Long(str));
					logService.deleteOne(l);
				}
			}
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			out.write("error");
			out.flush();
			out.close();
		}
	}
	
}
