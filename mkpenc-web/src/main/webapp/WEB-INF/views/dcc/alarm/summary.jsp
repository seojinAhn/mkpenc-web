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
	var timerOn = false;

	$(function(){
		
		$("#lblDate").text('${UserInfo.hogi} ' + ' ${UserInfo.xyGubun}' + ' ${BaseSearch.startDate}' );
		var diff = new Date().getTime() - new Date('${BaseSearch.startDate}').getTime();
		if( diff / 1800000 > 1 ) {
			$("#lblDate").css('color','#e85516');
		} else {
			$("#lblDate").css('color','#05c8be');
		}
		
		if( '${BaseSearch.startDate}' != null ) {
			var sDate = '${BaseSearch.startDate}'.split(' ')[0];
			var sHour = '${BaseSearch.startDate}'.split(' ')[1].split(':')[0];
			var sMin = '${BaseSearch.startDate}'.split(' ')[1].split(':')[1];
			$("#selectDate").val(sDate+' '+sHour+':'+sMin);
		}
		
		jQuery.datetimepicker.setLocale('ko');
		
		$('#selectDate').datetimepicker(DatetimepickerDefaults({}));
		
		$("#alarmSearch").click(function() {
			sendPage(2);
		});
		
		$("#alarmSave").click(function() {	
			toTXT();
		});
		
		$("#btnCurrent").click(function() {
			sendPage(0);
		});
		
		$("#btnPrev").click(function() {
			sendPage(-1);
		});
		
		$("#btnNext").click(function() {
			sendPage(1);
		});
	});
	
	function setTimer(num){
		sendPage(num);
	}

	function sendPage(pageNum) {
		var sDate,sHour,sMin;
		var today = new Date();
		if($("#selectDate").val() != null && $("#selectDate").val() != "") {
			sDate = $("#selectDate").val();
		} else {
			sDate = today.getFullYear()+'-'+convNum(today.getMonth()+1,2)+'-'+convNum(today.getDate(),3)+' '+convNum(today.getHours(),0)+':'+convNum(today.getMinutes(),1);
		}
		
		var comSubmit = new ComSubmit("searchForm");
		comSubmit.setUrl("/dcc/alarm/summary");
		comSubmit.addParam("startDate",sDate+':00.000');
		comSubmit.addParam("currentPage", pageNum);
		comSubmit.addParam("pagNo", '${DccSummaryList[0].seq}');
		comSubmit.submit();
	}
	
	function toTXT() {
		var sDate,sHour,sMin;
		var today = new Date();
		if($("#selectDate").val() != null && $("#selectDate").val() != "") {
			sDate = $("#selectDate").val();
		} else {
			sDate = today.getFullYear()+'-'+convNum(today.getMonth()+1,2)+'-'+convNum(today.getDate(),3)+' '+convNum(today.getHours(),0)+':'+convNum(today.getMinutes(),1);
		}
		
		var	comSubmit = new ComSubmit("searchForm");
		comSubmit.setUrl("/dcc/alarm/summaryTxtExport");
		comSubmit.addParam("pType", "S3");
		comSubmit.addParam("startDate",sDate+':00.000');
		comSubmit.addParam("currentPage", 2);
		comSubmit.addParam("pagNo", '${DccSummaryList[0].seq}');
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
				<h3>SUMMARY</h3>
				<div class="bc"><span>DCC</span><span>Alarm</span><strong>SUMMARY</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
					<form id="searchForm">
						<div class="fx_srch_item double">
							<label>검색시작일자</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id="selectDate" name="selectDate" readonly>
                                </div>
                            </div>
						</div>
                        <div class="fx_srch_item"></div>
                    </form>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a id="alarmSearch" name="alarmSearch" class="btn_srch">Search</a>
					<a id="alarmSave" name="alarmSave" class="btn_list primary" href="#none">알람저장</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->

			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>${DccSummaryList.size()}</strong></label>
						<label>Page : <strong>${DccSummaryList[0].pagNo}</strong></label>
					</div>
					<!-- button -->
					<div class="button">
						<a class="btn_list primary" id="btnCurrent" name="btnCurrent">현재</a>
						<a class="btn_list primary" id="btnPrev" name="btnPrev">이전</a>	
						<a class="btn_list primary" id="btnNext" name="btnNext">다음</a>
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
                    <c:forEach var="dccSummaryInfo" items="${DccSummaryList}">
                        <tr>
                        <c:if test="${dccSummaryInfo.almGubun eq 'X'}" >
                            <td id="alarmGubun" name="alarmGubun" class="tc"></td>
                        </c:if>
                        <c:if test="${dccSummaryInfo.almGubun ne 'X'}" >
                            <td id="alarmGubun" name="alarmGubun" class="tc">${dccSummaryInfo.almGubun}</td>
                        </c:if>
                            <td id="alarmDate" name="alarmDate" class="tc">${dccSummaryInfo.almDate}</td>
                        <c:if test="${dccSummaryInfo.almCode eq 'X'}" >
                            <td id="alarmCode" name="alarmCode" class="tc"></td>
                        </c:if>
                        <c:if test="${dccSummaryInfo.almCode ne 'X'}" >
                            <td id="alarmCode" name="alarmCode" class="tc">${dccSummaryInfo.almCode}</td>
                        </c:if>
                        <c:if test="${dccSummaryInfo.almAddress eq 'X'}" >
                            <td id="address" name="address" class="tc"></td>
                        </c:if>
                        <c:if test="${dccSummaryInfo.almAddress ne 'X'}" >
                            <td id="address" name="address" class="tc">${dccSummaryInfo.almAddress}</td>
                        </c:if>
                            <td id="alarmMsg" name="alarmMsg">${dccSummaryInfo.almMesg}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- //list_table -->							
				<!-- paginate -->
				<!-- //paginate -->
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