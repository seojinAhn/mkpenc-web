package com.mkpenc.dcc.trend.service.impl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.common.mapper.BasDccOsmsMapper;
import com.mkpenc.dcc.common.model.ComDccGrpTagInfo;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.dcc.common.service.BasDccOsmsService;
import com.mkpenc.dcc.status.model.DccGrpTagInfo;
import com.mkpenc.dcc.tip.service.DccTipService;
import com.mkpenc.dcc.trend.mapper.DccTrendMapper;
import com.mkpenc.dcc.trend.model.DccSearchTrend;
import com.mkpenc.dcc.trend.service.DccTrendService;


@Service("dccTrendService")
public class DccTrendServiceImpl implements DccTrendService{
	
	private static Logger logger = LoggerFactory.getLogger(DccTipService.class);
	private static final int cnstNull = -99999;
	private static final int cnstErr = -32768;
	private static final String cnstErrStr = "***IRR";
	
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
	
	@Autowired
	private DccTrendMapper dccTrendMapper;
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired
	private BasDccOsmsMapper basDccOsmsMapper;
	
	@Override
	public List<Map> selectGroupName(Map trendSearchMap) {
		return dccTrendMapper.selectGroupName(trendSearchMap);
	}
	
	public String sqlQueryDccReal(DccSearchTrend dccSearchTrend) {
		String res = "";
		List<Map> fldNoList = dccTrendMapper.selectTrendFldNo(dccSearchTrend);
		
		for( Map fldNo : fldNoList ) {
			Map trendSearchMap = new HashMap();
			trendSearchMap.put("rs0",fldNo.get("Hogi"));
			trendSearchMap.put("rs1",fldNo.get("TBLNO"));
			trendSearchMap.put("rs2",fldNo.get("FLDNO"));
			trendSearchMap.put("rs3",fldNo.get("XYGubun"));
			
			List<Map> dccTrendDataList = dccTrendMapper.selectTrendData(trendSearchMap);
			
			if( dccTrendDataList.size() < 1 ) {
				res = res + "|";
			} else {
				if( "".equals(res) ) {
					res = dccTrendDataList.get(0).get("SCANTIME") + "|";
				} else {
					res = res + dccTrendDataList.get(0).get("TVALUE") + "|";
				}
			}
		}
		
		return res;
	}
	
	public Map getDccValue(DccSearchTrend dccSearchTrend, List<Map> dccGrpTagList, Long lGap, ModelAndView mav) {
		Map rtnMap = new HashMap();
		String sMenuNo = dccSearchTrend.getsMenuNo() == null ? "" : dccSearchTrend.getsMenuNo().toString();
		
		String[] varValue = sqlQueryDccReal(dccSearchTrend).split("\\|");

		//*** Start getDccValue 에 포함 된 로직
    	if(varValue != null && varValue.length != 0) {
    		if(varValue[0].length() == 19) {
    			
    			rtnMap.put("LblDate",varValue[0]);
    			
    			try {
        			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
       			    java.util.Date date = format.parse(varValue[0]);
        			
        			Calendar c = Calendar.getInstance();
        			c.setTime(date); 
        			c.add(Calendar.MILLISECOND, 1);
        			
        			long searchTime = date.getTime();
        			long currentTime = System.currentTimeMillis();
        			
        			long secondsDifference = (currentTime -searchTime)  / 1000;
        			
        			if (secondsDifference > 1800) {
        				rtnMap.put("ForeColor", "#FF");
        			}else {
        				rtnMap.put("ForeColor", "#808000");
        			}
	        			
    			}catch (Exception e) {
    				e.printStackTrace();
    			}        			
    		} // end if varVal[0] len 19
    	} // end if varValue is not null
    	
    	
    	List<Map> lblDataList = new ArrayList<Map>();
    	for(int i=0;i<dccGrpTagList.size();i++) {
    		if( varValue[i+1] != null && !varValue[i+1].isEmpty() ) {
    			Map lblData = new HashMap();
    			String retVal = setDataConv(i, varValue[i+1], dccGrpTagList, sMenuNo, lGap);
    			switch( retVal ) {
    			case cnstErr+"":
    				lblData.put("fValue",cnstErrStr);
    				break;
    			case cnstNull+"":
    				lblData.put("fValue",cnstNull+"");
    				break;
    			default:
    				lblData.put("fValue",retVal);
    				break;
    			}
    			checkAlarm(dccGrpTagList.get(i), lblData);
    			
    			lblDataList.add(lblData);
    		}else {
    			lblDataList.add(new HashMap());
    		}
    	}
    	
    	rtnMap.put("lblDataList", lblDataList);
   	
    	return rtnMap; 
	}
	
