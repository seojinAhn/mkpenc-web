package com.mkpenc.dcc.admin.web;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.dcc.admin.model.EquipInfo;
import com.mkpenc.dcc.admin.model.HwSmInfo;
import com.mkpenc.dcc.admin.model.IOListInfo;
import com.mkpenc.dcc.admin.model.ImproveInfo;
import com.mkpenc.dcc.admin.model.MemberGroupInfo;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.model.RestartCodeInfo;
import com.mkpenc.dcc.admin.model.SwSmInfo;
import com.mkpenc.dcc.admin.service.DccAdminService;
import com.mkpenc.dcc.common.service.BasCommonService;
import com.mkpenc.alt.common.service.AltCommonService;
import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.common.model.Upload;
import com.mkpenc.common.module.ExcelHelperUtil;
import com.mkpenc.common.module.FileHelperUtil;
import com.mkpenc.common.module.PageHtmlUtil;
import com.mkpenc.configuration.SessionConfig;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/admin/")
public class DccAdminContentsController {
	
	private static Logger logger = LoggerFactory.getLogger(DccAdminContentsController.class);

	@Autowired
	private CommonConstant commonConstant;
	 
	@Autowired
	private DccAdminService dccAdminService;
	
	@Autowired
	private BasCommonService basCommonService;
	
	@Autowired
	private AltCommonService altCommonService;
	
	@Autowired
	private PageHtmlUtil pageHtmlUtil;
	
	@Autowired
	private FileHelperUtil fileHelperUtil;
	
	@Autowired
	private ExcelHelperUtil excelHelperUtil;	
	
	private String menuName = "ADMIN";
	
