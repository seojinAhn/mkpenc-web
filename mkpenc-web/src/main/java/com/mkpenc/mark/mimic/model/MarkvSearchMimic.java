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
	
	private String  sHogi;
	private String  sXYGubun;
	private String  sChkHogi;
	
	private String  sScreenId;
	
	private String hogiHeader;
	private String xyHeader;
	
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
	
}
