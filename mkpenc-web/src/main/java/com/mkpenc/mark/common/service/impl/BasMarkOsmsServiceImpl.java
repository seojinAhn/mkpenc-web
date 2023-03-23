package com.mkpenc.mark.common.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.mark.common.mapper.BasMarkOsmsMapper;
import com.mkpenc.mark.common.model.ComTagMarkInfo;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.mark.common.service.BasMarkMimicService;
import com.mkpenc.mark.common.service.BasMarkOsmsService;
    
@Service("basMarkOsmsService")
public class BasMarkOsmsServiceImpl implements BasMarkOsmsService{
	  
	public String[] gFormat = new String[]{ "%.5f",     "%.4f",     "%.3f",     "%.2f",     "%.1f",     "%f"};
	
	@Autowired
	private BasMarkOsmsMapper basMarkOsmsMapper;
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired
	private BasMarkMimicService basMarkMimicService;
	
	public List<ComTagMarkInfo> getMarkGrpTagList(Map searchMap) {
		
		List<Map> markGrpTagInfoList = basMarkOsmsMapper.selectMarkGrpTagList(searchMap);
		
		List<ComTagMarkInfo> tagMarkInfoList = new ArrayList();
		
		for(Map markGrpTagInfo:markGrpTagInfoList) {
			ComTagMarkInfo tMarkTag = new ComTagMarkInfo();
			
			tMarkTag.setSignal_Name(markGrpTagInfo.get("SIGNAL_NAME") !=null? markGrpTagInfo.get("SIGNAL_NAME").toString():"");
			tMarkTag.setUNIT_DIV(markGrpTagInfo.get("UNIT_DIV") !=null? markGrpTagInfo.get("UNIT_DIV").toString():"");
			tMarkTag.setUnit(markGrpTagInfo.get("Unit") !=null? markGrpTagInfo.get("Unit").toString():"");
			tMarkTag.setHogi(markGrpTagInfo.get("Hogi") !=null? markGrpTagInfo.get("Hogi").toString():"");
			tMarkTag.setGAIN(markGrpTagInfo.get("GAIN") !=null? markGrpTagInfo.get("GAIN").toString():"");
			tMarkTag.setOffset(markGrpTagInfo.get("Offset") !=null? markGrpTagInfo.get("Offset").toString():"");
			tMarkTag.setIOTYPE(markGrpTagInfo.get("IOTYPE") !=null? markGrpTagInfo.get("IOTYPE").toString():"");
			tMarkTag.setRegister(markGrpTagInfo.get("Register") !=null? markGrpTagInfo.get("Register").toString():"");
			tMarkTag.setIOBIT(markGrpTagInfo.get("IOBIT") !=null? markGrpTagInfo.get("IOBIT").toString():"");
			tMarkTag.setTBLNO(markGrpTagInfo.get("TBLNO") !=null? Integer.parseInt(markGrpTagInfo.get("TBLNO").toString()):-1);
			tMarkTag.setFLDNO(markGrpTagInfo.get("FLDNO") !=null? Integer.parseInt(markGrpTagInfo.get("FLDNO").toString()):-1);
			tMarkTag.setBScale(markGrpTagInfo.get("BScale") !=null? Integer.parseInt(markGrpTagInfo.get("BScale").toString()):-1);
			tMarkTag.setiSeq(markGrpTagInfo.get("iSeq") !=null? Integer.parseInt(markGrpTagInfo.get("iSeq").toString()):-1);
			
			tMarkTag.setSignal_Desc(markGrpTagInfo.get("Signal_Desc") !=null? markGrpTagInfo.get("Signal_Desc").toString():"");
			tMarkTag.setD0(markGrpTagInfo.get("D0") !=null? markGrpTagInfo.get("D0").toString():"");
			tMarkTag.setD1(markGrpTagInfo.get("D1") !=null? markGrpTagInfo.get("D1").toString():"");
			
			tMarkTag.setSaveCoreChk(markGrpTagInfo.get("SaveCoreChk") !=null? Integer.parseInt(markGrpTagInfo.get("SaveCoreChk").toString()):0);
			tMarkTag.setMinVal(markGrpTagInfo.get("MinVal") !=null? Double.parseDouble(markGrpTagInfo.get("MinVal").toString()):-1);
			tMarkTag.setMaxVal(markGrpTagInfo.get("MaxVal") !=null? Double.parseDouble(markGrpTagInfo.get("MaxVal").toString()):-1);
			
			tMarkTag.setDescr(markGrpTagInfo.get("Descr") !=null? markGrpTagInfo.get("Descr").toString():"");			
			
	        //If lblData.Count > iRow Then
            if(tMarkTag.getRegister().compareTo("0400") > 0) {
                String tipText = tMarkTag.getSignal_Name() + " [" + tMarkTag.getHogi() + "-" + tMarkTag.getUNIT_DIV() + ":" + tMarkTag.getRegister() +"-" + tMarkTag.getIOBIT() + "]";	
            	tMarkTag.setToolTip(tipText);
            } else {
                String tipText = tMarkTag.getSignal_Name() + " [" + tMarkTag.getHogi() + "-" + tMarkTag.getUNIT_DIV() + ":" + tMarkTag.getRegister() + "]";
            	tMarkTag.setToolTip(tipText);
            }
        //End If			
		}		
		
		return tagMarkInfoList;
		
	}
	
