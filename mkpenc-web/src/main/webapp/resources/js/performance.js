


function mbr_DccGrpTagEventCallback(data){
	
	var compareVarBody = $("#compareVarList");
	var compareVarBodyStr = "";
	
	$.each(data.TagDccInfoList, function(key, value){

	  			compareVarBodyStr += "<tr>"
                          					+ "  <td>"+  value.dataLoop  +"</td>";

            	if( value.IOTYPE == "DT" && (value.alarmType == 4 || value.alarmType == 12)){
                	   compareVarBodyStr	  += " <td class='tc'>%</td>";
                }else {
                	   compareVarBodyStr	  += " <td class='tc'>"+  value.unit  +"</td>";
                }
                
                
           switch (value.minVal){
                case 0 : 
                   compareVarBodyStr	  += " <td class='tc'>"+  value.maxVal  +"</td>";
                   break;
                case -1 :
                	compareVarBodyStr	  += " <td class='tc'> > "+  value.maxVal  +"</td>";
                	break;
                case -2 :
                    compareVarBodyStr	  += " <td class='tc'> < "+  value.maxVal  +"</td>";
                    break; 
                case -3 :
                    compareVarBodyStr	  += " <td class='tc'></td>";
                    break;
                default : 
                	compareVarBodyStr	  += ("<td class='tc'>"+  value.minVal  + "~" + value.maxVal  + "</td>");
             } 

                compareVarBodyStr	+= " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
					  		  + "</tr>";
				
	});
	
	compareVarBody.empty();
	compareVarBody.append(compareVarBodyStr);		
}

function mbr_MarkGrpTagEventCallback(data){
	
	var compareVarBody = $("#compareVarList");
	var compareVarBodyStr = "";
	
	$.each(data.TagMarkvInfoList, function(key, value){

	  			compareVarBodyStr += "<tr>"
                          					+ "  <td>"+  value.signal_Name  +"</td>";

            	if( value.IOTYPE == "DT" && (value.alarmType == 4 || value.alarmType == 12)){
                	   compareVarBodyStr	  += " <td class='tc'>%asdfadf asdf</td>";
                }else {
                	   compareVarBodyStr	  += " <td class='tc'>"+  value.unit  +"</td>";
                }
                
                
           switch (value.minVal){
                case 0 : 
                   compareVarBodyStr	  += " <td class='tc'>"+  value.maxVal  +"</td>";
                   break;
                case -1 :
                	compareVarBodyStr	  += " <td class='tc'> > "+  value.maxVal  +"</td>";
                	break;
                case -2 :
                    compareVarBodyStr	  += " <td class='tc'> < "+  value.maxVal  +"</td>";
                    break; 
                case -3 :
                    compareVarBodyStr	  += " <td class='tc'></td>";
                    break;
                default : 
                	compareVarBodyStr	  += ("<td class='tc'>"+  value.minVal  + "~" + value.maxVal  + "</td>");
             } 

                compareVarBodyStr	+= " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
				                           + " <td class='tc'></td>"
					  		  + "</tr>";
				
	});
	
	compareVarBody.empty();
	compareVarBody.append(compareVarBodyStr);		
}

function mbr_UGrpNoInfoEventCallback(data){
		
	if(data.GrpName != null){
		document.getElementById("uGrpName").value = data.GrpName.uGrpName;
	}

	
	var uGrpTagListBody = $("#uGrpTagList");
	var uGrpTagListBodyStr = "";
	
	$.each(data.TagDccInfoList, function(key, value){
		
				uGrpTagListBodyStr += '<tr>'
											+ ' <td class="tc">'+ value.hogi +'</td>'
					                        + ' <td class="tc">'+ value.xygubun +'</td>'
					                        + ' <td>'+ value.dataLoop +'</td>'
					                        + ' <td class="tr">'+ value.iotype +'</td>'
					                        + ' <td class="tc">'+ value.address +'</td>';
					                        
					                        if(value.saveCore == "0" && value.iotype == "SC"){
												uGrpTagListBodyStr += '<td class="tc"></td>'
											}else {
											    uGrpTagListBodyStr += ' <td class="tc">'+ value.iobit +'</td>'	
											}
					                        
				 uGrpTagListBodyStr += ' <td class="tc">'+ value.minVal +'</td>'
					                        + ' <td class="tc">'+ value.maxVal +'</td>'
					                        + ' <td class="tc">'+ value.saveCore +'</td>'
					                    + ' </tr>';
					                    
	});
		
	uGrpTagListBody.empty();
	uGrpTagListBody.append(uGrpTagListBodyStr);
}

