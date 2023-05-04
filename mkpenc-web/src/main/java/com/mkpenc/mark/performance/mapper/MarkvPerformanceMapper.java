package com.mkpenc.mark.performance.mapper;

import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;

@Mapper
public interface MarkvPerformanceMapper {
	
	Map selectTrendInfoA(Map searchMap);
	
	Map selectTrendInfoB(Map searchMap);

}
