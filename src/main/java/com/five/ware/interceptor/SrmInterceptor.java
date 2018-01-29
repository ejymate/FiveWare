package com.five.ware.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SrmInterceptor extends HandlerInterceptorAdapter {

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		boolean check = false;
		
		HttpSession session = request.getSession();
		
		String kind = (String)session.getAttribute("kind");
		if(kind.equals("store")) {
			modelAndView.setViewName("common/notSrmResult");
			modelAndView.addObject("check", !check);
		}
	}
}