function mbr_TagSearchEventCallback(data){
	
	var tagSearchListBody = $("#tagSearchList");
	var tagSearchListBodyStr = "";
	
	$.each(data.TagSearchList, function(key, value){
		
				tagSearchListBodyStr += '<tr>'
											+ ' <td class="tc">'+ value.IHOGI +'</td>'
					                        + ' <td class="tc">'+ value.XYGUBUN +'</td>'
					                        + ' <td>'+ value.LOOPNAME +'</td>'
					                        + ' <td>'+ value.DESCR +'</td>'
					                        + ' <td class="tc">'+ value.IOTYPE +'</td>'
					                        + ' <td class="tc">'+ value.ADDRESS +'</td>'
					                        + ' <td class="tc">'+ value.IOBIT +'</td>'	
					                        + ' <td class="tc">'+ value.ELOW +'</td>'
					                        + ' <td class="tc">'+ value.EHIGH +'</td>'
					                        + ' <td class="tc">0</td>'
					                        + ' <td style="display:none;">'+value.ISEQ +'</td>'
					                    + ' </tr>';
					                    
	});
	
	tagSearchListBody.empty();
	tagSearchListBody.append(tagSearchListBodyStr);
	
}

function mbr_FastIOSearchEventCallback(data){
	
}


function mbr_SetUGrpNameEventCallback(data){
	
	
//	$("#ioUGrpNo").val(data.BaseSearch.ioUGrpNo);
	
		
}


function mbr_RuntimerEventCallback(data){
	
	var tagDccInfoListBody = $("#tagDccInfoList");
	var tagDccInfoListBodyStr = "";
	
	var idx=1;
	$.each(data.DccTagList, function(key, value){
		
			tagDccInfoListBodyStr += '<tr>'
										+ ' <td class="tc">'+ idx +'</td>'
				                        + ' <td class="tc">'+ value.IOTYPE +'</td>'
				                        + ' <td class="tc">'+ value.ADDRESS +'</td>'
				                        + ' <td class="tc">'+ value.DataLoop +'</td>'
				                        + ' <td class="tc">'+ value.Descr +'</td>'
				                        + ' <td class="tc">'+ value.Value_3 +'</td>'
				                        + ' <td class="tc">'+ value.Value_4 +'</td>'
				                        + ' <td class="tc">'+ value.Unit +'</td>'
				                    + ' </tr>';				                    
			idx++;                    
	});
	
	tagDccInfoListBody.empty();
	tagDccInfoListBody.append(tagDccInfoListBodyStr);
		
}


