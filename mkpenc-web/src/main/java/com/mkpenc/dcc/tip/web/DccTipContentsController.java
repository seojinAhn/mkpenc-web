package com.mkpenc.dcc.tip.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.admin.model.IOListInfo;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.model.SwSmInfo;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.dcc.tip.model.DccSearchTip;
import com.mkpenc.dcc.tip.service.DccTipService;
import com.mkpenc.dcc.tip.model.DccIoColumnInfo;
import com.mkpenc.dcc.tip.model.DccIolistInfo;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/tip/")
public class DccTipContentsController {

	private static Logger logger = LoggerFactory.getLogger(DccTipContentsController.class);
	
	private String menuName = "TIP";
	
	@Autowired
	private DccTipService dccTipService;
	
	@Autowired
	private ExcelHelperUtil excelHelperUtil;
	
	@RequestMapping("iolist")
	public ModelAndView iolist(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ iolist");
        
        //if(dccSearchTip.getIoType() == null) dccSearchTip.setIoType("AI");
    	if( dccSearchTip.getHogiHeader() != null ) {
    		if( dccSearchTip.getiHogi() == null ) dccSearchTip.setiHogi(dccSearchTip.getHogiHeader());
    	} else {
    		if( dccSearchTip.getiHogi() == null ) dccSearchTip.setiHogi("3");
    	}
    	if( dccSearchTip.getXyHeader() != null ) {
    		if( dccSearchTip.getXyGubun() == null ) dccSearchTip.setXyGubun(dccSearchTip.getXyHeader());
    	} else {
    		if( dccSearchTip.getXyGubun() == null ) dccSearchTip.setXyGubun("X");
    	}
        	
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	if(dccSearchTip.getIoType() != null && !dccSearchTip.getIoType().equals("") ) {
		        /*List<DccIolistInfo> iolistList = dccTipService.selectIoList(dccSearchTip);
		        List<DccIoColumnInfo> ioColumnList = dccTipService.selectIoColumnList(dccSearchTip);
		        
		        int ioListInfoTotalCnt = iolistList.size();
		        String addrRange = "";
	        	if( ioListInfoTotalCnt > 1 ) {
	        		addrRange = iolistList.get(0).getAddress()+" - "+iolistList.get(ioListInfoTotalCnt-1).getAddress();
	        	} else if( ioListInfoTotalCnt > 0 ) {
	        		addrRange = iolistList.get(0).getAddress()+" - "+iolistList.get(0).getAddress();
	        	} else {
	        		addrRange = "0 - 0";
	        	}
	
	        	dccSearchTip.setAddrRange(addrRange);
		
		        mav.addObject("BaseSearch", dccSearchTip);
	        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
	        	
		        mav.addObject("DccIolistList", iolistList);
		        mav.addObject("DccIoColumnList", ioColumnList);*/
        		IOListInfo ioListinfo = setSearchIOList(dccSearchTip);
        		
        		int ioListInfoTotalCnt = dccTipService.selectIOListInfoTotalCnt(ioListinfo);
	        	dccSearchTip.setTotalCnt(ioListInfoTotalCnt);
	        	
	        	List<IOListInfo> ioListInfoList = dccTipService.selectIOListInfoList(ioListinfo);
	        	String addrRange = "";
	        	if( ioListInfoTotalCnt > 1 ) {
	        		addrRange = ioListInfoList.get(0).getAddress()+" - "+ioListInfoList.get(ioListInfoTotalCnt-1).getAddress();
	        	} else if( ioListInfoTotalCnt > 0 ) {
	        		addrRange = ioListInfoList.get(0).getAddress()+" - "+ioListInfoList.get(0).getAddress();
	        	} else {
	        		addrRange = "0 - 0";
	        	}

	        	dccSearchTip.setAddrRange(addrRange);
	        	dccSearchTip.setMenuName(this.menuName);
	        	
	        	mav.addObject("IOListInfoList", ioListInfoList);
        	}
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }else {
        	mav.addObject("UserInfo", null);
        }

