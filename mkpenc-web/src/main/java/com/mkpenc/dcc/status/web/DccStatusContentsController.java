package com.mkpenc.dcc.status.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.status.model.DccGrpTagInfo;
import com.mkpenc.dcc.status.model.DccLogTrendInfo;
import com.mkpenc.dcc.status.model.DccMstTagInfo;
import com.mkpenc.dcc.status.model.DccSearchStatus;
import com.mkpenc.dcc.status.model.DccTagInfo;
import com.mkpenc.dcc.status.model.TblFldInfo;
import com.mkpenc.dcc.status.service.DccStatusService;
import com.mkpenc.dcc.tip.model.DccIolistInfo;
import com.mkpenc.dcc.tip.model.DccSearchTip;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.dcc.common.service.BasDccOsmsService;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/status/")
public class DccStatusContentsController {
	
	private static Logger logger = LoggerFactory.getLogger(DccStatusContentsController.class);
	
	private String menuName = "STATUS";
	
	@Autowired
	private DccStatusService dccStatusService;

	@Autowired
	private ExcelHelperUtil excelHelperUtil;
	
	@Autowired	
	private BasDccOsmsService basDccOsmsService;
	
	@RequestMapping("schematic")
	public ModelAndView schematic(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ schematic");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("htc")
	public ModelAndView htc(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ htc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		//dccSearchStatus.setsDive("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("3");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
    		dccGrpTagSearchMap.put("dive","D");
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);

        }

