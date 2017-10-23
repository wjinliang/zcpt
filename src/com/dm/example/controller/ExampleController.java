package com.dm.example.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;
import net.sf.json.JSONObject;

import org.apache.commons.httpclient.util.DateUtil;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dm.ais.model.AisSiteInfo;
import com.dm.ais.model.SiteBaseInfoEntity;
import com.dm.ais.service.SiteInfoService;
import com.dm.ais.util.CacheUtil;
import com.dm.cms.service.SiteService;
import com.dm.example.model.ExampleEntity;
import com.dm.example.service.ExampleService;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping("/example")
public class ExampleController extends DefaultController {
	@Resource
	ExampleService exampleService;

	@Resource
	SiteInfoService siteInfoService;
	@Resource
	Cache myCache;
	
	/*
	 * jsp部分**********************************************************************
	 */
	
	public void put()
	{
		
		AisSiteInfo aisSiteInfo =  siteInfoService.findById("402883484c15bdd8014c15bf46670006");
		Element element = new Element("sitecount", aisSiteInfo); 
		myCache.put(element);
	}
	public Object get(Object key)
	{
		Element el = myCache.get(key);
		return el.getObjectValue();
	}
	
	@RequestMapping("/list")
	public ModelAndView list(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			ExampleEntity searchEntity) {
		
		System.out.println(siteInfoService);
		put();
		AisSiteInfo aisSiteInfo = (AisSiteInfo)get("sitecount");
		System.out.println(aisSiteInfo.getId()+"-"+aisSiteInfo.getCreateTime());
		System.out.println();
		try {
			if (pagesize == null) {
				pagesize = 10;
			}
			if (thispage == null) {
				thispage = 0;
			}
			Long totalcount = exampleService.count(searchEntity);
			if ((thispage) * pagesize >= totalcount && totalcount > 0) {
				thispage--;
			}
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.DESC, "id"));
			model.addObject("examples", exampleService.listByPage(searchEntity,
					thispage, pagesize, orders));
			model.addObject("searchEntity", searchEntity);
			model.setViewName("/pages/example/list");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/form/{mode}")
	public ModelAndView form(
			ModelAndView model,
			@PathVariable String mode,
			@RequestParam(value = "exampleid", required = false) String exampleid) {
		try {
			ExampleEntity ee = new ExampleEntity();
			if (mode != null && !mode.equals("new")) {
				if (exampleid != null) {
					ee = exampleService.findById(Long.valueOf(exampleid));
					model.addObject("example", ee);
					if(mode.equals("view")){
						model.setViewName("/pages/example/view");
						return Model(model);
					}
				}
			}
			model.setViewName("/pages/example/form");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}


	@RequestMapping("/save")
	public ModelAndView save(ModelAndView model, ExampleEntity entity) {
		try {
			ExampleEntity ee = new ExampleEntity();
			if (entity.getId() != null) {
				ee = exampleService.findById(entity.getId());
				ee.setName(entity.getName());
				ee.setUpdateTime(DateUtil.formatDate(new Date(),
						"yyyy-MM-dd HH:mm:ss"));
				ee.setModifier(UserAccountUtil.getInstance().getCurrentUser());
				exampleService.update(ee);
			} else {
				entity.setCreateTime(DateUtil.formatDate(new Date(),
						"yyyy-MM-dd HH:mm:ss"));
				entity.setCreator(UserAccountUtil.getInstance()
						.getCurrentUser());
				entity.setValidFlag("1");
				exampleService.save(entity);
			}
			return Redirect(model,getRootPath() + "/example/list","操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			return RedirectError(model, getRootPath() + "/example/list","操作失败！");
		}
	}

	@RequestMapping("/delete")
	public void delete(
			HttpServletResponse response,
			@RequestParam(value = "exampleid", required = false) String exampleid)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (exampleid != null) {
				String[] ids = exampleid.split(",");
				for (String str : ids) {
					exampleService.deleteById(Long.valueOf(str));
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

	/*
	 * ajax部分**********************************************************************
	 */
	@RequestMapping("/ajaxExample")
	public ModelAndView ajaxExample(
			ModelAndView model) {
		try {
			model.setViewName("/pages/example/ajax_list");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	@RequestMapping("/ajaxList")
	public @ResponseBody Object ajaxList(
			HttpServletResponse response,
			@RequestParam(value = "pageNum", required = false) Integer thispage,
			@RequestParam(value = "pageSize", required = false) Integer pagesize,
			ExampleEntity searchEntity) throws Exception {
		try {
			if (pagesize == null) {
				pagesize = 10;
			}
			if (thispage == null) {
				thispage = 1;
			}
			Long totalcount = exampleService.count(searchEntity);
			if ((thispage - 1) * pagesize >= totalcount && totalcount > 0) {
				thispage--;
			}
			List<Order> orders = new ArrayList<Order>();
			orders.add(new Order(Direction.DESC, "id"));
			List<ExampleEntity> list = exampleService.listByPage(searchEntity,
					thispage - 1, pagesize, orders);
			Map map = new HashMap();
			map.put("data", list);
			map.put("total", totalcount);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("异常");
		}
	}
	
	@RequestMapping("/ajaxLoad")
	public @ResponseBody
	Object ajaxLoad(
			@RequestParam(value = "exampleid", required = false) String exampleid) {
		try {
			ExampleEntity ee = new ExampleEntity();
			if (exampleid != null) {
				ee = exampleService.findById(Long.valueOf(exampleid));
			}
			return ee;
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("异常！");
		}
	}
	
	@RequestMapping("/ajaxSave")
	public @ResponseBody
	Object ajaxSave(ExampleEntity entity) {
		try {
			if (entity.getId() != null && !entity.getId().equals("")) {
				entity.setUpdateTime(DateUtil.formatDate(new Date(),
						"yyyy-MM-dd HH:mm:ss"));
				entity.setModifier(UserAccountUtil.getInstance()
						.getCurrentUser());
				exampleService.update(entity);
			} else {
				entity.setCreateTime(DateUtil.formatDate(new Date(),
						"yyyy-MM-dd HH:mm:ss"));
				entity.setCreator(UserAccountUtil.getInstance()
						.getCurrentUser());
				entity.setValidFlag("1");
				exampleService.save(entity);
			}
			return successJson();
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("异常");
		}
	}
	
	@RequestMapping("/ajaxDelete")
	public @ResponseBody
	Object ajaxDelete(
			@RequestParam(value = "exampleid", required = false) String exampleid)
			throws Exception {
		try {
			if (exampleid != null) {
				String[] ids = exampleid.split(",");
				for (String str : ids) {
					exampleService.deleteById(Long.valueOf(str));
				}
			}
			return successJson();
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("异常");
		}
	}
}
