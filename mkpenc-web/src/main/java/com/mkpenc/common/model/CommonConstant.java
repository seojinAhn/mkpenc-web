package com.mkpenc.common.model;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "props")
public class CommonConstant {
	
    private String domain;
    private String url;

    private String attachPath;

	/**
	 * @return the domain
	 */
	public String getDomain() {
		return domain;
	}

	/**
	 * @param domain the domain to set
	 */
	public void setDomain(String domain) {
		this.domain = domain;
	}

	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * @param url the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * @return the attachPath
	 */
	public String getAttachPath() {
		return attachPath;
	}

	/**
	 * @param attachPath the attachPath to set
	 */
	public void setAttachPath(String attachPath) {
		this.attachPath = attachPath;
	}

    
    
    
    
}