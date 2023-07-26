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

var XSearchTimeAjax = '';
var XForeColorAjax = '';
var lblDataXListAjax = {};
var shpDataXListAjax = {};

var YSearchTimeAjax = '';
var YForeColorAjax = '';
var lblDataYListAjax = {};
var shpDataYListAjax = {};

var timerOn = true;

$(function () {
	
	//$("#lblDate").text('${XSearchTime}');
	//$("#lblDate").css('color','${XForeColor}');
	
	setTimer(5000);

});

function setTimer(interval) {
	if( interval > 0 ) {
		setTimeout(function run() {
			if( timerOn ) {
				// 화면초기화
					//var	comSubmit	=	new ComSubmit("programonoffFrm");
				//comSubmit.setUrl("/dcc/performance/programonoff");
				//comSubmit.submit();
				var comAjax = new ComAjax("programonoffFrm");
				comAjax.setUrl('/dcc/performance/reloadProgramonoff');
				//comAjax.addParam("sHogi",hogiHeader);
				//comAjax.addParam("sXYGubun",xyHeader);
				comAjax.setCallback('performanceCallback');
				//comAjax.ajax();
			
				setTimeout(run,interval);
			}
		}, interval);
	} else {
		setTimeout(function run() {
			
			// 화면초기화
				//var	comSubmit	=	new ComSubmit("programonoffFrm");
			//comSubmit.setUrl("/dcc/performance/programonoff");
			//comSubmit.submit();
			var comAjax = new ComAjax("programonoffFrm");
			comAjax.setUrl('/dcc/performance/reloadProgramonoff');
			//comAjax.addParam("sHogi",hogiHeader);
			//comAjax.addParam("sXYGubun",xyHeader);
			comAjax.setCallback('performanceCallback');
			//comAjax.ajax();
			
			setTimeout(run,interval);
		
		}, 5000);
	}
}

function setLblDate() {
	$("#lblDateX").text(XSearchTimeAjax);
	$("#lblDateX").css("color",XForeColorAjax);
	$("#lblDateY").text(YSearchTimeAjax);
	$("#lblDateY").css("color",YForeColorAjax);
}

