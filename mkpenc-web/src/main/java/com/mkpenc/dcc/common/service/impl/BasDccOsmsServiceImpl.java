package com.mkpenc.dcc.common.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.dcc.common.mapper.BasDccOsmsMapper;
import com.mkpenc.dcc.common.model.ComDccGrpTagInfo;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.common.service.BasDccOsmsService;
import com.mkpenc.dcc.trend.model.TrendTagDccInfo;


@Service("basDccOsmsService")
public class BasDccOsmsServiceImpl implements BasDccOsmsService{
	
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
	
	@Autowired
	private CommonConstant commonConstant;	
	
	@Autowired
	private BasDccOsmsMapper basDccOsmsMapper;
	
	public List<ComTagDccInfo> getDccGrpTagList(Map searchMap) {
		
		List<ComDccGrpTagInfo> dccGrpTagInfoList = basDccOsmsMapper.selectDccGrpTagList(searchMap);
		
		List<ComTagDccInfo> tagDccInfoList = new ArrayList();
		
		for(ComDccGrpTagInfo dccGrpTagInfo:dccGrpTagInfoList) {
			
			ComTagDccInfo tagDccInfo = new ComTagDccInfo();
						
			tagDccInfo.setHogi(dccGrpTagInfo.getHogi());
			tagDccInfo.setADDRESS(dccGrpTagInfo.getADDRESS() == null? "": dccGrpTagInfo.getADDRESS());
			tagDccInfo.setFASTIOCHK(dccGrpTagInfo.getFASTIOCHK());
			
			if(dccGrpTagInfo.getFASTIOCHK() == 1){
				
				String fldNo = basDccOsmsMapper.selectFastIoChk(dccGrpTagInfo) ;
				
				if(fldNo == null || fldNo.isEmpty()) {
					tagDccInfo.setFLDNO_FAST(0);
				}else {
					tagDccInfo.setFLDNO_FAST(Integer.parseInt(fldNo));
				}
			}
			
			if(tagDccInfo.getFASTIOCHK() == 0 || (tagDccInfo.getFASTIOCHK() == 1 &&  tagDccInfo.getFLDNO_FAST() > 0)){
				
				tagDccInfo.setiSeq(dccGrpTagInfo.getiSeq());
				tagDccInfo.setGrpHogi(dccGrpTagInfo.getGrpHogi());
				tagDccInfo.setXYGubun(dccGrpTagInfo.getXYGubun());
				tagDccInfo.setBScale(dccGrpTagInfo.getBSCAL());
				tagDccInfo.setLOOPNAME(dccGrpTagInfo.getLOOPNAME() == null? "": dccGrpTagInfo.getLOOPNAME());
				tagDccInfo.setUnit(ConvertUnit(dccGrpTagInfo.getUNIT()));
				tagDccInfo.setAlarmType(dccGrpTagInfo.getTYPE() == null? "0": dccGrpTagInfo.getTYPE());
								
				//NULL EXIST
				dccGrpTagInfo.setTYPE(dccGrpTagInfo.getTYPE() == null? "0": dccGrpTagInfo.getTYPE());
				
				switch(dccGrpTagInfo.getTYPE()) {
						case "1":        			//HI, LO
						case "2":   
							tagDccInfo.setDataLimit1((dccGrpTagInfo.getLIMIT1() == null? -32768: dccGrpTagInfo.getLIMIT1()));
							break;
						case "3":        			//HI/LO, HI/VH, LO/VL
						case "7":   
						case "8":
							tagDccInfo.setDataLimit1((dccGrpTagInfo.getLIMIT1() == null? -32768: dccGrpTagInfo.getLIMIT1()));
							tagDccInfo.setDataLimit2((dccGrpTagInfo.getLIMIT2() == null? -32768: dccGrpTagInfo.getLIMIT2()));
							break;
						case "4":   				// HI(DTAB), LO(DTAB)
						case "5":
							tagDccInfo.setDataLimit1((dccGrpTagInfo.getLIMIT1() == null? -32768:1));
							break;
						case "6":					//HI/LO(DTAB)
							tagDccInfo.setDataLimit1((dccGrpTagInfo.getLIMIT1() == null? -32768:1));
							if(dccGrpTagInfo.getLIMIT2() == null) {
								tagDccInfo.setDataLimit1(-32768);
							} else {
								tagDccInfo.setDataLimit2(1);
							}
							break;
						 default :
								tagDccInfo.setDataLimit1((dccGrpTagInfo.getLIMIT1() == null? -32768: dccGrpTagInfo.getLIMIT1()));
								tagDccInfo.setDataLimit2((dccGrpTagInfo.getLIMIT2() == null?-32768: dccGrpTagInfo.getLIMIT2()));
							 
				} // end switch
				
				tagDccInfo.setSaveCore(dccGrpTagInfo.getSaveCoreChk());
	            tagDccInfo.setIOTYPE(dccGrpTagInfo.getIOTYPE() == null? "": dccGrpTagInfo.getIOTYPE());
	            tagDccInfo.setIOBIT(dccGrpTagInfo.getIOBIT());
	            tagDccInfo.setTBLNO(dccGrpTagInfo.getTBLNO() == 0? -32768: dccGrpTagInfo.getTBLNO());
	            tagDccInfo.setFLDNO(dccGrpTagInfo.getFLDNO() == 0? -32768: dccGrpTagInfo.getFLDNO());
	            tagDccInfo.setDescr(dccGrpTagInfo.getDescr() == null? "": dccGrpTagInfo.getDescr());
	            tagDccInfo.setMinVal(dccGrpTagInfo.getMinVal());
	            tagDccInfo.setMaxVal(dccGrpTagInfo.getMaxVal());
	            tagDccInfo.setDataLoop(dccGrpTagInfo.getTYPE() == null? "": dccGrpTagInfo.getDataLoop());
	            tagDccInfo.setELOW(dccGrpTagInfo.getELOW());
	            tagDccInfo.setEHIGH(dccGrpTagInfo.getEHIGH());
	            tagDccInfo.setVLOW(dccGrpTagInfo.getVLOW());
	            tagDccInfo.setVHIGH(dccGrpTagInfo.getVHIGH());
				  
				
				// '-* AI2010, AI2140
				if( tagDccInfo.getIOTYPE().equals("AI") &&  (tagDccInfo.getADDRESS().equals("2010") ||  tagDccInfo.getADDRESS().equals("2140"))){
					tagDccInfo.setUnit("DAC");
					tagDccInfo.setMinVal(tagDccInfo.getMinVal() / 0.0081);
					tagDccInfo.setMaxVal(tagDccInfo.getMaxVal() / 0.0081);

			    //   '-* AI2753, AI2754 (MPAG > KPAG)
				}else if( tagDccInfo.getIOTYPE().equals("AI") &&  (tagDccInfo.getADDRESS().equals("2753") ||  tagDccInfo.getADDRESS().equals("2754"))){
					tagDccInfo.setUnit("KPAG"); 
					tagDccInfo.setMinVal(tagDccInfo.getMinVal() * 1000);
					tagDccInfo.setMaxVal(tagDccInfo.getMaxVal() * 1000);
				}else {
					tagDccInfo.setUnit(ConvertUnit(dccGrpTagInfo.getUNIT()));
				}
				
				if(tagDccInfo.getIOBIT() != 0) {
					tagDccInfo.setToolTip(tagDccInfo.getDescr() + "[" +tagDccInfo.getHogi() +":" + tagDccInfo.getIOTYPE() +"-" + tagDccInfo.getADDRESS() + ":" + tagDccInfo.getIOBIT() + "]" );
				}else {
					tagDccInfo.setToolTip(tagDccInfo.getDescr() + "[" +tagDccInfo.getHogi() +":" + tagDccInfo.getIOTYPE() +"-" + tagDccInfo.getADDRESS() + "]" );
				}
												
			}// end if
			
			tagDccInfoList.add(tagDccInfo);		
		}
		
		return tagDccInfoList;
		
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
	
	public Map getDccValue2(Map searchMap, List<TrendTagDccInfo> tagDccInfoList){
		
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
	        				 rtnMap.put("ForeColor", "#e85516");
	        			 }else {
	        				 rtnMap.put("ForeColor", "#05c8be");
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
    	for(int i=0;i<tagDccInfoList.size();i++) {
    		//varValue[0]에는 날짜 데이터가 포함되어 있어 배열 idx + 1
    		if(varValue[i+1] != null && !varValue[i+1].isEmpty()) {
    			double fValue = Double.parseDouble(varValue[i+1]);
    			if(i == 365) { 
    				i = i; 
    			}
    			Map lblData = setDataConv2(fValue, tagDccInfoList.get(i), searchMap);
    			checkAlarm2(lblData, tagDccInfoList.get(i));
    			
    			lblDataList.add(lblData);
    		}else {
    			lblDataList.add(new HashMap());
    		}
    	}
    	
    	 rtnMap.put("lblDataList", lblDataList);
   	
    	return rtnMap; 
	}
	
	public Map getDccValue(Map searchMap, List<ComTagDccInfo> tagDccInfoList){
	
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
	        				 rtnMap.put("ForeColor", "#e85516");
	        			 }else {
	        				 rtnMap.put("ForeColor", "#05c8be");
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
    	for(int i=0;i<tagDccInfoList.size();i++) {
    		//varValue[0]에는 날짜 데이터가 포함되어 있어 배열 idx + 1
    		if(varValue[i+1] != null && !varValue[i+1].isEmpty()) {
    			double fValue = Double.parseDouble(varValue[i+1]);
    			if(i == 365) { 
    				i = i; 
    			}
    			Map lblData = setDataConv(fValue, tagDccInfoList.get(i), searchMap);
    			checkAlarm(lblData, tagDccInfoList.get(i));
    			
    			lblDataList.add(lblData);
    		}else {
    			lblDataList.add(new HashMap());
    		}
    	}
    	
    	 rtnMap.put("lblDataList", lblDataList);
   	
    	return rtnMap; 
	}

	public Map getDccValueSearch(Map searchMap, List<ComTagDccInfo> tagDccInfoList){
		
		Map rtnMap = new HashMap();
		
		String[] varValue = null;	
		
		if(commonConstant.getUrl().indexOf("10.135.101.222") > -1) {
			varValue = sqlQueryDcc4hogi(searchMap).split("\\|");
		}else {		
			varValue = sqlQueryDccSearch(searchMap).split("\\|");
		}
    	
    	List<Map> lblDataList = new ArrayList<Map>();
    	for(int i=0;i<tagDccInfoList.size();i++) {
    		//varValue[0]에는 날짜 데이터가 포함되어 있어 배열 idx + 1
    		if(varValue[i+1] != null && !varValue[i+1].isEmpty()) {
    			double fValue = Double.parseDouble(varValue[i+1]);
    			if(i == 365) { 
    				i = i; 
    			}
    			//System.out.println("idx=" + i + ":::: fValue = " + fValue);
    			Map lblData = setDataConv(fValue, tagDccInfoList.get(i), searchMap);
    			checkAlarm(lblData, tagDccInfoList.get(i));
    			
    			lblDataList.add(lblData);
    		}else {
    			lblDataList.add(new HashMap());
    		}
    	}
    	
    	 rtnMap.put("lblDataList", lblDataList);
   	
    	return rtnMap; 
	}
	
	private Map setDataConv2(double fValue, TrendTagDccInfo tagDccInfo, Map searchMap) {
		
		Map dataConv = new HashMap();
		//System.out.println("setDataConv setDataConv ::: IOTYPE = " + fValue + "::::" +  tagDccInfo.getIOTYPE());
		if(fValue == 0) {
			dataConv.put("fValue", "0");
			return dataConv;
		}
		
		//System.out.println("iotype = " + tagDccInfo.getIOTYPE() + ":::: iobit = " + tagDccInfo.getIOBIT() + "::::: address = " + tagDccInfo.getADDRESS() );
		// '- IOTYPE에 대한 설정
	    if( tagDccInfo.getIOTYPE().equals("DI") ||  tagDccInfo.getIOTYPE().equals("DO")){
	        if(tagDccInfo.getIOBIT() != 0) {
	            fValue = Double.parseDouble(GetBitVal(fValue+"", tagDccInfo.getIOBIT()+""));
	        }else {
	        	fValue = 0;
	        }
	    }else if(tagDccInfo.getIOTYPE().equals("SC")) {
	    	 if( tagDccInfo.getSaveCore() == 1 && tagDccInfo.getIOBIT() != -1) {
	    		 //System.out.println("setDataConv setDataConv ::: IOTYPE = " + fValue + "::::" +  tagDccInfo.getIOTYPE() + ";;;;" + tagDccInfo.getIOBIT());
	 	         fValue = Double.parseDouble(GetBitVal(fValue+"", tagDccInfo.getIOBIT()+""));
	 	         //System.out.println("setDataConv setDataConv ::: IOTYPE getbitval= " + fValue + "::::" +  tagDccInfo.getIOTYPE() + ";;;;" + tagDccInfo.getIOBIT());
	    	 }else if( tagDccInfo.getBScale() != 0 && tagDccInfo.getSaveCore() != 1) {
	    		 //System.out.println(Math.pow(2, (15 - tagDccInfo.getBScale())));   
	    		 fValue = fValue / Math.pow(2, (15 - tagDccInfo.getBScale()));
	 	         //System.out.println("setDataConv setDataConv ::: IOTYPE not getbitval= " + fValue + "::::" +  tagDccInfo.getIOTYPE() + ";;;;" + tagDccInfo.getIOBIT());
	 	     }
	    	
	    }else {
	    	  if( tagDccInfo.getIOTYPE().equals("AI") && (tagDccInfo.getADDRESS().equals("2010") ||  tagDccInfo.getADDRESS().equals("2140"))){
	  	            fValue = fValue / 0.0081;
	    	  }
	    }
	    
	    if(searchMap.get("menuNo").equals("21") || searchMap.get("menuNo").equals("22")) {
	    	if(Double.parseDouble(searchMap.get("TimeGap").toString())  < 5000 && tagDccInfo.getFASTIOCHK() == 1 && tagDccInfo.getBScale() != 0 ) {
	    		  fValue = fValue / Math.pow(2, (15 - tagDccInfo.getBScale() ));
	    	}
	    }
	    //System.out.println("fvalue = " + fValue);
	    if( tagDccInfo.getIOTYPE().equals("DI") ||  tagDccInfo.getIOTYPE().equals("DO") || tagDccInfo.getIOTYPE().equals("SC") && tagDccInfo.getSaveCore() == 1){
	    	dataConv.put("fValue", fValue > -32768? String.format("%.5f", fValue) : "***IRR");
	    }else if(tagDccInfo.getBScale() != 0) {
	    	dataConv.put("fValue",  fValue > -32768? String.format(gFormat[tagDccInfo.getBScale()], fValue) : "***IRR");
	    }else {
	    	dataConv.put("fValue", fValue > -32768? String.format("%.5f", fValue) +"": "***IRR");
	    }		
	    
	    return dataConv;
	}
	
	private Map setDataConv(double fValue, ComTagDccInfo tagDccInfo, Map searchMap) {
		
		Map dataConv = new HashMap();
		//System.out.println("setDataConv setDataConv ::: IOTYPE = " + fValue + "::::" +  tagDccInfo.getIOTYPE());
		if(fValue == 0) {
			dataConv.put("fValue", "0");
			return dataConv;
		}
		
		//System.out.println("iotype = " + tagDccInfo.getIOTYPE() + ":::: iobit = " + tagDccInfo.getIOBIT() + "::::: address = " + tagDccInfo.getADDRESS() );
		// '- IOTYPE에 대한 설정
	    if( tagDccInfo.getIOTYPE().equals("DI") ||  tagDccInfo.getIOTYPE().equals("DO")){
	        if(tagDccInfo.getIOBIT() != 0) {
	            fValue = Double.parseDouble(GetBitVal(fValue+"", tagDccInfo.getIOBIT()+""));
	        }else {
	        	fValue = 0;
	        }
	    }else if(tagDccInfo.getIOTYPE().equals("SC")) {
	    	 if( tagDccInfo.getSaveCore() == 1 && tagDccInfo.getIOBIT() != -1) {
	    		 //System.out.println("setDataConv setDataConv ::: IOTYPE = " + fValue + "::::" +  tagDccInfo.getIOTYPE() + ";;;;" + tagDccInfo.getIOBIT());
	 	         fValue = Double.parseDouble(GetBitVal(fValue+"", tagDccInfo.getIOBIT()+""));
	 	         //System.out.println("setDataConv setDataConv ::: IOTYPE getbitval= " + fValue + "::::" +  tagDccInfo.getIOTYPE() + ";;;;" + tagDccInfo.getIOBIT());
	    	 }else if( tagDccInfo.getBScale() != 0 && tagDccInfo.getSaveCore() != 1) {
	    		 //System.out.println(Math.pow(2, (15 - tagDccInfo.getBScale())));   
	    		 fValue = fValue / Math.pow(2, (15 - tagDccInfo.getBScale()));
	 	         //System.out.println("setDataConv setDataConv ::: IOTYPE not getbitval= " + fValue + "::::" +  tagDccInfo.getIOTYPE() + ";;;;" + tagDccInfo.getIOBIT());
	 	     }
	    	
	    }else {
	    	  if( tagDccInfo.getIOTYPE().equals("AI") && (tagDccInfo.getADDRESS().equals("2010") ||  tagDccInfo.getADDRESS().equals("2140"))){
	  	            fValue = fValue / 0.0081;
	    	  }
	    }
	    
	    if(searchMap.get("menuNo").equals("21") || searchMap.get("menuNo").equals("22")) {
	    	if(Double.parseDouble(searchMap.get("TimeGap").toString())  < 5000 && tagDccInfo.getFASTIOCHK() == 1 && tagDccInfo.getBScale() != 0 ) {
	    		  fValue = fValue / Math.pow(2, (15 - tagDccInfo.getBScale() ));
	    	}
	    }
	    //System.out.println("fvalue = " + fValue);
	    if( tagDccInfo.getIOTYPE().equals("DI") ||  tagDccInfo.getIOTYPE().equals("DO") || tagDccInfo.getIOTYPE().equals("SC") && tagDccInfo.getSaveCore() == 1){
	    	dataConv.put("fValue", fValue > -32768? String.format("%.5f", fValue) : "***IRR");
	    }else if(tagDccInfo.getBScale() != 0) {
	    	dataConv.put("fValue",  fValue > -32768? String.format(gFormat[tagDccInfo.getBScale()], fValue) : "***IRR");
	    }else {
	    	dataConv.put("fValue", fValue > -32768? String.format("%.5f", fValue) +"": "***IRR");
	    }		
	    
	    return dataConv;
	}
	
	private void checkAlarm(Map lblData, ComTagDccInfo tagDccInfo) {
		
		switch(tagDccInfo.getAlarmType()) {
			case "1" : 
			case "7" :
			case "4" :
						if(!"***IRR".equals(lblData.get("fValue")) && !"0".equals(lblData.get("fValue"))) {
							if(Double.parseDouble(lblData.get("fValue").toString()) >=  tagDccInfo.getDataLimit1()) {
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
							if(Double.parseDouble(lblData.get("fValue").toString()) <=  tagDccInfo.getDataLimit1()) {
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
							if(Double.parseDouble(lblData.get("fValue").toString()) >  tagDccInfo.getDataLimit1() || Double.parseDouble(lblData.get("fValue").toString()) <  tagDccInfo.getDataLimit2()) {
								lblData.put("ForeColor", "#FF&");
							}else {
								lblData.put("ForeColor", "#FF0000");
							}					
						}				
				  		break;
		}		
	}
	
	private void checkAlarm2(Map lblData, TrendTagDccInfo tagDccInfo) {
		
		switch(tagDccInfo.getAlarmType()) {
			case "1" : 
			case "7" :
			case "4" :
						if(!"***IRR".equals(lblData.get("fValue")) && !"0".equals(lblData.get("fValue"))) {
							if(Double.parseDouble(lblData.get("fValue").toString()) >=  tagDccInfo.getDataLimit1()) {
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
							if(Double.parseDouble(lblData.get("fValue").toString()) <=  tagDccInfo.getDataLimit1()) {
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
							if(Double.parseDouble(lblData.get("fValue").toString()) >  tagDccInfo.getDataLimit1() || Double.parseDouble(lblData.get("fValue").toString()) <  tagDccInfo.getDataLimit2()) {
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
				
		Map scantime = basDccOsmsMapper.selectScanTime(searchMap);
		
		if(scantime != null && scantime.get("SCANTIME") != null) {
			pSCanTime = scantime.get("SCANTIME") .toString();
		}
		
		searchMap.put("pSCanTime", pSCanTime);
	
		List<Map> tblNoFldNoList = basDccOsmsMapper.selectTblNoFldNo(searchMap);
		
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
		
		List<Map> vValue = basDccOsmsMapper.selectLogDccTrend(searchMap);
		
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
			Map scantime = basDccOsmsMapper.selectScanTime(searchMap);
			
			if(scantime != null && scantime.get("SCANTIME") != null) {
				pSCanTime = scantime.get("SCANTIME") .toString();
			}
			
			searchMap.put("pSCanTime", pSCanTime);
		}
	
		List<Map> tblNoFldNoList = basDccOsmsMapper.selectTblNoFldNo(searchMap);
		
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
		
		List<Map> vValue = basDccOsmsMapper.selectLogDccTrendSearch(searchMap);
		
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
				
			Map scantime = basDccOsmsMapper.selectScanTime(searchMap);
			
			if(scantime != null && scantime.get("SCANTIME") != null) {
				pSCanTime = scantime.get("SCANTIME").toString();
			}
		}
		
		searchMap.put("pSCanTime", pSCanTime);
	
		List<Map> tblNoFldNoList = basDccOsmsMapper.selectTblNoFldNo(searchMap);
		
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
			
			List<Map> vValue = basDccOsmsMapper.selectLogDccTrend4Hogi(searchMap);
			
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
	
	public Map getNumericRealValue(Map searchMap, List<ComTagDccInfo> tagDccInfoList){
		
		Map rtnMap = new HashMap();
		
		String[] varValue = null;
		
		if(commonConstant.getUrl().indexOf("10.135.101.222") > -1) {
			varValue = sqlQueryDccReal4Hogi(searchMap).split("\\|");
			//varValue = sqlQueryDccReal4Hogi(searchMap,tagDccInfoList).split("\\|");
		}else {		
			varValue = sqlQueryDccReal(searchMap).split("\\|");
			//varValue = sqlQueryDccReal(searchMap,tagDccInfoList).split("\\|");
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
	        				 rtnMap.put("ForeColor", "#e85516");
	        			 }else {
	        				 rtnMap.put("ForeColor", "#05c8be");
	        			 }
	        			
    			}catch (Exception e) {
    				e.printStackTrace();
    			}        			
    		} // end if varVal[0] len 19
    	} // end if varValue is not null
		
    	List<Map> lblDataList = new ArrayList<Map>();
    	List<String> lblCountList = new ArrayList<String>();
    	List<String> pCountList = new ArrayList<String>();
    	
    	for(int i=0;i<tagDccInfoList.size();i++) {
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
	   		for(int i=0;i<tagDccInfoList.size();i++) {
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
	
	public Map getNumericRealValue2(Map searchMap, List<ComTagDccInfo> tagDccInfoList){
		
		Map rtnMap = new HashMap();
		
		String[] varValue = null;
		
		if(commonConstant.getUrl().indexOf("10.135.101.222") > -1) {
			//varValue = sqlQueryDccReal4Hogi(searchMap).split("\\|");
			varValue = sqlQueryDccReal4Hogi(searchMap,tagDccInfoList).split("\\|");
		}else {		
			//varValue = sqlQueryDccReal(searchMap).split("\\|");
			varValue = sqlQueryDccReal(searchMap,tagDccInfoList).split("\\|");
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
	        				 rtnMap.put("ForeColor", "#e85516");
	        			 }else {
	        				 rtnMap.put("ForeColor", "#05c8be");
	        			 }
	        			
    			}catch (Exception e) {
    				e.printStackTrace();
    			}        			
    		} // end if varVal[0] len 19
    	} // end if varValue is not null
		
    	List<Map> lblDataList = new ArrayList<Map>();
    	List<String> lblCountList = new ArrayList<String>();
    	List<String> pCountList = new ArrayList<String>();
    	
    	for(int i=0;i<tagDccInfoList.size();i++) {
    		//varValue[0]에는 날짜 데이터가 포함되어 있어 배열 idx + 1
    		if(varValue[i+1] != null && !varValue[i+1].isEmpty()) {
    			double fValue = Double.parseDouble(varValue[i+1]);
    			if(i == 365) { 
    				i = i; 
    			}
    			Map lblData = setDataConv(fValue, tagDccInfoList.get(i), searchMap);
    			checkAlarm(lblData, tagDccInfoList.get(i));
    			
    			lblDataList.add(lblData);
    		}else {
    			lblDataList.add(new HashMap());
    		}
    	}
    	
    	/*for(int i=0;i<tagDccInfoList.size();i++) {
    		if(varValue[i+1] != null && !varValue[i+1].isEmpty()) {
    			double fValue = Double.parseDouble(varValue[i+1]);
    			
    			Map lblData = new HashMap();
    			lblData.put("fValue", fValue);
    			
    			lblDataList.add(lblData);
    		}else {
    			lblDataList.add(new HashMap());
    		}
    	}*/
    	
		varValue = sqlQueryDccCount(searchMap).split("\\|");
		
	   	if(varValue != null && varValue.length != 0) {
	   		
	   		//System.out.println(tagDccInfoList.size());
	   		//System.out.println(varValue.length);
	   		for(int i=0;i<tagDccInfoList.size();i++) {
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
		List<ComDccGrpTagInfo> dccGrpTagList = basDccOsmsMapper.selectDccGrpTagList(searchMap);
		
		for(ComDccGrpTagInfo dccGrpTag:dccGrpTagList) {
			Map trendSchMap = new HashMap();
			//System.out.println(dccGrpTag.getTBLNO());
			//System.out.println(dccGrpTag.getFLDNO());
			trendSchMap.put("hogi", dccGrpTag.getHogi());
			trendSchMap.put("tblNo", dccGrpTag.getTBLNO());
			trendSchMap.put("fldNo", dccGrpTag.getFLDNO());
			trendSchMap.put("xyGubun", dccGrpTag.getXYGubun());
			
			Map logTrend = basDccOsmsMapper.selectLogDccTrendReal(trendSchMap);
			
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
	
	private String sqlQueryDccReal(Map searchMap, List<ComTagDccInfo> dccGrpTagList) {
		
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
		//List<ComDccGrpTagInfo> dccGrpTagList = basDccOsmsMapper.selectDccGrpTagList(searchMap);
		
		for(ComTagDccInfo dccGrpTag:dccGrpTagList) {
			Map trendSchMap = new HashMap();
			//System.out.println(dccGrpTag.getTBLNO());
			//System.out.println(dccGrpTag.getFLDNO());
			trendSchMap.put("hogi", dccGrpTag.getHogi());
			trendSchMap.put("tblNo", dccGrpTag.getTBLNO());
			trendSchMap.put("fldNo", dccGrpTag.getFLDNO());
			trendSchMap.put("xyGubun", dccGrpTag.getXYGubun());
			
			Map logTrend = basDccOsmsMapper.selectLogDccTrendReal(trendSchMap);
			
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
		List<ComDccGrpTagInfo> dccGrpTagList = basDccOsmsMapper.selectDccGrpTagList(searchMap);
		
		for(ComDccGrpTagInfo dccGrpTag:dccGrpTagList) {
			Map trendSchMap = new HashMap();
			trendSchMap.put("hogi", dccGrpTag.getHogi());
			trendSchMap.put("tblNo", dccGrpTag.getTBLNO());
			trendSchMap.put("fldNo", dccGrpTag.getFLDNO());
			trendSchMap.put("xyGubun", dccGrpTag.getXYGubun());
			
			Map logTrend = basDccOsmsMapper.selectLogDccTrend4HogiReal(trendSchMap);
			
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
	
	private String sqlQueryDccReal4Hogi(Map searchMap, List<ComTagDccInfo> dccGrpTagList) {
		
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
		//List<ComDccGrpTagInfo> dccGrpTagList = basDccOsmsMapper.selectDccGrpTagList(searchMap);
		
		for(ComTagDccInfo dccGrpTag:dccGrpTagList) {
			Map trendSchMap = new HashMap();
			trendSchMap.put("hogi", dccGrpTag.getHogi());
			trendSchMap.put("tblNo", dccGrpTag.getTBLNO());
			trendSchMap.put("fldNo", dccGrpTag.getFLDNO());
			trendSchMap.put("xyGubun", dccGrpTag.getXYGubun());
			
			Map logTrend = basDccOsmsMapper.selectLogDccTrend4HogiReal(trendSchMap);
			
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
		
		Map scantime = basDccOsmsMapper.selectScanTime(searchMap);
		
		if(scantime != null && scantime.get("SCANTIME") != null) {
			pSCanTime = scantime.get("SCANTIME").toString();
		}

		searchMap.put("pSCanTime", pSCanTime);
						
		String pStr =  "";
		List<ComDccGrpTagInfo> dccGrpTagList = basDccOsmsMapper.selectDccGrpTagList(searchMap);
		
		for(ComDccGrpTagInfo dccGrpTag:dccGrpTagList) {
			Map trendSchMap = new HashMap();
			trendSchMap.put("hogi", dccGrpTag.getHogi());
			trendSchMap.put("tblNo", dccGrpTag.getTBLNO());
			trendSchMap.put("fldNo", dccGrpTag.getFLDNO());
			trendSchMap.put("xyGubun", dccGrpTag.getXYGubun());
			
			Map logTrend = basDccOsmsMapper.selectLogDccCount(trendSchMap);
			
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
		
		List<Map> tmpMapList = basDccOsmsMapper.selectDccGrpTagListB(searchMap);
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
		
		List<Map> tmpMapList = basDccOsmsMapper.selectDccGrpTagListA(searchMap);
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

