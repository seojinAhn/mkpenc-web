function mbr_RuntimerEventCallback(data){
	console.log(data.DccGrpTagList);
	var tagDccInfoListBody = $("#lblBody1");
	var tagDccInfoListBody2 = $("#lblBody2");
	var tagDccInfoListBodyStr = "";
	var tagDccInfoListBodyStr2 = "";
	
	var arrTrendData = data.ArrTrendData;
	var testArea = $("#testArea");
	var testStr = "";
	
	var rangeHi = $("#rangeHi");
	var rangeLow = $("#rangeLow");
	var rangeStr = '<label style="width:200px"> </label>';
	var HList = data.maxList;
	var LList = data.minList;
	var colorList = ['#801517','#B9529F','#1EBCBE','#282A73','#ED1E24','#7A57A4','#70CBD1','#364CA0'];
	
	for( var h=0;h<Object.keys(HList).length;h++ ) {
		var valHi = typeof HList[h] == 'undefined' || HList[h] == '' ? "0" : HList[h];
		var xPos = 0;
		if( h%2 == 0 ) {
			xPos = 200;	
			tAlign = 'right';
		} else {
			xPos = 1140;
			tAlign = 'left';
		}
		if( h < 8 ) {
			rangeStr += '<label id="Hi'+(h+1)+'" style="position:absolute;top:'+((Math.floor(h/2))*20+330)+'px;left:'+xPos+'px;display:inline-block;text-align:'+tAlign+';width:25px;color:'+colorList[h]+'">'+valHi+'</label> ';
		} else {
			rangeStr += '<label id="Hi'+(h+1)+'" style="position:absolute;top:'+((Math.floor(h/2))*20+330)+'px;left:'+xPos+'px;display:inline-block;text-align:'+tAlign+';width:25px;color:#F'+h%9+''+(9-h%9)+''+(9-h%9)+''+h%9+'A">'+valHi+'</label> ';
		}
		if( h < Object.keys(HList).length - 1 ) {
			rangeStr += '';
		}
	}
	
	rangeHi.empty();
	rangeHi.append(rangeStr);
	rangeStr = '<label style="width:200px"> </label>';
	
	for( var l=0;l<Object.keys(LList).length;l++ ) {
		var xPos = 0;
		if( l%2 == 0 ) {
			xPos = 200;	
			tAlign = 'right';
		} else {
			xPos = 1140;
			tAlign = 'left';
		}
		var valLow = typeof LList[l] == 'undefined' || LList[l] == '' ? "0" : LList[l];
		if( l < 8 ) {
			rangeStr += '<label id="Low'+(l+1)+'" style="position:absolute;top:'+(900-(Math.floor(l/2))*20)+'px;left:'+xPos+'px;display:inline-block;text-align:'+tAlign+';width:25px;color:'+colorList[l]+'">'+valLow+'</label> ';
		} else {
			rangeStr += '<label id="Low'+(l+1)+'" style="position:absolute;top:'+(900-(Math.floor(l/2))*20)+'px;left:'+xPos+'px;display:inline-block;text-align:'+tAlign+';width:25px;color:#F'+h%9+''+(9-h%9)+''+(9-h%9)+''+h%9+'A">'+valLow+'</label> ';
		}
		if( l < Object.keys(LList).length - 1 ) {
			rangeStr += '';
		}
	}
	
	rangeLow.empty();
	rangeLow.append(rangeStr);
	
	//testStr += '[';
	for( var k=0;k<arrTrendData.length;k++ ) {
		testStr += '{';
		for( var kk=0;kk<Object.keys(arrTrendData[k].m_data).length;kk++ ) {
			if( kk == 0 ) {
				testStr += arrTrendData[k].m_time+', '
						 + data.LblInfoList[0][kk]+'='
						 + arrTrendData[k].m_data[kk]+', ';
			} else if( kk < Object.keys(arrTrendData[k].m_data).length - 1 ) {
				testStr += data.LblInfoList[0][kk]+'='
						 + arrTrendData[k].m_data[kk]+', ';
			} else {
				testStr += data.LblInfoList[0][kk]+'='
						 + arrTrendData[k].m_data[kk];
			}
		}
		testStr += '},';
	}
	testStr = testStr.substring(0,testStr.length-1);
	//testStr += ']';
	
	testArea.empty();
	testArea.append(testStr);
	
	var size = Object.keys(data.LblInfoList[0]).length;
	var rest = size%4;
	var divGrp = (size-rest)/4;
	
	if( size > 0 ) {
		if( size <= 8 ) {
			if( size <= 4 ) {
				for( var i=0;i<size;i++ ) {
					tagDccInfoListBodyStr += '<div class="fx_srch_item line">'
	                            		   + '	<div class="fx_form chart_sum color_'+(i+1)+'">'
	                                	   + '		<input id="lblCheckbox'+i+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
	                                	   + '		<span><label id="lblTagName'+i+'" value="'+data.DccGrpTagList[i].fastiochk+'">'+data.LblInfoList[0][i]+'</label></span>'
	                                	   + '		<span><label id="lblValue'+i+'" value="'+size+'">'+data.LblInfoList[1][i].fValue+'</label></span>'
	                                	   + '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
	                            		   + '	</div>'
										   + '</div>';
				}
				for( var j=size;j<4;j++ ) {
					tagDccInfoListBodyStr += '<div class="fx_srch_item line">'
	                            		   + '	<div class="fx_form chart_sum color_'+(j+1)+'" style="display:none">'
	                                	   + '		<input id="lblCheckbox'+j+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
	                                	   + '		<span><label id="lblTagName'+j+'"></label></span>'
	                                	   + '		<span><label id="lblValue'+j+'"></label></span>'
	                                	   + '		<span><label id="lblUnit'+j+'"></label></span>'
	                            		   + '	</div>'
										   + '</div>';
				}
				for( var k=4;k<8;k++ ) {
					tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
	                            			+ '	<div class="fx_form chart_sum color_'+(k+1)+'" style="display:none">'
	                                		+ '		<input id="lblCheckbox'+k+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
	                                		+ '		<span><label id="lblTagName'+k+'"></label></span>'
	                                		+ '		<span><label id="lblValue'+k+'"></label></span>'
	                                		+ '		<span><label id="lblUnit'+k+'"></label></span>'
	                            			+ '	</div>'
											+ '</div>';
				}
			} else {
				for( var i=0;i<4;i++ ) {
					tagDccInfoListBodyStr += '<div class="fx_srch_item line">'
	                            		   + '	<div class="fx_form chart_sum color_'+(i+1)+'">'
	                                	   + '		<input id="lblCheckbox'+i+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
	                                	   + '		<span><label id="lblTagName'+i+'" value="'+data.DccGrpTagList[i].fastiochk+'">'+data.LblInfoList[0][i]+'</label></span>'
	                                	   + '		<span><label id="lblValue'+i+'" value="'+size+'">'+data.LblInfoList[1][i].fValue+'</label></span>'
	                                	   + '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
	                            		   + '	</div>'
										   + '</div>';
				}
				for( var j=4;j<size;j++ ) {
					tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
	                            			+ '	<div class="fx_form chart_sum color_'+(j+1)+'">'
	                                		+ '		<input id="lblCheckbox'+j+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
	                                		+ '		<span><label id="lblTagName'+j+'" value="'+data.DccGrpTagList[j].fastiochk+'">'+data.LblInfoList[0][j]+'</label></span>'
	                                		+ '		<span><label id="lblValue'+j+'">'+data.LblInfoList[1][j].fValue+'</label></span>'
	                                		+ '		<span><label id="lblUnit'+j+'">'+data.LblInfoList[2][j]+'</label></span>'
	                            			+ '	</div>'
											+ '</div>';
				}
				for( var k=size;k<8;k++ ) {
					tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
	                            			+ '	<div class="fx_form chart_sum color_'+(k+1)+'" style="display:none">'
	                                		+ '		<input id="lblCheckbox'+k+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
	                                		+ '		<span><label id="lblTagName'+k+'"></label></span>'
	                                		+ '		<span><label id="lblValue'+k+'"></label></span>'
	                                		+ '		<span><label id="lblUnit'+k+'"></label></span>'
	                            			+ '	</div>'
											+ '</div>';
				}
			}
			
			tagDccInfoListBody.empty();
			tagDccInfoListBody.append(tagDccInfoListBodyStr);
			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr2);
		} else {
			for( var i=0;i<4;i++ ) {
				tagDccInfoListBodyStr += '<div class="fx_srch_item line">'
                            		   + '	<div class="fx_form chart_sum color_'+(i+1)+'">'
                                	   + '		<input id="lblCheckbox'+i+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
                                	   + '		<span><label id="lblTagName'+i+'" value="'+data.DccGrpTagList[i].fastiochk+'">'+data.LblInfoList[0][i]+'</label></span>'
                                	   + '		<span><label id="lblValue'+i+'" value="'+size+'">'+data.LblInfoList[1][i].fValue+'</label></span>'
                                	   + '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
                            		   + '	</div>'
									   + '</div>';
			}
			for( var j=4;j<8;j++ ) {
				tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
                            			+ '	<div class="fx_form chart_sum color_'+(j+1)+'">'
                                		+ '		<input id="lblCheckbox'+j+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
                                		+ '		<span><label id="lblTagName'+j+'" value="'+data.DccGrpTagList[j].fastiochk+'">'+data.LblInfoList[0][j]+'</label></span>'
                                		+ '		<span><label id="lblValue'+j+'">'+data.LblInfoList[1][j].fValue+'</label></span>'
                                		+ '		<span><label id="lblUnit'+j+'">'+data.LblInfoList[2][j]+'</label></span>'
                            			+ '	</div>'
										+ '</div>';
			}
			
			tagDccInfoListBody.empty();
			tagDccInfoListBody.append(tagDccInfoListBodyStr);
			
			for( var ii=1;ii<divGrp;ii++ ) {
				var limit
				for( var i=9;i<8+ii*4;i++ ) {
					if( i <= size ) {
						tagDccInfoListBodyStr2 += '</div>'
												+ '<div class="fx_srch_row" id="lblBody'+(ii+2)+'">"'
												+ '<div class="fx_srch_item line">'
	                            				+ '	<div class="fx_form" style="color:#F'+i%9+''+(9-i%9)+''+(9-i%9)+''+i%9+'A">'
	                                			+ '		<input id="lblCheckbox'+i+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
	                                			+ '		<span><label id="lblTagName'+i+'" value="'+data.DccGrpTagList[i].fastiochk+'">'+data.LblInfoList[0][i]+'</label></span>'
		                                		+ '		<span><label id="lblValue'+i+'">'+data.LblInfoList[1][i].fValue+'</label></span>'
		                                		+ '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
		                            			+ '	</div>'
												+ '</div>';
					} else {
						tagDccInfoListBodyStr2 += '</div>'
												+ '<div class="fx_srch_row" id="lblBody'+(ii+2)+'">"'
		                            			+ '	<div class="fx_form" style="color:#F'+i%9+''+(9-i%9)+''+(9-i%9)+''+i%9+'A">'
		                                		+ '		<input id="lblCheckbox'+i+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
		                                		+ '		<span><label id="lblTagName'+i+'"></label></span>'
		                                		+ '		<span><label id="lblValue'+i+'"></label></span>'
		                                		+ '		<span><label id="lblUnit'+i+'"></label></span>'
		                            			+ '	</div>'
												+ '</div>';
					}
				}
			}
			tagDccInfoListBodyStr2 += '</div>';
			
			tagDccInfoListBody2.empty();
			tagDccInfoListBody2.append(tagDccInfoListBodyStr2);
		}
	}
}

