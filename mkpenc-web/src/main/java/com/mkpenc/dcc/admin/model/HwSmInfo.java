package com.mkpenc.dcc.admin.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class HwSmInfo {
	
	private String seqNo;
	private String  hogi;
	private String  type;
	private String  date;
	private String  failure;
	private String  repair;
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
	 * @return the date
	 */
	public String getDate() {
		return date;
	}
	/**
	 * @param date the date to set
	 */
	public void setDate(String date) {
		this.date = date;
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
	
	

}
