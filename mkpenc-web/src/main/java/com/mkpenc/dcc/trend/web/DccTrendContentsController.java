package com.mkpenc.dcc.trend.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.common.module.StringUtil;
import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.service.DccAdminService;
import com.mkpenc.dcc.alarm.model.DccSearchAlarm;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.dcc.common.service.BasDccOsmsService;
import com.mkpenc.dcc.trend.model.DccSearchTrend;
import com.mkpenc.dcc.trend.service.DccTrendService;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/trend/")
public class DccTrendContentsController {
	
	private static Logger logger = LoggerFactory.getLogger(DccTrendContentsController.class);
	private static final Integer nTrendWidth = 840;
	private static final int cnstNull = -99999;
	private static final int cnstErr = -32768;
	private static final String cnstErrStr = "***IRR";
	
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
	
	private String menuName = "TREND";
	
	@Autowired
	private DccAdminService dccAdminService;
	
	@Autowired
	private DccTrendService dccTrendService;

	@Autowired
	private BasDccOsmsService basDccOsmsService;
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired
	private ExcelHelperUtil excelHelperUtil;
	
	@RequestMapping("realtimetrendfixed")
	public ModelAndView realtimetrendfixed(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ realtimetrendfixed");
		
		if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
    	}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		
		MemberInfo mberInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(mberInfo.getId());
		MemberInfo userInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			getTrendData(dccSearchTrend,mav,userInfo);
			//getGrpTagList(dccSearchTrend,mav);
			