	@RequestMapping(value = "loginCheck", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView loginCheck(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
                
		ModelAndView mav = new ModelAndView("jsonView");
		/*
        logger.info("############ loginCheck");        
        logger.info("############ loginCheck=" + dccSearchAdmin.getUserId());        
        logger.info("############ loginCheck=" + dccSearchAdmin.getUserPwd());        
        */
        MemberInfo memberInfo = null;;
        
        if(dccSearchAdmin.getUserId() != null && dccSearchAdmin.getUserPwd() != null) {
        	memberInfo = dccAdminService.selectMemberInfo(dccSearchAdmin);
        }
        
        if(memberInfo != null && memberInfo.getId() != null ) {
        	
        	//logger.info("############ loginCheck===>" +  result.getUserName());
        	//mav.setViewName("jsonView");
    		
    		dccSearchAdmin.setuLogin("Y");
        	dccSearchAdmin.setuUserIp(request);
        	dccSearchAdmin.setuId(dccSearchAdmin.getUserId());

        	dccAdminService.updateMemberInfo(dccSearchAdmin);
        	
        	SessionConfig.getSessionidCheck("SESSION_UID", memberInfo.getId());
        	
        	request.getSession().setAttribute("USER_INFO", memberInfo);
        	request.getSession().setAttribute("SESSION_UID", memberInfo.getId());
        	
        	memberInfo.setHogi("3");
        	memberInfo.setXyGubun("X");
        	
        	//UserInfo send Client
        	mav.addObject("UserInfo",memberInfo);

        	mav.addObject("ResultType", "1");
        	
        }else {
        	
        	//logger.info("############ loginCheck===>NOT USER INFO");
        	//mav.setViewName("jsonView");
        	
        	mav.addObject("ResultType", "2");
        }

        return mav;
    }
	
	@RequestMapping(value = "logoutCheck", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView logoutCheck(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
		
		//logger.info("############ logoutCheck");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String userIp = req.getHeader("X-FORWARDED-FOR");
		if (userIp == null) {
			userIp = req.getRemoteAddr();
		}
		
		dccSearchAdmin.setuLogin("N");
		dccSearchAdmin.setuUserIp(userIp);
    	dccSearchAdmin.setuId(dccSearchAdmin.getUserId());

    	dccAdminService.updateMemberInfo(dccSearchAdmin);
		
		request.getSession().invalidate();
		request.getSession(true);

		mav.addObject("ResultType", "3");

		return mav;
	}
	
	@RequestMapping("memberlist")
	public ModelAndView memberlist(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        //mav.addObject("authInfo", authService.getAuth(searchAuth));
        /*
        logger.info("############ memberlist");
        logger.info("############ memberlist===>" + dccSearchAdmin.getPageNum());
        logger.info("############ memberlist===>" + dccSearchAdmin.getPageSize());
         */
        if(request.getSession().getAttribute("USER_INFO") != null) {
            
        	/*
        	logger.info("############ dashboard login status..!!!!");
        	logger.info("############ dashboard login status..!!!!===" + dccSearchAdmin.getSearchKey());
        	logger.info("############ dashboard login status..!!!!===" + dccSearchAdmin.getSearchWord());
        	*/
        	if(dccSearchAdmin.getSearchKey() != null && !dccSearchAdmin.getSearchKey().isEmpty()) {
        		if(dccSearchAdmin.getSearchKey().equals("userId")){
        			dccSearchAdmin.setUserId(dccSearchAdmin.getSearchWord());
        		}else if(dccSearchAdmin.getSearchKey().equals("userName")){
        			dccSearchAdmin.setUserName(dccSearchAdmin.getSearchWord());
        		} else if(dccSearchAdmin.getSearchKey().equals("all")){
        			dccSearchAdmin.setUserName(dccSearchAdmin.getSearchWord());
        		}
        	}
        	
        	//Get User Total Count
        	int memberTotalCnt = dccAdminService.selectMemberTotalCnt(dccSearchAdmin);
        	if( memberTotalCnt > 0 ) {
        		dccSearchAdmin.setTotalCnt(memberTotalCnt);
        	} else {
        		dccSearchAdmin.setUserName(null);
        		dccSearchAdmin.setUserId(dccSearchAdmin.getSearchWord());
        		memberTotalCnt = dccAdminService.selectMemberTotalCnt(dccSearchAdmin);
        		dccSearchAdmin.setTotalCnt(memberTotalCnt);
        	}
        	
        	List<MemberInfo> memberList = dccAdminService.selectMemberList(dccSearchAdmin);

        	List<MemberGroupInfo> groupComboList = dccAdminService.selectMemberGroupCombo();

        	int memberGrpTotalCnt = dccAdminService.selectMemberGroupCnt(dccSearchAdmin);
        	dccSearchAdmin.setGrpTotalCnt(memberGrpTotalCnt);
        	List<MemberGroupInfo> groupList = dccAdminService.selectMemberGroupList(dccSearchAdmin);
        	/*
        	logger.info("############ pageNum===>" +  dccSearchAdmin.getPageNum());
        	logger.info("############ memberTotalCnt===>" +  memberTotalCnt);
        	logger.info("############ memberlist===>" +  memberList.size());
        	logger.info("############ groupList===>" +  groupList.size());
        	*/
        	
        	dccSearchAdmin.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	            
            mav.addObject("MemberList", memberList);
            
            mav.addObject("GroupComboList", groupComboList);
            mav.addObject("GroupList", groupList);
            
        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(dccSearchAdmin));
            mav.addObject("UserGroupPageHtml", pageHtmlUtil.getUserGroupPageHtml(dccSearchAdmin));   
        	
        }else {
        	mav.addObject("UserInfo", null);
        	//logger.info("############ dashboard logout status..!!!!");
        }

        return mav;
    }
	
	@RequestMapping("memberInsert")
	public ModelAndView memberInsert(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();
		int rtn =  dccAdminService.insertMemberInfo(dccSearchAdmin);
       
		mav.setViewName("redirect:/dcc/admin/memberlist");       
        
        return mav;        
	}
	
	
	@RequestMapping("memberUpdate")
	public ModelAndView memberUpdate(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();
        /*
		logger.info("############ memberUpdate");    
		logger.info("############ memberUpdate===========" + dccSearchAdmin.getuId());
		logger.info("############ memberUpdate===========" + dccSearchAdmin.getuPwd());
		*/
		int rtn =  dccAdminService.updateMemberInfo(dccSearchAdmin);
       
		mav.setViewName("redirect:/dcc/admin/memberlist");       
        
        return mav;        
	}
	
	@RequestMapping("memberDelete")
	public ModelAndView memberDelete(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();
        /*
		logger.info("############ memberDelete");    
		logger.info("############ memberDelete===========" + dccSearchAdmin.getuId());
		logger.info("############ memberDelete===========" + dccSearchAdmin.getuPwd());
		*/
		int rtn =  dccAdminService.deleteMemberInfo(dccSearchAdmin);
       
		mav.setViewName("redirect:/dcc/admin/memberlist");       
        
        return mav;        
	}	
		
	@RequestMapping(value = "userGroup", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView userGroup(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
                
		ModelAndView mav = new ModelAndView("jsonView");
		/*
        logger.info("############ userGroup");        
        logger.info("############ userGroup=" + dccSearchAdmin.getGroupCode());        
        logger.info("############ userGroup=" + dccSearchAdmin.getGroupName());        
        */
		
        int memberGrpTotalCnt = dccAdminService.selectMemberGroupCnt(dccSearchAdmin);
    	dccSearchAdmin.setGrpTotalCnt(memberGrpTotalCnt);
    	List<MemberGroupInfo> groupList = dccAdminService.selectMemberGroupList(dccSearchAdmin);
    	
    	logger.info("############ groupList===>" +  groupList.size());

    	mav.addObject("DccSearchAdmin", dccSearchAdmin);
    	mav.addObject("GroupList", groupList);    
    	
        mav.addObject("UserGroupPageHtml", pageHtmlUtil.getUserGroupPageHtml(dccSearchAdmin));   

        return mav;
    }
	

	
	@RequestMapping(value = "userGroupInsert", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView userGroupInsert(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
		
        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("EventIdx", "1");
        int rtn = 0;
        
        /*
        logger.info("############ userGroupInsert=" + dccSearchAdmin.getGroupCode());        
        logger.info("############ userGroupInsert=" + dccSearchAdmin.getGroupName());        
        */
        
        if(dccSearchAdmin.getGroupCode() != null && !dccSearchAdmin.getGroupCode().isEmpty() &&
        		dccSearchAdmin.getGroupName() != null && !dccSearchAdmin.getGroupName().isEmpty()) {
        
	        rtn =  dccAdminService.insertMemberGroupInfo(dccSearchAdmin);

	        mav.addObject("Rtn", rtn);
        }else {

	        mav.addObject("Rtn", rtn);
        }
        
        //logger.info("############ userGroupInsert=" + rtn);
        
        return mav;        
	}
	
	@RequestMapping(value = "userGroupDelete", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView userGroupDelete(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
		
        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("EventIdx", "2");
        int rtn = 0;
        
        /*
        logger.info("############ userGroupDelete=" + dccSearchAdmin.getGroupCode());        
        logger.info("############ userGroupDelete=" + dccSearchAdmin.getGroupName());     
        */
        
        if(dccSearchAdmin.getGroupCode() != null && !dccSearchAdmin.getGroupCode().isEmpty() &&
        		dccSearchAdmin.getGroupName() != null && !dccSearchAdmin.getGroupName().isEmpty()) {
        
	        rtn =  dccAdminService.deleteMemberGroupInfo(dccSearchAdmin);

	        mav.addObject("Rtn", rtn);
        }else {

	        mav.addObject("Rtn", rtn);
        }
        
        //logger.info("############ userGroupDelete=" + rtn);        
        
        return mav;        
	}	

	@RequestMapping("currentmbrlist")
	public ModelAndView currentmbrlist(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ currentmbrlist");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	//Login Status : YES
        	dccSearchAdmin.setLogin("Y");
        	
        	//Get User Total Count
        	int loginMemberTotalCnt = dccAdminService.selectMemberTotalCnt(dccSearchAdmin);
        	dccSearchAdmin.setTotalCnt(loginMemberTotalCnt);
        	
        	List<MemberInfo> loginMemberList = dccAdminService.selectMemberList(dccSearchAdmin);

        	logger.info("############ pageNum===>" +  dccSearchAdmin.getPageNum());
        	logger.info("############ memberTotalCnt===>" +  loginMemberTotalCnt);
        	logger.info("############ memberlist===>" +  loginMemberList.size());
        	
        	dccSearchAdmin.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	            
            mav.addObject("LoginMemberList", loginMemberList);
            
        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(dccSearchAdmin));
     	
        }

        return mav;
    }
	
	@RequestMapping("forceLogout")
	public ModelAndView forceLogout(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        
		logger.info("############ forceLogout");
		
		ModelAndView mav = new ModelAndView();
		
		  if(request.getSession().getAttribute("USER_INFO") != null) {

			  String[] result = dccSearchAdmin.getLogoutUserList().split(",");			  
			  
			  dccSearchAdmin.setuLogin("N");
			  dccSearchAdmin.setuUserIp(request);
			  
			  for(String logoutId:result) {
				  logger.info("############ forceLogout===>" + logoutId);
				  
				  dccSearchAdmin.setuId(logoutId);
				  
				  dccAdminService.updateMemberInfo(dccSearchAdmin);
				  SessionConfig.getSessionidCheck("SESSION_UID", logoutId);
			  }			  
			  mav.setViewName("redirect:/dcc/admin/currentmbrlist");    
		  }
        
        return mav;
        
	}
	
	private IOListInfo setSearchIOList(DccSearchAdmin dccSearchAdmin) {
		
		IOListInfo ioListinfo = new IOListInfo();
		
		ioListinfo.setIhogi(dccSearchAdmin.getsIhogi());
    	ioListinfo.setXygubun(dccSearchAdmin.getsXYGubun());
		String addrStr = "";
		String addressRange = dccSearchAdmin.getsAddress() == null ? "" : dccSearchAdmin.getsAddress();
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
    	
    	ioListinfo.setIotype(dccSearchAdmin.getsIOType());
		
		if(dccSearchAdmin.getSearchKeys() != null) {        	
	
        	int searchKeysLen = dccSearchAdmin.getSearchKeys().length;
        	
        	switch(dccSearchAdmin.getsIOType()) {
        		case "AI":
	        	case "FTAI":
	        				for(int i=0;i<searchKeysLen;i++ ) {
	        					String searchKey = dccSearchAdmin.getSearchKeys()[i];
	        					String searchWord = dccSearchAdmin.getSearchWords()[i];
	        					
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
		     					String searchKey = dccSearchAdmin.getSearchKeys()[i];
		     					String searchWord = dccSearchAdmin.getSearchWords()[i];
		     					
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
		     					String searchKey = dccSearchAdmin.getSearchKeys()[i];
		     					String searchWord = dccSearchAdmin.getSearchWords()[i];
		     					
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
	     					String searchKey = dccSearchAdmin.getSearchKeys()[i];
	     					String searchWord = dccSearchAdmin.getSearchWords()[i];
	     					
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
	     					String searchKey = dccSearchAdmin.getSearchKeys()[i];
	     					String searchWord = dccSearchAdmin.getSearchWords()[i];
	     					
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
	     					String searchKey = dccSearchAdmin.getSearchKeys()[i];
	     					String searchWord = dccSearchAdmin.getSearchWords()[i];
	     					
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
	     					String searchKey = dccSearchAdmin.getSearchKeys()[i];
	     					String searchWord = dccSearchAdmin.getSearchWords()[i];
	     					
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
	
	@RequestMapping("iolistmgnlist")
	public ModelAndView iolistmgnlist(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        
		 logger.info("############ iolistmgnlist");
		 logger.info("############ iolistmgnlis==========t" + dccSearchAdmin.getsIOType());
		
		ModelAndView mav = new ModelAndView();
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(dccSearchAdmin.getsIOType() != null && !dccSearchAdmin.getsIOType().equals("") ) {
        		
        			IOListInfo ioListinfo = setSearchIOList(dccSearchAdmin);
        			/*String addrStr = "";
        			String addressRange = dccSearchAdmin.getsAddress() == null ? "" : dccSearchAdmin.getsAddress();
        			if( addressRange.indexOf("-") > -1 ) {
        				addrStr = "BETWEEN "+addressRange.split("-")[0]+" AND "+addressRange.split("-")[1];
        			} else if( addressRange.indexOf(",") > -1 ) {
        				addrStr = "IN ("+addressRange+")";
        			} else {
        				addrStr = "".equals(addressRange) ? "" : "= "+addressRange;
        			}
        			ioListinfo.setAddress(addrStr);*/
		        	
		        	int ioListInfoTotalCnt = dccAdminService.selectIOListInfoTotalCnt(ioListinfo);
		        	dccSearchAdmin.setTotalCnt(ioListInfoTotalCnt);
		        	
		        	List<IOListInfo> ioListInfoList = dccAdminService.selectIOListInfoList(ioListinfo);
		        	String addrRange = "";
		        	if( ioListInfoTotalCnt > 1 ) {
		        		addrRange = ioListInfoList.get(0).getAddress()+" - "+ioListInfoList.get(ioListInfoTotalCnt-1).getAddress();
		        	} else if( ioListInfoTotalCnt > 0 ) {
		        		addrRange = ioListInfoList.get(0).getAddress()+" - "+ioListInfoList.get(0).getAddress();
		        	} else {
		        		addrRange = "0 - 0";
		        	}

		        	dccSearchAdmin.setAddrRange(addrRange);
		        	dccSearchAdmin.setMenuName(this.menuName);
		        	
		        	mav.addObject("IOListInfoList", ioListInfoList);
		        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(dccSearchAdmin));
        	}//end if
        	
        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));

        }

        return mav;
    }	
	
	@RequestMapping("iolistupdate")
	@ResponseBody
	public ModelAndView iolistupdate(RedirectAttributes rttr, IOListInfo iolistInfo, HttpServletRequest request) {
     
        logger.info("############ iolistupdate");

		ModelAndView mav =  new ModelAndView("jsonView");

        if(request.getSession().getAttribute("USER_INFO") != null) {

        	int iolistRtn = dccAdminService.updateIOListInfo(iolistInfo);
   
        	mav.addObject("Rtn", iolistRtn);
        }
        
        return mav;
    }
	
	//파일 다운로드
	@RequestMapping("iolistExcelExport")
	public void ExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchAdmin dccSearchAdmin) throws Exception {
		   
			logger.info("############ ExcelExport");
			logger.info("############ ExcelExport==========t" + dccSearchAdmin.getsIOType());
				
			ModelAndView mav = new ModelAndView();
		        
		    if(request.getSession().getAttribute("USER_INFO") != null) {
	        	
	        	if(dccSearchAdmin.getsIOType() != null && !dccSearchAdmin.getsIOType().equals("") ) {
	        		
	        			IOListInfo ioListinfo = setSearchIOList(dccSearchAdmin);
			        	
			        	List<IOListInfo> ioListInfoList = dccAdminService.selectIOListInfoList(ioListinfo);
			        	
			        	try {
			        		
			        		switch( dccSearchAdmin.getsIOType()) {
			        			case "AI":   		excelHelperUtil.iolistAIExcelDownload(request, response, ioListInfoList);	 break; 
			        			case "AO": 		excelHelperUtil.iolistAOExcelDownload(request, response, ioListInfoList);	 break; 
			        			case "CI":   		excelHelperUtil.iolistCIExcelDownload(request, response, ioListInfoList);	 break; 
			        			case "DI":   		excelHelperUtil.iolistDIExcelDownload(request, response, ioListInfoList);	 break; 
			        			case "DO":  		excelHelperUtil.iolistDOExcelDownload(request, response, ioListInfoList);	 break; 
			        			case "DT":   	excelHelperUtil.iolistDTExcelDownload(request, response, ioListInfoList);	 break; 
			        			case "SC":   	excelHelperUtil.iolistSCExcelDownload(request, response, ioListInfoList);	 break; 
			        			case "FTAI":    	excelHelperUtil.iolistFTAIExcelDownload(request, response, ioListInfoList);	 break; 
			        			case "FTDT":    excelHelperUtil.iolistFTDTExcelDownload(request, response, ioListInfoList);	 break; 
			        		}		
						
						}catch(Exception e) {
							logger.error("### e : {}", e);
							throw new Exception(e);
						}
			        	
	        	} //iotype end if
	    }// session end if		
	}
	
	@RequestMapping("sysmonitoring")
	public ModelAndView sysmonitoring(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
     
        logger.info("############ sysmonitoring");
		
		ModelAndView mav = new ModelAndView();

        if(request.getSession().getAttribute("USER_INFO") != null) {
        	List<Map> dccMasterStates = new ArrayList();
        	List<Map> dccSlaveStates = new ArrayList();
        	Map searchMap = new HashMap();
        	
        	if( commonConstant.getUrl().indexOf("10.135.101.222") > -1 ) {
            	dccMasterStates = altCommonService.selectLogTimer(searchMap);
            	dccSlaveStates = basCommonService.selectLogTimer(searchMap);
			} else {
	        	dccMasterStates = basCommonService.selectLogTimer(searchMap);
            	dccSlaveStates = altCommonService.selectLogTimer(searchMap);
			}

        	List<Map> masterStates = new ArrayList();
        	List<Map> slaveStates = new ArrayList();
        	
        	LocalDateTime mNow = LocalDateTime.now();
        	for( int i=0;i<dccMasterStates.size();i++ ) {
    			String mGubun = dccMasterStates.get(i).get("Gubun") == null ? "E" : dccMasterStates.get(i).get("Gubun").toString();
    			String mHogi = dccMasterStates.get(i).get("Hogi") == null ? "E" : dccMasterStates.get(i).get("Hogi").toString();
    			String mDataType = dccMasterStates.get(i).get("Datatype") == null ? "E" : dccMasterStates.get(i).get("Datatype").toString();
    			String mScanTime = dccMasterStates.get(i).get("Scantime") == null ? "" : dccMasterStates.get(i).get("Scantime").toString();
    			
    			//logger.info("gubun : "+mGubun+", hogi : "+mHogi+", datatype : "+mDataType+", scantime : "+mScanTime);
    			
    			Map mTmp = new HashMap();
    			if( !"E".equals(mGubun) && !"E".equals(mHogi) && !"E".equals(mDataType) ) {
        			int mDiff = (int) Duration.between(mNow,convDtm(mScanTime,true)).getSeconds();
	    			if( Math.abs(mDiff) < 180 ) {
						mTmp.put("state", "ON");
	    			} else {
	    				mTmp.put("state", "OFF");
	    			}
					mTmp.put("toolTip", mScanTime);
					mTmp.put("type", mGubun+mHogi+mDataType);
    			} else {
    				mTmp.put("state", "OFF");
    				mTmp.put("toolTip", mScanTime);
    				mTmp.put("type", "EEE");
    			}
				
				masterStates.add(mTmp);
        	}

        	for( int i=0;i<dccSlaveStates.size();i++ ) {
    			String sGubun = dccSlaveStates.get(i).get("Gubun") == null ? "E" : dccSlaveStates.get(i).get("Gubun").toString();
    			String sHogi = dccSlaveStates.get(i).get("Gubun") == null ? "E" : dccSlaveStates.get(i).get("Hogi").toString();
    			String sDataType = dccSlaveStates.get(i).get("Gubun") == null ? "E" : dccSlaveStates.get(i).get("Datatype").toString();
    			String sScanTime = dccSlaveStates.get(i).get("Scantime") == null ? "" : dccSlaveStates.get(i).get("Scantime").toString();
    			
    			//logger.info("gubun : "+sGubun+", hogi : "+sHogi+", datatype : "+sDataType+", scantime : "+sScanTime);

    			Map sTmp = new HashMap();
    			if( !"E".equals(sGubun) && !"E".equals(sHogi) && !"E".equals(sDataType) ) {
        			int sDiff = (int) Duration.between(mNow,convDtm(sScanTime,true)).getSeconds();
	    			if( Math.abs(sDiff) < 180 ) {
						sTmp.put("state", "ON");
	    			} else {
	    				sTmp.put("state", "OFF");
	    			}
					sTmp.put("toolTip", sScanTime);
					sTmp.put("type", sGubun+sHogi+sDataType);
    			} else {
    				sTmp.put("state", "OFF");
    				sTmp.put("toolTip",  sScanTime);
    				sTmp.put("type", "EEE");
    			}
				
				slaveStates.add(sTmp);
        	}
        	
        	mav.addObject("ScanTime",mNow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).toString());
        	
        	mav.addObject("masterStates",masterStates);
        	mav.addObject("slaveStates",slaveStates);

        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        
        return mav;
    }
	
	@RequestMapping(value="reloadSysmonitoring", method= {RequestMethod.POST})
	@ResponseBody
	public ModelAndView reloadSysmonitoring(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
     
        logger.info("############ reloadSysmonitoring");
		
		ModelAndView mav = new ModelAndView("jsonView");

        if(request.getSession().getAttribute("USER_INFO") != null) {
        	List<Map> dccMasterStates = new ArrayList();
        	List<Map> dccSlaveStates = new ArrayList();
        	Map searchMap = new HashMap();
        	
        	if( commonConstant.getUrl().indexOf("10.135.101.222") > -1 ) {
            	dccMasterStates = altCommonService.selectLogTimer(searchMap);
            	dccSlaveStates = basCommonService.selectLogTimer(searchMap);
			} else {
	        	dccMasterStates = basCommonService.selectLogTimer(searchMap);
            	dccSlaveStates = altCommonService.selectLogTimer(searchMap);
			}

        	List<Map> masterStates = new ArrayList();
        	List<Map> slaveStates = new ArrayList();
        	
        	LocalDateTime mNow = LocalDateTime.now();
        	for( int i=0;i<dccMasterStates.size();i++ ) {
    			String mGubun = dccMasterStates.get(i).get("Gubun") == null ? "E" : dccMasterStates.get(i).get("Gubun").toString();
    			String mHogi = dccMasterStates.get(i).get("Hogi") == null ? "E" : dccMasterStates.get(i).get("Hogi").toString();
    			String mDataType = dccMasterStates.get(i).get("Datatype") == null ? "E" : dccMasterStates.get(i).get("Datatype").toString();
    			String mScanTime = dccMasterStates.get(i).get("Scantime") == null ? "" : dccMasterStates.get(i).get("Scantime").toString();
    			
    			//logger.info("gubun : "+mGubun+", hogi : "+mHogi+", datatype : "+mDataType+", scantime : "+mScanTime);
    			
    			Map mTmp = new HashMap();
    			if( !"E".equals(mGubun) && !"E".equals(mHogi) && !"E".equals(mDataType) ) {
        			int mDiff = (int) Duration.between(mNow,convDtm(mScanTime,true)).getSeconds();
	    			if( Math.abs(mDiff) < 180 ) {
						mTmp.put("state", "ON");
	    			} else {
	    				mTmp.put("state", "OFF");
	    			}
					mTmp.put("toolTip", mScanTime);
					mTmp.put("type", mGubun+mHogi+mDataType);
    			} else {
    				mTmp.put("state", "OFF");
    				mTmp.put("toolTip", mScanTime);
    				mTmp.put("type", "EEE");
    			}
				
				masterStates.add(mTmp);
        	}

        	for( int i=0;i<dccSlaveStates.size();i++ ) {
    			String sGubun = dccSlaveStates.get(i).get("Gubun") == null ? "E" : dccSlaveStates.get(i).get("Gubun").toString();
    			String sHogi = dccSlaveStates.get(i).get("Gubun") == null ? "E" : dccSlaveStates.get(i).get("Hogi").toString();
    			String sDataType = dccSlaveStates.get(i).get("Gubun") == null ? "E" : dccSlaveStates.get(i).get("Datatype").toString();
    			String sScanTime = dccSlaveStates.get(i).get("Scantime") == null ? "" : dccSlaveStates.get(i).get("Scantime").toString();
    			
    			//logger.info("gubun : "+sGubun+", hogi : "+sHogi+", datatype : "+sDataType+", scantime : "+sScanTime);

    			Map sTmp = new HashMap();
    			if( !"E".equals(sGubun) && !"E".equals(sHogi) && !"E".equals(sDataType) ) {
        			int sDiff = (int) Duration.between(mNow,convDtm(sScanTime,true)).getSeconds();
	    			if( Math.abs(sDiff) < 180 ) {
						sTmp.put("state", "ON");
	    			} else {
	    				sTmp.put("state", "OFF");
	    			}
					sTmp.put("toolTip", sScanTime);
					sTmp.put("type", sGubun+sHogi+sDataType);
    			} else {
    				sTmp.put("state", "OFF");
    				sTmp.put("toolTip",  sScanTime);
    				sTmp.put("type", "EEE");
    			}
				
				slaveStates.add(sTmp);
        	}
        	
        	mav.addObject("ScanTime",mNow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).toString());
        	
        	mav.addObject("masterStates",masterStates);
        	mav.addObject("slaveStates",slaveStates);

        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        
        return mav;
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
	
	@RequestMapping("sysimprovelist")
	public ModelAndView sysimprovelist(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
     
        logger.info("############ sysimprovelist");
		
		ModelAndView mav = new ModelAndView();

        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(dccSearchAdmin.getSearchKey() != null && !dccSearchAdmin.getSearchKey().isEmpty()) {
        		if(dccSearchAdmin.getSearchKey().equals("pTitle")){
        			dccSearchAdmin.setpTitle(dccSearchAdmin.getSearchWord());
        		}else if(dccSearchAdmin.getSearchKey().equals("pContents")){
        			dccSearchAdmin.setpContents(dccSearchAdmin.getSearchWord());
        		}
        	}
        	
        	int improveTotalCnt = dccAdminService.selectImproveTotalCnt(dccSearchAdmin);
        	dccSearchAdmin.setTotalCnt(improveTotalCnt);
        	
        	List<ImproveInfo> improveInfoList = dccAdminService.selectImproveList(dccSearchAdmin);
        	
        	dccSearchAdmin.setMenuName(this.menuName);
        	
        	mav.addObject("ImproveInfoList", improveInfoList);
        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(dccSearchAdmin));
        	
        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        
        return mav;
    }
	
	@RequestMapping("sysimproveInsert")
	public ModelAndView sysimproveInsert(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
 
        logger.info("############ sysimproveInsert");
		
		ModelAndView mav = new ModelAndView();

        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	MemberInfo memberInfo =(MemberInfo)(request.getSession().getAttribute("USER_INFO"));        	
        	dccSearchAdmin.setiWUser(memberInfo.getId());

        	int improveRtn = dccAdminService.insertImproveInfo(dccSearchAdmin);
        	
        	mav.setViewName("redirect:/dcc/admin/sysimprovelist");        	
        }
        
        return mav;
    }
	
