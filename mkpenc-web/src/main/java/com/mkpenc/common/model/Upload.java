package com.mkpenc.common.model;

import com.mkpenc.common.base.BaseObject;

@SuppressWarnings("serial")
public class Upload extends BaseObject {
    private Integer seq;
    private String div;
    private String bbsId;
    private String fileSaveName;
	private String fileRealName;
	private String fileSize;
	private String filePath;
	private String fileFullPath;
	private String pathType;
	private String fileExtension;
	/**
	 * @return the seq
	 */
	public Integer getSeq() {
		return seq;
	}
	/**
	 * @param seq the seq to set
	 */
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	/**
	 * @return the div
	 */
	public String getDiv() {
		return div;
	}
	/**
	 * @param div the div to set
	 */
	public void setDiv(String div) {
		this.div = div;
	}
	/**
	 * @return the bbsId
	 */
	public String getBbsId() {
		return bbsId;
	}
	/**
	 * @param bbsId the bbsId to set
	 */
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}
	/**
	 * @return the fileSaveName
	 */
	public String getFileSaveName() {
		return fileSaveName;
	}
	/**
	 * @param fileSaveName the fileSaveName to set
	 */
	public void setFileSaveName(String fileSaveName) {
		this.fileSaveName = fileSaveName;
	}
	/**
	 * @return the fileRealName
	 */
	public String getFileRealName() {
		return fileRealName;
	}
	/**
	 * @param fileRealName the fileRealName to set
	 */
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	/**
	 * @return the fileSize
	 */
	public String getFileSize() {
		return fileSize;
	}
	/**
	 * @param fileSize the fileSize to set
	 */
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	/**
	 * @return the filePath
	 */
	public String getFilePath() {
		return filePath;
	}
	/**
	 * @param filePath the filePath to set
	 */
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	/**
	 * @return the pathType
	 */
	public String getPathType() {
		return pathType;
	}
	
	/**
	 * @return the fileFullPath
	 */
	public String getFileFullPath() {
		return fileFullPath;
	}
	/**
	 * @param fileFullPath the fileFullPath to set
	 */
	public void setFileFullPath(String fileFullPath) {
		this.fileFullPath = fileFullPath;
	}
	/**
	 * @param pathType the pathType to set
	 */
	public void setPathType(String pathType) {
		this.pathType = pathType;
	}
	/**
	 * @return the fileExtension
	 */
	public String getFileExtension() {
		return fileExtension;
	}
	/**
	 * @param fileExtension the fileExtension to set
	 */
	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}

	

}
