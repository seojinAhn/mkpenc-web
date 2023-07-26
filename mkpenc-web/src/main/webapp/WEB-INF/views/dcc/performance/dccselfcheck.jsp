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
var shpDataXAjax = {};
var shpDataYAjax = {};
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
		 		//var	comSubmit	=	new ComSubmit("dccselfcheckFrm");
				//comSubmit.setUrl("/dcc/performance/dccselfcheck");
				//comSubmit.submit();
		 		var	comAjax	=	new ComAjax("dccselfcheckFrm");
		 		comAjax.setUrl("/dcc/performance/reloadDccselfcheck");
		 		comAjax.setCallback("performanceCallback");
		 		comAjax.ajax();
			//}
			
			setTimeout(run, interval);
		},interval);
	} else {
		setTimeout(function run() {
			//if( timerOn ) {
		 		//var	comSubmit	=	new ComSubmit("dccselfcheckFrm");
				//comSubmit.setUrl("/dcc/performance/dccselfcheck");
				//comSubmit.submit();
		 		var	comAjax	=	new ComAjax("dccselfcheckFrm");
		 		comAjax.setUrl("/dcc/performance/reloadDccselfcheck");
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
		var tmp = lblDataListXAjax[dx].fValue;
		if( dx > 7 && dx < 26 ) {
			dataX = convFormat(tmp);
		} else if( dx > 67 ) {
			dataX = convFormat(tmp);
		} else {
			dataX = tmp;
		}
		
		$("#lblDataX"+dx).text(dataX);
	}
	for( var sx=0;sx<shpDataXAjax.length;sx++ ) {
		$("#shpDataX"+sx).attr("bgColor",shpDataXAjax[sx].BackColor);
	}
	
	for( var dy=0;dy<lblDataListYAjax.length;dy++ ) {
		var dataY = '';
		var tmp = lblDataListYAjax[dy].fValue;
		if( dy > 7 && dy < 26 ) {
			dataY = convFormat(tmp);
		} else if( dy > 67 ) {
			dataY = convFormat(tmp);
		} else {
			dataY = tmp;
		}
		
		$("#lblDataY"+dy).text(dataY);
	}
	for( var sy=0;sy<shpDataYAjax.length;sy++ ) {
		$("#shpDataY"+sy).attr("bgColor",shpDataYAjax[sy].BackColor);
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
				<h3>DCC SELF CHECK</h3>
				<div class="bc"><span>DCC</span><span>Perfomance</span><strong>DCC SELF CHECK</strong></div>
			</div>
			<!-- //page_title -->
			<form id="dccselfcheckFrm" name="dccselfcheckFrm">	</form>
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_head -->
                        <div class="form_head">
                            <h4>DCC X</h4>
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
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>Program Failure</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full"><!-- a href="javascript:openLayer('modal_1')"-->DO 217B14<!-- /a--></label>
                                        <label id="lblDataX0" class="full flex_end">${lblDataXList[0].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>Availability Recorder</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">AI 1365</label>
                                        <label id="lblDataX1" class="full flex_end">${lblDataXList[1].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="tc">A0 - AI Self Check</th>
                            </tr>
                            <tr>
                                <td class="tc">AO 335 / AI 1332</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label id="lblDataX2" class="full flex_end">${lblDataXList[2].fValue}</label>
                                        <label id="lblDataX3" class="full flex_end">${lblDataXList[3].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">AO 342 / AI 2457</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label id="lblDataX4" class="full flex_end">${lblDataXList[4].fValue}</label>
                                        <label id="lblDataX5" class="full flex_end">${lblDataXList[5].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">AO 364 / AI 3077</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label id="lblDataX6" class="full flex_end">${lblDataXList[6].fValue}</label>
                                        <label id="lblDataX7" class="full flex_end">${lblDataXList[7].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
                            <colgroup>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th colspan="3" class="tc">D0 - DI Self Check</th>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 200B08</label>
                                        <label id="lblDataX8" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[8].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 40B00</label>
                                        <label id="lblDataX9" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[9].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 66B15</label>
                                        <label id="lblDataX10" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[10].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 212B13</label>
                                        <label id="lblDataX11" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[11].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 61B01</label>
                                        <label id="lblDataX12" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[12].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 45B05</label>
                                        <label id="lblDataX13" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[13].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 221B09</label>
                                        <label id="lblDataX14" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[14].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 55B15</label>
                                        <label id="lblDataX15" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[15].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 73B11</label>
                                        <label id="lblDataX16" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[16].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 233B14</label>
                                        <label id="lblDataX17" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[17].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 52B10</label>
                                        <label id="lblDataX18" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[18].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 70B14</label>
                                        <label id="lblDataX19" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[19].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 242B10</label>
                                        <label id="lblDataX20" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[20].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 114B12</label>
                                        <label id="lblDataX21" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[21].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 102B02</label>
                                        <label id="lblDataX22" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[22].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 247B12</label>
                                        <label id="lblDataX23" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[23].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 107B07</label>
                                        <label id="lblDataX24" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[24].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 111B13</label>
                                        <label id="lblDataX25" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[25].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
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
                            </colgroup>
                            <tr>
                                <th colspan="9" class="tc">AI Reference Voltage</th>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT01 (-4.9)</th>
                                <th colspan="3" class="stitle tc">POT02 (+4.9)</th>
                                <th colspan="3" class="stitle tc">POT03 (-1.25)</th>
                            </tr>                            
                            <tr>
                                <td id="shpDataX0" class="tc" bgcolor="${shpDataXList[0].BackColor}"><label id="lblDataX26">${lblDataXList[26].fValue}</label></td>
                                <td id="shpDataX1" class="tc" bgcolor="${shpDataXList[1].BackColor}"><label id="lblDataX27">${lblDataXList[27].fValue}</label></td>
                                <td id="shpDataX2" class="tc" bgcolor="${shpDataXList[2].BackColor}"><label id="lblDataX28">${lblDataXList[28].fValue}</label></td>
                                <td id="shpDataX3" class="tc" bgcolor="${shpDataXList[3].BackColor}"><label id="lblDataX29">${lblDataXList[29].fValue}</label></td>
                                <td id="shpDataX4" class="tc" bgcolor="${shpDataXList[4].BackColor}"><label id="lblDataX30">${lblDataXList[30].fValue}</label></td>
                                <td id="shpDataX5" class="tc" bgcolor="${shpDataXList[5].BackColor}"><label id="lblDataX31">${lblDataXList[31].fValue}</label></td>
                                <td id="shpDataX6" class="tc" bgcolor="${shpDataXList[6].BackColor}"><label id="lblDataX32">${lblDataXList[32].fValue}</label></td>
                                <td id="shpDataX7" class="tc" bgcolor="${shpDataXList[7].BackColor}"><label id="lblDataX33">${lblDataXList[33].fValue}</label></td>
                                <td id="shpDataX8" class="tc" bgcolor="${shpDataXList[8].BackColor}"><label id="lblDataX34">${lblDataXList[34].fValue}</label></td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT04 (+1.25)</th>
                                <th colspan="3" class="stitle tc">POT05 (+2.5)</th>
                                <th colspan="3" class="stitle tc">POT06 (-4.9)</th>
                            </tr>                            
                            <tr>
                                <td id="shpDataX9" class="tc" bgcolor="${shpDataXList[9].BackColor}"><label id="lblDataX35">${lblDataXList[35].fValue}</label></td>
                                <td id="shpDataX10" class="tc" bgcolor="${shpDataXList[10].BackColor}"><label id="lblDataX36">${lblDataXList[36].fValue}</label></td>
                                <td id="shpDataX11" class="tc" bgcolor="${shpDataXList[11].BackColor}"><label id="lblDataX37">${lblDataXList[37].fValue}</label></td>
                                <td id="shpDataX12" class="tc" bgcolor="${shpDataXList[12].BackColor}"><label id="lblDataX38">${lblDataXList[38].fValue}</label></td>
                                <td id="shpDataX13" class="tc" bgcolor="${shpDataXList[13].BackColor}"><label id="lblDataX39">${lblDataXList[39].fValue}</label></td>
                                <td id="shpDataX14" class="tc" bgcolor="${shpDataXList[14].BackColor}"><label id="lblDataX40">${lblDataXList[40].fValue}</label></td>
                                <td id="shpDataX15" class="tc" bgcolor="${shpDataXList[15].BackColor}"><label id="lblDataX41">${lblDataXList[41].fValue}</label></td>
                                <td id="shpDataX16" class="tc" bgcolor="${shpDataXList[16].BackColor}"><label id="lblDataX42">${lblDataXList[42].fValue}</label></td>
                                <td id="shpDataX17" class="tc" bgcolor="${shpDataXList[17].BackColor}"><label id="lblDataX43">${lblDataXList[43].fValue}</label></td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT07 (+1.25)</th>
                                <th colspan="3" class="stitle tc">POT08 (+4.9)</th>
                                <th colspan="3" class="stitle tc">POT09 (-0.5)</th>
                            </tr>                            
                            <tr>
                                <td id="shpDataX18" class="tc" bgcolor="${shpDataXList[18].BackColor}"><label id="lblDataX44">${lblDataXList[44].fValue}</label></td>
                                <td id="shpDataX19" class="tc" bgcolor="${shpDataXList[19].BackColor}"><label id="lblDataX45">${lblDataXList[45].fValue}</label></td>
                                <td id="shpDataX20" class="tc" bgcolor="${shpDataXList[20].BackColor}"><label id="lblDataX46">${lblDataXList[46].fValue}</label></td>
                                <td id="shpDataX21" class="tc" bgcolor="${shpDataXList[21].BackColor}"><label id="lblDataX47">${lblDataXList[47].fValue}</label></td>
                                <td id="shpDataX22" class="tc" bgcolor="${shpDataXList[22].BackColor}"><label id="lblDataX48">${lblDataXList[48].fValue}</label></td>
                                <td id="shpDataX23" class="tc" bgcolor="${shpDataXList[23].BackColor}"><label id="lblDataX49">${lblDataXList[49].fValue}</label></td>
                                <td id="shpDataX24" class="tc" bgcolor="${shpDataXList[24].BackColor}"><label id="lblDataX50">${lblDataXList[50].fValue}</label></td>
                                <td id="shpDataX25" class="tc" bgcolor="${shpDataXList[25].BackColor}"><label id="lblDataX51">${lblDataXList[51].fValue}</label></td>
                                <td id="shpDataX26" class="tc" bgcolor="${shpDataXList[26].BackColor}"><label id="lblDataX52">${lblDataXList[52].fValue}</label></td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT10 (+0.5)</th>
                                <th colspan="3" class="stitle tc">POT11 (-4.9)</th>
                                <th colspan="3" class="stitle tc">POT12 (+1.25)</th>
                            </tr>                            
                            <tr>
                                <td id="shpDataX27" class="tc" bgcolor="${shpDataXList[27].BackColor}"><label id="lblDataX53">${lblDataXList[53].fValue}</label></td>
                                <td id="shpDataX28" class="tc" bgcolor="${shpDataXList[28].BackColor}"><label id="lblDataX54">${lblDataXList[54].fValue}</label></td>
                                <td id="shpDataX29" class="tc" bgcolor="${shpDataXList[29].BackColor}"><label id="lblDataX55">${lblDataXList[55].fValue}</label></td>
                                <td id="shpDataX30" class="tc" bgcolor="${shpDataXList[30].BackColor}"><label id="lblDataX56">${lblDataXList[56].fValue}</label></td>
                                <td id="shpDataX31" class="tc" bgcolor="${shpDataXList[31].BackColor}"><label id="lblDataX57">${lblDataXList[57].fValue}</label></td>
                                <td id="shpDataX32" class="tc" bgcolor="${shpDataXList[32].BackColor}"><label id="lblDataX58">${lblDataXList[58].fValue}</label></td>
                                <td id="shpDataX33" class="tc" bgcolor="${shpDataXList[33].BackColor}"><label id="lblDataX59">${lblDataXList[59].fValue}</label></td>
                                <td id="shpDataX34" class="tc" bgcolor="${shpDataXList[34].BackColor}"><label id="lblDataX60">${lblDataXList[60].fValue}</label></td>
                                <td id="shpDataX35" class="tc" bgcolor="${shpDataXList[35].BackColor}"><label id="lblDataX61">${lblDataXList[61].fValue}</label></td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT13 (-1.25)</th>
                                <th colspan="3" class="stitle tc">POT14 (+2.5)</th>
                                <td colspan="3"></td>
                            </tr>                            
                            <tr>
                                <td id="shpDataX36" class="tc" bgcolor="${shpDataXList[36].BackColor}"><label id="lblDataX62">${lblDataXList[62].fValue}</label></td>
                                <td id="shpDataX37" class="tc" bgcolor="${shpDataXList[37].BackColor}"><label id="lblDataX63">${lblDataXList[63].fValue}</label></td>
                                <td id="shpDataX38" class="tc" bgcolor="${shpDataXList[38].BackColor}"><label id="lblDataX64">${lblDataXList[64].fValue}</label></td>
                                <td id="shpDataX39" class="tc" bgcolor="${shpDataXList[39].BackColor}"><label id="lblDataX65">${lblDataXList[65].fValue}</label></td>
                                <td id="shpDataX40" class="tc" bgcolor="${shpDataXList[40].BackColor}"><label id="lblDataX66">${lblDataXList[66].fValue}</label></td>
                                <td id="shpDataX41" class="tc" bgcolor="${shpDataXList[41].BackColor}"><label id="lblDataX67">${lblDataXList[67].fValue}</label></td>
                                <td colspan="3" class="bd_t_none"></td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>C/S Self Check</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 236B14</label>
                                        <label id="lblDataX68" class="full flex_end"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[68].fValue}"/></label>
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
                        <!-- form_head -->
                        <div class="form_head">
                            <h4>DCC Y</h4>
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
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>Program Failure</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 217B14</label>
                                        <label id="lblDataY0" class="full flex_end">${lblDataYList[0].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>Availability Recorder</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">AI 1365</label>
                                        <label id="lblDataY1" class="full flex_end">${lblDataYList[1].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="tc">A0 - AI Self Check</th>
                            </tr>
                            <tr>
                                <td class="tc">A0 335 / AI 1332</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label id="lblDataY2" class="full flex_end">${lblDataYList[2].fValue}</label>
                                        <label id="lblDataY3" class="full flex_end">${lblDataYList[3].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">AO 342 / AI 2457</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label id="lblDataY4" class="full flex_end">${lblDataYList[4].fValue}</label>
                                        <label id="lblDataY5" class="full flex_end">${lblDataYList[5].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">AO 364 / AI 3077</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label id="lblDataY6" class="full flex_end">${lblDataYList[6].fValue}</label>
                                        <label id="lblDataY7" class="full flex_end">${lblDataYList[7].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
                            <colgroup>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th colspan="3" class="tc">D0 - DI Self Check</th>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 200B08</label>
                                        <label id="lblDataY8" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[8].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 40B00</label>
                                        <label id="lblDataY9" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[9].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 66B15</label>
                                        <label id="lblDataY10" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[10].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 212B13</label>
                                        <label id="lblDataY11" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[11].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 61B01</label>
                                        <label id="lblDataY12" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[12].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 45B05</label>
                                        <label id="lblDataY13" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[13].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 221B09</label>
                                        <label id="lblDataY14" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[14].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 55B15</label>
                                        <label id="lblDataY15" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[15].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 73B11</label>
                                        <label id="lblDataY16" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[16].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 233B14</label>
                                        <label id="lblDataY17" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[17].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 52B10</label>
                                        <label id="lblDataY18" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[18].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 70B14</label>
                                        <label id="lblDataY19" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[19].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form" style="display:none">
                                        <label class="full">DO 242B10</label>
                                        <label id="lblDataY20" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[20].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form" style="display:none">
                                        <label class="full">DI 114B12</label>
                                        <label id="lblDataY21" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[21].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form" style="display:none">
                                        <label class="full">DI 102B02</label>
                                        <label id="lblDataY22" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[22].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form" style="display:none">
                                        <label class="full">DO 247B12</label>
                                        <label id="lblDataY23" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[23].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form" style="display:none">
                                        <label class="full">DI 107B07</label>
                                        <label id="lblDataY24" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[24].fValue}"/></label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form" style="display:none">
                                        <label class="full">DI 111B13</label>
                                        <label id="lblDataY25" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[25].fValue}"/></label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
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
                            </colgroup>
                            <tr>
                                <th colspan="9" class="tc">AI Reference Voltage</th>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT01 (-4.9)</th>
                                <th colspan="3" class="stitle tc">POT01 (+4.9)</th>
                                <th colspan="3" class="stitle tc">POT03 (-1.25)</th>
                            </tr>                            
                            <tr>
                                <td id="shpDataY0" class="tc" bgcolor="${shpDataYList[0].BackColor}"><label id="lblDataY26">${lblDataYList[26].fValue}</label></td>
                                <td id="shpDataY1" class="tc" bgcolor="${shpDataYList[1].BackColor}"><label id="lblDataY27">${lblDataYList[27].fValue}</label></td>
                                <td id="shpDataY2" class="tc" bgcolor="${shpDataYList[2].BackColor}"><label id="lblDataY28">${lblDataYList[28].fValue}</label></td>
                                <td id="shpDataY3" class="tc" bgcolor="${shpDataYList[3].BackColor}"><label id="lblDataY29">${lblDataYList[29].fValue}</label></td>
                                <td id="shpDataY4" class="tc" bgcolor="${shpDataYList[4].BackColor}"><label id="lblDataY30">${lblDataYList[30].fValue}</label></td>
                                <td id="shpDataY5" class="tc" bgcolor="${shpDataYList[5].BackColor}"><label id="lblDataY31">${lblDataYList[31].fValue}</label></td>
                                <td id="shpDataY6" class="tc" bgcolor="${shpDataYList[6].BackColor}"><label id="lblDataY32">${lblDataYList[32].fValue}</label></td>
                                <td id="shpDataY7" class="tc" bgcolor="${shpDataYList[7].BackColor}"><label id="lblDataY33">${lblDataYList[33].fValue}</label></td>
                                <td id="shpDataY8" class="tc" bgcolor="${shpDataYList[8].BackColor}"><label id="lblDataY34">${lblDataYList[34].fValue}</label></td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT04 (+1.25)</th>
                                <th colspan="3" class="stitle tc">POT05 (+2.5)</th>
                                <th colspan="3" class="stitle tc">POT06 (-4.9)</th>
                            </tr>                            
                            <tr>
                                <td id="shpDataY9" class="tc" bgcolor="${shpDataYList[9].BackColor}"><label id="lblDataY35">${lblDataYList[35].fValue}</label></td>
                                <td id="shpDataY10" class="tc" bgcolor="${shpDataYList[10].BackColor}"><label id="lblDataY36">${lblDataYList[36].fValue}</label></td>
                                <td id="shpDataY11" class="tc" bgcolor="${shpDataYList[11].BackColor}"><label id="lblDataY37">${lblDataYList[37].fValue}</label></td>
                                <td id="shpDataY12" class="tc" bgcolor="${shpDataYList[12].BackColor}"><label id="lblDataY38">${lblDataYList[38].fValue}</label></td>
                                <td id="shpDataY13" class="tc" bgcolor="${shpDataYList[13].BackColor}"><label id="lblDataY39">${lblDataYList[39].fValue}</label></td>
                                <td id="shpDataY14" class="tc" bgcolor="${shpDataYList[14].BackColor}"><label id="lblDataY40">${lblDataYList[40].fValue}</label></td>
                                <td id="shpDataY15" class="tc" bgcolor="${shpDataYList[15].BackColor}"><label id="lblDataY41">${lblDataYList[41].fValue}</label></td>
                                <td id="shpDataY16" class="tc" bgcolor="${shpDataYList[16].BackColor}"><label id="lblDataY42">${lblDataYList[42].fValue}</label></td>
                                <td id="shpDataY17" class="tc" bgcolor="${shpDataYList[17].BackColor}"><label id="lblDataY43">${lblDataYList[43].fValue}</label></td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT07 (+1.25)</th>
                                <th colspan="3" class="stitle tc">POT08 (+4.9)</th>
                                <th colspan="3" class="stitle tc">POT09 (-0.5)</th>
                            </tr>                            
                            <tr>
                                <td id="shpDataY18" class="tc" bgcolor="${shpDataYList[19].BackColor}"><label id="lblDataY44">${lblDataYList[44].fValue}</label></td>
                                <td id="shpDataY19" class="tc" bgcolor="${shpDataYList[19].BackColor}"><label id="lblDataY45">${lblDataYList[45].fValue}</label></td>
                                <td id="shpDataY20" class="tc" bgcolor="${shpDataYList[20].BackColor}"><label id="lblDataY46">${lblDataYList[46].fValue}</label></td>
                                <td id="shpDataY21" class="tc" bgcolor="${shpDataYList[21].BackColor}"><label id="lblDataY47">${lblDataYList[47].fValue}</label></td>
                                <td id="shpDataY22" class="tc" bgcolor="${shpDataYList[22].BackColor}"><label id="lblDataY48">${lblDataYList[48].fValue}</label></td>
                                <td id="shpDataY23" class="tc" bgcolor="${shpDataYList[23].BackColor}"><label id="lblDataY49">${lblDataYList[49].fValue}</label></td>
                                <td id="shpDataY24" class="tc" bgcolor="${shpDataYList[24].BackColor}"><label id="lblDataY50">${lblDataYList[50].fValue}</label></td>
                                <td id="shpDataY25" class="tc" bgcolor="${shpDataYList[25].BackColor}"><label id="lblDataY51">${lblDataYList[51].fValue}</label></td>
                                <td id="shpDataY26" class="tc" bgcolor="${shpDataYList[26].BackColor}"><label id="lblDataY52">${lblDataYList[52].fValue}</label></td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT10 (+0.5)</th>
                                <th colspan="3" class="stitle tc">PPOT11 (-4.9)</th>
                                <th colspan="3" class="stitle tc">POT12 (+1.25)</th>
                            </tr>                            
                            <tr>
                                <td id="shpDataY27" class="tc" bgcolor="${shpDataYList[27].BackColor}"><label id="lblDataY53">${lblDataYList[53].fValue}</label></td>
                                <td id="shpDataY28" class="tc" bgcolor="${shpDataYList[28].BackColor}"><label id="lblDataY54">${lblDataYList[54].fValue}</label></td>
                                <td id="shpDataY29" class="tc" bgcolor="${shpDataYList[29].BackColor}"><label id="lblDataY55">${lblDataYList[55].fValue}</label></td>
                                <td id="shpDataY30" class="tc" bgcolor="${shpDataYList[30].BackColor}"><label id="lblDataY56">${lblDataYList[56].fValue}</label></td>
                                <td id="shpDataY31" class="tc" bgcolor="${shpDataYList[31].BackColor}"><label id="lblDataY57">${lblDataYList[57].fValue}</label></td>
                                <td id="shpDataY32" class="tc" bgcolor="${shpDataYList[32].BackColor}"><label id="lblDataY58">${lblDataYList[58].fValue}</label></td>
                                <td id="shpDataY33" class="tc" bgcolor="${shpDataYList[33].BackColor}"><label id="lblDataY59">${lblDataYList[59].fValue}</label></td>
                                <td id="shpDataY34" class="tc" bgcolor="${shpDataYList[34].BackColor}"><label id="lblDataY60">${lblDataYList[60].fValue}</label></td>
                                <td id="shpDataY35" class="tc" bgcolor="${shpDataYList[35].BackColor}"><label id="lblDataY61">${lblDataYList[61].fValue}</label></td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT13 (-1.25)</th>
                                <th colspan="3" class="stitle tc">POT14 (+2.5)</th>
                                <td colspan="3"></td>
                            </tr>                            
                            <tr>
                                <td id="shpDataY36" class="tc" bgcolor="${shpDataYList[36].BackColor}"><label id="lblDataY62">${lblDataYList[62].fValue}</label></td>
                                <td id="shpDataY37" class="tc" bgcolor="${shpDataYList[37].BackColor}"><label id="lblDataY63">${lblDataYList[63].fValue}</label></td>
                                <td id="shpDataY38" class="tc" bgcolor="${shpDataYList[38].BackColor}"><label id="lblDataY64">${lblDataYList[64].fValue}</label></td>
                                <td id="shpDataY39" class="tc" bgcolor="${shpDataYList[39].BackColor}"><label id="lblDataY65">${lblDataYList[65].fValue}</label></td>
                                <td id="shpDataY40" class="tc" bgcolor="${shpDataYList[40].BackColor}"><label id="lblDataY66">${lblDataYList[66].fValue}</label></td>
                                <td id="shpDataY41" class="tc" bgcolor="${shpDataYList[41].BackColor}"><label id="lblDataY67">${lblDataYList[67].fValue}</label></td>
                                <td colspan="3" class="bd_t_none"></td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>C/S Self Check</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 236B14</label>
                                        <label id="lblDataY68" class="full flex_end"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[68].fValue}"/></label>
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
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col />
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th colspan="4" class="tc">DCC Available Cross Connection (DCCX ＜ － ＞ DCCY)</th>
                        </tr>
                        <tr>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DO 201B15</label>
                                    <label id="lblDataX69" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[69].fValue}"/></label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DI 52B04</label>
                                    <label id="lblDataY72" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[72].fValue}"/></label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DO 210B15</label>
                                    <label id="lblDataY69" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[69].fValue}"/></label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DI 52B04</label>
                                    <label id="lblDataX72" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[72].fValue}"/></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DO 202B12</label>
                                    <label id="lblDataX70" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[70].fValue}"/></label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DI 63B14</label>
                                    <label id="lblDataY73" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[73].fValue}"/></label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DO 202B12</label>
                                    <label id="lblDataY70" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[70].fValue}"/></label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DI 63B14</label>
                                    <label id="lblDataX73" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[73].fValue}"/></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DO 231B09</label>
                                    <label id="lblDataX71" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[71].fValue}"/></label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DI 66B02</label>
                                    <label id="lblDataY74" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[74].fValue}"/></label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DO 231B09</label>
                                    <label id="lblDataY71" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[71].fValue}"/></label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DI 66B02</label>
                                    <label id="lblDataX74" class="full"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[74].fValue}"/></label>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
            </div>
            <!-- //form_wrap -->
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
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태그정보</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <form id="setIOForm" name="setIOForm">
            <input type ="hidden" id="iSeq" name="iSeq">
            <table class="list_table" id=setVarTable" name="setVarTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>DESCR</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                         <td><input type="text" id="hogi" name="hogi"></td>
                        <td><input type="text" id="xyGubun" name="xyGubun"></td>
                        <td><input type="text" id="descr" name="descr"></td>
                        <td><input type="text" id="ioType" name="ioType"></td>
                        <td><input type="text" id="addresss" name="addresss"></td>
                        <td><input type="text" id="ioBit" name="ioBit"></td>
                    </tr>
                </tbody>
            </table>
            </form>
             <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" onclick="openLayer('modal_2');">Tag Search</a>
				</div>
 				<div class="button">                    
                    <a href="#none" class="btn_page" id="saveVarTable" name="saveVarTable">저장</a>
        			<a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
                </div>
            </div>
            <!-- //list_bottom -->
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->
	</div>
	<!-- pop_contents -->
