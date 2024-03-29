package com.mkpenc.dcc.common.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.dcc.common.model.ComDccGrpTagInfo;


@Mapper
public interface BasDccOsmsMapper {
	
	List<ComDccGrpTagInfo> selectDccGrpTagList(Map searchMapper);
	
	String selectFastIoChk(ComDccGrpTagInfo dccGrpTagInfo);
	
	Map selectScanTime(Map searchMapper);	
	
	Map selectScanTimeMark(Map searchMapper);	
	
	List<Map>  selectTblNoFldNo(Map searchMapper);
	
	List<Map> selectLogDccTrend(Map selectMap);
	
	List<Map> selectLogDccTrend4Hogi(Map selectMap);
	
	List<Map> selectLogDccTrendSearch(Map selectMap);
	
	Map selectLogDccTrendReal(Map selectMap);
	
	Map selectLogDccTrend4HogiReal(Map selectMap);
	
	Map selectLogDccCount(Map selectMap);
	
	// added by jhlee(23.02.28)
	List<Map> selectDccGrpTagListB(Map selectMap);
	
	List<Map> selectDccGrpTagListA(Map selectMap);

}
