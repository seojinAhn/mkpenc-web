package com.mkpenc.dcc.main.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.dcc.admin.model.MemberGroupInfo;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.service.DccAdminService;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.common.module.PageHtmlUtil;
import com.mkpenc.dcc.common.service.BasDccOsmsService;
import com.mkpenc.dcc.main.model.NoticeInfo;
import com.mkpenc.dcc.main.model.SearchMain;
import com.mkpenc.dcc.main.service.MainService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	
	@Autowired	
	private BasDccOsmsService basDccOsmsService;
	
	@Autowired	
	DccAdminService dccAdminService;
	
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
        
        //if(request.getSession().getAttribute("USER_INFO") != null) {
        
        if( request.getParameter("noLogin") != null && "Y".equalsIgnoreCase(request.getParameter("noLogin")) ) {
        	searchMain.setNoLogin(request.getParameter("noLogin"));
        }
        	
        	if(searchMain.getsMenuNo() == null || searchMain.getsMenuNo().isEmpty()) {
            	
        		searchMain.setsDive("D");
        		searchMain.setsMenuNo("0");
        		searchMain.setsGrpID("mimic");
        		searchMain.setsUGrpNo("0");
        		
        		if(request.getSession().getAttribute("USER_INFO") != null) {
        		
	        		//Get Session User Info   	        	
		        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		        	searchMain.setsHogi(member.getHogi());
		        	searchMain.setsXYGubun(member.getXyGubun());
        		}else {
        			searchMain.setsHogi("3");
		        	searchMain.setsXYGubun("X");
        		}
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",searchMain.getsXYGubun()==null?  "": searchMain.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",searchMain.getsHogi()==null?  "": searchMain.getsHogi());
    		dccGrpTagSearchMap.put("dive",searchMain.getsDive()==null?  "": searchMain.getsDive());
    		dccGrpTagSearchMap.put("grpID", searchMain.getsGrpID()==null?  "": searchMain.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", searchMain.getsMenuNo()==null?  "": searchMain.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", searchMain.getsUGrpNo()==null?  "": searchMain.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
    		
    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);  
        	
        	mav.addObject("BaseSearch", searchMain);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	List<MemberGroupInfo> groupComboList = dccAdminService.selectMemberGroupCombo();
        	mav.addObject("GroupComboList", groupComboList);
        	
        	logger.info("############ dashboard login status..!!!!");
        	
        //}else {

        //	logger.info("############ dashboard logout status..!!!!");
        //}

        return mav;
    }
	
	@RequestMapping(value="reloadDB", method= { RequestMethod.POST })
	@ResponseBody
	public ModelAndView reloadDB(SearchMain searchMain, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadDB");
        
        //if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(searchMain.getsMenuNo() == null || searchMain.getsMenuNo().isEmpty()) {
            	
        		searchMain.setsDive("D");
        		searchMain.setsMenuNo("0");
        		searchMain.setsGrpID("mimic");
        		searchMain.setsUGrpNo("0");
        		
        		if(request.getSession().getAttribute("USER_INFO") != null) {
        		
	        		//Get Session User Info   	        	
		        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		        	searchMain.setsHogi(member.getHogi());
		        	searchMain.setsXYGubun(member.getXyGubun());
        		}else {
        			searchMain.setsHogi(searchMain.getsHogi() == null ? "3" : searchMain.getsHogi());
		        	searchMain.setsXYGubun(searchMain.getsXYGubun() == null ? "X" : searchMain.getsXYGubun());
        		}
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",searchMain.getsXYGubun()==null?  "": searchMain.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",searchMain.getsHogi()==null?  "": searchMain.getsHogi());
    		dccGrpTagSearchMap.put("dive",searchMain.getsDive()==null?  "": searchMain.getsDive());
    		dccGrpTagSearchMap.put("grpID", searchMain.getsGrpID()==null?  "": searchMain.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", searchMain.getsMenuNo()==null?  "": searchMain.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", searchMain.getsUGrpNo()==null?  "": searchMain.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
    		
    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);  
        	
        	mav.addObject("BashSearch", searchMain);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	List<MemberGroupInfo> groupComboList = dccAdminService.selectMemberGroupCombo();
        	mav.addObject("GroupComboList", groupComboList);
        	
        	logger.info("############ dashboard login status..!!!!");
        	
        //}else {

        //	logger.info("############ dashboard logout status..!!!!");
        //}

        return mav;
    }
	
	@RequestMapping("memberInsert")
	public ModelAndView memberInsert(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();
		int rtn =  dccAdminService.insertMemberInfo(dccSearchAdmin);
       
		
		logger.info("############ memberInsert : " + rtn);   
		
		mav.setViewName("redirect:/main/dashboard");       
        
        return mav;        
	}
	
	@RequestMapping("memberUpdate")
	public ModelAndView memberUpdate(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();
		int rtn =  dccAdminService.updateMemberInfo(dccSearchAdmin);
       
		
		logger.info("############ memberUpdate : " + rtn);   
		
		mav.setViewName("redirect:/main/dashboard");       
        
        return mav;        
	}
	
	@RequestMapping("memberhogi")
	@ResponseBody
	public ModelAndView memberhogi(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        
		logger.info("############ memberhogi");
		
		ModelAndView mav = new ModelAndView("jsonView");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(dccSearchAdmin.getHogi() != null && !dccSearchAdmin.getHogi().isEmpty()) {
        		
        		System.out.println(dccSearchAdmin.getHogi());
        	
	            MemberInfo memberInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	            memberInfo.setHogi(dccSearchAdmin.getHogi());
	        	        
	        	mav.addObject("ResultType", "1");
        	}else {
        		mav.addObject("ResultType", "2");
        	}
        }
        
        return mav;
    }	
	
	@RequestMapping("memberxygubun")
	@ResponseBody
	public ModelAndView memberxygubun(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        
		logger.info("############ memberxygubun");
		
		ModelAndView mav = new ModelAndView("jsonView");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {        	
            	
         	if(dccSearchAdmin.getXyGubun() != null && !dccSearchAdmin.getXyGubun().isEmpty()) {
         	
 	            MemberInfo memberInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
 	            memberInfo.setXyGubun(dccSearchAdmin.getXyGubun());
 	        	        
 	        	mav.addObject("ResultType", "1");
         	}else {
         		mav.addObject("ResultType", "2");
         	}

        }
        
        return mav;
    }	


}
