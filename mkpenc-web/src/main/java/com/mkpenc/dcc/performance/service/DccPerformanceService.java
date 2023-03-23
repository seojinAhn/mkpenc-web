package com.mkpenc.dcc.performance.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mkpenc.dcc.performance.model.DccSearchPerformance;
import com.mkpenc.dcc.performance.model.GroupNameInfo;

@Service
public interface DccPerformanceService {
	
	Map selectTrendInfoByUrlA(Map searchMap);
	
	Map selectTrendInfoA(Map searchMap);
	
	Map selectTrendInfoByUrlB(Map searchMap);
	
	Map selectTrendInfoB(Map searchMap);	
	
	List<Map> selectTagSearch(DccSearchPerformance searchPerformance);
	
	List<Map> selectFastIOSearch(DccSearchPerformance searchPerformance);
	
	Map selectMaxGrpName(DccSearchPerformance searchPerformance);
	
	int insertGrpName(Map insertMap);
	
	int updateGrpName(Map updateMap);
	
	int deleteGrpTag(Map deleteMap);
	
	Map selectISeqTagDccSearch(Map selectMap);
	
	int insertGrpTag(Map insertMap);
	
	Map selectScanTime(DccSearchPerformance searchPerformance);
	
	List<Map> selectXYLogDccTrendByUrl(Map selectMap);
	
	List<Map> selectXYLogDccTrend(Map selectMap);
	
	int selectXYIOTypeAITotalCnt(Map selectMap);
	
	List<Map> selectXYIOTypeAI(Map selectMap);
	
	int selectXYIOTypeDITotalCnt(Map selectMap);
	
	List<Map> selectXYIOTypeDI(Map selectMap);
	
	int selectXYIOTypeAIWIBATotalCnt(Map selectMap);
	
	List<Map> selectXYIOTypeAIWIBA(Map selectMap);

}