        return mav;
    }
	
	private IOListInfo setSearchIOList(DccSearchTip dccSearchTip) {
		
		IOListInfo ioListinfo = new IOListInfo();
		
		ioListinfo.setIhogi(dccSearchTip.getiHogi());
    	ioListinfo.setXygubun(dccSearchTip.getXyGubun());
		String addrStr = "";
		String addressRange = dccSearchTip.getAddress() == null ? "" : dccSearchTip.getAddress();
		if( addressRange.indexOf("-") > -1 ) {
			addrStr = "BETWEEN "+addressRange.split("-")[0]+" AND "+addressRange.split("-")[1];
		} else if( addressRange.indexOf(",") > -1 ) {
			addrStr = "IN ("+addressRange+")";
		} else {
			addrStr = "".equals(addressRange) ? "" : "= "+addressRange;
		}
    	//ioListinfo.setAddress(dccSearchAdmin.getsAddress());
    	ioListinfo.setAddress(addrStr);
    	
    	/*
    	switch(dccSearchAdmin.getsIOType()) {
        	  case  "AI": ioListinfo.setIotype("AI"); break;
        	  case  "": ioListinfo.setIotype("AO"); break;
        	  case  "2": ioListinfo.setIotype("CI"); break;
        	  case  "3": ioListinfo.setIotype("DI"); break;
        	  case  "4": ioListinfo.setIotype("DO"); break;
        	  case  "5": ioListinfo.setIotype("DT"); break;
        	  case  "6": ioListinfo.setIotype("SC"); break;
        	  case  "7": ioListinfo.setIotype("'AI', 'FTAI'"); break;
        	  case  "8": ioListinfo.setIotype("'DT, 'FTDT'"); break;
    	}//end switch
    	*/
    	
    	ioListinfo.setIotype(dccSearchTip.getIoType());
		
		if(dccSearchTip.getSearchKeys() != null) {        	
	
        	int searchKeysLen = dccSearchTip.getSearchKeys().length;
        	
        	switch(dccSearchTip.getIoType()) {
        		case "AI":
	        	case "FTAI":
	        				for(int i=0;i<searchKeysLen;i++ ) {
	        					String searchKey = dccSearchTip.getSearchKeys()[i];
	        					String searchWord = dccSearchTip.getSearchWords()[i];
	        					
	        					switch(searchKey) {
	        						case "0" : ioListinfo.setDescr(searchWord);			break;
	        						case "1" : ioListinfo.setMessage(searchWord);		break;
	        						case "2" : ioListinfo.setRev(searchWord);			break;
	        						case "3" : ioListinfo.setDrawing(searchWord);		break;
	        						case "4" : ioListinfo.setLoopname(searchWord);	break;
	        						case "5" : ioListinfo.setDevice(searchWord);			break;
	        						case "6" : ioListinfo.setPurpose(searchWord);		break;
	        						case "7" : ioListinfo.setProgram(searchWord);		break;
	        						case "8" : ioListinfo.setVlow(searchWord);			break;
	        						case "9" : ioListinfo.setVhigh(searchWord);			break;
	        						case "10" : 	ioListinfo.setElow(searchWord);		break;
	        						case "11" : 	ioListinfo.setEhigh(searchWord);		break;
	        						case "12" : 	ioListinfo.setUnit(searchWord);			break;
	        						case "13" : 	ioListinfo.setConv(searchWord);		break;
	        						case "14" :  ioListinfo.setRtd(searchWord);			break;
	        						case "15" : 	ioListinfo.setType(searchWord);		break;
	        						case "16" : 	ioListinfo.setIogroup(searchWord);	break;
	        						case "17" : 	ioListinfo.setWindow(searchWord);	break;
	        						case "18" : 	ioListinfo.setPriority(searchWord);		break;
	        						case "19" : 	ioListinfo.setCr(searchWord);			break;
	        						case "20" :	ioListinfo.setLimit1(searchWord);		break;
	        						case "21" : 	ioListinfo.setLimit2(searchWord);		break;
	        						case "22" : 	ioListinfo.setJ(searchWord);				break;
	        						case "23" : 	ioListinfo.setN(searchWord);			break;
	        						case "24" : 	ioListinfo.setEqu(searchWord);			break;
	        						case "25" : 	ioListinfo.setBscal(searchWord);		break;
	        						case "26" : 	ioListinfo.setWiba(searchWord);		break;
	        						case "27" : 	ioListinfo.setWb(searchWord);			break;        						
	        					}  //end switch      					
	        				}     // end for   			
	        			break;
	        		case "AO":
		     				for(int i=0;i<searchKeysLen;i++ ) {
		     					String searchKey = dccSearchTip.getSearchKeys()[i];
		     					String searchWord = dccSearchTip.getSearchWords()[i];
		     					
		     					switch(searchKey) {
			     					case "0" : ioListinfo.setRev(searchWord);			break; 
			 						case "1" : ioListinfo.setDescr(searchWord);			break;
			 						case "2" : ioListinfo.setDrawing(searchWord);		break;
			 						case "3" : ioListinfo.setDevice(searchWord);			break;
			 						case "4" : ioListinfo.setPurpose(searchWord);		break;
			 						case "5" : ioListinfo.setCtrlname(searchWord);		break;
			 						case "6" : ioListinfo.setInterlock(searchWord);		break;
			 						case "7" : ioListinfo.setFeedback(searchWord);		break;
			 						case "8" : ioListinfo.setCom1(searchWord);			break;
			 						case "9" : ioListinfo.setCom2(searchWord);			break;
		     						case "10" : ioListinfo.setWiba(searchWord);			break;  
		     					}  //end switch      					
	        				}     // end for  
	        			break;
	        		case "CI":
		        			for(int i=0;i<searchKeysLen;i++ ) {
		     					String searchKey = dccSearchTip.getSearchKeys()[i];
		     					String searchWord = dccSearchTip.getSearchWords()[i];
		     					
		     					switch(searchKey) {
			     					case "0" : ioListinfo.setCr(searchWord);				break; 
			 						case "1" : ioListinfo.setMessage(searchWord);		break;
			 						case "2" : ioListinfo.setDrawing(searchWord);		break;
			 						case "3" : ioListinfo.setRev(searchWord);			break;
			 						case "4" : ioListinfo.setDevice(searchWord);			break;
			 						case "5" : ioListinfo.setCondition(searchWord);	break;
			 						case "6" : ioListinfo.setWiba(searchWord);			break;
			 						case "7" : ioListinfo.setIogroup(searchWord);		break;
			 						case "8" : ioListinfo.setTr(searchWord);				break;
			 						case "9" : ioListinfo.setPriority(searchWord);		break;
		     						case "10" : ioListinfo.setType(searchWord);			break;  
		     					}  //end switch      					
	        				}     // end for  
	        			break;
	        		case "DI":		           			
	        			for(int i=0;i<searchKeysLen;i++ ) {
	     					String searchKey = dccSearchTip.getSearchKeys()[i];
	     					String searchWord = dccSearchTip.getSearchWords()[i];
	     					
	     					switch(searchKey) {
		     					case "0" : ioListinfo.setIobit(searchWord);				break; 
		 						case "1" : ioListinfo.setRev(searchWord);				break;
		 						case "2" : ioListinfo.setDescr(searchWord);				break;
		 						case "3" : ioListinfo.setDrawing(searchWord);			break;
		 						case "4" : ioListinfo.setDevice(searchWord);				break;
		 						case "5" : ioListinfo.setPurpose(searchWord);			break;
		 						case "6" : ioListinfo.setCtrlname(searchWord);			break;
		 						case "7" : ioListinfo.setAlarmcond(searchWord);		break;
		 						case "8" : ioListinfo.setIndicate(searchWord);			break;
		 						case "9" : ioListinfo.setWiba(searchWord);				break;
	     					}  //end switch      					
        				}     // end for         			
	        			break;
	        		case "DO":		           			
	        			for(int i=0;i<searchKeysLen;i++ ) {
	     					String searchKey = dccSearchTip.getSearchKeys()[i];
	     					String searchWord = dccSearchTip.getSearchWords()[i];
	     					
	     					switch(searchKey) {
	     						case "0" : ioListinfo.setIobit(searchWord);				break; 
	     						case "1" : ioListinfo.setRev(searchWord);				break;
	     						case "2" : ioListinfo.setDescr(searchWord);				break;
	     						case "3" : ioListinfo.setDrawing(searchWord);			break;
	     						case "4" : ioListinfo.setDevice(searchWord);				break;
	     						case "5" : ioListinfo.setPurpose(searchWord);			break;
	     						case "6" : ioListinfo.setCtrlname(searchWord);			break;
	     						case "7" : ioListinfo.setInterlock(searchWord);			break;
	     						case "8" : ioListinfo.setWiba(searchWord);				break;
	     					}  //end switch      					
        				}     // end for   
	        			break;
	        		case "DT":
	        		case "FTDT'":		           			
	        			for(int i=0;i<searchKeysLen;i++ ) {
	     					String searchKey = dccSearchTip.getSearchKeys()[i];
	     					String searchWord = dccSearchTip.getSearchWords()[i];
	     					
	     					switch(searchKey) {
	     						case "0" : ioListinfo.setProgram(searchWord); 		break; 
	     						case "1" : ioListinfo.setDescr(searchWord);			break;
	     						case "2" : ioListinfo.setLoopname(searchWord);	break;
	     						case "3" : ioListinfo.setBscal(searchWord);			break;
	     						case "4" : ioListinfo.setElow(searchWord);			break;
	     						case "5" : ioListinfo.setEhigh(searchWord);			break;
	     					}  //end switch      					
        				}     // end for         			
	        			break;
	        		case "SC":
	        			for(int i=0;i<searchKeysLen;i++ ) {
	     					String searchKey = dccSearchTip.getSearchKeys()[i];
	     					String searchWord = dccSearchTip.getSearchWords()[i];
	     					
	     					switch(searchKey) {
	     						case "0" : ioListinfo.setIobit(searchWord); 			break;
	     						case "1" : ioListinfo.setProgram(searchWord);  	break;
	     						case "2" : ioListinfo.setDescr(searchWord);  		break;
	     						case "3" : ioListinfo.setIndicate(searchWord);  		break;
	     					}  //end switch      					
        				}     // end for         			
	        			break;
	        	}// end switch
    		}// search key endif
		
		return ioListinfo;
	}
	
	@RequestMapping("iolistModify")
	public ModelAndView iolistModify(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ iolistModify");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	System.out.println(dccSearchTip.getDescr());
	        
	        if(dccSearchTip.getiSeq() != null && !"".equals(dccSearchTip.getiSeq())) {
	        	int rtv = dccTipService.updateIolistInfo(dccSearchTip);
	        }
	
	        mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }else {
        	mav.addObject("UserInfo", null);
        }
        
        mav.setViewName("redirect:/dcc/tip/iolist");

        return mav;
    }
	
	@RequestMapping("iolistExcelExport")
	public void iolistExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchTip dccSearchTip) throws Exception {
		 if(request.getSession().getAttribute("USER_INFO") != null) {

        	if(dccSearchTip.getIoType() != null && !dccSearchTip.getIoType().equals("") ) {
				/*try{
		
			        List<DccIolistInfo> dccIolistList = dccTipService.selectIoListExcelDownload(dccSearchTip);
					
					excelHelperUtil.iolistExcelDownload(request, response, dccIolistList);		
		        	
				}catch(Exception e) {
					logger.error("### e : {}", e);
					throw new Exception(e);
				}*/
        		
        		IOListInfo ioListinfo = setSearchIOList(dccSearchTip);
	        	
	        	List<IOListInfo> ioListInfoList = dccTipService.selectIOListInfoList(ioListinfo);
	        	
	        	try {
	        		
	        		switch( dccSearchTip.getIoType()) {
	        			case "AI":   		excelHelperUtil.iolistTipAIExcelDownload(request, response, ioListInfoList);	 break; 
	        			case "AO": 		excelHelperUtil.iolistTipAOExcelDownload(request, response, ioListInfoList);	 break; 
	        			case "CI":   		excelHelperUtil.iolistTipCIExcelDownload(request, response, ioListInfoList);	 break; 
	        			case "DI":   		excelHelperUtil.iolistTipDIExcelDownload(request, response, ioListInfoList);	 break; 
	        			case "DO":  		excelHelperUtil.iolistTipDOExcelDownload(request, response, ioListInfoList);	 break; 
	        			case "DT":   	excelHelperUtil.iolistTipDTExcelDownload(request, response, ioListInfoList);	 break;
	        			case "FTAI":    	excelHelperUtil.iolistTipFTAIExcelDownload(request, response, ioListInfoList);	 break; 
	        			case "FTDT":    excelHelperUtil.iolistTipFTDTExcelDownload(request, response, ioListInfoList);	 break; 
	        		}		
				
				}catch(Exception e) {
					logger.error("### e : {}", e);
					throw new Exception(e);
				}
        	}
	
		 }
	}
	
	@RequestMapping("sds1")
	public ModelAndView sds1(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sds1");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("sds2")
	public ModelAndView sds2(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sds2");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("setback")
	public ModelAndView setback(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ setback");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }	
	
	@RequestMapping("stepback")
	public ModelAndView stepback(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ setback");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("unclearoutput")
	public ModelAndView unclearoutput(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ unclearoutput");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("unitconv")
	public ModelAndView unitconv(DccSearchTip dccSearchTip, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ unitconv");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchTip.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchTip);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
}
