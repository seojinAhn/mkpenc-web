package com.mkpenc.dcc.trend.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.dcc.trend.model.DccSearchTrend;

@Mapper
public interface DccTrendMapper {
	List<Map> selectGroupName(Map trendSearchMap);
	
	List<Map> selectTrendFldNo(DccSearchTrend dccSearchTrend);
	
	List<Map> selectTrendData(Map trendSearchMap);
	
	List<String> selectScanTime(DccSearchTrend dccSearchTrend);
	
	List<Map> selectGrpTagList(Map trendSearchMap);
	
	String selectMinScantime(Map trendSearchMap);
	
	String selectTValueTrend(Map trendSearchMap);
	
	int manageTrendProc(String procBody);
	
	List<Map> callTrendProc(Map procInfo);
}
