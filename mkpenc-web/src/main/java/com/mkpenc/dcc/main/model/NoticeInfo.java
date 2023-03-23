package com.mkpenc.dcc.main.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class NoticeInfo {
	
	String rowNum;
	String seqNo;
	String title;
	String contents;
	String createDate;
	String id;
	String userName;
	String pwd;
	/**
	 * @return the rowNum
	 */
	public String getRowNum() {
		return rowNum;
	}
	/**
	 * @param rowNum the rowNum to set
	 */
	public void setRowNum(String rowNum) {
		this.rowNum = rowNum;
	}
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
	 * @return the contents
	 */
	public String getContents() {
		return contents;
	}
	/**
	 * @param contents the contents to set
	 */
	public void setContents(String contents) {
		this.contents = contents;
	}
	/**
	 * @return the createDate
	 */
	public String getCreateDate() {
		return createDate;
	}
	/**
	 * @param createDate the createDate to set
	 */
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
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
	 * @return the pwd
	 */
	public String getPwd() {
		return pwd;
	}
	/**
	 * @param pwd the pwd to set
	 */
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}
	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	
	

}
