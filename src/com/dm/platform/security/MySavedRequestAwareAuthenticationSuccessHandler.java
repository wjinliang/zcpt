package com.dm.platform.security;

import java.io.IOException;
import java.util.Collection;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.dm.platform.model.LogEntity;
import com.dm.platform.model.UserAccount;
import com.dm.platform.model.UserRole;
import com.dm.platform.service.LogService;
import com.dm.platform.service.UserAccountService;
import com.dm.platform.service.UserRoleService;
import com.dm.platform.util.DmDateUtil;

public class MySavedRequestAwareAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler{
	protected final Log logger = LogFactory.getLog(this.getClass());  
	@Resource
	LogService logService;  
	@Resource
	UserAccountService userAccountService;
	@Resource
	UserRoleService userRoleService;
    private RequestCache requestCache = new HttpSessionRequestCache();  
    private String LOCAL_SERVER_URL;  
    public final static String TRY_MAX_COUNT = "tryMaxCount";
    @Override  
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,  
            Authentication authentication) throws ServletException, IOException {  
    	String loginTime = DmDateUtil
 				.DateToStr(new Date(), "yyyy-MM-dd HH:mm:ss");
        UserAccount user=(UserAccount)authentication.getPrincipal();
        Long loginCount = user.getLoginCount();
        LogEntity le = new LogEntity();
 		le.setDate(loginTime);
 		le.setType("0");
 		le.setTitle("登录成功");
 		le.setContent("用户名:" + user.getName());
 		le.setUser(user.getName()+"("+user.getCode()+")");
 		le.setIp(getIpAddress(request));
 		logService.insert(le);
 		user.setLastLoginTime(loginTime);
 		user.setLoginCount(user.getLoginCount()+1);
 		user.setRemoteIpAddr(getIpAddress(request));
 		userAccountService.updateUser(user);
 		//清除最大尝试次数
 		request.getSession().removeAttribute(user.getLoginname()+"_tryMaxCount");
    	SavedRequest savedRequest = requestCache.getRequest(request, response);  
        if (savedRequest == null) {  
            //用户判断是否要使用上次通过session里缓存的回调URL地址  
            int flag = 0;  
            //通过提交登录请求传递需要回调的URL callCustomRediretUrl  
            if(request.getSession().getAttribute("callCustomRediretUrl") != null && !"".equals(request.getSession().getAttribute("callCustomRediretUrl"))){  
                String url = String.valueOf(request.getSession().getAttribute("callCustomRediretUrl"));  
                //若session 存在则需要使用自定义回调的URL 而不是缓存的URL  
                super.setDefaultTargetUrl(url);  
                super.setAlwaysUseDefaultTargetUrl(true);  
                flag = 1;  
                request.getSession().setAttribute("callCustomRediretUrl", "");  
            }  
            //重设置默认URL为主页地址  
            if(flag  == 0){  
            	Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities(); 
                for (GrantedAuthority grantedAuthority : authorities) {  
                	UserRole ur = userRoleService.findOne(grantedAuthority.getAuthority());
                	if(ur!=null&&!ur.getHomePage().equals(""))
                	LOCAL_SERVER_URL=ur.getHomePage();
                break;
            }
             if(LOCAL_SERVER_URL==null)
             {
            	LOCAL_SERVER_URL = "/login";
             }
             else{
              super.setDefaultTargetUrl(LOCAL_SERVER_URL); 
             }
            }  
           /* if(loginCount==0){
            	LOCAL_SERVER_URL="/login?error=pwd";
            	super.setDefaultTargetUrl(LOCAL_SERVER_URL); 
    		}*/
            super.onAuthenticationSuccess(request, response, authentication);  
            return;  
        }  
        //targetUrlParameter 是否存在  
        String targetUrlParameter = getTargetUrlParameter();  
        if (isAlwaysUseDefaultTargetUrl() || (targetUrlParameter != null && StringUtils.isNotEmpty(request.getParameter(targetUrlParameter)))) {  
            requestCache.removeRequest(request, response);  
            super.setAlwaysUseDefaultTargetUrl(false);  
            super.setDefaultTargetUrl("/");  
            super.onAuthenticationSuccess(request, response, authentication);  
            return;  
        }  
        //清除属性  
        clearAuthenticationAttributes(request);  
        // Use the DefaultSavedRequest URL  
        String targetUrl = savedRequest.getRedirectUrl();  
        logger.debug("Redirecting to DefaultSavedRequest Url: " + targetUrl); 
        if(targetUrl != null && "".equals(targetUrl)){  
            targetUrl = LOCAL_SERVER_URL;  
        }  
		if(targetUrl==null)
        {
        	throw new AuthenticationServiceException("未授权角色！");
        }
		/*if(loginCount==0){
			targetUrl="/login?error=pwd";
		}*/
        getRedirectStrategy().sendRedirect(request, response, targetUrl);  
    }  
    
    public String getIpAddress(HttpServletRequest request){    
        String ip = request.getHeader("x-forwarded-for");    
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {    
            ip = request.getHeader("Proxy-Client-IP");    
        }    
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {    
            ip = request.getHeader("WL-Proxy-Client-IP");    
        }    
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {    
            ip = request.getHeader("HTTP_CLIENT_IP");    
        }    
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {    
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");    
        }    
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {    
            ip = request.getRemoteAddr();    
        }    
        return ip;    
    }  

    public void setRequestCache(RequestCache requestCache) {  
        this.requestCache = requestCache;  
    }

}
