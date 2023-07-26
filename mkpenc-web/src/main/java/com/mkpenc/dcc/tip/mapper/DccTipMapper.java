package com.mkpenc.dcc.tip.mapper;

import java.util.List;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.dcc.admin.model.IOListInfo;
import com.mkpenc.dcc.tip.model.DccIoColumnInfo;
import com.mkpenc.dcc.tip.model.DccIolistInfo;
import com.mkpenc.dcc.tip.model.DccSearchTip;

@Mapper
public interface DccTipMapper {
	
	List<DccIolistInfo> selectIoList(DccSearchTip dccSearchTip);

	List<DccIoColumnInfo> selectIoColumnList(DccSearchTip dccSearchTip);

	int updateIolistInfo(DccSearchTip dccSearchTip);
	
	List<DccIolistInfo> selectIoListExcelDownload(DccSearchTip dccSearchTip);
	
	int selectIOListInfoTotalCnt(IOListInfo ioListImfo);
	
	List<IOListInfo> selectIOListInfoList(IOListInfo ioListImfo);

}
