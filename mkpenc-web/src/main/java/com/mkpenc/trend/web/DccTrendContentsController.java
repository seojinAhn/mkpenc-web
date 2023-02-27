package com.mkpenc.trend.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.trend.model.DccSearchTrend;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/trend/")
public class DccTrendContentsController {
	
	private static Logger logger = LoggerFactory.getLogger(DccTrendContentsController.class);
	
	private String menuName = "TREND";
	
	@RequestMapping("realtimetrendfixed")
	public ModelAndView realtimetrendfixed(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ realtimetrendfixed");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("realtimetrendspare")
	public ModelAndView realtimetrendspare(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ realtimetrendspare");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("ftamtrend")
	public ModelAndView ftamtrend(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ ftamtrend");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("dccmarkvtrend")
	public ModelAndView dccmarkvtrend(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ dccmarkvtrend");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("barchartfixed")
	public ModelAndView barchartfixed(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ barchartfixed");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("barchartspare")
	public ModelAndView barchartspare(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ barchartspare");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("logfixedlist")
	public ModelAndView logfixedlist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ logfixedlist");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("logsharelist")
	public ModelAndView logsharelist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ logsharelist");
		
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        
       

        return mav;
    }
	
	@RequestMapping("numericallist")
	public ModelAndView numericallist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ numericallist");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        
        

        return mav;
    }	

}
