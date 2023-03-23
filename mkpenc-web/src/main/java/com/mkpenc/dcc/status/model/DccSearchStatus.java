package com.mkpenc.dcc.status.model;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class DccSearchStatus   extends BaseSearch {
	private String hogiHeader;
	private String xyHeader;

	private String userId;
	private String userIp;
	private String hogi;
	private String id;

	private String xyGubun;

	private String grpId;
	private String menuNo;
	private String grpNo;
	private String tblNo;
	
	private String scanTime;
	
	private String startDate;
	
	private String chkXy;
	private String iSeq;
	private String ySeq;
	private String tagNo;
	private String gubun;
	
	private String txtHogi;
	private String txtXyGubun;
	private String txtDescr;
	private String txtIoType;
	private String txtAddress;
	private String txtIoBit;
	
	private String searchStr;
	private String chkOpt1;
	private String chkOpt2;
	private String findAll;

	/**
	 * @return the hogiHeader3
	 */
	public String getHogiHeader() {
		return hogiHeader;
	}

	/**
	 * @param hogiHeader3 the hogiHeader3 to set
	 */
	public void setHogiHeader(String hogiHeader) {
		this.hogiHeader = hogiHeader;
	}

	/**
	 * @return the xyHeader
	 */
	public String getXyHeader() {
		return xyHeader;
	}

	/**
	 * @param xyHeader the xyHeader to set
	 */
	public void setXyHeader(String xyHeader) {
		this.xyHeader = xyHeader;
	}

	/**
	 * @return the userIp
	 */
	public String getUserIp() {
		return userIp;
	}

	/**
	 * @param userIp the userIp to set
	 */
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * @param userId the userIp to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
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
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
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
	 * @return the grpId
	 */
	public String getGrpId() {
		return grpId;
	}

	/**
	 * @param grpId the grpId to set
	 */
	public void setGrpId(String grpId) {
		this.grpId = grpId;
	}
	
	/**
	 * @return the menuNo
	 */
	public String getMenuNo() {
		return menuNo;
	}

	/**
	 * @param menuNo the menuNo to set
	 */
	public void setMenuNo(String menuNo) {
		this.menuNo = menuNo;
	}

	/**
	 * @return the grpNo
	 */
	public String getGrpNo() {
		return grpNo;
	}

	/**
	 * @return the tblNo
	 */
	public String getTblNo() {
		return tblNo;
	}

	/**
	 * @param tblNo the tblNo to set
	 */
	public void setTblNo(String tblNo) {
		this.tblNo = tblNo;
	}

	/**
	 * @param grpNo the grpNo to set
	 */
	public void setGrpNo(String grpNo) {
		this.grpNo = grpNo;
	}

	/**
	 * @return the scanTime
	 */
	public String getScanTime() {
		return scanTime;
	}

	/**
	 * @param scanTime the scanTime to set
	 */
	public void setScanTime(String scanTime) {
		this.scanTime = scanTime;
	}

	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * @return the chkXy
	 */
	public String getChkXy() {
		return chkXy;
	}

	/**
	 * @param chkXy the chkXy to set
	 */
	public void setChkXy(String chkXy) {
		this.chkXy = chkXy;
	}

	/**
	 * @return the iSeq
	 */
	public String getiSeq() {
		return iSeq;
	}

	/**
	 * @param iSeq the iSeq to set
	 */
	public void setiSeq(String iSeq) {
		this.iSeq = iSeq;
	}

	/**
	 * @return the ySeq
	 */
	public String getySeq() {
		return ySeq;
	}

	/**
	 * @param ySeq the ySeq to set
	 */
	public void setySeq(String ySeq) {
		this.ySeq = ySeq;
	}

	/**
	 * @return the tagNo
	 */
	public String getTagNo() {
		return tagNo;
	}

	/**
	 * @param tagNo the tagNo to set
	 */
	public void setTagNo(String tagNo) {
		this.tagNo = tagNo;
	}

	/**
	 * @return the gubun
	 */
	public String getGubun() {
		return gubun;
	}

	/**
	 * @param gubun the gubun to set
	 */
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	/**
	 * @return the txtHogi
	 */
	public String getTxtHogi() {
		return txtHogi;
	}

	/**
	 * @param txtHogi the txtHogi to set
	 */
	public void setTxtHogi(String txtHogi) {
		this.txtHogi = txtHogi;
	}

	/**
	 * @return the txtXyGubun
	 */
	public String getTxtXyGubun() {
		return txtXyGubun;
	}

	/**
	 * @param txtXyGubun the txtXyGubun to set
	 */
	public void setTxtXyGubun(String txtXyGubun) {
		this.txtXyGubun = txtXyGubun;
	}

	/**
	 * @return the txtDescr
	 */
	public String getTxtDescr() {
		return txtDescr;
	}

	/**
	 * @param txtDescr the txtDescr to set
	 */
	public void setTxtDescr(String txtDescr) {
		this.txtDescr = txtDescr;
	}

	/**
	 * @return the txtIoType
	 */
	public String getTxtIoType() {
		return txtIoType;
	}

	/**
	 * @param txtIoType the txtIoType to set
	 */
	public void setTxtIoType(String txtIoType) {
		this.txtIoType = txtIoType;
	}

	/**
	 * @return the txtAddresss
	 */
	public String getTxtAddress() {
		return txtAddress;
	}

	/**
	 * @param txtAddresss the txtAddresss to set
	 */
	public void setTxtAddress(String txtAddress) {
		this.txtAddress = txtAddress;
	}

	/**
	 * @return the txtIoBit
	 */
	public String getTxtIoBit() {
		return txtIoBit;
	}

	/**
	 * @param txtIoBit the txtIoBit to set
	 */
	public void setTxtIoBit(String txtIoBit) {
		this.txtIoBit = txtIoBit;
	}

	/**
	 * @return the searchStr
	 */
	public String getSearchStr() {
		return searchStr;
	}

	/**
	 * @param searchStr the searchStr to set
	 */
	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}

	/**
	 * @return the chkTagNm
	 */
	public String getChkOpt1() {
		return chkOpt1;
	}

	/**
	 * @param chkTagNm the chkTagNm to set
	 */
	public void setChkOpt1(String chkOpt1) {
		this.chkOpt1 = chkOpt1;
	}

	/**
	 * @return the chkTagDesc
	 */
	public String getChkOpt2() {
		return chkOpt2;
	}

	/**
	 * @param chkTagDesc the chkTagDesc to set
	 */
	public void setChkOpt2(String chkOpt2) {
		this.chkOpt2 = chkOpt2;
	}

	/**
	 * @return the findAll
	 */
	public String getFindAll() {
		return findAll;
	}

	/**
	 * @param findAll the findAll to set
	 */
	public void setFindAll(String findAll) {
		this.findAll = findAll;
	}
}
