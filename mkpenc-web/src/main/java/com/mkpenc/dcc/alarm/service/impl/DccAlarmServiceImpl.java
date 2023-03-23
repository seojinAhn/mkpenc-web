package com.mkpenc.dcc.alarm.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.dcc.alarm.mapper.DccAlarmMapper;
import com.mkpenc.dcc.alarm.model.DccAlarmInfo;
import com.mkpenc.dcc.alarm.model.DccSearchAlarm;
import com.mkpenc.dcc.alarm.service.DccAlarmService;

@Service("dccAlarmService")
public class DccAlarmServiceImpl  implements DccAlarmService {
	private static Logger logger = LoggerFactory.getLogger(DccAlarmService.class);

    @Autowired
    private DccAlarmMapper dccAlarmMapper;

	@Override
	public int selectAlarmTotalCnt(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectAlarmTotalCnt(dccSearchAlarm);
	}

	@Override
	public String selectAlarmSeq(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectAlarmSeq(dccSearchAlarm);
	}

	@Override
	public String selectAlarmSeqSp(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectAlarmSeqSp(dccSearchAlarm);
	}

	@Override
	public List<DccAlarmInfo> selectAlarmProc(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectAlarmProc(dccSearchAlarm);
	}

	@Override
	public List<DccAlarmInfo> selectAlarmToRecord(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectAlarmToRecord(dccSearchAlarm);
	}

	@Override
	public List<DccAlarmInfo> selectAlarmToExport(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectAlarmToExport(dccSearchAlarm);
	}

	@Override
	public String selectSummarySeq(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectSummarySeq(dccSearchAlarm);
	}

	@Override
	public List<DccAlarmInfo> selectSummaryList(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectSummaryList(dccSearchAlarm);
	}
	
	@Override
	public List<Map> selectSetIOList(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectSetIOList(dccSearchAlarm);
	}
	
	@Override
	public Integer deleteGrpTagB(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.deleteGrpTagB(dccSearchAlarm);
	}
	
	@Override
	public String selectISeqGrpTagB(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectISeqGrpTagB(dccSearchAlarm); 
	}
	
	@Override
	public Integer insertGrpTagB(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.insertGrpTagB(dccSearchAlarm);
	}
	
	@Override
	public List<Map> selectAlarmTagSearch(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectAlarmTagSearch(dccSearchAlarm);
	}
	
	@Override
	public List<DccAlarmInfo> selectFixedAlarm(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectFixedAlarm(dccSearchAlarm);
	}
	
	@Override
	public List<Map> selectGasInfo(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectGasInfo(dccSearchAlarm);
	}
	
	@Override
	public List<Map> selectStreamAIInfo(DccSearchAlarm dccSearchAlarm) {
		return dccAlarmMapper.selectStreamAIInfo(dccSearchAlarm);
	}
}