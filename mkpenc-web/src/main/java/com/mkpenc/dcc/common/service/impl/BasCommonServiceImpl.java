package com.mkpenc.dcc.common.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.dcc.common.mapper.BasCommonMapper;
import com.mkpenc.dcc.common.service.BasCommonService;

 
@Service("basCommonService")
public class BasCommonServiceImpl implements BasCommonService{
	
	@Autowired
	private BasCommonMapper basCommonMapper;
	
	public List<Map> selectGrpNameList(Map searchMap){
		return basCommonMapper.selectGrpNameList(searchMap);
	}
	
	// added by jhlee(23.02.28)
	public List<String> selectGrpNameListB(Map searchMap){
		return basCommonMapper.selectGrpNameListB(searchMap);
	}
	
	// - 디지털 값을 가져온다.(16bit -> 1bit)
	//private int GetBitVal(ByVal DigitalValue As String, ByVal DigitalBit As String) As String
	public String GetBitVal(String digitalValue, String digitalBit) {
		    
		    long Rest = 0;
		    
		    long di_val;
		    int bit_no;	    
		    
		    if(digitalBit.isEmpty()) {
		       if(digitalValue == null) {
		    	   return "";
		       }else {
		    	   return digitalValue;
		       }
		    }
		   // System.out.println("digitalValue=" + digitalValue);
		    di_val = Math.round(Double.parseDouble(digitalValue));	    
		    bit_no = Integer.parseInt(digitalBit);

		    for(int i = 0;i < bit_no;i++) {
		        Rest = (di_val % 2);
		        //System.out.println("rest=" + Rest);
		        //di_val = di_val \ 2;
		    	di_val = di_val >> 2;
			}
		    
		    return Rest +"";
		}

}

