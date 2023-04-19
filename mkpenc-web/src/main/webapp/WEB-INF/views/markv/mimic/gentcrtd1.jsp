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
	${MarkTagInfoList[50].iSeq},${MarkTagInfoList[51].iSeq},${MarkTagInfoList[52].iSeq},${MarkTagInfoList[53].iSeq},${MarkTagInfoList[54].iSeq},
	${MarkTagInfoList[55].iSeq},${MarkTagInfoList[56].iSeq},${MarkTagInfoList[57].iSeq},${MarkTagInfoList[58].iSeq},${MarkTagInfoList[59].iSeq},
	${MarkTagInfoList[60].iSeq},${MarkTagInfoList[61].iSeq},${MarkTagInfoList[62].iSeq},${MarkTagInfoList[63].iSeq},${MarkTagInfoList[64].iSeq},
	${MarkTagInfoList[65].iSeq},${MarkTagInfoList[66].iSeq},${MarkTagInfoList[67].iSeq},${MarkTagInfoList[68].iSeq},${MarkTagInfoList[69].iSeq},
	${MarkTagInfoList[70].iSeq},${MarkTagInfoList[71].iSeq}
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
	'${MarkTagInfoList[50].XYGubun}','${MarkTagInfoList[51].XYGubun}','${MarkTagInfoList[52].XYGubun}','${MarkTagInfoList[53].XYGubun}','${MarkTagInfoList[54].XYGubun}',
	'${MarkTagInfoList[55].XYGubun}','${MarkTagInfoList[56].XYGubun}','${MarkTagInfoList[57].XYGubun}','${MarkTagInfoList[58].XYGubun}','${MarkTagInfoList[59].XYGubun}',
	'${MarkTagInfoList[60].XYGubun}','${MarkTagInfoList[61].XYGubun}','${MarkTagInfoList[62].XYGubun}','${MarkTagInfoList[63].XYGubun}','${MarkTagInfoList[64].XYGubun}',
	'${MarkTagInfoList[65].XYGubun}','${MarkTagInfoList[66].XYGubun}','${MarkTagInfoList[67].XYGubun}','${MarkTagInfoList[68].XYGubun}','${MarkTagInfoList[69].XYGubun}',
	'${MarkTagInfoList[70].XYGubun}','${MarkTagInfoList[71].XYGubun}'
];