$(function () {
	
	var selectedRow;
	var tagSearhRow;
	var bGroupFlag = false;
	
	$(document.body).delegate('#setVarTable tbody tbody tr', 'click', function() {
		$(this).removeClass("highlight");
		//$(this).siblings().removeClass("highlight");
	});
	
	$(document.body).delegate('#uGrpTagTable tbody tr', 'click', function() {
			$(this).addClass("highlight");
			$(this).siblings().removeClass("highlight");
			
			selectedRow = $(this);
			
			$('#hogi option:contains("' + selectedRow.children().eq(0).text().trim() +'")').prop("selected", true);
			$('#xyGubun option:contains("' + selectedRow.children().eq(1).text().trim() +'")').prop("selected", true);
			$("#loopName").val(selectedRow.children().eq(2).text().trim());
			$('#IOType option:contains("' + selectedRow.children().eq(3).text().trim() +'")').prop("selected", true);
			$("#addresss").val(selectedRow.children().eq(4).text().trim());
			$("#ioBit").val(selectedRow.children().eq(5).text().trim());
			$("#minVal").val(selectedRow.children().eq(6).text().trim());
			$("#maxVal").val(selectedRow.children().eq(7).text().trim());		
			
			//alert(selectedRow.children().eq(8).text().trim());
			
			if(selectedRow.children().eq(8).text().trim() == "1"){
				$("#saveCore").prop("checked", true);	
			}else {
				$("#saveCore").prop("checked", false);	
			}	
			
			$("#iSeq").val(selectedRow.children().eq(9).text().trim());
			
			//alert($("#iSeq").val());
	});
	
	
	$(document.body).delegate('#tagSearchTable tbody tr', 'click', function() {
		$(this).addClass("highlight");
		$(this).siblings().removeClass("highlight");
		
		tagSearhRow = $(this);
	});
	
	$(document.body).delegate('#uGrpTagTable tbody tr', 'click', function() {
		$(this).addClass("highlight");
		$(this).siblings().removeClass("highlight");
		
		selectedRow = $(this);
		
		$('#hogi option:contains("' + selectedRow.children().eq(0).text().trim() +'")').prop("selected", true);
		$('#xyGubun option:contains("' + selectedRow.children().eq(1).text().trim() +'")').prop("selected", true);
		$("#loopName").val(selectedRow.children().eq(2).text().trim());
		$('#IOType option:contains("' + selectedRow.children().eq(3).text().trim() +'")').prop("selected", true);
		$("#addresss").val(selectedRow.children().eq(4).text().trim());
		$("#ioBit").val(selectedRow.children().eq(5).text().trim());
		$("#minVal").val(selectedRow.children().eq(6).text().trim());
		$("#maxVal").val(selectedRow.children().eq(7).text().trim());		
		
		//alert(selectedRow.children().eq(8).text().trim());
		
		if(selectedRow.children().eq(8).text().trim() == "1"){
			$("#saveCore").prop("checked", true);	
		}else {
			$("#saveCore").prop("checked", false);	
		}	
		
		$("#iSeq").val(selectedRow.children().eq(9).text().trim());
		
		//alert($("#iSeq").val());
	});
	
 	$("#setVar").click(function(){
  		
		if($("#sUGrpNo option:selected").val() != ""){
			
			bGroupFlag = false;
  		
  			var comAjax = new ComAjax("compareVarSearch");
			comAjax.setUrl("/dcc/performance/getUGrpNoInfo");
			comAjax.setCallback("mbr_UGrpNoInfoEventCallback");
			comAjax.ajax();					  
  		}else {
  			bGroupFlag = true;
  		}
  		
  		openLayer('modal_1');
	});	
	
	
	$("#addUGrpName").click(function(){
		bGroupFlag = true;
		
		$("#uGrpName").val("");			
		$("#uGrpTagList").empty();		
		
		//그룹정보 신규 insert를 위해 iseq 정보를 삭제 
		//$("#iSeq").val("");
		
	 });	  		
	
	$("#tagSearchSelect").click(function(){
		
		$('#hogi option:contains("' + tagSearhRow.children().eq(0).text().trim() +'")').prop("selected", true);
		$('#xyGubun option:contains("' + tagSearhRow.children().eq(1).text().trim() +'")').prop("selected", true);
		$("#loopName").val(tagSearhRow.children().eq(2).text().trim());
		//descr value is not used --> index 3
		$('#IOType option:contains("' + tagSearhRow.children().eq(4).text().trim() +'")').prop("selected", true);
		$("#addresss").val(tagSearhRow.children().eq(5).text().trim());
		$("#ioBit").val(tagSearhRow.children().eq(6).text().trim());
		$("#minVal").val(tagSearhRow.children().eq(7).text().trim());
		$("#maxVal").val(tagSearhRow.children().eq(8).text().trim());
		//saveCore value is default 0 --> index 9
		$("#iSeq").val(tagSearhRow.children().eq(10).text().trim());
		
		if($("#loopName").val()==""){
			// IOType + Address + IOBit
			$("#loopName").val(tagSearhRow.children().eq(4).text().trim() + " " + tagSearhRow.children().eq(5).text().trim() + " " + tagSearhRow.children().eq(6).text().trim());
		}
		
		if(tagSearhRow.children().eq(4).text().trim() == "DI" || tagSearhRow.children().eq(4).text().trim() == "DO"){
			$("#minVal").val("0");
			$("#maxVal").val("1");
		}

		closeLayer('modal_2');
	 });	 
	
	$("#saveVarTable").click(function(){
		
		if($("#uGrpName").val() == ""){
			alert("제목을 입력하십시요...!!");
			$("#uGrpName").focus();
			return;
		}
//alert("length==" + $('#uGrpTagTable tbody tr').length);	
		 if($('#uGrpTagTable tbody tr').length == 0){
			 alert("변수값을 입력하십시요...!!");
			 return;
		 }
//;lert("bGroupFlag==" + bGroupFlag)			;
		if(bGroupFlag){
			$("#bGroupFlag").val("1");
		}else {
			$("#bGroupFlag").val("0");
			$("#ioUGrpNo").val($("#sUGrpNo option:selected").val());
			
			//alert($("#ioGrpNameForm [name='ioUGrpNo']").val());
			//alert($("#ioUGrpNo").val());
		}
		
		var hogiArr = new Array();
		var xyGubunArr = new Array();
		var loopNameArr = new Array();
		var ioTypeArr = new Array();
		var addressArr = new Array();
		var ioBitArr = new Array();
		var minValArr = new Array();
		var maxValArr = new Array();
		var saveCoreArr = new Array();
		var iSeqArr = new Array();
	
		$('#uGrpTagTable tbody tr').each(function(){
			
			var tr = $(this);
			var td = tr.children();
		
			 hogiArr.push(td.eq(0).text());
			 xyGubunArr.push(td.eq(1).text());
			 loopNameArr.push(td.eq(2).text());
			 ioTypeArr.push(td.eq(3).text());
			 addressArr.push(td.eq(4).text());
			 ioBitArr.push(td.eq(5).text());
			 minValArr.push(td.eq(6).text());
			 maxValArr.push(td.eq(7).text());
			 saveCoreArr.push(td.eq(8).text());
			 iSeqArr.push(td.eq(9).text());
			 
		});
		
		//alert("hogiArr=" + hogiArr);
		//alert("loopNameArr=" + loopNameArr);
	    //alert("iSeqArr.length=" + iSeqArr.length);
	
		var comAjax = new ComAjax("ioGrpNameForm");
		comAjax.addParam("hogiArr", hogiArr);
		comAjax.addParam("tXyGubun", xyGubunArr);
		comAjax.addParam("xyGubunArr", loopNameArr);
		comAjax.addParam("ioTypeArr", ioTypeArr);
		comAjax.addParam("addressArr", addressArr);
		comAjax.addParam("ioBitArr", ioBitArr);
		comAjax.addParam("minValArr", minValArr);
		comAjax.addParam("maxValArr", maxValArr);
		comAjax.addParam("saveCoreArr", saveCoreArr);
		comAjax.addParam("iSeqArr", iSeqArr);
		
		comAjax.setUrl("/dcc/performance/setUGrpName");
		comAjax.setCallback("mbr_SetUGrpNameEventCallback");
		//comAjax.ajax();	
		
	});
	
	$("#addVarTable").click(function(){
		
		//alert("length=" + $('#uGrpTagTable tr').lengthh);
			if($('#uGrpTagTable tbody tr').length >= 100){
				alert("100개 까지만 지정할 수 있습니다.!!");
				return;
			}
		
			if($("#minVal").val() == ""){
				$("#minVal").val("0"); 
			}
			
			if($("#maxVal").val() == ""){
				if($("#IOType option:selected").val()== "DI" || $("#IOType option:selected").val() == "DO" ||  $("#IOType option:selected").val() &&  $("#saveCore").is(":checked")){
					$("#maxVal").val("1"); 
				}else if($("#IOType option:selected").val()== "SC"){
					$("#maxVal").val("65535"); 
				}else if($("#IOType option:selected").val()== "DT"){
					$("#maxVal").val("1.5"); 
				}else {
					$("#maxVal").val("100"); 
				}
			}
			
			if($("#IOType option:selected").val()== "SC" && $("#saveCore").is(":checked")){
				if($("#ioBit").val() == ""){
					alert("IOBIT을 입력하십시요");
					$("#ioBit").focus();
					return;
				}
			}else if($("#IOType option:selected").val()== "SC"){
					$("#ioBit").val("");
			}

		
			if($.isNumeric($("#minVal").val()) == false  || $.isNumeric($("#maxVal").val()) == false){
					alert("MIN, MAX 값이 잘못되었습니다.");
					return;
			} 
			
			if($("#loopName").val() == ""){
				if($("#ioBit").val() != ""){
					$("#loopName").val($("#IOType option:selected").val() + " " + $("#addresss").val() + " " +$("#ioBit").val());
				}else {
					$("#loopName").val($("#IOType option:selected").val() + " " + $("#addresss").val());
				}				
			}
		
			var chk = false;
			$('#uGrpTagTable tbody tr').each(function(){
				
				var tr = $(this);
				var td = tr.children();

				//var hogi = td.eq(0).text();
				var iSeq = td.eq(9).text();
				
				/*
				alert("hogi = " + hogi);
				alert("iSeq7= " + iSeq7);
				alert("iSeq8 = " + iSeq8);
				alert("iSeq = " + iSeq);
				*/
				
				if(iSeq !=null && iSeq != "" && $("#iSeq").val() == iSeq){
					chk= true;
				}
			});

			if(chk){
				alert("이미 설정되어 있습니다.");
				return;
			}
		
			var uGrpTagListBody = $("#uGrpTagList");
			var uGrpTagListBodyStr = "";
			
			uGrpTagListBodyStr += '<tr>'
				+ ' <td class="tc">'+ $("#hogi option:selected").val()+'</td>'
                + ' <td class="tc">'+ $("#xyGubun option:selected").val()+'</td>'
                + ' <td>'+ $("#loopName").val() +'</td>'
                + ' <td class="tr">'+ $("#IOType option:selected").val() +'</td>'
                + ' <td class="tc">'+ $("#addresss").val()+'</td>'
                + ' <td class="tc">'+ $("#ioBit").val()+'</td>'
                + ' <td class="tc">'+ $("#minVal").val()+'</td>'
                + ' <td class="tc">'+ $("#maxVal").val()+'</td>';
                
                
                if($("#saveCore").is(":checked")){
                	uGrpTagListBodyStr += ' <td class="tc">1</td>';
                } else {
                	uGrpTagListBodyStr += ' <td class="tc">0</td>';
                }
                
                uGrpTagListBodyStr += ' <td  style="display:none;">'+$("#iSeq").val()+'</td>';
                uGrpTagListBodyStr += ' </tr>';
                
			//uGrpTagListBody.empty();
			uGrpTagListBody.append(uGrpTagListBodyStr);                
                			
		});	  	
				
		$("#modVarTable").click(function(){
			
		});	  			
		
		$("#delVarTable").click(function(){
			if(selectedRow != null){
				
				alert("selectedRow");
				
				
				selectedRow.remove();
			}
		});
		
		$("#rowUp").click(function(){
	  		if(selectedRow != null){
	  			selectedRow.insertBefore(selectedRow.prev());
	  		}
	  	});
		   
	  	
	  	$("#rowDown").click(function(){
	  		if(selectedRow != null){
	  			selectedRow.insertAfter(selectedRow.next());
	  		}
	  	});
	  	
		$("#tagFind").click(function(){
			
			if($("#sIOType option:selected").val() ==""){
				 alert("IOTYPE을 선택하세요.!!");
				 $("#sIOType").focus();
				 return;			
			}
			
			if($("#tagSearchForm [name='chkOpt1']").is(":checked") == false &&
					$("#tagSearchForm [name='chkOpt2']").is(":checked") ==false ){
				alert("태크명 또는 태그설명을 선택하세요");
				return;
			}
			
			if($("#tagSearchForm [name='findData']").val() != ""){
		  		
	  			var comAjax = new ComAjax("tagSearchForm");
				comAjax.setUrl("/dcc/performance/tagSearch");
				comAjax.setCallback("mbr_TagSearchEventCallback");
				comAjax.ajax();					  
	  		}else {
	  			
	  			alert("검색어를 입력하세요");
	  			$("#findData").focus();
				return;
	  		}	
			
		 });	  
		
		$("#fastIoFind").click(function(){
			
			var comAjax = new ComAjax("tagSearchForm");
			comAjax.setUrl("/dcc/performance/fastioSearch");
			comAjax.setCallback("mbr_FastIOSearchEventCallback");
			comAjax.ajax();					  
			
		 });	  
	
	
});	

