package com.app.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.app.model.ApplicationInfo;
import com.app.service.SynService;
import com.app.service.TjcxService;
import com.dm.ais.dao.CommDAO;
import com.dm.platform.controller.DefaultController;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.Org;
import com.dm.platform.model.UserAccount;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.util.UserAccountUtil;

@Controller
@RequestMapping({ "/tjfx" })
public class TjfxConTroller extends DefaultController {
	@Resource
	private CommonDAO commonDAO;
	@Resource
	private CommDAO commDAO;
	@Resource
	private TjcxService tjcxService;

	@Resource
	SessionRegistry sessionRegistry;

	@Resource
	UserAccountService userAccountService;
	
	@Resource
	private SynService synService;

	@RequestMapping({ "/listOrgUsers" })
	public ModelAndView list(
			ModelAndView model,
			@RequestParam(value = "thispage", required = false) Integer thispage,
			@RequestParam(value = "orgid", required = false) String orgid,
			@RequestParam(value = "orgids", required = false) String orgids,
			@RequestParam(value = "pagesize", required = false) Integer pagesize,
			@RequestParam(value = "tj", required = false) String tj,
			@RequestParam(value = "xtid", required = false) String xtid) {
		try {
			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			Long totalcount = this.userAccountService.countUserAccount(orgid,
					orgids);
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			List ml = new ArrayList();
			Map root = new HashMap();
			root.put("id", "");
			root.put("name", "根组织");
			root.put("pId", null);
			root.put("open", Boolean.valueOf(true));
			ml.add(root);
			List orders = new ArrayList();
			orders.add(new Sort.Order(Sort.Direction.ASC, "seq"));
			UserAccount currentUserAccount = UserAccountUtil.getInstance().getCurrentUserAccount();
			Long currentUserId = currentUserAccount.getOrg().getId();
			
			List<Org> olist = this.commonDAO.findAll(Org.class, orders);
			for (Org org : olist) {
				Map m = new HashMap();
				m.put("id", org.getId());
				String ids = UserAccountUtil.getInstance().getDownOrgidsStrs(
						String.valueOf(org.getId()));
				List orglist = new ArrayList();
				for (String id : ids.split(",")) {
					orglist.add(new Long(id));
				}
				m.put("name", org.getName());
				if (org.getParent() != null)
					m.put("pId", org.getParent().getId());
				else {
					m.put("pId", "");
				}
				if (org.getChildren().size() != 0) {
					m.put("open", Boolean.valueOf(true));
				}
				ml.add(m);
			}
			List<Order> orders1 = new ArrayList<Order>();
			orders.add(new Order(Direction.ASC, "seq"));
			List<ApplicationInfo> app = this.commonDAO
					.findAll(ApplicationInfo.class,orders1);
			model.addObject("appList", app);
			model.addObject("xtid", xtid);
			JSONArray json = JSONArray.fromObject(ml);
			model.addObject("orgStr", json.toString());
			model.addObject("orgid", orgid);
			model.addObject("orgids", orgids);
			if ((tj != null && !tj.equals(""))
					|| (xtid != null && !xtid.equals("") && !xtid.equals("all"))) {
				model.addObject("tj", tj);
				totalcount = this.tjcxService.countSearchUserAccount(tj, xtid);
				model.addObject("useraccounts",
						this.tjcxService.listSearchUserAccount(tj, xtid));
			} else {
				model.addObject("tj", "");
				model.addObject("useraccounts", this.userAccountService
						.listUserAccount(orgid, orgids, thispage.intValue(),
								pagesize.intValue()));
			}
			model.setViewName("/pages/admin/useraccount/list");
			return Model(model, thispage, pagesize, totalcount);
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}
	@RequestMapping({ "/listTj" })
	public ModelAndView tjList(ModelAndView model,@RequestParam(value = "orgId", required = false) String orgId) {
		List<Object> allUser = sessionRegistry.getAllPrincipals();
		String hql = "from Org o where o.parent.id is null ";
		if(orgId !=null && !orgId.equals("")){
			hql = "from Org o where o.parent.id ="+new Long(orgId);
		}
		List<Org> orgList = this.commonDAO.find(hql);
		List resultList = new ArrayList();
		long userCountSum=0;
		int onLineUserCountSum=0;
		for (int j = 0; j < orgList.size(); j++) {
			String flag="0";
			int n = 0;// 在线用户
			Map resultMap = new HashMap();
			Org org = orgList.get(j);
			Map m = new HashMap();
			m.put("id", org.getId());
			String ids = UserAccountUtil.getInstance().getDownOrgidsStrs(
					String.valueOf(org.getId()));
			List orglist = new ArrayList();
			for (String id : ids.split(",")) {
				orglist.add(new Long(id));
			}
			if(orglist.size()>1){
				flag="1";
			}
			String sql = "select count(loginname) from UserAccount u where u.org.id in (:orgids) and u.delete=false";//--20161013用户假删除
			Object argsMap = new HashMap();
			((Map) argsMap).put("orgids", orglist);
			Long count = this.userAccountService.countByOrgIds(sql,
					(Map) argsMap);
			String downOrgidsStrs = UserAccountUtil.getInstance()
					.getDownOrgidsStrs(org.getId().toString());
			for (int i = 0; i < allUser.size(); i++) {
				UserAccount user = (UserAccount) allUser.get(i);
				if(ids.contains(user.getOrg().getId().toString())){
					n++;
				}
			}
			userCountSum=userCountSum+count;
			onLineUserCountSum=onLineUserCountSum+n;
			resultMap.put("id", org.getId());
			resultMap.put("ids", ids);
			resultMap.put("name", org.getName());
			resultMap.put("userCount", count);
			resultMap.put("onLineUserCount", n);
			resultMap.put("flag", flag);
			resultList.add(resultMap);
		}
		model.addObject("resultList", resultList);
		model.addObject("userCountSum", userCountSum);
		model.addObject("onLineUserCountSum", onLineUserCountSum);
		model.setViewName("/pages/tjfx/list");
		return Model(model);
	}
	@RequestMapping({"/listUsers"})
	 public ModelAndView list(ModelAndView model, @RequestParam(value="thispage", required=false) Integer thispage, @RequestParam(value="orgid", required=false) String orgid, @RequestParam(value="orgids", required=false) String orgids, @RequestParam(value="pagesize", required=false) Integer pagesize)
	  {
	    try
	    {
	      if (pagesize == null) {
	        pagesize = Integer.valueOf(10);
	      }
	      if (thispage == null) {
	        thispage = Integer.valueOf(0);
	      }
	      Long totalcount = this.userAccountService
	        .countUserAccount(orgid, orgids);
	      if ((thispage.intValue() * pagesize.intValue() >= totalcount.longValue()) && (totalcount.longValue() > 0L)) {
	        thispage = Integer.valueOf(thispage.intValue() - 1);
	      }
	      model.addObject("orgid", orgid);
	      model.addObject("orgids", orgids);
	      model.addObject("useraccounts", this.userAccountService.listUserAccount(
	        orgid, orgids, thispage.intValue(), pagesize.intValue()));
	      model.setViewName("/pages/tjfx/listUsers");
	      return Model(model, thispage, pagesize, totalcount);
	    } catch (Exception e) {
	      e.printStackTrace();
	      return Error(e);
	    }
	  }

	  @RequestMapping({"/listActiveUsers"})
	  public ModelAndView listActiveUsers(ModelAndView model,@RequestParam(value="orgids", required=false) String orgids, @RequestParam(value="thispage", required=false) Integer thispage, @RequestParam(value="pagesize", required=false) Integer pagesize)
	  {
	    try
	    {
	      if (pagesize == null) {
	        pagesize = Integer.valueOf(20);
	      }
	      if (thispage == null) {
	        thispage = Integer.valueOf(0);
	      }
	      List<Object> allUser = sessionRegistry.getAllPrincipals();
	      List<UserAccount> userList=new ArrayList<UserAccount>();
	      for (int i = 0; i < allUser.size(); i++) {
				UserAccount user = (UserAccount) allUser.get(i);
				if(orgids.contains(user.getOrg().getId().toString())){
					userList.add(user);
				}
			}
	      Long totalcount = Long.valueOf(userList.size());
	      model.addObject("userList", userList);
	      model.setViewName("/pages/tjfx/listOnline"); 
	      return Model(model, thispage, pagesize, totalcount);
	    } catch (Exception e) {
	      e.printStackTrace();
	      return Error(e);
	    }
	  }
	  @RequestMapping({ "/listApp" })
		public ModelAndView listApp(
				ModelAndView model,
				@RequestParam(value = "thispage", required = false) Integer thispage,
				@RequestParam(value = "pagesize", required = false) Integer pagesize) {

			if (pagesize == null) {
				pagesize = Integer.valueOf(10);
			}
			if (thispage == null) {
				thispage = Integer.valueOf(0);
			}
			List resultList = new ArrayList();
			Long totalcount = this.synService.countAppAccount();
			if ((thispage.intValue() * pagesize.intValue() >= totalcount
					.longValue()) && (totalcount.longValue() > 0L)) {
				thispage = Integer.valueOf(thispage.intValue() - 1);
			}
			List<ApplicationInfo> appList = this.synService.listAppAccount(
					thispage, pagesize);
			for (int i = 0; i < appList.size(); i++) {
				Map resultMap = new HashMap();
				ApplicationInfo applicationInfo = appList.get(i);
				String id = applicationInfo.getId();
				resultMap.put("app", applicationInfo);
				String orgCount="select count(*) from SynOrg o where o.appId='"+id+"'";
				Long orgSum = this.commonDAO.count(orgCount);
				resultMap.put("orgSum", orgSum);
				String userCount="select count(*) from SynUser u where u.appId='"+id+"'";
				Long userSum = this.commonDAO.count(userCount);
				resultMap.put("userSum", userSum);
				resultList.add(resultMap);
			}
			model.addObject("resultList", resultList);
			model.setViewName("/pages/tjfx/appList");
			return Model(model, thispage, pagesize, totalcount);
		}
	  @RequestMapping({ "/listSynOrg" })
		public ModelAndView listSynOrg(
				ModelAndView model,
				@RequestParam(value = "thispage", required = false) Integer thispage,
				@RequestParam(value = "pagesize", required = false) Integer pagesize,
				@RequestParam(value = "appId", required = true) String appId) {
			try {
				if (pagesize == null) {
					pagesize = Integer.valueOf(10);
				}
				if (thispage == null) {
					thispage = Integer.valueOf(0);
				}
				String orgSql = "SELECT o. id,o. NAME,o.CODE,s.syn_time FROM t_org o LEFT JOIN syn_org s ON o.id = s.org_id WHERE	s.app_id = '"+appId+"' AND s.id IS NOT NULL ORDER BY	s.syn_time DESC";
				List orgList = this.commDAO
						.findByPage(orgSql, thispage, pagesize);
				String countSql = "SELECT count(*) FROM t_org o LEFT JOIN syn_org s ON o.id = s.org_id WHERE s.app_id = '"+appId+"' AND s.id IS NOT NULL ORDER BY	s.syn_time DESC";
				Long totalcount = this.commDAO.count(countSql);
				model.addObject("appId", appId);
				model.addObject("orgList", orgList);
				model.setViewName("/pages/tjfx/orgList");
				return Model(model, thispage, pagesize, totalcount);
			} catch (Exception e) {
				e.printStackTrace();
				return Error(e);
			}
		}
	  @RequestMapping({ "/listSynUser" })
		public ModelAndView listSynUser(
				ModelAndView model,
				@RequestParam(value = "thispage", required = false) Integer thispage,
				@RequestParam(value = "pagesize", required = false) Integer pagesize,
				@RequestParam(value = "appId", required = true) String appId) {
			try {
				if (pagesize == null) {
					pagesize = Integer.valueOf(10);
				}
				if (thispage == null) {
					thispage = Integer.valueOf(0);
				}
				String userSql = "SELECT u.CODE,u.NAME,u.LOGINNAME,s.syn_time FROM t_user_account  u LEFT JOIN syn_user s ON u.CODE = s.user_id WHERE s.app_id='"
						+ appId + "' AND s.id is NOT NULL and u.is_delete=false ORDER BY s.syn_time DESC";//--20161013用户假删除
				List userList = this.commDAO
						.findByPage(userSql, thispage, pagesize);
				String countSql = "SELECT count(*) FROM t_user_account  u LEFT JOIN syn_user s ON u.CODE = s.user_id WHERE s.app_id='"
						+ appId + "' AND s.id is NOT NULL and u.is_delete=false ORDER BY s.syn_time DESC";//--20161013用户假删除
				Long totalcount = this.commDAO.count(countSql);
				model.addObject("appId", appId);
				model.addObject("userList", userList);
				model.setViewName("/pages/tjfx/userList");
				return Model(model, thispage, pagesize, totalcount);
			} catch (Exception e) {
				e.printStackTrace();
				return Error(e);
			}
		}
}
