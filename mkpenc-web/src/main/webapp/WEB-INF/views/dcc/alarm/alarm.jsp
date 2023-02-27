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
<script type="text/javascript" src="<c:url value="/resources/js/alarm.js" />" charset="utf-8"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/datetimepicker/jquery.datetimepicker.css" />">
<script type="text/javascript" src="<c:url value="/resources/datetimepicker/jquery.datetimepicker.full.min.js" />" charset="utf-8"></script>

<script type="text/javascript">

$(function () {
	
	jQuery.datetimepicker.setLocale('ko');
	
	$('#sdate').datetimepicker(DatetimepickerDefaults({}));
	
	
	$("#fncSearch").click(function() {
		$("#sType").val("serh");
		moveSubmit();
	});
	
	$("#moveCur").click(function() {
		$("#sType").val("");
		moveSubmit();
	});
	
	$("#movePrev").click(function() {
		$("#sType").val("prev");
		moveSubmit();
	});
	
	$("#moveNext").click(function() {
		$("#sType").val("next");
		moveSubmit();
	});	
		
	$("#fncMove").click(function() {
		
		var inputPage = prompt('이동하려는 페이지를 입력하세요', '이동페이지');
		
		if(inputPage < -200 || inputPage > 200) {
		    alert("-200 ~ 200 범위을 벗어났습니다.");
		    return;
		}
		
		$("#sMovPage").val(inputPage);
		$("#sType").val("move");
		moveSubmit();	
	});

});	


function alarmExport(type){
	
	$("#saveType").val(type);
		
	var	comSubmit	=	new ComSubmit("alarmFrm");
	comSubmit.setUrl("/dcc/alarm/alarmExport");
	comSubmit.submit();
}


function moveSubmit(){
	
	var	comSubmit	=	new ComSubmit("alarmFrm");
	comSubmit.setUrl("/dcc/alarm/alarm");
	comSubmit.submit();			
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
	<%@ include file="/WEB-INF/views/include/include-dcc-header.jspf" %>
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>ALARM</h3>
				<div class="bc"><span>DCC</span><span>Alarm</span><strong>Alarm</strong></div>
			</div>
			<!-- //page_title -->
			 <form id="alarmFrm" name="alarmFrm">
			<input type="hidden" id="sType"  	name="sType">
			<input type="hidden" id="sPage"  	name="sPage" value="${BaseSearch.sPage}"> <!-- sPage     hPage        hPage -->
			<input type="hidden" id="sSeq"  	name="sSeq"  value="${BaseSearch.sSeq}">  <!--  sSeq      curpage      inpageno -->
			<input type="hidden" id="sMinDate"  name="sMinDate" value="${BaseSearch.sMinDate}">
			<input type="hidden" id="sMaxDate"  name="sMaxDate"  value="${BaseSearch.sMaxDate}">
			<input type="hidden" id="sMovPage"  name="sMovPage" >
			<input type="hidden" id="saveType"  name="saveType" >
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item double">
							<label>검색일자</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id=sdate name="sdate" readonly>
                                </div>
                            </div>
						</div>
                        <div class="fx_srch_item"></div>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="fncSearch" name="fncSearch">Search</a>
					<a class="btn_list primary" href="/dcc/alarm/alarmsearch">조건검색</a>
					<a class="btn_list excel_down" href="javascript:alarmExport('S1')"  >알람저장</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			</form>
			<!-- //fx_srch_wrap -->

			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>10</strong></label>
					</div>
					<!-- button -->
					<div class="button">						
						<a class="btn_list primary" id="moveCur" name="moveCur" >현재</a>
						<a class="btn_list primary" id="movePrev" name="movePrev" >이전</a>						
						<a class="btn_list primary" id="moveNext" name="moveNext" >다음</a>
						<a class="btn_list primary"  id="fncMove" name="fncMove" >이동</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="60px"/>
                        <col width="180px"/>
                        <col width="120px"/>
                        <col width="200px"/>
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>알람구분</th>
                            <th>알람시간</th>
                            <th>알람코드</th>
                            <th>알람주소</th>
                            <th>내용</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="LogDccAlarm" items="${LogDccAlarmList}">
                    	<c:if test="${LogDccAlarm.ALMMESGLINE <= 1}">
                        <tr>
                        	<c:if test="${LogDccAlarm.ALMGUBUN != 'X'}">
                            	<td class="tc">${LogDccAlarm.ALMGUBUN}</td>
                            </c:if>
                            <c:if test="${LogDccAlarm.ALMGUBUN == 'X'}">
                            	<td class="tc"></td>
                            </c:if>
                            <td class="tc">${LogDccAlarm.ALMTIME}</td>
                            <td class="tc">${LogDccAlarm.ALMCODE}</td>
                            <td>${LogDccAlarm.ALMADDRESS}</td>
                            <td>${LogDccAlarm.ALMMESG}</td>
                        </tr>
                        </c:if>
                        </c:forEach>
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
</body>
</html>