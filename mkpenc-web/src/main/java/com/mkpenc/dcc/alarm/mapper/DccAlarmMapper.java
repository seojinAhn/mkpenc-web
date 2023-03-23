package com.mkpenc.dcc.alarm.mapper;

import java.util.List;
import java.util.Map;

import com.mkpenc.dcc.alarm.model.DccAlarmInfo;
import com.mkpenc.dcc.alarm.model.DccSearchAlarm;
import com.mkpenc.common.annotaion.Mapper;

@Mapper
public interface DccAlarmMapper {
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
	
	//earlywarning
	List<Map> selectSetIOList(DccSearchAlarm dccSearchAlarm);
	
	Integer deleteGrpTagB(DccSearchAlarm dccSearchAlarm);
	
	String selectISeqGrpTagB(DccSearchAlarm dccSearchAlarm);
	
	Integer insertGrpTagB(DccSearchAlarm dccSearchAlarm);
	
	List<Map> selectAlarmTagSearch(DccSearchAlarm dccSearchAlarm);
	
	//fixedtimecontrol
	List<DccAlarmInfo> selectFixedAlarm(DccSearchAlarm dccSearchAlarm);
	
	//gaschromatograthy
	List<Map> selectGasInfo(DccSearchAlarm dccSearchAlarm);
	
	List<Map> selectStreamAIInfo(DccSearchAlarm dccSearchAlarm);
}