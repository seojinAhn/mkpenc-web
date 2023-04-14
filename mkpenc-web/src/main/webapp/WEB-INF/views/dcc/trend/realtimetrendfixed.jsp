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
<script type="text/javascript" src="<c:url value="/resources/js/trend.js" />" charset="utf-8"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/datetimepicker/jquery.datetimepicker.css" />">
<script type="text/javascript" src="<c:url value="/resources/datetimepicker/jquery.datetimepicker.full.min.js" />" charset="utf-8"></script>

<link rel="stylesheet" href="/resources/sbchart/sbchart.css">
<script type="text/javascript" src="/resources/sbchart/sbchart.js"></script>

<script type="text/javascript">
	var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
	var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";
	var currentSelGrp = "";
	var grpNos = [];
	var selGrpNm = "";
	
	var chart;

	$(function() {
		//createChart();
		//var iid=0;
		//var str = '${DccGroupList[0]}';
		//var ss = str.replace(/{/gi,'').replace(/}/gi,'').split(', ');
		//for( var dd=0;dd<ss.length;dd++ ) {
		//	console.log(ss[dd].split("=")[1]);
		//}
		
		if( '${BaseSearch.gHis}' == 'H' ) {
			$("input:radio[id='H']").prop("checked",true);
			cmdHistorical_click();
		} else {
			$("input:radio[id='R']").prop("checked",true);
			cmdReal_click();
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
		
		currentSelGrp = $("#cboUGrpName option:selected").val();
		
		var grpList = '${DccGroupList}'.split(', groupNo=');
		for( var i=1;i<grpList.length;i++ ) {
			grpNos.push('opt'+grpList[i].substr(0,grpList[i].indexOf('}')));
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
		
		$(document.body).delegate('#chkUseGap', 'click', function() {
			chkUseGap_click($("input:checkbox[id='chkUseGap']").is(":checked"));
		});
		
		$(document.body).delegate('#R', 'click', function() {
			cmdReal_click();
		});
		
		$(document.body).delegate('#H', 'click', function() {
			cmdHistorical_click();
		});
		
		$(document.body).delegate('#3', 'click', function() {
			var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '3';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#4', 'click', function() {
			var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '4';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#X', 'click', function() {
			var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'X';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#Y', 'click', function() {
			var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'Y';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).on("change", "#cboUGrpName", function() {
			var selGrpName = $("#cboUGrpName option:selected").val();
			
			var startDate = "";
			var endDate = "";
			if( $("#selectSDate").val() != null && typeof $("#selectSDate").val() != 'undefined' ) {
				startDate = $("#selectSDate").val()+':00.000';
				endDate = $("#selectEDate").val()+':00.000';
			}
			
			var comAjax = new ComAjax("selGrpFrm");
			comAjax.setUrl("/dcc/trend/changeGrpName");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("startDate", startDate);
			comAjax.addParam("endDate", endDate);
			comAjax.addParam('sUGrpNo',selGrpName);
			comAjax.setCallback("mbr_RuntimerEventCallback");
			comAjax.ajax();
			
			createChart($("#testArea").text());
		});
	});
	
	function cmdHistorical_click() {
		$("#cmdHistorical").css("display","none");
		$("#cmdReal").css("display","");
		$("#divUseGap").css("display","");
		$("#searchDate").css("display","");
		$("#txtTimeGap").attr("disabled",true);
	}
	
	function cmdReal_click() {
		$("#cmdHistorical").css("display","");
		$("#cmdReal").css("display","none");
		$("#divUseGap").css("display","none");
		$("#searchDate").css("display","none");
		$("#txtTimeGap").attr("disabled",false);
	}
	
	function DatetimepickerDefaults(opts) {
	    return $.extend({},{
	    format:'Y-m-d H:i:00',
		formatTime:'H:i:00',
	    formatDate:'Y-m-d',
		step : 1,
		monthChangeSpinner:true,
	    sideBySide: true
	    
	    }, opts);
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
	
	function chkUseGap_click(type) {
		if( type == true ) {
			$("#txtTimeGap").attr("disabled",false);
			$("#selectSDate").attr("disabled",true);
		} else {
			$("#txtTimeGap").attr("disabled",true);
			$("#selectSDate").attr("disabled",false);
		}
	}

	function createChart(data){
		console.log(data);
		var xValues = data.split("},{");
		var str0 = xValues[0];
		var strLast = xValues[xValues.length-1];
		
		str0 = str0.substring(1,str0.length);
		strLast = strLast.substring(0,strLast.length-1);
		
		xValues.splice(0,1,str0);
		xValues.splice(xValues.length-1,1,strLast);

		var xData = [];
		var xAxis = [];
		for( var j=0;j<xValues.length;j++ ) {
			var xJson = xValues[j].split(', ');
			//xJson.splice(0,1);
			
			//xData = [
			//	{name:xJson[0], [xJson[1].split('=')[0]]:(xJson[1].split('=')[1])*1}
			//];
			//for( var d=1;d<xJson.length;d++ ) {
					//var key = xJson[d].split('=')[0];
					//var value = (xJson[d].split('=')[1])*1;
					xData.push({name:xJson[0], [xJson[1].split('=')[0]]:(xJson[1].split('=')[1])*1, [xJson[2].split('=')[0]]:(xJson[2].split('=')[1])*1, [xJson[3].split('=')[0]]:(xJson[3].split('=')[1])*1, [xJson[4].split('=')[0]]:(xJson[4].split('=')[1])*1});
					//xData.push({[key]:value});
			if( j == 0 ) {		
				for( var d=1;d<xJson.length;d++ ) {
					xAxis.push(xJson[d].split('=')[0]);
				}
			}
			//}
		}
		
		console.log(xData);
		console.log(xAxis);
		
		var chartConfig = {
			global: {
				svg: {
					classname: 'customClass' // í´ë¹ ì°¨í¸ì svg  íê·¸ì ì»¤ì¤í í´ëì¤ ì¤ì 
				},
				size: {
					width: 840,
					height: 600
				}
			},
			data: {
				type: 'line', // ì°¨í¸ì íìì ì¤ì 
				json: xData, // json ííë¡ ë°ì´í° ì¤ì íë©°, chartDataë¼ë ë³ìì ë°ì´í°ë¥¼ ê°ì ¸ìì ê·¸ë ¤ì¤
				keys: { // json ííì ë°ì´í°ë¥¼ ì¬ì© ì, íìë¡ keys ìì±ì ì¬ì©í´ì¼ í¨
					x: "name", // ê°ê°ì xì¶ ì´ë¦ì chartDataì nameê°ì¼ë¡ ì¤ì 
					value: xAxis // chartDataì 2015, 2016, 2017 ë°ì´í°ë¥¼ ë³´ì¬ì£¼ëë¡ ì¤ì 
				}
			},
			extend: {
				bar: {
					topRadius: 15
				}
			}
		};
		chart = new sb.chart("#chartArea", chartConfig) // ì²«ë²ì§¸ íë¼ë¯¸í°ë div ìì­ì id, ëë²ì§¸ íë¼ë¯¸í°ë ììì ì¤ì í chart config ê°ì²´ëª ê¸°ì
		chart.render(); // render ë©ìëë¥¼ ì¬ì©í´ì¼ ì°¨í¸ê° ê·¸ë ¤ì§ (ëì ì¼ë¡ ì¬ì© ììë ë§ì§ë§ì ê¼­ render()ë¥¼ ì¨ì¤ì¼ ë³ê²½í ê°ë¤ì´ ë°ìëì´ ë³´ì¬ì§ëë¤.)
	}

	var chartData = [
		{name: 'ìì¸', 2015: 10, 2016: 20, 2017: 30},
		{name: 'ê²½ê¸°', 2015: 30, 2016: 10, 2017: 20},
		{name: 'ì¸ì²', 2015: 20, 2016: 30, 2017: 10},
	]
	
	function loadTrendDataArray(data) {
		var arrTrendData = data;
		
		console.log('trend data :: '+arrTrendData);
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
				<h3>REALTIME TREND</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>REALTIME TREND</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<form id="selGrpFrm" type="hidden"></form>
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
                            <label>구분</label>
                            <div class="fx_form">
							    <label>
                                    <input id="R" value="R" type="radio" name="type">
                                    실시간
                                </label>
							    <label>
                                    <input id="H" value="H" type="radio" name="type">
                                    과거검색
                                </label>
                            </div>
						</div>
						<div class="fx_srch_item">
				    		<label id="divUseGap" style="display:none">
                                <input id="chkUseGap" type="checkbox" name="type">
                                &nbsp;주기설정
                            </label>
							<label>주기</label>
							<div class="class="fx_form">
							<label>
                            	<input id="txtTimeGap" type="text" value="5">
                            	<font style="padding-top:5px;">&nbsp;초</font>
                            </label>
                            </div>
						</div>
						<div id="searchDate" class="fx_srch_item" style="display:none">
							<label>검색기간</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id="selectSDate" name="selectSDate" readonly>
                                	<label>~</label>
                                    <input type="text" id="selectEDate" name="selectEDate" readonly>
                                </div>
                            </div>
						</div>
						<div class="fx_srch_item"></div>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a id="cmdReal" href="#none" onclick="javascript:cmdReal_click();" class="btn_srch">Search</a>
					<a id="cmdHistorical" href="#none" onclick="javascript:cmdHistorical_click();" class="btn_srch" style="display:none">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap b_type">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item no_label">	
                            <div class="fx_form">
                                <select id="cboUGrpName">
                                <c:forEach var="grpInfo" items="${DccGroupList}">
                                	<option id="opt${grpInfo.groupNo}" value="${grpInfo.groupNo}">${grpInfo.groupName}</option>
                                </c:forEach>
                                <a href="#none" class="btn_list">새창으로</a>
                                <a href="#none" class="btn_list">Range 저장</a>
                                <label>
                                    <input id="chkCross" type="checkbox">
                                    십자선
                                </label>
                            </div>
						</div>
						<div class="fx_srch_item"></div>
					</div>
					<div class="fx_srch_row" id="lblBody1">
						<div class="fx_srch_item line">
                            <div class="fx_form" style="color:#F1881A"><!-- color : #801517 -->
                                <input id="lblCheckbox0" type="checkbox" checked>
                                <span><label id="lblTagName0">3X MOD. TEMP</label></span>
                                <span><label id="lblValue0">68.74</label></span>
                                <span><label id="lblUnit0">DEG C</label></span>
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form" style="color:#F2772A"><!-- color : #B9529F -->
                                <input id="lblCheckbox1" type="checkbox" checked>
                                <span><label id="lblTagName1">3X MOD. TEMP</label></span>
                                <span><label id="lblValue1">68.74</label></span>
                                <span><label id="lblUnit1">DEG C</label></span>
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form" style="color:#F3663A"><!-- color : #1EBCBE -->
                                <input id="lblCheckbox2" type="checkbox" checked>
                                <span><label id="lblTagName2">3X MOD. TEMP</label></span>
                                <span><label id="lblValue2">68.74</label></span>
                                <span><label id="lblUnit2">DEG C</label></span>
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form" style="color:#F4554A"><!-- color : #282A73 -->
                                <input id="lblCheckbox3" type="checkbox" checked>
                                <span><label id="lblTagName3">3X MOD. TEMP</label></span>
                                <span><label id="lblValue3">68.74</label></span>
                                <span><label id="lblUnit3">DEG C</label></span>
                            </div>
						</div>
					</div>
					<div class="fx_srch_row" id="lblBody2">
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_5" style="display:none"><!-- color : #ED1E24 -->
                            </div>
                        </div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_6" style="display:none"><!-- color : #7A57A4 -->
                            </div>
                        </div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_7" style="display:none"><!-- color : #70CBD1 -->
                            </div>
                        </div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_8" style="display:none"><!-- color : #364CA0 -->
                            </div>
                        </div>
					</div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->         
			<!-- chart_wrap_area -->
			<div class="chart_wrap_area" id="chartArea">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_1');">변수설정</a></li>
                        <li><a href="#none" onclick="openLayer('modal_2');">엑셀로 저장</a></li>
                    </ul>
                    <ul>
                        <li class="check active"><a href="#none">X축 격자</a></li>
                        <li class="check active"><a href="#none">Y축 격자</a></li>
                        <li class="check"><a href="#none">선 굵게</a></li>
                    </ul>
                    <ul>
                        <li><a href="#none">그래프 인쇄</a></li>
                        <li><a href="#none">그래프 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                
                차트영역 (최종본 라인 제거)
            </div>
            <input id="testArea" type="hidden"></input>
            <!-- //chart_wrap_area -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<script type="text/javascript" src="<c:url value="/resources/js/footer.js" />" charset="utf-8"></script>
	<!-- //footer -->
</div>
<!--  //wrap  -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>변수설정</h3>
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
                    <th>Title</th>
                    <td>
                        <div class="fx_form">
                            <input type="text">
                            <a class="btn_list" herf="none">그룹추가</a>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <select>
                                <option>3</option>
                            </select>
                        </td>
                        <td>
                            <select>
                                <option>X</option>
                            </select>
                        </td>
                        <td><input type="text"></td>
                        <td>
                            <select>
                                <option>AI</option>
                            </select>
                        </td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td class="tc"><input type="checkbox"></td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
            <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none">Tag Search</a>
                </div>
                <div class="button">
                    <a class="btn_list" href="#none">추가</a>
                    <a class="btn_list" href="#none">수정</a>
                    <a class="btn_list" href="#none">삭제</a>
                    <a class="btn_list" href="#none">위</a>
                    <a class="btn_list" href="#none">아래</a>
                </div>
            </div>
            <!-- //list_bottom -->
        </div>
        <!-- //list_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>엑셀로 저장</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">

        <!-- fx_layout -->
        <div class="fx_layout"> 
            <div class="fx_block">        
                <!-- form_wrap -->
                <div class="form_wrap">
                    <div class="form_head">
                        <h4>저장일자</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col width="120px"/>
                            <col />
                        </colgroup>
                        <tr>
                            <th>시작 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>끝 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
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
                    <div class="form_head">
                        <h4>주기</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">0.5초 데이타</label>
                                    <label><input type="radio" name="radio">5분 데이타</label>
                                    <label><input type="radio" name="radio">5초 데이타</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">1시간 데이타</label>
                                    <label><input type="radio" name="radio">1분 데이타</label>
                                    <label><input type="radio" name="radio">직접입력</label>
                                    <input type="text" class="tr fx_none" style="width:60px;">
                                    <label>초</label>
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
        <!-- file_upload -->
        <div class="fx_form file_upload">
            <div class="fx_form">
                <input type="text" />
                <a href="#none" class="btn_list">파일선택</a>
            </div>
        </div>
        <!-- //file_upload -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

