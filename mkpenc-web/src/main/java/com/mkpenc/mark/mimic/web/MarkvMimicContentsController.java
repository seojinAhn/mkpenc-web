package com.mkpenc.mark.mimic.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.mark.common.model.ComShowTagMarkInfo;
import com.mkpenc.mark.common.model.ComTagMarkInfo;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.mark.common.service.BasMarkMimicService;
import com.mkpenc.mark.common.service.BasMarkOsmsService;
import com.mkpenc.mark.mimic.model.MarkvSearchMimic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
  
@Controller
@RequestMapping("/markv/mimic/")
public class MarkvMimicContentsController {

	private static Logger logger = LoggerFactory.getLogger(MarkvMimicContentsController.class);
	
	private String menuName = "MIMIC";
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired	
	private BasMarkOsmsService basMarkOsmsService;
	
	@Autowired
	private BasMarkMimicService basMarkMimicService;
	
	
	@RequestMapping("loadcontrol")
	public ModelAndView loadcontrol(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ loadcontrol");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("1");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("7");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
    		
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("1");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("rotorprewarm")
	public ModelAndView rotorprewarm(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rotorprewarm");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("1");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("2");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
        	List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("chestprewarm")
	public ModelAndView chestprewarm(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ chestprewarm");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("1");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("3");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
        	List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("1");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("4");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
    		
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("1");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("5");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("gensynchroniz")
	public ModelAndView gensynchroniz(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ gensynchroniz");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("1");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("10");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("limiter")
	public ModelAndView limiter(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ limiter");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("1");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("8");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("2");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("compositedata")
	public ModelAndView compositedata(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ compositedata");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("bearingdata")
	public ModelAndView bearingdata(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ bearingdata");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("lptbntemp")
	public ModelAndView lptbntemp(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ lptbntemp");
        
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("2");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("5");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}    
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("tbnstemsealsys")
	public ModelAndView tbnstemsealsys(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ tbnstemsealsys");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("2");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("2");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("6");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("steamvalve")
	public ModelAndView steamvalve(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ steamvalve");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("lubeoilsys")
	public ModelAndView lubeoilsys(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ lubeoilsys");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("3");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("hydraulicpower")
	public ModelAndView hydraulicpower(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ hydraulicpower");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("4");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("5");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("sealoilsys")
	public ModelAndView sealoilsys(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sealoilsys");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("6");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("statorwatersys")
	public ModelAndView statorwatersys(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ statorwatersys");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("7");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
        	List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }


        return mav;
    }	
	
	@RequestMapping("coolinggassys")
	public ModelAndView coolinggassys(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ coolinggassys");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("8");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("9");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("D");
        		markvSearchMimic.setsMenuNo("3");
        		markvSearchMimic.setsGrpID("mimic");
	        	markvSearchMimic.setsUGrpNo("10");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	//getMarkGrpTagList
        	Map markvGrpTagSearchMap = new HashMap();
        	markvGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markvGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
        	markvGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
        	markvGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
        	markvGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
        	markvGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());

        	List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);        	
        	
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("frontstandard")
	public ModelAndView frontstandard(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ frontstandard");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("4");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("fasolenoids")
	public ModelAndView fasolenoids(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ fasolenoids");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("4");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("2");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("hydraulictripsys")
	public ModelAndView hydraulictripsys(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ hydraulictripsys");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("4");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("3");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
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
        	
        	if(markvSearchMimic.getsMenuNo() == null || markvSearchMimic.getsMenuNo().isEmpty()) {
            	
        		markvSearchMimic.setsDive("M");
        		markvSearchMimic.setsMenuNo("4");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsUGrpNo("5");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchMimic.setsHogi(member.getHogi());
	        	markvSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map markGrpTagSearchMap = new HashMap();
        	markGrpTagSearchMap.put("xyGubun",markvSearchMimic.getsXYGubun()==null?  "": markvSearchMimic.getsXYGubun());
        	markGrpTagSearchMap.put("hogi",markvSearchMimic.getsHogi()==null?  "": markvSearchMimic.getsHogi());
    		markGrpTagSearchMap.put("dive",markvSearchMimic.getsDive()==null?  "": markvSearchMimic.getsDive());
    		markGrpTagSearchMap.put("grpID", markvSearchMimic.getsGrpID()==null?  "": markvSearchMimic.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markvSearchMimic.getsMenuNo()==null?  "": markvSearchMimic.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markvSearchMimic.getsUGrpNo()==null?  "": markvSearchMimic.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList);
    		
    		List<ComTagMarkInfo> tagComboCodeList = basMarkMimicService.getComboCodeList();
        	
        	markvSearchMimic.setComboCnt(tagComboCodeList.size());
        	List<ComTagMarkInfo> tagComboDescList = basMarkMimicService.getComboDescList(markvSearchMimic);
        	
        	mav.addObject("tagComboCodeList", tagComboCodeList);
        	mav.addObject("tagComboDescList", tagComboDescList);
        	
    		mav.addObject("SearchTime", markVal.get("SearchTime"));
        	mav.addObject("ForeColor", markVal.get("ForeColor"));
        	mav.addObject("lblDataList", markVal.get("lblDataList"));
        	mav.addObject("MarkTagInfoList", tagMarkInfoList);
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping(value="markvTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView mimicTagSearch(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ markvTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,markvSearchMimic,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="markvTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView mimicTagFind(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");
    	
        logger.info("############ markvTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	mav = markvTagFind(mav,markvSearchMimic,request);
        }
        return mav;
    }
	

	private ModelAndView tagSearch(ModelAndView mav, MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {

		List<ComShowTagMarkInfo> markvTagSearchList = basMarkMimicService.selectMarkTagSearch(markvSearchMimic);
    	markvSearchMimic.setMenuName(this.menuName);
    	
    	mav.addObject("BaseSearch", markvSearchMimic);
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
    	mav.addObject("TagSearchInfo", markvTagSearchList);
    	
        return mav;
    }
	
	private ModelAndView markvTagFind(ModelAndView mav,MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {

		List<ComShowTagMarkInfo> markvTagFindList = basMarkMimicService.selectMarkTagFind(markvSearchMimic);
		markvSearchMimic.setMenuName(this.menuName);
		
		mav.addObject("BaseSearch", markvSearchMimic);
		mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
		mav.addObject("TagFindList", markvTagFindList);
        	
        return mav;
    }
	

	@RequestMapping("markvSaveTag")
	public ModelAndView markvSaveTag(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String returnUrl = "";
        
        logger.info("############ markvSaveTag");
        int res1 = 0;
        int res2 = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	markvSearchMimic.setMenuName(this.menuName);

        	if( markvSearchMimic.getGubun() == null ) markvSearchMimic.setGubun("M");
        	
        	res1 = basMarkMimicService.updateMarkTagInfo1(markvSearchMimic);
        	res2 = basMarkMimicService.updateMarkTagInfo2(markvSearchMimic);
        	
        	returnUrl = "redirect:/markv/mimic/"+markvSearchMimic.getrUrl();
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName(returnUrl);
        
        }
        
        return mav;
	}
	
	@RequestMapping(value="getSaveCoreInfo", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView getSaveCoreInfo(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");
    	
        logger.info("############ getSaveCoreInfo");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
    		markvSearchMimic.setMenuName(this.menuName);
        	
        	String saveCoreChk = basMarkMimicService.getSaveCoreInfo(markvSearchMimic);
     		mav.addObject("saveCoreChk", saveCoreChk);
        }
        
        return mav;
    }
	
}
