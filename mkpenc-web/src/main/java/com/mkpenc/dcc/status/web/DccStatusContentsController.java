package com.mkpenc.dcc.status.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.lang3.StringUtils;

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
	
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
		
	private String menuName = "STATUS";
	
	@Autowired
	private DccStatusService dccStatusService;

	@Autowired
	private ExcelHelperUtil excelHelperUtil;
	
	@Autowired	
	private BasDccOsmsService basDccOsmsService;
	
	//reactive coordx, coord&
	double[] gCoordX = new double[27];
	double[] gCoordY = new double[27];
	int nCntVisible = 1;
	List<Map> glblXYList = new ArrayList<Map>();
	
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
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("1");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()== null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()== null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()== null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()== null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()== null?  "": dccSearchStatus.getGrpNo());
    		
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
	
	@RequestMapping(value="reloadSchematic", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadSchematic(DccSearchStatus dccSearchStatus, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadSchematic");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("1");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()== null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()== null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()== null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()== null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()== null?  "": dccSearchStatus.getGrpNo());
    		
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
	
	@RequestMapping("schematicExcelExport")
	public void schematicExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		
		logger.info("############ schematicExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("1");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "schematic");
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {

        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("1");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {

        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("2");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");   
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
	
	@RequestMapping(value="reloadRrs", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadRrs(DccSearchStatus dccSearchStatus, HttpServletRequest request, HttpServletResponse response) {
      
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadRrs");
        
    	if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {

        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("2");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");   
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("2");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    	        	
        	}        	

        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "rrs");
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {

        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("2");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("3");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    	        	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
	
	@RequestMapping(value="reloadHtc", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadHtc(DccSearchStatus dccSearchStatus, HttpServletRequest request, HttpServletResponse response) {
		
        ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadHtc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("3");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    	        	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
	
	@RequestMapping("htcExcelExport")
	public void htcExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		
		logger.info("############ htcExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("3");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");   
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "htc");
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
        	
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("3");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
    		
    		dccSearchStatus.setMenuName(this.menuName);
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("4");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
	
	@RequestMapping(value="reloadMtc", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadMtc(DccSearchStatus dccSearchStatus, HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadMtc");
        
    	if(request.getSession().getAttribute("USER_INFO") != null) {   
    		
    		dccSearchStatus.setMenuName(this.menuName);
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("4");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
	
	@RequestMapping("mtcExcelExport")
	public void mtcExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		
		logger.info("############ mtcExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("4");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "mtc");
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
        	
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("4");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
			
			MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("5");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
	
	@RequestMapping(value = "reloadSgp", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadSgp(DccSearchStatus dccSearchStatus, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

		logger.info("############ reloadSgp");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchStatus.setMenuName(this.menuName);
			
			MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("5");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("5");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "sgp");
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("5");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("6");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
	
	@RequestMapping(value="reloadSgl", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadSql(DccSearchStatus dccSearchStatus, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadSgl");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("6");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");
	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("6");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 	        		        	
        	}

        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "sgl");
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("6");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("7");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
	
	@RequestMapping(value="reloadPhtpump", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadPhtpump(DccSearchStatus dccSearchStatus, HttpServletRequest request, HttpServletResponse response) {
       
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadPhtpump");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("7");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("7");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");         	
        	}           	
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "phtpump");
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

        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("7");
	        	dccSearchStatus.setGubun("D");

	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("8");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
	
	@RequestMapping(value = "reloadZv", method = {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadZv(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadZv");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("8");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("8");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "zv");
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

        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("8");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("9");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
	
	@RequestMapping(value = "reloadZd", method = {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadZd(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadZd");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("9");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("9");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "zd");
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("9");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("15"); // not find page
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
    		dccSearchStatus.setStartDate(dccSearchStatus.getStartDate()==null?  "": dccSearchStatus.getStartDate());
        	
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
	
	@RequestMapping(value="reloadZc", method={ RequestMethod.POST })
	@ResponseBody
	public ModelAndView reloadZc(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ reloadZc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("15"); // not find page
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	String startDate = dccSearchStatus.getStartDate() == null ? "": dccSearchStatus.getStartDate();
        	if( startDate.indexOf(",") > -1 ) startDate = startDate.substring(0,startDate.indexOf(","));
        	String strType = dccSearchStatus.getSearchStr().indexOf("1") > -1 ? "1" : "0";
    		dccSearchStatus.setStartDate(startDate);
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		dccGrpTagSearchMap.put("startDate", dccSearchStatus.getStartDate()==null?  "": dccSearchStatus.getStartDate());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = new HashMap();
    		if( "0".equals(strType) ) {
    			dccVal = basDccOsmsService.getDccValueSearch(dccGrpTagSearchMap, tagDccInfoList);
    		} else {
    			dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		}
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }
	
	@RequestMapping("zcExcelExport")
	public void zcExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {		

		logger.info("############ zcExcelExport");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("15");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "zc");
		}
	}
	
	@RequestMapping("adjrod")
	public ModelAndView adjrod(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ adjrod");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("10");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
	
	@RequestMapping(value="reloadAdjrod", method={ RequestMethod.POST })
	@ResponseBody
	public ModelAndView reloadAdjrod(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView("jsonView");

		logger.info("############ reloadAdjrod");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("10");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("10");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");           	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "ar");
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

        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("10");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("11");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");   	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		List<Map> lblDataList = (ArrayList)dccVal.get("lblDataList");
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", lblDataList);
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
    		glblXYList = new ArrayList<Map>();
    		System.out.println(glblXYList.size());
    		System.out.println(glblXYList); 
        	
        	//lblxy init
        	if(glblXYList.size() == 0) {
	        	for(int i=0;i<27;i++) {
	        		Map lblXY = new HashMap();
	        		lblXY.put("Visible", false);
	        		lblXY.put("Left", 0);
	        		lblXY.put("Top", 0);
	        		
	        		glblXYList.add(lblXY);
	        	}
        	}
        	
        	int fValue = 0;
        	if(StringUtils.isNumeric(lblDataList.get(0).get("fValue").toString())) {
        		fValue = Integer.parseInt(lblDataList.get(0).get("fValue").toString());        		
        	}
        	
        	/*int gnTotalData = 26;
        	for(int i=gnTotalData; i > 0;i-- ) {
        		 gCoordX[i] = gCoordX[i-1];
        		 gCoordY[i] = gCoordY[i-1];
        	}*/
        	int gnTotalData = 26;
        	for(int i=gnTotalData-1; i > -1;i-- ) {
        		 gCoordX[i+1] = gCoordX[i];
        		 gCoordY[i+1] = gCoordY[i];
        	}

        	//System.out.println(lblDataList.get(0).get("fValue").toString()+" >> "+StringUtils.isNumeric(lblDataList.get(0).get("fValue").toString()));
        	//if(StringUtils.isNumeric(lblDataList.get(0).get("fValue").toString())) {
        		//gCoordX[0]= Double.parseDouble(lblDataList.get(0).get("fValue").toString());
        	try {
        		gCoordX[0] = Double.parseDouble(String.format(gFormat[tagDccInfoList.get(0).getBScale()],(Math.pow(10, Double.parseDouble(lblDataList.get(0).get("fValue").toString()))-1)*100));
        	} catch( NumberFormatException nfe ) {
        		//
        	}
        	//}
        	
        	//System.out.println(lblDataList.get(1).get("fValue").toString()+" >> "+StringUtils.isNumeric(lblDataList.get(1).get("fValue").toString()));
        	//if(StringUtils.isNumeric(lblDataList.get(1).get("fValue").toString())) {
        	try {
        		gCoordY[0]= Double.parseDouble(lblDataList.get(1).get("fValue").toString());
        	} catch( NumberFormatException nfe) {
        		//
        	}
        	//}

        	//movelebel
        	for(int i=0;i<nCntVisible;i++) {
        		//System.out.println(gCoordX[i]+":"+gCoordY[i]);
        		//long nLeft = (770/2) + Math.round(gCoordX[i]);
        		long nLeft = Math.round(770 * (gCoordX[i] + 5) / 10);
        		
        		if(nLeft < 0 ) nLeft = 0;
        		if(nLeft > 770 ) nLeft = 770;
    			
    			//long nTop =  (390/2) +  Math.round(gCoordY[i]);
        		long nTop =  390 - Math.round(390 * gCoordY[i] / 100);
    			
    			if(nTop < 0 ) nTop = 0;
        		if(nTop > 390 ) nTop = 390;
        		
    			glblXYList.get(i).put("Left", nLeft);
    			glblXYList.get(i).put("Top", nTop);
        		
        		/*
        	 	For i = 0 To nCnt
			        nLeft = nXBase + CInt(nXWidth * (coordX(i) + 5) / 10)
			        nTop = nYBase - CInt(nYHeight * coordY(i) / 100)
			        If nLeft < nXBase Then nLeft = nXBase
			        If nLeft > nXBase + nXWidth Then nLeft = nXBase + nXWidth
			        If nTop > nYBase Then nTop = nYBase
			        If nTop < nYBase - nYHeight Then nTop = nYBase + nYHeight
			        lblXY(i).Left = nLeft - lblXY(i).Width / 2
			        lblXY(i).Top = nTop - lblXY(i).Height / 2
			    Next
        	 * */
        	} // end for
        	
        	if(nCntVisible < 27) {
        		glblXYList.get(nCntVisible-1).put("Visible", true);
        		nCntVisible = nCntVisible + 1;
        	}else {
        		nCntVisible = 1;
        		
        		for(int i=nCntVisible;i<27;i++) {
        			glblXYList.get(nCntVisible-1).put("Visible", false);
        		}        		
        	}
        	
        	mav.addObject("lblXYList", glblXYList);   
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }

        return mav;
    }
	
	@RequestMapping(value="reloadReact", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadReact(DccSearchStatus dccSearchStatus, HttpServletRequest request, HttpServletResponse response) {
        
		ModelAndView mav = new ModelAndView("jsonView");

		logger.info("############ reloadReact");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("11");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");   	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		List<Map> lblDataList = (ArrayList)dccVal.get("lblDataList");
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", lblDataList);
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
    		glblXYList = new ArrayList<Map>();
        	
        	//lblxy init
        	if(glblXYList.size() == 0) {
	        	for(int i=0;i<27;i++) {
	        		Map lblXY = new HashMap();
	        		lblXY.put("Visible", false);
	        		lblXY.put("Left", 0);
	        		lblXY.put("Top", 0);        		
	        		
	        		glblXYList.add(lblXY);
	        	}
        	}
        	
        	int fValue = 0;
        	if(StringUtils.isNumeric(lblDataList.get(0).get("fValue").toString())) {
        		fValue = Integer.parseInt(lblDataList.get(0).get("fValue").toString());        		
        	}
        	
        	/*int gnTotalData = 26;
        	for(int i=gnTotalData; i > 0;i-- ) {
        		 gCoordX[i] = gCoordX[i-1];
        		 gCoordY[i] = gCoordY[i-1];
        	}*/
        	int gnTotalData = 26; 
        	for(int i=gnTotalData-1; i > -1;i-- ) {
        		 gCoordX[i+1] = gCoordX[i];
        		 gCoordY[i+1] = gCoordY[i];
        	}

        	//System.out.println(lblDataList.get(0).get("fValue").toString()+" >> "+StringUtils.isNumeric(lblDataList.get(0).get("fValue").toString()));
        	//if(StringUtils.isNumeric(lblDataList.get(0).get("fValue").toString())) {
        		//gCoordX[0]= Double.parseDouble(lblDataList.get(0).get("fValue").toString());
        	try {
        		gCoordX[0] = Double.parseDouble(String.format(gFormat[tagDccInfoList.get(0).getBScale()],(Math.pow(10, Double.parseDouble(lblDataList.get(0).get("fValue").toString()))-1)*100));
        	} catch( NumberFormatException nfe ) {
        		//
        	}
        	//}
        	
        	//System.out.println(lblDataList.get(1).get("fValue").toString()+" >> "+StringUtils.isNumeric(lblDataList.get(1).get("fValue").toString()));
        	//if(StringUtils.isNumeric(lblDataList.get(1).get("fValue").toString())) {
        	try {
        		gCoordY[0]= Double.parseDouble(lblDataList.get(1).get("fValue").toString());
        	} catch( NumberFormatException nfe) {
        		//
        	}
        	//}

        	//movelebel
        	for(int i=0;i<nCntVisible;i++) {
        		//System.out.println(gCoordX[i]+":"+gCoordY[i]);
        		//long nLeft = (770/2) + Math.round(gCoordX[i]);
        		long nLeft = Math.round(770 * (gCoordX[i] + 5) / 10);
        		
        		if(nLeft < 0 ) nLeft = 0;
        		if(nLeft > 770 ) nLeft = 770;
    			
    			//long nTop =  (390/2) +  Math.round(gCoordY[i]);
        		long nTop =  390 - Math.round(390 * gCoordY[i] / 100);
    			
    			if(nTop < 0 ) nTop = 0;
        		if(nTop > 390 ) nTop = 390;
        		
    			glblXYList.get(i).put("Left", nLeft);
    			glblXYList.get(i).put("Top", nTop);
        		
        		/*
        	 	For i = 0 To nCnt
			        nLeft = nXBase + CInt(nXWidth * (coordX(i) + 5) / 10)
			        nTop = nYBase - CInt(nYHeight * coordY(i) / 100)
			        If nLeft < nXBase Then nLeft = nXBase
			        If nLeft > nXBase + nXWidth Then nLeft = nXBase + nXWidth
			        If nTop > nYBase Then nTop = nYBase
			        If nTop < nYBase - nYHeight Then nTop = nYBase + nYHeight
			        lblXY(i).Left = nLeft - lblXY(i).Width / 2
			        lblXY(i).Top = nTop - lblXY(i).Height / 2
			    Next
        	 * */
        	} // end for
        	
        	if(nCntVisible < 27) {
        		glblXYList.get(nCntVisible-1).put("Visible", true);
        		nCntVisible = nCntVisible + 1;
        	}else {
        		nCntVisible = 1;
        		
        		for(int i=nCntVisible;i<27;i++) {
        			glblXYList.get(nCntVisible-1).put("Visible", false);
        		}        		
        	}
        	
        	mav.addObject("resultType", "reactivity");
        	mav.addObject("lblXYList", glblXYList);
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("11");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "react");
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

        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("11");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
	      	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	
        	
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
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("12");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 	        		        	
        	}        	

        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		List<Map> lblDataList = (ArrayList)dccVal.get("lblDataList");

    		for(int i=0;i<lblDataList.size();i++) {
    			
    			lblDataList.get(i).put("visible", true);
    			
    			if(i >= 12 && i<=23) {
    				lblDataList.get(i).put("visible", false);
    			}
    			
    			if(i >= 28 && i<=55) {
    				lblDataList.get(i).put("visible", false);
    			}
    		}
    		
    		String[] vData = basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
    		
    		int iError =0;
    		double fTmpVal = 0;
    		String sTipMsg = "";
    		
    		List<Map> lblConvList = new ArrayList<Map>();
    		List<Map> vINDValList= new ArrayList<Map>();
    		boolean[] shpIND = new boolean[10];
    		boolean[] shpIND2 = new boolean[10];
    		
    		for(int i=0;i<tagDccInfoList.size();i++) {
    			if(i< 6) {
    				    iError = iError + ((Double.parseDouble(vData[i+1]) == -32768)? 1:0);
    				    
    				    fTmpVal = fTmpVal + ((Double.parseDouble(vData[i+1]) == -32768)? 0: (Double.parseDouble(lblDataList.get(i).get("fValue").toString())));
    				    
    				    sTipMsg = sTipMsg + tagDccInfoList.get(i).getToolTip() + ((i == 2 || i == 5)? "":",");
    				    
    				    if(i == 2 || i == 5) {
    				    	
    				    	Map lblConv = new HashMap();
	    				    if(iError > 0) {
	    				    		lblConv.put("fValue", "***IRR");
	    				    }else {
	    				    		lblConv.put("fValue", (fTmpVal < 2)? "YES":"NO");
	    				    }
	    				    lblConv.put("TooTipTest", sTipMsg);
	    				    
	    				    lblConvList.add(lblConv);
	    				    
	    				    if(i ==5) {
	    				    	if(lblConvList.get(0).get("fValue").toString().equals("YES") || lblConvList.get(1).get("fValue").toString().equals("YES")  ) {
	    				    		shpIND[0] = true;	    				    		
	    				    	}else {
	    				    		shpIND[0] = false;
	    				    	}
	    				    }
	    				    
	    				    iError =0;
	    		    		fTmpVal = 0;
	    		    		sTipMsg = "";
	    				    
    				    }
    			} // i < 6
    			
    			if(i>=6 && i<=9) {
    				Map vINDVal = new HashMap();
    				if(Double.parseDouble(vData[i+1]) != -32768) {
    					vINDVal.put("fValue", lblDataList.get(i).get("fValue").toString());
    					vINDVal.put("fData", (Double.parseDouble(lblDataList.get(i).get("fValue").toString()) > 0)? "ON":"OFF");
    				}
    				
    				vINDValList.add(vINDVal);
    				
    				if(i == 9) {
    					if((Double.parseDouble(vINDValList.get(0).get("fValue").toString()) + Double.parseDouble(vINDValList.get(2).get("fValue").toString()) <  2) ||
    				         (Double.parseDouble(vINDValList.get(1).get("fValue").toString()) + Double.parseDouble(vINDValList.get(3).get("fValue").toString()) < 2)){
    								shpIND[1] = true;	
    					}else  if((Double.parseDouble(vINDValList.get(0).get("fValue").toString()) + Double.parseDouble(vINDValList.get(1).get("fValue").toString()) <  1) ||
       				         (Double.parseDouble(vINDValList.get(1).get("fValue").toString()) + Double.parseDouble(vINDValList.get(3).get("fValue").toString()) < 1)){
    								shpIND[2] = true;	
    					}    							
    				}    				
    			}// i >=6 && i <=9
    			
    			int fTmpIdx = 0;
    			if(i==14 || i == 17 || i==20 || i == 23) {
    				
    				 iError = ((Double.parseDouble(vData[i-1]) == -32768)? 1:0) +
    						 		((Double.parseDouble(vData[i]) == -32768)? 1:0) + 
    						 		((Double.parseDouble(vData[i+1]) == -32768)? 1:0);
    				 
    				 if(iError > 1) {
    					 lblDataList.get(i).put("fValue",  "***IRR");
    				 }else {
    					if( iError == 1) {
    						for(int j=(i-2); j<=i;j++) {
    							if((Double.parseDouble(vData[i+1])) != -32768){
    								if(fTmpIdx == -1) {
    									fTmpIdx = j;
    									fTmpVal = (Double.parseDouble(vData[i+1]));
    								}else {
    										if(fTmpVal > (Double.parseDouble(vData[i+1]))) {
    											fTmpIdx = j;
    	    									fTmpVal = (Double.parseDouble(vData[i+1]));
    										}
    								}    								
    							}
    						} // end for
    					}else {
    						fTmpIdx = i - getMidData(Double.parseDouble(vData[i-1]), Double.parseDouble(vData[i]), Double.parseDouble(vData[i+1]));
    					}
    					
    					lblDataList.get(fTmpIdx).put("visible", true); 
    					lblDataList.get(fTmpIdx).put("fValue",  lblDataList.get(fTmpIdx).get("fValue"));
    					
    				 }    				
    			} // i==14 || i == 17 || i==20 || i == 23
    			
    			if(i >= 28 && i <=55) {
    				if((i % 2) == 1) {
    					 iError = ((Double.parseDouble(vData[i]) == -32768)?1:0) + ((Double.parseDouble(vData[i+1]) == -32768)?1:0) ;
    					 
    					 if(iError > 1) {
    						 iError = ((Double.parseDouble(vData[62]) == -32768)?1:0) + ((Double.parseDouble(vData[63]) == -32768)?1:0) + ((Double.parseDouble(vData[64]) == -32768)?1:0) ;
    						 
    						 if (iError > 0){
    							 lblDataList.get(i).put("fValue",  "1.2");
    						 }else {
    							 fTmpIdx = 64 - getMidData(Double.parseDouble(vData[i-1]), Double.parseDouble(vData[i]), Double.parseDouble(vData[i+1]));
    							 
    							 lblDataList.get(i).put("fValue",  lblDataList.get(fTmpIdx).get("fValue"));
    							 tagDccInfoList.get(i).setToolTip(tagDccInfoList.get(fTmpIdx).getToolTip());    							 
    						 }    						 
    					 }else if(iError == 1) {
    						 if (Double.parseDouble(vData[i]) != -32768){
    							 lblDataList.get(i-1).put("fValue",  lblDataList.get(i).get("fValue"));
    							 lblDataList.get(i-1).put("visible",  true);
    						 }else if (Double.parseDouble(vData[i+1]) != -32768){
    							 lblDataList.get(i).put("fValue",  lblDataList.get(i+1).get("fValue"));
    							 lblDataList.get(i).put("visible",  true);
    						 }
    					 }else {
    						 if (Double.parseDouble(vData[i]) >  Double.parseDouble(vData[i+1]) ){
    							 lblDataList.get(i-1).put("fValue",  lblDataList.get(i-1).get("fValue"));
    							 lblDataList.get(i-1).put("visible",  true);
    						 }else {
    							 lblDataList.get(i).put("fValue",  lblDataList.get(i+1).get("fValue"));
    							 lblDataList.get(i).put("visible",  true);
    						 }
    					 }
    				}
    			}
    			
    			if(i == 56) {
    				 if (Double.parseDouble(vData[i+1]) > -32768){
    					 if(Double.parseDouble(lblDataList.get(i).get("fValue").toString()) > 0) {
    						lblDataList.get(i).put("fValue", "YES");    
    						shpIND[8] = true;	  
    					 }else {    						 
    						 lblDataList.get(i).put("fValue", "NO");
    						 shpIND[8] = false;
    					 }
    				 }else {
    					 lblDataList.get(i).put("fValue", -32768);
    					 shpIND[8] = false;
    				 }    				
    			}
    			
    			if(i == 61) {   				
	   				 if (StringUtils.isNumeric(vData[i+1])){
	   					 if(Double.parseDouble(vData[13]) < Double.parseDouble(vData[i+1])) {
	   						shpIND[5] = true;	  
	   					 }else {    						 
	   						shpIND[5] = false;
	   					 }
	   				 }
	   			}    			
    			
    			if(i == 65) {
    				double[] lblFP = {0.0, 0.01, 0.0, 0.005, 0.0, 0.005, 0.005, 0.0, 0.02};
    				
    				for( int j=0;j<lblFP.length;j++) {
    					 if (StringUtils.isNumeric(vData[i+1])){
    						 if( Double.parseDouble(vData[i+1]) > -32768) {
    							 if( Math.pow(10, Double.parseDouble(lblDataList.get(i).get("fValue" ).toString())) <  lblFP[j]) {
    								 shpIND2[j] = true;
    							 }else {
    								 shpIND2[j] = false;
    							 }
    						 }
    					 }
    				}
    				
    			}
    			
    		}// end for
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", lblDataList);
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("lblConvList", lblConvList);
        	mav.addObject("vINDValList", vINDValList);
        	mav.addObject("shpIND", shpIND);
        	mav.addObject("shpIND2", shpIND2);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }        

        return mav;
    }
	
	@RequestMapping(value="reloadStepbackstatus", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadStepbackstatus(DccSearchStatus dccSearchStatus, HttpServletRequest request, HttpServletResponse response) {
       
		ModelAndView mav = new ModelAndView("jsonView");
		
        logger.info("############ reloadStepbackstatus");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("12");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 	        		        	
        	}        	

        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		List<Map> lblDataList = (ArrayList)dccVal.get("lblDataList");

    		for(int i=0;i<lblDataList.size();i++) {
    			
    			lblDataList.get(i).put("visible", true);
    			
    			if(i >= 12 && i<=23) {
    				lblDataList.get(i).put("visible", false);
    			}
    			
    			if(i >= 28 && i<=55) {
    				lblDataList.get(i).put("visible", false);
    			}
    		}
    		
    		String[] vData = basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
    		
    		int iError =0;
    		double fTmpVal = 0;
    		String sTipMsg = "";
    		
    		List<Map> lblConvList = new ArrayList<Map>();
    		List<Map> vINDValList= new ArrayList<Map>();
    		boolean[] shpIND = new boolean[10];
    		boolean[] shpIND2 = new boolean[10];
    		
    		for(int i=0;i<tagDccInfoList.size();i++) {
    			if(i< 6) {
    				    iError = iError + ((Double.parseDouble(vData[i+1]) == -32768)? 1:0);
    				    
    				    fTmpVal = fTmpVal + ((Double.parseDouble(vData[i+1]) == -32768)? 0: (Double.parseDouble(lblDataList.get(i).get("fValue").toString())));
    				    
    				    sTipMsg = sTipMsg + tagDccInfoList.get(i).getToolTip() + ((i == 2 || i == 5)? "":",");
    				    
    				    if(i == 2 || i == 5) {
    				    	
    				    	Map lblConv = new HashMap();
	    				    if(iError > 0) {
	    				    		lblConv.put("fValue", "***IRR");
	    				    }else {
	    				    		lblConv.put("fValue", (fTmpVal < 2)? "YES":"NO");
	    				    }
	    				    lblConv.put("TooTipTest", sTipMsg);
	    				    
	    				    lblConvList.add(lblConv);
	    				    
	    				    if(i ==5) {
	    				    	if(lblConvList.get(0).get("fValue").toString().equals("YES") || lblConvList.get(1).get("fValue").toString().equals("YES")  ) {
	    				    		shpIND[0] = true;	    				    		
	    				    	}else {
	    				    		shpIND[0] = false;
	    				    	}
	    				    }
	    				    
	    				    iError =0;
	    		    		fTmpVal = 0;
	    		    		sTipMsg = "";
	    				    
    				    }
    			} // i < 6
    			
    			if(i>=6 && i<=9) {
    				Map vINDVal = new HashMap();
    				if(Double.parseDouble(vData[i+1]) != -32768) {
    					vINDVal.put("fValue", lblDataList.get(i).get("fValue").toString());
    					vINDVal.put("fData", (Double.parseDouble(lblDataList.get(i).get("fValue").toString()) > 0)? "ON":"OFF");
    				}
    				
    				vINDValList.add(vINDVal);
    				
    				if(i == 9) {
    					if((Double.parseDouble(vINDValList.get(0).get("fValue").toString()) + Double.parseDouble(vINDValList.get(2).get("fValue").toString()) <  2) ||
    				         (Double.parseDouble(vINDValList.get(1).get("fValue").toString()) + Double.parseDouble(vINDValList.get(3).get("fValue").toString()) < 2)){
    								shpIND[1] = true;	
    					}else  if((Double.parseDouble(vINDValList.get(0).get("fValue").toString()) + Double.parseDouble(vINDValList.get(1).get("fValue").toString()) <  1) ||
       				         (Double.parseDouble(vINDValList.get(1).get("fValue").toString()) + Double.parseDouble(vINDValList.get(3).get("fValue").toString()) < 1)){
    								shpIND[2] = true;	
    					}    							
    				}    				
    			}// i >=6 && i <=9
    			
    			int fTmpIdx = 0;
    			if(i==14 || i == 17 || i==20 || i == 23) {
    				
    				 iError = ((Double.parseDouble(vData[i-1]) == -32768)? 1:0) +
    						 		((Double.parseDouble(vData[i]) == -32768)? 1:0) + 
    						 		((Double.parseDouble(vData[i+1]) == -32768)? 1:0);
    				 
    				 if(iError > 1) {
    					 lblDataList.get(i).put("fValue",  "***IRR");
    				 }else {
    					if( iError == 1) {
    						for(int j=(i-2); j<=i;j++) {
    							if((Double.parseDouble(vData[i+1])) != -32768){
    								if(fTmpIdx == -1) {
    									fTmpIdx = j;
    									fTmpVal = (Double.parseDouble(vData[i+1]));
    								}else {
    										if(fTmpVal > (Double.parseDouble(vData[i+1]))) {
    											fTmpIdx = j;
    	    									fTmpVal = (Double.parseDouble(vData[i+1]));
    										}
    								}    								
    							}
    						} // end for
    					}else {
    						fTmpIdx = i - getMidData(Double.parseDouble(vData[i-1]), Double.parseDouble(vData[i]), Double.parseDouble(vData[i+1]));
    					}
    					
    					lblDataList.get(fTmpIdx).put("visible", true); 
    					lblDataList.get(fTmpIdx).put("fValue",  lblDataList.get(fTmpIdx).get("fValue"));
    					
    				 }    				
    			} // i==14 || i == 17 || i==20 || i == 23
    			
    			if(i >= 28 && i <=55) {
    				if((i % 2) == 1) {
    					 iError = ((Double.parseDouble(vData[i]) == -32768)?1:0) + ((Double.parseDouble(vData[i+1]) == -32768)?1:0) ;
    					 
    					 if(iError > 1) {
    						 iError = ((Double.parseDouble(vData[62]) == -32768)?1:0) + ((Double.parseDouble(vData[63]) == -32768)?1:0) + ((Double.parseDouble(vData[64]) == -32768)?1:0) ;
    						 
    						 if (iError > 0){
    							 lblDataList.get(i).put("fValue",  "1.2");
    						 }else {
    							 fTmpIdx = 64 - getMidData(Double.parseDouble(vData[i-1]), Double.parseDouble(vData[i]), Double.parseDouble(vData[i+1]));
    							 
    							 lblDataList.get(i).put("fValue",  lblDataList.get(fTmpIdx).get("fValue"));
    							 tagDccInfoList.get(i).setToolTip(tagDccInfoList.get(fTmpIdx).getToolTip());    							 
    						 }    						 
    					 }else if(iError == 1) {
    						 if (Double.parseDouble(vData[i]) != -32768){
    							 lblDataList.get(i-1).put("fValue",  lblDataList.get(i).get("fValue"));
    							 lblDataList.get(i-1).put("visible",  true);
    						 }else if (Double.parseDouble(vData[i+1]) != -32768){
    							 lblDataList.get(i).put("fValue",  lblDataList.get(i+1).get("fValue"));
    							 lblDataList.get(i).put("visible",  true);
    						 }
    					 }else {
    						 if (Double.parseDouble(vData[i]) >  Double.parseDouble(vData[i+1]) ){
    							 lblDataList.get(i-1).put("fValue",  lblDataList.get(i-1).get("fValue"));
    							 lblDataList.get(i-1).put("visible",  true);
    						 }else {
    							 lblDataList.get(i).put("fValue",  lblDataList.get(i+1).get("fValue"));
    							 lblDataList.get(i).put("visible",  true);
    						 }
    					 }
    				}
    			}
    			
    			if(i == 56) {
    				 if (Double.parseDouble(vData[i+1]) > -32768){
    					 if(Double.parseDouble(lblDataList.get(i).get("fValue").toString()) > 0) {
    						lblDataList.get(i).put("fValue", "YES");    
    						shpIND[8] = true;	  
    					 }else {    						 
    						 lblDataList.get(i).put("fValue", "NO");
    						 shpIND[8] = false;
    					 }
    				 }else {
    					 lblDataList.get(i).put("fValue", -32768);
    					 shpIND[8] = false;
    				 }    				
    			}
    			
    			if(i == 61) {   				
	   				 if (StringUtils.isNumeric(vData[i+1])){
	   					 if(Double.parseDouble(vData[13]) < Double.parseDouble(vData[i+1])) {
	   						shpIND[5] = true;	  
	   					 }else {    						 
	   						shpIND[5] = false;
	   					 }
	   				 }
	   			}    			
    			
    			if(i == 65) {
    				double[] lblFP = {0.0, 0.01, 0.0, 0.005, 0.0, 0.005, 0.005, 0.0, 0.02};
    				
    				for( int j=0;j<lblFP.length;j++) {
    					 if (StringUtils.isNumeric(vData[i+1])){
    						 if( Double.parseDouble(vData[i+1]) > -32768) {
    							 if( Math.pow(10, Double.parseDouble(lblDataList.get(i).get("fValue" ).toString())) <  lblFP[j]) {
    								 shpIND2[j] = true;
    							 }else {
    								 shpIND2[j] = false;
    							 }
    						 }
    					 }
    				}
    				
    			}
    			
    		}// end for
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", lblDataList);
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("lblConvList", lblConvList);
        	mav.addObject("vINDValList", vINDValList);
        	mav.addObject("shpIND", shpIND);
        	mav.addObject("shpIND2", shpIND2);
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("12");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  
        	}

        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "stb");
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

        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("12");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");    
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
			
			MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");
        	}        	

        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		List<Map> lblDataList = (ArrayList)dccVal.get("lblDataList");
    		
    		for(int i=0;i<lblDataList.size();i++) {
    			
    			lblDataList.get(i).put("visible", true);
    			
    			if(i >= 0 && i<=2) {
    				lblDataList.get(i).put("visible", false);
    			}
    			
    			if(i >= 5 && i<=20) {
    				lblDataList.get(i).put("visible", false);
    			}
    		}
      	   
     		String[] vData = basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
     		
     		int iError =0;
     		double fTmpVal = 0;
     		String sTipMsg = "";
     		
     		List<Map> lblConvList = new ArrayList<Map>();
     		boolean[] shpIND = new boolean[11];
     		int fTmpIdx = 0;
     		
     		for(int i=0;i<tagDccInfoList.size();i++) {
     			
     			if(i == 2 || i == 7 || i == 10 || i == 13 || i ==20) {
     				iError =(( Double.parseDouble(vData[i - 1]) == -32768)? 1: 0) + 
     						(( Double.parseDouble(vData[i ]) == -32768)? 1: 0) +
     						(( Double.parseDouble(vData[i + 1]) == -32768)? 1: 0);
     				
     				if(iError > 1) {
     					lblDataList.get(i).put("fValue",  "***IRR");
     					lblDataList.get(i).put("visible",  true);
     				}else if(iError == 1) {
     					fTmpIdx = -1;
     					
     					if(i == 2 || i == 7 || i ==20) {
     						for(int j=(i-2); j<=i;j++) {
     							if((Double.parseDouble(vData[i+1])) != -32768){
     								if(fTmpIdx == -1) {
     									fTmpIdx = j;
     									fTmpVal = (Double.parseDouble(vData[i+1]));
     								}else {
     										if(fTmpVal > (Double.parseDouble(vData[i+1]))) {
     											fTmpIdx = j;
     	    									fTmpVal = (Double.parseDouble(vData[i+1]));
     										}
     								}    								
     							}
     						} // end for    						
     					}else if( i == 10 || i == 13) {
     						if((Double.parseDouble(vData[i+1])) != -32768){
     							for(int j=(i-2); j<=i;j++) {
         							if((Double.parseDouble(vData[i+1])) != -32768){
         								if(fTmpIdx == -1) {
         									fTmpIdx = j;
         									fTmpVal = (Double.parseDouble(vData[i+1]));
         								}else {
         										if(fTmpVal < (Double.parseDouble(vData[i+1]))) {
         											fTmpIdx = j;
         	    									fTmpVal = (Double.parseDouble(vData[i+1]));
         										}
         								}    								
         							}
         						} // end for       								
 							}
     					}// end if sub i = 10, 13    					
     				}else { 
     					fTmpIdx = i - getMidData(Double.parseDouble(vData[i-1]), Double.parseDouble(vData[i]), Double.parseDouble(vData[i+1]));
     				}// end if iError
     				
     				lblDataList.get(fTmpIdx).put("visible",  true); 
     				lblDataList.get(fTmpIdx).put("fValue",  lblDataList.get(fTmpIdx).get("fValue")); 
     				 
     				
     			} // end if =  i 2, 7, 10, 13, 20
     			
     			if(i >= 14 && i <= 17) {
     				if(i == 14) {
     					fTmpIdx = i;
 						fTmpVal = (Double.parseDouble(vData[i+1]));
     				}else {
     					if(fTmpVal < (Double.parseDouble(vData[i+1]))) {
 							fTmpIdx = i;
 							fTmpVal = (Double.parseDouble(vData[i+1]));
 						}
     				} // end if i = 14
     				
     				
     				if(i == 17) {
     					lblDataList.get(fTmpIdx).put("visible",  true); 
     					lblDataList.get(fTmpIdx).put("fValue",  lblDataList.get(fTmpIdx).get("fValue"));
     				}
     			} // end if i == 14 to 17
     			
     			if(i >= 3 && i <= 4) {
     				
     				sTipMsg = sTipMsg +  tagDccInfoList.get(i).getToolTip() + ((i == 4)? "": ", ");   
     				
     				if(i == 4) {
     					Map lblConv = new HashMap();
     					  
     					if(Double.parseDouble(vData[i+1]) != -32768){
     						lblConv.put("fValue", (1.1/Double.parseDouble(vData[i])) * Double.parseDouble(vData[i+1]));
     					}else {
     						lblConv.put("fValue", -32768);
     					}
     					
     					lblConv.put("Tooltip", sTipMsg);    					
     					
     					lblConvList.add(lblConv);
     				}    				
     			}// end if i = 3, 4
     			
     			if(i >= 25&& i <= 27) {
     				
     				if(i == 25) {
     					iError = 0;
     					fTmpVal = 0;
     				}
     				
     				iError = iError + ((Double.parseDouble(vData[i+1]) == -32768)? 1:0);
     				
     				fTmpVal = fTmpVal + ((Double.parseDouble(vData[i+1]) == -32768)? 0: (Double.parseDouble(lblDataList.get(i).get("fValue").toString())));
     				
     				sTipMsg = sTipMsg +  tagDccInfoList.get(i).getToolTip() + ((i == 27)? "": ", ");    				
     				
     				if(i == 27) {
     				
 	    				Map lblConv = new HashMap();
 	    				
 	    				if(iError > 0) {
 	    						lblConv.put("fValue", -32768);
 	    				}else {
     					
 	    					lblConv.put("fValue", (fTmpVal >=2)? "YES": "NO");
 	   					
 	    					lblConv.put("Tooltip", sTipMsg);
 	    				}    	
 	    				
     					lblConvList.add(lblConv);
     					
     				} // i = 27
     			}// end if i = 25 to 27
     			
     			if(i == 28 || i == 43) {
     				
     				Map lblConv = new HashMap();
     				
 					if((Double.parseDouble(vData[i+1]) == -32768)) {
 						lblConv.put("fValue", -32768);
 					}else {
 						lblConv.put("fValue", ((Double.parseDouble(lblDataList.get(i).get("fValue").toString()) == 1)? "YES": "NO"));
 					}
 	    				
     				lblConvList.add(lblConv);
     				
     			}// end if i = 28,43    			
     			
     			if(i >=44 && i<=54) {
     				shpIND[i-44] = ((Double.parseDouble(lblDataList.get(i).get("fValue").toString()) == 0)? false: true);
     			}
     			
     		}// end for
    		
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", lblDataList);
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("lblConvList", lblConvList);
        	mav.addObject("shpIND", shpIND);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));        	
        }
		
        return mav;
    }
	
	@RequestMapping( value = "reloadSetback", method = { RequestMethod.POST} )
	@ResponseBody
	public ModelAndView reloadSetback(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView("jsonView");

		logger.info("############ reloadSetback");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchStatus.setMenuName(this.menuName);
			
			MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
			
			String strMenuNo = dccSearchStatus.getMenuNo() == null ? "11" : dccSearchStatus.getMenuNo();
			if( strMenuNo.indexOf(",") > -1 ) strMenuNo = strMenuNo.substring(0,strMenuNo.indexOf(","));
			String strGrpNo = dccSearchStatus.getGrpNo() == null ? "13" : dccSearchStatus.getGrpNo();
			if( strGrpNo.indexOf(",") > -1 ) strGrpNo = strGrpNo.substring(0,strGrpNo.indexOf(","));
			String strGrpId = dccSearchStatus.getGrpId() == null ? "mimic" : dccSearchStatus.getGrpId();
			if( strGrpId.indexOf(",") > -1 ) strGrpId = strGrpId.substring(0,strGrpId.indexOf(","));
			
			dccSearchStatus.setMenuNo(strMenuNo);
			dccSearchStatus.setGrpNo(strGrpNo);
			dccSearchStatus.setGrpId(strGrpId);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");
        	}        	

        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", strGrpId);
    		dccGrpTagSearchMap.put("menuNo", strMenuNo);
    		dccGrpTagSearchMap.put("uGrpNo", strGrpNo);
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
    		List<Map> lblDataList = (ArrayList)dccVal.get("lblDataList");
    		
    		for(int i=0;i<lblDataList.size();i++) {
    			
    			lblDataList.get(i).put("visible", true);
    			
    			if(i >= 0 && i<=2) {
    				lblDataList.get(i).put("visible", false);
    			}
    			
    			if(i >= 5 && i<=20) {
    				lblDataList.get(i).put("visible", false);
    			}
    		}
      	   
     		String[] vData = basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
     		
     		int iError =0;
     		double fTmpVal = 0;
     		String sTipMsg = "";
     		
     		List<Map> lblConvList = new ArrayList<Map>();
     		boolean[] shpIND = new boolean[11];
     		int fTmpIdx = 0;
     		
     		for(int i=0;i<tagDccInfoList.size();i++) {
     			
     			if(i == 2 || i == 7 || i == 10 || i == 13 || i ==20) {
     				iError =(( Double.parseDouble(vData[i - 1]) == -32768)? 1: 0) + 
     						(( Double.parseDouble(vData[i ]) == -32768)? 1: 0) +
     						(( Double.parseDouble(vData[i + 1]) == -32768)? 1: 0);
     				
     				if(iError > 1) {
     					lblDataList.get(i).put("fValue",  "***IRR");
     					lblDataList.get(i).put("visible",  true);
     				}else if(iError == 1) {
     					fTmpIdx = -1;
     					
     					if(i == 2 || i == 7 || i ==20) {
     						for(int j=(i-2); j<=i;j++) {
     							if((Double.parseDouble(vData[i+1])) != -32768){
     								if(fTmpIdx == -1) {
     									fTmpIdx = j;
     									fTmpVal = (Double.parseDouble(vData[i+1]));
     								}else {
     										if(fTmpVal > (Double.parseDouble(vData[i+1]))) {
     											fTmpIdx = j;
     	    									fTmpVal = (Double.parseDouble(vData[i+1]));
     										}
     								}    								
     							}
     						} // end for    						
     					}else if( i == 10 || i == 13) {
     						if((Double.parseDouble(vData[i+1])) != -32768){
     							for(int j=(i-2); j<=i;j++) {
         							if((Double.parseDouble(vData[i+1])) != -32768){
         								if(fTmpIdx == -1) {
         									fTmpIdx = j;
         									fTmpVal = (Double.parseDouble(vData[i+1]));
         								}else {
         										if(fTmpVal < (Double.parseDouble(vData[i+1]))) {
         											fTmpIdx = j;
         	    									fTmpVal = (Double.parseDouble(vData[i+1]));
         										}
         								}    								
         							}
         						} // end for       								
 							}
     					}// end if sub i = 10, 13    					
     				}else { 
     					fTmpIdx = i - getMidData(Double.parseDouble(vData[i-1]), Double.parseDouble(vData[i]), Double.parseDouble(vData[i+1]));
     				}// end if iError
     				
     				lblDataList.get(fTmpIdx).put("visible",  true); 
     				lblDataList.get(fTmpIdx).put("fValue",  lblDataList.get(fTmpIdx).get("fValue")); 
     				 
     				
     			} // end if =  i 2, 7, 10, 13, 20
     			
     			if(i >= 14 && i <= 17) {
     				if(i == 14) {
     					fTmpIdx = i;
 						fTmpVal = (Double.parseDouble(vData[i+1]));
     				}else {
     					if(fTmpVal < (Double.parseDouble(vData[i+1]))) {
 							fTmpIdx = i;
 							fTmpVal = (Double.parseDouble(vData[i+1]));
 						}
     				} // end if i = 14
     				
     				
     				if(i == 17) {
     					lblDataList.get(fTmpIdx).put("visible",  true); 
     					lblDataList.get(fTmpIdx).put("fValue",  lblDataList.get(fTmpIdx).get("fValue"));
     				}
     			} // end if i == 14 to 17
     			
     			if(i >= 3&& i <= 4) {
     				
     				sTipMsg = sTipMsg +  tagDccInfoList.get(i).getToolTip() + ((i == 4)? "": ", ");   
     				
     				if(i == 4) {
     					Map lblConv = new HashMap();
     					  
     					if(Double.parseDouble(vData[i+1]) != -32768){
     						lblConv.put("fValue", (1.1/Double.parseDouble(vData[i])) * Double.parseDouble(vData[i+1]));
     					}else {
     						lblConv.put("fValue", -32768);
     					}
     					
     					lblConv.put("Tooltip", sTipMsg);    					
     					
     					lblConvList.add(lblConv);
     				}    				
     			}// end if i = 3, 4
     			
     			if(i >= 25&& i <= 27) {
     				
     				if(i == 25) {
     					iError = 0;
     					fTmpVal = 0;
     				}
     				
     				iError = iError + ((Double.parseDouble(vData[i+1]) == -32768)? 1:0);
     				
     				fTmpVal = fTmpVal + ((Double.parseDouble(vData[i+1]) == -32768)? 0: (Double.parseDouble(lblDataList.get(i).get("fValue").toString())));
     				
     				sTipMsg = sTipMsg +  tagDccInfoList.get(i).getToolTip() + ((i == 27)? "": ", ");    				
     				
     				if(i == 27) {
     				
 	    				Map lblConv = new HashMap();
 	    				
 	    				if(iError > 0) {
 	    						lblConv.put("fValue", -32768);
 	    				}else {
     					
 	    					lblConv.put("fValue", (fTmpVal >=2)? "YES": "NO");
 	   					
 	    					lblConv.put("Tooltip", sTipMsg);
 	    				}    	
 	    				
     					lblConvList.add(lblConv);
     					
     				} // i = 27
     			}// end if i = 25 to 27
     			
     			if(i == 28 || i == 43) {
     				
     				Map lblConv = new HashMap();
     				
 					if((Double.parseDouble(vData[i+1]) == -32768)) {
 						lblConv.put("fValue", -32768);
 					}else {
 						lblConv.put("fValue", ((Double.parseDouble(lblDataList.get(i).get("fValue").toString()) == 1)? "YES": "NO"));
 					}
 	    				
     				lblConvList.add(lblConv);
     				
     			}// end if i = 28,43    			
     			
     			if(i >=44 && i<=54) {
     				shpIND[i-44] = ((Double.parseDouble(lblDataList.get(i).get("fValue").toString()) == 0)? false: true);
     			}
     			
     		}// end for
    		
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", lblDataList);
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("lblConvList", lblConvList);
        	mav.addObject("shpIND", shpIND);
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  	        	       	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());	 
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "sb");
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
        	
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
			
			MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("14");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
	
	@RequestMapping( value="reloadTpm", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadTpm(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView("jsonView");

		logger.info("############ reloadTpm");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchStatus.setMenuName(this.menuName);
			
			MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setGubun("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("14");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  	        		        	
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
    		
    		MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("14");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X");  
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
        	dccGrpTagSearchMap.put("dive",dccSearchStatus.getGubun()== null?  "": dccSearchStatus.getGubun());
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);    		
    		
    		excelHelperUtil.statusExcelDownload(request, response, (List)dccVal.get("lblDataList"), tagDccInfoList, dccVal.get("SearchTime").toString(), "tpm");
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
        	
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);
        	
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	dccSearchStatus.setGubun("D");
	        	
	        	member.setHogi("3");
	        	member.setXyGubun("X"); 
        	}
        	
        	dccSearchStatus.setHogi(member.getHogi());
        	dccSearchStatus.setXyGubun(member.getXyGubun());
        	
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
	
	private int getMidData(double iVal1, double iVal2, double iVal3) {
		
		int rtn = 0 ;
		
		if((iVal1 > iVal2) && (iVal1 > iVal3)){
				if(iVal2 > iVal3) {
					rtn = 1;
				}else {
					rtn = 0;
				}
		}
		
		if((iVal2 > iVal3) && (iVal2 > iVal1)){
			if(iVal3 > iVal1) {
				rtn = 0;
			}else {
				rtn = 2;
			}
		}
		
		if((iVal3 > iVal1) && (iVal3 > iVal2)){
			if(iVal1 > iVal2) {
				rtn = 2;
			}else {
				rtn = 1;
			}
		}	
		
		return rtn;
		
	}
}
