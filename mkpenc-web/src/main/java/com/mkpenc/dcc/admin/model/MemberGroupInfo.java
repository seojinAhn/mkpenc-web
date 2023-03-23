package com.mkpenc.dcc.admin.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class MemberGroupInfo {
	
	private String groupCode;
	private String groupName;
	
	
	/**
	 * @return the groupCode
	 */
	public String getGroupCode() {
		return groupCode;
	}
	/**
	 * @param groupCode the groupCode to set
	 */
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	/**
	 * @return the groupName
	 */
	public String getGroupName() {
		return groupName;
	}
	/**
	 * @param groupName the groupName to set
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	

}
