<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>월성 3,4 호기 원격감시시스템</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/style.css" />">
<script type="text/javascript" src="<c:url value="/resources/jquery/jquery-1.10.0.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/modal.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/common.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/login.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/performance.js" />" charset="utf-8"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/datetimepicker/jquery.datetimepicker.css" />">
<script type="text/javascript" src="<c:url value="/resources/datetimepicker/jquery.datetimepicker.full.min.js" />" charset="utf-8"></script>

<script type="text/javascript">

$(function () {
	
		jQuery.datetimepicker.setLocale('ko');

		$('#mskSpareS').datetimepicker(DatetimepickerDefaults({}));
		$('#mskSpareE').datetimepicker(DatetimepickerDefaults({}));
		$('#mskFixedS').datetimepicker(DatetimepickerDefaults({}));
		$('#mskFixedE').datetimepicker(DatetimepickerDefaults({}));	
		
		var mskSpareS = "${BaseSearch.mskSpareS}";
		if(mskSpareS == ""){
			$('#mskSpareS').val(getCurrentTime(-2));
		}else {
			$('#mskSpareS').val(mskSpareS);
		}
		
		var mskSpareE = "${BaseSearch.mskSpareE}";
		if(mskSpareE == ""){
			$('#mskSpareE').val(getCurrentTime(-1));
		}else {
			$('#mskSpareE').val(mskSpareE);
		}
		
		var mskFixedS = "${BaseSearch.mskFixedS}";
		if(mskFixedS == ""){
			$('#mskFixedS').val(getCurrentTime(-1));
		}else {
			$('#mskFixedS').val(mskFixedS);
		}
		
		var mskFixedE = "${BaseSearch.mskFixedE}";
		if(mskFixedE == ""){
			$('#mskFixedE').val(getCurrentTime(0));
		}else {
			$('#mskFixedE').val(mskFixedE);
		}
		
		$(document.body).delegate('#compareVarTable tbody tr', 'click', function() {
			$(this).addClass("highlight");
			$(this).siblings().removeClass("highlight");
		});
		
	  	$("#sUGrpNo").change(function(){
	  		
	  		if($("#sUGrpNo option:selected").val() != ""){
		  
				var comAjax = new ComAjax("compareVarSearch");
				comAjax.setUrl("/markv/performance/getMarkGrpTag");
				comAjax.setCallback("mbr_MarkGrpTagEventCallback");
				comAjax.ajax();					  
	  		}else {
	  			// 화면초기화
	  			var	comSubmit	=	new ComSubmit("compareVarSearch");
				comSubmit.setUrl("/markv/performance/fixed");
				comSubmit.submit();
	  		}
	  	});
	  
	  	/*
	  	$('input:radio[name=view_reactor]').click(function(){

	  		var chkVar = $('input:radio[name=view_reactor]:checked').val();
	  		alert(chkVar);
	  	});	
	  
	  	$('input:radio[name=view]').click(function(){

	  		var chkVar = $('input:radio[name=view]:checked').val();
	  		alert(chkVar);
	  	});	
	  	*/
	  	$("#sChkHogi").click(function(){
	  		
	  		if($('#sChkHogi').is(':checked')){
	  			$('#label3').text("검색기간 3");	
	  			$('#label4').text("검색기간 4");
	  			$('#aTime').text("기간 3호기");
	  			$('#bTime').text("기간 4호기");
	  			
	  			$('#mskFixedS').val($('#mskSpareS').val());
	  			$('#mskFixedE').val($('#mskSpareE').val());
	  	        
	  		}else {
	  			$('#label3').text("검색기간 A");	
	  			$('#label4').text("검색기간 B");
	  			$('#aTime').text("기간 A");
	  			$('#bTime').text("기간 B");
	  			
	  			$('#mskFixedS').val(getCurrentTime());
	  			$('#mskFixedE').val(getCurrentTime());
	  		}
	  		
	  		//alert($("input:checkbox[name='sChkHogi']:checked").val());
		});
	  	
		$("#comareVarSearch").click(function(){

			  if($('#mskSpareS').val() == ""){
				  alert("검색시간 A의 시작일을 선택하세요");
				  $('#mskSpareS').focus();
				  return;
			  }
			  
			  if($('#mskSpareE').val() == ""){
				  alert("검색시간 A의 종료일을 선택하세요");
				  $('#mskSpareE').focus();
				  return;
			  }
			  
			  if($('#mskFixedS').val() == ""){
				  alert("검색시간 B의 시작일을 선택하세요");
				  $('#mskFixedS').focus();
				  return;
			  }
			  
			  if($('#mskFixedE').val() == ""){
				  alert("검색시간 B의 종료일을 선택하세요");
				  $('#mskFixedE').focus();
				  return;
			  }
			  
			  var mskSpareS = new Date($('#mskSpareS').val());
			  var mskSpareE = new Date($('#mskSpareE').val());
			  var mskFixedS = new Date($('#mskFixedS').val());
			  var mskFixedE = new Date($('#mskFixedE').val());
			  
			  if(mskSpareS > mskSpareE){
				  alert("검색시간 A의 시작일일 종료일 보다 늦은 시간입니다. 올바른 날짜를 선택하세요");
				  $('#mskSpareS').focus();
				  return;
			  }
			  
			 // alert((mskSpareE - mskSpareS)/(1000*60*60*24));
			  
			  if(((mskSpareE - mskSpareS)/(1000*60*60*24)) > 14){
				  alert("검색시간 A의 입력된 시간 설정구간이 14일을 초과할 수 없습니다.");
				  $('#mskSpareE').focus();
				  return;
			  }
			  
 			  if(mskFixedS > mskFixedE){
 				 alert("검색시간 B의 시작일일 종료일 보다 늦은 시간입니다. 올바른 날짜를 선택하세요");
				 $('#mskFixedS').focus();
				 return;
			  }
 			  
			  if(((mskFixedE - mskFixedS)/(1000*60*60*24)) > 14){
				  alert("검색시간 B의 입력된 시간 설정구간이 14일을 초과할 수 없습니다.");
				  $('#mskFixedE').focus();
				  return;
			  }
			  
			  if($("#sUGrpNo option:selected").val() == ""){
				  alert("그룹을 선택하세요");
				  $('#sUGrpNo').focus();
				  return;
			  }

			  if($('#sChkHogi').is(':checked')){
		  			$('#aTime').text($('#mskSpareS').val() + "~" + $('#mskSpareE').val()+"(3)");
		  			$('#bTime').text($('#mskFixedS').val() + "~" + $('#mskSpareE').val()+"(4)");
		  	  }else {
		  			$('#aTime').text($('#mskSpareS').val() + "~" + $('#mskSpareE').val()+"(A)");
		  			$('#bTime').text($('#mskFixedS').val() + "~" + $('#mskSpareE').val()+"(B)");
		  	  }
			  
			  var	comSubmit	=	new ComSubmit("compareVarSearch");
			  comSubmit.setUrl("/markv/performance/spare");
			  comSubmit.submit();			
		 });	  		
		
});	


