package com.dm.platform.security;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.dm.platform.dao.CommonDAO;
import com.dm.platform.model.UserAccount;


public class MySimpleUrlAuthenticationFailureHandler implements
		AuthenticationFailureHandler {

	@Resource
	CommonDAO commonDAO;
	protected final Log logger = LogFactory.getLog(getClass());
	private boolean forwardToDestination = false;
	private boolean allowSessionCreation = true;
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	public final static String TRY_MAX_COUNT = "tryMaxCount";
	private int maxTryCount = 3;

	private String defaultFailureUrl;

	public MySimpleUrlAuthenticationFailureHandler() {
	}

	public void onAuthenticationFailure(HttpServletRequest request,
			HttpServletResponse response, AuthenticationException exception) {
		/**
		 * 次数限制
		 */
		HttpSession session = request.getSession();

		session.setAttribute(MyUsernamePasswordAuthenticationFilter.VALIDATE_CODE, Math.random());
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
				}
				session.setAttribute(name+"_"+ TRY_MAX_COUNT,tryCount + 1);
			}
		}

		/**
		 * 次数限制结束------------------
		 */
		try {
			// 觉得默认跳转的地方
			if (defaultFailureUrl == null) {
				logger.debug("No failure URL set, sending 401 Unauthorized error");

				response.sendError(HttpServletResponse.SC_UNAUTHORIZED,
						"Authentication Failed: " + exception.getMessage());
			} else {
				saveException(request, exception);

				if (forwardToDestination) {
					logger.debug("Forwarding to " + defaultFailureUrl);

					request.getRequestDispatcher(defaultFailureUrl).forward(
							request, response);
				} else {
					logger.debug("Redirecting to " + defaultFailureUrl);
					redirectStrategy.sendRedirect(request, response,
							defaultFailureUrl);
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * Caches the {@code AuthenticationException} for use in view rendering.
	 * <p>
	 * If {@code forwardToDestination} is set to true, request scope will be
	 * used, otherwise it will attempt to store the exception in the session. If
	 * there is no session and {@code allowSessionCreation} is {@code true} a
	 * session will be created. Otherwise the exception will not be stored.
	 */
	protected void saveException(HttpServletRequest request,
			AuthenticationException exception) {
		if (forwardToDestination) {
			request.setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION,
					exception);
		} else {
			HttpSession session = request.getSession(false);

			if (session != null || allowSessionCreation) {
				request.getSession().setAttribute(
						WebAttributes.AUTHENTICATION_EXCEPTION, exception);
			}
		}
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}
}
