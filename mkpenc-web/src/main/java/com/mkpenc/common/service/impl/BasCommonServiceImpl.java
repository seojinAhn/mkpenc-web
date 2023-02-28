package com.mkpenc.common.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.common.mapper.BasCommonMapper;
import com.mkpenc.common.service.BasCommonService;


@Service("basCommonService")
public class BasCommonServiceImpl implements BasCommonService{
	
	@Autowired
	private BasCommonMapper basCommonMapper;
	
	public List<Map> selectGrpNameList(Map searchMap){
		return basCommonMapper.selectGrpNameList(searchMap);
	}
	
	// added by jhlee(23.02.28)
	public List<String> selectGrpNameListB(Map searchMap){
		return basCommonMapper.selectGrpNameListB(searchMap);
	}

}

