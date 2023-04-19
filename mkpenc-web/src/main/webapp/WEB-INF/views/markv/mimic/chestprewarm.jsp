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
var timerOn = true; //true로 변경
var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

var tMarkTagSeq = [	
	${MarkTagInfoList[0].iSeq},${MarkTagInfoList[1].iSeq},${MarkTagInfoList[2].iSeq},${MarkTagInfoList[3].iSeq},${MarkTagInfoList[4].iSeq},
	${MarkTagInfoList[5].iSeq},${MarkTagInfoList[6].iSeq},${MarkTagInfoList[7].iSeq},${MarkTagInfoList[8].iSeq},${MarkTagInfoList[9].iSeq},
	${MarkTagInfoList[10].iSeq},${MarkTagInfoList[11].iSeq},${MarkTagInfoList[12].iSeq},${MarkTagInfoList[13].iSeq},${MarkTagInfoList[14].iSeq},
	${MarkTagInfoList[15].iSeq}	
];

var tMarkTagXy = [
	'${MarkTagInfoList[0].XYGubun}','${MarkTagInfoList[1].XYGubun}','${MarkTagInfoList[2].XYGubun}','${MarkTagInfoList[3].XYGubun}','${MarkTagInfoList[4].XYGubun}',
	'${MarkTagInfoList[5].XYGubun}','${MarkTagInfoList[6].XYGubun}','${MarkTagInfoList[7].XYGubun}','${MarkTagInfoList[8].XYGubun}','${MarkTagInfoList[9].XYGubun}',
	'${MarkTagInfoList[10].XYGubun}','${MarkTagInfoList[11].XYGubun}','${MarkTagInfoList[12].XYGubun}','${MarkTagInfoList[13].XYGubun}','${MarkTagInfoList[14].XYGubun}',
	'${MarkTagInfoList[15].XYGubun}'
];

var tToolTipText = [
	"${MarkTagInfoList[0].toolTip}"	,"${MarkTagInfoList[1].toolTip}"	,"${MarkTagInfoList[2].toolTip}"	,"${MarkTagInfoList[3].toolTip}"
	,"${MarkTagInfoList[4].toolTip}"	,"${MarkTagInfoList[5].toolTip}"	,"${MarkTagInfoList[6].toolTip}"	,"${MarkTagInfoList[7].toolTip}"
	,"${MarkTagInfoList[8].toolTip}"	,"${MarkTagInfoList[9].toolTip}"	,"${MarkTagInfoList[10].toolTip}"	,"${MarkTagInfoList[11].toolTip}"	
	,"${MarkTagInfoList[12].toolTip}"	,"${MarkTagInfoList[13].toolTip}"	,"${MarkTagInfoList[14].toolTip}"	,"${MarkTagInfoList[15].toolTip}"		
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
	
	$(document.body).delegate('#chestprewarmFrm_div label', 'dblclick', function() {		
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
				var	comSubmit	=	new ComSubmit("chestprewarmFrm");
				comSubmit.setUrl("/markv/mimic/chestprewarm");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("chestprewarmFrm");
		comSubmit.setUrl("/markv/mimic/chestprewarm");
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
				<h3>CHEST PREWARMING</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>CHEST PREWARMING</strong></div>
			</div>
			<!-- //page_title -->

			<form id="chestprewarmFrm" style="display:none"></form>
            <!-- fx_layout -->
            <div class="fx_layout w_full" id="chestprewarmFrm_div">
                <div class="fx_block triple">

                    <div class="chart_line_table">
                        <h4>CONTROL VALVE METAL TEMPERATURE</h4>
                        <div class="chart_wrap_area" style="height:284px;">
                            차트
                        </div>
                    </div>       

                    <div class="chart_line_table">
                        <h4>STEAM TO METAL TEMPERATURE</h4>
                        <div class="chart_wrap_area" style="height:284px;">
                            차트
                        </div>
                    </div>    

                </div>
                <div class="fx_block double center">

                    <div class="chart_line_table">
                        <h4>STEAM PRESSURE</h4>
                        <div class="chart_wrap_area" style="height:284px;">
                            차트
                        </div>
                    </div> 

                    <div class="chart_line_table line" style="width:240px;">
                        <div class="summary">
                            <p>
                                <span>PRESS RATIO</span>
                                <label id="10">
                                	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                </label>
                                <span class="fx_none">%</span>
                            </p>
                        </div>
                    </div>
                    <div class="chart_line_table" style="width:240px;">
                        <div class="line_table_block">
                            <h5>CHEST WARMING</h5>
                        </div>
                        <div class="line_table_block">
                            <div class="summary">
                                <p class="side">
                                    <label>0</label>
                                    <span>MSV</span>
                                    <label id="13">
                                    	<c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if>
                                    </label>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="rotor_off" name="switch_onoff" value="" checked/>
                                    <label for="rotor_off">OFF</label>
                                    <input type="radio" id="rotor_on" name="switch_onoff" value="" />
                                    <label for="rotor_on">ON</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block center">
                    <div class="chart_line_table">
                        <h4>SPEED</h4>
                        <div class="chart_wrap_area" style="height:284px;">
                            차트
                        </div>
                    </div> 

                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h5>MSV2</h5>
                        </div>
                        <div class="line_table_block">
                            <div class="block_item">
                                <div class="summary">
                                    <p>
                                        <label id="12">
                                        	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                        </label>
                                        <span class="fx_none">%</span>
                                    </p>
                                </div>
                                <div class="switch_button">
                                    <input type="radio" id="rotor_raise" name="switch_rl" value="" checked/>
                                    <label class="full" for="rotor_raise">RAISE</label>
                                    <input type="radio" id="rotor_lower" name="switch_rl" value="" />
                                    <label class="full" for="rotor_lower">LOWER</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //fx_layout -->
                
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

