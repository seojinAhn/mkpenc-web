function mbr_RuntimerEventCallback(data){
	
	var tagDccInfoListBody = $("#tagDccInfoList");
	var tagDccInfoListBodyStr = "";
	
	//$("#lblDate").text(data.UserInfo.hogi + " " + data.UserInfo.xyGubun + " " + data.BaseSearch.startDate);
	$("#lblDate").text(data.ScanTime);
	$("#lblDate").css('color',data.ForeColor);
	
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
										  + '<td class="tc">'+ value.hogi+value.xygubun+value.ADDRESS +'</td>';
				}
					tagDccInfoListBodyStr = tagDccInfoListBodyStr
										  + ' <td class="tc">'+ convFormat(value.ELow,4) +'</td>'
										  + ' <td class="tc">'+ convFormat(value.MinVal,4) +'</td>'
										  + ' <td class="tc">'+ convFormat(value.MaxVal,4) +'</td>'
										  + ' <td class="tc">'+ convFormat(value.EHigh,4) +'</td>'
										  + ' <td class="tc" style="background:'+ value.BackColor +'">'+ value.Value +' '+ value.Unit +'</td>'
					                      + '</tr>';
				idx++;                    
		});
		
		tagDccInfoListBody.empty();
		tagDccInfoListBody.append(tagDccInfoListBodyStr);
		
		var DccInfoButtonBody = $("#btnBody");
		var DccInfoButtonBodyStr = "";
		
		if( data.tagSize >= 25 ) {
			if( data.DccTagList[0].rowNum < 25 ) {
				DccInfoButtonBodyStr += '<a class="btn_list primary" id="pageNo1" name="pageNo1" href="javascript:pageChange(2)">다음</a>';
			} else {
				DccInfoButtonBodyStr += '<a class="btn_list primary" id="pageNo2" name="pageNo2" href="javascript:pageChange(1)">이전</a>';
			}
			
			DccInfoButtonBody.empty();
			DccInfoButtonBody.append(DccInfoButtonBodyStr);
		}
		
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
							   + ' <td class="tc"></td>'
		                       + '</tr>';
		
		tagDccInfoListBody.empty();
		tagDccInfoListBody.append(tagDccInfoListBodyStr);
		
		var DccInfoButtonBody = $("#btnBody");
		var DccInfoButtonBodyStr = "";
		
		/*if( data.BaseSearch.pageNum == '1' ) {
			DccInfoButtonBodyStr += '<a class="btn_list primary" id="pageNo1" name="pageNo1" href="javascript:pageChange(2)">다음</a>';
		} else {
			DccInfoButtonBodyStr += '<a class="btn_list primary" id="pageNo2" name="pageNo2" href="javascript:pageChange(1)">이전</a>';
		}*/
			
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

