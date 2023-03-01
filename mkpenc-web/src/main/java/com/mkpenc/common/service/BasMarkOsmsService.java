package com.mkpenc.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.common.model.ComTagMarkInfo;

@Service
public  interface BasMarkOsmsService {
	
	public List<ComTagMarkInfo> getMarkGrpTagList(Map searchMap); 
	
	public Map getMarkValue(Map searchMap, List<ComTagMarkInfo> tagMarkInfoList,  ModelAndView mav);

}
