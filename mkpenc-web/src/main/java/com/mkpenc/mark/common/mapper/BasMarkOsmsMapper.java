package com.mkpenc.mark.common.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;

@Mapper
public interface BasMarkOsmsMapper {
	
	List<Map> selectMarkGrpTagList(Map searchMapper);
	
	Map selectScanTime(Map searchMapper);	
	
	List<Map>  selectTblNoFldNo(Map searchMapper);
	
	List<Map> selectLogMarkTrend(Map selectMap); 

}
