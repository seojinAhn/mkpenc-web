package com.mkpenc.dcc.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.dcc.admin.model.EquipInfo;
import com.mkpenc.dcc.admin.model.HwSmInfo;
import com.mkpenc.dcc.admin.model.IOListInfo;
import com.mkpenc.dcc.admin.model.ImproveInfo;
import com.mkpenc.dcc.admin.model.MemberGroupInfo;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.model.RestartCodeInfo;
import com.mkpenc.dcc.admin.model.SwSmInfo;

@Service
public interface DccAdminService {
	
	//사용자 관리, 현재 사용자 관리
		int selectMemberTotalCnt(DccSearchAdmin dccSearchAdmin);
		
		List<MemberInfo> selectMemberList(DccSearchAdmin dccSearchAdmin);
		
		MemberInfo selectMemberInfo(DccSearchAdmin dccSearchAdmin);
		
		int insertMemberInfo(DccSearchAdmin dccSearchAdmin);
		
		int updateMemberInfo(DccSearchAdmin dccSearchAdmin);
		
		int deleteMemberInfo(DccSearchAdmin dccSearchAdmin);
		
		//그룹관리
		List<MemberGroupInfo> selectMemberGroupCombo();
		
		int selectMemberGroupCnt(DccSearchAdmin dccSearchAdmin);
		
		List<MemberGroupInfo> selectMemberGroupList(DccSearchAdmin dccSearchAdmin);
		
		int insertMemberGroupInfo(DccSearchAdmin dccSearchAdmin);
		
		int deleteMemberGroupInfo(DccSearchAdmin dccSearchAdmin);
		
		// IO LIST
		int selectIOListInfoTotalCnt(IOListInfo ioListImfo);
		
		List<IOListInfo> selectIOListInfoList(IOListInfo ioListImfo);
		
		IOListInfo selectIOListInfo(IOListInfo ioListImfo);
		
		int insertIOListInfo(IOListInfo ioListImfo);
		
		int updateIOListInfo(IOListInfo ioListImfo);
		
		int deleteIOListInfo(IOListInfo ioListImfo);		
			
		// 개선사항 관리
		int selectImproveTotalCnt(DccSearchAdmin dccSearchAdmin);
		
		List<ImproveInfo> selectImproveList(DccSearchAdmin dccSearchAdmin);
		
		int insertImproveInfo(DccSearchAdmin dccSearchAdmin);
		
		int updateImproveInfo(DccSearchAdmin dccSearchAdmin);
		
		int deleteImproveInfo(DccSearchAdmin dccSearchAdmin);
		
		//SW형상관리 관리
		int selectSwSmTotalCnt(DccSearchAdmin dccSearchAdmin);
		
		List<SwSmInfo> selectSwSmList(DccSearchAdmin dccSearchAdmin);
		
		List<SwSmInfo> selectSwSmExportList(DccSearchAdmin dccSearchAdmin);
		
		SwSmInfo selectSwSmInfo(DccSearchAdmin dccSearchAdmin);		
		
		int insertSwSmInfo(DccSearchAdmin dccSearchAdmin);
		
		int deleteSwSmInfo(DccSearchAdmin dccSearchAdmin);
		
		//HW형상관리 관리
		int selectHwSmTotalCnt(DccSearchAdmin dccSearchAdmin);
		
		List<HwSmInfo> selectHwSmList(DccSearchAdmin dccSearchAdmin);
		
		int insertHwSmInfo(DccSearchAdmin dccSearchAdmin);
		
		int deleteHwSmInfo(DccSearchAdmin dccSearchAdmin);		
		
		int updateHwSmInfo(DccSearchAdmin dccSearchAdmin);
		
		//PCB(equip) 관리
		int selectEquipTotalCnt(DccSearchAdmin dccSearchAdmin);
		
		List<EquipInfo> selectEquipList(DccSearchAdmin dccSearchAdmin);
		
		List<EquipInfo> selectEquipListForExcel(DccSearchAdmin dccSearchAdmin);
		
		EquipInfo selectEquipInfo(DccSearchAdmin dccSearchAdmin);
		
		int insertEquipInfo(DccSearchAdmin dccSearchAdmin);
		
		int updateEquipInfo(DccSearchAdmin dccSearchAdmin);
		
		int deleteEquipInfo(DccSearchAdmin dccSearchAdmin);
		
		//재가동 코드 관리
		int selectRestartCodeTotalCnt(DccSearchAdmin dccSearchAdmin);
		
		List<RestartCodeInfo> selectRestartCodeList(DccSearchAdmin dccSearchAdmin);
		
		RestartCodeInfo selectRestartCodeInfo(DccSearchAdmin dccSearchAdmin);
		
		int insertRestartCodeInfo(DccSearchAdmin dccSearchAdmin);
		
		int updateRestartCodeInfo(DccSearchAdmin dccSearchAdmin);
		
		int deleteRestartCodeInfo(DccSearchAdmin dccSearchAdmin);
	
	
		
}