        return mav;
    }
	
	public static String getClientIP(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");
	    logger.info("> X-FORWARDED-FOR : " + ip);

	    if (ip == null) {
	        ip = request.getHeader("Proxy-Client-IP");
	        logger.info("> Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	        logger.info(">  WL-Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
	        logger.info("> HTTP_CLIENT_IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	        logger.info("> HTTP_X_FORWARDED_FOR : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getRemoteAddr();
	        logger.info("> getRemoteAddr : "+ip);
	    }
	    logger.info("> Result : IP Address : "+ip);

	    return ip;
	}
	
	public String calcDouble(String val) {
		String rtv = "";
		
		if( Double.parseDouble(val) == 0d ) {
			return "0";
		} else {
			if( val.indexOf("E") > -1 ) {
				String[] valArray = val.split("E");
				if( valArray[0].indexOf("-") > -1 ) {
					if( valArray[1].indexOf("-") > -1 ) {
						rtv = "-0.";
						for(int p=0;p<Integer.parseInt(valArray[1].replace("-",""))-1;p++ ) {
							rtv = rtv + "0";
						}
						rtv = rtv + valArray[0].replace("-","").replace(".","");
					} else {
						rtv = valArray[0].replace(".","");
						for(int p=0;p<Integer.parseInt(valArray[1]);p++ ) {
							rtv = rtv + "0";
						}
					}
				} else {
					if( valArray[1].indexOf("-") > -1 ) {
						rtv = "0.";
						for(int p=0;p<Integer.parseInt(valArray[1].replace("-",""))-1;p++ ) {
							rtv = rtv + "0";
						}
						rtv = rtv + valArray[0].replace("-","").replace(".","");
					} else {
						rtv = valArray[0].replace(".","");
						for(int p=valArray[0].replace(".","").length()-1;p<Integer.parseInt(valArray[1]);p++ ) {
							rtv = rtv + "0";
						}
					}
				}
				return rtv;
			} else {
				return val;
			}
		}
	}
	
	public String setDataConv(DccTagInfo dccTagInfo, String menuNo, String val, String gap) {
		String rtv = "";
		Double tmpNum = 0d;
    	
    	String[] gFormat = {"%.4f",
    						"%.4f",
    						"%.4f",
		        			"%.4f",
		        			"%.3f",
		        			"%.3f",
		        			"%.3f",
		        			"%.2f",
		        			"%.2f",
		        			"%.2f",
		        			"%.2f",
		        			"%.1f",
		        			"%.1f",
		        			"%.1f",
		        			"%.1f",
		        			"%.0f"};
		
		try {
			tmpNum = Double.parseDouble(val);
			String strIoType = dccTagInfo.getIoType();

			switch ( strIoType ) {
				case "DI": case "DO":
					tmpNum = getBitVal(val,dccTagInfo.getIoBit());
					
					//rtv = bitNum > -32768 ? String.format(gFormat[15],tmpNum) : "-99999";
					break;
				case "SC":
					if( dccTagInfo.getSaveCore() == "1" && !"".equals(dccTagInfo.getIoBit()) ) {
						tmpNum = getBitVal(val,dccTagInfo.getIoBit());
						
						//rtv = bitNum > -32768 ? String.valueOf(tmpNum) : "-99999";
					} else if( !"".equals(dccTagInfo.getBscal()) && dccTagInfo.getSaveCore() != "1" ) {
						tmpNum = tmpNum/((int) Math.pow(2,15-Integer.parseInt(dccTagInfo.getBscal())));
						
						//String conv = gFormat[Integer.parseInt(dccTagInfo.getBscal())];
						
						//rtv = tmpNum > -32768 ? String.format(conv,tmpNum) : "-99999";
					} else {
						//rtv = tmpNum > -32768 ? String.valueOf(tmpNum) : "-99999";
					}
					break;
				case "AI":
					if( dccTagInfo.getAddress() == "2010" || dccTagInfo.getAddress() == "2140" ) {
						tmpNum = tmpNum / 0.0081;
					}
					
					/*
					 * if( !"".equals(dccTagInfo.getBscal()) && dccTagInfo.getSaveCore() != "1" ) {
					 * tmpNum = tmpNum/((int)
					 * Math.pow(2,15-Integer.parseInt(dccTagInfo.getBscal())));
					 * 
					 * String conv = gFormat[Integer.parseInt(dccTagInfo.getBscal())];
					 * 
					 * rtv = tmpNum > -32768 ? String.format(conv,tmpNum) : "-99999"; } else { rtv =
					 * tmpNum > -32768 ? String.valueOf(tmpNum) : "-99999"; }
					 */
					break;
				default:
					//rtv = tmpNum > -32768 ? String.valueOf(tmpNum) : "-99999";
					break;
			}
			
			if( "21".equals(menuNo) || "22".equals(menuNo) ) {
				if( Integer.parseInt(gap) < 5000 && "1".equals(dccTagInfo.getFastIoChk()) && !"".equals(dccTagInfo.getBscal()) ) {
					tmpNum = tmpNum/((int) Math.pow(2,15-Integer.parseInt(dccTagInfo.getBscal())));
					
					//String conv = gFormat[Integer.parseInt(dccTagInfo.getBscal())];
					
					//rtv = tmpNum > -32768 ? String.format(conv,tmpNum) : "-99999";
				} else {
					//rtv = tmpNum > -32768 ? String.valueOf(tmpNum) : "-99999";
				}
			}
			
			if( "DI".equals(strIoType) || "DO".equals(strIoType) || ("SC".equals(strIoType) && dccTagInfo.getSaveCore() == "1") ) {
				rtv = tmpNum > -32768 ? String.format(gFormat[15],tmpNum) : "***IRR";
			} else if( !"".equals(dccTagInfo.getBscal()) ) {
				String conv = gFormat[Integer.parseInt(dccTagInfo.getBscal())];
				
				rtv = tmpNum > -32768 ? String.format(conv,tmpNum) : "***IRR";
			} else {
				rtv = tmpNum > -32768 ? String.valueOf(tmpNum) : "***IRR";
			}
			
			return rtv;
		} catch(NumberFormatException nfe) {
			return "-99999";
		}
	}
	
	// - 디지털 값을 가져온다.(16bit -> 1bit)
	//private int getBitVal(ByVal DigitalValue As String, ByVal DigitalBit As String) As String
	private Double getBitVal(String digitalValue, String digitalBit) {
	    
	    long Rest = 0;
	    
	    long di_val;
	    int bit_no;	    
	    
	    if(digitalBit.isEmpty()) {
	       if(digitalValue == null) {
	    	   return 0d;
	       }else {
	    	   return Double.parseDouble(digitalValue);
	       }
	    }
	    
	    di_val = Math.round(Double.parseDouble(digitalValue));	    
	    bit_no = Integer.parseInt(digitalBit);

	    for(int i = 0;i < bit_no;i++) {
	        Rest = (di_val % 2);
	        //di_val = di_val \ 2;
	    	di_val = di_val >> 2;
		}
	    
	    return Double.parseDouble(Rest +"");
	}
	
	
	/*
	public Double getBitVal(String num, String bit) {
		Double rtv = 0d;
		Double tmpNum = 0d;
		int tmpBit = 0;
		try {
			tmpNum = Double.parseDouble(num);
			tmpBit = Integer.parseInt(bit);
			
			if( "".equals(bit) ) {
				return -99999d;
			} else {
				for( int i=0;i<tmpBit;i++ ) {
					rtv = tmpNum%2;
					//tmpNum = (tmpNum-rtv)/2;
					tmpNum = tmpNum >> 2;
				}
				return rtv;
			}
		} catch(NumberFormatException nfe ) {
			return -99999d;
		}
	}
	*/
	
	@RequestMapping("htcExcelExport")
	public void htcExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		try{
	        	
        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("3");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	
        	List<DccGrpTagInfo> dccGrpTagInfoList = dccStatusService.selectDccGrpTag(dccSearchStatus);
        	List<DccTagInfo> dccTagInfoList = new ArrayList<DccTagInfo>();
        	DccTagInfo dccTagInfo = null;
        	
        	for( int i=0;i<dccGrpTagInfoList.size();i++ ) {
        		dccTagInfo = new DccTagInfo();
        		
        		dccTagInfo.setAddress(dccGrpTagInfoList.get(i).getAddress());
        		dccTagInfo.setAlarmType(dccGrpTagInfoList.get(i).getType());
        		dccTagInfo.setBscal(dccGrpTagInfoList.get(i).getBscal());
        		dccTagInfo.setDataLoop(dccGrpTagInfoList.get(i).getDataLoop());
        		dccTagInfo.setDescr(dccGrpTagInfoList.get(i).getDescr());
        		switch( dccGrpTagInfoList.get(i).getType().toString()) {
        			case "1":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "2":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "3":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "4":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "5":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "6":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				if( dccGrpTagInfoList.get(i).getLimit2() == "-32768" ) {
        					dccTagInfo.setDataLimit1("-32768");
        				} else {
        					dccTagInfo.setDtabLimit2("1");
        				}
        				break;
        			case "7":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "8":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			default:
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        		}
        		dccTagInfo.seteHigh(dccGrpTagInfoList.get(i).geteHigh());
        		dccTagInfo.seteLow(dccGrpTagInfoList.get(i).geteLow());
        		dccTagInfo.setFastIoChk(dccGrpTagInfoList.get(i).getFastIoChk());
        		dccTagInfo.setFldNo(dccGrpTagInfoList.get(i).getFldNo());
        		dccTagInfo.setFldNoFast(dccGrpTagInfoList.get(i).getFldNoFast());
        		dccTagInfo.setGrpHogi(dccGrpTagInfoList.get(i).getGrpHogi());
        		dccTagInfo.setHogi(dccGrpTagInfoList.get(i).getHogi());
        		dccTagInfo.setIoBit(dccGrpTagInfoList.get(i).getIoBit());
        		dccTagInfo.setIoType(dccGrpTagInfoList.get(i).getIoType());
        		dccTagInfo.setiSeq(dccGrpTagInfoList.get(i).getiSeq());
        		dccTagInfo.setLoopName(dccGrpTagInfoList.get(i).getLoopName());
        		dccTagInfo.setSaveCore(dccGrpTagInfoList.get(i).getSaveCoreChk());
        		dccTagInfo.setTblNo(dccGrpTagInfoList.get(i).getTblNo());
        		if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2010" || dccGrpTagInfoList.get(i).getAddress() == "2140")) {
        			dccTagInfo.setUnit("DAC");
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		} else if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2753" || dccGrpTagInfoList.get(i).getAddress() == "2754")) {
        			dccTagInfo.setUnit("KPAG");
            		dccTagInfo.setMaxVal(String.valueOf(Double.parseDouble(dccTagInfo.getMaxVal())*1000));
            		dccTagInfo.setMinVal(String.valueOf(Double.parseDouble(dccTagInfo.getMinVal())*1000));
        		} else {
        			dccTagInfo.setUnit(dccGrpTagInfoList.get(i).getUnit());
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		}
        		dccTagInfo.setvHigh(dccGrpTagInfoList.get(i).getvHigh());
        		dccTagInfo.setvLow(dccGrpTagInfoList.get(i).getvLow());
        		dccTagInfo.setXyGubun(dccGrpTagInfoList.get(i).getXyGubun());
        		
        		dccTagInfoList.add(dccTagInfo);
        	}
        	
        	List<DccLogTrendInfo> dccLogTrendInfoList = new ArrayList<DccLogTrendInfo>();
        	List<DccLogTrendInfo> dccLogTrendInfoTmpList = new ArrayList<DccLogTrendInfo>();
    		String scanTime = dccStatusService.selectScanTime(dccSearchStatus);
    		if( scanTime == null || "".equals(scanTime) ) {
    			dccSearchStatus.setStartDate("");
    		} else {
    			dccSearchStatus.setStartDate(scanTime);
    		}
    		List<TblFldInfo> tblFldInfo = dccStatusService.selectTblFldNo(dccSearchStatus);
    		if( tblFldInfo.size() > 0  ) {
    			dccSearchStatus.setTblNo(tblFldInfo.get(0).getTblNo());
    			
    			dccLogTrendInfoTmpList = dccStatusService.selectLogTrend(dccSearchStatus);
    			
    			dccLogTrendInfoTmpList.forEach(t -> {
    				t.setTVALUE1(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE1(),"0"));
    				t.setTVALUE2(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE2(),"0"));
    				t.setTVALUE3(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE3(),"0"));
    				t.setTVALUE4(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE4(),"0"));
    				t.setTVALUE5(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE5(),"0"));
    				t.setTVALUE6(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE6(),"0"));
    				t.setTVALUE7(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE7(),"0"));
    				t.setTVALUE8(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE8(),"0"));
    				t.setTVALUE9(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE9(),"0"));
    				t.setTVALUE10(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE10(),"0"));
    				t.setTVALUE11(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE11(),"0"));
    				t.setTVALUE12(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE12(),"0"));
    				t.setTVALUE13(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE13(),"0"));
    				t.setTVALUE14(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE14(),"0"));
    				t.setTVALUE15(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE15(),"0"));
    				t.setTVALUE16(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE16(),"0"));
    				t.setTVALUE17(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0"));
    				t.setTVALUE18(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE18(),"0"));
    				t.setTVALUE19(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0"));
    				t.setTVALUE20(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0"));
    				t.setTVALUE21(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE21(),"0"));
    				t.setTVALUE22("0".equals(calcDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE22(),"0"))) ? "OFF" : "ON");
    				t.setTVALUE23("0".equals(calcDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE23(),"0"))) ? "OFF" : "ON");
    				t.setTVALUE24("0".equals(calcDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE24(),"0"))) ? "OFF" : "ON");
    				t.setTVALUE25("0".equals(calcDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE25(),"0"))) ? "OFF" : "ON");
    				t.setTVALUE26(getBitVal(t.getTVALUE26(),"0") == 0d ? "MANUAL" : "AUTO");
    				t.setTVALUE27(getBitVal(t.getTVALUE27(),"0") == 0d ? "MANUAL" : "AUTO");
    				t.setTVALUE28("0".equals(calcDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE28(),"0"))) ? "OFF" : "ON");
    				t.setTVALUE29(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE29(),"0"));
    				t.setTVALUE30(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE30(),"0"));
    				t.setTVALUE31(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE31(),"0"));
    				t.setTVALUE32(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE32(),"0"));
    				t.setTVALUE33(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE33(),"0"));
    				t.setTVALUE34(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE34(),"0"));
    				t.setTVALUE35(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE35(),"0"));
    				t.setTVALUE36(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE36(),"0"));
    			});
    			for( int j=0;j<dccLogTrendInfoTmpList.size();j++ ) {
    				dccLogTrendInfoList.add(dccLogTrendInfoTmpList.get(j));
    			}
    		}
    		
    		List<String> scanTimeList = new ArrayList<String>();
    		for( int si=0;si<dccLogTrendInfoList.size();si++ ) {
    			scanTimeList.add(dccSearchStatus.getHogi()+dccSearchStatus.getXyGubun()+" "+dccLogTrendInfoList.get(si).getSCANTIME());
    		}
    		
    		List<String[]> values = new ArrayList<String[]>();
    		for( DccLogTrendInfo dccLogTrendInfo : dccLogTrendInfoList ) {
    			values.add(getLogValues(dccLogTrendInfo,"htc"));
    		}
    		
    		excelHelperUtil.statusExcelDownload(request, response, values, dccTagInfoList, scanTimeList, "htc");

		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	public String[] getLogValues(DccLogTrendInfo d, String type) {
		switch ( type.toLowerCase() ) {
		case "htc":
			String[] rtv_htc = {d.getTVALUE1(),d.getTVALUE2(),d.getTVALUE3(),d.getTVALUE4(),d.getTVALUE5(),
							d.getTVALUE6(),d.getTVALUE7(),d.getTVALUE8(),d.getTVALUE9(),d.getTVALUE10(),
							d.getTVALUE11(),d.getTVALUE12(),d.getTVALUE13(),d.getTVALUE14(),d.getTVALUE15(),
							d.getTVALUE16(),d.getTVALUE17(),d.getTVALUE18(),d.getTVALUE19(),d.getTVALUE20(),
							d.getTVALUE21(),d.getTVALUE22(),d.getTVALUE23(),d.getTVALUE24(),d.getTVALUE25(),
							d.getTVALUE26(),d.getTVALUE27(),d.getTVALUE28(),d.getTVALUE29(),d.getTVALUE30(),
							d.getTVALUE31(),d.getTVALUE32(),d.getTVALUE33(),d.getTVALUE34(),d.getTVALUE35(),
							d.getTVALUE36()};
			
			return rtv_htc;
		case "rrs":
			String[] rtv_rrs = {d.getTVALUE1(),d.getTVALUE2(),d.getTVALUE3(),d.getTVALUE4(),d.getTVALUE5(),
							d.getTVALUE6(),d.getTVALUE7(),d.getTVALUE8(),d.getTVALUE9(),d.getTVALUE10(),
							d.getTVALUE11(),d.getTVALUE12(),d.getTVALUE13(),d.getTVALUE14(),d.getTVALUE15(),
							d.getTVALUE16(),d.getTVALUE17(),d.getTVALUE18(),d.getTVALUE19(),d.getTVALUE20(),
							d.getTVALUE21(),d.getTVALUE22(),d.getTVALUE23(),d.getTVALUE24(),d.getTVALUE25(),
							d.getTVALUE26(),d.getTVALUE27(),d.getTVALUE28()};
			
			return rtv_rrs;
		case "stb":
			String[] rtv_stb = {d.getTVALUE1(),d.getTVALUE2(),d.getTVALUE3(),d.getTVALUE4(),d.getTVALUE5(),
							d.getTVALUE6(),d.getTVALUE7(),d.getTVALUE8(),d.getTVALUE9(),d.getTVALUE10(),
							d.getTVALUE11(),d.getTVALUE12(),d.getTVALUE13(),d.getTVALUE14(),d.getTVALUE15(),
							d.getTVALUE16(),d.getTVALUE17(),d.getTVALUE18(),d.getTVALUE19(),d.getTVALUE20(),
							d.getTVALUE21(),d.getTVALUE22(),d.getTVALUE23(),d.getTVALUE24(),d.getTVALUE25(),
							d.getTVALUE26(),d.getTVALUE27(),d.getTVALUE28(),d.getTVALUE29(),d.getTVALUE30(),
							d.getTVALUE31(),d.getTVALUE32(),d.getTVALUE33(),d.getTVALUE34(),d.getTVALUE35(),
							d.getTVALUE36(),d.getTVALUE37(),d.getTVALUE38(),d.getTVALUE39(),d.getTVALUE40(),
							d.getTVALUE41(),d.getTVALUE42(),d.getTVALUE43(),d.getTVALUE44(),d.getTVALUE45(),
							d.getTVALUE46(),d.getTVALUE47(),d.getTVALUE48(),d.getTVALUE49(),d.getTVALUE50(),
							d.getTVALUE51(),d.getTVALUE52(),d.getTVALUE53(),d.getTVALUE54(),d.getTVALUE55(),
							d.getTVALUE56(),d.getTVALUE57(),d.getTVALUE58(),d.getTVALUE59(),d.getTVALUE60(),
							d.getTVALUE61(),d.getTVALUE62(),d.getTVALUE63(),d.getTVALUE64(),d.getTVALUE65(),
							d.getTVALUE66(),d.getTVALUE67()};
			
			return rtv_stb;
		case "sb":
			String[] rtv_sb = {d.getTVALUE1(),d.getTVALUE2(),d.getTVALUE3(),d.getTVALUE4(),d.getTVALUE5(),
							d.getTVALUE6(),d.getTVALUE7(),d.getTVALUE8(),d.getTVALUE9(),d.getTVALUE10(),
							d.getTVALUE11(),d.getTVALUE12(),d.getTVALUE13(),d.getTVALUE14(),d.getTVALUE15(),
							d.getTVALUE16(),d.getTVALUE17(),d.getTVALUE18(),d.getTVALUE19(),d.getTVALUE20(),
							d.getTVALUE21(),d.getTVALUE22(),d.getTVALUE23(),d.getTVALUE24(),d.getTVALUE25(),
							d.getTVALUE26(),d.getTVALUE27(),d.getTVALUE28(),d.getTVALUE29(),d.getTVALUE30(),
							d.getTVALUE31(),d.getTVALUE32(),d.getTVALUE33(),d.getTVALUE34(),d.getTVALUE35(),
							d.getTVALUE36(),d.getTVALUE37(),d.getTVALUE38(),d.getTVALUE39(),d.getTVALUE40(),
							d.getTVALUE41(),d.getTVALUE42(),d.getTVALUE43(),d.getTVALUE44(),d.getTVALUE45(),
							d.getTVALUE46(),d.getTVALUE47(),d.getTVALUE48(),d.getTVALUE49(),d.getTVALUE50(),
							d.getTVALUE51(),d.getTVALUE52(),d.getTVALUE53(),d.getTVALUE54(),d.getTVALUE55()};
			
			return rtv_sb;
			case "mtc":
				String[] rtv_mtc = {d.getTVALUE1(),d.getTVALUE2(),d.getTVALUE3(),d.getTVALUE4(),d.getTVALUE5(),
								d.getTVALUE6(),d.getTVALUE7(),d.getTVALUE8(),d.getTVALUE9(),d.getTVALUE10(),
								d.getTVALUE11(),d.getTVALUE12(),d.getTVALUE13(),d.getTVALUE14(),d.getTVALUE15()};
				
				return rtv_mtc;
			case "sgp":
				String[] rtv_sgp = {d.getTVALUE1(),d.getTVALUE2(),d.getTVALUE3(),d.getTVALUE4(),d.getTVALUE5(),
								d.getTVALUE6(),d.getTVALUE7(),d.getTVALUE8(),d.getTVALUE9(),d.getTVALUE10(),
								d.getTVALUE11(),d.getTVALUE12(),d.getTVALUE13(),d.getTVALUE14(),d.getTVALUE15(),
								d.getTVALUE16(),d.getTVALUE17(),d.getTVALUE18(),d.getTVALUE19(),d.getTVALUE20()};
				
				return rtv_sgp;
			case "sgl":
				String[] rtv_sgl = {d.getTVALUE1(),d.getTVALUE2(),d.getTVALUE3(),d.getTVALUE4(),d.getTVALUE5(),
								d.getTVALUE6(),d.getTVALUE7(),d.getTVALUE8(),d.getTVALUE9(),d.getTVALUE10(),
								d.getTVALUE11(),d.getTVALUE12(),d.getTVALUE13(),d.getTVALUE14(),d.getTVALUE15(),
								d.getTVALUE16(),d.getTVALUE17(),d.getTVALUE18(),d.getTVALUE19(),d.getTVALUE20(),
								d.getTVALUE21(),d.getTVALUE22(),d.getTVALUE23(),d.getTVALUE24(),d.getTVALUE25(),
								d.getTVALUE26(),d.getTVALUE27(),d.getTVALUE28(),d.getTVALUE29(),d.getTVALUE30(),
								d.getTVALUE31(),d.getTVALUE32(),d.getTVALUE33(),d.getTVALUE34(),d.getTVALUE35(),
								d.getTVALUE36(),d.getTVALUE37(),d.getTVALUE38(),d.getTVALUE39(),d.getTVALUE40(),
								d.getTVALUE41(),d.getTVALUE42(),d.getTVALUE43(),d.getTVALUE44(),d.getTVALUE45(),
								d.getTVALUE46(),d.getTVALUE47(),d.getTVALUE48(),d.getTVALUE49(),d.getTVALUE50(),
								d.getTVALUE51(),d.getTVALUE52(),d.getTVALUE53(),d.getTVALUE54(),d.getTVALUE55(),
								d.getTVALUE56(),d.getTVALUE57(),d.getTVALUE58(),d.getTVALUE59(),d.getTVALUE60(),
								d.getTVALUE61(),d.getTVALUE62(),d.getTVALUE63(),d.getTVALUE64()};
				
				return rtv_sgl;
			case "phtpump":
				String[] rtv_phtpump = {d.getTVALUE1(),d.getTVALUE2(),d.getTVALUE3(),d.getTVALUE4(),d.getTVALUE5(),
								d.getTVALUE6(),d.getTVALUE7(),d.getTVALUE8(),d.getTVALUE9(),d.getTVALUE10(),
								d.getTVALUE11(),d.getTVALUE12(),d.getTVALUE13(),d.getTVALUE14(),d.getTVALUE15(),
								d.getTVALUE16(),d.getTVALUE17(),d.getTVALUE18(),d.getTVALUE19(),d.getTVALUE20(),
								d.getTVALUE21(),d.getTVALUE22(),d.getTVALUE23(),d.getTVALUE24(),d.getTVALUE25(),
								d.getTVALUE26(),d.getTVALUE27(),d.getTVALUE28(),d.getTVALUE29(),d.getTVALUE30(),
								d.getTVALUE31(),d.getTVALUE32(),d.getTVALUE33(),d.getTVALUE34(),d.getTVALUE35(),
								d.getTVALUE36(),d.getTVALUE37(),d.getTVALUE38(),d.getTVALUE39(),d.getTVALUE40(),
								d.getTVALUE41(),d.getTVALUE42(),d.getTVALUE43(),d.getTVALUE44(),d.getTVALUE45(),
								d.getTVALUE46(),d.getTVALUE47(),d.getTVALUE48(),d.getTVALUE49(),d.getTVALUE50(),
								d.getTVALUE51(),d.getTVALUE52(),d.getTVALUE53(),d.getTVALUE54(),d.getTVALUE55(),
								d.getTVALUE56(),d.getTVALUE57(),d.getTVALUE58(),d.getTVALUE59(),d.getTVALUE60()};
				
				return rtv_phtpump;
			default:
				return null;
		}
	}
	
	@RequestMapping("htcSaveTag")
	public ModelAndView htcSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("3");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	if( dccSearchStatus.getGubun() == null ) dccSearchStatus.setGubun("D");
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/htc");
        
        }
        
        return mav;
	}
	
	@RequestMapping(value="htcTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView htcTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="htcTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView htcTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	public ModelAndView tagSearch(ModelAndView mav, DccSearchStatus dccSearchStatus, HttpServletRequest request) {

    	List<DccMstTagInfo> dccMstTagInfo = dccStatusService.selectTagSearch(dccSearchStatus);
    	dccSearchStatus.setMenuName(this.menuName);
    	
    	mav.addObject("BaseSearch", dccSearchStatus);
    	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
    	mav.addObject("TagSearchInfo", dccMstTagInfo);
    	
        return mav;
    }

	public ModelAndView tagFind(ModelAndView mav,DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		List<DccMstTagInfo> dccTagFindList = dccStatusService.selectTagFind(dccSearchStatus);
		dccSearchStatus.setMenuName(this.menuName);
		
		mav.addObject("BaseSearch", dccSearchStatus);
		mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
		mav.addObject("TagFindList", dccTagFindList);
        	
        return mav;
    }
	
	@RequestMapping("mtc")
	public ModelAndView mtc(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();

        logger.info("############ mtc");
        
    	if(request.getSession().getAttribute("USER_INFO") != null) {    		

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		//dccSearchStatus.setsDive("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("4");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
    		dccGrpTagSearchMap.put("dive","D");
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
    	}

        return mav;
    }
	
	@RequestMapping("mtcExcelExport")
	public void mtcExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		try{
			
			if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("4");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	
        	List<DccGrpTagInfo> dccGrpTagInfoList = dccStatusService.selectDccGrpTag(dccSearchStatus);

        	List<DccTagInfo> dccTagInfoList = new ArrayList<DccTagInfo>();
        	DccTagInfo dccTagInfo = null;
        	
        	for( int i=0;i<dccGrpTagInfoList.size();i++ ) {
        		dccTagInfo = new DccTagInfo();
        		
        		dccTagInfo.setAddress(dccGrpTagInfoList.get(i).getAddress());
        		dccTagInfo.setAlarmType(dccGrpTagInfoList.get(i).getType());
        		dccTagInfo.setBscal(dccGrpTagInfoList.get(i).getBscal());
        		dccTagInfo.setDataLoop(dccGrpTagInfoList.get(i).getDataLoop());
        		dccTagInfo.setDescr(dccGrpTagInfoList.get(i).getDescr());
        		switch( dccGrpTagInfoList.get(i).getType().toString()) {
        			case "1":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "2":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "3":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "4":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "5":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "6":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				if( dccGrpTagInfoList.get(i).getLimit2() == "-32768" ) {
        					dccTagInfo.setDataLimit1("-32768");
        				} else {
        					dccTagInfo.setDtabLimit2("1");
        				}
        				break;
        			case "7":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "8":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			default:
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        		}

        		dccTagInfo.seteHigh(dccGrpTagInfoList.get(i).geteHigh());
        		dccTagInfo.seteLow(dccGrpTagInfoList.get(i).geteLow());
        		dccTagInfo.setFastIoChk(dccGrpTagInfoList.get(i).getFastIoChk());
        		dccTagInfo.setFldNo(dccGrpTagInfoList.get(i).getFldNo());
        		dccTagInfo.setFldNoFast(dccGrpTagInfoList.get(i).getFldNoFast());
        		dccTagInfo.setGrpHogi(dccGrpTagInfoList.get(i).getGrpHogi());
        		dccTagInfo.setHogi(dccGrpTagInfoList.get(i).getHogi());
        		dccTagInfo.setIoBit(dccGrpTagInfoList.get(i).getIoBit());
        		dccTagInfo.setIoType(dccGrpTagInfoList.get(i).getIoType());
        		dccTagInfo.setiSeq(dccGrpTagInfoList.get(i).getiSeq());
        		dccTagInfo.setLoopName(dccGrpTagInfoList.get(i).getLoopName());
        		dccTagInfo.setSaveCore(dccGrpTagInfoList.get(i).getSaveCoreChk());
        		dccTagInfo.setTblNo(dccGrpTagInfoList.get(i).getTblNo());
        		if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2010" || dccGrpTagInfoList.get(i).getAddress() == "2140")) {
        			dccTagInfo.setUnit("DAC");
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		} else if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2753" || dccGrpTagInfoList.get(i).getAddress() == "2754")) {
        			dccTagInfo.setUnit("KPAG");
            		dccTagInfo.setMaxVal(String.valueOf(Double.parseDouble(dccTagInfo.getMaxVal())*1000));
            		dccTagInfo.setMinVal(String.valueOf(Double.parseDouble(dccTagInfo.getMinVal())*1000));
        		} else {
        			dccTagInfo.setUnit(dccGrpTagInfoList.get(i).getUnit());
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		}
        		dccTagInfo.setvHigh(dccGrpTagInfoList.get(i).getvHigh());
        		dccTagInfo.setvLow(dccGrpTagInfoList.get(i).getvLow());
        		dccTagInfo.setXyGubun(dccGrpTagInfoList.get(i).getXyGubun());
        		
        		dccTagInfoList.add(dccTagInfo);
        	}
        	
        	List<DccLogTrendInfo> dccLogTrendInfoList = new ArrayList<DccLogTrendInfo>();
        	List<DccLogTrendInfo> dccLogTrendInfoTmpList = new ArrayList<DccLogTrendInfo>();
    		String scanTime = dccStatusService.selectScanTime(dccSearchStatus);

    		if( scanTime == null || "".equals(scanTime) ) {
    			dccSearchStatus.setStartDate("");
    		} else {
    			dccSearchStatus.setStartDate(scanTime);
    		}
    		List<TblFldInfo> tblFldInfo = dccStatusService.selectTblFldNo(dccSearchStatus);
    		if( tblFldInfo.size() > 0  ) {
    			dccSearchStatus.setTblNo(tblFldInfo.get(0).getTblNo());
    			
    			dccLogTrendInfoTmpList = dccStatusService.selectLogTrend(dccSearchStatus);
    			
    			dccLogTrendInfoTmpList.forEach(t -> {
    				t.setTVALUE1(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE1(),"0"));
    				t.setTVALUE2(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE2(),"0"));
    				t.setTVALUE3(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE3(),"0"));
    				t.setTVALUE4(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE4(),"0"));
    				t.setTVALUE5(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE5(),"0"));
    				t.setTVALUE6(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE6(),"0"));
    				t.setTVALUE7(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE7(),"0"));
    				t.setTVALUE8(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE8(),"0"));
    				t.setTVALUE9(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE9(),"0"));
    				t.setTVALUE10(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE10(),"0"));
    				t.setTVALUE11(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE11(),"0"));
    				t.setTVALUE12(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE12(),"0"));
    				t.setTVALUE13(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE13(),"0"));
    				t.setTVALUE14(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE14(),"0"));
    				t.setTVALUE15(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE15(),"0"));
    			});
    			for( int j=0;j<dccLogTrendInfoTmpList.size();j++ ) {
    				dccLogTrendInfoList.add(dccLogTrendInfoTmpList.get(j));
    			}
    		}
    		
    		List<String> scanTimeList = new ArrayList<String>();
    		for( int si=0;si<dccLogTrendInfoList.size();si++ ) {
    			scanTimeList.add(dccSearchStatus.getHogi()+dccSearchStatus.getXyGubun()+" "+dccLogTrendInfoList.get(si).getSCANTIME());
    		}
    		
    		List<String[]> values = new ArrayList<String[]>();
    		for( DccLogTrendInfo dccLogTrendInfo : dccLogTrendInfoList ) {
    			values.add(getLogValues(dccLogTrendInfo,"mtc"));
    		}
    		
    		excelHelperUtil.statusExcelDownload(request, response, values, dccTagInfoList, scanTimeList, "mtc");
			
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("mtcSaveTag")
	public ModelAndView mtcSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("3");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	if( dccSearchStatus.getGubun() == null ) dccSearchStatus.setGubun("D");
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/mtc");
        
        }
        
        return mav;
	}
	
	@RequestMapping(value="mtcTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView mtcTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="mtcTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView mtcTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("phtpump")
	public ModelAndView phtpump(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ phtpump");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		//dccSearchStatus.setsDive("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("7");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
    		dccGrpTagSearchMap.put("dive","D");
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	
        	
        }

        return mav;
    }
	
	@RequestMapping("phtpumpExcelExport")
	public void phtpumpExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		try{
			
			if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("7");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	
        	List<DccGrpTagInfo> dccGrpTagInfoList = dccStatusService.selectDccGrpTag(dccSearchStatus);

        	List<DccTagInfo> dccTagInfoList = new ArrayList<DccTagInfo>();
        	DccTagInfo dccTagInfo = null;
        	
        	for( int i=0;i<dccGrpTagInfoList.size();i++ ) {
        		dccTagInfo = new DccTagInfo();
        		
        		dccTagInfo.setAddress(dccGrpTagInfoList.get(i).getAddress());
        		dccTagInfo.setAlarmType(dccGrpTagInfoList.get(i).getType());
        		dccTagInfo.setBscal(dccGrpTagInfoList.get(i).getBscal());
        		dccTagInfo.setDataLoop(dccGrpTagInfoList.get(i).getDataLoop());
        		dccTagInfo.setDescr(dccGrpTagInfoList.get(i).getDescr());
        		switch( dccGrpTagInfoList.get(i).getType().toString()) {
        			case "1":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "2":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "3":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "4":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "5":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "6":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				if( dccGrpTagInfoList.get(i).getLimit2() == "-32768" ) {
        					dccTagInfo.setDataLimit1("-32768");
        				} else {
        					dccTagInfo.setDtabLimit2("1");
        				}
        				break;
        			case "7":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "8":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			default:
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        		}

        		dccTagInfo.seteHigh(dccGrpTagInfoList.get(i).geteHigh());
        		dccTagInfo.seteLow(dccGrpTagInfoList.get(i).geteLow());
        		dccTagInfo.setFastIoChk(dccGrpTagInfoList.get(i).getFastIoChk());
        		dccTagInfo.setFldNo(dccGrpTagInfoList.get(i).getFldNo());
        		dccTagInfo.setFldNoFast(dccGrpTagInfoList.get(i).getFldNoFast());
        		dccTagInfo.setGrpHogi(dccGrpTagInfoList.get(i).getGrpHogi());
        		dccTagInfo.setHogi(dccGrpTagInfoList.get(i).getHogi());
        		dccTagInfo.setIoBit(dccGrpTagInfoList.get(i).getIoBit());
        		dccTagInfo.setIoType(dccGrpTagInfoList.get(i).getIoType());
        		dccTagInfo.setiSeq(dccGrpTagInfoList.get(i).getiSeq());
        		dccTagInfo.setLoopName(dccGrpTagInfoList.get(i).getLoopName());
        		dccTagInfo.setSaveCore(dccGrpTagInfoList.get(i).getSaveCoreChk());
        		dccTagInfo.setTblNo(dccGrpTagInfoList.get(i).getTblNo());
        		if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2010" || dccGrpTagInfoList.get(i).getAddress() == "2140")) {
        			dccTagInfo.setUnit("DAC");
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		} else if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2753" || dccGrpTagInfoList.get(i).getAddress() == "2754")) {
        			dccTagInfo.setUnit("KPAG");
            		dccTagInfo.setMaxVal(String.valueOf(Double.parseDouble(dccTagInfo.getMaxVal())*1000));
            		dccTagInfo.setMinVal(String.valueOf(Double.parseDouble(dccTagInfo.getMinVal())*1000));
        		} else {
        			dccTagInfo.setUnit(dccGrpTagInfoList.get(i).getUnit());
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		}
        		dccTagInfo.setvHigh(dccGrpTagInfoList.get(i).getvHigh());
        		dccTagInfo.setvLow(dccGrpTagInfoList.get(i).getvLow());
        		dccTagInfo.setXyGubun(dccGrpTagInfoList.get(i).getXyGubun());
        		
        		dccTagInfoList.add(dccTagInfo);
        	}
        	
        	List<DccLogTrendInfo> dccLogTrendInfoList = new ArrayList<DccLogTrendInfo>();
        	List<DccLogTrendInfo> dccLogTrendInfoTmpList = new ArrayList<DccLogTrendInfo>();
    		String scanTime = dccStatusService.selectScanTime(dccSearchStatus);

    		if( scanTime == null || "".equals(scanTime) ) {
    			dccSearchStatus.setStartDate("");
    		} else {
    			dccSearchStatus.setStartDate(scanTime);
    		}
    		List<TblFldInfo> tblFldInfo = dccStatusService.selectTblFldNo(dccSearchStatus);
    		if( tblFldInfo.size() > 0  ) {
    			dccSearchStatus.setTblNo(tblFldInfo.get(0).getTblNo());
    			
    			dccLogTrendInfoTmpList = dccStatusService.selectLogTrend(dccSearchStatus);
    			
    			dccLogTrendInfoTmpList.forEach(t -> {
    				t.setTVALUE1(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE1(),"0"));
    				t.setTVALUE2(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE2(),"0"));
    				t.setTVALUE3(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE3(),"0"));
    				t.setTVALUE4(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE4(),"0"));
    				t.setTVALUE5(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE5(),"0"));
    				t.setTVALUE6(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE6(),"0"));
    				t.setTVALUE7(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE7(),"0"));
    				t.setTVALUE8(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE8(),"0"));
    				t.setTVALUE9(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE9(),"0"));
    				t.setTVALUE10(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE10(),"0"));
    				t.setTVALUE11(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE11(),"0"));
    				t.setTVALUE12(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE12(),"0"));
    				t.setTVALUE13(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE13(),"0"));
    				t.setTVALUE14(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE14(),"0"));
    				t.setTVALUE15(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE15(),"0"));
    				t.setTVALUE16(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE16(),"0"));
    				t.setTVALUE17(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0"));
    				t.setTVALUE18(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE18(),"0"));
    				t.setTVALUE19(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0"));
    				t.setTVALUE20(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0"));
    				t.setTVALUE21(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE21(),"0"));
    				t.setTVALUE22(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE22(),"0"));
    				t.setTVALUE23(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE23(),"0"));
    				t.setTVALUE24(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE24(),"0"));
    				t.setTVALUE25(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE25(),"0"));
    				t.setTVALUE26(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE26(),"0"));
    				t.setTVALUE27(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE27(),"0"));
    				t.setTVALUE28(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE28(),"0"));
    				t.setTVALUE29(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE29(),"0"));
    				t.setTVALUE30(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE30(),"0"));
    				t.setTVALUE31(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE31(),"0"));
    				t.setTVALUE32(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE32(),"0"));
    				t.setTVALUE33(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE33(),"0"));
    				t.setTVALUE34(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE34(),"0"));
    				t.setTVALUE35(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE35(),"0"));
    				t.setTVALUE36(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE36(),"0"));
    				t.setTVALUE37(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE37(),"0"));
    				t.setTVALUE38(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE38(),"0"));
    				t.setTVALUE39(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE39(),"0"));
    				t.setTVALUE40(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE40(),"0"));
    				t.setTVALUE41(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE41(),"0"));
    				t.setTVALUE42(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE42(),"0"));
    				t.setTVALUE43(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE43(),"0"));
    				t.setTVALUE44(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE44(),"0"));
    				t.setTVALUE45(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE45(),"0"));
    				t.setTVALUE46(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE46(),"0"));
    				t.setTVALUE47(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE47(),"0"));
    				t.setTVALUE48(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE48(),"0"));
    				t.setTVALUE49(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE49(),"0"));
    				t.setTVALUE50(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE50(),"0"));
    				t.setTVALUE51(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE51(),"0"));
    				t.setTVALUE52(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE52(),"0"));
    				t.setTVALUE53(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE53(),"0"));
    				t.setTVALUE54(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE54(),"0"));
    				t.setTVALUE55(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE55(),"0")) == 0d ? "OFF" : "ON" );
    				t.setTVALUE56(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE56(),"0")) == 0d ? "OFF" : "ON" );
    				t.setTVALUE57(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE57(),"0")) == 0d ? "OFF" : "ON" );
    				t.setTVALUE58(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE58(),"0")) == 0d ? "OFF" : "ON" );
    				t.setTVALUE59(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE59(),"0"));
    				t.setTVALUE60(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE60(),"0")); 				
    			});
    			for( int j=0;j<dccLogTrendInfoTmpList.size();j++ ) {
    				dccLogTrendInfoList.add(dccLogTrendInfoTmpList.get(j));
    			}
    		}
    		
    		List<String> scanTimeList = new ArrayList<String>();
    		for( int si=0;si<dccLogTrendInfoList.size();si++ ) {
    			scanTimeList.add(dccSearchStatus.getHogi()+dccSearchStatus.getXyGubun()+" "+dccLogTrendInfoList.get(si).getSCANTIME());
    		}
    		
    		List<String[]> values = new ArrayList<String[]>();
    		for( DccLogTrendInfo dccLogTrendInfo : dccLogTrendInfoList ) {
    			values.add(getLogValues(dccLogTrendInfo,"phtpump"));
    		}
    		
    		excelHelperUtil.statusExcelDownload(request, response, values, dccTagInfoList, scanTimeList, "phtpump");
			
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("phtpumpSaveTag")
	public ModelAndView phtpumpSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("3");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	if( dccSearchStatus.getGubun() == null ) dccSearchStatus.setGubun("D");
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/phtpump");
        
        }
        
        return mav;
	}
	
	@RequestMapping(value="phtpumpTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView phtpumpTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="phtpumpTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView phtpumpTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("rrs")
	public ModelAndView rrs(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
      
		ModelAndView mav = new ModelAndView();

        logger.info("############ rrs");
        
    	if(request.getSession().getAttribute("USER_INFO") != null) {    
    		
    		dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		//dccSearchStatus.setsDive("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("3");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
    		dccGrpTagSearchMap.put("dive","D");
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));    		
        }
        

        return mav;
    }
	
	@RequestMapping("rrsExcelExport")
	public void rrsExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		try{
	        	
        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("2");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	
        	List<DccGrpTagInfo> dccGrpTagInfoList = dccStatusService.selectDccGrpTag(dccSearchStatus);
        	List<DccTagInfo> dccTagInfoList = new ArrayList<DccTagInfo>();
        	DccTagInfo dccTagInfo = null;
        	
        	for( int i=0;i<dccGrpTagInfoList.size();i++ ) {
        		dccTagInfo = new DccTagInfo();
        		
        		dccTagInfo.setAddress(dccGrpTagInfoList.get(i).getAddress());
        		dccTagInfo.setAlarmType(dccGrpTagInfoList.get(i).getType());
        		dccTagInfo.setBscal(dccGrpTagInfoList.get(i).getBscal());
        		dccTagInfo.setDataLoop(dccGrpTagInfoList.get(i).getDataLoop());
        		dccTagInfo.setDescr(dccGrpTagInfoList.get(i).getDescr());
        		switch( dccGrpTagInfoList.get(i).getType().toString()) {
        			case "1":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "2":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "3":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "4":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "5":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "6":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				if( dccGrpTagInfoList.get(i).getLimit2() == "-32768" ) {
        					dccTagInfo.setDataLimit1("-32768");
        				} else {
        					dccTagInfo.setDtabLimit2("1");
        				}
        				break;
        			case "7":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "8":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			default:
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        		}
        		dccTagInfo.seteHigh(dccGrpTagInfoList.get(i).geteHigh());
        		dccTagInfo.seteLow(dccGrpTagInfoList.get(i).geteLow());
        		dccTagInfo.setFastIoChk(dccGrpTagInfoList.get(i).getFastIoChk());
        		dccTagInfo.setFldNo(dccGrpTagInfoList.get(i).getFldNo());
        		dccTagInfo.setFldNoFast(dccGrpTagInfoList.get(i).getFldNoFast());
        		dccTagInfo.setGrpHogi(dccGrpTagInfoList.get(i).getGrpHogi());
        		dccTagInfo.setHogi(dccGrpTagInfoList.get(i).getHogi());
        		dccTagInfo.setIoBit(dccGrpTagInfoList.get(i).getIoBit());
        		dccTagInfo.setIoType(dccGrpTagInfoList.get(i).getIoType());
        		dccTagInfo.setiSeq(dccGrpTagInfoList.get(i).getiSeq());
        		dccTagInfo.setLoopName(dccGrpTagInfoList.get(i).getLoopName());
        		dccTagInfo.setSaveCore(dccGrpTagInfoList.get(i).getSaveCoreChk());
        		dccTagInfo.setTblNo(dccGrpTagInfoList.get(i).getTblNo());
        		if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2010" || dccGrpTagInfoList.get(i).getAddress() == "2140")) {
        			dccTagInfo.setUnit("DAC");
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		} else if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2753" || dccGrpTagInfoList.get(i).getAddress() == "2754")) {
        			dccTagInfo.setUnit("KPAG");
            		dccTagInfo.setMaxVal(String.valueOf(Double.parseDouble(dccTagInfo.getMaxVal())*1000));
            		dccTagInfo.setMinVal(String.valueOf(Double.parseDouble(dccTagInfo.getMinVal())*1000));
        		} else {
        			dccTagInfo.setUnit(dccGrpTagInfoList.get(i).getUnit());
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		}
        		dccTagInfo.setvHigh(dccGrpTagInfoList.get(i).getvHigh());
        		dccTagInfo.setvLow(dccGrpTagInfoList.get(i).getvLow());
        		dccTagInfo.setXyGubun(dccGrpTagInfoList.get(i).getXyGubun());
        		
        		dccTagInfoList.add(dccTagInfo);
        	}
        	
        	List<DccLogTrendInfo> dccLogTrendInfoList = new ArrayList<DccLogTrendInfo>();
        	List<DccLogTrendInfo> dccLogTrendInfoTmpList = new ArrayList<DccLogTrendInfo>();
    		String scanTime = dccStatusService.selectScanTime(dccSearchStatus);
    		if( scanTime == null || "".equals(scanTime) ) {
    			dccSearchStatus.setStartDate("");
    		} else {
    			dccSearchStatus.setStartDate(scanTime);
    		}
    		List<TblFldInfo> tblFldInfo = dccStatusService.selectTblFldNo(dccSearchStatus);
    		if( tblFldInfo.size() > 0  ) {
    			dccSearchStatus.setTblNo(tblFldInfo.get(0).getTblNo());
    			
    			dccLogTrendInfoTmpList = dccStatusService.selectLogTrend(dccSearchStatus);
    			
    			dccLogTrendInfoTmpList.forEach(t -> {
					t.setTVALUE1(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE1(),"0"));
					t.setTVALUE2(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE2(),"0"));
					t.setTVALUE3(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE3(),"0"));
					t.setTVALUE4(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE4(),"0"));
					t.setTVALUE5(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE5(),"0"));
					t.setTVALUE6(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE6(),"0"));
					t.setTVALUE7(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE7(),"0"));
					t.setTVALUE8(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE8(),"0"));
					t.setTVALUE9(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE9(),"0"));
					t.setTVALUE10(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE10(),"0"));
					t.setTVALUE11(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE11(),"0"));
					t.setTVALUE12(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE12(),"0"));
					t.setTVALUE13(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE13(),"0"));
					t.setTVALUE14(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE14(),"0"));
					t.setTVALUE15(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE15(),"0"));
					t.setTVALUE16(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE16(),"0"));
					t.setTVALUE17(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0"));
					t.setTVALUE18(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE18(),"0"));
					t.setTVALUE19(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0"));
    				t.setTVALUE20(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0")) == 0d ? "ALTERNATE" : "NORMAL" );
    				t.setTVALUE21(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE21(),"0")) == 0d ? "NO" : "YES" );
    				t.setTVALUE22(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE22(),"0")) == 0d ? "YES" : "NO" );
    				t.setTVALUE23(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE23(),"0")) == 0d ? "YES" : "NO" );
    				t.setTVALUE24(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE24(),"0")) == 0d ? "YES" : "NO" );
    				t.setTVALUE25(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE25(),"0")) == 0d ? "YES" : "NO" );
    				t.setTVALUE26(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE26(),"0")) == 0d ? "NO" : "YES" );
    				t.setTVALUE27(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE27(),"0")) == 0d ? "NO" : "YES" );
    				t.setTVALUE28(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE28(),"0"));
    			});
    			for( int j=0;j<dccLogTrendInfoTmpList.size();j++ ) {
    				dccLogTrendInfoList.add(dccLogTrendInfoTmpList.get(j));
    			}
    		}
    		
    		List<String> scanTimeList = new ArrayList<String>();
    		for( int si=0;si<dccLogTrendInfoList.size();si++ ) {
    			scanTimeList.add(dccSearchStatus.getHogi()+dccSearchStatus.getXyGubun()+" "+dccLogTrendInfoList.get(si).getSCANTIME());
    		}
    		
    		List<String[]> values = new ArrayList<String[]>();
    		for( DccLogTrendInfo dccLogTrendInfo : dccLogTrendInfoList ) {
    			values.add(getLogValues(dccLogTrendInfo,"rrs"));
    		}
    		
    		excelHelperUtil.statusExcelDownload(request, response, values, dccTagInfoList, scanTimeList, "rrs");
			
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("rrsSaveTag")
	public ModelAndView rrsSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("2");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	if( dccSearchStatus.getGubun() == null ) dccSearchStatus.setGubun("D");
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	mav.setViewName("redirect:/dcc/status/rrs");
        }
        
        return mav;
	}
	
	@RequestMapping(value="rrsTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView rrsTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="rrsTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView rrsTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("sgl")
	public ModelAndView sql(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sgl");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		//dccSearchStatus.setsDive("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("6");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
    		dccGrpTagSearchMap.put("dive","D");
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        

        return mav;
    }
	
	@RequestMapping("sglExcelExport")
	public void sglExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		try{
			
			if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("6");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	
        	List<DccGrpTagInfo> dccGrpTagInfoList = dccStatusService.selectDccGrpTag(dccSearchStatus);

        	List<DccTagInfo> dccTagInfoList = new ArrayList<DccTagInfo>();
        	DccTagInfo dccTagInfo = null;
        	
        	for( int i=0;i<dccGrpTagInfoList.size();i++ ) {
        		dccTagInfo = new DccTagInfo();
        		
        		dccTagInfo.setAddress(dccGrpTagInfoList.get(i).getAddress());
        		dccTagInfo.setAlarmType(dccGrpTagInfoList.get(i).getType());
        		dccTagInfo.setBscal(dccGrpTagInfoList.get(i).getBscal());
        		dccTagInfo.setDataLoop(dccGrpTagInfoList.get(i).getDataLoop());
        		dccTagInfo.setDescr(dccGrpTagInfoList.get(i).getDescr());
        		switch( dccGrpTagInfoList.get(i).getType().toString()) {
        			case "1":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "2":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "3":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "4":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "5":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "6":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				if( dccGrpTagInfoList.get(i).getLimit2() == "-32768" ) {
        					dccTagInfo.setDataLimit1("-32768");
        				} else {
        					dccTagInfo.setDtabLimit2("1");
        				}
        				break;
        			case "7":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "8":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			default:
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        		}

        		dccTagInfo.seteHigh(dccGrpTagInfoList.get(i).geteHigh());
        		dccTagInfo.seteLow(dccGrpTagInfoList.get(i).geteLow());
        		dccTagInfo.setFastIoChk(dccGrpTagInfoList.get(i).getFastIoChk());
        		dccTagInfo.setFldNo(dccGrpTagInfoList.get(i).getFldNo());
        		dccTagInfo.setFldNoFast(dccGrpTagInfoList.get(i).getFldNoFast());
        		dccTagInfo.setGrpHogi(dccGrpTagInfoList.get(i).getGrpHogi());
        		dccTagInfo.setHogi(dccGrpTagInfoList.get(i).getHogi());
        		dccTagInfo.setIoBit(dccGrpTagInfoList.get(i).getIoBit());
        		dccTagInfo.setIoType(dccGrpTagInfoList.get(i).getIoType());
        		dccTagInfo.setiSeq(dccGrpTagInfoList.get(i).getiSeq());
        		dccTagInfo.setLoopName(dccGrpTagInfoList.get(i).getLoopName());
        		dccTagInfo.setSaveCore(dccGrpTagInfoList.get(i).getSaveCoreChk());
        		dccTagInfo.setTblNo(dccGrpTagInfoList.get(i).getTblNo());
        		if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2010" || dccGrpTagInfoList.get(i).getAddress() == "2140")) {
        			dccTagInfo.setUnit("DAC");
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		} else if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2753" || dccGrpTagInfoList.get(i).getAddress() == "2754")) {
        			dccTagInfo.setUnit("KPAG");
            		dccTagInfo.setMaxVal(String.valueOf(Double.parseDouble(dccTagInfo.getMaxVal())*1000));
            		dccTagInfo.setMinVal(String.valueOf(Double.parseDouble(dccTagInfo.getMinVal())*1000));
        		} else {
        			dccTagInfo.setUnit(dccGrpTagInfoList.get(i).getUnit());
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		}
        		dccTagInfo.setvHigh(dccGrpTagInfoList.get(i).getvHigh());
        		dccTagInfo.setvLow(dccGrpTagInfoList.get(i).getvLow());
        		dccTagInfo.setXyGubun(dccGrpTagInfoList.get(i).getXyGubun());
        		
        		dccTagInfoList.add(dccTagInfo);
        	}
        	
        	List<DccLogTrendInfo> dccLogTrendInfoList = new ArrayList<DccLogTrendInfo>();
        	List<DccLogTrendInfo> dccLogTrendInfoTmpList = new ArrayList<DccLogTrendInfo>();
    		String scanTime = dccStatusService.selectScanTime(dccSearchStatus);

    		if( scanTime == null || "".equals(scanTime) ) {
    			dccSearchStatus.setStartDate("");
    		} else {
    			dccSearchStatus.setStartDate(scanTime);
    		}
    		List<TblFldInfo> tblFldInfo = dccStatusService.selectTblFldNo(dccSearchStatus);
    		if( tblFldInfo.size() > 0  ) {
    			dccSearchStatus.setTblNo(tblFldInfo.get(0).getTblNo());
    			
    			dccLogTrendInfoTmpList = dccStatusService.selectLogTrend(dccSearchStatus);
    			
    			dccLogTrendInfoTmpList.forEach(t -> {
    				t.setTVALUE1(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE1(),"0"));
    				t.setTVALUE2(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE2(),"0"));
    				t.setTVALUE3(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE3(),"0"));
    				t.setTVALUE4(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE4(),"0"));
    				t.setTVALUE5(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE5(),"0"));
    				t.setTVALUE6(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE6(),"0"));
    				t.setTVALUE7(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE7(),"0"));
    				t.setTVALUE8(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE8(),"0"));
    				t.setTVALUE9(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE9(),"0"));
    				t.setTVALUE10(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE10(),"0"));
    				t.setTVALUE11(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE11(),"0"));
    				t.setTVALUE12(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE12(),"0"));
    				t.setTVALUE13(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE13(),"0"));
    				t.setTVALUE14(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE14(),"0"));
    				t.setTVALUE15(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE15(),"0"));
    				t.setTVALUE16(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE16(),"0"));
    				t.setTVALUE17(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0"));
    				t.setTVALUE18(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE18(),"0"));
    				t.setTVALUE19(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0"));
    				t.setTVALUE20(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0"));
    				t.setTVALUE21(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE21(),"0"));
    				t.setTVALUE22(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE22(),"0"));
    				t.setTVALUE23(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE23(),"0"));
    				t.setTVALUE24(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE24(),"0"));
    				t.setTVALUE25(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE25(),"0"));
    				t.setTVALUE26(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE26(),"0"));
    				t.setTVALUE27(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE27(),"0"));
    				t.setTVALUE28(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE28(),"0"));
    				t.setTVALUE29(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE29(),"0"));
    				t.setTVALUE30(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE30(),"0"));
    				t.setTVALUE31(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE31(),"0"));
    				t.setTVALUE32(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE32(),"0"));
    				t.setTVALUE33(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE33(),"0"));
    				t.setTVALUE34(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE34(),"0"))));
    				t.setTVALUE35(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE35(),"0"))));
    				t.setTVALUE36(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE36(),"0"))));
    				t.setTVALUE37(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE37(),"0"))));
    				t.setTVALUE38(String.format("%.3f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE38(),"0"))));
    				t.setTVALUE39(String.format("%.3f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE39(),"0"))));
    				t.setTVALUE40(String.format("%.3f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE40(),"0"))));
    				t.setTVALUE41(String.format("%.3f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE41(),"0"))));
    				t.setTVALUE42(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE42(),"0")) == 0d ? "A" : "C" );	//-# DI:52-03
    				t.setTVALUE43(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE43(),"0")) == 0d ? "A" : "C" );	//-# DI:53-00
    				t.setTVALUE44(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE44(),"0")) == 0d ? "A" : "C" );	//-# DI:54-01
    				t.setTVALUE45(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE45(),"0")) == 0d ? "A" : "C" );	//-# DI:54-02
    				t.setTVALUE46(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE46(),"0")) == 0d ? "NO" : "YES" );	//-# DI:71-14
    				t.setTVALUE47(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE47(),"0")) == 0d ? "NO" : "YES" );	//-# DI:71-15
    				t.setTVALUE48(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE48(),"0")) == 0d ? "NO" : "YES" );	//-# DI:71-00
    				t.setTVALUE49(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE49(),"0")) == 0d ? "NO" : "YES" );	//-# DI:71-01
    				t.setTVALUE50(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE50(),"0")) == 0d ? "NO" : "YES" );	//-# SC:3153
    				t.setTVALUE51(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE51(),"0")) == 0d ? "NO" : "YES" );	//-# SC:3153
    				t.setTVALUE52(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE52(),"0")) == 0d ? "NO" : "YES" );	//-# SC:3153
    				t.setTVALUE53(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE53(),"0")) == 0d ? "NO" : "YES" );	//-# SC:3153
    				t.setTVALUE54(String.format("%.3f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE54(),"0"))));
    				t.setTVALUE55(String.format("%.3f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE55(),"0"))));
    				t.setTVALUE56(String.format("%.3f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE56(),"0"))));
    				t.setTVALUE57(String.format("%.3f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE57(),"0"))));
    				t.setTVALUE58(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE58(),"0"))));
    				t.setTVALUE59(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE59(),"0"))));
    				t.setTVALUE60(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE60(),"0"))));
    				t.setTVALUE61(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE61(),"0"))));
    				t.setTVALUE62(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE62(),"0"))));
    				t.setTVALUE63(String.format("%.2f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE63(),"0"))));
    				t.setTVALUE64(String.format("%.4f",Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE64(),"0"))));    				
    			});
    			for( int j=0;j<dccLogTrendInfoTmpList.size();j++ ) {
    				dccLogTrendInfoList.add(dccLogTrendInfoTmpList.get(j));
    			}
    		}
    		
    		List<String> scanTimeList = new ArrayList<String>();
    		for( int si=0;si<dccLogTrendInfoList.size();si++ ) {
    			scanTimeList.add(dccSearchStatus.getHogi()+dccSearchStatus.getXyGubun()+" "+dccLogTrendInfoList.get(si).getSCANTIME());
    		}
    		
    		List<String[]> values = new ArrayList<String[]>();
    		for( DccLogTrendInfo dccLogTrendInfo : dccLogTrendInfoList ) {
    			values.add(getLogValues(dccLogTrendInfo,"sgl"));
    		}
    		
    		excelHelperUtil.statusExcelDownload(request, response, values, dccTagInfoList, scanTimeList, "sgl");
			
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("sglSaveTag")
	public ModelAndView sglSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("3");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	if( dccSearchStatus.getGubun() == null ) dccSearchStatus.setGubun("D");
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/sgl");
        
        }
        
        return mav;
	}
	
	@RequestMapping(value="sglTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sglTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="sglTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sglTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("sgp")
	public ModelAndView sgp(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ sgp");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		//dccSearchStatus.setsDive("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("5");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
    		dccGrpTagSearchMap.put("dive","D");
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }
        

        return mav;
    }	
	
	@RequestMapping("sgpExcelExport")
	public void sgpExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		try{
			
			if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("5");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	
        	List<DccGrpTagInfo> dccGrpTagInfoList = dccStatusService.selectDccGrpTag(dccSearchStatus);

        	List<DccTagInfo> dccTagInfoList = new ArrayList<DccTagInfo>();
        	DccTagInfo dccTagInfo = null;
        	
        	for( int i=0;i<dccGrpTagInfoList.size();i++ ) {
        		dccTagInfo = new DccTagInfo();
        		
        		dccTagInfo.setAddress(dccGrpTagInfoList.get(i).getAddress());
        		dccTagInfo.setAlarmType(dccGrpTagInfoList.get(i).getType());
        		dccTagInfo.setBscal(dccGrpTagInfoList.get(i).getBscal());
        		dccTagInfo.setDataLoop(dccGrpTagInfoList.get(i).getDataLoop());
        		dccTagInfo.setDescr(dccGrpTagInfoList.get(i).getDescr());
        		switch( dccGrpTagInfoList.get(i).getType().toString()) {
        			case "1":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "2":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "3":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "4":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "5":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "6":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				if( dccGrpTagInfoList.get(i).getLimit2() == "-32768" ) {
        					dccTagInfo.setDataLimit1("-32768");
        				} else {
        					dccTagInfo.setDtabLimit2("1");
        				}
        				break;
        			case "7":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "8":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			default:
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        		}

        		dccTagInfo.seteHigh(dccGrpTagInfoList.get(i).geteHigh());
        		dccTagInfo.seteLow(dccGrpTagInfoList.get(i).geteLow());
        		dccTagInfo.setFastIoChk(dccGrpTagInfoList.get(i).getFastIoChk());
        		dccTagInfo.setFldNo(dccGrpTagInfoList.get(i).getFldNo());
        		dccTagInfo.setFldNoFast(dccGrpTagInfoList.get(i).getFldNoFast());
        		dccTagInfo.setGrpHogi(dccGrpTagInfoList.get(i).getGrpHogi());
        		dccTagInfo.setHogi(dccGrpTagInfoList.get(i).getHogi());
        		dccTagInfo.setIoBit(dccGrpTagInfoList.get(i).getIoBit());
        		dccTagInfo.setIoType(dccGrpTagInfoList.get(i).getIoType());
        		dccTagInfo.setiSeq(dccGrpTagInfoList.get(i).getiSeq());
        		dccTagInfo.setLoopName(dccGrpTagInfoList.get(i).getLoopName());
        		dccTagInfo.setSaveCore(dccGrpTagInfoList.get(i).getSaveCoreChk());
        		dccTagInfo.setTblNo(dccGrpTagInfoList.get(i).getTblNo());
        		if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2010" || dccGrpTagInfoList.get(i).getAddress() == "2140")) {
        			dccTagInfo.setUnit("DAC");
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		} else if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2753" || dccGrpTagInfoList.get(i).getAddress() == "2754")) {
        			dccTagInfo.setUnit("KPAG");
            		dccTagInfo.setMaxVal(String.valueOf(Double.parseDouble(dccTagInfo.getMaxVal())*1000));
            		dccTagInfo.setMinVal(String.valueOf(Double.parseDouble(dccTagInfo.getMinVal())*1000));
        		} else {
        			dccTagInfo.setUnit(dccGrpTagInfoList.get(i).getUnit());
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		}
        		dccTagInfo.setvHigh(dccGrpTagInfoList.get(i).getvHigh());
        		dccTagInfo.setvLow(dccGrpTagInfoList.get(i).getvLow());
        		dccTagInfo.setXyGubun(dccGrpTagInfoList.get(i).getXyGubun());
        		
        		dccTagInfoList.add(dccTagInfo);
        	}
        	
        	List<DccLogTrendInfo> dccLogTrendInfoList = new ArrayList<DccLogTrendInfo>();
        	List<DccLogTrendInfo> dccLogTrendInfoTmpList = new ArrayList<DccLogTrendInfo>();
    		String scanTime = dccStatusService.selectScanTime(dccSearchStatus);

    		if( scanTime == null || "".equals(scanTime) ) {
    			dccSearchStatus.setStartDate("");
    		} else {
    			dccSearchStatus.setStartDate(scanTime);
    		}
    		List<TblFldInfo> tblFldInfo = dccStatusService.selectTblFldNo(dccSearchStatus);
    		if( tblFldInfo.size() > 0  ) {
    			dccSearchStatus.setTblNo(tblFldInfo.get(0).getTblNo());
    			
    			dccLogTrendInfoTmpList = dccStatusService.selectLogTrend(dccSearchStatus);
    			
    			dccLogTrendInfoTmpList.forEach(t -> {
    				t.setTVALUE1(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE1(),"0")) == 0d ? "ALTERNATE" : "NORMAL" );
    				t.setTVALUE2(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE2(),"0"));
    				t.setTVALUE3(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE3(),"0"));
    				t.setTVALUE4(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE4(),"0"));
    				t.setTVALUE5(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE5(),"0")) == 0d ? "YES" : "NO" );
    				t.setTVALUE6(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE6(),"0")) == 0d ? "NO" : "YES" );
    				t.setTVALUE7(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE7(),"0")) == 0d ? "LOCAL" : "REMOTE" );
    				t.setTVALUE8(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE8(),"0"));
    				t.setTVALUE9(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE9(),"0"));
    				t.setTVALUE10(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE10(),"0"));
    				t.setTVALUE11(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE11(),"0"));
    				t.setTVALUE12(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE12(),"0"));
    				t.setTVALUE13(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE13(),"0"));
    				t.setTVALUE14(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE14(),"0"));
    				t.setTVALUE15(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE15(),"0"));
    				t.setTVALUE16(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE16(),"0")) == 0d ? "OFF" : "ON" );
    				t.setTVALUE17(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0"));
    				
    				if (((int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0")))+(int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE18(),"0")))) == 0) {
    					t.setTVALUE18("HOLD");
    				}else if (((int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0")))+(int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE18(),"0")))) == 1) {
    					t.setTVALUE18("WARM");
    				}else {
    					t.setTVALUE18("COOL");
    				}

    				t.setTVALUE19(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0"));
    				
    				if (((int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0")))+(int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0")))) == 0) {
    					t.setTVALUE20("0.0");
    				}else if (((int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0")))+(int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0")))) == 1) {
    					t.setTVALUE20("0.6");
    				}else if (((int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0")))+(int) Math.round(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0")))) == 2) {
    					t.setTVALUE20("1.8");
    				}else {
    					t.setTVALUE20("2.76");
    				}
    			});
    			for( int j=0;j<dccLogTrendInfoTmpList.size();j++ ) {
    				dccLogTrendInfoList.add(dccLogTrendInfoTmpList.get(j));
    			}
    		}
    		
    		List<String> scanTimeList = new ArrayList<String>();
    		for( int si=0;si<dccLogTrendInfoList.size();si++ ) {
    			scanTimeList.add(dccSearchStatus.getHogi()+dccSearchStatus.getXyGubun()+" "+dccLogTrendInfoList.get(si).getSCANTIME());
    		}
    		
    		List<String[]> values = new ArrayList<String[]>();
    		for( DccLogTrendInfo dccLogTrendInfo : dccLogTrendInfoList ) {
    			values.add(getLogValues(dccLogTrendInfo,"sgp"));
    		}
    		
    		excelHelperUtil.statusExcelDownload(request, response, values, dccTagInfoList, scanTimeList, "sgp");
			
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("sgpSaveTag")
	public ModelAndView sgpSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("3");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	if( dccSearchStatus.getGubun() == null ) dccSearchStatus.setGubun("D");
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        	mav.setViewName("redirect:/dcc/status/sgp");
        
        }
        
        return mav;
	}
	
	@RequestMapping(value="sgpTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sgpTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="sgpTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sgpTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("stepbackstatus")
	public ModelAndView stepbackstatus(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();
		
        logger.info("############ stepbackstatus");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		//dccSearchStatus.setsDive("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("12");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
    		dccGrpTagSearchMap.put("dive","D");
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
  

        	/*
        	MemberInfo userInfo = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
        	
        	dccSearchStatus.setUserId(userInfo.getId());
        	dccSearchStatus.setUserIp(getClientIP(request));
        	
        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("12");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	
        	int res = dccStatusService.updateMemberInfo(dccSearchStatus);
        	logger.info("Update User ["+userInfo.getId()+"]...... ["+String.valueOf(res)+"]");
        	
        	List<DccGrpTagInfo> dccGrpTagInfoList = dccStatusService.selectDccGrpTag(dccSearchStatus);
        	List<DccTagInfo> dccTagInfoList = new ArrayList<DccTagInfo>();
        	DccTagInfo dccTagInfo = null;
        	
        	for( int i=0;i<dccGrpTagInfoList.size();i++ ) {
        		dccTagInfo = new DccTagInfo();
        		
        		dccTagInfo.setAddress(dccGrpTagInfoList.get(i).getAddress());
        		dccTagInfo.setAlarmType(dccGrpTagInfoList.get(i).getType());
        		dccTagInfo.setBscal(dccGrpTagInfoList.get(i).getBscal());
        		dccTagInfo.setDataLoop(dccGrpTagInfoList.get(i).getDataLoop());
        		dccTagInfo.setDescr(dccGrpTagInfoList.get(i).getDescr());
        		switch( dccGrpTagInfoList.get(i).getType().toString()) {
        			case "1":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "2":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "3":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "4":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "5":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "6":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				if( dccGrpTagInfoList.get(i).getLimit2() == "-32768" ) {
        					dccTagInfo.setDataLimit1("-32768");
        				} else {
        					dccTagInfo.setDtabLimit2("1");
        				}
        				break;
        			case "7":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "8":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			default:
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        		}
        		dccTagInfo.seteHigh(dccGrpTagInfoList.get(i).geteHigh());
        		dccTagInfo.seteLow(dccGrpTagInfoList.get(i).geteLow());
        		dccTagInfo.setFastIoChk(dccGrpTagInfoList.get(i).getFastIoChk());
        		dccTagInfo.setFldNo(dccGrpTagInfoList.get(i).getFldNo());
        		dccTagInfo.setFldNoFast(dccGrpTagInfoList.get(i).getFldNoFast());
        		dccTagInfo.setGrpHogi(dccGrpTagInfoList.get(i).getGrpHogi());
        		dccTagInfo.setHogi(dccGrpTagInfoList.get(i).getHogi());
        		dccTagInfo.setIoBit(dccGrpTagInfoList.get(i).getIoBit());
        		dccTagInfo.setIoType(dccGrpTagInfoList.get(i).getIoType());
        		dccTagInfo.setiSeq(dccGrpTagInfoList.get(i).getiSeq());
        		dccTagInfo.setLoopName(dccGrpTagInfoList.get(i).getLoopName());
        		dccTagInfo.setSaveCore(dccGrpTagInfoList.get(i).getSaveCoreChk());
        		dccTagInfo.setTblNo(dccGrpTagInfoList.get(i).getTblNo());
        		if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2010" || dccGrpTagInfoList.get(i).getAddress() == "2140")) {
        			dccTagInfo.setUnit("DAC");
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		} else if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2753" || dccGrpTagInfoList.get(i).getAddress() == "2754")) {
        			dccTagInfo.setUnit("KPAG");
            		dccTagInfo.setMaxVal(String.valueOf(Double.parseDouble(dccTagInfo.getMaxVal())*1000));
            		dccTagInfo.setMinVal(String.valueOf(Double.parseDouble(dccTagInfo.getMinVal())*1000));
        		} else {
        			dccTagInfo.setUnit(dccGrpTagInfoList.get(i).getUnit());
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		}
        		dccTagInfo.setvHigh(dccGrpTagInfoList.get(i).getvHigh());
        		dccTagInfo.setvLow(dccGrpTagInfoList.get(i).getvLow());
        		dccTagInfo.setXyGubun(dccGrpTagInfoList.get(i).getXyGubun());
        		
        		dccTagInfoList.add(dccTagInfo);
        	}
        	
        	List<DccLogTrendInfo> dccLogTrendInfoList = new ArrayList<DccLogTrendInfo>();
        	List<DccLogTrendInfo> dccLogTrendInfoTmpList = new ArrayList<DccLogTrendInfo>();
    		String scanTime = dccStatusService.selectScanTime(dccSearchStatus);
    		if( scanTime == null || "".equals(scanTime) ) {
    			dccSearchStatus.setStartDate("");
    		} else {
    			dccSearchStatus.setStartDate(scanTime);
    		}
    		List<TblFldInfo> tblFldInfo = dccStatusService.selectTblFldNo(dccSearchStatus);
    		if( tblFldInfo.size() > 0  ) {
    			dccSearchStatus.setTblNo(tblFldInfo.get(0).getTblNo());
    			
    			dccLogTrendInfoTmpList = dccStatusService.selectLogTrend(dccSearchStatus);
    			
    			dccLogTrendInfoTmpList.forEach(t -> {
    				String tmpVal1 = selectValue("2",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE1(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE2(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE3(),"0"),0)[0];
					t.setTVALUE1(tmpVal1);
					t.setTVALUE2("");
					t.setTVALUE3("");
    				String tmpVal4 = selectValue("2",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE4(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE5(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE6(),"0"),3)[0];
					t.setTVALUE4(tmpVal4);
					t.setTVALUE5("");
					t.setTVALUE6("");
					t.setTVALUE7(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE7(),"0")) > 0d ? "ON" : "OFF");
					t.setTVALUE8(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE8(),"0")) > 0d ? "ON" : "OFF");
					t.setTVALUE9(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE9(),"0")) > 0d ? "ON" : "OFF");
					t.setTVALUE10(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE10(),"0")) > 0d ? "ON" : "OFF");
					t.setTVALUE11(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE11(),"0"));
					t.setTVALUE12(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE12(),"0"));
					String[] tmpVal13 = selectValue("0",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE13(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE14(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE15(),"0"),12);
					t.setTVALUE13(tmpVal13[0]);
					t.setTVALUE14(tmpVal13[1]);
					t.setTVALUE15("");
					String[] tmpVal16 = selectValue("0",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE16(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE18(),"0"),15);
					t.setTVALUE16(tmpVal16[0]);
					t.setTVALUE17(tmpVal16[1]);
					t.setTVALUE18("");
					String[] tmpVal19 = selectValue("0",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE21(),"0"),18);
					t.setTVALUE19(tmpVal19[0]);
					t.setTVALUE20(tmpVal19[1]);
					t.setTVALUE21("");
					String[] tmpVal22 = selectValue("0",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE22(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE23(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE24(),"0"),21);
					t.setTVALUE22(tmpVal22[0]);
					t.setTVALUE23(tmpVal22[1]);
					t.setTVALUE24("");
					t.setTVALUE25(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE25(),"0"));
					t.setTVALUE26(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE26(),"0"));
					t.setTVALUE27(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE27(),"0"));
					t.setTVALUE28(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE28(),"0"));
					String aiVal = setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE62(),"0")+"_"+setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE63(),"0")+"_"+setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE64(),"0");
					String[] tmpVal29 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE29(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE30(),"0"),aiVal,28);
					t.setTVALUE29(tmpVal29[0]);
					t.setTVALUE30(tmpVal29[1]);
					String[] tmpVal31 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE31(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE32(),"0"),aiVal,30);
					t.setTVALUE31(tmpVal31[0]);
					t.setTVALUE32(tmpVal31[1]);
					String[] tmpVal33 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE33(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE34(),"0"),aiVal,32);
					t.setTVALUE33(tmpVal33[0]);
					t.setTVALUE34(tmpVal33[1]);
					String[] tmpVal35 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE35(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE36(),"0"),aiVal,34);
					t.setTVALUE35(tmpVal35[0]);
					t.setTVALUE36(tmpVal35[1]);
					String[] tmpVal37 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE37(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE38(),"0"),aiVal,36);
					t.setTVALUE37(tmpVal37[0]);
					t.setTVALUE38(tmpVal37[1]);
					String[] tmpVal39 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE39(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE40(),"0"),aiVal,38);
					t.setTVALUE39(tmpVal39[0]);
					t.setTVALUE40(tmpVal39[1]);
					String[] tmpVal41 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE41(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE42(),"0"),aiVal,40);
					t.setTVALUE41(tmpVal41[0]);
					t.setTVALUE42(tmpVal41[1]);
					String[] tmpVal43 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE43(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE44(),"0"),aiVal,42);
					t.setTVALUE43(tmpVal43[0]);
					t.setTVALUE44(tmpVal43[1]);
					String[] tmpVal45 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE45(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE46(),"0"),aiVal,44);
					t.setTVALUE45(tmpVal45[0]);
					t.setTVALUE46(tmpVal45[1]);
					String[] tmpVal47 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE47(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE48(),"0"),aiVal,46);
					t.setTVALUE47(tmpVal47[0]);
					t.setTVALUE48(tmpVal47[1]);
					String[] tmpVal49 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE49(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE50(),"0"),aiVal,48);
					t.setTVALUE49(tmpVal49[0]);
					t.setTVALUE50(tmpVal49[1]);
					String[] tmpVal51 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE51(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE52(),"0"),aiVal,50);
					t.setTVALUE51(tmpVal51[0]);
					t.setTVALUE52(tmpVal51[1]);
					String[] tmpVal53 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE53(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE54(),"0"),aiVal,52);
					t.setTVALUE53(tmpVal53[0]);
					t.setTVALUE54(tmpVal53[1]);
					String[] tmpVal55 = selectValue("1",setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE55(),"0"),setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE56(),"0"),aiVal,54);
					t.setTVALUE55(tmpVal55[0]);
					t.setTVALUE56(tmpVal55[1]);
					if( Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE57(),"0")) > -32768d ) {
						t.setTVALUE57(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE57(),"0")) > 0d ? "YES" : "NO");
					} else {
						t.setTVALUE57("***IRR");
					}
					t.setTVALUE58(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE58(),"0"));
					t.setTVALUE59(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE59(),"0"));
					t.setTVALUE60(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE60(),"0"));
					t.setTVALUE61(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE61(),"0"));
					t.setTVALUE62(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE62(),"0"));
					t.setTVALUE63(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE63(),"0"));
					t.setTVALUE64(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE64(),"0"));
					t.setTVALUE65(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE65(),"0"));
					t.setTVALUE66(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE66(),"0"));
					t.setTVALUE67(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE67(),"0"));
    			});
    			for( int j=0;j<dccLogTrendInfoTmpList.size();j++ ) {
    				dccLogTrendInfoList.add(dccLogTrendInfoTmpList.get(j));
    			}
    		}
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	userInfo.setHogi(dccSearchStatus.getHogiHeader());
        	userInfo.setXyGubun(dccSearchStatus.getXyHeader());
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", userInfo);
        	
        	mav.addObject("DccTagInfoList", dccTagInfoList);
        	mav.addObject("DccLogTrendInfoList", dccLogTrendInfoList);
        	*/
        }
        

        return mav;
    }
	
	@RequestMapping("stbExcelExport")
	public void stbExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		try{
	        	
        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("12");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	
        	List<DccGrpTagInfo> dccGrpTagInfoList = dccStatusService.selectDccGrpTag(dccSearchStatus);
        	List<DccTagInfo> dccTagInfoList = new ArrayList<DccTagInfo>();
        	DccTagInfo dccTagInfo = null;
        	
        	for( int i=0;i<dccGrpTagInfoList.size();i++ ) {
        		dccTagInfo = new DccTagInfo();
        		
        		dccTagInfo.setAddress(dccGrpTagInfoList.get(i).getAddress());
        		dccTagInfo.setAlarmType(dccGrpTagInfoList.get(i).getType());
        		dccTagInfo.setBscal(dccGrpTagInfoList.get(i).getBscal());
        		dccTagInfo.setDataLoop(dccGrpTagInfoList.get(i).getDataLoop());
        		dccTagInfo.setDescr(dccGrpTagInfoList.get(i).getDescr());
        		switch( dccGrpTagInfoList.get(i).getType().toString()) {
        			case "1":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "2":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "3":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "4":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "5":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "6":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				if( dccGrpTagInfoList.get(i).getLimit2() == "-32768" ) {
        					dccTagInfo.setDataLimit1("-32768");
        				} else {
        					dccTagInfo.setDtabLimit2("1");
        				}
        				break;
        			case "7":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "8":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			default:
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        		}
        		dccTagInfo.seteHigh(dccGrpTagInfoList.get(i).geteHigh());
        		dccTagInfo.seteLow(dccGrpTagInfoList.get(i).geteLow());
        		dccTagInfo.setFastIoChk(dccGrpTagInfoList.get(i).getFastIoChk());
        		dccTagInfo.setFldNo(dccGrpTagInfoList.get(i).getFldNo());
        		dccTagInfo.setFldNoFast(dccGrpTagInfoList.get(i).getFldNoFast());
        		dccTagInfo.setGrpHogi(dccGrpTagInfoList.get(i).getGrpHogi());
        		dccTagInfo.setHogi(dccGrpTagInfoList.get(i).getHogi());
        		dccTagInfo.setIoBit(dccGrpTagInfoList.get(i).getIoBit());
        		dccTagInfo.setIoType(dccGrpTagInfoList.get(i).getIoType());
        		dccTagInfo.setiSeq(dccGrpTagInfoList.get(i).getiSeq());
        		dccTagInfo.setLoopName(dccGrpTagInfoList.get(i).getLoopName());
        		dccTagInfo.setSaveCore(dccGrpTagInfoList.get(i).getSaveCoreChk());
        		dccTagInfo.setTblNo(dccGrpTagInfoList.get(i).getTblNo());
        		if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2010" || dccGrpTagInfoList.get(i).getAddress() == "2140")) {
        			dccTagInfo.setUnit("DAC");
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		} else if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2753" || dccGrpTagInfoList.get(i).getAddress() == "2754")) {
        			dccTagInfo.setUnit("KPAG");
            		dccTagInfo.setMaxVal(String.valueOf(Double.parseDouble(dccTagInfo.getMaxVal())*1000));
            		dccTagInfo.setMinVal(String.valueOf(Double.parseDouble(dccTagInfo.getMinVal())*1000));
        		} else {
        			dccTagInfo.setUnit(dccGrpTagInfoList.get(i).getUnit());
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		}
        		dccTagInfo.setvHigh(dccGrpTagInfoList.get(i).getvHigh());
        		dccTagInfo.setvLow(dccGrpTagInfoList.get(i).getvLow());
        		dccTagInfo.setXyGubun(dccGrpTagInfoList.get(i).getXyGubun());
        		
        		dccTagInfoList.add(dccTagInfo);
        	}
        	
        	List<DccLogTrendInfo> dccLogTrendInfoList = new ArrayList<DccLogTrendInfo>();
        	List<DccLogTrendInfo> dccLogTrendInfoTmpList = new ArrayList<DccLogTrendInfo>();
    		String scanTime = dccStatusService.selectScanTime(dccSearchStatus);
    		if( scanTime == null || "".equals(scanTime) ) {
    			dccSearchStatus.setStartDate("");
    		} else {
    			dccSearchStatus.setStartDate(scanTime);
    		}
    		List<TblFldInfo> tblFldInfo = dccStatusService.selectTblFldNo(dccSearchStatus);
    		if( tblFldInfo.size() > 0  ) {
    			dccSearchStatus.setTblNo(tblFldInfo.get(0).getTblNo());
    			
    			dccLogTrendInfoTmpList = dccStatusService.selectLogTrend(dccSearchStatus);
    			
    			dccLogTrendInfoTmpList.forEach(t -> {
    				t.setTVALUE1(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE1(),"0"));
					t.setTVALUE2(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE2(),"0"));
					t.setTVALUE3(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE3(),"0"));
    				t.setTVALUE4(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE4(),"0"));
					t.setTVALUE5(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE5(),"0"));
					t.setTVALUE6(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE6(),"0"));
					t.setTVALUE7(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE7(),"0")) > 0d ? "ON" : "OFF");
					t.setTVALUE8(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE8(),"0")) > 0d ? "ON" : "OFF");
					t.setTVALUE9(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE9(),"0")) > 0d ? "ON" : "OFF");
					t.setTVALUE10(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE10(),"0")) > 0d ? "ON" : "OFF");
					t.setTVALUE11(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE11(),"0"));
					t.setTVALUE12(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE12(),"0"));
					t.setTVALUE13(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE13(),"0"));
					t.setTVALUE14(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE14(),"0"));
					t.setTVALUE15(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE15(),"0"));
					t.setTVALUE16(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE16(),"0"));
					t.setTVALUE17(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0"));
					t.setTVALUE18(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE18(),"0"));
					t.setTVALUE19(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0"));
					t.setTVALUE20(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0"));
					t.setTVALUE21(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE21(),"0"));
					t.setTVALUE22(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE22(),"0"));
					t.setTVALUE23(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE23(),"0"));
					t.setTVALUE24(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE24(),"0"));
					t.setTVALUE25(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE25(),"0"));
					t.setTVALUE26(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE26(),"0"));
					t.setTVALUE27(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE27(),"0"));
					t.setTVALUE28(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE28(),"0"));
					t.setTVALUE29(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE29(),"0"));
					t.setTVALUE30(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE30(),"0"));
					t.setTVALUE31(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE31(),"0"));
					t.setTVALUE32(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE32(),"0"));
					t.setTVALUE33(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE33(),"0"));
					t.setTVALUE34(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE34(),"0"));
					t.setTVALUE35(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE35(),"0"));
					t.setTVALUE36(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE36(),"0"));
					t.setTVALUE37(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE37(),"0"));
					t.setTVALUE38(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE38(),"0"));
					t.setTVALUE39(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE39(),"0"));
					t.setTVALUE40(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE40(),"0"));
					t.setTVALUE41(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE41(),"0"));
					t.setTVALUE42(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE42(),"0"));
					t.setTVALUE43(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE43(),"0"));
					t.setTVALUE44(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE44(),"0"));
					t.setTVALUE45(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE45(),"0"));
					t.setTVALUE46(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE46(),"0"));
					t.setTVALUE47(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE47(),"0"));
					t.setTVALUE48(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE48(),"0"));
					t.setTVALUE49(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE49(),"0"));
					t.setTVALUE50(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE50(),"0"));
					t.setTVALUE51(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE51(),"0"));
					t.setTVALUE52(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE52(),"0"));
					t.setTVALUE53(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE53(),"0"));
					t.setTVALUE54(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE54(),"0"));
					t.setTVALUE55(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE55(),"0"));
					if( Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE57(),"0")) > -32768d ) {
						t.setTVALUE57(Double.parseDouble(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE57(),"0")) > 0d ? "YES" : "NO");
					} else {
						t.setTVALUE57("***IRR");
					}
					t.setTVALUE58(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE58(),"0"));
					t.setTVALUE59(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE59(),"0"));
					t.setTVALUE60(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE60(),"0"));
					t.setTVALUE61(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE61(),"0"));
					t.setTVALUE62(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE62(),"0"));
					t.setTVALUE63(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE63(),"0"));
					t.setTVALUE64(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE64(),"0"));
					t.setTVALUE65(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE65(),"0"));
					t.setTVALUE66(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE66(),"0"));
					t.setTVALUE67(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE67(),"0"));
    			});
    			for( int j=0;j<dccLogTrendInfoTmpList.size();j++ ) {
    				dccLogTrendInfoList.add(dccLogTrendInfoTmpList.get(j));
    			}
    		}
    		
    		List<String> scanTimeList = new ArrayList<String>();
    		for( int si=0;si<dccLogTrendInfoList.size();si++ ) {
    			scanTimeList.add(dccSearchStatus.getHogi()+dccSearchStatus.getXyGubun()+" "+dccLogTrendInfoList.get(si).getSCANTIME());
    		}
    		
    		List<String[]> values = new ArrayList<String[]>();
    		for( DccLogTrendInfo dccLogTrendInfo : dccLogTrendInfoList ) {
    			values.add(getLogValues(dccLogTrendInfo,"stb"));
    		}
    		
    		excelHelperUtil.statusExcelDownload(request, response, values, dccTagInfoList, scanTimeList, "stb");
			
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("stbSaveTag")
	public ModelAndView stbSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("12");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	if( dccSearchStatus.getGubun() == null ) dccSearchStatus.setGubun("D");
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	mav.setViewName("redirect:/dcc/status/stepbackstatus");
        }
        
        return mav;
	}
	
	@RequestMapping(value="stbTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView stbTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        }
        return mav;
    }
	
	@RequestMapping(value="stbTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView stbTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping("setbackstatus")
	public ModelAndView setbackstatus(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ setbackstatus");
		
		if(request.getSession().getAttribute("USER_INFO") != null) {
			
			dccSearchStatus.setMenuName(this.menuName);

        	if(dccSearchStatus.getMenuNo() == null || dccSearchStatus.getMenuNo().isEmpty()) {
            	
        		//dccSearchStatus.setsDive("D");
        		dccSearchStatus.setMenuNo("11");
        		dccSearchStatus.setGrpId("mimic");
	        	dccSearchStatus.setGrpNo("13");
	        	
	        	MemberInfo member = (MemberInfo)(request.getSession().getAttribute("USER_INFO"));
	        	dccSearchStatus.setHogi(member.getHogi());
	        	dccSearchStatus.setXyGubun(member.getXyGubun());	        	
        	}
        	
        	Map dccGrpTagSearchMap = new HashMap();
        	dccGrpTagSearchMap.put("xyGubun",dccSearchStatus.getXyGubun()==null?  "": dccSearchStatus.getXyGubun());
        	dccGrpTagSearchMap.put("hogi",dccSearchStatus.getHogi()==null?  "": dccSearchStatus.getHogi());
    		dccGrpTagSearchMap.put("dive","D");
    		dccGrpTagSearchMap.put("grpID", dccSearchStatus.getGrpId()==null?  "": dccSearchStatus.getGrpId());
    		dccGrpTagSearchMap.put("menuNo", dccSearchStatus.getMenuNo()==null?  "": dccSearchStatus.getMenuNo());
    		dccGrpTagSearchMap.put("uGrpNo", dccSearchStatus.getGrpNo()==null?  "": dccSearchStatus.getGrpNo());
    		
    		List<ComTagDccInfo> tagDccInfoList = basDccOsmsService.getDccGrpTagList(dccGrpTagSearchMap);

    		Map dccVal = basDccOsmsService.getDccValue(dccGrpTagSearchMap, tagDccInfoList, mav);
    		
    		mav.addObject("SearchTime", dccVal.get("SearchTime"));
        	mav.addObject("ForeColor", dccVal.get("ForeColor"));
        	mav.addObject("lblDataList", dccVal.get("lblDataList"));
        	mav.addObject("DccTagInfoList", tagDccInfoList);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	
        }
        

        return mav;
    }
	
	@RequestMapping("sbExcelExport")
	public void sbExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchStatus dccSearchStatus) throws Exception {
		try{
	        	
        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("13");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	
        	List<DccGrpTagInfo> dccGrpTagInfoList = dccStatusService.selectDccGrpTag(dccSearchStatus);
        	List<DccTagInfo> dccTagInfoList = new ArrayList<DccTagInfo>();
        	DccTagInfo dccTagInfo = null;
        	
        	for( int i=0;i<dccGrpTagInfoList.size();i++ ) {
        		dccTagInfo = new DccTagInfo();
        		
        		dccTagInfo.setAddress(dccGrpTagInfoList.get(i).getAddress());
        		dccTagInfo.setAlarmType(dccGrpTagInfoList.get(i).getType());
        		dccTagInfo.setBscal(dccGrpTagInfoList.get(i).getBscal());
        		dccTagInfo.setDataLoop(dccGrpTagInfoList.get(i).getDataLoop());
        		dccTagInfo.setDescr(dccGrpTagInfoList.get(i).getDescr());
        		switch( dccGrpTagInfoList.get(i).getType().toString()) {
        			case "1":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "2":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "3":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "4":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "5":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				break;
        			case "6":
        				dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1() == "-32768" ? "1" : dccGrpTagInfoList.get(i).getLimit1());
        				if( dccGrpTagInfoList.get(i).getLimit2() == "-32768" ) {
        					dccTagInfo.setDataLimit1("-32768");
        				} else {
        					dccTagInfo.setDtabLimit2("1");
        				}
        				break;
        			case "7":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			case "8":
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        			default:
                		dccTagInfo.setDataLimit1(dccGrpTagInfoList.get(i).getLimit1());
                		dccTagInfo.setDataLimit2(dccGrpTagInfoList.get(i).getLimit2());
        				break;
        		}
        		dccTagInfo.seteHigh(dccGrpTagInfoList.get(i).geteHigh());
        		dccTagInfo.seteLow(dccGrpTagInfoList.get(i).geteLow());
        		dccTagInfo.setFastIoChk(dccGrpTagInfoList.get(i).getFastIoChk());
        		dccTagInfo.setFldNo(dccGrpTagInfoList.get(i).getFldNo());
        		dccTagInfo.setFldNoFast(dccGrpTagInfoList.get(i).getFldNoFast());
        		dccTagInfo.setGrpHogi(dccGrpTagInfoList.get(i).getGrpHogi());
        		dccTagInfo.setHogi(dccGrpTagInfoList.get(i).getHogi());
        		dccTagInfo.setIoBit(dccGrpTagInfoList.get(i).getIoBit());
        		dccTagInfo.setIoType(dccGrpTagInfoList.get(i).getIoType());
        		dccTagInfo.setiSeq(dccGrpTagInfoList.get(i).getiSeq());
        		dccTagInfo.setLoopName(dccGrpTagInfoList.get(i).getLoopName());
        		dccTagInfo.setSaveCore(dccGrpTagInfoList.get(i).getSaveCoreChk());
        		dccTagInfo.setTblNo(dccGrpTagInfoList.get(i).getTblNo());
        		if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2010" || dccGrpTagInfoList.get(i).getAddress() == "2140")) {
        			dccTagInfo.setUnit("DAC");
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		} else if( dccGrpTagInfoList.get(i).getIoType() == "AI" && (dccGrpTagInfoList.get(i).getAddress() == "2753" || dccGrpTagInfoList.get(i).getAddress() == "2754")) {
        			dccTagInfo.setUnit("KPAG");
            		dccTagInfo.setMaxVal(String.valueOf(Double.parseDouble(dccTagInfo.getMaxVal())*1000));
            		dccTagInfo.setMinVal(String.valueOf(Double.parseDouble(dccTagInfo.getMinVal())*1000));
        		} else {
        			dccTagInfo.setUnit(dccGrpTagInfoList.get(i).getUnit());
            		dccTagInfo.setMaxVal(dccGrpTagInfoList.get(i).getMaxVal());
            		dccTagInfo.setMinVal(dccGrpTagInfoList.get(i).getMinVal());
        		}
        		dccTagInfo.setvHigh(dccGrpTagInfoList.get(i).getvHigh());
        		dccTagInfo.setvLow(dccGrpTagInfoList.get(i).getvLow());
        		dccTagInfo.setXyGubun(dccGrpTagInfoList.get(i).getXyGubun());
        		
        		dccTagInfoList.add(dccTagInfo);
        	}
        	
        	List<DccLogTrendInfo> dccLogTrendInfoList = new ArrayList<DccLogTrendInfo>();
        	List<DccLogTrendInfo> dccLogTrendInfoTmpList = new ArrayList<DccLogTrendInfo>();
    		String scanTime = dccStatusService.selectScanTime(dccSearchStatus);
    		if( scanTime == null || "".equals(scanTime) ) {
    			dccSearchStatus.setStartDate("");
    		} else {
    			dccSearchStatus.setStartDate(scanTime);
    		}
    		List<TblFldInfo> tblFldInfo = dccStatusService.selectTblFldNo(dccSearchStatus);
    		if( tblFldInfo.size() > 0  ) {
    			dccSearchStatus.setTblNo(tblFldInfo.get(0).getTblNo());
    			
    			dccLogTrendInfoTmpList = dccStatusService.selectLogTrend(dccSearchStatus);
    			
    			dccLogTrendInfoTmpList.forEach(t -> {
    				t.setTVALUE1(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE1(),"0"));
					t.setTVALUE2(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE2(),"0"));
					t.setTVALUE3(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE3(),"0"));
					t.setTVALUE4(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE4(),"0"));
					t.setTVALUE5(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE5(),"0"));
					t.setTVALUE6(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE6(),"0"));
					t.setTVALUE7(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE7(),"0"));
					t.setTVALUE8(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE8(),"0"));
					t.setTVALUE9(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE9(),"0"));
					t.setTVALUE10(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE10(),"0"));
					t.setTVALUE11(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE11(),"0"));
					t.setTVALUE12(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE12(),"0"));
					t.setTVALUE13(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE13(),"0"));
					t.setTVALUE14(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE14(),"0"));
					t.setTVALUE15(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE15(),"0"));
					t.setTVALUE16(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE16(),"0"));
					t.setTVALUE17(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE17(),"0"));
					t.setTVALUE18(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE18(),"0"));
					t.setTVALUE19(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE19(),"0"));
					t.setTVALUE20(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE20(),"0"));
					t.setTVALUE21(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE21(),"0"));
					t.setTVALUE22(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE22(),"0"));
					t.setTVALUE23(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE23(),"0"));
					t.setTVALUE24(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE24(),"0"));
					t.setTVALUE25(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE25(),"0"));
					t.setTVALUE26(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE26(),"0"));
					t.setTVALUE27(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE27(),"0"));
					t.setTVALUE28(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE28(),"0"));
					t.setTVALUE29(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE29(),"0"));
					t.setTVALUE30(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE30(),"0"));
					t.setTVALUE31(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE31(),"0"));
					t.setTVALUE32(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE32(),"0"));
					t.setTVALUE33(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE33(),"0"));
					t.setTVALUE34(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE34(),"0"));
					t.setTVALUE35(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE35(),"0"));
					t.setTVALUE36(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE36(),"0"));
					t.setTVALUE37(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE37(),"0"));
					t.setTVALUE38(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE38(),"0"));
					t.setTVALUE39(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE39(),"0"));
					t.setTVALUE40(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE40(),"0"));
					t.setTVALUE41(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE41(),"0"));
					t.setTVALUE42(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE42(),"0"));
					t.setTVALUE43(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE43(),"0"));
					t.setTVALUE44(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE44(),"0"));
					t.setTVALUE45(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE45(),"0"));
					t.setTVALUE46(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE46(),"0"));
					t.setTVALUE47(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE47(),"0"));
					t.setTVALUE48(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE48(),"0"));
					t.setTVALUE49(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE49(),"0"));
					t.setTVALUE50(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE50(),"0"));
					t.setTVALUE51(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE51(),"0"));
					t.setTVALUE52(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE52(),"0"));
					t.setTVALUE53(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE53(),"0"));
					t.setTVALUE54(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE54(),"0"));
					t.setTVALUE55(setDataConv(dccTagInfoList.get(0),"11",t.getTVALUE55(),"0"));
    			});
    			for( int j=0;j<dccLogTrendInfoTmpList.size();j++ ) {
    				dccLogTrendInfoList.add(dccLogTrendInfoTmpList.get(j));
    			}
    		}
    		
    		List<String> scanTimeList = new ArrayList<String>();
    		for( int si=0;si<dccLogTrendInfoList.size();si++ ) {
    			scanTimeList.add(dccSearchStatus.getHogi()+dccSearchStatus.getXyGubun()+" "+dccLogTrendInfoList.get(si).getSCANTIME());
    		}
    		
    		List<String[]> values = new ArrayList<String[]>();
    		for( DccLogTrendInfo dccLogTrendInfo : dccLogTrendInfoList ) {
    			values.add(getLogValues(dccLogTrendInfo,"sb"));
    		}
    		
    		excelHelperUtil.statusExcelDownload(request, response, values, dccTagInfoList, scanTimeList, "sb");
			
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
	
	@RequestMapping("sbSaveTag")
	public ModelAndView sbSaveTag(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ saveTag");
        int res = 0;
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	dccSearchStatus.setMenuName(this.menuName);
        	String seqStr = dccStatusService.selectSeqInfo(dccSearchStatus);
        	System.out.println(seqStr);
        	String[] seqs = seqStr == null ? "_".split("_") : seqStr.split("_");
        	
        	dccSearchStatus.setiSeq(seqs[0]);
        	dccSearchStatus.setySeq(seqs[1]);

        	if( dccSearchStatus.getMenuNo() == null ) dccSearchStatus.setMenuNo("11");
        	if( dccSearchStatus.getGrpNo() == null ) dccSearchStatus.setGrpNo("13");
        	if( dccSearchStatus.getGrpId() == null ) dccSearchStatus.setGrpId("mimic");
        	if( dccSearchStatus.getHogi() == null ) dccSearchStatus.setHogi("3");
        	if( dccSearchStatus.getXyGubun() == null ) dccSearchStatus.setXyGubun("X");
        	if( dccSearchStatus.getGubun() == null ) dccSearchStatus.setGubun("D");
        	
        	res = dccStatusService.updateTagInfo(dccSearchStatus);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        	mav.setViewName("redirect:/dcc/status/setbackstatus");
        }
        
        return mav;
	}
	
	@RequestMapping(value="sbTagSearch", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sbTagSearch(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagSearch(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	@RequestMapping(value="sbTagFind", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView sbTagFind(DccSearchStatus dccSearchStatus, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ tagSearch");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	mav = tagFind(mav,dccSearchStatus,request);
        	
        }
        return mav;
    }
	
	public String[] selectValue(String type, String strA, String strB, String strC, int startNum) {
		String[] rtv = {"",""};
		Double tmpA = 0d;
		Double tmpB = 0d;
		Double tmpC = 0d;
		Double AI1223 = 0d;
		Double AI2405 = 0d;
		Double AI3067 = 0d;
		int caseNum = 0;
		
		try {
			switch( type ) {
			case "0":
				tmpA = Double.parseDouble(strA);
				tmpB = Double.parseDouble(strB);
				tmpC = Double.parseDouble(strC);
				
				if( tmpA == -32768d ) caseNum = caseNum+1;
				if( tmpB == -32768d ) caseNum = caseNum+10;
				if( tmpC == -32768d ) caseNum = caseNum+100;
				
				switch(caseNum) {
					case 0:
						if( tmpA >= tmpB ) {
							if( tmpA < tmpC ) {
								rtv[0] = strA;
								rtv[1] = String.valueOf(startNum);
							} else{
								rtv[0] = strC;
								rtv[1] = String.valueOf(startNum+2);
							}
						} else {
							if( tmpB < tmpC ) {
								rtv[0] = strB;
								rtv[1] = String.valueOf(startNum+1);
							} else {
								rtv[0] = strC;
								rtv[1] = String.valueOf(startNum+2);
							}
						}
						break;
					case 1:
						if( tmpB >= tmpC ) {
							rtv[0] = strB;
							rtv[1] = String.valueOf(startNum+1);
						} else {
							rtv[0] = strC;
							rtv[1] = String.valueOf(startNum+2);
						}
						break;
					case 10:
						if( tmpA >= tmpC ) {
							rtv[0] = strA;
							rtv[1] = String.valueOf(startNum);
						} else {
							rtv[0] = strC;
							rtv[1] = String.valueOf(startNum+2);
						}
						break;
					case 100:
						if( tmpA >= tmpB ) {
							rtv[0] = strA;
							rtv[1] = String.valueOf(startNum);
						} else {
							rtv[0] = strB;
							rtv[1] = String.valueOf(startNum+1);
						}
						break;
					default:
						rtv[0] = "***IRR";
						rtv[1] = String.valueOf(startNum);
						break;
				}
				return rtv;
			case "1":
				tmpA = Double.parseDouble(strA);
				tmpB = Double.parseDouble(strB);
				AI1223 = Double.parseDouble(strC.split("_")[0]);
				AI2405 = Double.parseDouble(strC.split("_")[1]);
				AI3067 = Double.parseDouble(strC.split("_")[2]);
				
				if( tmpA == -32768d ) caseNum = caseNum+1;
				if( tmpB == -32768d ) caseNum = caseNum+10;
				if( AI1223 == -32768d ) caseNum = caseNum+100;
				if( AI2405 == -32768d ) caseNum = caseNum+1000;
				if( AI3067 == -32768d ) caseNum = caseNum+10000;
				
				switch( caseNum ) {
					case 0:
						if( tmpA >= tmpB ) {
							rtv[0] = strA;
							rtv[1] = String.valueOf(startNum);
						} else {
							rtv[0] = strB;
							rtv[1] = String.valueOf(startNum+1);
						}
						break;
					case 1:
						rtv[0] = strB;
						rtv[1] = String.valueOf(startNum+1);
						break;
					case 10:
						rtv[0] = strA;
						rtv[1] = String.valueOf(startNum);
						break;
					default:
						if( caseNum < 100 ) {
							if( AI1223 >= AI2405 ) {
								if( AI1223 < AI3067 ) {
									rtv[0] = AI1223 < -0.5d ? "1.2" : strC.split("_")[0];
									rtv[1] = "62";
								} else {
									rtv[0] = AI3067 < -0.5d ? "1.2" : strC.split("_")[2];
									rtv[1] = "64";
								}
							} else {
								if( AI2405 < AI3067 ) {
									rtv[0] = AI1223 < -0.5d ? "1.2" : strC.split("_")[1];
									rtv[1] = "63";
								} else {
									rtv[0] = AI3067 < -0.5d ? "1.2" : strC.split("_")[2];
									rtv[1] = "64";
								}
							}
						} else {
							rtv[0] = "1.2";
							rtv[1] = String.valueOf(startNum);
						}
						break;
				}
				return rtv;
			case "2":
				tmpA = Double.parseDouble(strA);
				tmpB = Double.parseDouble(strB);
				tmpC = Double.parseDouble(strC);
				
				if( tmpA == -32768d ) caseNum = caseNum+1;
				if( tmpB == -32768d ) caseNum = caseNum+10;
				if( tmpC == -32768d ) caseNum = caseNum+100;
				
				Double tmpSum = 0d;
				
				if( tmpA > -32768d ) tmpSum = tmpSum + tmpA;
				if( tmpB > -32768d ) tmpSum = tmpSum + tmpB;
				if( tmpC > -32768d ) tmpSum = tmpSum + tmpC;
				
				switch( caseNum ) {
					case 0:
						if( tmpSum < 2d ) {
							rtv[0] = "YES";
							rtv[1] = "";
						} else {
							rtv[0] = "NO";
							rtv[1] = "";
						}
						break;
					default:
						rtv[0] = "***IRR";
						rtv[1] = "";
						break;
				}
				return rtv;
			case "3":
				tmpA = Double.parseDouble(strA);
				tmpB = Double.parseDouble(strB);
				tmpC = Double.parseDouble(strC);
				
				if( tmpA == -32768d ) caseNum = caseNum+1;
				if( tmpB == -32768d ) caseNum = caseNum+10;
				if( tmpC == -32768d ) caseNum = caseNum+100;
				
				switch(caseNum) {
					case 0:
						if( tmpA >= tmpB ) {
							if( tmpA < tmpC ) {
								rtv[0] = strA;
								rtv[1] = String.valueOf(startNum);
							} else{
								rtv[0] = strC;
								rtv[1] = String.valueOf(startNum+2);
							}
						} else {
							if( tmpB < tmpC ) {
								rtv[0] = strB;
								rtv[1] = String.valueOf(startNum+1);
							} else {
								rtv[0] = strC;
								rtv[1] = String.valueOf(startNum+2);
							}
						}
						break;
					case 1:
						if( tmpB < tmpC ) {
							rtv[0] = strB;
							rtv[1] = String.valueOf(startNum+1);
						} else {
							rtv[0] = strC;
							rtv[1] = String.valueOf(startNum+2);
						}
						break;
					case 10:
						if( tmpA < tmpC ) {
							rtv[0] = strA;
							rtv[1] = String.valueOf(startNum);
						} else {
							rtv[0] = strC;
							rtv[1] = String.valueOf(startNum+2);
						}
						break;
					case 100:
						if( tmpA < tmpB ) {
							rtv[0] = strA;
							rtv[1] = String.valueOf(startNum);
						} else {
							rtv[0] = strB;
							rtv[1] = String.valueOf(startNum+1);
						}
						break;
					default:
						rtv[0] = "***IRR";
						rtv[1] = String.valueOf(startNum);
						break;
				}
				return rtv;
			case "4":
				String[] tmps = strA.split("_");
				
				if( tmps.length < 4 ) {
					rtv[0] = "***IRR";
					rtv[1] = String.valueOf(startNum);
					return rtv;
				} else {
					tmpA = Double.parseDouble(tmps[0]);
					tmpB = Double.parseDouble(tmps[1]);
					tmpC = Double.parseDouble(tmps[2]);
					Double tmpD = Double.parseDouble(tmps[3]);
				
					if( tmpA == -32768d ) caseNum = caseNum+1;
					if( tmpB == -32768d ) caseNum = caseNum+10;
					if( tmpC == -32768d ) caseNum = caseNum+100;
					if( tmpD == -32768d ) caseNum = caseNum+1000;
					
					switch(caseNum) {
						case 0:
							Double d = tmpA > tmpB ? tmpB : tmpA;
							d = d > tmpC ? tmpC : d;
							d = d > tmpD ? tmpC : d;
							
							if( d == tmpA ) {
								rtv[0] = tmps[0];
								rtv[1] = String.valueOf(startNum);
							} else if( d == tmpB ) {
								rtv[0] = tmps[1];
								rtv[1] = String.valueOf(startNum+1);
							} else if( d == tmpC ) {
								rtv[0] = tmps[2];
								rtv[1] = String.valueOf(startNum+2);
							} else if( d == tmpD ) {
								rtv[0] = tmps[3];
								rtv[1] = String.valueOf(startNum+3);
							}
							break;
						default:
							rtv[0] = "***IRR";
							rtv[1] = String.valueOf(startNum);
							break;
					}
					return rtv;
				}
			case "5":
				String[] gFormat = {"%.4f",
									"%.4f",
									"%.4f",
				        			"%.4f",
				        			"%.3f",
				        			"%.3f",
				        			"%.3f",
				        			"%.2f",
				        			"%.2f",
				        			"%.2f",
				        			"%.2f",
				        			"%.1f",
				        			"%.1f",
				        			"%.1f",
				        			"%.1f",
				        			"%.0f"};
				
				tmpA = Double.parseDouble(strA);
				tmpB = Double.parseDouble(strB);
				String scale = gFormat[Integer.parseInt(strC)];
				
				if( tmpA == -32768d || tmpA == 0d ) caseNum = caseNum+1;
				if( tmpB == -32768d ) caseNum = caseNum+10;
				
				switch(caseNum) {
					case 0:
						tmpC = (1.1/tmpA)*tmpB;
						
						rtv[0] = tmpC > -32768 ? String.format(scale,tmpC) : "***IRR";
						break;
					default:
						rtv[0] = "***IRR";
						rtv[1] = String.valueOf(startNum);
						break;
				}
				return rtv;
			case "6":
				tmpA = Double.parseDouble(strA);
				tmpB = Double.parseDouble(strB);
				AI1223 = Double.parseDouble(strC.split("_")[0]);
				AI2405 = Double.parseDouble(strC.split("_")[1]);
				AI3067 = Double.parseDouble(strC.split("_")[2]);
				
				if( tmpA == -32768d ) caseNum = caseNum+1;
				if( tmpB == -32768d ) caseNum = caseNum+10;
				if( AI1223 == -32768d ) caseNum = caseNum+100;
				if( AI2405 == -32768d ) caseNum = caseNum+1000;
				if( AI3067 == -32768d ) caseNum = caseNum+10000;
				
				switch( caseNum ) {
					case 0:
						if( tmpA >= tmpB ) {
							rtv[0] = strA;
							rtv[1] = String.valueOf(startNum);
						} else {
							rtv[0] = strB;
							rtv[1] = String.valueOf(startNum+1);
						}
						break;
					case 1:
						rtv[0] = strB;
						rtv[1] = String.valueOf(startNum+1);
						break;
					case 10:
						rtv[0] = strA;
						rtv[1] = String.valueOf(startNum);
						break;
					default:
						if( caseNum < 100 ) {
							if( AI1223 >= AI2405 ) {
								if( AI1223 < AI3067 ) {
									rtv[0] = AI1223 < -0.5d ? "1.2" : strC.split("_")[0];
									rtv[1] = "62";
								} else {
									rtv[0] = AI3067 < -0.5d ? "1.2" : strC.split("_")[2];
									rtv[1] = "64";
								}
							} else {
								if( AI2405 < AI3067 ) {
									rtv[0] = AI1223 < -0.5d ? "1.2" : strC.split("_")[1];
									rtv[1] = "63";
								} else {
									rtv[0] = AI3067 < -0.5d ? "1.2" : strC.split("_")[2];
									rtv[1] = "64";
								}
							}
						} else {
							rtv[0] = "1.2";
							rtv[1] = String.valueOf(startNum);
						}
						break;
				}
				return rtv;
			default:
				return rtv;
			}
		} catch( NumberFormatException nfe ) {
			rtv[0] = "***IRR";
			rtv[1] = String.valueOf(startNum);

			return rtv;
		}
	}
		
	@RequestMapping("reactivity")
	public ModelAndView reactivity(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ reactivity");
		
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("adjrod")
	public ModelAndView adjrod(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ adjrod");
		
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("dcc_setbackinfo")
	public ModelAndView setbackinfo(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

		logger.info("############ setbackstatus");
		
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	
	@RequestMapping("zonedeviations")
	public ModelAndView zonedeviations(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ zonedeviations");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("zonecompare")
	public ModelAndView zonecompare(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ zonecompare");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("zonevalues")
	public ModelAndView zonevalues(DccSearchStatus dccSearchStatus, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ zonevalues");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchStatus.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchStatus);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }


}
