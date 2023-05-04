package com.mkpenc.mark.performance.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.common.module.StringUtil;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.mark.common.model.ComTagMarkInfo;
import com.mkpenc.mark.common.service.BasMarkOsmsService;
import com.mkpenc.mark.performance.model.MarkvSearchPerformance;
import com.mkpenc.mark.performance.service.MarkvPerformanceService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/markv/performance/")
public class MarkvPerformanceContentsController {

	private static Logger logger = LoggerFactory.getLogger(MarkvPerformanceContentsController.class);
	
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
	
	private String menuName = "PERFORMANCE";
	
	@Autowired
	 private CommonConstant commonConstant;	
	
	@Autowired	
	private BasMarkOsmsService basMarkOsmsService;
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired
	private MarkvPerformanceService markvPerfornamceService;
	
	@RequestMapping("fixed")
	public ModelAndView fixed(MarkvSearchPerformance markvSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ fixed");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchPerformance.setMenuName(this.menuName);
        	
        	if(markvSearchPerformance.getsMenuNo() == null || markvSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	markvSearchPerformance.setsDive("M");
	        	markvSearchPerformance.setsMenuNo("41");
	        	markvSearchPerformance.setsGrpID("CompareVar");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchPerformance.setsHogi(member.getHogi());
	        	markvSearchPerformance.setsXYGubun(member.getXyGubun());
	        	
	        	getMainPerformance(markvSearchPerformance, mav);    
        	}
        	
        	mav.addObject("BaseSearch", markvSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("spare")
	public ModelAndView spare(MarkvSearchPerformance markvSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ spare");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchPerformance.setMenuName(this.menuName);
        	
        	if(markvSearchPerformance.getsMenuNo() == null || markvSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	markvSearchPerformance.setsDive("M");
	        	markvSearchPerformance.setsMenuNo("42");
	        	markvSearchPerformance.setsGrpID("CompareVar");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchPerformance.setsHogi(member.getHogi());
	        	markvSearchPerformance.setsXYGubun(member.getXyGubun());
	        	
	        	markvSearchPerformance.setsGrpID(member.getId());
	        	
	        	getMainPerformance(markvSearchPerformance, mav);    
        	}
        	
        	mav.addObject("BaseSearch", markvSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping(value = "getMarkGrpTag", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView getMarkGrpTag(MarkvSearchPerformance markvSearchPerformance, HttpServletRequest request) {
		
			logger.info("############ getDccGrpTag");
		            
			ModelAndView mav = new ModelAndView("jsonView");
			
			Map markvGrpTagSearchMap = new HashMap();
			markvGrpTagSearchMap.put("xyGubun",markvSearchPerformance.getsXYGubun()==null?  "": markvSearchPerformance.getsXYGubun());
			markvGrpTagSearchMap.put("hogi",markvSearchPerformance.getsHogi()==null?  "": markvSearchPerformance.getsHogi());
			markvGrpTagSearchMap.put("dive",markvSearchPerformance.getsDive()==null?  "": markvSearchPerformance.getsDive());
			markvGrpTagSearchMap.put("grpID", markvSearchPerformance.getsGrpID()==null?  "": markvSearchPerformance.getsGrpID());
			markvGrpTagSearchMap.put("menuNo", markvSearchPerformance.getsMenuNo()==null?  "": markvSearchPerformance.getsMenuNo());
			markvGrpTagSearchMap.put("uGrpNo", markvSearchPerformance.getsUGrpNo()==null?  "": markvSearchPerformance.getsUGrpNo());
			
			List<ComTagMarkInfo> tagMarkvInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
			
			mav.addObject("TagMarkvInfoList", tagMarkvInfoList);
			mav.addObject("BaseSearch", markvSearchPerformance);        	
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
		
			return mav;
	}	
	
	@RequestMapping("compare34")
	public ModelAndView compare34(MarkvSearchPerformance markvSearchPerformance, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ compare34");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(markvSearchPerformance.getsMenuNo() == null || markvSearchPerformance.getsMenuNo().isEmpty()) {
            	
	        	markvSearchPerformance.setsDive("M");
	        	markvSearchPerformance.setsMenuNo("43");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchPerformance.setsHogi(member.getHogi());
	        	markvSearchPerformance.setsXYGubun(member.getXyGubun());
	        	
	        	markvSearchPerformance.setsGrpID(member.getId());
        	}
        	        	
        	
        	Map grpSearchMap = new HashMap();
    		grpSearchMap.put("dive",markvSearchPerformance.getsDive()==null?  "": markvSearchPerformance.getsDive());
    		grpSearchMap.put("grpID", markvSearchPerformance.getsGrpID()==null?  "": markvSearchPerformance.getsGrpID());
    		grpSearchMap.put("menuNo", markvSearchPerformance.getsMenuNo()==null?  "": markvSearchPerformance.getsMenuNo());
    		grpSearchMap.put("uGrpNo", markvSearchPerformance.getsUGrpNo()==null?  "": markvSearchPerformance.getsUGrpNo());
    		
        	List<Map> grpNameList = basCommonService.selectGrpNameList(grpSearchMap);
        	
        	if(markvSearchPerformance.getsUGrpNo() != null && !markvSearchPerformance.getsUGrpNo().isEmpty()) {
        		
        		Map markGrpTagSearchMap = new HashMap();
        		markGrpTagSearchMap.put("xyGubun",markvSearchPerformance.getsXYGubun()==null?  "": markvSearchPerformance.getsXYGubun());
        		markGrpTagSearchMap.put("hogi",markvSearchPerformance.getsHogi()==null?  "": markvSearchPerformance.getsHogi());
        		markGrpTagSearchMap.put("dive",markvSearchPerformance.getsDive()==null?  "": markvSearchPerformance.getsDive());
        		markGrpTagSearchMap.put("grpID", markvSearchPerformance.getsGrpID()==null?  "": markvSearchPerformance.getsGrpID());
        		markGrpTagSearchMap.put("menuNo", markvSearchPerformance.getsMenuNo()==null?  "": markvSearchPerformance.getsMenuNo());
        		markGrpTagSearchMap.put("uGrpNo", markvSearchPerformance.getsUGrpNo()==null?  "": markvSearchPerformance.getsUGrpNo());
        		
        		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
        		
        		mav.addObject("TagMarkInfoList", tagMarkInfoList);
        	}
        	
        	markvSearchPerformance.setMenuName(this.menuName);
        	
        	mav.addObject("GroupNameList", grpNameList);
        	mav.addObject("BaseSearch", markvSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping(value = "runtimer34", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView runtimer34(MarkvSearchPerformance markSearchPerformance, HttpServletRequest request) {
		
		logger.info("############ runtimer34");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		if(markSearchPerformance.getsUGrpNo() != null && !markSearchPerformance.getsUGrpNo().isEmpty()) {
    		
    		Map markGrpTagSearchMap = new HashMap();
    		markGrpTagSearchMap.put("xyGubun",markSearchPerformance.getsXYGubun()==null?  "": markSearchPerformance.getsXYGubun());
    		markGrpTagSearchMap.put("hogi",markSearchPerformance.getsHogi()==null?  "": markSearchPerformance.getsHogi());
    		markGrpTagSearchMap.put("dive",markSearchPerformance.getsDive()==null?  "": markSearchPerformance.getsDive());
    		markGrpTagSearchMap.put("grpID", markSearchPerformance.getsGrpID()==null?  "": markSearchPerformance.getsGrpID());
    		markGrpTagSearchMap.put("menuNo", markSearchPerformance.getsMenuNo()==null?  "": markSearchPerformance.getsMenuNo());
    		markGrpTagSearchMap.put("uGrpNo", markSearchPerformance.getsUGrpNo()==null?  "": markSearchPerformance.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markGrpTagSearchMap);
    		
    		mav.addObject("TagMarkInfoList", tagMarkInfoList);
    		
    		markGrpTagSearchMap.put("hogi","3");
    		String[] varValue3 =  basMarkOsmsService.getMarkValueReturn(markGrpTagSearchMap);

    		markGrpTagSearchMap.put("hogi","4");
    		String[] varValue4 =  basMarkOsmsService.getMarkValueReturn(markGrpTagSearchMap);
    		
    		List<Map> markTagList = new ArrayList<Map>();
    		
    		int iRow = 0;
    		for(ComTagMarkInfo tagMarkInfo:tagMarkInfoList) {
    			
    			Map rtnMap = new HashMap();
    			
    			rtnMap.put("IOTYPE", tagMarkInfo.getIOTYPE());
    			
    			if(tagMarkInfo.getIOTYPE().equals("DI") || tagMarkInfo.getIOTYPE().equals("DO")) {
    				//rtnMap.put("ADDRESS", tagMarkInfo.getADDRESS()  + "-" +  tagMarkInfo.getIOTYPE());
    			}else {
    				//rtnMap.put("ADDRESS", tagMarkInfo.getADDRESS());    				
    			}
    			
    			//rtnMap.put("DataLoop", tagMarkInfo.getDataLoop());
    			rtnMap.put("Descr", tagMarkInfo.getDescr());
    			
    			if(varValue3.length > 1) {
    				
    				if(StringUtil.isNumeric(varValue3[iRow + 1])){
    					
    					if(tagMarkInfo.getIOTYPE().equals("DI") || tagMarkInfo.getIOTYPE().equals("DO")) {
    	    				rtnMap.put("Value_3", basCommonService.GetBitVal(varValue3[iRow + 1], ""+tagMarkInfo.getIOBIT()));
    					}else if(tagMarkInfo.getIOTYPE().equals("DI")){
    						rtnMap.put("Value_3", varValue3[iRow + 1]);
    					}else {
    	    				rtnMap.put("Value_3", String.format(gFormat[tagMarkInfo.getBScale()], varValue3[iRow + 1])); 		
    	    			}    					
    				}    				
    			}
    			
    			if(varValue4.length > 1) {
    				
    				if(StringUtil.isNumeric(varValue4[iRow + 1])){
    					
    					if(tagMarkInfo.getIOTYPE().equals("DI") || tagMarkInfo.getIOTYPE().equals("DO")) {
    	    				rtnMap.put("Value_4", basCommonService.GetBitVal(varValue4[iRow + 1], ""+tagMarkInfo.getIOBIT()));
    					}else if(tagMarkInfo.getIOTYPE().equals("DI")){
    						rtnMap.put("Value_4", varValue4[iRow + 1]);
    					}else {
    						rtnMap.put("Value_4", String.format(gFormat[tagMarkInfo.getBScale()], varValue4[iRow + 1])); 		
    	    			}    					
    				}    	
    			}
    			
    			//rtnMap.put("Unit", basCommonService.getUnit());
    			
    			markTagList.add(rtnMap);
    		}
    		
    		mav.addObject("MarkTagList", markTagList);
    	}

		mav.addObject("BaseSearch", markSearchPerformance);        	
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

		return mav;
	}		
	
	private void getMainPerformance(MarkvSearchPerformance markvSearchPerformance, ModelAndView mav ) {
		
		Map grpSearchMap = new HashMap();
		grpSearchMap.put("dive",markvSearchPerformance.getsDive()==null?  "": markvSearchPerformance.getsDive());
		grpSearchMap.put("grpID", markvSearchPerformance.getsGrpID()==null?  "": markvSearchPerformance.getsGrpID());
		grpSearchMap.put("menuNo", markvSearchPerformance.getsMenuNo()==null?  "": markvSearchPerformance.getsMenuNo());
		//grpSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
				
		List<Map> grpNameList = basCommonService.selectGrpNameList(grpSearchMap);
    	mav.addObject("GroupNameList", grpNameList);
    	
    	if(markvSearchPerformance.getsUGrpNo() != null && !markvSearchPerformance.getsUGrpNo().isEmpty()) {
    		
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("xyGubun",markvSearchPerformance.getsXYGubun()==null?  "": markvSearchPerformance.getsXYGubun());
    		dccGrpTagSearchMap.put("hogi",markvSearchPerformance.getsHogi()==null?  "": markvSearchPerformance.getsHogi());
    		dccGrpTagSearchMap.put("dive",markvSearchPerformance.getsDive()==null?  "": markvSearchPerformance.getsDive());
    		dccGrpTagSearchMap.put("grpID", markvSearchPerformance.getsGrpID()==null?  "": markvSearchPerformance.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", markvSearchPerformance.getsMenuNo()==null?  "": markvSearchPerformance.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", markvSearchPerformance.getsUGrpNo()==null?  "": markvSearchPerformance.getsUGrpNo());
    		
    		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(dccGrpTagSearchMap);
    		
    		for(ComTagMarkInfo tagMarkInfo:tagMarkInfoList) {
    			
    			Map searchMap = new HashMap();
    			
    			searchMap.put("fldno", tagMarkInfo.getFLDNO());
    			searchMap.put("hogi", markvSearchPerformance.getsHogi());
    			searchMap.put("tblno", tagMarkInfo.getTBLNO());
    			searchMap.put("chkHogi", markvSearchPerformance.getsChkHogi());
    			
    			searchMap.put("mskSpareS", markvSearchPerformance.getMskSpareS());
    			searchMap.put("mskSpareE", markvSearchPerformance.getMskSpareE());
    			
    			Map rtnMapA = markvPerfornamceService.selectTrendInfoA(searchMap);
    			
    			if(rtnMapA != null) {
    				
    				if(rtnMapA.get("avgTvalue") != null) {
    					tagMarkInfo.setSpareAvgFldNo(methodMark(rtnMapA.get("avgTvalue").toString(), tagMarkInfo) );
    				}else {
    					tagMarkInfo.setSpareAvgFldNo("");
    				}
    				
    				if(rtnMapA.get("stdevTvalue") != null) {
    					tagMarkInfo.setSpareStdevFldNo(methodMark(rtnMapA.get("stdevTvalue").toString(), tagMarkInfo));
    				}else {
    					tagMarkInfo.setSpareStdevFldNo("");
    				}
    				
    				if(rtnMapA.get("maxTvalue") != null) {
    					tagMarkInfo.setSpareMaxFldNo(methodMark(rtnMapA.get("maxTvalue").toString(), tagMarkInfo));
    				}else {
    					tagMarkInfo.setSpareMaxFldNo("");
    				}
    				
    				if(rtnMapA.get("minTvalue") != null) {
    					tagMarkInfo.setSpareMinFldNo(methodMark(rtnMapA.get("minTvalue").toString(), tagMarkInfo));
    				}else {
    					tagMarkInfo.setSpareMinFldNo("");
    				}
    				
    			} // if rtnMapA
    			
    			searchMap.put("mskFixedS", markvSearchPerformance.getMskFixedS());
    			searchMap.put("mskFixedE", markvSearchPerformance.getMskFixedE());
    			
    			Map rtnMapB = markvPerfornamceService.selectTrendInfoB(searchMap);
    			
    			if(rtnMapB != null) {
    				
    				if(rtnMapB.get("avgTvalue") != null) {
    					tagMarkInfo.setFixedAvgFldNo(methodMark(rtnMapB.get("avgTvalue").toString(), tagMarkInfo) );
    				}else {
    					tagMarkInfo.setFixedAvgFldNo("");
    				}
    				
    				if(rtnMapB.get("stdevTvalue") != null) {
    					tagMarkInfo.setFixedStdevFldNo(methodMark(rtnMapB.get("stdevTvalue").toString(), tagMarkInfo));
    				}else {
    					tagMarkInfo.setFixedStdevFldNo("");
    				}
    				
    				if(rtnMapB.get("maxTvalue") != null) {
    					tagMarkInfo.setFixedMaxFldNo(methodMark(rtnMapB.get("maxTvalue").toString(), tagMarkInfo));
    				}else {
    					tagMarkInfo.setFixedMaxFldNo("");
    				}
    				
    				if(rtnMapB.get("minTvalue") != null) {
    					tagMarkInfo.setFixedMinFldNo(methodMark(rtnMapB.get("minTvalue").toString(), tagMarkInfo));
    				}else {
    					tagMarkInfo.setFixedMinFldNo("");
    				}
    				
    			} // end if rtnMapB
    			
    			if( tagMarkInfo.getSpareAvgFldNo() != null && !tagMarkInfo.getSpareAvgFldNo().equals("") && !tagMarkInfo.getSpareAvgFldNo().equals("***IRR") && 
						tagMarkInfo.getFixedAvgFldNo() != null && !tagMarkInfo.getFixedAvgFldNo().equals("") && !tagMarkInfo.getFixedAvgFldNo().equals("***IRR")) {
			 			
						double gapAB = Double.parseDouble(tagMarkInfo.getFixedAvgFldNo()) - Double.parseDouble(tagMarkInfo.getSpareAvgFldNo());
						tagMarkInfo.setGapAB(String.format(gFormat[tagMarkInfo.getBScale()], gapAB));
				
						if( tagMarkInfo.getGapAB() != null && !tagMarkInfo.getGapAB().equals("") &&
							  tagMarkInfo.getSpareAvgFldNo() != null && !tagMarkInfo.getSpareAvgFldNo().equals("")) {
						  
						  double rateAB = (Double.parseDouble(tagMarkInfo.getGapAB()) /  Double.parseDouble(tagMarkInfo.getSpareAvgFldNo())) * 100;
						  tagMarkInfo.setRateAB(String.format(gFormat[tagMarkInfo.getBScale()], rateAB));
						}else {
						  tagMarkInfo.setRateAB("");
						}
			}else {
						tagMarkInfo.setGapAB("");
						tagMarkInfo.setRateAB("");
			}
    			
    		} // // end for ComTagMarkInfo
    		
    		mav.addObject("TagMarkInfoList", tagMarkInfoList);
    		
    	}// end if UGrpNo
		
	}
		
	private String methodMark(String iVal, ComTagMarkInfo tagMarkInfo ) {
			
			String rVal = "";
			//String rtn = "";
			double fValue = 0.0f;
			
			if(iVal == null) {
		       return rVal;
			}
			
			if(Double.parseDouble(iVal) < -9999999) {
				return rVal;
			}else {
				if(tagMarkInfo.getIOTYPE().equals("PACKED") && !tagMarkInfo.getIOBIT().isEmpty()) {
					rVal = basCommonService.GetBitVal(iVal, tagMarkInfo.getIOBIT());
				}
				
				if(tagMarkInfo.getIOTYPE().equals("SIGN16")) {
					if (!iVal.isEmpty()) {
						fValue = Double.parseDouble(iVal) ;
						if(fValue> 32768) {
								fValue = (65535 - fValue) * -1;
						}
						fValue = fValue /  32768 * Double.parseDouble(tagMarkInfo.getGAIN()) + Double.parseDouble(tagMarkInfo.getOffset());
						
						rVal = fValue + "";
					}else {
						rVal = iVal;
					}
				}
			}
			
			if(rVal != null && !rVal.isEmpty()) {
				if(Double.parseDouble(rVal) > -32768) {
					if(tagMarkInfo.getIOTYPE().equals("PACKED")) {
						return rVal;
					}else {
						return String.format(gFormat[tagMarkInfo.getBScale()], Double.parseDouble(rVal));
					}				
				}else {
					return  "***IRR";
				}
			}else {
				return "";
			}		
	}
	
}
