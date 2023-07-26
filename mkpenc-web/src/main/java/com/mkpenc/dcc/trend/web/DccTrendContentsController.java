package com.mkpenc.dcc.trend.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.alt.common.service.AltCommonService;
import com.mkpenc.alt.trend.service.AltTrendService;
import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.common.module.StringUtil;
import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.service.DccAdminService;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.dcc.common.service.BasDccOsmsService;
import com.mkpenc.dcc.trend.model.DccSearchTrend;
import com.mkpenc.dcc.trend.model.TrendTagDccInfo;
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
	private CommonConstant commonConstant;
	
	@Autowired
	private DccAdminService dccAdminService;
	
	@Autowired
	private DccTrendService dccTrendService;
	
	@Autowired
	private AltTrendService altTrendService;

	@Autowired
	private BasDccOsmsService basDccOsmsService;
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired
	private AltCommonService altCommonService;
	
	@Autowired
	private ExcelHelperUtil excelHelperUtil;
	
	@RequestMapping("realtimetrendfixed")
	public ModelAndView realtimetrendfixed(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ realtimetrendfixed");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if( userInfo.getHogi() == null ) {
			if( dccSearchTrend.getHogiHeader() != null && !"".equals(dccSearchTrend.getHogiHeader()) ) {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) {
	    			if( commonConstant.getUrl().indexOf("10.135.101.222") > -1 ) {
	    				dccSearchTrend.setsHogi("4");
	    			} else {
	    				dccSearchTrend.setsHogi("3");
	    			}
	    		} else {
	    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
	    		}
	    	}
		} else {
			dccSearchTrend.setsHogi(userInfo.getHogi());
		}
		if( userInfo.getXyGubun() == null ) {
	    	if( dccSearchTrend.getXyHeader() != null && !"".equals(dccSearchTrend.getXyHeader()) ) {
	    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    		//}
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun("X");
	    		} else {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
	    		}
	    	}
		} else {
			dccSearchTrend.setsXYGubun(userInfo.getXyGubun());
		}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			getTrendData(dccSearchTrend,mav,mberInfo);
			//getGrpTagList(dccSearchTrend,mav);
			
			//changeGrpName(dccSearchTrend,mav);
	    	
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			//mav.addObject("UserInfo",mberInfo);
			
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
    	//String sGrade = userInfo.getGrade() == null ? "9" : userInfo.getGrade();
    	String strHis = dccSearchTrend.getgHis() == null ? "R" : dccSearchTrend.getgHis();
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
    	String strFast = dccSearchTrend.getgStrFast() == null ? "5" : dccSearchTrend.getgStrFast();
    	int nType = 0;
    	
    	LocalDateTime endDate = LocalDateTime.now();
    	LocalDateTime startDate = endDate.minusMinutes(10);
    	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
    	
    	String mskStart = dccSearchTrend.getStartDate();
    	String mskEnd = dccSearchTrend.getEndDate();
		
    	switch( sFixed.toUpperCase() ) {
	    	case "F": case "H":
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
    	String sGrade = userInfo.getGrade() == null ? "9" : userInfo.getGrade();
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
	
	@RequestMapping(value = "reloadGrp", method = { RequestMethod.POST } )
	@ResponseBody
	private ModelAndView reloadGrp(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("jsonView");

		logger.info("############ reloadGrp");
		
		if( dccSearchTrend.getHogiHeader() != null && !"".equals(dccSearchTrend.getHogiHeader()) ) {
    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) {
    			if( commonConstant.getUrl().indexOf("10.135.101.222") > -1 ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null && !"".equals(dccSearchTrend.getXyHeader()) ) {
    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		String strHogi = dccSearchTrend.getHogiHeader() == null ? "3" : dccSearchTrend.getHogiHeader();
		String strXY = dccSearchTrend.getXyHeader() == null ? "X" : dccSearchTrend.getXyHeader();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? userInfo.getId() : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "" : dccSearchTrend.getsUGrpNo();
    	String sFixed = dccSearchTrend.getFixed() == null ? "F" : dccSearchTrend.getFixed();
    	String sGrade = userInfo.getGrade() == null ? "9" : userInfo.getGrade();
    	String strHis = dccSearchTrend.getgHis() == null ? "R" : dccSearchTrend.getgHis();
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
    	String strFast = dccSearchTrend.getgStrFast() == null ? "5" : dccSearchTrend.getgStrFast();
    	int nType = 0;
    	
    	LocalDateTime endDate = LocalDateTime.now();
    	LocalDateTime startDate = endDate.minusMinutes(10);
    	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
    	
    	String mskStart = dccSearchTrend.getStartDate();
    	String mskEnd = dccSearchTrend.getEndDate();
		
    	switch( sFixed.toUpperCase() ) {
	    	case "F": case "H":
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
    	
    	return mav;
	}
	
	private void getGrpTagList(DccSearchTrend dccSearchTrend, String conHogi, ModelAndView mav) {
		//LocalDateTime endDate = LocalDateTime.now();
    	//LocalDateTime startDate = endDate.minusMinutes(10);

		String getStartDate = dccSearchTrend.getStartDate().replaceAll("\\{","").replaceAll("\\}","");
		String getEndDate = dccSearchTrend.getEndDate().replaceAll("\\{","").replaceAll("\\}","");
		
		if( getStartDate.indexOf(",") > -1 ) getStartDate = getStartDate.substring(0,getStartDate.indexOf(",")).trim();
		if( getEndDate.indexOf(",") > -1 ) getEndDate = getEndDate.substring(0,getEndDate.indexOf(",")).trim();
		dccSearchTrend.setStartDate(getStartDate);
		dccSearchTrend.setEndDate(getEndDate);
    	
    	LocalDateTime endDate = getEndDate == null || "".equals(getEndDate) ? LocalDateTime.now() : convDtm(getEndDate,true);
    	LocalDateTime startDate = getStartDate == null || "".equals(getStartDate) ? endDate.minusMinutes(10) : convDtm(getStartDate,true);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

		String strHogi = dccSearchTrend.getsHogi() == null ? conHogi : dccSearchTrend.getsHogi();
		String strXY = dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? "" : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "" : dccSearchTrend.getsUGrpNo();
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
    	String strFast = dccSearchTrend.getgStrFast() == null ? "5" : dccSearchTrend.getgStrFast();
    	
		if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
		if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
		if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
		String strGap = dccSearchTrend.getTxtTimeGap();
		if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
		
		Map searchMap = new HashMap();
		searchMap.put("xyGubun",strXY);
		searchMap.put("hogi",strHogi);
		searchMap.put("dive",strDive);
		searchMap.put("grpID",strGrpID);
		searchMap.put("menuNo",strMenuNo);
		searchMap.put("uGrpNo",strUGrpNo);
		searchMap.put("strFast",strFast);
		searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? addDate("s",endDate.format(dtf),-650) : dccSearchTrend.getStartDate());
		searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? endDate.format(dtf) : dccSearchTrend.getEndDate());

		//List<ComTagDccInfo> dccGrpTagList = basDccOsmsService.getDccGrpTagList(searchMap);
		List<TrendTagDccInfo> dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
		Map dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);

		Map lblTagList = new HashMap();
		Map lblValueList = new HashMap();
		Map lblUnitList = new HashMap();
		
		for( int ll=0;ll<dccGrpTagList.size();ll++ ) {
			//System.out.println(((List) dccVal.get("lblDataList")).get(ll));
			lblTagList.put(ll,dccGrpTagList.get(ll).getHogi()+dccGrpTagList.get(ll).getXYGubun()+" "+dccGrpTagList.get(ll).getDataLoop());
			lblValueList.put(ll,((List) dccVal.get("lblDataList")).get(ll));
			lblUnitList.put(ll,dccGrpTagList.get(ll).getUnit());
		}
		
		List<Map> lblInfoList = new ArrayList();
		lblInfoList.add(0,lblTagList);
		lblInfoList.add(1,lblValueList);
		lblInfoList.add(2,lblUnitList);
		
		//System.out.println(lblInfoList.get(1));
		
		mav.addObject("LblInfoList",lblInfoList);
	}
	
	private List<Map> getGrpTagListE(DccSearchTrend dccSearchTrend, String conHogi) {
		//LocalDateTime endDate = LocalDateTime.now();
    	//LocalDateTime startDate = endDate.minusMinutes(10);
    	
    	LocalDateTime endDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? LocalDateTime.now() : convDtm(dccSearchTrend.getEndDate(),true);
    	LocalDateTime startDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? endDate.minusMinutes(10) : convDtm(dccSearchTrend.getStartDate(),true);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

		String strHogi = dccSearchTrend.getsHogi() == null ? conHogi : dccSearchTrend.getsHogi();
		String strXY = dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? "" : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "0" : dccSearchTrend.getsUGrpNo();
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
		dccSearchTrend.setStartDate(startDate.format(dtf));
		dccSearchTrend.setEndDate(endDate.format(dtf));
		if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
		if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
		if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
		String strGap = dccSearchTrend.getTxtTimeGap();
		if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
		
		Map searchMap = new HashMap();
		searchMap.put("xyGubun",strXY);
		searchMap.put("hogi",strHogi);
		searchMap.put("dive",strDive);
		searchMap.put("grpID",strGrpID);
		searchMap.put("menuNo",strMenuNo);
		searchMap.put("uGrpNo",strUGrpNo);
		searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? addDate("s",endDate.format(dtf),-650) : dccSearchTrend.getStartDate());
		searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? endDate.format(dtf) : dccSearchTrend.getEndDate());

		//List<ComTagDccInfo> dccGrpTagList = basDccOsmsService.getDccGrpTagList(searchMap);
		List<TrendTagDccInfo> dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
		Map dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);

		Map lblTagList = new HashMap();
		Map lblValueList = new HashMap();
		Map lblUnitList = new HashMap();
		
		for( int ll=0;ll<dccGrpTagList.size();ll++ ) {
			//System.out.println(((List) dccVal.get("lblDataList")).get(ll));
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
	
	@RequestMapping(value="getScanTime", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView getScanTime(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		String getHogiHeader = dccSearchTrend.getHogiHeader();
		String getXyHeader = dccSearchTrend.getXyHeader();
		
		if( getHogiHeader.indexOf(",") > -1 ) getHogiHeader = getHogiHeader.substring(0,getHogiHeader.indexOf(",")).trim();
		if( getXyHeader.indexOf(",") > -1 ) getXyHeader = getXyHeader.substring(0,getXyHeader.indexOf(",")).trim();

		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( getXyHeader != null && !"".equals(getXyHeader) ) {
    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun(getXyHeader);
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
	    
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			String pScanTime = dccTrendService.selectScanTime(dccSearchTrend);
			
			mav.addObject("pScantTime",pScanTime);
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
		}
		
		return mav;
	}
	
	@RequestMapping(value="getTagCall", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView getTagCall(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("jsonView");

		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
	    
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		
		Map searchMap = new HashMap();
		searchMap.put("hogi", dccSearchTrend.getsHogi());
		searchMap.put("xyGubun", dccSearchTrend.getsXYGubun());
		searchMap.put("dive", dccSearchTrend.getsDive());
		
		String strUGrpNo = dccSearchTrend.getsUGrpNo();
		String strMenuNo = dccSearchTrend.getsMenuNo();
		String strGrpID = dccSearchTrend.getsGrpID();
		String strGap = dccSearchTrend.getTxtTimeGap();
		if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
		if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
		if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
		if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
		
		if( dccSearchTrend.getsGrpID() != null ) searchMap.put("grpID", dccSearchTrend.getsGrpID());
		if( dccSearchTrend.getsMenuNo() != null ) searchMap.put("menuNo", dccSearchTrend.getsMenuNo());
		if( dccSearchTrend.getsUGrpNo() != null ) searchMap.put("uGrpNo", dccSearchTrend.getsUGrpNo());                   
		
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			//List<ComTagDccInfo> dccGrpTagList = basDccOsmsService.getDccGrpTagList(searchMap);
			List<TrendTagDccInfo> dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
			
			// 소스에 없으나 AS-IS 에서 확인하면 이 부분이 필요
			dccGrpTagList.forEach(t -> {
				if( "AI".equalsIgnoreCase(t.getIOTYPE()) && ("2010".equals(t.getADDRESS()) || "2140".equals(t.getADDRESS())) ) {
					t.setMinVal((Double.parseDouble(t.getMinVal())*0.0081)+"");
					t.setMaxVal((Double.parseDouble(t.getMaxVal())*0.0081)+"");
				}
			});
			
			mav.addObject("getTagInfoList",dccGrpTagList);
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
		}
		
		return mav;
	}
	
	@RequestMapping(value="changeGrpName", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView changeGrpName(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		logger.info("############ changeGrpName");
		
		//LocalDateTime endDate = LocalDateTime.now();
    	//LocalDateTime startDate = endDate.minusMinutes(10);
		
		
		String getStartDate = dccSearchTrend.getStartDate().replaceAll("\\{","").replaceAll("\\}","");
		String getEndDate = dccSearchTrend.getEndDate().replaceAll("\\{","").replaceAll("\\}","");
		
		if( getStartDate.indexOf(",") > -1 ) getStartDate = getStartDate.substring(0,getStartDate.indexOf(",")).trim();
		if( getEndDate.indexOf(",") > -1 ) getEndDate = getEndDate.substring(0,getEndDate.indexOf(",")).trim();
		
		LocalDateTime endDate = getEndDate == null || "".equals(getEndDate) ? LocalDateTime.now() : convDtm(getEndDate,true);
    	LocalDateTime startDate = getStartDate == null || "".equals(getStartDate) ? endDate.minusMinutes(10) : convDtm(getStartDate,true);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getIsRealtime() == null ) dccSearchTrend.setIsRealtime("N");
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("Trend");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		if( dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf),-650));
		if( dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ) dccSearchTrend.setEndDate(endDate.format(dtf));

		String searchGrpNo = dccSearchTrend.getsUGrpNo();
		if( searchGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(searchGrpNo.substring(0,searchGrpNo.indexOf(",")));
		String searchMenuNo = dccSearchTrend.getsMenuNo();
		if( searchMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(searchMenuNo.substring(0,searchMenuNo.indexOf(",")));
		String strGrpID = dccSearchTrend.getsGrpID();
		if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
		String strGap = dccSearchTrend.getTxtTimeGap();
		if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
		String getHis = dccSearchTrend.getgHis();
		if( getHis.indexOf(",") > -1 ) dccSearchTrend.setgHis(getHis.substring(0,getHis.indexOf(",")));
	    
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			dccSearchTrend.setMenuName(this.menuName);
			
			dccSearchTrend.setsUGrpNo(dccSearchTrend.getsUGrpNo() == null ? userInfo.getId() : dccSearchTrend.getsUGrpNo());
			
			getGrpTagList(dccSearchTrend,conHogi,mav);
			
			changeGrpName(dccSearchTrend,conHogi,mav);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
		}
	
		return mav;
	}
	
	private void changeGrpName(DccSearchTrend dccSearchTrend, String conHogi, ModelAndView mav) {
		
		logger.info("############ realtimetrendfixed");
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getIsRealtime() == null ) dccSearchTrend.setIsRealtime("N");
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

		String getStartDate = dccSearchTrend.getStartDate().replaceAll("\\{","").replaceAll("\\}","");
		String getEndDate = dccSearchTrend.getEndDate().replaceAll("\\{","").replaceAll("\\}","");
		//System.out.println("########## changeGrpName >> "+getStartDate);
		//System.out.println("########## changeGrpName >> "+getEndDate);
		
		if( getStartDate.indexOf(",") > -1 ) getStartDate = getStartDate.substring(0,getStartDate.indexOf(",")).trim();
		if( getEndDate.indexOf(",") > -1 ) getEndDate = getEndDate.substring(0,getEndDate.indexOf(",")).trim();
		dccSearchTrend.setStartDate(getStartDate);
		dccSearchTrend.setEndDate(getEndDate);
		
		Map searchMap = new HashMap();
		searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
		searchMap.put("hogi",dccSearchTrend.getsHogi());
		searchMap.put("dive",dccSearchTrend.getsDive());
		searchMap.put("grpID",dccSearchTrend.getsGrpID());
		searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
		searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
		searchMap.put("startDate",getStartDate == null || "".equals(getStartDate) ? addDate("s",now.format(dtf)+".000",-650) : getStartDate);
		searchMap.put("endDate",getEndDate == null || "".equals(getEndDate) ? now.format(dtf)+".000" : getEndDate);
		
		//System.out.println(searchMap.get("startDate")+" // "+searchMap.get("endDate"));
		
		List<TrendTagDccInfo> dccGrpTagList = new ArrayList();
		Map dccVal = new HashMap();
		List<Map> grpTagList = new ArrayList();
		if( "D".equalsIgnoreCase(strDive) ) {
			dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
			dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);
		} else if( "B".equalsIgnoreCase(strDive) ) {
			grpTagList = dccTrendService.getGrpTag(searchMap);
		}
		
		//System.out.println(dccGrpTagList.size());
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
			for( TrendTagDccInfo comTagDccInfo : dccGrpTagList ) {
				
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
		
		if( ((ArrayList)dccVal.get("lblDataList")).size() > 0 ) {
			getTrendView(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, conHogi, mav);
		}
		
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
		
		
	private void getTrendView(DccSearchTrend dccSearchTrend, List<TrendTagDccInfo> dccGrpTagList, List<Map> grpTagList, Map searchMap, String conHogi, ModelAndView mav) {

		String strUGrpNo = dccSearchTrend.getsUGrpNo();
		String strTimeGap = dccSearchTrend.getTxtTimeGap();
		Long lGap = Long.parseLong(strTimeGap)*1000;
		String strFast = "";
		String sDtm = dccSearchTrend.getStartDate().indexOf(",") > -1 ? dccSearchTrend.getStartDate().substring(0,dccSearchTrend.getStartDate().indexOf(",")).trim().replaceAll("\\{","").replaceAll("\\}","") : dccSearchTrend.getStartDate().replaceAll("\\{","").replaceAll("\\}","");
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		String strStartTime = sDtm;
		String strEndTime = dccSearchTrend.getEndDate().indexOf(",") > -1 ? dccSearchTrend.getEndDate().substring(0,dccSearchTrend.getEndDate().indexOf(",")).trim().replaceAll("\\{","").replaceAll("\\}","") : dccSearchTrend.getEndDate().replaceAll("\\{","").replaceAll("\\}","");
		//System.out.println("########## changeGrpName >> "+strStartTime);
		//System.out.println("########## changeGrpName >> "+strEndTime);

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
			//System.out.println("CHECK");
			//Call RealTime
			strScanTime = dccTrendService.selectScanTime(dccSearchTrend) == null ? "" : dccTrendService.selectScanTime(dccSearchTrend);
			
			switch( dccSearchTrend.getsDive().toUpperCase() ) {
				case "M": case "A":
					lGap = Long.parseLong(strTimeGap) * 1000;
					strStartTime = "Y".equalsIgnoreCase(dccSearchTrend.getIsRealtime().toString()) ? dccSearchTrend.getStartDate() : dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*nTrendWidth));
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
						strStartTime = "Y".equalsIgnoreCase(dccSearchTrend.getIsRealtime().toString()) ? dccSearchTrend.getStartDate() : dtf.format(convDtm(strScanTime,false).minusSeconds(440));
						strEndTime = strScanTime;
					} else {
						strStartTime = "Y".equalsIgnoreCase(dccSearchTrend.getIsRealtime().toString()) ? dccSearchTrend.getStartDate() : dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*(nTrendWidth+10)));
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
						strStartTime = "Y".equalsIgnoreCase(dccSearchTrend.getIsRealtime().toString()) ? dccSearchTrend.getStartDate() : dtf.format(convDtm(strScanTime,false).minusSeconds(440));
						strEndTime = strScanTime;
					} else {
						strStartTime = "Y".equalsIgnoreCase(dccSearchTrend.getIsRealtime().toString()) ? dccSearchTrend.getStartDate() : dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*(nTrendWidth+10)));
						strEndTime = strScanTime;
					}
					break;
			}
		//} else {
		//	strScanTime = dccSearchTrend.getEndDate().toString();
		}
		
		//Call Historical
		String pScanTime = "";
		if( "".equals(strScanTime) && "".equals(strStartTime) ) {
			pScanTime = dccTrendService.selectScanTime(dccSearchTrend);
			lGap = Long.parseLong(strTimeGap) * 1000;
			strStartTime = dtf.format(convDtm(pScanTime,true).minusSeconds((lGap/1000)*nTrendWidth));
			strEndTime = pScanTime;
		//} else {
			//lGap = Long.parseLong(strTimeGap) * 1000;
			//strStartTime = dtf.format(convDtm(strScanTime,true).minusSeconds((lGap/1000)*nTrendWidth));
			//strStartTime = sDtm;
			//strEndTime = strScanTime;
		}
		
		Duration durSec = Duration.between(convDtm(strStartTime.replaceAll("/", "-"),true),convDtm(strEndTime.replaceAll("/", "-"),true));
		int nSec = (int) durSec.getSeconds();
		int nBun = (nSec-nSec%60)/60;

		//System.out.println("########## getTrendView >> "+strStartTime);
		//System.out.println("########## getTrendView >> "+strEndTime);
		
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
				if( "4".equals(conHogi) ) {
					//List<Map> rsTrendList = dccTrendService.rsTrend5sGap222(searchMap, dccGrpTagList, lGap, strFast);
					rsTrendListHistorical = getRsTrend5sGap222(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
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
		//if( "R".equalsIgnoreCase(dccSearchTrend.getgHis()) ) {
		//	nEndPos = nTrendWidth;
		//} else {
			nEndPos = rsTrendListHistorical.size() > nTrendWidth ? nTrendWidth : rsTrendListHistorical.size()-1;
		//}
		
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
				
				//System.out.println("["+ht+"]["+hi+"] "+rsTrendListHistorical.get(ht)+" >>> "+rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)));
				String convTarget = rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)) == null ? "-99999" : rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)).toString();
				
				String RetVal = setDataConv(ht,convTarget,dccGrpTagArray,dccSearchTrend.getsMenuNo(),lGap);
				
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
			
			timeNPosH.put("m_data",rtnMapHistorical);
			
			arrTrendData.add(ht,timeNPosH);
		}
		
		LocalDateTime now = LocalDateTime.now();
		int nDateDiff = (int) Duration.between(now,convDtm(strStartTime,true)).getSeconds();
		if( Math.abs(nDateDiff) > 51840000 ) {
			sDateE = arrTrendData.get(nEndPos).toString();
			
			if( !"".equals(sDateS) && !"".equals(sDateE) ) {
				if( !sDateS.equals(sDateE) ) {
					searchMap.replace("startDate",sDateS);
					searchMap.replace("endDate",sDateE);
					List<Map> rsTrendListHistorical2 = new ArrayList<Map>();
					if( "4".equals(conHogi) ) {
						//List<Map> rsTrendList = dccTrendService.rsTrend5sGap222(searchMap, dccGrpTagList, lGap, strFast);
						rsTrendListHistorical2 = getRsTrend5sGap222(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
					} else {
						//rsTrendListHistorical = dccTrendService.rsTrend5sGap(searchMap, dccGrpTagList, lGap, strFast);
						rsTrendListHistorical2 = getRsTrend5sGap(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
					}
					
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
	
	private List<Map> getTrendViewE(DccSearchTrend dccSearchTrend, List<TrendTagDccInfo> dccGrpTagList, List<Map> grpTagList, Map searchMap, String conHogi) {
			
		String strUGrpNo = dccSearchTrend.getsUGrpNo();
		String strTimeGap = dccSearchTrend.getTxtTimeGap();
		Long lGap = Long.parseLong(strTimeGap)*1000;
		String strFast = "";
		String sDtm = dccSearchTrend.getStartDate();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String strStartTime = sDtm;
		String strEndTime = dccSearchTrend.getEndDate();

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
		//} else {
		//	strScanTime = dccSearchTrend.getEndDate().toString();
		}

		//Call Historical
		String pScanTime = "";
		if( "".equals(strScanTime) && "".equals(strStartTime) ) {
			pScanTime = dccTrendService.selectScanTime(dccSearchTrend);
			lGap = Long.parseLong(strTimeGap) * 1000;
			strStartTime = dtf.format(convDtm(pScanTime,true).minusSeconds((lGap/1000)*nTrendWidth));
			strEndTime = pScanTime;
		//} else {
			//lGap = Long.parseLong(strTimeGap) * 1000;
			//strStartTime = dtf.format(convDtm(strScanTime,true).minusSeconds((lGap/1000)*nTrendWidth));
			//strStartTime = sDtm;
			//strEndTime = strScanTime;
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
				if( "4".equals(conHogi) ) {
					//List<Map> rsTrendList = dccTrendService.rsTrend5sGap222(searchMap, dccGrpTagList, lGap, strFast);
					rsTrendListHistorical = getRsTrend5sGap222(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
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
		//if( "R".equalsIgnoreCase(dccSearchTrend.getgHis()) ) {
		//	nEndPos = nTrendWidth;
		//} else {
			nEndPos = rsTrendListHistorical.size() > nTrendWidth ? nTrendWidth : rsTrendListHistorical.size()-1;
		//}
		
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
				
				//System.out.println("["+ht+"]["+hi+"] "+rsTrendListHistorical.get(ht)+" >>> "+rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)));
				String convTarget = rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)) == null ? "-99999" : rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)).toString();
				
				String RetVal = setDataConv(ht,convTarget,dccGrpTagArray,dccSearchTrend.getsMenuNo(),lGap);
				
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
			
			timeNPosH.put("m_data",rtnMapHistorical);
			
			arrTrendData.add(ht,timeNPosH);
		}
		
		LocalDateTime now = LocalDateTime.now();
		int nDateDiff = (int) Duration.between(now,convDtm(strStartTime,true)).getSeconds();
		if( Math.abs(nDateDiff) > 51840000 ) {
			sDateE = arrTrendData.get(nEndPos).toString();
			
			if( !"".equals(sDateS) && !"".equals(sDateE) ) {
				if( !sDateS.equals(sDateE) ) {
					searchMap.replace("startDate",sDateS);
					searchMap.replace("endDate",sDateE);
					List<Map> rsTrendListHistorical2 = new ArrayList<Map>();
					if( "4".equals(conHogi) ) {
						//List<Map> rsTrendList = dccTrendService.rsTrend5sGap222(searchMap, dccGrpTagList, lGap, strFast);
						rsTrendListHistorical2 = getRsTrend5sGap222(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
					} else {
						//rsTrendListHistorical = dccTrendService.rsTrend5sGap(searchMap, dccGrpTagList, lGap, strFast);
						rsTrendListHistorical2 = getRsTrend5sGap(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
					}
					
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
	
	private List<Map> getLogViewE(DccSearchTrend dccSearchTrend, List<TrendTagDccInfo> dccGrpTagList, List<Map> grpTagList, Map searchMap, String conHogi) {
		
		String strUGrpNo = dccSearchTrend.getsUGrpNo();
		String strTimeGap = dccSearchTrend.getTxtTimeGap();
		Long lGap = Long.parseLong(strTimeGap)*1000;
		String strFast = "";
		String sDtm = dccSearchTrend.getStartDate();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String strStartTime = sDtm;
		String strEndTime = dccSearchTrend.getEndDate();
		String tmpEndTime = dtf.format(convDtm(sDtm,false).plusSeconds(Long.parseLong(strTimeGap)*50));

		List<Map> arrTrendData = new ArrayList();
		
		Duration durSec = Duration.between(convDtm(tmpEndTime.replaceAll("/", "-"),false),convDtm(strEndTime.replaceAll("/", "-"),false));
		int nSec = (int) durSec.getSeconds();
		
		if( nSec > 0 ) tmpEndTime = strEndTime;
		
		dccSearchTrend.setStartDate(strStartTime);
		dccSearchTrend.setEndDate(tmpEndTime);
		
		Duration durCnt = Duration.between(convDtm(strStartTime.replaceAll("/", "-"),false),convDtm(strEndTime.replaceAll("/", "-"),false));
		int nCnt = Math.abs((int) durCnt.getSeconds());
		int nDiff = nCnt%Integer.parseInt(strTimeGap);
		nCnt = (nCnt-nDiff)/Integer.parseInt(strTimeGap);

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
				if( "4".equals(conHogi) ) {
					//List<Map> rsTrendList = dccTrendService.rsTrend5sGap222(searchMap, dccGrpTagList, lGap, strFast);
					rsTrendListHistorical = getRsTrend5sGap222(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
				} else {
					//rsTrendListHistorical = dccTrendService.rsTrend5sGap(searchMap, dccGrpTagList, lGap, strFast);
					rsTrendListHistorical = getRsTrend5sGap(dccSearchTrend, dccGrpTagList, strFast, false, lGap);
				}
				break;
			case "B":
				//rsTrendListpHistorical = dccTrendService.rsTrend5sGapDccMark(searchMap, dccGrpTagList, lGap, strFast);
				break;
		}
		
		String sDateS = "";
		String sDateE = "";
		int iRow = 0;

		if( nCnt > rsTrendListHistorical.size() ) nCnt = rsTrendListHistorical.size();
		for( int ht=0;ht<nCnt;ht++ ) {
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
				
				//System.out.println("["+ht+"]["+hi+"] "+rsTrendListHistorical.get(ht)+" >>> "+rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)));
				String convTarget = rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)) == null ? "-99999" : rsTrendListHistorical.get(ht).get("tvalue"+(hi+1)).toString();
				
				String RetVal = setDataConv(ht,convTarget,dccGrpTagArray,dccSearchTrend.getsMenuNo(),lGap);

				int nRetValType = 0;
				Double tmpN = 0d;
				try {
					if( RetVal == null ) {
						nRetValType = 2;
					} else {
						if( "0.5".equalsIgnoreCase(strTimeGap) && ("1".equals(dccGrpTagArray[5]) || !"".equals(dccGrpTagArray[3])) ) {
							tmpN = Double.parseDouble(RetVal) / Math.pow(2, 15-Double.parseDouble(dccGrpTagArray[3]));
						} else {
							tmpN = Double.parseDouble(RetVal);
						}
						nRetValType = 0;
					}
				} catch( NumberFormatException nfe ) {
					nRetValType = 1;
				}
				
				if( nRetValType == 0 ) {
					rtnMapHistorical.put(hi,tmpN+"");
				} else if( nRetValType == 1 ) {
					rtnMapHistorical.put(hi,cnstErrStr);
				} else {
					rtnMapHistorical.put(hi,"");
				}
			}
			
			timeNPosH.put("m_data",rtnMapHistorical);
			
			arrTrendData.add(ht,timeNPosH);
		}
		
		return arrTrendData;
	}
	
	private List<Map> getRsTrend5sGap(DccSearchTrend dccSearchTrend, List<TrendTagDccInfo> dccGrpTagList, String strFast, boolean bOldFlag, long lGap) {
		List<Map> rtnMapList = new ArrayList();
		int nRes = 0;
		String procName = "";
		Map procInfo = new HashMap();
		String qryStr = "";
		int size = dccGrpTagList.size();
		
		String strStartDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? "" : dccSearchTrend.getStartDate();
		String strEndDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? "" : dccSearchTrend.getEndDate();
		
		if( strStartDate.indexOf(",") > -1 ) strStartDate = strStartDate.substring(0,strStartDate.indexOf(","));
		if( strEndDate.indexOf(",") > -1 ) strEndDate = strEndDate.substring(0,strEndDate.indexOf(","));
		
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
	
	private List<Map> getRsTrend5sGap222(DccSearchTrend dccSearchTrend, List<TrendTagDccInfo> dccGrpTagList, String strFast, boolean bOldFlag, long lGap) {
		List<Map> rtnMapList = new ArrayList();
		int nRes = 0;
		String procName = "";
		Map procInfo = new HashMap();
		String qryStr = "";
		int size = dccGrpTagList.size();
		
		String strStartDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? "" : dccSearchTrend.getStartDate();
		String strEndDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? "" : dccSearchTrend.getEndDate();
		
		if( strStartDate.indexOf(",") > -1 ) strStartDate = strStartDate.substring(0,strStartDate.indexOf(","));
		if( strEndDate.indexOf(",") > -1 ) strEndDate = strEndDate.substring(0,strEndDate.indexOf(","));
		
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
					+ " declare @iSeq int \n"
					+ " declare @Chk smallint \n"
					+ " set @Chk = 0 \n"
					+ " set @iSeq = 0 \n"
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
				if( lGap > 60000 ) {
					qryStr += "     set @etime = dateadd(ms, 60000, @curdate) \n";
				} else {
					qryStr += "     set @etime = dateadd(ms, 7000, @curdate) \n";
				}
				
				for( int i=1;i<size+1;i++ ) {
					qryStr += "        SELECT @thistime"+i+" = min(Scantime) FROM LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND"+dccGrpTagList.get(i-1).getTBLNO()+" WHERE SCANTIME BETWEEN @stime AND @etime \n"
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
				
				qryStr += "@iSeq) \n";
			}
			
			qryStr += "         set @curdate = dateadd(ms, @timegap, @curdate) \n"
					+ "         if @curdate = @thistime1 \n"
					+ "            begin \n"
					+ "            set @curdate = dateadd(ms, 1000, @curdate) \n"
					+ "            End \n"
					+ " End\n";
			
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
						qryStr += "         'tvalue"+i+"' = (select tvalue"+dccGrpTagList.get(i-1).getFLDNO()+" from LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND"+dccGrpTagList.get(i-1).getTBLNO()+" where Scantime = a.thistime"+i+") \n";
					}
				} else {
					if( "F".equalsIgnoreCase(strFast) ) {
						qryStr += "         'tvalue"+i+"' = (select tvalue"+dccGrpTagList.get(i-1).getFLDNO_FAST()+" from LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND_FAST where Scantime = a.thistime"+i+" and Seq = 1), \n";
					} else {
						qryStr += "         'tvalue"+i+"' = (select tvalue"+dccGrpTagList.get(i-1).getFLDNO()+" from LOG_"+dccGrpTagList.get(i-1).getHogi()+"DCC_TREND"+dccGrpTagList.get(i-1).getTBLNO()+" where Scantime = a.thistime"+i+"), \n";
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
	public ModelAndView ssql(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("############ ssql");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
    	if( dccSearchTrend.getIoType() == null || "".equals(dccSearchTrend.getIoType()) ) dccSearchTrend.setIoType("AI");
    	if( dccSearchTrend.getIoBit() == null || "".equals(dccSearchTrend.getIoBit()) ) dccSearchTrend.setIoBit("0");
    	if( dccSearchTrend.getSaveCore() == null ) dccSearchTrend.setSaveCore("0");
    	if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
    	if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
    	if( dccSearchTrend.getCboHogi() == null ) dccSearchTrend.setCboHogi("3");
    	if( dccSearchTrend.getCboXY() == null ) dccSearchTrend.setCboXY("X");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchAlarm.getsUGrpNo() != null && !dccSearchAlarm.getsUGrpNo().isEmpty()) {
    	
		List<Map> ioList = dccTrendService.selectSetIOList(dccSearchTrend);
		
		for( Map ioItem: ioList) {
			ioItem.put("ioBit", dccSearchTrend.getIoBit());
			ioItem.put("ioType", dccSearchTrend.getIoType());
			ioItem.put("gubun", dccSearchTrend.getsDive());
			ioItem.put("hogi", dccSearchTrend.getCboHogi());
			ioItem.put("xyGubun", dccSearchTrend.getCboXY());
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

    	//userInfo.setHogi(dccSearchTrend.getHogiHeader());
    	//userInfo.setXyGubun(dccSearchTrend.getXyHeader());

		mav.addObject("BaseSearch", dccSearchTrend);        	
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value = "moveTag", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView moveTag(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("############ moveTag");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
    	if( dccSearchTrend.getIoType() == null || "".equals(dccSearchTrend.getIoType()) ) dccSearchTrend.setIoType("AI");
    	if( dccSearchTrend.getIoBit() == null || "".equals(dccSearchTrend.getIoBit()) ) dccSearchTrend.setIoBit("0");
    	if( dccSearchTrend.getSaveCore() == null ) dccSearchTrend.setSaveCore("0");
    	if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchTrend.getsUGrpNo() != null && !dccSearchTrend.getsUGrpNo().isEmpty()) {
    	
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? "Trend" : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "0" : dccSearchTrend.getsUGrpNo();
    	String strType = dccSearchTrend.getType() == null ? "U" : dccSearchTrend.getType();
    	
    	Map searchMapGrpNm = new HashMap();
		searchMapGrpNm.put("hogi", dccSearchTrend.getsHogi());
		searchMapGrpNm.put("xyGubun", dccSearchTrend.getsXYGubun());
		searchMapGrpNm.put("grpID", strGrpID);
		searchMapGrpNm.put("menuNo", strMenuNo);
		searchMapGrpNm.put("uGrpNo", strUGrpNo);
		searchMapGrpNm.put("loopName", dccSearchTrend.getDescrMod().split("_")[0]);
		//searchMapGrpNm.put("uGrpNo", strUGrpNo);
		
		List<Map> moveTagInfoList = dccTrendService.selectMoveTagTrend(searchMapGrpNm);
		
		//System.out.println(moveTagInfoList.get(0).get("ISEQ"));
		
		mav.addObject("MoveTagInfoList",moveTagInfoList);

		mav.addObject("BaseSearch", dccSearchTrend);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value = "cmdOK", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView cmdOK(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("############ cmdOK");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
    	if( dccSearchTrend.getIoType() == null || "".equals(dccSearchTrend.getIoType()) ) dccSearchTrend.setIoType("AI");
    	if( dccSearchTrend.getIoBit() == null || "".equals(dccSearchTrend.getIoBit()) ) dccSearchTrend.setIoBit("0");
    	if( dccSearchTrend.getSaveCore() == null ) dccSearchTrend.setSaveCore("0");
    	if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");

		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
    	if( dccSearchTrend.getFixed() == null || "".equals(dccSearchTrend.getFixed()) ) dccSearchTrend.setFixed("F");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
		
		//if(dccSearchTrend.getsUGrpNo() != null && !dccSearchTrend.getsUGrpNo().isEmpty()) {
    	
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? "Trend" : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpName = dccSearchTrend.getsUGrpName() == null ? "" : dccSearchTrend.getsUGrpName();
    	String strUGrpNo = "";
    	String strType = dccSearchTrend.getType() == null ? "" : dccSearchTrend.getType();
    	String strISeqMod = dccSearchTrend.getiSeqMod() == null ? "" : dccSearchTrend.getiSeqMod();
    	String strHogiMod = dccSearchTrend.getHogiMod() == null ? "" : dccSearchTrend.getHogiMod();
    	String strXyGubunMod = dccSearchTrend.getXyGubunMod() == null ? "" : dccSearchTrend.getXyGubunMod();
    	String strDescrMod = dccSearchTrend.getDescrMod() == null ? "" : dccSearchTrend.getDescrMod();
    	String strIoTypeMod = dccSearchTrend.getIoTypeMod() == null ? "" : dccSearchTrend.getIoTypeMod();
    	String strAddressMod = dccSearchTrend.getAddressMod() == null ? "" : dccSearchTrend.getAddressMod();
    	String strIoBitMod = dccSearchTrend.getIoBitMod() == null ? "" : dccSearchTrend.getIoBitMod();
    	String strMinValMod = dccSearchTrend.getMinValMod() == null ? "" : dccSearchTrend.getMinValMod();
    	String strMaxValMod = dccSearchTrend.getMaxValMod() == null ? "" : dccSearchTrend.getMaxValMod();
    	String strSaveCoreMod = dccSearchTrend.getSaveCoreMod() == null ? "" : dccSearchTrend.getSaveCoreMod();
    	
    	String strFixed = dccSearchTrend.getFixed() == null ? "" : dccSearchTrend.getFixed();
    	
    	Map searchMapGrpNm = new HashMap();
		searchMapGrpNm.put("grpID", strGrpID);
		searchMapGrpNm.put("dive", "D");
		searchMapGrpNm.put("menuNo", strMenuNo);
		searchMapGrpNm.put("uGrpName", strUGrpName);
		//searchMapGrpNm.put("uGrpNo", strUGrpNo);
		
		String manageType = "";
		
		int nRes = 0;
		if( "N".equalsIgnoreCase(strType) ) {
			nRes = 1;
			strUGrpNo = "1";
			searchMapGrpNm.put("gGrpNo", strUGrpNo);
			
			manageType = "numericalFixed";
		} else if( "I".equalsIgnoreCase(strType) ) {
			strUGrpNo = basCommonService.selectMaxGrpName(searchMapGrpNm).get(0) == null ? "" : basCommonService.selectMaxGrpName(searchMapGrpNm).get(0).get("MAX_UGrpNo").toString();
			if( strUGrpNo == null || "".equals(strUGrpNo) ) {
				if( "22".equals(strMenuNo) || "24".equals(strMenuNo) || "32".equals(strMenuNo) ) {
					strUGrpNo = "101";
				} else {
					strUGrpNo = "0";
				}
			}
			
			strUGrpNo = (Integer.parseInt(strUGrpNo)+1)+"";
			searchMapGrpNm.put("gGrpNo", strUGrpNo);
			
			nRes = dccTrendService.addGroupTrendFixed(searchMapGrpNm);
			
			manageType = "addNewGroup";
		} else {
			strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "0" : dccSearchTrend.getsUGrpNo();
			
			searchMapGrpNm.put("gGrpNo", strUGrpNo);
			
			nRes = dccTrendService.updateGroupTrendFixed(searchMapGrpNm);
			
			manageType = "updateExistGroup";
		}
		
		String[] data = new String[10];
		data[0] = strISeqMod;
		data[1] = strHogiMod;
		data[2] = strXyGubunMod;
		data[3] = strDescrMod;
		data[4] = strIoTypeMod;
		data[5] = strAddressMod;
		data[6] = strIoBitMod;
		data[7] = strMinValMod;
		data[8] = strMaxValMod;
		data[9] = strSaveCoreMod;
		
		if( nRes > 0 ) {
			nRes = Mst_GrpTagSave(strGrpID, strMenuNo, strUGrpNo, dccSearchTrend.getsXYGubun(), dccSearchTrend.getsHogi(), dccSearchTrend.getsHogi(), data);
			
			if( nRes > 0 ) {
				String tmpHogi = "3".equals(dccSearchTrend.getsHogi()) ? "4" : "3";
				nRes = Mst_GrpTagSave(strGrpID, strMenuNo, strUGrpNo, dccSearchTrend.getsXYGubun(), tmpHogi, dccSearchTrend.getsHogi(), data);
			}
			
			dccSearchTrend.setsUGrpNo(strUGrpNo);
		
			GroupSave222(dccSearchTrend);
		}
		
		//System.out.println(strUGrpNo+", "+strMenuNo+", "+strGrpID+", "+strFixed);
		dccSearchTrend.setsUGrpNo(strUGrpNo);
		dccSearchTrend.setsMenuNo(strMenuNo);
		dccSearchTrend.setsGrpID(strGrpID);
		dccSearchTrend.setFixed(strFixed);
		if( "31".equals(dccSearchTrend.getsMenuNo()) || "32".equals(dccSearchTrend.getsMenuNo()) ) {
			getTrendDataBar(dccSearchTrend,mav,userInfo);
		} else {
			getTrendData(dccSearchTrend,mav,userInfo);
		}
		
		mav.addObject("ManageType",manageType);
		mav.addObject("UpdatedGrpNo",strUGrpNo);

		mav.addObject("BaseSearch", dccSearchTrend);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	public int Mst_GrpTagSave(String strGrpID, String strMenuNo, String grpNo, String gXYGubun, String gHogi, String hogi, String[] data) {
		int nRes = 0;

		Map delMap = new HashMap();
		delMap.put("gubun", "D");
		delMap.put("id", strGrpID);
		delMap.put("grpHOGI", gHogi);
		delMap.put("menuNo", strMenuNo);
		delMap.put("grpNo", grpNo);
		
		dccTrendService.deleteGrpTag(delMap);
		
		for( int i=0;i<data[0].split("\\|").length;i++ ) {
			String strTagNo = i+"";
			String strTmpiSeq = "0";
			
			Map searchGrpTagMap = new HashMap();
			searchGrpTagMap.put("gubun", "D");
			searchGrpTagMap.put("id", strGrpID);
			searchGrpTagMap.put("ioType", data[4].split("\\|")[i]);
			searchGrpTagMap.put("menuNo", strMenuNo);
			searchGrpTagMap.put("address", data[5].split("\\|")[i]);
			searchGrpTagMap.put("iHogi", data[1].split("\\|")[i]);
			searchGrpTagMap.put("grpHogi", gHogi);
			searchGrpTagMap.put("grpNo", grpNo);
			searchGrpTagMap.put("ioBit", data[6].split("\\|")[i]);
			if( gHogi.equals(hogi) ) {
				searchGrpTagMap.put("hogi", data[1].split("\\|")[i]);
			} else {
				if( "3".equals(data[1].split("\\|")[i]) ) {
					searchGrpTagMap.put("hogi", "4");
				} else {
					searchGrpTagMap.put("hogi", "3");
				}
			}
			searchGrpTagMap.put("tagNo", strTagNo);
			searchGrpTagMap.put("saveCoreChk", data[9].split("\\|")[i]);
			searchGrpTagMap.put("descr", data[3].split("\\|")[i]);
			
			if( "X".equalsIgnoreCase(data[2].split("\\|")[i]) ) {
				searchGrpTagMap.put("xyGubun", "Y");
				strTmpiSeq = dccTrendService.selectISeqTagDccSearch(searchGrpTagMap);
			} else {
				searchGrpTagMap.put("xyGubun", "X");
				strTmpiSeq = dccTrendService.selectISeqTagDccSearch(searchGrpTagMap);
			}

			if( "X".equalsIgnoreCase(gXYGubun) ) {
				searchGrpTagMap.put("iSeq", data[0].split("\\|")[i]);
			} else {
				searchGrpTagMap.put("iSeq", strTmpiSeq == null ? "0" : strTmpiSeq);
			}
			if( "AI".equalsIgnoreCase(data[4].split("\\|")[i]) && ("2010".equals(data[5].split("\\|")[i]) || "2140".equals(data[5].split("\\|")[i])) ) {
				searchGrpTagMap.put("maxVal", Double.parseDouble(data[8].split("\\|")[i])*0.0081+"");
				searchGrpTagMap.put("minVal", Double.parseDouble(data[7].split("\\|")[i])*0.0081+"");
			} else {
				searchGrpTagMap.put("maxVal", data[8].split("\\|")[i]);
				searchGrpTagMap.put("minVal", data[7].split("\\|")[i]);
			}
			if( "Y".equalsIgnoreCase(gXYGubun) ) {
				searchGrpTagMap.put("ySeq", data[0].split("\\|")[i]);
			} else {
				searchGrpTagMap.put("ySeq", strTmpiSeq == null ? "0" : strTmpiSeq);
			}
			if( "AI".equalsIgnoreCase(data[4].split("\\|")[i]) && ("2010".equals(data[5].split("\\|")[i]) || "2140".equals(data[5].split("\\|")[i])) ) {
				searchGrpTagMap.put("yMaxVal", Double.parseDouble(data[8].split("\\|")[i])*0.0081+"");
				searchGrpTagMap.put("yMinVal", Double.parseDouble(data[7].split("\\|")[i])*0.0081+"");
			} else {
				searchGrpTagMap.put("yMaxVal", data[8].split("\\|")[i]);
				searchGrpTagMap.put("yMinVal", data[7].split("\\|")[i]);
			}
			
			//System.out.println(searchGrpTagMap);
			
			nRes += dccTrendService.insertGrpTag(searchGrpTagMap);
			
			//System.out.println(i+"::"+strISeqMod.split("\\|")[i]+"::"+strHogiMod.split("\\|")[i]+"::"+strXyGubunMod.split("\\|")[i]+"::"+strDescrMod.split("\\|")[i]
			//					+"::"+strIoTypeMod.split("\\|")[i]+"::"+strAddressMod.split("\\|")[i]+"::"+strIoBitMod.split("\\|")[i]+"::"+strMinValMod.split("\\|")[i]
			//					+"::"+strMaxValMod.split("\\|")[i]+"::"+strSaveCoreMod.split("\\|")[i]);
		}
		
		return nRes;
	}
	
	public void GroupSave222(DccSearchTrend dccSearchTrend) {
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
    	if( dccSearchTrend.getIoType() == null || "".equals(dccSearchTrend.getIoType()) ) dccSearchTrend.setIoType("AI");
    	if( dccSearchTrend.getIoBit() == null || "".equals(dccSearchTrend.getIoBit()) ) dccSearchTrend.setIoBit("0");
    	if( dccSearchTrend.getSaveCore() == null ) dccSearchTrend.setSaveCore("0");
    	if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		
		//if(dccSearchTrend.getsUGrpNo() != null && !dccSearchTrend.getsUGrpNo().isEmpty()) {
    	
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? "Trend" : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "21" : dccSearchTrend.getsMenuNo();
    	String strUGrpName = dccSearchTrend.getsUGrpName() == null ? "" : dccSearchTrend.getsUGrpName();
    	String strUGrpNo = "";
    	String strType = dccSearchTrend.getType() == null ? "" : dccSearchTrend.getType();
    	String strISeqMod = dccSearchTrend.getiSeqMod() == null ? "" : dccSearchTrend.getiSeqMod();
    	String strHogiMod = dccSearchTrend.getHogiMod() == null ? "" : dccSearchTrend.getHogiMod();
    	String strXyGubunMod = dccSearchTrend.getXyGubunMod() == null ? "" : dccSearchTrend.getXyGubunMod();
    	String strDescrMod = dccSearchTrend.getDescrMod() == null ? "" : dccSearchTrend.getDescrMod();
    	String strIoTypeMod = dccSearchTrend.getIoTypeMod() == null ? "" : dccSearchTrend.getIoTypeMod();
    	String strAddressMod = dccSearchTrend.getAddressMod() == null ? "" : dccSearchTrend.getAddressMod();
    	String strIoBitMod = dccSearchTrend.getIoBitMod() == null ? "" : dccSearchTrend.getIoBitMod();
    	String strMinValMod = dccSearchTrend.getMinValMod() == null ? "" : dccSearchTrend.getMinValMod();
    	String strMaxValMod = dccSearchTrend.getMaxValMod() == null ? "" : dccSearchTrend.getMaxValMod();
    	String strSaveCoreMod = dccSearchTrend.getSaveCoreMod() == null ? "" : dccSearchTrend.getSaveCoreMod();
    	
    	Map searchMapGrpNm = new HashMap();
		searchMapGrpNm.put("grpID", strGrpID);
		searchMapGrpNm.put("dive", "D");
		searchMapGrpNm.put("menuNo", strMenuNo);
		searchMapGrpNm.put("uGrpName", strUGrpName);
		//searchMapGrpNm.put("uGrpNo", strUGrpNo);
		
		String manageType = "";
		
		int nRes = 0;
		if( "N".equalsIgnoreCase(strType) ) {
			nRes = 1;
			strUGrpNo = "1";
			searchMapGrpNm.put("gGrpNo", strUGrpNo);
			
			//manageType = "numericalFixed";
		} else if( "I".equalsIgnoreCase(strType) ) {
			if( dccSearchTrend.getsUGrpNo() == null || "".equals(dccSearchTrend.getsUGrpNo()) ) {
				strUGrpNo = altCommonService.selectMaxGrpName(searchMapGrpNm).get(0) == null ? "" : altCommonService.selectMaxGrpName(searchMapGrpNm).get(0).get("MAX_UGrpNo").toString();
				if( strUGrpNo == null || "".equals(strUGrpNo) ) {
					if( "22".equals(strMenuNo) || "24".equals(strMenuNo) || "32".equals(strMenuNo) ) {
						strUGrpNo = "101";
					} else {
						strUGrpNo = "0";
					}
				}
				
				strUGrpNo = (Integer.parseInt(strUGrpNo)+1)+"";
			} else {
				String strUGrpNo222 = altCommonService.selectMaxGrpName(searchMapGrpNm).get(0) == null ? "0" : altCommonService.selectMaxGrpName(searchMapGrpNm).get(0).get("MAX_UGrpNo").toString();
				
				strUGrpNo = Integer.parseInt(dccSearchTrend.getsUGrpNo()) >= Integer.parseInt(strUGrpNo222) ? dccSearchTrend.getsUGrpNo() : strUGrpNo222;
			}
			searchMapGrpNm.put("gGrpNo", strUGrpNo);
			
			nRes = altTrendService.addGroupTrendFixed(searchMapGrpNm);
		} else {
			strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "0" : dccSearchTrend.getsUGrpNo();
			
			searchMapGrpNm.put("gGrpNo", strUGrpNo);
			
			nRes = altTrendService.updateGroupTrendFixed(searchMapGrpNm);
		}
		
		String[] data = new String[10];
		data[0] = strISeqMod;
		data[1] = strHogiMod;
		data[2] = strXyGubunMod;
		data[3] = strDescrMod;
		data[4] = strIoTypeMod;
		data[5] = strAddressMod;
		data[6] = strIoBitMod;
		data[7] = strMinValMod;
		data[8] = strMaxValMod;
		data[9] = strSaveCoreMod;
		
		nRes = Mst_GrpTagSave222(strGrpID, strMenuNo, strUGrpNo, dccSearchTrend.getsXYGubun(), dccSearchTrend.getsHogi(), dccSearchTrend.getsHogi(), data);
		
		if( nRes > 0 ) {
			String tmpHogi = "3".equals(dccSearchTrend.getsHogi()) ? "4" : "3";
			nRes = Mst_GrpTagSave222(strGrpID, strMenuNo, strUGrpNo, dccSearchTrend.getsXYGubun(), tmpHogi, dccSearchTrend.getsHogi(), data);
		}
	}
	
	public int Mst_GrpTagSave222(String strGrpID, String strMenuNo, String grpNo, String gXYGubun, String gHogi, String hogi, String[] data) {
		int nRes = 0;

		Map delMap = new HashMap();
		delMap.put("gubun", "D");
		delMap.put("id", strGrpID);
		delMap.put("grpHOGI", gHogi);
		delMap.put("menuNo", strMenuNo);
		delMap.put("grpNo", grpNo);
		
		altTrendService.deleteGrpTag(delMap);
		
		for( int i=0;i<data[0].split("\\|").length;i++ ) {
			String strTagNo = i+"";
			String strTmpiSeq = "0";
			
			Map searchGrpTagMap = new HashMap();
			searchGrpTagMap.put("gubun", "D");
			searchGrpTagMap.put("id", strGrpID);
			searchGrpTagMap.put("ioType", data[4].split("\\|")[i]);
			searchGrpTagMap.put("menuNo", strMenuNo);
			searchGrpTagMap.put("address", data[5].split("\\|")[i]);
			searchGrpTagMap.put("iHogi", data[1].split("\\|")[i]);
			searchGrpTagMap.put("grpHogi", gHogi);
			searchGrpTagMap.put("grpNo", grpNo);
			searchGrpTagMap.put("ioBit", data[6].split("\\|")[i]);
			if( gHogi.equals(hogi) ) {
				searchGrpTagMap.put("hogi", data[1].split("\\|")[i]);
			} else {
				if( "3".equals(data[1].split("\\|")[i]) ) {
					searchGrpTagMap.put("hogi", "4");
				} else {
					searchGrpTagMap.put("hogi", "3");
				}
			}
			searchGrpTagMap.put("tagNo", strTagNo);
			searchGrpTagMap.put("saveCoreChk", data[9].split("\\|")[i]);
			searchGrpTagMap.put("descr", data[3].split("\\|")[i]);
			
			if( "X".equalsIgnoreCase(data[2].split("\\|")[i]) ) {
				searchGrpTagMap.put("xyGubun", "Y");
				strTmpiSeq = altTrendService.selectISeqTagDccSearch(searchGrpTagMap);
			} else {
				searchGrpTagMap.put("xyGubun", "X");
				strTmpiSeq = altTrendService.selectISeqTagDccSearch(searchGrpTagMap);
			}

			if( "X".equalsIgnoreCase(gXYGubun) ) {
				searchGrpTagMap.put("iSeq", data[0].split("\\|")[i]);
			} else {
				searchGrpTagMap.put("iSeq", strTmpiSeq == null ? "0" : strTmpiSeq);
			}
			if( "AI".equalsIgnoreCase(data[4].split("\\|")[i]) && ("2010".equals(data[5].split("\\|")[i]) || "2140".equals(data[5].split("\\|")[i])) ) {
				searchGrpTagMap.put("maxVal", Double.parseDouble(data[8].split("\\|")[i])*0.0081+"");
				searchGrpTagMap.put("minVal", Double.parseDouble(data[7].split("\\|")[i])*0.0081+"");
			} else {
				searchGrpTagMap.put("maxVal", data[8].split("\\|")[i]);
				searchGrpTagMap.put("minVal", data[7].split("\\|")[i]);
			}
			if( "Y".equalsIgnoreCase(gXYGubun) ) {
				searchGrpTagMap.put("ySeq", data[0].split("\\|")[i]);
			} else {
				searchGrpTagMap.put("ySeq", strTmpiSeq == null ? "0" : strTmpiSeq);
			}
			if( "AI".equalsIgnoreCase(data[4].split("\\|")[i]) && ("2010".equals(data[5].split("\\|")[i]) || "2140".equals(data[5].split("\\|")[i])) ) {
				searchGrpTagMap.put("yMaxVal", Double.parseDouble(data[8].split("\\|")[i])*0.0081+"");
				searchGrpTagMap.put("yMinVal", Double.parseDouble(data[7].split("\\|")[i])*0.0081+"");
			} else {
				searchGrpTagMap.put("yMaxVal", data[8].split("\\|")[i]);
				searchGrpTagMap.put("yMinVal", data[7].split("\\|")[i]);
			}
			
			//System.out.println(searchGrpTagMap);
			
			nRes += altTrendService.insertGrpTag(searchGrpTagMap);
			
			//System.out.println(i+"::"+strISeqMod.split("\\|")[i]+"::"+strHogiMod.split("\\|")[i]+"::"+strXyGubunMod.split("\\|")[i]+"::"+strDescrMod.split("\\|")[i]
			//					+"::"+strIoTypeMod.split("\\|")[i]+"::"+strAddressMod.split("\\|")[i]+"::"+strIoBitMod.split("\\|")[i]+"::"+strMinValMod.split("\\|")[i]
			//					+"::"+strMaxValMod.split("\\|")[i]+"::"+strSaveCoreMod.split("\\|")[i]);
		}
		
		return nRes;
	}
	
	@RequestMapping(value="addGroup", method= { RequestMethod.POST})
	@ResponseBody
	public ModelAndView addGroup(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("############ addGroup");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
    	if( dccSearchTrend.getsMenuNo() == null || "".equals(dccSearchTrend.getsMenuNo()) ) dccSearchTrend.setsMenuNo("22");
    	if( dccSearchTrend.getGroupNameList() == null ) dccSearchTrend.setGroupNameList("");
    	if( dccSearchTrend.getGroupNoList() == null ) dccSearchTrend.setGroupNoList("");
    	if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("");
    	if( dccSearchTrend.getRefID() == null ) dccSearchTrend.setRefID("");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));

    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "22" : dccSearchTrend.getsMenuNo();
    	String strGrpID = dccSearchTrend.getsGrpID();
    	String strFixed = dccSearchTrend.getFixed() == null ? "S" : dccSearchTrend.getFixed();
    	String setGrpNo = "";
    	
    	if( !"".equals(dccSearchTrend.getsGrpID()) && !"".equals(dccSearchTrend.getRefID()) ) {
			
			//if(dccSearchTrend.getsUGrpNo() != null && !dccSearchTrend.getsUGrpNo().isEmpty()) {
	    	
	    	String[] strGroupNameList = dccSearchTrend.getGroupNameList() == null ? "".split("\\|") : dccSearchTrend.getGroupNameList().split("\\|");
	    	String[] strGroupNoList = dccSearchTrend.getGroupNoList() == null ? "".split("\\|") : dccSearchTrend.getGroupNoList().split("\\|");
	    	String strRefID = dccSearchTrend.getRefID();
	    	
	    	if( strMenuNo.indexOf(",") > -1 ) strMenuNo = strMenuNo.substring(0,strMenuNo.indexOf(","));
	    	if( strGrpID.indexOf(",") > -1 ) strGrpID = strGrpID.substring(0,strGrpID.indexOf(","));
	    	if( strRefID.indexOf(",") > -1 ) strRefID = strRefID.substring(0,strRefID.indexOf(","));
	    	
	    	for( int i=0;i<strGroupNoList.length;i++ ) {
	    		if( !"".equals(strGroupNoList[i]) ) {
			    	Map searchMapGrpNm = new HashMap();
					searchMapGrpNm.put("gMenuNo", strMenuNo);
					searchMapGrpNm.put("gID", strGrpID);
					searchMapGrpNm.put("refID", strRefID);
					searchMapGrpNm.put("grpName", strGroupNameList[i].trim().replaceAll("#amp;", "&"));
					searchMapGrpNm.put("gGrpNo", strGroupNoList[i]);
					
					String uGrpNo221 = dccTrendService.selectMaxUGrpNo(searchMapGrpNm);
					String uGrpNo222 = altTrendService.selectMaxUGrpNo(searchMapGrpNm);
					
					String uGrpNo = Integer.parseInt(uGrpNo221) >= Integer.parseInt(uGrpNo222) ? uGrpNo221 : uGrpNo222; 
					
					searchMapGrpNm.put("uGrpNo", uGrpNo);
					
					int nRes = dccTrendService.addGroupTrendSpare(searchMapGrpNm);
					
					if( nRes > 0 ) {
						dccTrendService.addGrpTagTrendSpare(searchMapGrpNm);
					}
					
					int nRes222 = altTrendService.addGroupTrendSpare(searchMapGrpNm);
					
					if( nRes222 > 0 ) {
						altTrendService.addGrpTagTrendSpare(searchMapGrpNm);
					}
	    		}
	    	}
    	}
    	
    	Map searchNewMap = new HashMap();
    	searchNewMap.put("gMenuNo", strMenuNo);
    	searchNewMap.put("gID", strGrpID);
    	int nGrpNo = Integer.parseInt(dccTrendService.selectMaxUGrpNo(searchNewMap))-1;
    	
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
    	
		dccSearchTrend.setsMenuNo(strMenuNo);
		dccSearchTrend.setsGrpID(strGrpID);
		dccSearchTrend.setFixed(strFixed);
		getTrendData(dccSearchTrend,mav,userInfo);
		
		mav.addObject("ManageType","addGroup");
		mav.addObject("UpdatedGrpNo",nGrpNo);

		mav.addObject("BaseSearch", dccSearchTrend);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value="delGroup", method= { RequestMethod.POST})
	@ResponseBody
	public ModelAndView delGroup(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("############ delGroup");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
    	if( dccSearchTrend.getsMenuNo() == null || "".equals(dccSearchTrend.getsMenuNo()) ) dccSearchTrend.setsMenuNo("22");
    	if( dccSearchTrend.getGroupNoList() == null ) dccSearchTrend.setGroupNoList("");
    	if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("");
    	if( dccSearchTrend.getRefID() == null ) dccSearchTrend.setRefID("");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
    	
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "22" : dccSearchTrend.getsMenuNo();
    	String strFixed = dccSearchTrend.getFixed() == null ? "S" : dccSearchTrend.getFixed();
    	String strGrpID = dccSearchTrend.getsGrpID();
    	if( !"".equals(dccSearchTrend.getsGrpID()) && !"".equals(dccSearchTrend.getRefID()) ) {
		
			//if(dccSearchTrend.getsUGrpNo() != null && !dccSearchTrend.getsUGrpNo().isEmpty()) {
	    	
	    	String[] strGroupNoList = dccSearchTrend.getGroupNoList() == null ? "".split("\\|") : dccSearchTrend.getGroupNoList().split("\\|");
	    	
	    	if( strMenuNo.indexOf(",") > -1 ) strMenuNo = strMenuNo.substring(0,strMenuNo.indexOf(","));
	    	if( strGrpID.indexOf(",") > -1 ) strGrpID = strGrpID.substring(0,strGrpID.indexOf(","));
	    	
	    	for( int i=0;i<strGroupNoList.length;i++ ) {
	    		if( !"".equals(strGroupNoList[i]) ) {
			    	Map searchMapGrpNm = new HashMap();
					searchMapGrpNm.put("gMenuNo", strMenuNo);
					searchMapGrpNm.put("gID", strGrpID);
					searchMapGrpNm.put("uGrpNo", strGroupNoList[i]);
					
					int nRes = dccTrendService.delGroupTrendSpare(searchMapGrpNm);
					
					if( nRes > 0 ) {
						dccTrendService.delGrpTagTrendSpare(searchMapGrpNm);
					}
					
					int nRes222 = altTrendService.delGroupTrendSpare(searchMapGrpNm);
					
					if( nRes222 > 0 ) {
						altTrendService.delGrpTagTrendSpare(searchMapGrpNm);
					}
	    		}
	    	}
    	}

    	Map searchNewMap = new HashMap();
    	searchNewMap.put("gMenuNo", strMenuNo);
    	searchNewMap.put("gID", strGrpID);
    	int nGrpNo = Integer.parseInt(dccTrendService.selectMaxUGrpNo(searchNewMap))-1;
    	
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
    	
		dccSearchTrend.setsMenuNo(strMenuNo);
		dccSearchTrend.setsGrpID(strGrpID);
		dccSearchTrend.setFixed(strFixed);
		getTrendData(dccSearchTrend,mav,userInfo);
		
		mav.addObject("ManageType","delGroup");
		mav.addObject("UpdatedGrpNo",nGrpNo);

		mav.addObject("BaseSearch", dccSearchTrend);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value="upGroup", method= { RequestMethod.POST})
	@ResponseBody
	public ModelAndView upGroup(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("############ upGroup");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
    	if( dccSearchTrend.getsMenuNo() == null || "".equals(dccSearchTrend.getsMenuNo()) ) dccSearchTrend.setsMenuNo("22");
    	if( dccSearchTrend.getGroupNameList() == null ) dccSearchTrend.setGroupNameList("");
    	if( dccSearchTrend.getGroupNoList() == null ) dccSearchTrend.setGroupNoList("");
    	if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("");
    	if( dccSearchTrend.getRefID() == null ) dccSearchTrend.setRefID("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
    	
    	String strGroupNameUp = dccSearchTrend.getGroupNameList() == null ? "" : dccSearchTrend.getGroupNameList().split("\\|")[1];
    	String strGroupNameDown = dccSearchTrend.getGroupNameList() == null ? "" : dccSearchTrend.getGroupNameList().split("\\|")[0];
    	String strGroupNoUp = dccSearchTrend.getGroupNoList() == null ? "" : dccSearchTrend.getGroupNoList().split("\\|")[1];
    	String strGroupNoDown = dccSearchTrend.getGroupNoList() == null ? "" : dccSearchTrend.getGroupNoList().split("\\|")[0];
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "22" : dccSearchTrend.getsMenuNo();
    	String strFixed = dccSearchTrend.getFixed() == null ? "S" : dccSearchTrend.getFixed();
    	String strGrpID = dccSearchTrend.getsGrpID();
    	String strRefID = dccSearchTrend.getRefID();
    	
    	if( !"".equals(dccSearchTrend.getsGrpID()) && !"".equals(dccSearchTrend.getRefID()) ) {
			
			//if(dccSearchTrend.getsUGrpNo() != null && !dccSearchTrend.getsUGrpNo().isEmpty()) {
	    	
	    	if( strMenuNo.indexOf(",") > -1 ) strMenuNo = strMenuNo.substring(0,strMenuNo.indexOf(","));
	    	if( strGrpID.indexOf(",") > -1 ) strGrpID = strGrpID.substring(0,strGrpID.indexOf(","));
	    	if( strRefID.indexOf(",") > -1 ) strRefID = strRefID.substring(0,strRefID.indexOf(","));
	    	
    		if( !"".equals(strGroupNoUp) && !"".equals(strGroupNoDown) ) {
		    	Map searchMapGrpDown = new HashMap();
		    	searchMapGrpDown.put("menuNo", strMenuNo);
				searchMapGrpDown.put("gMenuNo", strMenuNo);
		    	searchMapGrpDown.put("grpID", strGrpID);
		    	searchMapGrpDown.put("gGrpNo", strGroupNoDown);
		    	searchMapGrpDown.put("gID", strGrpID);
		    	searchMapGrpDown.put("uGrpNo", strGroupNoDown);
				
				List<Map> tagInfoDown = dccTrendService.selectGrpTagTrendSpare(searchMapGrpDown);
				//System.out.println(tagInfoDown);
				//System.out.println(strGroupNameUp+" >> "+strGroupNameUp.trim().replaceAll("#amp;", "&"));
				searchMapGrpDown.put("uGrpName", strGroupNameUp.trim().replaceAll("#amp;", "&"));
				
				dccTrendService.updateGroupTrendFixed(searchMapGrpDown);
				
				dccTrendService.delGrpTagTrendSpare(searchMapGrpDown);
				
				Map searchMapGrpUp = new HashMap();
				searchMapGrpUp.put("menuNo", strMenuNo);
				searchMapGrpUp.put("gMenuNo", strMenuNo);
				searchMapGrpUp.put("grpID", strGrpID);
				searchMapGrpUp.put("gGrpNo", strGroupNoUp);
		    	searchMapGrpUp.put("gID", strGrpID);
		    	searchMapGrpUp.put("uGrpNo", strGroupNoUp);

				List<Map> tagInfoUp = dccTrendService.selectGrpTagTrendSpare(searchMapGrpUp);
				//System.out.println(tagInfoUp);
				//System.out.println(strGroupNameDown+" >> "+strGroupNameDown.trim().replaceAll("#amp;", "&"));
				searchMapGrpUp.put("uGrpName", strGroupNameDown.trim().replaceAll("#amp;", "&"));
				
				dccTrendService.updateGroupTrendFixed(searchMapGrpUp);
				
				dccTrendService.delGrpTagTrendSpare(searchMapGrpUp);
				
				for( int di=0;di<tagInfoDown.size();di++ ) {
					String downData = tagInfoDown.get(di).get("Gubun").toString() + "','"
									+ tagInfoDown.get(di).get("ID").toString() + "','"
									+ tagInfoDown.get(di).get("GrpHogi").toString() + "','"
									+ tagInfoDown.get(di).get("MenuNo").toString() + "','"
									+ strGroupNoUp + "','"
									+ tagInfoDown.get(di).get("Hogi").toString() + "','"
									+ tagInfoDown.get(di).get("TagNo").toString() + "','"
									+ tagInfoDown.get(di).get("ISeq").toString() + "','"
									+ tagInfoDown.get(di).get("MaxVal").toString() + "','"
									+ tagInfoDown.get(di).get("MinVal").toString() + "','"
									+ tagInfoDown.get(di).get("YSeq").toString() + "','"
									+ tagInfoDown.get(di).get("YMaxVal").toString() + "','"
									+ tagInfoDown.get(di).get("YMinVal").toString() + "','"
									+ tagInfoDown.get(di).get("SaveCoreChk").toString() + "','"
									+ tagInfoDown.get(di).get("Descr").toString();
					
					Map downTmp = new HashMap();
					downTmp.put("data", downData);
					
					dccTrendService.insertGrpTagTrendSpare(downTmp);
				}
				
				for( int ui=0;ui<tagInfoUp.size();ui++ ) {
					String upData = tagInfoUp.get(ui).get("Gubun").toString() + "','"
								  + tagInfoUp.get(ui).get("ID").toString() + "','"
								  + tagInfoUp.get(ui).get("GrpHogi").toString() + "','"
								  + tagInfoUp.get(ui).get("MenuNo").toString() + "','"
								  + strGroupNoDown + "','"
								  + tagInfoUp.get(ui).get("Hogi").toString() + "','"
								  + tagInfoUp.get(ui).get("TagNo").toString() + "','"
								  + tagInfoUp.get(ui).get("ISeq").toString() + "','"
								  + tagInfoUp.get(ui).get("MaxVal").toString() + "','"
								  + tagInfoUp.get(ui).get("MinVal").toString() + "','"
								  + tagInfoUp.get(ui).get("YSeq").toString() + "','"
								  + tagInfoUp.get(ui).get("YMaxVal").toString() + "','"
								  + tagInfoUp.get(ui).get("YMinVal").toString() + "','"
								  + tagInfoUp.get(ui).get("SaveCoreChk").toString() + "','"
								  + tagInfoUp.get(ui).get("Descr").toString();
					
					Map upTmp = new HashMap();
					upTmp.put("data", upData);
					
					dccTrendService.insertGrpTagTrendSpare(upTmp);
				}
				
				Map searchMapGrpDown222 = new HashMap();
		    	searchMapGrpDown222.put("menuNo", strMenuNo);
				searchMapGrpDown222.put("gMenuNo", strMenuNo);
		    	searchMapGrpDown222.put("grpID", strGrpID);
		    	searchMapGrpDown222.put("gGrpNo", strGroupNoDown);
		    	searchMapGrpDown222.put("gID", strGrpID);
		    	searchMapGrpDown222.put("uGrpNo", strGroupNoDown);
				
				List<Map> tagInfoDown222 = altTrendService.selectGrpTagTrendSpare(searchMapGrpDown222);
				//System.out.println(tagInfoDown222);
				//System.out.println(strGroupNameUp+" >> "+strGroupNameUp.trim().replaceAll("#amp;", "&"));
				searchMapGrpDown222.put("uGrpName", strGroupNameUp.trim().replaceAll("#amp;", "&"));
				
				altTrendService.updateGroupTrendFixed(searchMapGrpDown222);
				
				altTrendService.delGrpTagTrendSpare(searchMapGrpDown222);
				
				Map searchMapGrpUp222 = new HashMap();
				searchMapGrpUp222.put("menuNo", strMenuNo);
				searchMapGrpUp222.put("gMenuNo", strMenuNo);
				searchMapGrpUp222.put("grpID", strGrpID);
				searchMapGrpUp222.put("gGrpNo", strGroupNoUp);
		    	searchMapGrpUp222.put("gID", strGrpID);
		    	searchMapGrpUp222.put("uGrpNo", strGroupNoUp);

				List<Map> tagInfoUp222 = altTrendService.selectGrpTagTrendSpare(searchMapGrpUp222);
				//System.out.println(tagInfoUp222);
				//System.out.println(strGroupNameDown+" >> "+strGroupNameDown.trim().replaceAll("#amp;", "&"));
				searchMapGrpUp222.put("uGrpName", strGroupNameDown.trim().replaceAll("#amp;", "&"));
				
				altTrendService.updateGroupTrendFixed(searchMapGrpUp222);
				
				altTrendService.delGrpTagTrendSpare(searchMapGrpUp222);
				
				for( int di=0;di<tagInfoDown222.size();di++ ) {
					String downData = tagInfoDown222.get(di).get("Gubun").toString() + "','"
									+ tagInfoDown222.get(di).get("ID").toString() + "','"
									+ tagInfoDown222.get(di).get("GrpHogi").toString() + "','"
									+ tagInfoDown222.get(di).get("MenuNo").toString() + "','"
									+ strGroupNoUp + "','"
									+ tagInfoDown222.get(di).get("Hogi").toString() + "','"
									+ tagInfoDown222.get(di).get("TagNo").toString() + "','"
									+ tagInfoDown222.get(di).get("ISeq").toString() + "','"
									+ tagInfoDown222.get(di).get("MaxVal").toString() + "','"
									+ tagInfoDown222.get(di).get("MinVal").toString() + "','"
									+ tagInfoDown222.get(di).get("YSeq").toString() + "','"
									+ tagInfoDown222.get(di).get("YMaxVal").toString() + "','"
									+ tagInfoDown222.get(di).get("YMinVal").toString() + "','"
									+ tagInfoDown222.get(di).get("SaveCoreChk").toString() + "','"
									+ tagInfoDown222.get(di).get("Descr").toString();
					
					Map downTmp222 = new HashMap();
					downTmp222.put("data", downData);
					
					altTrendService.insertGrpTagTrendSpare(downTmp222);
				}
				
				for( int ui=0;ui<tagInfoUp222.size();ui++ ) {
					String upData = tagInfoUp222.get(ui).get("Gubun").toString() + "','"
								  + tagInfoUp222.get(ui).get("ID").toString() + "','"
								  + tagInfoUp222.get(ui).get("GrpHogi").toString() + "','"
								  + tagInfoUp222.get(ui).get("MenuNo").toString() + "','"
								  + strGroupNoDown + "','"
								  + tagInfoUp222.get(ui).get("Hogi").toString() + "','"
								  + tagInfoUp222.get(ui).get("TagNo").toString() + "','"
								  + tagInfoUp222.get(ui).get("ISeq").toString() + "','"
								  + tagInfoUp222.get(ui).get("MaxVal").toString() + "','"
								  + tagInfoUp222.get(ui).get("MinVal").toString() + "','"
								  + tagInfoUp222.get(ui).get("YSeq").toString() + "','"
								  + tagInfoUp222.get(ui).get("YMaxVal").toString() + "','"
								  + tagInfoUp222.get(ui).get("YMinVal").toString() + "','"
								  + tagInfoUp222.get(ui).get("SaveCoreChk").toString() + "','"
								  + tagInfoUp222.get(ui).get("Descr").toString();
					
					Map upTmp222 = new HashMap();
					upTmp222.put("data", upData);
					
					altTrendService.insertGrpTagTrendSpare(upTmp222);
				}
    		}
    	}
    	
		dccSearchTrend.setsMenuNo(strMenuNo);
		dccSearchTrend.setsGrpID(strGrpID);
		dccSearchTrend.setFixed(strFixed);
		getTrendData(dccSearchTrend,mav,userInfo);
		
		mav.addObject("ManageType","upGroup");
		mav.addObject("selGrpNo",strGroupNoUp);

		mav.addObject("BaseSearch", dccSearchTrend);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value="downGroup", method= { RequestMethod.POST})
	@ResponseBody
	public ModelAndView downGroup(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("############ downGroup");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
    	if( dccSearchTrend.getsMenuNo() == null || "".equals(dccSearchTrend.getsMenuNo()) ) dccSearchTrend.setsMenuNo("22");
    	if( dccSearchTrend.getGroupNameList() == null ) dccSearchTrend.setGroupNameList("");
    	if( dccSearchTrend.getGroupNoList() == null ) dccSearchTrend.setGroupNoList("");
    	if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("");
    	if( dccSearchTrend.getRefID() == null ) dccSearchTrend.setRefID("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
    	
    	String strGroupNameUp = dccSearchTrend.getGroupNameList() == null ? "" : dccSearchTrend.getGroupNameList().split("\\|")[1];
    	String strGroupNameDown = dccSearchTrend.getGroupNameList() == null ? "" : dccSearchTrend.getGroupNameList().split("\\|")[0];
    	String strGroupNoUp = dccSearchTrend.getGroupNoList() == null ? "" : dccSearchTrend.getGroupNoList().split("\\|")[1];
    	String strGroupNoDown = dccSearchTrend.getGroupNoList() == null ? "" : dccSearchTrend.getGroupNoList().split("\\|")[0];
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "22" : dccSearchTrend.getsMenuNo();
    	String strFixed = dccSearchTrend.getFixed() == null ? "S" : dccSearchTrend.getFixed();
    	String strGrpID = dccSearchTrend.getsGrpID();
    	String strRefID = dccSearchTrend.getRefID();
    	
    	if( !"".equals(dccSearchTrend.getsGrpID()) && !"".equals(dccSearchTrend.getRefID()) ) {
			
			//if(dccSearchTrend.getsUGrpNo() != null && !dccSearchTrend.getsUGrpNo().isEmpty()) {
	    	
	    	if( strMenuNo.indexOf(",") > -1 ) strMenuNo = strMenuNo.substring(0,strMenuNo.indexOf(","));
	    	if( strGrpID.indexOf(",") > -1 ) strGrpID = strGrpID.substring(0,strGrpID.indexOf(","));
	    	if( strRefID.indexOf(",") > -1 ) strRefID = strRefID.substring(0,strRefID.indexOf(","));
	    	
    		if( !"".equals(strGroupNoUp) && !"".equals(strGroupNoDown) ) {
		    	Map searchMapGrpDown = new HashMap();
		    	searchMapGrpDown.put("menuNo", strMenuNo);
				searchMapGrpDown.put("gMenuNo", strMenuNo);
		    	searchMapGrpDown.put("grpID", strGrpID);
		    	searchMapGrpDown.put("gGrpNo", strGroupNoDown);
		    	searchMapGrpDown.put("gID", strGrpID);
		    	searchMapGrpDown.put("uGrpNo", strGroupNoDown);
				searchMapGrpDown.put("uGrpName", strGroupNameUp.trim().replaceAll("#amp;", "&"));
				
				Map searchMapGrpUp = new HashMap();
				searchMapGrpUp.put("menuNo", strMenuNo);
				searchMapGrpUp.put("gMenuNo", strMenuNo);
				searchMapGrpUp.put("grpID", strGrpID);
				searchMapGrpUp.put("gGrpNo", strGroupNoUp);
		    	searchMapGrpUp.put("gID", strGrpID);
		    	searchMapGrpUp.put("uGrpNo", strGroupNoUp);
				searchMapGrpUp.put("uGrpName", strGroupNameDown.trim().replaceAll("#amp;", "&"));
				
				List<Map> tagInfoDown = dccTrendService.selectGrpTagTrendSpare(searchMapGrpDown);
				//System.out.println(tagInfoDown);
				
				dccTrendService.updateGroupTrendFixed(searchMapGrpUp);
				
				dccTrendService.delGrpTagTrendSpare(searchMapGrpDown);

				List<Map> tagInfoUp = dccTrendService.selectGrpTagTrendSpare(searchMapGrpUp);
				//System.out.println(tagInfoUp);
				
				dccTrendService.updateGroupTrendFixed(searchMapGrpDown);
				
				dccTrendService.delGrpTagTrendSpare(searchMapGrpUp);
				
				for( int ui=0;ui<tagInfoUp.size();ui++ ) {
					String upData = tagInfoUp.get(ui).get("Gubun").toString() + "','"
								  + tagInfoUp.get(ui).get("ID").toString() + "','"
								  + tagInfoUp.get(ui).get("GrpHogi").toString() + "','"
								  + tagInfoUp.get(ui).get("MenuNo").toString() + "','"
								  + strGroupNoDown + "','"
								  + tagInfoUp.get(ui).get("Hogi").toString() + "','"
								  + tagInfoUp.get(ui).get("TagNo").toString() + "','"
								  + tagInfoUp.get(ui).get("ISeq").toString() + "','"
								  + tagInfoUp.get(ui).get("MaxVal").toString() + "','"
								  + tagInfoUp.get(ui).get("MinVal").toString() + "','"
								  + tagInfoUp.get(ui).get("YSeq").toString() + "','"
								  + tagInfoUp.get(ui).get("YMaxVal").toString() + "','"
								  + tagInfoUp.get(ui).get("YMinVal").toString() + "','"
								  + tagInfoUp.get(ui).get("SaveCoreChk").toString() + "','"
								  + tagInfoUp.get(ui).get("Descr").toString();
					
					Map upTmp = new HashMap();
					upTmp.put("data", upData);
					
					dccTrendService.insertGrpTagTrendSpare(upTmp);
				}
				
				for( int di=0;di<tagInfoDown.size();di++ ) {
					String downData = tagInfoDown.get(di).get("Gubun").toString() + "','"
									+ tagInfoDown.get(di).get("ID").toString() + "','"
									+ tagInfoDown.get(di).get("GrpHogi").toString() + "','"
									+ tagInfoDown.get(di).get("MenuNo").toString() + "','"
									+ strGroupNoUp + "','"
									+ tagInfoDown.get(di).get("Hogi").toString() + "','"
									+ tagInfoDown.get(di).get("TagNo").toString() + "','"
									+ tagInfoDown.get(di).get("ISeq").toString() + "','"
									+ tagInfoDown.get(di).get("MaxVal").toString() + "','"
									+ tagInfoDown.get(di).get("MinVal").toString() + "','"
									+ tagInfoDown.get(di).get("YSeq").toString() + "','"
									+ tagInfoDown.get(di).get("YMaxVal").toString() + "','"
									+ tagInfoDown.get(di).get("YMinVal").toString() + "','"
									+ tagInfoDown.get(di).get("SaveCoreChk").toString() + "','"
									+ tagInfoDown.get(di).get("Descr").toString();
					
					Map downTmp = new HashMap();
					downTmp.put("data", downData);
					
					dccTrendService.insertGrpTagTrendSpare(downTmp);
				}
				
				Map searchMapGrpDown222 = new HashMap();
		    	searchMapGrpDown222.put("menuNo", strMenuNo);
				searchMapGrpDown222.put("gMenuNo", strMenuNo);
		    	searchMapGrpDown222.put("grpID", strGrpID);
		    	searchMapGrpDown222.put("gGrpNo", strGroupNoDown);
		    	searchMapGrpDown222.put("gID", strGrpID);
		    	searchMapGrpDown222.put("uGrpNo", strGroupNoDown);
				searchMapGrpDown222.put("uGrpName", strGroupNameUp.trim().replaceAll("#amp;", "&"));
				
				Map searchMapGrpUp222 = new HashMap();
				searchMapGrpUp222.put("menuNo", strMenuNo);
				searchMapGrpUp222.put("gMenuNo", strMenuNo);
				searchMapGrpUp222.put("grpID", strGrpID);
				searchMapGrpUp222.put("gGrpNo", strGroupNoUp);
		    	searchMapGrpUp222.put("gID", strGrpID);
		    	searchMapGrpUp222.put("uGrpNo", strGroupNoUp);
				searchMapGrpUp222.put("uGrpName", strGroupNameDown.trim().replaceAll("#amp;", "&"));
				
				List<Map> tagInfoDown222 = altTrendService.selectGrpTagTrendSpare(searchMapGrpDown222);
				//System.out.println(tagInfoDown222);
				
				altTrendService.updateGroupTrendFixed(searchMapGrpUp222);
				
				altTrendService.delGrpTagTrendSpare(searchMapGrpDown222);

				List<Map> tagInfoUp222 = altTrendService.selectGrpTagTrendSpare(searchMapGrpUp222);
				//System.out.println(tagInfoUp222);
				
				altTrendService.updateGroupTrendFixed(searchMapGrpDown222);
				
				altTrendService.delGrpTagTrendSpare(searchMapGrpUp222);
				
				for( int ui=0;ui<tagInfoUp222.size();ui++ ) {
					String upData = tagInfoUp222.get(ui).get("Gubun").toString() + "','"
								  + tagInfoUp222.get(ui).get("ID").toString() + "','"
								  + tagInfoUp222.get(ui).get("GrpHogi").toString() + "','"
								  + tagInfoUp222.get(ui).get("MenuNo").toString() + "','"
								  + strGroupNoDown + "','"
								  + tagInfoUp222.get(ui).get("Hogi").toString() + "','"
								  + tagInfoUp222.get(ui).get("TagNo").toString() + "','"
								  + tagInfoUp222.get(ui).get("ISeq").toString() + "','"
								  + tagInfoUp222.get(ui).get("MaxVal").toString() + "','"
								  + tagInfoUp222.get(ui).get("MinVal").toString() + "','"
								  + tagInfoUp222.get(ui).get("YSeq").toString() + "','"
								  + tagInfoUp222.get(ui).get("YMaxVal").toString() + "','"
								  + tagInfoUp222.get(ui).get("YMinVal").toString() + "','"
								  + tagInfoUp222.get(ui).get("SaveCoreChk").toString() + "','"
								  + tagInfoUp222.get(ui).get("Descr").toString();
					
					Map upTmp222 = new HashMap();
					upTmp222.put("data", upData);
					
					altTrendService.insertGrpTagTrendSpare(upTmp222);
				}
				
				for( int di=0;di<tagInfoDown222.size();di++ ) {
					String downData = tagInfoDown222.get(di).get("Gubun").toString() + "','"
									+ tagInfoDown222.get(di).get("ID").toString() + "','"
									+ tagInfoDown222.get(di).get("GrpHogi").toString() + "','"
									+ tagInfoDown222.get(di).get("MenuNo").toString() + "','"
									+ strGroupNoUp + "','"
									+ tagInfoDown222.get(di).get("Hogi").toString() + "','"
									+ tagInfoDown222.get(di).get("TagNo").toString() + "','"
									+ tagInfoDown222.get(di).get("ISeq").toString() + "','"
									+ tagInfoDown222.get(di).get("MaxVal").toString() + "','"
									+ tagInfoDown222.get(di).get("MinVal").toString() + "','"
									+ tagInfoDown222.get(di).get("YSeq").toString() + "','"
									+ tagInfoDown222.get(di).get("YMaxVal").toString() + "','"
									+ tagInfoDown222.get(di).get("YMinVal").toString() + "','"
									+ tagInfoDown222.get(di).get("SaveCoreChk").toString() + "','"
									+ tagInfoDown222.get(di).get("Descr").toString();
					
					Map downTmp222 = new HashMap();
					downTmp222.put("data", downData);
					
					altTrendService.insertGrpTagTrendSpare(downTmp222);
				}
    		}
    	}
    	
		dccSearchTrend.setsMenuNo(strMenuNo);
		dccSearchTrend.setsGrpID(strGrpID);
		dccSearchTrend.setFixed(strFixed);
		getTrendData(dccSearchTrend,mav,userInfo);
		
		mav.addObject("ManageType","upGroup");
		mav.addObject("selGrpNo",strGroupNoDown);

		mav.addObject("BaseSearch", dccSearchTrend);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping(value="updateGroup", method= { RequestMethod.POST})
	@ResponseBody
	public ModelAndView updateGroup(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("############ updateGroup");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
    	if( dccSearchTrend.getsMenuNo() == null || "".equals(dccSearchTrend.getsMenuNo()) ) dccSearchTrend.setsMenuNo("22");
    	if( dccSearchTrend.getGroupNameList() == null ) dccSearchTrend.setGroupNameList("");
    	if( dccSearchTrend.getGroupNoList() == null ) dccSearchTrend.setGroupNoList("");
    	if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("");
    	if( dccSearchTrend.getType() == null ) dccSearchTrend.setType("0");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");

    	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
    	
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "22" : dccSearchTrend.getsMenuNo();
    	String strFixed = dccSearchTrend.getFixed() == null ? "S" : dccSearchTrend.getFixed();
    	String strGrpID = dccSearchTrend.getsGrpID();
    	String strType = dccSearchTrend.getType();
    	
    	if( !"".equals(dccSearchTrend.getsGrpID()) && !"".equals(dccSearchTrend.getRefID()) ) {
			
			//if(dccSearchTrend.getsUGrpNo() != null && !dccSearchTrend.getsUGrpNo().isEmpty()) {
	    	
	    	if( strMenuNo.indexOf(",") > -1 ) strMenuNo = strMenuNo.substring(0,strMenuNo.indexOf(","));
	    	if( strGrpID.indexOf(",") > -1 ) strGrpID = strGrpID.substring(0,strGrpID.indexOf(","));
	    	if( strType.indexOf(",") > -1 ) strType = strType.substring(0,strType.indexOf(","));
	    	
	    	if( "0".equals(strType) ) {
	        	String strGroupName = dccSearchTrend.getGroupNameList() == null ? "" : dccSearchTrend.getGroupNameList();
	        	String strGroupNo = dccSearchTrend.getGroupNoList() == null ? "" : dccSearchTrend.getGroupNoList();

	    		if( !"".equals(strGroupNo) && !"".equals(strGroupName) ) {
			    	Map searchMapGrp = new HashMap();
			    	searchMapGrp.put("menuNo", strMenuNo);
			    	searchMapGrp.put("grpID", strGrpID);
			    	searchMapGrp.put("gGrpNo", strGroupNo);
			    	searchMapGrp.put("uGrpName", strGroupName.trim().replaceAll("#amp;", "&"));
			    	
					dccTrendService.updateGroupTrendFixed(searchMapGrp);
					
					altTrendService.updateGroupTrendFixed(searchMapGrp);
	    		}
	    		
	    		mav.addObject("ManageType","updateGroup");
	    		mav.addObject("selGrpNo",strGroupNo);
	    	} else {
	        	String strGroupNameNew = dccSearchTrend.getGroupNameList() == null ? "" : dccSearchTrend.getGroupNameList().split("\\|")[1];
	        	String strGroupNameOrg = dccSearchTrend.getGroupNameList() == null ? "" : dccSearchTrend.getGroupNameList().split("\\|")[0];
	        	String strGroupNoNew = dccSearchTrend.getGroupNoList() == null ? "" : dccSearchTrend.getGroupNoList().split("\\|")[1];
	        	String strGroupNoOrg = dccSearchTrend.getGroupNoList() == null ? "" : dccSearchTrend.getGroupNoList().split("\\|")[0];
	        	
	    		if( !"".equals(strGroupNoNew) && !"".equals(strGroupNoOrg) ) {
			    	Map searchMapGrpOrg = new HashMap();
			    	searchMapGrpOrg.put("menuNo", strMenuNo);
			    	searchMapGrpOrg.put("gMenuNo", strMenuNo);
			    	searchMapGrpOrg.put("grpID", strGrpID);
			    	searchMapGrpOrg.put("gGrpNo", strGroupNoOrg);
			    	searchMapGrpOrg.put("gID", strGrpID);
			    	searchMapGrpOrg.put("uGrpNo", strGroupNoOrg);
			    	searchMapGrpOrg.put("uGrpName", strGroupNameNew.trim().replaceAll("#amp;", "&"));
					
					Map searchMapGrpNew = new HashMap();
					searchMapGrpNew.put("menuNo", strMenuNo);
					searchMapGrpNew.put("gMenuNo", strMenuNo);
					searchMapGrpNew.put("grpID", strGrpID);
					searchMapGrpNew.put("gGrpNo", strGroupNoNew);
					searchMapGrpNew.put("gID", strGrpID);
					searchMapGrpNew.put("uGrpNo", strGroupNoNew);
					searchMapGrpNew.put("uGrpName", strGroupNameOrg.trim().replaceAll("#amp;", "&"));
					
					List<Map> tagInfoDown = dccTrendService.selectGrpTagTrendSpare(searchMapGrpOrg);
					//System.out.println(tagInfoDown);
					
					dccTrendService.updateGroupTrendFixed(searchMapGrpNew);
					
					dccTrendService.delGrpTagTrendSpare(searchMapGrpOrg);
	
					List<Map> tagInfoUp = dccTrendService.selectGrpTagTrendSpare(searchMapGrpNew);
					//System.out.println(tagInfoUp);
					
					dccTrendService.updateGroupTrendFixed(searchMapGrpOrg);
					
					dccTrendService.delGrpTagTrendSpare(searchMapGrpNew);
					
					for( int ui=0;ui<tagInfoUp.size();ui++ ) {
						String upData = tagInfoUp.get(ui).get("Gubun").toString() + "','"
									  + tagInfoUp.get(ui).get("ID").toString() + "','"
									  + tagInfoUp.get(ui).get("GrpHogi").toString() + "','"
									  + tagInfoUp.get(ui).get("MenuNo").toString() + "','"
									  + strGroupNoOrg + "','"
									  + tagInfoUp.get(ui).get("Hogi").toString() + "','"
									  + tagInfoUp.get(ui).get("TagNo").toString() + "','"
									  + tagInfoUp.get(ui).get("ISeq").toString() + "','"
									  + tagInfoUp.get(ui).get("MaxVal").toString() + "','"
									  + tagInfoUp.get(ui).get("MinVal").toString() + "','"
									  + tagInfoUp.get(ui).get("YSeq").toString() + "','"
									  + tagInfoUp.get(ui).get("YMaxVal").toString() + "','"
									  + tagInfoUp.get(ui).get("YMinVal").toString() + "','"
									  + tagInfoUp.get(ui).get("SaveCoreChk").toString() + "','"
									  + tagInfoUp.get(ui).get("Descr").toString();
						
						Map upTmp = new HashMap();
						upTmp.put("data", upData);
						
						dccTrendService.insertGrpTagTrendSpare(upTmp);
					}
					
					for( int di=0;di<tagInfoDown.size();di++ ) {
						String downData = tagInfoDown.get(di).get("Gubun").toString() + "','"
										+ tagInfoDown.get(di).get("ID").toString() + "','"
										+ tagInfoDown.get(di).get("GrpHogi").toString() + "','"
										+ tagInfoDown.get(di).get("MenuNo").toString() + "','"
										+ strGroupNoNew + "','"
										+ tagInfoDown.get(di).get("Hogi").toString() + "','"
										+ tagInfoDown.get(di).get("TagNo").toString() + "','"
										+ tagInfoDown.get(di).get("ISeq").toString() + "','"
										+ tagInfoDown.get(di).get("MaxVal").toString() + "','"
										+ tagInfoDown.get(di).get("MinVal").toString() + "','"
										+ tagInfoDown.get(di).get("YSeq").toString() + "','"
										+ tagInfoDown.get(di).get("YMaxVal").toString() + "','"
										+ tagInfoDown.get(di).get("YMinVal").toString() + "','"
										+ tagInfoDown.get(di).get("SaveCoreChk").toString() + "','"
										+ tagInfoDown.get(di).get("Descr").toString();
						
						Map downTmp = new HashMap();
						downTmp.put("data", downData);
						
						dccTrendService.insertGrpTagTrendSpare(downTmp);
					}
					
					Map searchMapGrpOrg222 = new HashMap();
			    	searchMapGrpOrg222.put("menuNo", strMenuNo);
			    	searchMapGrpOrg222.put("gMenuNo", strMenuNo);
			    	searchMapGrpOrg222.put("grpID", strGrpID);
			    	searchMapGrpOrg222.put("gGrpNo", strGroupNoOrg);
			    	searchMapGrpOrg222.put("gID", strGrpID);
			    	searchMapGrpOrg222.put("uGrpNo", strGroupNoOrg);
			    	searchMapGrpOrg222.put("uGrpName", strGroupNameNew.trim().replaceAll("#amp;", "&"));
					
					Map searchMapGrpNew222 = new HashMap();
					searchMapGrpNew222.put("menuNo", strMenuNo);
					searchMapGrpNew222.put("gMenuNo", strMenuNo);
					searchMapGrpNew222.put("grpID", strGrpID);
					searchMapGrpNew222.put("gGrpNo", strGroupNoNew);
					searchMapGrpNew222.put("gID", strGrpID);
					searchMapGrpNew222.put("uGrpNo", strGroupNoNew);
					searchMapGrpNew222.put("uGrpName", strGroupNameOrg.trim().replaceAll("#amp;", "&"));
					
					List<Map> tagInfoDown222 = altTrendService.selectGrpTagTrendSpare(searchMapGrpOrg222);
					//System.out.println(tagInfoDown222);
					
					altTrendService.updateGroupTrendFixed(searchMapGrpNew222);
					
					altTrendService.delGrpTagTrendSpare(searchMapGrpOrg222);
	
					List<Map> tagInfoUp222 = altTrendService.selectGrpTagTrendSpare(searchMapGrpNew222);
					//System.out.println(tagInfoUp222);
					
					altTrendService.updateGroupTrendFixed(searchMapGrpOrg222);
					
					altTrendService.delGrpTagTrendSpare(searchMapGrpNew222);
					
					for( int ui=0;ui<tagInfoUp222.size();ui++ ) {
						String upData = tagInfoUp222.get(ui).get("Gubun").toString() + "','"
									  + tagInfoUp222.get(ui).get("ID").toString() + "','"
									  + tagInfoUp222.get(ui).get("GrpHogi").toString() + "','"
									  + tagInfoUp222.get(ui).get("MenuNo").toString() + "','"
									  + strGroupNoOrg + "','"
									  + tagInfoUp222.get(ui).get("Hogi").toString() + "','"
									  + tagInfoUp222.get(ui).get("TagNo").toString() + "','"
									  + tagInfoUp222.get(ui).get("ISeq").toString() + "','"
									  + tagInfoUp222.get(ui).get("MaxVal").toString() + "','"
									  + tagInfoUp222.get(ui).get("MinVal").toString() + "','"
									  + tagInfoUp222.get(ui).get("YSeq").toString() + "','"
									  + tagInfoUp222.get(ui).get("YMaxVal").toString() + "','"
									  + tagInfoUp222.get(ui).get("YMinVal").toString() + "','"
									  + tagInfoUp222.get(ui).get("SaveCoreChk").toString() + "','"
									  + tagInfoUp222.get(ui).get("Descr").toString();
						
						Map upTmp222 = new HashMap();
						upTmp222.put("data", upData);
						
						altTrendService.insertGrpTagTrendSpare(upTmp222);
					}
					
					for( int di=0;di<tagInfoDown222.size();di++ ) {
						String downData = tagInfoDown222.get(di).get("Gubun").toString() + "','"
										+ tagInfoDown222.get(di).get("ID").toString() + "','"
										+ tagInfoDown222.get(di).get("GrpHogi").toString() + "','"
										+ tagInfoDown222.get(di).get("MenuNo").toString() + "','"
										+ strGroupNoNew + "','"
										+ tagInfoDown222.get(di).get("Hogi").toString() + "','"
										+ tagInfoDown222.get(di).get("TagNo").toString() + "','"
										+ tagInfoDown222.get(di).get("ISeq").toString() + "','"
										+ tagInfoDown222.get(di).get("MaxVal").toString() + "','"
										+ tagInfoDown222.get(di).get("MinVal").toString() + "','"
										+ tagInfoDown222.get(di).get("YSeq").toString() + "','"
										+ tagInfoDown222.get(di).get("YMaxVal").toString() + "','"
										+ tagInfoDown222.get(di).get("YMinVal").toString() + "','"
										+ tagInfoDown222.get(di).get("SaveCoreChk").toString() + "','"
										+ tagInfoDown222.get(di).get("Descr").toString();
						
						Map downTmp222 = new HashMap();
						downTmp222.put("data", downData);
						
						altTrendService.insertGrpTagTrendSpare(downTmp222);
					}
	    		}
	    		
	    		mav.addObject("ManageType","updateGroup");
	    		mav.addObject("selGrpNo",strGroupNoNew);
	    	}
    	}
    	
		dccSearchTrend.setsMenuNo(strMenuNo);
		dccSearchTrend.setsGrpID(strGrpID);
		dccSearchTrend.setFixed(strFixed);
		getTrendData(dccSearchTrend,mav,userInfo);

		mav.addObject("BaseSearch", dccSearchTrend);
    	mav.addObject("UserInfo", userInfo);

		return mav;
	}
	
	@RequestMapping("tfExcelExport")
	public void tfExcelExport(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
			
			LocalDateTime endDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? LocalDateTime.now() : convDtm(dccSearchTrend.getEndDate(),true);
	    	LocalDateTime startDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? endDate.minusMinutes(10) : convDtm(dccSearchTrend.getStartDate(),true);
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

			String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
			
			if( member.getHogi() == null ) {
		    	if( dccSearchTrend.getHogiHeader() != null ) {
		    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
		    	} else {
		    		if( dccSearchTrend.getHogi() == null ) {
		    			if( "4".equals(conHogi) ) {
		    				dccSearchTrend.setsHogi("4");
		    			} else {
		    				dccSearchTrend.setsHogi("3");
		    			}
		    		}
		    	}
			} else {
				dccSearchTrend.setsHogi(member.getHogi());
			}
			if( member.getXyGubun() == null ) {
		    	if( dccSearchTrend.getXyHeader() != null ) {
		    		//if( dccSearchTrend.getXyGubun() == null ) {
		    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
		    		//}
		    	} else {
		    		if( dccSearchTrend.getXyGubun() == null ) {
		    			dccSearchTrend.setsXYGubun("X");
		    		} else {
		    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
		    		}
		    	}
			} else {
				dccSearchTrend.setsXYGubun(member.getXyGubun());
			}
			if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
			if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
			if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
			if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
			if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
			if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
			if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("Trend");
			if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
			//if( dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf),-650));
			//if( dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ) dccSearchTrend.setEndDate(endDate.format(dtf));
			
			dccSearchTrend.setStartDate(startDate.format(dtf));
			dccSearchTrend.setEndDate(endDate.format(dtf));
			String strUGrpNo = dccSearchTrend.getsUGrpNo();
			String strMenuNo = dccSearchTrend.getsMenuNo();
			String strGrpID = dccSearchTrend.getsGrpID();
			String strGap = dccSearchTrend.getTxtTimeGap();
			if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
			if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
			if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
			if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
		    	
			dccSearchTrend.setMenuName(this.menuName);
			
			String strDive = dccSearchTrend.getsDive();
			
			Map searchMap = new HashMap();
			searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
			searchMap.put("hogi",dccSearchTrend.getsHogi());
			searchMap.put("dive",dccSearchTrend.getsDive());
			searchMap.put("grpID",dccSearchTrend.getsGrpID());
			searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
			searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
			//searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? addDate("s",now.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
			//searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? now.format(dtf)+".000" : dccSearchTrend.getEndDate());
			searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? startDate.format(dtf) : dccSearchTrend.getStartDate());
			searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? endDate.format(dtf) : dccSearchTrend.getEndDate());
			
			List<TrendTagDccInfo> dccGrpTagList = new ArrayList();
			Map dccVal = new HashMap();
			List<Map> grpTagList = new ArrayList();
			if( "D".equalsIgnoreCase(strDive) ) {
				dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
				dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);
			} else if( "B".equalsIgnoreCase(strDive) ) {
				grpTagList = dccTrendService.getGrpTag(searchMap);
			}
			
			List<Map> LblInfoList = getGrpTagListE(dccSearchTrend,conHogi);
			List<Map> arrTrendData = getTrendViewE(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, conHogi);
        		
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
		
		if( "".equals(date) ) {
			return null;
		} else if( date.split(" ").length < 2 ) {
			if( date.split(" ")[0].indexOf("-") > -1 ) {
				pDate = date.split(" ")[0].split("-");
			} else if(date.split(" ")[0].indexOf("/") > -1 ) { 
				pDate = date.split(" ")[0].split("/");
			}
			LocalDateTime ldt = LocalDateTime.of(Integer.parseInt(pDate[0]),Integer.parseInt(pDate[1]),Integer.parseInt(pDate[2]),0,0,0);
			
			return ldt;
		} else {
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
	}
	
	/*@RequestMapping("realtimetrendspare")
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
			
			//userInfo.setHogi(dccSearchTrend.getsHogi());
			//userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			
		}

		return mav;
	}*/
	
	@RequestMapping(value="tagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView tagFind(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		String getHogiHeader = dccSearchTrend.getHogiHeader();
		String getXyHeader = dccSearchTrend.getXyHeader();
		
		if( getHogiHeader.indexOf(",") > -1 ) getHogiHeader = getHogiHeader.substring(0,getHogiHeader.indexOf(",")).trim();
		if( getXyHeader.indexOf(",") > -1 ) getXyHeader = getXyHeader.substring(0,getXyHeader.indexOf(",")).trim();
		
		String strFindData = dccSearchTrend.getFindData() == null ? "" : dccSearchTrend.getFindData();
		String strChkOpt1 = dccSearchTrend.getChkOpt1() == null ? "" : dccSearchTrend.getChkOpt1();
		String strChkOpt2 = dccSearchTrend.getChkOpt2() == null ? "" : dccSearchTrend.getChkOpt2();
		if( strFindData.indexOf(",") > -1 ) strFindData = strFindData.substring(0,strFindData.indexOf(",")).trim();
		if( strChkOpt1.indexOf(",") > -1 ) strChkOpt1 = strChkOpt1.substring(0,strChkOpt1.indexOf(",")).trim();
		if( strChkOpt2.indexOf(",") > -1 ) strChkOpt2 = strChkOpt2.substring(0,strChkOpt2.indexOf(",")).trim();
		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		}
    	}
    	if( getXyHeader != null && !"".equals(getXyHeader) ) {
    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun(getXyHeader);
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getType() == null ) dccSearchTrend.setType("0");
		if( dccSearchTrend.getTagHogi() == null ) dccSearchTrend.setTagHogi("3");
		if( dccSearchTrend.getTagIOType() == null ) dccSearchTrend.setTagIOType("AI");
		if( dccSearchTrend.getFindData() == null ) dccSearchTrend.setFindData("");
		if( dccSearchTrend.getbAll() == null ) dccSearchTrend.setbAll("0");
		if( dccSearchTrend.getChkOpt1() == null ) dccSearchTrend.setChkOpt1("0");
		if( dccSearchTrend.getChkOpt2() == null ) dccSearchTrend.setChkOpt2("1");
	    
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		
		Map searchMap = new HashMap();
		searchMap.put("type", dccSearchTrend.getType());
		searchMap.put("tagHogi", dccSearchTrend.getTagHogi());
		searchMap.put("tagIOType", dccSearchTrend.getTagIOType());
		searchMap.put("findData", strFindData);
		searchMap.put("bAll", dccSearchTrend.getbAll());
		searchMap.put("chkOpt1", strChkOpt1);
		searchMap.put("chkOpt2", strChkOpt2);
		
		/*System.out.println("type :: "+searchMap.get("type"));
		System.out.println("tagHogi :: "+searchMap.get("tagHogi"));
		System.out.println("tagIOType :: "+searchMap.get("tagIOType"));
		System.out.println("findData :: "+searchMap.get("findData"));
		System.out.println("bAll :: "+searchMap.get("bAll"));
		System.out.println("chkOpt1 :: "+searchMap.get("chkOpt1"));
		System.out.println("chkOpt2 :: "+searchMap.get("chkOpt2"));*/
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			List<Map> tagInfoList = new ArrayList();
			tagInfoList = dccTrendService.selectTrendTagSearch(searchMap);
			
			mav.addObject("TagInfoList",tagInfoList);
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
		}
		
		return mav;
	}
	
	@RequestMapping(value="saveRange", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView saveRange(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		String getHogiHeader = dccSearchTrend.getHogiHeader();
		String getXyHeader = dccSearchTrend.getXyHeader();
		
		if( getHogiHeader.indexOf(",") > -1 ) getHogiHeader = getHogiHeader.substring(0,getHogiHeader.indexOf(",")).trim();
		if( getXyHeader.indexOf(",") > -1 ) getXyHeader = getXyHeader.substring(0,getXyHeader.indexOf(",")).trim();
	
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		}
    	}
    	if( getXyHeader != null && !"".equals(getXyHeader) ) {
    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun(getXyHeader);
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		if( dccSearchTrend.getgID() == null ) dccSearchTrend.setgID("");
	    
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		
		int result3 = 0;
		int result4 = 0;
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			String[] rangeList = dccSearchTrend.getRangeList().toString().split("\\$SEP\\$");
			//String[] rangeDetail = rangeList[0].split("||");
			
			for( int la=0;la<rangeList.length;la++ ) {
				//System.out.println(la+" >> "+rangeList[la]);
				Map searchMap = new HashMap();
				searchMap.put("gID", dccSearchTrend.getgID());
				searchMap.put("gMenuNo", dccSearchTrend.getsMenuNo());
				searchMap.put("gGrpNo", dccSearchTrend.getsUGrpNo());
				//System.out.println(la+" gID >> "+dccSearchTrend.getgID());
				//System.out.println(la+" gMenuNo >> "+dccSearchTrend.getsMenuNo());
				//System.out.println(la+" sUGrpNo >> "+dccSearchTrend.getsUGrpNo());
				
				String[] rangeDetail = rangeList[la].split("\\|");
				for( int lb=0;lb<rangeDetail.length;lb++ ) {
					//System.out.println(lb+" >> "+rangeDetail[lb]);
					switch( lb ) {
						case 0:
							break;
						case 1:
							searchMap.put("tagNo", rangeDetail[1]);
							break;
						case 2:
							searchMap.put("hogi", rangeDetail[2]);
							break;
						case 3:
							searchMap.put("grpHogi", rangeDetail[3]);
							break;
						case 4:
							searchMap.put("maxVal", rangeDetail[4]);
							break;
						case 5:
							searchMap.put("minVal", rangeDetail[5]);
							break;
					}
				}
				
				//System.out.println(searchMap);
				result3 += dccTrendService.updateTrendRange(searchMap);
			}
			
			for( int la=0;la<rangeList.length;la++ ) {
				Map searchMap = new HashMap();
				searchMap.put("gID", dccSearchTrend.getgID());
				searchMap.put("gMenuNo", dccSearchTrend.getsMenuNo());
				searchMap.put("gGrpNo", dccSearchTrend.getsUGrpNo());
				
				String[] rangeDetail = rangeList[la].split("\\|");
				for( int lb=0;lb<rangeDetail.length;lb++ ) {
					switch( lb ) {
						case 0:
							break;
						case 1:
							searchMap.put("tagNo", rangeDetail[1]);
							break;
						case 2:
							searchMap.put("hogi", "3".equals(rangeDetail[2]) ? "4" : rangeDetail[2]);
							break;
						case 3:
							searchMap.put("grpHogi", "3".equals(rangeDetail[3]) ? "4" : rangeDetail[3]);
							break;
						case 4:
							searchMap.put("maxVal", rangeDetail[4]);
							break;
						case 5:
							searchMap.put("minVal", rangeDetail[5]);
							break;
					}
				}
				
				result4 += dccTrendService.updateTrendRange(searchMap);
			}
			
			if( result3 == rangeList.length && result4 == rangeList.length ) {
				mav.addObject("UdpateRangeResult","1");
			} else {
				mav.addObject("UdpateRangeResult","0");
			}
//			List<Map> groupGetList = new ArrayList();
//			if( dccSearchTrend.getgID() != null && !"".equals(dccSearchTrend.getgID()) ) {
//				groupGetList = dccTrendService.selectGroupGetTrendSpare(searchMap);
//			}
//			
//			mav.addObject("GroupGetList",groupGetList);
//			mav.addObject("GroupGetType",dccSearchTrend.getType() == null ? "0" : dccSearchTrend.getType());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
		}
		
		return mav;
	}
	
	@RequestMapping("realtimetrendspare")
	public ModelAndView realtimetrendspare(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ realtimetrendspare");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);

		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
		if( userInfo.getHogi() == null ) {
	    	if( dccSearchTrend.getHogiHeader() != null ) {
	    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null ) {
	    			if( "4".equals(conHogi) ) {
	    				dccSearchTrend.setsHogi("4");
	    			} else {
	    				dccSearchTrend.setsHogi("3");
	    			}
	    		}
	    	}
		} else {
			dccSearchTrend.setsHogi(userInfo.getHogi());
		}
		if( userInfo.getXyGubun() == null ) {
	    	if( dccSearchTrend.getXyHeader() != null && !"".equals(dccSearchTrend.getXyHeader()) ) {
	    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    		//}
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun("X");
	    		} else {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
	    		}
	    	}
		} else {
			dccSearchTrend.setsXYGubun(userInfo.getXyGubun());
		}
		
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("S");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("22");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			getTrendData(dccSearchTrend,mav,mberInfo);
			//getGrpTagList(dccSearchTrend,mav);
			
			//changeGrpName(dccSearchTrend,mav);
	    	
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			//mav.addObject("UserInfo",mberInfo);
			
		}

		return mav;
	}
	
	@RequestMapping("tsExcelExport")
	public void tsExcelExport(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
	    	MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
			
			LocalDateTime endDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? LocalDateTime.now() : convDtm(dccSearchTrend.getEndDate(),true);
	    	LocalDateTime startDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? endDate.minusMinutes(10) : convDtm(dccSearchTrend.getStartDate(),true);
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

			String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
			
			if( userInfo.getHogi() == null ) {
		    	if( dccSearchTrend.getHogiHeader() != null ) {
		    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
		    	} else {
		    		if( dccSearchTrend.getHogi() == null ) {
		    			if( "4".equals(conHogi) ) {
		    				dccSearchTrend.setsHogi("4");
		    			} else {
		    				dccSearchTrend.setsHogi("3");
		    			}
		    		}
		    	}
			} else {
				dccSearchTrend.setsHogi(userInfo.getHogi());
			}
			if( userInfo.getXyGubun() == null ) {
		    	if( dccSearchTrend.getXyHeader() != null ) {
		    		//if( dccSearchTrend.getXyGubun() == null ) {
		    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
		    		//}
		    	} else {
		    		if( dccSearchTrend.getXyGubun() == null ) {
		    			dccSearchTrend.setsXYGubun("X");
		    		} else {
		    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
		    		}
		    	}
			} else {
				dccSearchTrend.setsXYGubun(userInfo.getXyGubun());
			}
	    	
			if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("S");
			if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
			if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
			if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
			if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID(userInfo.getId());
			if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("22");
			if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
			if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
			//if( dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf),-650));
			//if( dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ) dccSearchTrend.setEndDate(endDate.format(dtf));
			
			dccSearchTrend.setStartDate(startDate.format(dtf));
			dccSearchTrend.setEndDate(endDate.format(dtf));
			String strUGrpNo = dccSearchTrend.getsUGrpNo();
			String strMenuNo = dccSearchTrend.getsMenuNo();
			String strGrpID = dccSearchTrend.getsGrpID();
			String strGap = dccSearchTrend.getTxtTimeGap();
			if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
			if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
			if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
			if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
		    	
			dccSearchTrend.setMenuName(this.menuName);
			
			String strDive = dccSearchTrend.getsDive();
			
			Map searchMap = new HashMap();
			searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
			searchMap.put("hogi",dccSearchTrend.getsHogi());
			searchMap.put("dive",dccSearchTrend.getsDive());
			searchMap.put("grpID",dccSearchTrend.getsGrpID());
			searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
			searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
			//searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? addDate("s",now.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
			//searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? now.format(dtf)+".000" : dccSearchTrend.getEndDate());
			searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? startDate.format(dtf) : dccSearchTrend.getStartDate());
			searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? endDate.format(dtf) : dccSearchTrend.getEndDate());
			
			List<TrendTagDccInfo> dccGrpTagList = new ArrayList();
			Map dccVal = new HashMap();
			List<Map> grpTagList = new ArrayList();
			if( "D".equalsIgnoreCase(strDive) ) {
				dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
				dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);
			} else if( "B".equalsIgnoreCase(strDive) ) {
				grpTagList = dccTrendService.getGrpTag(searchMap);
			}
			
			List<Map> LblInfoList = getGrpTagListE(dccSearchTrend,conHogi);
			List<Map> arrTrendData = getTrendViewE(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, conHogi);
        		
    		excelHelperUtil.alarmTSExcelDownload(request, response, "trend_", LblInfoList, arrTrendData);
        	
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
    }
	
	@RequestMapping(value="groupGet", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView groupGet(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		String getHogiHeader = dccSearchTrend.getHogiHeader();
		String getXyHeader = dccSearchTrend.getXyHeader();
		
		if( getHogiHeader.indexOf(",") > -1 ) getHogiHeader = getHogiHeader.substring(0,getHogiHeader.indexOf(",")).trim();
		if( getXyHeader.indexOf(",") > -1 ) getXyHeader = getXyHeader.substring(0,getXyHeader.indexOf(",")).trim();

		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		}
    	}
    	if( getXyHeader != null && !"".equals(getXyHeader) ) {
    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun(getXyHeader);
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("22");
		if( dccSearchTrend.getgID() == null ) dccSearchTrend.setgID("");
	    
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		
		Map searchMap = new HashMap();
		searchMap.put("gID", dccSearchTrend.getgID());
		searchMap.put("gMenuNo", dccSearchTrend.getsMenuNo());
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			List<Map> groupGetList = new ArrayList();
			if( dccSearchTrend.getgID() != null && !"".equals(dccSearchTrend.getgID()) ) {
				groupGetList = dccTrendService.selectGroupGetTrendSpare(searchMap);
			}
			
			mav.addObject("GroupGetList",groupGetList);
			mav.addObject("GroupGetType",dccSearchTrend.getType() == null ? "0" : dccSearchTrend.getType());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
		}
		
		return mav;
	}
	
	/*@RequestMapping("ftamtrend")
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
			
			//userInfo.setHogi(dccSearchTrend.getsHogi());
			//userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			
		}

		return mav;
	}*/
	
	@RequestMapping("ftamtrend")
	public ModelAndView ftamtrend(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ ftamtrend");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if( userInfo.getHogi() == null ) {
			if( dccSearchTrend.getHogiHeader() != null && !"".equals(dccSearchTrend.getHogiHeader()) ) {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) {
	    			if( commonConstant.getUrl().indexOf("10.135.101.222") > -1 ) {
	    				dccSearchTrend.setsHogi("4");
	    			} else {
	    				dccSearchTrend.setsHogi("3");
	    			}
	    		} else {
	    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
	    		}
	    	}
		} else {
			dccSearchTrend.setsHogi(userInfo.getHogi());
		}
		if( userInfo.getXyGubun() == null ) {
	    	if( dccSearchTrend.getXyHeader() != null && !"".equals(dccSearchTrend.getXyHeader()) ) {
	    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    		//}
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun("X");
	    		} else {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
	    		}
	    	}
		} else {
			dccSearchTrend.setsXYGubun(userInfo.getXyGubun());
		}
		
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("H");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			getTrendData(dccSearchTrend,mav,mberInfo);
			//getGrpTagList(dccSearchTrend,mav);
			
			//changeGrpName(dccSearchTrend,mav);
	    	
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			//mav.addObject("UserInfo",mberInfo);
			
		}

		return mav;
	}
	
	@RequestMapping("ftamExcelExport")
	public void ftamExcelExport(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
	    	MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
			
			LocalDateTime endDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? LocalDateTime.now() : convDtm(dccSearchTrend.getEndDate(),true);
	    	LocalDateTime startDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? endDate.minusMinutes(10) : convDtm(dccSearchTrend.getStartDate(),true);
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

			String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
			
			if( userInfo.getHogi() == null ) {
		    	if( dccSearchTrend.getHogiHeader() != null ) {
		    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
		    	} else {
		    		if( dccSearchTrend.getHogi() == null ) {
		    			if( "4".equals(conHogi) ) {
		    				dccSearchTrend.setsHogi("4");
		    			} else {
		    				dccSearchTrend.setsHogi("3");
		    			}
		    		}
		    	}
			} else {
				dccSearchTrend.setsHogi(userInfo.getHogi());
			}
			if( userInfo.getXyGubun() == null ) {
		    	if( dccSearchTrend.getXyHeader() != null ) {
		    		//if( dccSearchTrend.getXyGubun() == null ) {
		    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
		    		//}
		    	} else {
		    		if( dccSearchTrend.getXyGubun() == null ) {
		    			dccSearchTrend.setsXYGubun("X");
		    		} else {
		    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
		    		}
		    	}
			} else {
				dccSearchTrend.setsXYGubun(userInfo.getXyGubun());
			}
	    	
			if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("H");
			if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
			if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
			if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
			if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("Trend");
			if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("21");
			if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
			if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
			//if( dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf),-650));
			//if( dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ) dccSearchTrend.setEndDate(endDate.format(dtf));
			
			dccSearchTrend.setStartDate(startDate.format(dtf));
			dccSearchTrend.setEndDate(endDate.format(dtf));
			String strUGrpNo = dccSearchTrend.getsUGrpNo();
			String strMenuNo = dccSearchTrend.getsMenuNo();
			String strGrpID = dccSearchTrend.getsGrpID();
			String strGap = dccSearchTrend.getTxtTimeGap();
			if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
			if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
			if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
			if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
		    	
			dccSearchTrend.setMenuName(this.menuName);
			
			String strDive = dccSearchTrend.getsDive();
			
			Map searchMap = new HashMap();
			searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
			searchMap.put("hogi",dccSearchTrend.getsHogi());
			searchMap.put("dive",dccSearchTrend.getsDive());
			searchMap.put("grpID",dccSearchTrend.getsGrpID());
			searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
			searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
			//searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? addDate("s",now.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
			//searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? now.format(dtf)+".000" : dccSearchTrend.getEndDate());
			searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? startDate.format(dtf) : dccSearchTrend.getStartDate());
			searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? endDate.format(dtf) : dccSearchTrend.getEndDate());
			
			List<TrendTagDccInfo> dccGrpTagList = new ArrayList();
			Map dccVal = new HashMap();
			List<Map> grpTagList = new ArrayList();
			if( "D".equalsIgnoreCase(strDive) ) {
				dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
				dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);
			} else if( "B".equalsIgnoreCase(strDive) ) {
				grpTagList = dccTrendService.getGrpTag(searchMap);
			}
			
			List<Map> LblInfoList = getGrpTagListE(dccSearchTrend,conHogi);
			List<Map> arrTrendData = getTrendViewE(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, conHogi);
        		
    		excelHelperUtil.alarmFTAMExcelDownload(request, response, "trend_", LblInfoList, arrTrendData);
        	
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
    }
	
	@RequestMapping("dccmarkvtrend")
	public ModelAndView dccmarkvtrend(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ dccmarkvtrend");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if( userInfo.getHogi() == null ) {
			if( dccSearchTrend.getHogiHeader() != null && !"".equals(dccSearchTrend.getHogiHeader()) ) {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) {
	    			if( commonConstant.getUrl().indexOf("10.135.101.222") > -1 ) {
	    				dccSearchTrend.setsHogi("4");
	    			} else {
	    				dccSearchTrend.setsHogi("3");
	    			}
	    		} else {
	    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
	    		}
	    	}
		} else {
			dccSearchTrend.setsHogi(userInfo.getHogi());
		}
		if( userInfo.getXyGubun() == null ) {
	    	if( dccSearchTrend.getXyHeader() != null && !"".equals(dccSearchTrend.getXyHeader()) ) {
	    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    		//}
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun("X");
	    		} else {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
	    		}
	    	}
		} else {
			dccSearchTrend.setsXYGubun(userInfo.getXyGubun());
		}
		
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("B");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("91");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("1");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {

	    	String strGrpID = dccSearchTrend.getsGrpID() == null ? userInfo.getId() : dccSearchTrend.getsGrpID();
	    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "91" : dccSearchTrend.getsMenuNo();
	    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "1" : dccSearchTrend.getsUGrpNo();
			
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			
		}

		return mav;
	}
	
	@RequestMapping("dmExcelExport")
	public void dmExcelExport(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			
			LocalDateTime endDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? LocalDateTime.now() : convDtm(dccSearchTrend.getEndDate(),true);
	    	LocalDateTime startDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? endDate.minusMinutes(10) : convDtm(dccSearchTrend.getStartDate(),true);
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

			String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
			
	    	if( dccSearchTrend.getHogiHeader() != null ) {
	    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null ) {
	    			if( "4".equals(conHogi) ) {
	    				dccSearchTrend.setsHogi("4");
	    			} else {
	    				dccSearchTrend.setsHogi("3");
	    			}
	    		}
	    	}
	    	if( dccSearchTrend.getXyHeader() != null ) {
	    		//if( dccSearchTrend.getXyGubun() == null ) {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    		//}
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null ) {
	    			dccSearchTrend.setsXYGubun("X");
	    		} else {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
	    		}
	    	}
	    	MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
	    	
			if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("B");
			if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
			if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
			if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
			if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID(userInfo.getId());
			if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("91");
			if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
			if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
			//if( dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf),-650));
			//if( dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ) dccSearchTrend.setEndDate(endDate.format(dtf));
			
			dccSearchTrend.setStartDate(startDate.format(dtf));
			dccSearchTrend.setEndDate(endDate.format(dtf));
			String strUGrpNo = dccSearchTrend.getsUGrpNo();
			String strMenuNo = dccSearchTrend.getsMenuNo();
			String strGrpID = dccSearchTrend.getsGrpID();
			String strGap = dccSearchTrend.getTxtTimeGap();
			if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
			if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
			if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
			if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
		    	
			dccSearchTrend.setMenuName(this.menuName);
			
			String strDive = dccSearchTrend.getsDive();
			
			Map searchMap = new HashMap();
			searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
			searchMap.put("hogi",dccSearchTrend.getsHogi());
			searchMap.put("dive",dccSearchTrend.getsDive());
			searchMap.put("grpID",dccSearchTrend.getsGrpID());
			searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
			searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
			//searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? addDate("s",now.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
			//searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? now.format(dtf)+".000" : dccSearchTrend.getEndDate());
			searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? startDate.format(dtf) : dccSearchTrend.getStartDate());
			searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? endDate.format(dtf) : dccSearchTrend.getEndDate());
			
			List<TrendTagDccInfo> dccGrpTagList = new ArrayList();
			Map dccVal = new HashMap();
			List<Map> grpTagList = new ArrayList();
			if( "D".equalsIgnoreCase(strDive) ) {
				dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
				dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);
			} else if( "B".equalsIgnoreCase(strDive) ) {
				grpTagList = dccTrendService.getGrpTag(searchMap);
			}
			
			List<Map> LblInfoList = getGrpTagListE(dccSearchTrend,conHogi);
			List<Map> arrTrendData = getTrendViewE(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, conHogi);
        		
    		excelHelperUtil.alarmDMExcelDownload(request, response, "trend_", LblInfoList, arrTrendData);
        	
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
    }

	@RequestMapping("dsExcelExport")
	public void dsExcelExport(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			
			LocalDateTime endDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? LocalDateTime.now() : convDtm(dccSearchTrend.getEndDate(),true);
	    	LocalDateTime startDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? endDate.minusMinutes(10) : convDtm(dccSearchTrend.getStartDate(),true);
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

			String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
			
	    	if( dccSearchTrend.getHogiHeader() != null ) {
	    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null ) {
	    			if( "4".equals(conHogi) ) {
	    				dccSearchTrend.setsHogi("4");
	    			} else {
	    				dccSearchTrend.setsHogi("3");
	    			}
	    		}
	    	}
	    	if( dccSearchTrend.getXyHeader() != null ) {
	    		//if( dccSearchTrend.getXyGubun() == null ) {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    		//}
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null ) {
	    			dccSearchTrend.setsXYGubun("X");
	    		} else {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
	    		}
	    	}
	    	MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
	    	
			if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("A");
			if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
			if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
			if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
			if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("Trend");
			if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("51");
			if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("");
			if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
			//if( dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf),-650));
			//if( dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ) dccSearchTrend.setEndDate(endDate.format(dtf));
			
			dccSearchTrend.setStartDate(startDate.format(dtf));
			dccSearchTrend.setEndDate(endDate.format(dtf));
			String strUGrpNo = dccSearchTrend.getsUGrpNo();
			String strMenuNo = dccSearchTrend.getsMenuNo();
			String strGrpID = dccSearchTrend.getsGrpID();
			String strGap = dccSearchTrend.getTxtTimeGap();
			if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
			if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
			if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
			if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
		    	
			dccSearchTrend.setMenuName(this.menuName);
			
			String strDive = dccSearchTrend.getsDive();
			
			Map searchMap = new HashMap();
			searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
			searchMap.put("hogi",dccSearchTrend.getsHogi());
			searchMap.put("dive",dccSearchTrend.getsDive());
			searchMap.put("grpID",dccSearchTrend.getsGrpID());
			searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
			searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
			//searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? addDate("s",now.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
			//searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? now.format(dtf)+".000" : dccSearchTrend.getEndDate());
			searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? startDate.format(dtf) : dccSearchTrend.getStartDate());
			searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? endDate.format(dtf) : dccSearchTrend.getEndDate());
			
			List<TrendTagDccInfo> dccGrpTagList = new ArrayList();
			Map dccVal = new HashMap();
			List<Map> grpTagList = new ArrayList();
			if( "D".equalsIgnoreCase(strDive) ) {
				dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
				dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);
			} else if( "B".equalsIgnoreCase(strDive) ) {
				grpTagList = dccTrendService.getGrpTag(searchMap);
			}
			
			List<Map> LblInfoList = getGrpTagListE(dccSearchTrend,conHogi);
			List<Map> arrTrendData = getTrendViewE(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, conHogi);
        		
    		excelHelperUtil.alarmDSExcelDownload(request, response, "trend_", LblInfoList, arrTrendData);
        	
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
    }
	
	/*@RequestMapping("barchartfixed")
	public ModelAndView barchartfixed(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ barchartfixed");	
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}*/
	
	@RequestMapping("barchartfixed")
	public ModelAndView barchartfixed(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ barchartfixed");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if( userInfo.getHogi() == null ) {
			if( dccSearchTrend.getHogiHeader() != null && !"".equals(dccSearchTrend.getHogiHeader()) ) {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) {
	    			if( commonConstant.getUrl().indexOf("10.135.101.222") > -1 ) {
	    				dccSearchTrend.setsHogi("4");
	    			} else {
	    				dccSearchTrend.setsHogi("3");
	    			}
	    		} else {
	    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
	    		}
	    	}
		} else {
			dccSearchTrend.setsHogi(userInfo.getHogi());
		}
		if( userInfo.getXyGubun() == null ) {
	    	if( dccSearchTrend.getXyHeader() != null && !"".equals(dccSearchTrend.getXyHeader()) ) {
	    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    		//}
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun("X");
	    		} else {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
	    		}
	    	}
		} else {
			dccSearchTrend.setsXYGubun(userInfo.getXyGubun());
		}
		
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("31");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("1");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			getTrendDataBar(dccSearchTrend,mav,mberInfo);
			//getGrpTagList(dccSearchTrend,mav);
			
			//changeGrpName(dccSearchTrend,mav);
	    	
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			//mav.addObject("UserInfo",mberInfo);
			
		}

		return mav;
	}
	
	private void getTrendDataBar(DccSearchTrend dccSearchTrend, ModelAndView mav, MemberInfo userInfo) {
		String strHogi = dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi();
		String strXY = dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun();
    	String strGrpID = dccSearchTrend.getsGrpID() == null ? userInfo.getId() : dccSearchTrend.getsGrpID();
    	String strMenuNo = dccSearchTrend.getsMenuNo() == null ? "31" : dccSearchTrend.getsMenuNo();
    	String strUGrpNo = dccSearchTrend.getsUGrpNo() == null ? "" : dccSearchTrend.getsUGrpNo();
    	String sFixed = dccSearchTrend.getFixed() == null ? "F" : dccSearchTrend.getFixed();
    	String sGrade = userInfo.getGrade() == null ? "9" : userInfo.getGrade();
    	String strDive = dccSearchTrend.getsDive() == null ? "D" : dccSearchTrend.getsDive();
    	String strFast = dccSearchTrend.getgStrFast() == null ? "5" : dccSearchTrend.getgStrFast();
    	int nType = 0;
    	
    	LocalDateTime endDate = LocalDateTime.now();
    	LocalDateTime startDate = endDate.minusMinutes(10);
    	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
    	
    	String mskStart = dccSearchTrend.getStartDate();
    	String mskEnd = dccSearchTrend.getEndDate();
		
    	switch( sFixed.toUpperCase() ) {
	    	case "F":
	    		strGrpID = "bar";
	    		strMenuNo = "31";
	    		break;
	    	case "S":
	    		strGrpID = userInfo.getId();
	    		strMenuNo = "32";
	    		break;
    	}
    	
		mskStart = mskStart == null ? dtf.format(startDate) : mskStart;
		mskEnd = mskEnd == null ? dtf.format(endDate) : mskEnd;
    	
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
	
	@RequestMapping("barchartspare")
	public ModelAndView barchartspare(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ barchartspare");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if( userInfo.getHogi() == null ) {
			if( dccSearchTrend.getHogiHeader() != null && !"".equals(dccSearchTrend.getHogiHeader()) ) {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) {
	    			if( commonConstant.getUrl().indexOf("10.135.101.222") > -1 ) {
	    				dccSearchTrend.setsHogi("4");
	    			} else {
	    				dccSearchTrend.setsHogi("3");
	    			}
	    		} else {
	    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
	    		}
	    	}
		} else {
			dccSearchTrend.setsHogi(userInfo.getHogi());
		}
		if( userInfo.getXyGubun() == null ) {
	    	if( dccSearchTrend.getXyHeader() != null && !"".equals(dccSearchTrend.getXyHeader()) ) {
	    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    		//}
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun("X");
	    		} else {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
	    		}
	    	}
		} else {
			dccSearchTrend.setsXYGubun(userInfo.getXyGubun());
		}
		
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("S");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("32");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("1");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			getTrendDataBar(dccSearchTrend,mav,mberInfo);
			//getGrpTagList(dccSearchTrend,mav);
			
			//changeGrpName(dccSearchTrend,mav);
	    	
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			//mav.addObject("UserInfo",mberInfo);
			
		}

		return mav;
	}
	
	@RequestMapping(value="changeGrpNameBar", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView changeGrpNameBar(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		logger.info("############ changeGrpNameBar");
		
		//LocalDateTime endDate = LocalDateTime.now();
    	//LocalDateTime startDate = endDate.minusMinutes(10);
		
		String getStartDate = dccSearchTrend.getStartDate();
		String getEndDate = dccSearchTrend.getEndDate();
		
		if( getStartDate.indexOf(",") > -1 ) getStartDate = getStartDate.substring(0,getStartDate.indexOf(",")).trim();
		if( getEndDate.indexOf(",") > -1 ) getEndDate = getEndDate.substring(0,getEndDate.indexOf(",")).trim();
		
		LocalDateTime endDate = getEndDate == null || "".equals(getEndDate) ? LocalDateTime.now() : convDtm(getEndDate,true);
    	LocalDateTime startDate = getStartDate == null || "".equals(getStartDate) ? endDate.minusMinutes(10) : convDtm(getStartDate,true);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

		
		String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("31");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("1");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		if( dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf),-650));
		if( dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ) dccSearchTrend.setEndDate(endDate.format(dtf));

		String searchGrpNo = dccSearchTrend.getsUGrpNo();
		if( searchGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(searchGrpNo.substring(0,searchGrpNo.indexOf(",")));
		String searchMenuNo = dccSearchTrend.getsMenuNo();
		if( searchMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(searchMenuNo.substring(0,searchMenuNo.indexOf(",")));
		String strGrpID = dccSearchTrend.getsGrpID();
		if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
		String strGap = dccSearchTrend.getTxtTimeGap();
		if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
	    
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			dccSearchTrend.setMenuName(this.menuName);
			
			dccSearchTrend.setsUGrpNo(dccSearchTrend.getsUGrpNo() == null ? userInfo.getId() : dccSearchTrend.getsUGrpNo());
			
			getGrpTagList(dccSearchTrend,conHogi,mav);
			
			changeGrpNameBar(dccSearchTrend,conHogi,mav);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("resultType","barchart");
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
		}
	
		return mav;
	}
	
	private void changeGrpNameBar(DccSearchTrend dccSearchTrend, String conHogi, ModelAndView mav) {
		
		logger.info("############ changeGrpNameBar");
		
    	if( dccSearchTrend.getHogiHeader() != null ) {
    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
    	} else {
    		if( dccSearchTrend.getHogi() == null ) {
    			if( "4".equals(conHogi) ) {
    				dccSearchTrend.setsHogi("4");
    			} else {
    				dccSearchTrend.setsHogi("3");
    			}
    		} else {
    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
    		}
    	}
    	if( dccSearchTrend.getXyHeader() != null ) {
    		//if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
    		//}
    	} else {
    		if( dccSearchTrend.getXyGubun() == null ) {
    			dccSearchTrend.setsXYGubun("X");
    		} else {
    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
    		}
    	}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("31");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("1");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
	    	
		dccSearchTrend.setMenuName(this.menuName);
		
		String strDive = dccSearchTrend.getsDive();
		
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

		String getStartDate = dccSearchTrend.getStartDate();
		String getEndDate = dccSearchTrend.getEndDate();
		
		if( getStartDate.indexOf(",") > -1 ) getStartDate = getStartDate.substring(0,getStartDate.indexOf(",")).trim();
		if( getEndDate.indexOf(",") > -1 ) getEndDate = getEndDate.substring(0,getEndDate.indexOf(",")).trim();
		
		Map searchMap = new HashMap();
		searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
		searchMap.put("hogi",dccSearchTrend.getsHogi());
		searchMap.put("dive",dccSearchTrend.getsDive());
		searchMap.put("grpID",dccSearchTrend.getsGrpID());
		searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
		searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
		searchMap.put("startDate",getStartDate == null || "".equals(getStartDate) ? addDate("s",now.format(dtf)+".000",-650) : getStartDate);
		searchMap.put("endDate",getEndDate == null || "".equals(getEndDate) ? now.format(dtf)+".000" : getEndDate);
		
		//System.out.println(searchMap.get("startDate")+" // "+searchMap.get("endDate"));
		
		List<ComTagDccInfo> dccGrpTagList = new ArrayList();
		Map dccVal = new HashMap();
		List<Map> grpTagList = new ArrayList();
		if( "D".equalsIgnoreCase(strDive) ) {
			dccGrpTagList = basDccOsmsService.getDccGrpTagList(searchMap);
			dccVal = basDccOsmsService.getDccValue(searchMap, dccGrpTagList);
		} else if( "B".equalsIgnoreCase(strDive) ) {
			grpTagList = dccTrendService.getGrpTag(searchMap);
		}
		
		//System.out.println(dccGrpTagList.size());
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
					case "0":
						break;
					case "1": case "7":
						tmpHiAlarm.put(idx,comTagDccInfo.getDataLimit1());
						tmpLoAlarm.put(idx,"");
						tmpDtabHi.put(idx,"");
						tmpDtabLo.put(idx,"");
						break;
					case "2": case "8":
						tmpHiAlarm.put(idx,"");
						tmpLoAlarm.put(idx,comTagDccInfo.getDataLimit1());
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
						tmpDtabLo.put(idx,comTagDccInfo.getDataLimit2());
						break;
					case "9":
						break;
				}
				
				idx++;
			}

			mav.addObject("LblValue",dccVal.get("lblDataList"));
			mav.addObject("ScanTime",dccVal.get("SearchTime"));
			mav.addObject("LblUnit",tmpUnit);
			mav.addObject("minList",tmpMin);
			mav.addObject("maxList",tmpMax);
			mav.addObject("FHiAlarm",tmpHiAlarm);
			mav.addObject("FLoAlarm",tmpLoAlarm);
			mav.addObject("FDtabHi",tmpDtabHi);
			mav.addObject("FDtabLo",tmpDtabLo);
		}
		
		//getTrendView(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, conHogi, mav);
		
		mav.addObject("DccGrpTagList",dccGrpTagList);
		
	}
	
	@RequestMapping("bfExcelExport")
	public ModelAndView bfExcelExport(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ bfExcelExport");
		
		MemberInfo userInfo = (MemberInfo)request.getSession().getAttribute("USER_INFO");
		DccSearchAdmin dccSearchAdmin = new DccSearchAdmin();
		dccSearchAdmin.setUserId(userInfo.getId());
		MemberInfo mberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
		
		if( userInfo.getHogi() == null ) {
			if( dccSearchTrend.getHogiHeader() != null && !"".equals(dccSearchTrend.getHogiHeader()) ) {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
	    	} else {
	    		if( dccSearchTrend.getHogi() == null || "".equals(dccSearchTrend.getHogi()) ) {
	    			if( commonConstant.getUrl().indexOf("10.135.101.222") > -1 ) {
	    				dccSearchTrend.setsHogi("4");
	    			} else {
	    				dccSearchTrend.setsHogi("3");
	    			}
	    		} else {
	    			dccSearchTrend.setsHogi(dccSearchTrend.getHogi());
	    		}
	    	}
		} else {
			dccSearchTrend.setsHogi(userInfo.getHogi());
		}
		if( userInfo.getXyGubun() == null ) {
	    	if( dccSearchTrend.getXyHeader() != null && !"".equals(dccSearchTrend.getXyHeader()) ) {
	    		//if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
	    		//}
	    	} else {
	    		if( dccSearchTrend.getXyGubun() == null || "".equals(dccSearchTrend.getXyGubun()) ) {
	    			dccSearchTrend.setsXYGubun("X");
	    		} else {
	    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
	    		}
	    	}
		} else {
			dccSearchTrend.setsXYGubun(userInfo.getXyGubun());
		}
		if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
		if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
		if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
		if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
		if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("31");
		if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("1");
		if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			getTrendDataBar(dccSearchTrend,mav,mberInfo);
			//getGrpTagList(dccSearchTrend,mav);
			
			//changeGrpName(dccSearchTrend,mav);
	    	
			dccSearchTrend.setMenuName(this.menuName);
			
			userInfo.setHogi(dccSearchTrend.getsHogi());
			userInfo.setXyGubun(dccSearchTrend.getsXYGubun());
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo",userInfo);
			//mav.addObject("UserInfo",mberInfo);
			
		}

		return mav;
	}
	
	/*@RequestMapping("barchartspare")
	public ModelAndView barchartspare(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ barchartspare");	
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}*/
	
	@RequestMapping("logfixedlist")
	public ModelAndView logfixedlist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();

		logger.info("############ logfixedlist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
			
			if(dccSearchTrend.getsMenuNo() == null || dccSearchTrend.getsMenuNo().isEmpty()) {
            	
				dccSearchTrend.setsDive("D");
        		dccSearchTrend.setsMenuNo("23");
        		dccSearchTrend.setsGrpID("Trend");
	        	dccSearchTrend.setsUGrpNo("0");
			}
			if( member.getHogi() == null ) member.setHogi(dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi());
			if( member.getXyGubun() == null ) member.setXyGubun(dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun());
	        	
        	dccSearchTrend.setsHogi(member.getHogi());
        	dccSearchTrend.setsXYGubun(member.getXyGubun());
			
			getMainTrendLog(dccSearchTrend, mav);      
    		
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}
	
	@RequestMapping(value="reloadLogfixedlist", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadLogfixedlist(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
	
		ModelAndView mav = new ModelAndView("jsonView");

		logger.info("############ reloadLogfixedlist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
			
			if(dccSearchTrend.getsMenuNo() == null || dccSearchTrend.getsMenuNo().isEmpty()) {
            	
				dccSearchTrend.setsDive("D");
        		dccSearchTrend.setsMenuNo("23");
        		dccSearchTrend.setsGrpID("Trend");
	        	dccSearchTrend.setsUGrpNo("1");
			}
			if( member.getHogi() == null ) member.setHogi(dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi());
			if( member.getXyGubun() == null ) member.setXyGubun(dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun());
	        	
        	dccSearchTrend.setsHogi(member.getHogi());
        	dccSearchTrend.setsXYGubun(member.getXyGubun());
			
			getMainTrendLog(dccSearchTrend, mav);      
			
			mav.addObject("resultType","logfixedlist");
    		
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}
	
	@RequestMapping("lfExcelExport")
	public void lfExcelExport(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {

			logger.info("############ lfExcelExport");
			
			if(request.getSession().getAttribute("USER_INFO") != null) {
				MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
				
				LocalDateTime endDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? LocalDateTime.now() : convDtm(dccSearchTrend.getEndDate(),true);
		    	LocalDateTime startDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? endDate.minusMinutes(10) : convDtm(dccSearchTrend.getStartDate(),true);
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

				String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
				
				if( member.getHogi() == null ) {
			    	if( dccSearchTrend.getHogiHeader() != null ) {
			    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
			    	} else {
			    		if( dccSearchTrend.getHogi() == null ) {
			    			if( "4".equals(conHogi) ) {
			    				dccSearchTrend.setsHogi("4");
			    			} else {
			    				dccSearchTrend.setsHogi("3");
			    			}
			    		}
			    	}
				} else {
					dccSearchTrend.setsHogi(member.getHogi());
				}
				if( member.getXyGubun() == null ) {
			    	if( dccSearchTrend.getXyHeader() != null ) {
			    		//if( dccSearchTrend.getXyGubun() == null ) {
			    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
			    		//}
			    	} else {
			    		if( dccSearchTrend.getXyGubun() == null ) {
			    			dccSearchTrend.setsXYGubun("X");
			    		} else {
			    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
			    		}
			    	}
				} else {
					dccSearchTrend.setsXYGubun(member.getXyGubun());
				}
				if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("F");
				if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
				if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
				if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
				if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("23");
				if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("0");
				if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID("Trend");
				if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
				//if( dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf),-650));
				//if( dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ) dccSearchTrend.setEndDate(endDate.format(dtf));
				
				dccSearchTrend.setStartDate(startDate.format(dtf));
				dccSearchTrend.setEndDate(endDate.format(dtf));
				String strUGrpNo = dccSearchTrend.getsUGrpNo();
				String strMenuNo = dccSearchTrend.getsMenuNo();
				String strGrpID = dccSearchTrend.getsGrpID();
				String strGap = dccSearchTrend.getTxtTimeGap();
				if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
				if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
				if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
				if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
			    	
				dccSearchTrend.setMenuName(this.menuName);
				
				String strDive = dccSearchTrend.getsDive();
				
				Map searchMap = new HashMap();
				searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
				searchMap.put("hogi",dccSearchTrend.getsHogi());
				searchMap.put("dive",dccSearchTrend.getsDive());
				searchMap.put("grpID",dccSearchTrend.getsGrpID());
				searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
				searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
				//searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? addDate("s",now.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
				//searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? now.format(dtf)+".000" : dccSearchTrend.getEndDate());
				searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? startDate.format(dtf) : dccSearchTrend.getStartDate());
				searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? endDate.format(dtf) : dccSearchTrend.getEndDate());
				
				List<TrendTagDccInfo> dccGrpTagList = new ArrayList();
				Map dccVal = new HashMap();
				List<Map> grpTagList = new ArrayList();
				if( "D".equalsIgnoreCase(strDive) ) {
					dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
					dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);
				} else if( "B".equalsIgnoreCase(strDive) ) {
					grpTagList = dccTrendService.getGrpTag(searchMap);
				}
				
				List<Map> LblInfoList = ((List)dccVal.get("lblDataList")).size() > 0 ? getGrpTagListE(dccSearchTrend,conHogi) : new ArrayList<Map>();
				List<Map> arrTrendData = ((List)dccVal.get("lblDataList")).size() > 0 ? getLogViewE(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, conHogi) : new ArrayList<Map>();
				
				String fileName = dccSearchTrend.getFileName() == null ? "" : dccSearchTrend.getFileName();
				
				excelHelperUtil.alarmLFExcelDownload(request, response, fileName, LblInfoList, arrTrendData, dccGrpTagList);
			}
        	
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("logsparelist")
	public ModelAndView logsparelist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();

		logger.info("############ logsparelist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
			
			if(dccSearchTrend.getsMenuNo() == null || dccSearchTrend.getsMenuNo().isEmpty()) {
            	
				dccSearchTrend.setsDive("D");
        		dccSearchTrend.setsMenuNo("24");
        		dccSearchTrend.setsGrpID("Trend");
	        	dccSearchTrend.setsUGrpNo("0");
			}
			if( member.getHogi() == null ) member.setHogi(dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi());
			if( member.getXyGubun() == null ) member.setXyGubun(dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun());
	        	
        	dccSearchTrend.setsHogi(member.getHogi());
        	dccSearchTrend.setsXYGubun(member.getXyGubun());

        	dccSearchTrend.setsGrpID(member.getId());
			
			getMainTrendLog(dccSearchTrend, mav);      
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}
	
	@RequestMapping(value="reloadLogsparelist", method={RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadLogsparelist(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("jsonView");

		logger.info("############ reloadLogsparelist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
			
			if(dccSearchTrend.getsMenuNo() == null || dccSearchTrend.getsMenuNo().isEmpty()) {
            	
				dccSearchTrend.setsDive("D");
        		dccSearchTrend.setsMenuNo("24");
        		dccSearchTrend.setsGrpID("Trend");
	        	dccSearchTrend.setsUGrpNo("1");
			}
			if( member.getHogi() == null ) member.setHogi(dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi());
			if( member.getXyGubun() == null ) member.setXyGubun(dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun());
	        	
        	dccSearchTrend.setsHogi(member.getHogi());
        	dccSearchTrend.setsXYGubun(member.getXyGubun());

        	dccSearchTrend.setsGrpID(member.getId());
			
			getMainTrendLog(dccSearchTrend, mav);
			
			mav.addObject("resultType","logsparelist");
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}
	
	@RequestMapping("lsExcelExport")
	public void lsExcelExport(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {

			logger.info("############ lsExcelExport");
			
			if(request.getSession().getAttribute("USER_INFO") != null) {
				MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
				
				LocalDateTime endDate = dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? LocalDateTime.now() : convDtm(dccSearchTrend.getEndDate(),true);
		    	LocalDateTime startDate = dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? endDate.minusMinutes(10) : convDtm(dccSearchTrend.getStartDate(),true);
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

				String conHogi = commonConstant.getUrl().indexOf("10.135.101.222") > -1 ? "4" : "3";
				
				if( member.getHogi() == null ) {
			    	if( dccSearchTrend.getHogiHeader() != null ) {
			    		if( dccSearchTrend.getHogi() == null ) dccSearchTrend.setsHogi(dccSearchTrend.getHogiHeader());
			    	} else {
			    		if( dccSearchTrend.getHogi() == null ) {
			    			if( "4".equals(conHogi) ) {
			    				dccSearchTrend.setsHogi("4");
			    			} else {
			    				dccSearchTrend.setsHogi("3");
			    			}
			    		}
			    	}
				} else {
					dccSearchTrend.setsHogi(member.getHogi());
				}
				if( member.getXyGubun() == null ) {
			    	if( dccSearchTrend.getXyHeader() != null ) {
			    		//if( dccSearchTrend.getXyGubun() == null ) {
			    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyHeader());
			    		//}
			    	} else {
			    		if( dccSearchTrend.getXyGubun() == null ) {
			    			dccSearchTrend.setsXYGubun("X");
			    		} else {
			    			dccSearchTrend.setsXYGubun(dccSearchTrend.getXyGubun());
			    		}
			    	}
				} else {
					dccSearchTrend.setsXYGubun(member.getXyGubun());
				}
				if( dccSearchTrend.getFixed() == null ) dccSearchTrend.setFixed("S");
				if( dccSearchTrend.getgHis() == null ) dccSearchTrend.setgHis("R");
				if( dccSearchTrend.getsDive() == null ) dccSearchTrend.setsDive("D");
				if( dccSearchTrend.getgUseGap() == null ) dccSearchTrend.setgUseGap("0");
				if( dccSearchTrend.getsMenuNo() == null ) dccSearchTrend.setsMenuNo("24");
				if( dccSearchTrend.getsUGrpNo() == null ) dccSearchTrend.setsUGrpNo("0");
				if( dccSearchTrend.getsGrpID() == null ) dccSearchTrend.setsGrpID(member.getId());
				if( dccSearchTrend.getTxtTimeGap() == null ) dccSearchTrend.setTxtTimeGap("5");
				//if( dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ) dccSearchTrend.setStartDate(addDate("s",endDate.format(dtf),-650));
				//if( dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ) dccSearchTrend.setEndDate(endDate.format(dtf));
				
				dccSearchTrend.setStartDate(startDate.format(dtf));
				dccSearchTrend.setEndDate(endDate.format(dtf));
				String strUGrpNo = dccSearchTrend.getsUGrpNo();
				String strMenuNo = dccSearchTrend.getsMenuNo();
				String strGrpID = dccSearchTrend.getsGrpID();
				String strGap = dccSearchTrend.getTxtTimeGap();
				if( strGap.indexOf(",") > -1 ) dccSearchTrend.setTxtTimeGap(strGap.substring(0,strGap.indexOf(",")));
				if( strGrpID.indexOf(",") > -1 ) dccSearchTrend.setsGrpID(strGrpID.substring(0,strGrpID.indexOf(",")));
				if( strUGrpNo.indexOf(",") > -1 ) dccSearchTrend.setsUGrpNo(strUGrpNo.substring(0,strUGrpNo.indexOf(",")));
				if( strMenuNo.indexOf(",") > -1 ) dccSearchTrend.setsMenuNo(strMenuNo.substring(0,strMenuNo.indexOf(",")));
			    	
				dccSearchTrend.setMenuName(this.menuName);
				
				String strDive = dccSearchTrend.getsDive();
				
				Map searchMap = new HashMap();
				searchMap.put("xyGubun",dccSearchTrend.getsXYGubun());
				searchMap.put("hogi",dccSearchTrend.getsHogi());
				searchMap.put("dive",dccSearchTrend.getsDive());
				searchMap.put("grpID",dccSearchTrend.getsGrpID());
				searchMap.put("menuNo",dccSearchTrend.getsMenuNo());
				searchMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
				//searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? addDate("s",now.format(dtf)+".000",-650) : dccSearchTrend.getStartDate());
				//searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? now.format(dtf)+".000" : dccSearchTrend.getEndDate());
				searchMap.put("startDate",dccSearchTrend.getStartDate() == null || "".equals(dccSearchTrend.getStartDate()) ? startDate.format(dtf) : dccSearchTrend.getStartDate());
				searchMap.put("endDate",dccSearchTrend.getEndDate() == null || "".equals(dccSearchTrend.getEndDate()) ? endDate.format(dtf) : dccSearchTrend.getEndDate());
				
				List<TrendTagDccInfo> dccGrpTagList = new ArrayList();
				Map dccVal = new HashMap();
				List<Map> grpTagList = new ArrayList();
				if( "D".equalsIgnoreCase(strDive) ) {
					dccGrpTagList = dccTrendService.getDccGrpTagList(searchMap);
					dccVal = basDccOsmsService.getDccValue2(searchMap, dccGrpTagList);
				} else if( "B".equalsIgnoreCase(strDive) ) {
					grpTagList = dccTrendService.getGrpTag(searchMap);
				}
				
				List<Map> LblInfoList = ((List)dccVal.get("lblDataList")).size() > 0 ? getGrpTagListE(dccSearchTrend,conHogi) : new ArrayList<Map>();
				List<Map> arrTrendData = ((List)dccVal.get("lblDataList")).size() > 0 ? getLogViewE(dccSearchTrend, dccGrpTagList, grpTagList, searchMap, conHogi) : new ArrayList<Map>();
				
				String fileName = dccSearchTrend.getFileName() == null ? "" : dccSearchTrend.getFileName();
				
				excelHelperUtil.alarmLSExcelDownload(request, response, fileName, LblInfoList, arrTrendData, dccGrpTagList);
			}
        	
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
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

		mav.addObject("ForeColor",dccVal.get("ForeColor"));
		mav.addObject("ScanTime",dccVal.get("SearchTime"));
		mav.addObject("TagDccInfoList", tagDccInfoList);    		
		mav.addObject("lblDataList", lblDataList);
		
	}
	
	@RequestMapping("numericallist")
	public ModelAndView numericallist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();

		logger.info("############ numericallist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
			
			dccSearchTrend.setMenuName(this.menuName);
			
			if(dccSearchTrend.getsMenuNo() == null || dccSearchTrend.getsMenuNo().isEmpty()) {
            	
				dccSearchTrend.setsDive("D");
        		dccSearchTrend.setsMenuNo("25");
        		dccSearchTrend.setsGrpID(member.getId());
	        	dccSearchTrend.setsUGrpNo("1");
			}
			if( member.getHogi() == null ) member.setHogi(dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi());
			if( member.getXyGubun() == null ) member.setXyGubun(dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun());
			
        	dccSearchTrend.setsHogi(member.getHogi());
        	dccSearchTrend.setsXYGubun(member.getXyGubun());

			dccSearchTrend.setsGrpID(dccSearchTrend.getsGrpID()==null?  member.getId(): dccSearchTrend.getsGrpID());
			
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
    			lblDataList.get(idx).put("dccId", tagDccInfo.getHogi() + tagDccInfo.getXYGubun());
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
	
	@RequestMapping(value="reloadNumericallist", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadNumericallist(DccSearchTrend dccSearchTrend, HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("jsonView");

		logger.info("############ reloadNumericallist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
			
			dccSearchTrend.setMenuName(this.menuName);
			
			if(dccSearchTrend.getsMenuNo() == null || dccSearchTrend.getsMenuNo().isEmpty()) {
            	
				dccSearchTrend.setsDive("D");
        		dccSearchTrend.setsMenuNo("25");
        		dccSearchTrend.setsGrpID(member.getId());
	        	dccSearchTrend.setsUGrpNo("1");
			}
			if( member.getHogi() == null ) member.setHogi(dccSearchTrend.getsHogi() == null ? "3" : dccSearchTrend.getsHogi());
			if( member.getXyGubun() == null ) member.setXyGubun(dccSearchTrend.getsXYGubun() == null ? "X" : dccSearchTrend.getsXYGubun());
			
        	dccSearchTrend.setsHogi(member.getHogi());
        	dccSearchTrend.setsXYGubun(member.getXyGubun());
        	
			dccSearchTrend.setsGrpID(dccSearchTrend.getsGrpID()==null?  member.getId(): dccSearchTrend.getsGrpID());
			
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
    			lblDataList.get(idx).put("dccId", tagDccInfo.getHogi() + tagDccInfo.getXYGubun());
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
        	mav.addObject("resultType","numerical");

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

		//Y = Y / aOffset;
		
		if (Y*1d/aOffset < aYmin) {
			return aYmin + "";
		}else {
			return (Y*1d/aOffset) + "";
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
