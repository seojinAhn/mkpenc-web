package com.mkpenc.dcc.performance.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.dcc.performance.mapper.DccPerformanceMapper;
import com.mkpenc.dcc.performance.model.DccSearchPerformance;
import com.mkpenc.dcc.performance.service.DccPerformanceService;

@Service("dccPerformanceService")
public class DccPerformanceServiceImpl implements DccPerformanceService{
	
	private static Logger logger = LoggerFactory.getLogger(DccPerformanceService.class);

    @Autowired
    private DccPerformanceMapper dccPerformanceMapper;
	
	public Map selectTrendInfoByUrlA(Map searchMap) {
		return dccPerformanceMapper.selectTrendInfoByUrlA(searchMap);
	}
	
	public Map selectTrendInfoA(Map searchMap) {
		return dccPerformanceMapper.selectTrendInfoA(searchMap);
	}
	
	public Map selectTrendInfoByUrlB(Map searchMap) {
		return dccPerformanceMapper.selectTrendInfoByUrlB(searchMap);
	}
	
	public Map selectTrendInfoB(Map searchMap) {
		return dccPerformanceMapper.selectTrendInfoB(searchMap);
	}	
	
	public List<Map> selectTagSearch(DccSearchPerformance searchPerformance){
		return dccPerformanceMapper.selectTagSearch(searchPerformance);
	}
	
	public List<Map> selectFastIOSearch(DccSearchPerformance searchPerformance){
		return dccPerformanceMapper.selectFastIOSearch(searchPerformance);
	}
	
	public Map selectMaxGrpName(DccSearchPerformance searchPerformance) {
		return dccPerformanceMapper.selectMaxGrpName(searchPerformance);
	}
	
	public int insertGrpName(Map insertMap) {
		return dccPerformanceMapper.insertGrpName(insertMap);
	}
	
	public int updateGrpName(Map updateMap) {
		return dccPerformanceMapper.updateGrpName(updateMap);
	}
	
	public int deleteGrpTag(Map deleteMap) {
		return dccPerformanceMapper.deleteGrpTag(deleteMap);
	}
	
	public Map selectISeqTagDccSearch(Map selectMap) {
		return dccPerformanceMapper.selectISeqTagDccSearch(selectMap);
	}
	
	public int insertGrpTag(Map insertMap) {
		return dccPerformanceMapper.insertGrpTag(insertMap);
	}
	
	public Map selectScanTime(DccSearchPerformance searchPerformance) {
		return dccPerformanceMapper.selectScanTime(searchPerformance);
	}
	
	public List<Map> selectXYLogDccTrendByUrl(Map selectMap){
		return dccPerformanceMapper.selectXYLogDccTrendByUrl(selectMap);
	}
	
	public List<Map> selectXYLogDccTrend(Map selectMap){
		return dccPerformanceMapper.selectXYLogDccTrend(selectMap);
	}
	
	public int selectXYIOTypeAITotalCnt(Map selectMap) {
		return dccPerformanceMapper.selectXYIOTypeAITotalCnt(selectMap);
	}
	
	public List<Map> selectXYIOTypeAI(Map selectMap){
		return dccPerformanceMapper.selectXYIOTypeAI(selectMap);
	}
	
	public int selectXYIOTypeDITotalCnt(Map selectMap) {
		return dccPerformanceMapper.selectXYIOTypeDITotalCnt(selectMap);
	}
	
	public List<Map> selectXYIOTypeDI(Map selectMap){
		return dccPerformanceMapper.selectXYIOTypeDI(selectMap);
	}
	
	public int selectXYIOTypeAIWIBATotalCnt(Map selectMap) {
		return dccPerformanceMapper.selectXYIOTypeAIWIBATotalCnt(selectMap);
	}
	
	public List<Map> selectXYIOTypeAIWIBA(Map selectMap){
		return dccPerformanceMapper.selectXYIOTypeAIWIBA(selectMap);
	}
	
}
