package com.mkpenc.main.mapper;

import java.util.List;


import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.main.model.NoticeInfo;
import com.mkpenc.main.model.SearchMain;


@Mapper
public interface MainMapper {
	
	//공지사항
	int selectNoticeTotalCnt(SearchMain searchMain);
	
	List<NoticeInfo> selectNoticeList(SearchMain searchMain);
	
	NoticeInfo selectNoticeInfo(SearchMain searchMain);
	
	int insertNoticeInfo(NoticeInfo noticeInfo);
	
	int updateNoticeInfo(NoticeInfo noticeInfo);
	
	int deleteNoticeInfo(NoticeInfo noticeInfo);


}
