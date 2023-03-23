package com.mkpenc.dcc.performance.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class GroupNameInfo {
	
	 private String gubun; 
	 private String id; 
	 private String menuNo; 
	 private String uGrpNo; 
	 private String uGrpName;
	 
	 
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
	 * @return the uGrpNo
	 */
	public String getuGrpNo() {
		return uGrpNo;
	}
	/**
	 * @param uGrpNo the uGrpNo to set
	 */
	public void setuGrpNo(String uGrpNo) {
		this.uGrpNo = uGrpNo;
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
	 
	
}
