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
<script type="text/javascript" src="<c:url value="/resources/js/mimic.js" />" charset="utf-8"></script>

<script type="text/javascript">

var timerOn = false; //true로 변경
var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

var tMarkTagSeq = [	
	${MarkTagInfoList[0].iSeq},${MarkTagInfoList[1].iSeq},${MarkTagInfoList[2].iSeq},${MarkTagInfoList[3].iSeq},${MarkTagInfoList[4].iSeq},
	${MarkTagInfoList[5].iSeq},${MarkTagInfoList[6].iSeq},${MarkTagInfoList[7].iSeq},${MarkTagInfoList[8].iSeq},${MarkTagInfoList[9].iSeq},
	${MarkTagInfoList[10].iSeq},${MarkTagInfoList[11].iSeq},${MarkTagInfoList[12].iSeq}
];

var tMarkTagXy = [
	'${MarkTagInfoList[0].XYGubun}','${MarkTagInfoList[1].XYGubun}','${MarkTagInfoList[2].XYGubun}','${MarkTagInfoList[3].XYGubun}','${MarkTagInfoList[4].XYGubun}',
	'${MarkTagInfoList[5].XYGubun}','${MarkTagInfoList[6].XYGubun}','${MarkTagInfoList[7].XYGubun}','${MarkTagInfoList[8].XYGubun}','${MarkTagInfoList[9].XYGubun}',
	'${MarkTagInfoList[10].XYGubun}','${MarkTagInfoList[11].XYGubun}','${MarkTagInfoList[12].XYGubun}'
];

var tToolTipText = [
	"${MarkTagInfoList[0].toolTip}"	,"${MarkTagInfoList[1].toolTip}","${MarkTagInfoList[2].toolTip}","${MarkTagInfoList[3].toolTip}"
	,"${MarkTagInfoList[4].toolTip}","${MarkTagInfoList[5].toolTip}","${MarkTagInfoList[6].toolTip}","${MarkTagInfoList[7].toolTip}"
	,"${MarkTagInfoList[8].toolTip}","${MarkTagInfoList[9].toolTip}","${MarkTagInfoList[10].toolTip}","${MarkTagInfoList[11].toolTip}"
	,"${MarkTagInfoList[12].toolTip}"
];


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
	
	var lblDateVal = '${SearchTime}';
	$("#lblDate").text(lblDateVal);
	
	$(document.body).delegate('#3', 'click', function() {
		setTimer('3',xyHeader,0);
	});
	$(document.body).delegate('#4', 'click', function() {
		setTimer('4',xyHeader,0);
	});
	$(document.body).delegate('#X', 'click', function() {
		setTimer(hogiHeader,'X',0);
	});

	$(document.body).delegate('#frontstandard_div label', 'dblclick', function() {		
		var cId = this.id.indexOf('fValue') > -1 ? this.id.substring(4) : this.id;
		if( cId != null && cId != '' && cId != 'undefined' ) {
			showTag(cId,tMarkTagSeq[cId]);
		}
	});
	
	setTimer(hogiHeader,xyHeader,5000);
	
});

