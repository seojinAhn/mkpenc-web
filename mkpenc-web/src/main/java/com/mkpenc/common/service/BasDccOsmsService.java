package com.mkpenc.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.common.model.ComTagDccInfo;


@Service
public  interface BasDccOsmsService {
	
	public List<ComTagDccInfo> getDccGrpTagList(Map searchMap);
	
	public String[] getDccValueReturn(Map searchMap);
	
	public Map getDccValue(Map searchMap, List<ComTagDccInfo> tagDccInfoList,  ModelAndView mav);
	
	// added by jhlee(23.02.28)
	List<Map> selectDccGrpTagListB(Map selectMap);

}
