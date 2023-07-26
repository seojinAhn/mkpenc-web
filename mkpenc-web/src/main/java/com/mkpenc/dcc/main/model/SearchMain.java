package com.mkpenc.dcc.main.model;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class SearchMain extends BaseSearch {
	
	private String sGrpID;
	private String sMenuNo;
	private String sDive;
	private String sUGrpNo;
	
	private String  sHogi;
	private String  sXYGubun;	
	
	//공지사항
	private String sTitle;
	private String sContents;

	private String searchKey;
	private String searchWord;
	
	private String noLogin;
	
	
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
	
	/**
	 * @return the sTitle
	 */
	public String getsTitle() {
		return sTitle;
	}
	/**
	 * @param sTitle the sTitle to set
	 */
	public void setsTitle(String sTitle) {
		this.sTitle = sTitle;
	}
	/**
	 * @return the sContents
	 */
	public String getsContents() {
		return sContents;
	}
	/**
	 * @param sContents the sContents to set
	 */
	public void setsContents(String sContents) {
		this.sContents = sContents;
	}
	/**
	 * @return the searchKey
	 */
	public String getSearchKey() {
		return searchKey;
	}
	/**
	 * @param searchKey the searchKey to set
	 */
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	/**
	 * @return the searchWord
	 */
	public String getSearchWord() {
		return searchWord;
	}
	/**
	 * @param searchWord the searchWord to set
	 */
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	/**
	 * @return the noLogin
	 */
	public String getNoLogin() {
		return noLogin;
	}
	/**
	 * @param noLogin the noLogin to set
	 */
	public void setNoLogin(String noLogin) {
		this.noLogin = noLogin;
	}

	
	
}
