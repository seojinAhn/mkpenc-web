package com.mkpenc.common.module;

import org.springframework.stereotype.Service;

import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.common.base.AlarmBaseSearch;
import com.mkpenc.common.base.BaseSearch;


@Service
public class PageHtmlUtil {
	
	public String getPageHtml(BaseSearch basesearch) {
		
		StringBuffer pageHtml = new StringBuffer();
		
		pageHtml.append("<a class='first'' href='javascript:sendPage(1)' alt='첫페이지'' title='첫페이지'></a>");
         
		if(basesearch.getPageNum() == 1) { 
			pageHtml.append("<a class='pre' href='#none' alt='이전페이지'  title='이전페이지'></a>");
		}else {
			pageHtml.append("<a class='pre' href='javascript:sendPage(" + (basesearch.getPageNum() - 1) + ")' alt='이전페이지'  title='이전페이지'></a>");
		}

		for(int idx=basesearch.getBeginPage(); idx<=basesearch.getEndPage(); idx++) {
			if(basesearch.getPageNum() == idx) {
				pageHtml.append("<strong>" + idx + "</strong>");
			}else {
				pageHtml.append("<a href='javascript:sendPage("+idx + ")'>"+idx +"</a>");
			}
		}
		
		if(basesearch.getPageNum() == basesearch.getTotalPage()) { 
			pageHtml.append("<a class='next' href='#none' alt='다음페이지'  title='다음페이지'></a>");
		}else {
			pageHtml.append("<a class='next' href='javascript:sendPage(" + (basesearch.getPageNum() + 1) + ")' alt='다음페이지'  title='다음페이지'></a>");
		}
		
		pageHtml.append("<a class='last'' href='javascript:sendPage("+basesearch.getTotalPage() +")' alt='마지막페이지'' title='마지막페이지'></a>");
		
		return pageHtml.toString();
	
	}
	
	public String getAlarmPageHtml(AlarmBaseSearch basesearch) {
		
		StringBuffer pageHtml = new StringBuffer();
		
		pageHtml.append("<a class='first'' href='javascript:sendPage(1)' alt='첫페이지'' title='첫페이지'></a>");
         
		if(basesearch.getPageNum() == 1) { 
			pageHtml.append("<a class='pre' href='#none' alt='이전페이지'  title='이전페이지'></a>");
		}else {
			pageHtml.append("<a class='pre' href='javascript:sendPage(" + (basesearch.getPageNum() - 1) + ")' alt='이전페이지'  title='이전페이지'></a>");
		}

		for(int idx=basesearch.getBeginPage(); idx<=basesearch.getEndPage(); idx++) {
			if(basesearch.getPageNum() == idx) {
				pageHtml.append("<strong>" + idx + "</strong>");
			}else {
				pageHtml.append("<a href='javascript:sendPage("+idx + ")'>"+idx +"</a>");
			}
		}
		
		if(basesearch.getPageNum() == basesearch.getTotalPage()) { 
			pageHtml.append("<a class='next' href='#none' alt='다음페이지'  title='다음페이지'></a>");
		}else {
			pageHtml.append("<a class='next' href='javascript:sendPage(" + (basesearch.getPageNum() + 1) + ")' alt='다음페이지'  title='다음페이지'></a>");
		}
		
		pageHtml.append("<a class='last'' href='javascript:sendPage("+basesearch.getTotalPage() +")' alt='마지막페이지'' title='마지막페이지'></a>");
		
		return pageHtml.toString();
	
	}
	
	
	public String getUserGroupPageHtml(DccSearchAdmin dccSearchAdmin) {
		
		StringBuffer userGroupPageHtml = new StringBuffer();
		
		userGroupPageHtml.append("<a class='first'' href='javascript:usrGrpSendPage(1)' alt='첫페이지'' title='첫페이지'></a>");
         
		if(dccSearchAdmin.getGrpPageNum() == 1) { 
			userGroupPageHtml.append("<a class='pre' href='#none' alt='이전페이지'  title='이전페이지'></a>");
		}else {
			userGroupPageHtml.append("<a class='pre' href='javascript:usrGrpSendPage(" + (dccSearchAdmin.getGrpPageNum() - 1) + ")' alt='이전페이지'  title='이전페이지'></a>");
		}
		

		for(int idx=dccSearchAdmin.getGrpBeginPage(); idx<=dccSearchAdmin.getGrpEndPage(); idx++) {

			if(dccSearchAdmin.getGrpPageNum() == idx) {
				userGroupPageHtml.append("<strong>" + idx + "</strong>");
			}else {
				userGroupPageHtml.append("<a href='javascript:usrGrpSendPage("+idx + ")'>"+idx +"</a>");
			}
		}
		
		if(dccSearchAdmin.getGrpPageNum() == dccSearchAdmin.getGrpTotalPage()) { 
			userGroupPageHtml.append("<a class='next' href='#none' alt='다음페이지'  title='다음페이지'></a>");
		}else {
			userGroupPageHtml.append("<a class='next' href='javascript:usrGrpSendPage(" + (dccSearchAdmin.getGrpPageNum() + 1) + ")' alt='다음페이지'  title='다음페이지'></a>");
		}
		
		userGroupPageHtml.append("<a class='last'' href='javascript:usrGrpSendPage("+dccSearchAdmin.getGrpTotalPage() +")' alt='마지막페이지'' title='마지막페이지'></a>");
		
		return userGroupPageHtml.toString();
	
	}

}