function getCurrentTime(gap){
	var now = new Date();
	now.setHours(now.getHours() + (9 + gap));
	return now.toISOString().replace('T', ' ').substring(0, 16);
	
}

function DatetimepickerDefaults(opts) {
    return $.extend({},{
    format:'Y-m-d H:i',
	formatTime:'H:i',
    formatDate:'Y-m-d',
	step : 5,
	monthChangeSpinner:true,
    sideBySide: true
    
    }, opts);
}

</script>

</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-markv-header.jspf" %> 
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>주요기기 성능감시</h3>
				<div class="bc"><span>MARK_V</span><span>Performance</span><strong>주요기기 성능감시</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<form id="compareVarSearch" name=compareVarSearch">
					<input type = "hidden" id="sGrpID" name="sGrpID" value="${UserInfo.id }">
					<input type = "hidden" id="sMenuNo" name="sMenuNo" value = "42">
					<input type = "hidden" id="sDive" name="sDive" value = "D">
					<input type = "hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi }">
					<input type = "hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun }">
				
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>그룹</label>
                              <select class="fx_none" style="width:90px;" id="sUGrpNo" name="sUGrpNo">
                            	<option  value="">그룹을 선택하세요</option>
                           		<c:forEach var="GroupName" items="${GroupNameList}">
                           			<c:choose>
			                           		 <c:when test="${GroupName.uGrpNo eq BaseSearch.sUGrpNo }">
			                            			<option  value="${GroupName.uGrpNo}" selected>${UserInfo.hogi } - ${GroupName.uGrpNo} ${GroupName.uGrpName}</option>
			                            	</c:when>
			                            	<c:when test="${GroupName.uGrpNo ne BaseSearch.sUGrpNo }">
			                            			<option  value="${GroupName.uGrpNo}">${UserInfo.hogi } - ${GroupName.uGrpNo} ${GroupName.uGrpName}</option>
			                            	</c:when>
                                	</c:choose>
                                </c:forEach>
                            </select>
						</div>
						<div class="fx_srch_item">
							<label>호가비교</label>
                            <input type="checkbox" id="sChkHogi" name="sChkHogi" value="T">
						</div>
						<div class="fx_srch_item double">
							<label id="label3" name="label3">검색기간 A</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id="mskSpareS" name="mskSpareS" readonly>
                                   <label>~</label>
                                   <input type="text" id="mskSpareE" name="mskSpareE" readonly>
                                </div>
                            </div>
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item"></div>
						<div class="fx_srch_item"></div>
						<div class="fx_srch_item double">
							<label id="label4" name="label4">검색기간 B</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id="mskFixedS" name="mskFixedS" readonly>
                                   <label>~</label>
                                   <input type="text" id="mskFixedE" name="mskFixedE" readonly>
                             	</div>
                            </div>
						</div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="comareVarSearch" name="comareVarSearch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			</form>
			<!-- //fx_srch_wrap -->         
			<!-- list_wrap -->
			<div class="list_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <c:if test="${UserInfo.grade eq 1 or UserInfo.grade eq 2 }">
                        <li><a href="#none" id="setVar" name="setVar">변수설정</a></li>
                        </c:if>
                        <li><a href="#none" onclick="openLayer('modal_2');">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                
                <!-- list_table -->
                <table class="list_table" id="compareVarTable" name="compareVarTable">
                    <colgroup>
                        <col />
                        <col width="80px"/>
                        <col width="100px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">변수명</th>
                            <th rowspan="2">단위</th>
                            <th rowspan="2">참고치</th>
                            <th colspan="4" id="aTime" name="aTime">기간 A</th>
                            <th colspan="4" id="bTime" name="bTime">기간 B</th>
                            <th colspan="2">비교</th>
                        </tr>
                        <tr>
                            <th>평균</th>
                            <th>표준편차</th>
                            <th>최대값</th>
                            <th>최소값</th>
                            <th>평균</th>
                            <th>표준편차</th>
                            <th>최대값</th>
                            <th>최소값</th>
                            <th>B-A</th>
                            <th>변환율(%)</th>
                        </tr>
                    </thead>
                    <tbody id="compareVarList" name = "compareVarList">
                    <c:forEach var="tagMarkInfo" items="${TagMarkInfoList}">
                        <tr>
                            <td>${tagMarkInfo.LOOPNAME}- ${tagMarkInfo.spareAvgFldNo}</td>
                            <c:choose>
                            	   <c:when test="${tagMarkInfo.IOTYPE eq 'DT' and (tagMarkInfo.alarmType eq 4 or tagMarkInfo.alarmType eq 12) }">
                            			<td class="tc">%</td>
                            	</c:when>
                            	<c:otherwise>
                            			<td class="tc">${tagMarkInfo.unit}</td>
                            	</c:otherwise>
                            </c:choose>
             				<c:choose>
                            	<c:when test="${tagMarkInfo.minVal eq 0}">
                            			<td class="tc">${tagMarkInfo.maxVal}</td>
                            	</c:when>
                            	<c:when test="${tagMarkInfo.minVal eq -1}">
                            			<td class="tc">> ${tagMarkInfo.maxVal}</td>
                            	</c:when>
                            	<c:when test="${tagMarkInfo.minVal eq -2}">
                            			<td class="tc">< ${tagMarkInfo.maxVal}</td>
                            	</c:when>
                            	<c:when test="${tagMarkInfo.minVal eq -3}">
                            			<td class="tc"></td>
                            	</c:when>
                            	<c:otherwise>
                            			<td class="tc">${tagMarkInfo.minVal} ~ ${tagMarkInfo.maxVal}</td>
                            	</c:otherwise>
                            </c:choose>
                            <td class="tc">${tagMarkInfo.spareAvgFldNo}</td>
                            <td class="tc">${tagMarkInfo.spareStdevFldNo}</td>
                            <td class="tc">${tagMarkInfo.spareMaxFldNo}</td>
                            <td class="tc">${tagMarkInfo.spareMinFldNo}</td>
                            
                            <td class="tc">${tagMarkInfo.fixedAvgFldNo}</td>
                            <td class="tc">${tagMarkInfo.fixedStdevFldNo}</td>
                            <td class="tc">${tagMarkInfo.fixedMaxFldNo}</td>
                            <td class="tc">${tagMarkInfo.fixedMinFldNo}</td>
                            
                            <td class="tc">${tagMarkInfo.gapAB}</td>
                            <td class="tc">${tagMarkInfo.rateAB}</td>

                        </tr>
                        </c:forEach>
                        <c:if test="${TagMarkInfoList eq null}">
                        <tr>
                            <td></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
                <!-- //list_table -->
            </div>
            <!-- //list_wrap -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->


