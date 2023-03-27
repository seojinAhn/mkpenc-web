package com.mkpenc.dcc.performance.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.service.DccAdminService;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.common.module.StringUtil;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.dcc.common.service.BasDccMimicService;
import com.mkpenc.dcc.common.service.BasDccOsmsService;
import com.mkpenc.dcc.performance.model.DccSearchPerformance;
import com.mkpenc.dcc.performance.model.GroupNameInfo;
import com.mkpenc.dcc.performance.service.DccPerformanceService;
import com.mkpenc.dcc.status.model.DccSearchStatus;

import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/performance/")
public class DccPerformanceContentsController {

	private static Logger logger = LoggerFactory.getLogger(DccPerformanceContentsController.class);
	
	//AS-IS 포멧
	//public String[] gFormat = new String[]{ "0.00000",     "0.0000",     "0.0000",     "0.0000",     "0.000",     "0.000",     "0.000",     "0.00",     "0.00",     "0.00",     "0.00",     "0.0",     "0.0",     "0.0",     "0.0",     "0"};
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
	
	private String menuName = "PERFORMANCE";
	
	@Autowired
	 private CommonConstant commonConstant;	
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired	
	private BasDccOsmsService basDccOsmsService;
	
	@Autowired
	private BasDccMimicService basDccMimicService;
	
	@Autowired
	private DccPerformanceService dccPerfornamceService;
	
	
	@RequestMapping("fixed")
	public ModelAndView fixed(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ fixed");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	if(dccSearchPerformance.getsMenuNo() == null || dccSearchPerformance.getsMenuNo().isEmpty()) {
        	
	        	dccSearchPerformance.setsDive("D");
	        	dccSearchPerformance.setsMenuNo("41");
	        	dccSearchPerformance.setsGrpID("CompareVar");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
	        	dccSearchPerformance.setsXYGubun(member.getXyGubun());
        	}
        	        	
