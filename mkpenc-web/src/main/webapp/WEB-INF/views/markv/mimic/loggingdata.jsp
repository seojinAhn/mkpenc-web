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
	${MarkTagInfoList[15].iSeq},${MarkTagInfoList[16].iSeq},${MarkTagInfoList[17].iSeq},${MarkTagInfoList[18].iSeq},${MarkTagInfoList[19].iSeq},
	${MarkTagInfoList[20].iSeq},${MarkTagInfoList[21].iSeq},${MarkTagInfoList[22].iSeq},${MarkTagInfoList[23].iSeq},${MarkTagInfoList[24].iSeq},
	${MarkTagInfoList[25].iSeq},${MarkTagInfoList[26].iSeq},${MarkTagInfoList[27].iSeq},${MarkTagInfoList[28].iSeq},${MarkTagInfoList[29].iSeq},
	${MarkTagInfoList[30].iSeq},${MarkTagInfoList[31].iSeq},${MarkTagInfoList[32].iSeq},${MarkTagInfoList[33].iSeq},${MarkTagInfoList[34].iSeq},
	${MarkTagInfoList[35].iSeq},${MarkTagInfoList[36].iSeq},${MarkTagInfoList[37].iSeq},${MarkTagInfoList[38].iSeq},${MarkTagInfoList[39].iSeq},
	${MarkTagInfoList[40].iSeq},${MarkTagInfoList[41].iSeq},${MarkTagInfoList[42].iSeq},${MarkTagInfoList[43].iSeq},${MarkTagInfoList[44].iSeq},
	${MarkTagInfoList[45].iSeq},${MarkTagInfoList[46].iSeq},${MarkTagInfoList[47].iSeq},${MarkTagInfoList[48].iSeq},${MarkTagInfoList[49].iSeq},	
	${MarkTagInfoList[50].iSeq},${MarkTagInfoList[51].iSeq}
];

var tMarkTagXy = [
	'${MarkTagInfoList[0].XYGubun}','${MarkTagInfoList[1].XYGubun}','${MarkTagInfoList[2].XYGubun}','${MarkTagInfoList[3].XYGubun}','${MarkTagInfoList[4].XYGubun}',
	'${MarkTagInfoList[5].XYGubun}','${MarkTagInfoList[6].XYGubun}','${MarkTagInfoList[7].XYGubun}','${MarkTagInfoList[8].XYGubun}','${MarkTagInfoList[9].XYGubun}',
	'${MarkTagInfoList[10].XYGubun}','${MarkTagInfoList[11].XYGubun}','${MarkTagInfoList[12].XYGubun}','${MarkTagInfoList[13].XYGubun}','${MarkTagInfoList[14].XYGubun}',
	'${MarkTagInfoList[15].XYGubun}','${MarkTagInfoList[16].XYGubun}','${MarkTagInfoList[17].XYGubun}','${MarkTagInfoList[18].XYGubun}','${MarkTagInfoList[19].XYGubun}',
	'${MarkTagInfoList[20].XYGubun}','${MarkTagInfoList[21].XYGubun}','${MarkTagInfoList[22].XYGubun}','${MarkTagInfoList[23].XYGubun}','${MarkTagInfoList[24].XYGubun}',
	'${MarkTagInfoList[25].XYGubun}','${MarkTagInfoList[26].XYGubun}','${MarkTagInfoList[27].XYGubun}','${MarkTagInfoList[28].XYGubun}','${MarkTagInfoList[29].XYGubun}',
	'${MarkTagInfoList[30].XYGubun}','${MarkTagInfoList[31].XYGubun}','${MarkTagInfoList[32].XYGubun}','${MarkTagInfoList[33].XYGubun}','${MarkTagInfoList[34].XYGubun}',
	'${MarkTagInfoList[35].XYGubun}','${MarkTagInfoList[36].XYGubun}','${MarkTagInfoList[37].XYGubun}','${MarkTagInfoList[38].XYGubun}','${MarkTagInfoList[39].XYGubun}',
	'${MarkTagInfoList[40].XYGubun}','${MarkTagInfoList[41].XYGubun}','${MarkTagInfoList[42].XYGubun}','${MarkTagInfoList[43].XYGubun}','${MarkTagInfoList[44].XYGubun}',
	'${MarkTagInfoList[45].XYGubun}','${MarkTagInfoList[46].XYGubun}','${MarkTagInfoList[47].XYGubun}','${MarkTagInfoList[48].XYGubun}','${MarkTagInfoList[49].XYGubun}',
	'${MarkTagInfoList[50].XYGubun}','${MarkTagInfoList[51].XYGubun}'
];

