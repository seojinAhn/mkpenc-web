package com.mkpenc.tip.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mkpenc.tip.model.DccIoColumnInfo;
import com.mkpenc.tip.model.DccIolistInfo;
import com.mkpenc.tip.model.DccSearchTip;

@Service
public interface DccTipService {
	
	List<DccIolistInfo> selectIoList(DccSearchTip dccSearchTip);

	List<DccIoColumnInfo> selectIoColumnList(DccSearchTip dccSearchTip);
	
	int updateIolistInfo(DccSearchTip dccSearchTip);
	
	List<DccIolistInfo> selectIoListExcelDownload(DccSearchTip dccSearchTip);
	
}
