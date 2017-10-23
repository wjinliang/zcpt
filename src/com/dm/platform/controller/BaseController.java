package com.dm.platform.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;

import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.dto.MessageDto;
import com.dm.platform.model.ApplyEntity;
import com.dm.platform.model.NoticeEntity;
import com.dm.platform.model.TempUser;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserAttrEntity;
import com.dm.platform.model.UserMenu;
import com.dm.platform.model.UserRole;
import com.dm.platform.service.ApplyService;
import com.dm.platform.service.NoticeService;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.service.UserAttrService;
import com.dm.platform.service.UserRoleService;
import com.dm.platform.util.CommonStatics;
import com.dm.platform.util.DmDateUtil;
import com.dm.platform.util.MailUtil;
import com.dm.platform.util.UserAccountUtil;

@Controller
public class BaseController extends DefaultController {

	@Resource
	UserRoleService userRoleService;

	@Resource
	UserAccountService userAccountService;

	@Resource
	CommonDAO commonDAO;

	@Resource
	ApplyService applyService;
	
	@Resource
	UserAttrService userAttrService;
	
	@Resource
	NoticeService noticeService;
	
	@Resource
	Cache myCache;

	@RequestMapping("/mainpage")
	public ModelAndView mainpage(ModelAndView model) {
		try {
			UserAccount currentUser = UserAccountUtil.getInstance()
					.getCurrentUserAccount();

			if (currentUser.getRoles().size() > 0) {
				Map<String, Object> map = new HashMap<String, Object>();
				map = noticeService.getAll(0, 5);
				model.addObject("notices",(List<NoticeEntity>)map.get("items"));
				model.setViewName("/pages/admin/index");
				return Model(model);
			} else {
				return Error("未授权角色");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Error(e);
		}
	}

	@RequestMapping("/regiest")
	public ModelAndView regiest(ModelAndView model) {
		model.setViewName("/regiest");
		return model;
	}

	@RequestMapping("/saveRegiest")
	public ModelAndView saveRegiest(ModelAndView model, TempUser tempUser) {
		try {
			String userId = String.valueOf(System.currentTimeMillis());
			tempUser.setCode(userId);
			tempUser.setStatus("0");
			tempUser.setName(tempUser.getLoginname());
			tempUser.setCreatDate(DmDateUtil.DateToStr(new Date(),
					"yyyy-MM-dd HH:mm:ss"));
			commonDAO.save(tempUser);
			ApplyEntity entity = new ApplyEntity();
			String applyId = String.valueOf(System.currentTimeMillis());
			entity.setApplyId(applyId);
			entity.setApplyContent("用户：" + tempUser.getName() + "("
					+ tempUser.getLoginname() + ")申请注册");
			entity.setApplyStatus("1");
			entity.setApplyUserId(tempUser.getCode());
			entity.setApplyObjType(CommonStatics.USER_REG);
			entity.setApplyObjId("1415526251354");
			entity.setApplyDate(DmDateUtil.DateToStr(new Date()));
			applyService.newApply(entity);
			//发送个特定用户审批
			UserAccount admin  = userAccountService.findOne("1");
			applyService.sendApply(applyId, "1", CommonStatics.NEED_APPROVE, 0);
			String messageId = messageService.newMessage("新用户注册消息",
					"有一个新用户注册:"+"用户：" + tempUser.getName() + "("
					+ tempUser.getLoginname() + ")申请注册",
					getWholePath() + "apply/approveForm?applyId=" + applyId,
					tempUser.getName()+" <"+tempUser.getEmail()+">",
					admin.getName()+" <"+admin.getEmail()+">",
					"1","0");
			//发送给特定用户
			messageService.sendMessage(messageId,"1");
			model.addObject("redirect", getRootPath() + "/login");
			model.setViewName("/pages/content/redirect");
			return model;
		} catch (Exception e) {
			e.printStackTrace();
			model.addObject("msg", "注册失败！");
			model.addObject("redirect", getRootPath() + "/login");
			model.setViewName("/pages/content/fail");
			return model;
		}
	}

	@RequestMapping("/infoCenter")
	public ModelAndView infoCenter(ModelAndView model) {
		UserAccount currentUser = UserAccountUtil.getInstance()
				.getCurrentUserAccount();
		//list = messageService.getNewMessages(currentUser.getCode());
		model.addObject("currentUser", currentUser);
		UserAttrEntity userAttr = userAttrService.findOne(currentUser.getCode());
		if(userAttr==null){
			userAttr = new UserAttrEntity();
			userAttr.setLayoutType("0");
		}
		model.addObject("userAttr", userAttr);
		model.addObject("userName", currentUser.getUsername());
		model.addObject("headPicUrl", currentUser.getHeadpic());
		model.addObject("remoteIpAddr", currentUser.getRemoteIpAddr());
		model.addObject("lastLoginTime", currentUser.getLastLoginTime());
		model.addObject("totalcount", messageService.getNewMessagesCount(currentUser.getCode()));
		model.setViewName("/pages/admin/infoCenter");
		return Model(model);
	}

	@RequestMapping("/login")
	public ModelAndView login(ModelAndView model) {
		model.setViewName("/login");
		return model;
	}

	@RequestMapping("/checkunique")
	public void checkloginname(HttpServletResponse response,
			@RequestParam(value = "param", required = false) String param,
			@RequestParam(value = "name", required = false) String name) {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out;
		try {
			out = response.getWriter();
			if (commonDAO.findByPropertyName(UserAccount.class, name, param)
					.size() > 0) {
				out.write("n");
			} else {
				out.write("y");
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping("/resetPassword")
	public ModelAndView resetPassword(ModelAndView model,
			@RequestParam(value = "email", required = true) String email)
			throws IOException {
		try {
			UserAccount user = new UserAccount();
			user = userAccountService.findByEmail(email);
			if (user != null) {
				String newPassword = getRandomString(12);
				ShaPasswordEncoder sha = new ShaPasswordEncoder();
				sha.setEncodeHashAsBase64(false);
				String jiamicode = sha.encodePassword(newPassword, null);
				user.setPassword(jiamicode);
				userAccountService.updateUser(user);
				MailUtil.getInstance().sendMail(user.getEmail(), "重置密码",
						"新的密码：" + newPassword + "请妥善保管！");
				return Redirect(model, getRootPath() + "/login",
						"重置密码成功，请查收邮件！");
			} else {
				return Redirect(model, getRootPath() + "/login", "该邮箱注册的用户不存在！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return RedirectError(model, getRootPath() + "/login", "重置密码失败！");
		}
	}

	private String getRandomString(int length) { // length表示生成字符串的长度
		String base = "abcdefghijklmnopqrstuvwxyz0123456789";
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int number = random.nextInt(base.length());
			sb.append(base.charAt(number));
		}
		return sb.toString();
	}
	
	
	@RequestMapping("/loadMenus")
	public @ResponseBody
	Object loadMenus() {
		try {
			Comparator<UserMenu> c = new Comparator<UserMenu>() {
				 public int compare(UserMenu o1, UserMenu o2) {
			           return (int) (o1.getSeq()-o2.getSeq());
			    }
			};
			Set<UserMenu> menus = new HashSet<UserMenu>();
			List list = new ArrayList();
			String[] roleid = UserAccountUtil.getInstance().getCurrentRoles().split(",");
			List<UserMenu> menuList = new ArrayList<UserMenu>();
			for (String id : roleid) {
				if(myCache.get(id)==null){
					putOneRole(id);
				}
				for (UserMenu m : (Set<UserMenu>)myCache.get(id).getObjectValue()) {
					menus.add(m);
				}
			}
			for (UserMenu userMenu : menus) {
				if(userMenu.getIsShow()!=null && userMenu.getIsShow().equals("0"))
					continue;
				menuList.add(userMenu);
			}
			Collections.sort(menuList,c);
			for (UserMenu m : menuList) {
				Map map = new HashMap();
				map.put("id", m.getId());
				map.put("name", m.getName());
				if(m.getPuserMenu()!=null){
					if (!menuList.contains(m.getPuserMenu())) {
						map.put("pId", new Long(0));
					}else{
						map.put("pId", m.getPuserMenu().getId());
					}
				}else{
					map.put("pId", new Long(0));
				}
				map.put("icon", m.getIcon());
				map.put("url", m.getUrl());
				if(m.getChildren().size()==0){
					map.put("isLeaf", true);
				}else{
					map.put("isLeaf", false);
				}
				list.add(map);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return errorJson("异常");
		}
	}
	
	private void putOneRole(String roleId){
		UserRole u = commonDAO.findOne(UserRole.class, roleId);
		putMenusByRole(u);
	}
	private void putMenusByRole(UserRole u){
		Set<UserMenu> menus = new HashSet<UserMenu>();
		menus=u.getMenus();
		Element element = new Element(u.getCode(), menus);  
		myCache.put(element);
	}
	
	@RequestMapping("/loadInbox")
	public @ResponseBody
	Object loadInbox() {
		String userId = UserAccountUtil.getInstance()
				.getCurrentUserId();
		Map<String,Object> map = messageService.getNewMessages(userId, 0, 5);
		List<MessageDto> list = (List<MessageDto>)map.get("items");
		List items = new ArrayList();
		for (MessageDto messageDto : list) {
			Map msg = new HashMap();
			msg.put("from",messageDto.getFrom());
			msg.put("time",messageDto.getMessageTime());
			msg.put("message", messageDto.getMessageSubject());
			msg.put("link", getRootPath()+"/message/messageCenter?messageId="+messageDto.getMessageId());
			msg.put("attch", true);
			items.add(msg);
		}
		return items;
	}
	
	@RequestMapping("/inboxTotal")
	public void inboxTotal(
			HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			String userId = UserAccountUtil.getInstance()
					.getCurrentUserId();
			Long total = (long) messageService.getNewMessagesCount(userId);
			String totalStr = total==0?"":String.valueOf(total);
			out.write(totalStr);
			out.flush();
			out.close();
		} catch (Exception e) {
			out.write("");
			out.flush();
			out.close();
		}
	}
}
