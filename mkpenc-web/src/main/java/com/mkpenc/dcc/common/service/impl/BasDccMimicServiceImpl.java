package com.mkpenc.dcc.common.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.common.mapper.BasCommonMapper;
import com.mkpenc.dcc.common.mapper.BasDccMimicMapper;
import com.mkpenc.dcc.common.model.ComDccGrpTagInfo;
import com.mkpenc.dcc.common.model.ComShowTagInfo;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.common.service.BasDccMimicService;
import com.mkpenc.dcc.mimic.model.DccSearchMimic;


@Service("basDccMimicService")
public class BasDccMimicServiceImpl implements BasDccMimicService{
	
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.4f",     "%.4f",     "%.3f",     "%.3f",     "%.3f",     "%.2f",     "%.2f",     "%.2f",     "%.2f",     "%.1f",     "%.1f",     "%.1f",     "%.1f",     "%.0f"};
	
	@Autowired
	private BasDccMimicMapper basDccMimicMapper;
	
	// by sohe 2023.02.28
		public List<ComTagDccInfo> getDccGrpTagNoUnitConvList(Map searchMap) {
			List<ComDccGrpTagInfo> dccGrpTagInfoList = basDccMimicMapper.selectDccGrpTagList(searchMap);
			
			List<ComTagDccInfo> tagDccInfoList = new ArrayList();
			
			for(ComDccGrpTagInfo dccGrpTagInfo:dccGrpTagInfoList) {
				
				ComTagDccInfo tagDccInfo = new ComTagDccInfo();
							
				tagDccInfo.setHogi(dccGrpTagInfo.getHogi());
				tagDccInfo.setADDRESS(dccGrpTagInfo.getADDRESS() == null? "": dccGrpTagInfo.getADDRESS());
				tagDccInfo.setFASTIOCHK(dccGrpTagInfo.getFASTIOCHK());
				
				if(dccGrpTagInfo.getFASTIOCHK() == 1){
					
					String fldNo = basDccMimicMapper.selectFastIoChk(dccGrpTagInfo) ;
					
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
					tagDccInfo.setUnit(dccGrpTagInfo.getUNIT());
					tagDccInfo.setAlarmType(dccGrpTagInfo.getTYPE() == null? "0": dccGrpTagInfo.getTYPE());
					
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
//					if( tagDccInfo.getIOTYPE().equals("AI") &&  (tagDccInfo.getADDRESS().equals("2010") ||  tagDccInfo.getADDRESS().equals("2140"))){
//						tagDccInfo.setUnit("DAC");
	//
//				    //   '-* AI2753, AI2754 (MPAG > KPAG)
//					}else 
						if( tagDccInfo.getIOTYPE().equals("AI") &&  (tagDccInfo.getADDRESS().equals("2753") ||  tagDccInfo.getADDRESS().equals("2754"))){
						//tagDccInfo.setUnit("KPAG"); 
						tagDccInfo.setMinVal(tagDccInfo.getMinVal() * 1000);
						tagDccInfo.setMaxVal(tagDccInfo.getMaxVal() * 1000);
					}
//						else {
//						tagDccInfo.setUnit(dccGrpTagInfo.getUNIT());
//					}
					
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
	
	public List<ComTagDccInfo> getDccGrpTagList(Map searchMap) {
		
		List<ComDccGrpTagInfo> dccGrpTagInfoList = basDccMimicMapper.selectDccGrpTagList(searchMap);
		
		List<ComTagDccInfo> tagDccInfoList = new ArrayList();
		
		for(ComDccGrpTagInfo dccGrpTagInfo:dccGrpTagInfoList) {
			
			ComTagDccInfo tagDccInfo = new ComTagDccInfo();
						
			tagDccInfo.setHogi(dccGrpTagInfo.getHogi());
			tagDccInfo.setADDRESS(dccGrpTagInfo.getADDRESS() == null? "": dccGrpTagInfo.getADDRESS());
			tagDccInfo.setFASTIOCHK(dccGrpTagInfo.getFASTIOCHK());
			
			if(dccGrpTagInfo.getFASTIOCHK() == 1){
				
				String fldNo = basDccMimicMapper.selectFastIoChk(dccGrpTagInfo) ;
				
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

			    //   '-* AI2753, AI2754 (MPAG > KPAG)
				}else if( tagDccInfo.getIOTYPE().equals("AI") &&  (tagDccInfo.getADDRESS().equals("2753") ||  tagDccInfo.getADDRESS().equals("2754"))){
					tagDccInfo.setUnit("KPAG"); 
					tagDccInfo.setMinVal(tagDccInfo.getMinVal() * 1000);
					tagDccInfo.setMaxVal(tagDccInfo.getMaxVal() * 1000);
				}else {
					tagDccInfo.setUnit(dccGrpTagInfo.getUNIT());
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
	
	public Map getDccValue(Map searchMap, List<ComTagDccInfo> tagDccInfoList,  ModelAndView mav){
	
		Map rtnMap = new HashMap();
		
		String[] varValue = sqlQueryDcc(searchMap).split("\\|");
		
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
    	for(int i=0;i<tagDccInfoList.size();i++) {
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
	
	private Map setDataConv(double fValue, ComTagDccInfo tagDccInfo, Map searchMap) {
		
		Map dataConv = new HashMap();
		
		if(fValue == 0) {
			dataConv.put("fValue", "-");
			return dataConv;
		}
		
		// '- IOTYPE에 대한 설정
	    if( tagDccInfo.getIOTYPE().equals("DI") ||  tagDccInfo.getIOTYPE().equals("DO")){
	        if(tagDccInfo.getIOBIT() != 0) {
	            fValue = Double.parseDouble(GetBitVal(fValue+"", tagDccInfo.getIOBIT()+""));
	        }
	    }else if(tagDccInfo.getIOTYPE().equals("SC")) {
	    	 if( tagDccInfo.getSaveCore() == 1 &&  tagDccInfo.getIOBIT() != 0) {
	 	            fValue = Double.parseDouble(GetBitVal(fValue+"", tagDccInfo.getIOBIT()+""));
	    	 }else if( tagDccInfo.getBScale() != 0 && tagDccInfo.getSaveCore() != 1) {
	 	            fValue = fValue / (2 ^ (15 - tagDccInfo.getBScale() ));
	 	     }
	    	
	    }else {
	    	  if( tagDccInfo.getIOTYPE().equals("AI") && (tagDccInfo.getADDRESS().equals("2010") ||  tagDccInfo.getADDRESS().equals("2140"))){
	  	            fValue = fValue / 0.0081;
	    	  }
	    }
	    
	    if(searchMap.get("menuNo").equals("21") || searchMap.get("menuNo").equals("22")) {
	    	if(Double.parseDouble(searchMap.get("TimeGap").toString())  < 5000 && tagDccInfo.getFASTIOCHK() == 1 && tagDccInfo.getBScale() != 0 ) {
	    		  fValue = fValue / (2 ^ (15 - tagDccInfo.getBScale() ));
	    	}
	    }
	    
	    if( tagDccInfo.getIOTYPE().equals("DI") ||  tagDccInfo.getIOTYPE().equals("DO") || tagDccInfo.getIOTYPE().equals("SC") && tagDccInfo.getSaveCore() == 1){
	    	dataConv.put("fValue", fValue > -32768? String.format("%f", fValue) : "***IRR");
	    }else if(tagDccInfo.getBScale() != 0) {
	    	dataConv.put("fValue",  fValue > -32768? String.format(gFormat[tagDccInfo.getBScale()], fValue) : "***IRR");
	    }else {
	    	dataConv.put("fValue", fValue > -32768? fValue+"": "***IRR");
	    }		
	    
	    return dataConv;
	}
	
	private void checkAlarm(Map lblData, ComTagDccInfo tagDccInfo) {
		
		switch(tagDccInfo.getAlarmType()) {
			case "1" : 
			case "7" :
			case "4" :
						if(!"***IRR".equals(lblData.get("fValue"))) {
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
						if(!"***IRR".equals(lblData.get("fValue"))) {
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
						if(!"***IRR".equals(lblData.get("fValue"))) {
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
	    
	    long di_val;
	    int bit_no;	    
	    
	    if(digitalBit.isEmpty()) {
	       if(digitalValue == null) {
	    	   return "";
	       }else {
	    	   return digitalValue;
	       }
	    }
	    
	    di_val = Math.round(Double.parseDouble(digitalValue));	    
	    bit_no = Integer.parseInt(digitalBit);

	    for(int i = 0;i < bit_no;i++) {
	        Rest = (di_val % 2);
	        //di_val = di_val \ 2;
	    	di_val = di_val >> 2;
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
				
		Map scantime = basDccMimicMapper.selectScanTime(searchMap);
		
		if(scantime != null && scantime.get("SCANTIME") != null) {
			pSCanTime = scantime.get("SCANTIME") .toString();
		}		
		searchMap.put("pSCanTime", pSCanTime);
	
		List<Map> tblNoFldNoList = basDccMimicMapper.selectTblNoFldNo(searchMap);
		
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

		List<Map> vValue = basDccMimicMapper.selectLogDccTrend(searchMap);
		
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
	
	@Override
	public String selectSeqInfo(DccSearchMimic searchMimic) {
		return basDccMimicMapper.selectSeqInfo(searchMimic);
	}
	
	@Override
	public int updateTagInfo(DccSearchMimic searchMimic) {
		return basDccMimicMapper.updateTagInfo(searchMimic);
	}
	
	@Override
	public List<ComShowTagInfo> selectTagSearch(DccSearchMimic searchMimic) {
		return basDccMimicMapper.selectTagSearch(searchMimic);
	}
	
	@Override
	public List<ComShowTagInfo> selectTagFind(DccSearchMimic searchMimic) {
		return basDccMimicMapper.selectTagFind(searchMimic);
	}

}

