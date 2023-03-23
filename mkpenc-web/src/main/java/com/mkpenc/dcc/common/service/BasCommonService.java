package com.mkpenc.dcc.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

 
@Service
public  interface BasCommonService {
	
	List<Map> selectGrpNameList(Map searchMap);
	
	String GetBitVal(String digitalValue, String digitalBit);
	
	// added by jhlee(23.02.28)
	List<String> selectGrpNameListB(Map searchMapper);
	
	

}
