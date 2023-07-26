


function	mbr_UserGroupCallback(data){
	
	$("#usrGroupCode").val(data.BaseSearch.groupCode);
	$("#usrGroupName").val(data.BaseSearch.groupName);;	
	
	var userGroupBody = $("#groupList");
	var userGroupBodyStr = "";
	
	$.each(data.GroupList, function(key, value){
		
	  userGroupBodyStr += '<tr>'
		      + " <td class='tc'>" + value.groupCode + "</td>'"
			  + " <td class='tc'>" + value.groupName +"</td>"
	  		  + "</tr>";
	});
	
	userGroupBody.empty();
	userGroupBody.append(userGroupBodyStr);	
	
	var userPaginateBody = $("#userPaginate");
	var userPaginateBodyStr = data.UserGroupPageHtml;

	userPaginateBody.empty();
	userPaginateBody.append(userPaginateBodyStr);	
	
}


function	mbr_UserGroupEventCallback(data){
	
	if(data.EventIdx ==1){
		if(data.Rtn == 1){
			alert("사용자 그룹 등록을 완료합니다.");
			usrGrpSendPage(1);
		}else {
			alert("사용자 그룹 등록을 실패했습니다..");
		}
	
	}else if(data.EventIdx ==2){
		if(data.Rtn == 1){
			alert("사용자 그룹 삭제를 완료합니다.");
			$("#usrGroupCode").val("");
			$("#usrGroupName").val("");
			usrGrpSendPage(1);
		}else {
			alert("사용자 그룹 삭제를 실패했습니다..");
		}
	}

}


function mbr_SwSmEventCallback(data){
	
	
	if(data.SwSmInfo != null){
		
		var swsmBody = $("#swsmInfo");
		var swsmBodyStr = '';
		
		var swsmInfo = data.SwSmInfo;
		
		swsmBodyStr += '<tr>'
                + '    <th>Log번호 *</th>'
                + '    <td><input type="text"  id="iLogNo" name="iLogNo" value="'+ swsmInfo.logNo +'"></td>'
                + '</tr>'
                + '<tr>'
                + '    <th>변경서 고유번호 *</th>'
                + '    <td><input type="text" id="iProNo" name = "iProNo" value="'+ swsmInfo.proNo +'"></td>'
                + '</tr>'
                + ' <tr>'
                + '   <th>프로그램 명 *</th>'
                + '    <td><input type="text"  id="iProgName" name = "iProgName" value="'+ swsmInfo.progName +'"></td>'
                + '</tr>'                           
                + '<tr>'
                + '    <th>분류 *</th>'
                + '    <td><input type="text"  id="iDivide" name = "iDivide" value="'+ swsmInfo.divide +'"></td>'
                + '</tr>'
                + '<tr>'
                + '    <th>내용 </th>'
                + '    <td><textarea style="height:240px;" id="iDescr" name = "iDescr">'+ swsmInfo.descr+'</textarea></td>'
                + '</tr>'
                + '<tr>'
				+ '	<th>일자 </th>'
                + '  <td><input type="text"  id="iCreateDate" name = "iCreateDate" value="'+ swsmInfo.createDate +'"></td>'
                + '</tr>'
                + '<tr>'
                + '    <th>호기 *</th>'
                + '    <td> <input type="text"   id="iHogi" name="iHogi" value="'+ swsmInfo.hogi +'"></td>'                             
                + '</tr>'
                + ' <tr>'
                + '   <th>비고 </th>'
                + '   <td> <input type="text"   id="iBigo" name="iBigo" value="'+ swsmInfo.bigo +'"></td>'                             
                + '</tr>'      
                + '<tr>'
                + '   <th>첨부파일1</th>'
                + '   <td id="attachFile1"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +1+ ')">'+  (swsmInfo.fileName1 != null?  swsmInfo.fileName1:"") +'</a> </td>'
                + '</tr>'  
                + '<tr>'
                + '    <th>첨부파일2</th>'
                + '   <td id="attachFile2"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +2+ ')">'+ (swsmInfo.fileName2 != null?  swsmInfo.fileName2:"")  +'</a> </td>'
                + '</tr>'   
                + '<tr>'
                + '    <th>첨부파일3</th>'
                 + '   <td id="attachFile3"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +3+ ')">'+  (swsmInfo.fileName3 != null?  swsmInfo.fileName3:"")  +'</a> </td>'
                + '</tr>'  
                + ' <tr>'
                + '    <th>첨부파일4</th>'
                + '   <td id="attachFile4"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +4+ ')">'+  (swsmInfo.fileName4 != null?  swsmInfo.fileName4:"") +'</a> </td>'
                + '</tr>'
                + '<tr>'
                + '   <th>첨부파일5</th>'
                + '   <td id="attachFile5"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +5+ ')">'+  (swsmInfo.fileName5 != null?  swsmInfo.fileName5:"")  +'</a> </td>'
                + '</tr>'  
                +'<tr>'
                + '    <th>첨부파일6</th>'
                 + '   <td id="attachFile6"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +6+ ')">'+  (swsmInfo.fileName6 != null?  swsmInfo.fileName6:"") +'</a> </td>'
                + '</tr>'
                + '<tr>'
                + '    <th>첨부파일7</th>'
                 + '   <td id="attachFile7"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +7+ ')">'+ (swsmInfo.fileName7 != null?  swsmInfo.fileName7:"") +'</a> </td>'
                + '</tr>'  
                + '<tr>'
                + '    <th>첨부파일8</th>'
                 + '   <td id="attachFile8"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +8+ ')">'+ (swsmInfo.fileName8 != null?  swsmInfo.fileName8:"") +'</a> </td>'
                + '</tr>'
                + '<tr>'
                + '    <th>첨부파일9</th>'
                 + '   <td id="attachFile9"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +9+ ')">'+  (swsmInfo.fileName9 != null?  swsmInfo.fileName9:"")+'</a> </td>'
                + '</tr>'  
                + '<tr>'
                + '    <th>첨부파일10</th>'
                 + '   <td id="attachFile10"><a href="javascript:swsmDownload('+swsmInfo.seqNo +',' +10+ ')">'+ (swsmInfo.fileName10 != null?  swsmInfo.fileName10:"") +'</a> </td>'
                + '</tr>'  
                + '<tr style="display:none">'
                + '    <th>iSeq</th>'
                 + '   <td id="currentISeq">'+swsmInfo.seqNo+'</td>'
                + '</tr>' ;
				
		swsmBody.empty();
		swsmBody.append(swsmBodyStr);
	}		
}


