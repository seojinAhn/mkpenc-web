package com.mkpenc.dcc.status.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.status.model.DccGrpTagInfo;
import com.mkpenc.dcc.status.model.DccLogTrendInfo;
import com.mkpenc.dcc.status.model.DccMstTagInfo;
import com.mkpenc.dcc.status.model.DccSearchStatus;
import com.mkpenc.dcc.status.model.DccTagInfo;
import com.mkpenc.dcc.status.model.TblFldInfo;
import com.mkpenc.dcc.status.service.DccStatusService;
import com.mkpenc.dcc.tip.model.DccIolistInfo;
import com.mkpenc.dcc.tip.model.DccSearchTip;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.dcc.common.service.BasDccOsmsService;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/status/")
public class DccStatusContentsController {
	
	private static Logger logger = LoggerFactory.getLogger(DccStatusContentsController.class);
	
	private String menuName = "STATUS";
	
	@Autowired
	private DccStatusService dccStatusService;

	@Autowired
	private ExcelHelperUtil excelHelperUtil;
	
	@Autowired	
	private BasDccOsmsService basDccOsmsService;
	
	private ModelAndView tagSearch(ModelAndView mav, DccSearchStatus dccSearchStatus, HttpServletRequest request) {

    	List<DccMstTagInfo> dccMstTagInfo = dccStatusService.selectTagSearch(dccSearchStatus);
    	dccSearchStatus.setMenuName(this.menuName);
    	
    	mav.addObject("BaseSearch", dccSearchStatus);
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
    	mav.addObject("TagSearchInfo", dccMstTagInfo);
    	
        return mav;
    }

	private ModelAndView tagFind(ModelAndView mav,DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		List<DccMstTagInfo> dccTagFindList = dccStatusService.selectTagFind(dccSearchStatus);
		dccSearchStatus.setMenuName(this.menuName);
		
		mav.addObject("BaseSearch", dccSearchStatus);
		mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
		mav.addObject("TagFindList", dccTagFindList);
        	
        return mav;
    }
	
	@RequestMapping("schematic")
	public ModelAndView schematic(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ schematic");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("1");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()== null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()== null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()== null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()== null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        }

        return mav;
    }	
	
