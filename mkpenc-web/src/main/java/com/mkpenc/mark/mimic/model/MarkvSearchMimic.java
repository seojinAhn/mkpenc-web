package com.mkpenc.mark.mimic.model;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class MarkvSearchMimic  extends BaseSearch {
	
	private String sGrpID;
	private String sMenuNo;
	private String sDive;
	private String sUGrpNo;
	private String sSeq;
	private String sGrpNo;
	private String sIOType;
	private String sHogi;
	private String sXYGubun;
	private String sChkHogi;
	private String sScreenId;
	private String sTagNo;
	
	private String hogiHeader;
	private String xyHeader;
	
	private String chkXy;
	private String iSeq;
	private String ySeq;
	private String grpId;
	private String menuNo;
	private String grpNo;
	private String hogi;
	private String xyGubun;
	private String tagNo;
	private String gubun;
	
	private String searchStr;
	private String txtHogi;
	private String txtXyGubun;
	private String txtDescr;
	private String txtIoType;
	private String txtAddress;
	private String txtIoBit;
    private String txtOptVal;
    private String txtCboCode;
    private String txtCboDesc;
    private String txtD0;
    private String txtD1;
    private String txtBSCal;
    
    
	private String findAll;
	
	private String findData;
	private String chkOpt0;
	private String chkOpt1;
	
	private String rUrl;
	
	private int comboCnt = 0;
	
	public int getComboCnt() {
		return comboCnt;
	}
	public void setComboCnt(int comboCnt) {
		this.comboCnt = comboCnt;
	}
	public String getsSeq() {
		return sSeq;
	}
	public void setsSeq(String sSeq) {
		this.sSeq = sSeq;
	}
	public String getsGrpNo() {
		return sGrpNo;
	}
	public void setsGrpNo(String sGrpNo) {
		this.sGrpNo = sGrpNo;
	}
	public String getsIOType() {
		return sIOType;
	}
	public void setsIOType(String sIOType) {
		this.sIOType = sIOType;
	}
	public String getsTagNo() {
		return sTagNo;
	}
	public void setsTagNo(String sTagNo) {
		this.sTagNo = sTagNo;
	}
	public String getTxtOptVal() {
		return txtOptVal;
	}
	public void setTxtOptVal(String txtOptVal) {
		this.txtOptVal = txtOptVal;
	}
	public String getTxtCboCode() {
		return txtCboCode;
	}
	public void setTxtCboCode(String txtCboCode) {
		this.txtCboCode = txtCboCode;
	}
	public String getTxtCboDesc() {
		return txtCboDesc;
	}
	public void setTxtCboDesc(String txtCboDesc) {
		this.txtCboDesc = txtCboDesc;
	}
	public String getTxtD0() {
		return txtD0;
	}
	public void setTxtD0(String txtD0) {
		this.txtD0 = txtD0;
	}
	public String getTxtD1() {
		return txtD1;
	}
	public void setTxtD1(String txtD1) {
		this.txtD1 = txtD1;
	}
	public String getTxtBSCal() {
		return txtBSCal;
	}
	public void setTxtBSCal(String txtBSCal) {
		this.txtBSCal = txtBSCal;
	}
	public String getFindData() {
		return findData;
	}
	public void setFindData(String findData) {
		this.findData = findData;
	}
	public String getChkOpt0() {
		return chkOpt0;
	}
	public void setChkOpt0(String chkOpt0) {
		this.chkOpt0 = chkOpt0;
	}
	public String getChkOpt1() {
		return chkOpt1;
	}
	public void setChkOpt1(String chkOpt1) {
		this.chkOpt1 = chkOpt1;
	}
	public String getrUrl() {
		return rUrl;
	}
	public void setrUrl(String rUrl) {
		this.rUrl = rUrl;
	}
	public String getsGrpID() {
		return sGrpID;
	}
	public void setsGrpID(String sGrpID) {
		this.sGrpID = sGrpID;
	}
	public String getsMenuNo() {
		return sMenuNo;
	}
	public void setsMenuNo(String sMenuNo) {
		this.sMenuNo = sMenuNo;
	}
	public String getsDive() {
		return sDive;
	}
	public void setsDive(String sDive) {
		this.sDive = sDive;
	}
	public String getsUGrpNo() {
		return sUGrpNo;
	}
	public void setsUGrpNo(String sUGrpNo) {
		this.sUGrpNo = sUGrpNo;
	}
	public String getsHogi() {
		return sHogi;
	}
	public void setsHogi(String sHogi) {
		this.sHogi = sHogi;
	}
	public String getsXYGubun() {
		return sXYGubun;
	}
	public void setsXYGubun(String sXYGubun) {
		this.sXYGubun = sXYGubun;
	}
	public String getsChkHogi() {
		return sChkHogi;
	}
	public void setsChkHogi(String sChkHogi) {
		this.sChkHogi = sChkHogi;
	}
	public String getsScreenId() {
		return sScreenId;
	}
	public void setsScreenId(String sScreenId) {
		this.sScreenId = sScreenId;
	}
	public String getHogiHeader() {
		return hogiHeader;
	}
	public void setHogiHeader(String hogiHeader) {
		this.hogiHeader = hogiHeader;
	}
	public String getXyHeader() {
		return xyHeader;
	}
	public void setXyHeader(String xyHeader) {
		this.xyHeader = xyHeader;
	}
	public String getChkXy() {
		return chkXy;
	}
	public void setChkXy(String chkXy) {
		this.chkXy = chkXy;
	}
	public String getiSeq() {
		return iSeq;
	}
	public void setiSeq(String iSeq) {
		this.iSeq = iSeq;
	}
	public String getySeq() {
		return ySeq;
	}
	public void setySeq(String ySeq) {
		this.ySeq = ySeq;
	}
	public String getGrpId() {
		return grpId;
	}
	public void setGrpId(String grpId) {
		this.grpId = grpId;
	}
	public String getMenuNo() {
		return menuNo;
	}
	public void setMenuNo(String menuNo) {
		this.menuNo = menuNo;
	}
	public String getGrpNo() {
		return grpNo;
	}
	public void setGrpNo(String grpNo) {
		this.grpNo = grpNo;
	}
	public String getHogi() {
		return hogi;
	}
	public void setHogi(String hogi) {
		this.hogi = hogi;
	}
	public String getXyGubun() {
		return xyGubun;
	}
	public void setXyGubun(String xyGubun) {
		this.xyGubun = xyGubun;
	}
	public String getTagNo() {
		return tagNo;
	}
	public void setTagNo(String tagNo) {
		this.tagNo = tagNo;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getTxtHogi() {
		return txtHogi;
	}
	public void setTxtHogi(String txtHogi) {
		this.txtHogi = txtHogi;
	}
	public String getTxtXyGubun() {
		return txtXyGubun;
	}
	public void setTxtXyGubun(String txtXyGubun) {
		this.txtXyGubun = txtXyGubun;
	}
	public String getTxtDescr() {
		return txtDescr;
	}
	public void setTxtDescr(String txtDescr) {
		this.txtDescr = txtDescr;
	}
	public String getTxtIoType() {
		return txtIoType;
	}
	public void setTxtIoType(String txtIoType) {
		this.txtIoType = txtIoType;
	}
	public String getTxtAddress() {
		return txtAddress;
	}
	public void setTxtAddress(String txtAddress) {
		this.txtAddress = txtAddress;
	}
	public String getTxtIoBit() {
		return txtIoBit;
	}
	public void setTxtIoBit(String txtIoBit) {
		this.txtIoBit = txtIoBit;
	}
	public String getSearchStr() {
		return searchStr;
	}
	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}
	public String getFindAll() {
		return findAll;
	}
	public void setFindAll(String findAll) {
		this.findAll = findAll;
	}
}
