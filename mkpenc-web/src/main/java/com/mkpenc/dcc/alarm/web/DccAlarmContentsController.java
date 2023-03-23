package com.mkpenc.dcc.alarm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.alarm.model.DccSearchAlarm;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.alarm.model.DccAlarmInfo;
import com.mkpenc.dcc.alarm.service.DccAlarmService;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.common.model.Upload;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.common.module.FileHelperUtil;
import com.mkpenc.common.module.PageHtmlUtil;
import com.mkpenc.common.module.StringUtil;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.dcc.common.service.BasDccMimicService;
import com.mkpenc.dcc.common.service.BasDccOsmsService;
import com.mkpenc.dcc.performance.model.DccSearchPerformance;
import com.mkpenc.dcc.tip.model.DccIolistInfo;

import static org.mockito.ArgumentMatchers.contains;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/alarm/")
public class DccAlarmContentsController {

	private static Logger logger = LoggerFactory.getLogger(DccAlarmContentsController.class);
	
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
	
	private String menuName = "ALARM";
	
	@Autowired
	 private CommonConstant commonConstant;	
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired	
	private BasDccOsmsService basDccOsmsService;
	
	@Autowired
	private BasDccMimicService basDccMimicService;
	
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
        
        if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
    	}
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
    		if(dccSearchAlarm.getsMenuNo() == null || dccSearchAlarm.getsMenuNo().isEmpty()) {
            	
    			dccSearchAlarm.setsDive("D");
    			dccSearchAlarm.setsMenuNo("65");
    			dccSearchAlarm.setsGrpID("Alarm");;
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchAlarm.setsHogi(member.getHogi());
	        	dccSearchAlarm.setsXYGubun(member.getXyGubun());
	        	
	        	//dccSearchAlarm.setsGrpID(member.getId());
        	}
        	
        	//if(dccSearchAlarm.getsUGrpNo() != null && !dccSearchAlarm.getsUGrpNo().isEmpty()) {
        		
        		Map dccGrpTagSearchMap = new HashMap();
        		dccGrpTagSearchMap.put("xyGubun",dccSearchAlarm.getsXYGubun()==null?  "X": dccSearchAlarm.getsXYGubun());
        		dccGrpTagSearchMap.put("hogi",dccSearchAlarm.getsHogi()==null?  "3": dccSearchAlarm.getsHogi());
        		dccGrpTagSearchMap.put("dive",dccSearchAlarm.getsDive()==null?  "D": dccSearchAlarm.getsDive());
        		//dccGrpTagSearchMap.put("grpID", dccSearchAlarm.getsGrpID()==null?  "": dccSearchAlarm.getsGrpID());
        		dccGrpTagSearchMap.put("grpID", "Alarm");
        		dccGrpTagSearchMap.put("menuNo", dccSearchAlarm.getsMenuNo()==null?  "65": dccSearchAlarm.getsMenuNo());
        		dccGrpTagSearchMap.put("uGrpNo", dccSearchAlarm.getsUGrpNo()==null?  "1": dccSearchAlarm.getsUGrpNo());
        		dccGrpTagSearchMap.put("pSCanTime", dccSearchAlarm.getStartDate()==null?  "2022-12-01 14:52:01.000": dccSearchAlarm.getStartDate());

        		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
        		
        		mav.addObject("TagDccInfoList", tagDccInfoList);
        		
        		String[] varValue =  basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
        		
        		List<Map> dccTagList = new ArrayList<Map>();
        		
        		int iRow = 0;
        		for(ComTagDccInfo tagDccInfo:tagDccInfoList) {
        			
        			Map rtnMap = new HashMap();

        			rtnMap.put("SCANTIME", varValue[0]);
        			rtnMap.put("IOTYPE", tagDccInfo.getIOTYPE());
        			
        			if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
        				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS()  + "-" +  tagDccInfo.getIOTYPE());
        			}else {
        				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS());    				
        			}
        			
        			rtnMap.put("DataLoop", tagDccInfo.getDataLoop());
        			rtnMap.put("Descr", tagDccInfo.getDescr());
        			rtnMap.put("MinVal", tagDccInfo.getMinVal());
        			rtnMap.put("MaxVal", tagDccInfo.getMaxVal());
        			rtnMap.put("ELow", tagDccInfo.getELOW());
        			rtnMap.put("EHigh", tagDccInfo.getEHIGH());
        			
        			if(varValue.length > 1) {
        				
//        				if(StringUtil.isNumeric(varValue[iRow + 1])){
//        					
//        					if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
//        	    				rtnMap.put("Value", GetBitVal(varValue[iRow + 1], ""+tagDccInfo.getIOBIT()));
//        					}else if(tagDccInfo.getIOTYPE().equals("DI")){
//        						rtnMap.put("Value", varValue[iRow + 1]);
//        					}else {
//        	    				rtnMap.put("Value", String.format(gFormat[tagDccInfo.getBScale()], varValue[iRow + 1])); 		
//        	    			}
//        				}
    					rtnMap.put("Value", varValue[iRow + 1]);
    					if(StringUtil.isNumeric(varValue[iRow + 1])){
	        				if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getELOW() ) {
	        					rtnMap.put("BackColor", "#fdf3c0");
	        				} else if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getEHIGH() ){
	        					rtnMap.put("BackColor", "#ff5f1f");
	        				} else {
	        					rtnMap.put("BackColor", "#ffffff");
	        				}
        				} else {
        					rtnMap.put("BackColor", "#ffffff");
        				}
        			}
        			
        			rtnMap.put("Unit", tagDccInfo.getUnit());
        			rtnMap.put("rowNum", iRow+1);
        			
        			if( dccSearchAlarm.getPageNum() == 2 ) {
        				if( iRow >= 25 ) {
        					dccTagList.add(rtnMap);
        				}
        			} else {
        				if( iRow <= 24 ) {
        					dccTagList.add(rtnMap);
        				}
        			}
        			iRow++;
        		}
        		
        		mav.addObject("DccTagList", dccTagList);
        	//}
        		
    		Map searchMapGrpNm = new HashMap();
    		searchMapGrpNm.put("grpID", dccSearchAlarm.getsGrpID());
    		searchMapGrpNm.put("menuNo", dccSearchAlarm.getsMenuNo());
    		searchMapGrpNm.put("uGrpNo", dccSearchAlarm.getsUGrpNo()==null?  "1": dccSearchAlarm.getsUGrpNo());
    		
    		List<String> grpNameList = basCommonService.selectGrpNameListB(searchMapGrpNm);
    		
    		String groupName = (grpNameList == null || grpNameList.size() == 0)? "경보 설정" : grpNameList.get(0).toString();
    		
    		Map searchMap = new HashMap();
    		searchMap.put("dive", dccSearchAlarm.getsDive());
    		searchMap.put("grpID", dccSearchAlarm.getsGrpID());
    		searchMap.put("hogi", dccSearchAlarm.getsHogi());
    		searchMap.put("menuNo", dccSearchAlarm.getsMenuNo());
    		searchMap.put("uGrpNo", dccSearchAlarm.getsUGrpNo()==null?  "1": dccSearchAlarm.getsUGrpNo());
    		
        	List<Map> lvIOList = basDccOsmsService.selectDccGrpTagListB(searchMap);
        	if( lvIOList.size() > 0 ) {
	        	for( Map lvIOItem : lvIOList) {
		        	lvIOItem.put("title", groupName);
		        	if( lvIOItem.get("iSeq") == null ) lvIOItem.replace("iSeq", "");
		        	if( lvIOItem.get("gubun") == null ) lvIOItem.replace("gubun", "D");
		        	if( lvIOItem.get("hogi") == null ) lvIOItem.replace("hogi", "");
		        	if( lvIOItem.get("xyGubun") == null ) lvIOItem.replace("xyGubun", "");
		        	if( lvIOItem.get("Descr") == null ) lvIOItem.replace("Descr", "");
		        	if( lvIOItem.get("ioType") == null ) lvIOItem.replace("ioType", "");
		        	if( lvIOItem.get("address") == null ) lvIOItem.replace("address", "");
		        	if( "0".equals(lvIOItem.get("saveCoreChk")) && "SC".equalsIgnoreCase(lvIOItem.get("ioType").toString()) ) {
		        		lvIOItem.replace("ioBit", "");
		        	} else {
		        		if( lvIOItem.get("ioBit") == null ) lvIOItem.replace("ioBit", "");
		        	}
		        	if( lvIOItem.get("minVal") == null ) lvIOItem.replace("minVal", "");
		        	if( lvIOItem.get("maxVal") == null ) lvIOItem.replace("maxVal", "");
		        	if( lvIOItem.get("saveCoreChk") == null ) lvIOItem.replace("saveCoreChk", "");
	        	}
        	} else {
        		Map lvIOItem = new HashMap();
        		lvIOItem.put("title", groupName);
	        	lvIOItem.put("iSeq", "");
	        	lvIOItem.put("gubun", "D");
	        	lvIOItem.put("hogi", "");
	        	lvIOItem.put("xyGubun", "");
	        	lvIOItem.put("Descr", "");
	        	lvIOItem.put("ioType", "");
	        	lvIOItem.put("address", "");
	        	lvIOItem.put("ioBit", "");
	        	lvIOItem.put("minVal", "");
	        	lvIOItem.put("maxVal", "");
	        	lvIOItem.put("saveCoreChk", "");
	        	
	        	lvIOList.add(lvIOItem);
        	}
        	
        	mav.addObject("LvIOList",lvIOList);
        	
        	dccSearchAlarm.setiSeqMod("".equals(dccSearchAlarm.getiSeqMod()) ? "" : dccSearchAlarm.getiSeqMod());
        	dccSearchAlarm.setGubunMod("".equals(dccSearchAlarm.getGubunMod()) ? "" : dccSearchAlarm.getGubunMod());
        	dccSearchAlarm.setHogiMod("".equals(dccSearchAlarm.getHogiMod()) ? "" : dccSearchAlarm.getHogiMod());
        	dccSearchAlarm.setXyGubunMod("".equals(dccSearchAlarm.getXyGubunMod()) ? "" : dccSearchAlarm.getXyGubunMod());
        	dccSearchAlarm.setDescrMod("".equals(dccSearchAlarm.getDescrMod()) ? "" : dccSearchAlarm.getDescrMod());
        	dccSearchAlarm.setIoTypeMod("".equals(dccSearchAlarm.getIoTypeMod()) ? "" : dccSearchAlarm.getIoTypeMod());
        	dccSearchAlarm.setAddressMod("".equals(dccSearchAlarm.getAddressMod()) ? "" : dccSearchAlarm.getAddressMod());
        	dccSearchAlarm.setIoBitMod("".equals(dccSearchAlarm.getIoBitMod()) ? "" : dccSearchAlarm.getIoBitMod());
        	dccSearchAlarm.setMinValMod("".equals(dccSearchAlarm.getMinValMod()) ? "" : dccSearchAlarm.getMinValMod());
        	dccSearchAlarm.setMaxValMod("".equals(dccSearchAlarm.getMaxValMod()) ? "" : dccSearchAlarm.getMaxValMod());
        	dccSearchAlarm.setSaveCoreMod("".equals(dccSearchAlarm.getSaveCoreMod()) ? "" : dccSearchAlarm.getSaveCoreMod());
        	
        	dccSearchAlarm.setMenuName(this.menuName);

        	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
        	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
        	
        }
       

        return mav;
    }
	
	@RequestMapping(value = "runtimerEW", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView runtimerEW(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
		
		logger.info("############ runtimerEW");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
    	if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
    	}

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		if(dccSearchAlarm.getsUGrpNo() != null && !dccSearchAlarm.getsUGrpNo().isEmpty()) {
        	
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("xyGubun",dccSearchAlarm.getsXYGubun()==null?  "X": dccSearchAlarm.getsXYGubun());
    		dccGrpTagSearchMap.put("hogi",dccSearchAlarm.getsHogi()==null?  "3": dccSearchAlarm.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchAlarm.getsDive()==null?  "D": dccSearchAlarm.getsDive());
    		//dccGrpTagSearchMap.put("grpID", dccSearchAlarm.getsGrpID()==null?  "": dccSearchAlarm.getsGrpID());
    		dccGrpTagSearchMap.put("grpID", "Alarm");
    		dccGrpTagSearchMap.put("menuNo", dccSearchAlarm.getsMenuNo()==null?  "65": dccSearchAlarm.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchAlarm.getsUGrpNo()==null?  "1": dccSearchAlarm.getsUGrpNo());
    		dccGrpTagSearchMap.put("pSCanTime", dccSearchAlarm.getStartDate()==null?  "2022-12-01 14:52:01.000": dccSearchAlarm.getStartDate());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
    		
    		mav.addObject("TagDccInfoList", tagDccInfoList);
    		
    		String[] varValue =  basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
    		
    		List<Map> dccTagList = new ArrayList<Map>();
    		
    		int iRow = 0;
    		for(ComTagDccInfo tagDccInfo:tagDccInfoList) {
    			
    			Map rtnMap = new HashMap();

    			rtnMap.put("SCANTIME", varValue[0]);
    			rtnMap.put("IOTYPE", tagDccInfo.getIOTYPE());
    			
    			if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
    				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS()  + "-" +  tagDccInfo.getIOTYPE());
    			}else {
    				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS());    				
    			}
    			
    			rtnMap.put("DataLoop", tagDccInfo.getDataLoop());
    			rtnMap.put("Descr", tagDccInfo.getDescr());
    			rtnMap.put("MinVal", tagDccInfo.getMinVal());
    			rtnMap.put("MaxVal", tagDccInfo.getMaxVal());
    			rtnMap.put("ELow", tagDccInfo.getELOW());
    			rtnMap.put("EHigh", tagDccInfo.getEHIGH());
    			
    			if(varValue.length > 1) {
    				
//    				if(StringUtil.isNumeric(varValue[iRow + 1])){
//    					
//    					if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
//    	    				rtnMap.put("Value", GetBitVal(varValue[iRow + 1], ""+tagDccInfo.getIOBIT()));
//    					}else if(tagDccInfo.getIOTYPE().equals("DI")){
//    						rtnMap.put("Value", varValue[iRow + 1]);
//    					}else {
//    	    				rtnMap.put("Value", String.format(gFormat[tagDccInfo.getBScale()], varValue[iRow + 1])); 		
//    	    			}
//    				}
					rtnMap.put("Value", varValue[iRow + 1]);
					if(StringUtil.isNumeric(varValue[iRow + 1])){
        				if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getELOW() ) {
        					rtnMap.put("BackColor", "#fdf3c0");
        				} else if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getEHIGH() ){
        					rtnMap.put("BackColor", "#ff5f1f");
        				} else {
        					rtnMap.put("BackColor", "#ffffff");
        				}
    				} else {
    					rtnMap.put("BackColor", "#ffffff");
    				}
    			}
    			
    			rtnMap.put("Unit", tagDccInfo.getUnit());
    			rtnMap.put("rowNum", iRow+1);
    			
    			if( dccSearchAlarm.getPageNum() == 2 ) {
    				if( iRow >= 25 ) {
    					dccTagList.add(rtnMap);
    				}
    			} else {
    				if( iRow <= 24 ) {
    					dccTagList.add(rtnMap);
    				}
    			}
    			
    			//dccTagList.add(rtnMap);
    			iRow++;
    		}
    		
    		mav.addObject("DccTagList", dccTagList);
    	}

    	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
    	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());

		mav.addObject("BaseSearch", dccSearchAlarm);        	
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value = "ssql", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView ssql(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
		
		logger.info("############ ssql");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
    	if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
    	}
    	if( dccSearchAlarm.getIoType() == null || "".equals(dccSearchAlarm.getIoType()) ) dccSearchAlarm.setIoType("AI");
    	if( dccSearchAlarm.getIoBit() == null || "".equals(dccSearchAlarm.getIoBit()) ) dccSearchAlarm.setIoBit("0");
    	if( dccSearchAlarm.getSaveCore() == null ) dccSearchAlarm.setSaveCore("0");
    	if( dccSearchAlarm.getsDive() == null ) dccSearchAlarm.setsDive("D");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchAlarm.getsUGrpNo() != null && !dccSearchAlarm.getsUGrpNo().isEmpty()) {
    	
		List<Map> ioList = dccAlarmService.selectSetIOList(dccSearchAlarm);
		
		for( Map ioItem: ioList) {
			ioItem.put("ioBit", dccSearchAlarm.getIoBit());
			ioItem.put("ioType", dccSearchAlarm.getIoType());
			ioItem.put("gubun", dccSearchAlarm.getsDive());
			ioItem.put("hogi", dccSearchAlarm.getsHogi());
			ioItem.put("xyGubun", dccSearchAlarm.getsXYGubun());
			ioItem.put("saveCoreChk", dccSearchAlarm.getSaveCore());
			ioItem.replace("address", ioItem.get("address") == null ? "" : ioItem.get("address"));
			ioItem.replace("loopName", ioItem.get("loopName") == null ? "" : ioItem.get("loopName"));
			ioItem.replace("eHigh", ioItem.get("eHigh") == null ? "" : ioItem.get("eHigh"));
			ioItem.replace("eLow", ioItem.get("eLow") == null ? "" : ioItem.get("eLow"));
			ioItem.replace("iSeq", ioItem.get("iSeq") == null ? "" : ioItem.get("iSeq"));
			ioItem.replace("FASTIOCHK", ioItem.get("FASTIOCHK") == null ? "" : ioItem.get("FASTIOCHK"));
		}
		
		mav.addObject("LvIOList", ioList);
    	//}

    	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
    	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());

		mav.addObject("BaseSearch", dccSearchAlarm);        	
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value = "cmdInsert", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView cmdInsert(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
		
		logger.info("############ cmdInsert");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
    	if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
    	}
    	if( dccSearchAlarm.getIoType() == null || "".equals(dccSearchAlarm.getIoType()) ) dccSearchAlarm.setIoType("AI");
    	if( dccSearchAlarm.getIoBit() == null || "".equals(dccSearchAlarm.getIoBit()) ) dccSearchAlarm.setIoBit("0");
    	if( dccSearchAlarm.getSaveCore() == null ) dccSearchAlarm.setSaveCore("0");
    	if( dccSearchAlarm.getsDive() == null ) dccSearchAlarm.setsDive("D");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchAlarm.getsUGrpNo() != null && !dccSearchAlarm.getsUGrpNo().isEmpty()) {
    	
    	String strDive = dccSearchAlarm.getsDive() == "null" ? "D" : dccSearchAlarm.getsDive();
    	String strGrpID = dccSearchAlarm.getsGrpID() == null ? "Alarm" : dccSearchAlarm.getsGrpID();
    	String strMenuNo = dccSearchAlarm.getsMenuNo() == null ? "65" : dccSearchAlarm.getsMenuNo();
    	String strUGrpNo = dccSearchAlarm.getsUGrpNo() == null ? "1" : dccSearchAlarm.getsUGrpNo();
    	
    	Map searchMapGrpNm = new HashMap();
		searchMapGrpNm.put("grpID", strGrpID);
		searchMapGrpNm.put("menuNo", strMenuNo);
		searchMapGrpNm.put("uGrpNo", strUGrpNo);
		
		String groupName = basCommonService.selectGrpNameListB(searchMapGrpNm).get(0) == null ? "경보 설정" : basCommonService.selectGrpNameListB(searchMapGrpNm).get(0);
		
		Map searchMap = new HashMap();
		searchMap.put("dive", strDive);
		searchMap.put("grpID", strGrpID);
		searchMap.put("hogi", dccSearchAlarm.getsHogi());
		searchMap.put("menuNo", dccSearchAlarm.getsMenuNo());
		searchMap.put("uGrpNo", strUGrpNo);
		
    	List<Map> lvIOList = basDccOsmsService.selectDccGrpTagListB(searchMap);
    	
    	String[] iSeqMod = dccSearchAlarm.getiSeqMod().split("==SEP==");
    	String[] gubunMod = dccSearchAlarm.getGubunMod().split("==SEP==");
    	String[] hogiMod = dccSearchAlarm.getHogiMod().split("==SEP==");
    	String[] xyGubunMod = dccSearchAlarm.getXyGubunMod().split("==SEP==");
    	String[] DescrMod = dccSearchAlarm.getDescrMod().split("==SEP==");
    	String[] ioTypeMod = dccSearchAlarm.getIoTypeMod().split("==SEP==");
    	String[] addressMod = dccSearchAlarm.getAddressMod().split("==SEP==");
    	String[] ioBitMod = dccSearchAlarm.getIoBitMod().split("==SEP==");
    	String[] minValMod = dccSearchAlarm.getMinValMod().split("==SEP==");
    	String[] maxValMod = dccSearchAlarm.getMaxValMod().split("==SEP==");
    	String[] saveCoreMod = dccSearchAlarm.getSaveCoreMod().split("==SEP==");
    	
    	//for( Map lvIOItem : lvIOList) {
    	for( int di=0;di<lvIOList.size();di++ ) {
    		Map lvIOItem = lvIOList.get(di);
    		if( iSeqMod[1].indexOf("|") > -1 && iSeqMod[1].length() > 1 ) {
	    		for( int d=0;d<iSeqMod[1].split("\\|").length;d++ ) {
		    		if( iSeqMod[1].split("\\|")[d].trim().equals(lvIOItem.get("iSeq").toString().trim()) ) {
		    			lvIOList.remove(lvIOItem);
		    		}
	    		}
    		} else if( iSeqMod[1].length() > 0 ) {
    			if( iSeqMod[1].replaceAll("|", "").equals(lvIOItem.get("iSeq")) ) {
	    			lvIOList.remove(lvIOItem);
	    		}
    		}
    	}
    	
    	if( !"".equals(iSeqMod[0]) && iSeqMod[0].indexOf("|") > -1 ) {
    		int size = iSeqMod[0].split("\\|").length;
	    	for ( int i=0;i<size;i++ ) {
				Map lvIOItem = new HashMap();
				if( !"|".equals(iSeqMod[0]) ) {
					lvIOItem.put("iSeq", iSeqMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("iSeq", "");
				}
				if( !"|".equals(gubunMod[0]) ) {
					lvIOItem.put("gubun", gubunMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("gubun", "");
				}
				if( !"|".equals(hogiMod[0]) ) {
					lvIOItem.put("hogi", hogiMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("hogi", "");
				}
				if( !"|".equals(xyGubunMod[0]) ) {
					lvIOItem.put("xyGubun", xyGubunMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("xyGubun", "");
				}
				if( size == DescrMod[0].split("\\|").length ) {
					lvIOItem.put("Descr", DescrMod[0].split("\\|")[i]);
				} else {
					if( i < DescrMod[0].split("\\|").length ) {
						lvIOItem.put("Descr", DescrMod[0].split("\\|")[i]);
					} else {
						lvIOItem.put("Descr", "");
					}
				}
				if( !"|".equals(ioTypeMod[0]) ) {
					lvIOItem.put("ioType", ioTypeMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("ioType", "");
				}
				if( !"|".equals(addressMod[0]) ) {
					lvIOItem.put("address", addressMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("address", "");
				}
				if( !"|".equals(ioBitMod[0]) ) {
					lvIOItem.put("ioBit", ioBitMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("ioBit", "");
				}
				if( !"|".equals(minValMod[0]) ) {
					lvIOItem.put("minVal", minValMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("minVal", "");
				}
				if( !"|".equals(maxValMod[0]) ) {
					lvIOItem.put("maxVal", maxValMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("maxVal", "");
				}
				if( !"|".equals(saveCoreMod[0]) ) {
					lvIOItem.put("saveCoreChk", saveCoreMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("saveCoreChk", "");
				}
				
		    	lvIOList.add(lvIOItem);
	    	}
    	} else if( !"".equals(iSeqMod[0]) && iSeqMod[0].length() > 0 ) {
			Map lvIOItem = new HashMap();
			lvIOItem.put("title", groupName);
	    	lvIOItem.put("iSeq", !"|".equals(dccSearchAlarm.getiSeqMod()) ? iSeqMod[0] : "");
	    	lvIOItem.put("gubun", !"|".equals(dccSearchAlarm.getGubunMod()) ? gubunMod[0] : "");
	    	lvIOItem.put("hogi", !"|".equals(dccSearchAlarm.getHogiMod()) ? hogiMod[0] : "");
	    	lvIOItem.put("xyGubun", !"|".equals(dccSearchAlarm.getXyGubunMod()) ? xyGubunMod[0] : "");
	    	lvIOItem.put("Descr", !"|".equals(dccSearchAlarm.getDescrMod()) ? DescrMod[0] : "");
	    	lvIOItem.put("ioType", !"|".equals(dccSearchAlarm.getIoTypeMod()) ? ioTypeMod[0] : "");
	    	lvIOItem.put("address", !"|".equals(dccSearchAlarm.getAddressMod()) ? addressMod[0] : "");
	    	lvIOItem.put("ioBit", !"|".equals(dccSearchAlarm.getIoBitMod()) ? ioBitMod[0] : "");
	    	lvIOItem.put("minVal", !"|".equals(dccSearchAlarm.getMinValMod()) ? minValMod[0] : "");
	    	lvIOItem.put("maxVal", !"|".equals(dccSearchAlarm.getMaxValMod()) ? maxValMod[0] : "");
	    	lvIOItem.put("saveCoreChk", !"|".equals(dccSearchAlarm.getSaveCoreMod()) ? saveCoreMod[0] : "");
    	
	    	lvIOList.add(lvIOItem);
    	}
    	
    	mav.addObject("LvIOList",lvIOList);
    	//}

    	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
    	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());

		mav.addObject("BaseSearch", dccSearchAlarm);        	
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value = "tagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView tagFind(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
		
		logger.info("############ cmdTagSearch");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
    	if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
    	}
    	if( dccSearchAlarm.getIoType() == null || "".equals(dccSearchAlarm.getIoType()) ) dccSearchAlarm.setIoType("AI");
    	if( dccSearchAlarm.getIoBit() == null || "".equals(dccSearchAlarm.getIoBit()) ) dccSearchAlarm.setIoBit("0");
    	if( dccSearchAlarm.getSaveCore() == null ) dccSearchAlarm.setSaveCore("0");
    	if( dccSearchAlarm.getsDive() == null ) dccSearchAlarm.setsDive("D");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchAlarm.getsUGrpNo() != null && !dccSearchAlarm.getsUGrpNo().isEmpty()) {
    	
    	String strDive = dccSearchAlarm.getsDive() == "null" ? "D" : dccSearchAlarm.getsDive();
    	String strGrpID = dccSearchAlarm.getsGrpID() == null ? "Alarm" : dccSearchAlarm.getsGrpID();
    	String strMenuNo = dccSearchAlarm.getsMenuNo() == null ? "65" : dccSearchAlarm.getsMenuNo();
    	String strUGrpNo = dccSearchAlarm.getsUGrpNo() == null ? "1" : dccSearchAlarm.getsUGrpNo();
    	
    	dccSearchAlarm.setsDive(strDive);
    	dccSearchAlarm.setsGrpID(strGrpID);
    	dccSearchAlarm.setsMenuNo(strMenuNo);
    	dccSearchAlarm.setsUGrpNo(strUGrpNo);
    	
    	List<Map> tagSearchList = dccAlarmService.selectAlarmTagSearch(dccSearchAlarm);
    	
    	for( Map tagSearchItem : tagSearchList ) {
    		tagSearchItem.replace("iSeq",tagSearchItem.get("iSeq") == null ? "" : tagSearchItem.get("iSeq").toString());
    		tagSearchItem.replace("iHogi",tagSearchItem.get("iHogi") == null ? "" : tagSearchItem.get("iHogi").toString());
    		tagSearchItem.replace("xyGubun",tagSearchItem.get("xyGubun") == null ? "" : tagSearchItem.get("xyGubun").toString());
    		tagSearchItem.replace("loopName",tagSearchItem.get("loopName") == null ? "" : tagSearchItem.get("loopName").toString());
    		tagSearchItem.replace("descr",tagSearchItem.get("descr") == null ? "" : tagSearchItem.get("descr").toString());
    		tagSearchItem.replace("ioType",tagSearchItem.get("ioType") == null ? "" : tagSearchItem.get("ioType").toString());
    		tagSearchItem.replace("address",tagSearchItem.get("address") == null ? "" : tagSearchItem.get("address").toString());
    		tagSearchItem.replace("ioBit",tagSearchItem.get("ioBit") == null ? "" : tagSearchItem.get("ioBit").toString());
    		tagSearchItem.replace("eLow",tagSearchItem.get("eLow") == null ? "" : tagSearchItem.get("eLow").toString());
    		tagSearchItem.replace("eHigh",tagSearchItem.get("eHigh") == null ? "" : tagSearchItem.get("eHigh").toString());
    	}
    	
    	mav.addObject("TagSearchList", tagSearchList);

    	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
    	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());

		mav.addObject("BaseSearch", dccSearchAlarm);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value = "cmdOK", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView cmdOK(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
		
		logger.info("############ cmdOK");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
    	if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
    	}
    	if( dccSearchAlarm.getIoType() == null || "".equals(dccSearchAlarm.getIoType()) ) dccSearchAlarm.setIoType("AI");
    	if( dccSearchAlarm.getIoBit() == null || "".equals(dccSearchAlarm.getIoBit()) ) dccSearchAlarm.setIoBit("0");
    	if( dccSearchAlarm.getSaveCore() == null ) dccSearchAlarm.setSaveCore("0");
    	if( dccSearchAlarm.getsDive() == null ) dccSearchAlarm.setsDive("D");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchAlarm.getsUGrpNo() != null && !dccSearchAlarm.getsUGrpNo().isEmpty()) {
    	
    	String strDive = dccSearchAlarm.getsDive() == "null" ? "D" : dccSearchAlarm.getsDive();
    	String strGrpID = dccSearchAlarm.getsGrpID() == null ? "Alarm" : dccSearchAlarm.getsGrpID();
    	String strMenuNo = dccSearchAlarm.getsMenuNo() == null ? "65" : dccSearchAlarm.getsMenuNo();
    	String strUGrpNo = dccSearchAlarm.getsUGrpNo() == null ? "1" : dccSearchAlarm.getsUGrpNo();
    	
    	Map searchMapGrpNm = new HashMap();
		searchMapGrpNm.put("grpID", strGrpID);
		searchMapGrpNm.put("menuNo", strMenuNo);
		searchMapGrpNm.put("uGrpNo", strUGrpNo);
		
		String groupName = basCommonService.selectGrpNameListB(searchMapGrpNm).get(0) == null ? "경보 설정" : basCommonService.selectGrpNameListB(searchMapGrpNm).get(0);
		
		Map searchMap = new HashMap();
		searchMap.put("dive", strDive);
		searchMap.put("grpID", strGrpID);
		searchMap.put("hogi", dccSearchAlarm.getsHogi());
		searchMap.put("menuNo", dccSearchAlarm.getsMenuNo());
		searchMap.put("uGrpNo", strUGrpNo);
		
    	List<Map> lvIOList = basDccOsmsService.selectDccGrpTagListB(searchMap);
    	
    	String[] iSeqMod = dccSearchAlarm.getiSeqMod().split("==SEP==");
    	String[] gubunMod = dccSearchAlarm.getGubunMod().split("==SEP==");
    	String[] hogiMod = dccSearchAlarm.getHogiMod().split("==SEP==");
    	String[] xyGubunMod = dccSearchAlarm.getXyGubunMod().split("==SEP==");
    	String[] DescrMod = dccSearchAlarm.getDescrMod().split("==SEP==");
    	String[] ioTypeMod = dccSearchAlarm.getIoTypeMod().split("==SEP==");
    	String[] addressMod = dccSearchAlarm.getAddressMod().split("==SEP==");
    	String[] ioBitMod = dccSearchAlarm.getIoBitMod().split("==SEP==");
    	String[] minValMod = dccSearchAlarm.getMinValMod().split("==SEP==");
    	String[] maxValMod = dccSearchAlarm.getMaxValMod().split("==SEP==");
    	String[] saveCoreMod = dccSearchAlarm.getSaveCoreMod().split("==SEP==");
    	
    	//for( Map lvIOItem : lvIOList) {
    	for( int di=0;di<lvIOList.size();di++ ) {
    		Map lvIOItem = lvIOList.get(di);
    		if( iSeqMod[1].indexOf("|") > -1 && iSeqMod[1].length() > 1 ) {
	    		for( int d=0;d<iSeqMod[1].split("\\|").length;d++ ) {
		    		if( iSeqMod[1].split("\\|")[d].trim().equals(lvIOItem.get("iSeq").toString().trim()) ) {
		    			lvIOList.remove(lvIOItem);
		    		}
	    		}
    		} else if( iSeqMod[1].length() > 0 ) {
    			if( iSeqMod[1].replaceAll("|", "").equals(lvIOItem.get("iSeq")) ) {
	    			lvIOList.remove(lvIOItem);
	    		}
    		}
    	}
    	
    	if( !"".equals(iSeqMod[0]) && iSeqMod[0].indexOf("|") > -1 ) {
    		int size = iSeqMod[0].split("\\|").length;
	    	for ( int i=0;i<size;i++ ) {
				Map lvIOItem = new HashMap();
				if( !"|".equals(iSeqMod[0]) ) {
					lvIOItem.put("iSeq", iSeqMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("iSeq", "");
				}
				if( !"|".equals(gubunMod[0]) ) {
					lvIOItem.put("gubun", gubunMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("gubun", "");
				}
				if( !"|".equals(hogiMod[0]) ) {
					lvIOItem.put("hogi", hogiMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("hogi", "");
				}
				if( !"|".equals(xyGubunMod[0]) ) {
					lvIOItem.put("xyGubun", xyGubunMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("xyGubun", "");
				}
				if( size == DescrMod[0].split("\\|").length ) {
					lvIOItem.put("Descr", DescrMod[0].split("\\|")[i]);
				} else {
					if( i < DescrMod[0].split("\\|").length ) {
						lvIOItem.put("Descr", DescrMod[0].split("\\|")[i]);
					} else {
						lvIOItem.put("Descr", "");
					}
				}
				if( !"|".equals(ioTypeMod[0]) ) {
					lvIOItem.put("ioType", ioTypeMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("ioType", "");
				}
				if( !"|".equals(addressMod[0]) ) {
					lvIOItem.put("address", addressMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("address", "");
				}
				if( !"|".equals(ioBitMod[0]) ) {
					lvIOItem.put("ioBit", ioBitMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("ioBit", "");
				}
				if( !"|".equals(minValMod[0]) ) {
					lvIOItem.put("minVal", minValMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("minVal", "");
				}
				if( !"|".equals(maxValMod[0]) ) {
					lvIOItem.put("maxVal", maxValMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("maxVal", "");
				}
				if( !"|".equals(saveCoreMod[0]) ) {
					lvIOItem.put("saveCoreChk", saveCoreMod[0].split("\\|")[i]);
				} else {
					lvIOItem.put("saveCoreChk", "");
				}
				
		    	lvIOList.add(lvIOItem);
	    	}
    	} else if( !"".equals(iSeqMod[0]) && iSeqMod[0].length() > 0 ) {
			Map lvIOItem = new HashMap();
			lvIOItem.put("title", groupName);
	    	lvIOItem.put("iSeq", !"|".equals(dccSearchAlarm.getiSeqMod()) ? iSeqMod[0] : "");
	    	lvIOItem.put("gubun", !"|".equals(dccSearchAlarm.getGubunMod()) ? gubunMod[0] : "");
	    	lvIOItem.put("hogi", !"|".equals(dccSearchAlarm.getHogiMod()) ? hogiMod[0] : "");
	    	lvIOItem.put("xyGubun", !"|".equals(dccSearchAlarm.getXyGubunMod()) ? xyGubunMod[0] : "");
	    	lvIOItem.put("Descr", !"|".equals(dccSearchAlarm.getDescrMod()) ? DescrMod[0] : "");
	    	lvIOItem.put("ioType", !"|".equals(dccSearchAlarm.getIoTypeMod()) ? ioTypeMod[0] : "");
	    	lvIOItem.put("address", !"|".equals(dccSearchAlarm.getAddressMod()) ? addressMod[0] : "");
	    	lvIOItem.put("ioBit", !"|".equals(dccSearchAlarm.getIoBitMod()) ? ioBitMod[0] : "");
	    	lvIOItem.put("minVal", !"|".equals(dccSearchAlarm.getMinValMod()) ? minValMod[0] : "");
	    	lvIOItem.put("maxVal", !"|".equals(dccSearchAlarm.getMaxValMod()) ? maxValMod[0] : "");
	    	lvIOItem.put("saveCoreChk", !"|".equals(dccSearchAlarm.getSaveCoreMod()) ? saveCoreMod[0] : "");
    	
	    	lvIOList.add(lvIOItem);
    	}

    	dccSearchAlarm.setsGrpID(strGrpID);
    	dccSearchAlarm.setsMenuNo(strMenuNo);
    	dccSearchAlarm.setsUGrpNo(strUGrpNo);
    	
    	Integer delRes = dccAlarmService.deleteGrpTagB(dccSearchAlarm);
    	if( delRes == null ) delRes = 0;
    	logger.info("successfully delete ["+delRes+"] row(s).");
    	
    	int idx=0;
    	for( Map lvIOItem : lvIOList) {
    		String itemHogi = lvIOItem.get("hogi").toString();
    		String gHogi = itemHogi;

    		dccSearchAlarm.setHogiMod(itemHogi);
    		dccSearchAlarm.setIoTypeMod(lvIOItem.get("ioType").toString());
    		dccSearchAlarm.setAddressMod(lvIOItem.get("address").toString());
    		dccSearchAlarm.setIoBitMod(lvIOItem.get("ioBit").toString());
    		dccSearchAlarm.setXyGubunMod(lvIOItem.get("xyGubun").toString());
    		
    		String ySeq = dccAlarmService.selectISeqGrpTagB(dccSearchAlarm);

    		dccSearchAlarm.setgHogi(gHogi);
    		dccSearchAlarm.setTagNo(String.valueOf(idx));
    		dccSearchAlarm.setiSeqMod(lvIOItem.get("iSeq").toString());
    		dccSearchAlarm.setySeq(ySeq);
    		dccSearchAlarm.setMaxValMod(lvIOItem.get("maxVal").toString());
    		dccSearchAlarm.setMinValMod(lvIOItem.get("minVal").toString());
    		dccSearchAlarm.setSaveCoreMod(lvIOItem.get("saveCoreChk").toString());
    		dccSearchAlarm.setDescrMod(lvIOItem.get("Descr").toString());
    		
    		dccAlarmService.insertGrpTagB(dccSearchAlarm);

    		if( "1".equals(dccSearchAlarm.getChkHogi()) ) {
    			if( "3".equals(itemHogi) ) {
    				gHogi = "4";
    			} else {
    				gHogi = "3";
    			}
    			
    			dccSearchAlarm.setgHogi(gHogi);

        		dccAlarmService.insertGrpTagB(dccSearchAlarm);
    		}
    		
    		idx++;
    	}
    	//}
    	
    	List<Map> lvIOList2 = basDccOsmsService.selectDccGrpTagListB(searchMap);
    	
    	mav.addObject("LvIOList", lvIOList2);

    	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
    	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());

		mav.addObject("BaseSearch", dccSearchAlarm);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping("ewExcelExport")
	public void ewExcelExport(DccSearchAlarm dccSearchAlarm, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
        
	        if( dccSearchAlarm.getHogiHeader() != null ) {
	    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
	    	} else {
	    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
	    	}
	    	if( dccSearchAlarm.getXyHeader() != null ) {
	    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
	    	} else {
	    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
	    	}
	        
	        if(request.getSession().getAttribute("USER_INFO") != null) {
	        	
	        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	
	    		if(dccSearchAlarm.getsMenuNo() == null || dccSearchAlarm.getsMenuNo().isEmpty()) {
	            	
	    			dccSearchAlarm.setsDive("D");
	    			dccSearchAlarm.setsMenuNo("65");
	    			dccSearchAlarm.setsGrpID("Alarm");;
		        	
		        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		        	dccSearchAlarm.setsHogi(member.getHogi());
		        	dccSearchAlarm.setsXYGubun(member.getXyGubun());
		        	
	        	}
	        		
        		Map dccGrpTagSearchMap = new HashMap();
        		dccGrpTagSearchMap.put("xyGubun",dccSearchAlarm.getsXYGubun()==null?  "X": dccSearchAlarm.getsXYGubun());
        		dccGrpTagSearchMap.put("hogi",dccSearchAlarm.getsHogi()==null?  "3": dccSearchAlarm.getsHogi());
        		dccGrpTagSearchMap.put("dive",dccSearchAlarm.getsDive()==null?  "D": dccSearchAlarm.getsDive());
        		//dccGrpTagSearchMap.put("grpID", dccSearchAlarm.getsGrpID()==null?  "": dccSearchAlarm.getsGrpID());
        		dccGrpTagSearchMap.put("grpID", "Alarm");
        		dccGrpTagSearchMap.put("menuNo", dccSearchAlarm.getsMenuNo()==null?  "65": dccSearchAlarm.getsMenuNo());
        		dccGrpTagSearchMap.put("uGrpNo", dccSearchAlarm.getsUGrpNo()==null?  "1": dccSearchAlarm.getsUGrpNo());
        		dccGrpTagSearchMap.put("pSCanTime", dccSearchAlarm.getStartDate()==null?  "2022-12-01 14:52:01.000": dccSearchAlarm.getStartDate());

        		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
        		
        		String[] varValue =  basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
        		
        		List<Map> dccTagList = new ArrayList<Map>();
        		
        		int iRow = 0;
        		for(ComTagDccInfo tagDccInfo:tagDccInfoList) {
        			
        			Map rtnMap = new HashMap();

        			rtnMap.put("SCANTIME", varValue[0]);
        			rtnMap.put("IOTYPE", tagDccInfo.getIOTYPE());
        			
        			if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
        				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS()  + "-" +  tagDccInfo.getIOTYPE());
        			}else {
        				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS());    				
        			}
        			
        			rtnMap.put("DataLoop", tagDccInfo.getDataLoop());
        			rtnMap.put("Descr", tagDccInfo.getDescr());
        			rtnMap.put("MinVal", tagDccInfo.getMinVal());
        			rtnMap.put("MaxVal", tagDccInfo.getMaxVal());
        			rtnMap.put("ELow", tagDccInfo.getELOW());
        			rtnMap.put("EHigh", tagDccInfo.getEHIGH());
        			
        			if(varValue.length > 1) {
    					rtnMap.put("Value", varValue[iRow + 1]);
    					if(StringUtil.isNumeric(varValue[iRow + 1])){
	        				if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getELOW() ) {
	        					rtnMap.put("BackColor", "#fdf3c0");
	        				} else if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getEHIGH() ){
	        					rtnMap.put("BackColor", "#ff5f1f");
	        				} else {
	        					rtnMap.put("BackColor", "#ffffff");
	        				}
        				} else {
        					rtnMap.put("BackColor", "#ffffff");
        				}
        			}

        			rtnMap.put("IoBit", tagDccInfo.getIOBIT());
        			rtnMap.put("Unit", tagDccInfo.getUnit());
        			rtnMap.put("rowNum", iRow+1);
        			
					dccTagList.add(rtnMap);

        			iRow++;
        		}
        		
        		excelHelperUtil.alarmEWExcelDownload(request, response, "UserAlarm", "User Alarm", dccTagList, "earlywarning");
        		
	        }
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
    }
	
	@RequestMapping("fixedtimecontrol")
	public ModelAndView fixedtimecontrol(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ fixedtimecontrol");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {        	
        	
        	LocalDateTime lDtmS = LocalDateTime.now();         	
            LocalDateTime lDtmE = LocalDateTime.now();   
            
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            if( dccSearchAlarm.getEndDate() == null ) dccSearchAlarm.setEndDate(lDtmE.format(dtf));
            
            if( dccSearchAlarm.getStartDate() == null ) {
            	if( dccSearchAlarm.getEndDate() == null ) {
            		dccSearchAlarm.setStartDate(lDtmS.format(dtf));
            		dccSearchAlarm.setEndDate(lDtmE.format(dtf));
            	} else {
            		lDtmS = LocalDateTime.parse(dccSearchAlarm.getEndDate(),dtf).minusMonths(1L);            		
            		dccSearchAlarm.setStartDate(lDtmS.format(dtf));
            	}
            }
        	
        	if( dccSearchAlarm.getHogiHeader() != null ) {
        		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
        	} else {
        		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
        	}
        	if( dccSearchAlarm.getXyHeader() != null ) {
        		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
        	} else {
        		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
        	}
        	if( dccSearchAlarm.getIoType() == null || "".equals(dccSearchAlarm.getIoType()) ) dccSearchAlarm.setIoType("AI");
        	if( dccSearchAlarm.getIoBit() == null || "".equals(dccSearchAlarm.getIoBit()) ) dccSearchAlarm.setIoBit("0");
        	if( dccSearchAlarm.getSaveCore() == null ) dccSearchAlarm.setSaveCore("0");
        	if( dccSearchAlarm.getsDive() == null ) dccSearchAlarm.setsDive("D");
        	if( dccSearchAlarm.getpType() == null ) dccSearchAlarm.setpType("000");
        	
        	
        	String CI114Init = "268,269,198,272,273,202,276,277,206,280,281,197,"
							 + "284,285,201,288,736,205,739,740,200,743,744,204,"
							 + "747,748,208,751,752,199,755,756,203,759,760,207";
        	
        	
        	if( dccSearchAlarm.getAddress() == null ) dccSearchAlarm.setAddress(CI114Init);
        	String strPType = dccSearchAlarm.getpType();
        	String strAddress = dccSearchAlarm.getAddress();
        	String[] lbl285 = strAddress.indexOf("|") > -1 ? strAddress.split("\\|") : new String[] {};
        	String lblMOI = lbl285.length > 1 ? lbl285[0] : "";
        	String lblLRF = lbl285.length > 1 ? lbl285[1] : "";
        	String strSDate = dccSearchAlarm.getStartDate();
        	String strEDate = dccSearchAlarm.getEndDate();
        	String strTitle = dccSearchAlarm.getTitle();

        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	List<Map> fixedAlarmList = new ArrayList<Map>();
        	
        	int iMM = 0;
        	int iSS = 0;
        	
        	switch( strPType ) {
	        	case "003":
	        		Map start003 = new HashMap();
            		Map end003 = new HashMap();
	        		Map cha003 = new HashMap();
	        		
	        		boolean bS003 = false;
    				boolean bE003 = false;
	        		
    				//System.out.println(strAddress);
    				
	        		String[] addrList003 = strAddress.split(",");	        		
	        		
	        		for( int idx003=0;idx003<addrList003.length;idx003++ ) {
	        			if( idx003%6 == 5 ) {
	        				
		        			dccSearchAlarm.setAddress(addrList003[idx003]);
			        		dccSearchAlarm.setpType(strPType+"0");
			        		
			        		dccSearchAlarm.setStartDate(strSDate);
			        		dccSearchAlarm.setEndDate(strEDate);
	        				
			        		List<DccAlarmInfo> dccAlarmInfoList003 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
			        		
			        		if( dccAlarmInfoList003.size() > 0 ) {
			        			
			        			String schSDate = "";
			        			String schEDate = "";
			        			
			        			for( DccAlarmInfo dccAlarmInfo003 : dccAlarmInfoList003 ) {			        				
			        				
			        				if( Integer.parseInt(addrList003[idx003].trim()) == Integer.parseInt(dccAlarmInfo003.getAlmAddress().trim()) ) {
			        					if("N".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
			        						schEDate = dccAlarmInfo003.getAlmDate().toString().trim();	
			        						end003.put(idx003,schEDate);					                      
			        					}
			        					if("A".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
			        						schSDate = dccAlarmInfo003.getAlmDate().toString().trim();
			        						start003.put(idx003,schSDate);
			        					}
			        				}
			        			}
			        			
			        			for( int sub003=idx003-5;sub003<idx003;sub003++ ) {
			        				LocalDateTime pSDate = convDtm(schSDate.trim(),false).minusSeconds(1);
			        				LocalDateTime pEDate = convDtm(schEDate.trim(),false).plusMinutes(2);
			                        DateTimeFormatter dtf003 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			        				
			        				String sSDate = pSDate.format(dtf003)+".000";
			        				String sEDate = pEDate.format(dtf003)+".999";
			        				
			        				dccSearchAlarm.setAddress(addrList003[sub003]);
			        				dccSearchAlarm.setStartDate(sSDate);
			        				dccSearchAlarm.setEndDate(sEDate);
			        				
			        				if( idx003 == 5 || idx003 == 11 || idx003 == 17 ) {
			        					dccSearchAlarm.setpType(strPType+"1");
			        				} else {
			        					dccSearchAlarm.setpType(strPType+"2");
			        				}
			        				
			        				List<DccAlarmInfo> dccAlarmInfoList0032 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
			        				
			        				//System.out.println("idx = " + sub003 + "::::: size = " + dccAlarmInfoList0032.size());
			        				
			        				bS003 = false;
			        				bE003 = false;
			        				for( DccAlarmInfo dccAlarmInfo003 : dccAlarmInfoList0032 ) {

			        					if( Integer.parseInt(addrList003[sub003].trim()) == Integer.parseInt(dccAlarmInfo003.getAlmAddress().trim()) ) {
			        						if("N".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
				        						end003.put(sub003,dccAlarmInfo003.getAlmDate().toString().trim());
				        						
				        						//System.out.println("idx = " + sub003 + "::::: end003 = " + end003.get(sub003));
				        					}
				        					if("A".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
				        						start003.put(sub003,dccAlarmInfo003.getAlmDate().toString().trim());
				        						
				        						//System.out.println("idx = " + sub003 + "::::: start003 = " + start003.get(sub003));
				        					}
				        				}
			        				}			        				 
			        			}
			        		} else {
			        			for( int e003=0;e003<addrList003.length;e003++ ) {
			        				start003.put(e003,"");
			        				end003.put(e003,"");
			        			}
			        		}
	        			} // end if gap = 5
	        		} // end for gap

	        		if( start003.size() > 0 && !"".equals(start003.get(0)) ) {
		        		for( int idxC003=0;idxC003<addrList003.length;idxC003++ ) {
		        			String sS003 = "";
		        			String sE003 = "";
		        			String chaS0 = "";
		        			switch( idxC003 ) {
			        			case 0: case 6: case 12: case 18: case 24: case 30:
				        			sS003 = start003.get(idxC003).toString().trim();
				        			sE003 = start003.get(idxC003+1).toString().trim();
				        			if( !"".equals(sS003) && !"".equals(sE003) ) {
				            			iMM = Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length())) - Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length()));
				            			iSS = getDateGap(sE003,sS003);
				            					
			        					chaS0 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha003.put(idxC003,chaS0);
				        			}
				        			break;
			        			case 1: case 7: case 13: case 19: case 25: case 31:
			        				sS003 = start003.get(idxC003).toString().trim();
			        				sE003 = start003.get(idxC003+1).toString().trim();
				        			if( !"".equals(sS003) && !"".equals(sE003) ) {
				            			iMM = Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length())) - Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length()));
				            			iSS = getDateGap(sS003,sE003);
				            					
			        					chaS0 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha003.put(idxC003,chaS0);
				        			}
				        			break;
			        			case 2: case 8: case 14: case 20: case 26: case 32:
			        				sS003 = end003.get(idxC003-2).toString().trim();
			        				sE003 = end003.get(idxC003+1).toString().trim();
				        			if( !"".equals(sS003) && !"".equals(sE003) ) {
				        				iMM = Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length())) - Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length()));
				            			iSS = getDateGap(sS003,sE003);
				            					
			        					chaS0 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha003.put(idxC003,chaS0);
				        			}
				        			break;
			        			case 3: case 9: case 15: case 21: case 27: case 33:
			        				sS003 = end003.get(idxC003-1).toString().trim();
			        				sE003 = end003.get(idxC003+1).toString().trim();
				        			if( !"".equals(sS003) && !"".equals(sE003) ) {
				            			iMM = Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length())) - Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length()));
				            			iSS = getDateGap(sS003,sE003);
				            					
			        					chaS0 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha003.put(idxC003,chaS0);
				        			}
				        			break;
				        		default:
				        			cha003.put(idxC003,"");
				        			break;
		        			}
		        		}
        			} else {
	        			for( int e003=0;e003<addrList003.length;e003++ ) {
	        				cha003.put(e003,"");
	        			}
	        		}
	        		
	        		fixedAlarmList.add(0,start003);
	        		fixedAlarmList.add(1,end003);
	        		fixedAlarmList.add(2,cha003);
	        		
	        		break;
	        	case "032":
	        		
	        		Map start032 = new HashMap();
            		Map end032 = new HashMap();
	        		Map cha032 = new HashMap();
	        		
	        		boolean bS032 = false;
	        		boolean bE032 = false;
	        		
	        		String[] addrList032 = strAddress.split(",");
	        		
	        		for( int idx032=0;idx032<addrList032.length;idx032++ ) {
	        			if( idx032%2 == 1 ) {
	        				
		        			dccSearchAlarm.setAddress(addrList032[idx032]);
			        		dccSearchAlarm.setpType(strPType+"0");
			        		
			        		dccSearchAlarm.setStartDate(strSDate);
			        		dccSearchAlarm.setEndDate(strEDate);
		        			
		        			List<DccAlarmInfo> dccAlarmInfoList032 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
		        			
		        			if( dccAlarmInfoList032.size() > 0 ) {
		        				
		        				String schSDate = "";
			        			String schEDate = "";
			        			
			        			for( DccAlarmInfo dccAlarmInfo032 : dccAlarmInfoList032 ) {
			        				if( Integer.parseInt(addrList032[idx032]) == Integer.parseInt(dccAlarmInfo032.getAlmAddress()) ) {			        					
			        					
			        					if( "N".equalsIgnoreCase(dccAlarmInfo032.getAlmGubun()) ) {
			        						schEDate = dccAlarmInfo032.getAlmDate().toString().trim();
			        					}
	        							if("A".equalsIgnoreCase(dccAlarmInfo032.getAlmGubun()) ) {
	        								schSDate = dccAlarmInfo032.getAlmDate().toString().trim();
			        					}
			        				}
			        			}
			        			
			        			//System.out.println("schEDate = " + schEDate + ":::::");
			        			//System.out.println("schSDate = " + schSDate + ":::::");
			        			
			        			for( int sub032=idx032-1;sub032<=idx032;sub032++ )  {
			        				LocalDateTime pSDate = convDtm(schSDate.trim(),false).minusSeconds(1);
			        				LocalDateTime pEDate = convDtm(schEDate.trim(),false).plusSeconds(30);
			                        DateTimeFormatter dtf032 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			        				
			        				String sSDate = pSDate.format(dtf032)+".000";
			        				String sEDate = pEDate.format(dtf032)+".999";
			        				
			        				//System.out.println("sSDate = " + sSDate + ":::::");
				        			//System.out.println("sEDate = " + sEDate + ":::::");
			        				
			        				dccSearchAlarm.setStartDate(sSDate);
			        				dccSearchAlarm.setEndDate(sEDate);
			        				dccSearchAlarm.setAddress(addrList032[sub032]);
					        		dccSearchAlarm.setpType(strPType+"1");
					        		
					        		List<DccAlarmInfo> dccAlarmInfoList0322 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
					        		//System.out.println("dccAlarmInfoList0322 size = " + dccAlarmInfoList0322.size() + ":::::");
					        		bS032 = false;
					        		bE032 = false;
					        		for( DccAlarmInfo dccAlarmInfo0322 : dccAlarmInfoList0322 ) {
					        			if( Integer.parseInt(addrList032[sub032]) == Integer.parseInt(dccAlarmInfo0322.getAlmAddress()) ) {
					        				if( "N".equalsIgnoreCase(dccAlarmInfo0322.getAlmGubun()) ) {
				        						end032.put(sub032,dccAlarmInfo0322.getAlmDate().toString().trim());
				        						//System.out.println("sub032 end = " + sub032 + ":::::" + end032.get(sub032));
				        					}
				        					if( "A".equalsIgnoreCase(dccAlarmInfo0322.getAlmGubun()) ) {
				        						start032.put(sub032,dccAlarmInfo0322.getAlmDate().toString().trim());
				        						//System.out.println("sub032 start = " + sub032 + ":::::" + start032.get(sub032));
				        					}
				        				}
					        		}
			        			}// end for sub032
			        			
			        			//System.out.println("int032 start = " + idx032 + ":::::");
	
		        				String sS032 = start032.get(idx032-1).toString().trim();
		        				String sS0321 = start032.get(idx032).toString().trim();
			        			if( !"".equals(sS032) && !"".equals(sS0321) ) {
			            			iMM = Integer.parseInt(sS032.substring(sS032.indexOf(".")+1,sS032.length())) - Integer.parseInt(sS0321.substring(sS0321.indexOf(".")+1,sS0321.length()));
			            			iSS = getDateGap(sS0321,sS032);
			            					
		        					String chaS0 = AlarmDateDiff(iMM,iSS);

			            			cha032.put(idx032-1,"");
			            			cha032.put(idx032,chaS0);
			        			}
		        			} else {
		        				start032.put(idx032-1,"");
		        				end032.put(idx032-1,"");
		        				start032.put(idx032,"");
		        				end032.put(idx032,"");
		        				cha032.put(idx032-1,"");
		        				cha032.put(idx032,"");
		        			}
	        			} // end if idx032%2 == 1 
	        		} // end for addrList032
	        		
	        		fixedAlarmList.add(0,start032);
	        		fixedAlarmList.add(1,end032);
	        		fixedAlarmList.add(2,cha032);
	        		
	        		break;
	        	case "114":
	        		Map start114 = new HashMap();
            		Map end114 = new HashMap();
	        		Map cha114 = new HashMap();
	        		
	        		String[] addrList114 = strAddress.split(",");

	        		dccSearchAlarm.setpType(strPType+"0");
	        		
	        		dccSearchAlarm.setStartDate(strSDate);
	        		dccSearchAlarm.setEndDate(strEDate);
	        		
	        		List<DccAlarmInfo> dccAlarmInfoList114 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
	        		
	        		if( dccAlarmInfoList114.size() > 0 ) {
	        			for( int idx114=0;idx114<addrList114.length;idx114++ ) {
			        		for( DccAlarmInfo dccAlarmInfo114 : dccAlarmInfoList114 ) {
		        				if( addrList114[idx114].equals(dccAlarmInfo114.getAlmAddress()) ) {
		        					if( "N".equalsIgnoreCase(dccAlarmInfo114.getAlmGubun()) ) {
		        						if( end114.get(idx114) == null ) {
		        							end114.put(idx114,dccAlarmInfo114.getAlmDate().toString().trim());
		        						}
		        					} else if( "A".equalsIgnoreCase(dccAlarmInfo114.getAlmGubun()) ) {
		        						if( start114.get(idx114) == null ) {
		        							start114.put(idx114,dccAlarmInfo114.getAlmDate().toString().trim());
		        						}
		        					}
		        				}
		        			}
			        		if( start114.get(idx114) == null ) start114.put(idx114,"");
			        		if( end114.get(idx114) == null ) end114.put(idx114,"");
		        		}
		        		
		        		for( int fi=0;fi<36;fi+=3 ) {
		        			//if( fi%3 == 0 ) {
		        				String sS114 = start114.get(fi) == null ? "" : start114.get(fi).toString().trim();
		        				String sS1141 = start114.get(fi+1) == null ? "" : start114.get(fi+1).toString().trim();
		        				String sS1142 = start114.get(fi+2) == null ? "" : start114.get(fi+2).toString().trim();
		            			String sE114 = end114.get(fi) == null ? "" : end114.get(fi).toString().trim();
		            			String sE1142 = end114.get(fi+2) == null ? "" : end114.get(fi+2).toString().trim();
		            		
			            		if( !"".equals(sS114) && !"".equals(sS1141) ) {
			            			iMM = Integer.parseInt(sS1141.substring(sS1141.indexOf(".")+1,sS1141.length())) - Integer.parseInt(sS114.substring(sS114.indexOf(".")+1,sS114.length()));
			            			iSS = Math.abs(getDateGap(sS114,sS1141));
			            					
		        					String chaS0 = AlarmDateDiff(iMM,iSS);
			            					
			            			cha114.put(fi,chaS0);
			            		}
			            		
			            		if( !"".equals(sS1141) && !"".equals(sS1142) ) {
			            			iMM = Integer.parseInt(sS1141.substring(sS1141.indexOf(".")+1,sS1141.length())) - Integer.parseInt(sS1142.substring(sS1142.indexOf(".")+1,sS1142.length()));
			            			iSS = Math.abs(getDateGap(sS1141,sS1142));
			            					
		        					String chaS1 = AlarmDateDiff(iMM,iSS);
			            					
			            			cha114.put(fi+1,chaS1);
			            		}
			            		
			            		if( !"".equals(sE1142) && !"".equals(sE114) ) {
			            			iMM = Integer.parseInt(sE1142.substring(sE1142.indexOf(".")+1,sE1142.length())) - Integer.parseInt(sE114.substring(sE114.indexOf(".")+1,sE114.length()));
			            			iSS = Math.abs(getDateGap(sE114,sE1142));
			            					
		        					String chaE1 = AlarmDateDiff(iMM,iSS);
			            					
			            			cha114.put(fi+2,chaE1);
			            		}

				        		if( cha114.get(fi) == null ) cha114.put(fi,"");
				        		if( cha114.get(fi+1) == null ) cha114.put(fi+1,"");
				        		if( cha114.get(fi+2) == null ) cha114.put(fi+2,"");
		        			//}
		        		}
	        		} else {
	        			for( int e114=0;e114<addrList114.length;e114++ ) {
	        				start114.put(e114,"");
	        				end114.put(e114,"");
	        				cha114.put(e114,"");
	        			}
	        		}
	        		
	        		fixedAlarmList.add(0,start114);
	        		fixedAlarmList.add(1,end114);
	        		fixedAlarmList.add(2,cha114);
	        		
	        		break;
	        	case "118":
	        		Map start118 = new HashMap();
            		Map bigo118 = new HashMap();
	        		Map forecolor118 = new HashMap();
            		
            		String[] addrList118 = strAddress.split(",");
            		
            		dccSearchAlarm.setpType(strPType+"0");
            		dccSearchAlarm.setAddress(addrList118[6]);
            		
            		//System.out.println("strPType = "+dccSearchAlarm.getpType());
            		
            		dccSearchAlarm.setStartDate(strSDate);
	        		dccSearchAlarm.setEndDate(strEDate);
            		
            		List<DccAlarmInfo> dccAlarmInfoList118 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
            		
            		String pDate = "";
            		for( int i=0;i<dccAlarmInfoList118.size();i++ ) {
        				if( "N".equalsIgnoreCase(dccAlarmInfoList118.get(i).getAlmGubun()) ) {
        					pDate = dccAlarmInfoList118.get(i).getAlmDate();
        					
        					i = dccAlarmInfoList118.size();
        				}
            		}
            		
            		if( !"".equals(pDate) ) {
            			String[] pDD = pDate.split(" ")[0].split("-");
            			String[] pDT = pDate.split(" ")[1].split(":");
            			
            			LocalDateTime pPDtm = convDtm(pDate,false);
                        LocalDateTime pSDtm = pPDtm.minusSeconds(10L);
                        LocalDateTime pEDtm = pPDtm.plusSeconds(10L);
                        DateTimeFormatter dtf118 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        
                        String sSDtm = pSDtm.format(dtf118);
                        String sEDtm = pEDtm.format(dtf118);
                        
                        dccSearchAlarm.setStartDate(sSDtm);
                        dccSearchAlarm.setEndDate(sEDtm);
                        dccSearchAlarm.setpType(strPType+"0");
                		dccSearchAlarm.setAddress(strAddress);
                        
                        List<DccAlarmInfo> dccAlarmInfoList1182 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
                        
                        if( dccAlarmInfoList1182.size() > 0 ) { 	                        	
		                    int idx118 = 0;		                        
		                       
                        	for( String address : addrList118 ) {
                        		
                        		boolean chk = false;
                        		
                        		for( DccAlarmInfo dccAlarmInfo1182 : dccAlarmInfoList1182 ) {	 
                        		
	                        		String tmpAlmDate = dccAlarmInfo1182.getAlmDate().toString().trim();
	                        		tmpAlmDate = tmpAlmDate.substring(0, tmpAlmDate.indexOf("."));
	                        		boolean isOK = false;
	                        		
	                        		if( LocalDateTime.parse(tmpAlmDate,dtf118).compareTo(pPDtm) < 0 ) isOK = true; 
	                        		
		                        		if( address.equals(dccAlarmInfo1182.getAlmAddress()) ) {
		                        			if( "A".equalsIgnoreCase(dccAlarmInfo1182.getAlmGubun()) && idx118 <= 5 && isOK  ) {
		                        				if( start118.get(idx118) == null ) start118.put(idx118,dccAlarmInfo1182.getAlmDate().toString().trim());
		                        			} else if( "N".equalsIgnoreCase(dccAlarmInfo1182.getAlmGubun()) && idx118 > 5 ) {
		                        				if( start118.get(idx118) == null ) start118.put(idx118,dccAlarmInfo1182.getAlmDate().toString().trim());
		                        			}
		                        			
		                        			chk = true;
		                        			                			
		                        			break;
		                        		}	  
                        		 }// end for dccAlarmInfoList1182
                        		
                        		 if(!chk) start118.put(idx118, "-");
                        		
                        		 System.out.println(idx118 + ":::: = " + start118.get(idx118));   
                        		 idx118++;	                        	
		                        	
	                        }// end for address
	                        
//	                        Double dDtV1 = 0d;
//	                        Double dDtV2 = 0d;
	                        String dtSDate = "";
	                        String dtEDate = "";
	                        
	                        for( int bi=0;bi<72;bi++ ) {
	                        	if( bi > 5 && "".equals(start118.get(bi)) ) {
	                        		bigo118.put(bi,"");
	                        	} else {
	                        		if( bi == 0 ) {
	                        			if( "".equals(start118.get(bi)) || "-".equals(start118.get(bi)) || start118.get(bi) == null) {
//	                        				dDtV1 = 0d;
	                        				dtSDate = "";
	                        			} else {
	                        				//System.out.println("bi = " + bi);
	                        				String rStart118 = start118.get(bi).toString();
	                        				dtSDate = rStart118;
//	                        				dDtV1 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + rStart118.substring(rStart118.length()-4,rStart118.length())));
	                        			}
	                        		} else if( bi > 0 && bi < 6 ) {
	                        			if( "-".equals(start118.get(bi)) || start118.get(bi) == null) {
//	                        				dDtV1 = dDtV1 != 0d ? dDtV1 : 0d;
	                        				dtSDate = !"".equals(dtSDate) ? dtSDate : "";
	                        			} else {
	                        				//Double tmpDtv1 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + addrList118[bi]));
	                        				String rStart118 = start118.get(bi).toString();
	                        				if( !"".equals(dtSDate) ) {
	                        					dtSDate = getDateGap(dtSDate,rStart118) < 0 ? rStart118 : dtSDate;
	                        				} else {
	                        					dtSDate = rStart118;
	                        				}
//	                        				Double tmpDtv1 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + rStart118.substring(rStart118.length()-4,rStart118.length())));
//	                        				if( dDtV1 <  tmpDtv1) {
//	                        					dDtV1 = tmpDtv1;
//	                        				}
	                        			}
	                        		} else {
	                        			String rStart118 = start118.get(bi).toString();
	                        			//Double tmpDtv2 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 * (Double.parseDouble("0" + addrList118[bi]));
//	                        			Double tmpDtv2 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + rStart118.substring(rStart118.length()-4,rStart118.length())));
//	                        			dDtV2 = tmpDtv2;
	                        			dtEDate = rStart118;
	                        			
//	                        			System.out.println("dDtV1 :: "+dDtV1+", dDtV2 :: "+dDtV2);
//	                        			if( dDtV2 - dDtV1 < 0 || dDtV1 == 0 ) {
//	                        				if( bi > 5 ) {
//	                        					//bigo118.put(bi,"");
//	                        				}
//	                        			} else {
//	                        				String input = String.valueOf(dDtV2 - dDtV1);
//	                        				//input = input.indexOf(".") > -1 ? input.substring(0,input.indexOf(".")+3) : input;
//	                        				System.out.println("["+bi+"] "+input);
//	                        				
//	                        				//bigo118.put(bi,input);
//	                        			}
	                        			
	                        			int tmpMM = Integer.parseInt(dtEDate.substring(dtEDate.length()-3,dtEDate.length())) - Integer.parseInt(dtSDate.substring(dtSDate.length()-3,dtSDate.length()));
	                        			int tmpSS = getDateGap(dtSDate,dtEDate);
	                        			
	                        			System.out.println("dtSDate :: "+dtSDate+", dtEDate :: "+dtEDate+", tmpMM :: "+tmpMM+", tmpSS :: "+tmpSS);
	                        			if( tmpSS < 0 || "".equals(dtSDate) ) {
	                        				bigo118.put(bi,"");
	                        			} else {
	                        				String tmpInput = String.valueOf(AlarmDateDiff(tmpMM,tmpSS));
	                        				bigo118.put(bi,tmpInput);
	                        			}
	                        		}
	                        	}
	                        }
	                        

            				String[] titles = strTitle.split(",");

        					List<String> G1 = new ArrayList<String>();
        					List<String> G2 = new ArrayList<String>();
        					
        					String[] G1Set = {"15","16"};
        					for( String g1Item : G1Set ) {
            					G1.add(g1Item);
        					}
        					
        					String[] G2Set = {"13","14","29","30","31","32"};
        					for( String g2Item : G2Set ) {
            					G2.add(g2Item);
        					}
        					
        					String color = "";
        					
        					int ti=6;
        					for( String title : titles ) {
        						if(title.equals("-")) continue;
            					String chk = title.substring(title.length()-2,title.length());
            					

        						if( bigo118.get(ti) != null && !"".equals(bigo118.get(ti).toString()) ) {
	            					if( G1.contains(chk) ) {
	            						if( Double.parseDouble(bigo118.get(ti).toString()) > 1.1 ) {
	            							color = "red";
	            						} else {
	            							color = "blue";
	            						}
	            					} else if( G2.contains(chk) ) {
	            						if( Double.parseDouble(bigo118.get(ti).toString()) > 1.15 ) {
	            							color = "red";
	            						} else {
	            							color = "green";
	            						}
	            					} else {
            							if( Double.parseDouble(bigo118.get(ti).toString()) > 2 ) {
	            							color = "red";
	            						} else {
	            							color = "black";
	            						}
            						}
            					} else {
            						color = "black";
            					}
            					forecolor118.put(ti,color);
            					ti++;
            				}
                        }
            		} else {
            			for( int e118=0;e118<addrList118.length;e118++ ) {
            				start118.put(e118,"");
            				bigo118.put(e118,"");
            				forecolor118.put(e118,"");
            			}
            		}
            		
            		fixedAlarmList.add(0,start118);
            		fixedAlarmList.add(1,bigo118);
            		fixedAlarmList.add(2,forecolor118);
            		
	        		break;
	        	case "276":
	        		Map start276 = new HashMap();
            		Map end276 = new HashMap();
            		Map cha276 = new HashMap();
            		
            		String[] addrList276 = strAddress.split(",");
            		
            		dccSearchAlarm.setpType(strPType+"0");
            		
            		List<DccAlarmInfo> dccAlarmInfoList276 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
            		
            		if( dccAlarmInfoList276.size() > 0 ) {
		        		for( DccAlarmInfo dccAlarmInfo276 : dccAlarmInfoList276 ) {
		            		int idx276=0;
		        			for( String address : addrList276 ) {
		        				if( address.equals(dccAlarmInfo276.getAlmAddress()) ) {
		        					if( "A".equalsIgnoreCase(dccAlarmInfo276.getAlmGubun()) ) {
		        						start276.put(idx276,dccAlarmInfo276.getAlmDate());
		        					} else if( "N".equalsIgnoreCase(dccAlarmInfo276.getAlmGubun()) ) {
		        						end276.put(idx276,dccAlarmInfo276.getAlmDate());
		        					}
		        				}
			        			idx276++;
		        			}
		        		}
		        		
		        		for( int ad=0;ad<24;ad++ ) {
		        			if( !"".equals(start276.get(ad)) || !"".equals(start276.get(ad+1)) ) {
		            			String sS276 = start276.get(ad).toString().trim();
		            			String sE276 = end276.get(ad).toString().trim();
		            			int iS276 = Integer.parseInt(sS276.substring(sS276.indexOf("."),sS276.length()));
		            			int iE276 = Integer.parseInt(sE276.substring(sE276.indexOf("."),sE276.length()));

		            			iSS = getDateGap(sS276,sE276);
		            			
		            			if( iS276 > iE276 ) {
		            				iSS--;
		            				iMM = 1000;
		            			} else {
		            				iMM = 0;
		            			}
		            			iMM = iMM + iE276 - iS276;
		            			
		            			String sMM = String.valueOf(iMM);
		            			sMM = sMM.length() > 3 ? sMM.substring(0,3) : sMM;
		            			
		            			while( sMM.length() < 3 ) {
		            				sMM += "0";
		            			}
		            			
		            			cha276.put(ad,String.valueOf(sMM)+"."+sMM);
		        			}
		        		}
            		} else {
            			for( int e276=0;e276<addrList276.length;e276++ ) {
            				start276.put(e276,"");
            				end276.put(e276,"");
            				cha276.put(e276,"");
            			}
            		}
            		
        			fixedAlarmList.add(0,start276);
        			fixedAlarmList.add(1,end276);
        			fixedAlarmList.add(2,cha276);
            		
	        		break;
	        	case "550":
	        		String strAlarmGubun = dccSearchAlarm.getAlarmGubun();

            		Map startS = new HashMap();
            		Map endS = new HashMap();
            		Map startA = new HashMap();
            		Map endA = new HashMap();
            		Map startB = new HashMap();
            		Map endB = new HashMap();
            		Map chaS = new HashMap();
            		Map chaSColor = new HashMap();
            		Map chaA = new HashMap();
            		Map chaAColor = new HashMap();
            		Map chaB = new HashMap();
            		Map chaBColor = new HashMap();
	        		
	            	for( int ai=0;ai<strAlarmGubun.split(",").length;ai++ ) {
	            		dccSearchAlarm.setAlarmGubun(strAlarmGubun.split(",")[ai]);
	            		dccSearchAlarm.setAddress(strAddress.split(",")[ai]);
	            		if( ai < 2 ) {
	            			dccSearchAlarm.setpType(strPType+"0");
	            		} else {
	            			dccSearchAlarm.setpType(strPType+"1");
	            		}
	            		List<DccAlarmInfo> dccAlarmInfoList550 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
	            		int idx=0;
	            		
	            		if( dccAlarmInfoList550.size() > 0 ) {
		            		if( ai == 0 ) {
		            			startS.put(0, dccAlarmInfoList550.get(0).getAlmDate().toString());
		            		} else if ( ai == 1 ) {
		            			endS.put(0, dccAlarmInfoList550.get(0).getAlmDate().toString());
		            		} else if ( ai == 2 ) {
		            			for( int sa=0;sa<10;sa++ ) {
		            				if( sa >= dccAlarmInfoList550.size() ) {
		            					startA.put(9-sa, "");
		            				} else {
		            					startA.put(9-sa, dccAlarmInfoList550.get(sa).getAlmDate().toString());
		            				}
		            			}
		            		} else if ( ai == 3 ) {
		            			for( int ea=0;ea<10;ea++ ) {
		            				if( ea >= dccAlarmInfoList550.size() ) {
		            					endA.put(9-ea, "");
		            				} else {
		            					endA.put(9-ea, dccAlarmInfoList550.get(ea).getAlmDate().toString());
		            				}
		            			}
		            		} else if ( ai == 4 ) {
		            			for( int sb=0;sb<10;sb++ ) {
		            				if( sb >= dccAlarmInfoList550.size() ) {
		            					startB.put(9-sb, "");
		            				} else {
		            					startB.put(9-sb, dccAlarmInfoList550.get(sb).getAlmDate().toString());
		            				}
		            			}
		            		} else if ( ai == 5 ) {
		            			for( int eb=0;eb<10;eb++ ) {
		            				if( eb >= dccAlarmInfoList550.size() ) {
		            					endB.put(9-eb, "");
		            				} else {
		            					endB.put(9-eb, dccAlarmInfoList550.get(eb).getAlmDate().toString());
		            				}
		            			}
		            		}
	            		}
	            	}
	            	
	            	if( startS.size() > 0 ) {
		            	for( int ci=0;ci<startA.size();ci++ ) {
	            			String sSS = startS.get(ci) == null ? "" : startS.get(ci).toString().trim();
	            			String sES = endS.get(ci) == null ? "" : endS.get(ci).toString().trim();
	            			String sSA = startA.get(ci) == null ? "" : startA.get(ci).toString().trim();
	            			String sEA = endA.get(ci) == null ? "" : endA.get(ci).toString().trim();
	            			String sSB = startB.get(ci) == null ? "" : startB.get(ci).toString().trim();
	            			String sEB = endB.get(ci) == null ? "" : endB.get(ci).toString().trim();
	            		
		            		if( !"".equals(sSS) && !"".equals(sES) ) {
		            			if( ci == 0 ) {
			            			iMM = Integer.parseInt(sES.substring(sES.indexOf(".")+1,sES.length())) - Integer.parseInt(sSS.substring(sSS.indexOf(".")+1,sSS.length()));
			            			iSS = getDateGap(sSS,sES);
			            					
		        					String chaS0 = AlarmDateDiff(iMM,iSS);
			            					
			            			chaS.put(0,chaS0);
			            			if( Double.parseDouble(chaS0.replace(":","")) > 2.25 ) {
			            				chaSColor.put(0,"red");
			            			} else {
			            				chaSColor.put(0,"black");
			            			}
		            			}
		            		} else {
		            			if( ci == 0 ) {
			            			chaS.put(0,"");
		            				chaSColor.put(0,"black");
		            			}
		            		}
		            		
		            		if ( !"".equals(sSA) && !"".equals(sEA) ) {
		            			iMM = Integer.parseInt(sEA.substring(sEA.indexOf(".")+1,sEA.length())) - Integer.parseInt(sSA.substring(sSA.indexOf(".")+1,sSA.length()));
		            			iSS = getDateGap(sSA,sEA);
		            					
	        					String chaAi = AlarmDateDiff(iMM,iSS);
		            					
		            			chaA.put(ci,chaAi);
		            			if( ci == 0 ) {
			            			if( Double.parseDouble(chaAi.replace(":","")) > 4.75 ) {
			            				chaAColor.put(ci,"red");
			            			} else {
			            				chaAColor.put(ci,"black");
			            			}
		            			} else {
		            				if( Double.parseDouble(chaAi.replace(":","")) > 7 ) {
			            				chaAColor.put(ci,"red");
			            			} else {
			            				chaAColor.put(ci,"black");
			            			}
		            			}
		            		} else {
		            			chaA.put(ci,"");
	            				chaAColor.put(ci,"black");
		            		}
		            		
		            		if ( !"".equals(sSB) && !"".equals(sEB) ) {
		            			iMM = Integer.parseInt(sEB.substring(sEB.indexOf(".")+1,sEB.length())) - Integer.parseInt(sSB.substring(sSB.indexOf(".")+1,sSB.length()));
		            			iSS = getDateGap(sSB,sEB);
		            					
	        					String chaBi = AlarmDateDiff(iMM,iSS);
		            					
		            			chaB.put(ci,chaBi);
		            			if( ci == 0 ) {
			            			if( Double.parseDouble(chaBi.replace(":","")) > 7 && Double.parseDouble(chaBi.replace(":","")) < 15 ) {
			            				chaBColor.put(ci,"red");
			            			} else {
			            				chaBColor.put(ci,"black");
			            			}
		            			}
		            		} else {
		            			chaB.put(ci,"");
		            			chaBColor.put(ci,"black");
		            		}
		            	}
	            	} else {
            			for( int e550=0;e550<10;e550++ ) {
            				if( e550 == 0 ) {
	            				startS.put(0,"");
	            				endS.put(0,"");
            					chaS.put(0,"");
            					chaSColor.put(0,"");
            				}
            				startA.put(e550,"");
            				endA.put(e550,"");
            				startB.put(e550,"");
            				endB.put(e550,"");
            				chaA.put(e550,"");
            				chaAColor.put(e550,"");
            				chaB.put(e550,"");
            				chaBColor.put(e550,"");
            			}
            		}
	            	
            		fixedAlarmList.add(0,startS);
            		fixedAlarmList.add(1,endS);
            		fixedAlarmList.add(2,startA);
            		fixedAlarmList.add(3,endA);
            		fixedAlarmList.add(4,startB);
            		fixedAlarmList.add(5,endB);
            		fixedAlarmList.add(6,chaS);
            		fixedAlarmList.add(7,chaSColor);
            		fixedAlarmList.add(8,chaA);
            		fixedAlarmList.add(9,chaAColor);
            		fixedAlarmList.add(10,chaB);
            		fixedAlarmList.add(11,chaBColor);
            		
                	dccSearchAlarm.setAlarmGubun(strAlarmGubun);
	        		
	        		break;
	        	case "cor":
	        		Map startCha = new HashMap();
            		Map endCha = new HashMap();
            		Map valCha = new HashMap();
            		Map valChaCha = new HashMap();
	        		
	        		String[] addrListCor = strAddress.split(",");
	        		
	        		for( int idxC=0;idxC<addrListCor.length;idxC+=2 ) {
	        			if( idxC%2 == 0 ) {
	        				dccSearchAlarm.setStartDate(strSDate);
	        				dccSearchAlarm.setEndDate(strEDate);
	    	        		dccSearchAlarm.setpType(strPType+"e0");
		        			dccSearchAlarm.setAddress(addrListCor[idxC]);
		        			
			        		List<DccAlarmInfo> dccAlarmInfoListCor = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
			        		
			        		String sSC = "";
			        		String sEC = "";
			        		String sSC2 = "";
			        		String sEC2 = "";
			        		if( dccAlarmInfoListCor.size() > 0 ) {
				        		for( DccAlarmInfo dccAlarmInfoCor : dccAlarmInfoListCor ) {
				        			if( addrListCor[idxC].equals(dccAlarmInfoCor.getAlmAddress()) ) {
				        				if( "N".equalsIgnoreCase(dccAlarmInfoCor.getAlmGubun()) ) {
				        					endCha.put(idxC,dccAlarmInfoCor.getAlmDate());
				        				}
				        				if( "A".equalsIgnoreCase(dccAlarmInfoCor.getAlmGubun()) ) {
				        					startCha.put(idxC,dccAlarmInfoCor.getAlmDate());
				        				}
				        			}
				        		}
				        				
		            			sSC = startCha.get(idxC) != null ? startCha.get(idxC).toString().trim() : "";
		            			sEC = endCha.get(idxC) != null ? endCha.get(idxC).toString().trim() : "";
	
		            			if( !"".equals(sSC) && !"".equals(sEC) ) {
			            			iMM = Integer.parseInt(sEC.substring(sEC.indexOf(".")+1,sEC.length())) - Integer.parseInt(sSC.substring(sSC.indexOf(".")+1,sSC.length()));
			            			iSS = getDateGap(sSC,sEC);

			            			String strValCha = AlarmDateDiff(iMM,iSS);
			            			if( !"***IRR".equals(strValCha) ) {
			            				strValCha = String.valueOf(Math.abs(Double.parseDouble(strValCha)));
			            			}
			            			
			            			valCha.put(idxC,strValCha);
		            			} else {
		            				valCha.put(idxC,"");
		            			}

		            			if( !"".equals(sSC) && !"".equals(sEC) ) {
			            			
			            			dccSearchAlarm.setStartDate(sSC);
			    	        		dccSearchAlarm.setpType(strPType+"e1");
			            			
			            			List<DccAlarmInfo> dccAlarmInfoListCor2 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
		            			
			            			for( DccAlarmInfo dccAlarmInfoCor2 : dccAlarmInfoListCor2 ) {
					        			if( addrListCor[idxC+1].equals(dccAlarmInfoCor2.getAlmAddress()) ) {
					        				if( "N".equalsIgnoreCase(dccAlarmInfoCor2.getAlmGubun()) ) {
					        					endCha.put(idxC+1,dccAlarmInfoCor2.getAlmDate());
					        				}
					        				if( "A".equalsIgnoreCase(dccAlarmInfoCor2.getAlmGubun()) ) {
					        					startCha.put(idxC+1,dccAlarmInfoCor2.getAlmDate());
					        				}
					        			}
			            			}
					        				
			        				sSC2 = startCha.get(idxC+1) != null ? startCha.get(idxC+1).toString().trim() : "";
			            			sEC2 = endCha.get(idxC+1) != null ? endCha.get(idxC+1).toString().trim() : "";
			            			
			            			if( startCha.get(idxC+1) == null ) startCha.put(idxC+1,sSC2);
			            			if( endCha.get(idxC+1) == null ) endCha.put(idxC+1,sEC2);

			            			if( !"".equals(sSC2) && !"".equals(sEC2) ) {
				            			iMM = Integer.parseInt(sEC2.substring(sEC2.indexOf(".")+1,sEC2.length())) - Integer.parseInt(sSC2.substring(sSC2.indexOf(".")+1,sSC2.length()));
				            			iSS = getDateGap(sSC2,sEC2);

				            			String strValCha2 = AlarmDateDiff(iMM,iSS);
				            			if( !"***IRR".equals(strValCha2) ) {
				            				strValCha2 = String.valueOf(Math.abs(Integer.parseInt(strValCha2)));
				            			}
				            			
				            			valCha.put(idxC+1,strValCha2);
				            			
				            			iMM = Integer.parseInt(sEC2.substring(sEC2.indexOf(".")+1,sEC2.length())) - Integer.parseInt(sSC.substring(sSC.indexOf(".")+1,sSC.length()));
				            			iSS = getDateGap(sSC2,sSC);

				            			String strValChaCha = AlarmDateDiff(iMM,iSS);
				            			if( !"***IRR".equals(strValChaCha) ) {
				            				strValChaCha = String.valueOf(Math.abs(Integer.parseInt(strValChaCha)));
				            			}
				            			
				            			valChaCha.put((idxC+1)/2,strValChaCha);
			            			} else {
			            				valCha.put(idxC+1,"");
			            				valChaCha.put((idxC+1)/2,"");
			            			}
			        			}
	            			} else {
			        			for( int eCor=0;eCor<addrListCor.length;eCor++ ) {
			        				if( eCor%2 == 0 ) {
			        					startCha.put(eCor,"");
			        					startCha.put(eCor+1,"");
			        					endCha.put(eCor,"");
			        					endCha.put(eCor+1,"");
			        					valCha.put(eCor,"");
			        					valCha.put(eCor+1,"");
			        					valChaCha.put(eCor,"");
			        				}
			        			}
			        		}
	        			}
	        		}
	        		
	        		fixedAlarmList.add(0,startCha);
	        		fixedAlarmList.add(1,endCha);
	        		fixedAlarmList.add(2,valCha);
	        		fixedAlarmList.add(3,valChaCha);
	        		
	        		break;
	        	case "285":
            		Map lrfInfo = new HashMap();
            		Map resInfo = new HashMap();
            		Map moiInfo = new HashMap();
            		
	        		dccSearchAlarm.setpType(strPType+"0");
	            	dccSearchAlarm.setAddress(lblMOI);
	            	
	            	boolean bL285 = false;
	        		
	            	List<DccAlarmInfo> dccAlarmInfoList285 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);

            		if( dccAlarmInfoList285.size() > 0 ) {
		            	for( DccAlarmInfo dccAlarmInfo285 : dccAlarmInfoList285 ) {
			            	int moiIdx=0;
		            		for( String itemMOI : lblMOI.split(",") ) {
		            			if( itemMOI.trim().equals(dccAlarmInfo285.getAlmAddress().trim()) ) {
		            				if( "A".equalsIgnoreCase(dccAlarmInfo285.getAlmGubun()) && moiInfo.get(moiIdx) == null ) {
		            					moiInfo.put(moiIdx, dccAlarmInfo285.getAlmDate().trim());
		            				}
		            			}
			            		moiIdx++;
		            		}
		            	}
            		} else {
            			for( int e285=0;e285<lblMOI.split(",").length;e285++ ) {
            				moiInfo.put(e285,"");
            			}
            		}
	            	
            		if( moiInfo.size() > 0 &&  !"".equals(moiInfo.get(0)) ) {
		            	dccSearchAlarm.setpType(strPType+"1");
		            	int lrfIdx=0;
		            	String[] lblLrfList = lblLRF.split(",");
		            	for( String itemLRF : lblLrfList ) {
		            		String tmpDate = moiInfo.get(lrfIdx/2) == null ? "" : moiInfo.get(lrfIdx/2).toString();
		            		if( !"".equals(tmpDate) ) {
		            			dccSearchAlarm.setStartDate(tmpDate);
		            			dccSearchAlarm.setAddress(lblLrfList[lrfIdx]);
		                    	List<DccAlarmInfo> dccAlarmInfoList2852 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
		                    	bL285 = false;
		                    	
		                    	if( dccAlarmInfoList2852.size() > 0 ) {
			    	            	for( DccAlarmInfo dccAlarmInfo2852 : dccAlarmInfoList2852 ) {
		    	            			if( itemLRF.equals(dccAlarmInfo2852.getAlmAddress()) ) {
		    	            				if( !bL285 && "A".equalsIgnoreCase(dccAlarmInfo2852.getAlmGubun()) ) {
		    	            					lrfInfo.put(lrfIdx, dccAlarmInfo2852.getAlmDate().trim());
		    	            					bL285 = true;
		    	            				}
		    	            			}
	    	            				
	    	            				String almDate = dccAlarmInfo2852.getAlmDate().trim();
	    	            				
		    	            			int moiMilli = Integer.parseInt(tmpDate.substring(tmpDate.indexOf(".")+1,tmpDate.length()));
	    	            				int lrfMilli = Integer.parseInt(almDate.substring(almDate.indexOf(".")+1,almDate.length()));
	
	        	            			iSS = getDateGap(tmpDate,almDate);
	        	            			if( moiMilli > lrfMilli ) {
	        	            				iSS = iSS -1;
	        	            				iMM = 1000;
	        	            			}
	        	            			iMM += (lrfMilli-moiMilli);
	        	            			
	        	            			String sMM = String.valueOf(iMM);
	        	            			while( sMM.length() < 3 ) {
	        	            				sMM = "0" + sMM;
	        	            			}
	        	            			
	        	            			String res = String.valueOf(iSS)+"."+sMM;
	        	            			Double dRes = Double.parseDouble(res);
	        	            			if( dRes > 29.504 && dRes < 29.996 ) {
	        	            				res += " (Y)";
	        	            			} else if( dRes <= 29.504 ) {
	        	            				res += " (SHT)";
	        	            			} else if( dRes >= 29.996 ) {
	        	            				res += " (LNG)";
	        	            			}
	        	            			resInfo.put(lrfIdx,res);
			    	            	}
		                    	} else {
			            			lrfInfo.put(lrfIdx,"");
			            			resInfo.put(lrfIdx,"");
		                    	}
		            		}
		            		lrfIdx++;
		            	}
            		} else {
	            		for( int e285=0;e285<lblLRF.split(",").length;e285++ ) {
	            			lrfInfo.put(e285,"");
	            			resInfo.put(e285,"");
	            		}
            		}
            		
            		fixedAlarmList.add(0,moiInfo);
            		fixedAlarmList.add(1,lrfInfo);
            		fixedAlarmList.add(2,resInfo);
            		
	        		break;
        	}
        	
        	dccSearchAlarm.setStartDate(strSDate);
        	dccSearchAlarm.setEndDate(strEDate);
        	dccSearchAlarm.setpType(strPType);
        	dccSearchAlarm.setAddress(strAddress);
        	
        	mav.addObject("FixedAlarmList", fixedAlarmList);
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
        	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
        	
        }
        

        return mav;
    }
	
	@RequestMapping(value = "reloadFTC", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView reloadFTC(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ fixedtimecontrol");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
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
        	
        	if( dccSearchAlarm.getHogiHeader() != null ) {
        		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
        	} else {
        		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
        	}
        	if( dccSearchAlarm.getXyHeader() != null ) {
        		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
        	} else {
        		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
        	}
        	if( dccSearchAlarm.getIoType() == null || "".equals(dccSearchAlarm.getIoType()) ) dccSearchAlarm.setIoType("AI");
        	if( dccSearchAlarm.getIoBit() == null || "".equals(dccSearchAlarm.getIoBit()) ) dccSearchAlarm.setIoBit("0");
        	if( dccSearchAlarm.getSaveCore() == null ) dccSearchAlarm.setSaveCore("0");
        	if( dccSearchAlarm.getsDive() == null ) dccSearchAlarm.setsDive("D");
        	if( dccSearchAlarm.getpType() == null ) dccSearchAlarm.setpType("114");
        	if( dccSearchAlarm.getAddress() == null ) dccSearchAlarm.setAddress("|");
        	String strPType = dccSearchAlarm.getpType();
        	String strAddress = dccSearchAlarm.getAddress();
        	String[] lbl285 = strAddress.indexOf("|") > -1 ? strAddress.split("\\|") : new String[] {};
        	String lblMOI = lbl285.length > 1 ? lbl285[0] : "";
        	String lblLRF = lbl285.length > 1 ? lbl285[1] : "";
        	String strSDate = dccSearchAlarm.getStartDate();
        	String strEDate = dccSearchAlarm.getEndDate();
        	String strTitle = dccSearchAlarm.getTitle();

        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

        	List<Map> fixedAlarmList = new ArrayList<Map>();
        	
        	int iMM = 0;
        	int iSS = 0;
        	
        	switch( strPType ) {
	        	case "003":
	        		Map start003 = new HashMap();
            		Map end003 = new HashMap();
	        		Map cha003 = new HashMap();
	        		
	        		boolean bS003 = false;
    				boolean bE003 = false;
	        		
    				//System.out.println(strAddress);
    				
	        		String[] addrList003 = strAddress.split(",");	        		
	        		
	        		for( int idx003=0;idx003<addrList003.length;idx003++ ) {
	        			if( idx003%6 == 5 ) {
	        				
		        			dccSearchAlarm.setAddress(addrList003[idx003]);
			        		dccSearchAlarm.setpType(strPType+"0");
			        		
			        		dccSearchAlarm.setStartDate(strSDate);
			        		dccSearchAlarm.setEndDate(strEDate);
	        				
			        		List<DccAlarmInfo> dccAlarmInfoList003 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
			        		
			        		if( dccAlarmInfoList003.size() > 0 ) {
			        			
			        			String schSDate = "";
			        			String schEDate = "";
			        			
			        			for( DccAlarmInfo dccAlarmInfo003 : dccAlarmInfoList003 ) {			        				
			        				
			        				if( Integer.parseInt(addrList003[idx003].trim()) == Integer.parseInt(dccAlarmInfo003.getAlmAddress().trim()) ) {
			        					if("N".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
			        						schEDate = dccAlarmInfo003.getAlmDate().toString().trim();	
			        						end003.put(idx003,schEDate);					                      
			        					}
			        					if("A".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
			        						schSDate = dccAlarmInfo003.getAlmDate().toString().trim();
			        						start003.put(idx003,schSDate);
			        					}
			        				}
			        			}
			        			
			        			for( int sub003=idx003-5;sub003<idx003;sub003++ ) {
			        				LocalDateTime pSDate = convDtm(schSDate.trim(),false).minusSeconds(1);
			        				LocalDateTime pEDate = convDtm(schEDate.trim(),false).plusMinutes(2);
			                        DateTimeFormatter dtf003 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			        				
			        				String sSDate = pSDate.format(dtf003)+".000";
			        				String sEDate = pEDate.format(dtf003)+".999";
			        				
			        				dccSearchAlarm.setAddress(addrList003[sub003]);
			        				dccSearchAlarm.setStartDate(sSDate);
			        				dccSearchAlarm.setEndDate(sEDate);
			        				
			        				if( idx003 == 5 || idx003 == 11 || idx003 == 17 ) {
			        					dccSearchAlarm.setpType(strPType+"1");
			        				} else {
			        					dccSearchAlarm.setpType(strPType+"2");
			        				}
			        				
			        				List<DccAlarmInfo> dccAlarmInfoList0032 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
			        				
			        				//System.out.println("idx = " + sub003 + "::::: size = " + dccAlarmInfoList0032.size());
			        				
			        				bS003 = false;
			        				bE003 = false;
			        				for( DccAlarmInfo dccAlarmInfo003 : dccAlarmInfoList0032 ) {

			        					if( Integer.parseInt(addrList003[sub003].trim()) == Integer.parseInt(dccAlarmInfo003.getAlmAddress().trim()) ) {
			        						if("N".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
				        						end003.put(sub003,dccAlarmInfo003.getAlmDate().toString().trim());
				        						
				        						//System.out.println("idx = " + sub003 + "::::: end003 = " + end003.get(sub003));
				        					}
				        					if("A".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
				        						start003.put(sub003,dccAlarmInfo003.getAlmDate().toString().trim());
				        						
				        						//System.out.println("idx = " + sub003 + "::::: start003 = " + start003.get(sub003));
				        					}
				        				}
			        				}			        				 
			        			}
			        		} else {
			        			for( int e003=0;e003<addrList003.length;e003++ ) {
			        				start003.put(e003,"");
			        				end003.put(e003,"");
			        			}
			        		}
	        			} // end if gap = 5
	        		} // end for gap

	        		if( start003.size() > 0 && !"".equals(start003.get(0)) ) {
		        		for( int idxC003=0;idxC003<addrList003.length;idxC003++ ) {
		        			String sS003 = "";
		        			String sE003 = "";
		        			String chaS0 = "";
		        			switch( idxC003 ) {
			        			case 0: case 6: case 12: case 18: case 24: case 30:
				        			sS003 = start003.get(idxC003).toString().trim();
				        			sE003 = start003.get(idxC003+1).toString().trim();
				        			if( !"".equals(sS003) && !"".equals(sE003) ) {
				            			iMM = Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length())) - Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length()));
				            			iSS = getDateGap(sE003,sS003);
				            					
			        					chaS0 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha003.put(idxC003,chaS0);
				        			}
				        			break;
			        			case 1: case 7: case 13: case 19: case 25: case 31:
			        				sS003 = start003.get(idxC003).toString().trim();
			        				sE003 = start003.get(idxC003+1).toString().trim();
				        			if( !"".equals(sS003) && !"".equals(sE003) ) {
				            			iMM = Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length())) - Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length()));
				            			iSS = getDateGap(sS003,sE003);
				            					
			        					chaS0 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha003.put(idxC003,chaS0);
				        			}
				        			break;
			        			case 2: case 8: case 14: case 20: case 26: case 32:
			        				sS003 = end003.get(idxC003-2).toString().trim();
			        				sE003 = end003.get(idxC003+1).toString().trim();
				        			if( !"".equals(sS003) && !"".equals(sE003) ) {
				        				iMM = Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length())) - Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length()));
				            			iSS = getDateGap(sS003,sE003);
				            					
			        					chaS0 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha003.put(idxC003,chaS0);
				        			}
				        			break;
			        			case 3: case 9: case 15: case 21: case 27: case 33:
			        				sS003 = end003.get(idxC003-1).toString().trim();
			        				sE003 = end003.get(idxC003+1).toString().trim();
				        			if( !"".equals(sS003) && !"".equals(sE003) ) {
				            			iMM = Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length())) - Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length()));
				            			iSS = getDateGap(sS003,sE003);
				            					
			        					chaS0 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha003.put(idxC003,chaS0);
				        			}
				        			break;
				        		default:
				        			cha003.put(idxC003,"");
				        			break;
		        			}
		        		}
        			} else {
	        			for( int e003=0;e003<addrList003.length;e003++ ) {
	        				cha003.put(e003,"");
	        			}
	        		}
	        		
	        		fixedAlarmList.add(0,start003);
	        		fixedAlarmList.add(1,end003);
	        		fixedAlarmList.add(2,cha003);
	        		
	        		break;
	        	case "032":
	        		
	        		Map start032 = new HashMap();
            		Map end032 = new HashMap();
	        		Map cha032 = new HashMap();
	        		
	        		boolean bS032 = false;
	        		boolean bE032 = false;
	        		
	        		String[] addrList032 = strAddress.split(",");
	        		
	        		for( int idx032=0;idx032<addrList032.length;idx032++ ) {
	        			if( idx032%2 == 1 ) {
	        				
		        			dccSearchAlarm.setAddress(addrList032[idx032]);
			        		dccSearchAlarm.setpType(strPType+"0");
			        		
			        		dccSearchAlarm.setStartDate(strSDate);
			        		dccSearchAlarm.setEndDate(strEDate);
		        			
		        			List<DccAlarmInfo> dccAlarmInfoList032 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
		        			
		        			if( dccAlarmInfoList032.size() > 0 ) {
		        				
		        				String schSDate = "";
			        			String schEDate = "";
			        			
			        			for( DccAlarmInfo dccAlarmInfo032 : dccAlarmInfoList032 ) {
			        				if( Integer.parseInt(addrList032[idx032]) == Integer.parseInt(dccAlarmInfo032.getAlmAddress()) ) {			        					
			        					
			        					if( "N".equalsIgnoreCase(dccAlarmInfo032.getAlmGubun()) ) {
			        						schEDate = dccAlarmInfo032.getAlmDate().toString().trim();
			        					}
	        							if("A".equalsIgnoreCase(dccAlarmInfo032.getAlmGubun()) ) {
	        								schSDate = dccAlarmInfo032.getAlmDate().toString().trim();
			        					}
			        				}
			        			}
			        			
			        			//System.out.println("schEDate = " + schEDate + ":::::");
			        			//System.out.println("schSDate = " + schSDate + ":::::");
			        			
			        			for( int sub032=idx032-1;sub032<=idx032;sub032++ )  {
			        				LocalDateTime pSDate = convDtm(schSDate.trim(),false).minusSeconds(1);
			        				LocalDateTime pEDate = convDtm(schEDate.trim(),false).plusSeconds(30);
			                        DateTimeFormatter dtf032 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			        				
			        				String sSDate = pSDate.format(dtf032)+".000";
			        				String sEDate = pEDate.format(dtf032)+".999";
			        				
			        				//System.out.println("sSDate = " + sSDate + ":::::");
				        			//System.out.println("sEDate = " + sEDate + ":::::");
			        				
			        				dccSearchAlarm.setStartDate(sSDate);
			        				dccSearchAlarm.setEndDate(sEDate);
			        				dccSearchAlarm.setAddress(addrList032[sub032]);
					        		dccSearchAlarm.setpType(strPType+"1");
					        		
					        		List<DccAlarmInfo> dccAlarmInfoList0322 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
					        		//System.out.println("dccAlarmInfoList0322 size = " + dccAlarmInfoList0322.size() + ":::::");
					        		bS032 = false;
					        		bE032 = false;
					        		for( DccAlarmInfo dccAlarmInfo0322 : dccAlarmInfoList0322 ) {
					        			if( Integer.parseInt(addrList032[sub032]) == Integer.parseInt(dccAlarmInfo0322.getAlmAddress()) ) {
					        				if( "N".equalsIgnoreCase(dccAlarmInfo0322.getAlmGubun()) ) {
				        						end032.put(sub032,dccAlarmInfo0322.getAlmDate().toString().trim());
				        						//System.out.println("sub032 end = " + sub032 + ":::::" + end032.get(sub032));
				        					}
				        					if( "A".equalsIgnoreCase(dccAlarmInfo0322.getAlmGubun()) ) {
				        						start032.put(sub032,dccAlarmInfo0322.getAlmDate().toString().trim());
				        						//System.out.println("sub032 start = " + sub032 + ":::::" + start032.get(sub032));
				        					}
				        				}
					        		}
			        			}// end for sub032
			        			
			        			//System.out.println("int032 start = " + idx032 + ":::::");
	
		        				String sS032 = start032.get(idx032-1).toString().trim();
		        				String sS0321 = start032.get(idx032).toString().trim();
			        			if( !"".equals(sS032) && !"".equals(sS0321) ) {
			            			iMM = Integer.parseInt(sS032.substring(sS032.indexOf(".")+1,sS032.length())) - Integer.parseInt(sS0321.substring(sS0321.indexOf(".")+1,sS0321.length()));
			            			iSS = getDateGap(sS0321,sS032);
			            					
		        					String chaS0 = AlarmDateDiff(iMM,iSS);

			            			cha032.put(idx032-1,"");
			            			cha032.put(idx032,chaS0);
			        			}
		        			} else {
		        				start032.put(idx032-1,"");
		        				end032.put(idx032-1,"");
		        				start032.put(idx032,"");
		        				end032.put(idx032,"");
		        				cha032.put(idx032-1,"");
		        				cha032.put(idx032,"");
		        			}
	        			} // end if idx032%2 == 1 
	        		} // end for addrList032
	        		
	        		fixedAlarmList.add(0,start032);
	        		fixedAlarmList.add(1,end032);
	        		fixedAlarmList.add(2,cha032);
	        		
	        		break;
	        	case "114":
	        		Map start114 = new HashMap();
            		Map end114 = new HashMap();
	        		Map cha114 = new HashMap();
	        		
	        		String[] addrList114 = strAddress.split(",");

	        		dccSearchAlarm.setpType(strPType+"0");
	        		
	        		dccSearchAlarm.setStartDate(strSDate);
	        		dccSearchAlarm.setEndDate(strEDate);
	        		
	        		List<DccAlarmInfo> dccAlarmInfoList114 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
	        		
	        		if( dccAlarmInfoList114.size() > 0 ) {
	        			for( int idx114=0;idx114<addrList114.length;idx114++ ) {
			        		for( DccAlarmInfo dccAlarmInfo114 : dccAlarmInfoList114 ) {
		        				if( addrList114[idx114].equals(dccAlarmInfo114.getAlmAddress()) ) {
		        					if( "N".equalsIgnoreCase(dccAlarmInfo114.getAlmGubun()) ) {
		        						if( end114.get(idx114) == null ) {
		        							end114.put(idx114,dccAlarmInfo114.getAlmDate().toString().trim());
		        						}
		        					} else if( "A".equalsIgnoreCase(dccAlarmInfo114.getAlmGubun()) ) {
		        						if( start114.get(idx114) == null ) {
		        							start114.put(idx114,dccAlarmInfo114.getAlmDate().toString().trim());
		        						}
		        					}
		        				}
		        			}
			        		if( start114.get(idx114) == null ) start114.put(idx114,"");
			        		if( end114.get(idx114) == null ) end114.put(idx114,"");
		        		}
		        		
		        		for( int fi=0;fi<36;fi+=3 ) {
		        			//if( fi%3 == 0 ) {
		        				String sS114 = start114.get(fi) == null ? "" : start114.get(fi).toString().trim();
		        				String sS1141 = start114.get(fi+1) == null ? "" : start114.get(fi+1).toString().trim();
		        				String sS1142 = start114.get(fi+2) == null ? "" : start114.get(fi+2).toString().trim();
		            			String sE114 = end114.get(fi) == null ? "" : end114.get(fi).toString().trim();
		            			String sE1142 = end114.get(fi+2) == null ? "" : end114.get(fi+2).toString().trim();
		            		
			            		if( !"".equals(sS114) && !"".equals(sS1141) ) {
			            			iMM = Integer.parseInt(sS1141.substring(sS1141.indexOf(".")+1,sS1141.length())) - Integer.parseInt(sS114.substring(sS114.indexOf(".")+1,sS114.length()));
			            			iSS = Math.abs(getDateGap(sS114,sS1141));
			            					
		        					String chaS0 = AlarmDateDiff(iMM,iSS);
			            					
			            			cha114.put(fi,chaS0);
			            		}
			            		
			            		if( !"".equals(sS1141) && !"".equals(sS1142) ) {
			            			iMM = Integer.parseInt(sS1141.substring(sS1141.indexOf(".")+1,sS1141.length())) - Integer.parseInt(sS1142.substring(sS1142.indexOf(".")+1,sS1142.length()));
			            			iSS = Math.abs(getDateGap(sS1141,sS1142));
			            					
		        					String chaS1 = AlarmDateDiff(iMM,iSS);
			            					
			            			cha114.put(fi+1,chaS1);
			            		}
			            		
			            		if( !"".equals(sE1142) && !"".equals(sE114) ) {
			            			iMM = Integer.parseInt(sE1142.substring(sE1142.indexOf(".")+1,sE1142.length())) - Integer.parseInt(sE114.substring(sE114.indexOf(".")+1,sE114.length()));
			            			iSS = Math.abs(getDateGap(sE114,sE1142));
			            					
		        					String chaE1 = AlarmDateDiff(iMM,iSS);
			            					
			            			cha114.put(fi+2,chaE1);
			            		}

				        		if( cha114.get(fi) == null ) cha114.put(fi,"");
				        		if( cha114.get(fi+1) == null ) cha114.put(fi+1,"");
				        		if( cha114.get(fi+2) == null ) cha114.put(fi+2,"");
		        			//}
		        		}
	        		} else {
	        			for( int e114=0;e114<addrList114.length;e114++ ) {
	        				start114.put(e114,"");
	        				end114.put(e114,"");
	        				cha114.put(e114,"");
	        			}
	        		}
	        		
	        		fixedAlarmList.add(0,start114);
	        		fixedAlarmList.add(1,end114);
	        		fixedAlarmList.add(2,cha114);
	        		
	        		break;
	        	case "118":
	        		Map start118 = new HashMap();
            		Map bigo118 = new HashMap();
	        		Map forecolor118 = new HashMap();
            		
            		String[] addrList118 = strAddress.split(",");
            		
            		dccSearchAlarm.setpType(strPType+"0");
            		dccSearchAlarm.setAddress(addrList118[6]);
            		
            		//System.out.println("strPType = "+dccSearchAlarm.getpType());
            		
            		dccSearchAlarm.setStartDate(strSDate);
	        		dccSearchAlarm.setEndDate(strEDate);
            		
            		List<DccAlarmInfo> dccAlarmInfoList118 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
            		
            		String pDate = "";
            		for( int i=0;i<dccAlarmInfoList118.size();i++ ) {
        				if( "N".equalsIgnoreCase(dccAlarmInfoList118.get(i).getAlmGubun()) ) {
        					pDate = dccAlarmInfoList118.get(i).getAlmDate();
        					
        					i = dccAlarmInfoList118.size();
        				}
            		}
            		
            		if( !"".equals(pDate) ) {
            			String[] pDD = pDate.split(" ")[0].split("-");
            			String[] pDT = pDate.split(" ")[1].split(":");
            			
            			LocalDateTime pPDtm = convDtm(pDate,false);
                        LocalDateTime pSDtm = pPDtm.minusSeconds(10L);
                        LocalDateTime pEDtm = pPDtm.plusSeconds(10L);
                        DateTimeFormatter dtf118 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        
                        String sSDtm = pSDtm.format(dtf118);
                        String sEDtm = pEDtm.format(dtf118);
                        
                        dccSearchAlarm.setStartDate(sSDtm);
                        dccSearchAlarm.setEndDate(sEDtm);
                        dccSearchAlarm.setpType(strPType+"0");
                		dccSearchAlarm.setAddress(strAddress);
                        
                        List<DccAlarmInfo> dccAlarmInfoList1182 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
                        
                        if( dccAlarmInfoList1182.size() > 0 ) { 	                        	
		                    int idx118 = 0;		                        
		                       
                        	for( String address : addrList118 ) {
                        		
                        		boolean chk = false;
                        		
                        		for( DccAlarmInfo dccAlarmInfo1182 : dccAlarmInfoList1182 ) {	 
                        		
	                        		String tmpAlmDate = dccAlarmInfo1182.getAlmDate().toString().trim();
	                        		tmpAlmDate = tmpAlmDate.substring(0, tmpAlmDate.indexOf("."));
	                        		boolean isOK = false;
	                        		
	                        		if( LocalDateTime.parse(tmpAlmDate,dtf118).compareTo(pPDtm) < 0 ) isOK = true; 
	                        		
		                        		if( address.equals(dccAlarmInfo1182.getAlmAddress()) ) {
		                        			if( "A".equalsIgnoreCase(dccAlarmInfo1182.getAlmGubun()) && idx118 <= 5 && isOK  ) {
		                        				if( start118.get(idx118) == null ) start118.put(idx118,dccAlarmInfo1182.getAlmDate().toString().trim());
		                        			} else if( "N".equalsIgnoreCase(dccAlarmInfo1182.getAlmGubun()) && idx118 > 5 ) {
		                        				if( start118.get(idx118) == null ) start118.put(idx118,dccAlarmInfo1182.getAlmDate().toString().trim());
		                        			}
		                        			
		                        			chk = true;
		                        			                			
		                        			break;
		                        		}	  
                        		 }// end for dccAlarmInfoList1182
                        		
                        		 if(!chk) start118.put(idx118, "-");
                        		
                        		 System.out.println(idx118 + ":::: = " + start118.get(idx118));   
                        		 idx118++;	                        	
		                        	
	                        }// end for address
	                        
//	                        Double dDtV1 = 0d;
//	                        Double dDtV2 = 0d;
	                        String dtSDate = "";
	                        String dtEDate = "";
	                        
	                        for( int bi=0;bi<72;bi++ ) {
	                        	if( bi > 5 && "".equals(start118.get(bi)) ) {
	                        		bigo118.put(bi,"");
	                        	} else {
	                        		if( bi == 0 ) {
	                        			if( "".equals(start118.get(bi)) || "-".equals(start118.get(bi)) || start118.get(bi) == null) {
//	                        				dDtV1 = 0d;
	                        				dtSDate = "";
	                        			} else {
	                        				//System.out.println("bi = " + bi);
	                        				String rStart118 = start118.get(bi).toString();
	                        				dtSDate = rStart118;
//	                        				dDtV1 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + rStart118.substring(rStart118.length()-4,rStart118.length())));
	                        			}
	                        		} else if( bi > 0 && bi < 6 ) {
	                        			if( "-".equals(start118.get(bi)) || start118.get(bi) == null) {
//	                        				dDtV1 = dDtV1 != 0d ? dDtV1 : 0d;
	                        				dtSDate = !"".equals(dtSDate) ? dtSDate : "";
	                        			} else {
	                        				//Double tmpDtv1 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + addrList118[bi]));
	                        				String rStart118 = start118.get(bi).toString();
	                        				if( !"".equals(dtSDate) ) {
	                        					dtSDate = getDateGap(dtSDate,rStart118) < 0 ? rStart118 : dtSDate;
	                        				} else {
	                        					dtSDate = rStart118;
	                        				}
//	                        				Double tmpDtv1 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + rStart118.substring(rStart118.length()-4,rStart118.length())));
//	                        				if( dDtV1 <  tmpDtv1) {
//	                        					dDtV1 = tmpDtv1;
//	                        				}
	                        			}
	                        		} else {
	                        			String rStart118 = start118.get(bi).toString();
	                        			//Double tmpDtv2 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 * (Double.parseDouble("0" + addrList118[bi]));
//	                        			Double tmpDtv2 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + rStart118.substring(rStart118.length()-4,rStart118.length())));
//	                        			dDtV2 = tmpDtv2;
	                        			dtEDate = rStart118;
	                        			
//	                        			System.out.println("dDtV1 :: "+dDtV1+", dDtV2 :: "+dDtV2);
//	                        			if( dDtV2 - dDtV1 < 0 || dDtV1 == 0 ) {
//	                        				if( bi > 5 ) {
//	                        					//bigo118.put(bi,"");
//	                        				}
//	                        			} else {
//	                        				String input = String.valueOf(dDtV2 - dDtV1);
//	                        				//input = input.indexOf(".") > -1 ? input.substring(0,input.indexOf(".")+3) : input;
//	                        				System.out.println("["+bi+"] "+input);
//	                        				
//	                        				//bigo118.put(bi,input);
//	                        			}
	                        			
	                        			int tmpMM = Integer.parseInt(dtEDate.substring(dtEDate.length()-3,dtEDate.length())) - Integer.parseInt(dtSDate.substring(dtSDate.length()-3,dtSDate.length()));
	                        			int tmpSS = getDateGap(dtSDate,dtEDate);
	                        			
	                        			System.out.println("dtSDate :: "+dtSDate+", dtEDate :: "+dtEDate+", tmpMM :: "+tmpMM+", tmpSS :: "+tmpSS);
	                        			if( tmpSS < 0 || "".equals(dtSDate) ) {
	                        				bigo118.put(bi,"");
	                        			} else {
	                        				String tmpInput = String.valueOf(AlarmDateDiff(tmpMM,tmpSS));
	                        				bigo118.put(bi,tmpInput);
	                        			}
	                        		}
	                        	}
	                        }
	                        

            				String[] titles = strTitle.split(",");

        					List<String> G1 = new ArrayList<String>();
        					List<String> G2 = new ArrayList<String>();
        					
        					String[] G1Set = {"15","16"};
        					for( String g1Item : G1Set ) {
            					G1.add(g1Item);
        					}
        					
        					String[] G2Set = {"13","14","29","30","31","32"};
        					for( String g2Item : G2Set ) {
            					G2.add(g2Item);
        					}
        					
        					String color = "";
        					
        					int ti=6;
        					for( String title : titles ) {
        						if(title.equals("-")) continue;
            					String chk = title.substring(title.length()-2,title.length());
            					

        						if( bigo118.get(ti) != null && !"".equals(bigo118.get(ti).toString()) ) {
	            					if( G1.contains(chk) ) {
	            						if( Double.parseDouble(bigo118.get(ti).toString()) > 1.1 ) {
	            							color = "red";
	            						} else {
	            							color = "blue";
	            						}
	            					} else if( G2.contains(chk) ) {
	            						if( Double.parseDouble(bigo118.get(ti).toString()) > 1.15 ) {
	            							color = "red";
	            						} else {
	            							color = "green";
	            						}
	            					} else {
            							if( Double.parseDouble(bigo118.get(ti).toString()) > 2 ) {
	            							color = "red";
	            						} else {
	            							color = "black";
	            						}
            						}
            					} else {
            						color = "black";
            					}
            					forecolor118.put(ti,color);
            					ti++;
            				}
                        }
            		} else {
            			for( int e118=0;e118<addrList118.length;e118++ ) {
            				start118.put(e118,"");
            				bigo118.put(e118,"");
            				forecolor118.put(e118,"");
            			}
            		}
            		
            		fixedAlarmList.add(0,start118);
            		fixedAlarmList.add(1,bigo118);
            		fixedAlarmList.add(2,forecolor118);
            		
	        		break;
	        	case "276":
	        		Map start276 = new HashMap();
            		Map end276 = new HashMap();
            		Map cha276 = new HashMap();
            		
            		String[] addrList276 = strAddress.split(",");
            		
            		dccSearchAlarm.setpType(strPType+"0");
            		
            		List<DccAlarmInfo> dccAlarmInfoList276 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
            		
            		if( dccAlarmInfoList276.size() > 0 ) {
		        		for( DccAlarmInfo dccAlarmInfo276 : dccAlarmInfoList276 ) {
		            		int idx276=0;
		        			for( String address : addrList276 ) {
		        				if( address.equals(dccAlarmInfo276.getAlmAddress()) ) {
		        					if( "A".equalsIgnoreCase(dccAlarmInfo276.getAlmGubun()) ) {
		        						start276.put(idx276,dccAlarmInfo276.getAlmDate());
		        					} else if( "N".equalsIgnoreCase(dccAlarmInfo276.getAlmGubun()) ) {
		        						end276.put(idx276,dccAlarmInfo276.getAlmDate());
		        					}
		        				}
			        			idx276++;
		        			}
		        		}
		        		
		        		for( int ad=0;ad<24;ad+=2 ) {
		        			if( !"".equals(start276.get(ad)) || !"".equals(start276.get(ad+1)) ) {
		            			String sS276 = start276.get(ad).toString().trim();
		            			String sE276 = start276.get(ad+1).toString().trim();
		            			int iS276 = Integer.parseInt(sS276.substring(sS276.indexOf(".")+1,sS276.length()));
		            			int iE276 = Integer.parseInt(sE276.substring(sE276.indexOf(".")+1,sE276.length()));

		            			iSS = getDateGap(sS276,sE276);
		            			
		            			if( iS276 > iE276 ) {
		            				iSS--;
		            				iMM = 1000;
		            			} else {
		            				iMM = 0;
		            			}
		            			iMM = iMM + iE276 - iS276;
		            			
		            			String sMM = String.valueOf(iMM);
		            			sMM = sMM.length() > 3 ? sMM.substring(0,3) : sMM;
		            			
		            			while( sMM.length() < 3 ) {
		            				sMM = "0" + sMM;
		            			}
		            			
		            			cha276.put(ad,String.valueOf(iSS)+"."+sMM);
		            			cha276.put(ad+1,"");
		        			}
		        		}
            		} else {
            			for( int e276=0;e276<addrList276.length;e276++ ) {
            				start276.put(e276,"");
            				end276.put(e276,"");
            				cha276.put(e276,"");
            			}
            		}
            		
        			fixedAlarmList.add(0,start276);
        			fixedAlarmList.add(1,end276);
        			fixedAlarmList.add(2,cha276);
            		
	        		break;
	        	case "550":
	        		String strAlarmGubun = dccSearchAlarm.getAlarmGubun();

            		Map startS = new HashMap();
            		Map endS = new HashMap();
            		Map startA = new HashMap();
            		Map endA = new HashMap();
            		Map startB = new HashMap();
            		Map endB = new HashMap();
            		Map chaS = new HashMap();
            		Map chaSColor = new HashMap();
            		Map chaA = new HashMap();
            		Map chaAColor = new HashMap();
            		Map chaB = new HashMap();
            		Map chaBColor = new HashMap();
	        		
	            	for( int ai=0;ai<strAlarmGubun.split(",").length;ai++ ) {
	            		dccSearchAlarm.setAlarmGubun(strAlarmGubun.split(",")[ai]);
	            		dccSearchAlarm.setAddress(strAddress.split(",")[ai]);
	            		if( ai < 2 ) {
	            			dccSearchAlarm.setpType(strPType+"0");
	            		} else {
	            			dccSearchAlarm.setpType(strPType+"1");
	            		}
	            		List<DccAlarmInfo> dccAlarmInfoList550 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
	            		int idx=0;
	            		
	            		if( dccAlarmInfoList550.size() > 0 ) {
		            		if( ai == 0 ) {
		            			startS.put(0, dccAlarmInfoList550.get(0).getAlmDate().toString());
		            		} else if ( ai == 1 ) {
		            			endS.put(0, dccAlarmInfoList550.get(0).getAlmDate().toString());
		            		} else if ( ai == 2 ) {
		            			for( int sa=0;sa<10;sa++ ) {
		            				if( sa >= dccAlarmInfoList550.size() ) {
		            					startA.put(9-sa, "");
		            				} else {
		            					startA.put(9-sa, dccAlarmInfoList550.get(sa).getAlmDate().toString());
		            				}
		            			}
		            		} else if ( ai == 3 ) {
		            			for( int ea=0;ea<10;ea++ ) {
		            				if( ea >= dccAlarmInfoList550.size() ) {
		            					endA.put(9-ea, "");
		            				} else {
		            					endA.put(9-ea, dccAlarmInfoList550.get(ea).getAlmDate().toString());
		            				}
		            			}
		            		} else if ( ai == 4 ) {
		            			for( int sb=0;sb<10;sb++ ) {
		            				if( sb >= dccAlarmInfoList550.size() ) {
		            					startB.put(9-sb, "");
		            				} else {
		            					startB.put(9-sb, dccAlarmInfoList550.get(sb).getAlmDate().toString());
		            				}
		            			}
		            		} else if ( ai == 5 ) {
		            			for( int eb=0;eb<10;eb++ ) {
		            				if( eb >= dccAlarmInfoList550.size() ) {
		            					endB.put(9-eb, "");
		            				} else {
		            					endB.put(9-eb, dccAlarmInfoList550.get(eb).getAlmDate().toString());
		            				}
		            			}
		            		}
	            		}
	            	}
	            	
	            	if( startS.size() > 0 ) {
		            	for( int ci=0;ci<startA.size();ci++ ) {
	            			String sSS = startS.get(ci) == null ? "" : startS.get(ci).toString().trim();
	            			String sES = endS.get(ci) == null ? "" : endS.get(ci).toString().trim();
	            			String sSA = startA.get(ci) == null ? "" : startA.get(ci).toString().trim();
	            			String sEA = endA.get(ci) == null ? "" : endA.get(ci).toString().trim();
	            			String sSB = startB.get(ci) == null ? "" : startB.get(ci).toString().trim();
	            			String sEB = endB.get(ci) == null ? "" : endB.get(ci).toString().trim();
	            		
		            		if( !"".equals(sSS) && !"".equals(sES) ) {
		            			if( ci == 0 ) {
			            			iMM = Integer.parseInt(sES.substring(sES.indexOf(".")+1,sES.length())) - Integer.parseInt(sSS.substring(sSS.indexOf(".")+1,sSS.length()));
			            			iSS = getDateGap(sSS,sES);
			            					
		        					String chaS0 = AlarmDateDiff(iMM,iSS);
			            					
			            			chaS.put(0,chaS0);
			            			if( Double.parseDouble(chaS0.replace(":","")) > 2.25 ) {
			            				chaSColor.put(0,"red");
			            			} else {
			            				chaSColor.put(0,"black");
			            			}
		            			}
		            		} else {
		            			if( ci == 0 ) {
			            			chaS.put(0,"");
		            				chaSColor.put(0,"black");
		            			}
		            		}
		            		
		            		if ( !"".equals(sSA) && !"".equals(sEA) ) {
		            			iMM = Integer.parseInt(sEA.substring(sEA.indexOf(".")+1,sEA.length())) - Integer.parseInt(sSA.substring(sSA.indexOf(".")+1,sSA.length()));
		            			iSS = getDateGap(sSA,sEA);
		            					
	        					String chaAi = AlarmDateDiff(iMM,iSS);
		            					
		            			chaA.put(ci,chaAi);
		            			if( ci == 0 ) {
			            			if( Double.parseDouble(chaAi.replace(":","")) > 4.75 ) {
			            				chaAColor.put(ci,"red");
			            			} else {
			            				chaAColor.put(ci,"black");
			            			}
		            			} else {
		            				if( Double.parseDouble(chaAi.replace(":","")) > 7 ) {
			            				chaAColor.put(ci,"red");
			            			} else {
			            				chaAColor.put(ci,"black");
			            			}
		            			}
		            		} else {
		            			chaA.put(ci,"");
	            				chaAColor.put(ci,"black");
		            		}
		            		
		            		if ( !"".equals(sSB) && !"".equals(sEB) ) {
		            			iMM = Integer.parseInt(sEB.substring(sEB.indexOf(".")+1,sEB.length())) - Integer.parseInt(sSB.substring(sSB.indexOf(".")+1,sSB.length()));
		            			iSS = getDateGap(sSB,sEB);
		            					
	        					String chaBi = AlarmDateDiff(iMM,iSS);
		            					
		            			chaB.put(ci,chaBi);
		            			if( ci == 0 ) {
			            			if( Double.parseDouble(chaBi.replace(":","")) > 7 && Double.parseDouble(chaBi.replace(":","")) < 15 ) {
			            				chaBColor.put(ci,"red");
			            			} else {
			            				chaBColor.put(ci,"black");
			            			}
		            			}
		            		} else {
		            			chaB.put(ci,"");
		            			chaBColor.put(ci,"black");
		            		}
		            	}
	            	} else {
            			for( int e550=0;e550<10;e550++ ) {
            				if( e550 == 0 ) {
	            				startS.put(0,"");
	            				endS.put(0,"");
            					chaS.put(0,"");
            					chaSColor.put(0,"");
            				}
            				startA.put(e550,"");
            				endA.put(e550,"");
            				startB.put(e550,"");
            				endB.put(e550,"");
            				chaA.put(e550,"");
            				chaAColor.put(e550,"");
            				chaB.put(e550,"");
            				chaBColor.put(e550,"");
            			}
            		}
	            	
            		fixedAlarmList.add(0,startS);
            		fixedAlarmList.add(1,endS);
            		fixedAlarmList.add(2,startA);
            		fixedAlarmList.add(3,endA);
            		fixedAlarmList.add(4,startB);
            		fixedAlarmList.add(5,endB);
            		fixedAlarmList.add(6,chaS);
            		fixedAlarmList.add(7,chaSColor);
            		fixedAlarmList.add(8,chaA);
            		fixedAlarmList.add(9,chaAColor);
            		fixedAlarmList.add(10,chaB);
            		fixedAlarmList.add(11,chaBColor);
            		
                	dccSearchAlarm.setAlarmGubun(strAlarmGubun);
	        		
	        		break;
	        	case "cor":
	        		Map startCha = new HashMap();
            		Map endCha = new HashMap();
            		Map valCha = new HashMap();
            		Map valChaCha = new HashMap();
	        		
	        		String[] addrListCor = strAddress.split(",");
	        		
	        		for( int idxC=0;idxC<addrListCor.length;idxC+=2 ) {
	        			if( idxC%2 == 0 ) {
	        				dccSearchAlarm.setStartDate(strSDate);
	        				dccSearchAlarm.setEndDate(strEDate);
	    	        		dccSearchAlarm.setpType(strPType+"e0");
		        			dccSearchAlarm.setAddress(addrListCor[idxC]);
		        			
			        		List<DccAlarmInfo> dccAlarmInfoListCor = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
			        		
			        		String sSC = "";
			        		String sEC = "";
			        		String sSC2 = "";
			        		String sEC2 = "";
			        		if( dccAlarmInfoListCor.size() > 0 ) {
				        		for( DccAlarmInfo dccAlarmInfoCor : dccAlarmInfoListCor ) {
				        			if( addrListCor[idxC].equals(dccAlarmInfoCor.getAlmAddress()) ) {
				        				if( "N".equalsIgnoreCase(dccAlarmInfoCor.getAlmGubun()) ) {
				        					endCha.put(idxC,dccAlarmInfoCor.getAlmDate());
				        				}
				        				if( "A".equalsIgnoreCase(dccAlarmInfoCor.getAlmGubun()) ) {
				        					startCha.put(idxC,dccAlarmInfoCor.getAlmDate());
				        				}
				        			}
				        		}
				        				
		            			sSC = startCha.get(idxC) != null ? startCha.get(idxC).toString().trim() : "";
		            			sEC = endCha.get(idxC) != null ? endCha.get(idxC).toString().trim() : "";
	
		            			if( !"".equals(sSC) && !"".equals(sEC) ) {
			            			iMM = Integer.parseInt(sEC.substring(sEC.indexOf(".")+1,sEC.length())) - Integer.parseInt(sSC.substring(sSC.indexOf(".")+1,sSC.length()));
			            			iSS = getDateGap(sSC,sEC);

			            			String strValCha = AlarmDateDiff(iMM,iSS);
			            			if( !"***IRR".equals(strValCha) ) {
			            				strValCha = String.valueOf(Math.abs(Double.parseDouble(strValCha)));
			            			}
			            			
			            			valCha.put(idxC,strValCha);
		            			} else {
		            				valCha.put(idxC,"");
		            			}

		            			if( !"".equals(sSC) && !"".equals(sEC) ) {
			            			
			            			dccSearchAlarm.setStartDate(sSC);
			    	        		dccSearchAlarm.setpType(strPType+"e1");
			            			
			            			List<DccAlarmInfo> dccAlarmInfoListCor2 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
		            			
			            			for( DccAlarmInfo dccAlarmInfoCor2 : dccAlarmInfoListCor2 ) {
					        			if( addrListCor[idxC+1].equals(dccAlarmInfoCor2.getAlmAddress()) ) {
					        				if( "N".equalsIgnoreCase(dccAlarmInfoCor2.getAlmGubun()) ) {
					        					endCha.put(idxC+1,dccAlarmInfoCor2.getAlmDate());
					        				}
					        				if( "A".equalsIgnoreCase(dccAlarmInfoCor2.getAlmGubun()) ) {
					        					startCha.put(idxC+1,dccAlarmInfoCor2.getAlmDate());
					        				}
					        			}
			            			}
					        				
			        				sSC2 = startCha.get(idxC+1) != null ? startCha.get(idxC+1).toString().trim() : "";
			            			sEC2 = endCha.get(idxC+1) != null ? endCha.get(idxC+1).toString().trim() : "";
			            			
			            			if( startCha.get(idxC+1) == null ) startCha.put(idxC+1,sSC2);
			            			if( endCha.get(idxC+1) == null ) endCha.put(idxC+1,sEC2);

			            			if( !"".equals(sSC2) && !"".equals(sEC2) ) {
				            			iMM = Integer.parseInt(sEC2.substring(sEC2.indexOf(".")+1,sEC2.length())) - Integer.parseInt(sSC2.substring(sSC2.indexOf(".")+1,sSC2.length()));
				            			iSS = getDateGap(sSC2,sEC2);

				            			String strValCha2 = AlarmDateDiff(iMM,iSS);
				            			if( !"***IRR".equals(strValCha2) ) {
				            				strValCha2 = String.valueOf(Math.abs(Integer.parseInt(strValCha2)));
				            			}
				            			
				            			valCha.put(idxC+1,strValCha2);
				            			
				            			iMM = Integer.parseInt(sEC2.substring(sEC2.indexOf(".")+1,sEC2.length())) - Integer.parseInt(sSC.substring(sSC.indexOf(".")+1,sSC.length()));
				            			iSS = getDateGap(sSC2,sSC);

				            			String strValChaCha = AlarmDateDiff(iMM,iSS);
				            			if( !"***IRR".equals(strValChaCha) ) {
				            				strValChaCha = String.valueOf(Math.abs(Integer.parseInt(strValChaCha)));
				            			}
				            			
				            			valChaCha.put((idxC+1)/2,strValChaCha);
			            			} else {
			            				valCha.put(idxC+1,"");
			            				valChaCha.put((idxC+1)/2,"");
			            			}
			        			}
	            			} else {
			        			for( int eCor=0;eCor<addrListCor.length;eCor++ ) {
			        				if( eCor%2 == 0 ) {
			        					startCha.put(eCor,"");
			        					startCha.put(eCor+1,"");
			        					endCha.put(eCor,"");
			        					endCha.put(eCor+1,"");
			        					valCha.put(eCor,"");
			        					valCha.put(eCor+1,"");
			        					valChaCha.put(eCor,"");
			        				}
			        			}
			        		}
	        			}
	        		}
	        		
	        		fixedAlarmList.add(0,startCha);
	        		fixedAlarmList.add(1,endCha);
	        		fixedAlarmList.add(2,valCha);
	        		fixedAlarmList.add(3,valChaCha);
	        		
	        		break;
	        	case "285":
            		Map lrfInfo = new HashMap();
            		Map resInfo = new HashMap();
            		Map moiInfo = new HashMap();
            		
	        		dccSearchAlarm.setpType(strPType+"0");
	            	dccSearchAlarm.setAddress(lblMOI);
	            	
	            	boolean bL285 = false;
	        		
	            	List<DccAlarmInfo> dccAlarmInfoList285 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);

            		if( dccAlarmInfoList285.size() > 0 ) {
		            	for( DccAlarmInfo dccAlarmInfo285 : dccAlarmInfoList285 ) {
			            	int moiIdx=0;
		            		for( String itemMOI : lblMOI.split(",") ) {
		            			if( itemMOI.trim().equals(dccAlarmInfo285.getAlmAddress().trim()) ) {
		            				if( "A".equalsIgnoreCase(dccAlarmInfo285.getAlmGubun()) && moiInfo.get(moiIdx) == null ) {
		            					moiInfo.put(moiIdx, dccAlarmInfo285.getAlmDate().trim());
		            				}
		            			}
			            		moiIdx++;
		            		}
		            	}
            		} else {
            			for( int e285=0;e285<lblMOI.split(",").length;e285++ ) {
            				moiInfo.put(e285,"");
            			}
            		}
	            	
            		if( moiInfo.size() > 0 &&  !"".equals(moiInfo.get(0)) ) {
		            	dccSearchAlarm.setpType(strPType+"1");
		            	int lrfIdx=0;
		            	String[] lblLrfList = lblLRF.split(",");
		            	for( String itemLRF : lblLrfList ) {
		            		String tmpDate = moiInfo.get(lrfIdx/2) == null ? "" : moiInfo.get(lrfIdx/2).toString();
		            		if( !"".equals(tmpDate) ) {
		            			dccSearchAlarm.setStartDate(tmpDate);
		            			dccSearchAlarm.setAddress(lblLrfList[lrfIdx]);
		                    	List<DccAlarmInfo> dccAlarmInfoList2852 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
		                    	bL285 = false;
		                    	
		                    	if( dccAlarmInfoList2852.size() > 0 ) {
			    	            	for( DccAlarmInfo dccAlarmInfo2852 : dccAlarmInfoList2852 ) {
		    	            			if( itemLRF.equals(dccAlarmInfo2852.getAlmAddress()) ) {
		    	            				if( !bL285 && "A".equalsIgnoreCase(dccAlarmInfo2852.getAlmGubun()) ) {
		    	            					lrfInfo.put(lrfIdx, dccAlarmInfo2852.getAlmDate().trim());
		    	            					bL285 = true;
		    	            				}
		    	            			}
	    	            				
	    	            				String almDate = dccAlarmInfo2852.getAlmDate().trim();
	    	            				
		    	            			int moiMilli = Integer.parseInt(tmpDate.substring(tmpDate.indexOf(".")+1,tmpDate.length()));
	    	            				int lrfMilli = Integer.parseInt(almDate.substring(almDate.indexOf(".")+1,almDate.length()));
	
	        	            			iSS = getDateGap(tmpDate,almDate);
	        	            			if( moiMilli > lrfMilli ) {
	        	            				iSS = iSS -1;
	        	            				iMM = 1000;
	        	            			}
	        	            			iMM += (lrfMilli-moiMilli);
	        	            			
	        	            			String sMM = String.valueOf(iMM);
	        	            			while( sMM.length() < 3 ) {
	        	            				sMM = "0" + sMM;
	        	            			}
	        	            			
	        	            			String res = String.valueOf(iSS)+"."+sMM;
	        	            			Double dRes = Double.parseDouble(res);
	        	            			if( dRes > 29.504 && dRes < 29.996 ) {
	        	            				res += " (Y)";
	        	            			} else if( dRes <= 29.504 ) {
	        	            				res += " (SHT)";
	        	            			} else if( dRes >= 29.996 ) {
	        	            				res += " (LNG)";
	        	            			}
	        	            			resInfo.put(lrfIdx,res);
			    	            	}
		                    	} else {
			            			lrfInfo.put(lrfIdx,"");
			            			resInfo.put(lrfIdx,"");
		                    	}
		            		}
		            		lrfIdx++;
		            	}
            		} else {
	            		for( int e285=0;e285<lblLRF.split(",").length;e285++ ) {
	            			lrfInfo.put(e285,"");
	            			resInfo.put(e285,"");
	            		}
            		}
            		
            		fixedAlarmList.add(0,moiInfo);
            		fixedAlarmList.add(1,lrfInfo);
            		fixedAlarmList.add(2,resInfo);
            		
	        		break;
        	}
        	
        	dccSearchAlarm.setStartDate(strSDate);
        	dccSearchAlarm.setEndDate(strEDate);
        	dccSearchAlarm.setpType(strPType);
        	
        	mav.addObject("FixedAlarmList", fixedAlarmList);
        	
        	dccSearchAlarm.setMenuName(this.menuName);
        	
        	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
        	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
        	
        }
        return mav;
    }
	
	private int getDateGap(String startDtm, String endDtm) {
		while( startDtm.length() < 23 ) {
			if( startDtm.length() == 19 ) {
				startDtm = startDtm+".";
			} else {
				startDtm = startDtm+"0";
			}
		}
		String[] sDates = startDtm.split(" ")[0].split("-");
		String[] sTimes = startDtm.split(" ")[1].substring(0,startDtm.split(" ")[1].indexOf(".")).split(":");
		
		while( endDtm.length() < 23 ) {
			if( endDtm.length() == 19 ) {
				endDtm = endDtm+".";
			} else {
				endDtm = endDtm+"0";
			}
		}
		String[] eDates = endDtm.split(" ")[0].split("-");
		String[] eTimes = endDtm.split(" ")[1].substring(0,endDtm.split(" ")[1].indexOf(".")).split(":");
			
		LocalDateTime sDtm = LocalDateTime.of(Integer.parseInt(sDates[0]), Integer.parseInt(sDates[1]), Integer.parseInt(sDates[2]),
					Integer.parseInt(sTimes[0]), Integer.parseInt(sTimes[1]), Integer.parseInt(sTimes[2]));
		LocalDateTime eDtm = LocalDateTime.of(Integer.parseInt(eDates[0]), Integer.parseInt(eDates[1]), Integer.parseInt(eDates[2]),
					Integer.parseInt(eTimes[0]), Integer.parseInt(eTimes[1]), Integer.parseInt(eTimes[2]));
		Duration gap = Duration.between(sDtm, eDtm);
		
		return (int) gap.getSeconds();
	}
	
	private String AlarmDateDiff(int iMM, int iSS) {
		String sRtnVal = "";
		
		if( iMM < 0 ) {
			Double dDiff = ((iSS*1000d)+iMM*1d)/1000d;
			String[] vVL = String.valueOf(dDiff).split("\\.");

			int iVL0 = (int) Integer.parseInt(vVL[0]);
			String sVL1 = vVL[1].length() > 3 ? vVL[1].substring(0,3) : vVL[1];
			while( sVL1.length() < 3 ) {
				sVL1 = sVL1 + "0";
			}
			if( Math.abs(iVL0) > 3600 ) {
				sRtnVal = "***IRR";
			} else if( Math.abs(iVL0) > 60 ) {
				sRtnVal = (Math.abs(iVL0)/60)+":"+(Math.abs(iVL0)%60)+"."+sVL1;
			} else if( Math.abs(iVL0) < 60 ) {
				sRtnVal = iVL0+"."+sVL1;
			} else {
				//
			}
		} else {
			String sMM = String.valueOf(iMM).length() > 3 ? String.valueOf(iMM).substring(0,3) : String.valueOf(iMM);
			while( sMM.length() < 3 ) {
				sMM = "0" + sMM;
			}
			if( iSS > 3600 ) {
				sRtnVal = "***IRR";
			} else if( iSS > 60 ){
				sRtnVal = (iSS/60)+":"+(iSS%60)+"."+sMM;
			} else {
				sRtnVal = iSS+"."+sMM;
			}
		}
		
		return sRtnVal;
	}
	
	private LocalDateTime convDtm(String date, boolean isMilli) {
		String[] pDate = date.split(" ")[0].split("-");
		String[] pTime = date.split(" ")[1].split(":");
		if( !isMilli ) {
			pTime[2] = pTime[2].indexOf(".") > -1 ? pTime[2].substring(0,pTime[2].indexOf(".")) : pTime[2];
		}
		
		LocalDateTime ldt = LocalDateTime.of(Integer.parseInt(pDate[0]),Integer.parseInt(pDate[1]),Integer.parseInt(pDate[2]),
											Integer.parseInt(pTime[0]),Integer.parseInt(pTime[1]),Integer.parseInt(pTime[2]));
		
		return ldt;
	}
	
	private Double convDbl(String pDate,String multiplier) {
		
		Double rtv = 0d;
		
		try { 
		
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = sdf.parse(pDate);
			
			rtv =  Double.parseDouble(String.valueOf(date.getTime()));
			
		}catch(ParseException pe) {
			
		}
		
		//Calendar calendar = Calendar.getInstance();
		//calendar.getTimeInMillis()
		/*
		System.out.println(date);
		String[] pDate = date.split(" ")[0].split("-");
		String[] pTime = date.split(" ")[1].split(":");
		
		LocalDate dRef = LocalDate.of(1900,1,1);
		LocalDate pDD = LocalDate.of(Integer.parseInt(pDate[0]),Integer.parseInt(pDate[1]),Integer.parseInt(pDate[2]));
		
		System.out.println(pDate[0]);
		System.out.println(pDate[1]);
		System.out.println(pDate[2]);
		System.out.println(dRef.toString());
		System.out.println(pDD.toString());
		Duration dGap = Duration.between(pDD,dRef);
		
		int iGapD = (int) dGap.getSeconds();
		int iGapT = Integer.parseInt(pTime[0])*3600 + Integer.parseInt(pTime[1])*60 + Integer.parseInt(pTime[2].substring(0,2));
		
		Double rtv = (iGapD+iGapT)*1d;
		rtv = !"".equals(multiplier) ? rtv + Double.parseDouble("0."+multiplier) : rtv;
		*/
		
		return rtv;
	}
	
	@RequestMapping("fixedExcelExport")
	public void fixedExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchAlarm dccSearchAlarm) throws Exception {
		try{
        	if( dccSearchAlarm.getHogiHeader() != null ) {
        		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
        	} else {
        		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
        	}
        	if( dccSearchAlarm.getXyHeader() != null ) {
        		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
        	} else {
        		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
        	}
        	if( dccSearchAlarm.getIoType() == null || "".equals(dccSearchAlarm.getIoType()) ) dccSearchAlarm.setIoType("AI");
        	if( dccSearchAlarm.getIoBit() == null || "".equals(dccSearchAlarm.getIoBit()) ) dccSearchAlarm.setIoBit("0");
        	if( dccSearchAlarm.getSaveCore() == null ) dccSearchAlarm.setSaveCore("0");
        	if( dccSearchAlarm.getsDive() == null ) dccSearchAlarm.setsDive("D");
        	if( dccSearchAlarm.getpType() == null ) dccSearchAlarm.setpType("114");
        	String CI114Init = "268,269,198,272,273,202,276,277,206,280,281,197,"
							 + "284,285,201,288,736,205,739,740,200,743,744,204,"
							 + "747,748,208,751,752,199,755,756,203,759,760,207";
        	if( dccSearchAlarm.getAddress() == null ) dccSearchAlarm.setAddress(CI114Init);
        	String strPType = dccSearchAlarm.getpType();
        	String strAddress = dccSearchAlarm.getAddress();
        	String strSDate = dccSearchAlarm.getStartDate();
        	String strEDate = dccSearchAlarm.getEndDate();
        	String strTitle = dccSearchAlarm.getTitle() == null ? "" : dccSearchAlarm.getTitle();
        	String strLoop = dccSearchAlarm.getLoop() == null ? "" : dccSearchAlarm.getLoop();
        	String strCI = dccSearchAlarm.getCi() == null ? "" : dccSearchAlarm.getCi();
        	String[] lblTitles = strTitle.split(",");
        	String[] lblLoops = strLoop.split(",");
        	String[] lblCIs = strCI.split(",");
	        
	        if(request.getSession().getAttribute("USER_INFO") != null) {
	        	
	        	List<Map> fixedAlarmList = new ArrayList<Map>();
	        	
	        	String fileTitle = "";

	        	int iMM = 0;
	        	int iSS = 0;
	        	
	        	switch( strPType ) {
		        	case "003":
		        		fileTitle = "정기-003";
		        		
		        		Map start003 = new HashMap();
	            		Map end003 = new HashMap();
		        		Map cha003 = new HashMap();
		        		
		        		boolean bS003 = false;
	    				boolean bE003 = false;
		        		
	    				//System.out.println(strAddress);
	    				
		        		String[] addrList003 = strAddress.split(",");	        		
		        		
		        		for( int idx003=0;idx003<addrList003.length;idx003++ ) {
		        			if( idx003%6 == 5 ) {
		        				
			        			dccSearchAlarm.setAddress(addrList003[idx003]);
				        		dccSearchAlarm.setpType(strPType+"0");
				        		
				        		dccSearchAlarm.setStartDate(strSDate);
				        		dccSearchAlarm.setEndDate(strEDate);
		        				
				        		List<DccAlarmInfo> dccAlarmInfoList003 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
				        		
				        		if( dccAlarmInfoList003.size() > 0 ) {
				        			
				        			String schSDate = "";
				        			String schEDate = "";
				        			
				        			for( DccAlarmInfo dccAlarmInfo003 : dccAlarmInfoList003 ) {			        				
				        				
				        				if( Integer.parseInt(addrList003[idx003].trim()) == Integer.parseInt(dccAlarmInfo003.getAlmAddress().trim()) ) {
				        					if("N".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
				        						schEDate = dccAlarmInfo003.getAlmDate().toString().trim();	
				        						end003.put(idx003,schEDate);					                      
				        					}
				        					if("A".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
				        						schSDate = dccAlarmInfo003.getAlmDate().toString().trim();
				        						start003.put(idx003,schSDate);
				        					}
				        				}
				        			}
				        			
				        			for( int sub003=idx003-5;sub003<idx003;sub003++ ) {
				        				LocalDateTime pSDate = convDtm(schSDate.trim(),false).minusSeconds(1);
				        				LocalDateTime pEDate = convDtm(schEDate.trim(),false).plusMinutes(2);
				                        DateTimeFormatter dtf003 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				        				
				        				String sSDate = pSDate.format(dtf003)+".000";
				        				String sEDate = pEDate.format(dtf003)+".999";
				        				
				        				dccSearchAlarm.setAddress(addrList003[sub003]);
				        				dccSearchAlarm.setStartDate(sSDate);
				        				dccSearchAlarm.setEndDate(sEDate);
				        				
				        				if( idx003 == 5 || idx003 == 11 || idx003 == 17 ) {
				        					dccSearchAlarm.setpType(strPType+"1");
				        				} else {
				        					dccSearchAlarm.setpType(strPType+"2");
				        				}
				        				
				        				List<DccAlarmInfo> dccAlarmInfoList0032 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
				        				
				        				//System.out.println("idx = " + sub003 + "::::: size = " + dccAlarmInfoList0032.size());
				        				
				        				bS003 = false;
				        				bE003 = false;
				        				for( DccAlarmInfo dccAlarmInfo003 : dccAlarmInfoList0032 ) {

				        					if( Integer.parseInt(addrList003[sub003].trim()) == Integer.parseInt(dccAlarmInfo003.getAlmAddress().trim()) ) {
				        						if("N".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
					        						end003.put(sub003,dccAlarmInfo003.getAlmDate().toString().trim());
					        						
					        						//System.out.println("idx = " + sub003 + "::::: end003 = " + end003.get(sub003));
					        					}
					        					if("A".equalsIgnoreCase(dccAlarmInfo003.getAlmGubun()) ) {
					        						start003.put(sub003,dccAlarmInfo003.getAlmDate().toString().trim());
					        						
					        						//System.out.println("idx = " + sub003 + "::::: start003 = " + start003.get(sub003));
					        					}
					        				}
				        				}			        				 
				        			}
				        		} else {
				        			for( int e003=0;e003<addrList003.length;e003++ ) {
				        				start003.put(e003,"");
				        				end003.put(e003,"");
				        			}
				        		}
		        			} // end if gap = 5
		        		} // end for gap

		        		if( start003.size() > 0 && !"".equals(start003.get(0)) ) {
			        		for( int idxC003=0;idxC003<addrList003.length;idxC003++ ) {
			        			String sS003 = "";
			        			String sE003 = "";
			        			String chaS0 = "";
			        			switch( idxC003 ) {
				        			case 0: case 6: case 12: case 18: case 24: case 30:
					        			sS003 = start003.get(idxC003).toString().trim();
					        			sE003 = start003.get(idxC003+1).toString().trim();
					        			if( !"".equals(sS003) && !"".equals(sE003) ) {
					            			iMM = Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length())) - Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length()));
					            			iSS = getDateGap(sE003,sS003);
					            					
				        					chaS0 = AlarmDateDiff(iMM,iSS);
					            					
					            			cha003.put(idxC003,chaS0);
					        			}
					        			break;
				        			case 1: case 7: case 13: case 19: case 25: case 31:
				        				sS003 = start003.get(idxC003).toString().trim();
				        				sE003 = start003.get(idxC003+1).toString().trim();
					        			if( !"".equals(sS003) && !"".equals(sE003) ) {
					            			iMM = Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length())) - Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length()));
					            			iSS = getDateGap(sS003,sE003);
					            					
				        					chaS0 = AlarmDateDiff(iMM,iSS);
					            					
					            			cha003.put(idxC003,chaS0);
					        			}
					        			break;
				        			case 2: case 8: case 14: case 20: case 26: case 32:
				        				sS003 = end003.get(idxC003-2).toString().trim();
				        				sE003 = end003.get(idxC003+1).toString().trim();
					        			if( !"".equals(sS003) && !"".equals(sE003) ) {
					        				iMM = Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length())) - Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length()));
					            			iSS = getDateGap(sS003,sE003);
					            					
				        					chaS0 = AlarmDateDiff(iMM,iSS);
					            					
					            			cha003.put(idxC003,chaS0);
					        			}
					        			break;
				        			case 3: case 9: case 15: case 21: case 27: case 33:
				        				sS003 = end003.get(idxC003-1).toString().trim();
				        				sE003 = end003.get(idxC003+1).toString().trim();
					        			if( !"".equals(sS003) && !"".equals(sE003) ) {
					            			iMM = Integer.parseInt(sE003.substring(sE003.indexOf(".")+1,sE003.length())) - Integer.parseInt(sS003.substring(sS003.indexOf(".")+1,sS003.length()));
					            			iSS = getDateGap(sS003,sE003);
					            					
				        					chaS0 = AlarmDateDiff(iMM,iSS);
					            					
					            			cha003.put(idxC003,chaS0);
					        			}
					        			break;
					        		default:
					        			cha003.put(idxC003,"");
					        			break;
			        			}
			        		}
	        			} else {
		        			for( int e003=0;e003<addrList003.length;e003++ ) {
		        				cha003.put(e003,"");
		        			}
		        		}
		        		
		        		fixedAlarmList.add(0,start003);
		        		fixedAlarmList.add(1,end003);
		        		fixedAlarmList.add(2,cha003);
		        		
		        		break;
		        	case "032":
		        		fileTitle = "정기-032";
		        		
		        		Map start032 = new HashMap();
	            		Map end032 = new HashMap();
		        		Map cha032 = new HashMap();
		        		
		        		boolean bS032 = false;
		        		boolean bE032 = false;
		        		
		        		String[] addrList032 = strAddress.split(",");
		        		
		        		for( int idx032=0;idx032<addrList032.length;idx032++ ) {
		        			if( idx032%2 == 1 ) {
		        				
			        			dccSearchAlarm.setAddress(addrList032[idx032]);
				        		dccSearchAlarm.setpType(strPType+"0");
				        		
				        		dccSearchAlarm.setStartDate(strSDate);
				        		dccSearchAlarm.setEndDate(strEDate);
			        			
			        			List<DccAlarmInfo> dccAlarmInfoList032 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
			        			
			        			if( dccAlarmInfoList032.size() > 0 ) {
			        				
			        				String schSDate = "";
				        			String schEDate = "";
				        			
				        			for( DccAlarmInfo dccAlarmInfo032 : dccAlarmInfoList032 ) {
				        				if( Integer.parseInt(addrList032[idx032]) == Integer.parseInt(dccAlarmInfo032.getAlmAddress()) ) {			        					
				        					
				        					if( "N".equalsIgnoreCase(dccAlarmInfo032.getAlmGubun()) ) {
				        						schEDate = dccAlarmInfo032.getAlmDate().toString().trim();
				        					}
		        							if("A".equalsIgnoreCase(dccAlarmInfo032.getAlmGubun()) ) {
		        								schSDate = dccAlarmInfo032.getAlmDate().toString().trim();
				        					}
				        				}
				        			}
				        			
				        			//System.out.println("schEDate = " + schEDate + ":::::");
				        			//System.out.println("schSDate = " + schSDate + ":::::");
				        			
				        			for( int sub032=idx032-1;sub032<=idx032;sub032++ )  {
				        				LocalDateTime pSDate = convDtm(schSDate.trim(),false).minusSeconds(1);
				        				LocalDateTime pEDate = convDtm(schEDate.trim(),false).plusSeconds(30);
				                        DateTimeFormatter dtf032 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				        				
				        				String sSDate = pSDate.format(dtf032)+".000";
				        				String sEDate = pEDate.format(dtf032)+".999";
				        				
				        				//System.out.println("sSDate = " + sSDate + ":::::");
					        			//System.out.println("sEDate = " + sEDate + ":::::");
				        				
				        				dccSearchAlarm.setStartDate(sSDate);
				        				dccSearchAlarm.setEndDate(sEDate);
				        				dccSearchAlarm.setAddress(addrList032[sub032]);
						        		dccSearchAlarm.setpType(strPType+"1");
						        		
						        		List<DccAlarmInfo> dccAlarmInfoList0322 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
						        		//System.out.println("dccAlarmInfoList0322 size = " + dccAlarmInfoList0322.size() + ":::::");
						        		bS032 = false;
						        		bE032 = false;
						        		for( DccAlarmInfo dccAlarmInfo0322 : dccAlarmInfoList0322 ) {
						        			if( Integer.parseInt(addrList032[sub032]) == Integer.parseInt(dccAlarmInfo0322.getAlmAddress()) ) {
						        				if( "N".equalsIgnoreCase(dccAlarmInfo0322.getAlmGubun()) ) {
					        						end032.put(sub032,dccAlarmInfo0322.getAlmDate().toString().trim());
					        						//System.out.println("sub032 end = " + sub032 + ":::::" + end032.get(sub032));
					        					}
					        					if( "A".equalsIgnoreCase(dccAlarmInfo0322.getAlmGubun()) ) {
					        						start032.put(sub032,dccAlarmInfo0322.getAlmDate().toString().trim());
					        						//System.out.println("sub032 start = " + sub032 + ":::::" + start032.get(sub032));
					        					}
					        				}
						        		}
				        			}// end for sub032
				        			
				        			//System.out.println("int032 start = " + idx032 + ":::::");
		
			        				String sS032 = start032.get(idx032-1).toString().trim();
			        				String sS0321 = start032.get(idx032).toString().trim();
				        			if( !"".equals(sS032) && !"".equals(sS0321) ) {
				            			iMM = Integer.parseInt(sS032.substring(sS032.indexOf(".")+1,sS032.length())) - Integer.parseInt(sS0321.substring(sS0321.indexOf(".")+1,sS0321.length()));
				            			iSS = getDateGap(sS0321,sS032);
				            					
			        					String chaS0 = AlarmDateDiff(iMM,iSS);

				            			cha032.put(idx032-1,"");
				            			cha032.put(idx032,chaS0);
				        			}
			        			} else {
			        				start032.put(idx032-1,"");
			        				end032.put(idx032-1,"");
			        				start032.put(idx032,"");
			        				end032.put(idx032,"");
			        				cha032.put(idx032-1,"");
			        				cha032.put(idx032,"");
			        			}
		        			} // end if idx032%2 == 1 
		        		} // end for addrList032
		        		
		        		fixedAlarmList.add(0,start032);
		        		fixedAlarmList.add(1,end032);
		        		fixedAlarmList.add(2,cha032);
		        		
		        		break;
		        	case "114":
		        		fileTitle = "정기-114";
		        		
		        		Map start114 = new HashMap();
	            		Map end114 = new HashMap();
		        		Map cha114 = new HashMap();
		        		
		        		String[] addrList114 = strAddress.split(",");

		        		dccSearchAlarm.setpType(strPType+"0");
		        		
		        		dccSearchAlarm.setStartDate(strSDate);
		        		dccSearchAlarm.setEndDate(strEDate);
		        		
		        		List<DccAlarmInfo> dccAlarmInfoList114 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
		        		
		        		if( dccAlarmInfoList114.size() > 0 ) {
		        			for( int idx114=0;idx114<addrList114.length;idx114++ ) {
				        		for( DccAlarmInfo dccAlarmInfo114 : dccAlarmInfoList114 ) {
			        				if( addrList114[idx114].equals(dccAlarmInfo114.getAlmAddress()) ) {
			        					if( "N".equalsIgnoreCase(dccAlarmInfo114.getAlmGubun()) ) {
			        						if( end114.get(idx114) == null ) {
			        							end114.put(idx114,dccAlarmInfo114.getAlmDate().toString().trim());
			        						}
			        					} else if( "A".equalsIgnoreCase(dccAlarmInfo114.getAlmGubun()) ) {
			        						if( start114.get(idx114) == null ) {
			        							start114.put(idx114,dccAlarmInfo114.getAlmDate().toString().trim());
			        						}
			        					}
			        				}
			        			}
				        		if( start114.get(idx114) == null ) start114.put(idx114,"");
				        		if( end114.get(idx114) == null ) end114.put(idx114,"");
			        		}
			        		
			        		for( int fi=0;fi<36;fi+=3 ) {
			        			//if( fi%3 == 0 ) {
			        				String sS114 = start114.get(fi) == null ? "" : start114.get(fi).toString().trim();
			        				String sS1141 = start114.get(fi+1) == null ? "" : start114.get(fi+1).toString().trim();
			        				String sS1142 = start114.get(fi+2) == null ? "" : start114.get(fi+2).toString().trim();
			            			String sE114 = end114.get(fi) == null ? "" : end114.get(fi).toString().trim();
			            			String sE1142 = end114.get(fi+2) == null ? "" : end114.get(fi+2).toString().trim();
			            		
				            		if( !"".equals(sS114) && !"".equals(sS1141) ) {
				            			iMM = Integer.parseInt(sS1141.substring(sS1141.indexOf(".")+1,sS1141.length())) - Integer.parseInt(sS114.substring(sS114.indexOf(".")+1,sS114.length()));
				            			iSS = Math.abs(getDateGap(sS114,sS1141));
				            					
			        					String chaS0 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha114.put(fi,chaS0);
				            		}
				            		
				            		if( !"".equals(sS1141) && !"".equals(sS1142) ) {
				            			iMM = Integer.parseInt(sS1141.substring(sS1141.indexOf(".")+1,sS1141.length())) - Integer.parseInt(sS1142.substring(sS1142.indexOf(".")+1,sS1142.length()));
				            			iSS = Math.abs(getDateGap(sS1141,sS1142));
				            					
			        					String chaS1 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha114.put(fi+1,chaS1);
				            		}
				            		
				            		if( !"".equals(sE1142) && !"".equals(sE114) ) {
				            			iMM = Integer.parseInt(sE1142.substring(sE1142.indexOf(".")+1,sE1142.length())) - Integer.parseInt(sE114.substring(sE114.indexOf(".")+1,sE114.length()));
				            			iSS = Math.abs(getDateGap(sE114,sE1142));
				            					
			        					String chaE1 = AlarmDateDiff(iMM,iSS);
				            					
				            			cha114.put(fi+2,chaE1);
				            		}

					        		if( cha114.get(fi) == null ) cha114.put(fi,"");
					        		if( cha114.get(fi+1) == null ) cha114.put(fi+1,"");
					        		if( cha114.get(fi+2) == null ) cha114.put(fi+2,"");
			        			//}
			        		}
		        		} else {
		        			for( int e114=0;e114<addrList114.length;e114++ ) {
		        				start114.put(e114,"");
		        				end114.put(e114,"");
		        				cha114.put(e114,"");
		        			}
		        		}
		        		
		        		fixedAlarmList.add(0,start114);
		        		fixedAlarmList.add(1,end114);
		        		fixedAlarmList.add(2,cha114);
		        		
		        		break;
		        	case "118":
		        		fileTitle = "정기-118";
		        		
		        		Map start118 = new HashMap();
	            		Map bigo118 = new HashMap();
		        		Map forecolor118 = new HashMap();
	            		
	            		String[] addrList118 = strAddress.split(",");
	            		
	            		dccSearchAlarm.setpType(strPType+"0");
	            		dccSearchAlarm.setAddress(addrList118[6]);
	            		
	            		//System.out.println("strPType = "+dccSearchAlarm.getpType());
	            		
	            		dccSearchAlarm.setStartDate(strSDate);
		        		dccSearchAlarm.setEndDate(strEDate);
	            		
	            		List<DccAlarmInfo> dccAlarmInfoList118 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
	            		
	            		String pDate = "";
	            		for( int i=0;i<dccAlarmInfoList118.size();i++ ) {
	        				if( "N".equalsIgnoreCase(dccAlarmInfoList118.get(i).getAlmGubun()) ) {
	        					pDate = dccAlarmInfoList118.get(i).getAlmDate();
	        					
	        					i = dccAlarmInfoList118.size();
	        				}
	            		}
	            		
	            		if( !"".equals(pDate) ) {
	            			String[] pDD = pDate.split(" ")[0].split("-");
	            			String[] pDT = pDate.split(" ")[1].split(":");
	            			
	            			LocalDateTime pPDtm = convDtm(pDate,false);
	                        LocalDateTime pSDtm = pPDtm.minusSeconds(10L);
	                        LocalDateTime pEDtm = pPDtm.plusSeconds(10L);
	                        DateTimeFormatter dtf118 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	                        
	                        String sSDtm = pSDtm.format(dtf118);
	                        String sEDtm = pEDtm.format(dtf118);
	                        
	                        dccSearchAlarm.setStartDate(sSDtm);
	                        dccSearchAlarm.setEndDate(sEDtm);
	                        dccSearchAlarm.setpType(strPType+"0");
	                		dccSearchAlarm.setAddress(strAddress);
	                        
	                        List<DccAlarmInfo> dccAlarmInfoList1182 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
	                        
	                        if( dccAlarmInfoList1182.size() > 0 ) { 	                        	
			                    int idx118 = 0;		                        
			                       
	                        	for( String address : addrList118 ) {
	                        		
	                        		boolean chk = false;
	                        		
	                        		for( DccAlarmInfo dccAlarmInfo1182 : dccAlarmInfoList1182 ) {	 
	                        		
		                        		String tmpAlmDate = dccAlarmInfo1182.getAlmDate().toString().trim();
		                        		tmpAlmDate = tmpAlmDate.substring(0, tmpAlmDate.indexOf("."));
		                        		boolean isOK = false;
		                        		
		                        		if( LocalDateTime.parse(tmpAlmDate,dtf118).compareTo(pPDtm) < 0 ) isOK = true; 
		                        		
			                        		if( address.equals(dccAlarmInfo1182.getAlmAddress()) ) {
			                        			if( "A".equalsIgnoreCase(dccAlarmInfo1182.getAlmGubun()) && idx118 <= 5 && isOK  ) {
			                        				if( start118.get(idx118) == null ) start118.put(idx118,dccAlarmInfo1182.getAlmDate().toString().trim());
			                        			} else if( "N".equalsIgnoreCase(dccAlarmInfo1182.getAlmGubun()) && idx118 > 5 ) {
			                        				if( start118.get(idx118) == null ) start118.put(idx118,dccAlarmInfo1182.getAlmDate().toString().trim());
			                        			}
			                        			
			                        			chk = true;
			                        			                			
			                        			break;
			                        		}	  
	                        		 }// end for dccAlarmInfoList1182
	                        		
	                        		 if(!chk) start118.put(idx118, "-");
	                        		
	                        		 System.out.println(idx118 + ":::: = " + start118.get(idx118));   
	                        		 idx118++;	                        	
			                        	
		                        }// end for address
		                        
//		                        Double dDtV1 = 0d;
//		                        Double dDtV2 = 0d;
		                        String dtSDate = "";
		                        String dtEDate = "";
		                        
		                        for( int bi=0;bi<72;bi++ ) {
		                        	if( bi > 5 && "".equals(start118.get(bi)) ) {
		                        		bigo118.put(bi,"");
		                        	} else {
		                        		if( bi == 0 ) {
		                        			if( "".equals(start118.get(bi)) || "-".equals(start118.get(bi)) || start118.get(bi) == null) {
//		                        				dDtV1 = 0d;
		                        				dtSDate = "";
		                        			} else {
		                        				//System.out.println("bi = " + bi);
		                        				String rStart118 = start118.get(bi).toString();
		                        				dtSDate = rStart118;
//		                        				dDtV1 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + rStart118.substring(rStart118.length()-4,rStart118.length())));
		                        			}
		                        		} else if( bi > 0 && bi < 6 ) {
		                        			if( "-".equals(start118.get(bi)) || start118.get(bi) == null) {
//		                        				dDtV1 = dDtV1 != 0d ? dDtV1 : 0d;
		                        				dtSDate = !"".equals(dtSDate) ? dtSDate : "";
		                        			} else {
		                        				//Double tmpDtv1 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + addrList118[bi]));
		                        				String rStart118 = start118.get(bi).toString();
		                        				if( !"".equals(dtSDate) ) {
		                        					dtSDate = getDateGap(dtSDate,rStart118) < 0 ? rStart118 : dtSDate;
		                        				} else {
		                        					dtSDate = rStart118;
		                        				}
//		                        				Double tmpDtv1 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + rStart118.substring(rStart118.length()-4,rStart118.length())));
//		                        				if( dDtV1 <  tmpDtv1) {
//		                        					dDtV1 = tmpDtv1;
//		                        				}
		                        			}
		                        		} else {
		                        			String rStart118 = start118.get(bi).toString();
		                        			//Double tmpDtv2 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 * (Double.parseDouble("0" + addrList118[bi]));
//		                        			Double tmpDtv2 = convDbl(start118.get(bi).toString().substring(0,19),"") * 86400 + (Double.parseDouble("0" + rStart118.substring(rStart118.length()-4,rStart118.length())));
//		                        			dDtV2 = tmpDtv2;
		                        			dtEDate = rStart118;
		                        			
//		                        			System.out.println("dDtV1 :: "+dDtV1+", dDtV2 :: "+dDtV2);
//		                        			if( dDtV2 - dDtV1 < 0 || dDtV1 == 0 ) {
//		                        				if( bi > 5 ) {
//		                        					//bigo118.put(bi,"");
//		                        				}
//		                        			} else {
//		                        				String input = String.valueOf(dDtV2 - dDtV1);
//		                        				//input = input.indexOf(".") > -1 ? input.substring(0,input.indexOf(".")+3) : input;
//		                        				System.out.println("["+bi+"] "+input);
//		                        				
//		                        				//bigo118.put(bi,input);
//		                        			}
		                        			
		                        			int tmpMM = Integer.parseInt(dtEDate.substring(dtEDate.length()-3,dtEDate.length())) - Integer.parseInt(dtSDate.substring(dtSDate.length()-3,dtSDate.length()));
		                        			int tmpSS = getDateGap(dtSDate,dtEDate);
		                        			
		                        			System.out.println("dtSDate :: "+dtSDate+", dtEDate :: "+dtEDate+", tmpMM :: "+tmpMM+", tmpSS :: "+tmpSS);
		                        			if( tmpSS < 0 || "".equals(dtSDate) ) {
		                        				bigo118.put(bi,"");
		                        			} else {
		                        				String tmpInput = String.valueOf(AlarmDateDiff(tmpMM,tmpSS));
		                        				bigo118.put(bi,tmpInput);
		                        			}
		                        		}
		                        	}
		                        }
		                        

	            				String[] titles = strTitle.split(",");

	        					List<String> G1 = new ArrayList<String>();
	        					List<String> G2 = new ArrayList<String>();
	        					
	        					String[] G1Set = {"15","16"};
	        					for( String g1Item : G1Set ) {
	            					G1.add(g1Item);
	        					}
	        					
	        					String[] G2Set = {"13","14","29","30","31","32"};
	        					for( String g2Item : G2Set ) {
	            					G2.add(g2Item);
	        					}
	        					
	        					String color = "";
	        					
	        					int ti=6;
	        					for( String title : titles ) {
	        						if(title.equals("-")) continue;
	            					String chk = title.substring(title.length()-2,title.length());
	            					

	        						if( bigo118.get(ti) != null && !"".equals(bigo118.get(ti).toString()) ) {
		            					if( G1.contains(chk) ) {
		            						if( Double.parseDouble(bigo118.get(ti).toString()) > 1.1 ) {
		            							color = "red";
		            						} else {
		            							color = "blue";
		            						}
		            					} else if( G2.contains(chk) ) {
		            						if( Double.parseDouble(bigo118.get(ti).toString()) > 1.15 ) {
		            							color = "red";
		            						} else {
		            							color = "green";
		            						}
		            					} else {
	            							if( Double.parseDouble(bigo118.get(ti).toString()) > 2 ) {
		            							color = "red";
		            						} else {
		            							color = "black";
		            						}
	            						}
	            					} else {
	            						color = "black";
	            					}
	            					forecolor118.put(ti,color);
	            					ti++;
	            				}
	                        }
	            		} else {
	            			for( int e118=0;e118<addrList118.length;e118++ ) {
	            				start118.put(e118,"");
	            				bigo118.put(e118,"");
	            				forecolor118.put(e118,"");
	            			}
	            		}
	            		
	            		fixedAlarmList.add(0,start118);
	            		fixedAlarmList.add(1,bigo118);
	            		fixedAlarmList.add(2,forecolor118);
	            		
		        		break;
		        	case "276":
		        		fileTitle = "정기-276";
		        		
		        		Map start276 = new HashMap();
	            		Map end276 = new HashMap();
	            		Map cha276 = new HashMap();
	            		
	            		String[] addrList276 = strAddress.split(",");
	            		
	            		dccSearchAlarm.setpType(strPType+"0");
	            		
	            		List<DccAlarmInfo> dccAlarmInfoList276 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
	            		
	            		if( dccAlarmInfoList276.size() > 0 ) {
			        		for( DccAlarmInfo dccAlarmInfo276 : dccAlarmInfoList276 ) {
			            		int idx276=0;
			        			for( String address : addrList276 ) {
			        				if( address.equals(dccAlarmInfo276.getAlmAddress()) ) {
			        					if( "A".equalsIgnoreCase(dccAlarmInfo276.getAlmGubun()) ) {
			        						start276.put(idx276,dccAlarmInfo276.getAlmDate());
			        					} else if( "N".equalsIgnoreCase(dccAlarmInfo276.getAlmGubun()) ) {
			        						end276.put(idx276,dccAlarmInfo276.getAlmDate());
			        					}
			        				}
				        			idx276++;
			        			}
			        		}
			        		
			        		for( int ad=0;ad<24;ad+=2 ) {
			        			if( !"".equals(start276.get(ad)) || !"".equals(start276.get(ad+1)) ) {
			            			String sS276 = start276.get(ad).toString().trim();
			            			String sE276 = start276.get(ad+1).toString().trim();
			            			int iS276 = Integer.parseInt(sS276.substring(sS276.indexOf(".")+1,sS276.length()));
			            			int iE276 = Integer.parseInt(sE276.substring(sE276.indexOf(".")+1,sE276.length()));

			            			iSS = getDateGap(sS276,sE276);
			            			
			            			if( iS276 > iE276 ) {
			            				iSS--;
			            				iMM = 1000;
			            			} else {
			            				iMM = 0;
			            			}
			            			iMM = iMM + iE276 - iS276;
			            			
			            			String sMM = String.valueOf(iMM);
			            			sMM = sMM.length() > 3 ? sMM.substring(0,3) : sMM;
			            			
			            			while( sMM.length() < 3 ) {
			            				sMM = "0" + sMM;
			            			}
			            			
			            			cha276.put(ad,String.valueOf(iSS)+"."+sMM);
			            			cha276.put(ad+1,"");
			        			}
			        		}
	            		} else {
	            			for( int e276=0;e276<addrList276.length;e276++ ) {
	            				start276.put(e276,"");
	            				end276.put(e276,"");
	            				cha276.put(e276,"");
	            			}
	            		}
	            		
	        			fixedAlarmList.add(0,start276);
	        			fixedAlarmList.add(1,end276);
	        			fixedAlarmList.add(2,cha276);
	            		
		        		break;
		        	case "cor":
		        		fileTitle = "노심저차압";
		        		
		        		Map startCha = new HashMap();
	            		Map endCha = new HashMap();
	            		Map valCha = new HashMap();
	            		Map valChaCha = new HashMap();
		        		
		        		String[] addrListCor = strAddress.split(",");
		        		
		        		for( int idxC=0;idxC<addrListCor.length;idxC+=2 ) {
		        			if( idxC%2 == 0 ) {
		        				dccSearchAlarm.setStartDate(strSDate);
		        				dccSearchAlarm.setEndDate(strEDate);
		    	        		dccSearchAlarm.setpType(strPType+"e0");
			        			dccSearchAlarm.setAddress(addrListCor[idxC]);
			        			
				        		List<DccAlarmInfo> dccAlarmInfoListCor = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
				        		
				        		String sSC = "";
				        		String sEC = "";
				        		String sSC2 = "";
				        		String sEC2 = "";
				        		if( dccAlarmInfoListCor.size() > 0 ) {
					        		for( DccAlarmInfo dccAlarmInfoCor : dccAlarmInfoListCor ) {
					        			if( addrListCor[idxC].equals(dccAlarmInfoCor.getAlmAddress()) ) {
					        				if( "N".equalsIgnoreCase(dccAlarmInfoCor.getAlmGubun()) ) {
					        					endCha.put(idxC,dccAlarmInfoCor.getAlmDate());
					        				}
					        				if( "A".equalsIgnoreCase(dccAlarmInfoCor.getAlmGubun()) ) {
					        					startCha.put(idxC,dccAlarmInfoCor.getAlmDate());
					        				}
					        			}
					        		}
					        				
			            			sSC = startCha.get(idxC) != null ? startCha.get(idxC).toString().trim() : "";
			            			sEC = endCha.get(idxC) != null ? endCha.get(idxC).toString().trim() : "";
		
			            			if( !"".equals(sSC) && !"".equals(sEC) ) {
				            			iMM = Integer.parseInt(sEC.substring(sEC.indexOf(".")+1,sEC.length())) - Integer.parseInt(sSC.substring(sSC.indexOf(".")+1,sSC.length()));
				            			iSS = getDateGap(sSC,sEC);

				            			String strValCha = AlarmDateDiff(iMM,iSS);
				            			if( !"***IRR".equals(strValCha) ) {
				            				strValCha = String.valueOf(Math.abs(Double.parseDouble(strValCha)));
				            			}
				            			
				            			valCha.put(idxC,strValCha);
			            			} else {
			            				valCha.put(idxC,"");
			            			}

			            			if( !"".equals(sSC) && !"".equals(sEC) ) {
				            			
				            			dccSearchAlarm.setStartDate(sSC);
				    	        		dccSearchAlarm.setpType(strPType+"e1");
				            			
				            			List<DccAlarmInfo> dccAlarmInfoListCor2 = dccAlarmService.selectFixedAlarm(dccSearchAlarm);
			            			
				            			for( DccAlarmInfo dccAlarmInfoCor2 : dccAlarmInfoListCor2 ) {
						        			if( addrListCor[idxC+1].equals(dccAlarmInfoCor2.getAlmAddress()) ) {
						        				if( "N".equalsIgnoreCase(dccAlarmInfoCor2.getAlmGubun()) ) {
						        					endCha.put(idxC+1,dccAlarmInfoCor2.getAlmDate());
						        				}
						        				if( "A".equalsIgnoreCase(dccAlarmInfoCor2.getAlmGubun()) ) {
						        					startCha.put(idxC+1,dccAlarmInfoCor2.getAlmDate());
						        				}
						        			}
				            			}
						        				
				        				sSC2 = startCha.get(idxC+1) != null ? startCha.get(idxC+1).toString().trim() : "";
				            			sEC2 = endCha.get(idxC+1) != null ? endCha.get(idxC+1).toString().trim() : "";
				            			
				            			if( startCha.get(idxC+1) == null ) startCha.put(idxC+1,sSC2);
				            			if( endCha.get(idxC+1) == null ) endCha.put(idxC+1,sEC2);

				            			if( !"".equals(sSC2) && !"".equals(sEC2) ) {
					            			iMM = Integer.parseInt(sEC2.substring(sEC2.indexOf(".")+1,sEC2.length())) - Integer.parseInt(sSC2.substring(sSC2.indexOf(".")+1,sSC2.length()));
					            			iSS = getDateGap(sSC2,sEC2);

					            			String strValCha2 = AlarmDateDiff(iMM,iSS);
					            			if( !"***IRR".equals(strValCha2) ) {
					            				strValCha2 = String.valueOf(Math.abs(Integer.parseInt(strValCha2)));
					            			}
					            			
					            			valCha.put(idxC+1,strValCha2);
					            			
					            			iMM = Integer.parseInt(sEC2.substring(sEC2.indexOf(".")+1,sEC2.length())) - Integer.parseInt(sSC.substring(sSC.indexOf(".")+1,sSC.length()));
					            			iSS = getDateGap(sSC2,sSC);

					            			String strValChaCha = AlarmDateDiff(iMM,iSS);
					            			if( !"***IRR".equals(strValChaCha) ) {
					            				strValChaCha = String.valueOf(Math.abs(Integer.parseInt(strValChaCha)));
					            			}
					            			
					            			valChaCha.put((idxC+1)/2,strValChaCha);
				            			} else {
				            				valCha.put(idxC+1,"");
				            				valChaCha.put((idxC+1)/2,"");
				            			}
				        			}
		            			} else {
				        			for( int eCor=0;eCor<addrListCor.length;eCor++ ) {
				        				if( eCor%2 == 0 ) {
				        					startCha.put(eCor,"");
				        					startCha.put(eCor+1,"");
				        					endCha.put(eCor,"");
				        					endCha.put(eCor+1,"");
				        					valCha.put(eCor,"");
				        					valCha.put(eCor+1,"");
				        					valChaCha.put(eCor,"");
				        				}
				        			}
				        		}
		        			}
		        		}
		        		
		        		fixedAlarmList.add(0,startCha);
		        		fixedAlarmList.add(1,endCha);
		        		fixedAlarmList.add(2,valCha);
		        		fixedAlarmList.add(3,valChaCha);
		        		
		        		break;
	        	}
	        	
				excelHelperUtil.alarmFTCExcelDownload(request, response, "ALARMTEST", fileTitle,
						strSDate, strEDate, fixedAlarmList, lblTitles, lblLoops, lblCIs, strPType);
	        }
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("gaschromatography")
	public ModelAndView gaschromatography(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ gaschromatography");
        
        LocalDateTime lDtmS = LocalDateTime.now();
        LocalDateTime lDtmE = LocalDateTime.now();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        if( dccSearchAlarm.getStartDate() == null ) dccSearchAlarm.setStartDate(lDtmS.format(dtf));
        if( dccSearchAlarm.getEndDate() == null ) dccSearchAlarm.setEndDate(lDtmE.format(dtf));
        if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
    	}
    	if( dccSearchAlarm.getsDive() == null ) dccSearchAlarm.setsDive("D");
    	if( dccSearchAlarm.getsMenuNo() == null ) dccSearchAlarm.setsMenuNo("12");
    	//if( dccSearchAlarm.getsGrpID() == null ) dccSearchAlarm.setsGrpID("1");
    	if( dccSearchAlarm.getsUGrpNo() == null ) dccSearchAlarm.setsUGrpNo("1");
    	
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
    		if(dccSearchAlarm.getsMenuNo() == null || dccSearchAlarm.getsMenuNo().isEmpty()) {
        	
				dccSearchAlarm.setsDive("D");
				dccSearchAlarm.setsMenuNo("12");
				dccSearchAlarm.setsGrpID("Alarm");;
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchAlarm.setsHogi(member.getHogi());
	        	dccSearchAlarm.setsXYGubun(member.getXyGubun());
	        	
	        	//dccSearchAlarm.setsGrpID(member.getId());
	    	}
    		
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("xyGubun",dccSearchAlarm.getsXYGubun()==null?  "X": dccSearchAlarm.getsXYGubun());
    		dccGrpTagSearchMap.put("hogi",dccSearchAlarm.getsHogi()==null?  "3": dccSearchAlarm.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchAlarm.getsDive()==null?  "D": dccSearchAlarm.getsDive());
    		//dccGrpTagSearchMap.put("grpID", dccSearchAlarm.getsGrpID()==null?  "": dccSearchAlarm.getsGrpID());
    		dccGrpTagSearchMap.put("grpID", "mimic");
    		dccGrpTagSearchMap.put("menuNo", dccSearchAlarm.getsMenuNo()==null?  "12": dccSearchAlarm.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchAlarm.getsUGrpNo()==null?  "1": dccSearchAlarm.getsUGrpNo());
    		//dccGrpTagSearchMap.put("pSCanTime", dccSearchAlarm.getStartDate()==null?  "2022-12-01 14:52:01.000": dccSearchAlarm.getStartDate());

    		String sBit2 = "";
    		String sBit3 = "";
    		String sBit4 = "";
    		String sBit5 = "";
    		String sBit6 = "";
    		
    		String strLblTitle = "N/A";
    		String[] sStream = new String[6];
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
    		
    		mav.addObject("TagDccInfoList", tagDccInfoList);
    		
    		String[] varValue =  basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
    		//System.out.println("varValue=" + varValue.length);
    		List<Map> dccTagList = new ArrayList<Map>();
        	
    		int iRow = 0;
    		for(ComTagDccInfo tagDccInfo:tagDccInfoList) {
    			
    			Map rtnMap = new HashMap();

    			rtnMap.put("SCANTIME", varValue[0]);
    			rtnMap.put("IOTYPE", tagDccInfo.getIOTYPE());
    			
    			if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
    				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS()  + "-" +  tagDccInfo.getIOTYPE());
    			}else {
    				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS());    				
    			}
    			
    			rtnMap.put("DataLoop", tagDccInfo.getDataLoop());
    			rtnMap.put("Descr", tagDccInfo.getDescr());
    			rtnMap.put("MinVal", tagDccInfo.getMinVal());
    			rtnMap.put("MaxVal", tagDccInfo.getMaxVal());
    			rtnMap.put("ELow", tagDccInfo.getELOW());
    			rtnMap.put("EHigh", tagDccInfo.getEHIGH());
    			
    			if(varValue.length > 1) {
    				
//    				if(StringUtil.isNumeric(varValue[iRow + 1])){
//    					
//    					if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
//    	    				rtnMap.put("Value", GetBitVal(varValue[iRow + 1], ""+tagDccInfo.getIOBIT()));
//    					}else if(tagDccInfo.getIOTYPE().equals("DI")){
//    						rtnMap.put("Value", varValue[iRow + 1]);
//    					}else {
//    	    				rtnMap.put("Value", String.format(gFormat[tagDccInfo.getBScale()], varValue[iRow + 1])); 		
//    	    			}
//    				}
					rtnMap.put("Value", varValue[iRow + 1]);
					//System.out.println("Value=" + rtnMap.get("Value"));
					if(StringUtil.isNumeric(varValue[iRow + 1])){
        				if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getELOW() ) {
        					rtnMap.put("BackColor", "#fdf3c0");
        				} else if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getEHIGH() ){
        					rtnMap.put("BackColor", "#ff5f1f");
        				} else {
        					rtnMap.put("BackColor", "#ffffff");
        				}
    				} else {
    					rtnMap.put("BackColor", "#ffffff");
    				}
    			}
    			
    			rtnMap.put("Unit", tagDccInfo.getUnit());
    			rtnMap.put("rowNum", iRow+1);
    			
    			dccTagList.add(rtnMap);
    			iRow++;
    		}
    		
    		mav.addObject("DccTagList", dccTagList);
    		
    		String strLblDate = varValue[0];
    		
    		dccSearchAlarm.setEndDate(strLblDate);
    		dccSearchAlarm.setpType("0");
    		List<Map> historyInfoList = dccAlarmService.selectGasInfo(dccSearchAlarm);
    		
    		Map lblH2 = new HashMap();
    		Map lblO2 = new HashMap();
    		Map lblN2 = new HashMap();
    		Map lblD2 = new HashMap();
    		
    		if( historyInfoList.size() > 0 ) {
	        	sBit2 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"2");
	        	sBit3 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"3");
	        	sBit4 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"4");
	        	sBit5 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"5");
	        	sBit6 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"6");
	        	
	        	if( "1".equals(sBit2) && "0".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "경수영역 제어계통 재결합기 전단";
	        	} else if( "0".equals(sBit2) && "1".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "경수영역 제어계통 재결합기 후단";
	        	} else if( "1".equals(sBit2) && "1".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "감속재 상층기체 재결합기 전단";
	        	} else if( "0".equals(sBit2) && "0".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "감속재 상층기체 재결합기 후단";
	        	} else if( "1".equals(sBit2) && "0".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "중수저장탱크 Vent. Condenser";
	        	} else if( "0".equals(sBit2) && "1".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "예비용";
	        	} else if( "1".equals(sBit2) && "1".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "중수저장탱크 상층 기체";
	        	} else if( "0".equals(sBit2) && "0".equals(sBit3) && "0".equals(sBit4) && "1".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "교정 기체";
	        	} else {
	        		strLblTitle = "N/A";
	        	}
	        	
	        	String sEndDT = convDtm(strLblDate,false).format(dtf);
	        	String sStartDT = convDtm(strLblDate,false).minusHours(1).format(dtf);
	        	
	        	dccSearchAlarm.setStartDate(sStartDT);
	        	dccSearchAlarm.setEndDate(sEndDT);
	    		dccSearchAlarm.setpType("1");
	    		List<Map> historyInfoListPre = dccAlarmService.selectGasInfo(dccSearchAlarm);
	    		
	    		for( int hi=0;hi<historyInfoListPre.size();hi++ ) {
		    		sBit2 = basCommonService.GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"2");
		        	sBit3 = basCommonService.GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"3");
		        	sBit4 = basCommonService.GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"4");
		        	sBit5 = basCommonService.GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"5");
		        	sBit6 = basCommonService.GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"6");
		        	
		        	/*
		        	System.out.println("sBit2=" + sBit2);
		        	System.out.println("sBit3=" + sBit3);
		        	System.out.println("sBit4=" + sBit4);
		        	System.out.println("sBit5=" + sBit5);
		        	System.out.println("sBit6=" + sBit6);
		        	
		        	System.exit(0);
		        	*/
		        	
		        	String tmpScanTime = historyInfoListPre.get(hi).get("SCANTIME").toString();	
		        	tmpScanTime = tmpScanTime.indexOf(".") == -1 ? tmpScanTime+".000" : tmpScanTime;
		        	
		        	//System.out.println("tmpScanTime=" + tmpScanTime);		        	
		        	
		        	if( "1".equals(sBit2) && "0".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[0] = sStream[0] == null || "".equals(sStream[0]) ? tmpScanTime : sStream[0];
		        	} else if( "0".equals(sBit2) && "1".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[1] = sStream[1] == null || "".equals(sStream[1]) ? tmpScanTime : sStream[1];
		        	} else if( "1".equals(sBit2) && "1".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[2] = sStream[2] == null || "".equals(sStream[2]) ? tmpScanTime : sStream[2];
		        	} else if( "0".equals(sBit2) && "0".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[3] = sStream[3] == null || "".equals(sStream[3]) ? tmpScanTime : sStream[3];
		        	} else if( "1".equals(sBit2) && "0".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[4] = sStream[4] == null || "".equals(sStream[4]) ? tmpScanTime : sStream[4];
		        	} else if( "1".equals(sBit2) && "1".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[5] = sStream[5] == null || "".equals(sStream[5]) ? tmpScanTime : sStream[5];
		        	}
		        	
		        	int checker = 0;
		        	for( int si=0;si<sStream.length;si++ ) {
		        		if( !"".equals(sStream[si]) && sStream[si] != null ) {
		        			checker++;
		        		}
		        		
		        		if( checker > 5 ) hi = historyInfoListPre.size();
		        	}
	    		}
	    		
	    		for( int sa=0;sa<4;sa++ ) {
	    			if( sa == 0 ) {
	    				dccSearchAlarm.setAddress("2760");
	    			} else if( sa == 1 ) {
	    				dccSearchAlarm.setAddress("2762");
	    			} else if( sa == 2 ) {
	    				dccSearchAlarm.setAddress("2763");
	    			} else if( sa == 3 ) {
	    				dccSearchAlarm.setAddress("2761");
	    			}
	    			
	    			List<Map> dccStreamAIInfo = dccAlarmService.selectStreamAIInfo(dccSearchAlarm);
	    			
	    			String sSEQ = dccStreamAIInfo.get(0).get("TBLNO").toString();
	    			String sTVALUE = "TVALUE"+dccStreamAIInfo.get(0).get("FLDNO").toString();
	    			String sBSCALE = dccStreamAIInfo.get(0).get("BSCAL").toString();
	    			
	    			if( !"".equals(sSEQ) && !"".equals(sTVALUE) ) {	    				
	    				
	    				for( int qi=0;qi<sStream.length;qi++ ) {
	    					dccSearchAlarm.settValue(sTVALUE);
	    					dccSearchAlarm.setSeq(sSEQ);
	    					dccSearchAlarm.setEndDate(sStream[qi]);
	    					dccSearchAlarm.setpType("2");
	    					
	    					List<Map> historyInfoListDen = dccAlarmService.selectGasInfo(dccSearchAlarm);
	    					
	    					if( historyInfoListDen.size() > 0 ) {
	    						String fValue = historyInfoListDen.get(0).get("TVALUE").toString();
	    						
	    						String sDataConv = "";
	    						if( !"".equals(sBSCALE) ) {
	    							
	    							//System.out.println("fValue=" + fValue + "::::" + sBSCALE);
	    							
	    							//sDataConv = fValue.compareTo("-32768") > 0 ? String.format(gFormat[Integer.parseInt(sBSCALE)],fValue) : "***IRR";
	    							sDataConv = Double.parseDouble(fValue) > Double.parseDouble("-32768") ? fValue : "***IRR";
	    						} else {
	    							sDataConv = Double.parseDouble(fValue) > Double.parseDouble("-32768") ? fValue : "***IRR";
	    						}
	    						
	    						if( sa == 0 ) {
	    							lblH2.put("idx"+qi,sDataConv);
	    							//System.out.println("idx0"+lblH2.get("idx0"));
	    						} else if( sa == 1 ) {
	    							lblO2.put("idx"+qi,sDataConv);
	    						} else if( sa == 2 ) {
	    							lblN2.put("idx"+qi,sDataConv);
	    						} else if( sa == 3 ) {
	    							lblD2.put("idx"+qi,sDataConv);
	    						}
	    					}
	    				}
	    			}
	    		}
    		}

        	mav.addObject("LblTitle", strLblTitle);
        	mav.addObject("LblH2", lblH2);
        	mav.addObject("LblO2", lblO2);
        	mav.addObject("LblN2", lblN2);
        	mav.addObject("LblD2", lblD2);
    		
        	dccSearchAlarm.setMenuName(this.menuName);

        	userInfo.setHogi(dccSearchAlarm.getsHogi());
        	userInfo.setXyGubun(dccSearchAlarm.getsXYGubun());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
        }
        

        return mav;
    }
	
	@RequestMapping(value = "runtimerGC", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView runtimerGC(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ runtimeGC");
        
        LocalDateTime lDtmS = LocalDateTime.now();
        LocalDateTime lDtmE = LocalDateTime.now();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        if( dccSearchAlarm.getStartDate() == null ) dccSearchAlarm.setStartDate(lDtmS.format(dtf));
        if( dccSearchAlarm.getEndDate() == null ) dccSearchAlarm.setEndDate(lDtmE.format(dtf));
        if( dccSearchAlarm.getHogiHeader() != null ) {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi(dccSearchAlarm.getHogiHeader());
    	} else {
    		if( dccSearchAlarm.getHogi() == null ) dccSearchAlarm.setsHogi("3");
    	}
    	if( dccSearchAlarm.getXyHeader() != null ) {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun(dccSearchAlarm.getXyHeader());
    	} else {
    		if( dccSearchAlarm.getXyGubun() == null ) dccSearchAlarm.setsXYGubun("X");
    	}
    	if( dccSearchAlarm.getsDive() == null ) dccSearchAlarm.setsDive("D");
    	if( dccSearchAlarm.getsMenuNo() == null ) dccSearchAlarm.setsMenuNo("12");
    	//if( dccSearchAlarm.getsGrpID() == null ) dccSearchAlarm.setsGrpID("1");
    	if( dccSearchAlarm.getsUGrpNo() == null ) dccSearchAlarm.setsUGrpNo("1");
    	
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
    		if(dccSearchAlarm.getsMenuNo() == null || dccSearchAlarm.getsMenuNo().isEmpty()) {
        	
				dccSearchAlarm.setsDive("D");
				dccSearchAlarm.setsMenuNo("12");
				dccSearchAlarm.setsGrpID("mimic");;
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchAlarm.setsHogi(member.getHogi());
	        	dccSearchAlarm.setsXYGubun(member.getXyGubun());
	        	
	        	//dccSearchAlarm.setsGrpID(member.getId());
	    	}
    		
    		Map dccGrpTagSearchMap = new HashMap();
    		dccGrpTagSearchMap.put("xyGubun",dccSearchAlarm.getsXYGubun()==null?  "X": dccSearchAlarm.getsXYGubun());
    		dccGrpTagSearchMap.put("hogi",dccSearchAlarm.getsHogi()==null?  "3": dccSearchAlarm.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchAlarm.getsDive()==null?  "D": dccSearchAlarm.getsDive());
    		//dccGrpTagSearchMap.put("grpID", dccSearchAlarm.getsGrpID()==null?  "": dccSearchAlarm.getsGrpID());
    		dccGrpTagSearchMap.put("grpID", "Alarm");
    		dccGrpTagSearchMap.put("menuNo", dccSearchAlarm.getsMenuNo()==null?  "12": dccSearchAlarm.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchAlarm.getsUGrpNo()==null?  "1": dccSearchAlarm.getsUGrpNo());
    		//dccGrpTagSearchMap.put("pSCanTime", dccSearchAlarm.getStartDate()==null?  "2022-12-01 14:52:01.000": dccSearchAlarm.getStartDate());

    		String sBit2 = "";
    		String sBit3 = "";
    		String sBit4 = "";
    		String sBit5 = "";
    		String sBit6 = "";
    		
    		String strLblTitle = "N/A";
    		String[] sStream = new String[6];
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
    		
    		mav.addObject("TagDccInfoList", tagDccInfoList);
    		
    		String[] varValue =  basDccOsmsService.getDccValueReturn(dccGrpTagSearchMap);
    		
    		List<Map> dccTagList = new ArrayList<Map>();
        	
    		int iRow = 0;
    		for(ComTagDccInfo tagDccInfo:tagDccInfoList) {
    			
    			Map rtnMap = new HashMap();

    			rtnMap.put("SCANTIME", varValue[0]);
    			rtnMap.put("IOTYPE", tagDccInfo.getIOTYPE());
    			
    			if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
    				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS()  + "-" +  tagDccInfo.getIOTYPE());
    			}else {
    				rtnMap.put("ADDRESS", tagDccInfo.getADDRESS());    				
    			}
    			
    			rtnMap.put("DataLoop", tagDccInfo.getDataLoop());
    			rtnMap.put("Descr", tagDccInfo.getDescr());
    			rtnMap.put("MinVal", tagDccInfo.getMinVal());
    			rtnMap.put("MaxVal", tagDccInfo.getMaxVal());
    			rtnMap.put("ELow", tagDccInfo.getELOW());
    			rtnMap.put("EHigh", tagDccInfo.getEHIGH());
    			
    			if(varValue.length > 1) {
    				
//    				if(StringUtil.isNumeric(varValue[iRow + 1])){
//    					
//    					if(tagDccInfo.getIOTYPE().equals("DI") || tagDccInfo.getIOTYPE().equals("DO")) {
//    	    				rtnMap.put("Value", GetBitVal(varValue[iRow + 1], ""+tagDccInfo.getIOBIT()));
//    					}else if(tagDccInfo.getIOTYPE().equals("DI")){
//    						rtnMap.put("Value", varValue[iRow + 1]);
//    					}else {
//    	    				rtnMap.put("Value", String.format(gFormat[tagDccInfo.getBScale()], varValue[iRow + 1])); 		
//    	    			}
//    				}
					rtnMap.put("Value", varValue[iRow + 1]);
					if(StringUtil.isNumeric(varValue[iRow + 1])){
        				if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getELOW() ) {
        					rtnMap.put("BackColor", "#fdf3c0");
        				} else if( Double.parseDouble(varValue[iRow + 1]) < tagDccInfo.getEHIGH() ){
        					rtnMap.put("BackColor", "#ff5f1f");
        				} else {
        					rtnMap.put("BackColor", "#ffffff");
        				}
    				} else {
    					rtnMap.put("BackColor", "#ffffff");
    				}
    			}
    			
    			rtnMap.put("Unit", tagDccInfo.getUnit());
    			rtnMap.put("rowNum", iRow+1);
    			
    			dccTagList.add(rtnMap);
    			iRow++;
    		}
    		
    		mav.addObject("DccTagList", dccTagList);
    		
    		String strLblDate = varValue[0];
    		
    		dccSearchAlarm.setEndDate(strLblDate);
    		dccSearchAlarm.setpType("0");
    		List<Map> historyInfoList = dccAlarmService.selectGasInfo(dccSearchAlarm);
    		
    		Map lblH2 = new HashMap();
    		Map lblO2 = new HashMap();
    		Map lblN2 = new HashMap();
    		Map lblD2 = new HashMap();
    		
    		if( historyInfoList.size() > 0 ) {
	        	sBit2 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"2");
	        	sBit3 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"3");
	        	sBit4 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"4");
	        	sBit5 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"5");
	        	sBit6 = basCommonService.GetBitVal(historyInfoList.get(0).get("TVALUE").toString(),"6");
	        	
	        	if( "1".equals(sBit2) && "0".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "경수영역 제어계통 재결합기 전단";
	        	} else if( "0".equals(sBit2) && "1".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "경수영역 제어계통 재결합기 후단";
	        	} else if( "1".equals(sBit2) && "1".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "감속재 상층기체 재결합기 전단";
	        	} else if( "0".equals(sBit2) && "0".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "감속재 상층기체 재결합기 후단";
	        	} else if( "1".equals(sBit2) && "0".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "중수저장탱크 Vent. Condenser";
	        	} else if( "0".equals(sBit2) && "1".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "예비용";
	        	} else if( "1".equals(sBit2) && "1".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "중수저장탱크 상층 기체";
	        	} else if( "0".equals(sBit2) && "0".equals(sBit3) && "0".equals(sBit4) && "1".equals(sBit5) && "1".equals(sBit6) ) {
	        		strLblTitle = "교정 기체";
	        	} else {
	        		strLblTitle = "N/A";
	        	}
	        	
	        	String sEndDT = convDtm(strLblDate,false).format(dtf);
	        	String sStartDT = convDtm(strLblDate,false).minusHours(1).format(dtf);
	        	
	        	dccSearchAlarm.setStartDate(sStartDT);
	        	dccSearchAlarm.setEndDate(sEndDT);
	    		dccSearchAlarm.setpType("1");
	    		List<Map> historyInfoListPre = dccAlarmService.selectGasInfo(dccSearchAlarm);
	    		
	    		for( int hi=0;hi<historyInfoListPre.size();hi++ ) {
		    		sBit2 = basCommonService.GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"2");
		        	sBit3 =basCommonService. GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"3");
		        	sBit4 = basCommonService.GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"4");
		        	sBit5 = basCommonService.GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"5");
		        	sBit6 = basCommonService.GetBitVal(historyInfoListPre.get(hi).get("TVALUE").toString(),"6");
		        	
		        	String tmpScanTime = historyInfoListPre.get(hi).get("SCANTIME").toString();
		        	tmpScanTime = tmpScanTime.indexOf(".") == -1 ? tmpScanTime+".000" : tmpScanTime;
		        	if( "1".equals(sBit2) && "0".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[0] = sStream[0] == null || "".equals(sStream[0]) ? tmpScanTime : sStream[0];
		        	} else if( "0".equals(sBit2) && "1".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[1] = sStream[1] == null || "".equals(sStream[1]) ? tmpScanTime : sStream[1];
		        	} else if( "1".equals(sBit2) && "1".equals(sBit3) && "0".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[2] = sStream[2] == null || "".equals(sStream[2]) ? tmpScanTime : sStream[2];
		        	} else if( "0".equals(sBit2) && "0".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[3] = sStream[3] == null || "".equals(sStream[3]) ? tmpScanTime : sStream[3];
		        	} else if( "1".equals(sBit2) && "0".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[4] = sStream[4] == null || "".equals(sStream[4]) ? tmpScanTime : sStream[4];
		        	} else if( "1".equals(sBit2) && "1".equals(sBit3) && "1".equals(sBit4) && "0".equals(sBit5) && "1".equals(sBit6) ) {
		        		sStream[5] = sStream[5] == null || "".equals(sStream[5]) ? tmpScanTime : sStream[5];
		        	}
		        	
		        	int checker = 0;
		        	for( int si=0;si<sStream.length;si++ ) {
		        		if( !"".equals(sStream[si]) && sStream[si] != null ) {
		        			checker++;
		        		}
		        		
		        		if( checker > 5 ) hi = historyInfoListPre.size();
		        	}
	    		}
	    		
	    		for( int sa=0;sa<4;sa++ ) {
	    			if( sa == 0 ) {
	    				dccSearchAlarm.setAddress("2760");
	    			} else if( sa == 1 ) {
	    				dccSearchAlarm.setAddress("2762");
	    			} else if( sa == 2 ) {
	    				dccSearchAlarm.setAddress("2763");
	    			} else if( sa == 3 ) {
	    				dccSearchAlarm.setAddress("2761");
	    			}
	    			
	    			List<Map> dccStreamAIInfo = dccAlarmService.selectStreamAIInfo(dccSearchAlarm);
	    			
	    			String sSEQ = dccStreamAIInfo.get(0).get("TBLNO").toString();
	    			String sTVALUE = "TVALUE"+dccStreamAIInfo.get(0).get("FLDNO").toString();
	    			String sBSCALE = dccStreamAIInfo.get(0).get("BSCAL").toString();
	    			
	    			if( !"".equals(sSEQ) && !"".equals(sTVALUE) ) {
	    				for( int qi=0;qi<sStream.length;qi++ ) {
	    					dccSearchAlarm.settValue(sTVALUE);
	    					dccSearchAlarm.setSeq(sSEQ);
	    					dccSearchAlarm.setEndDate(sStream[qi]);
	    					
	    					List<Map> historyInfoListDen = dccAlarmService.selectGasInfo(dccSearchAlarm);
	    					
	    					if( historyInfoListDen.size() > 0 ) {
	    						String fValue = historyInfoListDen.get(0).get("TVALUE").toString();
	    						
	    						String sDataConv = "";
	    						if( !"".equals(sBSCALE) ) {
	    							sDataConv = Integer.parseInt(fValue) > -32768 ? String.format(gFormat[Integer.parseInt(sBSCALE)],fValue) : "***IRR";
	    						} else {
	    							sDataConv = Integer.parseInt(fValue) > -32768 ? fValue : "***IRR";
	    						}
	    						
	    						if( sa == 0 ) {
	    							lblH2.put("idx"+qi,sDataConv);
	    							//System.out.println(lblH2.get("idx0"));
	    						} else if( sa == 1 ) {
	    							lblO2.put("idx"+qi,sDataConv);
	    						} else if( sa == 2 ) {
	    							lblN2.put("idx"+qi,sDataConv);
	    						} else if( sa == 3 ) {
	    							lblD2.put("idx"+qi,sDataConv);
	    						}
	    					}
	    				}
	    			}
	    		}
    		}

        	mav.addObject("LblTitle", strLblTitle);
        	mav.addObject("LblH2", lblH2);
        	mav.addObject("LblO2", lblO2);
        	mav.addObject("LblN2", lblN2);
        	mav.addObject("LblD2", lblD2);
    		
        	dccSearchAlarm.setMenuName(this.menuName);

        	userInfo.setHogi(dccSearchAlarm.getsHogi());
        	userInfo.setXyGubun(dccSearchAlarm.getsXYGubun());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
        	
        }
        
        return mav;
    }
	
}
