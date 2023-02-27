package com.mkpenc.common.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;

@Mapper
public interface BasCommonMapper {
	
	List<Map> selectGrpNameList(Map searchMapper);
	
	List<String> selectGrpNameListB(Map searchMapper);

}
