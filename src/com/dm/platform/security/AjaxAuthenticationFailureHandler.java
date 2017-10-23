package com.dm.platform.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.dm.platform.dao.impl.CommonDAOImpl;
import com.dm.platform.model.UserAccount;

public class AjaxAuthenticationFailureHandler implements AuthenticationFailureHandler {
	@Resource
	CommonDAOImpl commonDAO;
    protected final Log logger = LogFactory.getLog(getClass());
    public final static String TRY_MAX_COUNT="tryMaxCount";  
    private int maxTryCount=3;  
    
    public AjaxAuthenticationFailureHandler() {  
    }  
  
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,  
            AuthenticationException exception) throws IOException, ServletException {
		/**
		 * 次数限制
		 */
    	String tryMsg=null;
		HttpSession session = request.getSession();
		if (exception.getMessage().equals("密码不正确")) {
			String name = request
					.getParameter(UsernamePasswordAuthenticationFilter.SPRING_SECURITY_FORM_USERNAME_KEY);
			UserAccount u = null;
			if (commonDAO.findByPropertyName(UserAccount.class, "loginname", name)
					.size() > 0) {
				u = commonDAO.findByPropertyName(UserAccount.class, "loginname",
						name).get(0);
			}
			Integer tryCount = (Integer) session.getAttribute(name + "_"
					+ TRY_MAX_COUNT);
			if (tryCount == null) {
				session.setAttribute(name + "_" + TRY_MAX_COUNT, 1);// 增加失败次数
			} else {
				if (tryCount > maxTryCount - 1) {
					// 锁定账户
					u.setLocked(true);
					commonDAO.update(u);
					session.setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION,
							new AuthenticationServiceException("超过最大登录尝试次数"
									+ maxTryCount + ",用户已被锁定"));
					tryMsg = "超过最大登录尝试次数"+maxTryCount+",用户已被锁定";
				}
				session.setAttribute(name+"_"+ TRY_MAX_COUNT,tryCount + 1);
			}
		}

		/**
		 * 次数限制结束------------------
		 */
        
        ObjectMapper objectMapper = new ObjectMapper();  
        response.setHeader("Content-Type", "application/json;charset=UTF-8");  
        JsonGenerator jsonGenerator = objectMapper.getJsonFactory().createJsonGenerator(response.getOutputStream(),  
                JsonEncoding.UTF8);  
        try {  
        	String msg = tryMsg==null?exception.getMessage():tryMsg;
        	//失败为1  
        	Map map = new HashMap();
        	map.put("status", 1);
        	map.put("msg",msg==null?"":msg);
        	JSONObject jsonData = JSONObject.fromObject(map);  
            objectMapper.writeValue(jsonGenerator, jsonData);  
        } catch (JsonProcessingException ex) {  
            throw new HttpMessageNotWritableException("Could not write JSON: " + ex.getMessage(), ex);  
        }  
    }  
}
