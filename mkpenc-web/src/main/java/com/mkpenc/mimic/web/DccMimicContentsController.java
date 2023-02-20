package com.mkpenc.mimic.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.admin.model.MemberInfo;
import com.mkpenc.common.model.ComShowTagInfo;
import com.mkpenc.common.model.ComTagDccInfo;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.common.service.BasCommonService;
import com.mkpenc.common.service.BasDccMimicService;
import com.mkpenc.common.service.BasDccOsmsService;
import com.mkpenc.mimic.model.DccSearchMimic;
import com.mkpenc.status.model.DccMstTagInfo;
import com.mkpenc.status.model.DccSearchStatus;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchMimic.setsHogi(member.getHogi());
	        	dccSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
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

        logger.info("############ lzc_1");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchMimic.setsHogi(member.getHogi());
	        	dccSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		List<String> lblDataList = (List<String>) dccVal.get("lblDataList");    		
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
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
	        	dccSearchMimic.setsUGrpNo("2");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchMimic.setsHogi(member.getHogi());
	        	dccSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
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

        logger.info("############ lzc_1");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	dccSearchMimic.setMenuName(this.menuName);
        	
        	if(dccSearchMimic.getsMenuNo() == null || dccSearchMimic.getsMenuNo().isEmpty()) {
            	
        		dccSearchMimic.setsDive("D");
        		dccSearchMimic.setsMenuNo("1");
        		dccSearchMimic.setsGrpID("mimic");
        		dccSearchMimic.setsUGrpNo("2");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchMimic.setsHogi(member.getHogi());
	        	dccSearchMimic.setsXYGubun(member.getXyGubun());	        	
        	}
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchMimic.getsXYGubun()==null?  "": dccSearchMimic.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchMimic.getsHogi()==null?  "": dccSearchMimic.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchMimic.getsDive()==null?  "": dccSearchMimic.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchMimic.getsGrpID()==null?  "": dccSearchMimic.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchMimic.getsMenuNo()==null?  "": dccSearchMimic.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchMimic.getsUGrpNo()==null?  "": dccSearchMimic.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		List<String> lblDataList = (List<String>) dccVal.get("lblDataList");    		
    		String searchTime = (String) dccVal.get("SearchTime");

        	try {
				excelHelperUtil.mimicExcelDownload(request, response, lblDataList, tagDccInfoList, searchTime, "lzc_1");
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
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("phtctrl")
	public ModelAndView phtctrl(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ phtctrl");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("moderator")
	public ModelAndView moderator(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ moderator");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }			
	
	
	@RequestMapping("phtpuri")
	public ModelAndView phtpuri(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ phtpuri");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("ecc")
	public ModelAndView ecc(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ ecc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("mainsteam")
	public ModelAndView mainsteam(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ mainsteam");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("feedwater")
	public ModelAndView feedwater(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ feedwater");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("condensate")
	public ModelAndView condensate(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ condensate");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	
	@RequestMapping("fuelhandlingmenu")
	public ModelAndView fuelhandlingmenu(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ fuelhandlingmenu");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("d2octrla")
	public ModelAndView d2octrla(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ d2octrla");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("d2octrlc")
	public ModelAndView d2octrlc(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ d2octrlc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("radmain")
	public ModelAndView radmain(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ radmain");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("rbbase")
	public ModelAndView rbbase(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rbbase");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("rb1f")
	public ModelAndView rb1f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb1f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("rb2f")
	public ModelAndView rb2f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb2f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("rb3f")
	public ModelAndView rb3f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb3f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("rb4f")
	public ModelAndView rb4f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb4f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("rb5f")
	public ModelAndView rb5f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb4f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("sbbase")
	public ModelAndView sbbase(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sbbase");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
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
	
	public ModelAndView tagSearch(ModelAndView mav, DccSearchMimic dccSearchMimic, HttpServletRequest request) {

		List<ComShowTagInfo> dccTagSearchList = basDccMimicService.selectTagSearch(dccSearchMimic);
    	dccSearchMimic.setMenuName(this.menuName);
    	
    	mav.addObject("BaseSearch", dccSearchMimic);
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
    	mav.addObject("TagSearchInfo", dccTagSearchList);
    	
        return mav;
    }

	public ModelAndView tagFind(ModelAndView mav,DccSearchMimic dccSearchMimic, HttpServletRequest request) {

		List<ComShowTagInfo> dccTagFindList = basDccMimicService.selectTagFind(dccSearchMimic);
		dccSearchMimic.setMenuName(this.menuName);
		
		mav.addObject("BaseSearch", dccSearchMimic);
		mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
		mav.addObject("TagFindList", dccTagFindList);
        	
        return mav;
    }
	
	
}