function mbr_FixedTimeControlCallback(data){
	
	var tagDccInfoListBody;
	var tagDccInfoListBodyStr = "";

	if( data.BaseSearch.pType == '003' ) {
		if( typeof data.FixedAlarmList[0][0] != 'undefined' ) {
			tagDccInfoListBody = $("#003Body1");

			for( var idx=0;idx<36;idx++ ) {
				if( idx < 18 ) {
					tagDccInfoListBodyStr += '<tr>';
					if( idx == 0 ) {
						tagDccInfoListBodyStr += '<td id="0lblTitle003" class="tc" rowspan="6">채널 "G"</td>'
					}
					if( idx == 6 ) {
						tagDccInfoListBodyStr += '<td id="1lblTitle003" class="tc" rowspan="6">채널 "H"</td>'
					}
					if( idx == 12 ) {
						tagDccInfoListBodyStr += '<td id="2lblTitle003" class="tc" rowspan="6">채널 "J"</td>'
					}
	                tagDccInfoListBodyStr += '<td id="'+idx+'lblCI003" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblStart003" class="tc">'+data.FixedAlarmList[0][idx]+'</td>'
	                					   + '	<td id="'+idx+'lblEnd003" class="tc">'+data.FixedAlarmList[1][idx]+'</td>'
	                					   + '	<td id="'+idx+'lblCha003" class="tc" style="color:red">'+data.FixedAlarmList[2][idx]+'</td>'
	                					   + '</tr>';
				} else {
					if( idx == 18 ) {
						tagDccInfoListBody.empty();
						tagDccInfoListBody.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>';
					if( idx == 18 ) {
						tagDccInfoListBodyStr += '<td id="3lblTitle003" class="tc" rowspan="6">채널 "G"</td>'
					}
					if( idx == 24 ) {
						tagDccInfoListBodyStr += '<td id="4lblTitle003" class="tc" rowspan="6">채널 "H"</td>'
					}
					if( idx == 30 ) {
						tagDccInfoListBodyStr += '<td id="5lblTitle003" class="tc" rowspan="6">채널 "J"</td>'
					}
	                tagDccInfoListBodyStr += '<td id="'+idx+'lblCI003" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblStart003" class="tc">'+data.FixedAlarmList[0][idx]+'</td>'
	                					   + '	<td id="'+idx+'lblEnd003" class="tc">'+data.FixedAlarmList[1][idx]+'</td>'
	                					   + '	<td id="'+idx+'lblCha003" class="tc" style="color:red">'+data.FixedAlarmList[2][idx]+'</td>'
	                					   + '</tr>';
				}
			}
			var tagDccInfoListBody2 = $("#003Body2");

			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr);
		} else {
			tagDccInfoListBody = $("#003Body1");
			
			for( var idx=0;idx<36;idx++ ) {
				if( idx < 18 ) {
					tagDccInfoListBodyStr += '<tr>';
					if( idx == 0 ) {
						tagDccInfoListBodyStr += '<td id="0lblTitle003" class="tc" rowspan="6">채널 "G"</td>'
					}
					if( idx == 6 ) {
						tagDccInfoListBodyStr += '<td id="1lblTitle003" class="tc" rowspan="6">채널 "H"</td>'
					}
					if( idx == 12 ) {
						tagDccInfoListBodyStr += '<td id="2lblTitle003" class="tc" rowspan="6">채널 "J"</td>'
					}
	                tagDccInfoListBodyStr += '<td id="'+idx+'lblCI003" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblStart003" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblEnd003" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblCha003" class="tc" style="color:red"></td>'
	                					   + '</tr>';
				} else {
					if( idx == 18 ) {
						tagDccInfoListBody.empty();
						tagDccInfoListBody.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>';
					if( idx == 18 ) {
						tagDccInfoListBodyStr += '<td id="3lblTitle003" class="tc" rowspan="6">채널 "G"</td>'
					}
					if( idx == 24 ) {
						tagDccInfoListBodyStr += '<td id="4lblTitle003" class="tc" rowspan="6">채널 "H"</td>'
					}
					if( idx == 30 ) {
						tagDccInfoListBodyStr += '<td id="5lblTitle003" class="tc" rowspan="6">채널 "J"</td>'
					}
	                tagDccInfoListBodyStr += '<td id="'+idx+'lblCI003" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblStart003" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblEnd003" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblCha003" class="tc" style="color:red"></td>'
	                					   + '</tr>';
				}
			}
			var tagDccInfoListBody2 = $("#003Body2");

			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr);
		}
	} else if( data.BaseSearch.pType == '032') {
		if( typeof data.FixedAlarmList[0][0] != 'undefined' ) { 
			tagDccInfoListBody = $("#032Body");
			
			for( var idx=0;idx<12;idx++ ) {
				tagDccInfoListBodyStr += '<tr>';
				if( idx == 0 ) {
					tagDccInfoListBodyStr += '	<td id="0lblTitle032" class="tc" rowspan="4">채널 "D"</td>';
				}
				if( idx == 4 ) {
					tagDccInfoListBodyStr += '	<td id="1lblTitle032" class="tc" rowspan="4">채널 "E"</td>';
				}
				if( idx == 8 ) {
					tagDccInfoListBodyStr += '	<td id="2lblTitle032" class="tc" rowspan="4">채널 "F"</td>';
				}
                tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI032" class="tc"></td>'
									   + '	<td id="'+idx+'lblStart032" class="tc">'+data.FixedAlarmList[0][idx]+'</td>'
									   + '	<td id="'+idx+'lblEnd032" class="tc">'+data.FixedAlarmList[1][idx]+'</td>'
									   + '	<td id="'+idx+'lblCha032" class="tc" style="color:red">'+data.FixedAlarmList[2][idx]+'</td>'
                                	   + '</tr>';
			}
			//alert(tagDccInfoListBodyStr)
			tagDccInfoListBody.empty();
			tagDccInfoListBody.append(tagDccInfoListBodyStr);
		} else {
			tagDccInfoListBody = $("#032Body");
			
			for( var idx=0;idx<12;idx++ ) {
				tagDccInfoListBodyStr += '<tr>';
				if( idx == 0 ) {
					tagDccInfoListBodyStr += '	<td id="0lblTitle032" class="tc" rowspan="4">채널 "D"</td>';
				}
				if( idx == 4 ) {
					tagDccInfoListBodyStr += '	<td id="1lblTitle032" class="tc" rowspan="4">채널 "E"</td>';
				}
				if( idx == 8 ) {
					tagDccInfoListBodyStr += '	<td id="2lblTitle032" class="tc" rowspan="4">채널 "F"</td>';
				}
                tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI032" class="tc"></td>'
									   + '	<td id="'+idx+'lblStart032" class="tc"></td>'
									   + '	<td id="'+idx+'lblEnd032" class="tc"></td>'
									   + '	<td id="'+idx+'lblCha032" class="tc" style="color:red"></td>'
                                	   + '</tr>';
			}
			
			tagDccInfoListBody.empty();
			tagDccInfoListBody.append(tagDccInfoListBodyStr);
		}
	} else if( data.BaseSearch.pType == '114') {
		if( typeof data.FixedAlarmList[0][0] != 'undefined' ) {
			tagDccInfoListBody = $("#114Body1");
			
			for( var idx=0;idx<36;idx++ ) {
				if( idx < 18 ) {
					tagDccInfoListBodyStr += '<tr>';
					if( idx%3 == 0 ) {
						tagDccInfoListBodyStr += '	<td id="'+(idx/3)+'lblVal" class="tc" rowspan="3"></td>';
					}
	                tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblStart" class="tc">'+data.FixedAlarmList[0][idx]+'</td>'
	                					   + '	<td id="'+idx+'lblEnd" class="tc">'+data.FixedAlarmList[1][idx]+'</td>'
	                					   + '	<td id="'+idx+'lblCha" class="tc" style="color:red">'+data.FixedAlarmList[2][idx]+'</td>'
	                					   + '</tr>';
	        	} else {
					if( idx == 18 ) {
						tagDccInfoListBody.empty();
						tagDccInfoListBody.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>';
					if( idx%3 == 0 ) {
						tagDccInfoListBodyStr += '	<td id="'+(idx/3)+'lblVal" class="tc" rowspan="3"></td>';
					}
	                tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblStart" class="tc">'+data.FixedAlarmList[0][idx]+'</td>'
	                					   + '	<td id="'+idx+'lblEnd" class="tc">'+data.FixedAlarmList[1][idx]+'</td>'
	                					   + '	<td id="'+idx+'lblCha" class="tc" style="color:red">'+data.FixedAlarmList[2][idx]+'</td>'
	                					   + '</tr>';
				}
			}
			var tagDccInfoListBody2 = $("#114Body2");
			
			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr);
		} else {
			tagDccInfoListBody = $("#114Body1");
			
			for( var idx=0;idx<36;idx++ ) {
				if( idx < 18 ) {
					tagDccInfoListBodyStr += '<tr>';
					if( idx%3 == 0 ) {
						tagDccInfoListBodyStr += '	<td id="'+(idx/3)+'lblVal" class="tc" rowspan="3"></td>';
					}
	                tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblStart" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblEnd" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblCha" class="tc" style="color:red"></td>'
	                					   + '</tr>';
	        	} else {
					if( idx == 18 ) {
						tagDccInfoListBody.empty();
						tagDccInfoListBody.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>';
					if( idx%3 == 0 ) {
						tagDccInfoListBodyStr += '	<td id="'+(idx/3)+'lblVal" class="tc" rowspan="3"></td>';
					}
	                tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblStart" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblEnd" class="tc"></td>'
	                					   + '	<td id="'+idx+'lblCha" class="tc" style="color:red"></td>'
	                					   + '</tr>';
				}
			}
			var tagDccInfoListBody2 = $("#114Body2");
			
			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr);
		}
	} else if( data.BaseSearch.pType == '118') {
		if( typeof data.FixedAlarmList[0][0] != 'undefined' ) {
			tagDccInfoListBody = $("#118Body1");
			
			for( var idx=0;idx<84;idx++ ) {
				if( idx < 24 ) {
					tagDccInfoListBodyStr += '<tr>'
	             						   + '	<td id="'+idx+'lblTitle118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	           							   + '	<td id="'+idx+'lblCI118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	            						   + '	<td id="'+idx+'lblStart118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[0][idx]+'</td>'
	           							   + '	<td id="'+idx+'lblBigo118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[1][idx]+'</td>'
	            						   + '</tr>';
	            } else if( idx < 48 ) {
					if( idx == 24 ) {
						tagDccInfoListBody.empty();
						tagDccInfoListBody.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>'
	             						   + '	<td id="'+idx+'lblTitle118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	           							   + '	<td id="'+idx+'lblCI118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	            						   + '	<td id="'+idx+'lblStart118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[0][idx]+'</td>'
	           							   + '	<td id="'+idx+'lblBigo118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[1][idx]+'</td>'
	            						   + '</tr>';
	        	} else if( idx < 72 ) {
					if( idx == 48 ) {
						var tagDccInfoListBody2 = $("#118Body2");
						
						tagDccInfoListBody2.empty();
						tagDccInfoListBody2.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>'
	             						   + '	<td id="'+idx+'lblTitle118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	           							   + '	<td id="'+idx+'lblCI118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	            						   + '	<td id="'+idx+'lblStart118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[0][idx]+'</td>'
	           							   + '	<td id="'+idx+'lblBigo118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[1][idx]+'</td>'
	            						   + '</tr>';
				} else if( idx < 76 ) {
					if( idx == 72 ) {
						var tagDccInfoListBody3 = $("#118Body3");
						
						tagDccInfoListBody3.empty();
						tagDccInfoListBody3.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>'
	             						   + '	<td id="'+idx+'lblTitle118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	           							   + '	<td id="'+idx+'lblCI118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	            						   + '	<td id="'+idx+'lblStart118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[0][idx]+'</td>'
	           							   + '	<td id="'+idx+'lblBigo118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[1][idx]+'</td>'
	            						   + '</tr>';
				} else if( idx < 80 ) {
					if( idx == 76 ) {
						var tagDccInfoListBody4 = $("#118Body4");
						
						tagDccInfoListBody4.empty();
						tagDccInfoListBody4.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>'
	             						   + '	<td id="'+idx+'lblTitle118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	           							   + '	<td id="'+idx+'lblCI118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	            						   + '	<td id="'+idx+'lblStart118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[0][idx]+'</td>'
	           							   + '	<td id="'+idx+'lblBigo118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[1][idx]+'</td>'
	            						   + '</tr>';
				} else if( idx < 84 ) {
					if( idx == 80 ) {
						var tagDccInfoListBody5 = $("#118Body5");
						
						tagDccInfoListBody5.empty();
						tagDccInfoListBody5.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>'
	             						   + '	<td id="'+idx+'lblTitle118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	           							   + '	<td id="'+idx+'lblCI118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'"></td>'
	            						   + '	<td id="'+idx+'lblStart118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[0][idx]+'</td>'
	           							   + '	<td id="'+idx+'lblBigo118" class="tc" style="color:'+data.FixedAlarmList[2][idx]+'">'+data.FixedAlarmList[1][idx]+'</td>'
	            						   + '</tr>';
				}
			}
			var tagDccInfoListBody6 = $("#118Body6");
			
			tagDccInfoListBody6.empty();
			tagDccInfoListBody6.append(tagDccInfoListBodyStr);
		} else {
			tagDccInfoListBody = $("#118Body1");
			for( var idx=0;idx<24;idx++ ) {
				tagDccInfoListBodyStr += '<tr>'
             						   + '	<td id="'+idx+'lblTitle118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblCI118" class="tc"></td>'
            						   + '	<td id="'+idx+'lblStart118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblBigo118" class="tc"></td>'
            						   + '</tr>';
            }
            tagDccInfoListBody.empty();
			tagDccInfoListBody.append(tagDccInfoListBodyStr);
			tagDccInfoListBodyStr = '';
			for( var idx=24;idx<48;idx++ ) {
				tagDccInfoListBodyStr += '<tr>'
             						   + '	<td id="'+idx+'lblTitle118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblCI118" class="tc"></td>'
            						   + '	<td id="'+idx+'lblStart118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblBigo118" class="tc"></td>'
            						   + '</tr>';
            }
            var tagDccInfoListBody2 = $("#118Body2");
            tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr);
			tagDccInfoListBodyStr = '';
			for( var idx=48;idx<72;idx++ ) {
				tagDccInfoListBodyStr += '<tr>'
             						   + '	<td id="'+idx+'lblTitle118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblCI118" class="tc"></td>'
            						   + '	<td id="'+idx+'lblStart118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblBigo118" class="tc"></td>'
            						   + '</tr>';
            }
            var tagDccInfoListBody2 = $("#118Body3");
            tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr);
			for( var idx=72;idx<76;idx++ ) {
				tagDccInfoListBodyStr += '<tr>'
             						   + '	<td id="'+idx+'lblTitle118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblCI118" class="tc"></td>'
            						   + '	<td id="'+idx+'lblStart118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblBigo118" class="tc"></td>'
            						   + '</tr>';
            }
            var tagDccInfoListBody3 = $("#118Body4");
            tagDccInfoListBody3.empty();
			tagDccInfoListBody3.append(tagDccInfoListBodyStr);
			for( var idx=76;idx<80;idx++ ) {
				tagDccInfoListBodyStr += '<tr>'
             						   + '	<td id="'+idx+'lblTitle118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblCI118" class="tc"></td>'
            						   + '	<td id="'+idx+'lblStart118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblBigo118" class="tc"></td>'
            						   + '</tr>';
            }
            var tagDccInfoListBody4 = $("#118Body5");
            tagDccInfoListBody4.empty();
			tagDccInfoListBody4.append(tagDccInfoListBodyStr);
			for( var idx=80;idx<84;idx++ ) {
				tagDccInfoListBodyStr += '<tr>'
             						   + '	<td id="'+idx+'lblTitle118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblCI118" class="tc"></td>'
            						   + '	<td id="'+idx+'lblStart118" class="tc"></td>'
           							   + '	<td id="'+idx+'lblBigo118" class="tc"></td>'
            						   + '</tr>';
            }
            var tagDccInfoListBody5 = $("#118Body6");
            tagDccInfoListBody5.empty();
			tagDccInfoListBody5.append(tagDccInfoListBodyStr);
		}
	} else if( data.BaseSearch.pType == '276') {
		if( typeof data.FixedAlarmList[0][0] != 'undefined' ) {
			tagDccInfoListBody = $("#276Body1");
			
			for( var idx=0;idx<24;idx++ ) {
				if( idx < 12 ) {
					tagDccInfoListBodyStr += '<tr>';
					if( idx%2 == 0 ) {
						tagDccInfoListBodyStr += '	<td id="'+(idx/2)+'lblTitle276" class="tc" rowspan="2"></td>';
					}
					tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI276" class="tc"></td>'
										   + '	<td id="'+idx+'lblStart276" class="tc">'+data.FixedAlarmList[0][idx]+'</td>'
										   + '	<td id="'+idx+'lblEnd276" class="tc">'+data.FixedAlarmList[1][idx]+'</td>'
										   + '	<td id="'+idx+'lblCha276" class="tc" style="color:red">'+data.FixedAlarmList[2][idx]+'</td>'
										   + '</tr>';
				} else {
					if( idx == 12 ) {
						tagDccInfoListBody.empty();
						tagDccInfoListBody.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>';
					if( idx%2 == 0 ) {
						tagDccInfoListBodyStr += '	<td id="'+(idx/2)+'lblTitle276" class="tc" rowspan="2"></td>';
					}
					tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI276" class="tc"></td>'
										   + '	<td id="'+idx+'lblStart276" class="tc">'+data.FixedAlarmList[0][idx]+'</td>'
										   + '	<td id="'+idx+'lblEnd276" class="tc">'+data.FixedAlarmList[1][idx]+'</td>'
										   + '	<td id="'+idx+'lblCha276" class="tc" style="color:red">'+data.FixedAlarmList[2][idx]+'</td>'
										   + '</tr>';
				}
			}
			var tagDccInfoListBody2 = $("#276Body2");
		
			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr);
		} else {
			tagDccInfoListBody = $("#276Body1");
			
			for( var idx=0;idx<24;idx++ ) {
				if( idx < 12 ) {
					tagDccInfoListBodyStr += '<tr>';
					if( idx%2 == 0 ) {
						tagDccInfoListBodyStr += '	<td id="'+(idx/2)+'lblTitle276" class="tc" rowspan="2"></td>';
					}
					tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI276" class="tc"></td>'
										   + '	<td id="'+idx+'lblStart276" class="tc"></td>'
										   + '	<td id="'+idx+'lblEnd276" class="tc"></td>'
										   + '	<td id="'+idx+'lblCha276" class="tc" style="color:red"></td>'
										   + '</tr>';
				} else {
					if( idx == 12 ) {
						tagDccInfoListBody.empty();
						tagDccInfoListBody.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '';
					}
					tagDccInfoListBodyStr += '<tr>';
					if( idx%2 == 0 ) {
						tagDccInfoListBodyStr += '	<td id="'+(idx/2)+'lblTitle276" class="tc" rowspan="2"></td>';
					}
					tagDccInfoListBodyStr += '	<td id="'+idx+'lblCI276" class="tc"></td>'
										   + '	<td id="'+idx+'lblStart276" class="tc"></td>'
										   + '	<td id="'+idx+'lblEnd276" class="tc"></td>'
										   + '	<td id="'+idx+'lblCha276" class="tc" style="color:red"></td>'
										   + '</tr>';
				}
			}
			var tagDccInfoListBody2 = $("#276Body2");
			
			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr);
		}
	} else if( data.BaseSearch.pType == '550') {
		if( typeof data.FixedAlarmList[0][0] != 'undefined' ) {
			tagDccInfoListBody = $("#550Body1");
			
			tagDccInfoListBodyStr += '<tr>'
								   + '	<td class="tc" rowspan="6">1회</td>'
								   + '	<td class="tc" rowspan="2">기계적 구동시간</td>'
								   + '	<td id="0lblTitle550" class="tc"></td>'
								   + '	<td id="0lblStartS550" class="tc">'+data.FixedAlarmList[0][0]+'</td>'
								   + '	<td id="0lblChaS550" class="tc" rowspan="2" style="color:'+data.FixedAlarmList[7][0]+'">'+data.FixedAlarmList[6][0]+'</td>'
								   + '	<td class="tc" rowspan="2">≤ 2.25</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td id="1lblTitle550" class="tc"></td>'
								   + '	<td id="0lblEndS550" class="tc">'+data.FixedAlarmList[1][0]+'</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc" rowspan="2">밸브 열림시간<br>(루프응답시간 포함)</td>'
								   + '	<td id="2lblTitle550" class="tc"></td>'
								   + '	<td id="0lblStartA550" class="tc">'+data.FixedAlarmList[2][0]+'</td>'
								   + '	<td id="0lblChaA550" class="tc" rowspan="2" style="color:'+data.FixedAlarmList[9][0]+'">'+data.FixedAlarmList[8][0]+'</td>'
								   + '	<td class="tc" rowspan="2">≤ 4.75</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td id="3lblTitle550" class="tc"></td>'
								   + '	<td id="0lblEndA550" class="tc">'+data.FixedAlarmList[3][0]+'</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc" rowspan="2">밸브 닫힘시간</td>'
								   + '	<td id="4lblTitle550" class="tc"></td>'
								   + '	<td id="0lblStartB550" class="tc">'+data.FixedAlarmList[4][0]+'</td>'
								   + '	<td id="0lblChaB550" class="tc" rowspan="2" style="color:'+data.FixedAlarmList[11][0]+'">'+data.FixedAlarmList[10][0]+'</td>'
								   + '	<td class="tc" rowspan="2">7~15</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td id="5lblTitle550" class="tc"></td>'
								   + '	<td id="0lblEndB550" class="tc">'+data.FixedAlarmList[5][0]+'</td>'
								   + '</tr>';
								   
			tagDccInfoListBody.empty();
			tagDccInfoListBody.append(tagDccInfoListBodyStr);
			
			var tagDccInfoListBody2 = $("#550Body2");
			var tagDccInfoListBodyStr2 = '';
			
			for( var ai=1;ai<10;ai++ ) {
				tagDccInfoListBodyStr2 += '<tr>'
									   + '	<td class="tc">'+(ai+1)+'회</td>'
									   + '	<td id="'+ai+'lblStartA550" class="tc">'+data.FixedAlarmList[2][ai]+'</td>'
									   + '	<td id="'+ai+'1lblEndA550" class="tc">'+data.FixedAlarmList[3][ai]+'</td>'
									   + '	<td id="'+ai+'lblChaA550" class="tc" style="color:'+data.FixedAlarmList[9][ai]+'">'+data.FixedAlarmList[8][ai]+'</td>'
									   + '	<td class="tc">≤ 7</td>'
									   + '</tr>';
			}
			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr2);
			
			var tagDccInfoListBody3 = $("#550Body3");
			var tagDccInfoListBodyStr3 = '';
			
			for( var bi=1;bi<10;bi++ ) {
				tagDccInfoListBodyStr3 += '<tr>'
									   + '	<td class="tc">'+(bi+1)+'회</td>'
									   + '	<td id="'+bi+'lblStartB550" class="tc">'+data.FixedAlarmList[4][bi]+'</td>'
									   + '	<td id="'+bi+'1lblEndB550" class="tc">'+data.FixedAlarmList[5][bi]+'</td>'
									   + '	<td id="'+bi+'lblChaB550" class="tc" style="color:'+data.FixedAlarmList[11][bi]+'">'+data.FixedAlarmList[10][bi]+'</td>'
									   + '	<td class="tc">7~15</td>'
									   + '</tr>';
			}
			tagDccInfoListBody3.empty();
			tagDccInfoListBody3.append(tagDccInfoListBodyStr3);
		} else {
			tagDccInfoListBody = $("#550Body1");
			
			tagDccInfoListBodyStr += '<tr>'
								   + '	<td class="tc" rowspan="6">1회</td>'
								   + '	<td class="tc" rowspan="2">기계적 구동시간</td>'
								   + '	<td id="0lblTitle550" class="tc"></td>'
								   + '	<td id="0lblStartS550" class="tc"></td>'
								   + '	<td id="0lblChaS550" class="tc" rowspan="2"></td>'
								   + '	<td class="tc" rowspan="2">≤ 2.25</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td id="1lblTitle550" class="tc"></td>'
								   + '	<td id="0lblEndS550" class="tc"></td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc" rowspan="2">밸브 열림시간<br>(루프응답시간 포함)</td>'
								   + '	<td id="2lblTitle550" class="tc"></td>'
								   + '	<td id="0lblStartA550" class="tc"></td>'
								   + '	<td id="0lblChaA550" class="tc" rowspan="2"></td>'
								   + '	<td class="tc" rowspan="2">≤ 4.75</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td id="3lblTitle550" class="tc"></td>'
								   + '	<td id="0lblEndA550" class="tc"></td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc" rowspan="2">밸브 닫힘시간</td>'
								   + '	<td id="4lblTitle550" class="tc"></td>'
								   + '	<td id="0lblStartB550" class="tc"></td>'
								   + '	<td id="0lblChaB550" class="tc" rowspan="2"></td>'
								   + '	<td class="tc" rowspan="2">7~15</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td id="5lblTitle550" class="tc"></td>'
								   + '	<td id="0lblEndB550" class="tc"></td>'
								   + '</tr>';
								   
			tagDccInfoListBody.empty();
			tagDccInfoListBody.append(tagDccInfoListBodyStr);
			
			var tagDccInfoListBody2 = $("#550Body2");
			var tagDccInfoListBodyStr2 = '';
			
			for( var ai=1;ai<10;ai++ ) {
				tagDccInfoListBodyStr2 += '<tr>'
									   + '	<td class="tc">'+(ai+1)+'회</td>'
									   + '	<td id="'+ai+'lblStartA550" class="tc"></td>'
									   + '	<td id="'+ai+'1lblEndA550" class="tc"></td>'
									   + '	<td id="'+ai+'lblChaA550" class="tc"></td>'
									   + '	<td class="tc">≤ 7</td>'
									   + '</tr>';
			}
			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr2);
			
			var tagDccInfoListBody3 = $("#550Body3");
			var tagDccInfoListBodyStr3 = '';
			
			for( var bi=1;bi<10;bi++ ) {
				tagDccInfoListBodyStr3 += '<tr>'
									   + '	<td class="tc">'+(bi+1)+'회</td>'
									   + '	<td id="'+bi+'lblStartB550" class="tc"></td>'
									   + '	<td id="'+bi+'1lblEndB550" class="tc"></td>'
									   + '	<td id="'+bi+'lblChaB550" class="tc"></td>'
									   + '	<td class="tc">7~15</td>'
									   + '</tr>';
			}
			tagDccInfoListBody3.empty();
			tagDccInfoListBody3.append(tagDccInfoListBodyStr3);
		}
	} else if( data.BaseSearch.pType == 'cor' ) {
		var tagDccInfoListBody = $("#coreBody1");
		if( typeof data.FixedAlarmList[0][0] != 'undefined' ) {
			for( var idx=0;idx<24;idx ++ ) {
				if( idx%2 == 0 ) {
					tagDccInfoListBodyStr += '<tr>';
					if( idx == 0 ) {
						tagDccInfoListBodyStr += '	<td id="0lblTitleCha" class="tc" rowspan="12">채널 "G"</td>';
					} else if( idx == 8 ) {
						tagDccInfoListBodyStr += '	<td id="1lblTitleCha" class="tc" rowspan="12">채널 "H"</td>';
					} else if( idx == 16 ) {
						tagDccInfoListBody.empty();
						tagDccInfoListBody.append(tagDccInfoListBodyStr);
						
						tagDccInfoListBodyStr = '<tr>'
											  + '	<td id="2lblTitleCha" class="tc" rowspan="12">채널 "J"</td>';
					}
					tagDccInfoListBodyStr += '	<td id="'+(idx/2)+'lblLoop" class="tc" rowspan="3"></td>'
										   + '	<td id="'+idx+'lblCICh" class="tc"></td>'
										   + '	<td id="'+idx+'lblStartCha" class="tc">'+data.FixedAlarmList[0][idx]+'</td>'
										   + '	<td id="'+idx+'lblEndCha" class="tc">'+data.FixedAlarmList[1][idx]+'</td>'
										   + '	<td id="'+idx+'lblValCha" class="tc" style="color:red">'+data.FixedAlarmList[2][idx]+'</td>'
										   + '</tr>'
										   + '<tr>'
										   + '	<td id="'+(idx+1)+'lblCICh" class="tc"></td>'
										   + '	<td id="'+(idx+1)+'lblStartCha" class="tc">'+data.FixedAlarmList[0][idx+1]+'</td>'
										   + '	<td id="'+(idx+1)+'lblEndCha" class="tc">'+data.FixedAlarmList[1][idx+1]+'</td>'
										   + '	<td id="'+(idx+1)+'lblValCha" class="tc" style="color:red">'+data.FixedAlarmList[2][idx+1]+'</td>'
										   + '</tr>'
										   + '<tr>'
										   + '	<td class="tc"></td>'
										   + '	<td id="'+(idx/2)+'lblLoopDescr" class="tc" colspan="2"></td>'
										   + '	<td id="'+(idx/2)+'lblValChaCha" class="tc" style="color:blue">'+data.FixedAlarmList[3][idx/2]+'</td>'
										   + '</tr>';
				}
				
				if( idx == 23 ) {
					var tagDccInfoListBody2 = $("#coreBody2");
					
					tagDccInfoListBody2.empty();
					tagDccInfoListBody2.append(tagDccInfoListBodyStr);
				}
			}
		} else {
			for( var idx=0;idx<24;idx++ ) {
				if( idx < 16 ) {
					tagDccInfoListBody = $("#coreBody1");
					
					if( idx%2 == 0 ) {
						tagDccInfoListBodyStr += '<tr>'
						if( idx == 0 ) {
							tagDccInfoListBodyStr += '	<td id="0lblTitleCha" class="tc" rowspan="12">채널 "G"</td>';
						} else if( idx == 0 ) {
							tagDccInfoListBodyStr += '	<td id="1lblTitleCha" class="tc" rowspan="12">채널 "H"</td>';
						} else if( idx == 16 ) {
							tagDccInfoListBody.empty();
							tagDccInfoListBody.append(tagDccInfoListBodyStr);
							
							tagDccInfoListBodyStr = '<tr>'
												  + '	<td id="1lblTitleCha" class="tc" rowspan="12">채널 "J"</td>';
						}
						tagDccInfoListBodyStr += '	<td id="'+(idx/2)+'lblLoop" class="tc" rowspan="3"></td>'
											   + '	<td id="'+idx+'lblCICh" class="tc"></td>'
											   + '	<td id="'+idx+'lblStartCha" class="tc"></td>'
											   + '	<td id="'+idx+'lblEndCha" class="tc"></td>'
											   + '	<td id="'+idx+'lblValCha" class="tc" style="color:red"></td>'
											   + '</tr>'
											   + '<tr>'
											   + '	<td id="'+(idx+1)+'lblCICh" class="tc"></td>'
											   + '	<td id="'+(idx+1)+'lblStartCha" class="tc"></td>'
											   + '	<td id="'+(idx+1)+'lblEndCha" class="tc"></td>'
											   + '	<td id="'+(idx+1)+'lblValCha" class="tc" style="color:red"></td>'
											   + '</tr>'
											   + '<tr>'
											   + '	<td class="tc"></td>'
											   + '	<td id="'+(idx/2)+'lblLoopDescr" class="tc" colspan="2"></td>'
											   + '	<td id="'+(idx/2)+'lblValChaCha" class="tc" style="color:blue"></td>'
											   + '</tr>';
					}
				}
			}
			var tagDccInfoListBody2 = $("#coreBody2");

			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr);
		}
	} else if( data.BaseSearch.pType == '285' ) {
		tagDccInfoListBody = $("#285Body");
		
		if( typeof data.FixedAlarmList[0][0] != 'undefined' ) {
			tagDccInfoListBodyStr += '<tr>'
								   + '	<td class="tc" rowspan="2">K</td>'
								   + '	<td class="tc">5#1, 6#1, 7#1</td>'
								   + '	<td id="0lblMOI" class="tc" rowspan="2"></td>'
								   + '	<td id="0lblMOIDate" class="tc" rowspan="2">'+data.FixedAlarmList[0][0]+'</td>'
								   + '	<td id="0lblRelay" class="tc"></td>'
								   + '	<td id="0lblLRF" class="tc"></td>'
								   + '	<td id="0lblLRFDate" class="tc">'+data.FixedAlarmList[1][0]+'</td>'
								   + '	<td id="0lblResult" class="tc">'+data.FixedAlarmList[2][0]+'</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc">5#4, 6#4, 8#4</td>'
								   + '	<td id="1lblRelay" class="tc"></td>'
								   + '	<td id="1lblLRF" class="tc"></td>'
								   + '	<td id="1lblLRFDate" class="tc">'+data.FixedAlarmList[1][1]+'</td>'
								   + '	<td id="1lblResult" class="tc">'+data.FixedAlarmList[2][1]+'</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc" rowspan="2">L</td>'
								   + '	<td class="tc">7#4, 8#2</td>'
								   + '	<td id="1lblMOI" class="tc" rowspan="2"></td>'
								   + '	<td id="1lblMOIDate" class="tc" rowspan="2">'+data.FixedAlarmList[0][1]+'</td>'
								   + '	<td id="2lblRelay" class="tc"></td>'
								   + '	<td id="2lblLRF" class="tc"></td>'
								   + '	<td id="2lblLRFDate" class="tc">'+data.FixedAlarmList[1][2]+'</td>'
								   + '	<td id="2lblResult" class="tc">'+data.FixedAlarmList[2][2]+'</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc">5#2, 7#2, 6#2</td>'
								   + '	<td id="3lblRelay" class="tc"></td>'
								   + '	<td id="3lblLRF" class="tc"></td>'
								   + '	<td id="3lblLRFDate" class="tc">'+data.FixedAlarmList[1][3]+'</td>'
								   + '	<td id="3lblResult" class="tc">'+data.FixedAlarmList[2][3]+'</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc" rowspan="2">M</td>'
								   + '	<td class="tc">6#3, 7#3, 8#3</td>'
								   + '	<td id="2lblMOI" class="tc" rowspan="2"></td>'
								   + '	<td id="2lblMOIDate" class="tc" rowspan="2">'+data.FixedAlarmList[0][2]+'</td>'
								   + '	<td id="4lblRelay" class="tc"></td>'
								   + '	<td id="4lblLRF" class="tc"></td>'
								   + '	<td id="4lblLRFDate" class="tc">'+data.FixedAlarmList[1][4]+'</td>'
								   + '	<td id="4lblResult" class="tc">'+data.FixedAlarmList[2][4]+'</td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc">8#4, 5#3</td>'
								   + '	<td id="5lblRelay" class="tc"></td>'
								   + '	<td id="5lblLRF" class="tc"></td>'
								   + '	<td id="5lblLRFDate" class="tc">'+data.FixedAlarmList[1][5]+'</td>'
								   + '	<td id="5lblResult" class="tc">'+data.FixedAlarmList[2][5]+'</td>'
								   + '</tr>';
	
			tagDccInfoListBody.empty();
			tagDccInfoListBody.append(tagDccInfoListBodyStr);
    	} else {
			tagDccInfoListBodyStr += '<tr>'
								   + '	<td class="tc" rowspan="2">K</td>'
								   + '	<td class="tc">5#1, 6#1, 7#1</td>'
								   + '	<td id="0lblMOI" class="tc" rowspan="2"></td>'
								   + '	<td id="0lblMOIDate" class="tc" rowspan="2"></td>'
								   + '	<td id="0lblRelay" class="tc"></td>'
								   + '	<td id="0lblLRF" class="tc"></td>'
								   + '	<td id="0lblLRFDate" class="tc"></td>'
								   + '	<td id="0lblResult" class="tc"></td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc">5#4, 6#4, 8#4</td>'
								   + '	<td id="1lblRelay" class="tc"></td>'
								   + '	<td id="1lblLRF" class="tc"></td>'
								   + '	<td id="1lblLRFDate" class="tc"></td>'
								   + '	<td id="1lblResult" class="tc"></td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc" rowspan="2">L</td>'
								   + '	<td class="tc">7#4, 8#2</td>'
								   + '	<td id="1lblMOI" class="tc" rowspan="2"></td>'
								   + '	<td id="1lblMOIDate" class="tc" rowspan="2"></td>'
								   + '	<td id="2lblRelay" class="tc"></td>'
								   + '	<td id="2lblLRF" class="tc"></td>'
								   + '	<td id="2lblLRFDate" class="tc"></td>'
								   + '	<td id="2lblResult" class="tc"></td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc">5#2, 7#2, 6#2</td>'
								   + '	<td id="3lblRelay" class="tc"></td>'
								   + '	<td id="3lblLRF" class="tc"></td>'
								   + '	<td id="3lblLRFDate" class="tc"></td>'
								   + '	<td id="3lblResult" class="tc"></td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc" rowspan="2">M</td>'
								   + '	<td class="tc">6#3, 7#3, 8#3</td>'
								   + '	<td id="2lblMOI" class="tc" rowspan="2"></td>'
								   + '	<td id="2lblMOIDate" class="tc" rowspan="2"></td>'
								   + '	<td id="4lblRelay" class="tc"></td>'
								   + '	<td id="4lblLRF" class="tc"></td>'
								   + '	<td id="4lblLRFDate" class="tc"></td>'
								   + '	<td id="4lblResult" class="tc"></td>'
								   + '</tr>'
								   + '<tr>'
								   + '	<td class="tc">8#4, 5#3</td>'
								   + '	<td id="5lblRelay" class="tc"></td>'
								   + '	<td id="5lblLRF" class="tc"></td>'
								   + '	<td id="5lblLRFDate" class="tc"></td>'
								   + '	<td id="5lblResult" class="tc"></td>'
								   + '</tr>';
								   
			tagDccInfoListBody.empty();
			tagDccInfoListBody.append(tagDccInfoListBodyStr);
		}
	}
}

