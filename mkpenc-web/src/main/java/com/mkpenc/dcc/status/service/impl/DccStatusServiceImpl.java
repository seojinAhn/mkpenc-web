package com.mkpenc.dcc.status.service.impl;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.dcc.status.mapper.DccStatusMapper;
import com.mkpenc.dcc.status.model.DccGrpTagInfo;
import com.mkpenc.dcc.status.model.DccSearchStatus;
import com.mkpenc.dcc.status.model.DccLogTrendInfo;
import com.mkpenc.dcc.status.model.DccMstTagInfo;
import com.mkpenc.dcc.status.model.TblFldInfo;
import com.mkpenc.dcc.status.service.DccStatusService;

@Service("dccStatusService")
public class DccStatusServiceImpl  implements DccStatusService {
	
	private static Logger logger = LoggerFactory.getLogger(DccStatusService.class);

    @Autowired
    private DccStatusMapper dccStatusMapper;

	@Override
	public int updateMemberInfo(DccSearchStatus dccSearchStatus) {
		return dccStatusMapper.updateMemberInfo(dccSearchStatus);
	}

	@Override
	public String selectScanTime(DccSearchStatus dccSearchStatus) {
		return dccStatusMapper.selectScanTime(dccSearchStatus);
	}

	@Override
	public List<TblFldInfo> selectTblFldNo(DccSearchStatus dccSearchStatus) {
		return dccStatusMapper.selectTblFldNo(dccSearchStatus);
	}

	@Override
	public List<DccLogTrendInfo> selectLogTrend(DccSearchStatus dccSearchStatus) {
		return dccStatusMapper.selectLogTrend(dccSearchStatus);
	}

	@Override
	public List<DccGrpTagInfo> selectDccGrpTag(DccSearchStatus dccSearchStatus) {
		return dccStatusMapper.selectDccGrpTag(dccSearchStatus);
	}

	@Override
	public String selectSeqInfo(DccSearchStatus dccSearchStatus) {
		return dccStatusMapper.selectSeqInfo(dccSearchStatus);
	}
	
	@Override
	public int updateTagInfo(DccSearchStatus dccSearchStatus) {
		return dccStatusMapper.updateTagInfo(dccSearchStatus);
	}
	
	@Override
	public List<DccMstTagInfo> selectTagSearch(DccSearchStatus dccSearchStatus) {
		return dccStatusMapper.selectTagSearch(dccSearchStatus);
	}
	
	@Override
	public List<DccMstTagInfo> selectTagFind(DccSearchStatus dccSearchStatus) {
		return dccStatusMapper.selectTagFind(dccSearchStatus);
	}
}
