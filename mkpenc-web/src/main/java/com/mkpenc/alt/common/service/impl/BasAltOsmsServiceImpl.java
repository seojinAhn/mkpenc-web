package com.mkpenc.alt.common.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.alt.common.mapper.BasAltOsmsMapper;
import com.mkpenc.alt.common.model.ComAltGrpTagInfo;
import com.mkpenc.alt.common.model.ComTagAltInfo;
import com.mkpenc.alt.common.service.BasAltOsmsService;


@Service("basAltOsmsService")
public class BasAltOsmsServiceImpl implements BasAltOsmsService{
	
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
	
	@Autowired
	private CommonConstant commonConstant;	
	
	@Autowired
	private BasAltOsmsMapper basAltOsmsMapper;
	
	public List<ComTagAltInfo> getDccGrpTagList(Map searchMap) {
		
		List<ComAltGrpTagInfo> altGrpTagInfoList = basAltOsmsMapper.selectDccGrpTagList(searchMap);
		
		List<ComTagAltInfo> tagAltInfoList = new ArrayList();
		
		for(ComAltGrpTagInfo altGrpTagInfo:altGrpTagInfoList) {
			
			ComTagAltInfo tagAltInfo = new ComTagAltInfo();
						
			tagAltInfo.setHogi(altGrpTagInfo.getHogi());
			tagAltInfo.setADDRESS(altGrpTagInfo.getADDRESS() == null? "": altGrpTagInfo.getADDRESS());
			tagAltInfo.setFASTIOCHK(altGrpTagInfo.getFASTIOCHK());
			
			if(altGrpTagInfo.getFASTIOCHK() == 1){
				
				String fldNo = basAltOsmsMapper.selectFastIoChk(altGrpTagInfo) ;
				
				if(fldNo == null || fldNo.isEmpty()) {
					tagAltInfo.setFLDNO_FAST(0);
				}else {
					tagAltInfo.setFLDNO_FAST(Integer.parseInt(fldNo));
				}
			}
			
			if(tagAltInfo.getFASTIOCHK() == 0 || (tagAltInfo.getFASTIOCHK() == 1 &&  tagAltInfo.getFLDNO_FAST() > 0)){
				
				tagAltInfo.setiSeq(altGrpTagInfo.getiSeq());
				tagAltInfo.setGrpHogi(altGrpTagInfo.getGrpHogi());
				tagAltInfo.setXYGubun(altGrpTagInfo.getXYGubun());
				tagAltInfo.setBScale(altGrpTagInfo.getBSCAL());
				tagAltInfo.setLOOPNAME(altGrpTagInfo.getLOOPNAME() == null? "": altGrpTagInfo.getLOOPNAME());
				tagAltInfo.setUnit(ConvertUnit(altGrpTagInfo.getUNIT()));
				tagAltInfo.setAlarmType(altGrpTagInfo.getTYPE() == null? "0": altGrpTagInfo.getTYPE());
								
				//NULL EXIST
				altGrpTagInfo.setTYPE(altGrpTagInfo.getTYPE() == null? "0": altGrpTagInfo.getTYPE());
				
				switch(altGrpTagInfo.getTYPE()) {
						case "1":        			//HI, LO
						case "2":   
							tagAltInfo.setDataLimit1((altGrpTagInfo.getLIMIT1() == null? -32768: altGrpTagInfo.getLIMIT1()));
							break;
						case "3":        			//HI/LO, HI/VH, LO/VL
						case "7":   
						case "8":
							tagAltInfo.setDataLimit1((altGrpTagInfo.getLIMIT1() == null? -32768: altGrpTagInfo.getLIMIT1()));
							tagAltInfo.setDataLimit2((altGrpTagInfo.getLIMIT2() == null? -32768: altGrpTagInfo.getLIMIT2()));
							break;
						case "4":   				// HI(DTAB), LO(DTAB)
						case "5":
							tagAltInfo.setDataLimit1((altGrpTagInfo.getLIMIT1() == null? -32768:1));
							break;
						case "6":					//HI/LO(DTAB)
							tagAltInfo.setDataLimit1((altGrpTagInfo.getLIMIT1() == null? -32768:1));
							if(altGrpTagInfo.getLIMIT2() == null) {
								tagAltInfo.setDataLimit1(-32768);
							} else {
								tagAltInfo.setDataLimit2(1);
							}
							break;
						 default :
								tagAltInfo.setDataLimit1((altGrpTagInfo.getLIMIT1() == null? -32768: altGrpTagInfo.getLIMIT1()));
								tagAltInfo.setDataLimit2((altGrpTagInfo.getLIMIT2() == null?-32768: altGrpTagInfo.getLIMIT2()));
							 
				} // end switch
				
				tagAltInfo.setSaveCore(altGrpTagInfo.getSaveCoreChk());
	            tagAltInfo.setIOTYPE(altGrpTagInfo.getIOTYPE() == null? "": altGrpTagInfo.getIOTYPE());
	            tagAltInfo.setIOBIT(altGrpTagInfo.getIOBIT());
	            tagAltInfo.setTBLNO(altGrpTagInfo.getTBLNO() == 0? -32768: altGrpTagInfo.getTBLNO());
	            tagAltInfo.setFLDNO(altGrpTagInfo.getFLDNO() == 0? -32768: altGrpTagInfo.getFLDNO());
	            tagAltInfo.setDescr(altGrpTagInfo.getDescr() == null? "": altGrpTagInfo.getDescr());
	            tagAltInfo.setMinVal(altGrpTagInfo.getMinVal());
	            tagAltInfo.setMaxVal(altGrpTagInfo.getMaxVal());
	            tagAltInfo.setDataLoop(altGrpTagInfo.getTYPE() == null? "": altGrpTagInfo.getDataLoop());
	            tagAltInfo.setELOW(altGrpTagInfo.getELOW());
	            tagAltInfo.setEHIGH(altGrpTagInfo.getEHIGH());
	            tagAltInfo.setVLOW(altGrpTagInfo.getVLOW());
	            tagAltInfo.setVHIGH(altGrpTagInfo.getVHIGH());
				  
				
				// '-* AI2010, AI2140
				if( tagAltInfo.getIOTYPE().equals("AI") &&  (tagAltInfo.getADDRESS().equals("2010") ||  tagAltInfo.getADDRESS().equals("2140"))){
					tagAltInfo.setUnit("DAC");
					tagAltInfo.setMinVal(tagAltInfo.getMinVal() / 0.0081);
					tagAltInfo.setMaxVal(tagAltInfo.getMaxVal() / 0.0081);

			    //   '-* AI2753, AI2754 (MPAG > KPAG)
				}else if( tagAltInfo.getIOTYPE().equals("AI") &&  (tagAltInfo.getADDRESS().equals("2753") ||  tagAltInfo.getADDRESS().equals("2754"))){
					tagAltInfo.setUnit("KPAG"); 
					tagAltInfo.setMinVal(tagAltInfo.getMinVal() * 1000);
					tagAltInfo.setMaxVal(tagAltInfo.getMaxVal() * 1000);
				}else {
					tagAltInfo.setUnit(ConvertUnit(altGrpTagInfo.getUNIT()));
				}
				
				if(tagAltInfo.getIOBIT() != 0) {
					tagAltInfo.setToolTip(tagAltInfo.getDescr() + "[" +tagAltInfo.getHogi() +":" + tagAltInfo.getIOTYPE() +"-" + tagAltInfo.getADDRESS() + ":" + tagAltInfo.getIOBIT() + "]" );
				}else {
					tagAltInfo.setToolTip(tagAltInfo.getDescr() + "[" +tagAltInfo.getHogi() +":" + tagAltInfo.getIOTYPE() +"-" + tagAltInfo.getADDRESS() + "]" );
				}
												
			}// end if
			
			tagAltInfoList.add(tagAltInfo);		
		}
		
		return tagAltInfoList;
		
	}
	
