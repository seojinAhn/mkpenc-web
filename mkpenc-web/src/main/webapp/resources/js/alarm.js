function mbr_RuntimerEventCallback(data){
	
	var tagDccInfoListBody = $("#tagDccInfoList");
	var tagDccInfoListBodyStr = "";
	
	if( data.DccTagList.length > 0 ) {
	
		var idx=1;
		$.each(data.DccTagList, function(key, value){
			
				tagDccInfoListBodyStr += '<tr>'
											+ ' <td class="tc">'+ value.rowNum +'</td>'
											+ ' <td class="tc">'+ value.Descr +'</td>'
											+ ' <td class="tc">'+ value.IOTYPE +'</td>';
				if( value.IOTYPE == 'DI' || value.IOTYPE == 'DO' ) {
					tagDccInfoListBodyStr = tagDccInfoListBodyStr
										  + '<td class="tc">'+ value.ADDRESS +' : '+ value.IOTYPE +'</td>';
				} else {
					tagDccInfoListBodyStr = tagDccInfoListBodyStr
										  + '<td class="tc">'+ value.ADDRESS +'</td>';
				}
					tagDccInfoListBodyStr = tagDccInfoListBodyStr
										  + ' <td class="tc">'+ value.MinVal +'</td>'
										  + ' <td class="tc">'+ value.ELow +'</td>'
										  + ' <td class="tc">'+ value.EHigh +'</td>'
										  + ' <td class="tc">'+ value.MaxVal +'</td>'
										  + ' <td colspan="2" class="tc" style="background:'+ value.BackColor +'">'+ value.Value +' '+ value.Unit +'</td>'
					                      + '</tr>';
				idx++;                    
		});
		
		tagDccInfoListBody.empty();
		tagDccInfoListBody.append(tagDccInfoListBodyStr);
		
		var DccInfoButtonBody = $("#btnBody");
		var DccInfoButtonBodyStr = "";
		
		if( data.DccTagList[0].rowNum < 25 ) {
			DccInfoButtonBodyStr += '<a class="btn_list primary" id="pageNo1" name="pageNo1" href="javascript:pageChange(2)">다음</a>';
		} else {
			DccInfoButtonBodyStr += '<a class="btn_list primary" id="pageNo2" name="pageNo2" href="javascript:pageChange(1)">이전</a>';
		}
			
		DccInfoButtonBody.empty();
		DccInfoButtonBody.append(DccInfoButtonBodyStr);
		
	} else {
		tagDccInfoListBodyStr += '<tr>'
							   + ' <td class="tc"></td>'
							   + ' <td class="tc"></td>'
							   + ' <td class="tc"></td>'
							   + ' <td class="tc"></td>'
							   + ' <td class="tc"></td>'
							   + ' <td class="tc"></td>'
							   + ' <td class="tc"></td>'
							   + ' <td class="tc"></td>'
							   + ' <td colspan="2" class="tc"></td>'
		                       + '</tr>';
		
		tagDccInfoListBody.empty();
		tagDccInfoListBody.append(tagDccInfoListBodyStr);
		
		var DccInfoButtonBody = $("#btnBody");
		var DccInfoButtonBodyStr = "";
		
		if( data.BaseSearch.pageNum == '1' ) {
			DccInfoButtonBodyStr += '<a class="btn_list primary" id="pageNo1" name="pageNo1" href="javascript:pageChange(2)">다음</a>';
		} else {
			DccInfoButtonBodyStr += '<a class="btn_list primary" id="pageNo2" name="pageNo2" href="javascript:pageChange(1)">이전</a>';
		}
			
		DccInfoButtonBody.empty();
		DccInfoButtonBody.append(DccInfoButtonBodyStr);
	}
}

