package com.mkpenc.dcc.common.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.dcc.common.model.ComDccGrpTagInfo;
import com.mkpenc.dcc.common.model.ComShowTagInfo;
import com.mkpenc.dcc.mimic.model.DccSearchMimic;

@Mapper
public interface BasDccMimicMapper {
	
	List<ComDccGrpTagInfo> selectDccGrpTagList(Map searchMapper);
	
	String selectFastIoChk(ComDccGrpTagInfo dccGrpTagInfo);
	
	Map selectScanTime(Map searchMapper);	
	
	List<Map>  selectTblNoFldNo(Map searchMapper);
	
	List<Map> selectLogDccTrend(Map selectMap);
	
	String selectSeqInfo(DccSearchMimic searchMimic);
	
	int updateTagInfo(DccSearchMimic searchMimic);
	
	List<ComShowTagInfo> selectTagSearch(DccSearchMimic searchMimic);
	
	List<ComShowTagInfo> selectTagFind(DccSearchMimic searchMimic);

}
