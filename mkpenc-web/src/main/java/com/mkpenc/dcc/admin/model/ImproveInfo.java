package com.mkpenc.dcc.admin.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class ImproveInfo {
	
	private String rowNum;
	private String seqNo;
	private String pDate;
	private String pTitle;
	private String pContents;
	private String pUser;
	private String wDate;
	private String wUser;
	
	
	/**
	 * @return the rowNum
	 */
	public String getRowNum() {
		return rowNum;
	}
	/**
	 * @param rowNum the rowNum to set
	 */
	public void setRowNum(String rowNum) {
		this.rowNum = rowNum;
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
	 * @return the pDate
	 */
	public String getpDate() {
		return pDate;
	}
	/**
	 * @param pDate the pDate to set
	 */
	public void setpDate(String pDate) {
		this.pDate = pDate;
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
	 * @return the pUser
	 */
	public String getpUser() {
		return pUser;
	}
	/**
	 * @param pUser the pUser to set
	 */
	public void setpUser(String pUser) {
		this.pUser = pUser;
	}
	/**
	 * @return the wDate
	 */
	public String getwDate() {
		return wDate;
	}
	/**
	 * @param wDate the wDate to set
	 */
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	/**
	 * @return the wUser
	 */
	public String getwUser() {
		return wUser;
	}
	/**
	 * @param wUser the wUser to set
	 */
	public void setwUser(String wUser) {
		this.wUser = wUser;
	}
	
	

}
