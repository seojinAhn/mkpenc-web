package com.mkpenc.dcc.tip.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class DccIoColumnInfo {

	private String columnName;

	
	/**
	 * @return the columnName
	 */
	public String getColumnName() {
		return columnName;
	}

	/**
	 * @param columnName the columnName to set
	 */
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	
}
