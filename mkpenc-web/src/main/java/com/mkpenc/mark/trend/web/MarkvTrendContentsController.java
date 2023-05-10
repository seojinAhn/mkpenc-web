package com.mkpenc.mark.trend.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.mark.common.model.ComTagMarkInfo;
import com.mkpenc.mark.common.service.BasMarkOsmsService;
import com.mkpenc.mark.trend.model.MarkvSearchTrend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/markv/trend/")
public class MarkvTrendContentsController {
	
	private static Logger logger = LoggerFactory.getLogger(MarkvTrendContentsController.class);
	
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
	
	private String menuName = "TREND";
	
	@Autowired
	private BasMarkOsmsService basMarkOsmsService;
	
	@Autowired
	private BasCommonService basCommonService;
	
	@RequestMapping("realtimetrendfixed")
	public ModelAndView realtimetrendfixed(MarkvSearchTrend markvSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ realtimetrendfixed");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("realtimetrendspare")
	public ModelAndView realtimetrendspare(MarkvSearchTrend markvSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ realtimetrendspare");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchTrend.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", markvSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("logfixed")
	public ModelAndView logfixed(MarkvSearchTrend markvSearchTrend, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ logfixed");       
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchTrend.setMenuName(this.menuName);
        	
        	if(markvSearchTrend.getsMenuNo() == null || markvSearchTrend.getsMenuNo().isEmpty()) {
            	
				markvSearchTrend.setsDive("M");
        		markvSearchTrend.setsMenuNo("23");
        		markvSearchTrend.setsGrpID("Trend");
	        	markvSearchTrend.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchTrend.setsHogi(member.getHogi());
	        	markvSearchTrend.setsXYGubun(member.getXyGubun());	        	
        	}
			
        	getMainTrendLog(markvSearchTrend, mav);     
        	
        	mav.addObject("BaseSearch", markvSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("logshare")
	public ModelAndView logshare(MarkvSearchTrend markvSearchTrend, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ logshare");
		
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchTrend.setMenuName(this.menuName);
        	
        	if(markvSearchTrend.getsMenuNo() == null || markvSearchTrend.getsMenuNo().isEmpty()) {
            	
				markvSearchTrend.setsDive("M");
        		markvSearchTrend.setsMenuNo("23");
        		markvSearchTrend.setsGrpID("Trend");
	        	markvSearchTrend.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	markvSearchTrend.setsHogi(member.getHogi());
	        	markvSearchTrend.setsXYGubun(member.getXyGubun());
	        	
	        	markvSearchTrend.setsGrpID(member.getId());
        	}
        	
        	getMainTrendLog(markvSearchTrend, mav);   
        	
        	mav.addObject("BaseSearch", markvSearchTrend);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
              

        return mav;
    }
	
	private void getMainTrendLog(MarkvSearchTrend markvSearchTrend, ModelAndView mav ) {
		
		Map grpSearchMap = new HashMap();
		grpSearchMap.put("dive",markvSearchTrend.getsDive()==null?  "": markvSearchTrend.getsDive());
		grpSearchMap.put("grpID", markvSearchTrend.getsGrpID()==null?  "": markvSearchTrend.getsGrpID());
		grpSearchMap.put("menuNo", markvSearchTrend.getsMenuNo()==null?  "": markvSearchTrend.getsMenuNo());
				
		List<Map> grpNameList = basCommonService.selectGrpNameList(grpSearchMap);
    	mav.addObject("GroupNameList", grpNameList);
    	
    	Map markvGrpTagSearchMap = new HashMap();
    	markvGrpTagSearchMap.put("xyGubun",markvSearchTrend.getsXYGubun()==null?  "": markvSearchTrend.getsXYGubun());
    	markvGrpTagSearchMap.put("hogi",markvSearchTrend.getsHogi()==null?  "": markvSearchTrend.getsHogi());
		markvGrpTagSearchMap.put("dive",markvSearchTrend.getsDive()==null?  "": markvSearchTrend.getsDive());
		markvGrpTagSearchMap.put("grpID", markvSearchTrend.getsGrpID()==null?  "": markvSearchTrend.getsGrpID());
		markvGrpTagSearchMap.put("menuNo", markvSearchTrend.getsMenuNo()==null?  "": markvSearchTrend.getsMenuNo());
		markvGrpTagSearchMap.put("uGrpNo", markvSearchTrend.getsUGrpNo()==null?  "": markvSearchTrend.getsUGrpNo());
		
		List<ComTagMarkInfo> tagMarkInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
		
		Map markVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkInfoList);
		
		List<Map> lblDataList = (ArrayList)markVal.get("lblDataList");
		
		for(int i=0;i<lblDataList.size();i++) {
			lblDataList.get(i).put("unit", tagMarkInfoList.get(i).getUnit());
			lblDataList.get(i).put("desc", tagMarkInfoList.get(i).getDescr());
			
			if(tagMarkInfoList.get(i).getIOTYPE().equals("SIGN16")) {
				lblDataList.get(i).put("type", "AI");
			}else {
				lblDataList.get(i).put("type", "DI");
			}
						
			if(!tagMarkInfoList.get(i).getIOBIT().isEmpty()) {
				lblDataList.get(i).put("address", tagMarkInfoList.get(i).getUNIT_DIV() + " : " + tagMarkInfoList.get(i).getRegister() + " : " + tagMarkInfoList.get(i).getIOBIT());
			}else {
				lblDataList.get(i).put("address", tagMarkInfoList.get(i).getUNIT_DIV() + " : " + tagMarkInfoList.get(i).getRegister());
			}    					
		}		
		
		mav.addObject("TagMarkInfoList", tagMarkInfoList);    		
		mav.addObject("lblDataList", lblDataList);
    	
	}	

}
