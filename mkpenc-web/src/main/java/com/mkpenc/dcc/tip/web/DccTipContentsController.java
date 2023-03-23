package com.mkpenc.dcc.tip.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.model.SwSmInfo;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.dcc.tip.model.DccSearchTip;
import com.mkpenc.dcc.tip.service.DccTipService;
import com.mkpenc.dcc.tip.model.DccIoColumnInfo;
import com.mkpenc.dcc.tip.model.DccIolistInfo;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/tip/")
public class DccTipContentsController {

	private static Logger logger = LoggerFactory.getLogger(DccTipContentsController.class);
	
	private String menuName = "TIP";
	
	@Autowired
	private DccTipService dccTipService;
	
	@Autowired
	private ExcelHelperUtil excelHelperUtil;
	
	@RequestMapping("iolist")
	public ModelAndView iolist(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ iolist");
        
        if(dccSearchTip.getIoType() == null) dccSearchTip.setIoType("AI");
    	if( dccSearchTip.getHogiHeader() != null ) {
    		if( dccSearchTip.getiHogi() == null ) dccSearchTip.setiHogi(dccSearchTip.getHogiHeader());
    	} else {
    		if( dccSearchTip.getiHogi() == null ) dccSearchTip.setiHogi("3");
    	}
    	if( dccSearchTip.getXyHeader() != null ) {
    		if( dccSearchTip.getXyGubun() == null ) dccSearchTip.setXyGubun(dccSearchTip.getXyHeader());
    	} else {
    		if( dccSearchTip.getXyGubun() == null ) dccSearchTip.setXyGubun("X");
    	}
        	
        if(request.getSession().getAttribute("USER_INFO") != null) {
	        List<DccIolistInfo> iolistList = dccTipService.selectIoList(dccSearchTip);
	        List<DccIoColumnInfo> ioColumnList = dccTipService.selectIoColumnList(dccSearchTip);
	
	        mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
	        mav.addObject("DccIolistList", iolistList);
	        mav.addObject("DccIoColumnList", ioColumnList);
        }else {
        	mav.addObject("UserInfo", null);
        }

        return mav;
    }
	
	@RequestMapping("iolistModify")
	public ModelAndView iolistModify(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ iolistModify");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	System.out.println(dccSearchTip.getDescr());
	        
	        if(dccSearchTip.getiSeq() != null && !"".equals(dccSearchTip.getiSeq())) {
	        	int rtv = dccTipService.updateIolistInfo(dccSearchTip);
	        }
	
	        mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }else {
        	mav.addObject("UserInfo", null);
        }
        
        mav.setViewName("redirect:/dcc/tip/iolist");

        return mav;
    }
	
	@RequestMapping("iolistExcelExport")
	public void iolistExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchTip dccSearchTip) throws Exception {
		try{
	        List<DccIolistInfo> dccIolistList = dccTipService.selectIoListExcelDownload(dccSearchTip);
			
			excelHelperUtil.iolistExcelDownload(request, response, dccIolistList);		
			
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("sds1")
	public ModelAndView sds1(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sds1");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("sds2")
	public ModelAndView sds2(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sds2");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("setback")
	public ModelAndView setback(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ setback");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("stepback")
	public ModelAndView stepback(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ setback");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
	@RequestMapping("unclearoutput")
	public ModelAndView unclearoutput(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ unclearoutput");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }		
	
}
