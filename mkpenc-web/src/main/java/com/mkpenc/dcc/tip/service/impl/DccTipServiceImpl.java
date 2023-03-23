package com.mkpenc.dcc.tip.service.impl;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkpenc.dcc.tip.mapper.DccTipMapper;
import com.mkpenc.dcc.tip.model.DccIoColumnInfo;
import com.mkpenc.dcc.tip.model.DccIolistInfo;
import com.mkpenc.dcc.tip.model.DccSearchTip;
import com.mkpenc.dcc.tip.service.DccTipService;

@Service("dccTipService")
public class DccTipServiceImpl  implements DccTipService {
	
		private static Logger logger = LoggerFactory.getLogger(DccTipService.class);

	    @Autowired
	    private DccTipMapper dccTipMapper;

		@Override
		public List<DccIolistInfo> selectIoList(DccSearchTip dccSearchTip) {
			return dccTipMapper.selectIoList(dccSearchTip);
		}
		
		@Override
		public List<DccIoColumnInfo> selectIoColumnList(DccSearchTip dccSearchTip) {
			return dccTipMapper.selectIoColumnList(dccSearchTip);
		}
		
		@Override
		public int updateIolistInfo(DccSearchTip dccSearchTip) {
			return dccTipMapper.updateIolistInfo(dccSearchTip);
		}
		
		@Override
		public List<DccIolistInfo> selectIoListExcelDownload(DccSearchTip dccSearchTip) {
			return dccTipMapper.selectIoListExcelDownload(dccSearchTip);
		}
}