<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>변수설정</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <form id = "ioGrpNameForm" name ="ioGrpNameForm" >
            	<input type ="hidden" id="sGrpID" name="sGrpID" value="${UserInfo.id }">
				<input type ="hidden" id="sMenuNo" name="sMenuNo" value = "42">
				<input type ="hidden" id="sDive" name="sDive" value = "D">
				<input type ="hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi }">
				<input type ="hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun }">
				<input type ="hidden" id="ioUGrpNo" name="ioUGrpNo">
				<input type ="hidden" id="bGroupFlag" name="bGroupFlag">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>Title</th>
                    <td>
                        <div class="fx_form">
                            <input type="text" id="uGrpName" name="uGrpName" >
                            <a class="btn_list" herf="none" id="addUGrpName" name="addUGrpName">그룹추가</a>
                        </div>
                    </td>
                </tr>
            </table>
            </form>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table" id="uGrpTagTable" name="uGrpTagTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody id="uGrpTagList" name="uGrpTagList">
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <form id="setIOForm" name="setIOForm">
            <input type ="hidden" id="iSeq" name="iSeq">
            <table class="list_table" id=setVarTable" name="setVarTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                         <td>
                            <select id="hogi" name="hogi" readonly
				                            style="background-color:#ababab" 
									        onFocus="this.initialSelect = this.selectedIndex;" 
									        onChange="this.selectedIndex = this.initialSelect;">
                             	<c:if test="${UserInfo ne null &&  UserInfo.hogi eq '3' }">    
                                	<option value="3" selected>3</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.hogi ne '3' }">
                                	<option value="3" >3</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.hogi eq '4' }">        
                                	<option value="4" selected>4</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.hogi ne '4' }">
                                	<option value="4" >4</option>    
                                </c:if>
                            </select>
                        </td>
                        <td>
                            <select id="xyGubun" name="xyGubun"  readonly
				                            style="background-color:#ababab" 
									        onFocus="this.initialSelect = this.selectedIndex;" 
									        onChange="this.selectedIndex = this.initialSelect;">
                            <c:if test="${UserInfo ne null &&  UserInfo.xyGubun eq 'X' }">    
                                	<option value="X" selected>X</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.xyGubun ne 'X' }">
                                	<option value="X" >X</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.xyGubun eq 'Y' }">        
                                	<option value="Y" selected>Y</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.xyGubun ne 'Y' }">
                                	<option value="Y" >Y</option>    
                                </c:if>
                            </select>
                        </td>
                        <td><input type="text" id="loopName" name="loopName"></td>
                        <td>
                            <select id="IOType" name="IOType">
                                <option value="AI" selected>AI</option>
                                <option value="AO">AO</option>
                                <option value="DI">DI</option>
                                <option value="DO">DO</option>
                                <option value="SC">SC</option>
                                <option value="DT">DT</option>
                            </select>
                        </td>
                        <td><input type="text" id="addresss" name="addresss"></td>
                        <td><input type="text" id="ioBit" name="ioBit"></td>
                        <td><input type="text" id="minVal" name="minVal"></td>
                        <td><input type="text" id="maxVal" name="maxVal"></td>
                        <td class="tc"><input type="checkbox" id="saveCore" name="saveCore"></td>
                    </tr>
                </tbody>
            </table>
            </form>
            <!-- //list_table -->
            <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" onclick="openLayer('modal_2');">Tag Search</a>
                </div>
                <c:if test="${UserInfo.grade eq 1 or UserInfo.grade eq 2 }">
                <div class="button">
                    <a class="btn_list" href="#none" id="addVarTable" name="addVarTable">추가</a>
                    <a class="btn_list" href="#none" id="modVarTable" name="modVarTable">수정</a>
                    <a class="btn_list" href="#none"  id="delVarTable" name="delVarTable">삭제</a>
                    <a class="btn_list" href="#none" id="rowUp" name="rowUp">위</a>
                    <a class="btn_list" href="#none" id="rowDown" name="rowDown">아래</a>
                </div>
                </c:if>
            </div>
            <!-- //list_bottom -->
        </div>
        <!-- //list_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary" id="saveVarTable" name="saveVarTable">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->