function mbr_RuntimerGCCallback(data){
	
	var tagDccInfoListBody = $("#lblTitle");
	var tagDccInfoListBody1 = $("#gasSummary");
	var tagDccInfoListBody2 = $("#gasDensityBody");
	var tagDccInfoListBodyStr = "";
	
	$("#lblDate").text(data.UserInfo.hogi + " " + data.UserInfo.xyGubun + " " + data.BaseSearch.startDate);

	tagDccInfoListBody.empty();
	tagDccInfoListBody.append('<strong>'+data.LblTitle+'</strong>');
	
	if( typeof data.DccTagList[0] != 'undefined' ) {
		tagDccInfoListBodyStr += '<label>[ 수소<strong>'+data.lblDataList[0].fValue+'</strong>%] ,</label>'
							   + '<label>[ 산소<strong>'+data.lblDataList[1].fValue+'</strong>%] ,</label>'
							   + '<label>[ 질소<strong>'+data.lblDataList[2].fValue+'</strong>%] ,</label>'
							   + '<label>[ 중소<strong>'+data.lblDataList[3].fValue+'</strong>%]</label>';
	} else {
		tagDccInfoListBodyStr += '<label>[ 수소<strong></strong>%] ,</label>'
							   + '<label>[ 산소<strong></strong>%] ,</label>'
							   + '<label>[ 질소<strong></strong>%] ,</label>'
							   + '<label>[ 중소<strong></strong>%]</label>';
	}
	
	tagDccInfoListBody1.empty();
	tagDccInfoListBody1.append(tagDccInfoListBodyStr);
	
	tagDccInfoListBodyStr = '';
	if( typeof data.LblH2[0] != 'undefined' ) {
		for( var idx=0;idx<6;idx++ ) {
			tagDccInfoListBodyStr += '<tr>';
			if( idx == 0 ) {
	        	tagDccInfoListBodyStr += '	<td>LZC RU 전단</td>';
	        } else if( idx == 1 ) {
	        	tagDccInfoListBodyStr += '	<td>LZC RU 후단</td>';
			} else if( idx == 2 ) {
	        	tagDccInfoListBodyStr += '	<td>MOD RU 전단</td>';
			} else if( idx == 3 ) {
	        	tagDccInfoListBodyStr += '	<td>MOD RU 후단</td>';
			} else if( idx == 4 ) {
	        	tagDccInfoListBodyStr += '	<td>HI COLLECTION</td>';
			} else if( idx == 5 ) {
	        	tagDccInfoListBodyStr += '	<td>HT DST</td>';
			}
			tagDccInfoListBodyStr += '	<td class="tc"><label id="lblH25">'+data.LblH2[idx]+'</label></td>'
								   + '	<td class="tc"><label id="lblO25">'+data.LblO2[idx]+'</label></td>'
								   + '	<td class="tc"><label id="lblN25">'+data.LblN2[idx]+'</label></td>'
								   + '	<td class="tc"><label id="lblD25">'+data.LblD2[idx]+'</label></td>'
								   + '</tr>';
		}
	} else {
		for( var idx=0;idx<6;idx++ ) {
			tagDccInfoListBodyStr += '<tr>';
			if( idx == 0 ) {
	        	tagDccInfoListBodyStr += '	<td>LZC RU 전단</td>';
	        } else if( idx == 1 ) {
	        	tagDccInfoListBodyStr += '	<td>LZC RU 후단</td>';
			} else if( idx == 2 ) {
	        	tagDccInfoListBodyStr += '	<td>MOD RU 전단</td>';
			} else if( idx == 3 ) {
	        	tagDccInfoListBodyStr += '	<td>MOD RU 후단</td>';
			} else if( idx == 4 ) {
	        	tagDccInfoListBodyStr += '	<td>HI COLLECTION</td>';
			} else if( idx == 5 ) {
	        	tagDccInfoListBodyStr += '	<td>HT DST</td>';
			}
			tagDccInfoListBodyStr += '	<td class="tc"><label id="lblH25"></label></td>'
								   + '	<td class="tc"><label id="lblO25"></label></td>'
								   + '	<td class="tc"><label id="lblN25"></label></td>'
								   + '	<td class="tc"><label id="lblD25"></label></td>'
								   + '</tr>';
		}
	}
	tagDccInfoListBody2.empty();
	tagDccInfoListBody2.append(tagDccInfoListBodyStr);
}

