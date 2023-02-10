package com.mkpenc.main.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.admin.model.EquipInfo;
import com.mkpenc.admin.model.MemberInfo;
import com.mkpenc.admin.service.DccAdminService;
import com.mkpenc.common.model.Upload;
import com.mkpenc.common.module.PageHtmlUtil;
import com.mkpenc.main.model.NoticeInfo;
import com.mkpenc.main.model.SearchMain;
import com.mkpenc.main.service.MainService;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/main/")
public class MainContentsController {
	
	private static Logger logger = LoggerFactory.getLogger(MainContentsController.class);
	
	@Autowired
	private MainService mainService;
	
	@Autowired
	private PageHtmlUtil pageHtmlUtil;
	
	private String menuName = "MAIN";
	
	@RequestMapping("noticelist")
	public ModelAndView noticelist(SearchMain searchMain, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();

        logger.info("############ noticelist");

        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(searchMain.getSearchKey() != null && !searchMain.getSearchKey().isEmpty()) {
        		if(searchMain.getSearchKey().equals("title")){
        			searchMain.setsTitle(searchMain.getSearchWord());;
        		}else if(searchMain.getSearchKey().equals("content")){
        			searchMain.setsContents(searchMain.getSearchWord());
        		}
        	}
        	
        	int noticeTotalCnt = mainService.selectNoticeTotalCnt(searchMain);
        	searchMain.setTotalCnt(noticeTotalCnt);
        	
        	List<NoticeInfo> noticeInfoList = mainService.selectNoticeList(searchMain);
        	
        	searchMain.setMenuName(this.menuName);
        	
        	mav.addObject("NoticeInfoList", noticeInfoList);
        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(searchMain));       	

        	
        	mav.addObject("BaseSearch", searchMain);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        }
 
        return mav;
    }
	
	@RequestMapping("noticeinsert")
	@ResponseBody
	public ModelAndView noticeinsert(NoticeInfo noticeInfo, HttpServletRequest request) {
        
        logger.info("############ noticeinsert");
        
		ModelAndView mav = new ModelAndView("jsonView");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo memberInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	noticeInfo.setId(memberInfo.getId());
        
        	int rtn =  mainService.insertNoticeInfo(noticeInfo);
			   
        	mav.addObject("Rtn", rtn);
        }
        
        return mav;
    }
	
	@RequestMapping("noticeupdate")
	@ResponseBody
	public ModelAndView noticeupdate(NoticeInfo noticeInfo, HttpServletRequest request) {
        
		logger.info("############ noticeupdate");
		
		ModelAndView mav = new ModelAndView("jsonView");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo memberInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	noticeInfo.setId(memberInfo.getId());
        	
        	int rtn = mainService.updateNoticeInfo(noticeInfo);
        
        	mav.addObject("Rtn", rtn);
        }
        
        return mav;
    }
	
	@RequestMapping("noticedelete")
	@ResponseBody
	public ModelAndView noticedelete(NoticeInfo noticeInfo, HttpServletRequest request) {
        
		logger.info("############ noticedelete");
		
		ModelAndView mav = new ModelAndView("jsonView");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
            MemberInfo memberInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
            noticeInfo.setId(memberInfo.getId());
        	
        	int rtn = mainService.deleteNoticeInfo(noticeInfo);
        
        	mav.addObject("Rtn", rtn);
        }
        
        return mav;
    }	
	
	
	@RequestMapping(value="dashboard")
	public ModelAndView dashboard(SearchMain searchMain, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ dashboard");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	//Get Session User Info        	
        	
        	mav.addObject("BashSearch", searchMain);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	logger.info("############ dashboard login status..!!!!");
        }else {

        	logger.info("############ dashboard logout status..!!!!");
        }

        return mav;
    }


}
