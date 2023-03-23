package com.mkpenc.common.base;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@SuppressWarnings("serial")
public class BaseSearch extends BaseObject {

	protected int pageNum = 1;
	protected int pageSize = 10;
		
	protected int totalCnt;
	protected int totalPage;	
	
	protected int beginPage;
	protected int endPage;	
	
	protected String menuName;
	protected String viewHogi = "3";
	protected String hogiType = "X";	
	
	protected String currentTime;
	
	/**
	 * @return the pageNum
	 */
	public int getPageNum() {
		return pageNum;
	}
	/**
	 * @param pageNum the pageNum to set
	 */
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	/**
	 * @return the pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}
	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	/**
	 * @return the totalCnt
	 */
	public int getTotalCnt() {
		return totalCnt;
	}
	/**
	 * @param totalCnt the totalCnt to set
	 */
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
		this.setTotalPage(this.getTotalPage());
		
		beginPage = (this.pageNum / this.pageSize) * this.pageSize + 1;
		
		if((this.pageNum % this.pageSize) == 0) {
			beginPage = beginPage  - 1;
		}
		
		endPage = beginPage + 9;
		
		if(endPage > this.getTotalPage()) {
			endPage = this.getTotalPage();
		}
		
		/*
		
		if((this.pageNum - 5) <= 0) {
			beginPage = 1;
		}else {
			beginPage = (this.pageNum - 5) + 1;
		}
		
		if((this.pageNum + 5) > this.getTotalPage()) {
			endPage = this.getTotalPage();
		}else {
			endPage = (this.pageNum + 5);
		}
		*/
		
		//현재시간 설정
		this.setCurrentTime("");
	}
	/**
	 * @return the totalPage
	 */
	public int getTotalPage() {
		return (this.totalCnt/this.pageSize) + 1;
	}
	/**
	 * @param totalPage the totalPage to set
	 */
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	/**
	 * @return the beginPage
	 */
	public int getBeginPage() {
		return beginPage;
	}
	/**
	 * @param beginPage the beginPage to set
	 */
	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}
	/**
	 * @return the endPage
	 */
	public int getEndPage() {
		return endPage;
	}
	/**
	 * @param endPage the endPage to set
	 */
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	/**
	 * @return the menuName
	 */
	public String getMenuName() {
		return menuName;
	}
	/**
	 * @param menuName the menuName to set
	 */
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	/**
	 * @return the viewHogi
	 */
	public String getViewHogi() {
		return viewHogi;
	}
	/**
	 * @param viewHogi the viewHogi to set
	 */
	public void setViewHogi(String viewHogi) {
		this.viewHogi = viewHogi;
	}
	/**
	 * @return the hogiType
	 */
	public String getHogiType() {
		return hogiType;
	}
	/**
	 * @param hogiType the hogiType to set
	 */
	public void setHogiType(String hogiType) {
		this.hogiType = hogiType;
	}
	/**
	 * @return the currentTime
	 */
	public String getCurrentTime() {
		return this.currentTime;
	}
	/**
	 * @param currentTime the currentTime to set
	 */
	public void setCurrentTime(String currentTime) {
		
		if(currentTime == null || currentTime.equals("")) {
			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			
			currentTime = now.format(formatter);
		}
		
		this.currentTime = currentTime;
	}
	
	
	
	
}