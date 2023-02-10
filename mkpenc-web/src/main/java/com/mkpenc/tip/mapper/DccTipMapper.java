package com.mkpenc.tip.mapper;

import java.util.List;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.tip.model.DccIoColumnInfo;
import com.mkpenc.tip.model.DccIolistInfo;
import com.mkpenc.tip.model.DccSearchTip;

@Mapper
public interface DccTipMapper {
	
	List<DccIolistInfo> selectIoList(DccSearchTip dccSearchTip);

	List<DccIoColumnInfo> selectIoColumnList(DccSearchTip dccSearchTip);

	int updateIolistInfo(DccSearchTip dccSearchTip);
	
	List<DccIolistInfo> selectIoListExcelDownload(DccSearchTip dccSearchTip);

}
