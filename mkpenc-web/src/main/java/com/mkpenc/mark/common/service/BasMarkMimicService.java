package com.mkpenc.mark.common.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mkpenc.mark.mimic.model.MarkvSearchMimic;
import com.mkpenc.mark.common.model.ComShowTagMarkInfo;
import com.mkpenc.mark.common.model.ComTagMarkInfo;

@Service
public  interface BasMarkMimicService {
	 
	public String[][] AnalogCharacter();
	
	int updateMarkTagInfo1(MarkvSearchMimic searchMimic);
	
	int updateMarkTagInfo2(MarkvSearchMimic searchMimic);
	
	List<ComShowTagMarkInfo> selectMarkTagSearch(MarkvSearchMimic searchMimic);

	List<ComShowTagMarkInfo> selectMarkTagFind(MarkvSearchMimic searchMimic);
	
	List<ComTagMarkInfo> getComboCodeList();
	 
	List<ComTagMarkInfo> getComboDescList(MarkvSearchMimic searchMimic);
	
	String getSaveCoreInfo(MarkvSearchMimic markvSearchMimic);

}