function setTimer(hogiHeader,xyHeader,interval) {
	if( interval > 0 ) {
		setTimeout(function() {
			if( timerOn ) {
				var	comSubmit	=	new ComSubmit("frontstandardFrm");
				comSubmit.setUrl("/markv/mimic/frontstandard");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("frontstandardFrm");
		comSubmit.setUrl("/markv/mimic/frontstandard");
		comSubmit.addParam("hogiHeader",hogiHeader);
		comSubmit.addParam("xyHeader",xyHeader);
		comSubmit.submit();
	}
}

function showTag(tagNo,iSeq) {	
	alert("showTag");	
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
				<h3>PROTECTIVE TESTS FRONT STANDARD</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>TESTs</span><strong>PROTECTIVE TESTS FRONT STANDARD</strong></div>
			</div>
			<!-- //page_title -->
			<form id="frontstandardFrm" style="display:none"></form>
			<div class="img_wrap" style="min-height:600px;" id="frontstandard_div">
                <div class="fx_layout no_mg" style="position:absolute;top:40px;left:170px;width:510px;height:124px;">
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>ACTUAL MECH O/S</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_mech" name="switch_mech" value="" checked/>
                                    <label for="off_mech">STOP</label>
                                    <input type="radio" id="on_mech" name="switch_mech" value="" />
                                    <label for="on_mech">START</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>RESET PEAK SPEED</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <div class="chart_block_contents">
                                <div class="switch_button center">
                                    <input type="radio" id="reset" name="switch_reset" value=""/>
                                    <label for="reset">RESET</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_layout no_mg" style="position:absolute;top:40px;left:700px;width:510px;height:480px;">
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>MECH TRIP SYS</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>1. LOCKOUT</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button center">
                                    <input type="radio" id="off_lock" name="switch_lock" value=""/>
                                    <label for="off_lock">LOCK</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>2. MECH O/S</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_mech_os" name="switch_mech_os" value="" checked/>
                                    <label for="off_mech_os">OFF</label>
                                    <input type="radio" id="on_mech_os" name="switch_mech_os" value="" />
                                    <label for="on_mech_os">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>MECH PISTON TEST 1</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_test1" name="switch_test1" value="" checked/>
                                    <label for="off_test1">OFF</label>
                                    <input type="radio" id="on_test1" name="switch_test1" value="" />
                                    <label for="on_test1">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>MECH PISTON TEST 2</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_test2" name="switch_test2" value="" checked/>
                                    <label for="off_test2">OFF</label>
                                    <input type="radio" id="on_test2" name="switch_test2" value="" />
                                    <label for="on_test2">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>3. UNLOCK</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button center">
                                    <input type="radio" id="off_unlock" name="switch_unlock" value="" checked/>
                                    <label for="off_unlock">UNLOCK</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>ELECT TRIP SYS</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>1. LOCKOUT</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_elect_lock" name="switch_elect_lock" value=""/>
                                    <label for="off_elect_lock">LOCK</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>2. ELECT O/S</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_elect_os" name="switch_elect_os" value="" checked/>
                                    <label for="off_elect_os">OFF</label>
                                    <input type="radio" id="on_elect_os" name="switch_elect_os" value="" />
                                    <label for="on_elect_os">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>ELECT TRIP</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_elect_trip" name="switch_elect_trip" value="" checked/>
                                    <label for="off_elect_trip">OFF</label>
                                    <input type="radio" id="on_elect_trip" name="switch_elect_trip" value="" />
                                    <label for="on_elect_trip">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <div class="chart_block_contents">
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>3. UNLOCK</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_elect_unlock" name="switch_elect_unlock" value="" checked/>
                                    <label for="off_elect_unlock">UNLOCK</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart_block small half" style="top:180px;left:170px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>MECHANICAL TRIP SYSTEM</span>
                                <label id="0">
                                	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span></span>
                                <label id="1">
                                	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ELECTRACAL TRIP SYSTEM</span>
                                <label id="2">
                                	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span></span>
                                <label id="3">
                                	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PROTECTIVE TEST ACTIVE</span>
                                <label id="4">
                                	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CURRENT SPEED</span>
                                <label id="5">
                                	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                </label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>TRIP SPEED SETPOINT</span>
                                <label id="6">
                                	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                </label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PEAK SPEED</span>
                                <label id="7">
                                	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                                </label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LAST OIL TRIP TEST</span>
                                <label id="8">
                                	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                </label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LOAD</span>
                                <label id="9">
                                	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                                </label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CVR</span>
                                <label id="10">
                                	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                </label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>IVR</span>
                                <label id="11">
                                	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MECH O/S MAIN. TEST</span>
                                <label id="12">
                                	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                    </div>
                </div>      
                <div class="chart_block small half" style="top:540px;left:700px;">
                    <div class="chart_block_contents only_txt">
                        <div class="msg_warning">
                            <p>!!!!! WARNING !!!!!</p>
                            <p>MANUAL UNLOCK MAY TRIP THE TURBINE</p>
                        </div>
                    </div>
                </div>                          
            </div>
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
<div class="layer_pop_wrap large" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태그정보</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>태그번호</th>
                    <td>
                        <div class="fx_form">
                            <input type="text">
                            <a class="btn_list" herf="none" onclick="openLayer('modal_2');">태그찾기</a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>태그명</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>태그설명</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>표현방식</th>
                    <td>
                        <div class="fx_form_multi">
                            <div class="fx_form">
                                <label>
                                    <input type="radio" name="type">
                                    수치표현
                                </label>
                                <label>
                                    <input type="radio" name="type">
                                    문자표현
                                </label>
                                <label>
                                    <input type="radio" name="type">
                                    문자표현(A)
                                </label>
                                <a class="btn_list" herf="none" onclick="openLayer('modal_3');">문자(A) 표현관리</a>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>소수점 자리수</th>
                    <td>
                        <select class="fx_none" style="width:120px;">
                            <option>0000</option>
                        </select>                        
                    </td>
                </tr>
                <tr>
                    <th>0 상태 문자표현(0)</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>1 상태 문자표현(0)</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>문자표현(A)</th>
                    <td>
                        <div class="fx_form">
                            <select class="fx_none" style="width:260px;">
                                <option>0000</option>
                            </select>
                            <select>
                                <option>0000</option>
                            </select>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
        <a href="#none" class="btn_page">Command1</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태그목록</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        <!-- fx_srch_wrap -->
        <div class="fx_srch_wrap">	
            <div class="fx_srch_form">
                <div class="fx_srch_row">
                    <div class="fx_srch_item">
                        <label>검색옵션</label>
                        <div class="fx_form">
                            <label>
                                <input type="checkbox" name="type">
                                태그명
                            </label>
                            <label>
                                <input type="checkbox" name="type">
                                태그설명
                            </label>
                        </div>
                    </div>
                    <div class="fx_srch_item">
                        <label>검색어</label>
                        <input type="text">
                    </div>
                </div>
            </div>
            <!-- fx_srch_button -->
            <div class="fx_srch_button">
                <a class="btn_srch">Search</a>
            </div>
            <!-- //fx_srch_button -->
        </div>
        <!-- //fx_srch_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table_scroll -->
            <div class="list_table_scroll">                
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>title</th>
                            <th>title</th>
                            <th>title</th>
                            <th>title</th>
                            <th>title</th>
                            <th>title</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
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
                <!-- //list_table_scroll -->
        </div>
        <!-- //list_wrap -->        
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page">전체리스트</a>
        <a href="#none" class="btn_page primary">선택</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_3">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>Analog 문자표현 그룹관리</h3>
        <a onclick="closeLayer('modal_3');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        
        <!-- layout_table -->
        <table class="layout_table">
            <colgroup>
                <col />
                <col />
            </colgroup>
            <tbody>
                <tr>
                    <td>

                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <h4>그룹목록</h4>
                            </div>
                            <!-- //list_head --> 
                        </div>                
                        <!-- fx_srch_wrap -->
                        <div class="fx_srch_wrap b_type">	
                            <div class="fx_srch_form">
                                <div class="fx_srch_row">
                                    <div class="fx_srch_item">
                                        <label>그룹</label>
                                        <div class="fx_form">
                                            <input type="text" class="fx_none" style="width:50px;">
                                            <input type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //fx_srch_wrap -->                
                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <!-- button -->
                                <div class="button">
                                    <a class="btn_list primary" href="#none">추가</a>
                                    <a class="btn_list" href="#none">수정</a>
                                    <a class="btn_list" href="#none">삭제</a>
                                </div>
                                <!-- button -->
                            </div>
                            <!-- //list_head -->            
                            <!-- list_table_scroll -->
                            <div class="list_table_scroll">
                                <!-- list_table -->
                                <table class="list_table">
                                    <colgroup>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
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
                                <!-- //list_table_scroll -->
                        </div>
                        <!-- //list_wrap -->
                        
                    </td>
                    <td>

                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <h4>표현문자목록</h4>
                            </div>
                            <!-- //list_head --> 
                        </div>                
                        <!-- fx_srch_wrap -->
                        <div class="fx_srch_wrap b_type">	
                            <div class="fx_srch_form">
                                <div class="fx_srch_row">
                                    <div class="fx_srch_item">
                                        <label>표현문자</label>
                                        <div class="fx_form">
                                            <input type="text" class="fx_none" style="width:50px;">
                                            <input type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //fx_srch_wrap -->                
                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <!-- button -->
                                <div class="button">
                                    <a class="btn_list primary" href="#none">추가</a>
                                    <a class="btn_list" href="#none">수정</a>
                                    <a class="btn_list" href="#none">삭제</a>
                                </div>
                                <!-- button -->
                            </div>
                            <!-- //list_head -->            
                            <!-- list_table_scroll -->
                            <div class="list_table_scroll">                
                                <!-- list_table -->
                                <table class="list_table">
                                    <colgroup>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
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
                                <!-- //list_table_scroll -->
                        </div>
                        <!-- //list_wrap -->
                        
                    </td>
                </tr>
            </tbody>
        </table>

	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">선택</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_3');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

