package com.mkpenc.dcc.admin.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.dcc.admin.mapper.DccAdminMapper;
import com.mkpenc.dcc.admin.model.DccSearchAdmin;
import com.mkpenc.dcc.admin.model.EquipInfo;
import com.mkpenc.dcc.admin.model.HwSmInfo;
import com.mkpenc.dcc.admin.model.IOListInfo;
import com.mkpenc.dcc.admin.model.ImproveInfo;
import com.mkpenc.dcc.admin.model.MemberGroupInfo;
import com.mkpenc.dcc.admin.model.MemberInfo;
import com.mkpenc.dcc.admin.model.RestartCodeInfo;
import com.mkpenc.dcc.admin.model.SwSmInfo;
import com.mkpenc.dcc.admin.service.DccAdminService;

@Service("dccAdminService")
public class DccAdminServiceImpl  implements DccAdminService {
	
		private static Logger logger = LoggerFactory.getLogger(DccAdminService.class);

	    @Autowired
	    private DccAdminMapper dccAdminMapper;
	    
	    @Override
	     public int selectMemberTotalCnt(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectMemberTotalCnt(dccSearchAdmin);	    	
	    }
	    
	    @Override
	     public List<MemberInfo> selectMemberList(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectMemberList(dccSearchAdmin);	    	
	    }
	    
	    @Override
	     public MemberInfo selectMemberInfo(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectMemberInfo(dccSearchAdmin);	    	
	    }
	    
