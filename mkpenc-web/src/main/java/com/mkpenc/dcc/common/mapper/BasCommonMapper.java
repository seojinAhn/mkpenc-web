package com.mkpenc.dcc.common.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;

@Mapper
public interface BasCommonMapper {
	
	List<Map> selectGrpNameList(Map searchMapper);
	
	List<Map> selectMaxGrpName(Map searchMapper);
	
	// added by jhlee(23.02.28)
	List<String> selectGrpNameListB(Map searchMapper);
	
	List<Map> selectLogTimer(Map searchMapper);

}
