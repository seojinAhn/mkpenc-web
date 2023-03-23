package com.mkpenc.dcc.admin.model;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class DccSearchAdmin extends BaseSearch {
	
	private String userId;
	private String userPwd;
	
	private String groupCode; 
	private String groupName;
	private String userName;  
	private String useYN;	  
	private String login;
	 
	private String searchKey;  
	private String searchWord;	
	
	private String[] searchKeys;  
	private String[] searchWords;	  
	
	private String userGroupCode;
	private String userGroupName;
	
	private String logoutUserList;
	
	protected int grpPageNum = 1;
	protected int grpPageSize = 10;
		
	protected int grpTotalCnt;
	protected int grpTotalPage;	
	
	protected int grpBeginPage;;
	protected int grpEndPage;	
	
	protected int intSeqNo;;
	
	protected String iId;
	protected String iUserName;
	protected String iPwd;
	protected String iGroupCode;
	protected String iGrade;
	protected String iLoginHogi;
	protected String iEmail;
	protected String iUseYN;
	
	protected String uId;
	protected String uPwd;
	protected String uLogin;
	protected String uUserIp;
	
	//IOLIST 
	protected String sIhogi;
	protected String sXYGubun;
	protected String sIOType;
	protected String sAddress;
	
	
	//개선사항
	protected String pTitle;
	protected String pContents;
	
	protected String iPTitle;
	protected String iPContents;
	protected String iPUser;
	protected String iWUser;
	
	//SW 형상관리
	protected String seqNo;
	protected String progName;
	protected String logNo;
	protected String createDate;
	protected String fileIdx;
	
	protected String iLogNo;
	protected String iProNo;
	protected String iProgName;
	protected String iDivide;
	protected String iDescr;
	protected String iCreateDate;
	protected String iHogi;
	protected String iBigo;
	protected String iFileName1;
	protected String iFileName2;
	protected String iFileName3;
	protected String iFileName4;
	protected String iFileName5;
	protected String iFileName6;
	protected String iFileName7;
	protected String iFileName8;
	protected String iFileName9;
	protected String iFileName10;
	
	//HW형상관리
	protected String failure;
	protected String repair;
	
	protected String iSeqNo;
	protected String iType;
	protected String iDate;
	protected String iFailure;
	protected String iRepair;
	
	
	//PCB
	protected String invnr;
	protected String state;
	protected String materialNo;
	protected String sn;
	protected String sysNm;
	protected String rack;
	protected String equipNm;	
	
	protected String iInvnr; 
	protected String iUserNm;
	protected String iSysNm;
	protected String iInsLoc;
	protected String iRack;
	protected String iFid;
	protected String iSpv;
	protected String iEquipNm;
	protected String iTagNo;
	protected String iMaterialNo;
	protected String iQGrade;
	protected String iSgRade;
	protected String iSYear;
	protected String iProduct;
	protected String iSupplier;
	protected String iPn;
	protected String iSn;
	protected String iRev;
	protected String iProDate;
	protected String iPo;
	protected String iInDate;
	protected String iInCnt;
	protected String iState;
	protected String iWeakPart;
	protected String iWPartNm;
	protected String iPmNo;
	protected String iPcDate;
	protected String iPcCycle;
	protected String iIctCycle;
	protected String iChgCycle;
	protected String iChkMeth;
	protected String iChkCycle;
	protected String iInsDate;
	protected String iMDate1;
	protected String iMContent1;
	protected String iMBigo1;
	protected String iMDate2;
	protected String iMContent2;
	protected String iMBigo2;
	protected String iMDate3;
	protected String iMContent3;
	protected String iMBigo3;
	protected String iMDate4;
	protected String iMContent4;
	protected String iMBigo4;
	protected String iEDate1;
	protected String iEContent1;
	protected String iEBigo1;
	protected String iEDate2;
	protected String iEContent2;
	protected String iEBigo2;
	protected String iEDate3;
	protected String iEContent3;
	protected String iEBigo3;
	protected String iEDate4;
	protected String iEContent4;
	protected String iEBigo4;
	
	protected String uInvnr; 
	protected String uUserNm;
	protected String uHogi;
	protected String uSysNm;
	protected String uInsLoc;
	protected String uRack;
	protected String uFid;
	protected String uSpv;
	protected String uEquipNm;
	protected String uTagNo;
	protected String uMaterialNo;
	protected String uQGrade;
	protected String uSGrade;
	protected String uSYear;
	protected String uProduct;
	protected String uSupplier;
	protected String uPn;
	protected String uSn;
	protected String uRev;
	protected String uProDate;
	protected String uPo;
	protected String uInDate;
	protected String uInCnt;
	protected String uState;
	protected String uWeakPart;
	protected String uWPartNm;
	protected String uPmNo;
	protected String uPcDate;
	protected String uPcCycle;
	protected String uIctCycle;
	protected String uChgCycle;
	protected String uChkMeth;
	protected String uChkCycle;
	protected String uInsDate;
	protected String uMDate1;
	protected String uMContent1;
	protected String uMBigo1;
	protected String uMDate2;
	protected String uMContent2;
	protected String uMBigo2;
	protected String uMDate3;
	protected String uMContent3;
	protected String uMBigo3;
	protected String uMDate4;
	protected String uMContent4;
	protected String uMBigo4;
	protected String uEDate1;
	protected String uEContent1;
	protected String uEBigo1;
	protected String uEDate2;
	protected String uEContent2;
	protected String uEBigo2;
	protected String uEDate3;
	protected String uEContent3;
	protected String uEBigo3;
	protected String uEDate4;
	protected String uEContent4;
	protected String uEBigo4;
	
	
	//재기동관리
	protected String hogi;
	protected String xyGubun;
	protected String type;
	protected String restartCode;
	protected String descr;
	
	protected String iXYGubun;
	protected String iRestartCode;

	
	
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the userPwd
	 */
	public String getUserPwd() {
		return userPwd;
	}
	/**
	 * @param userPwd the userPwd to set
	 */
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	/**
	 * @return the groupCode
	 */
	public String getGroupCode() {
		return groupCode;
	}
	/**
	 * @param groupCode the groupCode to set
	 */
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	
	/**
	 * @return the groupName
	 */
	public String getGroupName() {
		return groupName;
	}
	/**
	 * @param groupName the groupName to set
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}
	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	/**
	 * @return the useYN
	 */
	public String getUseYN() {
		return useYN;
	}
	/**
	 * @param useYN the useYN to set
	 */
	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}
	
	/**
	 * @return the login
	 */
	public String getLogin() {
		return login;
	}
	/**
	 * @param login the login to set
	 */
	public void setLogin(String login) {
		this.login = login;
	}
	/**
	 * @return the searchKey
	 */
	public String getSearchKey() {
		return searchKey;
	}
	/**
	 * @param searchKey the searchKey to set
	 */
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	/**
	 * @return the searchWord
	 */
	public String getSearchWord() {
		return searchWord;
	}
	/**
	 * @param searchWord the searchWord to set
	 */
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	/**
	 * @return the searchKeys
	 */
	public String[] getSearchKeys() {
		return searchKeys;
	}
	/**
	 * @param searchKeys the searchKeys to set
	 */
	public void setSearchKeys(String[] searchKeys) {
		this.searchKeys = searchKeys;
	}
	/**
	 * @return the searchWords
	 */
	public String[] getSearchWords() {
		return searchWords;
	}
	/**
	 * @param searchWords the searchWords to set
	 */
	public void setSearchWords(String[] searchWords) {
		this.searchWords = searchWords;
	}
	/**
	 * @return the userGroupCode
	 */
	public String getUserGroupCode() {
		return userGroupCode;
	}
	/**
	 * @param userGroupCode the userGroupCode to set
	 */
	public void setUserGroupCode(String userGroupCode) {
		this.userGroupCode = userGroupCode;
	}
	/**
	 * @return the uesrGroupName
	 */
	public String getUserGroupName() {
		return userGroupName;
	}
	/**
	 * @param uesrGroupName the uesrGroupName to set
	 */
	public void setUserGroupName(String userGroupName) {
		this.userGroupName = userGroupName;
	}
		
	/**
	 * @return the logoutUserList
	 */
	public String getLogoutUserList() {
		return logoutUserList;
	}
	/**
	 * @param logoutUserList the logoutUserList to set
	 */
	public void setLogoutUserList(String logoutUserList) {
		this.logoutUserList = logoutUserList;
	}
	/**
	 * @return the grpPageNum
	 */
	public int getGrpPageNum() {
		return grpPageNum;
	}
	/**
	 * @param grpPageNum the grpPageNum to set
	 */
	public void setGrpPageNum(int grpPageNum) {
		this.grpPageNum = grpPageNum;
	}
	/**
	 * @return the grpPageSize
	 */
	public int getGrpPageSize() {
		return grpPageSize;
	}
	/**
	 * @param grpPageSize the grpPageSize to set
	 */
	public void setGrpPageSize(int grpPageSize) {
		this.grpPageSize = grpPageSize;
	}
	/**
	 * @return the grpTotalCnt
	 */
	public int getGrpTotalCnt() {
		return grpTotalCnt;
	}
	/**
	 * @param grpTotalCnt the grpTotalCnt to set
	 */
	public void setGrpTotalCnt(int grpTotalCnt) {
		this.grpTotalCnt = grpTotalCnt;
		this.setGrpTotalPage(this.getGrpTotalPage());
		
		if((this.grpPageNum - 5) <= 0) {
			grpBeginPage = 1;
		}else {
			grpBeginPage = (this.grpPageNum - 5) + 1;
		}
		
		if((this.grpPageNum + 5) > this.getGrpTotalPage()) {
			grpEndPage = this.getGrpTotalPage();
		}else {
			grpEndPage = (this.grpPageNum + 5);
		}	
	}
	/**
	 * @return the grpTotalPage
	 */
	public int getGrpTotalPage() {
		return (this.grpTotalCnt/this.grpPageSize) + 1;
	}
	/**
	 * @param grpTotalPage the grpTotalPage to set
	 */
	public void setGrpTotalPage(int grpTotalPage) {
		this.grpTotalPage = grpTotalPage;
	}
	/**
	 * @return the grpBeginPage
	 */
	public int getGrpBeginPage() {
		return grpBeginPage;
	}
	/**
	 * @param grpBeginPage the grpBeginPage to set
	 */
	public void setGrpBeginPage(int grpBeginPage) {
		this.grpBeginPage = grpBeginPage;
	}
	/**
	 * @return the grpEndPage
	 */
	public int getGrpEndPage() {
		return grpEndPage;
	}
	/**
	 * @param grpEndPage the grpEndPage to set
	 */
	public void setGrpEndPage(int grpEndPage) {
		this.grpEndPage = grpEndPage;
	}
	/**
	 * @return the iId
	 */
	public String getiId() {
		return iId;
	}
	/**
	 * @param iId the iId to set
	 */
	public void setiId(String iId) {
		this.iId = iId;
	}
	/**
	 * @return the iUserName
	 */
	public String getiUserName() {
		return iUserName;
	}
	/**
	 * @param iUserName the iUserName to set
	 */
	public void setiUserName(String iUserName) {
		this.iUserName = iUserName;
	}
	/**
	 * @return the iPwd
	 */
	public String getiPwd() {
		return iPwd;
	}
	/**
	 * @param iPwd the iPwd to set
	 */
	public void setiPwd(String iPwd) {
		this.iPwd = iPwd;
	}
	/**
	 * @return the iGroupCode
	 */
	public String getiGroupCode() {
		return iGroupCode;
	}
	/**
	 * @param iGroupCode the iGroupCode to set
	 */
	public void setiGroupCode(String iGroupCode) {
		this.iGroupCode = iGroupCode;
	}
	/**
	 * @return the iGrade
	 */
	public String getiGrade() {
		return iGrade;
	}
	/**
	 * @param iGrade the iGrade to set
	 */
	public void setiGrade(String iGrade) {
		this.iGrade = iGrade;
	}
	/**
	 * @return the iLoginHogi
	 */
	public String getiLoginHogi() {
		return iLoginHogi;
	}
	/**
	 * @param iLoginHogi the iLoginHogi to set
	 */
	public void setiLoginHogi(String iLoginHogi) {
		this.iLoginHogi = iLoginHogi;
	}
	/**
	 * @return the iEmail
	 */
	public String getiEmail() {
		return iEmail;
	}
	/**
	 * @param iEmail the iEmail to set
	 */
	public void setiEmail(String iEmail) {
		this.iEmail = iEmail;
	}
	/**
	 * @return the iUseYN
	 */
	public String getiUseYN() {
		return iUseYN;
	}
	/**
	 * @param iUseYN the iUseYN to set
	 */
	public void setiUseYN(String iUseYN) {
		this.iUseYN = iUseYN;
	}
	
	/**
	 * @return the uId
	 */
	public String getuId() {
		return uId;
	}
	/**
	 * @param uId the uId to set
	 */
	public void setuId(String uId) {
		this.uId = uId;
	}
	/**
	 * @return the uPwd
	 */
	public String getuPwd() {
		return uPwd;
	}
	/**
	 * @param uPwd the uPwd to set
	 */
	public void setuPwd(String uPwd) {
		this.uPwd = uPwd;
	}
	/**
	 * @return the uLogin
	 */
	public String getuLogin() {
		return uLogin;
	}
	/**
	 * @param uLogin the uLogin to set
	 */
	public void setuLogin(String uLogin) {
		this.uLogin = uLogin;
	}
	/**
	 * @return the uUserIp
	 */
	public String getuUserIp() {
		return uUserIp;
	}
	/**
	 * @param uUserIp the uUserIp to set
	 */
	public void setuUserIp(String uUserIp) {
		this.uUserIp = uUserIp;
	}
	
	public void setuUserIp(HttpServletRequest request) {
		
		String clientIp = null;
	    boolean isIpInHeader = false;

	    List<String> headerList = new ArrayList<>();
	    headerList.add("X-Forwarded-For");
	    headerList.add("HTTP_CLIENT_IP");
	    headerList.add("HTTP_X_FORWARDED_FOR");
	    headerList.add("HTTP_X_FORWARDED");
	    headerList.add("HTTP_FORWARDED_FOR");
	    headerList.add("HTTP_FORWARDED");
	    headerList.add("Proxy-Client-IP");
	    headerList.add("WL-Proxy-Client-IP");
	    headerList.add("HTTP_VIA");    
	    headerList.add("IPV6_ADR");

	    for (String header : headerList) {
	        clientIp = request.getHeader(header);
	        
	        if (StringUtils.hasText(clientIp) && !clientIp.equals("unknown")) {
	            isIpInHeader = true;
	            break;
	        }
	    }

	    if (!isIpInHeader) {
	        clientIp = request.getRemoteAddr();
	    }else {
	    	HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
	    	clientIp = req.getHeader("X-FORWARDED-FOR");
	    }
	    
		this.uUserIp = clientIp;
	}
	
	/**
	 * @return the sIhogi
	 */
	public String getsIhogi() {
		return sIhogi;
	}
	/**
	 * @param sIhogi the sIhogi to set
	 */
	public void setsIhogi(String sIhogi) {
		this.sIhogi = sIhogi;
	}
	/**
	 * @return the sXYGubun
	 */
	public String getsXYGubun() {
		return sXYGubun;
	}
	/**
	 * @param sXYGubun the sXYGubun to set
	 */
	public void setsXYGubun(String sXYGubun) {
		this.sXYGubun = sXYGubun;
	}
	/**
	 * @return the sIOType
	 */
	public String getsIOType() {
		return sIOType;
	}
	/**
	 * @param sIOType the sIOType to set
	 */
	public void setsIOType(String sIOType) {
		this.sIOType = sIOType;
	}
	/**
	 * @return the sAddress
	 */
	public String getsAddress() {
		return sAddress;
	}
	/**
	 * @param sAddress the sAddress to set
	 */
	public void setsAddress(String sAddress) {
		this.sAddress = sAddress;
	}
	/**
	 * @return the pTitle
	 */
	public String getpTitle() {
		return pTitle;
	}
	/**
	 * @param pTitle the pTitle to set
	 */
	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}
	/**
	 * @return the pContents
	 */
	public String getpContents() {
		return pContents;
	}
	/**
	 * @param pContents the pContents to set
	 */
	public void setpContents(String pContents) {
		this.pContents = pContents;
	}
	/**
	 * @return the iPTitle
	 */
	public String getiPTitle() {
		return iPTitle;
	}
	/**
	 * @param iPTitle the iPTitle to set
	 */
	public void setiPTitle(String iPTitle) {
		this.iPTitle = iPTitle;
	}
	/**
	 * @return the iPContents
	 */
	public String getiPContents() {
		return iPContents;
	}
	/**
	 * @param iPContents the iPContents to set
	 */
	public void setiPContents(String iPContents) {
		this.iPContents = iPContents;
	}
	/**
	 * @return the iPUser
	 */
	public String getiPUser() {
		return iPUser;
	}
	/**
	 * @param iPUser the iPUser to set
	 */
	public void setiPuser(String iPUser) {
		this.iPUser = iPUser;
	}
	/**
	 * @return the iWUser
	 */
	public String getiWUser() {
		return iWUser;
	}
	/**
	 * @param iWUser the iWUser to set
	 */
	public void setiWUser(String iWUser) {
		this.iWUser = iWUser;
	}
	
	public void setiPUser(String iPUser) {
		this.iPUser = iPUser;
	}
	/**
	 * @return the invnr
	 */
	public String getInvnr() {
		return invnr;
	}
	/**
	 * @param invnr the invnr to set
	 */
	public void setInvnr(String invnr) {
		this.invnr = invnr;
	}
	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}
	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}
	/**
	 * @return the materialNo
	 */
	public String getMaterialNo() {
		return materialNo;
	}
	/**
	 * @param materialNo the materialNo to set
	 */
	public void setMaterialNo(String materialNo) {
		this.materialNo = materialNo;
	}
	/**
	 * @return the sn
	 */
	public String getSn() {
		return sn;
	}
	/**
	 * @param sn the sn to set
	 */
	public void setSn(String sn) {
		this.sn = sn;
	}
	/**
	 * @return the sysNm
	 */
	public String getSysNm() {
		return sysNm;
	}
	/**
	 * @param sysnm the sysNm to set
	 */
	public void setSysNm(String sysNm) {
		this.sysNm = sysNm;
	}
	/**
	 * @return the rack
	 */
	public String getRack() {
		return rack;
	}
	/**
	 * @param rack the rack to set
	 */
	public void setRack(String rack) {
		this.rack = rack;
	}
	/**
	 * @return the equipNm
	 */
	public String getEquipNm() {
		return equipNm;
	}
	/**
	 * @param equipNm the equipNm to set
	 */
	public void setEquipNm(String equipNm) {
		this.equipNm = equipNm;
	}
	/**
	 * @return the hogi
	 */
	public String getHogi() {
		return hogi;
	}
	/**
	 * @param hogi the hogi to set
	 */
	public void setHogi(String hogi) {
		this.hogi = hogi;
	}
	/**
	 * @return the xyGubun
	 */
	public String getXyGubun() {
		return xyGubun;
	}
	/**
	 * @param xyGubun the xyGubun to set
	 */
	public void setXyGubun(String xyGubun) {
		this.xyGubun = xyGubun;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return the restartCode
	 */
	public String getRestartCode() {
		return restartCode;
	}
	/**
	 * @param restartCode the restartCode to set
	 */
	public void setRestartCode(String restartCode) {
		this.restartCode = restartCode;
	}
	/**
	 * @return the descr
	 */
	public String getDescr() {
		return descr;
	}
	/**
	 * @param descr the descr to set
	 */
	public void setDescr(String descr) {
		this.descr = descr;
	}
	
	/**
	 * @return the seqNo
	 */
	public String getSeqNo() {
		return seqNo;
	}
	/**
	 * @param seqNo the seqNo to set
	 */
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	/**
	 * @return the progName
	 */
	public String getProgName() {
		return progName;
	}
	/**
	 * @param progName the progName to set
	 */
	public void setProgName(String progName) {
		this.progName = progName;
	}
	/**
	 * @return the logNo
	 */
	public String getLogNo() {
		return logNo;
	}
	/**
	 * @param logNo the logNo to set
	 */
	public void setLogNo(String logNo) {
		this.logNo = logNo;
	}
	/**
	 * @return the createDate
	 */
	public String getCreateDate() {
		return createDate;
	}
	/**
	 * @param createDate the createDate to set
	 */
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	/**
	 * @return the fileIdx
	 */
	public String getFileIdx() {
		return fileIdx;
	}
	/**
	 * @param fileIdx the fileIdx to set
	 */
	public void setFileIdx(String fileIdx) {
		this.fileIdx = fileIdx;
	}
	/**
	 * @return the failure
	 */
	public String getFailure() {
		return failure;
	}
	/**
	 * @param failure the failure to set
	 */
	public void setFailure(String failure) {
		this.failure = failure;
	}
	/**
	 * @return the repair
	 */
	public String getRepair() {
		return repair;
	}
	/**
	 * @param repair the repair to set
	 */
	public void setRepair(String repair) {
		this.repair = repair;
	}
	/**
	 * @return the iLogNo
	 */
	public String getiLogNo() {
		return iLogNo;
	}
	/**
	 * @param iLlogNo the iLogNo to set
	 */
	public void setiLogNo(String iLogNo) {
		this.iLogNo = iLogNo;
	}
	/**
	 * @return the iProNo
	 */
	public String getiProNo() {
		return iProNo;
	}
	/**
	 * @param iProNo the iProNo to set
	 */
	public void setiProNo(String iProNo) {
		this.iProNo = iProNo;
	}
	/**
	 * @return the iProgName
	 */
	public String getiProgName() {
		return iProgName;
	}
	/**
	 * @param iProgName the iProgName to set
	 */
	public void setiProgName(String iProgName) {
		this.iProgName = iProgName;
	}
	/**
	 * @return the iDivide
	 */
	public String getiDivide() {
		return iDivide;
	}
	/**
	 * @param iDivide the iDivide to set
	 */
	public void setiDivide(String iDivide) {
		this.iDivide = iDivide;
	}
	/**
	 * @return the iDescr
	 */
	public String getiDescr() {
		return iDescr;
	}
	/**
	 * @param iDescr the iDescr to set
	 */
	public void setiDescr(String iDescr) {
		this.iDescr = iDescr;
	}
	/**
	 * @return the iCreateDate
	 */
	public String getiCreateDate() {
		return iCreateDate;
	}
	/**
	 * @param iCreateDate the iCreateDate to set
	 */
	public void setiCreateDate(String iCreateDate) {
		this.iCreateDate = iCreateDate;
	}
	/**
	 * @return the iHogi
	 */
	public String getiHogi() {
		return iHogi;
	}
	/**
	 * @param iHogi the iHogi to set
	 */
	public void setiHogi(String iHogi) {
		this.iHogi = iHogi;
	}
	/**
	 * @return the iBigo
	 */
	public String getiBigo() {
		return iBigo;
	}
	/**
	 * @param iBigo the iBigo to set
	 */
	public void setiBigo(String iBigo) {
		this.iBigo = iBigo;
	}
	/**
	 * @return the iFileName1
	 */
	public String getiFileName1() {
		return iFileName1;
	}
	/**
	 * @param iFileName1 the iFileName1 to set
	 */
	public void setiFileName1(String iFileName1) {
		this.iFileName1 = iFileName1;
	}
	/**
	 * @return the iFileName2
	 */
	public String getiFileName2() {
		return iFileName2;
	}
	/**
	 * @param iFileName2 the iFileName2 to set
	 */
	public void setiFileName2(String iFileName2) {
		this.iFileName2 = iFileName2;
	}
	/**
	 * @return the iFileName3
	 */
	public String getiFileName3() {
		return iFileName3;
	}
	/**
	 * @param iFileName3 the iFileName3 to set
	 */
	public void setiFileName3(String iFileName3) {
		this.iFileName3 = iFileName3;
	}
	/**
	 * @return the iFileName4
	 */
	public String getiFileName4() {
		return iFileName4;
	}
	/**
	 * @param iFileName4 the iFileName4 to set
	 */
	public void setiFileName4(String iFileName4) {
		this.iFileName4 = iFileName4;
	}
	/**
	 * @return the iFileName5
	 */
	public String getiFileName5() {
		return iFileName5;
	}
	/**
	 * @param iFileName5 the iFileName5 to set
	 */
	public void setiFileName5(String iFileName5) {
		this.iFileName5 = iFileName5;
	}
	/**
	 * @return the iFileName6
	 */
	public String getiFileName6() {
		return iFileName6;
	}
	/**
	 * @param iFileName6 the iFileName6 to set
	 */
	public void setiFileName6(String iFileName6) {
		this.iFileName6 = iFileName6;
	}
	/**
	 * @return the iFileName7
	 */
	public String getiFileName7() {
		return iFileName7;
	}
	/**
	 * @param iFileName7 the iFileName7 to set
	 */
	public void setiFileName7(String iFileName7) {
		this.iFileName7 = iFileName7;
	}
	/**
	 * @return the iFileName8
	 */
	public String getiFileName8() {
		return iFileName8;
	}
	/**
	 * @param iFileName8 the iFileName8 to set
	 */
	public void setiFileName8(String iFileName8) {
		this.iFileName8 = iFileName8;
	}
	/**
	 * @return the iFileName9
	 */
	public String getiFileName9() {
		return iFileName9;
	}
	/**
	 * @param iFileName9 the iFileName9 to set
	 */
	public void setiFileName9(String iFileName9) {
		this.iFileName9 = iFileName9;
	}
	/**
	 * @return the iFileName10
	 */
	public String getiFileName10() {
		return iFileName10;
	}
	/**
	 * @param iFileName10 the iFileName10 to set
	 */
	public void setiFileName10(String iFileName10) {
		this.iFileName10 = iFileName10;
	}
	/**
	 * @return the iType
	 */
	public String getiType() {
		return iType;
	}
	/**
	 * @param iType the iType to set
	 */
	public void setiType(String iType) {
		this.iType = iType;
	}
	/**
	 * @return the iDate
	 */
	public String getiDate() {
		return iDate;
	}
	/**
	 * @param iDate the iDate to set
	 */
	public void setiDate(String iDate) {
		this.iDate = iDate;
	}
	/**
	 * @return the iFailure
	 */
	public String getiFailure() {
		return iFailure;
	}
	/**
	 * @param iFailure the iFailure to set
	 */
	public void setiFailure(String iFailure) {
		this.iFailure = iFailure;
	}
	/**
	 * @return the iRepair
	 */
	public String getiRepair() {
		return iRepair;
	}
	/**
	 * @param iRepair the iRepair to set
	 */
	public void setiRepair(String iRepair) {
		this.iRepair = iRepair;
	}
	/**
	 * @return the iSeqNo
	 */
	public String getiSeqNo() {
		return iSeqNo;
	}
	/**
	 * @param iSeqNo the iSeqNo to set
	 */
	public void setiSeqNo(String iSeqNo) {
		this.iSeqNo = iSeqNo;
	}
	/**
	 * @return the iXYGubun
	 */
	public String getiXYGubun() {
		return iXYGubun;
	}
	/**
	 * @param iXYGubun the iXYGubun to set
	 */
	public void setiXYGubun(String iXYGubun) {
		this.iXYGubun = iXYGubun;
	}
	/**
	 * @return the iRestartCode
	 */
	public String getiRestartCode() {
		return iRestartCode;
	}
	/**
	 * @param iRestartCode the iRestartCode to set
	 */
	public void setiRestartCode(String iRestartCode) {
		this.iRestartCode = iRestartCode;
	}
	/**
	 * @return the intSeqNo
	 */
	public int getIntSeqNo() {
		return intSeqNo;
	}
	/**
	 * @param intSeqNo the intSeqNo to set
	 */
	public void setIntSeqNo(int intSeqNo) {
		this.intSeqNo = intSeqNo;
	}
	/**
	 * @return the iInvnr
	 */
	public String getiInvnr() {
		return iInvnr;
	}
	/**
	 * @param iInvnr the iInvnr to set
	 */
	public void setiInvnr(String iInvnr) {
		this.iInvnr = iInvnr;
	}
	/**
	 * @return the iUserNm
	 */
	public String getiUserNm() {
		return iUserNm;
	}
	/**
	 * @param iUserNm the iUserNm to set
	 */
	public void setiUserNm(String iUserNm) {
		this.iUserNm = iUserNm;
	}
	/**
	 * @return the iSysNm
	 */
	public String getiSysNm() {
		return iSysNm;
	}
	/**
	 * @param iSysNm the iSysNm to set
	 */
	public void setiSysNm(String iSysNm) {
		this.iSysNm = iSysNm;
	}
	/**
	 * @return the iInsLoc
	 */
	public String getiInsLoc() {
		return iInsLoc;
	}
	/**
	 * @param iInsLoc the iInsLoc to set
	 */
	public void setiInsLoc(String iInsLoc) {
		this.iInsLoc = iInsLoc;
	}
	/**
	 * @return the iRack
	 */
	public String getiRack() {
		return iRack;
	}
	/**
	 * @param iRack the iRack to set
	 */
	public void setiRack(String iRack) {
		this.iRack = iRack;
	}
	/**
	 * @return the iFid
	 */
	public String getiFid() {
		return iFid;
	}
	/**
	 * @param iFid the iFid to set
	 */
	public void setiFid(String iFid) {
		this.iFid = iFid;
	}
	/**
	 * @return the iSpv
	 */
	public String getiSpv() {
		return iSpv;
	}
	/**
	 * @param iSpv the iSpv to set
	 */
	public void setiSpv(String iSpv) {
		this.iSpv = iSpv;
	}
	/**
	 * @return the iEquipNm
	 */
	public String getiEquipNm() {
		return iEquipNm;
	}
	/**
	 * @param iEquipNm the iEquipNm to set
	 */
	public void setiEquipNm(String iEquipNm) {
		this.iEquipNm = iEquipNm;
	}
	/**
	 * @return the iTagNo
	 */
	public String getiTagNo() {
		return iTagNo;
	}
	/**
	 * @param iTagNo the iTagNo to set
	 */
	public void setiTagNo(String iTagNo) {
		this.iTagNo = iTagNo;
	}
	/**
	 * @return the iMaterialNo
	 */
	public String getiMaterialNo() {
		return iMaterialNo;
	}
	/**
	 * @param iMaterialNo the iMaterialNo to set
	 */
	public void setiMaterialNo(String iMaterialNo) {
		this.iMaterialNo = iMaterialNo;
	}
	/**
	 * @return the iQGrade
	 */
	public String getiQGrade() {
		return iQGrade;
	}
	/**
	 * @param iQGrade the iQGrade to set
	 */
	public void setiQGrade(String iQGrade) {
		this.iQGrade = iQGrade;
	}
	/**
	 * @return the iSgRade
	 */
	public String getiSgRade() {
		return iSgRade;
	}
	/**
	 * @param iSgRade the iSgRade to set
	 */
	public void setiSgRade(String iSgRade) {
		this.iSgRade = iSgRade;
	}
	/**
	 * @return the iSYear
	 */
	public String getiSYear() {
		return iSYear;
	}
	/**
	 * @param iSYear the iSYear to set
	 */
	public void setiSYear(String iSYear) {
		this.iSYear = iSYear;
	}
	/**
	 * @return the iProduct
	 */
	public String getiProduct() {
		return iProduct;
	}
	/**
	 * @param iProduct the iProduct to set
	 */
	public void setiProduct(String iProduct) {
		this.iProduct = iProduct;
	}
	/**
	 * @return the iSupplier
	 */
	public String getiSupplier() {
		return iSupplier;
	}
	/**
	 * @param iSupplier the iSupplier to set
	 */
	public void setiSupplier(String iSupplier) {
		this.iSupplier = iSupplier;
	}
	/**
	 * @return the iPn
	 */
	public String getiPn() {
		return iPn;
	}
	/**
	 * @param iPn the iPn to set
	 */
	public void setiPn(String iPn) {
		this.iPn = iPn;
	}
	/**
	 * @return the iSn
	 */
	public String getiSn() {
		return iSn;
	}
	/**
	 * @param iSn the iSn to set
	 */
	public void setiSn(String iSn) {
		this.iSn = iSn;
	}
	/**
	 * @return the iRev
	 */
	public String getiRev() {
		return iRev;
	}
	/**
	 * @param iRev the iRev to set
	 */
	public void setiRev(String iRev) {
		this.iRev = iRev;
	}
	/**
	 * @return the iProDate
	 */
	public String getiProDate() {
		return iProDate;
	}
	/**
	 * @param iProDate the iProDate to set
	 */
	public void setiProDate(String iProDate) {
		this.iProDate = iProDate;
	}
	/**
	 * @return the iPo
	 */
	public String getiPo() {
		return iPo;
	}
	/**
	 * @param iPo the iPo to set
	 */
	public void setiPo(String iPo) {
		this.iPo = iPo;
	}
	/**
	 * @return the iInDate
	 */
	public String getiInDate() {
		return iInDate;
	}
	/**
	 * @param iInDate the iInDate to set
	 */
	public void setiInDate(String iInDate) {
		this.iInDate = iInDate;
	}
	/**
	 * @return the iInCnt
	 */
	public String getiInCnt() {
		return iInCnt;
	}
	/**
	 * @param iInCnt the iInCnt to set
	 */
	public void setiInCnt(String iInCnt) {
		this.iInCnt = iInCnt;
	}
	/**
	 * @return the iState
	 */
	public String getiState() {
		return iState;
	}
	/**
	 * @param iState the iState to set
	 */
	public void setiState(String iState) {
		this.iState = iState;
	}
	/**
	 * @return the iWeakPart
	 */
	public String getiWeakPart() {
		return iWeakPart;
	}
	/**
	 * @param iWeakPart the iWeakPart to set
	 */
	public void setiWeakPart(String iWeakPart) {
		this.iWeakPart = iWeakPart;
	}
	/**
	 * @return the iWPartNm
	 */
	public String getiWPartNm() {
		return iWPartNm;
	}
	/**
	 * @param iWPartNm the iWPartNm to set
	 */
	public void setiWPartNm(String iWPartNm) {
		this.iWPartNm = iWPartNm;
	}
	/**
	 * @return the iPmNo
	 */
	public String getiPmNo() {
		return iPmNo;
	}
	/**
	 * @param iPmNo the iPmNo to set
	 */
	public void setiPmNo(String iPmNo) {
		this.iPmNo = iPmNo;
	}
	/**
	 * @return the iPcDate
	 */
	public String getiPcDate() {
		return iPcDate;
	}
	/**
	 * @param iPcDate the iPcDate to set
	 */
	public void setiPcDate(String iPcDate) {
		this.iPcDate = iPcDate;
	}
	/**
	 * @return the iPcCycle
	 */
	public String getiPcCycle() {
		return iPcCycle;
	}
	/**
	 * @param iPcCycle the iPcCycle to set
	 */
	public void setiPcCycle(String iPcCycle) {
		this.iPcCycle = iPcCycle;
	}
	/**
	 * @return the iIctCycle
	 */
	public String getiIctCycle() {
		return iIctCycle;
	}
	/**
	 * @param iIctCycle the iIctCycle to set
	 */
	public void setiIctCycle(String iIctCycle) {
		this.iIctCycle = iIctCycle;
	}
	/**
	 * @return the iChgCycle
	 */
	public String getiChgCycle() {
		return iChgCycle;
	}
	/**
	 * @param iChgCycle the iChgCycle to set
	 */
	public void setiChgCycle(String iChgCycle) {
		this.iChgCycle = iChgCycle;
	}
	/**
	 * @return the iChkMeth
	 */
	public String getiChkMeth() {
		return iChkMeth;
	}
	/**
	 * @param iChkMeth the iChkMeth to set
	 */
	public void setiChkMeth(String iChkMeth) {
		this.iChkMeth = iChkMeth;
	}
	/**
	 * @return the iChkCycle
	 */
	public String getiChkCycle() {
		return iChkCycle;
	}
	/**
	 * @param iChkCycle the iChkCycle to set
	 */
	public void setiChkCycle(String iChkCycle) {
		this.iChkCycle = iChkCycle;
	}
	/**
	 * @return the iInsDate
	 */
	public String getiInsDate() {
		return iInsDate;
	}
	/**
	 * @param iInsDate the iInsDate to set
	 */
	public void setiInsDate(String iInsDate) {
		this.iInsDate = iInsDate;
	}
	/**
	 * @return the iMDate1
	 */
	public String getiMDate1() {
		return iMDate1;
	}
	/**
	 * @param iMDate1 the iMDate1 to set
	 */
	public void setiMDate1(String iMDate1) {
		this.iMDate1 = iMDate1;
	}
	/**
	 * @return the iMContent1
	 */
	public String getiMContent1() {
		return iMContent1;
	}
	/**
	 * @param iMContent1 the iMContent1 to set
	 */
	public void setiMContent1(String iMContent1) {
		this.iMContent1 = iMContent1;
	}
	/**
	 * @return the iMBigo1
	 */
	public String getiMBigo1() {
		return iMBigo1;
	}
	/**
	 * @param iMBigo1 the iMBigo1 to set
	 */
	public void setiMBigo1(String iMBigo1) {
		this.iMBigo1 = iMBigo1;
	}
	/**
	 * @return the iMDate2
	 */
	public String getiMDate2() {
		return iMDate2;
	}
	/**
	 * @param iMDate2 the iMDate2 to set
	 */
	public void setiMDate2(String iMDate2) {
		this.iMDate2 = iMDate2;
	}
	/**
	 * @return the iMContent2
	 */
	public String getiMContent2() {
		return iMContent2;
	}
	/**
	 * @param iMContent2 the iMContent2 to set
	 */
	public void setiMContent2(String iMContent2) {
		this.iMContent2 = iMContent2;
	}
	/**
	 * @return the iMBigo2
	 */
	public String getiMBigo2() {
		return iMBigo2;
	}
	/**
	 * @param iMBigo2 the iMBigo2 to set
	 */
	public void setiMBigo2(String iMBigo2) {
		this.iMBigo2 = iMBigo2;
	}
	/**
	 * @return the iMDate3
	 */
	public String getiMDate3() {
		return iMDate3;
	}
	/**
	 * @param iMDate3 the iMDate3 to set
	 */
	public void setiMDate3(String iMDate3) {
		this.iMDate3 = iMDate3;
	}
	/**
	 * @return the iMContent3
	 */
	public String getiMContent3() {
		return iMContent3;
	}
	/**
	 * @param iMContent3 the iMContent3 to set
	 */
	public void setiMContent3(String iMContent3) {
		this.iMContent3 = iMContent3;
	}
	/**
	 * @return the iMBigo3
	 */
	public String getiMBigo3() {
		return iMBigo3;
	}
	/**
	 * @param iMBigo3 the iMBigo3 to set
	 */
	public void setiMBigo3(String iMBigo3) {
		this.iMBigo3 = iMBigo3;
	}
	/**
	 * @return the iMDate4
	 */
	public String getiMDate4() {
		return iMDate4;
	}
	/**
	 * @param iMDate4 the iMDate4 to set
	 */
	public void setiMDate4(String iMDate4) {
		this.iMDate4 = iMDate4;
	}
	/**
	 * @return the iMContent4
	 */
	public String getiMContent4() {
		return iMContent4;
	}
	/**
	 * @param iMContent4 the iMContent4 to set
	 */
	public void setiMContent4(String iMContent4) {
		this.iMContent4 = iMContent4;
	}
	/**
	 * @return the iMBigo4
	 */
	public String getiMBigo4() {
		return iMBigo4;
	}
	/**
	 * @param iMBigo4 the iMBigo4 to set
	 */
	public void setiMBigo4(String iMBigo4) {
		this.iMBigo4 = iMBigo4;
	}
	/**
	 * @return the iEDate1
	 */
	public String getiEDate1() {
		return iEDate1;
	}
	/**
	 * @param iEDate1 the iEDate1 to set
	 */
	public void setiEDate1(String iEDate1) {
		this.iEDate1 = iEDate1;
	}
	/**
	 * @return the iEContent1
	 */
	public String getiEContent1() {
		return iEContent1;
	}
	/**
	 * @param iEContent1 the iEContent1 to set
	 */
	public void setiEContent1(String iEContent1) {
		this.iEContent1 = iEContent1;
	}
	/**
	 * @return the iEBigo1
	 */
	public String getiEBigo1() {
		return iEBigo1;
	}
	/**
	 * @param iEBigo1 the iEBigo1 to set
	 */
	public void setiEBigo1(String iEBigo1) {
		this.iEBigo1 = iEBigo1;
	}
	/**
	 * @return the iEDate2
	 */
	public String getiEDate2() {
		return iEDate2;
	}
	/**
	 * @param iEDate2 the iEDate2 to set
	 */
	public void setiEDate2(String iEDate2) {
		this.iEDate2 = iEDate2;
	}
	/**
	 * @return the iEContent2
	 */
	public String getiEContent2() {
		return iEContent2;
	}
	/**
	 * @param iEContent2 the iEContent2 to set
	 */
	public void setiEContent2(String iEContent2) {
		this.iEContent2 = iEContent2;
	}
	/**
	 * @return the iEBigo2
	 */
	public String getiEBigo2() {
		return iEBigo2;
	}
	/**
	 * @param iEBigo2 the iEBigo2 to set
	 */
	public void setiEBigo2(String iEBigo2) {
		this.iEBigo2 = iEBigo2;
	}
	/**
	 * @return the iEDate3
	 */
	public String getiEDate3() {
		return iEDate3;
	}
	/**
	 * @param iEDate3 the iEDate3 to set
	 */
	public void setiEDate3(String iEDate3) {
		this.iEDate3 = iEDate3;
	}
	/**
	 * @return the iEContent3
	 */
	public String getiEContent3() {
		return iEContent3;
	}
	/**
	 * @param iEContent3 the iEContent3 to set
	 */
	public void setiEContent3(String iEContent3) {
		this.iEContent3 = iEContent3;
	}
	/**
	 * @return the iEBigo3
	 */
	public String getiEBigo3() {
		return iEBigo3;
	}
	/**
	 * @param iEBigo3 the iEBigo3 to set
	 */
	public void setiEBigo3(String iEBigo3) {
		this.iEBigo3 = iEBigo3;
	}
	/**
	 * @return the iEDate4
	 */
	public String getiEDate4() {
		return iEDate4;
	}
	/**
	 * @param iEDate4 the iEDate4 to set
	 */
	public void setiEDate4(String iEDate4) {
		this.iEDate4 = iEDate4;
	}
	/**
	 * @return the iEContent4
	 */
	public String getiEContent4() {
		return iEContent4;
	}
	/**
	 * @param iEContent4 the iEContent4 to set
	 */
	public void setiEContent4(String iEContent4) {
		this.iEContent4 = iEContent4;
	}
	/**
	 * @return the iEBigo4
	 */
	public String getiEBigo4() {
		return iEBigo4;
	}
	/**
	 * @param iEBigo4 the iEBigo4 to set
	 */
	public void setiEBigo4(String iEBigo4) {
		this.iEBigo4 = iEBigo4;
	}
	/**
	 * @return the uInvnr
	 */
	public String getuInvnr() {
		return uInvnr;
	}
	/**
	 * @param uInvnr the uInvnr to set
	 */
	public void setuInvnr(String uInvnr) {
		this.uInvnr = uInvnr;
	}
	/**
	 * @return the uUserNm
	 */
	public String getuUserNm() {
		return uUserNm;
	}
	/**
	 * @param uUserNm the uUserNm to set
	 */
	public void setuUserNm(String uUserNm) {
		this.uUserNm = uUserNm;
	}
	/**
	 * @return the uHogi
	 */
	public String getuHogi() {
		return uHogi;
	}
	/**
	 * @param uHogi the uHogi to set
	 */
	public void setuHogi(String uHogi) {
		this.uHogi = uHogi;
	}
	/**
	 * @return the uSysNm
	 */
	public String getuSysNm() {
		return uSysNm;
	}
	/**
	 * @param uSysNm the uSysNm to set
	 */
	public void setuSysNm(String uSysNm) {
		this.uSysNm = uSysNm;
	}
	/**
	 * @return the uInsLoc
	 */
	public String getuInsLoc() {
		return uInsLoc;
	}
	/**
	 * @param uInsLoc the uInsLoc to set
	 */
	public void setuInsLoc(String uInsLoc) {
		this.uInsLoc = uInsLoc;
	}
	/**
	 * @return the uRack
	 */
	public String getuRack() {
		return uRack;
	}
	/**
	 * @param uRack the uRack to set
	 */
	public void setuRack(String uRack) {
		this.uRack = uRack;
	}
	/**
	 * @return the uFid
	 */
	public String getuFid() {
		return uFid;
	}
	/**
	 * @param uFid the uFid to set
	 */
	public void setuFid(String uFid) {
		this.uFid = uFid;
	}
	/**
	 * @return the uSpv
	 */
	public String getuSpv() {
		return uSpv;
	}
	/**
	 * @param uSpv the uSpv to set
	 */
	public void setuSpv(String uSpv) {
		this.uSpv = uSpv;
	}
	/**
	 * @return the uEquipNm
	 */
	public String getuEquipNm() {
		return uEquipNm;
	}
	/**
	 * @param uEquipNm the uEquipNm to set
	 */
	public void setuEquipNm(String uEquipNm) {
		this.uEquipNm = uEquipNm;
	}
	/**
	 * @return the uTagNo
	 */
	public String getuTagNo() {
		return uTagNo;
	}
	/**
	 * @param uTagNo the uTagNo to set
	 */
	public void setuTagNo(String uTagNo) {
		this.uTagNo = uTagNo;
	}
	/**
	 * @return the uMaterialNo
	 */
	public String getuMaterialNo() {
		return uMaterialNo;
	}
	/**
	 * @param uMaterialNo the uMaterialNo to set
	 */
	public void setuMaterialNo(String uMaterialNo) {
		this.uMaterialNo = uMaterialNo;
	}
	/**
	 * @return the uQGrade
	 */
	public String getuQGrade() {
		return uQGrade;
	}
	/**
	 * @param uQGrade the uQGrade to set
	 */
	public void setuQGrade(String uQGrade) {
		this.uQGrade = uQGrade;
	}
	/**
	 * @return the uSGrade
	 */
	public String getuSGrade() {
		return uSGrade;
	}
	/**
	 * @param uSGrade the uSGrade to set
	 */
	public void setuSGrade(String uSGrade) {
		this.uSGrade = uSGrade;
	}
	/**
	 * @return the uSYear
	 */
	public String getuSYear() {
		return uSYear;
	}
	/**
	 * @param uSYear the uSYear to set
	 */
	public void setuSYear(String uSYear) {
		this.uSYear = uSYear;
	}
	/**
	 * @return the uProduct
	 */
	public String getuProduct() {
		return uProduct;
	}
	/**
	 * @param uProduct the uProduct to set
	 */
	public void setuProduct(String uProduct) {
		this.uProduct = uProduct;
	}
	/**
	 * @return the uSupplier
	 */
	public String getuSupplier() {
		return uSupplier;
	}
	/**
	 * @param uSupplier the uSupplier to set
	 */
	public void setuSupplier(String uSupplier) {
		this.uSupplier = uSupplier;
	}
	/**
	 * @return the uPn
	 */
	public String getuPn() {
		return uPn;
	}
	/**
	 * @param uPn the uPn to set
	 */
	public void setuPn(String uPn) {
		this.uPn = uPn;
	}
	/**
	 * @return the uSn
	 */
	public String getuSn() {
		return uSn;
	}
	/**
	 * @param uSn the uSn to set
	 */
	public void setuSn(String uSn) {
		this.uSn = uSn;
	}
	/**
	 * @return the uRev
	 */
	public String getuRev() {
		return uRev;
	}
	/**
	 * @param uRev the uRev to set
	 */
	public void setuRev(String uRev) {
		this.uRev = uRev;
	}
	/**
	 * @return the uProDate
	 */
	public String getuProDate() {
		return uProDate;
	}
	/**
	 * @param uProDate the uProDate to set
	 */
	public void setuProDate(String uProDate) {
		this.uProDate = uProDate;
	}
	/**
	 * @return the uPo
	 */
	public String getuPo() {
		return uPo;
	}
	/**
	 * @param uPo the uPo to set
	 */
	public void setuPo(String uPo) {
		this.uPo = uPo;
	}
	/**
	 * @return the uInDate
	 */
	public String getuInDate() {
		return uInDate;
	}
	/**
	 * @param uInDate the uInDate to set
	 */
	public void setuInDate(String uInDate) {
		this.uInDate = uInDate;
	}
	/**
	 * @return the uInCnt
	 */
	public String getuInCnt() {
		return uInCnt;
	}
	/**
	 * @param uInCnt the uInCnt to set
	 */
	public void setuInCnt(String uInCnt) {
		this.uInCnt = uInCnt;
	}
	/**
	 * @return the uState
	 */
	public String getuState() {
		return uState;
	}
	/**
	 * @param uState the uState to set
	 */
	public void setuState(String uState) {
		this.uState = uState;
	}
	/**
	 * @return the uWeakPart
	 */
	public String getuWeakPart() {
		return uWeakPart;
	}
	/**
	 * @param uWeakPart the uWeakPart to set
	 */
	public void setuWeakPart(String uWeakPart) {
		this.uWeakPart = uWeakPart;
	}
	/**
	 * @return the uWPartNm
	 */
	public String getuWPartNm() {
		return uWPartNm;
	}
	/**
	 * @param uWPartNm the uWPartNm to set
	 */
	public void setuWPartNm(String uWPartNm) {
		this.uWPartNm = uWPartNm;
	}
	/**
	 * @return the uPmNo
	 */
	public String getuPmNo() {
		return uPmNo;
	}
	/**
	 * @param uPmNo the uPmNo to set
	 */
	public void setuPmNo(String uPmNo) {
		this.uPmNo = uPmNo;
	}
	/**
	 * @return the uPcDate
	 */
	public String getuPcDate() {
		return uPcDate;
	}
	/**
	 * @param uPcDate the uPcDate to set
	 */
	public void setuPcDate(String uPcDate) {
		this.uPcDate = uPcDate;
	}
	/**
	 * @return the uPcCycle
	 */
	public String getuPcCycle() {
		return uPcCycle;
	}
	/**
	 * @param uPcCycle the uPcCycle to set
	 */
	public void setuPcCycle(String uPcCycle) {
		this.uPcCycle = uPcCycle;
	}
	/**
	 * @return the uIctCycle
	 */
	public String getuIctCycle() {
		return uIctCycle;
	}
	/**
	 * @param uIctCycle the uIctCycle to set
	 */
	public void setuIctCycle(String uIctCycle) {
		this.uIctCycle = uIctCycle;
	}
	/**
	 * @return the uChgCycle
	 */
	public String getuChgCycle() {
		return uChgCycle;
	}
	/**
	 * @param uChgCycle the uChgCycle to set
	 */
	public void setuChgCycle(String uChgCycle) {
		this.uChgCycle = uChgCycle;
	}
	/**
	 * @return the uChkMeth
	 */
	public String getuChkMeth() {
		return uChkMeth;
	}
	/**
	 * @param uChkMeth the uChkMeth to set
	 */
	public void setuChkMeth(String uChkMeth) {
		this.uChkMeth = uChkMeth;
	}
	/**
	 * @return the uChkCycle
	 */
	public String getuChkCycle() {
		return uChkCycle;
	}
	/**
	 * @param uChkCycle the uChkCycle to set
	 */
	public void setuChkCycle(String uChkCycle) {
		this.uChkCycle = uChkCycle;
	}
	/**
	 * @return the uInsDate
	 */
	public String getuInsDate() {
		return uInsDate;
	}
	/**
	 * @param uInsDate the uInsDate to set
	 */
	public void setuInsDate(String uInsDate) {
		this.uInsDate = uInsDate;
	}
	/**
	 * @return the uMDate1
	 */
	public String getuMDate1() {
		return uMDate1;
	}
	/**
	 * @param uMDate1 the uMDate1 to set
	 */
	public void setuMDate1(String uMDate1) {
		this.uMDate1 = uMDate1;
	}
	/**
	 * @return the uMContent1
	 */
	public String getuMContent1() {
		return uMContent1;
	}
	/**
	 * @param uMContent1 the uMContent1 to set
	 */
	public void setuMContent1(String uMContent1) {
		this.uMContent1 = uMContent1;
	}
	/**
	 * @return the uMBigo1
	 */
	public String getuMBigo1() {
		return uMBigo1;
	}
	/**
	 * @param uMBigo1 the uMBigo1 to set
	 */
	public void setuMBigo1(String uMBigo1) {
		this.uMBigo1 = uMBigo1;
	}
	/**
	 * @return the uMDate2
	 */
	public String getuMDate2() {
		return uMDate2;
	}
	/**
	 * @param uMDate2 the uMDate2 to set
	 */
	public void setuMDate2(String uMDate2) {
		this.uMDate2 = uMDate2;
	}
	/**
	 * @return the uMContent2
	 */
	public String getuMContent2() {
		return uMContent2;
	}
	/**
	 * @param uMContent2 the uMContent2 to set
	 */
	public void setuMContent2(String uMContent2) {
		this.uMContent2 = uMContent2;
	}
	/**
	 * @return the uMBigo2
	 */
	public String getuMBigo2() {
		return uMBigo2;
	}
	/**
	 * @param uMBigo2 the uMBigo2 to set
	 */
	public void setuMBigo2(String uMBigo2) {
		this.uMBigo2 = uMBigo2;
	}
	/**
	 * @return the uMDate3
	 */
	public String getuMDate3() {
		return uMDate3;
	}
	/**
	 * @param uMDate3 the uMDate3 to set
	 */
	public void setuMDate3(String uMDate3) {
		this.uMDate3 = uMDate3;
	}
	/**
	 * @return the uMContent3
	 */
	public String getuMContent3() {
		return uMContent3;
	}
	/**
	 * @param uMContent3 the uMContent3 to set
	 */
	public void setuMContent3(String uMContent3) {
		this.uMContent3 = uMContent3;
	}
	/**
	 * @return the uMBigo3
	 */
	public String getuMBigo3() {
		return uMBigo3;
	}
	/**
	 * @param uMBigo3 the uMBigo3 to set
	 */
	public void setuMBigo3(String uMBigo3) {
		this.uMBigo3 = uMBigo3;
	}
	/**
	 * @return the uMDate4
	 */
	public String getuMDate4() {
		return uMDate4;
	}
	/**
	 * @param uMDate4 the uMDate4 to set
	 */
	public void setuMDate4(String uMDate4) {
		this.uMDate4 = uMDate4;
	}
	/**
	 * @return the uMContent4
	 */
	public String getuMContent4() {
		return uMContent4;
	}
	/**
	 * @param uMContent4 the uMContent4 to set
	 */
	public void setuMContent4(String uMContent4) {
		this.uMContent4 = uMContent4;
	}
	/**
	 * @return the uMBigo4
	 */
	public String getuMBigo4() {
		return uMBigo4;
	}
	/**
	 * @param uMBigo4 the uMBigo4 to set
	 */
	public void setuMBigo4(String uMBigo4) {
		this.uMBigo4 = uMBigo4;
	}
	/**
	 * @return the uEDate1
	 */
	public String getuEDate1() {
		return uEDate1;
	}
	/**
	 * @param uEDate1 the uEDate1 to set
	 */
	public void setuEDate1(String uEDate1) {
		this.uEDate1 = uEDate1;
	}
	/**
	 * @return the uEContent1
	 */
	public String getuEContent1() {
		return uEContent1;
	}
	/**
	 * @param uEContent1 the uEContent1 to set
	 */
	public void setuEContent1(String uEContent1) {
		this.uEContent1 = uEContent1;
	}
	/**
	 * @return the uEBigo1
	 */
	public String getuEBigo1() {
		return uEBigo1;
	}
	/**
	 * @param uEBigo1 the uEBigo1 to set
	 */
	public void setuEBigo1(String uEBigo1) {
		this.uEBigo1 = uEBigo1;
	}
	/**
	 * @return the uEDate2
	 */
	public String getuEDate2() {
		return uEDate2;
	}
	/**
	 * @param uEDate2 the uEDate2 to set
	 */
	public void setuEDate2(String uEDate2) {
		this.uEDate2 = uEDate2;
	}
	/**
	 * @return the uEContent2
	 */
	public String getuEContent2() {
		return uEContent2;
	}
	/**
	 * @param uEContent2 the uEContent2 to set
	 */
	public void setuEContent2(String uEContent2) {
		this.uEContent2 = uEContent2;
	}
	/**
	 * @return the uEBigo2
	 */
	public String getuEBigo2() {
		return uEBigo2;
	}
	/**
	 * @param uEBigo2 the uEBigo2 to set
	 */
	public void setuEBigo2(String uEBigo2) {
		this.uEBigo2 = uEBigo2;
	}
	/**
	 * @return the uEDate3
	 */
	public String getuEDate3() {
		return uEDate3;
	}
	/**
	 * @param uEDate3 the uEDate3 to set
	 */
	public void setuEDate3(String uEDate3) {
		this.uEDate3 = uEDate3;
	}
	/**
	 * @return the uEContent3
	 */
	public String getuEContent3() {
		return uEContent3;
	}
	/**
	 * @param uEContent3 the uEContent3 to set
	 */
	public void setuEContent3(String uEContent3) {
		this.uEContent3 = uEContent3;
	}
	/**
	 * @return the uEBigo3
	 */
	public String getuEBigo3() {
		return uEBigo3;
	}
	/**
	 * @param uEBigo3 the uEBigo3 to set
	 */
	public void setuEBigo3(String uEBigo3) {
		this.uEBigo3 = uEBigo3;
	}
	/**
	 * @return the uEDate4
	 */
	public String getuEDate4() {
		return uEDate4;
	}
	/**
	 * @param uEDate4 the uEDate4 to set
	 */
	public void setuEDate4(String uEDate4) {
		this.uEDate4 = uEDate4;
	}
	/**
	 * @return the uEContent4
	 */
	public String getuEContent4() {
		return uEContent4;
	}
	/**
	 * @param uEContent4 the uEContent4 to set
	 */
	public void setuEContent4(String uEContent4) {
		this.uEContent4 = uEContent4;
	}
	/**
	 * @return the uEBigo4
	 */
	public String getuEBigo4() {
		return uEBigo4;
	}
	/**
	 * @param uEBigo4 the uEBigo4 to set
	 */
	public void setuEBigo4(String uEBigo4) {
		this.uEBigo4 = uEBigo4;
	}
	
	
}
