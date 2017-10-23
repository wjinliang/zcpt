package com.dm.ais.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.dao.CommDAO;
import com.dm.ais.model.AcaEntity;
import com.dm.ais.model.Test;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.dao.CommonDAO;

@Controller
public class TestController extends DefaultController{
	
	  @Resource
	  private CommonDAO commonDAO;
	  
	  @RequestMapping("/test")
		public ModelAndView getTest(ModelAndView model) throws Exception {
		  	List<Test> findAll = commonDAO.findAll(Test.class);
			model.addObject("testList", findAll);
			model.addObject("test", "fengqiyong");
			model.setViewName("/pages/test/test");
			return Model(model);
		}
}
