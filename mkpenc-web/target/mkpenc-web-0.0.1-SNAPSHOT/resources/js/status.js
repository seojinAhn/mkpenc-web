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