function setData() {
	for( var i=0;i<lblDataXListAjax.length;i++ ) {
		$("#lblDataX"+i).text(convFormat(lblDataXListAjax[i].fValue));
	}
	
	for( var j=0;j<lblDataYListAjax.length;j++ ) {
		$("#lblDataY"+j).text(convFormat(lblDataYListAjax[j].fValue));
	}
	
	for( var k=0;k<shpDataXListAjax.length;k++ ) {
		$("#shpDataX"+k).css('background',shpDataXListAjax[k]);
	}
	
	for( var l=0;l<shpDataXListAjax.length;l++ ) {
		$("#shpDataY"+l).css('background',shpDataYListAjax[l]);
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
				<h3>PROGRAM ON/OFF</h3>
				<div class="bc"><span>DCC</span><span>Perfomance</span><strong>PROGRAM ON/OFF</strong></div>
			</div>
			<!-- //page_title -->
			<form id="programonoffFrm" name="programonoffFrm">	</form>
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_head -->
                        <div class="form_head">
                        	<div class="button">
                                <div class="fx_legend">
                                </div>
                            </div>
							<div class="button">
                                <div class="fx_legend">
                                </div>
                            </div>
							<div class="button">
                                <div class="fx_legend">
                                   <label id="lblDateX" style="color:${XForeColor}">${XSearchTime}</label>
                                </div>
                            </div>
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
                            <thead>
                                <tr>
                                    <th>H/S No / DI</th>
                                    <th>Programe</th>
                                    <th>DCC X</th>
                                    <th>DCC Y</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-1 / DI 56B00</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX0"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[0].fValue}"/></label>
                                                <label id="lblDataY0"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[0].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>01 STP</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX1"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[1].fValue}"/></label>
                                                <label id="lblDataY1"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[1].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX2"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[2].fValue}"/></label>
                                                <label id="lblDataY2"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[2].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX3"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[3].fValue}"/></label>
                                                <label id="lblDataY3"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[3].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX4"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[4].fValue}"/></label>
                                                <label id="lblDataY4"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[4].fValue}"/></label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX0" style="background:${shpDataXList[0].BackColor}" class="tc">DO 200B15, 232B09, 201B10, 233B08</td>
                                    <td id="shpDataY0" style="background:${shpDataYList[0].BackColor}" class="tc">DO 200B15, 232B09, 201B10, 233B08</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-4 / DI 56B03</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX5"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[5].fValue}"/></label>
                                                <label id="lblDataY5"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[5].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>04 FLOG(DCCX) / FDR(DCCY)</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX1" style="background:${shpDataXList[1].BackColor}" class="tc"></td>
                                    <td id="shpDataY1" style="background:${shpDataYList[1].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-5 / DI 56B04</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX6"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[6].fValue}"/></label>
                                                <label id="lblDataY6"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[6].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>11 RRS</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX7"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[7].fValue}"/></label>
                                                <label id="lblDataY7"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[7].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX8"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[8].fValue}"/></label>
                                                <label id="lblDataY8"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[8].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX9"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[9].fValue}"/></label>
                                                <label id="lblDataY9"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[9].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX10"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[10].fValue}"/></label>
                                                <label id="lblDataY10"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[10].fValue}"/></label>
                                            </div>
                                        </div>
                                    </td>
                                      <td id="shpDataX2" style="background:${shpDataXList[2].BackColor}" class="tc">DO 200B13, 232B14, 201B08, 233B09</td>
                                      <td id="shpDataY2" style="background:${shpDataYList[2].BackColor}" class="tc">DO 200B13, 232B14, 201B08, 233B09</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-6 / DI 56B05</label>
                                            </div>
                                            <div class="fx_form column">
                                               	<label id="lblDataX11"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[11].fValue}"/></label>
                                                <label id="lblDataY11"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[11].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>12 SGL</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX12"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[12].fValue}"/></label>
                                                <label id="lblDataY12"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[12].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX13"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[13].fValue}"/></label>
                                                <label id="lblDataY13"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[13].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX14"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[14].fValue}"/></label>
                                                <label id="lblDataY14"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[14].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX15"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[15].fValue}"/></label>
                                                <label id="lblDataY15"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[15].fValue}"/></label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX3" style="background:${shpDataXList[3].BackColor}" class="tc">DO 201B11, 232B10, 202B08, 233B12</td>
                                    <td id="shpDataY3" style="background:${shpDataYList[3].BackColor}" class="tc">DO 201B11, 232B10, 202B08, 233B12</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-7 / DI 56B06</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX16"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[16].fValue}"/></label>
                                                <label id="lblDataY16"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[16].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>13 HTC</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX17"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[17].fValue}"/></label>
                                                <label id="lblDataY17"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[17].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX18"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[18].fValue}"/></label>
                                                <label id="lblDataY18"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[18].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX19"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[19].fValue}"/></label>
                                                <label id="lblDataY19"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[19].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX20"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[20].fValue}"/></label>
                                                <label id="lblDataY20"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[20].fValue}"/></label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX4" style="background:${shpDataXList[4].BackColor}" class="tc">DO 201B13, 232B12, 202B10, 233B11</td>
                                    <td id="shpDataY4" style="background:${shpDataYList[4].BackColor}" class="tc">DO 201B13, 232B12, 202B10, 233B11</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-8 / DI 56B07</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX21"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[21].fValue}"/></label>
                                                <label id="lblDataY21"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[21].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>14 SGP</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX22"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[22].fValue}"/></label>
                                                <label id="lblDataY22"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[22].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX23"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[23].fValue}"/></label>
                                                <label id="lblDataY23"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[23].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX24"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[24].fValue}"/></label>
                                                <label id="lblDataY24"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[24].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX25"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[25].fValue}"/></label>
                                                <label id="lblDataY25"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[25].fValue}"/></label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX5" style="background:${shpDataXList[5].BackColor}" class="tc">DO 201B12, 232B11, 202B09, 233B13</td>
                                    <td id="shpDataY5" style="background:${shpDataYList[5].BackColor}" class="tc">DO 201B12, 232B11, 202B09, 233B13</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-9 / DI 56B08</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX26"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[26].fValue}"/></label>
                                                <label id="lblDataY26"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[26].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>15 FLX</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX6" style="background:${shpDataXList[6].BackColor}" class=ytumn "tc"></td>
                                    <td id="shpDataY6" style="background:${shpDataYList[6].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-13 / DI 56B12</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX27"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[27].fValue}"/></label>
                                                <label id="lblDataY27"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[27].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>21 MAS</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX7" style="background:${shpDataXList[7].BackColor}" class="tc"></td>
                                    <td id="shpDataY7" style="background:${shpDataYList[7].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-14 / DI 56B13</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX28"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[28].fValue}"/></label>
                                                <label id="lblDataY28"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[28].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>22 AAS</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX8" style="background:${shpDataXList[8].BackColor}" class="tc"></td>
                                    <td id="shpDataY8" style="background:${shpDataYList[8].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-15 / DI 56B14</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX29"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[29].fValue}"/></label>
                                                <label id="lblDataY29"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[29].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>23 CAS</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX9" style="background:${shpDataXList[9].BackColor}" id="shpDataX9" class="tc"></td>
                                    <td id="shpDataY9" style="background:${shpDataYList[9].BackColor}" id="shpDataY9" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-16 / DI 56B15</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX30"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[30].fValue}"/></label>
                                                <label id="lblDataY30"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[30].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>24 MAS1</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX10" style="background:${shpDataXList[8].BackColor}" class="tc"></td>
                                    <td id="shpDataY10" style="background:${shpDataXList[8].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-17 / DI 57B00</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX31"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[31].fValue}"/></label>
                                                <label id="lblDataY31"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[31].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>25 HDS</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX11" style="background:${shpDataXList[11].BackColor}" class="tc"></td>
                                    <td id="shpDataY11" style="background:${shpDataYList[11].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-19 / DI 57B02</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX32"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[32].fValue}"/></label>
                                                <label id="lblDataY32"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[32].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>27 PARC</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX12" style="background:${shpDataXList[12].BackColor}" class="tc"></td>
                                    <td id="shpDataY12" style="background:${shpDataYList[12].BackColor}" class="tc"></td>                                    
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-21 / DI 57B04</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX33"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[33].fValue}"/></label>
                                                <label id="lblDataY33"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[33].fValue}"/></label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>31 EDC</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX13" style="background:${shpDataXList[13].BackColor}" class="tc"></td>
                                    <td id="shpDataY13" style="background:${shpDataXList[13].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-22 / DI 57B05</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX34"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[34].fValue}"/></label>
                                                <label id="lblDataY34"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[34].fValue}"/></label>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>32 MTC</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX35"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[35].fValue}"/></label>
                                                <label id="lblDataY35"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[35].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX36"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[36].fValue}"/></label>
                                                <label id="lblDataY36"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[36].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX37"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[37].fValue}"/></label>
                                                <label id="lblDataY37"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[37].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX38"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[38].fValue}"/></label>
                                                <label id="lblDataY38"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[38].fValue}"/></label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX14" style="background:${shpDataXList[14].BackColor}" class="tc">DO 200B14, 232B08, 201B09, 233B10</td>
                                    <td id="shpDataY14" style="background:${shpDataYList[14].BackColor}" class="tc">DO 200B14, 232B08, 201B09, 233B10</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-23 / DI 57B06</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX39"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[39].fValue}"/></label>
                                                <label id="lblDataY39"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[39].fValue}"/></label>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>33 XEN</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX15" style="background:${shpDataXList[15].BackColor}" class="tc"></td>
                                    <td id="shpDataY15" style="background:${shpDataYList[15].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-24 / DI 57B07</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX40"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[40].fValue}"/></label>                                                
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>34 TPM(DCCX)</label>
                                            </div>
                                             <div class="fx_form column">
                                                 <label id="lblDataY40"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[40].fValue}"/></label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX16" style="background:${shpDataXList[16].BackColor}" class="tc"></td>
                                    <td id="shpDataY16" style="background:${shpDataYList[16].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-25 / DI 57B08</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX41"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[41].fValue}"/></label>
                                                <label id="lblDataY41"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[41].fValue}"/></label>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>35 DUMY(DCCX) / FHSUP(DCCY)</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX17" style="background:${shpDataXList[17].BackColor}" class="tc"></td>
                                    <td id="shpDataY17" style="background:${shpDataYList[17].BackColor}" class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-28 / DI 57B11</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX42"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[42].fValue}"/></label>
                                                <label id="lblDataY42"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[42].fValue}"/></label>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>40 HTT</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX43"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[43].fValue}"/></label>
                                                <label id="lblDataY43"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[43].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                                <label id="lblDataX44"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[44].fValue}"/></label>
                                                <label id="lblDataY44"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[44].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                               	<label id="lblDataX45"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[45].fValue}"/></label>
                                                <label id="lblDataY45"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[45].fValue}"/></label>
                                            </div>
                                            <div class="fx_form column">
                                               <label id="lblDataX46"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataXList[46].fValue}"/></label>
                                               <label id="lblDataY46"><fmt:formatNumber type="number" pattern="###,###" value ="${lblDataYList[46].fValue}"/></label>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="shpDataX18" style="background:${shpDataXList[18].BackColor}" class="tc">DO 203B15, 230B13, 205B13, 231B13</td>
                                    <td id="shpDataY18" style="background:${shpDataYList[18].BackColor}" class="tc">DO 203B15, 230B13, 205B13, 231B13</td>
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

