package com.mkpenc.alarm.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.alarm.mapper.DccAlarmMapper;
import com.mkpenc.alarm.model.DccAlarmInfo;
import com.mkpenc.alarm.model.DccSearchAlarm;
import com.mkpenc.alarm.service.DccAlarmService;

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
}