        	getMainPerformance(dccSearchPerformance, mav);        	
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);        	
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("spare")
	public ModelAndView spare(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ spare");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	if(dccSearchPerformance.getsMenuNo() == null || dccSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	dccSearchPerformance.setsDive("D");
	        	dccSearchPerformance.setsMenuNo("42");	        	
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
	        	dccSearchPerformance.setsXYGubun(member.getXyGubun());
	        	
	        	dccSearchPerformance.setsGrpID(member.getId());
        	}
        	        	
        	getMainPerformance(dccSearchPerformance, mav);       
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	private void getMainPerformance(DccSearchPerformance dccSearchPerformance, ModelAndView mav ) {
		
		Map grpSearchMap = new HashMap();
		grpSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
		grpSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
		grpSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
		//grpSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
				
		List<Map> grpNameList = basCommonService.selectGrpNameList(grpSearchMap);
    	mav.addObject("GroupNameList", grpNameList);
    	
    	if(dccSearchPerformance.getsUGrpNo() != null && !dccSearchPerformance.getsUGrpNo().isEmpty()) {
    		
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("xyGubun",dccSearchPerformance.getsXYGubun()==null?  "": dccSearchPerformance.getsXYGubun());
    		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
    		
    		for(ComTagDccInfo tagDccInfo:tagDccInfoList) {
    			
    			Map searchMap = new HashMap();
    			Map rtnMap;
    			
    			searchMap.put("fldno", tagDccInfo.getFLDNO());
    			searchMap.put("hogi", dccSearchPerformance.getsHogi());
    			searchMap.put("tblno", tagDccInfo.getTBLNO());
    			searchMap.put("chkHogi", dccSearchPerformance.getsChkHogi());
    			
    			searchMap.put("mskSpareS", dccSearchPerformance.getMskSpareS());
    			searchMap.put("mskSpareE", dccSearchPerformance.getMskSpareE());
    			
    			if(commonConstant.getUrl().equals("http://10.135.101.222")) {
    				
    				rtnMap = dccPerfornamceService.selectTrendInfoByUrlA(searchMap);
    				
    			}else {
    				 if(dccSearchPerformance.getMskSpareE().compareTo("2012-12-17") < 0) {
    						searchMap.put("mskSpareEchk", "1");
    				 }else {
    					 	searchMap.put("mskSpareEchk", "2");
    				 }
    				 
    				 rtnMap = dccPerfornamceService.selectTrendInfoA(searchMap);
    			}
    			
    			if(rtnMap != null) {
    				
    				//  If tDccTag(pCnt).IOTYPE = "DT" And (CInt(tDccTag(pCnt).AlarmType) = 4 Or CInt(tDccTag(pCnt).AlarmType) = 12) Then
    				
    				if(tagDccInfo.getIOTYPE().equals("DT") && (tagDccInfo.getAlarmType().equals("4") || tagDccInfo.getAlarmType().equals("12"))) {
    					
    					//private String methodCompare(String iVal, TagDccInfo tagDccInfo ) {
    					
    					if(rtnMap.get("avgTvalue") != null) {
    						
    						double tmp = Double.parseDouble(rtnMap.get("avgTvalue").toString()) * 100;
	    					tagDccInfo.setSpareAvgFldNo(methodCompare(String.valueOf(tmp), tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareAvgFldNo("");
	    				}
	    				
	    				if(rtnMap.get("stdevTvalue") != null) {
	    					tagDccInfo.setSpareStdevFldNo(methodCompare(rtnMap.get("stdevTvalue").toString(),tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareStdevFldNo("");
	    				}
	    				
	    				if(rtnMap.get("maxTvalue") != null) {
	    					double tmp = Double.parseDouble(rtnMap.get("maxTvalue").toString()) * 100;
	    					tagDccInfo.setSpareMaxFldNo(methodCompare(String.valueOf(tmp), tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareMaxFldNo("");
	    				}
	    				
	    				if(rtnMap.get("minTvalue") != null) {
	    					double tmp = Double.parseDouble(rtnMap.get("minTvalue").toString()) * 100;
	    					tagDccInfo.setSpareMinFldNo(methodCompare(String.valueOf(tmp), tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareMinFldNo("");
	    				}
    					
    				}else {
	    				
	    				if(rtnMap.get("avgTvalue") != null) {
	    					tagDccInfo.setSpareAvgFldNo(methodCompare(rtnMap.get("avgTvalue").toString(), tagDccInfo) );
	    				}else {
	    					tagDccInfo.setSpareAvgFldNo("");
	    				}
	    				
	    				if(rtnMap.get("stdevTvalue") != null) {
	    					tagDccInfo.setSpareStdevFldNo(methodCompare(rtnMap.get("stdevTvalue").toString(), tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareStdevFldNo("");
	    				}
	    				
	    				if(rtnMap.get("maxTvalue") != null) {
	    					tagDccInfo.setSpareMaxFldNo(methodCompare(rtnMap.get("maxTvalue").toString(), tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareMaxFldNo("");
	    				}
	    				
	    				if(rtnMap.get("minTvalue") != null) {
	    					tagDccInfo.setSpareMinFldNo(methodCompare(rtnMap.get("minTvalue").toString(), tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareMinFldNo("");
	    				}
	    				
    				}
   
    			}
    			
    			searchMap.put("mskFixedS", dccSearchPerformance.getMskFixedS());
    			searchMap.put("mskFixedE", dccSearchPerformance.getMskFixedE());
    			
    			if(commonConstant.getUrl().equals("http://10.135.101.222")) {
    				
    				rtnMap = dccPerfornamceService.selectTrendInfoByUrlB(searchMap);
    				
    			}else {
    				rtnMap = dccPerfornamceService.selectTrendInfoB(searchMap);
    			}
    			
    			if(rtnMap != null) {
    				
    				//  If tDccTag(pCnt).IOTYPE = "DT" And (CInt(tDccTag(pCnt).AlarmType) = 4 Or CInt(tDccTag(pCnt).AlarmType) = 12) Then
    				
    				if(tagDccInfo.getIOTYPE().equals("DT") && (tagDccInfo.getAlarmType().equals("4") || tagDccInfo.getAlarmType().equals("12"))) {
    					
    					//private String methodCompare(String iVal, TagDccInfo tagDccInfo ) {
    					
    					if(rtnMap.get("avgTvalue") != null) {
    						
    						double tmp = Double.parseDouble(rtnMap.get("avgTvalue").toString()) * 100;
	    					tagDccInfo.setSpareAvgFldNo(methodCompare(String.valueOf(tmp), tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareAvgFldNo("");
	    				}
	    				
	    				if(rtnMap.get("stdevTvalue") != null) {
	    					tagDccInfo.setSpareStdevFldNo(methodCompare(rtnMap.get("stdevTvalue").toString(),tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareStdevFldNo("");
	    				}
	    				
	    				if(rtnMap.get("maxTvalue") != null) {
	    					double tmp = Double.parseDouble(rtnMap.get("maxTvalue").toString()) * 100;
	    					tagDccInfo.setSpareMaxFldNo(methodCompare(String.valueOf(tmp), tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareMaxFldNo("");
	    				}
	    				
	    				if(rtnMap.get("minTvalue") != null) {
	    					double tmp = Double.parseDouble(rtnMap.get("minTvalue").toString()) * 100;
	    					tagDccInfo.setSpareMinFldNo(methodCompare(String.valueOf(tmp), tagDccInfo));
	    				}else {
	    					tagDccInfo.setSpareMinFldNo("");
	    				}
    					
    				}else {
	    				
	    				
	    				if(rtnMap.get("avgTvalue") != null) {
	    					tagDccInfo.setFixedAvgFldNo(methodCompare(rtnMap.get("avgTvalue").toString(), tagDccInfo));
	    				}else {
	    					tagDccInfo.setFixedAvgFldNo("");
	    				}
	    				
	    				if(rtnMap.get("stdevTvalue") != null) {
	    					tagDccInfo.setFixedStdevFldNo(methodCompare(rtnMap.get("stdevTvalue").toString(), tagDccInfo));
	    				}else {
	    					tagDccInfo.setFixedStdevFldNo("");
	    				}   
	    				
	    				if(rtnMap.get("maxTvalue") != null) {
	    					tagDccInfo.setFixedMaxFldNo(methodCompare(rtnMap.get("maxTvalue").toString(), tagDccInfo));
	    				}else {
	    					tagDccInfo.setFixedMaxFldNo("");
	    				}
	    				
	    				if(rtnMap.get("minTvalue") != null) {
	    					tagDccInfo.setFixedMinFldNo(methodCompare(rtnMap.get("minTvalue").toString(), tagDccInfo));
	    				}else {
	    					tagDccInfo.setFixedMinFldNo("");
	    				}	    				
	    				
    				}
    			}
    			
				if( tagDccInfo.getSpareAvgFldNo() != null && !tagDccInfo.getSpareAvgFldNo().equals("") && !tagDccInfo.getSpareAvgFldNo().equals("***IRR") && 
							tagDccInfo.getFixedAvgFldNo() != null && !tagDccInfo.getFixedAvgFldNo().equals("") && !tagDccInfo.getFixedAvgFldNo().equals("***IRR")) {
				 			
							double gapAB = Double.parseDouble(tagDccInfo.getFixedAvgFldNo()) - Double.parseDouble(tagDccInfo.getSpareAvgFldNo());
							tagDccInfo.setGapAB(String.format(gFormat[tagDccInfo.getBScale()], gapAB));
					
							if( tagDccInfo.getGapAB() != null && !tagDccInfo.getGapAB().equals("") &&
								  tagDccInfo.getSpareAvgFldNo() != null && !tagDccInfo.getSpareAvgFldNo().equals("")) {
							  
							  double rateAB = (Double.parseDouble(tagDccInfo.getGapAB()) /  Double.parseDouble(tagDccInfo.getSpareAvgFldNo())) * 100;
							  tagDccInfo.setRateAB(String.format(gFormat[tagDccInfo.getBScale()], rateAB));
							}else {
							  tagDccInfo.setRateAB("");
							}
				}else {
							tagDccInfo.setGapAB("");
							tagDccInfo.setRateAB("");
				}
    		} // end for ComTagDccInfo

    		mav.addObject("TagDccInfoList", tagDccInfoList);
    		
    	} // end if UGrpNo
    	
	}
	
	private String methodCompare(String iVal, ComTagDccInfo tagDccInfo ) {
		
		String rVal = "";
		//String rtn = "";
		
		if(iVal == null) {
	       return rVal;
		}
		
		if(Double.parseDouble(iVal) < -9999999) {
			return rVal;
		}else {
			if(tagDccInfo.getIOTYPE().equals("SC") && tagDccInfo.getBScale() != 0) {
				rVal = (Integer.parseInt(rVal) / (2 ^ (15 - tagDccInfo.getBScale()))) + "";
			}
			
			if(tagDccInfo.getIOTYPE().equals("SC") && tagDccInfo.getSaveCore() != 1 && tagDccInfo.getIOBIT() != 0) {
				  rVal = GetBitVal(iVal, Integer.toString(tagDccInfo.getIOBIT()));
			}
			
			if(tagDccInfo.getIOTYPE().equals("AI")) {
				if(tagDccInfo.getTBLNO()== 8 && tagDccInfo.equals("77")) {
					   rVal = (Double.parseDouble(iVal) * 8.1081) + "";
				}else {
					rVal = iVal;
				}
			}else {
				rVal = iVal;
			}			
		}
		
		if(rVal != null && !rVal.isEmpty()) {
			if(Double.parseDouble(rVal) > -32768) {
				if( tagDccInfo.getIOTYPE().equals("DI") ||  tagDccInfo.getIOTYPE().equals("SC")) {
					if(tagDccInfo.getIOTYPE().equals("SC")) {
						//Method_Compare = Format(CSng(rVal / 2 ^ (15 - tDccTag(iCnt).IOBIT)), gFormat(tDccTag(iCnt).BScale))
						double tmpRtn = Math.pow((Double.parseDouble(rVal) / 2) ,  (15-tagDccInfo.getIOBIT()));
						return String.format(gFormat[tagDccInfo.getBScale()], tmpRtn);
					}else {
						return rVal;
					}
				}else {
					 // Method_Compare = Format(CSng(rVal), gFormat(tDccTag(iCnt).BScale))
					return String.format(gFormat[tagDccInfo.getBScale()], Double.parseDouble(rVal));
				}
			}else {
				return "***IRR";
			}
		}else {
			return "";
		}		
	}
	
	
	// - 디지털 값을 가져온다.(16bit -> 1bit)
	//private int GetBitVal(ByVal DigitalValue As String, ByVal DigitalBit As String) As String
	private String GetBitVal(String digitalValue, String digitalBit) {
	    
	    long Rest = 0;
	    
	    long di_val;
	    int bit_no;	    
	    
	    if(digitalBit.isEmpty()) {
	       if(digitalValue == null) {
	    	   return "";
	       }else {
	    	   return digitalValue;
	       }
	    }
	    
	    di_val = Math.round(Double.parseDouble(digitalValue));	    
	    bit_no = Integer.parseInt(digitalBit);

	    for(int i = 0;i < bit_no;i++) {
	        Rest = (di_val % 2);
	        //di_val = di_val \ 2;
	    	di_val = di_val / 2;
		}
	    
	    return Rest +"";
	}
	
	
	@RequestMapping(value = "getDccGrpTag", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView getDccGrpTag(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
		
		logger.info("############ getDccGrpTag");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		Map dccGrpTagSearchMap = new HashMap();
		dccGrpTagSearchMap.put("xyGubun",dccSearchPerformance.getsXYGubun()==null?  "": dccSearchPerformance.getsXYGubun());
		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
		
		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
		
		mav.addObject("TagDccInfoList", tagDccInfoList);
    	mav.addObject("BaseSearch", dccSearchPerformance);        	
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

		return mav;
	}	
	
	@RequestMapping(value = "getUGrpNoInfo", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView getUGrpNoInfo(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
		
		logger.info("############ getUGrpNoInfo");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		dccSearchPerformance.setMenuName(this.menuName);
		
				
		Map searchMap = new HashMap();
		searchMap.put("dive",dccSearchPerformance.getsDive()== null?  "": dccSearchPerformance.getsDive());
		searchMap.put("grpID", dccSearchPerformance.getsGrpID()== null?  "": dccSearchPerformance.getsGrpID());
		searchMap.put("menuNo", dccSearchPerformance.getsMenuNo()== null?  "": dccSearchPerformance.getsMenuNo());
		searchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()== null?  "": dccSearchPerformance.getsUGrpNo());
		searchMap.put("menuName", dccSearchPerformance.getsUGrpNo()== null?  "": dccSearchPerformance.getsUGrpNo());
		
		
    	List<Map> grpNameList = basCommonService.selectGrpNameList(searchMap);
	
    	if(grpNameList != null && grpNameList.size() == 1) {
    		mav.addObject("GrpName", grpNameList.get(0));
    	}
    	
    	if(dccSearchPerformance.getsUGrpNo() != null && !dccSearchPerformance.getsUGrpNo().isEmpty()) {
    		    		
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("xyGubun",dccSearchPerformance.getsXYGubun()==null?  "": dccSearchPerformance.getsXYGubun());
    		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
    		
    		mav.addObject("TagDccInfoList", tagDccInfoList);
    	}    	    	
    	
    	mav.addObject("BaseSearch", dccSearchPerformance);        	
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

		return mav;
	}	
	
	
	@RequestMapping(value = "tagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView tagSearch(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
		
		logger.info("############ tagSearch");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<Map> tagSearchList = dccPerfornamceService.selectTagSearch(dccSearchPerformance);
		

		mav.addObject("TagSearchList", tagSearchList);
    	mav.addObject("BaseSearch", dccSearchPerformance);        	
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

		return mav;
	}	
	
	@RequestMapping(value = "fastioSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView fastioSearch(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
		
		logger.info("############ fastioSearch");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<Map> fastIoSearchList = dccPerfornamceService.selectFastIOSearch(dccSearchPerformance);

		mav.addObject("FastIoSearchList", fastIoSearchList);
    	mav.addObject("BaseSearch", dccSearchPerformance);        	
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

		return mav;
	}	
	
	@RequestMapping(value = "setUGrpName", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView setUGrpName(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
		
		logger.info("############ setUGrpName");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		if(dccSearchPerformance.getbGroupFlag().equals("1")) {
			
			Map rtnUGrpNo = dccPerfornamceService.selectMaxGrpName(dccSearchPerformance);
			String maxUGrpNo = "0";
			
			if(rtnUGrpNo != null && rtnUGrpNo.get("MAX_ UGrpNo") != null) {
				maxUGrpNo = (Integer.parseInt(rtnUGrpNo.get("MAX_ UGrpNo").toString()) + 1) + "";
			}
			
			Map insertMap = new HashMap();
			insertMap.put("gubun",dccSearchPerformance.getsDive() );
			insertMap.put("id", dccSearchPerformance.getsGrpID());
			insertMap.put("menuNo", dccSearchPerformance.getsMenuNo());
			insertMap.put("uGrpName", dccSearchPerformance.getuGrpName());

			
			//'- Fixed 000~100
	        //'- Spare 101~200
			switch(dccSearchPerformance.getsMenuNo()) {
				case "22" :
				case "24" : 
				case "32" :
						if(maxUGrpNo.equals("0")) {
							maxUGrpNo = "101";
						}
					break;				
			}
			
			insertMap.put("uGrpNo", maxUGrpNo);
			
			dccPerfornamceService.insertGrpName(insertMap);
			
			dccSearchPerformance.setIoUGrpNo(maxUGrpNo);
			
		}else {
			
		//	System.out.println("getIoUGrpNo==="+ dccSearchPerformance.getIoUGrpNo());
		//	System.out.println("getsDive==="+ dccSearchPerformance.getsDive());
		//	System.out.println("getsMenuNo==="+ dccSearchPerformance.getsMenuNo());
		//	System.out.println("getsGrpID==="+ dccSearchPerformance.getsGrpID());
			
			Map updateMap = new HashMap();
			updateMap.put("gubun",dccSearchPerformance.getsDive() );
			updateMap.put("id", dccSearchPerformance.getsGrpID());
			updateMap.put("menuNo", dccSearchPerformance.getsMenuNo());
			updateMap.put("uGrpNo", dccSearchPerformance.getIoUGrpNo());
			updateMap.put("uGrpName", dccSearchPerformance.getuGrpName());
			
			dccPerfornamceService.updateGrpName(updateMap);
			
		}
		
		if(dccSearchPerformance.getHogiArr() != null && !dccSearchPerformance.getHogiArr().isEmpty()) {
			mstGrpTagSave(dccSearchPerformance.getsHogi(), dccSearchPerformance);
		}
		
		mav.addObject("BaseSearch", dccSearchPerformance);        	
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

		return mav;
	}	
	
	private void mstGrpTagSave(String hogi, DccSearchPerformance dccSearchPerformance) {
		
		Map deleteMap = new HashMap();
		deleteMap.put("gubun",dccSearchPerformance.getsDive() );
		deleteMap.put("id", dccSearchPerformance.getsGrpID());
		deleteMap.put("menuNo", dccSearchPerformance.getsMenuNo());
		deleteMap.put("grpHOGI", hogi);
		deleteMap.put("grpNo", dccSearchPerformance.getIoUGrpNo());
		
		//MST_GrpTap 
		dccPerfornamceService.deleteGrpTag(deleteMap);
		
		String[] hogiArr = dccSearchPerformance.getHogiArr().split(",");
		String[] xyGubunArr = dccSearchPerformance.getXyGubunArr().split(",");
		String[] loopNameArr = dccSearchPerformance.getLoopNameArr().split(",");
		String[] ioTypeArr = dccSearchPerformance.getIoTypeArr().split(",");
		String[] addressArr = dccSearchPerformance.getAddressArr().split(",");
		String[] ioBitArr = dccSearchPerformance.getIoBitArr().split(",");
		String[] minValArr = dccSearchPerformance.getMinValArr().split(",");
		String[] maxValArr = dccSearchPerformance.getMaxValArr().split(",");
		String[] saveCoreArr = dccSearchPerformance.getSaveCoreArr().split(",");
		String[] iSeqArr = dccSearchPerformance.getiSeqArr().split(",");
		
		for(int idx=0;idx<hogiArr.length;idx++) {
			
			Map searchMap = new HashMap();
			searchMap.put("iHogi", hogiArr[idx]);
			searchMap.put("ioType", ioTypeArr[idx]);
			searchMap.put("address", hogiArr[idx]);
			
			if(ioBitArr[idx] != null && !ioBitArr[idx].isEmpty()) {
				searchMap.put("ioBit", ioBitArr[idx]);
			}
			
			if(xyGubunArr[idx].equals("X")) {
				searchMap.put("xyGubun", "Y");				
			}else {
				searchMap.put("xyGubun", "X");
			}
			
			//MST_GrpTap 
			Map rtnISeq = dccPerfornamceService.selectISeqTagDccSearch(deleteMap);
			
			String tmpiSeq="0";
			if(rtnISeq != null && rtnISeq.get("ISEQ") !=null) {
				tmpiSeq = rtnISeq.get("ISEQ").toString();
			}		   
			
			
			Map insertMap = new HashMap();
			insertMap.put("gubun", dccSearchPerformance.getsDive());
			insertMap.put("id", dccSearchPerformance.getsGrpID());
			insertMap.put("grpHogi", hogi);
			insertMap.put("menuNo", dccSearchPerformance.getsMenuNo());
			insertMap.put("grpNo", dccSearchPerformance.getsUGrpNo());
			
			if(dccSearchPerformance.getsHogi().equals(hogi)) {
				insertMap.put("hogi", hogiArr[idx]);
			}else {
				if(hogiArr[idx].equals("3")) {
					insertMap.put("hogi", "4");
				}else {
					insertMap.put("hogi", "3");
				}
			}
			
			insertMap.put("tagNo", idx);

			insertMap.put("iSeq", dccSearchPerformance.getsXYGubun().equals("X")?  xyGubunArr[idx]: tmpiSeq);
			insertMap.put("maxVal", maxValArr[idx]);
			insertMap.put("minVal", minValArr[idx]);
			
			insertMap.put("ySeq",  dccSearchPerformance.getsXYGubun().equals("Y")?  xyGubunArr[idx]: tmpiSeq);
			insertMap.put("yMaxVal", maxValArr[idx]);
			insertMap.put("yMinVal", minValArr[idx]);
			
			insertMap.put("saveCoreChk", saveCoreArr[idx]);
			insertMap.put("descr", loopNameArr[idx]);
			
			dccPerfornamceService.insertGrpTag(insertMap);			
		}		
	}	
		
	
	@RequestMapping("compare34")
	public ModelAndView compare34(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ compare34");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(dccSearchPerformance.getsMenuNo() == null || dccSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	dccSearchPerformance.setsDive("D");
	        	dccSearchPerformance.setsMenuNo("43");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
	        	dccSearchPerformance.setsXYGubun(member.getXyGubun());
	        	
	        	dccSearchPerformance.setsGrpID(member.getId());
        	}
        	        	
        	
        	Map grpSearchMap = new HashMap();
    		grpSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
    		grpSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
    		grpSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
    		grpSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
    		
        	List<Map> grpNameList = basCommonService.selectGrpNameList(grpSearchMap);
        	
        	if(dccSearchPerformance.getsUGrpNo() != null && !dccSearchPerformance.getsUGrpNo().isEmpty()) {
        		
        		Map dccGrpTagSearchMap = new HashMap();
        		dccGrpTagSearchMap.put("xyGubun",dccSearchPerformance.getsXYGubun()==null?  "": dccSearchPerformance.getsXYGubun());
        		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
        		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
        		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
        		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
        		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
        		
        		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
        		
        		mav.addObject("TagDccInfoList", tagDccInfoList);
        	}
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	mav.addObject("GroupNameList", grpNameList);
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping(value = "runtimer34", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView runtimer34(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
		
		logger.info("############ runtimer34");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		if(dccSearchPerformance.getsUGrpNo() != null && !dccSearchPerformance.getsUGrpNo().isEmpty()) {
    		
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("xyGubun",dccSearchPerformance.getsXYGubun()==null?  "": dccSearchPerformance.getsXYGubun());
    		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
    		
    		mav.addObject("TagDccInfoList", tagDccInfoList);
    		
    		dccGrpTagSearchMap.put("hogi","3");
    		String[] varValue3 =  basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);

    		dccGrpTagSearchMap.put("hogi","4");
    		String[] varValue4 =  basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
    		
    		List<Map> dccTagList = new ArrayList<Map>();
    		
    		int iRow = 0;
    		for(ComTagDccInfo tagDccInfo:tagDccInfoList) {
    			
    			Map rtnMap = new HashMap();
    			
    			rtnMap.put("IOTYPE", tagDccInfo.getIOTYPE());
    			
    			if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
    				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS()  + "-" +  tagDccInfo.getIOTYPE());
    			}else {
    				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS());    				
    			}
    			
    			rtnMap.put("DataLoop", tagDccInfo.getDataLoop());
    			rtnMap.put("Descr", tagDccInfo.getDescr());
    			
    			if(varValue3.length > 1) {
    				
    				if(StringUtil.isNumeric(varValue3[iRow + 1])){
    					
    					if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
    	    				rtnMap.put("Value_3", GetBitVal(varValue3[iRow + 1], ""+tagDccInfo.getIOBIT()));
    					}else if(tagDccInfo.getIOTYPE().equals("DI")){
    						rtnMap.put("Value_3", varValue3[iRow + 1]);
    					}else {
    	    				rtnMap.put("Value_3", String.format(gFormat[tagDccInfo.getBScale()], varValue3[iRow + 1])); 		
    	    			}    					
    				}    				
    			}
    			
    			if(varValue4.length > 1) {
    				
    				if(StringUtil.isNumeric(varValue4[iRow + 1])){
    					
    					if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
    	    				rtnMap.put("Value_4", GetBitVal(varValue4[iRow + 1], ""+tagDccInfo.getIOBIT()));
    					}else if(tagDccInfo.getIOTYPE().equals("DI")){
    						rtnMap.put("Value_4", varValue4[iRow + 1]);
    					}else {
    						rtnMap.put("Value_4", String.format(gFormat[tagDccInfo.getBScale()], varValue4[iRow + 1])); 		
    	    			}    					
    				}    	
    			}
    			
    			rtnMap.put("Unit", tagDccInfo.getUnit());
    			
    			dccTagList.add(rtnMap);
    		}
    		
    		mav.addObject("DccTagList", dccTagList);
    	}

		mav.addObject("BaseSearch", dccSearchPerformance);        	
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

		return mav;
	}		
	
	
	@RequestMapping("comparexy")
	public ModelAndView comparexy(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ comparexy");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	String preSPer = "";
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	if(dccSearchPerformance.getsPer() == null || dccSearchPerformance.getsPer().isEmpty()) {
        		dccSearchPerformance.setsPer("0.02");
        	}else {
        		preSPer = dccSearchPerformance.getsPer(); 
        		double per = Double.parseDouble(preSPer) / 100;
        		dccSearchPerformance.setsPer(String.valueOf(per));
        	}
        	
        	if(dccSearchPerformance.getsHogi() == null || dccSearchPerformance.getsHogi().isEmpty()){
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
        	}
        	
        	if(dccSearchPerformance.getsIOType() == null || dccSearchPerformance.getsIOType().isEmpty()) {
        		dccSearchPerformance.setsIOType("0");
        	}
        	
        	getCompareXY(dccSearchPerformance, mav);
        	dccSearchPerformance.setsPer(preSPer );        	
        	        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("irrationalai")
	public ModelAndView irrationalai(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ irrationalai");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	

        	
        	String preSPer = "";
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	if(dccSearchPerformance.getsPer() == null || dccSearchPerformance.getsPer().isEmpty()) {
        		dccSearchPerformance.setsPer("0.02");
        	}else {
        		preSPer = dccSearchPerformance.getsPer(); 
        		double per = Double.parseDouble(preSPer) / 100;
        		dccSearchPerformance.setsPer(String.valueOf(per));
        	}
        	
        	if(dccSearchPerformance.getsHogi() == null || dccSearchPerformance.getsHogi().isEmpty()){
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
        	}
        	
        	if(dccSearchPerformance.getsIOType() == null || dccSearchPerformance.getsIOType().isEmpty()) {
        		dccSearchPerformance.setsIOType("2");
        	}
        	
        	getCompareXY(dccSearchPerformance, mav);
        	dccSearchPerformance.setsPer(preSPer);        	
        	        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	private void getCompareXY(DccSearchPerformance dccSearchPerformance, ModelAndView mav) {
		
		if(dccSearchPerformance.getsIOType() != null && !dccSearchPerformance.getsIOType().isEmpty()) {
    		
    		//*** START X GUBUN
    		String pSCanTimeX = "";
    		dccSearchPerformance.setsXYGubun("X");
    		Map scantimeX = dccPerfornamceService.selectScanTime(dccSearchPerformance);
			
			if(scantimeX != null && scantimeX.get("SCANTIME") != null) {
				pSCanTimeX = scantimeX.get("SCANTIME") .toString();
			}
			
			if(pSCanTimeX.isEmpty()) {
				
				LocalDateTime now = LocalDateTime.now();
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			 
		         pSCanTimeX = now.format(formatter);
			}
			
			 try {
				   java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				   java.util.Date date = format.parse(pSCanTimeX);

				   java.text.SimpleDateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				   pSCanTimeX = format1.format(date);

			 } catch (java.text.ParseException ex) {
			   ex.printStackTrace();
			 }
		 
			List<Map> varValueX = new ArrayList<Map>();
			if(commonConstant.getUrl().equals("http://10.135.101.222")) {    				
				
				for(int i=1;i<=113;i++) {
		               
					if( (i >0 && i<19) ||  (i > 20 && i < 37) || (i > 40 && i < 49) ||
	    		               i == 60 || i == 70 || i == 80 || i == 90 || i == 110 || i == 111 || i == 112 || i==113) {
						
						Map selectMap = new HashMap();
						selectMap.put("idx", i);
						selectMap.put("hogi", dccSearchPerformance.getsHogi());
						selectMap.put("pSCanTime", pSCanTimeX);

						List<Map> xyLogDccTrendByUrlList = dccPerfornamceService.selectXYLogDccTrendByUrl(selectMap);
						for(Map xyLogDccTrendByUrl:xyLogDccTrendByUrlList) {
							varValueX.add(xyLogDccTrendByUrl);
						}// end for
					} // end if i range :  sql --> union all 처리 
				}//end for 113 : sql --> union all 처리
			}else {
				
				Map selectMap = new HashMap();
				selectMap.put("hogi", dccSearchPerformance.getsHogi());
				selectMap.put("pSCanTime", pSCanTimeX);
				
				List<Map> xyLogDccTrendList = dccPerfornamceService.selectXYLogDccTrend(selectMap);
				for(Map xyLogDccTrend:xyLogDccTrendList) {
					varValueX.add(xyLogDccTrend);
				}// end for
			}
			//*** END X GUBUN
			
 			//*** START Y GUBUN    			
			String pSCanTimeY = "";
    		dccSearchPerformance.setsXYGubun("Y");
    		Map scantimeY = dccPerfornamceService.selectScanTime(dccSearchPerformance);
			
			if(scantimeY != null && scantimeY.get("SCANTIME") != null) {
				pSCanTimeY = scantimeY.get("SCANTIME") .toString();
			}
			
			if(pSCanTimeY.isEmpty()) {
	
				LocalDateTime now = LocalDateTime.now();
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			 
				pSCanTimeY = now.format(formatter);
			}
			
			 try {
				   java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				   java.util.Date date = format.parse(pSCanTimeY);

				   java.text.SimpleDateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				   pSCanTimeY = format1.format(date);

			 } catch (java.text.ParseException ex) {
			   ex.printStackTrace();
			 }
			
			List<Map> varValueY = new ArrayList<Map>();
			if(commonConstant.getUrl().equals("http://10.135.101.222")) {    				
				
				for(int i=1;i<=113;i++) {
		               
					if( (i >0 && i<19) ||  (i > 20 && i < 37) || (i > 40 && i < 49) ||
	    		               i == 60 || i == 70 || i == 80 || i == 90 || i == 110 || i == 111 || i == 112 || i==113) {
						
						Map selectMap = new HashMap();
						selectMap.put("idx", i);
						selectMap.put("hogi", dccSearchPerformance.getsHogi());
						selectMap.put("pSCanTime", pSCanTimeY);

						List<Map> xyLogDccTrendByUrlList = dccPerfornamceService.selectXYLogDccTrendByUrl(selectMap);
						for(Map xyLogDccTrendByUrl:xyLogDccTrendByUrlList) {
							varValueY.add(xyLogDccTrendByUrl);
						}// end for
					} // end if
				}//end for
			}else {
				
				Map selectMap = new HashMap();
				selectMap.put("hogi", dccSearchPerformance.getsHogi());
				selectMap.put("pSCanTime", pSCanTimeY);
				
				List<Map> xyLogDccTrendList = dccPerfornamceService.selectXYLogDccTrend(selectMap);
				for(Map xyLogDccTrend:xyLogDccTrendList) {
					varValueY.add(xyLogDccTrend);
				}// end for
			}
			//*** END Y GUBUN
			
			//*** START IOTYPE 
			List<Map> pRsList = new ArrayList<Map>();
			int pRsListTotalCnt = 0;
			
			Map selectMap = new HashMap();
			selectMap.put("hogi", dccSearchPerformance.getsHogi());
			selectMap.put("per", dccSearchPerformance.getsPer());
			selectMap.put("pageNum", dccSearchPerformance.getPageNum());
			selectMap.put("pageSize", 30);				
			
			switch(dccSearchPerformance.getsIOType()) {
				case "0": 
							pRsListTotalCnt = dccPerfornamceService.selectXYIOTypeAITotalCnt(selectMap);
							pRsList = dccPerfornamceService.selectXYIOTypeAI(selectMap);
							break;
				case "1": 
							pRsListTotalCnt = dccPerfornamceService.selectXYIOTypeDITotalCnt(selectMap);
							pRsList = dccPerfornamceService.selectXYIOTypeDI(selectMap);    					
							break;   							
				case "2": 
							pRsListTotalCnt = dccPerfornamceService.selectXYIOTypeAIWIBATotalCnt(selectMap);
							pRsList = dccPerfornamceService.selectXYIOTypeAIWIBA(selectMap);    					
							break;
			}
			//*** END IOTYPE 
			
			//*** START RETURN  aryValueList
			List<Map> aryValueList = new ArrayList<Map>();
			
			int j=0;
			int idx=1;
			String fldNoX ="";
			String xValue = "";
			String fldNoY="";
			String yValue = "";
			
			for(Map pRs:pRsList) {

				switch(dccSearchPerformance.getsIOType()) {
	    				case "0": 			    					
			    					for(j=0;j<varValueX.size();j++) {
			    	                    if(pRs.get("TBLNO").equals(varValueX.get(j).get("SEQ"))){
			    	                    	break;
			    	                    }
			    					 }
			    					 fldNoX = pRs.get("FLDNO").toString();
			    	                 xValue = varValueX.get(j).get("TVALUE" + (Integer.parseInt(fldNoX))).toString();
			    	                 
			    	                 for(j=0;j<varValueY.size();j++) {
				    					 if(pRs.get("B_TBLNO").equals(varValueY.get(j).get("SEQ"))){
				    	                    	break;
				    	                 }
				    				 }
				    				 fldNoY= pRs.get("B_FLDNO").toString();
				    	             yValue = varValueY.get(j).get("TVALUE" + (Integer.parseInt(fldNoY))).toString();
				    	             /*
				    	             BigDecimal yBigValue = new BigDecimal(Double.parseDouble(yValue));
				    	             
				    	             if(yBigValue.toString().length() > 10) {      
				    	                 yValue = yBigValue.toString().substring(0, 10);
				    	                 System.out.println("yValue = " + yValue);
			    	                 }	
				    	             */
				    	             double xyValue = Double.parseDouble(xValue) - Double.parseDouble(yValue);

				    	             if(xyValue < 0 ) {
				    	            	 xyValue = xyValue * -1;
				    	             }
					                 
					                 double value10 = Double.parseDouble(pRs.get("Calc").toString());
					                 if(value10 < 0) {
					                     value10 = value10 * -1;
					                 }
				    	             
					                 if(xyValue > value10) {
					                	 
					                	 Map aryValue = new HashMap();
					                	 aryValue.put("INDEX", idx);
					                	 aryValue.put("LOOPNAME", pRs.get("LOOPNAME"));
					                	 aryValue.put("TBLNO", pRs.get("TBLNO"));
					                	 aryValue.put("FLDNO", pRs.get("FLDNO"));
					                	 aryValue.put("Calc", pRs.get("Calc"));
					                	 aryValue.put("ADDRESS", pRs.get("ADDRESS"));
					                	 
					                	 aryValue.put("xValue", xValue);
					                	 aryValue.put("yValue", yValue);
					                	 
					                	 aryValue.put("UNIT", pRs.get("UNIT"));					                	 
					                	 aryValue.put("BSCAL", pRs.get("BSCAL"));					                	 
					                	 aryValue.put("B_TBLNO", pRs.get("B_TBLNO"));
					                	 aryValue.put("B_FLDNO", pRs.get("B_FLDNO"));
					                	 aryValue.put("DESCR", pRs.get("DESCR"));
					                	 
					                	 aryValue.put("WIBA", pRs.get("WIBA"));
					                	 aryValue.put("B_WIBA", pRs.get("B_WIBA"));
					                	 
					                	 aryValueList.add(aryValue);
					                	 idx++;
					                 }
					             	    					
				    	             break;
	    				case "1":     			
	    				
			    					for(j=0;j<varValueX.size();j++) {
			    	                    if(pRs.get("TBLNO").equals(varValueX.get(j).get("SEQ"))){
			    	                    	break;
			    	                    }
			    					 }
			    					 fldNoX= pRs.get("FLDNO").toString();
			    	                 xValue = varValueX.get(j).get("TVALUE" + (Integer.parseInt(fldNoX))).toString();
			    					
				    				 for(j=0;j<varValueY.size();j++) {
				    					 if(pRs.get("B_TBLNO").equals(varValueY.get(j).get("SEQ"))){
				    	                    	break;
				    	                 }
				    				 }
				    				 fldNoY= pRs.get("B_TBLNO").toString();
				    	             yValue = varValueY.get(j).get("TVALUE" + (Integer.parseInt(fldNoY))).toString();
				    	             
				    	             String xBit = GetBitVal(xValue, pRs.get("IOBIT").toString());
				    	             String yBit = GetBitVal(yValue, pRs.get("IOBIT").toString());
				    	             
				    	             
				    	             if(Double.parseDouble(xBit) != Double.parseDouble(yBit)) {
				    	            	 
				    	            	 Map aryValue = new HashMap();
				    	            	 aryValue.put("INDEX", idx);
					                	 aryValue.put("LOOPNAME", pRs.get("LOOPNAME"));
					                	 aryValue.put("TBLNO", pRs.get("TBLNO"));
					                	 aryValue.put("FLDNO", pRs.get("FLDNO"));
					                	 aryValue.put("IOBIT", pRs.get("IOBIT"));
					                	 aryValue.put("ADDRESS", pRs.get("ADDRESS"));
					                	 
					                	 aryValue.put("xValue", xBit);
					                	 aryValue.put("yValue", yBit);
					                	 
					                	 aryValue.put("UNIT", pRs.get("UNIT"));					                	 
					                	 aryValue.put("BSCAL", pRs.get("BSCAL"));					                	 
					                	 aryValue.put("B_TBLNO", pRs.get("B_TBLNO"));
					                	 aryValue.put("B_FLDNO", pRs.get("B_FLDNO"));
					                	 aryValue.put("DESCR", pRs.get("DESCR"));
					                	 
					                	 aryValue.put("WIBA", pRs.get("WIBA"));
					                	 aryValue.put("B_WIBA", pRs.get("B_WIBA"));
					                	 
					                	 aryValueList.add(aryValue);	
					                	 idx++;
				    	             }
	    	             
	    							break;   							
	    				case "2": 
	    					
			    					for(j=0;j<varValueX.size();j++) {
			    	                    if(pRs.get("TBLNO").equals(varValueX.get(j).get("SEQ"))){
			    	                    	break;
			    	                    }
			    					}
			    					fldNoX= pRs.get("FLDNO").toString();
			    	                xValue = varValueX.get(j).get("TVALUE" + (Integer.parseInt(fldNoX))).toString();
			    					
				    				for(j=0;j<varValueY.size();j++) {
				    					 if(pRs.get("B_TBLNO").equals(varValueY.get(j).get("SEQ"))){
				    	                    	break;
				    	                 }
				    				}
				    				fldNoY= pRs.get("B_TBLNO").toString();
				    	            yValue = varValueY.get(j).get("TVALUE" + (Integer.parseInt(fldNoY))).toString();
	    					
				    	            if(Double.parseDouble(xValue) <= -32768 ||  Double.parseDouble(yValue) <= -32768) {
				    	            	
				    	            	 Map aryValue = new HashMap();
				    	            	 aryValue.put("INDEX", idx);
				    	            	 aryValue.put("LOOPNAME", pRs.get("LOOPNAME"));
					                	 aryValue.put("TBLNO", pRs.get("TBLNO"));
					                	 aryValue.put("FLDNO", pRs.get("FLDNO"));
					                	 aryValue.put("IOBIT", "");
					                	 aryValue.put("ADDRESS", pRs.get("ADDRESS"));
					                	 
					                	 aryValue.put("xValue", xValue);
					                	 aryValue.put("yValue", yValue);
					                	 
					                	 aryValue.put("UNIT", pRs.get("UNIT"));					                	 
					                	 aryValue.put("BSCAL", pRs.get("BSCAL"));					                	 
					                	 aryValue.put("B_TBLNO", pRs.get("B_TBLNO"));
					                	 aryValue.put("B_FLDNO", pRs.get("B_FLDNO"));
					                	 aryValue.put("DESCR", pRs.get("DESCR"));
					                	 
					                	 aryValue.put("WIBA", pRs.get("WIBA"));
					                	 aryValue.put("B_WIBA", pRs.get("B_WIBA"));
					                	 
					                	 aryValueList.add(aryValue);
					                	 idx++;
				    	            }
	    					
	    							break;
				}// end switch
			}//  end for  pRsList     	
			//*** END RETURN  aryValueList
			
			mav.addObject("AryValueList", aryValueList);
			mav.addObject("PageCnt", (pRsListTotalCnt/30) + 1);
			mav.addObject("PageTotal", pRsListTotalCnt);
			
    	} // end iotype             	
		
	}
	
	@RequestMapping("scm")
	public ModelAndView scm(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ scm");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));        	
        }
        
        return mav;
	}
	
	@RequestMapping("requiredsafevar")
	public ModelAndView requiredsafevar(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ requiredsafevar");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	if(dccSearchPerformance.getsMenuNo() == null || dccSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	dccSearchPerformance.setsDive("D");
	        	dccSearchPerformance.setsMenuNo("44");
	        	dccSearchPerformance.setsGrpID("mimic");
	        	dccSearchPerformance.setsUGrpNo("3");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
	        	dccSearchPerformance.setsXYGubun(member.getXyGubun());
	        	
        	}
        	
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("xyGubun",dccSearchPerformance.getsXYGubun()==null?  "": dccSearchPerformance.getsXYGubun());
    		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

        	Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
        	
        	List<Map> lblDataList = (ArrayList)dccVal.get("lblDataList");
        	
        	String SteamData_1 = "";
        	String SteamData_0 = "";
        	Map lblSCM = new HashMap();
        	double fValue;
        	
        	for(int i=0;i<4;i++) {        		
        		
        		if(lblDataList.get(32 + i * 2).get("fValue").equals("***IRR")) {
        			SteamData_1 = "***IRR";
        		}else {
        			 fValue = Double.parseDouble(lblDataList.get(32 + i * 2).get("fValue").toString());
 				     SteamData_1 = (fValue > -32768? String.format(gFormat[tagDccInfoList.get(i).getBScale()], fValue) : "***IRR");
        		}
        		
        		if(lblDataList.get(32 + i * 2 + 1).get("fValue").equals("***IRR")) {
        			lblSCM.put(i, "***IRR");
        		}else {
			            fValue = Double.parseDouble(lblDataList.get(32 + i * 2 + 1).get("fValue").toString());
			            SteamData_0 = (fValue > -32768? String.format(gFormat[tagDccInfoList.get(i).getBScale()], fValue) : "***IRR");
			            double vSCM = getSaturationMargin(Double.parseDouble(SteamData_1), Double.parseDouble(SteamData_0));
			            lblSCM.put("idx" + i,(vSCM > -32768? String.format("%.3f", vSCM): "***IRR"));

        		}
        		
        	}
        	
        	
        	mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", lblDataList);
        	mav.addObject("lblSCM", lblSCM);
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	//'- SCM값을 계산한다.
	private double getSaturationMargin(double pressure, double temperature) {
		
		double saturationTemp = 0;
		double saturationMargin = 0;
		
		double[] TempTable = new double[276];
		
	    TempTable[0] = 95.01;
	    TempTable[1] = 96.63;
	    TempTable[2] = 98.17;
	    TempTable[3] = 99.64;
	    TempTable[4] = 101.05;
	    TempTable[5] = 101.42;
	    TempTable[6] = 102.4;
	    TempTable[7] = 103.71;
	    TempTable[8] = 104.96;
	    TempTable[9] = 106.17;
	    TempTable[10] = 107.33;
	    TempTable[11] = 108.46;
	    TempTable[12] = 109.56;
	    TempTable[13] = 110.62;
	    TempTable[14] = 111.65;
	    TempTable[15] = 112.65;
	    TempTable[16] = 113.63;
	    TempTable[17] = 114.58;
	    TempTable[18] = 115.5;
	    TempTable[19] = 116.41;
	    TempTable[20] = 117.29;
	    TempTable[21] = 118.15;
	    TempTable[22] = 118.99;
	    TempTable[23] = 119.81;
	    TempTable[24] = 120.62;
	    TempTable[25] = 121.41;
	    TempTable[26] = 122.18;
	    TempTable[27] = 122.94;
	    TempTable[28] = 123.68;
	    TempTable[29] = 124.41;
	    TempTable[30] = 125.13;
	    TempTable[31] = 125.83;
	    TempTable[32] = 126.52;
	    TempTable[33] = 127.2;
	    TempTable[34] = 127.87;
	    TempTable[35] = 128.52;
	    TempTable[36] = 129.17;
	    TempTable[37] = 129.81;
	    TempTable[38] = 130.43;
	    TempTable[39] = 131.05;
	    TempTable[40] = 131.65;
	    TempTable[41] = 132.25;
	    TempTable[42] = 132.84;
	    TempTable[43] = 133.42;
	    TempTable[44] = 134;
	    TempTable[45] = 134.56;
	    TempTable[46] = 135.12;
	    TempTable[47] = 135.67;
	    TempTable[48] = 136.21;
	    TempTable[49] = 136.75;
	    TempTable[50] = 137.28;
	    TempTable[51] = 137.8;
	    TempTable[52] = 138.32;
	    TempTable[53] = 138.83;
	    TempTable[54] = 139.34;
	    TempTable[55] = 139.83;
	    TempTable[56] = 140.33;
	    TempTable[57] = 140.82;
	    TempTable[58] = 141.3;
	    TempTable[59] = 141.77;
	    TempTable[60] = 142.25;
	    TempTable[61] = 142.71;
	    TempTable[62] = 143.17;
	    TempTable[63] = 143.63;
	    TempTable[64] = 144.08;
	    TempTable[65] = 144.53;
	    TempTable[66] = 145.41;
	    TempTable[67] = 146.28;
	    TempTable[68] = 147.13;
	    TempTable[69] = 147.96;
	    TempTable[70] = 148.78;
	    TempTable[71] = 149.58;
	    TempTable[72] = 150.37;
	    TempTable[73] = 151.14;
	    TempTable[74] = 151.91;
	    TempTable[75] = 152.66;
	    TempTable[76] = 153.4;
	    TempTable[77] = 154.12;
	    TempTable[78] = 154.84;
	    TempTable[79] = 155.54;
	    TempTable[80] = 156.24;
	    TempTable[81] = 156.92;
	    TempTable[82] = 157.6;
	    TempTable[83] = 158.27;
	    TempTable[84] = 158.92;
	    TempTable[85] = 159.57;
	    TempTable[86] = 160.21;
	    TempTable[87] = 160.84;
	    TempTable[88] = 161.46;
	    TempTable[89] = 162.08;
	    TempTable[90] = 162.69;
	    TempTable[91] = 163.29;
	    TempTable[92] = 163.88;
	    TempTable[93] = 164.47;
	    TempTable[94] = 165.05;
	    TempTable[95] = 165.62;
	    TempTable[96] = 166.19;
	    TempTable[97] = 166.75;
	    TempTable[98] = 167.3;
	    TempTable[99] = 167.85;
	    
	    TempTable[100] = 168.39;
	    TempTable[101] = 168.93;
	    TempTable[102] = 169.46;
	    TempTable[103] = 169.98;
	    TempTable[104] = 170.5;
	    TempTable[105] = 171.02;
	    TempTable[106] = 171.53;
	    TempTable[107] = 172.03;
	    TempTable[108] = 172.53;
	    TempTable[109] = 173.03;
	    TempTable[110] = 173.52;
	    TempTable[111] = 174;
	    TempTable[112] = 174.48;
	    TempTable[113] = 174.96;
	    TempTable[114] = 175.44;
	    TempTable[115] = 175.9;
	    TempTable[116] = 176.37;
	    TempTable[117] = 176.83;
	    TempTable[118] = 177.29;
	    TempTable[119] = 177.74;
	    TempTable[120] = 178.19;
	    TempTable[121] = 178.63;
	    TempTable[122] = 179.08;
	    TempTable[123] = 179.51;
	    TempTable[124] = 179.95;
	    TempTable[125] = 180.38;
	    TempTable[126] = 181.23;
	    TempTable[127] = 182.07;
	    TempTable[128] = 182.9;
	    TempTable[129] = 183.71;
	    TempTable[130] = 184.52;
	    TempTable[131] = 185.31;
	    TempTable[132] = 186.09;
	    TempTable[133] = 186.86;
	    TempTable[134] = 187.62;
	    TempTable[135] = 188.37;
	    TempTable[136] = 189.11;
	    TempTable[137] = 189.84;
	    TempTable[138] = 190.56;
	    TempTable[139] = 191.27;
	    TempTable[140] = 191.97;
	    TempTable[141] = 192.67;
	    TempTable[142] = 193.35;
	    TempTable[143] = 194.03;
	    TempTable[144] = 194.7;
	    TempTable[145] = 195.37;
	    TempTable[146] = 196.02;
	    TempTable[147] = 196.67;
	    TempTable[148] = 197.31;
	    TempTable[149] = 197.95;
	    TempTable[150] = 198.58;
	    TempTable[151] = 200.12;
	    TempTable[152] = 201.63;
	    TempTable[153] = 203.1;
	    TempTable[154] = 204.53;
	    TempTable[155] = 205.93;
	    TempTable[156] = 207.3;
	    TempTable[157] = 208.65;
	    TempTable[158] = 209.96;
	    TempTable[159] = 211.25;
	    TempTable[160] = 212.51;
	    TempTable[161] = 213.75;
	    TempTable[162] = 214.96;
	    TempTable[163] = 216.16;
	    TempTable[164] = 217.33;
	    TempTable[165] = 218.48;
	    TempTable[166] = 219.61;
	    TempTable[167] = 220.72;
	    TempTable[168] = 221.82;
	    TempTable[169] = 222.89;
	    TempTable[170] = 223.95;
	    TempTable[171] = 226.03;
	    TempTable[172] = 228.04;
	    TempTable[173] = 229.99;
	    TempTable[174] = 231.9;
	    TempTable[175] = 233.75;
	    TempTable[176] = 235.55;
	    TempTable[177] = 237.31;
	    TempTable[178] = 239.03;
	    TempTable[179] = 240.71;
	    TempTable[180] = 242.36;
	    TempTable[181] = 243.96;
	    TempTable[182] = 245.54;
	    TempTable[183] = 247.08;
	    TempTable[184] = 248.59;
	    TempTable[185] = 250.07;
	    TempTable[186] = 251.52;
	    TempTable[187] = 252.95;
	    TempTable[188] = 254.35;
	    TempTable[189] = 255.72;
	    TempTable[190] = 257.08;
	    TempTable[191] = 258.4;
	    TempTable[192] = 259.71;
	    TempTable[193] = 261;
	    TempTable[194] = 262.26;
	    TempTable[195] = 263.51;
	    TempTable[196] = 264.74;
	    TempTable[197] = 265.95;
	    TempTable[198] = 267.14;
	    TempTable[199] = 268.31;

	    TempTable[200] = 269.47;
	    TempTable[201] = 270.61;
	    TempTable[202] = 271.74;
	    TempTable[203] = 272.85;
	    TempTable[204] = 273.95;
	    TempTable[205] = 275.03;
	    TempTable[206] = 276.1;
	    TempTable[207] = 277.15;
	    TempTable[208] = 278.2;
	    TempTable[209] = 279.23;
	    TempTable[210] = 280.25;
	    TempTable[211] = 281.25;
	    TempTable[212] = 282.25;
	    TempTable[213] = 283.23;
	    TempTable[214] = 284.2;
	    TempTable[215] = 285.16;
	    TempTable[216] = 286.11;
	    TempTable[217] = 287.06;
	    TempTable[218] = 287.99;
	    TempTable[219] = 288.91;
	    TempTable[220] = 289.82;
	    TempTable[221] = 290.72;
	    TempTable[222] = 291.62;
	    TempTable[223] = 292.5;
	    TempTable[224] = 293.38;
	    TempTable[225] = 294.24;
	    TempTable[226] = 295.1;
	    TempTable[227] = 295.95;
	    TempTable[228] = 296.8;
	    TempTable[229] = 297.63;
	    TempTable[230] = 298.46;
	    TempTable[231] = 299.28;
	    TempTable[232] = 300.09;
	    TempTable[233] = 300.9;
	    TempTable[234] = 301.7;
	    TempTable[235] = 302.49;
	    TempTable[236] = 303.28;
	    TempTable[237] = 304.05;
	    TempTable[238] = 304.83;
	    TempTable[239] = 305.59;
	    TempTable[240] = 306.35;
	    TempTable[241] = 307.1;
	    TempTable[242] = 307.85;
	    TempTable[243] = 308.59;
	    TempTable[244] = 309.33;
	    TempTable[245] = 310.06;
	    TempTable[246] = 310.78;
	    TempTable[247] = 311.5;
	    TempTable[248] = 312.21;
	    TempTable[249] = 312.92;
	    TempTable[250] = 313.62;
	    TempTable[251] = 314.32;
	    TempTable[252] = 315.01;
	    TempTable[253] = 315.7;
	    TempTable[254] = 316.38;
	    TempTable[255] = 317.06;
	    TempTable[256] = 317.73;
	    TempTable[257] = 318.4;
	    TempTable[258] = 319.06;
	    TempTable[259] = 319.72;
	    TempTable[260] = 320.38;
	    TempTable[261] = 321.03;
	    TempTable[262] = 321.67;
	    TempTable[263] = 322.31;
	    TempTable[264] = 322.95;
	    TempTable[265] = 323.58;
	    TempTable[266] = 324.21;
	    TempTable[267] = 324.83;
	    TempTable[268] = 325.45;
	    TempTable[268] = 326.07;
	    TempTable[270] = 326.68;
	    TempTable[271] = 327.29;
	    TempTable[272] = 327.9;
	    TempTable[273] = 328.5;
	    TempTable[274] = 329.09;
	    TempTable[275] = 329.69;
		
		Map rtnMap = getPressIndex(pressure);
		
		int idx = Integer.parseInt(rtnMap.get("idx").toString());		
		double PressTableVal = Double.parseDouble(rtnMap.get("value").toString());
		double PressTableVal2 = Double.parseDouble(rtnMap.get("value2").toString());
		
		if(idx == -1) {
			saturationMargin= -9999;
		}else {
			saturationTemp = TempTable[idx] + (pressure - PressTableVal) * (TempTable[idx + 1] - TempTable[idx]) / (PressTableVal2 - PressTableVal);
			saturationMargin = saturationTemp - temperature;			
		}	
		
		return saturationMargin;
		
	}
	
	private Map getPressIndex(Double pressure) {
		
		int totalCnt;
		
		Map rtnMap = new HashMap();
		
		double[] PressTable = new double[276];
		DecimalFormat df = new DecimalFormat("#.###");
		
		// '- Pressure Table값 생성
		for(int i=0;i<276;i++) {
			if(i == 5) {
				PressTable[i] = 0.101325;
			}else if(i <= 4) { 
				PressTable[i] = Double.parseDouble(String.format("%.3f", 0.08 + (i * 0.005)));
			}else if(i > 4 && i <= 65) { 
				PressTable[i] = Double.parseDouble(String.format("%.3f", 0.08 + ((i-1) * 0.005)));
			}else if(i > 65 && i <= 125) { 
				PressTable[i] = Double.parseDouble(String.format("%.3f", PressTable[i-1] + 0.01));
			}else if(i > 125 && i <= 150) { 
				PressTable[i] = Double.parseDouble(String.format("%.3f", PressTable[i-1] + 0.02));
			}else if(i > 150 && i <= 170) { 
				PressTable[i] = Double.parseDouble(String.format("%.3f", PressTable[i-1] + 0.05));
			}else if(i > 170 && i <= 275) { 
				PressTable[i] = Double.parseDouble(String.format("%.3f", PressTable[i-1] + 0.1));
			}			
		}
		
		int tolCnt = PressTable.length;
		
		pressure =  Double.parseDouble(String.format("%.2f", pressure));
	
		if((pressure < PressTable[0]) || (pressure >= PressTable[tolCnt-1])) { 
	        rtnMap.put("idx", -1);
	        rtnMap.put("value", -1);
            rtnMap.put("value2", -1);
		}else {
			boolean chk = false;
			for(int i=0;i<tolCnt;i++) {
				if((pressure >= PressTable[i]) && (pressure < PressTable[i + 1])) {
	               chk = true;
	               
	               rtnMap.put("idx", i);
	               rtnMap.put("value", PressTable[i]);
	               rtnMap.put("value2", PressTable[i+1]);
	               break;
	            }
	        }

			if(!chk) {
				rtnMap.put("idx", -1);
		        rtnMap.put("value", -1);
	            rtnMap.put("value2", -1);
			}
		}		 
		
		return rtnMap;		
	}
	
	@RequestMapping("dccselfcheck")
	public ModelAndView dccselfcheck(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ dccselfcheck");
        
        double[] vPOT = {-4.9,	4.9,	-1.25,		1.25,		2.5,	-4.9, 1.25,	4.9,	-0.5,	0.5,	-4.9,	1.25,	-1.25,		2.5};
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchPerformance.setMenuName(this.menuName);        	
        	
        	if(dccSearchPerformance.getsMenuNo() == null || dccSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	dccSearchPerformance.setsDive("D");
	        	dccSearchPerformance.setsMenuNo("91");
	        	dccSearchPerformance.setsGrpID("admin");
	        	dccSearchPerformance.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
	        	dccSearchPerformance.setsXYGubun(member.getXyGubun());	        	
        	}
        	
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
    		        	
        	//VB : ScreenInit
    		dccGrpTagSearchMap.put("xyGubun","X");
    		List<ComTagDccInfo> tagDccInfoXList = basDccMimicService.getDccGrpTagList(dccGrpTagSearchMap);
        	
        	//VB : timer  
        	Map dccValX = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoXList);
        	
        	List<Map> lblDataXList = (ArrayList)dccValX.get("lblDataList");
        	List<Map> shpDataXList = new ArrayList<Map>();
        	
        	if(lblDataXList != null && lblDataXList.size() > 0){

        		for(int i=26;i<=67;i++) {
	        		
	        		Map lblDataX = lblDataXList.get(i);
	        		lblDataX.put("ForeColor", "#80000012");
	        		
	        		int iPos = (i - 26);
	        		int iPot = 0;
	     			if((iPos % 3) == 0) {
	     				iPot = iPos / 3;
	     			}
	     			
	     			Map shpDataX = new HashMap();
	     			String lblDataXfValue = lblDataX.get("fValue") != null? lblDataX.get("fValue").toString():"";
	     			if(StringUtils.isNumeric(lblDataXfValue)) {
	     				if(Math.abs(vPOT[iPot]) - Double.parseDouble(lblDataXfValue) >= 0.004 && Math.abs(vPOT[iPot]) - Double.parseDouble(lblDataXfValue) <= 0.005) {
	     					shpDataX.put("BackColor", "#80FFFF");
	     				}else if(Math.abs(vPOT[iPot]) - Double.parseDouble(lblDataXfValue) > 0.005) {
	     					shpDataX.put("BackColor", "#8080FF");
	     				}else {
	     					shpDataX.put("BackColor", "#FFFFFF");
	     				}
	     			}else {
	     				shpDataX.put("BackColor", "#FFFFFF");
	     			}
	     			
	     			shpDataXList.add(shpDataX);     			
	        	} // end for
        		
        	}else {
        		
        		if(lblDataXList == null) {
        			lblDataXList = new ArrayList<Map>();
        		}
        		
        		for(int i=0;i<=74;i++) {
        			Map lblDataX = new HashMap();
        			lblDataX.put("fValue", "0");
        			
        			lblDataXList.add(lblDataX);
        		}
        		
        		for(int i=0;i<=41;i++) {
        			Map shpDataX = new HashMap();
        			shpDataX.put("BackColor", "#FFFFFF");
        			
        			shpDataXList.add(shpDataX);   
        		}
        	}
        	
        	//VB : ScreenInit
        	dccGrpTagSearchMap.put("xyGubun","Y");
    		List<ComTagDccInfo> tagDccInfoYList = basDccMimicService.getDccGrpTagList(dccGrpTagSearchMap);
        	
        	//VB : timer  
        	Map dccValY = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoYList);
        	
        	List<Map> lblDataYList = (ArrayList)dccValY.get("lblDataList");
        	List<Map> shpDataYList = new ArrayList<Map>();
        	
        	if(lblDataYList != null && lblDataYList.size() > 0){
        	
	        	for(int i=26;i<67;i++) {
	        		
	     			Map lblDataY = lblDataYList.get(i);
	        		lblDataY.put("ForeColor", "#80000012");
	        		
	        		int iPos = (i - 26);
	        		int iPot = 0;
	     			if((iPos % 3) == 0) {
	     				iPot = iPos / 3;
	     			}
	     			
	     			Map shpDataY = new HashMap();
	     			String lblDataYfValue = lblDataY.get("fValue") != null? lblDataY.get("fValue").toString():"";
	     			if(StringUtils.isNumeric(lblDataYfValue)) {
	     				if(Math.abs(vPOT[iPot]) - Double.parseDouble(lblDataYfValue) >= 0.004 && Math.abs(vPOT[iPot]) - Double.parseDouble(lblDataYfValue) <= 0.005) {
	     					shpDataY.put("BackColor", "#80FFFF");
	     				}else if(Math.abs(vPOT[iPot]) - Double.parseDouble(lblDataYfValue) > 0.005) {
	     					shpDataY.put("BackColor", "#8080FF");
	     				}else {
	     					shpDataY.put("BackColor", "#FFFFFF");
	     				}
	     			}else {
	     				shpDataY.put("BackColor", "#FFFFFF");
	     			}
	     			
	     			shpDataYList.add(shpDataY);     			
	        	} // end for
	        	
        	}else {
        		
        		if(lblDataYList == null) {
        			lblDataYList = new ArrayList<Map>();
        		}
        		
        		for(int i=0;i<=74;i++) {
        			Map lblDataY = new HashMap();
        			lblDataY.put("fValue", "0");
        			
        			lblDataYList.add(lblDataY);
        		}
        		
        		for(int i=0;i<=41;i++) {
        			Map shpDataY = new HashMap();
        			shpDataY.put("BackColor", "#FFFFFF");
        			
        			shpDataYList.add(shpDataY);   
        		}
        		
        	}
        	
        	mav.addObject("XSearchTime", dccValX.get("SearchTime"));
        	mav.addObject("XForeColor", dccValX.get("ForeColor"));
        	mav.addObject("lblDataXList", lblDataXList);
        	mav.addObject("shpDataXList", shpDataXList);
        	
        	mav.addObject("YSearchTime", dccValY.get("SearchTime"));
        	mav.addObject("YForeColor", dccValY.get("ForeColor"));
        	mav.addObject("lblDataYList", lblDataYList);
        	mav.addObject("shpDataYList", shpDataYList);
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("mainsysiostatus")
	public ModelAndView mainsysiostatus(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ mainsysiostatus");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	if(dccSearchPerformance.getsMenuNo() == null || dccSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	dccSearchPerformance.setsDive("D");
	        	dccSearchPerformance.setsMenuNo("91");
	        	dccSearchPerformance.setsGrpID("admin");
	        	dccSearchPerformance.setsUGrpNo("2");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
	        	dccSearchPerformance.setsXYGubun(member.getXyGubun());	        	
        	}
        	
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
    		        	
        	//VB : ScreenInit--X
    		dccGrpTagSearchMap.put("xyGubun","X");
        	List<ComTagDccInfo> tagDccInfoXList = basDccMimicService.getDccGrpTagList(dccGrpTagSearchMap);
        	
        	//VB : timer--X
        	Map dccValX = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoXList);
        	
        	//VB : ScreenInit--Y
        	dccGrpTagSearchMap.put("xyGubun","Y");
        	List<ComTagDccInfo> tagDccInfoYList = basDccMimicService.getDccGrpTagList(dccGrpTagSearchMap);
        	
        	//VB : timer--Y
        	Map dccValY = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoYList);
        	
        	mav.addObject("XSearchTime", dccValX.get("SearchTime"));
        	mav.addObject("XForeColor", dccValX.get("ForeColor"));
        	mav.addObject("lblDataXList", dccValX.get("lblDataList"));
        	
        	mav.addObject("YSearchTime", dccValY.get("SearchTime"));
        	mav.addObject("YForeColor", dccValY.get("ForeColor"));
        	mav.addObject("lblDataYList", dccValY.get("lblDataList"));
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("dccstatus")
	public ModelAndView dccstatus(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ dccstatus");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }
        
        return mav;
        
	}
	
	@RequestMapping("programonoff")
	public ModelAndView programonoff(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();
		
		int[]  vHS = { 0	 , 5 , 6 , 11 , 16 , 21 , 26 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 39 , 40 , 41 , 42};

        logger.info("############ programonoff");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	if(dccSearchPerformance.getsMenuNo() == null || dccSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	dccSearchPerformance.setsDive("D");
	        	dccSearchPerformance.setsMenuNo("91");
	        	dccSearchPerformance.setsGrpID("admin");
	        	dccSearchPerformance.setsUGrpNo("4");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
	        	dccSearchPerformance.setsXYGubun(member.getXyGubun());	        	
        	}
        	
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
    		        	
        	//VB : ScreenInit--X
    		dccGrpTagSearchMap.put("xyGubun","X");
        	List<ComTagDccInfo> tagDccInfoXList = basDccMimicService.getDccGrpTagList(dccGrpTagSearchMap);
        	
        	//VB : timer--X
        	Map dccValX = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoXList);
        	
        	List<Map> lblDataXList = (ArrayList)dccValX.get("lblDataList");
        	List<Map> shpDataXList = new ArrayList<Map>();
        	
        	if(lblDataXList != null && lblDataXList.size() > 0){
        	
	        	for(int i=0;i<vHS.length;i++) {
	        		
	        		Map shpDataX = new HashMap();
	        	
	        		if(vHS[i] == 0 || vHS[i] == 6 || vHS[i] == 11 || vHS[i] == 16 || vHS[i] == 21 || vHS[i] == 34 || vHS[i] == 42) {
	        			
	        			// lblDataX type casting part
	            		int[] lblDataX = new int[5];
	            		for(int j=0;j<lblDataX.length;j++) {
	            			Map lblData= lblDataXList.get(vHS[i] + j);
	            			
	            			String lblDataValue = lblData.get("fValue") != null? lblData.get("fValue").toString():"";
	            			
	            			if(StringUtils.isNumeric(lblDataValue)) {
	            				lblDataX[j] = (int) Math.round (Double.parseDouble(lblDataValue));
	            			}else {
	            				lblDataX[j] = 0;
	            			}            			
	            		}
	            		
	            		// bit 연산관련
	            		if((lblDataX[0] & lblDataX[1] & lblDataX[2] & lblDataX[3] & lblDataX[4]) == 1) {
	            			shpDataX.put("BackColor", "#80FF80");
	            		}else if(lblDataX[0] == 0 && (lblDataX[1] & lblDataX[2] & lblDataX[3] & lblDataX[4]) == 0) {
	            			shpDataX.put("BackColor", "#FFFFFF");
	            		}else {
	            			shpDataX.put("BackColor", "#8080FF");
	            		}
	
	               }else {
	            	   
	            		Map lblData= lblDataXList.get(vHS[i]);
	            		String lblDataValue = lblData.get("fValue") != null? lblData.get("fValue").toString():"";
	            		if(StringUtils.isNumeric(lblDataValue)) {
	        				int lblDataX = (int) Math.round (Double.parseDouble(lblDataValue));
	        				if(lblDataX == 1) {
	        					shpDataX.put("BackColor", "#80FF80");
	        				}else {
	        					shpDataX.put("BackColor", "#8080FF");
	        				}
	        			}else {
	        				shpDataX.put("BackColor", "#8080FF");
	        			}            			
	               }
	     			shpDataXList.add(shpDataX);     			
	        	} // end for
        	}
        	
        	
        	//VB : ScreenInit--Y
        	dccGrpTagSearchMap.put("xyGubun","Y");
        	List<ComTagDccInfo> tagDccInfoYList = basDccMimicService.getDccGrpTagList(dccGrpTagSearchMap);
        	
        	//VB : timer --Y
        	Map dccValY = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoYList);
        	
        	List<Map> lblDataYList = (ArrayList)dccValY.get("lblDataList");
        	List<Map> shpDataYList = new ArrayList<Map>();
        	
        	if(lblDataYList != null && lblDataYList.size() > 0){
        	
	        	for(int i=0;i<vHS.length;i++) {
	        		
	        		Map shpDataY = new HashMap();
	        	
	        		if(vHS[i] == 0 || vHS[i] == 6 || vHS[i] == 11 || vHS[i] == 16 || vHS[i] == 21 || vHS[i] == 34 || vHS[i] == 42) {
	        			
	        			// lblDataY type casting part
	            		int[] lblDataY = new int[5];
	            		for(int j=0;j<lblDataY.length;j++) {
	            			Map lblData= lblDataYList.get(vHS[i] + j);
	            			
	            			String lblDataValue = lblData.get("fValue") != null? lblData.get("fValue").toString():"";
	            			
	            			if(StringUtils.isNumeric(lblDataValue)) {
	            				lblDataY[j] = (int) Math.round (Double.parseDouble(lblDataValue));
	            			}else {
	            				lblDataY[j] = 0;
	            			}            			
	            		}
	            		
	            		// bit 연산관련
	            		if((lblDataY[0] & lblDataY[1] & lblDataY[2] & lblDataY[3] & lblDataY[4]) == 1) {
	            			shpDataY.put("BackColor", "#80FF80");
	            		}else if(lblDataY[0] == 0 && (lblDataY[1] & lblDataY[2] & lblDataY[3] & lblDataY[4]) == 0) {
	            			shpDataY.put("BackColor", "#FFFFFF");
	            		}else {
	            			shpDataY.put("BackColor", "#8080FF");
	            		}
	
	               }else {
	            	   
	            		Map lblData= lblDataYList.get(vHS[i]);
	            		String lblDataValue = lblData.get("fValue") != null? lblData.get("fValue").toString():"";
	            		if(StringUtils.isNumeric(lblDataValue)) {
	        				int lblDataY = (int) Math.round (Double.parseDouble(lblDataValue));
	        				if(lblDataY == 1) {
	        					shpDataY.put("BackColor", "#80FF80");
	        				}else {
	        					shpDataY.put("BackColor", "#8080FF");
	        				}
	        			}else {
	        				shpDataY.put("BackColor", "#8080FF");
	        			}            			
	               }
	     			shpDataYList.add(shpDataY);     			
	        	} // end for
        	}
        	
        	mav.addObject("XSearchTime", dccValX.get("SearchTime"));
        	mav.addObject("XForeColor", dccValX.get("ForeColor"));
        	mav.addObject("lblDataXList", lblDataXList);
        	mav.addObject("shpDataXList", shpDataXList);
        	
        	mav.addObject("YSearchTime", dccValY.get("SearchTime"));
        	mav.addObject("YForeColor", dccValY.get("ForeColor"));        	
        	mav.addObject("lblDataYList", lblDataYList);
        	mav.addObject("shpDataYList", shpDataYList);        	
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        

        return mav;
    }
	
	@RequestMapping("aicheck")
	public ModelAndView aicheck(DccSearchPerformance dccSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ aicheck");
        
        double[] vPOT = {-4.9,	4.9,	-1.25,		1.25,		2.5,	-4.9, 1.25,	4.9,	-0.5,	0.5,	-4.9,	1.25,	-1.25,		2.5};
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
        	if(dccSearchPerformance.getsMenuNo() == null || dccSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	dccSearchPerformance.setsDive("D");
	        	dccSearchPerformance.setsMenuNo("91");
	        	dccSearchPerformance.setsGrpID("admin");
	        	dccSearchPerformance.setsUGrpNo("7");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
	        	dccSearchPerformance.setsXYGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("hogi",dccSearchPerformance.getsHogi()==null?  "": dccSearchPerformance.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchPerformance.getsDive()==null?  "": dccSearchPerformance.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchPerformance.getsGrpID()==null?  "": dccSearchPerformance.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchPerformance.getsMenuNo()==null?  "": dccSearchPerformance.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
    		     
        	
        	//VB : ScreenInit--X
    		dccGrpTagSearchMap.put("xyGubun","X");
        	List<ComTagDccInfo> tagDccInfoXList = basDccMimicService.getDccGrpTagList(dccGrpTagSearchMap);
        	
        	//VB : timer--X 
        	Map dccValX = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoXList);
        	
        	List<Map> lblDataXList = (ArrayList)dccValX.get("lblDataList");
        	List<Map> shpDataXList = new ArrayList<Map>();
        	
        	if(lblDataXList != null && lblDataXList.size() > 0) {
        	
	        	for(int i=0;i<lblDataXList.size();i++) {
	        		
	        		Map lblDataX = lblDataXList.get(i);
	        		lblDataX.put("ForeColor", "#80000012");
	        		
	        		int iPot = 0;
	     			if((i % 3) == 0) {
	     				iPot = i / 3;
	     			}
	     			
	     			Map shpDataX = new HashMap();
	     			String lblDataXfValue = lblDataX.get("fValue") != null? lblDataX.get("fValue").toString():"";
	     			if(StringUtils.isNumeric(lblDataXfValue)) {
	     				if(Math.abs(vPOT[iPot]) - Double.parseDouble(lblDataXfValue) >= 0.004 && Math.abs(vPOT[iPot]) - Double.parseDouble(lblDataXfValue) <= 0.005) {
	     					shpDataX.put("BackColor", "#80FFFF");
	     				}else if(Math.abs(vPOT[iPot]) - Double.parseDouble(lblDataXfValue) > 0.005) {
	     					shpDataX.put("BackColor", "#8080FF");
	     				}else {
	     					shpDataX.put("BackColor", "#FFFFFF");
	     				}
	     			}else {
	     				shpDataX.put("BackColor", "#FFFFFF");
	     			}
	     			
	     			shpDataXList.add(shpDataX);     			
	        	} // end for
        	}else {
        		lblDataXList = new ArrayList<Map>();
        	}
        	
        	mav.addObject("XSearchTime", dccValX.get("SearchTime"));
        	mav.addObject("XForeColor", dccValX.get("ForeColor"));
        	mav.addObject("lblDataXList", lblDataXList);
        	mav.addObject("shpDataXList", shpDataXList);
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
          

        return mav;
    }
	
}
