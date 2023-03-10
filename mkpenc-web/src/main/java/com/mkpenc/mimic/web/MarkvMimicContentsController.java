package com.mkpenc.mimic.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.admin.model.MemberInfo;
import com.mkpenc.common.model.ComTagMarkInfo;
import com.mkpenc.common.service.BasCommonService;
import com.mkpenc.common.service.BasMarkMimicService;
import com.mkpenc.common.service.BasMarkOsmsService;
import com.mkpenc.mimic.model.MarkvSearchMimic;

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
    		
    		Map markVal = basMarkOsmsService.getMarkValue(markGrpTagSearchMap, tagMarkInfoList, mav);
    		
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

	
	@RequestMapping("tbnoverview")
	public ModelAndView tbnoverview(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ tbnoverview");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
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
        		
        		markvSearchMimic.setsMenuNo("4");
        		markvSearchMimic.setsGrpID("mimic");
        		markvSearchMimic.setsScreenId("1");
        		//markvSearchMimic.setsDive("D");
        		//markvSearchMimic.setsUGrpNo("1");
	        	
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

        	List<ComTagMarkInfo> tagMarkvInfoList = basMarkOsmsService.getMarkGrpTagList(markvGrpTagSearchMap);
        	
        	Map markvVal = basMarkOsmsService.getMarkValue(markvGrpTagSearchMap, tagMarkvInfoList, mav);
        	
        	String[][] tAnalogChar = basMarkMimicService.AnalogCharacter();
        	
        	mav.addObject("SearchTime", markvVal.get("SearchTime"));
        	mav.addObject("ForeColor", markvVal.get("ForeColor"));
        	mav.addObject("lblDataList", markvVal.get("lblDataList"));
        	
        	mav.addObject("BasvbseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	mav.addObject("AnalogChar", tAnalogChar);
        	
        }

        return mav;
    }		
	
	@RequestMapping("fasolenoids")
	public ModelAndView fasolenoids(MarkvSearchMimic markvSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ fasolenoids");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	markvSearchMimic.setMenuName(this.menuName);
        	
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
        	
        	mav.addObject("BaseSearch", markvSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
}