var tToolTipText = [
	"${MarkTagInfoList[0].toolTip}"	,"${MarkTagInfoList[1].toolTip}"	,"${MarkTagInfoList[2].toolTip}"	,"${MarkTagInfoList[3].toolTip}"
	,"${MarkTagInfoList[4].toolTip}"	,"${MarkTagInfoList[5].toolTip}"	,"${MarkTagInfoList[6].toolTip}"	,"${MarkTagInfoList[7].toolTip}"
	,"${MarkTagInfoList[8].toolTip}"	,"${MarkTagInfoList[9].toolTip}"	,"${MarkTagInfoList[10].toolTip}"	,"${MarkTagInfoList[11].toolTip}"
	,"${MarkTagInfoList[12].toolTip}"	,"${MarkTagInfoList[13].toolTip}"	,"${MarkTagInfoList[14].toolTip}"	,"${MarkTagInfoList[15].toolTip}"
	,"${MarkTagInfoList[16].toolTip}"	,"${MarkTagInfoList[17].toolTip}"	,"${MarkTagInfoList[18].toolTip}"	,"${MarkTagInfoList[19].toolTip}"
	,"${MarkTagInfoList[20].toolTip}"	,"${MarkTagInfoList[21].toolTip}"	,"${MarkTagInfoList[22].toolTip}"	,"${MarkTagInfoList[23].toolTip}"
	,"${MarkTagInfoList[24].toolTip}"	,"${MarkTagInfoList[25].toolTip}"	,"${MarkTagInfoList[26].toolTip}"	,"${MarkTagInfoList[27].toolTip}"
	,"${MarkTagInfoList[28].toolTip}"	,"${MarkTagInfoList[29].toolTip}"	,"${MarkTagInfoList[30].toolTip}"	,"${MarkTagInfoList[31].toolTip}"
	,"${MarkTagInfoList[32].toolTip}"	,"${MarkTagInfoList[33].toolTip}"	,"${MarkTagInfoList[34].toolTip}"	,"${MarkTagInfoList[35].toolTip}"	
	,"${MarkTagInfoList[36].toolTip}"	,"${MarkTagInfoList[37].toolTip}"	,"${MarkTagInfoList[38].toolTip}"	,"${MarkTagInfoList[39].toolTip}"
	,"${MarkTagInfoList[40].toolTip}"	,"${MarkTagInfoList[41].toolTip}"	,"${MarkTagInfoList[42].toolTip}"	,"${MarkTagInfoList[43].toolTip}"
	,"${MarkTagInfoList[44].toolTip}"	,"${MarkTagInfoList[45].toolTip}"	,"${MarkTagInfoList[46].toolTip}"	,"${MarkTagInfoList[47].toolTip}"
	,"${MarkTagInfoList[48].toolTip}"	,"${MarkTagInfoList[49].toolTip}"	,"${MarkTagInfoList[50].toolTip}"	,"${MarkTagInfoList[51].toolTip}"	
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
	
	$(document.body).delegate('#Y', 'click', function() {		
		setTimer(hogiHeader,'Y',0);
	});	
	
	$(document.body).delegate('#loggingdata_div label', 'dblclick', function() {
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
				var	comSubmit	=	new ComSubmit("loggingdataFrm");
				comSubmit.setUrl("/markv/mimic/loggingdata");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("loggingdataFrm");
		comSubmit.setUrl("/markv/mimic/loggingdata");
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
				<h3>LOGGING DATA</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>SECONDARY</span><strong>LOGGING DATA</strong></div>
			</div>
			<!-- //page_title -->
            <!-- fx_layout -->
            <form id="loggingdataFrm" style="display:none"></form>
            <div class="fx_layout" id="loggingdata_div">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>TURBINE LOAD</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="0">
                                        	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                        </label>
                                        <label class="full">MW</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>TURBINE SPEED</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="1">
                                        	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                        </label>
                                        <label class="full">rpm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAIN STEAM HEADER PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="2">
                                        	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAIN STEAM HEADER TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="3">
                                        	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV1 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="4">
                                        	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV2 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="5">
                                        	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV3 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="6">
                                        	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV4 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="7">
                                        	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING COND OUT</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="8">
                                        	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                        </label>
                                        <label class="full">umo/c</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING COND IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="9">
                                        	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                                        </label>
                                        <label class="full">umo/c</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING PRESS IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="10">
                                        	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING FLOW IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="11">
                                        	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                                        </label>
                                        <label class="full">I/min</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING TEMP IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="12">
                                        	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING TEMP OUT</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="13">
                                        	<c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDROGEN PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="14">
                                        	<c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDROGEN PURITY</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="15">
                                        	<c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>COMMON COLD GAS TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="16">
                                        	<c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="17">
                                        	<c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="18">
                                        	<c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BEARING HEADER PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="19">
                                        	<c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BEARING HEADER TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="20">
                                        	<c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP1 EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="52">
                                        	<c:if test="${lblDataList[52].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[52].fValue ne null}">${lblDataList[52].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP2 EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="53">
                                        	<c:if test="${lblDataList[53].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[53].fValue ne null}">${lblDataList[53].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP3 EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="26">
                                       		<c:if test="${lblDataList[26].fValue eq null}">0</c:if>
                                       		<c:if test="${lblDataList[26].fValue ne null}">${lblDataList[26].fValue}</c:if>
                                       	</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STEAM SEAL HEADER PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="24">
                                        	<c:if test="${lblDataList[24].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[24].fValue ne null}">${lblDataList[24].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THURST BRG METAL F.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="25">
                                        	<c:if test="${lblDataList[25].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[25].fValue ne null}">${lblDataList[25].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
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
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>THURST BRG METAL R.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="27">
                                        	<c:if test="${lblDataList[27].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[27].fValue ne null}">${lblDataList[27].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THURST BRG DRAIN F.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="28">
                                        	<c:if test="${lblDataList[28].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[28].fValue ne null}">${lblDataList[28].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THURST BRG DRAIN R.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="29">
                                        	<c:if test="${lblDataList[29].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[29].fValue ne null}">${lblDataList[29].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 1X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="30">
                                        	<c:if test="${lblDataList[30].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[30].fValue ne null}">${lblDataList[30].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 2X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="31">
                                        	<c:if test="${lblDataList[31].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[31].fValue ne null}">${lblDataList[31].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 3X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="32">
                                        	<c:if test="${lblDataList[32].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[32].fValue ne null}">${lblDataList[32].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 4X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="33">
                                        	<c:if test="${lblDataList[33].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[33].fValue ne null}">${lblDataList[33].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 5X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="34">
                                        	<c:if test="${lblDataList[34].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[34].fValue ne null}">${lblDataList[34].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 6X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="35">
                                        	<c:if test="${lblDataList[35].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[35].fValue ne null}">${lblDataList[35].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 7X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="36">
                                        	<c:if test="${lblDataList[36].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[36].fValue ne null}">${lblDataList[36].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 8X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="37">
                                        	<c:if test="${lblDataList[37].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[37].fValue ne null}">${lblDataList[37].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 9X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="38">
                                        	<c:if test="${lblDataList[38].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[38].fValue ne null}">${lblDataList[38].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 10X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="39">
                                        	<c:if test="${lblDataList[39].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[39].fValue ne null}">${lblDataList[39].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THUST BRG WEAR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="40">
                                        	<c:if test="${lblDataList[40].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[40].fValue ne null}">${lblDataList[40].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ROTOR EXPANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="41">
                                        	<c:if test="${lblDataList[41].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[41].fValue ne null}">${lblDataList[41].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>SHELL EXPANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="42">
                                        	<c:if test="${lblDataList[42].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[42].fValue ne null}">${lblDataList[42].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>DIFFERENTIAL EXOANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="43">
                                        	<c:if test="${lblDataList[43].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[43].fValue ne null}">${lblDataList[43].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ECCENTRICITY</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="44">
                                        	<c:if test="${lblDataList[44].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[44].fValue ne null}">${lblDataList[44].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAX BRG VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="45">
                                        	<c:if test="${lblDataList[45].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[45].fValue ne null}">${lblDataList[45].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP FIRST STAGE PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="46">
                                        	<c:if test="${lblDataList[46].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[46].fValue ne null}">${lblDataList[46].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>REHEATER INLET PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="47">
                                        	<c:if test="${lblDataList[47].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[47].fValue ne null}">${lblDataList[47].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP EXHAUST STAGE TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="48">
                                        	<c:if test="${lblDataList[48].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[48].fValue ne null}">${lblDataList[48].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP1 EXHAUST PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="49">
                                        	<c:if test="${lblDataList[49].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[49].fValue ne null}">${lblDataList[49].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP2 EXHAUST PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="50">
                                        	<c:if test="${lblDataList[50].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[50].fValue ne null}">${lblDataList[50].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP3 EXHAUST PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end" id="51">
                                        	<c:if test="${lblDataList[51].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[51].fValue ne null}">${lblDataList[51].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
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