			//changeGrpName(dccSearchTrend,mav);
	    	
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			
		}

		return mav;
	}
	
	private void getTrendData(DccSearchTrend dccSearchTrend, ModelAndView mav, MemberInfo userInfo) {
		String strHogi = dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi();
		String strXY = dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? userInfo.getId() : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "" : dccSearchTrend.getsUGrpNo();
    	String sFixed = dccSearchTrend.getFixed() == null ? "F" : dccSearchTrend.getFixed();
    	String sGrade = userInfo.getGrade() == null ? "9" : dccSearchTrend.getFixed();
    	String strHis = dccSearchTrend.getgHis() == null ? "R" : dccSearchTrend.getgHis();
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
    	int nType = 0;
    	
    	LocalDateTime endDate = LocalDateTime.now();
    	LocalDateTime startDate = endDate.minusMinutes(10);
    	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
    	
    	String mskStart = dccSearchTrend.getStartDate();
    	String mskEnd = dccSearchTrend.getEndDate();
		
    	switch( sFixed.toUpperCase() ) {
	    	case "F":
	    		strGrpID = "Trend";
	    		strMenuNo = "21";
	    		break;
	    	case "S":
	    		strGrpID = userInfo.getId();
	    		strMenuNo = "22";
	    		break;
	    	case "A":
	    		strGrpID = "Trend";
	    		strMenuNo = "51";
	    		break;
	    	case "B":
	    		strGrpID = userInfo.getId();
	    		strMenuNo = "91";
	    		break;
    	}
    	
    	if( "R".equalsIgnoreCase(strHis) ) {
    		nType = 0;
    	} else {
    		nType = 1;
    		mskStart = mskStart == null ? dtf.format(startDate) : mskStart;
    		mskEnd = mskEnd == null ? dtf.format(endDate) : mskEnd;
    	}
    	
    	Long lGap = Long.parseLong(dccSearchTrend.getTxtTimeGap())*1000;
    	
    	Map trendSearchMap = new HashMap();
    	trendSearchMap.put("sDive",strDive);
    	trendSearchMap.put("sGrpID",strGrpID);
    	trendSearchMap.put("sMenuNo",strMenuNo);
    	
    	List<Map> dccGroupNmaeList = dccTrendService.selectGroupName(trendSearchMap);
    	List<Map> dccGroupList = new ArrayList<Map>();
    	
    	for( Map dccGroupInfo : dccGroupNmaeList ) {
    		Map tmpMap = new HashMap();
    		
    		String tmpGrpNo = dccGroupInfo.get("UGrpNo") != null ? dccGroupInfo.get("UGrpNo").toString() : "";
    		while( tmpGrpNo.length() < 3 ) {
    			tmpGrpNo = "0"+tmpGrpNo;
    		}
    		
    		tmpMap.put("groupName",strHogi+"-"+tmpGrpNo+" "+dccGroupInfo.get("UGrpName").toString());
    		tmpMap.put("groupNo",dccGroupInfo.get("UGrpNo").toString());
    		
    		dccGroupList.add(tmpMap);
    	}
    	
    	mav.addObject("DccGroupList",dccGroupList);
	}
	
	private List<Map> getTrendDataE(DccSearchTrend dccSearchTrend, MemberInfo userInfo) {
		String strHogi = dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi();
		String strXY = dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? userInfo.getId() : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "" : dccSearchTrend.getsUGrpNo();
    	String sFixed = dccSearchTrend.getFixed() == null ? "F" : dccSearchTrend.getFixed();
    	String sGrade = userInfo.getGrade() == null ? "9" : dccSearchTrend.getFixed();
    	String strHis = dccSearchTrend.getgHis() == null ? "R" : dccSearchTrend.getgHis();
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
    	int nType = 0;
    	
    	LocalDateTime endDate = LocalDateTime.now();
    	LocalDateTime startDate = endDate.minusMinutes(10);
    	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
    	
    	String mskStart = dccSearchTrend.getStartDate();
    	String mskEnd = dccSearchTrend.getEndDate();
		
    	switch( sFixed.toUpperCase() ) {
	    	case "F":
	    		strGrpID = "Trend";
	    		strMenuNo = "21";
	    		break;
	    	case "S":
	    		strGrpID = userInfo.getId();
	    		strMenuNo = "22";
	    		break;
	    	case "A":
	    		strGrpID = "Trend";
	    		strMenuNo = "51";
	    		break;
	    	case "B":
	    		strGrpID = userInfo.getId();
	    		strMenuNo = "91";
	    		break;
    	}
    	
    	if( "R".equalsIgnoreCase(strHis) ) {
    		nType = 0;
    	} else {
    		nType = 1;
    		mskStart = mskStart == null ? dtf.format(startDate) : mskStart;
    		mskEnd = mskEnd == null ? dtf.format(endDate) : mskEnd;
    	}
    	
    	Long lGap = Long.parseLong(dccSearchTrend.getTxtTimeGap())*1000;
    	
    	Map trendSearchMap = new HashMap();
    	trendSearchMap.put("sDive",strDive);
    	trendSearchMap.put("sGrpID",strGrpID);
    	trendSearchMap.put("sMenuNo",strMenuNo);
    	
    	List<Map> dccGroupNmaeList = dccTrendService.selectGroupName(trendSearchMap);
    	List<Map> dccGroupList = new ArrayList<Map>();
    	
    	for( Map dccGroupInfo : dccGroupNmaeList ) {
    		Map tmpMap = new HashMap();
    		
    		String tmpGrpNo = dccGroupInfo.get("UGrpNo") != null ? dccGroupInfo.get("UGrpNo").toString() : "";
    		while( tmpGrpNo.length() < 3 ) {
    			tmpGrpNo = "0"+tmpGrpNo;
    		}
    		
    		tmpMap.put("groupName",strHogi+"-"+tmpGrpNo+" "+dccGroupInfo.get("UGrpName").toString());
    		tmpMap.put("groupNo",dccGroupInfo.get("UGrpNo").toString());
    		
    		dccGroupList.add(tmpMap);
    	}
    	
    	return dccGroupList;
	}
	
	private void getGrpTagList(DccSearchTrend dccSearchTrend, ModelAndView mav) {
		LocalDateTime endDate = LocalDateTime.now();
    	LocalDateTime startDate = endDate.minusMinutes(10);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

		String strHogi = dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi();
		String strXY = dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? "" : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "" : dccSearchTrend.getsUGrpNo();
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
		
		Map searchMap = new HashMap();
		searchMap.put("xyGubun",strXY);
		searchMap.put("hogi",strHogi);
		searchMap.put("dive",strDive);
		searchMap.put("grpID",strGrpID);
		searchMap.put("menuNo",strMenuNo);
		searchMap.put("uGrpNo",strUGrpNo);
		searchMap.put("startDate",dccSearchTrend.getStartDate() == null ? addDate("s",endDate.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
		searchMap.put("endDate",dccSearchTrend.getEndDate() == null ? endDate.format(dtf)+".000" : dccSearchTrend.getEndDate());

		List<ComTagDccInfo> dccGrpTagList = basDccOsmsService.getDccGrpTagList(searchMap);
		Map dccVal = basDccOsmsService.getDccValue(searchMap, dccGrpTagList);

		Map lblTagList = new HashMap();
		Map lblValueList = new HashMap();
		Map lblUnitList = new HashMap();
		
		for( int ll=0;ll<dccGrpTagList.size();ll++ ) {
			System.out.println(((List) dccVal.get("lblDataList")).get(ll));
			lblTagList.put(ll,dccGrpTagList.get(ll).getHogi()+dccGrpTagList.get(ll).getXYGubun()+" "+dccGrpTagList.get(ll).getDataLoop());
			lblValueList.put(ll,((List) dccVal.get("lblDataList")).get(ll));
			lblUnitList.put(ll,dccGrpTagList.get(ll).getUnit());
		}
		
		List<Map> lblInfoList = new ArrayList();
		lblInfoList.add(0,lblTagList);
		lblInfoList.add(1,lblValueList);
		lblInfoList.add(2,lblUnitList);
		
		System.out.println(lblInfoList.get(1));
		
		mav.addObject("LblInfoList",lblInfoList);
	}
	
	private List<Map> getGrpTagListE(DccSearchTrend dccSearchTrend) {
		LocalDateTime endDate = LocalDateTime.now();
    	LocalDateTime startDate = endDate.minusMinutes(10);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

		String strHogi = dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi();
		String strXY = dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? "" : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "" : dccSearchTrend.getsUGrpNo();
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
		
		Map searchMap = new HashMap();
		searchMap.put("xyGubun",strXY);
		searchMap.put("hogi",strHogi);
		searchMap.put("dive",strDive);
		searchMap.put("grpID",strGrpID);
		searchMap.put("menuNo",strMenuNo);
		searchMap.put("uGrpNo",strUGrpNo);
		searchMap.put("startDate",dccSearchTrend.getStartDate() == null ? addDate("s",endDate.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
		searchMap.put("endDate",dccSearchTrend.getEndDate() == null ? endDate.format(dtf)+".000" : dccSearchTrend.getEndDate());

		List<ComTagDccInfo> dccGrpTagList = basDccOsmsService.getDccGrpTagList(searchMap);
		Map dccVal = basDccOsmsService.getDccValue(searchMap, dccGrpTagList);

		Map lblTagList = new HashMap();
		Map lblValueList = new HashMap();
		Map lblUnitList = new HashMap();
		
		for( int ll=0;ll<dccGrpTagList.size();ll++ ) {
			System.out.println(((List) dccVal.get("lblDataList")).get(ll));
			lblTagList.put(ll,dccGrpTagList.get(ll).getHogi()+dccGrpTagList.get(ll).getXYGubun()+" "+dccGrpTagList.get(ll).getDataLoop());
			lblValueList.put(ll,((List) dccVal.get("lblDataList")).get(ll));
			lblUnitList.put(ll,dccGrpTagList.get(ll).getUnit());
		}
		
		List<Map> lblInfoList = new ArrayList();
		lblInfoList.add(0,lblTagList);
		lblInfoList.add(1,lblValueList);
		lblInfoList.add(2,lblUnitList);
		
		return lblInfoList;
	}
	
	@RequestMapping(value="changeGrpName", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView changeGrpName(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		logger.info("############ realtimetrendfixed");
		
		LocalDateTime endDate = LocalDateTime.now();
    	LocalDateTime startDate = endDate.minusMinutes(10);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
		
		if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
    	}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		if( dccSearchTrend.getStartDate() == null ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf)+".000",-650));
		if( dccSearchTrend.getEndDate() == null ) dccSearchTrend.setEndDate(endDate.format(dtf)+".000");
	    
		MemberInfo mberInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(mberInfo.getId());
		MemberInfo userInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			dccSearchTrend.setMenuName(this.menuName);
			
			dccSearchTrend.setsUGrpNo(dccSearchTrend.getsUGrpNo() == null ? mberInfo.getId() : dccSearchTrend.getsUGrpNo());
			
			getGrpTagList(dccSearchTrend,mav);
			
			changeGrpName(dccSearchTrend,mav);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
		}
	
		return mav;
	}
	
	private void changeGrpName(DccSearchTrend dccSearchTrend, ModelAndView mav) {
		
		logger.info("############ realtimetrendfixed");
		
		if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
    	}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
	    	
		dccSearchTrend.setMenuName(this.menuName);
		
		String strDive = dccSearchTrend.getsDive();
		
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		
		Map searchMap = new HashMap();
		searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
		searchMap.put("hogi",dccSearchTrend.getsHogi());
		searchMap.put("dive",dccSearchTrend.getsDive());
		searchMap.put("grpID",dccSearchTrend.getsGrpID());
		searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
		searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
		searchMap.put("startDate",dccSearchTrend.getStartDate() == null ? addDate("s",now.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
		searchMap.put("endDate",dccSearchTrend.getEndDate() == null ? now.format(dtf)+".000" : dccSearchTrend.getEndDate());
		
		System.out.println(searchMap.get("startDate")+" // "+searchMap.get("endDate"));
		
		List<ComTagDccInfo> dccGrpTagList = new ArrayList();
		Map dccVal = new HashMap();
		List<Map> grpTagList = new ArrayList();
		if( "D".equalsIgnoreCase(strDive) ) {
			dccGrpTagList = basDccOsmsService.getDccGrpTagList(searchMap);
			dccVal = basDccOsmsService.getDccValue(searchMap, dccGrpTagList);
		} else if( "B".equalsIgnoreCase(strDive) ) {
			grpTagList = dccTrendService.getGrpTag(searchMap);
		}
		
		System.out.println(dccGrpTagList.size());
		if( dccGrpTagList.size() > 0 ) {
			Map tmpTagName = new HashMap();
			Map tmpUnit = new HashMap();
			Map tmpMax = new HashMap();
			Map tmpMin = new HashMap();
			Map tmpHiAlarm = new HashMap();
			Map tmpLoAlarm = new HashMap();
			Map tmpDtabHi = new HashMap();
			Map tmpDtabLo = new HashMap();
			
			int idx=0;
			for( ComTagDccInfo comTagDccInfo : dccGrpTagList ) {
				
				tmpTagName.put(idx,comTagDccInfo.getHogi()+comTagDccInfo.getXYGubun()+" "+comTagDccInfo.getDataLoop());
				tmpUnit.put(idx,comTagDccInfo.getUnit());
				tmpMax.put(idx,comTagDccInfo.getMaxVal());
				tmpMin.put(idx,comTagDccInfo.getMinVal());
				
				switch( comTagDccInfo.getAlarmType() ) {
					case "1": case "7":
						tmpHiAlarm.put(idx,comTagDccInfo.getDataLimit1());
						tmpLoAlarm.put(idx,"");
						tmpDtabHi.put(idx,"");
						tmpDtabLo.put(idx,"");
						break;
					case "2": case "8":
						tmpHiAlarm.put(idx,"");
						tmpLoAlarm.put(idx,comTagDccInfo.getDataLimit2());
						tmpDtabHi.put(idx,"");
						tmpDtabLo.put(idx,"");
						break;
					case "3":
						tmpHiAlarm.put(idx,comTagDccInfo.getDataLimit1());
						tmpLoAlarm.put(idx,comTagDccInfo.getDataLimit2());
						tmpDtabHi.put(idx,"");
						tmpDtabLo.put(idx,"");
						break;
					case "4":
						tmpHiAlarm.put(idx,"");
						tmpLoAlarm.put(idx,"");
						tmpDtabHi.put(idx,comTagDccInfo.getDataLimit1());
						tmpDtabLo.put(idx,"");
						break;
					case "5":
						tmpHiAlarm.put(idx,"");
						tmpLoAlarm.put(idx,"");
						tmpDtabHi.put(idx,"");
						tmpDtabLo.put(idx,comTagDccInfo.getDataLimit1());
						break;
					case "6":
						tmpHiAlarm.put(idx,"");
						tmpLoAlarm.put(idx,"");
						tmpDtabHi.put(idx,comTagDccInfo.getDataLimit1());
						tmpDtabLo.put(idx,comTagDccInfo.getDataLimit1());
						break;
				}
				
				idx++;
			}

			mav.addObject("LblValue",dccVal.get("lblDataList"));
			mav.addObject("LblTagName",tmpTagName);
			mav.addObject("LblUnit",tmpUnit);
			mav.addObject("minList",tmpMin);
			mav.addObject("maxList",tmpMax);
			mav.addObject("FHiAlarm",tmpHiAlarm);
			mav.addObject("FLoAlarm",tmpLoAlarm);
			mav.addObject("FDtabHi",tmpDtabHi);
			mav.addObject("FDtabLo",tmpDtabLo);
		}
		
		getTrendView(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, mav);
		
		mav.addObject("DccGrpTagList",dccGrpTagList);
		
	}
	
	private String addDate(String type, String dtm, int diff) {
		LocalDateTime ldt = convDtm(dtm,true);
		String rtv = "";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String millis = "";
		String tmpMillis = dtm.indexOf(".") > -1 ? dtm.substring(dtm.indexOf(".")+1,dtm.length()) : "0";
		
		switch( type ) {
		case "y":
			rtv = ldt.plusYears(diff).format(dtf)+"."+tmpMillis;
			break;
		case "m":
			rtv = ldt.plusMonths(diff).format(dtf)+"."+tmpMillis;
			break;
		case "d":
			rtv = ldt.plusDays(diff).format(dtf)+"."+tmpMillis;
			break;
		case "h":
			rtv = ldt.plusHours(diff).format(dtf)+"."+tmpMillis;
			break;
		case "n":
			rtv = ldt.plusMinutes(diff).format(dtf)+"."+tmpMillis;
			break;
		case "s":
			rtv = ldt.plusSeconds(diff).format(dtf)+"."+tmpMillis;
			break;
		case "mi":
			int newMillis = Integer.parseInt(tmpMillis)*1000 + diff*1000;
			
			if( newMillis < 0 ) {
				if( newMillis < -1000 ) {
					if( newMillis%1000 == 0 ) {
						rtv = ldt.minusSeconds((newMillis/1000)).format(dtf);
					} else {
						rtv = ldt.minusSeconds((newMillis/1000)+1).format(dtf);
					}
				}
				millis = String.valueOf(1000 - (newMillis - (newMillis/1000)*1000));
				
				rtv = rtv+"."+millis;
			} else if( newMillis >= 0 && newMillis < 1000 ){
				millis = diff+"";
				
				rtv = rtv+"."+millis;
			} else {
				if( newMillis > 1000 ) rtv = ldt.plusSeconds((newMillis/1000)).format(dtf);
				
				millis = String.valueOf(newMillis - (newMillis/1000)*1000);
				
				rtv = rtv+"."+millis;
			}
			break;
		}
		
		return rtv;
	}
		
		
	private void getTrendView(DccSearchTrend dccSearchTrend, List<ComTagDccInfo> dccGrpTagList, List<Map> grpTagList, Map searchMap, ModelAndView mav) {
		
		String strUGrpNo = dccSearchTrend.getsUGrpNo();
		String strTimeGap = dccSearchTrend.getTxtTimeGap();
		Long lGap = Long.parseLong(strTimeGap)*1000;
		String strFast = "";
		String sDtm = dccSearchTrend.getStartDate();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		String strStartTime = "";
		String strEndTime = "";

		List<Map> arrTrendData = new ArrayList();
		
		//TrendView
		for( int di=0;di<dccGrpTagList.size();di++ ) {
			if( dccGrpTagList.get(di).getFASTIOCHK() != 1 ) {
				if( Double.parseDouble(strTimeGap) < 5 ) {
					strTimeGap = "5";
					lGap = 5000L;
					strFast = "";
					String eDtm = dtf.format(convDtm(sDtm,false).plusSeconds(840));
					
					di = dccGrpTagList.size();
				}
			}
		}
		
		String strScanTime = "";
		if( "R".equalsIgnoreCase(dccSearchTrend.getgHis()) ) {
			//Call RealTime
			strScanTime = dccTrendService.selectScanTime(dccSearchTrend) == null ? "" : dccTrendService.selectScanTime(dccSearchTrend);
			
			switch( dccSearchTrend.getsDive().toUpperCase() ) {
				case "M": case "A":
					lGap = Long.parseLong(strTimeGap) * 1000;
					strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*nTrendWidth));
					strEndTime = strScanTime;
					break;
				case "D":
					lGap = Long.parseLong(strTimeGap) * 1000;
					if( "F".equalsIgnoreCase(strFast) || "0.5".equals(strTimeGap) ) {
						strFast = "F";
						for( int i=0;i<dccGrpTagList.size();i++ ) {
							if( dccGrpTagList.get(i).getFASTIOCHK() != 1 ) {
								if( "0.5".equals(strTimeGap) ) strTimeGap = "5";
								lGap = Long.parseLong(strTimeGap) * 1000;
								strFast = "5";
								
								i = dccGrpTagList.size();
							}
						}
					}
					
					if( "F".equalsIgnoreCase(strFast) ) {
						strTimeGap = "0.5";
						lGap = 500L;
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds(440));
						strEndTime = strScanTime;
					} else {
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*(nTrendWidth+10)));
						strEndTime = strScanTime;
					}
					break;
				case "B":
					lGap = Long.parseLong(strTimeGap) * 1000;
					if( "F".equalsIgnoreCase(strFast) || "0.5".equals(strTimeGap) ) {
						strFast = "F";
						for( int i=0;i<grpTagList.size();i++ ) {
							if( !"1".equals(grpTagList.get(i).get("FASTIOCHK").toString()) ) {
								if( "0.5".equals(strTimeGap) ) strTimeGap = "5";
								lGap = Long.parseLong(strTimeGap) * 1000;
								strFast = "5";
								
								i = grpTagList.size();
							}
						}
					}
					
					if( "F".equalsIgnoreCase(strFast) ) {
						strTimeGap = "0.5";
						lGap = 500L;
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds(440));
						strEndTime = strScanTime;
					} else {
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*(nTrendWidth+10)));
						strEndTime = strScanTime;
					}
					break;
			}
		}
		
		//Call Historical
		String pScanTime = "";
		if( "".equals(strScanTime) ) {
			pScanTime = dccTrendService.selectScanTime(dccSearchTrend);
			lGap = Long.parseLong(strTimeGap) * 1000;
			strStartTime = dtf.format(convDtm(pScanTime,true).minusSeconds((lGap/1000)*nTrendWidth));
			strEndTime = pScanTime;
		}
		
		Duration durSec = Duration.between(convDtm(strStartTime.replaceAll("/", "-"),true),convDtm(strEndTime.replaceAll("/", "-"),true));
		int nSec = (int) durSec.getSeconds();
		int nBun = (nSec-nSec%60)/60;
		
		dccSearchTrend.setStartDate(strStartTime);
		dccSearchTrend.setEndDate(strEndTime);

		//frmProgressBar.show
		List<Map> rsTrendListHistorical = new ArrayList();
		switch( dccSearchTrend.getsDive().toUpperCase() ) {
			case "M":
				//rsTrendListpHistorical = dccTrendService.rsTrend5sGapMark(searchMap, dccGrpTagList, lGap, strFast);
				break;
			case "A":
				//rsTrendListpHistorical = dccTrendService.rsTrend5sGapAux(searchMap, dccGrpTagList, lGap, strFast);
				break;
			case "D":
				if( "4".equals(dccSearchTrend.getsHogi()) ) {
					//List<Map> rsTrendList = dccTrendService.rsTrend5sGap222(searchMap, dccGrpTagList, lGap, strFast);
				} else {
					//rsTrendListHistorical = dccTrendService.rsTrend5sGap(searchMap, dccGrpTagList, lGap, strFast);
					rsTrendListHistorical = getRsTrend5sGap(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
				}
				break;
			case "B":
				//rsTrendListpHistorical = dccTrendService.rsTrend5sGapDccMark(searchMap, dccGrpTagList, lGap, strFast);
				break;
		}
		
		int nEndPos = 0;
		if( "R".equalsIgnoreCase(dccSearchTrend.getgHis()) ) {
			nEndPos = nTrendWidth;
		} else {
			nEndPos = rsTrendListHistorical.size() > nTrendWidth ? nTrendWidth : rsTrendListHistorical.size();
		}
		
		String sDateS = "";
		String sDateE = "";
		int iRow = 0;

		for( int ht=0;ht<rsTrendListHistorical.size();ht++ ) {
			Map rtnMapHistorical = new HashMap();
			Map timeNPosH = new HashMap();
			timeNPosH.put("m_time",rsTrendListHistorical.get(ht).get("").toString());
			timeNPosH.put("m_xpos",ht+"");
			for( int hi=0;hi<dccGrpTagList.size();hi++ ) {
				String[] dccGrpTagArray = {
					dccGrpTagList.get(hi).getIOTYPE(),
					dccGrpTagList.get(hi).getIOBIT()+"",
					dccGrpTagList.get(hi).getSaveCore()+"",
					dccGrpTagList.get(hi).getBScale()+"",
					dccGrpTagList.get(hi).getADDRESS(),
					dccGrpTagList.get(hi).getFASTIOCHK()+""
				};
				
				String RetVal = setDataConv(ht,rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)).toString(),dccGrpTagArray,dccSearchTrend.getsMenuNo(),lGap);
				
				int nRetValType = 0;
				Double tmpN = 0d;
				try {
					if( RetVal == null ) {
						nRetValType = 2;
					} else {
						tmpN = Double.parseDouble(RetVal);
						nRetValType = 0;
					}
				} catch( NumberFormatException nfe ) {
					nRetValType = 1;
				}
				
				if( nRetValType == 0 ) {
					if( "AI".equalsIgnoreCase(dccGrpTagArray[0]) && ("2753".equals(dccGrpTagArray[4]) || "2754".equals(dccGrpTagArray[4])) ) {
						rtnMapHistorical.put(hi,tmpN*1000+"");
					} else {
						rtnMapHistorical.put(hi,tmpN+"");
					}
					
					sDateS = rsTrendListHistorical.get(ht).get("").toString();
					iRow = hi;
				} else if( nRetValType == 1 ) {
					rtnMapHistorical.put(hi,cnstErr+"");
				} else {
					rtnMapHistorical.put(hi,cnstNull+"");
				}
			}
			for( int hii=0;hii<rtnMapHistorical.size();hii++ ) {
				if( hii == 0 ) System.out.println(hii+" >>>>> "+rtnMapHistorical.get(hii));
			}
			
			timeNPosH.put("m_data",rtnMapHistorical);
			
			arrTrendData.add(ht,timeNPosH);
		}
		
		LocalDateTime now = LocalDateTime.now();
		int nDateDiff = (int) Duration.between(now,convDtm(strStartTime,true)).getSeconds();
		if( Math.abs((nDateDiff-nDateDiff%60)/60) > 20 ) {
			sDateE = arrTrendData.get(nEndPos).toString();
			
			if( !"".equals(sDateS) && !"".equals(sDateE) ) {
				if( !sDateS.equals(sDateE) ) {
					searchMap.replace("startDate",sDateS);
					searchMap.replace("endDate",sDateE);
					//List<Map> rsTrendListHistorical2 = dccTrendService.rsTrend5sGap(searchMap, dccGrpTagList, lGap, strFast);
					List<Map> rsTrendListHistorical2 = getRsTrend5sGap(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
					
					int iPoint = 0;
					if( rsTrendListHistorical2.size() < 1 ) {
						iPoint = -1;
					} else {
						iPoint = rsTrendListHistorical2.size();
					}
					
					for( int subi=iRow;subi<nEndPos;subi++ ) {
						if( iPoint > (subi-iRow) ) {
							arrTrendData.get(subi).replace("m_time", rsTrendListHistorical2.get(subi-iRow).get("").toString());
							arrTrendData.get(subi).replace("m_xpos", subi+"");
							
							for( int subj=0;subj<dccGrpTagList.size();subj++ ) {
								if( rsTrendListHistorical2.get(subi-iRow).get("tvalue"+(subj+1)) == null || "".equals(rsTrendListHistorical2.get(subi-iRow).get("tvalue"+(subj+1))) ) {
									((Map) arrTrendData.get(subi).get("m_data")).replace(subj,cnstNull+"");
								} else {
									switch( dccSearchTrend.getsDive().toUpperCase() ) {
									case "M":
										//((Map) arrTrendData.get(subi).get("m_data")).replace(subj,CheckValueMark(rsTrendListHistorical2.get(subi-iRow).get(subj).toString()));
										break;
									case "A":
										//((Map) arrTrendData.get(subi).get("m_data")).replace(subj,CheckValueAux(rsTrendListHistorical2.get(subi-iRow).get(subj).toString()));
										break;
									case "D":
										String[] dccGrpTagArray = {
											dccGrpTagList.get(subj).getIOTYPE(),
											dccGrpTagList.get(subj).getIOBIT()+"",
											dccGrpTagList.get(subj).getSaveCore()+"",
											dccGrpTagList.get(subj).getBScale()+"",
											dccGrpTagList.get(subj).getADDRESS(),
											dccGrpTagList.get(subj).getFASTIOCHK()+""
										};
										String RetVal2 = setDataConv(subj,rsTrendListHistorical.get(subi-iRow).get("tvalue"+(subj+1)).toString(),dccGrpTagArray,dccSearchTrend.getsMenuNo(),lGap);
										
										int nRetValType = 0;
										Double tmpN = 0d;
										try {
											if( RetVal2 == null ) {
												nRetValType = 2;
											} else {
												tmpN = Double.parseDouble(RetVal2);
												nRetValType = 0;
											}
										} catch( NumberFormatException nfe ) {
											nRetValType = 1;
										}
										
										if( nRetValType == 0 ) {
											if( "AI".equalsIgnoreCase(dccGrpTagArray[0]) && ("2753".equals(dccGrpTagArray[4]) || "2754".equals(dccGrpTagArray[4])) ) {
												((Map) arrTrendData.get(subi).get("m_data")).replace(subj,tmpN*1000+"");
											} else {
												((Map) arrTrendData.get(subi).get("m_data")).replace(subj,RetVal2);
											}
										} else if( nRetValType == 1 ) {
											((Map) arrTrendData.get(subi).get("m_data")).replace(subj,cnstErr+"");
										} else {
											((Map) arrTrendData.get(subi).get("m_data")).replace(subj,cnstNull+"");
										}
										break;
									}
								}
							}
						} else {
							break;
						}
					}
				}
			}
		}
		
		mav.addObject("ArrTrendData",arrTrendData);
	}
	
