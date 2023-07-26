package com.mkpenc.alt.trend.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.alt.trend.model.AltSearchTrend;

@Mapper
public interface AltTrendMapper {
	List<Map> selectGroupName(Map trendSearchMap);
	
	List<Map> selectTrendFldNo(AltSearchTrend altSearchTrend);
	
	List<Map> selectTrendData(Map trendSearchMap);
	
	List<String> selectScanTime(AltSearchTrend altSearchTrend);
	
	List<Map> selectGrpTagList(Map trendSearchMap);
	
	String selectMinScantime(Map trendSearchMap);
	
	String selectTValueTrend(Map trendSearchMap);
	
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
