package com.mkpenc.alarm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.alarm.model.DccSearchAlarm;
import com.mkpenc.admin.model.MemberInfo;
import com.mkpenc.alarm.model.DccAlarmInfo;
import com.mkpenc.alarm.service.DccAlarmService;
import com.mkpenc.common.model.Upload;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.common.module.FileHelperUtil;
import com.mkpenc.common.module.PageHtmlUtil;
import com.mkpenc.tip.model.DccIolistInfo;

import static org.mockito.ArgumentMatchers.contains;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/alarm/")
public class DccAlarmContentsController {

	private static Logger logger = LoggerFactory.getLogger(DccAlarmContentsController.class);
	
	private String menuName = "ALARM";
	
	@Autowired
	private DccAlarmService dccAlarmService;
	
	@Autowired
	private PageHtmlUtil pageHtmlUtil;
	
	@Autowired
	private ExcelHelperUtil excelHelperUtil;

	@Autowired
	private FileHelperUtil fileHelperUtil;
	
	@RequestMapping("alarm")
	public ModelAndView alarm(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ alarm");

        LocalDateTime lDtmS = LocalDateTime.of(2022, 12, 1, 14, 19, 42);
        LocalDateTime lDtmE = LocalDateTime.of(2022, 12, 1, 14, 20, 44);
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        if( dccSearchAlarm.getStartDate() == null ) dccSearchAlarm.setStartDate(lDtmS.format(dtf));
        if( dccSearchAlarm.getEndDate() == null ) dccSearchAlarm.setEndDate(lDtmE.format(dtf));
        if( dccSearchAlarm.getCurrentPage() == null ) dccSearchAlarm.setCurrentPage("0");
    	if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun("X");
    	}
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	dccSearchAlarm.setMenuName(this.menuName);
        	String sSeq = "";
        	List<String> staticValues = new ArrayList<String>();
        	staticValues.add("0");
        	staticValues.add("1");
        	staticValues.add("-1");
        	staticValues.add("-9999");
        	if( staticValues.contains(dccSearchAlarm.getCurrentPage()) ) {
        		sSeq = dccAlarmService.selectAlarmSeq(dccSearchAlarm);
        	} else {
        		sSeq = dccAlarmService.selectAlarmSeqSp(dccSearchAlarm);
        	}
        	
        	dccSearchAlarm.setSeq(sSeq);
        	
        	List<DccAlarmInfo> dccAlarmInfoList = dccAlarmService.selectAlarmProc(dccSearchAlarm);

        	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
        	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
            
