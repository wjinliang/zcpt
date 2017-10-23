package com.dm.platform.interceptor;

import java.lang.reflect.Method;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.dm.platform.target.FormToken;

public class FormTokenInterceptor extends HandlerInterceptorAdapter {
	
	@Override  
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {  
        if (handler instanceof HandlerMethod) {  
            HandlerMethod handlerMethod = (HandlerMethod) handler;  
            Method method = handlerMethod.getMethod();  
            FormToken annotation = method.getAnnotation(FormToken.class);  
            if (annotation != null) {  
                boolean needSaveSession = annotation.save();  
                if (needSaveSession) {  
                    request.getSession(false).setAttribute("FORM_TOKEN", UUID.randomUUID().toString());  
                }  
                boolean needRemoveSession = annotation.remove();  
                if (needRemoveSession) {  
                    if (isRepeatSubmit(request)) {  
                        return false;  
                    }  
                    request.getSession(false).removeAttribute("FORM_TOKEN");  
                }  
            }  
            return true;  
        } else {  
            return super.preHandle(request, response, handler);  
        }  
    }  
  
    private boolean isRepeatSubmit(HttpServletRequest request) {  
        String serverToken = (String) request.getSession(false).getAttribute("FORM_TOKEN");  
        if (serverToken == null) {  
            return true;  
        }  
        String clinetToken = request.getParameter("FORM_TOKEN");  
        if (clinetToken == null) {  
            return true;  
        }  
        if (!serverToken.equals(clinetToken)) {  
            return true;  
        }  
        return false;  
    }  

}
