function mbr_RuntimerEventCallback(data){
	
	var tagDccInfoListBody = $("#tagDccInfoList");
	var tagDccInfoListBodyStr = "";
	
	var idx=1;
	$.each(data.DccTagList, function(key, value){
		
			tagDccInfoListBodyStr += '<tr>'
										+ ' <td class="tc">'+ idx +'</td>'
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
		
}