package com.mkpenc.mark.performance.service.impl;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.mkpenc.mark.alarm.service.MarkvAlarmService;
import com.mkpenc.mark.performance.mapper.MarkvPerformanceMapper;
import com.mkpenc.mark.performance.service.MarkvPerformanceService;

@Service("markvPerformanceService")
public class MarkvPerformanceServiceImpl implements MarkvPerformanceService{
	
	private static Logger logger = LoggerFactory.getLogger(MarkvPerformanceService.class);

    @Autowired
    private MarkvPerformanceMapper markvPerformanceMapper;
	
	public Map selectTrendInfoA(Map searchMap) {
		return markvPerformanceMapper.selectTrendInfoA(searchMap);
	}
	
	public Map selectTrendInfoB(Map searchMap) {
		return markvPerformanceMapper.selectTrendInfoB(searchMap);
	}

}

