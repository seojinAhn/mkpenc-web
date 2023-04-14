function mbr_RuntimerEventCallback(data){
	console.log(data.ArrTrendData);
	var tagDccInfoListBody = $("#lblBody1");
	var tagDccInfoListBody2 = $("#lblBody2");
	var tagDccInfoListBodyStr = "";
	var tagDccInfoListBodyStr2 = "";
	
	var arrTrendData = data.ArrTrendData;
	var testArea = $("#testArea");
	var testStr = "";
	
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
	                                	   + '		<input id="lblCheckbox'+i+'" type="checkbox" checked>'
	                                	   + '		<span><label id="lblTagName'+i+'">'+data.LblInfoList[0][i]+'</label></span>'
	                                	   + '		<span><label id="lblValue'+i+'">'+data.LblInfoList[1][i].fValue+'</label></span>'
	                                	   + '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
	                            		   + '	</div>'
										   + '</div>';
				}
				for( var j=size;j<4;j++ ) {
					tagDccInfoListBodyStr += '<div class="fx_srch_item line">'
	                            		   + '	<div class="fx_form chart_sum color_'+(j+1)+'" style="display:none">'
	                                	   + '		<input id="lblCheckbox'+j+'" type="checkbox" checked>'
	                                	   + '		<span><label id="lblTagName'+j+'"></label></span>'
	                                	   + '		<span><label id="lblValue'+j+'"></label></span>'
	                                	   + '		<span><label id="lblUnit'+j+'"></label></span>'
	                            		   + '	</div>'
										   + '</div>';
				}
				for( var k=4;k<8;k++ ) {
					tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
	                            			+ '	<div class="fx_form chart_sum color_'+(k+1)+'" style="display:none">'
	                                		+ '		<input id="lblCheckbox'+k+'" type="checkbox" checked>'
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
	                                	   + '		<input id="lblCheckbox'+i+'" type="checkbox" checked>'
	                                	   + '		<span><label id="lblTagName'+i+'">'+data.LblInfoList[0][i]+'</label></span>'
	                                	   + '		<span><label id="lblValue'+i+'">'+data.LblInfoList[1][i].fValue+'</label></span>'
	                                	   + '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
	                            		   + '	</div>'
										   + '</div>';
				}
				for( var j=4;j<size;j++ ) {
					tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
	                            			+ '	<div class="fx_form chart_sum color_'+(j+1)+'">'
	                                		+ '		<input id="lblCheckbox'+j+'" type="checkbox" checked>'
	                                		+ '		<span><label id="lblTagName'+j+'">'+data.LblInfoList[0][j]+'</label></span>'
	                                		+ '		<span><label id="lblValue'+j+'">'+data.LblInfoList[1][j].fValue+'</label></span>'
	                                		+ '		<span><label id="lblUnit'+j+'">'+data.LblInfoList[2][j]+'</label></span>'
	                            			+ '	</div>'
											+ '</div>';
				}
				for( var k=size;k<8;k++ ) {
					tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
	                            			+ '	<div class="fx_form chart_sum color_'+(k+1)+'" style="display:none">'
	                                		+ '		<input id="lblCheckbox'+k+'" type="checkbox" checked>'
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
                                	   + '		<input id="lblCheckbox'+i+'" type="checkbox" checked>'
                                	   + '		<span><label id="lblTagName'+i+'">'+data.LblInfoList[0][i]+'</label></span>'
                                	   + '		<span><label id="lblValue'+i+'">'+data.LblInfoList[1][i].fValue+'</label></span>'
                                	   + '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
                            		   + '	</div>'
									   + '</div>';
			}
			for( var j=4;j<8;j++ ) {
				tagDccInfoListBodyStr2 += '<div class="fx_srch_item line">'
                            			+ '	<div class="fx_form chart_sum color_'+(j+1)+'">'
                                		+ '		<input id="lblCheckbox'+j+'" type="checkbox" checked>'
                                		+ '		<span><label id="lblTagName'+j+'">'+data.LblInfoList[0][j]+'</label></span>'
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
	                                			+ '		<input id="lblCheckbox'+i+'" type="checkbox" checked>'
	                                			+ '		<span><label id="lblTagName'+i+'">'+data.LblInfoList[0][i]+'</label></span>'
		                                		+ '		<span><label id="lblValue'+i+'">'+data.LblInfoList[1][i].fValue+'</label></span>'
		                                		+ '		<span><label id="lblUnit'+i+'">'+data.LblInfoList[2][i]+'</label></span>'
		                            			+ '	</div>'
												+ '</div>';
					} else {
						tagDccInfoListBodyStr2 += '</div>'
												+ '<div class="fx_srch_row" id="lblBody'+(ii+2)+'">"'
		                            			+ '	<div class="fx_form" style="color:#F'+i%9+''+(9-i%9)+''+(9-i%9)+''+i%9+'A">'
		                                		+ '		<input id="lblCheckbox'+i+'" type="checkbox" checked>'
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