package com.mkpenc.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


@Service
public  interface BasCommonService {
	
	List<Map> selectGrpNameList(Map searchMap);

}
