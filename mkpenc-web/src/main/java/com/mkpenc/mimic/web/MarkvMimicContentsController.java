package com.mkpenc.mimic.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.mimic.model.MarkvSearchMimic;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/markv/mimic/")
public class MarkvMimicContentsController {

	private static Logger logger = LoggerFactory.getLogger(MarkvMimicContentsController.class);
	
	private String menuName = "MIMIC";
	
	@RequestMapping("loadcontrol")
	public ModelAndView loadcontrol(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ loadcontrol");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("modeselection")
	public ModelAndView modeselection(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ modeselection");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("prepforrolloff")
	public ModelAndView prepforrolloff(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ prepforrolloff");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("speedcontrol")
	public ModelAndView speedcontrol(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ speedcontrol");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("generaldata")
	public ModelAndView generaldata(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ generaldata");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		

	
	@RequestMapping("tbnoverview")
	public ModelAndView tbnoverview(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ tbnoverview");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("loggingdata")
	public ModelAndView loggingdata(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ loggingdata");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("drainvalvepos")
	public ModelAndView drainvalvepos(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ drainvalvepos");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("gentcrtd1")
	public ModelAndView gentcrtd1(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ gentcrtd1");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("gentcrtd2")
	public ModelAndView gentcrtd2(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ gentcrtd2");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("valvetightness")
	public ModelAndView valvetightness(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ valvetightness");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
}