<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태크검색</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <form id="tagSearchForm" name="tagSearchForm">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>호기</th>
                    <td>
                        <div class="fx_form">
                          <select  id="sHogi" name="sHogi"> 
                          	<option value="3"> 3</option>
                          	<option value="4"> 4</option>
                          </select>
                           <select  id="sIOType" name="sIOType"> 
                          	<option value="">전체</option>
                          	<option value="AI"> AI</option>
                          	<option value="AO">AO</option>
                          	<option value="DI"> DI</option>
                          	<option value="DO">DO</option>
                          	<option value="SC">SC</option>
                          	<option value="DT">DT</option>
                          </select>
                        </div>
                    </td>
                    <th>검색어</th>
                    <td>
                        <div class="fx_form">
                          <input type="text" id="findData" name="findData">
                        </div>
                    </td>
                    <td>
	                    <div class="button">
	                    <a class="btn_list" href="#none" id="tagFind" name="tagFind">검색</a>
	                    <a class="btn_list" href="#none"  id="fastIoFind" name="fastIoFind">Fast All</a>
	                    </div>
                    </td>
                    <td>
	                	<div class="fx_form">
                          <input type="checkbox" id="chkOpt1" name="chkOpt1" value="1"> 태그명
                          <input type="checkbox" id="chkOpt2" name="chkOpt2" value="1" checked> 태그설명
                        </div>
                    </td>
                </tr>
            </table>
            </form>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table" id="tagSearchTable" name="tagSearchTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>LOOG NAME</th>
                        <th>DESCR</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody id="tagSearchList" name="tagSearchList">
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary" id="tagSearchSelect" name="tagSearchSelect">선택</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->





