package com.mkpenc.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.common.model.ComShowTagInfo;
import com.mkpenc.common.model.ComTagDccInfo;
import com.mkpenc.mimic.model.DccSearchMimic;

@Service
public  interface BasDccMimicService {
	
	
	public List<ComTagDccInfo> getDccGrpTagNoUnitConvList(Map searchMap);
	
	public List<ComTagDccInfo> getDccGrpTagList(Map searchMap);
	
	public String[] getDccValueReturn(Map searchMap);
	
	public Map getDccValue(Map searchMap, List<ComTagDccInfo> tagDccInfoList,  ModelAndView mav);
	
	String selectSeqInfo(DccSearchMimic searchMimic);
	
	int updateTagInfo(DccSearchMimic searchMimic);
	
	List<ComShowTagInfo> selectTagSearch(DccSearchMimic searchMimic);

	List<ComShowTagInfo> selectTagFind(DccSearchMimic searchMimic);

}