function alarmCallback(data) {
	lblTitleAjax = data.LblTitle;
	lblDataListAjax = data.lblDataList;
	TagDccInfoListAjax = data.TagDccInfoList;
	lblH2Ajax = data.LblH2;
	lblO2Ajax = data.LblO2;
	lblN2Ajax = data.LblN2;
	lblD2Ajax = data.LblD2;
	
	$("#lblDate").text(data.SearchTime);
	$("#lblDate").css('color',data.ForeColor);
	
	setData();
}

function mbr_getTagCallback(data){
	var tagDccInfoListBody = $("#lvIolistTable");
	var tagDccInfoListBodyStr = "";
	var tagData = data.getTagInfoList;
	
	if( typeof tagData != 'undefined' ) {
		$.each(tagData, function(key, value){
			tagDccInfoListBodyStr += '<tr id="tr'+value.iSeq+'_'+value.hogi+'">'
								   + '	<td class="tc"><label id="'+value.iSeq+'hogi'+value.hogi+'">'+value.hogi+'</label></td>'
								   + '	<td class="tc"><label id="'+value.iSeq+'xyGubun'+value.hogi+'">'+value.xygubun+'</label></td>'
								   + '	<td><label id="'+value.iSeq+'loopName'+value.hogi+'">'+value.loopname+'</label></td>'
								   + '	<td class="tc"><label id="'+value.iSeq+'ioType'+value.hogi+'">'+value.iotype+'</label></td>'
								   + '	<td class="tc"><label id="'+value.iSeq+'address'+value.hogi+'">'+value.address+'</label></td>'
								   + '	<td class="tc"><label id="'+value.iSeq+'ioBit'+value.hogi+'">'+value.iobit+'</label></td>'
								   + '	<td class="tc"><label id="'+value.iSeq+'minVal'+value.hogi+'">'+cutData(value.minVal,8)+'</label></td>'
								   + '	<td class="tc"><label id="'+value.iSeq+'maxVal'+value.hogi+'">'+cutData(value.maxVal,8)+'</label></td>'
								   + '	<td class="tc"><label id="'+value.iSeq+'saveCoreChk'+value.hogi+'">'+value.saveCore+'</label></td>'
								   + '	<td style="display:none"><label id="'+value.iSeq+'iSeq'+value.hogi+'">'+value.iSeq+'</label></td>'
								   + '</tr>';
								   
	console.log(value);
			ioListArray.push(value);
		});
		
		if( tagData.length < 8 ) {
			for( var ei=tagData.length;ei<8;ei++ ) {
				tagDccInfoListBodyStr += '<tr>'
									   + '	<td class="tc"><label id="'+ei+'hogi'+ei+'"></label></td>'
									   + '	<td class="tc"><label id="'+ei+'xyGubun'+ei+'"></label></td>'
									   + '	<td><label id="'+ei+'descr'+ei+'"></label></td>'
									   + '	<td class="tc"><label id="'+ei+'ioType'+ei+'"></label></td>'
									   + '	<td class="tc"><label id="'+ei+'address'+ei+'"></label></td>'
									   + '	<td class="tc"><label id="'+ei+'ioBit'+ei+'"></label></td>'
									   + '	<td class="tc"><label id="'+ei+'minVal'+ei+'"></label></td>'
									   + '	<td class="tc"><label id="'+ei+'maxVal'+ei+'"></label></td>'
									   + '	<td class="tc"><label id="'+ei+'saveCoreChk'+ei+'"></label></td>'
									   + '	<td style="display:none"><label id="'+ei+'iSeq'+ei+'"></label></td>'
									   + '</tr>';
			}
		}
	}
	
	tagDccInfoListBody.empty();
	tagDccInfoListBody.append(tagDccInfoListBodyStr);
}

