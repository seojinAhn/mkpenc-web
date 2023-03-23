package com.mkpenc.dcc.main.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mkpenc.dcc.main.model.NoticeInfo;
import com.mkpenc.dcc.main.model.SearchMain;

@Service
public interface MainService {
	
	//공지사항
	int selectNoticeTotalCnt(SearchMain searchMain);
	
	List<NoticeInfo> selectNoticeList(SearchMain searchMain);
	
	NoticeInfo selectNoticeInfo(SearchMain searchMain);
	
	int insertNoticeInfo(NoticeInfo noticeInfo);
	
	int updateNoticeInfo(NoticeInfo noticeInfo);
	
	int deleteNoticeInfo(NoticeInfo noticeInfo);

}