function mbr_performanceCallback(data) {
	//console.log(data.BaseSearch);
	setLblDate(data.SearchTime);
	
	if( data.BaseSearch.sUGrpNo == '2' ) {
		lblDataListAjax = data.lblDataList;
		lblSCMAjax = data.lblSCM;
		dccGrpTagListAjax = data.DccGrpTagList;
		
		UserControl_Paint(0);
	} else if( data.BaseSearch.sUGrpNo == '3' ) {
		lblDataListAjax = data.lblDataList;
		lblSCMAjax = data.lblSCM;
		dccGrpTagListAjax = data.DccGrpTagList;
	}
	
	setLblDataAjax(0);
}

function performanceCallback(data) {
	var type = data.resultType;
	
	if( type == 'fixed' ) {
		var tblBody = $("#compareVarList");
		var tblBodyStr = '';
		
		if( data.TagDccInfoList != null ) {
			for( var i=0;i<data.TagDccInfoList.length;i++ ) {
				tblBodyStr += '<tr>'
                            + '	<td>'+data.TagDccInfoList[i].dataLoop+'</td>';
				if( data.TagDccInfoList[i].IOTYPE == 'DT' && (data.TagDccInfoList[i].alarmType == 4 || data.TagDccInfoList[i].alarmType == 12) ) {
                	tblBodyStr += '	<td class="tc">%</td>';
            	} else {
					tblBodyStr += '	<td class="tc">'+data.TagDccInfoList[i].unit+'</td>';
				}
				
				if( data.TagDccInfoList[i].minVal == 0 ) {
                	tblBodyStr += '	<td class="tc">'+data.TagDccInfoList[i].maxVal+'</td>';
            	} else if( data.TagDccInfoList[i].minVal == -1 ) {
					tblBodyStr += '	<td class="tc">>'+data.TagDccInfoList[i].maxVal+'</td>';
				} else if( data.TagDccInfoList[i].minVal == -2 ) {
					tblBodyStr += '	<td class="tc"><'+data.TagDccInfoList[i].maxVal+'</td>';
				} else if( data.TagDccInfoList[i].minVal == -3 ) {
					tblBodyStr += '	<td class="tc"></td>';
				} else {
					tblBodyStr += '	<td class="tc">'+data.TagDccInfoList[i].minVal+' ~ '+data.TagDccInfoList[i].maxVal+'</td>';
				}
				tblBodyStr += '	<td class="tc">'+data.TagDccInfoList[i].spareAvgFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].spareStdevFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].spareMaxFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].spareMinFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].fixedAvgFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].fixedStdevFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].fixedMaxFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].fixedMinFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].gapAB+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].rateAB+'</td>'
                            + '</tr>';
			}
		} else {
			tblBodyStr += '<tr>'
                     	+ '	<td></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                    	+ '	<td class="tc"></td>'
                    	+ '	<td class="tc"></td>'
                    	+ '	<td class="tc"></td>'
                        + '</tr>';
		}
		  
		tblBody.empty();
		tblBody.append(tblBodyStr);
	} else if( type == 'spare' ) {
		var tblBody = $("#compareVarList");
		var tblBodyStr = '';
		
		if( data.TagDccInfoList != null ) {
			for( var i=0;i<data.TagDccInfoList.length;i++ ) {
				tblBodyStr += '<tr>'
                            + '	<td>'+data.TagDccInfoList[i].LOOPNAME- data.TagDccInfoList[i].spareAvgFldNo+'</td>';
				if( data.TagDccInfoList[i].IOTYPE == 'DT' && (data.TagDccInfoList[i].alarmType == 4 || data.TagDccInfoList[i].alarmType == 12) ) {
                	tblBodyStr += '	<td class="tc">%</td>';
            	} else {
					tblBodyStr += '	<td class="tc">'+data.TagDccInfoList[i].unit+'</td>';
				}
				
				if( data.TagDccInfoList[i].minVal == 0 ) {
                	tblBodyStr += '	<td class="tc">'+data.TagDccInfoList[i].maxVal+'</td>';
            	} else if( data.TagDccInfoList[i].minVal == -1 ) {
					tblBodyStr += '	<td class="tc">>'+data.TagDccInfoList[i].maxVal+'</td>';
				} else if( data.TagDccInfoList[i].minVal == -2 ) {
					tblBodyStr += '	<td class="tc"><'+data.TagDccInfoList[i].maxVal+'</td>';
				} else if( data.TagDccInfoList[i].minVal == -3 ) {
					tblBodyStr += '	<td class="tc"></td>';
				} else {
					tblBodyStr += '	<td class="tc">'+data.TagDccInfoList[i].minVal+' ~ '+data.TagDccInfoList[i].maxVal+'</td>';
				}
				tblBodyStr += '	<td class="tc">'+data.TagDccInfoList[i].spareAvgFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].spareStdevFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].spareMaxFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].spareMinFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].fixedAvgFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].fixedStdevFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].fixedMaxFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].fixedMinFldNo+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].gapAB+'</td>'
                            + '	<td class="tc">'+data.TagDccInfoList[i].rateAB+'</td>'
                            + '</tr>';
			}
		} else {
			tblBodyStr += '<tr>'
                     	+ '	<td></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                     	+ '	<td class="tc"></td>'
                    	+ '	<td class="tc"></td>'
                    	+ '	<td class="tc"></td>'
                    	+ '	<td class="tc"></td>'
                        + '</tr>';
		}
		  
		tblBody.empty();
		tblBody.append(tblBodyStr);
	} else if( type == 'aicheck' ) {
		lblDataListAjax = data.lblDataXList;
		shpDataListAjax = data.shpDataXList;
		lblDateAjax = data.XSearchTime;
		lblDateColorAjax = data.XForeColor;
		
		setLblDate();
		setData();
	} else if( type == 'dccselfcheck' ) {
		lblDataListXAjax = data.lblDataXList;
		lblDataListYAjax = data.lblDataYList;
		shpDataXAjax = data.shpDataXList;
		shpDataYAjax = data.shpDataYList;
		XSearchTimeAjax = data.XSearchTime;
		YSearchTimeAjax = data.YSearchTime;
		XForeColorAjax = data.lblDataListX;
		YForeColorAjax = data.lblDataListX;
		
		setLblDate();
		setData();
	} else if( type == 'mainsysiostatus' ) {
		lblDataListXAjax = data.lblDataXList;
		lblDataListYAjax = data.lblDataYList;
		XSearchTimeAjax = data.XSearchTime;
		YSearchTimeAjax = data.YSearchTime;
		XForeColorAjax = data.lblDataListX;
		YForeColorAjax = data.lblDataListX;
		
		setLblDate();
		setData();
	} else if( type == 'programonoff' ) {
		XSearchTimeAjax = data.XSearchTime;
		XForeColorAjax = data.XForeColor;
		lblDataXListAjax = data.lblDataXList;
		shpDataXListAjax = data.shpDataXList;
		
		YSearchTimeAjax = data.YSearchTime;
		YForeColorAjax = data.YForeColor;
		lblDataYListAjax = data.lblDataYList;
		shpDataYList = data.shpDataXList;
		
		setLblDate();
		setData();
	}
}




