package com.mkpenc.mark.common.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;


@Mapper
public interface BasMarkMimicMapper {	
	
	Map distinctMstCodeMark();
	
	List<Map> selectMstCodeMark(); 

}