</div>
<!-- //layer_pop_wrap -->



<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태크목록</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <form id="tagSearchForm" name="tagSearchForm">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>검색어</th>
                    <td>
                        <div class="fx_form">
                          <input type="text" id="findData" name="findData">
                        </div>
                    </td>
                    <td>
	                    <div class="button">
	                    <a class="btn_list" href="#none" id="tagFind" name="tagFind">검색</a>
	                    </div>
                    </td>
                    <th>검색옵션</th>
                    <td>
	                	<div class="fx_form">
                          <input type="checkbox" id="chkOpt1" name="chkOpt1" value="1"> 태그명
                          <input type="checkbox" id="chkOpt2" name="chkOpt2" value="1" checked> 태그설명
                        </div>
                    </td>
                </tr>
            </table>
            </form>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table" id="tagSearchTable" name="tagSearchTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col />
                </colgroup>
                <thead>
                    <tr>
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>LOOG NAME</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>DESCR</th>
                    </tr>
                </thead>
                <tbody id="tagSearchList" name="tagSearchList">
                <tr>
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
             <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" onclick="openLayer('modal_2');">전체리스트</a>
                </div>
                <div class="button">
                     <a href="#none" class="btn_page" id="tagSearchSelect" name="tagSearchSelect">선택</a>
        			 <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
                </div>
            </div>
            <!-- //list_bottom -->
        </div>
        <!-- //list_wrap -->       
	</div>
	<!-- pop_contents -->
</div>
<!-- //layer_pop_wrap -->


</body>
</html>