function mbr_ssqlCallback(data){
	
	var tagDccInfoListBody = $("#ioListAjax");
	var tagDccInfoListBodyStr = "";
	
	if( data.LvIOList.length > 0 ) {
	
		var idx=0;
		$.each(data.LvIOList, function(key, value){
			if( idx == 0 ) {
				tagDccInfoListBodyStr += '<tr>'
									   + '	<td style="display:none">'
									   + '		<input type="hidden" id="ajaxHogi" type="text" value="'+value.hogi+'">'
									   + '		<input type="hidden" id="ajaxXYGubun" type="text" value="'+value.xyGubun+'">'
									   + '		<input type="hidden" id="ajaxLoopName" type="text" value="'+value.loopName+'">'
									   + '		<input type="hidden" id="ajaxIOType" type="text" value="'+value.ioType+'">'
									   + '		<input type="hidden" id="ajaxAddress" type="text" value="'+value.address+'">'
									   + '		<input type="hidden" id="ajaxIOBit" type="text" value="'+value.ioBit+'">'
									   + '		<input type="hidden" id="ajaxMin" type="text" value="'+value.eLow+'">'
									   + '		<input type="hidden" id="ajaxMax" type="text" value="'+value.eHigh+'">'
									   + '		<input type="hidden" id="ajaxSaveCore" type="text" value="'+value.saveCoreChk+'">'
									   + '		<input type="hidden" id="ajaxFastIoChk" type="text" value="'+value.FASTIOCHK+'">'
									   + '		<input type="hidden" id="ajaxISeq" type="text" value="'+value.iSeq+'">'
									   + '	</td>'
									   + '</tr>';
	    	}
	        idx++;
		});
	
		tagDccInfoListBody.empty();
		tagDccInfoListBody.append(tagDccInfoListBodyStr);
	} else {
		tagDccInfoListBodyStr += '<tr>'
							  + '	<td style="display:none">'
							  + '		<input type="hidden" id="ajaxHogi" type="text" value="'+data.BaseSearch.sHogi+'">'
							  + '		<input type="hidden" id="ajaxXYGubun" type="text" value="'+data.BaseSearch.sXYGubun+'">'
							  + '		<input type="hidden" id="ajaxLoopName" type="text" value="">';
		if( data.BaseSearch.ioType == 'undefined' ) {
			tagDccInfoListBodyStr += '		<input type="hidden" id="ajaxIOType" type="text" value="AI">'
		} else {
			tagDccInfoListBodyStr += '		<input type="hidden" id="ajaxIOType" type="text" value="'+data.BaseSearch.ioType+'">'
		}
		tagDccInfoListBodyStr += '		<input type="hidden" id="ajaxAddress" type="text" value="">'
							  + '		<input type="hidden" id="ajaxIOBit" type="text" value="">'
							  + '		<input type="hidden" id="ajaxMin" type="text" value="">'
							  + '		<input type="hidden" id="ajaxMax" type="text" value="">'
							  + '		<input type="hidden" id="ajaxSaveCore" type="text" value="">'
							  + '		<input type="hidden" id="ajaxFastIoChk" type="text" value="">'
							  + '	</td>'
							  + '</tr>';
	
		tagDccInfoListBody.empty();
		tagDccInfoListBody.append(tagDccInfoListBodyStr);
									   
		alert('해당하는 어드레스가 없습니다. 월성3,4호기 원격감시시스템');
	}
	
}