	@RequestMapping("sysimproveupdate")
	public ModelAndView sysimproveupdate(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        
        logger.info("############ sysimproveUpdate");
		
		ModelAndView mav = new ModelAndView();
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	int improveRtn = dccAdminService.updateImproveInfo(dccSearchAdmin);
        	
        	mav.setViewName("redirect:/dcc/admin/sysimprovelist");        	
        }
        
        return mav;
    }
	
	
	@RequestMapping("sysimprovedelete")
	public ModelAndView sysimprovedelete(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        
        logger.info("############ sysimproveDelete");
		
		ModelAndView mav = new ModelAndView();
        
        if(request.getSession().getAttribute("USER_INFO") != null) {

        	int improveRtn = dccAdminService.deleteImproveInfo(dccSearchAdmin);
        	
        	mav.setViewName("redirect:/dcc/admin/sysimprovelist");        	
        }
        
        return mav;
    }
		
	
	@RequestMapping("swsmlist")
	public ModelAndView swsmlist(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        
        logger.info("############ swsmlist");
		
		ModelAndView mav = new ModelAndView();
       
        if(request.getSession().getAttribute("USER_INFO") != null) {
         	
        	if(dccSearchAdmin.getSearchKey() != null && !dccSearchAdmin.getSearchKey().isEmpty()) {
        		if(dccSearchAdmin.getSearchKey().equals("progName")){
        			dccSearchAdmin.setProgName(dccSearchAdmin.getSearchWord());
        		}else if(dccSearchAdmin.getSearchKey().equals("logNo")){
        			dccSearchAdmin.setLogNo(dccSearchAdmin.getSearchWord());
        		}else if(dccSearchAdmin.getSearchKey().equals("descr")){
        			dccSearchAdmin.setDescr(dccSearchAdmin.getSearchWord());
        		}else if(dccSearchAdmin.getSearchKey().equals("createDate")){
        			dccSearchAdmin.setCreateDate(dccSearchAdmin.getSearchWord());
        		}
        	}
        	
        	int swSmTotalCnt = dccAdminService.selectSwSmTotalCnt(dccSearchAdmin);
        	dccSearchAdmin.setTotalCnt(swSmTotalCnt);
        	
        	List<SwSmInfo> swSmInfoList = dccAdminService.selectSwSmList(dccSearchAdmin);
        	
        	dccSearchAdmin.setMenuName(this.menuName);
        	
        	mav.addObject("SwSmInfoList", swSmInfoList);
        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(dccSearchAdmin));
        	
        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }
        
        return mav;
    }
	
	@RequestMapping("swsmInsert")
	public ModelAndView swsmInsert(@RequestParam MultipartFile[] fileNames, DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
		
        logger.info("############ swsmInsert");
		
		ModelAndView mav = new ModelAndView();
		
		   if(request.getSession().getAttribute("USER_INFO") != null) {
			   
			   int idx =1;
			   for(MultipartFile file:fileNames) {
				   
				   Upload upload = new Upload();
				   upload.setDiv(this.menuName);
				   
				   try {
					   
					   if(file.isEmpty()) {
						   logger.info("############ swsmInsert file is not selected.....!!!!");
						   continue;
					   }
					   
					   fileHelperUtil.upload(file, upload);

					   logger.info("############ swsmInsert file full path =====" + upload.getFileFullPath());
				   
					  switch(idx) {
					  	case 1: dccSearchAdmin.setiFileName1(upload.getFileRealName()); break;
					  	case 2: dccSearchAdmin.setiFileName2(upload.getFileRealName()); break;
					  	case 3: dccSearchAdmin.setiFileName3(upload.getFileRealName()); break;
					  	case 4: dccSearchAdmin.setiFileName4(upload.getFileRealName()); break;
					  	case 5: dccSearchAdmin.setiFileName5(upload.getFileRealName()); break;
					  	case 6: dccSearchAdmin.setiFileName6(upload.getFileRealName()); break;
					  	case 7: dccSearchAdmin.setiFileName7(upload.getFileRealName()); break;
					  	case 8: dccSearchAdmin.setiFileName8(upload.getFileRealName()); break;
					  	case 9: dccSearchAdmin.setiFileName9(upload.getFileRealName()); break;
					  	case 10: dccSearchAdmin.setiFileName10(upload.getFileRealName()); break;						   
					  }
					   
				   }catch (Exception ex) {
					   logger.info(ex.getMessage());
				   }
				   
				   idx++;
			   }		
			   
			   dccAdminService.insertSwSmInfo(dccSearchAdmin);
	        	
			   mav.setViewName("redirect:/dcc/admin/swsmlist");
	        }
	
        return mav;
	}
	
	@RequestMapping("swsmdelete")
	public ModelAndView swsmdelete(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ swsmdelete");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
			Upload upload = new Upload();
			upload.setDiv(this.menuName);
        	
        	int rtn = dccAdminService.deleteSwSmInfo(dccSearchAdmin);
        	
        	if( rtn > 0 ) {
				if( !"".equals(dccSearchAdmin.getiFileName1().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName1().trim() );
				if( !"".equals(dccSearchAdmin.getiFileName2().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName2().trim() );
				if( !"".equals(dccSearchAdmin.getiFileName3().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName3().trim() );
				if( !"".equals(dccSearchAdmin.getiFileName4().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName4().trim() );
				if( !"".equals(dccSearchAdmin.getiFileName5().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName5().trim() );
				if( !"".equals(dccSearchAdmin.getiFileName6().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName6().trim() );
				if( !"".equals(dccSearchAdmin.getiFileName7().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName7().trim() );
				if( !"".equals(dccSearchAdmin.getiFileName8().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName8().trim() );
				if( !"".equals(dccSearchAdmin.getiFileName9().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName9().trim() );
				if( !"".equals(dccSearchAdmin.getiFileName10().trim()) && rtn > 0 ) rtn = fileHelperUtil.deleteAttachFile(upload,dccSearchAdmin.getiFileName10().trim() );
        	}
        	
    		mav.setViewName("redirect:/dcc/admin/swsmlist");
        }
        
        return mav;
    }
	
	@RequestMapping(value = "swsmDetail", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView swsmDetail(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
		
		logger.info("############ swsmDetail");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		SwSmInfo swSmInfo = dccAdminService.selectSwSmInfo(dccSearchAdmin);
		
		if(swSmInfo != null && !swSmInfo.getSeqNo().equals("")) {
			mav.addObject("SwSmInfo", swSmInfo);
		}

		return mav;
	}
	
	
	//파일 다운로드
	@RequestMapping("swsmDownload")
	public void swsmDownload(HttpServletRequest request, HttpServletResponse response, DccSearchAdmin dccSearchAdmin) throws Exception {
		
		   if(request.getSession().getAttribute("USER_INFO") != null) {
		
					try{
						
						SwSmInfo swSmInfo = dccAdminService.selectSwSmInfo(dccSearchAdmin);
						
						Upload upload = new Upload();
						upload.setDiv(this.menuName);			
						
						switch(Integer.parseInt(dccSearchAdmin.getFileIdx())) {
							case 1:	upload.setFileRealName(swSmInfo.getFileName1()); break;
							case 2:	upload.setFileRealName(swSmInfo.getFileName2()); break;
							case 3:	upload.setFileRealName(swSmInfo.getFileName3()); break;
							case 4:	upload.setFileRealName(swSmInfo.getFileName4()); break;
							case 5:	upload.setFileRealName(swSmInfo.getFileName5()); break;
							case 6:	upload.setFileRealName(swSmInfo.getFileName6()); break;
							case 7:	upload.setFileRealName(swSmInfo.getFileName7()); break;
							case 8:	upload.setFileRealName(swSmInfo.getFileName8()); break;
							case 9:	upload.setFileRealName(swSmInfo.getFileName9()); break;
							case 10:	upload.setFileRealName(swSmInfo.getFileName10()); break;
						}
						
						fileHelperUtil.download(request, response, upload, "application/octet-stream");
						
					}catch(Exception e) {
						logger.error("### e : {}", e);
						throw new Exception(e);
					}
		   }
	}
	
	@RequestMapping("swsmExcelExport")
	public void swsmExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchAdmin dccSearchAdmin) throws Exception {
		
			logger.info("############ swsmExcelExport");
		
			if(request.getSession().getAttribute("USER_INFO") != null) {
		
				try{
					
					if(dccSearchAdmin.getSearchKey() != null && !dccSearchAdmin.getSearchKey().isEmpty()) {
						if(dccSearchAdmin.getSearchKey().equals("progName")){
							dccSearchAdmin.setProgName(dccSearchAdmin.getSearchWord());
						}else if(dccSearchAdmin.getSearchKey().equals("logNo")){
							dccSearchAdmin.setLogNo(dccSearchAdmin.getSearchWord());
						}else if(dccSearchAdmin.getSearchKey().equals("descr")){
							dccSearchAdmin.setDescr(dccSearchAdmin.getSearchWord());
						}else if(dccSearchAdmin.getSearchKey().equals("createDate")){
							dccSearchAdmin.setCreateDate(dccSearchAdmin.getSearchWord());
						}
					}
					
					//int swSmTotalCnt = dccAdminService.selectSwSmTotalCnt(dccSearchAdmin);
					//dccSearchAdmin.setTotalCnt(swSmTotalCnt);
					
					List<SwSmInfo> swSmInfoList = dccAdminService.selectSwSmExportList(dccSearchAdmin);
					
					excelHelperUtil.swsmExcelDownload(request, response, swSmInfoList);			
					
				}catch(Exception e) {
					logger.error("### e : {}", e);
					throw new Exception(e);
				}
			}
	}

	
	@RequestMapping("swsmExcelImport")
	public ModelAndView swsmExcelImport(@RequestParam MultipartFile importExcelFile, DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
		
		logger.info("############ swsmExcelImport");
		
		ModelAndView mav = new ModelAndView();
				
		if(request.getSession().getAttribute("USER_INFO") != null) {
			   
			   Upload upload = new Upload();
			   upload.setDiv(this.menuName);
			   
			   try {
				   //file upload
				   
				   if(importExcelFile.isEmpty()) {
					   logger.info("############ swsmExcelImport file is not selected.....!!!!");
					   throw new IOException("파일을 선택해 해주세요.");
				   }
				   
				   fileHelperUtil.upload(importExcelFile, upload);
				   logger.info("############ swsmExcelImport===" + upload.getFileRealName());
				   logger.info("############ swsmExcelImport===" + upload.getFilePath());
				   
				   String extension = FilenameUtils.getExtension(upload.getFileRealName()); // 3
				   logger.info("############ extension===" + extension);
				   
				   if (!extension.equals("xlsx") && !extension.equals("xls")) {
				      throw new IOException("엑셀파일만 업로드 해주세요.");
				   }
				   
				   upload.setFileExtension(extension);
				   
				   //excel file parsing
				   List<SwSmInfo> swsmInfoList = excelHelperUtil.swsmExcelImport(importExcelFile, upload);
				   
				   logger.info("############ swsmInfoList size===" + swsmInfoList.size());
				   
				   //excel file insert
				   for(SwSmInfo swsmInfo:swsmInfoList) {
					   
					   dccSearchAdmin.setiLogNo(swsmInfo.getLogNo());
					   dccSearchAdmin.setiProNo(swsmInfo.getProNo());
					   dccSearchAdmin.setiProgName(swsmInfo.getProgName());
					   dccSearchAdmin.setiDivide(swsmInfo.getDivide());
					   dccSearchAdmin.setiDescr(swsmInfo.getDescr());
					   dccSearchAdmin.setiCreateDate(swsmInfo.getCreateDate());
					   dccSearchAdmin.setiCreateDate(swsmInfo.getCreateDate());
					   dccSearchAdmin.setiBigo(swsmInfo.getBigo());
					   dccSearchAdmin.setiFileName1(swsmInfo.getFileName1());
					   dccSearchAdmin.setiFileName2(swsmInfo.getFileName2());
					   dccSearchAdmin.setiFileName3(swsmInfo.getFileName3());
					   dccSearchAdmin.setiFileName4(swsmInfo.getFileName4());
					   dccSearchAdmin.setiFileName5(swsmInfo.getFileName5());
					   dccSearchAdmin.setiFileName6(swsmInfo.getFileName6());
					   dccSearchAdmin.setiFileName7(swsmInfo.getFileName7());
					   dccSearchAdmin.setiFileName8(swsmInfo.getFileName8());
					   dccSearchAdmin.setiFileName9(swsmInfo.getFileName9());
					   dccSearchAdmin.setiFileName10(swsmInfo.getFileName10());

					   dccAdminService.insertSwSmInfo(dccSearchAdmin);
				   }
				   
			   }catch (Exception ex) {
				   		ex.printStackTrace();
			   }
		   
		   mav.setViewName("redirect:/dcc/admin/swsmlist");
        }
	
        return mav;
	}

	
	@RequestMapping("hwsmlist")
	public ModelAndView hwsmlist(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ hwsmlist");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(dccSearchAdmin.getSearchKey() != null && !dccSearchAdmin.getSearchKey().isEmpty()) {
        		if(dccSearchAdmin.getSearchKey().equals("failure")){
        			dccSearchAdmin.setFailure(dccSearchAdmin.getSearchWord());
        		}else if(dccSearchAdmin.getSearchKey().equals("repair")){
        			dccSearchAdmin.setRepair(dccSearchAdmin.getSearchWord());
        		}
        	}
        	
        	int hwSmTotalCnt = dccAdminService.selectHwSmTotalCnt(dccSearchAdmin);
        	dccSearchAdmin.setTotalCnt(hwSmTotalCnt);
        	
        	List<HwSmInfo> hwSmInfoList = dccAdminService.selectHwSmList(dccSearchAdmin);
        	
        	dccSearchAdmin.setMenuName(this.menuName);
        	
        	mav.addObject("HwSmInfoList", hwSmInfoList);
        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(dccSearchAdmin));
        	
        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        }
        
        return mav;
    }	
	
	@RequestMapping("hwsmupdate")
	public ModelAndView hwsmUpdate(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ hwsmupdate");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	
        	logger.info("############ hwsmupdate---" + dccSearchAdmin.getiFailure());
        	
        	int rtn = dccAdminService.updateHwSmInfo(dccSearchAdmin);
        	
        	mav.setViewName("redirect:/dcc/admin/hwsmlist");

        }
        
        return mav;
    }	
	
	@RequestMapping("hwsmdelete")
	public ModelAndView hwsmdelete(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ hwsmdelete");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	int rtn = dccAdminService.deleteHwSmInfo(dccSearchAdmin);
        	
        	mav.setViewName("redirect:/dcc/admin/hwsmlist");
        }
        
        return mav;
    }
	
	@RequestMapping("hwsminsert")
	public ModelAndView hwsminsert(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ hwsminsert");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	int rtn = dccAdminService.insertHwSmInfo(dccSearchAdmin);
        	
        	mav.setViewName("redirect:/dcc/admin/hwsmlist");
        }
        
        return mav;
    }
	
	
	@RequestMapping("pcbmgmlist")
	public ModelAndView pcbmgmlist(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ pcbmgmlist");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	if(dccSearchAdmin.getSearchKey() != null && !dccSearchAdmin.getSearchKey().isEmpty()) {
        		if(dccSearchAdmin.getSearchKey().equals("sysNm")){
        			dccSearchAdmin.setSysNm(dccSearchAdmin.getSearchWord());
        		}else if(dccSearchAdmin.getSearchKey().equals("rack")){
        			dccSearchAdmin.setRack(dccSearchAdmin.getSearchWord());
        		}else if(dccSearchAdmin.getSearchKey().equals("equipNm")){
        			dccSearchAdmin.setEquipNm(dccSearchAdmin.getSearchWord());
        		}
        	}
        	
        	int equipTotalCnt = dccAdminService.selectEquipTotalCnt(dccSearchAdmin);
        	dccSearchAdmin.setTotalCnt(equipTotalCnt);
        	
        	List<EquipInfo> equipInfoList = dccAdminService.selectEquipList(dccSearchAdmin);
        	
        	dccSearchAdmin.setMenuName(this.menuName);
        	
        	mav.addObject("EquipInfoList", equipInfoList);
        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(dccSearchAdmin));
        	
        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        
        return mav;
    }
	
	@RequestMapping(value = "pcbinfo", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView pcbinfo(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("jsonView");

        logger.info("############ pcbinfo");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
    		
    		EquipInfo equipInfo = dccAdminService.selectEquipInfo(dccSearchAdmin);
    		
    		if(equipInfo != null && !equipInfo.getSeqNo().equals("")) {
    			mav.addObject("EquipInfo", equipInfo);
    		}        	
        }
        
        return mav;
    }
	
	@RequestMapping("pcbinsert")
	public ModelAndView pcbinsert(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ pcbinsert");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	int rtn = dccAdminService.insertEquipInfo(dccSearchAdmin);
        	
        	mav.setViewName("redirect:/dcc/admin/pcbmgmlist");
        	
        }
        
        return mav;
    }
	
	@RequestMapping("pcbupdate")
	public ModelAndView pcbupdate(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ pcbupdate");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	int rtn = dccAdminService.updateEquipInfo(dccSearchAdmin);
        	
        	mav.setViewName("redirect:/dcc/admin/pcbmgmlist");
        	
        }
        
        return mav;
    }	
	
	@RequestMapping("pcbdelete")
	public ModelAndView pcbdelete(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
       
		ModelAndView mav = new ModelAndView();

        logger.info("############ pcbdelete");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	int rtn = dccAdminService.deleteEquipInfo(dccSearchAdmin);
        	
        	mav.setViewName("redirect:/dcc/admin/pcbmgmlist");
        	
        }
        
        return mav;
    }	
	
	@RequestMapping("equipExcelExport")
	public void equipExcelExport(HttpServletRequest request, HttpServletResponse response, DccSearchAdmin dccSearchAdmin) throws Exception {
	
			logger.info("############ equipExcelExport");
	
			if(request.getSession().getAttribute("USER_INFO") != null) {
		
				try{
					
				 	if(dccSearchAdmin.getSearchKey() != null && !dccSearchAdmin.getSearchKey().isEmpty()) {
		        		if(dccSearchAdmin.getSearchKey().equals("sysNm")){
		        			dccSearchAdmin.setSysNm(dccSearchAdmin.getSearchWord());
		        		}else if(dccSearchAdmin.getSearchKey().equals("rack")){
		        			dccSearchAdmin.setRack(dccSearchAdmin.getSearchWord());
		        		}else if(dccSearchAdmin.getSearchKey().equals("equipNm")){
		        			dccSearchAdmin.setEquipNm(dccSearchAdmin.getSearchWord());
		        		}
		        	}
		        	
		        	int equipTotalCnt = dccAdminService.selectEquipTotalCnt(dccSearchAdmin);
		        	dccSearchAdmin.setTotalCnt(equipTotalCnt);
		        	
		        	List<EquipInfo> equipInfoList = dccAdminService.selectEquipListForExcel(dccSearchAdmin);
					
					excelHelperUtil.equipExcelDownload(request, response, equipInfoList);			
					
				}catch(Exception e) {
					logger.error("### e : {}", e);
					throw new Exception(e);
				}
		}			
	}
		
		
	@RequestMapping("restartcodelist")
	public ModelAndView restartcodelist(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ restartcodelist");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	int restartCodeTotalCnt = dccAdminService.selectRestartCodeTotalCnt(dccSearchAdmin);
        	dccSearchAdmin.setTotalCnt(restartCodeTotalCnt);
        	
        	List<RestartCodeInfo> restartCodeInfoList = dccAdminService.selectRestartCodeList(dccSearchAdmin);
        	
        	dccSearchAdmin.setMenuName(this.menuName);
        	
        	mav.addObject("RestartCodeInfoList", restartCodeInfoList);
        	mav.addObject("PageHtml", pageHtmlUtil.getPageHtml(dccSearchAdmin));
        	
        	mav.addObject("BaseSearch", dccSearchAdmin);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
        
        return mav;
    }
	
	@RequestMapping("restartcodeinsert")
	public ModelAndView restartcodeinsert(@RequestParam MultipartFile[] fileNames, DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ restartcodeinsert");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	 int idx =1;
			   for(MultipartFile file:fileNames) {
				   
				   Upload upload = new Upload();
				   upload.setDiv(this.menuName);
				   
				   try {
					   
					   if(file.isEmpty()) {
						   logger.info("############ restartcodeinsert file is not selected");
						   continue;
					   }
					   
					   fileHelperUtil.upload(file, upload);

					   logger.info("############ restartcodeinsert file full path =====" + upload.getFileFullPath());
				   
					  switch(idx) {
					  	case 1: dccSearchAdmin.setiFileName1(upload.getFileRealName()); break;
					  	case 2: dccSearchAdmin.setiFileName2(upload.getFileRealName()); break;
					  	case 3: dccSearchAdmin.setiFileName3(upload.getFileRealName()); break;
					  	case 4: dccSearchAdmin.setiFileName4(upload.getFileRealName()); break;
					  	case 5: dccSearchAdmin.setiFileName5(upload.getFileRealName()); break;
					  }
					   
				   }catch (Exception ex) {
					   logger.info(ex.getMessage());
				   }
				   
				   idx++;
			   }		
        
			   dccAdminService.insertRestartCodeInfo(dccSearchAdmin);
			   
			   mav.setViewName("redirect:/dcc/admin/restartcodelist");
        	
        }
        
        return mav;
    }
	
	@RequestMapping(value = "restartcodedetail", method = { RequestMethod.POST })
	@ResponseBody
	public ModelAndView restartcodedetail(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
		
		logger.info("############ restartcodedetail");
                
		ModelAndView mav = new ModelAndView("jsonView");
		
		RestartCodeInfo restartCodeInfo = dccAdminService.selectRestartCodeInfo(dccSearchAdmin);
		
		if(restartCodeInfo != null && !restartCodeInfo.getSeqNo().equals("")) {
			mav.addObject("RestartCodeInfo", restartCodeInfo);
		}

		return mav;
	}
	
	@RequestMapping("restartcodeupdate")
	public ModelAndView restartcodeupdate(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ restartcodeupdate");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	int rtn = dccAdminService.updateRestartCodeInfo(dccSearchAdmin);
        
        	mav.setViewName("redirect:/dcc/admin/restartcodelist");
        	
        }
        
        return mav;
    }
	
	@RequestMapping("restartcodedelete")
	public ModelAndView restartcodedelete(DccSearchAdmin dccSearchAdmin, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        logger.info("############ restartcodedelete");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	int rtn = dccAdminService.deleteRestartCodeInfo(dccSearchAdmin);
        
        	mav.setViewName("redirect:/dcc/admin/restartcodelist");
        	
        }
        
        return mav;
    }	
	

	//파일 다운로드
	@RequestMapping("restartCodeDownload")
	public void restartCodeDownload(HttpServletRequest request, HttpServletResponse response, DccSearchAdmin dccSearchAdmin) throws Exception {
		try{
			
			RestartCodeInfo restartCodeInfo = dccAdminService.selectRestartCodeInfo(dccSearchAdmin);
			
			Upload upload = new Upload();
			upload.setDiv(this.menuName);			
			
			switch(Integer.parseInt(dccSearchAdmin.getFileIdx())) {
				case 1:	upload.setFileRealName(restartCodeInfo.getFileName1()); break;
				case 2:	upload.setFileRealName(restartCodeInfo.getFileName2()); break;
				case 3:	upload.setFileRealName(restartCodeInfo.getFileName3()); break;
				case 4:	upload.setFileRealName(restartCodeInfo.getFileName4()); break;
				case 5:	upload.setFileRealName(restartCodeInfo.getFileName5()); break;
			}
			
			fileHelperUtil.download(request, response, upload, "application/octet-stream");
			
		}catch(Exception e) {
			logger.error("### e : {}", e);
			throw new Exception(e);
		}
	}
}
