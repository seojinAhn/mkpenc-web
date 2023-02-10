package com.mkpenc.main.model;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class SearchMain extends BaseSearch {
	
	//공지사항
	private String sTitle;
	private String sContents;

	private String searchKey;
	private String searchWord;
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

	
	
}
