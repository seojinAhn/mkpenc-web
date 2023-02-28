package com.mkpenc.alarm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.alarm.model.DccSearchAlarm;
import com.mkpenc.admin.model.MemberInfo;
import com.mkpenc.alarm.model.DccAlarmInfo;
import com.mkpenc.alarm.service.DccAlarmService;
import com.mkpenc.common.model.ComTagDccInfo;
import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.common.model.Upload;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.common.module.FileHelperUtil;
import com.mkpenc.common.module.PageHtmlUtil;
import com.mkpenc.common.module.StringUtil;
import com.mkpenc.common.service.BasCommonService;
import com.mkpenc.common.service.BasDccMimicService;
import com.mkpenc.common.service.BasDccOsmsService;
import com.mkpenc.performance.model.DccSearchPerformance;
import com.mkpenc.tip.model.DccIolistInfo;

import static org.mockito.ArgumentMatchers.contains;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
    		
    		String groupName = basCommonService.selectGrpNameListB(searchMapGrpNm).get(0) == null ? "경보 설정" : basCommonService.selectGrpNameListB(searchMapGrpNm).get(0);
    		
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
        	
        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	dccSearchAlarm.setMenuName(this.menuName);

        	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
        	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
        	
        }
        

        return mav;
    }
	
	@RequestMapping("gaschromatography")
	public ModelAndView gaschromatography(DccSearchAlarm dccSearchAlarm, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();


        logger.info("############ gaschromatography");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	dccSearchAlarm.setMenuName(this.menuName);

        	userInfo.setHogi(dccSearchAlarm.getHogiHeader());
        	userInfo.setXyGubun(dccSearchAlarm.getXyHeader());
        	
        	mav.addObject("BaseSearch", dccSearchAlarm);
        	mav.addObject("UserInfo", userInfo);
        	
        }
        

        return mav;
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
}
