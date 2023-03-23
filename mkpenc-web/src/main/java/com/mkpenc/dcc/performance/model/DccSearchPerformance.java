package com.mkpenc.dcc.performance.model;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class DccSearchPerformance  extends BaseSearch {
	
	private String sGrpID;
	private String sMenuNo;
	private String sDive;
	private String sUGrpNo;
	
	private String  sHogi;
	private String  sXYGubun;
	private String  sChkHogi;
	
	private String  mskSpareS;
	private String  mskSpareE;
	
	private String  mskFixedS;
	private String  mskFixedE;
	
	private String sIOType;
	private String findData;
	private String chkOpt1;
	private String chkOpt2;
	
	private String bGroupFlag;	
	private String ioUGrpNo;
	private String uGrpName;
	
	private String hogiArr;
	private String xyGubunArr;
	private String loopNameArr;
	private String ioTypeArr;
	private String addressArr;
	private String ioBitArr;
	private String minValArr;
	private String maxValArr;
	private String saveCoreArr;
	private String iSeqArr;
	
	private String startDate;
	private String sPer;
	
	private String timeGap;
	
	
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
	 * @return the sChkHogi
	 */
	public String getsChkHogi() {
		return sChkHogi;
	}
	/**
	 * @param sChkHogi the sChkHogi to set
	 */
	public void setsChkHogi(String sChkHogi) {
		this.sChkHogi = sChkHogi;
	}
	/**
	 * @return the mskSpareS
	 */
	public String getMskSpareS() {
		return mskSpareS;
	}
	/**
	 * @param mskSpareS the mskSpareS to set
	 */
	public void setMskSpareS(String mskSpareS) {
		this.mskSpareS = mskSpareS;
	}
	/**
	 * @return the mskSpareE
	 */
	public String getMskSpareE() {
		return mskSpareE;
	}
	/**
	 * @param mskSpareE the mskSpareE to set
	 */
	public void setMskSpareE(String mskSpareE) {
		this.mskSpareE = mskSpareE;
	}
	/**
	 * @return the mskFixedS
	 */
	public String getMskFixedS() {
		return mskFixedS;
	}
	/**
	 * @param mskFixedS the mskFixedS to set
	 */
	public void setMskFixedS(String mskFixedS) {
		this.mskFixedS = mskFixedS;
	}
	/**
	 * @return the mskFixedE
	 */
	public String getMskFixedE() {
		return mskFixedE;
	}
	/**
	 * @param mskFixedE the mskFixedE to set
	 */
	public void setMskFixedE(String mskFixedE) {
		this.mskFixedE = mskFixedE;
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
	 * @return the bGroupFlag
	 */
	public String getbGroupFlag() {
		return bGroupFlag;
	}
	/**
	 * @param bGroupFlag the bGroupFlag to set
	 */
	public void setbGroupFlag(String bGroupFlag) {
		this.bGroupFlag = bGroupFlag;
	}
	/**
	 * @return the ioUGrpNo
	 */
	public String getIoUGrpNo() {
		return ioUGrpNo;
	}
	/**
	 * @param ioUGrpNo the ioUGrpNo to set
	 */
	public void setIoUGrpNo(String ioUGrpNo) {
		this.ioUGrpNo = ioUGrpNo;
	}
	/**
	 * @return the uGrpName
	 */
	public String getuGrpName() {
		return uGrpName;
	}
	/**
	 * @param uGrpName the uGrpName to set
	 */
	public void setuGrpName(String uGrpName) {
		this.uGrpName = uGrpName;
	}
	/**
	 * @return the hogiArr
	 */
	public String getHogiArr() {
		return hogiArr;
	}
	/**
	 * @param hogiArr the hogiArr to set
	 */
	public void setHogiArr(String hogiArr) {
		this.hogiArr = hogiArr;
	}
	/**
	 * @return the xyGubunArr
	 */
	public String getXyGubunArr() {
		return xyGubunArr;
	}
	/**
	 * @param xyGubunArr the xyGubunArr to set
	 */
	public void setXyGubunArr(String xyGubunArr) {
		this.xyGubunArr = xyGubunArr;
	}
	/**
	 * @return the loopNameArr
	 */
	public String getLoopNameArr() {
		return loopNameArr;
	}
	/**
	 * @param loopNameArr the loopNameArr to set
	 */
	public void setLoopNameArr(String loopNameArr) {
		this.loopNameArr = loopNameArr;
	}
	/**
	 * @return the ioTypeArr
	 */
	public String getIoTypeArr() {
		return ioTypeArr;
	}
	/**
	 * @param ioTypeArr the ioTypeArr to set
	 */
	public void setIoTypeArr(String ioTypeArr) {
		this.ioTypeArr = ioTypeArr;
	}
	/**
	 * @return the addressArr
	 */
	public String getAddressArr() {
		return addressArr;
	}
	/**
	 * @param addressArr the addressArr to set
	 */
	public void setAddressArr(String addressArr) {
		this.addressArr = addressArr;
	}
	/**
	 * @return the ioBitArr
	 */
	public String getIoBitArr() {
		return ioBitArr;
	}
	/**
	 * @param ioBitArr the ioBitArr to set
	 */
	public void setIoBitArr(String ioBitArr) {
		this.ioBitArr = ioBitArr;
	}
	/**
	 * @return the minValArr
	 */
	public String getMinValArr() {
		return minValArr;
	}
	/**
	 * @param minValArr the minValArr to set
	 */
	public void setMinValArr(String minValArr) {
		this.minValArr = minValArr;
	}
	/**
	 * @return the maxValArr
	 */
	public String getMaxValArr() {
		return maxValArr;
	}
	/**
	 * @param maxValArr the maxValArr to set
	 */
	public void setMaxValArr(String maxValArr) {
		this.maxValArr = maxValArr;
	}
	/**
	 * @return the saveCoreArr
	 */
	public String getSaveCoreArr() {
		return saveCoreArr;
	}
	/**
	 * @param saveCoreArr the saveCoreArr to set
	 */
	public void setSaveCoreArr(String saveCoreArr) {
		this.saveCoreArr = saveCoreArr;
	}
	/**
	 * @return the iSeqArr
	 */
	public String getiSeqArr() {
		return iSeqArr;
	}
	/**
	 * @param iSeqArr the iSeqArr to set
	 */
	public void setiSeqArr(String iSeqArr) {
		this.iSeqArr = iSeqArr;
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
	 * @return the sPer
	 */
	public String getsPer() {
		return sPer;
	}
	/**
	 * @param sPer the sPer to set
	 */
	public void setsPer(String sPer) {
		this.sPer = sPer;
	}
	/**
	 * @return the timeGap
	 */
	public String getTimeGap() {
		return timeGap;
	}
	/**
	 * @param timeGap the timeGap to set
	 */
	public void setTimeGap(String timeGap) {
		this.timeGap = timeGap;
	}
	
	
	
}
