package com.mkpenc.mark.performance.service;

import java.util.Map;

import org.springframework.stereotype.Service;


@Service
public interface MarkvPerformanceService {
	
	Map selectTrendInfoA(Map searchMap);
	
	Map selectTrendInfoB(Map searchMap);

}
