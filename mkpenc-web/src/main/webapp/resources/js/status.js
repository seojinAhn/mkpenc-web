function	tagSearchCallback(data){
	
	var tagInfoBody = $("#tagInfos");
	var tagInfoBodyStr = "";
	
	tagInfoBodyStr += '<tr>'
	  		  + "<td><input style='text-align:center' type='text' id='txtHogi' name='txtHogi' value='"+data.TagSearchInfo[0].iHogi+"'></td>"
              + "<td><input style='text-align:center' type='text' id='txtXyGubun' name='txtXyGubun' value='"+data.TagSearchInfo[0].xyGubun+"'></td>"
              + "<td style='text-align:center'><input type='checkbox' id='xyAll' name='xyAll' value='1'></td>"
              + "<td><input type='text' id='txtDescr' name='txtDescr' value='"+data.TagSearchInfo[0].descr+"'></td>"
              + "<td><input style='text-align:center' type='text' id='txtIoType' name='txtIoType' value='"+data.TagSearchInfo[0].ioType+"'></td>"
              + "<td><input style='text-align:center' type='text' id='txtAddress' name='txtAddress' value='"+data.TagSearchInfo[0].address+"'></td>"
              + "<td><input style='text-align:center' type='text' id='txtIoBit' name='txtIoBit' value='"+data.TagSearchInfo[0].ioBit+"'></td>"
              + "	<td style='text-align:center'>"
              + "		<div class='button'>"
              + "			<a href='#none' class='btn_list' id='tagSearch' name='tagSearch'>검색</a>"
              + "		</div>"
              + "	</td>"
              + "</tr>";

	tagInfoBody.empty();
	tagInfoBody.append(tagInfoBodyStr);

}

function tagFindCallback(data){
	
	var tagSearhcListBody = $("#tagSearchList");
	var tagSearhcListBodyStr = "";
	var i=0;
	
	$.each(data.TagFindList, function(key, value){
		tagSearhcListBodyStr += "<tr id='tag"+i+"'>"
		  		  + "	<td class='tc' id='tagHogi' name='tagHogi' value='"+value.iHogi+"'>"+value.iHogi+"</td>"
	              + "	<td class='tc' id='tagXyGubun' name='tagXyGubun' value='"+value.xyGubun+"'>"+value.xyGubun+"</td>"
	              + "	<td class='tc' id='tagLoopName' name='tagLoopName' value='"+value.loopName+"'>"+value.loopName+"</td>"
	              + "	<td class='tc' id='tagIoType' name='tagIoType' value='"+value.ioType+"'>"+value.ioType+"</td>"
	              + "	<td class='tc' id='tagAddress' name='tagAddress' value='"+value.address+"'>"+value.address+"</td>"
	              + "	<td class='tc' id='tagIoBit' name='tagIoBit' value='"+value.ioBit+"'>"+value.ioBit+"</td>"
	              + "	<td class='tc' id='tagDescr' name='tagDescr' value='"+value.descr+"'>"+value.descr+"</td>"
	              + "</tr>";
          i++;
  	});

	tagSearhcListBody.empty();
	tagSearhcListBody.append(tagSearhcListBodyStr);
}

function mbr_chartCallback(data){
	var i=0;
	
	searchTime = data.SearchTime;
	lblDataListAjax = data.lblDataList;
	
	$.each(data.DccTagInfoList, function(key, value){
		bScales.splice(i,1,value.bscale+'');
		toolTipText.splice(i,1,value.toolTip);
		
		i++;
  	});
  	
  	reloadAjax(data.BaseSearch.searchStr);
}

function mbr_statusCallback(data) {
	if( data.BaseSearch.grpNo == '13' || data.BaseSearch.grpNo == 13 ) {
		type == 0;
		
		lblDataListAjax = data.lblDataList;
		lblConvListAjax = data.lblConvList;
		dccGrpTagListAjax = data.DccTagInfoList;
		
		setConst();
		setDate(data.SearchTime,data.ForeColor);
		setLblDataAjax(0);
	} else if( data.BaseSearch.grpNo == '14' ) {
		lblDataListAjax = data.lblDataList;
		dccGrpTagListAjax = data.DccTagInfoList;
		
		setLblDate(data.SearchTime,data.ForeColor);
		setLblDataAjax(0);
		
		if( bView ) {
			setDataAddress(0);
		} else {
			setChannelNo();
		}
		
		var avgCnt = 0;
		var avgVal = 0;
		for( var i=0;i<data.lblDataList.length;i++ ) {
			var tmp = data.lblDataList[i].fValue*1;
			if( tmp != -32768 && !isNaN(tmp) ) {
				avgCnt++;
				avgVal += tmp;
			}
		}
		calAvg(avgVal/avgCnt);
	}
}

function statusCallback(data) {
	var type = data.resultType;
	var searchTime = data.SearchTime;
	var color = data.ForeColor;
	setDate(searchTime,color);
	
	if( type == 'reactivity' ) {
		lblXYListAjax = data.lblXYList;
	} else if( type == 'stepback' ) {
		lblDataListAjax = data.lblDataList;
		DccTagInfoListAjax = data.DccTagInfoList;
		lblConvListAjax = data.lblConvList;
		vINDValListAjax = data.vINDValList;
		shpINDAjax = data.shpIND;
		shpIND2Ajax = data.shpIND2;
	} else {
		lblDataListAjax = data.lblDataList;
		DccTagInfoListAjax = data.DccTagInfoList;
	}
		
	setData();
}