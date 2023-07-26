package com.mkpenc.alt.trend.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.alt.common.model.ComTagAltInfo;
import com.mkpenc.alt.trend.model.AltSearchTrend;

@Service
public interface AltTrendService {
	List<Map> selectGroupName(Map trendSearchMap);
	
	//List<Map> selectTrendFldNo(AltSearchTrend altSearchTrend);
	
	String sqlQueryDccReal(AltSearchTrend altSearchTrend);
	
	String selectScanTime(AltSearchTrend altSearchTrend);
	
	List<Map> getGrpTag(Map trendSearchMap);
	
	Map getDccValue(AltSearchTrend altSearchTrend, List<Map> dccGrpTagList, Long lGap, ModelAndView mav);
	
	List<Map> rsTrend5sGap(Map trendSearchMap, List<ComTagAltInfo> dccGrpTagList, Long lGap, String strFast);
	
	int manageTrendProc(String procBody);
	
	List<Map> callTrendProc(Map procInfo);
	
	int deleteGrpTag(Map trendSearchMap);
	
	String selectISeqTagDccSearch(Map trendSearchMap);
	
	int insertGrpTag(Map trendSearchMap);
	
	List<Map> selectSetIOList(AltSearchTrend altSearchTrend);
	
	int updateTrendRange(Map trendSearchMap);
	
	int addGroupTrendFixed(Map trendSearchMap);
	
	int updateGroupTrendFixed(Map trendSearchMap);
	
	List<Map> selectMoveTagTrend(Map trendSearchMap);
	
	List<Map> selectTrendTagSearch(Map trendSearchMap);
	
	String selectMaxUGrpNo(Map trendSearchMap);
	
	int addGroupTrendSpare(Map trendSearchMap);
	
	int addGrpTagTrendSpare(Map trendSearchMap);
	
	int delGroupTrendSpare(Map trendSearchMap);
	
	int delGrpTagTrendSpare(Map trendSearchMap);
	
	List<Map> selectGroupGetTrendSpare(Map trendSearchMap);
	
	List<Map> selectGrpTagTrendSpare(Map trendSearchMap);
	
	int insertGrpTagTrendSpare(Map trendSearchMap);
}