	@RequestMapping("schematicExcelExport")
	public void schematicExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		
		logger.info("############ schematicExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("1");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "schematic");
		}
	}
	
	@RequestMapping("schematicSaveTag")
	public ModelAndView schematicSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
		
        ModelAndView mav = new ModelAndView();

        logger.info("############ schematicSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	
        	System.out.println(seqStr);        	
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {

        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("1");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	mav.setViewName("redirect:/dcc/status/schematic");
        }
        
        return mav;
	}
	
	@RequestMapping(value="schematicTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView schematicTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ schematicTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="schematicTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView schematicTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("rrs")
	public ModelAndView rrs(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
      
		ModelAndView mav = new ModelAndView();

        logger.info("############ rrs");
        
    	if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {

        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("2");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));    		
        }
    	
        return mav;
    }
	
	@RequestMapping("rrsExcelExport")
	public void rrsExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		
		logger.info("############ rrsExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("2");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "rrs");
		}
	}
	
	@RequestMapping("rrsSaveTag")
	public ModelAndView rrsSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
		
        ModelAndView mav = new ModelAndView();

        logger.info("############ rrsSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	
        	System.out.println(seqStr);        	
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {

        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("2");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	mav.setViewName("redirect:/dcc/status/rrs");
        }
        
        return mav;
	}
	
	@RequestMapping(value="rrsTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView rrsTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ rrsTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="rrsTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView rrsTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("htc")
	public ModelAndView htc(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
		
        ModelAndView mav = new ModelAndView();

        logger.info("############ htc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("3");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);

        }

        return mav;
    }	
	
	@RequestMapping("htcExcelExport")
	public void htcExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		
		logger.info("############ htcExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("3");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "htc");
		}
	}
	
	@RequestMapping("htcSaveTag")
	public ModelAndView htcSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
		
        ModelAndView mav = new ModelAndView();

        logger.info("############ htcSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("3");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/htc");
        
        }
        
        return mav;
	}
	
	@RequestMapping(value="htcTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView htcTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ htcTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="htcTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView htcTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ htcTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("mtc")
	public ModelAndView mtc(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();

        logger.info("############ mtc");
        
    	if(request.getSession().getAttribute("USER_INFO") != null) {    		

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("4");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
    	}

        return mav;
    }
	
	@RequestMapping("mtcExcelExport")
	public void mtcExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		
		logger.info("############ mtcExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("4");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "mtc");
		}
	}
	
	@RequestMapping("mtcSaveTag")
	public ModelAndView mtcSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ mtcSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("4");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/mtc");
        
        }
        
        return mav;
	}
	
	@RequestMapping(value="mtcTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView mtcTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ mtcTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="mtcTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView mtcTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ mtcTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("sgp")
	public ModelAndView sgp(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ sgp");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("5");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }	
	
	@RequestMapping("sgpExcelExport")
	public void sgpExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		
		logger.info("############ sgpExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("5");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "sgp");
		}
	}
	
	@RequestMapping("sgpSaveTag")
	public ModelAndView sgpSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("5");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/sgp");        
        }
        
        return mav;
	}
	
	@RequestMapping(value="sgpTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sgpTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ sgpTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        
        return mav;
    }
	
	@RequestMapping(value="sgpTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sgpTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ sgpTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("sgl")
	public ModelAndView sql(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sgl");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("6");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }
	
	@RequestMapping("sglExcelExport")
	public void sglExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		
		logger.info("############ sglExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("6");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "sgl");
		}
		
	}
	
	@RequestMapping("sglSaveTag")
	public ModelAndView sglSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ sglSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("6");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/sgl");        
        }
        
        return mav;
	}
	
	@RequestMapping(value="sglTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sglTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ sglTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="sglTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sglTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ sglTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("phtpump")
	public ModelAndView phtpump(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ phtpump");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("7");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }
	
	@RequestMapping("phtpumpExcelExport")
	public void phtpumpExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {		

		logger.info("############ phtpumpExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("7");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "phtpump");
		}
	}
	
	@RequestMapping("phtpumpSaveTag")
	public ModelAndView phtpumpSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ phtpumpSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("7");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/phtpump");        
        }
        
        return mav;
	}
	
	@RequestMapping(value="phtpumpTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView phtpumpTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ phtpumpTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="phtpumpTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView phtpumpTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ phtpumpTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }	

	@RequestMapping("zonevalues")
	public ModelAndView zonevalues(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ zonevalues");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("8");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }
	
	@RequestMapping("zvExcelExport")
	public void zvExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {		

		logger.info("############ zvExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("8");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "zonevalues");
		}
	}
	
	@RequestMapping("zvSaveTag")
	public ModelAndView zvSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ zvSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("8");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/zonevalues");        
        }
        
        return mav;
	}
	
	@RequestMapping(value="zvTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView zvTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ zvTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="zvTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView zvTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ zvTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("zonedeviations")
	public ModelAndView zonedeviations(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ zonedeviations");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("9");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }
	
	@RequestMapping("zdExcelExport")
	public void zdExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {		

		logger.info("############ zdExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("9");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "zonediviations");
		}
	}
	
	@RequestMapping("zdSaveTag")
	public ModelAndView zdSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ zdSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("9");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/zonediviations");        
        }
        
        return mav;
	}
	
	@RequestMapping(value="zdTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView zdTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ zdTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="zdTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView zdTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ zvTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("zonecompare")
	public ModelAndView zonecompare(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ zonecompare");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("10"); // not find page
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }
	
	@RequestMapping("adjrod")
	public ModelAndView adjrod(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ adjrod");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("10");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }
	
	@RequestMapping("adjrodExcelExport")
	public void adjrodExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {		

		logger.info("############ adjrodExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("10");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "adjrod");
		}
	}
	
	@RequestMapping("adjrodSaveTag")
	public ModelAndView adjrodSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ adjrodSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("10");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/adjrod");        
        }
        
        return mav;
	}
	
	@RequestMapping(value="adjrodTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView adjrodTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ adjrodTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="adjrodTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView adjrodTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ adjrodTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("reactivity")
	public ModelAndView reactivity(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ reactivity");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("11");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }	
	
	@RequestMapping("reactExcelExport")
	public void reactExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {		

		logger.info("############ adjrodExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("11");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "react");
		}
	}
	
	@RequestMapping("reactSaveTag")
	public ModelAndView reactSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ reactSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("11");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/reactivity");        
        }
        
        return mav;
	}
	
	@RequestMapping(value="reactTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView reactTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reactTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="reactTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView reactTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reactTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("stepbackstatus")
	public ModelAndView stepbackstatus(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();
		
        logger.info("############ stepbackstatus");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("12");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }        

        return mav;
    }
	
	@RequestMapping("stbExcelExport")
	public void stbExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {

		logger.info("############ htcExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("12");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "stb");
		}
	}
	
	@RequestMapping("stbSaveTag")
	public ModelAndView stbSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ stbSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("12");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	mav.setViewName("redirect:/dcc/status/stepbackstatus");
        }
        
        return mav;
	}
	
	@RequestMapping(value="stbTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView stbTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ stbTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        }
        return mav;
    }
	
	@RequestMapping(value="stbTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView stbTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ stbTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("setbackstatus")
	public ModelAndView setbackstatus(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ setbackstatus");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));        	
        }
		
        return mav;
    }
	
	@RequestMapping("sbExcelExport")
	public void sbExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {

		logger.info("############ sbExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "sb");
		}
	}
	
	@RequestMapping("sbSaveTag")
	public ModelAndView sbSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ sbSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	mav.setViewName("redirect:/dcc/status/setbackstatus");
        }
        
        return mav;
	}
	
	@RequestMapping(value="sbTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sbTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ sbTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="sbTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sbTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ sbTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	
	@RequestMapping("chtemp")
	public ModelAndView chtemp(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ chtemp");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("14");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));        	
        }

        return mav;
    }
	
	@RequestMapping("chtempExcelExport")
	public void chtempExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {

		logger.info("############ chtempExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, (Map)dccVal.get("SearchTime"), "chtemp");
		}
	}
	
	@RequestMapping("chtempSaveTag")
	public ModelAndView chtempSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ chtempSaveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	dccSearchStatus.setGubun("D");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	mav.setViewName("redirect:/dcc/status/setbackstatus");
        }
        
        return mav;
	}
	
	@RequestMapping(value="chtempTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView chtempTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ chtempTagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="chtempTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView chtempTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ chtempTagFind");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	 
        }
        return mav;
    }
}