	    @Override
	    public int insertMemberInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.insertMemberInfo(dccSearchAdmin);
	    }
	    
	    @Override
	    public int updateMemberInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.updateMemberInfo(dccSearchAdmin);
	    }
	    
	    @Override
	    public int deleteMemberInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.deleteMemberInfo(dccSearchAdmin);
	    }
	    
	    @Override
		public List<MemberGroupInfo> selectMemberGroupCombo(){
	    	return dccAdminMapper.selectMemberGroupCombo();	    
		}
		
	    @Override
		public int selectMemberGroupCnt(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.selectMemberGroupCnt(dccSearchAdmin);
	    }
	    
	    @Override
	    public List<MemberGroupInfo> selectMemberGroupList(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectMemberGroupList(dccSearchAdmin);
	    }
	    
	    @Override
	    public int insertMemberGroupInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.insertMemberGroupInfo(dccSearchAdmin);
	    }
		
	    @Override
	    public int deleteMemberGroupInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.deleteMemberGroupInfo(dccSearchAdmin);
	    }
	    
	 // IO LIST
	    @Override
	    public int selectIOListInfoTotalCnt(IOListInfo ioListImfo) {
	    	return dccAdminMapper.selectIOListInfoTotalCnt(ioListImfo);
	    }
		
	    @Override
	    public List<IOListInfo> selectIOListInfoList(IOListInfo ioListImfo) {
	    	return dccAdminMapper.selectIOListInfoList(ioListImfo);
	    }
		
	    @Override
	    public IOListInfo selectIOListInfo(IOListInfo ioListImfo) {
	    	return dccAdminMapper.selectIOListInfo(ioListImfo);
	    }
		
	    @Override
	    public int insertIOListInfo(IOListInfo ioListImfo) {
	    	return dccAdminMapper.insertIOListInfo(ioListImfo);
	    }
		
	    @Override
	    public int updateIOListInfo(IOListInfo ioListImfo) {
	    	return dccAdminMapper.updateIOListInfo(ioListImfo);
	    }
	    
	    @Override
	    public int deleteIOListInfo(IOListInfo ioListImfo) {
	    	return dccAdminMapper.deleteIOListInfo(ioListImfo);
	    }	
	    
	    @Override
	    public int selectImproveTotalCnt(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.selectImproveTotalCnt(dccSearchAdmin);
	    }
	    
	    @Override
	    public List<ImproveInfo> selectImproveList(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectImproveList(dccSearchAdmin);
	    }
	    
	    @Override
	    public int insertImproveInfo(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.insertImproveInfo(dccSearchAdmin);
	    }
		
	    @Override
	    public int updateImproveInfo(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.updateImproveInfo(dccSearchAdmin);
	    }
		
	    @Override
	    public int deleteImproveInfo(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.deleteImproveInfo(dccSearchAdmin);
	    }
	    
	   @Override
	    public int selectSwSmTotalCnt(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectSwSmTotalCnt(dccSearchAdmin);
	    }
  		
	   @Override
	    public List<SwSmInfo> selectSwSmList(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectSwSmList(dccSearchAdmin);
	    }
	   
	   @Override
	    public List<SwSmInfo> selectSwSmExportList(DccSearchAdmin dccSearchAdmin){
		   return dccAdminMapper.selectSwSmExportList(dccSearchAdmin);
	   }
	   
	   @Override
	    public SwSmInfo selectSwSmInfo(DccSearchAdmin dccSearchAdmin) {
		   return dccAdminMapper.selectSwSmInfo(dccSearchAdmin);
	   }
	   
	   @Override
	    public int insertSwSmInfo(DccSearchAdmin dccSearchAdmin) { 
		   return dccAdminMapper.insertSwSmInfo(dccSearchAdmin);
	   }
  		
	   @Override
	    public int deleteSwSmInfo(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.deleteSwSmInfo(dccSearchAdmin);
	    }
  		
	   @Override
	    public int selectHwSmTotalCnt(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectHwSmTotalCnt(dccSearchAdmin);
	    }
  		
	   @Override
	    public List<HwSmInfo> selectHwSmList(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectHwSmList(dccSearchAdmin);
	    }
	   
	   @Override
	    public int insertHwSmInfo(DccSearchAdmin dccSearchAdmin) {
		   return dccAdminMapper.insertHwSmInfo(dccSearchAdmin);
	   }
  		
	   @Override
	    public int deleteHwSmInfo(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.deleteHwSmInfo(dccSearchAdmin);
	    }
	   
	   @Override
	    public int updateHwSmInfo(DccSearchAdmin dccSearchAdmin) {
		   return dccAdminMapper.updateHwSmInfo(dccSearchAdmin);
	   }
	    
	    @Override
	    public int selectEquipTotalCnt(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectEquipTotalCnt(dccSearchAdmin);
	    }
		
	    @Override
	    public List<EquipInfo> selectEquipList(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectEquipList(dccSearchAdmin);
	    }
	    
	    @Override
	    public List<EquipInfo> selectEquipListForExcel(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectEquipList(dccSearchAdmin);
	    }
	    
	    @Override
	    public EquipInfo selectEquipInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.selectEquipInfo(dccSearchAdmin);
	    }
	    
	    @Override
	    public int insertEquipInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.insertEquipInfo(dccSearchAdmin);
	    }
		
	    @Override
	    public int updateEquipInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.updateEquipInfo(dccSearchAdmin);
	    }
		
	    @Override
	    public int deleteEquipInfo(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.deleteEquipInfo(dccSearchAdmin);
	    }
	    
		//재가동 코드 관리
	    @Override
	    public int selectRestartCodeTotalCnt(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectRestartCodeTotalCnt(dccSearchAdmin);
	    }
		
	    @Override
	    public List<RestartCodeInfo> selectRestartCodeList(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.selectRestartCodeList(dccSearchAdmin);
	    }
	    
	    @Override
	    public RestartCodeInfo selectRestartCodeInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.selectRestartCodeInfo(dccSearchAdmin);
	    }
	    
	    @Override
	    public int insertRestartCodeInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.insertRestartCodeInfo(dccSearchAdmin);
	    }
		
	    @Override
	    public int updateRestartCodeInfo(DccSearchAdmin dccSearchAdmin) {
	    	return dccAdminMapper.updateRestartCodeInfo(dccSearchAdmin);
	    }
		
	    @Override
	    public int deleteRestartCodeInfo(DccSearchAdmin dccSearchAdmin){
	    	return dccAdminMapper.deleteRestartCodeInfo(dccSearchAdmin);
	    }
	
}
