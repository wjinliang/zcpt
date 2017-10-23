package com.app.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.app.model.ApplicationInfo;
import com.app.model.SynLog;
import com.app.model.SynUser;
import com.app.service.AsyncService;
import com.app.service.SynService;
import com.app.util.TimeUtil;
import com.app.util.UUIDUtil;
import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.UserAccount;

@Service
public class AsyncServiceImpl implements AsyncService{
	
	@Resource
	private CommonDAO commonDAO;
	@Resource
	private SynService synService;
	@Async
	public void asyncUser(String userid){
		try {
			UserAccount mg = this.commonDAO.findOne(UserAccount.class, userid);
			String synAppSql = " from ApplicationInfo t where t.status='1' and t.id in(select u.appId from SynUser u where u.userId = '"
					+ mg.getCode() + "' ) order by seq";
			List<ApplicationInfo> applist = this.commonDAO
					.find(synAppSql);
			for (ApplicationInfo applicationInfo : applist) {
				String result = this.synService.synStart(
						applicationInfo.getId(), mg.getCode(), "12");
				String today = TimeUtil
						.getTheDateOfToday("yyyy-MM-dd HH:mm:ss");
				if (result != null && result.equals("000")) {
					result = "同步成功";
					String synSql = "from SynUser u where u.appId='"
							+ applicationInfo.getId()
							+ "' and u.userId= '" + mg.getCode() + "'";
					List<SynUser> synUserList = this.commonDAO
							.find(synSql);
					if (synUserList != null && synUserList.size() > 0) {
						for (int j = 0; j < synUserList.size(); j++) {
							synUserList.get(j).setSynTime(today);
							this.synService.update(synUserList.get(j));
						}
					}
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(applicationInfo.getId());
					synLog.setAppName(applicationInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("用户(" + mg.getName()
							+ ")更新密码操作：" + result);
					synLog.setSynUserId(mg.getCode());
					synLog.setSynUserName(mg.getName());
					this.synService.save(synLog);
				} else {
					SynLog synLog = new SynLog();
					synLog.setId(UUIDUtil.getUUID());
					synLog.setAppId(applicationInfo.getId());
					synLog.setAppName(applicationInfo.getAppName());
					synLog.setSynTime(today);
					synLog.setSynResult("用户(" + mg.getName()
							+ ")更新密码操作：" + result);
					synLog.setSynUserId(mg.getCode());
					synLog.setSynUserName(mg.getName());
					this.synService.save(synLog);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    } 
}
