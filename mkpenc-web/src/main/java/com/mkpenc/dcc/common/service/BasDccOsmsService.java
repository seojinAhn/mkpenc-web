package com.mkpenc.dcc.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.trend.model.TrendTagDccInfo;


@Service
public  interface BasDccOsmsService {
	
	public List<ComTagDccInfo> getDccGrpTagList(Map searchMap);
	
	public String[] getDccValueReturn(Map searchMap);
	
	public Map getDccValue(Map searchMap, List<ComTagDccInfo> tagDccInfoList);
	public Map getDccValue2(Map searchMap, List<TrendTagDccInfo> tagDccInfoList);
	
	public Map getDccValueSearch(Map searchMap, List<ComTagDccInfo> tagDccInfoList);
	
	public Map getNumericRealValue(Map searchMap, List<ComTagDccInfo> tagDccInfoList);
	public Map getNumericRealValue2(Map searchMap, List<ComTagDccInfo> tagDccInfoList);
	
	// added by jhlee(23.02.28)
	List<Map> selectDccGrpTagListB(Map selectMap);
	
	List<Map> selectDccGrpTagListA(Map selectMap);

}
