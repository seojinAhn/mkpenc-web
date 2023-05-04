package com.mkpenc.mark.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.mark.common.model.ComTagMarkInfo;

@Service
public  interface BasMarkOsmsService {
	 
	public List<ComTagMarkInfo> getMarkGrpTagList(Map searchMap); 
	
	public String[] getMarkValueReturn(Map searchMap);
	
	public Map getMarkValue(Map searchMap, List<ComTagMarkInfo> tagMarkInfoList,  ModelAndView mav);

}
