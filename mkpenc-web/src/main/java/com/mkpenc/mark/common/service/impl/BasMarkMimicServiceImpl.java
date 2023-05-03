package com.mkpenc.mark.common.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.mark.common.mapper.BasMarkMimicMapper;
import com.mkpenc.mark.common.model.ComShowTagMarkInfo;
import com.mkpenc.mark.common.model.ComTagMarkInfo;
import com.mkpenc.mark.common.service.BasMarkMimicService;
import com.mkpenc.mark.mimic.model.MarkvSearchMimic;
 
@Service("basMarkMimicService")
public class BasMarkMimicServiceImpl implements BasMarkMimicService{
	
	@Autowired
	private BasMarkMimicMapper basMarkMimicMapper;
	
	public String[][] AnalogCharacter() {
		
		Map disCodeMark = basMarkMimicMapper.distinctMstCodeMark();
		
		int iCX = 0;
		int iCY = 0;
		if(disCodeMark != null) {
			iCX = disCodeMark.get("CX") != null? Integer.parseInt(disCodeMark.get("CX").toString()):0;
			iCY = disCodeMark.get("CY") != null? Integer.parseInt(disCodeMark.get("CY").toString()):0;
		}
		
		String[][] tAnalogChar = new String[iCX+1][iCY+1];
		
		//System.out.println("iCX = " + (iCX+1));
		//System.out.println("iCY = " + (iCY+1));
		
		List<Map> codeMarkList = basMarkMimicMapper.selectMstCodeMark();
		
		if(codeMarkList != null) {
			if(tAnalogChar.length >0) {
				
				for(Map codeMark:codeMarkList) {
					int x = codeMark.get("CODE2") != null? Integer.parseInt(codeMark.get("CODE2").toString()):0;
					int y = codeMark.get("CODE3") != null? Integer.parseInt(codeMark.get("CODE3").toString()):0;
					String desc = codeMark.get("CODEDESC") != null? codeMark.get("CODEDESC").toString():"";
					
					//System.out.println("x = " + x);
					//System.out.println("y = " + y);
					
					tAnalogChar[x][y] = desc;
				}				
			}
		}
			
	   return tAnalogChar;
	}


	
	@Override
	public int updateMarkTagInfo1(MarkvSearchMimic searchMimic) {
		return basMarkMimicMapper.updateMarkTagInfo1(searchMimic);
	}
	
	@Override
	public int updateMarkTagInfo2(MarkvSearchMimic searchMimic) {
		return basMarkMimicMapper.updateMarkTagInfo2(searchMimic);
	}

	@Override
	public List<ComShowTagMarkInfo> selectMarkTagSearch(MarkvSearchMimic searchMimic) {
		return basMarkMimicMapper.selectMarkTagSearch(searchMimic);
	}
	
	@Override
	public List<ComShowTagMarkInfo> selectMarkTagFind(MarkvSearchMimic searchMimic) {
		return basMarkMimicMapper.selectMarkTagFind(searchMimic);
	}
	
	@Override
	public List<ComTagMarkInfo> getComboCodeList() {
		return basMarkMimicMapper.selectComboCodeList();
	}
	
	@Override
	public List<ComTagMarkInfo> getComboDescList(MarkvSearchMimic searchMimic) {
		return basMarkMimicMapper.selectComboDescList(searchMimic);
	}
	
	@Override
	public String getSaveCoreInfo(MarkvSearchMimic markvSearchMimic) {
		return basMarkMimicMapper.getSaveCoreInfo(markvSearchMimic);
	}
	
}
