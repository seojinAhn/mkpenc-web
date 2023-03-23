package com.mkpenc.mark.common.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.mark.common.mapper.BasMarkMimicMapper;
import com.mkpenc.mark.common.service.BasMarkMimicService;
 
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

}
