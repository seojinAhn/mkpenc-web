package com.mkpenc.alt.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

 
@Service
public  interface AltCommonService {
	
	List<Map> selectGrpNameList(Map searchMap);
	
	List<Map> selectMaxGrpName(Map searchMapper);
	
	String GetBitVal(String digitalValue, String digitalBit);
	
	// added by jhlee(23.02.28)
	List<String> selectGrpNameListB(Map searchMapper);
	
	List<Map> selectLogTimer(Map searchMapper);

}
