package com.mkpenc.dcc.tip.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mkpenc.dcc.admin.model.IOListInfo;
import com.mkpenc.dcc.tip.model.DccIoColumnInfo;
import com.mkpenc.dcc.tip.model.DccIolistInfo;
import com.mkpenc.dcc.tip.model.DccSearchTip;

@Service
public interface DccTipService {
	
	List<DccIolistInfo> selectIoList(DccSearchTip dccSearchTip);

	List<DccIoColumnInfo> selectIoColumnList(DccSearchTip dccSearchTip);
	
	int updateIolistInfo(DccSearchTip dccSearchTip);
	
	List<DccIolistInfo> selectIoListExcelDownload(DccSearchTip dccSearchTip);
	
	int selectIOListInfoTotalCnt(IOListInfo ioListImfo);
	
	List<IOListInfo> selectIOListInfoList(IOListInfo ioListImfo);
	
}
