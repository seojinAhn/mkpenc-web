package com.mkpenc.alarm.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mkpenc.alarm.model.DccAlarmInfo;
import com.mkpenc.alarm.model.DccSearchAlarm;

@Service
public interface DccAlarmService {
	//alarm, alarmsearch
	int selectAlarmTotalCnt(DccSearchAlarm dccSearchAlarm);
	
	String selectAlarmSeq(DccSearchAlarm dccSearchAlarm);
	
	String selectAlarmSeqSp(DccSearchAlarm dccSearchAlarm);
	
	List<DccAlarmInfo> selectAlarmProc(DccSearchAlarm dccSearchAlarm);
	
	List<DccAlarmInfo> selectAlarmToRecord(DccSearchAlarm dccSearchAlarm);

	List<DccAlarmInfo> selectAlarmToExport(DccSearchAlarm dccSearchAlarm);
	
	//summary
	String selectSummarySeq(DccSearchAlarm dccSearchAlarm);
	
	List<DccAlarmInfo> selectSummaryList(DccSearchAlarm dccSearchAlarm);
}