function mbr_cmdEventCallback(data){
	
	var tagDccInfoListBody = $("#lvIolistTable");
	var tagDccInfoListBodyStr = "";
	
	if( data.LvIOList.length > 0 ) {
	
		var idx=0;
		$.each(data.LvIOList, function(key, value){
			//if( idx == 0 ) {
				if( value.gubun == 'D' || value.gubun == 'd') {
					tagDccInfoListBodyStr += '<tr>'
										   + '	<td id="${oListItem.iSeq}gubun${oListItem.hogi}" class="tc">'+value.gubun+'</td>'
										   + '	<td id="${oListItem.iSeq}hogi${oListItem.hogi}" class="tc">'+value.hogi+'</td>'
										   + '	<td id="${oListItem.iSeq}xyGubun${oListItem.hogi}" class="tc">'+value.xyGubun+'</td>'
										   + '	<td id="${oListItem.iSeq}descr${oListItem.hogi}">'+value.Descr+'</td>'
										   + '	<td id="${oListItem.iSeq}ioType${oListItem.hogi}" class="tc">'+value.ioType+'</td>'
										   + '	<td id="${oListItem.iSeq}address${oListItem.hogi}" class="tc">'+value.address+'</td>'
										   + '	<td id="${oListItem.iSeq}ioBit${oListItem.hogi}" class="tc">'+value.ioBit+'</td>'
										   + '	<td id="${oListItem.iSeq}minVal${oListItem.hogi}" class="tc">'+value.minVal+'</td>'
										   + '	<td id="${oListItem.iSeq}maxVal${oListItem.hogi}" class="tc">'+value.maxVal+'</td>'
										   + '	<td id="${oListItem.iSeq}saveCoreChk${oListItem.hogi}" class="tc">'+value.saveCoreChk+'</td>'
										   + '	<td id="${oListItem.iSeq}iSeq${oListItem.hogi}" style="display:none">'+value.iSeq+'</td>'
										   + '</tr>';
				} else {
					tagDccInfoListBodyStr += '<tr>'
										   + '	<td id="${oListItem.iSeq}gubun${oListItem.hogi}" class="tc">'+value.gubun+'</td>'
										   + '	<td id="${oListItem.iSeq}hogi${oListItem.hogi}" class="tc">'+value.hogi_M+'</td>'
										   + '	<td id="${oListItem.iSeq}xyGubun${oListItem.hogi}" class="tc"></td>'
										   + '	<td id="${oListItem.iSeq}descr${oListItem.hogi}">'+value.Descr_M+'"</td>'
										   + '	<td id="${oListItem.iSeq}ioType${oListItem.hogi}" class="tc">'+value.ioType_M+'</td>'
										   + '	<td id="${oListItem.iSeq}address${oListItem.hogi}" class="tc">'+value.address_M+'</td>'
										   + '	<td id="${oListItem.iSeq}ioBit${oListItem.hogi}" class="tc">'+value.ioBit_M+'</td>'
										   + '	<td id="${oListItem.iSeq}minVal${oListItem.hogi}" class="tc">'+value.minVal_M+'</td>'
										   + '	<td id="${oListItem.iSeq}maxVal${oListItem.hogi}" class="tc">'+value.maxVal_M+'</td>'
										   + '	<td id="${oListItem.iSeq}saveCoreChk${oListItem.hogi}" class="tc"></td>'
										   + '	<td id="${oListItem.iSeq}iSeq${oListItem.hogi}" style="display:none">'+value.iSeq+'"</td>'
										   + '</tr>';
				}
									   
	    	//}
	        idx++;
		});
		
	
		tagDccInfoListBody.empty();
		tagDccInfoListBody.append(tagDccInfoListBodyStr);
	} else {
		tagDccInfoListBodyStr += '<tr>'
							   + '	<td class="tc"></td>'
							   + '	<td class="tc"></td>'
							   + '	<td class="tc"></td>'
							   + '	<td></td>'
							   + '	<td class="tc"></td>';
							   + '	<td class="tc"></td>'
							   + '	<td class="tc"></td>'
							   + '	<td class="tc"></td>'
							   + '	<td class="tc"></td>'
							   + '	<td class="tc"></td>'
							   + '	<td style="display:none"></td>'
							   + '</tr>';
	
		tagDccInfoListBody.empty();
		tagDccInfoListBody.append(tagDccInfoListBodyStr);
									   
		alert('해당하는 어드레스가 없습니다. 월성3,4호기 원격감시시스템');
	}
	
}

function mbr_tagSearchCallback(data){
	
	var tagDccInfoListBody = $("#tagSearchList");
	var tagDccInfoListBodyStr = "";
	
	if( data.TagSearchList.length > 0 ) {
	
		var idx=0;
		$.each(data.TagSearchList, function(key, value){
			tagDccInfoListBodyStr += '<tr>'
								   + '	<td class="tc" id="tagISeq">'+value.iSeq+'</td>'
								   + '	<td class="tc" id="tagHogi">'+value.iHogi+'</td>'
								   + '	<td class="tc" id="tagXyGubun">'+value.xyGubun+'</td>'
								   + '	<td class="tc" id="tagLoopName">'+value.loopName+'</td>'
								   + '	<td class="tc" id="tagDescr">'+value.descr+'</td>'
								   + '	<td class="tc" id="tagIoType">'+value.ioType+'</td>'
								   + '	<td class="tc" id="tagAddress">'+value.address+'</td>'
								   + '	<td class="tc" id="tagIoBit">'+value.ioBit+'</td>'
								   + '	<td class="tc" id="tagMin">'+value.eLow+'</td>'
								   + '	<td class="tc" id="tagMax">'+value.eHigh+'</td>'
								   + '	<td class="tc" id="tagSaveCore">'+value.saveCore+'</td>'
								   + '</tr>';
	        idx++;
		});
	} else {
		tagDccInfoListBodyStr += '<tr>'
							   + '	<td class="tc" id="tagISeq"></td>'
							   + '	<td class="tc" id="tagHogi"></td>'
							   + '	<td class="tc" id="tagXyGubun"></td>'
							   + '	<td class="tc" id="tagLoopName"></td>'
							   + '	<td class="tc" id="tagDescr"></td>'
							   + '	<td class="tc" id="tagIoType"></td>'
							   + '	<td class="tc" id="tagAddress"></td>'
							   + '	<td class="tc" id="tagIoBit"></td>'
							   + '	<td class="tc" id="tagMin"></td>'
							   + '	<td class="tc" id="tagMax"></td>'
							   + '	<td class="tc" id="tagSaveCore"></td>'
							   + '</tr>';
	}
	
	tagDccInfoListBody.empty();
	tagDccInfoListBody.append(tagDccInfoListBodyStr);
	
}