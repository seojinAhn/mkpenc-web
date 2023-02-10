package com.mkpenc.alarm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.admin.model.DccSearchAdmin;
import com.mkpenc.admin.model.IOListInfo;
import com.mkpenc.admin.model.MemberInfo;
import com.mkpenc.alarm.model.DccSearchAlarm;
import com.mkpenc.alarm.service.DccAlarmService;
import com.mkpenc.common.module.FileHelperUtil;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/alarm/")
public class DccAlarmContentsController {

	private static Logger logger = LoggerFactory.getLogger(DccAlarmContentsController.class);
	
	private String menuName = "ALARM";
	
	@Autowired
	private FileHelperUtil fileHelperUtil;
	
	@Autowired
	private DccAlarmService dccAlarmService;
	
	@RequestMapping("alarm")
	public ModelAndView alarm(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
		
        ModelAndView mav = new ModelAndView();

        logger.info("############ alarm");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }       

        return mav;
    }	
	
	
	@RequestMapping("alarmsearch")
	public ModelAndView alarmsearch(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ alarmsearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }       

        return mav;
    }		
	
	@RequestMapping("summary")
	public ModelAndView summary(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ summary");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }       

        return mav;
    }		
	
	@RequestMapping("earlywarning")
	public ModelAndView earlywarning(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ earlywarning");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
       

        return mav;
    }
	
	@RequestMapping("fixedtimecontrol")
	public ModelAndView fixedtimecontrol(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ fixedtimecontrol");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        

        return mav;
    }
	
	@RequestMapping("gaschromatography")
	public ModelAndView gaschromatography(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();


        logger.info("############ gaschromatography");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        

        return mav;
    }
}