	private String ConvertUnit(String strUnit) {
		
		String strConUnit;
	      
		if(strUnit == null || strUnit.isEmpty()) {
		    	strUnit = "";
		}
	    
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
	
	public String[] getDccValueReturn(Map searchMap) {
		return sqlQueryDcc(searchMap).split("\\|");
	}
	
	public Map getDccValue(Map searchMap, List<ComTagAltInfo> tagAltInfoList){
	
		Map rtnMap = new HashMap();
		
		String[] varValue = null;	
		
		if(commonConstant.getUrl().indexOf("10.135.101.222") > -1) {
			varValue = sqlQueryDcc4hogi(searchMap).split("\\|");
		}else {		
			varValue = sqlQueryDcc(searchMap).split("\\|");
		}

		//*** Start getDccValue 에 포함 된 로직
    	if(varValue != null && varValue.length != 0) {
    		if(varValue[0].length() == 19) {
    			
    			rtnMap.put("SearchTime", searchMap.get("hogi").toString() + " " +  searchMap.get("xyGubun").toString() + " " + varValue[0]);
    			
    			try {
	        			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	       			    java.util.Date date = format.parse(varValue[0]);
	        			
	        			Calendar c = Calendar.getInstance();
	        			c.setTime(date); 
	        			c.add(Calendar.MILLISECOND, 1);
	        			
	        			long searchTime = date.getTime();
	        			long currentTime = System.currentTimeMillis();
	        			
	        			long secondsDifference = (currentTime -searchTime)  / 1000;   
	        			
	        			searchMap.put("TimeGap", secondsDifference);
	        			//System.out.println("1"+searchMap.get("TimeGap"));
	        			
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
    	
    	if( searchMap.get("TimeGap") == null ) {
    		String tmpTimeGap = searchMap.get("strFast") == null ? "5" : searchMap.get("strFast").toString();
    		searchMap.put("TimeGap",("F".equalsIgnoreCase(tmpTimeGap) || "0.5".equals(tmpTimeGap) ? "500" : Integer.parseInt(tmpTimeGap)*1000+""));
    	}
    	
    	List<Map> lblDataList = new ArrayList<Map>();
    	for(int i=0;i<tagAltInfoList.size();i++) {
    		//varValue[0]에는 날짜 데이터가 포함되어 있어 배열 idx + 1
    		if(varValue[i+1] != null && !varValue[i+1].isEmpty()) {
    			double fValue = Double.parseDouble(varValue[i+1]);
    			if(i == 365) { 
    				i = i; 
    			}
    			Map lblData = setDataConv(fValue, tagAltInfoList.get(i), searchMap);
    			checkAlarm(lblData, tagAltInfoList.get(i));
    			
    			lblDataList.add(lblData);
    		}else {
    			lblDataList.add(new HashMap());
    		}
    	}
    	
    	 rtnMap.put("lblDataList", lblDataList);
   	
    	return rtnMap; 
	}

	public Map getDccValueSearch(Map searchMap, List<ComTagAltInfo> tagAltInfoList){
		
		Map rtnMap = new HashMap();
		
		String[] varValue = null;	
		
		if(commonConstant.getUrl().indexOf("10.135.101.222") > -1) {
			varValue = sqlQueryDcc4hogi(searchMap).split("\\|");
		}else {		
			varValue = sqlQueryDccSearch(searchMap).split("\\|");
		}
    	
    	List<Map> lblDataList = new ArrayList<Map>();
    	for(int i=0;i<tagAltInfoList.size();i++) {
    		//varValue[0]에는 날짜 데이터가 포함되어 있어 배열 idx + 1
    		if(varValue[i+1] != null && !varValue[i+1].isEmpty()) {
    			double fValue = Double.parseDouble(varValue[i+1]);
    			if(i == 365) { 
    				i = i; 
    			}
    			//System.out.println("idx=" + i + ":::: fValue = " + fValue);
    			Map lblData = setDataConv(fValue, tagAltInfoList.get(i), searchMap);
    			checkAlarm(lblData, tagAltInfoList.get(i));
    			
    			lblDataList.add(lblData);
    		}else {
    			lblDataList.add(new HashMap());
    		}
    	}
    	
    	 rtnMap.put("lblDataList", lblDataList);
   	
    	return rtnMap; 
	}
	
	private Map setDataConv(double fValue, ComTagAltInfo tagAltInfo, Map searchMap) {
		
		Map dataConv = new HashMap();
		//System.out.println("setDataConv setDataConv ::: IOTYPE = " + fValue + "::::" +  tagDccInfo.getIOTYPE());
		if(fValue == 0) {
			dataConv.put("fValue", "0");
			return dataConv;
		}
		
		//System.out.println("iotype = " + tagDccInfo.getIOTYPE() + ":::: iobit = " + tagDccInfo.getIOBIT() + "::::: address = " + tagDccInfo.getADDRESS() );
		// '- IOTYPE에 대한 설정
	    if( tagAltInfo.getIOTYPE().equals("DI") ||  tagAltInfo.getIOTYPE().equals("DO")){
	        if(tagAltInfo.getIOBIT() != 0) {
	            fValue = Double.parseDouble(GetBitVal(fValue+"", tagAltInfo.getIOBIT()+""));
	        }else {
	        	fValue = 0;
	        }
	    }else if(tagAltInfo.getIOTYPE().equals("SC")) {
	    	 if( tagAltInfo.getSaveCore() == 1 && tagAltInfo.getIOBIT() != -1) {
	    		 //System.out.println("setDataConv setDataConv ::: IOTYPE = " + fValue + "::::" +  tagAltInfo.getIOTYPE() + ";;;;" + tagAltInfo.getIOBIT());
	 	         fValue = Double.parseDouble(GetBitVal(fValue+"", tagAltInfo.getIOBIT()+""));
	 	         //System.out.println("setDataConv setDataConv ::: IOTYPE getbitval= " + fValue + "::::" +  tagAltInfo.getIOTYPE() + ";;;;" + tagAltInfo.getIOBIT());
	    	 }else if( tagAltInfo.getBScale() != 0 && tagAltInfo.getSaveCore() != 1) {
	    		 //System.out.println(Math.pow(2, (15 - tagAltInfo.getBScale())));   
	    		 fValue = fValue / Math.pow(2, (15 - tagAltInfo.getBScale()));
	 	         //System.out.println("setDataConv setDataConv ::: IOTYPE not getbitval= " + fValue + "::::" +  tagAltInfo.getIOTYPE() + ";;;;" + tagAltInfo.getIOBIT());
	 	     }
	    	
	    }else {
	    	  if( tagAltInfo.getIOTYPE().equals("AI") && (tagAltInfo.getADDRESS().equals("2010") ||  tagAltInfo.getADDRESS().equals("2140"))){
	  	            fValue = fValue / 0.0081;
	    	  }
	    }
	    
	    if(searchMap.get("menuNo").equals("21") || searchMap.get("menuNo").equals("22")) {
	    	if(Double.parseDouble(searchMap.get("TimeGap").toString())  < 5000 && tagAltInfo.getFASTIOCHK() == 1 && tagAltInfo.getBScale() != 0 ) {
	    		  fValue = fValue / Math.pow(2, (15 - tagAltInfo.getBScale() ));
	    	}
	    }
	    //System.out.println("fvalue = " + fValue);
	    if( tagAltInfo.getIOTYPE().equals("DI") ||  tagAltInfo.getIOTYPE().equals("DO") || tagAltInfo.getIOTYPE().equals("SC") && tagAltInfo.getSaveCore() == 1){
	    	dataConv.put("fValue", fValue > -32768? String.format("%.5f", fValue) : "***IRR");
	    }else if(tagAltInfo.getBScale() != 0) {
	    	dataConv.put("fValue",  fValue > -32768? String.format(gFormat[tagAltInfo.getBScale()], fValue) : "***IRR");
	    }else {
	    	dataConv.put("fValue", fValue > -32768? String.format("%.5f", fValue) +"": "***IRR");
	    }		
	    
	    return dataConv;
	}
	
	private void checkAlarm(Map lblData, ComTagAltInfo tagAltInfo) {
		
		switch(tagAltInfo.getAlarmType()) {
			case "1" : 
			case "7" :
			case "4" :
						if(!"***IRR".equals(lblData.get("fValue")) && !"0".equals(lblData.get("fValue"))) {
							if(Double.parseDouble(lblData.get("fValue").toString()) >=  tagAltInfo.getDataLimit1()) {
								lblData.put("ForeColor", "#FF&");
							}else {
								lblData.put("ForeColor", "#FF0000");
							}					
						}
				  		break;
			case "2" : 
			case "8" :
			case "5" :
						if(!"***IRR".equals(lblData.get("fValue")) && !"0".equals(lblData.get("fValue"))) {
							if(Double.parseDouble(lblData.get("fValue").toString()) <=  tagAltInfo.getDataLimit1()) {
								lblData.put("ForeColor", "#FF&");
							}else {
								lblData.put("ForeColor", "#FF0000");
							}					
						}
				  		break;
			case "3" : 
			//case "7" :
			case "6" :
						if(!"***IRR".equals(lblData.get("fValue")) && !"0".equals(lblData.get("fValue"))) {
							if(Double.parseDouble(lblData.get("fValue").toString()) >  tagAltInfo.getDataLimit1() || Double.parseDouble(lblData.get("fValue").toString()) <  tagAltInfo.getDataLimit2()) {
								lblData.put("ForeColor", "#FF&");
							}else {
								lblData.put("ForeColor", "#FF0000");
							}					
						}				
				  		break;
		}		
	}
	
	// - 디지털 값을 가져온다.(16bit -> 1bit)
	//private int GetBitVal(ByVal DigitalValue As String, ByVal DigitalBit As String) As String
	private String GetBitVal(String digitalValue, String digitalBit) {
	    
	    long Rest = 0;
	    
	    double di_val;
	    int bit_no;	    
	    
	    if(digitalBit.isEmpty()) {
	       if(digitalValue == null) {
	    	   return "";
	       }else {
	    	   return digitalValue;
	       }
	    }
	    
	    di_val = Double.parseDouble(digitalValue);	    
	    bit_no = Integer.parseInt(digitalBit);

	    for(int i = 0;i <= bit_no;i++) {
	    	
	        Rest = Math.round(di_val % 2);
	        di_val = Math.floor(di_val / 2);
		}
	    
	    return Rest +"";
	}
	
	private String sqlQueryDcc(Map searchMap) {
		
		String pSCanTime ="";
		
		/*
		  if strUserID <> "" then
	    	pSQL = "UPDATE MST_USER SET UserIP = '" & strIp & "', conntime = getdate()"
	    	pSQL = pSQL & ", Login = 'Y', LoginHogi = '" & strHogi & "'"
	    	pSQL = pSQL & " WHERE ID = '" & strUserID & "'"
	    	conn1.execute(pSQL)
	    End If
	    */
				
		Map scantime = basAltOsmsMapper.selectScanTime(searchMap);
		
		if(scantime != null && scantime.get("SCANTIME") != null) {
			pSCanTime = scantime.get("SCANTIME") .toString();
		}
		
		searchMap.put("pSCanTime", pSCanTime);
	
		List<Map> tblNoFldNoList = basAltOsmsMapper.selectTblNoFldNo(searchMap);
		
		/*
		String[] iTBLNO = new String[400];
		String[] iFLDNO = new String[400];
	
		
		int iTagCnt = 0;
		int iTblCnt = 0;
				
		for(Map tblNoFldNo:tblNoFldNoList) {
			iTBLNO[iTagCnt] = tblNoFldNo.get("TBLNO").toString();
			iFLDNO[iTagCnt] = tblNoFldNo.get("FLDNO").toString();		
			
			iTagCnt = iTagCnt + 1;			
		}
		*/
		
		List<Map> vValue = basAltOsmsMapper.selectLogDccTrend(searchMap);
		
	    String pStr = pSCanTime + "|";
	    for(int i=0;i<tblNoFldNoList.size();i++) {
	    	
	    	String iTBLNO = tblNoFldNoList.get(i).get("TBLNO") != null? tblNoFldNoList.get(i).get("TBLNO").toString():"";
	    	String iFLDNO = tblNoFldNoList.get(i).get("FLDNO") != null? tblNoFldNoList.get(i).get("FLDNO").toString():"";
	    	
	    	int j=0;
	    	for(j=0;j<vValue.size();j++) {

	    		String seq = vValue.get(j).get("SEQ") != null? vValue.get(j).get("SEQ").toString():"";
	    	
	    		if(iTBLNO.equals(seq)) {
	    			break;
	    		}
	    	}
	    	
	    	//System.out.println(j +  "::::" +iTBLNO  + "::::" + iFLDNO);
	    	
	    	 if(j >= vValue.size()) {
	    		 pStr = pStr + "|";
	    	 }else {
	    		 // *** field 명 확인 필요 ***
	    		 pStr = pStr + vValue.get(j).get("TVALUE"+ Integer.parseInt(iFLDNO)) +  "|";
	    	 }
	    	
	    }
	    	   
	    pStr = pStr + "}";    

		return pStr;
		
	}
	
	private String sqlQueryDccSearch(Map searchMap) {
		
		String pSCanTime = searchMap.get("startDate") == null ? "" : searchMap.get("startDate").toString();
		searchMap.put("pSCanTime", pSCanTime);
		/*
		  if strUserID <> "" then
	    	pSQL = "UPDATE MST_USER SET UserIP = '" & strIp & "', conntime = getdate()"
	    	pSQL = pSQL & ", Login = 'Y', LoginHogi = '" & strHogi & "'"
	    	pSQL = pSQL & " WHERE ID = '" & strUserID & "'"
	    	conn1.execute(pSQL)
	    End If
	    */
		
		if( "".equals(pSCanTime) ) {
			Map scantime = basAltOsmsMapper.selectScanTime(searchMap);
			
			if(scantime != null && scantime.get("SCANTIME") != null) {
				pSCanTime = scantime.get("SCANTIME") .toString();
			}
			
			searchMap.put("pSCanTime", pSCanTime);
		}
	
		List<Map> tblNoFldNoList = basAltOsmsMapper.selectTblNoFldNo(searchMap);
		
		/*
		String[] iTBLNO = new String[400];
		String[] iFLDNO = new String[400];
	
		
		int iTagCnt = 0;
		int iTblCnt = 0;
				
		for(Map tblNoFldNo:tblNoFldNoList) {
			iTBLNO[iTagCnt] = tblNoFldNo.get("TBLNO").toString();
			iFLDNO[iTagCnt] = tblNoFldNo.get("FLDNO").toString();		
			
			iTagCnt = iTagCnt + 1;			
		}
		*/
		
		List<Map> vValue = basAltOsmsMapper.selectLogDccTrendSearch(searchMap);
		
	    String pStr = pSCanTime + "|";
	    for(int i=0;i<tblNoFldNoList.size();i++) {
	    	
	    	String iTBLNO = tblNoFldNoList.get(i).get("TBLNO") != null? tblNoFldNoList.get(i).get("TBLNO").toString():"";
	    	String iFLDNO = tblNoFldNoList.get(i).get("FLDNO") != null? tblNoFldNoList.get(i).get("FLDNO").toString():"";
	    	
	    	int j=0;
	    	for(j=0;j<vValue.size();j++) {

	    		String seq = vValue.get(j).get("SEQ") != null? vValue.get(j).get("SEQ").toString():"";
	    	
	    		if(iTBLNO.equals(seq)) {
	    			break;
	    		}
	    	}
	    	
	    	//System.out.println(j +  "::::" +iTBLNO  + "::::" + iFLDNO);
	    	
	    	 if(j >= vValue.size()) {
	    		 pStr = pStr + "|";
	    	 }else {
	    		 // *** field 명 확인 필요 ***
	    		 pStr = pStr + vValue.get(j).get("TVALUE"+ Integer.parseInt(iFLDNO)) +  "|";
	    	 }
	    	
	    }
	    	   
	    pStr = pStr + "}";    

		return pStr;
		
	}
	
	private String sqlQueryDcc4hogi(Map searchMap) {		
		
		String pSCanTime ="";	
		
		if(searchMap.get("startDate") != null ) {
			pSCanTime = searchMap.get("startDate").toString();
		}else {
				
			Map scantime = basAltOsmsMapper.selectScanTime(searchMap);
			
			if(scantime != null && scantime.get("SCANTIME") != null) {
				pSCanTime = scantime.get("SCANTIME").toString();
			}
		}
		
		searchMap.put("pSCanTime", pSCanTime);
	
		List<Map> tblNoFldNoList = basAltOsmsMapper.selectTblNoFldNo(searchMap);
		
		String[] iTBLNO = new String[400];
		String[] iFLDNO = new String[400];
		String[] iTBLNO_GRP = new String[400];	
		
		int iTagCnt = 0;
		int iTblCnt = 0;
				
		for(Map tblNoFldNo:tblNoFldNoList) {
			iTBLNO[iTagCnt] = tblNoFldNo.get("TBLNO").toString();
			iFLDNO[iTagCnt] = tblNoFldNo.get("FLDNO").toString();	
			
			int i=0;
			for(i=0;i<iTblCnt;i++) {
				if(iTBLNO[iTagCnt] == iTBLNO_GRP[i]) {
					break;
				}
			}
			
			if(i == iTblCnt) {
				iTBLNO_GRP[iTblCnt] = iTBLNO[iTagCnt];
				iTblCnt = iTblCnt + 1;
			}
			
			iTagCnt = iTagCnt + 1;			
		}
		
		int iValCnt = 0;
		List<Map> vValues = new ArrayList<Map>();
		
		for(int i=0;i<iTblCnt;i++) {
			searchMap.put("tblnoGrp", iTBLNO_GRP[i]);
			
			List<Map> vValue = basAltOsmsMapper.selectLogDccTrend4Hogi(searchMap);
			
			for(Map value:vValue) {
				vValues.add(value);
				iValCnt = iValCnt + 1;
			}
		}
		
		int i;
		int j;
		String pStr = pSCanTime + "|";		
		for(i=0;i<iTagCnt;i++) {
			for(j=0;j<iValCnt;j++) {
				if(iTBLNO[i].equals(vValues.get(j).get("SEQ").toString())) {
					break;
				}
			}
			
			if(j >= iValCnt ) {
				 pStr = pStr + "|";
			}else {
				 pStr = pStr + vValues.get(j).get("TVALUE"+iFLDNO[i])  + "|";
			}			
		}	
		
		return pStr;
		
	}
	
	public Map getNumericRealValue(Map searchMap, List<ComTagAltInfo> tagAltInfoList){
		
		Map rtnMap = new HashMap();
		
		String[] varValue = null;
		
		if(commonConstant.getUrl().indexOf("10.135.101.222") > -1) {
			varValue = sqlQueryDccReal4Hogi(searchMap).split("\\|");
		}else {		
			varValue = sqlQueryDccReal(searchMap).split("\\|");
		}
		
		//*** Start getDccValue 에 포함 된 로직
    	if(varValue != null && varValue.length != 0) {
    		if(varValue[0].length() == 19) {
    			
    			rtnMap.put("SearchTime", searchMap.get("hogi").toString() + " " +  searchMap.get("xyGubun").toString() + " " + varValue[0]);
    			
    			try {
	        			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	       			    java.util.Date date = format.parse(varValue[0]);
	        			
	        			Calendar c = Calendar.getInstance();
	        			c.setTime(date); 
	        			c.add(Calendar.MILLISECOND, 1);
	        			
	        			long searchTime = date.getTime();
	        			long currentTime = System.currentTimeMillis();
	        			
	        			long secondsDifference = (currentTime -searchTime)  / 1000;   
	        			
	        			searchMap.put("TimeGap", secondsDifference);
	        			
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
    	List<String> lblCountList = new ArrayList<String>();
    	List<String> pCountList = new ArrayList<String>();
    	
    	for(int i=0;i<tagAltInfoList.size();i++) {
    		if(varValue[i+1] != null && !varValue[i+1].isEmpty()) {
    			double fValue = Double.parseDouble(varValue[i+1]);
    			
    			Map lblData = new HashMap();
    			lblData.put("fValue", fValue);
    			
    			lblDataList.add(lblData);
    		}else {
    			lblDataList.add(new HashMap());
    		}
    	}
    	
		varValue = sqlQueryDccCount(searchMap).split("\\|");
		
	   	if(varValue != null && varValue.length != 0) {
	   		
	   		//System.out.println(tagDccInfoList.size());
	   		//System.out.println(varValue.length);
	   		for(int i=0;i<tagAltInfoList.size();i++) {
	   			if(varValue[i+1] != null && !varValue[i+1].isEmpty()) {
	   				if(Double.parseDouble(varValue[i+1]) < 0) {
	   					Long tmpL = 65535 + Math.round(Double.parseDouble(varValue[i+1]) + 1);
	   					lblCountList.add(Integer.toOctalString(tmpL.intValue()));
	   					pCountList.add(""+ 65535 + Math.round(Double.parseDouble(varValue[i+1]) + 1));
	   				}else {
	   					Long tmpL = Math.round(Double.parseDouble(varValue[i+1]));
	   					lblCountList.add(Integer.toOctalString(tmpL.intValue()));
	   					pCountList.add(""+ Math.round(Double.parseDouble(varValue[i+1])));
	   				}
	   			}
	   		}
	   	}
    	
	    rtnMap.put("lblDataList", lblDataList);
    	rtnMap.put("lblCountList", lblCountList);
    	rtnMap.put("pCountList", pCountList);

		return rtnMap;
		
	}
	
	private String sqlQueryDccReal(Map searchMap) {
		
		String pSCanTime ="";
		
		/*
		  if strUserID <> "" then
	    	pSQL = "UPDATE MST_USER SET UserIP = '" & strIp & "', conntime = getdate()"
	    	pSQL = pSQL & ", Login = 'Y', LoginHogi = '" & strHogi & "'"
	    	pSQL = pSQL & " WHERE ID = '" & strUserID & "'"
	    	conn1.execute(pSQL)
	    End If
	    */
						
		String pStr =  "";
		List<ComAltGrpTagInfo> altGrpTagList = basAltOsmsMapper.selectDccGrpTagList(searchMap);
		
		for(ComAltGrpTagInfo altGrpTag:altGrpTagList) {
			Map trendSchMap = new HashMap();
			//System.out.println(dccGrpTag.getTBLNO());
			//System.out.println(dccGrpTag.getFLDNO());
			trendSchMap.put("hogi", altGrpTag.getHogi());
			trendSchMap.put("tblNo", altGrpTag.getTBLNO());
			trendSchMap.put("fldNo", altGrpTag.getFLDNO());
			trendSchMap.put("xyGubun", altGrpTag.getXYGubun());
			
			Map logTrend = basAltOsmsMapper.selectLogDccTrendReal(trendSchMap);
			
			if(logTrend == null || logTrend.get("scantime") == null ) {
				pStr = pStr + "|";
			}else {
				if(pStr.isEmpty()) {
					 pStr = logTrend.get("scantime").toString() + "|";
				}
				pStr += logTrend.get("tValue").toString() + "|";
			}			
		}
		//System.out.println(pStr);
		return pStr;			
	}	

	private String sqlQueryDccReal4Hogi(Map searchMap) {
		
		String pSCanTime ="";
		
		/*
		  if strUserID <> "" then
	    	pSQL = "UPDATE MST_USER SET UserIP = '" & strIp & "', conntime = getdate()"
	    	pSQL = pSQL & ", Login = 'Y', LoginHogi = '" & strHogi & "'"
	    	pSQL = pSQL & " WHERE ID = '" & strUserID & "'"
	    	conn1.execute(pSQL)
	    End If
	    */
						
		String pStr =  "";
		List<ComAltGrpTagInfo> altGrpTagList = basAltOsmsMapper.selectDccGrpTagList(searchMap);
		
		for(ComAltGrpTagInfo altGrpTag:altGrpTagList) {
			Map trendSchMap = new HashMap();
			trendSchMap.put("hogi", altGrpTag.getHogi());
			trendSchMap.put("tblNo", altGrpTag.getTBLNO());
			trendSchMap.put("fldNo", altGrpTag.getFLDNO());
			trendSchMap.put("xyGubun", altGrpTag.getXYGubun());
			
			Map logTrend = basAltOsmsMapper.selectLogDccTrend4HogiReal(trendSchMap);
			
			if(logTrend == null || logTrend.get("scantime") == null ) {
				pStr = pStr + "|";
			}else {
				if(pStr.isEmpty()) {
					 pStr = logTrend.get("scantime").toString() + "|";
				}
				pStr += logTrend.get("tValue").toString() + "|";
			}			
		}
		
		return pStr;			
	}
	

	private String sqlQueryDccCount(Map searchMap) {
		
		String pSCanTime ="";
		
		/*
		  if strUserID <> "" then
	    	pSQL = "UPDATE MST_USER SET UserIP = '" & strIp & "', conntime = getdate()"
	    	pSQL = pSQL & ", Login = 'Y', LoginHogi = '" & strHogi & "'"
	    	pSQL = pSQL & " WHERE ID = '" & strUserID & "'"
	    	conn1.execute(pSQL)
	    End If
	    */
		
		Map scantime = basAltOsmsMapper.selectScanTime(searchMap);
		
		if(scantime != null && scantime.get("SCANTIME") != null) {
			pSCanTime = scantime.get("SCANTIME").toString();
		}

		searchMap.put("pSCanTime", pSCanTime);
						
		String pStr =  "";
		List<ComAltGrpTagInfo> altGrpTagList = basAltOsmsMapper.selectDccGrpTagList(searchMap);
		
		for(ComAltGrpTagInfo altGrpTag:altGrpTagList) {
			Map trendSchMap = new HashMap();
			trendSchMap.put("hogi", altGrpTag.getHogi());
			trendSchMap.put("tblNo", altGrpTag.getTBLNO());
			trendSchMap.put("fldNo", altGrpTag.getFLDNO());
			trendSchMap.put("xyGubun", altGrpTag.getXYGubun());
			
			Map logTrend = basAltOsmsMapper.selectLogDccCount(trendSchMap);
			
			if(logTrend == null || logTrend.get("scantime") == null ) {
				pStr = pStr + "0|";
			}else {
				if(pStr.isEmpty()) {
					 pStr = logTrend.get("scantime").toString() + "|";
				}
				pStr += logTrend.get("tValue").toString() + "|";
			}			
		}
		//System.out.println(pStr);
		return pStr;			
	}
	
	// added by jhlee(23.02.28)
	public List<Map> selectDccGrpTagListB(Map searchMap) {
		List<Map> rtnMap = new ArrayList<Map>();
		
		List<Map> tmpMapList = basAltOsmsMapper.selectDccGrpTagListB(searchMap);
		tmpMapList.forEach(m -> {
			Map tmpMap = new HashMap();
			if( "D".equalsIgnoreCase(m.get("gubun").toString()) ) {
				tmpMap.put("iSeq", m.get("iSeq"));
				tmpMap.put("gubun", m.get("gubun"));
				tmpMap.put("hogi", m.get("hogi"));
				tmpMap.put("xyGubun", m.get("xyGubun"));
				tmpMap.put("Descr", m.get("Descr"));
				tmpMap.put("ioType", m.get("ioType"));
				tmpMap.put("address", m.get("address"));
				tmpMap.put("ioBit", m.get("ioBit"));
				tmpMap.put("minVal", m.get("minVal"));
				tmpMap.put("maxVal", m.get("maxVal"));
				if( "0".equals(m.get("saveCoreChk")) && "SC".equalsIgnoreCase(m.get("ioType").toString()) ) {
					tmpMap.put("saveCoreChk", "");
				} else {
					tmpMap.put("saveCoreChk", m.get("saveCoreChk"));
				}
			} else {
				tmpMap.put("iSeq_m", m.get("iSeq_M"));
				tmpMap.put("gubun", m.get("gubun_M"));
				tmpMap.put("hogi_m", m.get("hogi_M"));
				tmpMap.put("xyGubun", "");
				tmpMap.put("Descr_m", m.get("Descr_M"));
				tmpMap.put("ioType_m", m.get("ioType_M"));
				tmpMap.put("register_m", m.get("register_M"));
				tmpMap.put("ioBit_m", m.get("ioBit_M"));
				tmpMap.put("minVal_m", m.get("minVal_M"));
				tmpMap.put("maxVal_m", m.get("maxVal_M"));
				tmpMap.put("saveCoreChk_m", "");
			}
			
			rtnMap.add(tmpMap);
		});
		
		return rtnMap;
	}
	

	public List<Map> selectDccGrpTagListA(Map searchMap) {
		List<Map> rtnMap = new ArrayList<Map>();
		
		List<Map> tmpMapList = basAltOsmsMapper.selectDccGrpTagListA(searchMap);
		tmpMapList.forEach(m -> {
			Map tmpMap = new HashMap();
			if( "D".equalsIgnoreCase(m.get("gubun").toString()) ) {
				tmpMap.put("iSeq", m.get("iSeq"));
				tmpMap.put("gubun", m.get("gubun"));
				tmpMap.put("hogi", m.get("hogi"));
				tmpMap.put("xyGubun", m.get("xyGubun"));
				tmpMap.put("Descr", m.get("Descr"));
				tmpMap.put("ioType", m.get("ioType"));
				tmpMap.put("address", m.get("address"));
				tmpMap.put("ioBit", m.get("ioBit"));
				tmpMap.put("minVal", m.get("minVal"));
				tmpMap.put("maxVal", m.get("maxVal"));
				if( "0".equals(m.get("saveCoreChk")) && "SC".equalsIgnoreCase(m.get("ioType").toString()) ) {
					tmpMap.put("saveCoreChk", "");
				} else {
					tmpMap.put("saveCoreChk", m.get("saveCoreChk"));
				}
			} else {
				tmpMap.put("iSeq_m", m.get("iSeq_M"));
				tmpMap.put("gubun", m.get("gubun_M"));
				tmpMap.put("hogi_m", m.get("hogi_M"));
				tmpMap.put("xyGubun", "");
				tmpMap.put("Descr_m", m.get("Descr_M"));
				tmpMap.put("ioType_m", m.get("ioType_M"));
				tmpMap.put("register_m", m.get("register_M"));
				tmpMap.put("ioBit_m", m.get("ioBit_M"));
				tmpMap.put("minVal_m", m.get("minVal_M"));
				tmpMap.put("maxVal_m", m.get("maxVal_M"));
				tmpMap.put("saveCoreChk_m", "");
			}
			
			rtnMap.add(tmpMap);
		});
		
		return rtnMap;
	}

}

