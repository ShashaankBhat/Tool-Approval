package com.anand;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class RequestInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		try {
			String expectedHost;
			if (request.getRequestURL().toString().contains("localhost")) {
				expectedHost = "localhost:8080";
			} else if (request.getRequestURL().toString().contains("172.16.6.42")) {
				expectedHost = "172.16.6.42:8080";
			} else {
				expectedHost = "corporateia.anandgroupindia.com";
			}
            String actualHost = request.getHeader("Host");
            if (actualHost != null && actualHost.equals(expectedHost)) {
            	return true;
            } else {
            	response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid Host Header");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        try {
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        try {
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
