package com.mkpenc.dcc.trend.model;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class DccSearchTrend  extends BaseSearch {
	private String hogiHeader;
	private String xyHeader;
	
	private String sHogi;
	private String sXYGubun;
	
	private String startDate;
	private String endDate;
	
	private String sDive;
	
	private String gHis;
	private String gUseGap;
	private String txtTimeGap;
	private String sUGrpNo;
	private String fixed;
	private String sGrpID;
	private String sMenuNo;
	
	private String hogi;
	private String xyGubun;
	
	private String ioType;
	private String ioBit;
	private String SaveCore;
	
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
	 * @return the gHis
	 */
	public String getgHis() {
		return gHis;
	}
	/**
	 * @param gHis the gHis to set
	 */
	public void setgHis(String gHis) {
		this.gHis = gHis;
	}
	/**
	 * @return the gUseGap
	 */
	public String getgUseGap() {
		return gUseGap;
	}
	/**
	 * @param gUseGap the gUseGap to set
	 */
	public void setgUseGap(String gUseGap) {
		this.gUseGap = gUseGap;
	}
	/**
	 * @return the txtTimeGap
	 */
	public String getTxtTimeGap() {
		return txtTimeGap;
	}
	/**
	 * @param txtTimeGap the txtTimeGap to set
	 */
	public void setTxtTimeGap(String txtTimeGap) {
		this.txtTimeGap = txtTimeGap;
	}
	/**
	 * @return the gUGrpNo
	 */
	public String getsUGrpNo() {
		return sUGrpNo;
	}
	/**
	 * @param gUGrpNo the gUGrpNo to set
	 */
	public void setsUGrpNo(String sUGrpNo) {
		this.sUGrpNo = sUGrpNo;
	}
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
	 * @return the fixed
	 */
	public String getFixed() {
		return fixed;
	}
	/**
	 * @param fixed the fixed to set
	 */
	public void setFixed(String fixed) {
		this.fixed = fixed;
	}
	/**
	 * @return the gDiv
	 */
	public String getsDive() {
		return sDive;
	}
	/**
	 * @param gDiv the gDiv to set
	 */
	public void setsDive(String sDive) {
		this.sDive = sDive;
	}
	/**
	 * @return the gGrpID
	 */
	public String getsGrpID() {
		return sGrpID;
	}
	/**
	 * @param gGrpID the gGrpID to set
	 */
	public void setsGrpID(String sGrpID) {
		this.sGrpID = sGrpID;
	}
	/**
	 * @return the gMenuNo
	 */
	public String getsMenuNo() {
		return sMenuNo;
	}
	/**
	 * @param gMenuNo the gMenuNo to set
	 */
	public void setsMenuNo(String sMenuNo) {
		this.sMenuNo = sMenuNo;
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
		return SaveCore;
	}
	/**
	 * @param saveCore the saveCore to set
	 */
	public void setSaveCore(String saveCore) {
		SaveCore = saveCore;
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
	public void setDescrMod(String descrMod) {
		this.descrMod = descrMod;
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
}
