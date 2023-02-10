package com.mkpenc.performance.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.admin.model.DccSearchAdmin;
import com.mkpenc.admin.model.MemberInfo;
import com.mkpenc.admin.service.DccAdminService;
import com.mkpenc.common.model.ComTagDccInfo;
import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.common.module.StringUtil;
import com.mkpenc.common.service.BasCommonService;
import com.mkpenc.common.service.BasDccMimicService;
import com.mkpenc.common.service.BasDccOsmsService;
import com.mkpenc.performance.model.DccSearchPerformance;
import com.mkpenc.performance.model.GroupNameInfo;
import com.mkpenc.performance.service.DccPerformanceService;

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
		grpSearchMap.put("uGrpNo", dccSearchPerformance.getsUGrpNo()==null?  "": dccSearchPerformance.getsUGrpNo());
				
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
    				
    				if(rtnMap.get("minTvalue") != null) {
    					tagDccInfo.setSpareMinFldNo(rtnMap.get("minTvalue").toString());
    				}else {
    					tagDccInfo.setSpareMinFldNo("");
    				}
    				
    				if(rtnMap.get("maxTvalue") != null) {
    					tagDccInfo.setSpareMaxFldNo(rtnMap.get("maxTvalue").toString());
    				}else {
    					tagDccInfo.setSpareMaxFldNo("");
    				}
    				
    				if(rtnMap.get("avgTvalue") != null) {
    					tagDccInfo.setSpareAvgFldNo(rtnMap.get("avgTvalue").toString());
    				}else {
    					tagDccInfo.setSpareAvgFldNo("");
    				}
    				
    				if(rtnMap.get("stdevTvalue") != null) {
    					tagDccInfo.setSpareStdevFldNo(rtnMap.get("stdevTvalue").toString());
    				}else {
    					tagDccInfo.setSpareStdevFldNo("");
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
    				
    				if(rtnMap.get("minTvalue") != null) {
    					tagDccInfo.setFixedMinFldNo(rtnMap.get("minTvalue").toString());
    				}else {
    					tagDccInfo.setFixedMinFldNo("");
    				}
    				
    				if(rtnMap.get("maxTvalue") != null) {
    					tagDccInfo.setFixedMaxFldNo(rtnMap.get("maxTvalue").toString());
    				}else {
    					tagDccInfo.setFixedMaxFldNo("");
    				}
    				
    				if(rtnMap.get("avgTvalue") != null) {
    					tagDccInfo.setFixedAvgFldNo(rtnMap.get("avgTvalue").toString());
    				}else {
    					tagDccInfo.setFixedAvgFldNo("");
    				}
    				
    				if(rtnMap.get("stdevTvalue") != null) {
    					tagDccInfo.setFixedStdevFldNo(rtnMap.get("stdevTvalue").toString());
    				}else {
    					tagDccInfo.setFixedStdevFldNo("");
    				}       
    			}
    			
    			if( tagDccInfo.getSpareAvgFldNo() != null && !tagDccInfo.getSpareAvgFldNo().equals("") &&
    					tagDccInfo.getFixedAvgFldNo() != null && !tagDccInfo.getFixedAvgFldNo().equals("")) {
    				     			
    				  double gapAB = Double.parseDouble(tagDccInfo.getFixedAvgFldNo()) - Double.parseDouble(tagDccInfo.getSpareAvgFldNo());
    				  tagDccInfo.setGapAB(String.format(gFormat[tagDccInfo.getBScale()], gapAB));
    				  
    				  if( tagDccInfo.getGapAB() != null && tagDccInfo.getGapAB().equals("") &&
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
		String rtn = "";
		
		if(iVal == null) {
	       return rVal;
		}
		
		if(Integer.parseInt(rVal) < -9999999) {
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
			if(rVal.equals("-32768")) {
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
					return String.format(gFormat[tagDccInfo.getBScale()], rVal);
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
	    
	    di_val = Long.parseLong(digitalValue);
	    bit_no = Integer.parseInt(digitalBit);;

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
        	
        	if(dccSearchPerformance.getsPer() == null || dccSearchPerformance.getsPer().isEmpty()) {
        		dccSearchPerformance.setsPer("2");
        	}
        	
        	if(dccSearchPerformance.getsHogi() == null || dccSearchPerformance.getsHogi().isEmpty()){
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
        	}
        	
        	// XYGubun = "X", "Y"
        	dccSearchPerformance.setsIOType("0");
        	getCompareXY(dccSearchPerformance, mav);
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
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
        	
        	if(dccSearchPerformance.getsPer() == null || dccSearchPerformance.getsPer().isEmpty()) {
        		dccSearchPerformance.setsPer("2");
        	}
        	
        	if(dccSearchPerformance.getsHogi() == null || dccSearchPerformance.getsHogi().isEmpty()){
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchPerformance.setsHogi(member.getHogi());
        	}
        	
        	// XYGubun = "3"
        	dccSearchPerformance.setsIOType("2");
        	getCompareXY(dccSearchPerformance, mav);
        	
        	dccSearchPerformance.setMenuName(this.menuName);
        	
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
				   pSCanTimeX = format1.format(date);

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
				    				 fldNoY= pRs.get("B_TBLNO").toString();
				    	             yValue = varValueY.get(j).get("TVALUE" + (Integer.parseInt(fldNoY))).toString();
				    	                 
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
				    	             
				    	             
				    	             if(Double.parseDouble(xBit) > Double.parseDouble(yBit)) {
				    	            	 
				    	            	 Map aryValue = new HashMap();
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

        	Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
        	
        	mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	
        	mav.addObject("BaseSearch", dccSearchPerformance);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
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
        	Map dccValX = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoXList, mav);
        	
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
        	Map dccValY = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoYList,  mav);
        	
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
        	Map dccValX = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoXList, mav);
        	
        	//VB : ScreenInit--Y
        	dccGrpTagSearchMap.put("xyGubun","Y");
        	List<ComTagDccInfo> tagDccInfoYList = basDccMimicService.getDccGrpTagList(dccGrpTagSearchMap);
        	
        	//VB : timer--Y
        	Map dccValY = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoYList, mav);
        	
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
        	Map dccValX = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoXList, mav);
        	
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
        	Map dccValY = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoYList, mav);
        	
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
        	Map dccValX = basDccMimicService.getDccValue(dccGrpTagSearchMap, tagDccInfoXList,  mav);
        	
        	List<Map> lblDataXList = (ArrayList)dccValX.get("lblDataList");
        	List<Map> shpDataXList = new ArrayList<Map>();
        	
        	if(lblDataXList != null && lblDataXList.size() > 0) {
        	
	        	for(int i=0;i<=lblDataXList.size();i++) {
	        		
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
