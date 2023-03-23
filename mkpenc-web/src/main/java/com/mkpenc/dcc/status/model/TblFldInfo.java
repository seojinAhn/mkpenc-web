package com.mkpenc.dcc.status.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class TblFldInfo {

	private String tblNo;
	private String fldNo;
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
	 * @return the fldNo
	 */
	public String getFldNo() {
		return fldNo;
	}
	/**
	 * @param fldNo the fldNo to set
	 */
	public void setFldNo(String fldNo) {
		this.fldNo = fldNo;
	}

}
