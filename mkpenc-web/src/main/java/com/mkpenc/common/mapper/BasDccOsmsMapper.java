package com.mkpenc.common.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.common.model.DccGrpTagInfo;


@Mapper
public interface BasDccOsmsMapper {
	
	List<DccGrpTagInfo> selectDccGrpTagList(Map searchMapper);
	
	String selectFastIoChk(DccGrpTagInfo dccGrpTagInfo);
	
	Map selectScanTime(Map searchMapper);	
	
	List<Map>  selectTblNoFldNo(Map searchMapper);
	
	List<Map> selectLogDccTrend(Map selectMap);

}
