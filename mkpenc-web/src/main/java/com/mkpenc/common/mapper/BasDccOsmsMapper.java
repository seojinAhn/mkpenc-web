package com.mkpenc.common.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.common.model.ComDccGrpTagInfo;


@Mapper
public interface BasDccOsmsMapper {
	
	List<ComDccGrpTagInfo> selectDccGrpTagList(Map searchMapper);
	
	String selectFastIoChk(ComDccGrpTagInfo dccGrpTagInfo);
	
	Map selectScanTime(Map searchMapper);	
	
	List<Map>  selectTblNoFldNo(Map searchMapper);
	
	List<Map> selectLogDccTrend(Map selectMap);

}
