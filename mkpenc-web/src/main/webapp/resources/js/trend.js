function mbr_RuntimerEventCallback(data){
	//console.log(data);
	var tagDccInfoListBody = $("#lblBody1");
	var tagDccInfoListBody2 = $("#lblBody2");
	var tagDccInfoListBodyStr = "";
	var tagDccInfoListBodyStr2 = "";
	
	var arrTrendData = data.ArrTrendData;
	//console.log(arrTrendData);
	var testArea = $("#testArea");
	var testStr = "";
	
	var rangeHi = $("#rangeHi");
	var rangeLow = $("#rangeLow");
	var rangeStr = '<label style="width:200px"> </label>';
	var HList = data.maxList;
	var LList = data.minList;
	var colorList = ['#801517','#B9529F','#1EBCBE','#282A73','#ED1E24','#7A57A4','#70CBD1','#364CA0'];
	
	var minListBody = $("#minList");
	var maxListBody = $("#maxList");
	var FHiAlarmBody = $("#FHiAlarm");
	var FLoAlarmBody = $("#FLoAlarm");
	var FDtabHiBody = $("#FDtabHi");
	var FDtabLoBody = $("#FDtabLo");
	
	var minListStr = "";
	var maxListStr = "";
	var FHiAlarmStr = "";
	var FLoAlarmStr = "";
	var FDtabHiStr = "";
	var FDtabLoStr = "";
	
	var maxmax = [];
	var minmin = [];
	
	$("#lblBody3").empty();
	$("#lblBody4").empty();

	if( data.DccGrpTagList.length > 0 ) {
		for( var si=0;si<Object.keys(data.minList).length;si++ ) {
			if( si < Object.keys(data.minList).length - 1 ) {
				minListStr += data.minList[si] + ',';
				maxListStr += data.maxList[si] + ',';
				FHiAlarmStr += data.FHiAlarm[si] + ',';
				FLoAlarmStr += data.FLoAlarm[si] + ',';
			} else {
				minListStr += data.minList[si];
				maxListStr += data.maxList[si];
				FHiAlarmStr += data.FHiAlarm[si];
				FLoAlarmStr += data.FLoAlarm[si];
			}
			
			maxmax[si] = data.maxList[si]*1;
			minmin[si] = data.minList[si]*1;
		}
		
		var mMax = 0;
		var mMin = 0;
		for( var mi=0;mi<maxmax.length;mi++ ) {
			if( mMax < maxmax[mi] ) mMax = maxmax[mi];
			if( mMin > minmin[mi] ) mMin = minmin[mi];
		}
		
		minListBody.empty();
		minListBody.append(minListStr);
		maxListBody.empty();
		maxListBody.append(maxListStr);
		FHiAlarmBody.empty();
		FHiAlarmBody.append(FHiAlarmStr);
		FLoAlarmBody.empty();
		FLoAlarmBody.append(FLoAlarmStr);
		
		for( var h=0;h<Object.keys(HList).length;h++ ) {
			var valHi = typeof HList[h] == 'undefined' || HList[h] == '' ? "0" : HList[h];
			var xPos = 0;
			if( h%2 == 0 ) {
				xPos = 1;	
				tAlign = 'right';
			} else {
				xPos = 1294;
				tAlign = 'left';
			}
			if( h < 8 ) {
				rangeStr += '<input id="Hi'+(h+1)+'" style="border:0 solid black;outline:none;position:absolute;top:'+((Math.floor(h/2))*20+270)+'px;left:'+xPos+'px;display:inline-block;text-align:'+tAlign+';width:85px;color:'+colorList[h]+'" value="'+cutData(valHi,6)+'" onkeypress="javascript:rangeCustom(\'Hi'+(h+1)+'\',0);" onBlur="javascript:rangeCustom(\'Hi'+(h+1)+'\',1);"> ';
			} else {
				rangeStr += '<input id="Hi'+(h+1)+'" style="border:0 solid black;outline:none;position:absolute;top:'+((Math.floor(h/2))*20+270)+'px;left:'+xPos+'px;display:inline-block;text-align:'+tAlign+';width:85px;color:#F'+h%9+''+(9-h%9)+''+(9-h%9)+''+h%9+'A" value="'+cutData(valHi,6)+'" onkeypress="javascript:rangeCustom(\'Hi'+(h+1)+'\',0);" onBlur="javascript:rangeCustom(\'Hi'+(h+1)+'\',1);"> ';
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
				xPos = 1;	
				tAlign = 'right';
			} else {
				xPos = 1294;
				tAlign = 'left';
			}
			var valLow = typeof LList[l] == 'undefined' || LList[l] == '' ? "0" : LList[l];
			if( l < 8 ) {
				rangeStr += '<input id="Low'+(l+1)+'" style="border:0 solid black;outline:none;position:absolute;top:'+(594-(Math.floor(l/2))*20)+'px;left:'+xPos+'px;display:inline-block;text-align:'+tAlign+';width:85px;color:'+colorList[l]+'" value="'+cutData(valLow,6)+'" onkeypress="javascript:rangeCustom(\'Low'+(l+1)+'\',0);" onBlur="javascript:rangeCustom(\'Low'+(l+1)+'\',1);"> ';
			} else {
				rangeStr += '<input id="Low'+(l+1)+'" style="border:0 solid black;outline:none;position:absolute;top:'+(594-(Math.floor(l/2))*20)+'px;left:'+xPos+'px;display:inline-block;text-align:'+tAlign+';width:85px;color:#F'+l%9+''+(9-l%9)+''+(9-l%9)+''+l%9+'A" value="'+cutData(valLow,6)+'" onkeypress="javascript:rangeCustom(\'Low'+(l+1)+'\',0);" onBlur="javascript:rangeCustom(\'Low'+(l+1)+'\',1);"> ';
			}
			if( l < Object.keys(LList).length - 1 ) {
				rangeStr += '';
			}
		}
		
		rangeLow.empty();
		rangeLow.append(rangeStr);
		
		var testJson = {};
		for( var k=0;k<arrTrendData.length;k++ ) {
			//testStr += '{';
			for( var kk=0;kk<Object.keys(arrTrendData[k].m_data).length;kk++ ) {
				/*if( kk == 0 ) {
					if( Object.keys(arrTrendData[k].m_data).length > 1 ) {
						testStr += arrTrendData[k].m_time+', '
								 + data.LblInfoList[0][kk]+'='
								 + arrTrendData[k].m_data[kk]+', ';
					} else {
						testStr += arrTrendData[k].m_time+', '
								 + data.LblInfoList[0][kk]+'='
								 + arrTrendData[k].m_data[kk];
					}
				} else if( kk < Object.keys(arrTrendData[k].m_data).length - 1 ) {
					testStr += data.LblInfoList[0][kk]+'='
							 + arrTrendData[k].m_data[kk]+', ';
				} else {
					testStr += data.LblInfoList[0][kk]+'='
							 + arrTrendData[k].m_data[kk];
				}*/
			
				testJson['name'] = arrTrendData[k].m_time;
				testJson[data.LblInfoList[0][kk]] = arrTrendData[k].m_data[kk];
			}
			//testStr += '},';
			tXData.push(JSON.parse(JSON.stringify(testJson)));
		}
		//console.log(tXData);
		//testStr = testStr != '' ? testStr.substring(0,testStr.length-1) : '';
		//testStr += ']';
		//testArea.empty();
		//testArea.append(testStr);
		
		var size = Object.keys(data.LblInfoList[0]).length;
		var rest = size%4;
		var divGrp = (size-rest)/4;
		var foreColorStr = '';
		
		var isChecked = ' checked';
		if( size > 0 ) {
			if( size <= 8 ) {
				if( size <= 4 ) {
					for( var i=0;i<size;i++ ) {
						isChecked = ' checked'
						for( var hi=0;hi<hideLegnedItems.length;hi++ ) {
							if( data.LblInfoList[0][i] == hideLegnedItems[hi] ) isChecked = '';
						}
						var alarmType = data.DccGrpTagList[i].alarmType;
						var alarmHi = typeof data.FHiAlarm[i] == 'undefined' ? 0 : data.FHiAlarm[i]*1;
						var alarmLo = typeof data.FLoAlarm[i] == 'undefined' ? 0 : data.FLoAlarm[i]*1;
						//var tmpVal = typeof data.LblInfoList[1][i].fValue == 'undefined' ? '***IRR' : data.LblInfoList[1][i].fValue*1;
						var tmpVal = typeof data.LblInfoList[1][i].fValue == 'undefined' ? arrTrendData[arrTrendData.length-1].m_data[i] : data.LblInfoList[1][i].fValue*1;
						if( typeof tmpVal == 'undefined' || tmpVal == 'undefined' || tmpVal == '-32768' || tmpVal == -32768 ) tmpVal = '***IRR';
						
						if( alarmType == '1' || alarmType == '4' || alarmType == '7' ) {
							if( alarmHi < tmpVal && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else if( alarmType == '2' || alarmType == '8' || alarmType == '5' ) {
							if( alarmLo > tmpVal && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else if( alarmType == '3' || alarmType == '6' ) {
							if( (alarmLo > tmpVal || alarmHi < tmpVal) && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else {
							foreColorStr = '';
						}
						tagDccInfoListBodyStr += '<div class="fx_srch_item line">'
		                            		   + '	<div class="fx_form chart_sum color_'+(i+1)+'">'
		                                	   + '		<input id="lblCheckbox'+i+'" type="checkbox"'+isChecked+' onclick="javascript:checkbox_click(this.id)">'
		                                	   + '		<span><label id="lblTagName'+i+'" value="'+data.DccGrpTagList[i].fastiochk+'">'+data.LblInfoList[0][i]+'</label></span>'
		                                	   + '		<span><label id="lblValue'+i+'" value="'+i+'_'+data.DccGrpTagList[i].hogi+'_'+data.DccGrpTagList[i].grpHogi+'"'+foreColorStr+'">'+tmpVal+'</label></span>'
		                                	   + '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
		                            		   + '	</div>'
											   + '</div>';
					}
					for( var j=size;j<4;j++ ) {
						tagDccInfoListBodyStr += '<div class="fx_srch_item line">'
		                            		   + '	<div class="fx_form chart_sum color_'+(j+1)+'" style="display:none">'
		                                	   + '		<input id="lblCheckbox'+j+'" type="checkbox" onclick="javascript:checkbox_click(this.id)">'
		                                	   + '		<span><label id="lblTagName'+j+'"></label></span>'
		                                	   + '		<span><label id="lblValue'+j+'"></label></span>'
		                                	   + '		<span><label id="lblUnit'+j+'"></label></span>'
		                            		   + '	</div>'
											   + '</div>';
					}
					for( var k=4;k<8;k++ ) {
						tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
		                            			+ '	<div class="fx_form chart_sum color_'+(k+1)+'" style="display:none">'
		                                		+ '		<input id="lblCheckbox'+k+'" type="checkbox" onclick="javascript:checkbox_click(this.id)">'
		                                		+ '		<span><label id="lblTagName'+k+'"></label></span>'
		                                		+ '		<span><label id="lblValue'+k+'"></label></span>'
		                                		+ '		<span><label id="lblUnit'+k+'"></label></span>'
		                            			+ '	</div>'
												+ '</div>';
					}
				} else {
					for( var i=0;i<4;i++ ) {
						isChecked = ' checked'
						for( var hi=0;hi<hideLegnedItems.length;hi++ ) {
							if( data.LblInfoList[0][i] == hideLegnedItems[hi] ) isChecked = '';
						}
						var alarmType = data.DccGrpTagList[i].alarmType;
						var alarmHi = typeof data.FHiAlarm[i] == 'undefined' ? 0 : data.FHiAlarm[i]*1;
						var alarmLo = typeof data.FLoAlarm[i] == 'undefined' ? 0 : data.FLoAlarm[i]*1;
						//var tmpVal = typeof data.LblInfoList[1][i].fValue == 'undefined' ? '***IRR' : data.LblInfoList[1][i].fValue*1;
						var tmpVal = typeof data.LblInfoList[1][i].fValue == 'undefined' ? arrTrendData[arrTrendData.length-1].m_data[i] : data.LblInfoList[1][i].fValue*1;
						if( typeof tmpVal == 'undefined' || tmpVal == 'undefined' || tmpVal == '-32768' || tmpVal == -32768 ) tmpVal = '***IRR';
						
						if( alarmType == '1' || alarmType == '4' || alarmType == '7' ) {
							if( alarmHi < tmpVal && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else if( alarmType == '2' || alarmType == '8' || alarmType == '5' ) {
							if( alarmLo > tmpVal && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else if( alarmType == '3' || alarmType == '6' ) {
							if( (alarmLo > tmpVal || alarmHi < tmpVal) && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else {
							foreColorStr = '';
						}
						tagDccInfoListBodyStr += '<div class="fx_srch_item line">'
		                            		   + '	<div class="fx_form chart_sum color_'+(i+1)+'">'
		                                	   + '		<input id="lblCheckbox'+i+'" type="checkbox"'+isChecked+' onclick="javascript:checkbox_click(this.id)">'
		                                	   + '		<span><label id="lblTagName'+i+'" value="'+data.DccGrpTagList[i].fastiochk+'">'+data.LblInfoList[0][i]+'</label></span>'
		                                	   + '		<span><label id="lblValue'+i+'" value="'+i+'_'+data.DccGrpTagList[i].hogi+'_'+data.DccGrpTagList[i].grpHogi+'"'+foreColorStr+'">'+tmpVal+'</label></span>'
		                                	   + '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
		                            		   + '	</div>'
											   + '</div>';
					}
					for( var j=4;j<size;j++ ) {
						isChecked = ' checked'
						for( var hi=0;hi<hideLegnedItems.length;hi++ ) {
							if( data.LblInfoList[0][j] == hideLegnedItems[hi] ) isChecked = '';
						}
						var alarmType = data.DccGrpTagList[j].alarmType;
						var alarmHi = typeof data.FHiAlarm[j] == 'undefined' ? 0 : data.FHiAlarm[j]*1;
						var alarmLo = typeof data.FLoAlarm[j] == 'undefined' ? 0 : data.FLoAlarm[j]*1;
						//var tmpVal = typeof data.LblInfoList[1][j].fValue == 'undefined' ? '***IRR' : data.LblInfoList[1][j].fValue*1;
						var tmpVal = typeof data.LblInfoList[1][j].fValue == 'undefined' ? arrTrendData[arrTrendData.length-1].m_data[j] : data.LblInfoList[1][j].fValue*1;
						if( typeof tmpVal == 'undefined' || tmpVal == 'undefined' || tmpVal == '-32768' || tmpVal == -32768 ) tmpVal = '***IRR';
						
						if( alarmType == '1' || alarmType == '4' || alarmType == '7' ) {
							if( alarmHi < tmpVal && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else if( alarmType == '2' || alarmType == '8' || alarmType == '5' ) {
							if( alarmLo > tmpVal && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else if( alarmType == '3' || alarmType == '6' ) {
							if( (alarmLo > tmpVal || alarmHi < tmpVal) && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else {
							foreColorStr = '';
						}
						tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
		                            			+ '	<div class="fx_form chart_sum color_'+(j+1)+'">'
		                                		+ '		<input id="lblCheckbox'+j+'" type="checkbox"'+isChecked+' onclick="javascript:checkbox_click(this.id)">'
		                                		+ '		<span><label id="lblTagName'+j+'" value="'+data.DccGrpTagList[j].fastiochk+'">'+data.LblInfoList[0][j]+'</label></span>'
		                                		+ '		<span><label id="lblValue'+j+'" value="'+j+'_'+data.DccGrpTagList[j].hogi+'_'+data.DccGrpTagList[j].grpHogi+'"'+foreColorStr+'">'+tmpVal+'</label></span>'
		                                		+ '		<span><label id="lblUnit'+j+'">'+data.LblInfoList[2][j]+'</label></span>'
		                            			+ '	</div>'
												+ '</div>';
					}
					for( var k=size;k<8;k++ ) {
						tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
		                            			+ '	<div class="fx_form chart_sum color_'+(k+1)+'" style="display:none">'
		                                		+ '		<input id="lblCheckbox'+k+'" type="checkbox" onclick="javascript:checkbox_click(this.id)">'
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
					var alarmType = data.DccGrpTagList[i].alarmType;
					var alarmHi = typeof data.FHiAlarm[i] == 'undefined' ? 0 : data.FHiAlarm[i]*1;
					var alarmLo = typeof data.FLoAlarm[i] == 'undefined' ? 0 : data.FLoAlarm[i]*1;
						//var tmpVal = typeof data.LblInfoList[1][i].fValue == 'undefined' ? '***IRR' : data.LblInfoList[1][i].fValue*1;
						var tmpVal = typeof data.LblInfoList[1][i].fValue == 'undefined' ? arrTrendData[arrTrendData.length-1].m_data[i] : data.LblInfoList[1][i].fValue*1;
						if( typeof tmpVal == 'undefined' || tmpVal == 'undefined' || tmpVal == '-32768' || tmpVal == -32768 ) tmpVal = '***IRR';
						
						if( alarmType == '1' || alarmType == '4' || alarmType == '7' ) {
							if( alarmHi < tmpVal && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else if( alarmType == '2' || alarmType == '8' || alarmType == '5' ) {
							if( alarmLo > tmpVal && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else if( alarmType == '3' || alarmType == '6' ) {
							if( (alarmLo > tmpVal || alarmHi < tmpVal) && tmpVal != '***IRR' ) {
								foreColorStr = ' style="color:#FF0000"';
							}
						} else {
							foreColorStr = '';
						}
					tagDccInfoListBodyStr += '<div class="fx_srch_item line">'
	                            		   + '	<div class="fx_form chart_sum color_'+(i+1)+'">'
	                                	   + '		<input id="lblCheckbox'+i+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
	                                	   + '		<span><label id="lblTagName'+i+'" value="'+data.DccGrpTagList[i].fastiochk+'">'+data.LblInfoList[0][i]+'</label></span>'
	                                	   + '		<span><label id="lblValue'+i+'" value="'+i+'_'+data.DccGrpTagList[i].hogi+'_'+data.DccGrpTagList[i].grpHogi+'">'+tmpVal+'</label></span>'
	                                	   + '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
	                            		   + '	</div>'
										   + '</div>';
				}
				for( var j=4;j<8;j++ ) {
					var alarmType = data.DccGrpTagList[j].alarmType;
					var alarmHi = typeof data.FHiAlarm[j] == 'undefined' ? 0 : data.FHiAlarm[j]*1;
					var alarmLo = typeof data.FLoAlarm[j] == 'undefined' ? 0 : data.FLoAlarm[j]*1;
					//var tmpVal = typeof data.LblInfoList[1][j].fValue == 'undefined' ? '***IRR' : data.LblInfoList[1][j].fValue*1;
						var tmpVal = typeof data.LblInfoList[1][j].fValue == 'undefined' ? arrTrendData[arrTrendData.length-1].m_data[j] : data.LblInfoList[1][j].fValue*1;
						if( typeof tmpVal == 'undefined' || tmpVal == 'undefined' || tmpVal == '-32768' || tmpVal == -32768 ) tmpVal = '***IRR';
					
					if( alarmType == '1' || alarmType == '4' || alarmType == '7' ) {
						if( alarmHi < tmpVal && tmpVal != '***IRR' ) {
							foreColorStr = ' style="color:#FF0000"';
						}
					} else if( alarmType == '2' || alarmType == '8' || alarmType == '5' ) {
						if( alarmLo > tmpVal && tmpVal != '***IRR' ) {
							foreColorStr = ' style="color:#FF0000"';
						}
					} else if( alarmType == '3' || alarmType == '6' ) {
						if( (alarmLo > tmpVal || alarmHi < tmpVal) && tmpVal != '***IRR' ) {
							foreColorStr = ' style="color:#FF0000"';
						}
					} else {
						foreColorStr = '';
					}
					tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
	                            			+ '	<div class="fx_form chart_sum color_'+(j+1)+'">'
	                                		+ '		<input id="lblCheckbox'+j+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
	                                		+ '		<span><label id="lblTagName'+j+'" value="'+data.DccGrpTagList[j].fastiochk+'">'+data.LblInfoList[0][j]+'</label></span>'
	                                		+ '		<span><label id="lblValue'+j+'" value="'+j+'_'+data.DccGrpTagList[j].hogi+'_'+data.DccGrpTagList[j].grpHogi+'"'+foreColorStr+'">'+tmpVal+'</label></span>'
	                                		+ '		<span><label id="lblUnit'+j+'">'+data.LblInfoList[2][j]+'</label></span>'
	                            			+ '	</div>'
											+ '</div>';
				}
				
				tagDccInfoListBody.empty();
				tagDccInfoListBody.append(tagDccInfoListBodyStr);
				
				tagDccInfoListBody2.empty();
				tagDccInfoListBody2.append(tagDccInfoListBodyStr2);
				
				for( var ii=1;ii<divGrp;ii++ ) {
					var tagDccInfoListBodyTmp = $("#lblBody"+(ii+2));
					var tagDccInfoListBodyStrTmp = '';

					tagDccInfoListBodyTmp.css("display","");
					
					for( var i=8;i<8+ii*4;i++ ) {
						if( i < size ) {
							var alarmType = data.DccGrpTagList[i].alarmType;
							var alarmHi = typeof data.FHiAlarm[i] == 'undefined' ? 0 : data.FHiAlarm[i]*1;
							var alarmLo = typeof data.FLoAlarm[i] == 'undefined' ? 0 : data.FLoAlarm[i]*1;
							//var tmpVal = typeof data.LblInfoList[1][i].fValue == 'undefined' ? '***IRR' : data.LblInfoList[1][i].fValue*1;
						var tmpVal = typeof data.LblInfoList[1][i].fValue == 'undefined' ? arrTrendData[arrTrendData.length-1].m_data[i] : data.LblInfoList[1][i].fValue*1;
						if( typeof tmpVal == 'undefined' || tmpVal == 'undefined' || tmpVal == '-32768' || tmpVal == -32768 ) tmpVal = '***IRR';
							
							if( alarmType == '1' || alarmType == '4' || alarmType == '7' ) {
								if( alarmHi < tmpVal && tmpVal != '***IRR' ) {
									foreColorStr = ' style="color:#FF0000"';
								}
							} else if( alarmType == '2' || alarmType == '8' || alarmType == '5' ) {
								if( alarmLo > tmpVal && tmpVal != '***IRR' ) {
									foreColorStr = ' style="color:#FF0000"';
								}
							} else if( alarmType == '3' || alarmType == '6' ) {
								if( (alarmLo > tmpVal || alarmHi < tmpVal) && tmpVal != '***IRR' ) {
									foreColorStr = ' style="color:#FF0000"';
								}
							} else {
								foreColorStr = '';
							}
							
							tagDccInfoListBodyStrTmp += '<div class="fx_srch_item line">'
		                            				  + '	<div class="fx_form chart_sum">'
		                                			  + '		<input id="lblCheckbox'+i+'" type="checkbox" checked onclick="javascript:checkbox_click(this.id)">'
		                                			  + '		<span><label id="lblTagName'+i+'" value="'+data.DccGrpTagList[i].fastiochk+'" style="color:#F'+i%9+''+(9-i%9)+''+(9-i%9)+''+i%9+'A!important;">'+data.LblInfoList[0][i]+'</label></span>'
			                                		  + '		<span><label id="lblValue'+i+'" value="'+i+'_'+data.DccGrpTagList[i].hogi+'_'+data.DccGrpTagList[i].grpHogi+'"'+foreColorStr+'" style="color:#F'+i%9+''+(9-i%9)+''+(9-i%9)+''+i%9+'A!important;">'+tmpVal+'</label></span>'
			                                		  + '		<span><label id="lblUnit'+i+'" style="color:#F'+i%9+''+(9-i%9)+''+(9-i%9)+''+i%9+'A!important;">'+data.LblInfoList[2][i]+'</label></span>'
			                            			  + '	</div>'
													  + '</div>';
						} else {
							tagDccInfoListBodyStrTmp += '<div class="fx_srch_item line">'
		                            				  + '	<div class="fx_form chart_sum" style="display:none">'
			                            			  + '	</div>'
													  + '</div>';
						}
					}
				}
				
				tagDccInfoListBodyTmp.empty();
				tagDccInfoListBodyTmp.append(tagDccInfoListBodyStrTmp);
			}
		}
	} else {
		testArea.empty();
		var lblBodyStr1 = '<div class="fx_srch_item line">'
                       + '	<div class="fx_form chart_sum color_1" style="display:none"><!-- color : #801517 -->'
            		   + '	</div>'
					   + '</div>'
					   + '<div class="fx_srch_item line">'
                       + '	<div class="fx_form chart_sum color_2" style="display:none"><!-- color : #B9529F -->'
            		   + '	</div>'
					   + '</div>'
					   + '<div class="fx_srch_item line">'
                       + '	<div class="fx_form chart_sum color_3" style="display:none"><!-- color : #1EBCBE -->'
            		   + '	</div>'
					   + '</div>'
					   + '<div class="fx_srch_item line">'
                       + '	<div class="fx_form chart_sum color_4" style="display:none"><!-- color : #282A73 -->'
            		   + '	</div>'
					   + '</div>';
		$("#lblBody1").empty();
		$("#lblBody1").append(lblBodyStr1);
		var lblBodyStr2 = '<div class="fx_srch_item line">'
                       + '	<div class="fx_form chart_sum color_5" style="display:none"><!-- color : #ED1E24 -->'
            		   + '	</div>'
					   + '</div>'
					   + '<div class="fx_srch_item line">'
                       + '	<div class="fx_form chart_sum color_6" style="display:none"><!-- color : #7A57A4 -->'
            		   + '	</div>'
					   + '</div>'
					   + '<div class="fx_srch_item line">'
                       + '	<div class="fx_form chart_sum color_7" style="display:none"><!-- color : #70CBD1 -->'
            		   + '	</div>'
					   + '</div>'
					   + '<div class="fx_srch_item line">'
                       + '	<div class="fx_form chart_sum color_8" style="display:none"><!-- color : #364CA0 -->'
            		   + '	</div>'
					   + '</div>';
		$("#lblBody2").empty();
		$("#lblBody2").append(lblBodyStr2);
		$("#chart_wrap_area").empty();
		$("#chartBack").css("display","none");
		$("#xAxisArea").css("display","none");
		$("#yAxisArea").css("display","none");
		$("#rangeHi").css("display","none");
		$("#rangeLow").css("display","none");
		$("#pagingArea").css("display","none");
		$("#MonthDayArea").css("display","none");
		$("#TimeArea").css("display","none");
	}
}

function mbr_ScanTimeCallback(data) {
	var scanTimeBody = $("#scanTimed");
	var scanTimeBodyStr = "";
	
	scanTimeBodyStr += '<input id="scanTimeGot" type="hidden" value="'+data.pScantTime+'">';
	
	scanTimeBody.empty();
	scanTimeBody.append(scanTimeBodyStr);
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
									   
		alert('해당하는 어드레스가 없습니다.');
	}
	
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

function mbr_groupGetCallBack(data){
	var gType = data.GroupGetType;
	
	var tagDccInfoListBody = '';
	if( gType == '0' ) {
		tagDccInfoListBody = $("#lvGroup");
	} else {
		tagDccInfoListBody = $("#lvReference");
	}
	var tagDccInfoListBodyStr = "";
	var tagData = data.GroupGetList;
	var idx=0;
	
	if( typeof tagData != 'undefined' ) {
		$.each(tagData, function(key, value){
			if( gType == '0' ) {
				tagDccInfoListBodyStr += '<tr id="trU'+value.UGrpNo+'">'
									   + '	<td class="tc"><input id="gguCheckbox'+idx+'" type="checkbox" value="'+tagData.length+'"></td>'
									   + '	<td class="tc"><label id="gguGrpNo'+idx+'">'+value.UGrpNo+'</label></td>'
									   + '	<td><label id="gguGrpName'+idx+'">'+value.UGrpName+'</label></td>'
									   + '</tr>';
			} else {
				tagDccInfoListBodyStr += '<tr id="trR'+value.UGrpNo+'">'
									   + '	<td class="tc"><input id="ggrCheckbox'+idx+'" type="checkbox" value="'+tagData.length+'"></td>'
									   + '	<td class="tc" style="display:none"><label id="ggrGrpNo'+idx+'">'+value.UGrpNo+'</label></td>'
									   + '	<td><label id="ggrGrpName'+idx+'" value="'+value.UGrpNo+'">'+value.UGrpName+'</label></td>'
									   + '</tr>';
			}
		
			idx++;
		});
	}
		
	if( tagData.length < 20 ) {
		for( var ei=tagData.length;ei<20;ei++ ) {
			if( gType == '0' ) {
				tagDccInfoListBodyStr += '<tr id="trUNone'+ei+'">'
									   + '	<td class="tc"><input id="gguCheckbox'+ei+'" type="checkbox"></td>'
									   + '	<td class="tc"><label id="gguGrpNo'+ei+'"></label></td>'
									   + '	<td><label id="gguGrpName'+ei+'"></label></td>'
									   + '</tr>';
			} else {
				tagDccInfoListBodyStr += '<tr id="trRNone'+ei+'">'
									   + '	<td class="tc"><input id="ggrCheckbox'+ei+'" type="checkbox"></td>'
									   + '	<td style="display:none"><label id="ggrGrpNo'+ei+'"></label></td>'
									   + '	<td><label id="ggrGrpName'+ei+'"></label></td>'
									   + '</tr>';
			}
		}
	}
	
	tagDccInfoListBody.empty();
	tagDccInfoListBody.append(tagDccInfoListBodyStr);
}

function mbr_saveRangeCallback(data) {
	if( data.UdpateRangeResult == '1' ) {
		alert('저장되었습니다.');
	} else {
		console.log(data.UdpateRangeResult);
	}
}

function mbr_cmdMoveCallback(data) {
	console.log(data);
}

function mbr_cmdEventCallback(data) {
	//console.log(data);
	
	var tagDccInfoListBody = $("#lvIolistTable");
	var tagDccInfoListBodyStr = "";
	var tagData = data.LvIOList;
	
	if( data.execType == 'cmdInsert' ) {
		/*if( typeof tagData != 'undefined' ) {
			$.each(tagData, function(key, value){
				tagDccInfoListBodyStr += '<tr id="tr'+value.iSeq+'">'
									   + '	<td id="'+value.iSeq+'hogi'+value.hogi+'" class="tc">'+value.hogi+'</td>'
									   + '	<td id="'+value.iSeq+'xyGubun'+value.hogi+'" class="tc">'+value.xyGubun+'</td>'
									   + '	<td id="'+value.iSeq+'loopName'+value.hogi+'">'+value.Descr+'</td>'
									   + '	<td id="'+value.iSeq+'ioType'+value.hogi+'" class="tc">'+value.ioType+'</td>'
									   + '	<td id="'+value.iSeq+'address'+value.hogi+'" class="tc">'+value.address+'</td>'
									   + '	<td id="'+value.iSeq+'ioBit'+value.hogi+'" class="tc">'+(value.ioBit == '' ? '0' : value.ioBit)+'</td>'
									   + '	<td id="'+value.iSeq+'minVal'+value.hogi+'" class="tc">'+value.minVal+'</td>'
									   + '	<td id="'+value.iSeq+'maxVal'+value.hogi+'" class="tc">'+value.maxVal+'</td>'
									   + '	<td id="'+value.iSeq+'saveCoreChk'+value.hogi+'" class="tc">'+value.saveCoreChk+'</td>'
									   + '	<td id="'+value.iSeq+'iSeq'+value.hogi+'" style="display:none">'+value.iSeq+'</td>'
									   + '</tr>';
									   
				//ioListArray.push(value);
			});
			
			if( tagData.length < 8 ) {
				for( var ei=tagData.length;ei<8;ei++ ) {
					tagDccInfoListBodyStr += '<tr>'
										   + '	<td id="'+ei+'hogi'+ei+'" class="tc"></td>'
										   + '	<td id="'+ei+'xyGubun'+ei+'" class="tc"></td>'
										   + '	<td id="'+ei+'descr'+ei+'"></td>'
										   + '	<td id="'+ei+'ioType'+ei+'" class="tc"></td>'
										   + '	<td id="'+ei+'address'+ei+'" class="tc"></td>'
										   + '	<td id="'+ei+'ioBit'+ei+'" class="tc"></td>'
										   + '	<td id="'+ei+'minVal'+ei+'" class="tc"></td>'
										   + '	<td id="'+ei+'maxVal'+ei+'" class="tc"></td>'
										   + '	<td id="'+ei+'saveCoreChk'+ei+'" class="tc"></td>'
										   + '	<td id="'+ei+'iSeq'+ei+'" style="display:none"></td>'
										   + '</tr>';
				}
			}
		}
		
		tagDccInfoListBody.empty();
		tagDccInfoListBody.append(tagDccInfoListBodyStr);*/
		
		setAddedItem(tagData);
	}
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
	var refID = data.BaseSearch.refID;
	
	if( type == 'numericalFixed' ) {
		setData();
		
		closeModal('modal_1');
	} else {
		selectBody = $("#cboUGrpName");
		selectBodyStr = '<option id="init" value="null"></option>';
		for( var i=0;i<data.DccGroupList.length;i++ ) {
			selectBodyStr += '<option id="opt'+data.DccGroupList[i].groupNo+'" value="'+data.DccGroupList[i].groupNo+'">'+data.DccGroupList[i].groupName+'</option>';
		}
		selectBody.empty();
		selectBody.append(selectBodyStr);
		
		$("#cboUGrpName").val(data.UpdatedGrpNo);
		
		
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
			
			cboUGrpName_click(1);
			cboUGrpName_change();
		} else if( type == 'updateExistGroup' ) {
			closeModal('modal_1');
			
			cboUGrpName_click(1);
			cboUGrpName_change();
		}
		
		activeCharts = [];
		for( var i=0;i<xAxis.length;i++ ) {
			activeCharts.push(i);
		}
	}
}

function mbr_reloadGrpCallback(data) {
	selectBody = $("#cboUGrpName");
	selectBodyStr = '';
	
	if( data.DccGroupList != null ) {
        selectBodyStr += '<option id="init" value="null"></option>';
        for( var i=0;i<data.DccGroupList.length;i++ ) {
        	selectBodyStr += '<option id="opt'+data.DccGroupList[i].groupNo+'" value="'+data.DccGroupList[i].groupNo+'">'+data.DccGroupList[i].groupName+'</option>';
        }
        selectBodyStr += '</select>';
    }
    
	selectBody.empty();
	selectBody.append(selectBodyStr);
}

function trendCallback(data) {
	var type = data.resultType;
	var time = '';
	var color = '';
	
	if( type == 'barchart' ) {
		lblDataListAjax = data.LblValue;
		DccTagInfoListAjax = data.DccGrpTagList;
		maxListAjax = data.maxList;
		minListAjax = data.minList;
		tagMaxListAjax = data.FHiAlarm;
		tagMinListAjax = data.FLoAlarm;
		dtabMaxListAjax = data.FDtabHi;
		dtabMinListAjax = data.FDtabLo;
		
		time = data.ScanTime;
	} else if( type == 'logfixedlist' || type == 'logsparelist' ) {
		lblDataListAjax = data.lblDataList;
		DccTagInfoListAjax = data.TagDccInfoList;
		
		time = data.ScanTime;
	} else if( type == 'numerical' ) {
		lblDataListAjax = data.lblDataList;
		DccTagInfoListAjax = data.TagDccInfoList;
		lblVoltsAjax = data.lblVolts;
		lblCountListAjax = data.lblCountList;
		lblBinaryAjax = data.lblBinary;
		
		time = data.SearchTime == null ? '' : data.SearchTime;
	}
	color = data.ForeColor;
	
	setLblDate('','',time,color);
	setData();
}

function excelCallback(data) {
	
}