private List<Map> getTrendViewE(DccSearchTrend dccSearchTrend, List<ComTagDccInfo> dccGrpTagList, List<Map> grpTagList, Map searchMap) {
		
		String strUGrpNo = dccSearchTrend.getsUGrpNo();
		String strTimeGap = dccSearchTrend.getTxtTimeGap();
		Long lGap = Long.parseLong(strTimeGap)*1000;
		String strFast = "";
		String sDtm = dccSearchTrend.getStartDate();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		String strStartTime = "";
		String strEndTime = "";

		List<Map> arrTrendData = new ArrayList();
		
		//TrendView
		for( int di=0;di<dccGrpTagList.size();di++ ) {
			if( dccGrpTagList.get(di).getFASTIOCHK() != 1 ) {
				if( Double.parseDouble(strTimeGap) < 5 ) {
					strTimeGap = "5";
					lGap = 5000L;
					strFast = "";
					String eDtm = dtf.format(convDtm(sDtm,false).plusSeconds(840));
					
					di = dccGrpTagList.size();
				}
			}
		}
		
		String strScanTime = "";
		if( "R".equalsIgnoreCase(dccSearchTrend.getgHis()) ) {
			//Call RealTime
			strScanTime = dccTrendService.selectScanTime(dccSearchTrend) == null ? "" : dccTrendService.selectScanTime(dccSearchTrend);
			
			switch( dccSearchTrend.getsDive().toUpperCase() ) {
				case "M": case "A":
					lGap = Long.parseLong(strTimeGap) * 1000;
					strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*nTrendWidth));
					strEndTime = strScanTime;
					break;
				case "D":
					lGap = Long.parseLong(strTimeGap) * 1000;
					if( "F".equalsIgnoreCase(strFast) || "0.5".equals(strTimeGap) ) {
						strFast = "F";
						for( int i=0;i<dccGrpTagList.size();i++ ) {
							if( dccGrpTagList.get(i).getFASTIOCHK() != 1 ) {
								if( "0.5".equals(strTimeGap) ) strTimeGap = "5";
								lGap = Long.parseLong(strTimeGap) * 1000;
								strFast = "5";
								
								i = dccGrpTagList.size();
							}
						}
					}
					
					if( "F".equalsIgnoreCase(strFast) ) {
						strTimeGap = "0.5";
						lGap = 500L;
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds(440));
						strEndTime = strScanTime;
					} else {
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*(nTrendWidth+10)));
						strEndTime = strScanTime;
					}
					break;
				case "B":
					lGap = Long.parseLong(strTimeGap) * 1000;
					if( "F".equalsIgnoreCase(strFast) || "0.5".equals(strTimeGap) ) {
						strFast = "F";
						for( int i=0;i<grpTagList.size();i++ ) {
							if( !"1".equals(grpTagList.get(i).get("FASTIOCHK").toString()) ) {
								if( "0.5".equals(strTimeGap) ) strTimeGap = "5";
								lGap = Long.parseLong(strTimeGap) * 1000;
								strFast = "5";
								
								i = grpTagList.size();
							}
						}
					}
					
					if( "F".equalsIgnoreCase(strFast) ) {
						strTimeGap = "0.5";
						lGap = 500L;
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds(440));
						strEndTime = strScanTime;
					} else {
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*(nTrendWidth+10)));
						strEndTime = strScanTime;
					}
					break;
			}
		}
		
		//Call Historical
		String pScanTime = "";
		if( "".equals(strScanTime) ) {
			pScanTime = dccTrendService.selectScanTime(dccSearchTrend);
			lGap = Long.parseLong(strTimeGap) * 1000;
			strStartTime = dtf.format(convDtm(pScanTime,true).minusSeconds((lGap/1000)*nTrendWidth));
			strEndTime = pScanTime;
		}
		
		Duration durSec = Duration.between(convDtm(strStartTime.replaceAll("/", "-"),true),convDtm(strEndTime.replaceAll("/", "-"),true));
		int nSec = (int) durSec.getSeconds();
		int nBun = (nSec-nSec%60)/60;
		
		dccSearchTrend.setStartDate(strStartTime);
		dccSearchTrend.setEndDate(strEndTime);

		//frmProgressBar.show
		List<Map> rsTrendListHistorical = new ArrayList();
		switch( dccSearchTrend.getsDive().toUpperCase() ) {
			case "M":
				//rsTrendListpHistorical = dccTrendService.rsTrend5sGapMark(searchMap, dccGrpTagList, lGap, strFast);
				break;
			case "A":
				//rsTrendListpHistorical = dccTrendService.rsTrend5sGapAux(searchMap, dccGrpTagList, lGap, strFast);
				break;
			case "D":
				if( "4".equals(dccSearchTrend.getsHogi()) ) {
					//List<Map> rsTrendList = dccTrendService.rsTrend5sGap222(searchMap, dccGrpTagList, lGap, strFast);
				} else {
					//rsTrendListHistorical = dccTrendService.rsTrend5sGap(searchMap, dccGrpTagList, lGap, strFast);
					rsTrendListHistorical = getRsTrend5sGap(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
				}
				break;
			case "B":
				//rsTrendListpHistorical = dccTrendService.rsTrend5sGapDccMark(searchMap, dccGrpTagList, lGap, strFast);
				break;
		}
		
		int nEndPos = 0;
		if( "R".equalsIgnoreCase(dccSearchTrend.getgHis()) ) {
			nEndPos = nTrendWidth;
		} else {
			nEndPos = rsTrendListHistorical.size() > nTrendWidth ? nTrendWidth : rsTrendListHistorical.size();
		}
		
		String sDateS = "";
		String sDateE = "";
		int iRow = 0;

		for( int ht=0;ht<rsTrendListHistorical.size();ht++ ) {
			Map rtnMapHistorical = new HashMap();
			Map timeNPosH = new HashMap();
			timeNPosH.put("m_time",rsTrendListHistorical.get(ht).get("").toString());
			timeNPosH.put("m_xpos",ht+"");
			for( int hi=0;hi<dccGrpTagList.size();hi++ ) {
				String[] dccGrpTagArray = {
					dccGrpTagList.get(hi).getIOTYPE(),
					dccGrpTagList.get(hi).getIOBIT()+"",
					dccGrpTagList.get(hi).getSaveCore()+"",
					dccGrpTagList.get(hi).getBScale()+"",
					dccGrpTagList.get(hi).getADDRESS(),
					dccGrpTagList.get(hi).getFASTIOCHK()+""
				};
				
				String RetVal = setDataConv(ht,rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)).toString(),dccGrpTagArray,dccSearchTrend.getsMenuNo(),lGap);
				
				int nRetValType = 0;
				Double tmpN = 0d;
				try {
					if( RetVal == null ) {
						nRetValType = 2;
					} else {
						tmpN = Double.parseDouble(RetVal);
						nRetValType = 0;
					}
				} catch( NumberFormatException nfe ) {
					nRetValType = 1;
				}
				
				if( nRetValType == 0 ) {
					if( "AI".equalsIgnoreCase(dccGrpTagArray[0]) && ("2753".equals(dccGrpTagArray[4]) || "2754".equals(dccGrpTagArray[4])) ) {
						rtnMapHistorical.put(hi,tmpN*1000+"");
					} else {
						rtnMapHistorical.put(hi,tmpN+"");
					}
					
					sDateS = rsTrendListHistorical.get(ht).get("").toString();
					iRow = hi;
				} else if( nRetValType == 1 ) {
					rtnMapHistorical.put(hi,cnstErr+"");
				} else {
					rtnMapHistorical.put(hi,cnstNull+"");
				}
			}
			for( int hii=0;hii<rtnMapHistorical.size();hii++ ) {
				if( hii == 0 ) System.out.println(hii+" >>>>> "+rtnMapHistorical.get(hii));
			}
			
			timeNPosH.put("m_data",rtnMapHistorical);
			
			arrTrendData.add(ht,timeNPosH);
		}
		
		LocalDateTime now = LocalDateTime.now();
		int nDateDiff = (int) Duration.between(now,convDtm(strStartTime,true)).getSeconds();
		if( Math.abs((nDateDiff-nDateDiff%60)/60) > 20 ) {
			sDateE = arrTrendData.get(nEndPos).toString();
			
			if( !"".equals(sDateS) && !"".equals(sDateE) ) {
				if( !sDateS.equals(sDateE) ) {
					searchMap.replace("startDate",sDateS);
					searchMap.replace("endDate",sDateE);
					//List<Map> rsTrendListHistorical2 = dccTrendService.rsTrend5sGap(searchMap, dccGrpTagList, lGap, strFast);
					List<Map> rsTrendListHistorical2 = getRsTrend5sGap(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
					
					int iPoint = 0;
					if( rsTrendListHistorical2.size() < 1 ) {
						iPoint = -1;
					} else {
						iPoint = rsTrendListHistorical2.size();
					}
					
					for( int subi=iRow;subi<nEndPos;subi++ ) {
						if( iPoint > (subi-iRow) ) {
							arrTrendData.get(subi).replace("m_time", rsTrendListHistorical2.get(subi-iRow).get("").toString());
							arrTrendData.get(subi).replace("m_xpos", subi+"");
							
							for( int subj=0;subj<dccGrpTagList.size();subj++ ) {
								if( rsTrendListHistorical2.get(subi-iRow).get("tvalue"+(subj+1)) == null || "".equals(rsTrendListHistorical2.get(subi-iRow).get("tvalue"+(subj+1))) ) {
									((Map) arrTrendData.get(subi).get("m_data")).replace(subj,cnstNull+"");
								} else {
									switch( dccSearchTrend.getsDive().toUpperCase() ) {
									case "M":
										//((Map) arrTrendData.get(subi).get("m_data")).replace(subj,CheckValueMark(rsTrendListHistorical2.get(subi-iRow).get(subj).toString()));
										break;
									case "A":
										//((Map) arrTrendData.get(subi).get("m_data")).replace(subj,CheckValueAux(rsTrendListHistorical2.get(subi-iRow).get(subj).toString()));
										break;
									case "D":
										String[] dccGrpTagArray = {
											dccGrpTagList.get(subj).getIOTYPE(),
											dccGrpTagList.get(subj).getIOBIT()+"",
											dccGrpTagList.get(subj).getSaveCore()+"",
											dccGrpTagList.get(subj).getBScale()+"",
											dccGrpTagList.get(subj).getADDRESS(),
											dccGrpTagList.get(subj).getFASTIOCHK()+""
										};
										String RetVal2 = setDataConv(subj,rsTrendListHistorical.get(subi-iRow).get("tvalue"+(subj+1)).toString(),dccGrpTagArray,dccSearchTrend.getsMenuNo(),lGap);
										
										int nRetValType = 0;
										Double tmpN = 0d;
										try {
											if( RetVal2 == null ) {
												nRetValType = 2;
											} else {
												tmpN = Double.parseDouble(RetVal2);
												nRetValType = 0;
											}
										} catch( NumberFormatException nfe ) {
											nRetValType = 1;
										}
										
										if( nRetValType == 0 ) {
											if( "AI".equalsIgnoreCase(dccGrpTagArray[0]) && ("2753".equals(dccGrpTagArray[4]) || "2754".equals(dccGrpTagArray[4])) ) {
												((Map) arrTrendData.get(subi).get("m_data")).replace(subj,tmpN*1000+"");
											} else {
												((Map) arrTrendData.get(subi).get("m_data")).replace(subj,RetVal2);
											}
										} else if( nRetValType == 1 ) {
											((Map) arrTrendData.get(subi).get("m_data")).replace(subj,cnstErr+"");
										} else {
											((Map) arrTrendData.get(subi).get("m_data")).replace(subj,cnstNull+"");
										}
										break;
									}
								}
							}
						} else {
							break;
						}
					}
				}
			}
		}
		
		return arrTrendData;
	}
	
	private List<Map> getRsTrend5sGap(DccSearchTrend dccSearchTrend, List<ComTagDccInfo> dccGrpTagList, String strFast, boolean bOldFlag, long lGap) {
		List<Map> rtnMapList = new ArrayList();
		int nRes = 0;
		String procName = "";
		Map procInfo = new HashMap();
		String qryStr = "";
		int size = dccGrpTagList.size();
		
		String strStartDate = dccSearchTrend.getStartDate() == null ? "" : dccSearchTrend.getStartDate();
		String strEndDate = dccSearchTrend.getEndDate() == null ? "" : dccSearchTrend.getEndDate();
		
		if( !"".equals(strStartDate) && !"".equals(strEndDate) ) {
			if( "F".equalsIgnoreCase(strFast) && !"".equals(strStartDate) ) {
				if( strStartDate.length() > 19 ) strStartDate = strStartDate.substring(0,19);
			}
			
			String tickCount = System.currentTimeMillis()+"";
			
			procName = "DccTrend"+strStartDate.replaceAll("/","").replaceAll("-","").replaceAll(" ","").replaceAll(":","").replaceAll("\\.","")+tickCount.substring(tickCount.length()-3,tickCount.length());
			
			// craete tmp procedure
			qryStr = "CREATE PROCEDURE " + procName + " @timegap as int AS \n"
				   + " declare @maxdate datetime \n"
				   + " declare @mindate datetime \n"
				   + " declare @curdate datetime \n"
				   + " set @mindate = convert(datetime, '"+strStartDate.replaceAll("/","-")+"') \n"
				   + " set @maxdate = convert(datetime, '"+strEndDate.replaceAll("/","-")+"') \n"
				   + " set @curdate = convert(datetime, '"+strStartDate.replaceAll("/","-")+"') \n";
			
			for( int i=1;i<size+1;i++ ) {
				qryStr += " declare @thistime"+i+" datetime \n";
			}
			
			qryStr += " declare @stime datetime \n"
					+ " declare @etime datetime \n"
					+ " declare @thistime datetime \n"
					+ " declare @now_mintime datetime \n"
					+ " create table #temp( \n"
					+ "     Scantime datetime, \n";
			
			for( int i=1;i<size+1;i++ ) {
				if( i == size+1 ) {
					qryStr += "     tvalue"+i+" float \n";
				} else {
					qryStr += "     tvalue"+i+" float, \n";
				}
			}
			
			qryStr += " ) \n"
					+ " create table #OnlyDate( \n";
			
			for( int i=1;i<size+1;i++ ) {
				qryStr += "     thistime"+i+" datetime, \n";
			}
			
			qryStr += "     OutSeq int \n"
					+ " ) "
					+ " create table #OnlyDate2( \n";
			
			for( int i=1;i<size+1;i++ ) {
				qryStr += "     thistime"+i+" datetime, \n";
			}
			
			qryStr += "     OutSeq int \n"
					+ " ) "
					+ " declare @iSeq int \n"
					+ " declare @Chk smallint \n"
					+ " set @Chk = 0 \n"
					+ " set @iSeq = 0 \n"
					+ " select @now_mintime = min(Scantime) from log_4dcc_trend \n"
					+ " while @curdate <= @maxdate \n"
					+ " begin \n"
					+ "     set @stime = @curdate \n";
			
			if( "F".equalsIgnoreCase(strFast) ) {
				qryStr += "     set @etime = dateadd(ms, 800, @curdate) \n";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "     SELECT @thistime"+i+" = min(Scantime) FROM LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND_FAST WHERE SCANTIME BETWEEN @stime AND @etime AND Seq = 1 \n"
							+ "     set @thistime"+i+" = isnull(@thistime"+i+", @curdate) \n";
				}
				
				qryStr += "        set @iSeq = @iSeq + 1 \n"
						+ "        insert into #OnlyDate(";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "thistime"+i+",";
				}
				
				qryStr += "OutSeq) values (";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "@thistime"+i+",";
				}
				
				qryStr += "@iSeq) \n";
			} else {
				if( bOldFlag ) {
					qryStr += "     set @etime = dateadd(ms, 60000, @curdate) \n";
				} else {
					qryStr += "     set @etime = dateadd(ms, 7000, @curdate) \n";
				}
				
				qryStr += "     if (@now_mintime > @etime)  \n"
						+ "        begin \n";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "        SELECT @thistime"+i+" = min(Scantime) FROM LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND_HIST WHERE SCANTIME BETWEEN @stime AND @etime AND Seq = "+dccGrpTagList.get(i-1).getTBLNO()+" \n"
							+ "        set @thistime"+i+" = isnull(@thistime"+i+", @curdate) \n";
				}
				
				qryStr += "        set @iSeq = @iSeq + 1 \n"
						+ "        insert into #OnlyDate2(";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "thistime"+i+",";
				}
				
				qryStr += "OutSeq) values (";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "@thistime"+i+",";
				}
				
				qryStr += "@iSeq) \n"
						+ "        End \n"
						+ "     Else \n"
						+ "        begin \n";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "        SELECT @thistime"+i+" = min(Scantime) FROM LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND WHERE SCANTIME BETWEEN @stime AND @etime AND Seq = "+dccGrpTagList.get(i-1).getTBLNO()+" \n"
							+ "        set @thistime"+i+" = isnull(@thistime"+i+", @curdate) \n";
				}
				
				qryStr += "        set @iSeq = @iSeq + 1 \n"
						+ "        insert into #OnlyDate(";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "thistime"+i+",";
				}
				
				qryStr += "OutSeq) values (";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "@thistime"+i+",";
				}
				
				qryStr += "@iSeq) \n"
						+ "        End \n";
			}
			
			qryStr += "         set @curdate = dateadd(ms, @timegap, @curdate) \n"
					+ "         if @curdate = @thistime1 \n"
					+ "            begin \n"
					+ "            set @curdate = dateadd(ms, 1000, @curdate) \n"
					+ "            End \n"
					+ " End\n";
			
			if( !"F".equalsIgnoreCase(strFast) ) {
				qryStr += " insert into #temp(Scantime";
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += ",tvalue"+i;
				}
				
				qryStr += ") \n"
						+ " select a.thistime1,";
				
				for( int i=1;i<size+1;i++ ) {
					if( i == size ) {
						qryStr += "         'tvalue"+i+"' = (select tvalue"+dccGrpTagList.get(i-1).getFLDNO()+" from LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND_HIST where Scantime = a.thistime"+i+" and Seq = "+dccGrpTagList.get(i-1).getTBLNO()+") \n";
					} else {
						qryStr += "         'tvalue"+i+"' = (select tvalue"+dccGrpTagList.get(i-1).getFLDNO()+" from LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND_HIST where Scantime = a.thistime"+i+" and Seq = "+dccGrpTagList.get(i-1).getTBLNO()+"), \n";
					}
				}
				
				qryStr += "      from #OnlyDate2 a \n"
						+ "      order by OutSeq   \n";
			}
			
			qryStr += " insert into #temp(Scantime";
			
			for( int i=1;i<size+1;i++ ) {
				qryStr += ",tvalue"+i;
			}
			
			qryStr += ") \n"
					+ " select a.thistime1,";
			
			for( int i=1;i<size+1;i++ ) {
				if( i == size ) {
					if( "F".equalsIgnoreCase(strFast) ) {
						qryStr += "         'tvalue"+i+"' = (select tvalue"+dccGrpTagList.get(i-1).getFLDNO_FAST()+" from LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND_FAST where Scantime = a.thistime"+i+" and Seq = 1) \n";
					} else {
						qryStr += "         'tvalue"+i+"' = (select tvalue"+dccGrpTagList.get(i-1).getFLDNO()+" from LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND where Scantime = a.thistime"+i+" and Seq = "+dccGrpTagList.get(i-1).getTBLNO()+") \n";
					}
				} else {
					if( "F".equalsIgnoreCase(strFast) ) {
						qryStr += "         'tvalue"+i+"' = (select tvalue"+dccGrpTagList.get(i-1).getFLDNO_FAST()+" from LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND_FAST where Scantime = a.thistime"+i+" and Seq = 1), \n";
					} else {
						qryStr += "         'tvalue"+i+"' = (select tvalue"+dccGrpTagList.get(i-1).getFLDNO()+" from LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND where Scantime = a.thistime"+i+" and Seq = "+dccGrpTagList.get(i-1).getTBLNO()+"), \n";
					}
				}
			}
			
			qryStr += "      from #OnlyDate a \n"
					+ "      order by OutSeq   \n"
					+ " delete from #temp where Scantime is null \n";
			
			if( "F".equalsIgnoreCase(strFast) ) {
				qryStr += " select convert(char(23),Scantime,121)";
			} else {
				qryStr += " select convert(char(19),Scantime,121)";
			}
			
			for( int i=1;i<size+1;i++ ) {
				qryStr += ",tvalue"+i;
			}
			
			qryStr += "  from #temp\n";
			
			//System.out.println(qryStr);
			
			nRes = dccTrendService.manageTrendProc(qryStr);
			
			// exec tmp procedure
			procInfo.put("procName",procName);
			procInfo.put("param",lGap+"");
			
			rtnMapList = dccTrendService.callTrendProc(procInfo);
			
			// drop tmp procedure
			qryStr = "DROP PROCEDURE " + procName;
			nRes = dccTrendService.manageTrendProc(qryStr);
		}
			
		return rtnMapList;
	}
	
	@RequestMapping(value = "ssql", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView ssql(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
		
		logger.info("############ ssql");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
    	}
    	if( dccSearchTrend.getIoType() == null || "".equals(dccSearchTrend.getIoType()) ) dccSearchTrend.setIoType("AI");
    	if( dccSearchTrend.getIoBit() == null || "".equals(dccSearchTrend.getIoBit()) ) dccSearchTrend.setIoBit("0");
    	if( dccSearchTrend.getSaveCore() == null ) dccSearchTrend.setSaveCore("0");
    	if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchAlarm.getsUGrpNo() != null && !dccSearchAlarm.getsUGrpNo().isEmpty()) {
    	
		List<Map> ioList = dccTrendService.selectSetIOList(dccSearchTrend);
		
		for( Map ioItem: ioList) {
			ioItem.put("ioBit", dccSearchTrend.getIoBit());
			ioItem.put("ioType", dccSearchTrend.getIoType());
			ioItem.put("gubun", dccSearchTrend.getsDive());
			ioItem.put("hogi", dccSearchTrend.getsHogi());
			ioItem.put("xyGubun", dccSearchTrend.getsXYGubun());
			ioItem.put("saveCoreChk", dccSearchTrend.getSaveCore());
			ioItem.replace("address", ioItem.get("address") == null ? "" : ioItem.get("address"));
			ioItem.replace("loopName", ioItem.get("loopName") == null ? "" : ioItem.get("loopName"));
			ioItem.replace("eHigh", ioItem.get("eHigh") == null ? "" : ioItem.get("eHigh"));
			ioItem.replace("eLow", ioItem.get("eLow") == null ? "" : ioItem.get("eLow"));
			ioItem.replace("iSeq", ioItem.get("iSeq") == null ? "" : ioItem.get("iSeq"));
			ioItem.replace("FASTIOCHK", ioItem.get("FASTIOCHK") == null ? "" : ioItem.get("FASTIOCHK"));
		}
		
		mav.addObject("LvIOList", ioList);
    	//}

    	userInfo.setHogi(dccSearchTrend.getHogiHeader());
    	userInfo.setXyGubun(dccSearchTrend.getXyHeader());

		mav.addObject("BaseSearch", dccSearchTrend);        	
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value = "cmdInsert", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView cmdInsert(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
		
		logger.info("############ cmdInsert");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
    	}
    	if( dccSearchTrend.getIoType() == null || "".equals(dccSearchTrend.getIoType()) ) dccSearchTrend.setIoType("AI");
    	if( dccSearchTrend.getIoBit() == null || "".equals(dccSearchTrend.getIoBit()) ) dccSearchTrend.setIoBit("0");
    	if( dccSearchTrend.getSaveCore() == null ) dccSearchTrend.setSaveCore("0");
    	if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchAlarm.getsUGrpNo() != null && !dccSearchAlarm.getsUGrpNo().isEmpty()) {
    	
    	String strDive = dccSearchTrend.getsDive() == "null" ? "D" : dccSearchTrend.getsDive();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? "Trend" : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "1" : dccSearchTrend.getsUGrpNo();
    	
    	Map searchMapGrpNm = new HashMap();
		searchMapGrpNm.put("grpID", strGrpID);
		searchMapGrpNm.put("menuNo", strMenuNo);
		searchMapGrpNm.put("uGrpNo", strUGrpNo);

    	String groupName = "";
    	List<Map> dccGroupNmaeList = dccTrendService.selectGroupName(searchMapGrpNm);
    	for( int gg=0;gg<dccGroupNmaeList.size();gg++ ) {
    		if( strUGrpNo.equals(dccGroupNmaeList.get(gg).get("UGrpNo").toString()) ) {
    			groupName = dccGroupNmaeList.get(gg).get("UGrpName").toString();
    		}
    	}
		
		//String groupName = basCommonService.selectGrpNameListB(searchMapGrpNm).get(0) == null ? "경보 설정" : basCommonService.selectGrpNameListB(searchMapGrpNm).get(0);
		
		Map searchMap = new HashMap();
		searchMap.put("dive", strDive);
		searchMap.put("grpID", strGrpID);
		searchMap.put("hogi", dccSearchTrend.getsHogi());
		searchMap.put("menuNo", dccSearchTrend.getsMenuNo());
		searchMap.put("uGrpNo", strUGrpNo);
		

		List<ComTagDccInfo> lvIOListOrg = basDccOsmsService.getDccGrpTagList(searchMap);
		List<Map> lvIOList = new ArrayList();
		
		lvIOListOrg.forEach(l -> {
			lvIOList.add((Map) l);
		});
		
    	//List<Map> lvIOList = basDccOsmsService.selectDccGrpTagListB(searchMap);
    	
    	String[] iSeqMod = dccSearchTrend.getiSeqMod().split("==SEP==");
    	String[] gubunMod = dccSearchTrend.getGubunMod().split("==SEP==");
    	String[] hogiMod = dccSearchTrend.getHogiMod().split("==SEP==");
    	String[] xyGubunMod = dccSearchTrend.getXyGubunMod().split("==SEP==");
    	String[] DescrMod = dccSearchTrend.getDescrMod().split("==SEP==");
    	String[] ioTypeMod = dccSearchTrend.getIoTypeMod().split("==SEP==");
    	String[] addressMod = dccSearchTrend.getAddressMod().split("==SEP==");
    	String[] ioBitMod = dccSearchTrend.getIoBitMod().split("==SEP==");
    	String[] minValMod = dccSearchTrend.getMinValMod().split("==SEP==");
    	String[] maxValMod = dccSearchTrend.getMaxValMod().split("==SEP==");
    	String[] saveCoreMod = dccSearchTrend.getSaveCoreMod().split("==SEP==");
    	
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
	    	lvIOItem.put("iSeq", !"|".equals(dccSearchTrend.getiSeqMod()) ? iSeqMod[0] : "");
	    	lvIOItem.put("gubun", !"|".equals(dccSearchTrend.getGubunMod()) ? gubunMod[0] : "");
	    	lvIOItem.put("hogi", !"|".equals(dccSearchTrend.getHogiMod()) ? hogiMod[0] : "");
	    	lvIOItem.put("xyGubun", !"|".equals(dccSearchTrend.getXyGubunMod()) ? xyGubunMod[0] : "");
	    	lvIOItem.put("Descr", !"|".equals(dccSearchTrend.getDescrMod()) ? DescrMod[0] : "");
	    	lvIOItem.put("ioType", !"|".equals(dccSearchTrend.getIoTypeMod()) ? ioTypeMod[0] : "");
	    	lvIOItem.put("address", !"|".equals(dccSearchTrend.getAddressMod()) ? addressMod[0] : "");
	    	lvIOItem.put("ioBit", !"|".equals(dccSearchTrend.getIoBitMod()) ? ioBitMod[0] : "");
	    	lvIOItem.put("minVal", !"|".equals(dccSearchTrend.getMinValMod()) ? minValMod[0] : "");
	    	lvIOItem.put("maxVal", !"|".equals(dccSearchTrend.getMaxValMod()) ? maxValMod[0] : "");
	    	lvIOItem.put("saveCoreChk", !"|".equals(dccSearchTrend.getSaveCoreMod()) ? saveCoreMod[0] : "");
    	
	    	lvIOList.add(lvIOItem);
    	}
    	
    	mav.addObject("LvIOList",lvIOList);
    	//}

    	userInfo.setHogi(dccSearchTrend.getHogiHeader());
    	userInfo.setXyGubun(dccSearchTrend.getXyHeader());

		mav.addObject("BaseSearch", dccSearchTrend);        	
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value = "cmdOK", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView cmdOK(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
		
		logger.info("############ cmdOK");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
    	}
    	if( dccSearchTrend.getIoType() == null || "".equals(dccSearchTrend.getIoType()) ) dccSearchTrend.setIoType("AI");
    	if( dccSearchTrend.getIoBit() == null || "".equals(dccSearchTrend.getIoBit()) ) dccSearchTrend.setIoBit("0");
    	if( dccSearchTrend.getSaveCore() == null ) dccSearchTrend.setSaveCore("0");
    	if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchTrend.getsUGrpNo() != null && !dccSearchTrend.getsUGrpNo().isEmpty()) {
    	
    	String strDive = dccSearchTrend.getsDive() == "null" ? "D" : dccSearchTrend.getsDive();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? "Trend" : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "1" : dccSearchTrend.getsUGrpNo();
    	
    	Map searchMapGrpNm = new HashMap();
		searchMapGrpNm.put("grpID", strGrpID);
		searchMapGrpNm.put("menuNo", strMenuNo);
		searchMapGrpNm.put("uGrpNo", strUGrpNo);
		

    	String groupName = "";
    	List<Map> dccGroupNmaeList = dccTrendService.selectGroupName(searchMapGrpNm);
    	for( int gg=0;gg<dccGroupNmaeList.size();gg++ ) {
    		if( strUGrpNo.equals(dccGroupNmaeList.get(gg).get("UGrpNo").toString()) ) {
    			groupName = dccGroupNmaeList.get(gg).get("UGrpName").toString();
    		}
    	}
		//String groupName = basCommonService.selectGrpNameListB(searchMapGrpNm).get(0) == null ? "경보 설정" : basCommonService.selectGrpNameListB(searchMapGrpNm).get(0);
		
		Map searchMap = new HashMap();
		searchMap.put("dive", strDive);
		searchMap.put("grpID", strGrpID);
		searchMap.put("hogi", dccSearchTrend.getsHogi());
		searchMap.put("menuNo", dccSearchTrend.getsMenuNo());
		searchMap.put("uGrpNo", strUGrpNo);
		
		List<ComTagDccInfo> lvIOListOrg = basDccOsmsService.getDccGrpTagList(searchMap);
		List<Map> lvIOList = new ArrayList();
		
		lvIOListOrg.forEach(l -> {
			lvIOList.add((Map) l);
		});
		
    	//List<Map> lvIOList = basDccOsmsService.selectDccGrpTagListB(searchMap);
    	
    	String[] iSeqMod = dccSearchTrend.getiSeqMod().split("==SEP==");
    	String[] gubunMod = dccSearchTrend.getGubunMod().split("==SEP==");
    	String[] hogiMod = dccSearchTrend.getHogiMod().split("==SEP==");
    	String[] xyGubunMod = dccSearchTrend.getXyGubunMod().split("==SEP==");
    	String[] DescrMod = dccSearchTrend.getDescrMod().split("==SEP==");
    	String[] ioTypeMod = dccSearchTrend.getIoTypeMod().split("==SEP==");
    	String[] addressMod = dccSearchTrend.getAddressMod().split("==SEP==");
    	String[] ioBitMod = dccSearchTrend.getIoBitMod().split("==SEP==");
    	String[] minValMod = dccSearchTrend.getMinValMod().split("==SEP==");
    	String[] maxValMod = dccSearchTrend.getMaxValMod().split("==SEP==");
    	String[] saveCoreMod = dccSearchTrend.getSaveCoreMod().split("==SEP==");
    	
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
	    	lvIOItem.put("iSeq", !"|".equals(dccSearchTrend.getiSeqMod()) ? iSeqMod[0] : "");
	    	lvIOItem.put("gubun", !"|".equals(dccSearchTrend.getGubunMod()) ? gubunMod[0] : "");
	    	lvIOItem.put("hogi", !"|".equals(dccSearchTrend.getHogiMod()) ? hogiMod[0] : "");
	    	lvIOItem.put("xyGubun", !"|".equals(dccSearchTrend.getXyGubunMod()) ? xyGubunMod[0] : "");
	    	lvIOItem.put("Descr", !"|".equals(dccSearchTrend.getDescrMod()) ? DescrMod[0] : "");
	    	lvIOItem.put("ioType", !"|".equals(dccSearchTrend.getIoTypeMod()) ? ioTypeMod[0] : "");
	    	lvIOItem.put("address", !"|".equals(dccSearchTrend.getAddressMod()) ? addressMod[0] : "");
	    	lvIOItem.put("ioBit", !"|".equals(dccSearchTrend.getIoBitMod()) ? ioBitMod[0] : "");
	    	lvIOItem.put("minVal", !"|".equals(dccSearchTrend.getMinValMod()) ? minValMod[0] : "");
	    	lvIOItem.put("maxVal", !"|".equals(dccSearchTrend.getMaxValMod()) ? maxValMod[0] : "");
	    	lvIOItem.put("saveCoreChk", !"|".equals(dccSearchTrend.getSaveCoreMod()) ? saveCoreMod[0] : "");
    	
	    	lvIOList.add(lvIOItem);
    	}

    	dccSearchTrend.setsGrpID(strGrpID);
    	dccSearchTrend.setsMenuNo(strMenuNo);
    	dccSearchTrend.setsUGrpNo(strUGrpNo);
    	
    	Map trendSearchMap = new HashMap();
    	trendSearchMap.put("gubun",strDive);
    	trendSearchMap.put("id",strGrpID);
    	trendSearchMap.put("menuNo",strMenuNo);
    	trendSearchMap.put("grpNo",strUGrpNo);
    	
    	Integer delRes = dccTrendService.deleteGrpTag(trendSearchMap);
    	if( delRes == null ) delRes = 0;
    	logger.info("successfully delete ["+delRes+"] row(s).");
    	
    	int idx=0;
    	for( Map lvIOItem : lvIOList) {
    		String itemHogi = lvIOItem.get("hogi").toString();
    		String gHogi = itemHogi;

    		dccSearchTrend.setHogiMod(itemHogi);
    		dccSearchTrend.setIoTypeMod(lvIOItem.get("ioType").toString());
    		dccSearchTrend.setAddressMod(lvIOItem.get("address").toString());
    		dccSearchTrend.setIoBitMod(lvIOItem.get("ioBit").toString());
    		dccSearchTrend.setXyGubunMod(lvIOItem.get("xyGubun").toString());
    		
    		Map newSeachMap = new HashMap();
    		newSeachMap.put("gubun",strDive);
    		newSeachMap.put("id",strGrpID);
    		newSeachMap.put("menuNo",strMenuNo);
        	newSeachMap.put("grpNo",strUGrpNo);
    		newSeachMap.put("iHogi",itemHogi);
    		newSeachMap.put("xyGubun",lvIOItem.get("xyGubun").toString());
    		newSeachMap.put("ioType",lvIOItem.get("ioType").toString());
    		newSeachMap.put("address",lvIOItem.get("address").toString());
    		newSeachMap.put("ioBit",lvIOItem.get("ioBit").toString());
    		
    		String ySeq = dccTrendService.selectISeqTagDccSearch(newSeachMap);

    		/*dccSearchTrend.setgHogi(gHogi);
    		dccSearchTrend.setTagNo(String.valueOf(idx));
    		dccSearchTrend.setiSeqMod(lvIOItem.get("iSeq").toString());
    		dccSearchTrend.setySeq(ySeq);
    		dccSearchTrend.setMaxValMod(lvIOItem.get("maxVal").toString());
    		dccSearchTrend.setMinValMod(lvIOItem.get("minVal").toString());
    		dccSearchTrend.setSaveCoreMod(lvIOItem.get("saveCoreChk").toString());
    		dccSearchTrend.setDescrMod(lvIOItem.get("Descr").toString());*/
    		
    		//VALUES ( #{gubun},  #{id}, #{grpHogi}, #{menuNo}, #{grpNo}, #{hogi}, #{tagNo}, #{iSeq},
    		//		#{maxVal}, #{minVal}, #{ySeq}, #{yMaxVal}, #{yMinVal}, #{saveCoreChk}, #{descr} )        

    		newSeachMap.put("grpHogi",gHogi);
    		newSeachMap.put("hogi",gHogi);
    		newSeachMap.put("tagNo",String.valueOf(idx));
    		newSeachMap.put("iSeq",lvIOItem.get("iSeq").toString());
    		newSeachMap.put("maxVal",lvIOItem.get("maxVal").toString());
    		newSeachMap.put("minVal",lvIOItem.get("minVal").toString());
    		newSeachMap.put("ySeq",ySeq);
    		newSeachMap.put("yMaxVal",lvIOItem.get("maxVal").toString());
    		newSeachMap.put("yMinVal",lvIOItem.get("minVal").toString());
    		newSeachMap.put("saveCoreChk",lvIOItem.get("saveCoreChk").toString());
    		newSeachMap.put("descr",lvIOItem.get("Descr").toString());
    		
    		dccTrendService.insertGrpTag(newSeachMap);

    		if( "1".equals(dccSearchTrend.getChkHogi()) ) {
    			if( "3".equals(itemHogi) ) {
    				gHogi = "4";
    			} else {
    				gHogi = "3";
    			}
    			
    			newSeachMap.replace("hogi",gHogi);

    			dccTrendService.insertGrpTag(newSeachMap);
    		}
    		
    		idx++;
    	}
    	//}
    	
    	//List<Map> lvIOList2 = basDccOsmsService.selectDccGrpTagListB(searchMap);
    	
    	List<ComTagDccInfo> lvIOListOrg2 = basDccOsmsService.getDccGrpTagList(searchMap);
		List<Map> lvIOList2 = new ArrayList();
		
		lvIOListOrg2.forEach(l -> {
			lvIOList2.add((Map) l);
		});
    	
    	mav.addObject("LvIOList", lvIOList2);

    	userInfo.setHogi(dccSearchTrend.getHogiHeader());
    	userInfo.setXyGubun(dccSearchTrend.getXyHeader());

		mav.addObject("BaseSearch", dccSearchTrend);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping("tfExcelExport")
	public void tfExcelExport(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try {
        
			if( dccSearchTrend.getHogiHeader() != null ) {
	    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
	    	}
	    	if( dccSearchTrend.getXyHeader() != null ) {
	    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
	    	}
			if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
			if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
			if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
			if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
			if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
			if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
			if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		    	
			dccSearchTrend.setMenuName(this.menuName);
			
			String strDive = dccSearchTrend.getsDive();
			
			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			
			Map searchMap = new HashMap();
			searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
			searchMap.put("hogi",dccSearchTrend.getsHogi());
			searchMap.put("dive",dccSearchTrend.getsDive());
			searchMap.put("grpID",dccSearchTrend.getsGrpID());
			searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
			searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
			searchMap.put("startDate",dccSearchTrend.getStartDate() == null ? addDate("s",now.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
			searchMap.put("endDate",dccSearchTrend.getEndDate() == null ? now.format(dtf)+".000" : dccSearchTrend.getEndDate());
			
			List<ComTagDccInfo> dccGrpTagList = new ArrayList();
			Map dccVal = new HashMap();
			List<Map> grpTagList = new ArrayList();
			if( "D".equalsIgnoreCase(strDive) ) {
				dccGrpTagList = basDccOsmsService.getDccGrpTagList(searchMap);
				dccVal = basDccOsmsService.getDccValue(searchMap, dccGrpTagList);
			} else if( "B".equalsIgnoreCase(strDive) ) {
				grpTagList = dccTrendService.getGrpTag(searchMap);
			}
			
			List<Map> LblInfoList = getGrpTagListE(dccSearchTrend);
			List<Map> arrTrendData = getTrendViewE(dccSearchTrend, dccGrpTagList, grpTagList, searchMap);
        		
    		excelHelperUtil.alarmTFExcelDownload(request, response, "trend_", LblInfoList, arrTrendData);
        	
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
    }
	
//	public void tmRum_timer (DccSearchTrend dccSearchTrend) {
//		
//		//tmRun_timer
//		if( dccGrpTagList.size() > 0 ) {
//			if( "F".equalsIgnoreCase(strFast) ) {
//				List<Map> rsTrendList = dccTrendService.rsTrend5sGap(searchMap, dccGrpTagList, lGap, strFast);
//				
//				int nCnt = rsTrendList.size();
//				for( int tt=0;tt<nTrendWidth-nCnt;tt++ ) {
//					//rtnList.put(tt,)
//				}
//				
//				for( int tt=nTrendWidth-nCnt;tt<nTrendWidth;tt++ ) {
//					String[] dccGrpTagArray = {
//						dccGrpTagList.get(tt).getIOTYPE(),
//						dccGrpTagList.get(tt).getIOBIT()+"",
//						dccGrpTagList.get(tt).getSaveCore()+"",
//						dccGrpTagList.get(tt).getBScale()+"",
//						dccGrpTagList.get(tt).getADDRESS(),
//						dccGrpTagList.get(tt).getFASTIOCHK()+""
//					};
//
//					Map rtnMap = new HashMap();
//					for( int st=0;st<rsTrendList.get(tt).size();st++ ) {
//						String RetVal = setDataConv(st,rsTrendList.get(tt).get(st).toString(),dccGrpTagArray,dccSearchTrend.getsMenuNo(),lGap);
//						
//						int nRetValType = 0;
//						try {
//							if( RetVal == null ) {
//								nRetValType = 2;
//							} else {
//								int tmpN = Integer.parseInt(RetVal);
//								nRetValType = 0;
//							}
//						} catch( NumberFormatException nfe ) {
//							nRetValType = 1;
//						}
//						
//						if( nRetValType == 0 ) {
//							rtnMap.put(st,RetVal);
//						} else if( nRetValType == 1 ) {
//							rtnMap.put(st,cnstErr+"");
//						} else {
//							rtnMap.put(st,cnstNull+"");
//						}
//					}
//					Map timeNPos = new HashMap();
//					timeNPos.put("m_data",rtnMap);
//					timeNPos.put("m_time",rsTrendList.get(tt).get(0).toString());
//					timeNPos.put("m_xpos",tt+"");
//					
//					arrTrendData.add(tt,timeNPos);
//				}
//				
//				String lblDate = arrTrendData.get(nTrendWidth-1).get("m_time").toString();
//				String lblDate2 = lblDate;
//				Map lblValue = (Map) arrTrendData.get(nTrendWidth-1).get("m_data");
//			} else {
//				//GetTrendRealValue
//			}
//		}
//		
//		//String lblDate = arrTrendData(gnEndPos-1).m_time;
//	}
	
	private String setDataConv(int i, String fVal, String[] dccGrpTagArray, String sMenuNo, Long lGap) {
		Map dataConv = new HashMap();
		Double fValue = 0d;
		String rtnVal = "";
		
		try {
			if( "".equals(fVal) ) {
				return cnstNull+"";
			}
			
			fValue = Double.parseDouble(fVal);
		} catch( Exception e ) {
			return cnstNull+"";
		}
		
		String strIOType = dccGrpTagArray[0];
		String strIOBit = dccGrpTagArray[1];
		String strSvaeCore = dccGrpTagArray[2];
		String strBScale = dccGrpTagArray[3];
		String strAddress = dccGrpTagArray[4];
		String strFastIOChk = dccGrpTagArray[5];
		
		// '- IOTYPE에 대한 설정
	    if( "DI".equals(strIOType) || "DO".equals(strIOType) ){
	        if( !"".equals(strIOBit) ) {
	            fValue = Double.parseDouble(basCommonService.GetBitVal(fValue+"",strIOBit));
	        }
	    } else if( "SC".equals(strIOType) ) {
	    	 if( "1".equals(strSvaeCore) && !"".equals(strIOBit) ) {
    		 	fValue = Double.parseDouble(basCommonService.GetBitVal(fValue+"",strIOBit));
	    	 }else if( !"".equals(strBScale) && !"1".equals(strSvaeCore) ) {
 	            fValue = fValue / (2 ^ (15 - Integer.parseInt(strBScale) ));
	 	     }
	    } else {
	    	if( "AI".equals(strIOType) && ( "2010".equals(strAddress) || "2140".equals(strAddress) ) ) {
	    		fValue = fValue / 0.0081;
	    	}
	    }
	    
	    if( "21".equals(sMenuNo) || "22".equals(sMenuNo) ) {
	    	if( lGap < 5000 && "1".equals(strFastIOChk) && !"".equals(strBScale) ) {
	    		  fValue = fValue / (2 ^ (15 - Integer.parseInt(strBScale) ));
	    	}
	    }
	    
	    if( "DI".equals(strIOType) || "DO".equals(strIOType) || "SC".equals(strIOType) && "1".equals(strSvaeCore) ){
	    	rtnVal = fValue > cnstErr ? String.format("%f", fValue) : cnstErrStr;
	    } else if( !"".equals(strBScale) ) {
	    	rtnVal = fValue > cnstErr ? String.format(gFormat[Integer.parseInt(strBScale)], fValue) : cnstErrStr;
	    } else {
	    	rtnVal = fValue > cnstErr ? fValue+"" : cnstErrStr;
	    }		
	    
	    return rtnVal;
	}
	
	private LocalDateTime convDtm(String date, boolean isMilli) {
		String[] pDate = {};
		
		if( date.split(" ")[0].indexOf("-") > -1 ) {
			pDate = date.split(" ")[0].split("-");
		} else if(date.split(" ")[0].indexOf("/") > -1 ) { 
			pDate = date.split(" ")[0].split("/");
		}
		String[] pTime = date.split(" ")[1].split(":");
		String millis = "000";

		pTime[2] = pTime[2].indexOf(".") > -1 ? pTime[2].substring(0,pTime[2].indexOf(".")) : pTime[2];
		if( isMilli ) {
			if( pTime[2].indexOf(".") > -1 ) {
				millis = pTime[2].substring(pTime[2].indexOf(".")+1,pTime[2].length());
			}
		
			LocalDateTime ldt = LocalDateTime.of(Integer.parseInt(pDate[0]),Integer.parseInt(pDate[1]),Integer.parseInt(pDate[2]),
												Integer.parseInt(pTime[0]),Integer.parseInt(pTime[1]),Integer.parseInt(pTime[2]),Integer.parseInt(millis));
			
			return ldt;
		} else {
			LocalDateTime ldt = LocalDateTime.of(Integer.parseInt(pDate[0]),Integer.parseInt(pDate[1]),Integer.parseInt(pDate[2]),
												Integer.parseInt(pTime[0]),Integer.parseInt(pTime[1]),Integer.parseInt(pTime[2]));

			return ldt;
		}
	}
	
	@RequestMapping("realtimetrendspare")
	public ModelAndView realtimetrendspare(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ realtimetrendspare");	
		
		if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
    	}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("S");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("1");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		if(request.getSession().getAttribute("USER_INFO") != null) {

	    	String strGrpID = dccSearchTrend.getsGrpID() == null ? userInfo.getId() : dccSearchTrend.getsGrpID();
	    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
	    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "1" : dccSearchTrend.getsUGrpNo();
			
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			
		}

		return mav;
	}
	
	@RequestMapping("ftamtrend")
	public ModelAndView ftamtrend(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ ftamtrend");
		
		if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
    	}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("A");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("1");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {

	    	String strGrpID = dccSearchTrend.getsGrpID() == null ? userInfo.getId() : dccSearchTrend.getsGrpID();
	    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
	    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "1" : dccSearchTrend.getsUGrpNo();
			
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			
		}

		return mav;
	}
	
	@RequestMapping("dccmarkvtrend")
	public ModelAndView dccmarkvtrend(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ dccmarkvtrend");
		
		if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi("3");
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) dccSearchTrend.setsXYGubun("X");
    	}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("B");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("1");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {

	    	String strGrpID = dccSearchTrend.getsGrpID() == null ? userInfo.getId() : dccSearchTrend.getsGrpID();
	    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
	    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "1" : dccSearchTrend.getsUGrpNo();
			
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			
		}

		return mav;
	}	
	
	@RequestMapping("barchartfixed")
	public ModelAndView barchartfixed(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ barchartfixed");	
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}		
	
	@RequestMapping("barchartspare")
	public ModelAndView barchartspare(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ barchartspare");	
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}	
	
	@RequestMapping("logfixedlist")
	public ModelAndView logfixedlist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ logfixedlist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
			
			if(dccSearchTrend.getsMenuNo() == null || dccSearchTrend.getsMenuNo().isEmpty()) {
            	
				dccSearchTrend.setsDive("D");
        		dccSearchTrend.setsMenuNo("23");
        		dccSearchTrend.setsGrpID("Trend");
	        	dccSearchTrend.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchTrend.setsHogi(member.getHogi());
	        	dccSearchTrend.setsXYGubun(member.getXyGubun());	        	
        	}
			
			getMainTrendLog(dccSearchTrend, mav);      
    		
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}
	
	@RequestMapping("logsharelist")
	public ModelAndView logsharelist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();

		logger.info("############ logsharelist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
			
			if(dccSearchTrend.getsMenuNo() == null || dccSearchTrend.getsMenuNo().isEmpty()) {
            	
				dccSearchTrend.setsDive("D");
        		dccSearchTrend.setsMenuNo("24");
        		dccSearchTrend.setsGrpID("Trend");
	        	dccSearchTrend.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchTrend.setsHogi(member.getHogi());
	        	dccSearchTrend.setsXYGubun(member.getXyGubun());	        
	        	
	        	dccSearchTrend.setsGrpID(member.getId());
        	}
			
			getMainTrendLog(dccSearchTrend, mav);      
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}
	
	private void getMainTrendLog(DccSearchTrend dccSearchTrend, ModelAndView mav ) {
		
		Map grpSearchMap = new HashMap();
		grpSearchMap.put("dive",dccSearchTrend.getsDive()==null?  "": dccSearchTrend.getsDive());
		grpSearchMap.put("grpID", dccSearchTrend.getsGrpID()==null?  "": dccSearchTrend.getsGrpID());
		grpSearchMap.put("menuNo", dccSearchTrend.getsMenuNo()==null?  "": dccSearchTrend.getsMenuNo());
				
		List<Map> grpNameList = basCommonService.selectGrpNameList(grpSearchMap);
    	mav.addObject("GroupNameList", grpNameList);
    	
    	Map dccGrpTagSearchMap = new HashMap();
    	dccGrpTagSearchMap.put("xyGubun",dccSearchTrend.getsXYGubun()==null?  "": dccSearchTrend.getsXYGubun());
    	dccGrpTagSearchMap.put("hogi",dccSearchTrend.getsHogi()==null?  "": dccSearchTrend.getsHogi());
		dccGrpTagSearchMap.put("dive",dccSearchTrend.getsDive()==null?  "": dccSearchTrend.getsDive());
		dccGrpTagSearchMap.put("grpID", dccSearchTrend.getsGrpID()==null?  "": dccSearchTrend.getsGrpID());
		dccGrpTagSearchMap.put("menuNo", dccSearchTrend.getsMenuNo()==null?  "": dccSearchTrend.getsMenuNo());
		dccGrpTagSearchMap.put("uGrpNo", dccSearchTrend.getsUGrpNo()==null?  "": dccSearchTrend.getsUGrpNo());
		
		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
		
		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList);
		
		List<Map> lblDataList = (ArrayList)dccVal.get("lblDataList");
		
		for(int i=0;i<lblDataList.size();i++) {
			lblDataList.get(i).put("type", tagDccInfoList.get(i).getIOTYPE());
			lblDataList.get(i).put("desc", tagDccInfoList.get(i).getLOOPNAME());
			
			if(tagDccInfoList.get(i).getIOBIT()> -1) {
				lblDataList.get(i).put("address", tagDccInfoList.get(i).getADDRESS() + " : " + tagDccInfoList.get(i).getIOBIT());
			}else {
				lblDataList.get(i).put("address", tagDccInfoList.get(i).getADDRESS());
			}    		
			
			lblDataList.get(i).put("unit", tagDccInfoList.get(i).getUnit());
		}		
		
		mav.addObject("TagDccInfoList", tagDccInfoList);    		
		mav.addObject("lblDataList", lblDataList);
		
	}
	
	@RequestMapping("numericallist")
	public ModelAndView numericallist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();

		logger.info("############ numericallist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
			
			if(dccSearchTrend.getsMenuNo() == null || dccSearchTrend.getsMenuNo().isEmpty()) {
            	
				dccSearchTrend.setsDive("D");
        		dccSearchTrend.setsMenuNo("25");
        		dccSearchTrend.setsGrpID("Trend");
	        	dccSearchTrend.setsUGrpNo("1");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchTrend.setsHogi(member.getHogi());
	        	dccSearchTrend.setsXYGubun(member.getXyGubun());	        	
        	}
			
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchTrend.getsXYGubun()==null?  "": dccSearchTrend.getsXYGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchTrend.getsHogi()==null?  "": dccSearchTrend.getsHogi());
    		dccGrpTagSearchMap.put("dive",dccSearchTrend.getsDive()==null?  "": dccSearchTrend.getsDive());
    		dccGrpTagSearchMap.put("grpID", dccSearchTrend.getsGrpID()==null?  "": dccSearchTrend.getsGrpID());
    		dccGrpTagSearchMap.put("menuNo", dccSearchTrend.getsMenuNo()==null?  "": dccSearchTrend.getsMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchTrend.getsUGrpNo()==null?  "": dccSearchTrend.getsUGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);
    		
    		Map dccVal = basDccOsmsService.getNumericRealValue(dccGrpTagSearchMap, tagDccInfoList);
    		
    		List<Map> lblDataList = (ArrayList)dccVal.get("lblDataList");
    		List<String> pCount = (ArrayList)dccVal.get("pCountList");
    		List<String> lblCounts= (ArrayList)dccVal.get("lblCountList");
    		
    		int idx = 0;
    		double fValue = 0.0f;
    		List<String> lblBinary = new ArrayList();
    		List<String> lblVolts = new ArrayList();
    		
    		for(ComTagDccInfo tagDccInfo:tagDccInfoList) {
    			if(tagDccInfo.getIOTYPE().equals("DI")) {
    				
    				if(lblDataList.get(idx) != null && !lblDataList.get(idx).get("fValue").toString().isEmpty()) {
    					fValue = Double.parseDouble(lblDataList.get(idx).get("fValue").toString());
    					String strBin = Convert2Bin(fValue);
    					lblBinary.add( strBin.substring(0, 1) + "  " + strBin.substring(2, 5) + "  " + strBin.substring(5, 8) + 
    							"  " + strBin.substring(8, 11) + "  " + strBin.substring(11, 14) + "  " + strBin.substring(14, 17));
    				}else {
    					lblBinary.add("");
    				}    			
    				
    			}else 	if(tagDccInfo.getIOTYPE().equals("DO")) {
    				
    				if(lblDataList.get(idx) != null && !lblDataList.get(idx).get("fValue").toString().isEmpty()) {
    					fValue = Double.parseDouble(lblDataList.get(idx).get("fValue").toString());
    					String strBin = Convert2Bin(fValue);
    					lblBinary.add( strBin.substring(0, 2) + "  " + strBin.substring(3, 6) + "  " + strBin.substring(6, 9));
    				}else {
    					lblBinary.add("");
    				}    		
    				
    			}else 	if(tagDccInfo.getIOTYPE().equals("SC")) {
    				if(tagDccInfo.getSaveCore()> -1) {
	    				if(lblDataList.get(idx) != null && !lblDataList.get(idx).get("fValue").toString().isEmpty()) {
	    					fValue = Double.parseDouble(lblDataList.get(idx).get("fValue").toString());
	    					String strBin = Convert2Bin(fValue);
	    					lblBinary.add( strBin.substring(0, 1) + "  " + strBin.substring(2, 5) + "  " + strBin.substring(5, 8) + 
	    							"  " + strBin.substring(8, 11) + "  " + strBin.substring(11, 14) + "  " + strBin.substring(14, 17));
	    				}else {
	    					lblBinary.add("");
	    				}  
    				}
    				
    			}else {
    				
    				if(lblDataList.get(idx) != null && !lblDataList.get(idx).get("fValue").toString().isEmpty()) {
    					
    					if(lblDataList.get(idx).get("fValue").toString().equals("***IRR")) {
    						lblVolts.add("-");
    						lblCounts.add(idx, "-");
    					}else {
		    					fValue = Double.parseDouble(lblDataList.get(idx).get("fValue").toString());
		    					if(tagDccInfo.getIOTYPE().equals("AI")){
		    						lblVolts.add(Get_Y(Double.parseDouble(pCount.get(idx).toString()), 0, 32767, 0, 5, 10000));
		    						lblDataList.get(idx).put("fValue", (fValue > -32768)? fValue:"***IRR");
		    					}else {
		    						lblDataList.get(idx).put("fValue", (fValue > -32768)? fValue:"***IRR");
		    					}
    					}    					
    				}else {
    					lblDataList.get(idx).put("fValue", "");
    				}  
    			} 
    			
    			lblDataList.get(idx).put("type", tagDccInfo.getIOTYPE());
    			lblDataList.get(idx).put("dccId", tagDccInfo.getHogi() + " : " + tagDccInfo.getXYGubun());
    			lblDataList.get(idx).put("addr", tagDccInfo.getADDRESS());
    			lblDataList.get(idx).put("unit", tagDccInfo.getUnit());
    			
    			idx++;    			
    		}
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	
        	mav.addObject("lblDataList", lblDataList);
        	mav.addObject("lblCountList", lblCounts);
        	mav.addObject("lblBinary", lblBinary);
        	mav.addObject("lblVolts", lblVolts);
        	
        	mav.addObject("DccTagInfoList", tagDccInfoList);

			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
		}
		
		return mav;
	}
	
	private String Convert2Bin(Double value) {
	        return (value < 0 ? "1" : "0")
	                + Long.toBinaryString(Double.doubleToLongBits(Math
	                        .abs(value)));
		
		/*
		
		  	Dim i As Integer
		    Dim nDiv As Double
		    Dim nRemind As Single
		    
		    nDiv = value
		    For i = 0 To 15
		        nRemind = nDiv \ 2
		        Convert2Bin = nDiv Mod 2 & Convert2Bin
		        nDiv = nRemind
		    Next
		*/
	}
	
	private String Get_Y(double aXval, int aXmin, int aXmax, int aYmin, int aYmax, int aOffset) {
		
		String rtn ="";
		
		long Y = 0L;
		
		Y = Math.round(aXval);
		
		Y = Math.round((aYmin * aOffset) + (((aYmax - aYmin) * aOffset) * (aXval - aXmin)) / (aXmax - aXmin));
		
		Y = Y / aOffset;
		
		if (Y < aYmin) {
			return aYmin + "";
		}else {
			return Y + "";
		}
		/*
		 * Dim Y   As Single
    
		    Y = CLng(aXval)
		    
		    Y = Fix((aYmin * aOffset) + (((aYmax - aYmin) * aOffset) * (aXval - aXmin)) / (aXmax - aXmin))
		    
		    Y = Y / aOffset
		    
		    If Y < aYmin Then
		        Get_Y = aYmin
		    Else
		        Get_Y = Y
		    End If
    
		 */
	}

}
