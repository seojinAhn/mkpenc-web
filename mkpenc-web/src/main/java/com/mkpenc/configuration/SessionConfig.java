package com.mkpenc.configuration;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mkpenc.common.interceptor.LoginInterceptor;

@WebListener
public class SessionConfig implements HttpSessionListener {
	
	private static Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	private static final Map<String, HttpSession> sessions = new ConcurrentHashMap<>();
	
	public synchronized static String getSessionidCheck(String type, String compareId){
		
		logger.info("############ getSessionidCheck===>" + type);
		logger.info("############ getSessionidCheck===>" + compareId);
		
		String result = "";
		
		for( String key : sessions.keySet() ){
			logger.debug("getSessionidCheck key : " + key);
			HttpSession hs = sessions.get(key);
			
			if(hs != null &&  hs.getAttribute(type) != null && hs.getAttribute(type).toString().equals(compareId) ){
				result =  key.toString();
				break;
			}
		}
		
		removeSessionForDoubleLogin(result);
		return result;
	}
	
	private static void removeSessionForDoubleLogin(String key){    	
		
		logger.info("removeSessionForDoubleLogin key : " + key);
		
		if(key != null && key.length() > 0){
			sessions.get(key).invalidate();
			sessions.remove(key);    		
		}
	}
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		logger.info("sessionCreated : " + se);
		sessions.put(se.getSession().getId(), se.getSession());
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		logger.info("sessionDestroyed : " + se);
		
		if(sessions.get(se.getSession().getId()) != null){
			sessions.get(se.getSession().getId()).invalidate();
			sessions.remove(se.getSession().getId());	
		}
		
	}
}
