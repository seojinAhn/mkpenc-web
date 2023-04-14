package com.mkpenc.mark.performance.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.mark.performance.model.MarkvSearchPerformance;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/markv/performance/")
public class MarkvPerformanceContentsController {

	private static Logger logger = LoggerFactory.getLogger(MarkvPerformanceContentsController.class);
	
	private String menuName = "PERFORMANCE";
	
	@RequestMapping("fixed")
	public ModelAndView fixed(MarkvSearchPerformance markvSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ fixed");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchPerformance.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("spare")
	public ModelAndView spare(MarkvSearchPerformance markvSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ spare");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchPerformance.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	
}
