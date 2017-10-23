package com.app.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.app.service.TjyhService;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.util.ExcelExportUtils;

@Controller
@RequestMapping({ "/tjyh" })
public class TjyhController extends DefaultController {
	@Resource
	private TjyhService tjyhService;
	/**
	 * 各个区划用户数量统计
	 * @param model
	 * @param thispage
	 * @param pagesize
	 * @return
	 */
	@RequestMapping({ "/qhyh" })
	public ModelAndView qhyhsl(
			ModelAndView model,
			@RequestParam(value="systemId",required = false,defaultValue="动物标识及动物产品追溯系统") String systemId, 
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(100);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			Long totalcount = this.tjyhService.countUserTJ( systemId);
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			List<Map> appList = this.tjyhService.ListUserTJ(
					systemId,thispage, pagesize);
			model.addObject("tjsj", appList);
			model.addObject("xt",systemId);
			model.setViewName("/pages/tjyh/quhuayonghu");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	/**
	 * 各个区划用户登录次数统计
	 * @param model
	 * @param thispage
	 * @param pagesize
	 * @return
	 */
	@RequestMapping({ "/qhyhdl" })
	public ModelAndView qhyhdl(
			ModelAndView model,
			@RequestParam(value="systemId",required = false,defaultValue="动物标识及动物产品追溯系统") String systemId, 
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(100);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			Long totalcount = this.tjyhService.countLoginCountTJ( systemId);
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			List<Map> appList = this.tjyhService.ListLoginCountTJ(
					systemId,thispage, pagesize);
			model.addObject("tjsj", appList);
			model.addObject("xt",systemId);
			model.setViewName("/pages/tjyh/quhuadenglu");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	/**
	 * 各个区划删除的用户数量
	 * @param model
	 * @param thispage
	 * @param pagesize
	 * @return
	 */
	@RequestMapping({ "/qhscyh" })
	public ModelAndView qhscyh(
			ModelAndView model,
			@RequestParam(value="systemId",required = false,defaultValue="动物标识及动物产品追溯系统") String systemId, 
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(100);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			Long totalcount = this.tjyhService.countDeleteUserTJ( systemId);
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			List<Map> appList = this.tjyhService.ListDeleteUserTJ(
					systemId,thispage, pagesize);
			model.addObject("tjsj", appList);
			model.addObject("xt",systemId);
			model.setViewName("/pages/tjyh/quhuashanchu");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	@RequestMapping("/excelExport")
	public void excelExport(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "type", required = false,defaultValue="1") String type,
			@RequestParam(value = "systemId", required = false,defaultValue="动物标识及动物产品追溯系统") String systemId)
	{
		
		List<Map> list = new ArrayList<Map>();
		String name ="";
		if(type.equals("1")){
			list = this.tjyhService.ListUserTJ(systemId, 0, 100);
			name = "各个区划用户数量统计";
		}
		if(type.equals("2")){
			list = this.tjyhService.ListLoginCountTJ(systemId, 0, 100);
			name = "各个区划用户登录次数统计";
		}
		if(type.equals("3")){
			list = this.tjyhService.ListDeleteUserTJ(systemId, 0, 100);
			name = "各个区划用户删除数量统计";
		}
		String fileName = systemId+name;
		OutputStream fOut = null;
		try {
		response.setContentType("application/vnd.ms-excel;charset=ISO8859_1"); 
		response.setHeader("content-disposition", "attachment;filename="+new String(fileName.getBytes(), "iso-8859-1")+".xls");  
			fOut = response.getOutputStream();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//List<UserAccount> list = this.userAccountService.listUserAccount(orgId, orgId, 0, 1000);
		String[] fields = {"divisionName","shengcount","shicount","xiancount","xiangcount","cuncount"};
		String[] names = {"区划","省级","市级","县级","乡镇级","村级"};
		Workbook workbook;
		try {
			workbook = ExcelExportUtils.getInstance().inExcel(list, fields, names);
			workbook.write(fOut);  
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			try {
				fOut.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}
