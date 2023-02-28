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
<script type="text/javascript" src="<c:url value="/resources/js/status.js" />" charset="utf-8"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/datetimepicker/jquery.datetimepicker.css" />">
<script type="text/javascript" src="<c:url value="/resources/datetimepicker/jquery.datetimepicker.full.min.js" />" charset="utf-8"></script>

<script type="text/javascript" >
	var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
	var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

	$(function () {
		if( $("input:radio[id='4']").is(":checked") ) {
			hogiHeader = "4";
		} else {
			hogiHeader = "3";
		}
		if( $("input:radio[id='Y']").is(":checked") ) {
			xyHeader = "Y";
		} else {
			xyHeader = "X";
		}
		
		if( '${BaseSearch.startDate}' != null ) {
			var sDate = '${BaseSearch.startDate}'.split(' ')[0];
			var sHour = '${BaseSearch.startDate}'.split(' ')[1].split(':')[0];
			var sMin = '${BaseSearch.startDate}'.split(' ')[1].split(':')[1];
			$("#selectDate").val(sDate+' '+sHour+':'+sMin);
		}

		jQuery.datetimepicker.setLocale('ko');
		
		$('#selectDate').datetimepicker(DatetimepickerDefaults({}));

		$(document.body).delegate('#3', 'click', function() {
			sendPage(0,0,'3',xyHeader);
		});
		$(document.body).delegate('#4', 'click', function() {
			sendPage(0,0,'4',xyHeader);
		});
		$(document.body).delegate('#X', 'click', function() {
			sendPage(0,0,hogiHeader,'X');
		});
		$(document.body).delegate('#Y', 'click', function() {
			sendPage(0,0,hogiHeader,'Y');
		});
		
		$("#alarmSearch").click(function() {
			sendPage(-9999,0,hogiHeader,xyHeader);
		});
		
		$("#alarmDetail").click(function() {
			sendPage(1,1,hogiHeader,xyHeader);
		});
		
		$("#alarmSave").click(function() {
			if( $("input:radio[id='4']").is(":checked") ) {
				hogiHeader = $("#4").val();
			} else {
				hogiHeader = $("#3").val();
			}
			if( $("input:radio[id='Y']").is(":checked") ) {
				xyHeader = $("#Y").val();
			} else {
				xyHeader = $("#X").val();
			}
			toTXT(hogiHeader,xyHeader);
		});
		
		$("#btnCurrent").click(function() {
			sendPage(0,0,hogiHeader,xyHeader);
		});
		
		$("#btnPrev").click(function() {
			sendPage(-1,0,hogiHeader,xyHeader);
		});
		
		$("#btnNext").click(function() {
			sendPage(1,0,hogiHeader,xyHeader);
		});
		
		$("#btnMove").click(function() {
			var goPage = sql_injection($("#goPage").val()) == null ? 0 : sql_injection($("#goPage").val())*1;
			if( goPage > 200 || goPage < -200 ) {
				alert("-200 ~ 200 범위을 벗어났습니다.");
				$("#goPage").val('');
				return;
			} else {
				if( goPage == 0 ) goPage = -10;
				if( sql_injection($("#goPage").val()) != null ) {
					goPage = goPage + (sql_injection('${DccAlarmList[0].pagNo}') == null ? 0 : sql_injection('${DccAlarmList[0].pagNo}')*1);
				}
				if( sql_injection($("#goPage").val())*1 > 0 ) {
					sendPage(goPage,2,hogiHeader,xyHeader);
				} else {
					sendPage(goPage,0,hogiHeader,xyHeader);
				}
			}
		});
		
	});
	
	function convNum(num,type) {
		var tmp = num*1;
		if( type == 0 ) {
			if( tmp > 23 ) tmp = tmp - 24;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		} else if( type == 1 ) {
			if( tmp > 59 ) tmp = tmp - 60;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		} else if( type == 2 ) {
			if( tmp > 12 ) tmp = tmp - 12;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		} else if( type == 3 ) {
			if( tmp > 31 ) tmp = tmp - 31;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		}
		return num;
	}
	
	function sendPage(pageNum,type,hogiHeader,xyHeader) {
		var sDate,sHour,sMin;
		var today = new Date();
		if($("#selectDate").val() != null && $("#selectDate").val() != "") {
			sDate = $("#selectDate").val();
		} else {
			sDate = today.getFullYear()+'-'+convNum(today.getMonth()+1,2)+'-'+convNum(today.getDate(),3)+' '+convNum(today.getHours(),0)+':'+convNum(today.getMinutes(),1);
		}
		
		var comSubmit = new ComSubmit("searchForm");
		if( type == 0 ) {
			comSubmit.setUrl("/dcc/alarm/alarm");
		} else if( type == 1 ) {
			comSubmit.addParam("endDate",sDate+':00.000');
			comSubmit.setUrl("/dcc/alarm/alarmsearch");
		} else if( type == 2 ) {
			comSubmit.setUrl("/dcc/alarm/alarm");
			comSubmit.addParam("moveDirection","N");
		}
		comSubmit.addParam("startDate",sDate+':00.000');
		comSubmit.addParam("endDate",sDate+':00.000');
		comSubmit.addParam("hogiHeader", hogiHeader);
		comSubmit.addParam("xyHeader", xyHeader);
		comSubmit.addParam("currentPage", pageNum);
		comSubmit.addParam("pagNo", '${DccAlarmList[0].seq}');
		comSubmit.submit();
	}
	
	function toTXT(hogiHeader,xyHeader) {
		var goPage = sql_injection($("#goPage").val()) == null ? 0 : sql_injection($("#goPage").val())*1;
		if( sql_injection($("#goPage").val()) != null ) {
			goPage = goPage + (sql_injection('${DccAlarmList[0].pagNo}') == null ? 0 : sql_injection('${DccAlarmList[0].pagNo}')*1);
		}
		var	comSubmit = new ComSubmit("searchForm");
		comSubmit.setUrl("/dcc/alarm/alarmTxtExport");
		comSubmit.addParam("pType", "S1");
		comSubmit.addParam("hogiHeader", hogiHeader);
		comSubmit.addParam("xyHeader", xyHeader);
		comSubmit.addParam("currentPage", goPage);
		comSubmit.addParam("pagNo", '${DccAlarmList[0].seq}');
		comSubmit.submit();
	}
	
	function sql_injection(str) {
		if( str != null && str != 'undefined' ) {
			if( isNaN(str) ) {
				return null;
			} else {
				return str;
			}
		}
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
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
					<form id="searchForm">
						<div class="fx_srch_item double">
							<label>검색일자</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id="selectDate" name="selectDate" readonly>
                                </div>
                            </div>
						</div>
					</form>
                        <div class="fx_srch_item"></div>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a id="alarmSearch" name="alarmSearch" class="btn_srch">Search</a>
					<a id="alarmDetail" name="alarmDetail" class="btn_list primary" href="/dcc/alarm/alarmsearch">조건검색</a>
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
						<label>Total : <strong>${DccAlarmList.size()}</strong></label>
						<label>Page : <strong>${DccAlarmList[0].pagNo}</strong></label>
					</div>
					<!-- button -->
					<div class="button">
						<a class="btn_list primary" id="btnCurrent" name="btnCurrent">현재</a>
						<a class="btn_list primary" id="btnPrev" name="btnPrev">이전</a>	
						<a class="btn_list primary" id="btnNext" name="btnNext">다음</a>				
						<a class="btn_list primary" id="btnMove" name="btnMove">이동</a>
					</div>
					<div>
						&nbsp;
					</div>
					<div>
						<input id="goPage" name="goPage" style="width:40px;" type="text">
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
                    <c:forEach var="dccAlarmInfo" items="${DccAlarmList}">
                        <tr>
                        <c:if test="${dccAlarmInfo.almGubun eq 'X'}" >
                            <td id="alarmGubun" name="alarmGubun" class="tc"></td>
                        </c:if>
                        <c:if test="${dccAlarmInfo.almGubun ne 'X'}" >
                            <td id="alarmGubun" name="alarmGubun" class="tc">${dccAlarmInfo.almGubun}</td>
                        </c:if>
                            <td id="alarmDate" name="alarmDate" class="tc">${dccAlarmInfo.almDate}</td>
                        <c:if test="${dccAlarmInfo.almCode eq 'X'}" >
                            <td id="alarmCode" name="alarmCode" class="tc"></td>
                        </c:if>
                        <c:if test="${dccAlarmInfo.almCode ne 'X'}" >
                            <td id="alarmCode" name="alarmCode" class="tc">${dccAlarmInfo.almCode}</td>
                        </c:if>
                        <c:if test="${dccAlarmInfo.almAddress eq 'X'}" >
                            <td id="address" name="address" class="tc"></td>
                        </c:if>
                        <c:if test="${dccAlarmInfo.almAddress ne 'X'}" >
                            <td id="address" name="address" class="tc">${dccAlarmInfo.almAddress}</td>
                        </c:if>
                            <td id="alarmMsg" name="alarmMsg">${dccAlarmInfo.almMesg}</td>
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