function mbr_EquipInfoCallback(data){
	
		if(data.EquipInfo != null){
			
			var equipInfo = data.EquipInfo;
			
			var equipInfoDetailBody = $("#equipInfoDetail");
			var equipInfoDetailBodyStr = '';
			
			equipInfoDetailBodyStr += '<tr>' 
                  + '  <th colspan="4">Ⅰ. 관리번호</th>'
                  + '</tr>'  
                  + '<tr>'
                  + '  <th>관리번호 * </th>'
                  + '  <td><input type="text" id="uInvnr" name="uInvnr" value= "' +equipInfo.invnr  + '" readonly></td>'
                  + '  <th>담당자</th>'
                  + '  <td><input type="text" id="uUserNm" name="uUserNm" value= "' +equipInfo.userNm  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>호기</th>';
                  
                  
                  var check_3_hogi="";
                  var check_4_hogi="";
                  if(equipInfo.hogi  == 3) {
						check_3_hogi = "selected"; 
				  } else if(equipInfo.hogi  == 4) {
					check_4_hogi = "selected"; 
			      }
                  
                  
                  
             equipInfoDetailBodyStr += '  <td><select id="uHogi" name="uHogi">'                  
                  + '                  <option value="3" '+  check_3_hogi  +'> 3호기</option>'
                  + '                  <option value="4" '+  check_4_hogi  +'> 4호기</option>'
                  + '         </select></td>'
                  + '  <th>설치장소</th>'
                  + '  <td><input type="text" id="uInsLoc" name="uInsLoc" value= "' +equipInfo.insLoc  + '"></td>'
                  + '</tr>'       
                  + '<tr>'
                  + '  <th>품명</th>'
                  + ' <td><input type="text" id="uEquipNm" name="uEquipNm" value= "' +equipInfo.equipNm  + '"></td>'
                  + '  <th>태그번호</th>'
                  + '  <td><input type="text" id="uTagNo" name="uTagNo" value= "' +equipInfo.tagNo  + '"></td>'
                  + '</tr>'  
                  + '<tr>'
                  + '  <th colspan="4">Ⅱ. 사양</th>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>제작사</th>'
                  + '  <td><input type="text" id="uProduct" name="uProduct" value= "' +equipInfo.product  + '"></td>'
                  + ' <th>계통명</th>'
                  + '  <td><input type="text" id="uSysNm" name="uSysNm" value= "' +equipInfo.sysNm  + '"></td>'
                  + '</tr>'  
                  + '<tr>'
                  + ' <th>Part No.</th>'
                  + '  <td><input type="text" id="uPn" name="uPn" value= "' +equipInfo.pn  + '"></td>'
                  + '  <th>Serial No.</th>'
                  + '  <td><input type="text" id="uSn" name="uSn" value= "' +equipInfo.sn  + '"></td>'
                  + ' </tr>'
                  + '<tr>'
                  + '  <th>자재번호</th>'
                  + '  <td><input type="text" id="uMaterialNo" name="uMaterialNo" value= "' +equipInfo.materialNo  + '"></td>'
                  + '  <th>설치위치(RACK)</th>'
                  + '  <td><input type="text" id="uRack" name="uRack" value= "' +equipInfo.rack  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>제작연도</th>'
                  + '  <td><input type="text" id="uProDate" name="uProDate" value= "' +equipInfo.proDate  + '"></td>'
                  + '  <th>REV . NO</th>'
                  + ' <td><input type="text" id="uRev" name="uRev" value= "' +equipInfo.rev  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>취약부품</th>'
                  + '  <td><input type="text" id="uWeakPart" name="uWeakPart" value= "' +equipInfo.weakPart  + '"></td>'
                  + '  <th>설치일자</th>'
                  + '  <td><input type="text" id="uInsDate" name="uInsDate" value= "' +equipInfo.insDate  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>FID</th>'
                  + '  <td><input type="text" id="uTitle" name="uFid" value= "' +equipInfo.fid  + '"></td>'
                  + '  <th>SPV</th>'
                  + '  <td><input type="text" id="uTitle" name="uiSpv" value= "' +equipInfo.spv  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>품질등급</th>'
                  + '  <td><input type="text" id="uQGrade" name="uQGrade" value= "' +equipInfo.qGrade  + '"></td>'
                  + '  <th>저장등급</th>'
                  + '  <td><input type="text" id="uSGrade" name=""uSGrade"" value= "' +equipInfo.sGrade  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>저장수명</th>'
                  + '  <td><input type="text" id="uSyear" name="uSYear" value= "' +equipInfo.sYear  + '"></td>'
                  + '  <th>공급자</th>'
                  + ' <td><input type="text" id="uSupplier" name="uSupplier" value= "' +equipInfo.supplier  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>PO</th>'
                  + '  <td><input type="text" id="uPo" name="uPo" value= "' +equipInfo.po  + '"></td>'
                  + '  <th>최종입고일자</th>'
                  + '  <td><input type="text" id="uInDate" name="uInDate" value= "' +equipInfo.inDate  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>최종입고수량</th>'
                  + '  <td><input type="text" id="uInCnt" name="uInCnt" value= "' +equipInfo.inCnt  + '"></td>'
                  + '  <th>현상태</th>'
                  + '  <td><input type="text" id="uState" name="uState" value= "' +equipInfo.state  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>취약부품명</th>'
                  + '  <td><input type="text" id="uWPartNm" name="uWPartNm" value= "' +equipInfo.weakPart  + '"></td>'
                  + '  <th>부품자재번호</th>'
                  + '  <td><input type="text" id="uPmNo" name="uPmNo" value= "' +equipInfo.pmNo  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>부품교체일자</th>'
                  + '  <td><input type="text" id="uPcDate" name="uPcDate" value= "' +equipInfo.pcDate  + '"></td>'
                  + '  <th>부품교체주기</th>'
                  + '  <td><input type="text" id="uPcCycle" name="uPcCycle" value= "' +equipInfo.pcCycle  + '"></td>'
                  + ' </tr>'
                  + '<tr>'
                  + '  <th>ICT주기</th>'
                  + '  <td><input type="text" id="uIctCycle" name="uIctCycle" value= "' +equipInfo.ictCycle  + '"></td>'
                  + '  <th>교체주기</th>'
                  + '  <td><input type="text" id="uChgCycle" name="uChgCycle" value= "' +equipInfo.chgCycle  + '"></td>'
                  + '</tr>'
                  + '<tr>'
                  + '  <th>점검방법</th>'
                  + '  <td><input type="text" id="uChkMeth" name="uChkMeth" value= "' +equipInfo.chkMeth  + '"></td>'
                  + '  <th>점검주기</th>'
                  + '  <td><input type="text" id="uChkCycle" name="uChkCycle" value= "' +equipInfo.chkCycle  + '"></td>'
                  + '</tr>';
                  
                equipInfoDetailBody.empty();
				equipInfoDetailBody.append(equipInfoDetailBodyStr);     
                  
					
				var equipInfoEtcBody = $("#equipInfoEtc");			
				var equipInfoEtcBodyStr = '<tr>'
					                + '    <th colspan="3" >Ⅲ. 정비이력</th>'
							        + '        </tr>'
							        + '        <tr>'
							        + '            <th>년 월 일</th>'
							        + '            <th>정 비 내 용</th>'
							        + '            <th>비         고</th>'
							        + '        </tr>'
							        + '        <tr>'
							        + '             <td><input type="text" id="iMDate1" name="iMDate1" value= "' +equipInfo.mDate1  + '"></td>'
							        + '             <td><input type="text" id="iMContent1" name="iMContent1" value= "' +equipInfo.mContent1  + '"></td>'
							        + '             <td><input type="text" id="iMBigo1" name="iMBigo1" value= "' +equipInfo.mBigo1  + '"></td>'
							        + '        </tr>'
							        + '         <tr>'
							        + '             <td><input type="text" id="iMDate2" name="iMDate2" value= "' +equipInfo.mDate2  + '"></td>'
							        + '             <td><input type="text" id="iMContent2" name="iMContent2" value= "' +equipInfo.mContent2  + '"></td>'
							        + '             <td><input type="text" id="iMBigo2" name="iMBigo2" value= "' +equipInfo.mBigo2  + '"></td>'
							        + '        </tr>'
							        + '         <tr>'
							        + '             <td><input type="text" id="iMDate3" name="iMDate3" value= "' +equipInfo.mDate3  + '"></td>'
							        + '             <td><input type="text" id="iMContent3" name="iMContent3" value= "' +equipInfo.mContent3  + '"></td>'
							        + '             <td><input type="text" id="iMBigo3" name="iMBigo3" value= "' +equipInfo.mBigo3  + '"></td>'
							        + '        </tr>'
							        + '         <tr>'
							        + '             <td><input type="text" id="iMDate4" name="iMDate4" value= "' +equipInfo.mDate4  + '"></td>'
							        + '             <td><input type="text" id="iMContent4" name="iMContent4" value= "' +equipInfo.mContent4  + '"></td>'
							        + '             <td><input type="text" id="iMBigo4" name="iMBigo4" value= "' +equipInfo.mBigo4  + '"></td>'
							        + '        </tr>'
							        + '        <tr>'
							        + '            <th colspan="3">Ⅳ. 특이사항</th>'
							        + '        </tr>'
							        + '        <tr>'
							        + '            <th>년 월 일</th>'
							        + '            <th>변 동 사 항</th>'
							        + '            <th>비         고</th>'
							        + '        </tr>'
							        + '         <tr>'
							        + '             <td><input type="text" id="iEDate1" name="iEDate1" value= "' +equipInfo.eDate1  + '"></td>'
							        + '             <td><input type="text" id="iEcontent1" name="iEcontent1" value= "' +equipInfo.eContent1  + '"></td>'
							        + '             <td><input type="text" id="iEBigo1" name="iEBigo1" value= "' +equipInfo.eBigo1  + '"></td>'
							        + '        </tr>'
							        + '        <tr>'
							        + '             <td><input type="text" id="iEDate2" name="iEDate2" value= "' +equipInfo.eDate2  + '"></td>'
							        + '             <td><input type="text" id="iEcontent2" name="iEcontent2" value= "' +equipInfo.eContent2  + '"></td>'
							        + '             <td><input type="text" id="iEBigo2" name="iEBigo2" value= "' +equipInfo.eBigo2  + '"></td>'
							        + '        </tr>'
							        + '      <tr>'
							        + '             <td><input type="text" id="iEDate3" name="iEDate3" value= "' +equipInfo.eDate3  + '"></td>'
							        + '             <td><input type="text" id="iEcontent3" name="iEcontent3" value= "' +equipInfo.eContent3  + '"></td>'
							        + '             <td><input type="text" id="iEBigo3" name="iEBigo3" value= "' +equipInfo.eBigo3  + '"></td>'
							        + '        </tr>'
							        + '        <tr>'
							        + '             <td><input type="text" id="iEDate4" name="iEDate4" value= "' +equipInfo.eDate4  + '"></td>'
							        + '             <td><input type="text" id="iEcontent1" name="iEcontent4" value= "' +equipInfo.eContent4  + '"></td>'
							        + '             <td><input type="text" id="iEBigo4" name="iEBigo4" value= "' +equipInfo.eBigo4  + '"></td>'
							        + '        </tr>';

					equipInfoEtcBody.empty();
					equipInfoEtcBody.append(equipInfoEtcBodyStr);	
				
		}
	
}