function mbr_cmdEventCallback(data){
	console.log(data);
	
	var tagDccInfoListBody = $("#lvIolistTable");
	var tagDccInfoListBodyStr = "";
	
	if( data.LvIOList.length > 0 ) {
	
		var idx=0;
		$.each(data.LvIOList, function(key, value){
			//if( idx == 0 ) {
				if( value.gubun == 'D' || value.gubun == 'd') {
					tagDccInfoListBodyStr += '<tr>'
										   + '	<td id="'+value.iSeq+'hogi'+value.hogi+'" class="tc">'+value.hogi+'</td>'
										   + '	<td id="'+value.iSeq+'xyGubun'+value.hogi+'" class="tc">'+value.xyGubun+'</td>'
										   + '	<td id="'+value.iSeq+'descr'+value.hogi+'">'+value.Descr+'</td>'
										   + '	<td id="'+value.iSeq+'ioType'+value.hogi+'" class="tc">'+value.ioType+'</td>'
										   + '	<td id="'+value.iSeq+'address'+value.hogi+'" class="tc">'+value.address+'</td>'
										   + '	<td id="'+value.iSeq+'ioBit'+value.hogi+'" class="tc">'+value.ioBit+'</td>'
										   + '	<td id="'+value.iSeq+'minVal'+value.hogi+'" class="tc">'+value.minVal+'</td>'
										   + '	<td id="'+value.iSeq+'maxVal'+value.hogi+'" class="tc">'+value.maxVal+'</td>'
										   + '	<td id="'+value.iSeq+'saveCoreChk'+value.hogi+'" class="tc">'+value.saveCoreChk+'</td>'
										   + '	<td id="'+value.iSeq+'iSeq'+value.hogi+'" style="display:none">'+value.iSeq+'</td>'
										   + '</tr>';
				} else {
					tagDccInfoListBodyStr += '<tr>'
										   + '	<td id="'+value.iSeq+'hogi'+value.hogi+'" class="tc">'+value.hogi_M+'</td>'
										   + '	<td id="'+value.iSeq+'xyGubun'+value.hogi+'" class="tc"></td>'
										   + '	<td id="'+value.iSeq+'descr'+value.hogi+'">'+value.Descr_M+'"</td>'
										   + '	<td id="'+value.iSeq+'ioType'+value.hogi+'" class="tc">'+value.ioType_M+'</td>'
										   + '	<td id="'+value.iSeq+'address'+value.hogi+'" class="tc">'+value.address_M+'</td>'
										   + '	<td id="'+value.iSeq+'ioBit'+value.hogi+'" class="tc">'+value.ioBit_M+'</td>'
										   + '	<td id="'+value.iSeq+'minVal'+value.hogi+'" class="tc">'+value.minVal_M+'</td>'
										   + '	<td id="'+value.iSeq+'maxVal'+value.hogi+'" class="tc">'+value.maxVal_M+'</td>'
										   + '	<td id="'+value.iSeq+'saveCoreChk'+value.hogi+'" class="tc"></td>'
										   + '	<td id="'+value.iSeq+'iSeq'+value.hogi+'" style="display:none">'+value.iSeq+'"</td>'
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