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
	
	@Override
	public List<Map> selectMaxGrpName(Map searchMap) {
		return basCommonMapper.selectMaxGrpName(searchMap);
	}
	
	// added by jhlee(23.02.28)
	public List<String> selectGrpNameListB(Map searchMap){
		return basCommonMapper.selectGrpNameListB(searchMap);
	}
	
	// - 디지털 값을 가져온다.(16bit -> 1bit)
	//private int GetBitVal(ByVal DigitalValue As String, ByVal DigitalBit As String) As String
	public String GetBitVal(String digitalValue, String digitalBit) {
		    
		long Rest = 0;
	    
	    double di_val;
	    int bit_no;	    
	    
	    if(digitalBit.isEmpty()) {
	       if(digitalValue == null) {
	    	   return "";
	       }else {
	    	   return digitalValue;
	       }
	    }
	    
	    di_val = Double.parseDouble(digitalValue);	    
	    bit_no = Integer.parseInt(digitalBit);

	    for(int i = 0;i <= bit_no;i++) {
	    	
	        Rest = Math.round(di_val % 2);
	        di_val = Math.floor(di_val / 2);
		}
	    
	    return Rest +"";
	}
	
	@Override
	public List<Map> selectLogTimer(Map searchMapper) {
		return basCommonMapper.selectLogTimer(searchMapper);
	}

}