    		mav.addObject("DccAlarmList", dccAlarmInfoList);
        }
        return mav;
    }
	
	@RequestMapping("alarmTxtExport")
	public void alarmTxtExport(HttpServletRequest request, HttpServletResponse response, DccSearchAlarm dccSearchAlarm) throws Exception {
        try{
	        LocalDateTime lDtmS = LocalDateTime.of(2022, 12, 1, 14, 19, 42);
	        LocalDateTime lDtmE = LocalDateTime.of(2022, 12, 1, 14, 20, 44);
	        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        if( dccSearchAlarm.getStartDate() == null ) dccSearchAlarm.setStartDate(lDtmS.format(dtf));
	        if( dccSearchAlarm.getEndDate() == null ) dccSearchAlarm.setEndDate(lDtmE.format(dtf));
	        if( dccSearchAlarm.getCurrentPage() == null ) dccSearchAlarm.setCurrentPage("0");
	    	if( dccSearchAlarm.getHogiHeader() != null ) {
	    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi(dccSearchAlarm.getHogiHeader());
	    	} else {
	    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi("3");
	    	}
	    	if( dccSearchAlarm.getXyHeader() != null ) {
	    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun(dccSearchAlarm.getXyHeader());
	    	} else {
	    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun("X");
	    	}
	        
	        if(request.getSession().getAttribute("USER_INFO") != null) {
	        	
	        	if( dccSearchAlarm.getPagNo() != null ) {
		        	String sPagNo = dccSearchAlarm.getPagNo();
		        	int nfSeq = Integer.parseInt(sPagNo.substring(0,8));
		        	int nlSeq = Integer.parseInt(sPagNo.substring(9,sPagNo.length()))+1;
		        	sPagNo = String.valueOf(nfSeq)+String.valueOf(nlSeq);
		        	dccSearchAlarm.setPagNo(sPagNo);
	        	}
	        	
	        	String sSeq = "";
	        	List<String> staticValues = new ArrayList<String>();
	        	staticValues.add("0");
	        	staticValues.add("1");
	        	staticValues.add("-1");
	        	staticValues.add("-9999");
	        	if( staticValues.contains(dccSearchAlarm.getCurrentPage()) ) {
	        		sSeq = dccAlarmService.selectAlarmSeq(dccSearchAlarm);
	        	} else {
	        		sSeq = dccAlarmService.selectAlarmSeqSp(dccSearchAlarm);
	        	}
	        	
	        	dccSearchAlarm.setSeq(sSeq);

	        	List<DccAlarmInfo> dccAlarmInfoList = new ArrayList<DccAlarmInfo>();
	        	String contentStr = "";
	        	
	        	if( "S1".equals(dccSearchAlarm.getpType()) || "S3".equals(dccSearchAlarm.getpType()) ) {
	        		dccAlarmInfoList = dccAlarmService.selectAlarmProc(dccSearchAlarm);
	        		
	        		contentStr = dccSearchAlarm.getStartDate().substring(0,10)
		    				   +"   UNIT "+dccSearchAlarm.getHogi()+" DCC "+dccSearchAlarm.getXyGubun()
		    				   +"   Page "+(dccAlarmInfoList.size() > 0 ? dccAlarmInfoList.get(0).getPagNo() : "0")
		    				   +"   (total record : "+dccAlarmInfoList.size()+" )==SEP==";

	        		contentStr = contentStr + "==SEP==A/N    DATE        MESSAGE==SEP==";
	        		contentStr = contentStr
	        				   + "=== ============   ===================================================================SEP==";
	        	} else {
	        		dccAlarmInfoList = dccAlarmService.selectAlarmToExport(dccSearchAlarm);
	        		
	        		contentStr = contentStr + "A/N        DATE               MESSAGE==SEP==";
	        		contentStr = contentStr
	        				   + "=== =======================   ================================================================SEP==";
	        	}
	        	
	        	String filePath = dccSearchAlarm.getHogi()+dccSearchAlarm.getXyGubun()+"_ALARM.txt";
	        	for( DccAlarmInfo dccAlarmInfo : dccAlarmInfoList ) {
	        		int almMsegLine = Integer.parseInt(dccAlarmInfo.getAlmMesgLine());
	        		if( almMsegLine <= 1 ) {
	        			String almDtm = "";
	        			if( "S1".equals(dccSearchAlarm.getpType()) || "S3".equals(dccSearchAlarm.getpType()) ) {
	        				almDtm = dccAlarmInfo.getAlmTime() + (!"0".equals(dccAlarmInfo.getAlmMsecchk()) ? "   " : "       ");
	        			} else {
	        				almDtm = dccAlarmInfo.getAlmDate() + (!"0".equals(dccAlarmInfo.getAlmMsecchk()) ? "   " : "       ");
	        			}
		        		String almCode = dccAlarmInfo.getAlmCode();
		        		String almAddress = dccAlarmInfo.getAlmAddress();
		        		for( int ci=0;ci<4-dccAlarmInfo.getAlmCode().length();ci++ ) {
		        			almCode = almCode + " ";
		        		}
		        		for( int ai=0;ai<4-dccAlarmInfo.getAlmAddress().length();ai++ ) {
		        			almAddress = " " + almAddress;
		        		}
		        		contentStr = contentStr
		        				 + (!"X".equals(dccAlarmInfo.getAlmGubun()) ? " "+dccAlarmInfo.getAlmGubun() : "  ") + "  "
		        				 + almDtm
		        				 + almCode
		        				 + almAddress + "  "
		        				 + dccAlarmInfo.getAlmMesg()
		        				 + "==SEP==";
	        		} else {
	        			contentStr = contentStr + "==SEP==";
	        		}
	        	}
	        	String[] contents = contentStr.split("==SEP==");
	        	
	        	boolean write = false;
				try {
					write = fileHelperUtil.writeTxtFile(filePath, contents, this.menuName);
				} catch (Exception e) {
					logger.error(e.toString());
				}
	        	
	        	if( write ) {
		        	Upload upload = new Upload();
	        		upload.setDiv(this.menuName);
	        		upload.setFileRealName(filePath);
	        		
	        		fileHelperUtil.download(request, response, upload, "application/octet-stream");
	        		
	        		fileHelperUtil.deleteTxtFile(upload, filePath);
	        	}

	        }
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
    }
	
	@RequestMapping("alarmExcelExport")
	public void alarmExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchAlarm dccSearchAlarm) throws Exception {
        try{
            if( dccSearchAlarm.getCurrentPage() == null ) dccSearchAlarm.setCurrentPage("-9999");
            if( dccSearchAlarm.getAlarmGubun() == null ) dccSearchAlarm.setAlarmGubun("None");
        	if( dccSearchAlarm.getHogiHeader() != null ) {
        		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi(dccSearchAlarm.getHogiHeader());
        	} else {
        		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi("3");
        	}
        	if( dccSearchAlarm.getXyHeader() != null ) {
        		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun(dccSearchAlarm.getXyHeader());
        	} else {
        		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun("X");
        	}
	        
	        if(request.getSession().getAttribute("USER_INFO") != null) {
	        	
	        	List<DccAlarmInfo> dccAlarmInfoList = dccAlarmService.selectAlarmToExport(dccSearchAlarm);
	        	
	        	String title = "경보메시지 ("+dccSearchAlarm.getStartDate().substring(0,16)
	        				  +" ~ "+dccSearchAlarm.getEndDate().substring(0,16)+")";

				excelHelperUtil.alarmExcelDownload(request, response, dccSearchAlarm.getHogi()+dccSearchAlarm.getXyGubun(),
												title, dccAlarmInfoList, "alarmsearch");
	        	
	        }
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
    }
	
	@RequestMapping("alarmsearch")
	public ModelAndView alarmsearch(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ alarmsearch");

        LocalDateTime lDtmS = LocalDateTime.of(2022, 12, 1, 14, 19, 42);
        LocalDateTime lDtmE = LocalDateTime.of(2022, 12, 1, 14, 20, 44);
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        if( dccSearchAlarm.getEndDate() == null ) dccSearchAlarm.setEndDate(lDtmE.format(dtf));
        if( dccSearchAlarm.getStartDate() == null ) {
        	if( dccSearchAlarm.getEndDate() == null ) {
        		dccSearchAlarm.setStartDate(lDtmS.format(dtf));
        		dccSearchAlarm.setEndDate(lDtmE.format(dtf));
        	} else {
        		lDtmS = LocalDateTime.parse(dccSearchAlarm.getEndDate(),dtf).minusDays(3L);
        		dccSearchAlarm.setStartDate(lDtmS.format(dtf));
        	}
        }
        
        if( dccSearchAlarm.getCurrentPage() == null ) dccSearchAlarm.setCurrentPage("-9999");
        if( dccSearchAlarm.getAlarmGubun() == null ) dccSearchAlarm.setAlarmGubun("None");
    	if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun("X");
    	}
    	
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	dccSearchAlarm.setMenuName(this.menuName);
        	int totalCnt = dccAlarmService.selectAlarmTotalCnt(dccSearchAlarm);
        	dccSearchAlarm.setTotalCnt(totalCnt);
        	
        	List<DccAlarmInfo> dccAlarmInfoList = dccAlarmService.selectAlarmToRecord(dccSearchAlarm);
        	
        	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
        	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
            
    		mav.addObject("DccAlarmList", dccAlarmInfoList);
        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(dccSearchAlarm));
        	
        }

        return mav;
    }
	
	@RequestMapping("summary")
	public ModelAndView summary(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ summary");
        
        LocalDateTime lDtmS = LocalDateTime.of(2022, 12, 1, 14, 19, 42);
        LocalDateTime lDtmE = LocalDateTime.of(2022, 12, 1, 14, 20, 44);
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        if( dccSearchAlarm.getStartDate() == null ) dccSearchAlarm.setStartDate(lDtmS.format(dtf));
        if( dccSearchAlarm.getEndDate() == null ) dccSearchAlarm.setEndDate(lDtmE.format(dtf));
        if( dccSearchAlarm.getCurrentPage() == null ) dccSearchAlarm.setCurrentPage("2");
    	if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun("X");
    	}
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	dccSearchAlarm.setMenuName(this.menuName);
        	String sSeq = dccAlarmService.selectSummarySeq(dccSearchAlarm);
        	if( sSeq == null ) sSeq = dccSearchAlarm.getCurrentPage();
        	dccSearchAlarm.setSeq(sSeq);
        	
        	List<DccAlarmInfo> dccAlarmInfoList = dccAlarmService.selectSummaryList(dccSearchAlarm);

        	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
        	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
            
    		mav.addObject("DccSummaryList", dccAlarmInfoList);
        }
        return mav;
    }
	
	@RequestMapping("summaryTxtExport")
	public void summaryTxtExport(HttpServletRequest request, HttpServletResponse response, DccSearchAlarm dccSearchAlarm) throws Exception {
        try{
	        LocalDateTime lDtmS = LocalDateTime.of(2022, 12, 1, 14, 19, 42);
	        LocalDateTime lDtmE = LocalDateTime.of(2022, 12, 1, 14, 20, 44);
	        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        if( dccSearchAlarm.getStartDate() == null ) dccSearchAlarm.setStartDate(lDtmS.format(dtf));
	        if( dccSearchAlarm.getEndDate() == null ) dccSearchAlarm.setEndDate(lDtmE.format(dtf));
	        if( dccSearchAlarm.getCurrentPage() == null ) dccSearchAlarm.setCurrentPage("0");
	    	if( dccSearchAlarm.getHogiHeader() != null ) {
	    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi(dccSearchAlarm.getHogiHeader());
	    	} else {
	    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setHogi("3");
	    	}
	    	if( dccSearchAlarm.getXyHeader() != null ) {
	    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun(dccSearchAlarm.getXyHeader());
	    	} else {
	    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setXyGubun("X");
	    	}
	        
	        if(request.getSession().getAttribute("USER_INFO") != null) {
	        	
//	        	if( dccSearchAlarm.getPagNo() != null ) {
//		        	String sPagNo = dccSearchAlarm.getPagNo();
//		        	int nfSeq = Integer.parseInt(sPagNo.substring(0,8));
//		        	int nlSeq = Integer.parseInt(sPagNo.substring(9,sPagNo.length()))+1;
//		        	sPagNo = String.valueOf(nfSeq)+String.valueOf(nlSeq);
//		        	dccSearchAlarm.setPagNo(sPagNo);
//	        	}
	        	
	        	String sSeq = dccAlarmService.selectSummarySeq(dccSearchAlarm);
	        	dccSearchAlarm.setSeq(sSeq);

	        	List<DccAlarmInfo> dccSummaryInfoList = new ArrayList<DccAlarmInfo>();
	        	String contentStr = "";
	        	
        		dccSummaryInfoList = dccAlarmService.selectSummaryList(dccSearchAlarm);
        		
        		contentStr = dccSearchAlarm.getStartDate().substring(0,10)
	    				   +"   UNIT "+dccSearchAlarm.getHogi()+" DCC "+dccSearchAlarm.getXyGubun()
	    				   +"   Page "+(dccSummaryInfoList.size() > 0 ? dccSummaryInfoList.get(0).getPagNo() : "0")
	    				   +"   (total record : "+dccSummaryInfoList.size()+" )==SEP==";

        		contentStr = contentStr + "==SEP==A/N    DATE        MESSAGE==SEP==";
        		contentStr = contentStr
        				   + "=== ============   ===================================================================SEP==";
	        	
	        	String filePath = dccSearchAlarm.getHogi()+dccSearchAlarm.getXyGubun()+"_SUMMARY.txt";
	        	for( DccAlarmInfo dccAlarmInfo : dccSummaryInfoList ) {
	        		int almMsegLine = Integer.parseInt(dccAlarmInfo.getAlmMesgLine());
	        		if( almMsegLine <= 1 ) {
	        			String almDtm = "";
        				almDtm = dccAlarmInfo.getAlmTime() + (!"0".equals(dccAlarmInfo.getAlmMsecchk()) ? "   " : "       ");
		        		String almCode = dccAlarmInfo.getAlmCode();
		        		String almAddress = dccAlarmInfo.getAlmAddress();
		        		for( int ci=0;ci<4-dccAlarmInfo.getAlmCode().length();ci++ ) {
		        			almCode = almCode + " ";
		        		}
		        		for( int ai=0;ai<4-dccAlarmInfo.getAlmAddress().length();ai++ ) {
		        			almAddress = " " + almAddress;
		        		}
		        		contentStr = contentStr
		        				 + (!"X".equals(dccAlarmInfo.getAlmGubun()) ? " "+dccAlarmInfo.getAlmGubun() : "  ") + "  "
		        				 + almDtm
		        				 + almCode
		        				 + almAddress + "  "
		        				 + dccAlarmInfo.getAlmMesg()
		        				 + "==SEP==";
	        		} else {
	        			contentStr = contentStr + "==SEP==";
	        		}
	        	}
	        	String[] contents = contentStr.split("==SEP==");
	        	
	        	boolean write = false;
				try {
					write = fileHelperUtil.writeTxtFile(filePath, contents, this.menuName);
				} catch (Exception e) {
					logger.error(e.toString());
				}
	        	
	        	if( write ) {
		        	Upload upload = new Upload();
	        		upload.setDiv(this.menuName);
	        		upload.setFileRealName(filePath);
	        		
	        		fileHelperUtil.download(request, response, upload, "application/octet-stream");
	        		
	        		fileHelperUtil.deleteTxtFile(upload, filePath);
	        	}

	        }
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
    }
	
	@RequestMapping("earlywarning")
	public ModelAndView earlywarning(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ earlywarning");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
       

        return mav;
    }
	
	@RequestMapping("fixedtimecontrol")
	public ModelAndView fixedtimecontrol(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ fixedtimecontrol");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        

        return mav;
    }
	
	@RequestMapping("gaschromatography")
	public ModelAndView gaschromatography(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();


        logger.info("############ gaschromatography");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        

        return mav;
    }
}
