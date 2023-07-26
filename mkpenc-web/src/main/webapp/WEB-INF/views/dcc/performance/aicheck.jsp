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
<script type="text/javascript">

var timerOn = true; //true로 변경
var hogiHeader = '${UserInfo.hogi}' != "undefined" && '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
var xyHeader = '${UserInfo.xyGubun}' != "undefined" && '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";

var shpDataListAjax = {};
var lblDataListAjax = {};
var lblDateAjax = '';
var lblDateColorAjax = '';

$(function () {

	$("#lblDate").text('${XSearchTime}');
	$("#lblDate").css("color",'${XForeColor}');
	
	setTimer(5000);
});	



function setTimer(interval) {
	
	if( interval > 0 ) {
		setTimeout(function run() {
			if( timerOn ) {
				var comAjax = new ComAjax("aicheckFrm");
				comAjax.setUrl('/dcc/performance/reloadAicheck');
				comAjax.addParam("sHogi",hogiHeader);
				comAjax.addParam("sXYGubun",xyHeader);
				comAjax.setCallback('performanceCallback');
				comAjax.ajax();
			}
			
			setTimeout(run, interval);
		},interval);
	} else {
		var comAjax = new ComAjax("aicheckFrm");
		comAjax.setUrl('/dcc/performance/reloadAicheck');
		comAjax.addParam("sHogi",hogiHeader);
		comAjax.addParam("sXYGubun",xyHeader);
		comAjax.setCallback('performanceCallback');
		comAjax.ajax();
	}
}

function setLblDate() {
	$("#lblDate").text(lblDateAjax);
	$("#lblDate").css("color",lblDateColorAjax);
	$("#lblDateTmp").text(lblDateAjax);
	$("#lblDateTmp").css("color",lblDateColorAjax);
}

