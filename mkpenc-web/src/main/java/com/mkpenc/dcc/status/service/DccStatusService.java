package com.mkpenc.dcc.status.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mkpenc.dcc.status.model.DccGrpTagInfo;
import com.mkpenc.dcc.status.model.DccSearchStatus;
import com.mkpenc.dcc.status.model.DccLogTrendInfo;
import com.mkpenc.dcc.status.model.DccMstTagInfo;
import com.mkpenc.dcc.status.model.TblFldInfo;

/*import com.mkpenc.tip.model.DccIoColumnInfo;
import com.mkpenc.tip.model.DccIolistInfo;
import com.mkpenc.tip.model.DccSearchTip;*/

@Service
public interface DccStatusService {
	
	int updateMemberInfo(DccSearchStatus searchStatus);
	
	String selectScanTime(DccSearchStatus searchStatus);
	
	List<TblFldInfo> selectTblFldNo(DccSearchStatus searchStatus);
	
	List<DccLogTrendInfo> selectLogTrend(DccSearchStatus searchStatus);
	
	List<DccGrpTagInfo> selectDccGrpTag(DccSearchStatus searchStatus);
	
	String selectSeqInfo(DccSearchStatus searchStatus);
	
	int updateTagInfo(DccSearchStatus searchStatus);
	
	List<DccMstTagInfo> selectTagSearch(DccSearchStatus searchStatus);

	List<DccMstTagInfo> selectTagFind(DccSearchStatus searchStatus);	
}
