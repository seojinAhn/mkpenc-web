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

var lblDataListXAjax = {};
var lblDataListYAjax = {};
var XSearchTimeAjax = '';
var YSearchTimeAjax = '';
var XForeColorAjax = '';
var YForeColorAjax = '';
var timerOn = false;

$(function () {
	
	setTimer(5000);

});

function setTimer(interval) {
	if( interval > 0 ) {
		setTimeout(function run() {
			//if( timerOn ) {
		 		//var	comSubmit	=	new ComSubmit("mainsysiostatusFrm");
				//comSubmit.setUrl("/dcc/performance/mainsysiostatus");
				//comSubmit.submit();
		 		var	comAjax	=	new ComAjax("mainsysiostatusFrm");
		 		comAjax.setUrl("/dcc/performance/reloadMainsysiostatus");
		 		comAjax.setCallback("performanceCallback");
		 		comAjax.ajax();
			//}
			
			setTimeout(run, interval);
		},interval);
	} else {
		setTimeout(function run() {
			//if( timerOn ) {
		 		//var	comSubmit	=	new ComSubmit("mainsysiostatusFrm");
				//comSubmit.setUrl("/dcc/performance/mainsysiostatus");
				//comSubmit.submit();
		 		var	comAjax	=	new ComAjax("mainsysiostatusFrm");
		 		comAjax.setUrl("/dcc/performance/reloadMainsysiostatus");
		 		comAjax.setCallback("performanceCallback");
		 		comAjax.ajax();
			//}
			
			setTimeout(run, 5000);
		},5000);
	}
}

function setLblDate() {
	$("#lblDateX").text(XSearchTimeAjax);
	$("#lblDateX").css("color",XForeColorAjax);
	$("#lblDateY").text(YSearchTimeAjax);
	$("#lblDateY").css("color",YForeColorAjax);
}

function setData() {
	for( var dx=0;dx<lblDataListXAjax.length;dx++ ) {
		var dataX = '';
		var tmpX = lblDataListXAjax[dx].fValue;
		
		dataX = convFormat(tmpX);
		
		$("#lblDataX"+dx).text(dataX);
	}
	
	for( var dy=0;dy<lblDataListYAjax.length;dy++ ) {
		var dataY = '';
		var tmpY = lblDataListYAjax[dy].fValue;

		dataY = convFormat(tmpY);
		
		$("#lblDataY"+dy).text(dataY);
	}
}