	public Map getMarkValue(Map searchMap, List<ComTagMarkInfo> tagMarkInfoList,  ModelAndView mav){
		
		Map rtnMap = new HashMap();
		
		String[][] tAnalogChar = basMarkMimicService.AnalogCharacter();
		
		String[] varValue = sqlQueryMark(searchMap).split("\\|");
		
		//*** Start getDccValue 에 포함 된 로직
    	if(varValue != null && varValue.length != 0) {
    		if(varValue[0].length() == 19) {
    			
    			rtnMap.put("SearchTime", searchMap.get("hogi").toString() + " " +  searchMap.get("xyGubun").toString() + " " + varValue[0]);
    			
    			int idx=1;
    			double fValue=0;
    			List<Map> lblDataList = new ArrayList<Map>();
    			
    			for(ComTagMarkInfo tMarkTag:tagMarkInfoList) {
    				
    				Map lblData = new HashMap();
    				
    				if(!varValue[idx].isEmpty()) {
    					fValue = Double.parseDouble(varValue[idx]);
    					
    					if(tMarkTag.getRegister().compareTo("0400") > 0) {
    						
    						fValue = Double.parseDouble(basCommonService.GetBitVal(varValue[idx], tMarkTag.getIOBIT()));
	                        if(tMarkTag.getSaveCoreChk() == 1) {
	                        	lblData.put("fValue", fValue != 0? tMarkTag.getD1():tMarkTag.getD0());
	                        } else {
	                        	lblData.put("fValue",  fValue);
	                        }    						
    					}else {

    						if(StringUtils.isNumeric(tMarkTag.getGAIN()) && StringUtils.isNumeric(tMarkTag.getOffset()) ) {
    							
    							if(fValue > 32768) {
    								fValue = (65535 - fValue) * -1;
    							}
    							fValue = fValue / 32768 * Double.parseDouble(tMarkTag.getGAIN()) + Double.parseDouble(tMarkTag.getOffset());
    							
    							int x = tMarkTag.getSaveCoreChk();
    							int y = Long.valueOf(Math.round(ChangeUnitVal(tMarkTag.getUnit(), fValue))).intValue();
    							
    							if(tMarkTag.getSaveCoreChk() > 1) {
    								if((tAnalogChar[0].length < tMarkTag.getSaveCoreChk()) ||
    										tAnalogChar[x][y] == null || tAnalogChar[x][y].isEmpty()) {
    									lblData.put("fValue",  "?????");
    								}else {
    									lblData.put("fValue",  tAnalogChar[x][y]);
    								}   	
    							}else {
    								
    								if(tMarkTag.getRegister().equals( "0153")) {
    									lblData.put("fValue", String.format(gFormat[tMarkTag.getBScale()], (fValue * 3.785)));
    								}else if(tMarkTag.getRegister().equals( "0225") || tMarkTag.getRegister().equals( "0226") || 
    										tMarkTag.getRegister().equals( "0248") || tMarkTag.getRegister().equals( "0254") || 
    										tMarkTag.getRegister().equals( "0211") || tMarkTag.getRegister().equals( "0212") || 
    										tMarkTag.getRegister().equals( "0214") || tMarkTag.getRegister().equals( "0218")  ){
    									
    									lblData.put("fValue",  String.format(gFormat[tMarkTag.getBScale()], (5 / 9) * fValue));
    								}else {
    									lblData.put("fValue",  String.format(gFormat[tMarkTag.getBScale()], ChangeUnitVal(tMarkTag.getUnit(), fValue)));
    								}
    							}
    						}else {
    							lblData.put("fValue", "X");
    						}    						
    					} // else "0400"    					
    				} // if isEmpty    	
    				
    				lblDataList.add(lblData);
    			} // end for    	
    			
    			rtnMap.put("lblDataList", lblDataList);    			
    		}
    	}
		
		return rtnMap;
	}
	
	
	private String sqlQueryMark(Map searchMap) {
		
		String pSCanTime ="";
		
		/*
		  if strUserID <> "" then
	    	pSQL = "UPDATE MST_USER SET UserIP = '" & strIp & "', conntime = getdate()"
	    	pSQL = pSQL & ", Login = 'Y', LoginHogi = '" & strHogi & "'"
	    	pSQL = pSQL & " WHERE ID = '" & strUserID & "'"
	    	conn1.execute(pSQL)
	    End If
	    */
				
		Map scantime = basMarkOsmsMapper.selectScanTime(searchMap);
		
		if(scantime != null && scantime.get("SCANTIME") != null) {
			pSCanTime = scantime.get("SCANTIME") .toString();
		}
	
		List<Map> tblNoFldNoList = basMarkOsmsMapper.selectTblNoFldNo(searchMap);
		
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
		
		searchMap.put("pSCanTime", pSCanTime);
		
		List<Map> vValue = basMarkOsmsMapper.selectLogMarkTrend(searchMap);
		
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
	    		 pStr = pStr + vValue.get(j).get("TVALUE"+ Integer.parseInt(iFLDNO)+ 1) +  "|";
	    	 }
	    	
	    }
	    	   
	    pStr = pStr + "}";    
		
		return pStr;
		
	}
	
	//'-------------------------------------------------------------------------------------------
	//'-- 단위값에 따라 값을 변경한다.
	//'-------------------------------------------------------------------------------------------
	public double ChangeUnitVal(String sUnit, double fVal) {

		double rtnUnitVal = 0;
		
	    switch(sUnit.toUpperCase()) {
	    
		    case "DEG F":
		    	rtnUnitVal = (5 / 9) * (fVal - 32);
		    	break;
		    case "PSI":
		        rtnUnitVal = (fVal * 0.068966) / 14.69595;
		        break;
		    case "MILS":
		        rtnUnitVal = fVal * 0.0254;
		        break;
		    default:
		        rtnUnitVal = fVal;
	    }
	    
	    return rtnUnitVal;
	    
	}

}