	private String setDataConv(int i, String fVal, List<Map> dccGrpTagList, String sMenuNo, Long lGap) {
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
		
		String strIOType = dccGrpTagList.get(i).get("IOTYPE") == null ? "" : dccGrpTagList.get(i).get("IOTYPE").toString();
		String strIOBit = dccGrpTagList.get(i).get("IOBIT") == null ? "" : dccGrpTagList.get(i).get("IOBIT").toString();
		String strSvaeCore = dccGrpTagList.get(i).get("SaveCore") == null ? "" : dccGrpTagList.get(i).get("SaveCore").toString();
		String strBScale = dccGrpTagList.get(i).get("BScale") == null ? "" : dccGrpTagList.get(i).get("BScale").toString();
		String strAddress = dccGrpTagList.get(i).get("ADDRESS") == null ? "" : dccGrpTagList.get(i).get("ADDRESS").toString();
		String strFastIOChk = dccGrpTagList.get(i).get("FASTIOCHK") == null ? "" : dccGrpTagList.get(i).get("FASTIOCHK").toString();
		
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
	
	private void checkAlarm(Map dccGrpTag, Map lblData) {
		String strAlarmType = dccGrpTag.get("AlarmType").toString();
		String strDataLimit1 = dccGrpTag.get("DataLimit1").toString();
		String strDataLimit2 = dccGrpTag.get("DataLimit2").toString();
		
		switch( strAlarmType ) {
			case "1" : 
			case "7" :
			case "4" :
						if( !String.valueOf(cnstErr).equals(lblData.get("fValue")) ) {
							if( Double.parseDouble(lblData.get("fValue").toString()) >= Double.parseDouble(strDataLimit1) ) {
								lblData.put("ForeColor", "#FF&");
							}else {
								lblData.put("ForeColor", "#FF0000");
							}					
						}
				  		break;
			case "2" : 
			case "8" :
			case "5" :
						if( !String.valueOf(cnstErr).equals(lblData.get("fValue")) ) {
							if( Double.parseDouble(lblData.get("fValue").toString()) <= Double.parseDouble(strDataLimit1) ) {
								lblData.put("ForeColor", "#FF&");
							}else {
								lblData.put("ForeColor", "#FF0000");
							}					
						}
				  		break;
			case "3" : 
			//case "7" :
			case "6" :
						if( !String.valueOf(cnstErr).equals(lblData.get("fValue")) ) {
							if(Double.parseDouble(lblData.get("fValue").toString()) > Double.parseDouble(strDataLimit1) || Double.parseDouble(lblData.get("fValue").toString()) < Double.parseDouble(strDataLimit2)) {
								lblData.put("ForeColor", "#FF&");
							}else {
								lblData.put("ForeColor", "#FF0000");
							}					
						}				
				  		break;
		}		
	}
	
	public String selectScanTime(DccSearchTrend dccSearchTrend){
		List<String> scanTimeList = dccTrendMapper.selectScanTime(dccSearchTrend);
		
		String res = scanTimeList.size() > 0 ? scanTimeList.get(0) : "";
		if( res.length() > 19 ) res = res.substring(0,19);
		
		return res;
	}
	
	public List<Map> getGrpTag(Map searchMap) {
		List<Map> grpTagList = dccTrendMapper.selectGrpTagList(searchMap);
		List<Map> getTagInfoList = new ArrayList<Map>();
		
		int idx=0;
		for( Map grpTag : grpTagList ) {
			Map grpTagInfo = new HashMap();
			
			if( "D".equalsIgnoreCase(grpTag.get("Gubun").toString()) ) {
				grpTagInfo.put("Gubun","D");
				grpTagInfo.put("Hogi",grpTag.get("Hogi").toString());
				grpTagInfo.put("ADDRESS",grpTag.get("ADDRESS") == null ? "" : grpTag.get("ADDRESS").toString());
				String strFastIOChk = grpTag.get("FASTIOCHK") == null ? "0" : grpTag.get("FASTIOCHK").toString();
				grpTagInfo.put("FASTIOCHK",strFastIOChk);
				
				if( "1".equals(strFastIOChk) ) {
					ComDccGrpTagInfo dccGrpTagInfo = new ComDccGrpTagInfo();
					dccGrpTagInfo.setHogi(grpTagInfo.get("Hogi").toString());
					dccGrpTagInfo.setADDRESS(grpTagInfo.get("ADDRESS").toString());
					
					String fldNo = basDccOsmsMapper.selectFastIoChk(dccGrpTagInfo);
					
					if( fldNo == null ) {
						grpTagInfo.put("FLDNO_FAST","0");
					} else {
						grpTagInfo.put("FLDNO_FAST",fldNo);
					}
				}
				
				if( "0".equals(strFastIOChk) || ( "1".equals(strFastIOChk) && Integer.parseInt(grpTagInfo.get("FLDNO_FAST").toString()) > 0 ) ) {
					grpTagInfo.put("iSeq",grpTag.get("iSeq").toString());
					grpTagInfo.put("GrpHogi",grpTag.get("GrpHogi").toString());
					grpTagInfo.put("XYGubun",grpTag.get("XYGubun").toString());
					grpTagInfo.put("BScale",grpTag.get("BSCAL") == null ? "" : grpTag.get("BSCAL").toString());
					grpTagInfo.put("LOOPNAME",grpTag.get("LOOPNAME") == null ? "" : grpTag.get("LOOPNAME").toString());
					grpTagInfo.put("Unit",grpTag.get("UNIT") == null ? "" : ConvertUnit(grpTag.get("UNIT").toString()));
					grpTagInfo.put("AlarmType",grpTag.get("TYPE") == null ? "0" : grpTag.get("TYPE").toString());
					
					switch( grpTag.get("TYPE").toString() ) {
						case "1": case "2":
							grpTagInfo.put("DataLimit1",grpTag.get("LIMIT1") == null ? cnstErr+"" : grpTag.get("LIMIT1").toString());
							break;
						case "3": case "7": case "8":
							grpTagInfo.put("DataLimit1",grpTag.get("LIMIT1") == null ? cnstErr+"" : grpTag.get("LIMIT1").toString());
							grpTagInfo.put("DataLimit2",grpTag.get("LIMIT2") == null ? cnstErr+"" : grpTag.get("LIMIT2").toString());
							break;
						case "4": case "5":
							grpTagInfo.put("DataLimit1",grpTag.get("LIMIT1") == null ? cnstErr+"" : "1");
							break;
						case "6":
							String tmpLimit = grpTag.get("LIMIT1") == null ? cnstErr+"" : "1";
							if( grpTag.get("LIMIT2") == null ) {
								grpTagInfo.put("DataLimit1",grpTag.get("LIMIT2") == null ? cnstErr+"" : tmpLimit);
							} else {
								grpTagInfo.put("DataLimit2","1");
							}
							break;
						default:
							grpTagInfo.put("DataLimit1",grpTag.get("LIMIT1") == null ? cnstErr+"" : grpTag.get("LIMIT1").toString());
							grpTagInfo.put("DataLimit2",grpTag.get("LIMIT2") == null ? cnstErr+"" : grpTag.get("LIMIT2").toString());
							break;
					}
					grpTagInfo.put("SaveCore",grpTag.get("SaveCoreChk") == null ? "0" : grpTag.get("SaveCoreChk").toString());
					grpTagInfo.put("IOTYPE",grpTag.get("IOTYPE") == null ? "" : grpTag.get("IOTYPE").toString());
					grpTagInfo.put("IOBIT",grpTag.get("IOBIT") == null ? "" : grpTag.get("IOBIT").toString());
					grpTagInfo.put("TBLNO",grpTag.get("TBLNO") == null ? cnstErr+"" : grpTag.get("TBLNO").toString());
					grpTagInfo.put("FLDNO",grpTag.get("FLDNO") == null ? cnstErr+"" : grpTag.get("FLDNO").toString());
					grpTagInfo.put("Descr",grpTag.get("Descr") == null ? "" : grpTag.get("Descr").toString());
					grpTagInfo.put("MinVal",grpTag.get("MinVal") == null ? "0" : grpTag.get("MinVal").toString());
					grpTagInfo.put("MaxVal",grpTag.get("MaxVal") == null ? "100" : grpTag.get("MaxVal").toString());
					grpTagInfo.put("DataLoop",grpTag.get("DataLoop") == null ? "" : grpTag.get("DataLoop").toString());
					grpTagInfo.put("ELOW",grpTag.get("ELOW") == null ? "0" : grpTag.get("ELOW").toString());
					grpTagInfo.put("EHIGH",grpTag.get("EHIGH") == null ? "0" : grpTag.get("EHIGH").toString());
					grpTagInfo.put("VLOW",grpTag.get("VLOW") == null ? "0" : grpTag.get("VLOW").toString());
					grpTagInfo.put("VHIGH",grpTag.get("VHIGH") == null ? "0" : grpTag.get("VHIGH").toString());
					if( "AI".equalsIgnoreCase(grpTagInfo.get("IOTYPE").toString()) && ("2010".equals(grpTagInfo.get("ADDRESS")) || "2140".equals(grpTagInfo.get("ADDRESS"))) ) {
						grpTagInfo.replace("Unit","DAC");
					}
					
					String strDescr = grpTagInfo.get("Descr").toString();
					String strHogi = grpTagInfo.get("Hogi").toString();
					String strIOType = grpTagInfo.get("IOTYPE").toString();
					String strAddress = grpTagInfo.get("ADDRESS").toString();
					String strIOBit = grpTagInfo.get("IOBIT").toString();
					
					if( !"".equals(grpTagInfo.get("IOBIT")) ) {
						grpTagInfo.put("tooltipText",strDescr+"["+strHogi+":"+strIOType+"-"+strAddress+":"+strIOBit+"]");
					} else {
						grpTagInfo.put("tooltipText",strDescr+"["+strHogi+":"+strIOType+"-"+strAddress+"]");
					}
				}
			} else {
				grpTagInfo.put("Gubun","M");
				grpTagInfo.put("Signal_Name",grpTag.get("Signal_Name") == null ? "" : grpTag.get("Signal_Name").toString().trim());
				grpTagInfo.put("UNIT_DIV",grpTag.get("UNIT_DIV") == null ? "" : grpTag.get("UNIT_DIV").toString());
				grpTagInfo.put("Unit",grpTag.get("UNIT_M") == null ? "" : grpTag.get("UNIT_M").toString());
				grpTagInfo.put("Hogi",grpTag.get("HOGI_M") == null ? "" : grpTag.get("HOGI_M").toString().trim());
				grpTagInfo.put("GAIN",grpTag.get("GAIN") == null ? "" : grpTag.get("GAIN").toString());
				grpTagInfo.put("Offset",grpTag.get("OFFSET") == null ? "" : grpTag.get("OFFSET").toString());
				grpTagInfo.put("IOTYPE",grpTag.get("IOTYPE_M") == null ? "" : grpTag.get("IOTYPE_M").toString());
				grpTagInfo.put("Register",grpTag.get("Register") == null ? "" : grpTag.get("Register").toString());
				grpTagInfo.put("IOBIT",grpTag.get("IOBIT_M") == null ? "" : grpTag.get("IOBIT_M").toString());
				grpTagInfo.put("TBLNO",grpTag.get("TBLNO_M") == null ? "-1" : grpTag.get("TBLNO_M").toString());
				grpTagInfo.put("FLDNO",grpTag.get("FLDNO_M") == null ? "-1" : grpTag.get("FLDNO_M").toString());
				grpTagInfo.put("BScale",grpTag.get("BScal_M") == null ? "0" : grpTag.get("BScal_M").toString());
				grpTagInfo.put("iSeq",grpTag.get("iSeq_M") == null ? "-1" : grpTag.get("iSeq_M").toString());
				grpTagInfo.put("Signal_Desc",grpTag.get("Signal_Desc") == null ? "0" : grpTag.get("Signal_Desc").toString().trim());
				grpTagInfo.put("D0",grpTag.get("d0") == null ? "" : grpTag.get("d0").toString());
				grpTagInfo.put("D1",grpTag.get("d1") == null ? "" : grpTag.get("d1").toString());
				grpTagInfo.put("SaveCoreChk",grpTag.get("SaveCoreChk") == null ? "0" : grpTag.get("SaveCoreChk").toString());
				grpTagInfo.put("MinVal",grpTag.get("MinVal") == null ? "-1" : grpTag.get("MinVal").toString());
				grpTagInfo.put("MaxVal",grpTag.get("MaxVal") == null ? "-1" : grpTag.get("MaxVal").toString());
				grpTagInfo.put("Descr",grpTag.get("Descr_M").toString());
				
				String strSignalName = grpTagInfo.get("Signal_Name").toString();
				String strHogi = grpTagInfo.get("Hogi").toString();
				String strUnitDiv = grpTagInfo.get("UNIT_DIV").toString();
				String strRegister = grpTagInfo.get("Register").toString();
				String strIOBit = grpTagInfo.get("IOBIT").toString();
				
				if( idx < grpTagList.size() ) {
					if( grpTagInfo.get("Register").toString().compareTo("0400") > 0 ) {
						grpTagInfo.put("tooltipText",strSignalName+"["+strHogi+"-"+strUnitDiv+":"+strRegister+"-"+strIOBit+"]");
					} else {
						grpTagInfo.put("tooltipText",strSignalName+"["+strHogi+"-"+strUnitDiv+":"+strRegister+"]");
					}
				}
			}
			idx++;
			getTagInfoList.add(grpTagInfo);
		}
		return getTagInfoList;
	}
	
	private String ConvertUnit(String strUnit) {
	      String strConUnit;
	    
			    switch (strUnit.toUpperCase()) {
			        case "G:SEC" : 
			            strConUnit = "G/S"; break;
			        case "KG:HR" :
			            strConUnit = "KG/HR"; break;
			        case "L:MIN" :
			            strConUnit = "L/MIN"; break;
			        case "L:SEC" :
			            strConUnit = "L/S"; break;
			        case "M3:HR" :
			            strConUnit = "M3/H"; break;
			        case "ML:S":
			            strConUnit = "ML/S";    break;
			        case "DECADE" :
			            strConUnit = "DEC";    break;
			        case "FP:HR" :
			            strConUnit = "FP/HR";    break;
			        case "VOLTS" :
			            strConUnit = "V";    break;
			        case "DEGC:H" :
			            strConUnit = "DEGC/H";    break;
			        case "M:MIN" :
			            strConUnit = "M/MIN";    break;
			        case "MM:HR" :
			            strConUnit = "MM/HR";    break;
			        case "MM:SEC" :
			            strConUnit = "MM/S";    break;
			        case "MW:MIN" :
			            strConUnit = "MW/MIN";    break;
			        case "METERS":
			        case "METRES":
			            strConUnit = "M";    break;
			        case "MS:M" :
			            strConUnit = "MSIE/M";    break;
			        case "US:M" :
			            strConUnit = "USIE/M";    break;
			        case "CI:M3" :
			            strConUnit = "CI/M3";    break;
			        case "DEC:S" :
			            strConUnit = "DEC/S";    break;
			        case "KCNT:M" :
			            strConUnit = "KCNT/M";    break;
			        case "KCNT:S" :
			            strConUnit = "KCNT/S";    break;
			        case "MCI:M3" :
			            strConUnit = "MCI/M3";    break;
			        case "MGY:HR":
			        case "MGY/HR" :
			            strConUnit = "mGy/hr";    break;
			        case "MILLIK" :
			            strConUnit = "MK";    break;
			        case "MR:HR" :
			            strConUnit = "MREM/H";    break;
			        case "R:HR" :
			            strConUnit = "REM/H";    break;
			        case "DEGC"  :
			        case "DEG C" :
			            strConUnit = "°C";    break;
			        case "LD:LG" :
			            strConUnit = "KD/LAG";    break;
			        case "NOTAVL" :
			            strConUnit = "N/A";    break;
			        case "PERU" :
			            strConUnit = "P.U.";    break;
			        default  :
			            strConUnit = strUnit;    break;
			    }
	    
	    return strConUnit;

	}
	
	private LocalDateTime convDtm(String date, boolean isMilli) {
		String[] pDate = date.split(" ")[0].split("-");
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
	
	private String addDate(String type, String dtm, int diff) {
		LocalDateTime ldt = convDtm(dtm,true);
		String rtv = "";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		boolean isMinus = diff < 0 ? true : false;
		String millis = "";
		String tmpMillis = dtm.indexOf(".") > -1 ? dtm.substring(dtm.indexOf(".")+1,dtm.length()) : "0";
		
		System.out.println("diff and isMinus ::: "+diff+", "+isMinus);
		
		switch( type ) {
		case "y":
			if( isMinus ) {
				rtv = ldt.minusYears(diff).format(dtf)+"."+tmpMillis;
			} else {
				rtv = ldt.plusYears(diff).format(dtf)+"."+tmpMillis;
			}
			break;
		case "m":
			if( isMinus ) {
				rtv = ldt.minusMonths(diff).format(dtf)+"."+tmpMillis;
			} else {
				rtv = ldt.plusMonths(diff).format(dtf)+"."+tmpMillis;
			}
			break;
		case "d":
			if( isMinus ) {
				rtv = ldt.minusDays(diff).format(dtf)+"."+tmpMillis;
			} else {
				rtv = ldt.plusDays(diff).format(dtf)+"."+tmpMillis;
			}
			break;
		case "h":
			if( isMinus ) {
				rtv = ldt.minusHours(diff).format(dtf)+"."+tmpMillis;
			} else {
				rtv = ldt.plusHours(diff).format(dtf)+"."+tmpMillis;
			}
			break;
		case "n":
			if( isMinus ) {
				rtv = ldt.minusMinutes(diff).format(dtf)+"."+tmpMillis;
			} else {
				rtv = ldt.plusMinutes(diff).format(dtf)+"."+tmpMillis;
			}
			break;
		case "s":
			if( isMinus ) {
				rtv = ldt.minusSeconds(diff).format(dtf)+"."+tmpMillis;
			} else {
				rtv = ldt.plusSeconds(diff).format(dtf)+"."+tmpMillis;
			}
			break;
		case "mi":
			int newMillis = Integer.parseInt(tmpMillis)*1000 + diff*1000;
			System.out.println("tmpMillis : "+tmpMillis+", newMillis : "+newMillis);
			
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
	
	public List<Map> rsTrend5sGap(Map trendSearchMap, List<ComTagDccInfo> dccGrpTagList, Long lGap, String strFast) {
		List<Map> rtnList = new ArrayList();
		Map onlyDate = new HashMap();
		Map onlyDate2 = new HashMap();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String minDate = trendSearchMap.get("startDate") == null ? "" : trendSearchMap.get("startDate").toString();
		String maxDate = trendSearchMap.get("endDate") == null ? "" : trendSearchMap.get("endDate").toString();
		String curDate = minDate;
		Map get4Map = new HashMap();
		get4Map.put("type","3");
		String now_minTime = dccTrendMapper.selectMinScantime(get4Map);
		String thistime = "";
		String thistime2 = "";
		
		System.out.println("chkDate ::: "+curDate+", "+maxDate);
		while( convDtm(curDate,true).compareTo(convDtm(maxDate,true)) <= 0 ) {
			//onlyDate.clear();
			//onlyDate2.clear();
			
			String sTime = curDate;
			String eTime = "";
			if( "F".equalsIgnoreCase(strFast) ) {
				eTime = dtf.format(convDtm(curDate,true).plusNanos(800*10^6));
				
				for( int ti=1;ti<dccGrpTagList.size()+1;ti++ ) {
					Map searchMap = new HashMap();
					
					searchMap.put("hogi",dccGrpTagList.get(ti-1).getHogi());
					searchMap.put("startDate",sTime);
					searchMap.put("endDate",eTime);
					searchMap.put("seq","1");
					searchMap.put("type","1");
					
					thistime = dccTrendMapper.selectMinScantime(searchMap);
					thistime = thistime == null ? curDate : thistime;
					
					onlyDate.put(ti,thistime);
					
					
				}
			} else {
				eTime = dtf.format(convDtm(curDate,true).plusNanos(7000*10^6));
				
				System.out.println("chk1 :: "+eTime+", "+now_minTime);
				
				if( convDtm(now_minTime,true).compareTo(convDtm(eTime,true)) > 0 ) {
					for( int ti=1;ti<dccGrpTagList.size()+1;ti++ ) {
						Map searchMap = new HashMap();
						
						searchMap.put("hogi",dccGrpTagList.get(ti-1).getHogi());
						searchMap.put("startDate",sTime);
						searchMap.put("endDate",eTime);
						searchMap.put("seq",dccGrpTagList.get(ti-1).getTBLNO());
						searchMap.put("type","2");
						
						thistime = dccTrendMapper.selectMinScantime(searchMap);
						thistime = thistime == null ? curDate : thistime;
						
						onlyDate2.put(ti,thistime2);
					}
				} else {
					for( int ti=1;ti<dccGrpTagList.size()+1;ti++ ) {
						Map searchMap = new HashMap();
						
						searchMap.put("hogi",dccGrpTagList.get(ti-1).getHogi());
						searchMap.put("startDate",sTime);
						searchMap.put("endDate",eTime);
						searchMap.put("seq",dccGrpTagList.get(ti-1).getTBLNO());
						searchMap.put("type","0");
						
						thistime = dccTrendMapper.selectMinScantime(searchMap);
						thistime = thistime == null ? curDate : thistime;
						
						onlyDate.put(ti,thistime);
					}
				}
			}
			
			curDate = dtf.format(convDtm(curDate,true).plusNanos(lGap*10^6));
			System.out.println("cur/only :: "+curDate+", "+onlyDate.get(1));
			if( convDtm(curDate,true).compareTo(convDtm(onlyDate.get(1).toString(),true)) == 0 ) {
				curDate = dtf.format(convDtm(curDate,true).plusNanos(1000*10^6));
			}
		}

		int idx=0;
		Map temp = new HashMap();
		if( !"F".equalsIgnoreCase(strFast) ) {
			
			if( onlyDate.size() > 0 ) {
				temp.put(0,onlyDate2.get(1).toString());
				for( int vi=1;vi<dccGrpTagList.size()+1;vi++ ) {
					Map searchMap = new HashMap();
					
					searchMap.put("hogi",dccGrpTagList.get(vi-1).getHogi());
					searchMap.put("startDate",onlyDate2.get(vi).toString());
					searchMap.put("seq",dccGrpTagList.get(vi-1).getTBLNO());
					searchMap.put("FldNo",dccGrpTagList.get(vi-1).getFLDNO());
					searchMap.put("type","1");
					
					String tmpValue = dccTrendMapper.selectTValueTrend(searchMap);
					temp.put(vi,tmpValue);
					
					if( "F".equalsIgnoreCase(strFast) ) {
						temp.replace(0,temp.get(0).toString().length() != 23 ? temp.get(0).toString()+".000" : temp.get(0).toString());
					} else {
						temp.replace(0,temp.get(0).toString().length() > 19 ? temp.get(0).toString().substring(0,19) : temp.get(0).toString());
					}
				}
			}
			
			rtnList.add(idx,temp);
			idx++;
		}
		
		if( onlyDate2.size() > 0 ) {
			//temp.clear();
			temp.put(0,onlyDate.get(1).toString());
			for( int vi=1;vi<dccGrpTagList.size()+1;vi++ ) {
				Map searchMap = new HashMap();
	
				searchMap.put("hogi",dccGrpTagList.get(vi-1).getHogi());
				searchMap.put("startDate",onlyDate.get(vi).toString());
				if( "F".equalsIgnoreCase(strFast) ) {
					searchMap.put("seq","1");
					searchMap.put("FldNo",dccGrpTagList.get(vi-1).getFLDNO_FAST());
					searchMap.put("type","2");
				} else {
					searchMap.put("seq",dccGrpTagList.get(vi-1).getTBLNO());
					searchMap.put("FldNo",dccGrpTagList.get(vi-1).getFLDNO());
					searchMap.put("type","0");
				}
	
				String tmpValue = dccTrendMapper.selectTValueTrend(searchMap);
				temp.put(vi,tmpValue);
				
				if( "F".equalsIgnoreCase(strFast) ) {
					temp.replace(0,temp.get(0).toString().length() != 23 ? temp.get(0).toString()+".000" : temp.get(0).toString());
				} else {
					temp.replace(0,temp.get(0).toString().length() > 19 ? temp.get(0).toString().substring(0,19) : temp.get(0).toString());
				}
			}
			rtnList.add(idx,temp);
		}
		
		return rtnList;
	}
	
	@Override
	public int manageTrendProc(String procBody) {
		return dccTrendMapper.manageTrendProc(procBody);
	}
	
	@Override
	public List<Map> callTrendProc(Map procInfo) {
		return dccTrendMapper.callTrendProc(procInfo);
	}
	
	@Override
	public int deleteGrpTag(Map trendSearchMap) {
		return dccTrendMapper.deleteGrpTag(trendSearchMap);
	}
	
	@Override
	public String selectISeqTagDccSearch(Map trendSearchMap) {
		return dccTrendMapper.selectISeqTagDccSearch(trendSearchMap);
	}
	
	@Override
	public int insertGrpTag(Map trendSearchMap) {
		return dccTrendMapper.insertGrpTag(trendSearchMap);
	}
	
	@Override
	public List<Map> selectSetIOList(DccSearchTrend dccSearchTrend) {
		return dccTrendMapper.selectSetIOList(dccSearchTrend);
	}
}
