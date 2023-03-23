package com.mkpenc.mark.alarm.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.mark.alarm.model.MarkvSearchAlarm;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/markv/alarm/")
public class MarkvAlarmContentsController {

	private static Logger logger = LoggerFactory.getLogger(MarkvAlarmContentsController.class);
	
	private String menuName = "ALARM";
	
	@RequestMapping("earlywarning")
	public ModelAndView earlywarning(MarkvSearchAlarm markvSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ earlywarning");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

       

        return mav;
    }
	
	@RequestMapping("fixedtimecontrol")
	public ModelAndView fixedtimecontrol(MarkvSearchAlarm markvSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ fixedtimecontrol");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        

        return mav;
    }
	
	@RequestMapping("gaschromatography")
	public ModelAndView gaschromatography(MarkvSearchAlarm markvSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ gaschromatography");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        

        return mav;
    }
}