var tToolTipText = [
	"${MarkTagInfoList[0].toolTip}"	,"${MarkTagInfoList[1].toolTip}","${MarkTagInfoList[2].toolTip}","${MarkTagInfoList[3].toolTip}"
	,"${MarkTagInfoList[4].toolTip}","${MarkTagInfoList[5].toolTip}","${MarkTagInfoList[6].toolTip}","${MarkTagInfoList[7].toolTip}"
	,"${MarkTagInfoList[8].toolTip}","${MarkTagInfoList[9].toolTip}","${MarkTagInfoList[10].toolTip}","${MarkTagInfoList[11].toolTip}"
	,"${MarkTagInfoList[12].toolTip}","${MarkTagInfoList[13].toolTip}","${MarkTagInfoList[14].toolTip}","${MarkTagInfoList[15].toolTip}"
	,"${MarkTagInfoList[16].toolTip}","${MarkTagInfoList[17].toolTip}","${MarkTagInfoList[18].toolTip}","${MarkTagInfoList[19].toolTip}"
	,"${MarkTagInfoList[20].toolTip}","${MarkTagInfoList[21].toolTip}","${MarkTagInfoList[22].toolTip}","${MarkTagInfoList[23].toolTip}"
	,"${MarkTagInfoList[24].toolTip}","${MarkTagInfoList[25].toolTip}","${MarkTagInfoList[26].toolTip}","${MarkTagInfoList[27].toolTip}"
	,"${MarkTagInfoList[28].toolTip}","${MarkTagInfoList[29].toolTip}","${MarkTagInfoList[30].toolTip}","${MarkTagInfoList[31].toolTip}"
	,"${MarkTagInfoList[32].toolTip}","${MarkTagInfoList[33].toolTip}","${MarkTagInfoList[34].toolTip}","${MarkTagInfoList[35].toolTip}"
	,"${MarkTagInfoList[36].toolTip}","${MarkTagInfoList[37].toolTip}","${MarkTagInfoList[38].toolTip}","${MarkTagInfoList[39].toolTip}"
	,"${MarkTagInfoList[40].toolTip}","${MarkTagInfoList[41].toolTip}","${MarkTagInfoList[42].toolTip}","${MarkTagInfoList[43].toolTip}"
	,"${MarkTagInfoList[44].toolTip}","${MarkTagInfoList[45].toolTip}","${MarkTagInfoList[46].toolTip}","${MarkTagInfoList[47].toolTip}"
	,"${MarkTagInfoList[48].toolTip}","${MarkTagInfoList[49].toolTip}","${MarkTagInfoList[50].toolTip}","${MarkTagInfoList[51].toolTip}"
	,"${MarkTagInfoList[52].toolTip}","${MarkTagInfoList[53].toolTip}","${MarkTagInfoList[54].toolTip}","${MarkTagInfoList[55].toolTip}"
	,"${MarkTagInfoList[56].toolTip}","${MarkTagInfoList[57].toolTip}","${MarkTagInfoList[58].toolTip}","${MarkTagInfoList[59].toolTip}"
	,"${MarkTagInfoList[60].toolTip}","${MarkTagInfoList[61].toolTip}","${MarkTagInfoList[62].toolTip}","${MarkTagInfoList[63].toolTip}"
	,"${MarkTagInfoList[64].toolTip}","${MarkTagInfoList[65].toolTip}","${MarkTagInfoList[66].toolTip}","${MarkTagInfoList[67].toolTip}"
	,"${MarkTagInfoList[68].toolTip}","${MarkTagInfoList[69].toolTip}","${MarkTagInfoList[70].toolTip}","${MarkTagInfoList[71].toolTip}"
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

	$(document.body).delegate('#gentcrtd1_div td', 'dblclick', function() {		
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
				var	comSubmit	=	new ComSubmit("gentcrtd1Frm");
				comSubmit.setUrl("/markv/mimic/gentcrtd1");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("gentcrtd1Frm");
		comSubmit.setUrl("/markv/mimic/gentcrtd1");
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
				<h3>STATOR SLOT(RTD) & BAR(TC) TEMP-1</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>STATOR SLOT(RTD) & BAR(TC) TEMP-1</strong></div>
			</div>
			<!-- //page_title -->
			
			<form id="gentcrtd1Frm" style="display:none"></form>
            <!-- fx_layout -->
            <div class="fx_layout" id="gentcrtd1_div">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col />
                                <col width="140px" />
                                <col width="140px" />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>SLOT #</th>
                                    <th>RTD TEMP</th>
                                    <th>TC TEMP</th>
                                    <th>BAR 1</th>
                                    <th>BAR 2</th>
                                    <th>CON RING</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tc">01</td>
                                    <td class="tc" id="0">
                                    <c:if test="${lblDataList[0].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[0].fValue ne null}"><input type="text" value="${lblDataList[0].fValue}" class="tr" /></c:if>
                                    </td>
                                    <td class="tc" id="36">
                                    <c:if test="${lblDataList[36].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[36].fValue ne null}"><input type="text" value="${lblDataList[36].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    
                                    <td class="tc">T66</td>
                                    <td class="tc">B08</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">02</td>
                                    <td class="tc" id="1">
                                    <c:if test="${lblDataList[1].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[1].fValue ne null}"><input type="text" value="${lblDataList[1].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="37">
                                    <c:if test="${lblDataList[37].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[37].fValue ne null}"><input type="text" value="${lblDataList[37].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">B09</td>
                                    <td class="tc">B26</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">03</td>
                                    <td class="tc" id="2">
                                    <c:if test="${lblDataList[2].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[2].fValue ne null}"><input type="text" value="${lblDataList[2].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="38">
                                    <c:if test="${lblDataList[38].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[38].fValue ne null}"><input type="text" value="${lblDataList[38].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T68</td>
                                    <td class="tc">T49</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">04</td>
                                    <td class="tc" id="3">
                                    <c:if test="${lblDataList[3].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[3].fValue ne null}"><input type="text" value="${lblDataList[3].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="39">
                                    <c:if test="${lblDataList[39].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[39].fValue ne null}"><input type="text" value="${lblDataList[39].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T69</td>
                                    <td class="tc">B10</td>
                                    <td class="tc">-T3</td>
                                </tr>
                                <tr>
                                    <td class="tc">05</td>
                                    <td class="tc" id="4">
                                    <c:if test="${lblDataList[4].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[4].fValue ne null}"><input type="text" value="${lblDataList[4].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="40">
                                    <c:if test="${lblDataList[40].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[40].fValue ne null}"><input type="text" value="${lblDataList[40].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T70</td>
                                    <td class="tc">B12</td>
                                    <td class="tc">-T6</td>
                                </tr>
                                <tr>
                                    <td class="tc">06</td>
                                    <td class="tc" id="5">
                                    <c:if test="${lblDataList[5].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[5].fValue ne null}"><input type="text" value="${lblDataList[5].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="41">
                                    <c:if test="${lblDataList[41].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[41].fValue ne null}"><input type="text" value="${lblDataList[41].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T71</td>
                                    <td class="tc">B11</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">07</td>
                                    <td class="tc" id="6">
                                    <c:if test="${lblDataList[6].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[6].fValue ne null}"><input type="text" value="${lblDataList[6].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="42">
                                    <c:if test="${lblDataList[42].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[42].fValue ne null}"><input type="text" value="${lblDataList[42].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T72</td>
                                    <td class="tc">B13</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">08</td>
                                    <td class="tc" id="7">
                                    <c:if test="${lblDataList[7].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[7].fValue ne null}"><input type="text" value="${lblDataList[7].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="43">
                                    <c:if test="${lblDataList[43].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[43].fValue ne null}"><input type="text" value="${lblDataList[43].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T31</td>
                                    <td class="tc">B15</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">09</td>
                                    <td class="tc" id="8">
                                    <c:if test="${lblDataList[8].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[8].fValue ne null}"><input type="text" value="${lblDataList[8].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="44">
                                    <c:if test="${lblDataList[44].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[44].fValue ne null}"><input type="text" value="${lblDataList[44].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T02</td>
                                    <td class="tc">B16</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">10</td>
                                    <td class="tc" id="9">
                                    <c:if test="${lblDataList[9].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[9].fValue ne null}"><input type="text" value="${lblDataList[9].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="45">
                                    <c:if test="${lblDataList[45].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[45].fValue ne null}"><input type="text" value="${lblDataList[45].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T03</td>
                                    <td class="tc">B17</td>
                                    <td class="tc">-T5</td>
                                </tr>
                                <tr>
                                    <td class="tc">11</td>
                                    <td class="tc" id="10">
                                    <c:if test="${lblDataList[10].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[10].fValue ne null}"><input type="text" value="${lblDataList[10].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="46">
                                    <c:if test="${lblDataList[46].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[46].fValue ne null}"><input type="text" value="${lblDataList[46].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T04</td>
                                    <td class="tc">B18</td>
                                    <td class="tc">-T2</td>
                                </tr>
                                <tr>
                                    <td class="tc">12</td>
                                    <td class="tc" id="11">
                                    <c:if test="${lblDataList[11].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[11].fValue ne null}"><input type="text" value="${lblDataList[11].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="47">
                                    <c:if test="${lblDataList[47].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[47].fValue ne null}"><input type="text" value="${lblDataList[47].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T05</td>
                                    <td class="tc">B19</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">13</td>
                                    <td class="tc" id="12">
                                    <c:if test="${lblDataList[12].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[12].fValue ne null}"><input type="text" value="${lblDataList[12].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="48">
                                    <c:if test="${lblDataList[48].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[48].fValue ne null}"><input type="text" value="${lblDataList[48].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T06</td>
                                    <td class="tc">B20</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">14</td>
                                    <td class="tc" id="13">
                                    <c:if test="${lblDataList[13].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[13].fValue ne null}"><input type="text" value="${lblDataList[13].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="49">
                                    <c:if test="${lblDataList[49].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[49].fValue ne null}"><input type="text" value="${lblDataList[49].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">B21</td>
                                    <td class="tc">B38</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">15</td>
                                    <td class="tc" id="14">
                                    <c:if test="${lblDataList[14].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[14].fValue ne null}"><input type="text" value="${lblDataList[14].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="50">
                                    <c:if test="${lblDataList[50].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[50].fValue ne null}"><input type="text" value="${lblDataList[50].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T08</td>
                                    <td class="tc">T61</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">16</td>
                                    <td class="tc" id="15">
                                    <c:if test="${lblDataList[15].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[15].fValue ne null}"><input type="text" value="${lblDataList[15].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="51">
                                    <c:if test="${lblDataList[51].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[51].fValue ne null}"><input type="text" value="${lblDataList[51].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T09</td>
                                    <td class="tc">B22</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">17</td>
                                    <td class="tc" id="16">
                                    <c:if test="${lblDataList[16].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[16].fValue ne null}"><input type="text" value="${lblDataList[16].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="52">
                                    <c:if test="${lblDataList[52].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[52].fValue ne null}"><input type="text" value="${lblDataList[52].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T10</td>
                                    <td class="tc">B24</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">18</td>
                                    <td class="tc" id="17">
                                    <c:if test="${lblDataList[17].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[17].fValue ne null}"><input type="text" value="${lblDataList[17].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="53">
                                    <c:if test="${lblDataList[53].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[53].fValue ne null}"><input type="text" value="${lblDataList[53].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T11</td>
                                    <td class="tc">B23</td>
                                    <td class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col />
                                <col width="140px" />
                                <col width="140px" />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>SLOT #</th>
                                    <th>RTD TEMP</th>
                                    <th>TC TEMP</th>
                                    <th>BAR 1</th>
                                    <th>BAR 2</th>
                                    <th>CON RING</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tc">19</td>
                                    <td class="tc" id="18">
                                    <c:if test="${lblDataList[18].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[18].fValue ne null}"><input type="text" value="${lblDataList[18].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="54">
                                    <c:if test="${lblDataList[54].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[54].fValue ne null}"><input type="text" value="${lblDataList[54].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T12</td>
                                    <td class="tc">B25</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">20</td>
                                    <td class="tc" id="19">
                                    <c:if test="${lblDataList[19].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[19].fValue ne null}"><input type="text" value="${lblDataList[19].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="55">
                                    <c:if test="${lblDataList[55].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[55].fValue ne null}"><input type="text" value="${lblDataList[55].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T43</td>
                                    <td class="tc">B27</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">21</td>
                                    <td class="tc" id="20">
                                    <c:if test="${lblDataList[20].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[20].fValue ne null}"><input type="text" value="${lblDataList[20].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="56">
                                    <c:if test="${lblDataList[56].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[56].fValue ne null}"><input type="text" value="${lblDataList[56].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T14</td>
                                    <td class="tc">B28</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">22</td>
                                    <td class="tc" id="21">
                                    <c:if test="${lblDataList[21].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[21].fValue ne null}"><input type="text" value="${lblDataList[21].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="57">
                                    <c:if test="${lblDataList[57].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[57].fValue ne null}"><input type="text" value="${lblDataList[57].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T15</td>
                                    <td class="tc">B29</td>
                                    <td class="tc">-T6</td>
                                </tr>
                                <tr>
                                    <td class="tc">23</td>
                                    <td class="tc" id="22">
                                    <c:if test="${lblDataList[22].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[22].fValue ne null}"><input type="text" value="${lblDataList[22].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="58">
                                    <c:if test="${lblDataList[58].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[58].fValue ne null}"><input type="text" value="${lblDataList[58].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T16</td>
                                    <td class="tc">B30</td>
                                    <td class="tc">-T3</td>
                                </tr>
                                <tr>
                                    <td class="tc">24</td>
                                    <td class="tc" id="23">
                                    <c:if test="${lblDataList[23].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[23].fValue ne null}"><input type="text" value="${lblDataList[23].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="59">
                                    <c:if test="${lblDataList[59].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[59].fValue ne null}"><input type="text" value="${lblDataList[59].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T17</td>
                                    <td class="tc">B31</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">25</td>
                                    <td class="tc" id="24">
                                    <c:if test="${lblDataList[24].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[24].fValue ne null}"><input type="text" value="${lblDataList[24].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="60">
                                    <c:if test="${lblDataList[60].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[60].fValue ne null}"><input type="text" value="${lblDataList[60].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T18</td>
                                    <td class="tc">B32</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">26</td>
                                    <td class="tc" id="25">
                                    <c:if test="${lblDataList[25].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[25].fValue ne null}"><input type="text" value="${lblDataList[25].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="61">
                                    <c:if test="${lblDataList[61].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[61].fValue ne null}"><input type="text" value="${lblDataList[61].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">B33</td>
                                    <td class="tc">B50</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">27</td>
                                    <td class="tc" id="26">
                                    <c:if test="${lblDataList[26].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[26].fValue ne null}"><input type="text" value="${lblDataList[26].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="62">
                                    <c:if test="${lblDataList[62].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[62].fValue ne null}"><input type="text" value="${lblDataList[62].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T20</td>
                                    <td class="tc">T01</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">28</td>
                                    <td class="tc" id="27">
                                    <c:if test="${lblDataList[27].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[27].fValue ne null}"><input type="text" value="${lblDataList[27].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="63">
                                    <c:if test="${lblDataList[63].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[63].fValue ne null}"><input type="text" value="${lblDataList[63].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T21</td>
                                    <td class="tc">B34</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">29</td>
                                    <td class="tc" id="28">
                                    <c:if test="${lblDataList[28].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[28].fValue ne null}"><input type="text" value="${lblDataList[28].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="64">
                                    <c:if test="${lblDataList[64].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[64].fValue ne null}"><input type="text" value="${lblDataList[64].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T22</td>
                                    <td class="tc">B36</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">30</td>
                                    <td class="tc" id="29">
                                    <c:if test="${lblDataList[29].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[29].fValue ne null}"><input type="text" value="${lblDataList[29].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="65">
                                    <c:if test="${lblDataList[65].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[65].fValue ne null}"><input type="text" value="${lblDataList[65].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T23</td>
                                    <td class="tc">B35</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">31</td>
                                    <td class="tc" id="30">
                                    <c:if test="${lblDataList[30].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[30].fValue ne null}"><input type="text" value="${lblDataList[30].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="66">
                                    <c:if test="${lblDataList[66].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[66].fValue ne null}"><input type="text" value="${lblDataList[66].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T24</td>
                                    <td class="tc">B37</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">32</td>
                                    <td class="tc" id="31">
                                    <c:if test="${lblDataList[31].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[31].fValue ne null}"><input type="text" value="${lblDataList[31].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="67">
                                    <c:if test="${lblDataList[67].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[67].fValue ne null}"><input type="text" value="${lblDataList[67].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T55</td>
                                    <td class="tc">B39</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">33</td>
                                    <td class="tc" id="32">
                                    <c:if test="${lblDataList[32].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[32].fValue ne null}"><input type="text" value="${lblDataList[32].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="68">
                                    <c:if test="${lblDataList[68].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[68].fValue ne null}"><input type="text" value="${lblDataList[68].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T26</td>
                                    <td class="tc">B40</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">34</td>
                                    <td class="tc" id="33">
                                    <c:if test="${lblDataList[33].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[33].fValue ne null}"><input type="text" value="${lblDataList[33].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="69">
                                    <c:if test="${lblDataList[69].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[69].fValue ne null}"><input type="text" value="${lblDataList[69].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T27</td>
                                    <td class="tc">B41</td>
                                    <td class="tc">-T4</td>
                                </tr>
                                <tr>
                                    <td class="tc">35</td>
                                    <td class="tc" id="34">
                                    <c:if test="${lblDataList[34].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[34].fValue ne null}"><input type="text" value="${lblDataList[34].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="70">
                                    <c:if test="${lblDataList[70].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[70].fValue ne null}"><input type="text" value="${lblDataList[70].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T28</td>
                                    <td class="tc">B42</td>
                                    <td class="tc">-T1</td>
                                </tr>
                                <tr>
                                    <td class="tc">36</td>
                                    <td class="tc" id="35">
                                    <c:if test="${lblDataList[35].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[35].fValue ne null}"><input type="text" value="${lblDataList[35].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc" id="71">
                                    <c:if test="${lblDataList[71].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[71].fValue ne null}"><input type="text" value="${lblDataList[71].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T29</td>
                                    <td class="tc">B43</td>
                                    <td class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
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

