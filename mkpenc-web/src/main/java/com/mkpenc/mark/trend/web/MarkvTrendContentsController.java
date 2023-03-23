package com.mkpenc.mark.trend.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.mark.trend.model.MarkvSearchTrend;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/markv/trend/")
public class MarkvTrendContentsController {
	
	private static Logger logger = LoggerFactory.getLogger(MarkvTrendContentsController.class);
	
	private String menuName = "TREND";
	
	@RequestMapping("realtimetrendfixed")
	public ModelAndView realtimetrendfixed(MarkvSearchTrend markvSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ realtimetrendfixed");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("realtimetrendspare")
	public ModelAndView realtimetrendspare(MarkvSearchTrend markvSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ realtimetrendspare");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("logfixed")
	public ModelAndView logfixed(MarkvSearchTrend markvSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ logfixed");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("logshare")
	public ModelAndView logshare(MarkvSearchTrend markvSearchTrend, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ logshare");
		
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
              

        return mav;
    }
	
	

}
