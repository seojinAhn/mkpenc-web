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
	var levelVal = [];
	var vlVal = [];
	var fluxVal = [];
	var timerOn = true;
	var gInterval = 5000;
	var searchTime = '${SearchTime}';
	var lblDataList = [];
	var lblDataListAjax = {};
	
	function convFormat(data,scale) {
		//var rtv = data*1;
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
		$(document.body).delegate('#3','click',function() {
			hogiheader = '3';
			setLblDate(hogiHeader,xyHeader,searchTime);
		});
		$(document.body).delegate('#4','click',function() {
			hogiheader = '4';
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
		setLblDate(hogiHeader,xyHeader,searchTime);
		
		lblDataList = '${lblDataList}'.replace('[{','').replace('}]','').split("}, {");
		setLabelData(lblDataList,0);
		createChart(lblDataList,0);
		
		setTimer(0);
	});

	function setTimer(num) {
		if( num == 0 && timerOn ) {
			setInterval(function() {
				var comAjax = new ComAjax("reloadFrm");
				comAjax.setUrl("/dcc/status/reloadZv");
				comAjax.addParam("hogiHeader", hogiHeader);
				comAjax.addParam("xyHeader", xyHeader);
				comAjax.addParam("hogi", hogiHeader);
				comAjax.addParam("xyGubun", xyHeader);
				comAjax.addParam("gubun", 'D');
				comAjax.addParam("menuNo", '11');
				comAjax.addParam("grpID", 'mimic');
				comAjax.addParam("grpNo", '8');
				comAjax.setCallback("mbr_chartCallback");
				comAjax.ajax();
			},gInterval);
		}
	}
	
	function reloadAjax(type) {
		setLabelData(lblDataListAjax,1);
		
		createChart(lblDataListAjax,1);
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
	
	function setLabelData(xData,type) {
		for( var i=0;i<14;i++ ) {
			if( type == 0 ) {
				levelVal.splice(i,1,convFormat(xData[i].split("=")[1]*1,8));
				vlVal.splice(i,1,convFormat(xData[i+14].split("=")[1]*1,8));
				fluxVal.splice(i,1,convFormat(xData[i+28].split("=")[1]*100,8));
			} else {
				levelVal.splice(i,1,convFormat(xData[i].fValue*1,8));
				vlVal.splice(i,1,convFormat(xData[i+14].fValue*1,8));
				fluxVal.splice(i,1,convFormat(xData[i+28].fValue*100,8));
			}
			
			$("#levelData"+i).text(levelVal[i]);
			$("#levelData"+i).attr("title",toolTipText[i]);
			
			$("#vlData"+i).text(vlVal[i]);
			$("#vlData"+i).attr("title",toolTipText[i+14]);
			
			$("#fluxData"+i).text(fluxVal[i]);
			$("#fluxData"+i).attr("title",toolTipText[i+28]);
		}
	}
	
	function createChart(xData,type) {
		for( var i=0;i<14;i++ ) {
			var levelTmp = [{
				name: 'LEVEL',
				data: convFormat(levelVal[i]*1/1.4,8)*1
			}];
			var vlTmp = [{
				name: 'VALVE_LIFT',
				data: convFormat(vlVal[i]*1,bScales[i+14])*1
			}];
			var fluxTmp = [{
				name: 'FLUX',
				data: convFormat(fluxVal[i]/1.2,8)*1
			}];
			
			if( type == 0 || type == 1 ) {
				var levelConfig = {
					global: {
						svg: {
							classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
						},
						size: {
							width: 40,
							height: 100
						},
						color: {
							pattern: ['#8AD4E4']
						}
					},
					data: {
						type: 'bar', // 차트의 타입을 설정 
						json: levelTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
							min:0,
							max:100
						}
					},
					grid: {
						x:{show:false},
						y:{show:false}
					},
					legend: {
						show: false
					},
					extend: {
						bar: {
							useBackground: true,
							background: {
								color: '#ffffff',
								strokeColor: '#8AD4E4',
								strokeWidth: 2
							}
						}
					},
					tooltip: {
						show: false
					}
				};
				
				chart = new sb.chart("#level"+i, levelConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
				chart.render();
			}
			
			if( type == 0 || type == 2 ) {
				var vlConfig = {
					global: {
						svg: {
							classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
						},
						size: {
							width: 40,
							height: 100
						},
						color: {
							pattern: ['#FEC87F']
						}
					},
					data: {
						type: 'bar', // 차트의 타입을 설정 
						json: vlTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
							min:0,
							max:100
						}
					},
					grid: {
						x:{show:false},
						y:{show:false}
					},
					legend: {
						show: false
					},
					extend: {
						bar: {
							useBackground: true,
							background: {
								color: '#ffffff',
								strokeColor: '#FEC87F',
								strokeWidth: 2
							}
						}
					},
					tooltip: {
						show: false
					}
				};
				
				chart = new sb.chart("#vl"+i, vlConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
				chart.render();
			}
			
			if( type == 0 || type == 3 ) {
				var fluxConfig = {
					global: {
						svg: {
							classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
						},
						size: {
							width: 40,
							height: 120
						},
						color: {
							pattern: ['#A8A4D1']
						}
					},
					data: {
						type: 'bar', // 차트의 타입을 설정 
						json: fluxTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
							min:0,
							max:100
						}
					},
					grid: {
						x:{show:false},
						y:{show:false}
					},
					legend: {
						show: false
					},
					extend: {
						bar: {
							useBackground: true,
							background: {
								color: '#ffffff',
								strokeColor: '#A8A4D1',
								strokeWidth: 2
							}
						}
					},
					tooltip: {
						show: false
					}
				};
			
				chart = new sb.chart("#flux"+i, fluxConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
				chart.render();
			}
		}
	}
	
	function toCSV() {
		timerOn = false;
		var comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl('/dcc/status/zvExcelExport');
		comSubmit.addParam("hogi",hogiHeader);
		comSubmit.addParam("xyGubun",xyHeader);
		comSubmit.submit();
		timerOn = true;
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
				<h3>ZONE VALUES IN %</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>ZONE VALUES IN %</strong></div>
			</div>
			<!-- //page_title -->
            <div class="legend center">
                <ul>
                    <li class="level">LEVEL</li>
                    <li class="valvelift">VALVE LIFT</li>
                    <li class="flux">FLUX</li>
                </ul>
            </div> 
            <!-- barchart_layout -->
            <div class="barchart_layout">
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>ZONE 1</h6>
                        <div id="barchart0" class="barchart" style="width:120px;height:160px;">
                        	<div id="level0" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl0" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux0" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData0" style="position:absolute;top:370px;left:275px"></div>
                        	<div id="vlData0" style="position:absolute;top:255px;left:315px"></div>
                        	<div id="fluxData0" style="position:absolute;top:370px;left:355px"></div>
                        </div>
                    </div>
                    <div class="barchart_item">
                        <h6>ZONE 2</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level1" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl1" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux1" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData1" style="position:absolute;top:558px;left:275px"></div>
                        	<div id="vlData1" style="position:absolute;top:442px;left:315px"></div>
                        	<div id="fluxData1" style="position:absolute;top:558px;left:355px"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>ZONE 3</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level2" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl2" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux2" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData2" style="position:absolute;top:275px;left:413px"></div>
                        	<div id="vlData2" style="position:absolute;top:160px;left:453px"></div>
                        	<div id="fluxData2" style="position:absolute;top:275px;left:493px"></div>
                        </div>
                    </div>
                    <div class="barchart_item">
                        <h6>ZONE 4</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level3" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl3" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux3" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData3" style="position:absolute;top:463px;left:413px"></div>
                        	<div id="vlData3" style="position:absolute;top:348px;left:453px"></div>
                        	<div id="fluxData3" style="position:absolute;top:463px;left:493px"></div>
                        </div>
                    </div>
                    <div class="barchart_item">
                        <h6>ZONE 5</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level4" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl4" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux4" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData4" style="position:absolute;top:651px;left:413px"></div>
                        	<div id="vlData4" style="position:absolute;top:536px;left:453px"></div>
                        	<div id="fluxData4" style="position:absolute;top:651px;left:493px"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>ZONE 6</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level5" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl5" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux5" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData5" style="position:absolute;top:370px;left:551px"></div>
                        	<div id="vlData5" style="position:absolute;top:255px;left:591px"></div>
                        	<div id="fluxData5" style="position:absolute;top:370px;left:631px"></div>
                        </div>
                    </div>
                    <div class="barchart_item">
                        <h6>ZONE 7</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level6" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl6" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux6" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData6" style="position:absolute;top:558px;left:551px"></div>
                        	<div id="vlData6" style="position:absolute;top:442px;left:591px"></div>
                        	<div id="fluxData6" style="position:absolute;top:558px;left:631px"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_gap">
                </div>
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>ZONE 1</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level7" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl7" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux7" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData7" style="position:absolute;top:370px;left:712px"></div>
                        	<div id="vlData7" style="position:absolute;top:255px;left:752px"></div>
                        	<div id="fluxData7" style="position:absolute;top:370px;left:792px"></div>
                        </div>
                    </div>
                    <div class="barchart_item">
                        <h6>ZONE 2</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level8" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl8" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux8" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData8" style="position:absolute;top:558px;left:712px"></div>
                        	<div id="vlData8" style="position:absolute;top:442px;left:752px"></div>
                        	<div id="fluxData8" style="position:absolute;top:558px;left:792px"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>ZONE 3</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level9" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl9" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux9" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData9" style="position:absolute;top:275px;left:850px"></div>
                        	<div id="vlData9" style="position:absolute;top:160px;left:890px"></div>
                        	<div id="fluxData9" style="position:absolute;top:275px;left:930px"></div>
                        </div>
                    </div>
                    <div class="barchart_item">
                        <h6>ZONE 4</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level10" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl10" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux10" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData10" style="position:absolute;top:463px;left:850px"></div>
                        	<div id="vlData10" style="position:absolute;top:348px;left:890px"></div>
                        	<div id="fluxData10" style="position:absolute;top:463px;left:930px"></div>
                        </div>
                    </div>
                    <div class="barchart_item">
                        <h6>ZONE 5</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level11" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl11" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux11" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData11" style="position:absolute;top:651px;left:850px"></div>
                        	<div id="vlData11" style="position:absolute;top:536px;left:890px"></div>
                        	<div id="fluxData11" style="position:absolute;top:651px;left:930px"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>ZONE 6</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level12" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl12" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux12" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData12" style="position:absolute;top:370px;left:988px"></div>
                        	<div id="vlData12" style="position:absolute;top:255px;left:1028px"></div>
                        	<div id="fluxData12" style="position:absolute;top:370px;left:1068px"></div>
                        </div>
                    </div>
                    <div class="barchart_item">
                        <h6>ZONE 7</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level13" style="top:10px;width:40px;height:100px;float:left;margin-bottom:10px"></div>
                        	<div id="vl13" style="width:40px;height:100px;float:left;margin-top:40px"></div>
                        	<div id="flux13" style="top:10px;width:40px;height:120px;float:left;margin-right:5px;margin-bottom:30px"></div>
                        	<div id="levelData13" style="position:absolute;top:558px;left:988px"></div>
                        	<div id="vlData13" style="position:absolute;top:442px;left:1028px"></div>
                        	<div id="fluxData13" style="position:absolute;top:558px;left:1068px"></div>
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
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