<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_3">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>엑셀로 저장</h3>
        <a onclick="closeLayer('modal_3');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">

        <!-- fx_layout -->
        <div class="fx_layout"> 
            <div class="fx_block">        
                <!-- form_wrap -->
                <div class="form_wrap">
                    <div class="form_head">
                        <h4>저장일자</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col width="120px"/>
                            <col />
                        </colgroup>
                        <tr>
                            <th>시작 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>끝 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
                                </div>
                            </td>
                        </tr>
                    </table>
                    <!-- //form_table -->
                </div>
                <!-- //form_wrap -->
            </div>
            <div class="fx_block">        
                <!-- form_wrap -->
                <div class="form_wrap">
                    <div class="form_head">
                        <h4>주기</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">0.5초 데이타</label>
                                    <label><input type="radio" name="radio">5분 데이타</label>
                                    <label><input type="radio" name="radio">5초 데이타</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">1시간 데이타</label>
                                    <label><input type="radio" name="radio">1분 데이타</label>
                                    <label><input type="radio" name="radio">직접입력</label>
                                    <input type="text" class="tr fx_none" style="width:60px;">
                                    <label>초</label>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <!-- //form_table -->
                </div>
                <!-- //form_wrap -->
            </div>
        </div>
        <!-- //fx_layout -->    
        <!-- file_upload -->
        <div class="fx_form file_upload">
            <div class="fx_form">
                <input type="text" />
                <a href="#none" class="btn_list">파일선택</a>
            </div>
        </div>
        <!-- //file_upload -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_3');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>


