package com.mkpenc.dcc.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.dcc.common.model.ComShowTagInfo;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.mimic.model.DccSearchMimic;

@Service
public  interface BasDccMimicService {
	
	
	public List<ComTagDccInfo> getDccGrpTagNoUnitConvList(Map searchMap);
	
	public List<ComTagDccInfo> getDccGrpTagList(Map searchMap);
	
	public String[] getDccValueReturn(Map searchMap);
	
	public Map getDccValue(Map searchMap, List<ComTagDccInfo> tagDccInfoList);
	
	public Map getDccValue2(Map searchMap, List<ComTagDccInfo> tagDccInfoList);
	
	String selectSeqInfo(DccSearchMimic searchMimic);
	
	int updateTagInfo(DccSearchMimic searchMimic);
	
	List<ComShowTagInfo> selectTagSearch(DccSearchMimic searchMimic);

	List<ComShowTagInfo> selectTagFind(DccSearchMimic searchMimic);

}
