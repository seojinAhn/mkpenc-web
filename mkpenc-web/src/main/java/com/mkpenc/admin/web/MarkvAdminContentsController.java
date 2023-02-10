package com.mkpenc.admin.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.admin.model.MarkvSearchAdmin;
import com.mkpenc.admin.model.MemberGroupInfo;
import com.mkpenc.admin.model.MemberInfo;
import com.mkpenc.admin.service.MarkvAdminService;
import com.mkpenc.common.module.PageHtmlUtil;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/markv/admin/")
public class MarkvAdminContentsController {
	private static Logger logger = LoggerFactory.getLogger(MarkvAdminContentsController.class);
	
	@Autowired
	private MarkvAdminService markvAdminService;
	
	@Autowired
	private PageHtmlUtil pageHtmlUtil;
	
	private String menuName = "ADMIN";
	
	@RequestMapping("taginfo")
	public ModelAndView taginfo(MarkvSearchAdmin markvSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ taginfo");
      
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchAdmin.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }
}