function setData() {
	for( var i=0;i<42;i++ ) {
		$("#lblData"+i).text(lblDataListAjax[i].fValue);
		
		if( shpDataListAjax[i].BackColor == '#80FFFF' ) {
			$("#shpData"+i).prop("class","tc cell_color_yellow");
		} else if( shpDataListAjax[i].BackColor == '#8080FF' ) {
			$("#shpData"+i).prop("class","tc cell_color_red");
		} else {
			$("#shpData"+i).prop("class","tc");
		}
	}
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
				<h3>AI CHECK</h3>
				<div class="bc"><span>DCC</span><span>Perfomance</span><strong>AI CHECK</strong></div>
			</div>
			<!-- //page_title -->
			<form id="aicheckFrm" name="aicheckFrm">	</form>
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_head -->
                <div class="form_head">
                    <div class="button">
                         <div class="fx_legend">
                            <label id="lblDateTmp" style="color:${XForeColor}">${XSearchTime}</label>
                         </div>
                     </div>
                </div>
                <!-- //form_head -->
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>S1AB69</th>
                            <th>S1AB76</th>
                            <th>S1AB5</th>
                            <th>S1AB12</th>
                            <th>S1AB19</th>
                            <th>S1AB26</th>
                            <th>S1AB55</th>
                            <th>S1AB62</th>
                            <th>S1AB76</th>
                            <th>S1AB83</th>
                            <th>S1AB12</th>
                            <th>S1AB19</th>
                            <th>S1AB26</th>
                            <th>S1AB33</th>
                            <th>전압(V)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>POT01</th>
                            <c:if test="${shpDataXList[0].BackColor eq '#80FFFF'}">
                            <td id="shpData0" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[0].BackColor eq '#8080FF'}">
                            <td id="shpData0" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[0].BackColor ne '#80FFFF' and shpDataXList[0].BackColor ne '#8080FF'}">
                            <td id="shpData0" class="tc">
                            </c:if>
                                <div class="fx_form column">
                                    <label class="full flex_center blue">452</label>
                                    <label class="full flex_center" id="lblData0">${lblDataXList[0].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[1].BackColor eq '#80FFFF'}">
                            <td id="shpData1" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[1].BackColor eq '#8080FF'}">
                            <td id="shpData1" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[1].BackColor ne '#80FFFF' and shpDataXList[1].BackColor ne '#8080FF'}">
                            <td id="shpData1" class="tc">
                            </c:if>
                                <div class="fx_form column">
                                    <label class="full flex_center blue">2052</label>
                                    <label class="full flex_center" id="lblData1">${lblDataXList[1].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[2].BackColor eq '#80FFFF'}">
                            <td id="shpData2" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[2].BackColor eq '#8080FF'}">
                            <td id="shpData2" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[2].BackColor ne '#80FFFF' and shpDataXList[2].BackColor ne '#8080FF'}">
                            <td id="shpData2" class="tc">
                            </c:if>
                                <div class="fx_form column">
                                    <label class="full flex_center blue">3225</label>
                                    <label class="full flex_center" id="lblData2">${lblDataXList[2].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-4.9</label></th>
                        </tr>
                        <tr>
                            <th>POT02</th>
                            <c:if test="${shpDataXList[3].BackColor eq '#80FFFF'}">
                            <td id="shpData3" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[3].BackColor eq '#8080FF'}">
                            <td id="shpData3" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[3].BackColor ne '#80FFFF' and shpDataXList[0].BackColor ne '#8080FF'}">
                            <td id="shpData3" class="tc">
                            </c:if>
                                <div class="fx_form column">
                                    <label class="full flex_center blue">525</label>
                                    <label class="full flex_center" id="lblData3">${lblDataXList[3].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[4].BackColor eq '#80FFFF'}">
                            <td id="shpData4" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[4].BackColor eq '#8080FF'}">
                            <td id="shpData4" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[4].BackColor ne '#80FFFF' and shpDataXList[4].BackColor ne '#8080FF'}">
                            <td id="shpData4" class="tc">
                            </c:if>
                                <div class="fx_form column">
                                    <label class="full flex_center blue">1552</label>
                                    <label class="full flex_center" id="lblData4">${lblDataXList[4].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[5].BackColor eq '#80FFFF'}">
                            <td id="shpData5" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[5].BackColor eq '#8080FF'}">
                            <td id="shpData5" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[5].BackColor ne '#80FFFF' and shpDataXList[5].BackColor ne '#8080FF'}">
                            <td id="shpData5" class="tc">
                            </c:if>
                                <div class="fx_form column">
                                    <label class="full flex_center blue">3425</label>
                                    <label class="full flex_center" id="lblData5">${lblDataXList[5].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+4.9</label></th>
                        </tr>
                        <tr>
                            <th>POT03</th>
                            <td class="tc"></th>
                            <c:if test="${shpDataXList[6].BackColor eq '#80FFFF'}">
                            <td id="shpData6" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[6].BackColor eq '#8080FF'}">
                            <td id="shpData6" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[6].BackColor ne '#80FFFF' and shpDataXList[6].BackColor ne '#8080FF'}">
                            <td id="shpData6" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">652</label>
                                    <label class="full flex_center" id="lblData6">${lblDataXList[6].fValue}</label>
                                </div>
                            </td>
                            <c:if test="${shpDataXList[7].BackColor eq '#80FFFF'}">
                            <td id="shpData7" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[7].BackColor eq '#8080FF'}">
                            <td id="shpData7" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[7].BackColor ne '#80FFFF' and shpDataXList[7].BackColor ne '#8080FF'}">
                            <td id="shpData7" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1152</label>
                                    <label class="full flex_center" id="lblData7">${lblDataXList[7].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[8].BackColor eq '#80FFFF'}">
                            <td id="shpData8" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[8].BackColor eq '#8080FF'}">
                            <td id="shpData8" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[8].BackColor ne '#80FFFF' and shpDataXList[8].BackColor ne '#8080FF'}">
                            <td id="shpData8" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2752</label>
                                    <label class="full flex_center" id="lblData8">${lblDataXList[8].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT04</th>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[9].BackColor eq '#80FFFF'}">
                            <td id="shpData9" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[9].BackColor eq '#8080FF'}">
                            <td id="shpData9" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[9].BackColor ne '#80FFFF' and shpDataXList[9].BackColor ne '#8080FF'}">
                            <td id="shpData9" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">752</label>
                                    <label class="full flex_center" id="lblData9">${lblDataXList[9].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[10].BackColor eq '#80FFFF'}">
                            <td id="shpData10" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[10].BackColor eq '#8080FF'}">
                            <td id="shpData10" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[10].BackColor ne '#80FFFF' and shpDataXList[10].BackColor ne '#8080FF'}">
                            <td id="shpData10" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1424</label>
                                    <label class="full flex_center" id="lblData10">${lblDataXList[10].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[11].BackColor eq '#80FFFF'}">
                            <td id="shpData11" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[11].BackColor eq '#8080FF'}">
                            <td id="shpData11" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[11].BackColor ne '#80FFFF' and shpDataXList[11].BackColor ne '#8080FF'}">
                            <td id="shpData11" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2352</label>
                                    <label class="full flex_center" id="lblData11">${lblDataXList[11].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT05</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[12].BackColor eq '#80FFFF'}">
                            <td id="shpData12" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[12].BackColor eq '#8080FF'}">
                            <td id="shpData12" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[12].BackColor ne '#80FFFF' and shpDataXList[12].BackColor ne '#8080FF'}">
                            <td id="shpData12" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1025</label>
                                    <label class="full flex_center" id="lblData12">${lblDataXList[12].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[13].BackColor eq '#80FFFF'}">
                            <td id="shpData13" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[13].BackColor eq '#8080FF'}">
                            <td id="shpData13" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[13].BackColor ne '#80FFFF' and shpDataXList[13].BackColor ne '#8080FF'}">
                            <td id="shpData13" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2400</label>
                                    <label class="full flex_center" id="lblData13">${lblDataXList[13].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[14].BackColor eq '#80FFFF'}">
                            <td id="shpData14" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[14].BackColor eq '#8080FF'}">
                            <td id="shpData14" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[14].BackColor ne '#80FFFF' and shpDataXList[14].BackColor ne '#8080FF'}">
                            <td id="shpData14" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3107</label>
                                    <label class="full flex_center" id="lblData14">${lblDataXList[14].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+2.5</label></td>
                        </tr>
                        <tr>
                            <th>POT06</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[15].BackColor eq '#80FFFF'}">
                            <td id="shpData15" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[15].BackColor eq '#8080FF'}">
                            <td id="shpData15" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[15].BackColor ne '#80FFFF' and shpDataXList[15].BackColor ne '#8080FF'}">
                            <td id="shpData15" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1205</label>
                                    <label class="full flex_center" id="lblData15">${lblDataXList[15].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[16].BackColor eq '#80FFFF'}">
                            <td id="shpData16" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[16].BackColor eq '#8080FF'}">
                            <td id="shpData16" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[16].BackColor ne '#80FFFF' and shpDataXList[16].BackColor ne '#8080FF'}">
                            <td id="shpData16" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2425</label>
                                    <label class="full flex_center" id="lblData16">${lblDataXList[16].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[17].BackColor eq '#80FFFF'}">
                            <td id="shpData17" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[17].BackColor eq '#8080FF'}">
                            <td id="shpData17" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[17].BackColor ne '#80FFFF' and shpDataXList[17].BackColor ne '#8080FF'}">
                            <td id="shpData17" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3025</label>
                                    <label class="full flex_center" id="lblData17">${lblDataXList[17].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-4.9</label></td>
                        </tr>
                        <tr>
                            <th>POT07</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[18].BackColor eq '#80FFFF'}">
                            <td id="shpData18" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[18].BackColor eq '#8080FF'}">
                            <td id="shpData18" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[18].BackColor ne '#80FFFF' and shpDataXList[18].BackColor ne '#8080FF'}">
                            <td id="shpData18" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1300</label>
                                    <label class="full flex_center" id="lblData18">${lblDataXList[18].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[19].BackColor eq '#80FFFF'}">
                            <td id="shpData19" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[19].BackColor eq '#8080FF'}">
                            <td id="shpData19" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[19].BackColor ne '#80FFFF' and shpDataXList[19].BackColor ne '#8080FF'}">
                            <td id="shpData19" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2525</label>
                                    <label class="full flex_center" id="lblData19">${lblDataXList[19].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[20].BackColor eq '#80FFFF'}">
                            <td id="shpData20" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[20].BackColor eq '#8080FF'}">
                            <td id="shpData20" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[20].BackColor ne '#80FFFF' and shpDataXList[20].BackColor ne '#8080FF'}">
                            <td id="shpData20" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3125</label>
                                    <label class="full flex_center" id="lblData20">${lblDataXList[20].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT08</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[21].BackColor eq '#80FFFF'}">
                            <td id="shpData21" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[21].BackColor eq '#8080FF'}">
                            <td id="shpData21" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[21].BackColor ne '#80FFFF' and shpDataXList[21].BackColor ne '#8080FF'}">
                            <td id="shpData21" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1225</label>
                                    <label class="full flex_center" id="lblData21">${lblDataXList[21].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[22].BackColor eq '#80FFFF'}">
                            <td id="shpData22" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[22].BackColor eq '#8080FF'}">
                            <td id="shpData22" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[22].BackColor ne '#80FFFF' and shpDataXList[22].BackColor ne '#8080FF'}">
                            <td id="shpData22" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2625</label>
                                    <label class="full flex_center" id="lblData22">${lblDataXList[22].fValue}</label>
                                </div>
                            </td>
                            <c:if test="${shpDataXList[23].BackColor eq '#80FFFF'}">
                            <td id="shpData23" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[23].BackColor eq '#8080FF'}">
                            <td id="shpData23" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[23].BackColor ne '#80FFFF' and shpDataXList[23].BackColor ne '#8080FF'}">
                            <td id="shpData23" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3052</label>
                                    <label class="full flex_center" id="lblData23">${lblDataXList[23].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+4.9</label></td>
                        </tr>
                        <tr>
                            <th>POT09</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[24].BackColor eq '#80FFFF'}">
                            <td id="shpData24" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[24].BackColor eq '#8080FF'}">
                            <td id="shpData24" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[24].BackColor ne '#80FFFF' and shpDataXList[24].BackColor ne '#8080FF'}">
                            <td id="shpData24" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1252</label>
                                    <label class="full flex_center" id="lblData24">${lblDataXList[24].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[25].BackColor eq '#80FFFF'}">
                            <td id="shpData25" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[25].BackColor eq '#8080FF'}">
                            <td id="shpData25" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[25].BackColor ne '#80FFFF' and shpDataXList[25].BackColor ne '#8080FF'}">
                            <td id="shpData25" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2477</label>
                                    <label class="full flex_center" id="lblData25">${lblDataXList[25].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[26].BackColor eq '#80FFFF'}">
                            <td id="shpData26" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[26].BackColor eq '#8080FF'}">
                            <td id="shpData26" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[26].BackColor ne '#80FFFF' and shpDataXList[26].BackColor ne '#8080FF'}">
                            <td id="shpData26" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3152</label>
                                    <label class="full flex_center" id="lblData26">${lblDataXList[26].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-0.5</label></td>
                        </tr>
                        <tr>
                            <th>POT10</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[27].BackColor eq '#80FFFF'}">
                            <td id="shpData27" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[27].BackColor eq '#8080FF'}">
                            <td id="shpData27" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[27].BackColor ne '#80FFFF' and shpDataXList[27].BackColor ne '#8080FF'}">
                            <td id="shpData27" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1325</label>
                                    <label class="full flex_center" id="lblData27">${lblDataXList[27].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[28].BackColor eq '#80FFFF'}">
                            <td id="shpData28" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[28].BackColor eq '#8080FF'}">
                            <td id="shpData28" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[28].BackColor ne '#80FFFF' and shpDataXList[28].BackColor ne '#8080FF'}">
                            <td id="shpData28" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2552</label>
                                    <label class="full flex_center" id="lblData28">${lblDataXList[28].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[29].BackColor eq '#80FFFF'}">
                            <td id="shpData29" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[29].BackColor eq '#8080FF'}">
                            <td id="shpData29" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[29].BackColor ne '#80FFFF' and shpDataXList[29].BackColor ne '#8080FF'}">
                            <td id="shpData29" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3070</label>
                                    <label class="full flex_center" id="lblData29">${lblDataXList[29].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+0.5</label></td>
                        </tr>
                        <tr>
                            <th>POT11</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[30].BackColor eq '#80FFFF'}">
                            <td id="shpData30" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[30].BackColor eq '#8080FF'}">
                            <td id="shpData30" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[30].BackColor ne '#80FFFF' and shpDataXList[30].BackColor ne '#8080FF'}">
                            <td id="shpData30" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1377</label>
                                    <label class="full flex_center" id="lblData30">${lblDataXList[30].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[31].BackColor eq '#80FFFF'}">
                            <td id="shpData31" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[31].BackColor eq '#8080FF'}">
                            <td id="shpData31" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[31].BackColor ne '#80FFFF' and shpDataXList[31].BackColor ne '#8080FF'}">
                            <td id="shpData31" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2570</label>
                                    <label class="full flex_center" id="lblData31">${lblDataXList[31].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[32].BackColor eq '#80FFFF'}">
                            <td id="shpData32" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[32].BackColor eq '#8080FF'}">
                            <td id="shpData32" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[32].BackColor ne '#80FFFF' and shpDataXList[32].BackColor ne '#8080FF'}">
                            <td id="shpData32" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3352</label>
                                    <label class="full flex_center" id="lblData32">${lblDataXList[32].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-4.9</label></td>
                        </tr>
                        <tr>
                            <th>POT12</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[33].BackColor eq '#80FFFF'}">
                            <td id="shpData33" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[33].BackColor eq '#8080FF'}">
                            <td id="shpData33" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[33].BackColor ne '#80FFFF' and shpDataXList[33].BackColor ne '#8080FF'}">
                            <td id="shpData33" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1625</label>
                                    <label class="full flex_center" id="lblData33">${lblDataXList[33].fValue}</label>
                                </div>
                            </td>
                            <c:if test="${shpDataXList[34].BackColor eq '#80FFFF'}">
                            <td id="shpData34" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[34].BackColor eq '#8080FF'}">
                            <td id="shpData34" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[34].BackColor ne '#80FFFF' and shpDataXList[34].BackColor ne '#8080FF'}">
                            <td id="shpData34" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2152</label>
                                    <label class="full flex_center" id="lblData34">${lblDataXList[34].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[35].BackColor eq '#80FFFF'}">
                            <td id="shpData35" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[35].BackColor eq '#8080FF'}">
                            <td id="shpData35" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[35].BackColor ne '#80FFFF' and shpDataXList[35].BackColor ne '#8080FF'}">
                            <td id="shpData35" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3552</label>
                                    <label class="full flex_center" id="lblData35">${lblDataXList[35].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT13</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[36].BackColor eq '#80FFFF'}">
                            <td id="shpData36" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[36].BackColor eq '#8080FF'}">
                            <td id="shpData36" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[36].BackColor ne '#80FFFF' and shpDataXList[36].BackColor ne '#8080FF'}">
                            <td id="shpData36" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1752</label>
                                    <label class="full flex_center" id="lblData36">${lblDataXList[36].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[37].BackColor eq '#80FFFF'}">
                            <td id="shpData37" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[37].BackColor eq '#8080FF'}">
                            <td id="shpData37" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[37].BackColor ne '#80FFFF' and shpDataXList[37].BackColor ne '#8080FF'}">
                            <td id="shpData37" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2225</label>
                                    <label class="full flex_center" id="lblData37">${lblDataXList[37].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[38].BackColor eq '#80FFFF'}">
                            <td id="shpData38" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[38].BackColor eq '#8080FF'}">
                            <td id="shpData38" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[38].BackColor ne '#80FFFF' and shpDataXList[38].BackColor ne '#8080FF'}">
                            <td id="shpData38" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3625</label>
                                    <label class="full flex_center" id="lblData38">${lblDataXList[38].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"><label class="fs_double">-1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT14</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[39].BackColor eq '#80FFFF'}">
                            <td id="shpData39" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[39].BackColor eq '#8080FF'}">
                            <td id="shpData39" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[39].BackColor ne '#80FFFF' and shpDataXList[39].BackColor ne '#8080FF'}">
                            <td id="shpData39" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1177</label>
                                    <label class="full flex_center" id="lblData39">${lblDataXList[39].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[40].BackColor eq '#80FFFF'}">
                            <td id="shpData40" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[40].BackColor eq '#8080FF'}">
                            <td id="shpData40" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[40].BackColor ne '#80FFFF' and shpDataXList[40].BackColor ne '#8080FF'}">
                            <td id="shpData40" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2637</label>
                                    <label class="full flex_center" id="lblData40">${lblDataXList[40].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <c:if test="${shpDataXList[41].BackColor eq '#80FFFF'}">
                            <td id="shpData41" class="tc cell_color_yellow">
                            </c:if>
                            <c:if test="${shpDataXList[41].BackColor eq '#8080FF'}">
                            <td id="shpData41" class="tc cell_color_red">
                            </c:if>
                            <c:if test="${shpDataXList[41].BackColor ne '#80FFFF' and shpDataXList[41].BackColor ne '#8080FF'}">
                            <td id="shpData41" class="tc">
                            </c:if>
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3752</label>
                                    <label class="full flex_center" id="lblData41">${lblDataXList[41].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"><label class="fs_double">+2.5</label></td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
            </div>
            <!-- //form_wrap -->
            <div class="form_info">
				<div class="fx_legend txt_type">
					<label>※ 접압과 편차가 ± 4~5mV 차이 발생 시 해당 쉘 황색, 5mV 발생 시 적색, AI Adress 아래에 현재 값 표시</label>
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
</body>
</html>

