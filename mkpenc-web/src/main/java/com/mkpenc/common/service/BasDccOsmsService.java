package com.mkpenc.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.common.model.TagDccInfo;


@Service
public  interface BasDccOsmsService {
	
	public List<TagDccInfo> getDccGrpTagList(Map searchMap);
	
	public String[] getDccValueReturn(Map searchMap);
	
	public Map getDccValue(Map searchMap, List<TagDccInfo> tagDccInfoList,  ModelAndView mav);

}
