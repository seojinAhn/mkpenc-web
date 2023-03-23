package com.mkpenc.dcc.status.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class DccMstTagInfo {
	private String iHogi;
	private String xyGubun;
	private String descr;
	private String ioType;
	private String address;
	private String ioBit;
	private String iSeq;
	private String loopName;
	
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
	 * @return the loopName
	 */
	public String getLoopName() {
		return loopName;
	}
	/**
	 * @param loopName the loopName to set
	 */
	public void setLoopName(String loopName) {
		this.loopName = loopName;
	}
}