package com.mkpenc.dcc.trend.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.trend.model.DccSearchTrend;

@Service
public interface DccTrendService {
	List<Map> selectGroupName(Map trendSearchMap);
	
	//List<Map> selectTrendFldNo(DccSearchTrend dccSearchTrend);
	
	String sqlQueryDccReal(DccSearchTrend dccSearchTrend);
	
	String selectScanTime(DccSearchTrend dccSearchTrend);
	
	List<Map> getGrpTag(Map trendSearchMap);
	
	Map getDccValue(DccSearchTrend dccSearchTrend, List<Map> dccGrpTagList, Long lGap, ModelAndView mav);
	
	List<Map> rsTrend5sGap(Map trendSearchMap, List<ComTagDccInfo> dccGrpTagList, Long lGap, String strFast);
	
	int manageTrendProc(String procBody);
	
	List<Map> callTrendProc(Map procInfo);
	
	int deleteGrpTag(Map trendSearchMap);
	
	String selectISeqTagDccSearch(Map trendSearchMap);
	
	int insertGrpTag(Map trendSearchMap);
}
