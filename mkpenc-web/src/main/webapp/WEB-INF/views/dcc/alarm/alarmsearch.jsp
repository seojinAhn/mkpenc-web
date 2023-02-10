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
	$('#edate').datetimepicker(DatetimepickerDefaults({}));
	
	

});	

function movepage(){
	
	var inputString = prompt('문자열을 입력하세요', '기본 값 문자열');
	alert(inputString);
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
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item double">
							<label>검색범위</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id="sdate" name="sdate" readonly>
                                   <label>~</label>
                                   <input type="text" id="edate" name="edate" readonly>
                                </div>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>알림상태</label>
                            <select class="fx_none" style="width:90px;">
                                <option>3-002 가압기</option>
                            </select>
						</div>

						<div class="fx_srch_item">
							<label>I/O 형식</label>
                            <input type="text" >
						</div>
						<div class="fx_srch_item">
							<label>Address</label>
                            <input type="text" >
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>알림내역</label>
                            <input type="text" >
						</div>
						<div class="fx_srch_item"></div>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch">Search</a>
					<a class="btn_list primary" href="/dcc/alarm/alarm">알림검색</a>
					<a class="btn_list primary" href="#none">알람저장</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
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
						<a class="btn_list primary" href="#none">이동</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->     
                <!-- list_table -->
                <table class="list_table">
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
                            <th colspan="4">기간 A</th>
                            <th colspan="4">기간 B</th>
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
                    <tbody>
                        <tr>
                            <td>가압기 입력</td>
                            <td class="tc">MPGA</td>
                            <td class="tc">9.97</td>
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
                        <tr>
                            <td>가압기 입력</td>
                            <td class="tc">MPGA</td>
                            <td class="tc">9.97</td>
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
                        <tr>
                            <td>가압기 입력</td>
                            <td class="tc">MPGA</td>
                            <td class="tc">9.97</td>
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
                        <tr>
                            <td>가압기 입력</td>
                            <td class="tc">MPGA</td>
                            <td class="tc">9.97</td>
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
                        <tr>
                            <td>가압기 입력</td>
                            <td class="tc">MPGA</td>
                            <td class="tc">9.97</td>
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
                        <tr>
                            <td>가압기 입력</td>
                            <td class="tc">MPGA</td>
                            <td class="tc">9.97</td>
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