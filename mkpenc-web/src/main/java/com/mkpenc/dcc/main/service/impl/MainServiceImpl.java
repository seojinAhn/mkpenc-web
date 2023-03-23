package com.mkpenc.dcc.main.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.dcc.main.mapper.MainMapper;
import com.mkpenc.dcc.main.model.NoticeInfo;
import com.mkpenc.dcc.main.model.SearchMain;
import com.mkpenc.dcc.main.service.MainService;


@Service("mainService")
public class MainServiceImpl implements MainService {
	
	
	private static Logger logger = LoggerFactory.getLogger(MainServiceImpl.class);

    @Autowired
    private MainMapper mainMapper;
    
    @Override
     public int selectNoticeTotalCnt(SearchMain searchMain){
    	return mainMapper.selectNoticeTotalCnt(searchMain);	    	
    }
    
    @Override
     public List<NoticeInfo> selectNoticeList(SearchMain searchMain){
    	return mainMapper.selectNoticeList(searchMain);	    	
    }
    
    @Override
     public NoticeInfo selectNoticeInfo(SearchMain searchMain){
    	return mainMapper.selectNoticeInfo(searchMain);	    	
    }
    
    @Override
    public int insertNoticeInfo(NoticeInfo noticeInfo) {
    	return mainMapper.insertNoticeInfo(noticeInfo);
    }
    
    @Override
    public int updateNoticeInfo(NoticeInfo noticeInfo) {
    	return mainMapper.updateNoticeInfo(noticeInfo);
    }
    
    @Override
    public int deleteNoticeInfo(NoticeInfo noticeInfo) {
    	return mainMapper.deleteNoticeInfo(noticeInfo);
    }

}
