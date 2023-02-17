package com.mkpenc.alarm.model;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class DccSearchAlarm  extends BaseSearch {
	private String hogiHeader;
	private String xyHeader;
	
	private String pType;
	
	private String hogi;
	private String xyGubun;
	private String startDate;
	private String endDate;
	private String alarmGubun;
	private String alarmCode;
	private String address;
	private String alarmMsg;
	private String pagNo;
	private String currentPage;
	private String moveDirection;
	
	private String seq;
	
	/**
	 * @return the hogiHeader
	 */
	public String getHogiHeader() {
		return hogiHeader;
	}
	/**
	 * @param hogiHeader the hogiHeader to set
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
	 * @return the pType
	 */
	public String getpType() {
		return pType;
	}
	/**
	 * @param pType the pType to set
	 */
	public void setpType(String pType) {
		this.pType = pType;
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
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return the alarmGubun
	 */
	public String getAlarmGubun() {
		return alarmGubun;
	}
	/**
	 * @param alarmGubun the alarmGubun to set
	 */
	public void setAlarmGubun(String alarmGubun) {
		this.alarmGubun = alarmGubun;
	}
	/**
	 * @return the alarmCode
	 */
	public String getAlarmCode() {
		return alarmCode;
	}
	/**
	 * @param alarmCode the alarmCode to set
	 */
	public void setAlarmCode(String alarmCode) {
		this.alarmCode = alarmCode;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return the alarmMsg
	 */
	public String getAlarmMsg() {
		return alarmMsg;
	}
	/**
	 * @param alarmMsg the alarmMsg to set
	 */
	public void setAlarmMsg(String alarmMsg) {
		this.alarmMsg = alarmMsg;
	}
	/**
	 * @return the pagNo
	 */
	public String getPagNo() {
		return pagNo;
	}
	/**
	 * @param pagNo the pagNo to set
	 */
	public void setPagNo(String pagNo) {
		this.pagNo = pagNo;
	}
	/**
	 * @return the currentPage
	 */
	public String getCurrentPage() {
		return currentPage;
	}
	/**
	 * @param currentPage the currentPage to set
	 */
	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}
	/**
	 * @return the moveDirection
	 */
	public String getMoveDirection() {
		return moveDirection;
	}
	/**
	 * @param moveDirection the moveDirection to set
	 */
	public void setMoveDirection(String moveDirection) {
		this.moveDirection = moveDirection;
	}
	/**
	 * @return the seq
	 */
	public String getSeq() {
		return seq;
	}
	/**
	 * @param seq the seq to set
	 */
	public void setSeq(String seq) {
		this.seq = seq;
	}
}
