package com.mkpenc.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mkpenc.dcc.admin.model.MemberInfo;


@Component
public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	private static Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        
    	logger.info("[LoginInterceptor] preHandle");
    	
    	boolean result = false;
    	
        try {
        	
        	if (request.getSession().getAttribute("USER_INFO") == null ){
        		
        		if(isAjaxRequest(request)) {
        			response.setContentType("application/json; charset=UTF-8");        			
					result =  true;
        		}else {
        			response.sendRedirect("/main/dashboard?noLogin=Y");
        			result = false;
        		}
        		
        	}else {
        		
        		MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	  	logger.info("Login Request URI:  " + userInfo.getUserName() );
        	  	result = true;
        	}
        	
        } catch (Exception e) {
        		e.printStackTrace();
        }
        return result;
    }
    
    private boolean isAjaxRequest(HttpServletRequest req) {
		String header = req.getHeader("AJAX");
		logger.info("[LoginInterceptor] isAjaxRequest  == " + header);
		
		if ("true".equals(header)){
			return true;
		}else{
			return false;
		}
	}
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,    ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub
    	
    	 logger.info("[LoginInterceptor] postHandle-start");
    	 
    	 logger.info("[LoginInterceptor] postHandle-end");
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // TODO Auto-generated method stub
    	
    	 logger.info("[LoginInterceptor] afterCompletion");
        
    }

}