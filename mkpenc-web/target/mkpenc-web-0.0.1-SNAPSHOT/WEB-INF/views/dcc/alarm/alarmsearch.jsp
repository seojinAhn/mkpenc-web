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
	var startAlarmDate,endAlarmDate;
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
		
		var sDtm,eDtm,eDate,eHour,eMin;
		if( isNull('${BaseSearch.startDate}') && !isNull('${BaseSearch.endDate}') ) {
			eDate = '${BaseSearch.endDate}'.split(' ')[0];
			eHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			eMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			eDtm = new Date(eDate.split('-')[0]*1, eDate.split('-')[1]*1, eDate.split('-')[2]*1);
			sDtm = new Date(eDtm.setDate(eDtm.getDate()-3));
			$("#selectSDate").val(sDtm.getFullYear()+'-'+convNum(sDtm.getMonth()+1,2)+'-'+convNum(sDtm.getDate(),3)+' '+convNum(eHour,0)+':'+convNum(eMin,1));
			$("#selectEDate").val(eDate+' '+convNum(eHour,0)+':'+convNum(eMin,1));
		} else if( !isNull('${BaseSearch.startDate}') && isNull('${BaseSearch.endDate}') ) {
			sDate = '${BaseSearch.endDate}'.split(' ')[0];
			sHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			sMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			sDtm = new Date(eDate.split('-')[0]*1, eDate.split('-')[1]*1, eDate.split('-')[2]*1);
			eDtm = new Date(sDtm.setDate(sDtm.getDate()+3));
			$("#selectSDate").val(sDate+' '+convNum(sHour,0)+':'+convNum(sMin,1));
			$("#selectEDate").val(eDtm.getFullYear()+'-'+convNum(eDtm.getMonth()+1,2)+'-'+convNum(eDtm.getDate(),3)+' '+convNum(eHour,0)+':'+convNum(eMin,1));
			$("#selectEHour").val(convNum(sHour,0));
			$("#selectEMinute").val(convNum(sMin,1));
		} else if( !isNull('${BaseSearch.startDate}') && !isNull('${BaseSearch.endDate}') ) {
			sDate = '${BaseSearch.startDate}'.split(' ')[0];
			sHour = '${BaseSearch.startDate}'.split(' ')[1].split(':')[0];
			sMin = '${BaseSearch.startDate}'.split(' ')[1].split(':')[1];
			eDate = '${BaseSearch.endDate}'.split(' ')[0];
			eHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			eMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			$("#selectSDate").val(sDate+' '+convNum(sHour,0)+':'+convNum(sMin,1));
			$("#selectEDate").val(eDate+' '+convNum(eHour,0)+':'+convNum(eMin,1));
		} else {
			var eDtm = new Date();
			var sDtm = new Date();
			sDtm = new Date(sDtm.setDate(sDtm.getDate()-3));
			$("#selectSDate").val(sDtm.getFullYear()+'-'+convNum(sDtm.getMonth()+1,2)+'-'+convNum(sDtm.getDate(),3)+' '+convNum(sDtm.getHours(),0)+':'+convNum(sDtm.getMinutes(),1));
			$("#selectEDate").val(eDtm.getFullYear()+'-'+convNum(eDtm.getMonth()+1,2)+'-'+convNum(eDtm.getDate(),3)+' '+convNum(eDtm.getHours(),0)+':'+convNum(eDtm.getMinutes(),1));
		}
		
		jQuery.datetimepicker.setLocale('ko');
		
		$('#selectSDate').datetimepicker(DatetimepickerDefaults({}));
		$('#selectEDate').datetimepicker(DatetimepickerDefaults({}));
		
		$("#alarmSearch").click(function() {
			sendPage(1);
		});

		$(document.body).delegate('#3', 'click', function() {
			sendPage(1);
		});
		$(document.body).delegate('#4', 'click', function() {
			sendPage(1);
		});
		$(document.body).delegate('#X', 'click', function() {
			sendPage(1);
		});
		$(document.body).delegate('#Y', 'click', function() {
			sendPage(1);
		});
		
		$("#alarmDetail").click(function() {
			var sDate,eDate,sHour,eHour,sMin,eMin;
			var fDate = new Date();
			fDate = new Date(fDate.setDate(fDate.getDate()-3));
			if($("#selectSDate").val() != null && $("#selectSDate").val() != "") {
				sDate = $("#selectEDate").val();
			} else {
				sDate = fDate.getFullYear()+'-'+convNum(fDate.getMonth()+1,2)+'-'+convNum(fDate.getDate(),3)+' '+convNum(fDate.getHours(),0)+':'+convNum(fDate.getMinutes(),1);
			}
			
			var comSubmit = new ComSubmit("searchForm");
			comSubmit.setUrl("/dcc/alarm/alarm");
			comSubmit.addParam("startDate",sDate+':00.000');
			comSubmit.submit();
		});
		
		$("#alarmSave").click(function() {
			toTXT();
		});
		
		$("#alarmExcel").click(function() {
			toCSV();
		});
	});
	
	function setInit() {
		if( !isNull('${BaseSearch.alarmGubun}') ) {
			$("#alarmGubun").val('${BaseSearch.alarmGubun}');
		} else {
			$("#alarmGubun").val("None");
		}
		if( !isNull('${BaseSearch.alarmCode}') ) {
			$("#alarmCode").val('${BaseSearch.alarmCode}');
		} else {
			$("#alarmCode").val("");
		}
		if( !isNull('${BaseSearch.address}') ) {
			$("#address").val('${BaseSearch.address}');
		} else {
			$("#address").val("");
		}
		if( !isNull('${BaseSearch.alarmMsg}') ) {
			$("#alarmMsg").val('${BaseSearch.alarmMsg}');
		} else {
			$("#alarmMsg").val("");
		}
	}
	
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
	
	function isNull(str) {
		if( str == null || str == '' || str == 'undefined' ) {
			return true;
		} else {
			return false;
		}
	}

	function sendPage(pageNum) {
		var sDate,eDate,sHour,eHour,sMin,eMin;
		var rDate = new Date();
		var fDate = new Date();
		fDate = new Date(fDate.setDate(fDate.getDate()-3));
		if($("#selectSDate").val() != null && $("#selectSDate").val() != "") {
			sDate = $("#selectSDate").val();
		} else {
			sDate = fDate.getFullYear()+'-'+convNum(fDate.getMonth()+1,2)+'-'+convNum(fDate.getDate(),3)+' '+convNum(fDate.getHours(),0)+':'+convNum(fDate.getMinutes(),1);
		}
		if($("#selectEDate").val() != null && $("#selectEDate").val() != "") {
			eDate = $("#selectEDate").val();
		} else {
			eDate = rDate.getFullYear()+'-'+convNum(rDate.getMonth()+1,2)+'-'+convNum(rDate.getDate(),3)+' '+convNum(rDate.getHours(),0)+':'+convNum(rDate.getMinutes(),1);
		}
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
		
		var comSubmit = new ComSubmit("searchForm");
		comSubmit.setUrl("/dcc/alarm/alarmsearch");
		comSubmit.addParam("endDate",eDate+':00.000');
		var alarmGubunConv = isNull($("#alarmGubun option:selected").val()) ? "None" : $("#alarmGubun option:selected").val();
		comSubmit.addParam("alarmGubun", alarmGubunConv);
		comSubmit.addParam("alarmCode", sql_injection($("#alarmCode").val()));
		comSubmit.addParam("address", sql_injection($("#address").val()));
		comSubmit.addParam("alarmMsg", sql_injection($("#alarmMsg").val()));
		comSubmit.addParam("startDate",sDate+':00.000');
		if( ${BaseSearch.totalCnt} <= pageNum && ${BaseSearch.totalCnt} > 0 ) {
			comSubmit.addParam("pageNum", ${BaseSearch.totalCnt});
		} else {
			comSubmit.addParam("pageNum", pageNum);
		}
		comSubmit.addParam("hogiHeader", hogiHeader);
		comSubmit.addParam("xyHeader", xyHeader);
		comSubmit.submit();
	}
	
	function toCSV() {
		var sDate,eDate,sHour,eHour,sMin,eMin;
		var rDate = new Date();
		var fDate = new Date();
		fDate = new Date(fDate.setDate(fDate.getDate()-3));
		if($("#selectSDate").val() != null && $("#selectSDate").val() != "") {
			sDate = $("#selectSDate").val();
		} else {
			sDate = fDate.getFullYear()+'-'+convNum(fDate.getMonth()+1,2)+'-'+convNum(fDate.getDate(),3)+' '+convNum(fDate.getHours(),0)+':'+convNum(fDate.getMinutes(),1);
		}
		if($("#selectEDate").val() != null && $("#selectEDate").val() != "") {
			eDate = $("#selectEDate").val();
		} else {
			eDate = rDate.getFullYear()+'-'+convNum(rDate.getMonth()+1,2)+'-'+convNum(rDate.getDate(),3)+' '+convNum(rDate.getHours(),0)+':'+convNum(rDate.getMinutes(),1);
		}
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
		
		var	comSubmit = new ComSubmit("searchForm");
		comSubmit.setUrl("/dcc/alarm/alarmExcelExport");
		comSubmit.addParam("endDate",eDate+':00.000');
		var alarmGubunConv = isNull($("#alarmGubun option:selected").val()) ? "None" : $("#alarmGubun option:selected").val();
		comSubmit.addParam("alarmGubun", alarmGubunConv);
		comSubmit.addParam("alarmCode", sql_injection($("#alarmCode").val()));
		comSubmit.addParam("address", sql_injection($("#address").val()));
		comSubmit.addParam("alarmMsg", sql_injection($("#alarmMsg").val()));
		comSubmit.addParam("startDate",sDate+':00.000');
		comSubmit.addParam("hogiHeader", hogiHeader);
		comSubmit.addParam("xyHeader", xyHeader);
		comSubmit.submit();
		
		setTimeout(function() {
			sendPage(${BaseSearch.pageNum});
		},2000);
	}
	
	function toTXT() {
		var sDate,eDate,sHour,eHour,sMin,eMin;
		var rDate = new Date();
		var fDate = new Date();
		fDate = new Date(fDate.setDate(fDate.getDate()-3));
		if($("#selectSDate").val() != null && $("#selectSDate").val() != "") {
			sDate = $("#selectSDate").val();
		} else {
			sDate = fDate.getFullYear()+'-'+convNum(fDate.getMonth()+1,2)+'-'+convNum(fDate.getDate(),3)+' '+convNum(fDate.getHours(),0)+':'+convNum(fDate.getMinutes(),1);
		}
		if($("#selectEDate").val() != null && $("#selectEDate").val() != "") {
			eDate = $("#selectEDate").val();
		} else {
			eDate = rDate.getFullYear()+'-'+convNum(rDate.getMonth()+1,2)+'-'+convNum(rDate.getDate(),3)+' '+convNum(rDate.getHours(),0)+':'+convNum(rDate.getMinutes(),1);
		}
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
		
		var	comSubmit = new ComSubmit("searchForm");
		comSubmit.setUrl("/dcc/alarm/alarmTxtExport");
		comSubmit.addParam("endDate",eDate+':00.000');
		var alarmGubunConv = isNull($("#alarmGubun option:selected").val()) ? "None" : $("#alarmGubun option:selected").val();
		comSubmit.addParam("alarmGubun", alarmGubunConv);
		comSubmit.addParam("alarmCode", sql_injection($("#alarmCode").val()));
		comSubmit.addParam("address", sql_injection($("#address").val()));
		comSubmit.addParam("alarmMsg", sql_injection($("#alarmMsg").val()));
		comSubmit.addParam("startDate",sDate+':00.000');
		comSubmit.addParam("hogiHeader", hogiHeader);
		comSubmit.addParam("xyHeader", xyHeader);
		comSubmit.submit();
		
		setTimeout(function() {
			sendPage(${BaseSearch.pageNum});
		},2000);
	}
	
	function sql_injection(str) {
		if( str != null && str != "undefined" ) {
			if( str.indexOf("|") != -1 ) str = str.replaceAll("|","");
			if( str.indexOf("&") != -1 ) str = str.replaceAll("&","");
			if( str.indexOf(";") != -1 ) str = str.replaceAll(";","");
			if( str.indexOf("$") != -1 ) str = str.replaceAll("$","");
			if( str.indexOf("%") != -1 ) str = str.replaceAll("%","");
			if( str.indexOf("@") != -1 ) str = str.replaceAll("@","");
			if( str.indexOf('"') != -1 ) str = str.replaceAll('"',"");
			if( str.indexOf("'") != -1 ) str = str.replaceAll("'","");
			if( str.indexOf("<") != -1 ) str = str.replaceAll("<","");
			if( str.indexOf(">") != -1 ) str = str.replaceAll(">","");
			if( str.indexOf("(") != -1 ) str = str.replaceAll("(","");
			if( str.indexOf(")") != -1 ) str = str.replaceAll(")","");
			if( str.indexOf("+") != -1 ) str = str.replaceAll("+","");
			if( str.indexOf(",") != -1 ) str = str.replaceAll(",","");
			if( str.indexOf("\\") != -1 ) str = str.replaceAll("\\","");
			if( str.indexOf("=") != -1 ) str = str.replaceAll("=","");
		}
		return str;
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
				<h3>ALARM(검색)</h3>
				<div class="bc"><span>DCC</span><span>Alarm</span><strong>Alarm(검색)</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="javascript:toCSV()">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->
				<div class="fx_srch_form">
				<form id="searchForm" name="searchForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item double">
							<label>검색범위</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id="selectSDate" name="selectSDate" readonly>
                                	<label>~</label>
                                    <input type="text" id="selectEDate" name="selectEDate" readonly>
                                </div>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>알람상태</label>
                            <select id="alarmGubun" style="width:90px;">
	                            <c:if test="${BaseSearch.alarmGubun eq 'None'}">
	                                <option value="None" selected>None</option>
	                            </c:if>
	                            <c:if test="${BaseSearch.alarmGubun ne 'None'}">
	                                <option value="None">None</option>
	                            </c:if>
	                            <c:if test="${BaseSearch.alarmGubun eq 'A'}">
	                                <option value="A" selected>A</option>
	                            </c:if>
	                            <c:if test="${BaseSearch.alarmGubun ne 'A'}">
	                                <option value="A">A</option>
	                            </c:if>
	                            <c:if test="${BaseSearch.alarmGubun eq 'N'}">
	                                <option value="N" selected>N</option>
	                            </c:if>
	                            <c:if test="${BaseSearch.alarmGubun ne 'N'}">
	                                <option value="N">N</option>
	                            </c:if>
	                            <c:if test="${BaseSearch.alarmGubun eq 'Null'}">
	                                <option value="Null" selected>Null</option>
	                            </c:if>
	                            <c:if test="${BaseSearch.alarmGubun ne 'Null'}">
	                                <option value="Null">Null</option>
	                            </c:if>
                            </select>
						</div>
						<div class="fx_srch_item">
							<label>I/O 형식</label>
                            <input id="alarmCode" type="text" value="${BaseSearch.alarmCode}">
						</div>
						<div class="fx_srch_item">
							<label>Address</label>
                            <input id="address" type="text" value="${BaseSearch.address}">
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item triple">
							<div style="margin-left:120px;color:red;">
								*BSI별로 경보를 검색하고자 할 경우에는 알람내역에 BSI를 입력하여 주십시오.
							</div>
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item triple">
							<label>알림내역</label>
                            <input id="alarmMsg" type="text" value="${BaseSearch.alarmMsg}">
						</div>
						<div class="fx_srch_item">
							<div style="margin-left:10px">ex) 67120 또는 7120...</div>
						</div>
						<!-- fx_srch_button -->
						<div class="fx_srch_button">
							<a id="alarmSearch" name="alarmSearch" class="btn_srch">Search</a>
							<a id="alarmDetail" name="alarmDetail" class="btn_list primary" href="#none">알람검색</a>
							<a id="alarmSave" name="alarmSave" class="btn_list primary" href="#none">알람저장</a>
							<a id="alarmExcel" name="alarmExcel" class="btn_list primary" href="#none">엑셀저장</a>
						</div>
						<!-- //fx_srch_button -->
					</div>
				</form>
				</div>
			</div>
			<!-- //fx_srch_wrap -->
			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>총건수 : <strong>${BaseSearch.totalCnt}</strong></label>
						<label>총페이지 : <strong>${BaseSearch.totalPage}</strong></label>
					</div>
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="80px"/>
                        <col width="120px"/>
                        <col width="120px"/>
                        <col width="120px"/>
                        <col width="200px"/>
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>순번</th>
                            <th>알람상태</th>
                            <th>I/O형식</th>
                            <th>Address</th>
                            <th>알람일자</th>
                            <th>알람내역</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="dccAlarmInfo" items="${DccAlarmList}">
                        <tr>
                            <td id="rowNum" name="rowNum" class="tc">${dccAlarmInfo.rowNum}</td>
                        <c:if test="${dccAlarmInfo.almGubun eq 'X'}" >
                            <td id="alarmGubun" name="alarmGubun" class="tc"></td>
                        </c:if>
                        <c:if test="${dccAlarmInfo.almGubun ne 'X'}" >
                            <td id="alarmGubun" name="alarmGubun" class="tc">${dccAlarmInfo.almGubun}</td>
                        </c:if>
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
                            <td id="alarmDate" name="alarmDate" class="tc">${dccAlarmInfo.almDate}</td>
                            <td id="alarmMsg" name="alarmMsg">${dccAlarmInfo.almMesg}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- //list_table -->							
				<!-- paginate -->
				<div class="paginate">
					${PageHtml}
				</div>
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
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