function convFormat(data) {
	var tmp = (data*1).toLocaleString()+'';
	return tmp;
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
				<h3>중요 계통 I/O 상태</h3>
				<div class="bc"><span>DCC</span><span>Perfomance</span><strong>중요 계통 I/O 상태</strong></div>
			</div>
			<!-- //page_title -->
			<form id="mainsysiostatusFrm" name="mainsysiostatusFrm">	</form>
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_head -->
                        <div class="form_head">
                            <div class="button">
                                <div class="fx_legend">
                                      <label id="lblDateX" style="color:${XForeColor}">${XSearchTime}</label>
                                </div>
                            </div>
                        </div>
                        <!-- //form_head -->
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col width="60px"/>
                                <col width="160px"/>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">구분</th>
                                    <th>DCCX</th>
                                    <th>DCCY</th>
                                    <th>I/O</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th rowspan="8">MAC<br>Driver<br>DO</th>
                                    <th>CA1 OUT DRIVER</th>
                                    <td class="tc"><label id="lblDataX0"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[0].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY0"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[0].fValue}"/></label></td>
                                    <td class="tc">DO 226B08</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 IN DRIVER</th>
                                    <td class="tc"><label id="lblDataX1"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[1].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY1"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[1].fValue}"/></label></td>
                                    <td class="tc">DO 226B09</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 OUT DRIVER</th>
                                    <td class="tc"><label id="lblDataX2"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[2].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY2"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[2].fValue}"/></label></td>
                                    <td class="tc">DO 226B10</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 IN DRIVER</th>
                                    <td class="tc"><label id="lblDataX3"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[3].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY3"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[3].fValue}"/></label></td>
                                    <td class="tc">DO 226B12</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 OUT DRIVER</th>
                                    <td class="tc"><label id="lblDataX4"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[4].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY4"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[4].fValue}"/></label></td>
                                    <td class="tc">DO 227B08</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 IN DRIVER</th>
                                    <td class="tc"><label id="lblDataX5"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[5].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY5"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[5].fValue}"/></label></td>
                                    <td class="tc">DO 227B09</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 OUT DRIVER</th>
                                    <td class="tc"><label id="lblDataX6"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[6].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY6"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[6].fValue}"/></label></td>
                                    <td class="tc">DO 227B10</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 IN DRIVER</th>
                                    <td class="tc"><label id="lblDataX7"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[7].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY7"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[7].fValue}"/></label></td>
                                    <td class="tc">DO 227B11</td>
                                </tr>
                                <tr>
                                    <th rowspan="4">MAC<br>Driver<br>DO</th>
                                    <th>CA1 Clutch</th>
                                    <td class="tc"><label id="lblDataX8"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[8].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY8"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[8].fValue}"/></label></td>
                                    <td class="tc">DO 230B11</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA2 Clutch</th>
                                    <td class="tc"><label id="lblDataX9"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[9].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY9"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[9].fValue}"/></label></td>
                                    <td class="tc">DO 230B10</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA3 Clutch</th>
                                    <td class="tc"><label id="lblDataX10"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[10].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY10"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[10].fValue}"/></label></td>
                                    <td class="tc">DO 227B09</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA4 Clutch</th>
                                    <td class="tc"><label id="lblDataX11"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[11].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY11"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[11].fValue}"/></label></td>
                                    <td class="tc">DO 230B08</td>
                                </tr>
                                <tr>
                                    <th colspan="2">Self-Back Initiate Alarm</th>
                                    <td class="tc"><label id="lblDataX12"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[12].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY12"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[12].fValue}"/></label></td>
                                    <td class="tc">DO 235B10</td>
                                </tr>
                                <tr>
                                    <th colspan="2">Control Power Fall</th>
                                   	<td class="tc"><label id="lblDataX13"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[13].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY13"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[13].fValue}"/></label></td>
                                    <td class="tc">DO 227B14</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //form_table -->
                    </div>
                    <!-- //form_wrap -->
                </div>
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_head -->
                        <div class="form_head">
                            <div class="button">
                                <div class="fx_legend">
                                      <label id="lblDateY" style="color:${YForeColor}">${YSearchTime}</label>
                                </div>
                            </div>
                        </div>
                        <!-- //form_head -->                        
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col width="60px"/>
                                <col width="160px"/>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">구분</th>
                                    <th>DCCX</th>
                                    <th>DCCY</th>
                                    <th>I/O</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th rowspan="3">SDS #1<br>Trip DI</th>
                                    <th>CH D</th>
                                    <td class="tc"><label id="lblDataX14"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[14].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY14"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[14].fValue}"/></label></td>
                                    <td class="tc">DI 64B06</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH E</th>
                                    <td class="tc"><label id="lblDataX15"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[15].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY15"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[15].fValue}"/></label></td>
                                    <td class="tc">DI 52B07</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH F</th>
                                    <td class="tc"><label id="lblDataX16"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[16].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY16"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[16].fValue}"/></label></td>
                                    <td class="tc">DI 67B04</td>
                                </tr>
                                <tr>
                                    <th rowspan="3">SDS #2<br>Trip DI</th>
                                    <th>CH G</th>
                                    <td class="tc"><label id="lblDataX17"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[17].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY17"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[17].fValue}"/></label></td>
                                    <td class="tc">DI 65B02</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH E</th>
                                    <td class="tc"><label id="lblDataX18"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[18].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY18"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[18].fValue}"/></label></td>
                                    <td class="tc">DI 53B03</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH J</th>
                                    <td class="tc"><label id="lblDataX19"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[19].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY19"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[19].fValue}"/></label></td>
                                    <td class="tc">DI 70B15</td>
                                </tr>
                                <tr>
                                    <th rowspan="3">TBN<br>Trip DI</th>
                                    <th>CH A</th>
                                    <td class="tc"><label id="lblDataX20"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[20].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY20"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[20].fValue}"/></label></td>
                                    <td class="tc">DI 40B13</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH B</th>
                                    <td class="tc"><label id="lblDataX21"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[21].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY21"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[21].fValue}"/></label></td>
                                    <td class="tc">DI 40B14</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH C</th>
                                    <td class="tc"><label id="lblDataX22"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[22].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY22"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[22].fValue}"/></label></td>
                                    <td class="tc">DI 40B15</td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th colspan="2">Power Load Unbalance</th>
                                    <td class="tc"><label id="lblDataX23"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[23].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY23"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[23].fValue}"/></label></td>
                                    <td class="tc">DI 41B00</td>
                                </tr>
                                <tr>
                                    <th colspan="2">Loss of Line</th>
                                    <td class="tc"><label id="lblDataX24"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[24].fValue}"/></label></td>
                                    <td class="tc"><label id="lblDataY24"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[24].fValue}"/></label></td>
                                    <td class="tc">DI 41B01</td>
                                </tr>
                            </tbody>
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
</body>
</html>

