package com.app.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.app.service.AsyncService;
 
@Controller
@RequestMapping({ "/async" })
public class AsyncController {
	
	@Resource
	private AsyncService asyncService;
	
	@RequestMapping(value="/test")
	public void test(){
		System.out.println("zhixing");
	}
}
