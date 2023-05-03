package com.mkpenc.mark.common.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.mark.common.model.ComShowTagMarkInfo;
import com.mkpenc.mark.common.model.ComTagMarkInfo;
import com.mkpenc.mark.mimic.model.MarkvSearchMimic;


@Mapper
public interface BasMarkMimicMapper {	
	
	Map distinctMstCodeMark();
	
	List<Map> selectMstCodeMark(); 
	
	int updateMarkTagInfo1(MarkvSearchMimic searchMimic);
	
	int updateMarkTagInfo2(MarkvSearchMimic searchMimic);
	
	List<ComShowTagMarkInfo> selectMarkTagSearch(MarkvSearchMimic searchMimic);
	
	List<ComShowTagMarkInfo> selectMarkTagFind(MarkvSearchMimic searchMimic);
	
	List<ComTagMarkInfo> selectComboCodeList();
	
	List<ComTagMarkInfo> selectComboDescList(MarkvSearchMimic searchMimic);
	
	String getSaveCoreInfo(MarkvSearchMimic markvSearchMimic);

}
