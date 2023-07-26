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

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/datetimepicker/jquery.datetimepicker.css" />">
<script type="text/javascript" src="<c:url value="/resources/datetimepicker/jquery.datetimepicker.full.min.js" />" charset="utf-8"></script>

<link rel="stylesheet" href="/resources/sbchart/sbchart.css">
<script type="text/javascript" src="/resources/sbchart/sbchart.js"></script>

<script type="text/javascript">
	var hogiHeader = '${UserInfo.hogi}' != "undefined" && '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
	var xyHeader = '${UserInfo.xyGubun}' != "undefined" && '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";
	var levelHeight = 0;
	var vlHeight = 0;
	var fluxHeight = 0;
	var levelTop = 100;
	var vlTop = 100;
	var fluxTop = 100;
	var bScales = [
		'${DccTagInfoList[0].BScale}','${DccTagInfoList[1].BScale}','${DccTagInfoList[2].BScale}','${DccTagInfoList[3].BScale}','${DccTagInfoList[4].BScale}','${DccTagInfoList[5].BScale}',
		'${DccTagInfoList[6].BScale}','${DccTagInfoList[7].BScale}','${DccTagInfoList[8].BScale}','${DccTagInfoList[9].BScale}','${DccTagInfoList[10].BScale}','${DccTagInfoList[11].BScale}',
		'${DccTagInfoList[12].BScale}','${DccTagInfoList[13].BScale}','${DccTagInfoList[14].BScale}','${DccTagInfoList[15].BScale}','${DccTagInfoList[16].BScale}','${DccTagInfoList[17].BScale}',
		'${DccTagInfoList[18].BScale}','${DccTagInfoList[19].BScale}','${DccTagInfoList[20].BScale}','${DccTagInfoList[21].BScale}','${DccTagInfoList[22].BScale}','${DccTagInfoList[23].BScale}',
		'${DccTagInfoList[24].BScale}','${DccTagInfoList[25].BScale}','${DccTagInfoList[26].BScale}','${DccTagInfoList[27].BScale}','${DccTagInfoList[28].BScale}','${DccTagInfoList[29].BScale}',
		'${DccTagInfoList[30].BScale}','${DccTagInfoList[31].BScale}','${DccTagInfoList[32].BScale}','${DccTagInfoList[33].BScale}','${DccTagInfoList[34].BScale}','${DccTagInfoList[35].BScale}',
		'${DccTagInfoList[36].BScale}','${DccTagInfoList[37].BScale}','${DccTagInfoList[38].BScale}','${DccTagInfoList[39].BScale}','${DccTagInfoList[40].BScale}','${DccTagInfoList[41].BScale}'
	];
	var toolTipText = [
		'${DccTagInfoList[0].toolTip}','${DccTagInfoList[1].toolTip}','${DccTagInfoList[2].toolTip}','${DccTagInfoList[3].toolTip}','${DccTagInfoList[4].toolTip}','${DccTagInfoList[5].toolTip}',
		'${DccTagInfoList[6].toolTip}','${DccTagInfoList[7].toolTip}','${DccTagInfoList[8].toolTip}','${DccTagInfoList[9].toolTip}','${DccTagInfoList[10].toolTip}','${DccTagInfoList[11].toolTip}',
		'${DccTagInfoList[12].toolTip}','${DccTagInfoList[13].toolTip}','${DccTagInfoList[14].toolTip}','${DccTagInfoList[15].toolTip}','${DccTagInfoList[16].toolTip}','${DccTagInfoList[17].toolTip}',
		'${DccTagInfoList[18].toolTip}','${DccTagInfoList[19].toolTip}','${DccTagInfoList[20].toolTip}','${DccTagInfoList[21].toolTip}','${DccTagInfoList[22].toolTip}','${DccTagInfoList[23].toolTip}',
		'${DccTagInfoList[24].toolTip}','${DccTagInfoList[25].toolTip}','${DccTagInfoList[26].toolTip}','${DccTagInfoList[27].toolTip}','${DccTagInfoList[28].toolTip}','${DccTagInfoList[29].toolTip}',
		'${DccTagInfoList[30].toolTip}','${DccTagInfoList[31].toolTip}','${DccTagInfoList[32].toolTip}','${DccTagInfoList[33].toolTip}','${DccTagInfoList[34].toolTip}','${DccTagInfoList[35].toolTip}',
		'${DccTagInfoList[36].toolTip}','${DccTagInfoList[37].toolTip}','${DccTagInfoList[38].toolTip}','${DccTagInfoList[39].toolTip}','${DccTagInfoList[40].toolTip}','${DccTagInfoList[41].toolTip}',
	];
	var refScales = [
		"5","4","4","4","3","3","3","2","2","2","2","1","1","1","1","0"
	];
	var levelPrev = [];
	var levelPost = [];
	var fluxPrev = [];
	var fluxPost = [];
	var timerOn = true;
	var gInterval = 5000;
	var searchTime = '${SearchTime}';
	var lblDataList = [];
	var lblDataListAjax = {};
	var isCompareMode = false;
	var lastSearchTime = '';
	
	function convFormat(data,scale) {
		var tmp = data+"";
		var conv = data+"";
		var scal = refScales[scale]*1;
		
		if( tmp.indexOf('.') > -1 ) {
			var len = tmp.substring(tmp.indexOf('.')+1,tmp.length).length;
			if( len > scal ) {
				conv = tmp.substring(0,tmp.indexOf('.')+(scal+1));
			} else {
				var idx = len;
				while( idx < scal ) {
					conv += '0';
					
					idx++;
				}
			}
		} else {
			conv += '.00';
		}
		
		return conv;
	}
	
	$(function() {
		$("#selectSDate").val('${BaseSearch.startDate}');
		
		$(document.body).delegate('#3','click',function() {
			hogiHeader = '3';
			setLblDate(hogiHeader,xyHeader,searchTime);
		});
		$(document.body).delegate('#4','click',function() {
			hogiHeader = '4';
			setLblDate(hogiHeader,xyHeader,searchTime);
		});
		$(document.body).delegate('#X','click',function() {
			xyHeader = 'X';
			setLblDate(hogiHeader,xyHeader,searchTime);
		});
		$(document.body).delegate('#Y','click',function() {
			xyHeader = 'Y';
			setLblDate(hogiHeader,xyHeader,searchTime);
		});
		$(document.body).delegate('#oldSearch','click',function() {
			oldSearch_click();
		});
		
		setLblDate(hogiHeader,xyHeader,searchTime);
		
		jQuery.datetimepicker.setLocale('ko');
		
		$('#selectSDate').datetimepicker(DatetimepickerDefaults({}));
		$('#selectEDate').datetimepicker(DatetimepickerDefaults({}));
		
		lblDataList = '${lblDataList}'.replace('[{','').replace('}]','').split("}, {");
		setLabelData(lblDataList,0);
		createChart(lblDataList,0);
		
		setTimer(0);
	});
	
	function oldSearch_click() {
		var startDate = $('#selectSDate').val();
		
		if( startDate != '' && typeof startDate != 'undefined' ) {
			lastSearchTime = startDate;
			isCompareMode = true;
			
			var comAjax = new ComAjax("reloadFrm");
			comAjax.setUrl("/dcc/status/reloadZc");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("hogi", hogiHeader);
			comAjax.addParam("xyGubun", xyHeader);
			comAjax.addParam("searchStr", '0');
			comAjax.addParam("startDate", startDate);
			//comAjax.addParam("gubun", 'D');
			//comAjax.addParam("menuNo", '11');
			comAjax.addParam("grpID", 'mimic');
			//comAjax.addParam("grpNo", '15');
			comAjax.setCallback("mbr_chartCallback");
			comAjax.ajax();
		}
	}
	
	function reloadAjax(type) {
		if( type == 0 || type == '0' ) {
			setLabelData(lblDataListAjax,1);
			
			createChart(lblDataListAjax,1);
		} else {
			setLabelData(lblDataListAjax,0);

			createChart(lblDataListAjax,0);
		}
	}
	
	function setTimer(num) {
		if( num == 0 && timerOn ) {
			setInterval(function() {
				isCompareMode = true;
				
				var startDate = $("#selectSDate").val();
				
				var comAjax = new ComAjax("reloadFrm");
				comAjax.setUrl("/dcc/status/reloadZc");
				comAjax.addParam("hogiHeader", hogiHeader);
				comAjax.addParam("xyHeader", xyHeader);
				comAjax.addParam("hogi", hogiHeader);
				comAjax.addParam("xyGubun", xyHeader);
				comAjax.addParam("searchStr", '1');
				comAjax.addParam("startDate", startDate);
				//comAjax.addParam("gubun", 'D');
				//comAjax.addParam("menuNo", '11');
				comAjax.addParam("grpID", 'mimic');
				//comAjax.addParam("grpNo", '15');
				comAjax.setCallback("mbr_chartCallback");
				comAjax.ajax();
			},gInterval);
		}
	}
	
	function setLblDate(hogi,xy,m_time) {
		var lblDateVal = m_time;
		//var lblDateVal = hogi+xy+' '+m_time;
		$("#lblDate").text(lblDateVal);
		var diff = new Date().getTime() - new Date(m_time).getTime();
		if( diff / 1800000 > 1 ) {
			$("#lblDate").css('color','#e85516');
		} else {
			$("#lblDate").css('color','#05c8be');
		}
	}
	
	function calcDeviation() {
		var fValue1 = 0;
		var fValue2 = 0;
		
		for( var i=0;i<14;i++ ) {
			fValue1 = levelPrev[i]
		}
	}
	
	function setLabelData(xData,type) {
		var levelAvg = '';
		var fluxAvg = 0;
		var fluxSum = 0;
		var j = 0;
		if( type == 0 ) {
			if( !isCompareMode ) {
				levelAvg = xData[42].split("=")[1]*1 > -32768 ? convFormat(xData[42].split("=")[1]*1,7) : '***IRR';
				
				for( var i=0;i<14;i++ ) {
					levelPrev.splice(i,0,convFormat(xData[i].split("=")[1]*1,7));
					levelPrev.splice(i+14,0,'0.0');
				}
	
				for( var l=0;l<14;l++ ) {
					if( !isNaN(levelAvg*1) && !isNaN(levelPrev[l]*1) ) {
						$("#lblLevel"+l).text(convFormat(levelPrev[l]*1,7));
						$("#lblLevel"+l).attr("title",toolTipText[l]);
						$("#lblLevel"+(l+14)).text(convFormat(levelPrev[l+14]*1,7));
					}

					$("#lblDLevel"+l).text(convFormat(levelPrev[l]*1-levelPrev[l+14]*1,7));
				}
				
				for( var k=0;k<28;k++ ) {
					fluxPrev.splice(k,0,convFormat(xData[k+14].split("=")[1]*1,6));
					
					if( !isNaN(fluxPrev[k]*1) ) {
						fluxSum += fluxPrev[k]*1;
						j++;
					}
				}
			} else {
				levelAvg = xData[42].fValue*1 > -32768 ? convFormat(xData[42].fValue*1,7) : '***IRR';
				
				for( var i=0;i<14;i++ ) {
					levelPrev.splice(i,1,convFormat(xData[i].fValue*1,7));
				}

				for( var l=0;l<14;l++ ) {
					if( !isNaN(levelAvg*1) && !isNaN(levelPrev[l]*1) ) {
						$("#lblLevel"+l).text(convFormat(levelPrev[l]*1,7));
						$("#lblLevel"+l).attr("title",toolTipText[l]);
					}

					$("#lblDLevel"+l).text(convFormat(levelPrev[l]*1-levelPrev[l+14]*1,7));
				}
				
				for( var k=0;k<28;k++ ) {
					fluxPrev.splice(k,1,convFormat(xData[k+14].fValue*1,6));
					
					if( !isNaN(fluxPrev[k]*1) ) {
						fluxSum += fluxPrev[k]*1;
						j++;
					}
				}
			}

			var lblLevelAvgStr = "<span>LEVEL AVG</span><strong>"+levelAvg+"</strong>";
			$("#lblLevelAvg").empty();
			$("#lblLevelAvg").append(lblLevelAvgStr);
			
			fluxAvg = convFormat(fluxSum/j,7);

			for( var h=0;h<28;h++ ) {
				if( !isNaN(fluxAvg*1) && !isNaN(fluxPrev[h]*1) ) {
					$("#lblFlux"+h).text(convFormat(fluxPrev[h]*1,6));
					$("#lblFlux"+h).attr("title",toolTipText[h+14]);
				}

				$("#lblDFlux"+h).text(convFormat(fluxPrev[h]*1-fluxPrev[h+14]*1,6));
			}
		} else {
			if( xData[0].fValue != '' && xData[0].fValue != null ) {
				levelAvg = xData[42].fValue*1 > -32768 ? convFormat(xData[42].fValue*1,7) : '***IRR';
				
				for( var i=0;i<14;i++ ) {
					levelPrev.splice(i+14,1,convFormat(xData[i].fValue*1,7));
				}
	
				for( var l=0;l<14;l++ ) {
					if( !isNaN(levelAvg*1) && !isNaN(levelPrev[l]*1) ) {
						$("#lblLevel"+(l+14)).text(convFormat(levelPrev[l+14]*1,7));
						$("#lblLevel"+(l+14)).attr("title",toolTipText[l]);
					}

					$("#lblDLevel"+l).text(convFormat(levelPrev[l]*1-levelPrev[l+14]*1,7));
				}
			} else {
				for( var i=0;i<14;i++ ) {
					levelPrev.splice(i+14,1,$("#lblLevel"+i).text());
					$("#lblLevel"+(i+14)).text($("#lblLevel"+i).text());
				}

				$("#lblDLevel"+i).text(convFormat(levelPrev[i]*1-levelPrev[i+14]*1,7));
			}
		}
	}
	
	function createChart(xData,type) {
		var colorSet = ['#8AD4E4','#FEC87F','#A8A4D1'];
		var minVal = 0;
		var maxVal = 100;
		
		for( var i=0;i<14;i++ ) {
			var zcTmp = [{
				name: 'prev',
				data: convFormat(levelPrev[i]*1-levelPrev[i+14]*1,7)
			}];
			
			var zcConfig = {
				global: {
					svg: {
						classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
					},
					size: {
						width: 40,
						height: 70
					},
					color: {
						pattern: ['#A8A4D1']
					}
				},
				data: {
					type: 'bar', // 차트의 타입을 설정 
					json: zcTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
					keys: { // json 형태의 데이터를 사용 시, 필수로 keys 속성을 사용해야 함
						x: "name", // 각각의 x축 이름을 chartData의 name값으로 설정 
						value: ['data'] // chartData의 2015, 2016, 2017 데이터를 보여주도록 설정
					}
				},
				axis: {
					x: {
						show: false,
						padding: 0
					},
					y: {
						show: false,
						padding: 0,
						min: -10,
						max: 10
					}
				},
				grid: {
					x:{show:false},
					y:{show:false}
				},
				legend: {
					show: false
				},
				tooltip: {
					show: false
				}
			};
			
			chart = new sb.chart("#shpLevel"+i, zcConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.render();
		}
	}
	
	function toCSV() {
		timerOn = false;
		var comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl('/dcc/status/zcExcelExport');
		comSubmit.addParam("hogi",hogiHeader);
		comSubmit.addParam("xyGubun",xyHeader);
		comSubmit.submit();
		timerOn = true;
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
				<h3>ZONE COMPARE</h3>
				<div class="bc"><span>MARK_V</span><span>Status</span><strong>ZONE COMPARE</strong></div>
			</div>
			<!-- //page_title -->
			
			<div class="fx_srch_wrap" style="max-height:60px;margin-bottom:10px">	
				<div class="fx_srch_form" style="margin-top:-5px">
					<div class="fx_srch_row">
						<div id="searchDate" class="fx_srch_item">
							<label>검색기간</label>
			                <div class="fx_form_multi">
			                    <div class="fx_form">
			                        <input type="text" id="selectSDate" name="selectSDate">
			                    </div>
			                </div>
						</div>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a id="oldSearch" href="#none" class="btn_srch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<div></div>

            <!-- barchart_layout -->
            <div class="barchart_layout">
                <div class="barchart_block">
                    <div class="barchart_item double">
                        <h6>1 & 8</h6>
                        <div class="barchart_item_row">
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux0">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux14">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux0">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel14">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel0">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel0">0.834</label></span>
                                    </li>
                                </ul>
                            </div>
                            <div id="barchart0" class="barchart" style="width:80px;height:160px;">
	                        	<div id="shpLevel0" style="width:40px;height:60px;float:left;margin-top:94px;margin-left:-4px;"></div>
	                        	<div id="vl0" style="width:40px;height:100px;float:left;margin-top:40px"></div>
	                        	<div id="shpLevel7" style="width:40px;height:60px;float:left;margin-top:94px;margin-right:-4px;"></div>
                        		<div id="lnLevel0" style="width:80px;height:1px;position:absolute;top:384px;left:351px;background-color:red"></div>
							</div>
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span>PT1A</span>
                                        <span><label id="lblFlux7">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux21">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux7">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span>PT1A</span>
                                        <span><label id="lblLevel21">0.834</label></span>
                                    </li>  
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblLevel7">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDLevel7">0.834</label></span>
                                    </li>
                                </ul>
                            </div>                            
                        </div>
                    </div>
                    <div class="barchart_item double">
                        <h6>2 & 9</h6>
                        <div class="barchart_item_row">
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux1">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux16">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux1">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel15">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel1">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel1">0.834</label></span>
                                    </li>
                                </ul>
                            </div>
                            <div id="barchart1" class="barchart" style="width:80px;height:160px;">
	                        	<div id="shpLevel1" style="width:40px;height:60px;float:left;margin-top:94px;margin-left:-4px;"></div>
	                        	<div id="vl1" style="width:40px;height:100px;float:left;margin-top:40px"></div>
	                        	<div id="shpLevel8" style="width:40px;height:60px;float:left;margin-top:94px;margin-right:-4px;"></div>
                        		<div id="lnLevel1" style="width:80px;height:1px;position:absolute;top:571px;left:351px;background-color:red"></div>
                       		</div>
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux8">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux22">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux8">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel22">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel8">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel8">0.834</label></span>
                                    </li>
                                </ul>
                            </div>                            
                        </div>                        
                    </div>
                </div>
                <div class="barchart_block">
                    <h5 id="lblLevelAvg">
                        <span>LEVEL AVG</span>
                        <strong>50.74</strong>
                    </h5>
                    <div class="barchart_item double">
                        <h6>3 & 10</h6>
                        <div class="barchart_item_row">
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux2">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux16">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux2">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel16">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel2">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel2">0.834</label></span>
                                    </li>
                                </ul>
                            </div>
                            <div id="barchart2" class="barchart" style="width:80px;height:160px;">
	                        	<div id="shpLevel2" style="width:40px;height:60px;float:left;margin-top:94px;margin-left:-4px;"></div>
	                        	<div id="vl2" style="width:40px;height:100px;float:left;margin-top:40px"></div>
	                        	<div id="shpLevel9" style="width:40px;height:60px;float:left;margin-top:94px;margin-right:-4px;"></div>
                        		<div id="lnLevel2" style="width:80px;height:1px;position:absolute;top:304px;left:650px;background-color:red"></div>
                       		</div>
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux9">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux23">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux9">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel23">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel9">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel9">0.834</label></span>
                                    </li>
                                </ul>
                            </div>                            
                        </div>                        
                    </div>
                    <div class="barchart_item double">
                        <h6>4 & 11</h6>
                        <div class="barchart_item_row">
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux3">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux17">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux3">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel17">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel3">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel3">0.834</label></span>
                                    </li>
                                </ul>
                            </div>
                            <div id="barchart3" class="barchart" style="width:80px;height:160px;">
	                        	<div id="shpLevel3" style="width:40px;height:60px;float:left;margin-top:94px;margin-left:-4px;"></div>
	                        	<div id="vl3" style="width:40px;height:100px;float:left;margin-top:40px"></div>
	                        	<div id="shpLevel10" style="width:40px;height:60px;float:left;margin-top:94px;margin-right:-4px;"></div>
                        		<div id="lnLevel3" style="width:80px;height:1px;position:absolute;top:491px;left:650px;background-color:red"></div>
                       		</div>
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux10">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux24">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux10">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel24">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel10">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel10">0.834</label></span>
                                    </li>
                                </ul>
                            </div>                            
                        </div>                        
                    </div>
                    <div class="barchart_item double">
                        <h6>5 & 12</h6>
                        <div class="barchart_item_row">
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux4">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux18">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux4">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel18">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel4">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel4">0.834</label></span>
                                    </li>
                                </ul>
                            </div>
                            <div id="barchart4" class="barchart" style="width:80px;height:160px;">
	                        	<div id="shpLevel4" style="width:40px;height:60px;float:left;margin-top:94px;margin-left:-4px;"></div>
	                        	<div id="vl4" style="width:40px;height:100px;float:left;margin-top:40px"></div>
	                        	<div id="shpLevel11" style="width:40px;height:60px;float:left;margin-top:94px;margin-right:-4px;"></div>
                        		<div id="lnLevel4" style="width:80px;height:1px;position:absolute;top:678px;left:650px;background-color:red"></div>
                       		</div>
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux11">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux25">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux11">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel25">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel11">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel11">0.834</label></span>
                                    </li>
                                </ul>
                            </div>                            
                        </div>                        
                    </div>
                </div>
                <div class="barchart_block">
                    <div class="barchart_item double">
                        <h6>6 & 13</h6>
                        <div class="barchart_item_row">
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux5">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux19">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux5">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel19">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel5">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel5">0.834</label></span>
                                    </li>
                                </ul>
                            </div>
                            <div id="barchart5" class="barchart" style="width:80px;height:160px;">
	                        	<div id="shpLevel5" style="width:40px;height:60px;float:left;margin-top:94px;margin-left:-4px;"></div>
	                        	<div id="vl5" style="width:40px;height:100px;float:left;margin-top:40px"></div>
	                        	<div id="shpLevel12" style="width:40px;height:60px;float:left;margin-top:94px;margin-right:-4px;"></div>
                        		<div id="lnLevel5" style="width:80px;height:1px;position:absolute;top:384px;left:949px;background-color:red"></div>
                       		</div>
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux12">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux26">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux12">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel26">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel12">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel12">0.834</label></span>
                                    </li>
                                </ul>
                            </div>                            
                        </div>                        
                    </div>
                    <div class="barchart_item double">
                        <h6>7 & 14</h6>
                        <div class="barchart_item_row">
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux6">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux20">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux6">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel20">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel6">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel6">0.834</label></span>
                                    </li>
                                </ul>
                            </div>
                            <div id="barchart6" class="barchart" style="width:80px;height:160px;">
	                        	<div id="shpLevel6" style="width:40px;height:60px;float:left;margin-top:94px;margin-left:-4px;"></div>
	                        	<div id="vl6" style="width:40px;height:100px;float:left;margin-top:40px"></div>
	                        	<div id="shpLevel13" style="width:40px;height:60px;float:left;margin-top:94px;margin-right:-4px;"></div>
                        		<div id="lnLevel6" style="width:80px;height:1px;position:absolute;top:571px;left:949px;background-color:red"></div>
                       		</div>
                            <div class="barchart_item_table">
                                <ul class="blue">
                                    <li>
                                        <span class="center">PT1A</span>
                                        <span><label id="lblFlux13">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>PT1C</span>
                                        <span><label id="lblFlux27">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>FP Diff</span>
                                        <span><label id="lblDFlux13">0.834</label></span>
                                    </li>
                                </ul>
                                <ul class="red">
                                    <li>
                                        <span style="font-size:10px;">Past LVL</span>
                                        <span><label id="lblLevel27">0.834</label></span>
                                    </li>
                                    <li>
                                        <span style="font-size:10px;">Prst LVL</span>
                                        <span><label id="lblLevel13">0.834</label></span>
                                    </li>
                                    <li>
                                        <span>LVL Diff</span>
                                        <span><label id="lblDLevel13">0.834</label></span>
                                    </li>
                                </ul>
                            </div>                            
                        </div>                        
                    </div>
                </div>
            </div>
            <!-- //barchart_layout -->
                
		</div>
        <!-- 마우스 우클릭 메뉴 -->
        <div class="context_menu" id="mouse_area">
            <ul>
                <li><a href="javascript:toCSV()">엑셀로 저장</a></li>
            </ul>
        </div>
        <!-- //마우스 우클릭 메뉴 --> 
		<!-- //contents -->
	</div>
			<form id="reloadFrm" type="hidden"></form>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->
<!-- <script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script> -->
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

