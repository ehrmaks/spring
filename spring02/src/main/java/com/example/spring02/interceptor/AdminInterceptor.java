package com.example.spring02.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = 
			LoggerFactory.getLogger(AdminInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("Admin preHandle");
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("admin_userid")==null) {
			response.sendRedirect(request.getContextPath() + 
					"/admin/login.do?message=nologin");
			return false;
		} else {
			
			return true;
		}
	}

}
