package com.mkpenc.dcc.trend.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.service.DccAdminService;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.dcc.common.service.BasDccOsmsService;
import com.mkpenc.dcc.trend.model.DccSearchTrend;
import com.mkpenc.dcc.trend.service.DccTrendService;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
    	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    	
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
	
	private void changeGrpName(DccSearchTrend dccSearchTrend, ModelAndView mav) {
		List<Map> arrTrendData = new ArrayList();
		
		String strUGrpNo = dccSearchTrend.getsUGrpNo();
		String strTimeGap = dccSearchTrend.getTxtTimeGap();
		String strDive = dccSearchTrend.getsDive();
		Long lGap = Long.parseLong(strTimeGap)*1000;
		String strFast = "";
		String sDtm = dccSearchTrend.getStartDate();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		String strStartTime = "";
		String strEndTime = "";
		
		Map serachMap = new HashMap();
		serachMap.put("xyGubun",dccSearchTrend.getsXYGubun());
		serachMap.put("hogi",dccSearchTrend.getsHogi());
		serachMap.put("dive",dccSearchTrend.getsDive());
		serachMap.put("grpID",dccSearchTrend.getsGrpID());
		serachMap.put("menuNo",dccSearchTrend.getsMenuNo());
		serachMap.put("uGrpNo",dccSearchTrend.getsUGrpNo());
		
		List<ComTagDccInfo> dccGrpTagList = new ArrayList();
		List<Map> grpTagList = new ArrayList();
		if( "D".equalsIgnoreCase(strDive) ) {
			dccGrpTagList = basDccOsmsService.getDccGrpTagList(serachMap);
		} else if( "B".equalsIgnoreCase(strDive) ) {
			grpTagList = dccTrendService.getGrpTag(serachMap);
		}
		
		if( dccGrpTagList.size() > 0 ) {
			List<Map> lblValue = new ArrayList<Map>();
			List<Map> lblTagNme = new ArrayList<Map>();
			List<Map> lblUnit = new ArrayList<Map>();
			List<Map> txtMax = new ArrayList<Map>();
			List<Map> txtMin = new ArrayList<Map>();
			List<Map> fHiAlarm = new ArrayList<Map>();
			List<Map> fLoAlarm = new ArrayList<Map>();
			List<Map> fDtabHi = new ArrayList<Map>();
			List<Map> fDtabLo = new ArrayList<Map>();
			
			int idx=0;
			for( ComTagDccInfo comTagDccInfo : dccGrpTagList ) {
				Map tmpValue = new HashMap();
				Map tmpTagName = new HashMap();
				Map tmpUnit = new HashMap();
				Map tmpMax = new HashMap();
				Map tmpMin = new HashMap();
				Map tmpHiAlarm = new HashMap();
				Map tmpLoAlarm = new HashMap();
				Map tmpDtabHi = new HashMap();
				Map tmpDtabLo = new HashMap();
				
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
		}
		
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
		
		if( "R".equalsIgnoreCase(dccSearchTrend.getgHis()) ) {
			//RealTime
			String strScanTime = dccTrendService.selectScanTime(dccSearchTrend);
			
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
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((440)*nTrendWidth));
						strEndTime = strScanTime;
					} else {
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*nTrendWidth+10));
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
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((440)*nTrendWidth));
						strEndTime = strScanTime;
					} else {
						strStartTime = dtf.format(convDtm(strScanTime,false).minusSeconds((lGap/1000)*nTrendWidth+10));
						strEndTime = strScanTime;
					}
					break;
			}
			
			//tmRun_timer
			if( dccGrpTagList.size() > 0 ) {
				if( "F".equalsIgnoreCase(strFast) ) {
					List<Map> rsTrendList = dccTrendService.rsTrend5sGap(serachMap, dccGrpTagList, lGap, strFast);
					
					int nCnt = rsTrendList.size();
					for( int tt=0;tt<nTrendWidth-nCnt;tt++ ) {
						//rtnList.put(tt,)
					}
					
					for( int tt=nTrendWidth-nCnt;tt<nTrendWidth;tt++ ) {
						String[] dccGrpTagArray = {
							dccGrpTagList.get(tt).getIOTYPE(),
							dccGrpTagList.get(tt).getIOBIT()+"",
							dccGrpTagList.get(tt).getSaveCore()+"",
							dccGrpTagList.get(tt).getBScale()+"",
							dccGrpTagList.get(tt).getADDRESS(),
							dccGrpTagList.get(tt).getFASTIOCHK()+""
						};

						Map rtnMap = new HashMap();
						for( int st=0;st<rsTrendList.get(tt).size();st++ ) {
							String RetVal = setDataConv(st,rsTrendList.get(tt).get(st).toString(),dccGrpTagArray,dccSearchTrend.getsMenuNo(),lGap);
							
							int nRetValType = 0;
							try {
								if( RetVal == null ) {
									nRetValType = 2;
								} else {
									int tmpN = Integer.parseInt(RetVal);
									nRetValType = 0;
								}
							} catch( NumberFormatException nfe ) {
								nRetValType = 1;
							}
							
							if( nRetValType == 0 ) {
								rtnMap.put(st,RetVal);
							} else if( nRetValType == 1 ) {
								rtnMap.put(st,cnstErr+"");
							} else {
								rtnMap.put(st,cnstNull+"");
							}
						}
						Map timeNPos = new HashMap();
						timeNPos.put("m_data",rtnMap);
						timeNPos.put("m_time",rsTrendList.get(tt).get(0).toString());
						timeNPos.put("m_xpos",tt+"");
						
						arrTrendData.add(tt,timeNPos);
					}
					
					String lblDate = arrTrendData.get(nTrendWidth-1).get("m_time").toString();
					String lblDate2 = lblDate;
					Map lblValue = (Map) arrTrendData.get(nTrendWidth-1).get("m_data");
				} else {
					//GetTrendRealValue
				}
			}
		} else {
			//Historical
		}
		
		//String lblDate = arrTrendData(gnEndPos-1).m_time;
	}
	
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
		String[] pDate = date.split(" ")[0].split("-");
		String[] pTime = date.split(" ")[1].split(":");
		if( !isMilli ) {
			pTime[2] = pTime[2].indexOf(".") > -1 ? pTime[2].substring(0,pTime[2].indexOf(".")) : pTime[2];
		}
		
		LocalDateTime ldt = LocalDateTime.of(Integer.parseInt(pDate[0]),Integer.parseInt(pDate[1]),Integer.parseInt(pDate[2]),
											Integer.parseInt(pTime[0]),Integer.parseInt(pTime[1]),Integer.parseInt(pTime[2]));
		
		return ldt;
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
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}

		return mav;
	}
	
	@RequestMapping("numericallist")
	public ModelAndView numericallist(DccSearchTrend dccSearchTrend, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();

		logger.info("############ numericallist");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchTrend.setMenuName(this.menuName);
			
			mav.addObject("BaseSearch", dccSearchTrend);
			mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
			
		}
		
		

		return mav;
	}

}