function mbr_tagFindCallback(data) {
	
	var tagInfoBody = $("#tagSearchList");
	var tagInfoBodyStr = "";
	var tagData = data.TagInfoList;
	
	if( typeof tagData != 'undefined' ) {
		$.each(tagData, function(key, value){
			var tmpISeq = typeof value.iSeq == 'undefined' ? "" : value.iSeq;
			var tmpIHogi = typeof value.iHogi == 'undefined' ? "" : value.iHogi;
			var tmpXyGubun = typeof value.xyGubun == 'undefined' ? "" : value.xyGubun;
			var tmpLoopName = typeof value.loopName == 'undefined' ? "" : value.loopName;
			var tmpDescr = typeof value.descr == 'undefined' ? "" : value.descr;
			var tmpIoType = typeof value.ioType == 'undefined' ? "" : value.ioType;
			var tmpAddress = typeof value.address == 'undefined' ? "" : value.address;
			var tmpIoBit = typeof value.ioBit == 'undefined' ? "" : value.ioBit;
			var tmpELow = typeof value.eLow == 'undefined' ? "" : value.eLow;
			var tmpEHigh = typeof value.eHigh == 'undefined' ? "" : value.eHigh;
			var tmpSaveCore = typeof value.saveCore == 'undefined' ? "" : value.saveCore;
			
			tagInfoBodyStr += '<tr id="tr'+tmpISeq+'">'
							+ '	<td class="tc" id="tagHogi'+tmpISeq+'">'+tmpIHogi+'</td>'
							+ '	<td class="tc" id="tagXyGubun'+tmpISeq+'">'+tmpXyGubun+'</td>'
							+ '	<td class="tc" id="tagLoopName'+tmpISeq+'">'+tmpLoopName+'</td>'
							+ '	<td class="tc" id="tagDescr'+tmpISeq+'">'+tmpDescr+'</td>'
							+ '	<td class="tc" id="tagIoType'+tmpISeq+'">'+tmpIoType+'</td>'
							+ '	<td class="tc" id="tagAddress'+tmpISeq+'">'+tmpAddress+'</td>'
							+ '	<td class="tc" id="tagIoBit'+tmpISeq+'">'+tmpIoBit+'</td>'
							+ '	<td class="tc" id="tagMin'+tmpISeq+'">'+tmpELow+'</td>'
							+ '	<td class="tc" id="tagMax'+tmpISeq+'">'+tmpEHigh+'</td>'
							+ '	<td class="tc" id="tagSaveCore'+tmpISeq+'">'+tmpSaveCore+'</td>'
							+ '<tr>';
		});
	}
	
	tagInfoBody.empty();
	tagInfoBody.append(tagInfoBodyStr);
}

function mngGroupCallback(data) {
	var type = data.ManageType;
	var uID = data.UserInfo.id;
	
	if( type == 'addGroup' ) {
		Group_Get(uID,0);
		
		selectManageGroup(3,'trU'+data.UpdatedGrpNo);
	} else if( type == 'delGroup' ) {
		Group_Get(uID,0);
		
		selectManageGroup(3,'trU'+data.UpdatedGrpNo);
	} else if( type == 'upGroup' ) {
		Group_Get(uID,0);
		
		selectManageGroup(3,'trU'+data.selGrpNo);
	} else if( type == 'downGroup' ) {
		Group_Get(uID,0);
		
		selectManageGroup(3,'trU'+data.selGrpNo);
	} else if( type == 'updateGroup' ) {
		Group_Get(uID,0);
		
		selectManageGroup(3,'trU'+data.selGrpNo);
	} else if( type == 'addNewGroup' ) {
		closeModal('modal_1');
	} else if( type == 'updateExistGroup' ) {
		closeModal('modal_1');
	}
	
}
