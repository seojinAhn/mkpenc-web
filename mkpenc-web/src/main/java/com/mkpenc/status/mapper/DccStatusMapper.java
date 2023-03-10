package com.mkpenc.status.mapper;

import java.util.List;

import com.mkpenc.common.annotaion.Mapper;
import com.mkpenc.status.model.DccGrpTagInfo;
import com.mkpenc.status.model.DccSearchStatus;
import com.mkpenc.status.model.DccLogTrendInfo;
import com.mkpenc.status.model.DccMstTagInfo;
import com.mkpenc.status.model.TblFldInfo;

@Mapper
public interface DccStatusMapper {
	
	int updateMemberInfo(DccSearchStatus searchStatus);
	
	String selectScanTime(DccSearchStatus searchStatus);
	
	List<TblFldInfo> selectTblFldNo(DccSearchStatus searchStatus);
	
	List<DccGrpTagInfo> selectDccGrpTag(DccSearchStatus searchStatus);
	
	List<DccLogTrendInfo> selectLogTrend(DccSearchStatus searchStatus);
	
	String selectSeqInfo(DccSearchStatus searchStatus);
	
	int updateTagInfo(DccSearchStatus searchStatus);
	
	List<DccMstTagInfo> selectTagSearch(DccSearchStatus searchStatus);
	
	List<DccMstTagInfo> selectTagFind(DccSearchStatus searchStatus);	

}
