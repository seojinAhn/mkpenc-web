package com.mkpenc.alt.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.alt.common.model.ComTagAltInfo;


@Service
public  interface BasAltOsmsService {
	
	public List<ComTagAltInfo> getDccGrpTagList(Map searchMap);
	
	public String[] getDccValueReturn(Map searchMap);
	
	public Map getDccValue(Map searchMap, List<ComTagAltInfo> tagAltInfoList);
	
	public Map getDccValueSearch(Map searchMap, List<ComTagAltInfo> tagAltInfoList);
	
	public Map getNumericRealValue(Map searchMap, List<ComTagAltInfo> tagAltInfoList);
	
	// added by jhlee(23.02.28)
	List<Map> selectDccGrpTagListB(Map selectMap);
	
	List<Map> selectDccGrpTagListA(Map selectMap);

}
