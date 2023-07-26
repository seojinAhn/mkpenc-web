package com.mkpenc.dcc.mimic.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.common.model.ComShowTagInfo;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.dcc.common.service.BasDccMimicService;
import com.mkpenc.dcc.common.service.BasDccOsmsService;
import com.mkpenc.dcc.mimic.model.DccSearchMimic;
import com.mkpenc.dcc.status.model.DccMstTagInfo;
import com.mkpenc.dcc.status.model.DccSearchStatus;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/mimic/")
public class DccMimicContentsController {

	private static Logger logger = LoggerFactory.getLogger(DccMimicContentsController.class);
		
	private String menuName = "MIMIC";
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired	
	private BasDccOsmsService basDccOsmsService;
	
	@Autowired
	private BasDccMimicService basDccMimicService;
	
	@Autowired
	private ExcelHelperUtil excelHelperUtil;
	
	
	@RequestMapping("lzc_1")
	public ModelAndView lzc_1(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ lzc_1");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1"); 	
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
	        	       	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());        	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        return mav;
    }
	
	@RequestMapping(value="reloadLzc1", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadLzc1(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadLzc1");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1"); 	
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
	        	       	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());        	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        return mav;
    }
	
	@RequestMapping("lzc_1ExcelExport")
	public void lzc_1ExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");  	        	
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());

        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());        	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "lzc_1");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("lzc_1SaveTag")
	public ModelAndView lzc_1SaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("1");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("1");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/lzc_1");
        
        }
        
        return mav;
	}
	
	@RequestMapping("lzc_2")
	public ModelAndView lzc_2(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ lzc_2");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
    	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadLzc2",method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadLzc2(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadLzc2");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
	        	
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
    	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("lzc_2ExcelExport")
	public void lzc_2ExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("2");   
	        	
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
    	       	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());        	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "lzc_2");
			} catch (Exception e) {
				e.printStackTrace();
			}        	
        }
    }
	
	@RequestMapping("lzc_2SaveTag")
	public ModelAndView lzc_2SaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("1");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("2");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/lzc_2");
        
        }
        
        return mav;
	}
	
	@RequestMapping("pht")
	public ModelAndView pht(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ pht");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
    	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());

        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadPht", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadPht(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadPht");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
    	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());

        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("phtExcelExport")
	public void phtExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));  
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
    	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());        	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "pht");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("phtSaveTag")
	public ModelAndView phtSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("1");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("3");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/pht");
        
        }
        
        return mav;
	}
	
	@RequestMapping("phtctrl")
	public ModelAndView phtctrl(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ phtctrl");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("4");        	
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
    	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());        	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadPhtctrl", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadPhtctrl(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadPhtctrl");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO")); 
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("4");        	
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
    	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());        	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("phtctrlExcelExport")
	public void phtctrlExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("4");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
    		        	        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "phtctrl");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("phtctrlSaveTag")
	public ModelAndView phtctrlSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("1");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("4");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/phtctrl");
        
        }
        
        return mav;
	}
	
	@RequestMapping("moderator")
	public ModelAndView moderator(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ moderator");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("5");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadModerator", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadModerator(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadModerator");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("5");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("moderatorExcelExport")
	public void moderatorExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("5");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());       	
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "moderator");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("moderatorSaveTag")
	public ModelAndView moderatorSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("1");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("5");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/moderator");
        
        }
        
        return mav;
	}
	
	
	@RequestMapping("phtpuri")
	public ModelAndView phtpuri(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ phtpuri");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("6");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadPhtpuri", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadPhtpuri(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadPhtpuri");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("6");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("phtpuriExcelExport")
	public void phtpuriExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("6");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());       	
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "phtpuri");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("phtpuriSaveTag")
	public ModelAndView phtpuriSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("1");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("6");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/phtpuri");
        
        }
        
        return mav;
	}
	
	@RequestMapping("ecc")
	public ModelAndView ecc(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ ecc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("7");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }

	@RequestMapping(value="reloadEcc", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadEcc(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadEcc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("7");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("eccExcelExport")
	public void eccExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("7");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "ecc");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("eccSaveTag")
	public ModelAndView eccSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("1");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("7");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/ecc");
        
        }
        
        return mav;
	}
	
	@RequestMapping("mainsteam")
	public ModelAndView mainsteam(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ mainsteam");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("2");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadMainsteam", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadMainsteam(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadMainsteam");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("2");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("mainsteamExcelExport")
	public void mainsteamExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("2");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("1");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "mainsteam");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("mainsteamSaveTag")
	public ModelAndView mainsteamSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("2");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("1");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/mainsteam");
        
        }
        
        return mav;
	}
	
	@RequestMapping("feedwater")
	public ModelAndView feedwater(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ feedwater");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("2");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadFeedwater", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadFeedwater(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadFeedwater");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("2");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("feedwaterExcelExport")
	public void feedwaterExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("2");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "feedwater");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("feedwaterSaveTag")
	public ModelAndView feedwaterSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("2");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("2");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/feedwater");
        
        }
        
        return mav;
	}
	
	@RequestMapping("condensate")
	public ModelAndView condensate(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ condensate");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("2");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadCondensate", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadCondensate(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadCondensate");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("2");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("condensateExcelExport")
	public void condensateExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("2");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "condensate");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("condensateSaveTag")
	public ModelAndView condensateSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("2");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("3");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/condensate");
        
        }
        
        return mav;
	}
	
	@RequestMapping("fuelhandlingmenu")
	public ModelAndView fuelhandlingmenu(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ fuelhandlingmenu");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("3");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	//member.setXyGubun("Y");
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun("Y");
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		//단위변환 사용하지 않음
    		//List<ComTagDccInfo> tagDccInfoList = basDccMimicService.getDccGrpTagNoUnitConvList(dccGrpTagSearchMap);
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadFuelhandlingmenu", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadFuelhandlingmenu(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse reponse) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadFuelhandlingmenu");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("3");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	//member.setXyGubun("Y");
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun("Y");
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		//단위변환 사용하지 않음
    		//List<ComTagDccInfo> tagDccInfoList = basDccMimicService.getDccGrpTagNoUnitConvList(dccGrpTagSearchMap);
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("fuelhandlingmenuExcelExport")
	public void fuelhandlingmenuExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("3");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("1");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	//member.setXyGubun("Y");
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun("Y");
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());

    		List<ComTagDccInfo> tagDccInfoList = basDccMimicService.getDccGrpTagNoUnitConvList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "fuelhandlingmenu");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("fuelhandlingmenuSaveTag")
	public ModelAndView fuelhandlingmenuSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("3");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("1");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("Y");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/fuelhandlingmenu");
        
        }
        
        return mav;
	}
	
	@RequestMapping("d2octrla")
	public ModelAndView d2octrla(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ d2octrla");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("3");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	//member.setXyGubun("Y");
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun("Y");
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadD2octrla", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadD2octrla(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadD2octrla");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("3");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	//member.setXyGubun("Y");
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun("Y");
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("d2octrlaExcelExport")
	public void d2octrlaExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("3");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	//member.setXyGubun("Y");
        	        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun("Y");
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "d2octrla");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("d2octrlaSaveTag")
	public ModelAndView d2octrlaSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("3");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("2");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("Y");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/d2octrla");
        
        }
        
        return mav;
	}
	
	@RequestMapping("d2octrlc")
	public ModelAndView d2octrlc(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ d2octrlc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("3");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	//member.setXyGubun("Y");
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun("Y");
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadD2octrlc", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadD2octrlc(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadD2octrlc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("3");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	//member.setXyGubun("Y");
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun("Y");
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("d2octrlcExcelExport")
	public void d2octrlcExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);

        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("3");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	//member.setXyGubun("Y");
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun("Y");
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "d2octrlc");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("d2octrlcSaveTag")
	public ModelAndView d2octrlcSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("3");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("3");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("Y");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/d2octrlc");
        
        }
        
        return mav;
	}
	
	@RequestMapping("radmain")
	public ModelAndView radmain(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ radmain");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);

        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("8");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccMimicService.getDccGrpTagNoUnitConvList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadRadmain", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadRadmain(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadRadmain");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);

        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("8");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccMimicService.getDccGrpTagNoUnitConvList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("radmainExcelExport")
	public void radmainExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	

        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("8");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());

    		List<ComTagDccInfo> tagDccInfoList = basDccMimicService.getDccGrpTagNoUnitConvList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "radmain");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("radmainSaveTag")
	public ModelAndView radmainSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("4");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("8");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/radmain");
        
        }
        
        return mav;
	}
	
	@RequestMapping("rbbase")
	public ModelAndView rbbase(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rbbase");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadRbbase", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadRbbase(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadRbbase");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("rbbaseExcelExport")
	public void rbbaseExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "rbbase");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("rbbaseSaveTag")
	public ModelAndView rbbaseSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("4");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("1");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/rbbase");
        
        }
        
        return mav;
	}
	
	@RequestMapping("rb1f")
	public ModelAndView rb1f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb1f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }

	@RequestMapping(value="reloadRb1f", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadRb1f(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadRb1f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("rb1fExcelExport")
	public void rb1fExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "rb1f");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("rb1fSaveTag")
	public ModelAndView rb1fSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("4");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("2");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/rb1f");
        
        }
        
        return mav;
	}
	
	@RequestMapping("rb2f")
	public ModelAndView rb2f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb2f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));   
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadRb2f", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadRb2f(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadRb2f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));   
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("rb2fExcelExport")
	public void rb2fExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("3");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "rb2f");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("rb2fSaveTag")
	public ModelAndView rb2fSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("4");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("3");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/rb2f");
        
        }
        
        return mav;
	}
	
	@RequestMapping("rb3f")
	public ModelAndView rb3f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb3f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("4");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadRb3f", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadRb3f(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadRb3f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("4");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("rb3fExcelExport")
	public void rb3fExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("4");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "rb3f");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("rb3fSaveTag")
	public ModelAndView rb3fSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("4");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("4");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/rb3f");
        
        }
        
        return mav;
	}
	
	@RequestMapping("rb4f")
	public ModelAndView rb4f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb4f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("5");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadRb4f", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadRb4f(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadRb4f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("5");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("rb4fExcelExport")
	public void rb4fExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("5");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "rb4f");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("rb4fSaveTag")
	public ModelAndView rb4fSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("4");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("5");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/rb4f");
        
        }
        
        return mav;
	}
	
	@RequestMapping("rb5f")
	public ModelAndView rb5f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb4f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("6");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());

        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadRb5f", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadRb5f(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadRb5f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("6");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());

        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("rb5fExcelExport")
	public void rb5fExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);

        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("6");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "rb5f");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("rb5fSaveTag")
	public ModelAndView rb5fSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("4");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("6");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/rb5f");
        
        }
        
        return mav;
	}
	
	@RequestMapping("sbbase")
	public ModelAndView sbbase(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sbbase");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);        	

        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("7");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping(value="reloadSbbase", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadSbbase(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadSbbase");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);        	

        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("7");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("sbbaseExcelExport")
	public void sbbaseExcelExport(DccSearchMimic dccSearchMimic, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ excel");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);

        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));    
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("4");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("7");
        	}
	    	if( member.getHogi() == null ) member.setHogi(dccSearchMimic.getsHogi() == null ? "3" : dccSearchMimic.getsHogi());
	    	if( member.getXyGubun() == null ) member.setXyGubun(dccSearchMimic.getsXYGubun() == null ? "X" : dccSearchMimic.getsXYGubun());
        	
        	dccSearchMimic.setsHogi(member.getHogi());
        	dccSearchMimic.setsXYGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (List<Map>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "sbbase");
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
    }
	
	@RequestMapping("sbbaseSaveTag")
	public ModelAndView sbbaseSaveTag(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchMimic.setMenuName(this.menuName);
        	String seqStr = basDccMimicService.selectSeqInfo(dccSearchMimic);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchMimic.setiSeq(seqs[0]);
        	dccSearchMimic.setySeq(seqs[1]);

        	if( dccSearchMimic.getMenuNo() == null ) dccSearchMimic.setMenuNo("4");
        	if( dccSearchMimic.getGrpNo() == null ) dccSearchMimic.setGrpNo("7");
        	if( dccSearchMimic.getGrpId() == null ) dccSearchMimic.setGrpId("mimic");
        	if( dccSearchMimic.getHogi() == null ) dccSearchMimic.setHogi("3");
        	if( dccSearchMimic.getXyGubun() == null ) dccSearchMimic.setXyGubun("X");
        	if( dccSearchMimic.getGubun() == null ) dccSearchMimic.setGubun("D");
        	
        	res = basDccMimicService.updateTagInfo(dccSearchMimic);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/mimic/sbbase");
        
        }
        
        return mav;
	}
	
	
	@RequestMapping(value="tagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView mimicTagSearch(DccSearchMimic dccSearchMimic, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchMimic,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="tagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView mimicTagFind(DccSearchMimic dccSearchMimic, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");
    	
        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchMimic,request);
        	
        }
        return mav;
    }
	
	
	// create by sohee 20230228
	private ModelAndView tagSearch(ModelAndView mav, DccSearchMimic dccSearchMimic, HttpServletRequest request) {

		List<ComShowTagInfo> dccTagSearchList = basDccMimicService.selectTagSearch(dccSearchMimic);
    	dccSearchMimic.setMenuName(this.menuName);
    	
    	mav.addObject("BaseSearch", dccSearchMimic);
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
    	mav.addObject("TagSearchInfo", dccTagSearchList);
    	
        return mav;
    }
	
	// create by sohee 20230228
	private ModelAndView tagFind(ModelAndView mav,DccSearchMimic dccSearchMimic, HttpServletRequest request) {

		List<ComShowTagInfo> dccTagFindList = basDccMimicService.selectTagFind(dccSearchMimic);
		dccSearchMimic.setMenuName(this.menuName);
		
		mav.addObject("BaseSearch", dccSearchMimic);
		mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
		mav.addObject("TagFindList", dccTagFindList);
        	
        return mav;
    }
	
	
}