function mbr_RestartCodeEventCallback(data){
	
		   if(data.RestartCodeInfo != null){
				
				var restartCodeBody = $("#restartCodeInfo");
				var restartCodeBodyStr = '';
				
				var restartCodeInfo = data.RestartCodeInfo;
			
				restartCodeBodyStr += '<tr>'
		                  	+ '		<th>호기 *</th>'
		                    + '		<td> '+ restartCodeInfo.hogi +'호기 ('+ restartCodeInfo.xyGubun+')</td>'
				            + '    <tr>'
							+ '		<th>일자 * </th>'
				            + '       <td>'+ restartCodeInfo.createDate +'</td>'
				            + '    </tr>';
			            
				            var strType;
				            if(restartCodeInfo.type == '0'){
								strType = "Stall";
							}else if(restartCodeInfo.restartCode == '1'){
								strType = "Restart";
							}
				restartCodeBodyStr += '<tr>'
							+ '		<th>형식 * </th>'
				            + '        <td>'+strType+'</td>'
				            + '    </tr>';
				         
							var strRestartCode;
							if(restartCodeInfo.restartCode == '111111'){
								strRestartCode = "Initial Cold Start";
							}else if(restartCodeInfo.restartCode == '000503'){
								strRestartCode = "Console Interrupt";
							}else if(restartCodeInfo.restartCode == '100514'){
								strRestartCode = "Power Fail/Up";
							}else if(restartCodeInfo.restartCode == '000517'){
								strRestartCode = "Memory Parity Error";
							}else if(restartCodeInfo.restartCode == '000522'){
								strRestartCode = "Watchdog Time-Ou";
							}else if(restartCodeInfo.restartCode == '011112'){
								strRestartCode = "IIIegal Memory Map Violations";
							}	
							
				  restartCodeBodyStr +=  '   <tr>'
							+ '			<th>Restart Code * </th>'         
				  			+ '       <td> '+ strRestartCode +'</td>'
				            + '    </tr>'
				            + '    <tr>'
				            + '        <th>내용 *</th>'
				            + '        <td>'+ restartCodeInfo.descr +'</td>'
				            + '    </tr>'               
							+ '<tr>' 
				            + '   <th>첨부파일1</th>'
			                + '   <td><a href="javascript:restartCodeDownload('+restartCodeInfo.seqNo +',' +1+ ')">'+  (restartCodeInfo.fileName1 != null?  restartCodeInfo.fileName1:"") +'</a> </td>'
			                + '</tr>'  
			                + '<tr>'
			                + '    <th>첨부파일2</th>'
			                + '   <td><a href="javascript:restartCodeDownload('+restartCodeInfo.seqNo +',' +2+ ')">'+ (restartCodeInfo.fileName2 != null?  restartCodeInfo.fileName2:"")  +'</a> </td>'
			                + '</tr>'   
			                + '<tr>'
			                + '    <th>첨부파일3</th>'
			                 + '   <td><a href="javascript:restartCodeDownload('+restartCodeInfo.seqNo +',' +3+ ')">'+  (restartCodeInfo.fileName3 != null?  restartCodeInfo.fileName3:"")  +'</a> </td>'
			                + '</tr>'  
			                + ' <tr>'
			                + '    <th>첨부파일4</th>'
			                + '   <td><a href="javascript:restartCodeDownload('+restartCodeInfo.seqNo +',' +4+ ')">'+  (restartCodeInfo.fileName4 != null?  restartCodeInfo.fileName4:"") +'</a> </td>'
			                + '</tr>'
			                + '<tr>'
			                + '   <th>첨부파일5</th>'
			                + '   <td><a href="javascript:restartCodeDownload('+restartCodeInfo.seqNo +',' +5+ ')">'+  (restartCodeInfo.fileName5 != null?  restartCodeInfo.fileName5:"")  +'</a> </td>'
			                + '</tr>'  ;
						
					restartCodeBody.empty();
					restartCodeBody.append(restartCodeBodyStr);
			
			}
}

function mbr_IOListUpdateEventCallback(data){
	
	if(data.Rtn == 1){
		alert("I/O LIST을 저장을 완료 합니다..!!");
		sendPage(1);
	}else {
		alert("I/O LIST 저장에 오류가 발생했습니다..!!");
	}
}

function adminCallback(data) {
	masterStatesAjax = data.masterStates;
	slaveStatesAjax = data.slaveStates;
	
	$("#lblDate").text(data.ScanTime);
	
	setStates(1);
}
