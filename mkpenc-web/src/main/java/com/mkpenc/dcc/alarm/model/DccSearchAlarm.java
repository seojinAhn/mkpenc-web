package com.mkpenc.dcc.alarm.model;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class DccSearchAlarm  extends BaseSearch {
	private String hogiHeader;
	private String xyHeader;
	
	private String sGrpID;
	private String sMenuNo;
	private String sDive;
	private String sUGrpNo;
	
	private String sHogi;
	private String sXYGubun;
	
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
	
	private String ioType;
	private String ioBit;
	private String saveCore;
	
	private String seq;
	
	private String iSeqMod;
	private String gubunMod;
	private String hogiMod;
	private String xyGubunMod;
	private String descrMod;
	private String ioTypeMod;
	private String addressMod;
	private String ioBitMod;
	private String minValMod;
	private String maxValMod;
	private String saveCoreMod;
	private String chkHogi;
	
	private String ySeq;
	private String tagNo;
	private String gHogi;
	
	private String tagHogi;
	private String bAll;
	private String tagIOType;
	private String chkOpt1;
	private String chkOpt2;
	private String findData;
	
	private String title;
	private String loop;
	private String ci;
	
	private String tValue;
	
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
	 * @return the sGrpID
	 */
	public String getsGrpID() {
		return sGrpID;
	}
	/**
	 * @param sGrpID the sGrpID to set
	 */
	public void setsGrpID(String sGrpID) {
		this.sGrpID = sGrpID;
	}
	/**
	 * @return the sMenuNo
	 */
	public String getsMenuNo() {
		return sMenuNo;
	}
	/**
	 * @param sMenuNo the sMenuNo to set
	 */
	public void setsMenuNo(String sMenuNo) {
		this.sMenuNo = sMenuNo;
	}
	/**
	 * @return the sDive
	 */
	public String getsDive() {
		return sDive;
	}
	/**
	 * @param sDive the sDive to set
	 */
	public void setsDive(String sDive) {
		this.sDive = sDive;
	}
	/**
	 * @return the sUGrpNo
	 */
	public String getsUGrpNo() {
		return sUGrpNo;
	}
	/**
	 * @param sUGrpNo the sUGrpNo to set
	 */
	public void setsUGrpNo(String sUGrpNo) {
		this.sUGrpNo = sUGrpNo;
	}
	/**
	 * @return the sHogi
	 */
	public String getsHogi() {
		return sHogi;
	}
	/**
	 * @param sHogi the sHogi to set
	 */
	public void setsHogi(String sHogi) {
		this.sHogi = sHogi;
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
	 * @return the ioType
	 */
	public String getIoType() {
		return ioType;
	}
	/**
	 * @param ioType the ioType to set
	 */
	public void setIoType(String ioType) {
		this.ioType = ioType;
	}
	/**
	 * @return the ioBit
	 */
	public String getIoBit() {
		return ioBit;
	}
	/**
	 * @param ioBit the ioBit to set
	 */
	public void setIoBit(String ioBit) {
		this.ioBit = ioBit;
	}
	/**
	 * @return the saveCore
	 */
	public String getSaveCore() {
		return saveCore;
	}
	/**
	 * @param saveCore the saveCore to set
	 */
	public void setSaveCore(String saveCore) {
		this.saveCore = saveCore;
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
	/**
	 * @return the iSeqMod
	 */
	public String getiSeqMod() {
		return iSeqMod;
	}
	/**
	 * @param iSeqMod the iSeqMod to set
	 */
	public void setiSeqMod(String iSeqMod) {
		this.iSeqMod = iSeqMod;
	}
	/**
	 * @return the gubunMod
	 */
	public String getGubunMod() {
		return gubunMod;
	}
	/**
	 * @param gubunMod the gubunMod to set
	 */
	public void setGubunMod(String gubunMod) {
		this.gubunMod = gubunMod;
	}
	/**
	 * @return the hogiMod
	 */
	public String getHogiMod() {
		return hogiMod;
	}
	/**
	 * @param hogiMod the hogiMod to set
	 */
	public void setHogiMod(String hogiMod) {
		this.hogiMod = hogiMod;
	}
	/**
	 * @return the xyGubunMod
	 */
	public String getXyGubunMod() {
		return xyGubunMod;
	}
	/**
	 * @param xyGubunMod the xyGubunMod to set
	 */
	public void setXyGubunMod(String xyGubunMod) {
		this.xyGubunMod = xyGubunMod;
	}
	/**
	 * @return the descrMod
	 */
	public String getDescrMod() {
		return descrMod;
	}
	/**
	 * @param descrMod the descrMod to set
	 */
	public void setDescrMod(String DescrMod) {
		descrMod = DescrMod;
	}
	/**
	 * @return the ioTypeMod
	 */
	public String getIoTypeMod() {
		return ioTypeMod;
	}
	/**
	 * @param ioTypeMod the ioTypeMod to set
	 */
	public void setIoTypeMod(String ioTypeMod) {
		this.ioTypeMod = ioTypeMod;
	}
	/**
	 * @return the addressMod
	 */
	public String getAddressMod() {
		return addressMod;
	}
	/**
	 * @param addressMod the addressMod to set
	 */
	public void setAddressMod(String addressMod) {
		this.addressMod = addressMod;
	}
	/**
	 * @return the ioBitMod
	 */
	public String getIoBitMod() {
		return ioBitMod;
	}
	/**
	 * @param ioBitMod the ioBitMod to set
	 */
	public void setIoBitMod(String ioBitMod) {
		this.ioBitMod = ioBitMod;
	}
	/**
	 * @return the minValMod
	 */
	public String getMinValMod() {
		return minValMod;
	}
	/**
	 * @param minValMod the minValMod to set
	 */
	public void setMinValMod(String minValMod) {
		this.minValMod = minValMod;
	}
	/**
	 * @return the maxValMod
	 */
	public String getMaxValMod() {
		return maxValMod;
	}
	/**
	 * @param maxValMod the maxValMod to set
	 */
	public void setMaxValMod(String maxValMod) {
		this.maxValMod = maxValMod;
	}
	/**
	 * @return the saveCoreMod
	 */
	public String getSaveCoreMod() {
		return saveCoreMod;
	}
	/**
	 * @param saveCoreMod the saveCoreMod to set
	 */
	public void setSaveCoreMod(String saveCoreMod) {
		this.saveCoreMod = saveCoreMod;
	}
	/**
	 * @return the chkHogi
	 */
	public String getChkHogi() {
		return chkHogi;
	}
	/**
	 * @param chkHogi the chkHogi to set
	 */
	public void setChkHogi(String chkHogi) {
		this.chkHogi = chkHogi;
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
	 * @return the gHogi
	 */
	public String getgHogi() {
		return gHogi;
	}
	/**
	 * @param gHogi the gHogi to set
	 */
	public void setgHogi(String gHogi) {
		this.gHogi = gHogi;
	}
	/**
	 * @return the tagHogi
	 */
	public String getTagHogi() {
		return tagHogi;
	}
	/**
	 * @param tagHogi the tagHogi to set
	 */
	public void setTagHogi(String tagHogi) {
		this.tagHogi = tagHogi;
	}
	/**
	 * @return the bAll
	 */
	public String getbAll() {
		return bAll;
	}
	/**
	 * @param bAll the bAll to set
	 */
	public void setbAll(String bAll) {
		this.bAll = bAll;
	}
	/**
	 * @return the tagIOType
	 */
	public String getTagIOType() {
		return tagIOType;
	}
	/**
	 * @param tagIOType the tagIOType to set
	 */
	public void setTagIOType(String tagIOType) {
		this.tagIOType = tagIOType;
	}
	/**
	 * @return the chkOpt1
	 */
	public String getChkOpt1() {
		return chkOpt1;
	}
	/**
	 * @param chkOpt1 the chkOpt1 to set
	 */
	public void setChkOpt1(String chkOpt1) {
		this.chkOpt1 = chkOpt1;
	}
	/**
	 * @return the chkOpt2
	 */
	public String getChkOpt2() {
		return chkOpt2;
	}
	/**
	 * @param chkOpt2 the chkOpt2 to set
	 */
	public void setChkOpt2(String chkOpt2) {
		this.chkOpt2 = chkOpt2;
	}
	/**
	 * @return the findData
	 */
	public String getFindData() {
		return findData;
	}
	/**
	 * @param findData the findData to set
	 */
	public void setFindData(String findData) {
		this.findData = findData;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the loop
	 */
	public String getLoop() {
		return loop;
	}
	/**
	 * @param loop the loop to set
	 */
	public void setLoop(String loop) {
		this.loop = loop;
	}
	/**
	 * @return the ci
	 */
	public String getCi() {
		return ci;
	}
	/**
	 * @param ci the ci to set
	 */
	public void setCi(String ci) {
		this.ci = ci;
	}
	/**
	 * @return the tValue
	 */
	public String gettValue() {
		return tValue;
	}
	/**
	 * @param tValue the tValue to set
	 */
	public void settValue(String tValue) {
		this.tValue = tValue;
	}
}
