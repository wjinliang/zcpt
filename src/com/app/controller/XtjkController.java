package com.app.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.JKApplicationInfo;
import com.app.service.JkptService;
import com.app.util.UUIDUtil;
import com.dm.ais.dao.CommDAO;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping({ "/xtjk" })
public class XtjkController extends DefaultController {
	@Resource
	private CommonDAO commonDAO;
	@Resource
	private CommDAO commDAO;
	@Resource
	private JkptService synService;

	@RequestMapping({ "/listApp" })
	public ModelAndView listApp(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "pagesize", required = false) Integer pagesize) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			Long totalcount = this.synService.countAppAccount();
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			List<JKApplicationInfo> appList = this.synService.listAppAccount(
					thispage, pagesize);
			model.addObject("appList", appList);
			model.setViewName("/pages/xtjk/appList");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	@RequestMapping({ "/form/{mode}" })
	public ModelAndView gotoCreateAppPage(ModelAndView model,
			@PathVariable String mode,
			@RequestParam(value = "appid", required = false) String appid) {
		if ((mode != null) && (!mode.equals("new"))) {
			JKApplicationInfo appInfo = this.commonDAO.findOne(
					JKApplicationInfo.class, appid);
			model.addObject("appInfo", appInfo);
			model.setViewName("/pages/xtjk/viewAppPage");
		} else {
			model.setViewName("/pages/xtjk/createAppPage");
		}
		return Model(model);
	}
	@RequestMapping({ "/saveApp" })
	public ModelAndView saveApp(ModelAndView model, JKApplicationInfo app) {
		System.out.println(app.getAppName());
		String uuid = UUIDUtil.getUUID();
		System.out.println(uuid);
		app.setId(uuid);
		this.synService.save(app);
		return NewRedirect(model, "/xtjk/listApp");
	}
	@RequestMapping({ "/updateApp" })
	public ModelAndView updateApp(ModelAndView model, JKApplicationInfo app) {
		this.synService.update(app);
		return NewRedirect(model, "/xtjk/listApp");
	}
	@RequestMapping({ "/delete" })
	public void delete(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "appid", required = false) String appid)
			throws Exception {
		String requestIp = UserAccountUtil.getInstance().getRequestIp(request);
		System.out.println(requestIp);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			if (appid != null) {
				
					this.synService.delete(null,appid);
			}
			out.write("ok");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.write("error");
			out.flush();
			out.close();
		}
	}
	@RequestMapping({ "/jianKong" })
	public void jianKong(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "appId", required = true) String appId) {
		response.setContentType("text/html;charset=UTF-8");
		JKApplicationInfo applicationInfo = this.commonDAO.findOne(
				JKApplicationInfo.class, appId);
		HttpClient httpclient = new HttpClient();
		httpclient.getHttpConnectionManager().getParams()
				.setConnectionTimeout(2500);
		httpclient.getHttpConnectionManager().getParams().setSoTimeout(2500);
		String url = applicationInfo.getAppPath();
		GetMethod getMethod = new GetMethod(url);
		getMethod.getParams().setParameter("http.method.retry-handler",
				new DefaultHttpMethodRetryHandler());
		int statusCode = 0;
		try {
			statusCode = httpclient.executeMethod(getMethod);
			response.getWriter().write(String.valueOf(statusCode));
		} catch (IOException e) {
			e.printStackTrace();
			statusCode = 0;
		}
		System.out.println(statusCode);
	}

	@RequestMapping({ "/ping" })
	public ModelAndView ping(ModelAndView model,
			@RequestParam(value = "appId", required = true) String appId) {
			Runtime runtime = Runtime.getRuntime(); // 获取当前程序的运行进对象
		try {
			JKApplicationInfo applicationInfo = this.commonDAO.findOne(JKApplicationInfo.class, appId);
			String appPath = applicationInfo.getAppPath();
			String ip = getAppIp(appPath);
			System.out.println("应用IP为："+ip);
			Process process = null; // 声明处理类对象
			String line = null; // 返回行信息
			InputStream is = null; // 输入流
			InputStreamReader isr = null; // 字节流
			BufferedReader br = null;
			boolean res = false;// 结果
			process = runtime.exec("ping " + ip); // PING
			is = process.getInputStream(); // 实例化输入流
			isr = new InputStreamReader(is, "GBK");// 把输入流转换成字节流
			br = new BufferedReader(isr);// 从字节中读取文本
			int i =0;
			while ((line = br.readLine()) != null) {
				System.out.println(line);
				if (line.contains("TTL") || line.contains("ttl")) {
					res = true;
					break;
				}
				i++;
				if(i>=4){
					break;
				}
				System.out.println(i);
			}
			is.close();
			isr.close();
			br.close();
			if (res) {
				System.out.println("ping 通  ...");
			} else {
				System.out.println("ping 不通...");
			}
			model.addObject("result", res);
			model.setViewName("/pages/xtjk/pingResult");
			return Model(model);
		} catch (Exception e) {
			e.printStackTrace();
			runtime.exit(1);
			return Error(e);
		}
	}
	
	public String getAppIp(String url) {
		String result = url.substring(7);
		String[] urlsz = result.split(":");
		String ip = urlsz[0];
		return ip;
	}
}
