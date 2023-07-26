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
	var levelTop = [
		229,416,149,336,523,229,416
	];
	var vlTop = 100;
	var fluxTop = [
		229,416,149,336,523,229,416
	];
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
	var levelAvg,fluxAvg,fluxAvgVal;
	
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
				comAjax.setUrl("/dcc/status/reloadZd");
				comAjax.addParam("hogiHeader", hogiHeader);
				comAjax.addParam("xyHeader", xyHeader);
				comAjax.addParam("hogi", hogiHeader);
				comAjax.addParam("xyGubun", xyHeader);
				comAjax.addParam("gubun", 'D');
				comAjax.addParam("menuNo", '11');
				comAjax.addParam("grpID", 'mimic');
				comAjax.addParam("grpNo", '9');
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
		var fluxSum = 0;
		var j = 0;
		if( type == 0 ) {
			levelAvg = xData[28].split("=")[1]*1 > -32768 ? convFormat(xData[28].split("=")[1]*1,7) : '***IRR';
		} else {
			levelAvg = xData[28].fValue*1 > -32768 ? convFormat(xData[28].fValue*1,7) : '***IRR';
		}
			
		for( var i=0;i<7;i++ ) {
			if( type == 0 ) {
				levelPrev.splice(i,1,convFormat(xData[i].split("=")[1]*1,8));
				levelPost.splice(i,1,convFormat(xData[i+7].split("=")[1]*1,8));
				fluxPrev.splice(i,1,convFormat(xData[i+14].split("=")[1]*100,8));
				fluxPost.splice(i,1,convFormat(xData[i+21].split("=")[1]*100,8));
			} else {
				levelPrev.splice(i,1,convFormat(xData[i].fValue*1,8));
				levelPost.splice(i,1,convFormat(xData[i+7].fValue*1,8));
				fluxPrev.splice(i,1,convFormat(xData[i+14].fValue*100,8));
				fluxPost.splice(i,1,convFormat(xData[i+21].fValue*100,8));
			}

			if( !isNaN(levelAvg*1) && !isNaN(levelPrev[i]*1) ) {
				$("#lblLevel"+i).text(convFormat(levelPrev[i]*1-levelAvg*1,8));
				$("#lblLevel"+i).attr("title",toolTipText[i]);
			}
			if( !isNaN(levelAvg*1) && !isNaN(levelPost[i]*1) ) {
				$("#lblLevel"+(i+7)).text(convFormat(levelPost[i]*1-levelAvg*1,8));
				$("#lblLevel"+(i+7)).attr("title",toolTipText[i+7]);
			}
			if( !isNaN(fluxPrev[i]*1) ) {
				fluxSum += fluxPrev[i]*1;
				j++;
			}
			if( !isNaN(fluxPost[i]*1) ) {
				fluxSum += fluxPost[i]*1;
				j++;
			}
		}
		fluxAvg = convFormat(fluxSum/j,8);
		
		var lblLevelAvgStr = "<span>LEVEL AVG</span><strong>"+levelAvg+"</strong>";
		$("#lblLevelAvg").empty();
		$("#lblLevelAvg").append(lblLevelAvgStr);

		var lblFluxAvgStr = "<span>FLUX AVG</span><strong>"+fluxAvg+"</strong>";
		$("#lblFluxAvg").empty();
		$("#lblFluxAvg").append(lblFluxAvgStr);

		for( var i=0;i<7;i++ ) {
			if( !isNaN(fluxAvg*1) && !isNaN(fluxPrev[i]*1) ) {
				$("#lblFlux"+i).text(convFormat(fluxPrev[i]*1-fluxAvg*1,8));
				$("#lblFlux"+i).attr("title",toolTipText[i+14]);
			}
			if( !isNaN(fluxAvg*1) && !isNaN(fluxPost[i]*1) ) {
				$("#lblFlux"+(i+7)).text(convFormat(fluxPost[i]*1-fluxAvg*1,8));
				$("#lblFlux"+(i+7)).attr("title",toolTipText[i+21]);
			}
		}
		fluxAvgVal = convFormat((120-fluxAvg*1)/120,8)*100;
	}
	
	function createChart(xData,type) {
		for( var i=0;i<7;i++ ) {
			var prevLTmp = [{
				name: 'prev',
				data: convFormat(levelPrev[i]*1-levelAvg*1,8)*1
			}];
			var avgLTmp = [{
				name: 'avg',
				data: levelAvg*-1
			}];
			var postLTmp = [{
				name: 'post',
				data: convFormat(levelPost[i]*1-levelAvg*1,8)*1
			}];
			var prevFTmp = [{
				name: 'prev',
				data: convFormat(fluxPrev[i]*1-fluxAvg*1,8)*1
			}];
			var avgFTmp = [{
				name: 'avg',
				data: fluxAvgVal*1-100,
			}];
			var postFTmp = [{
				name: 'post',
				data: convFormat(fluxPost[i]*1-fluxAvg*1,8)*1
			}];
			
			var prevLConfig = {
				global: {
					svg: {
						classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
					},
					size: {
						width: 40,
						height: 130
					},
					color: {
						pattern: ['#A8A4D1']
					}
				},
				data: {
					type: 'bar', // 차트의 타입을 설정 
					json: prevLTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
						min: levelAvg*-1,
						max: 100-levelAvg*1
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
			
			chart = new sb.chart("#level"+i, prevLConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.render();
			
			var avgLConfig = {
				global: {
					svg: {
						classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
					},
					size: {
						width: 40,
						height: 130
					},
					color: {
						pattern: ['#A8A4D1']
					}
				},
				data: {
					type: 'bar', // 차트의 타입을 설정 
					json: avgLTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
						min: levelAvg*-1,
						max: 100-levelAvg*1
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
			
			chart = new sb.chart("#lvAvg"+i, avgLConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.render();
			
			var postLConfig = {
				global: {
					svg: {
						classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
					},
					size: {
						width: 40,
						height: 130
					},
					color: {
						pattern: ['#A8A4D1']
					}
				},
				data: {
					type: 'bar', // 차트의 타입을 설정 
					json: postLTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
						min: levelAvg*-1,
						max: 100-levelAvg*1
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
		
			chart = new sb.chart("#level"+(i+7), postLConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.render();
			
			var newTop = levelTop[i]*1+convFormat(100-levelAvg*1,15)*1+9;
			$("#lnLevel"+i).css("top",newTop);
			$("#lnLevel"+i).css("display","");
		
			var prevFConfig = {
				global: {
					svg: {
						classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
					},
					size: {
						width: 40,
						height: 130
					},
					color: {
						pattern: ['#FEC87F']
					}
				},
				data: {
					type: 'bar', // 차트의 타입을 설정 
					json: prevFTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
						min: fluxAvgVal*1-100,
						max: convFormat(fluxAvgVal*1,8)*1
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
			
			chart = new sb.chart("#flux"+i, prevFConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.render();
			
			var avgFConfig = {
				global: {
					svg: {
						classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
					},
					size: {
						width: 40,
						height: 130
					},
					color: {
						pattern: ['#FEC87F']
					}
				},
				data: {
					type: 'bar', // 차트의 타입을 설정 
					json: avgFTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
						min: fluxAvgVal*1-100,
						max: convFormat(fluxAvgVal*1,8)*1
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
			
			chart = new sb.chart("#fluxAvg"+i, avgFConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.render();
			
			var postFConfig = {
				global: {
					svg: {
						classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
					},
					size: {
						width: 40,
						height: 130
					},
					color: {
						pattern: ['#FEC87F']
					}
				},
				data: {
					type: 'bar', // 차트의 타입을 설정 
					json: postFTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
						min: fluxAvgVal*1-100,
						max: convFormat(fluxAvgVal*1,8)*1
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
		
			chart = new sb.chart("#flux"+(i+7), postFConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.render();
			
			var newTop = fluxTop[i]*1+(fluxAvgVal*1+10)/1.2;
			$("#lnFlux"+i).css("top",newTop);
			$("#lnFlux"+i).css("display","");
		}
	}
	
	function toCSV() {
		timerOn = false;
		var comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl('/dcc/status/zdExcelExport');
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
				<h3>ZONE DEVIATIONS</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>ZONE DEVIATIONS</strong></div>
			</div>
			<!-- //page_title -->

            <!-- barchart_layout -->
            <div class="barchart_layout">
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>1 & 8</h6>
                        <div id="barchart0" class="barchart" style="width:120px;height:160px;">
                        	<div id="level0" style="width:40px;height:130px;float:left"></div>
                        	<div id="lvAvg0" style="width:40px;height:130px;float:left"></div>
                        	<div id="level7" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblLevel0" style="position:absolute;top:355px;left:275px"></div>
                        	<div id="lvAvgData0" style="position:absolute;top:255px;left:315px"></div>
                        	<div id="lblLevel7" style="position:absolute;top:355px;left:362px"></div>
                        	<div id="lnLevel0" style="width:120px;height:1px;position:absolute;top:229px;left:272px;background-color:red;display:none"></div>
                        </div>
                    </div>
                    <div id="barchart1" class="barchart_item">
                        <h6>2 & 9</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level1" style="width:40px;height:130px;float:left"></div>
                        	<div id="lvAvg1" style="width:40px;height:130px;float:left"></div>
                        	<div id="level8" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblLevel1" style="position:absolute;top:543px;left:275px"></div>
                        	<div id="lvAvgData1" style="position:absolute;top:442px;left:315px"></div>
                        	<div id="lblLevel8" style="position:absolute;top:543px;left:362px"></div>
                        	<div id="lnLevel1" style="width:120px;height:1px;position:absolute;top:416px;left:272px;background-color:red;display:none"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_block">
                    <h5 id="lblLevelAvg">
                        <span>LEVEL AVG</span>
                        <strong>50.74</strong>
                    </h5>
                    <div id="barchart2" class="barchart_item">
                        <h6>3 & 10</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level2" style="width:40px;height:130px;float:left"></div>
                        	<div id="lvAvg2" style="width:40px;height:130px;float:left"></div>
                        	<div id="level9" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblLevel2" style="position:absolute;top:275px;left:413px"></div>
                        	<div id="lvAvgData2" style="position:absolute;top:160px;left:453px"></div>
                        	<div id="lblLevel9" style="position:absolute;top:275px;left:502px"></div>
                        	<div id="lnLevel2" style="width:120px;height:1px;position:absolute;top:149px;left:410px;background-color:red;display:none"></div>
                        </div>
                    </div>
                    <div id="barchart3" class="barchart_item">
                        <h6>4 & 11</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level3" style="width:40px;height:130px;float:left"></div>
                        	<div id="lvAvg3" style="width:40px;height:130px;float:left"></div>
                        	<div id="level10" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblLevel3" style="position:absolute;top:463px;left:413px"></div>
                        	<div id="lvAvgData3" style="position:absolute;top:328px;left:453px"></div>
                        	<div id="lblLevel10" style="position:absolute;top:463px;left:502px"></div>
                        	<div id="lnLevel3" style="width:120px;height:1px;position:absolute;top:336px;left:410px;background-color:red;display:none"></div>
                        </div>
                    </div>
                    <div id="barchart4" class="barchart_item">
                        <h6>5 & 12</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level4" style="width:40px;height:130px;float:left"></div>
                        	<div id="lvAvg4" style="width:40px;height:130px;float:left"></div>
                        	<div id="level11" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblLevel4" style="position:absolute;top:651px;left:413px"></div>
                        	<div id="lvAvgData4" style="position:absolute;top:496px;left:453px"></div>
                        	<div id="lblLevel11" style="position:absolute;top:651px;left:502px"></div>
                        	<div id="lnLevel4" style="width:120px;height:1px;position:absolute;top:523px;left:410px;background-color:red;display:none"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_block">
                    <div id="barchart5" class="barchart_item">
                        <h6>6 & 13</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level5" style="width:40px;height:130px;float:left"></div>
                        	<div id="lvAvg5" style="width:40px;height:130px;float:left"></div>
                        	<div id="level12" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblLevel5" style="position:absolute;top:355px;left:555px"></div>
                        	<div id="lvAvgData5" style="position:absolute;top:255px;left:595px"></div>
                        	<div id="lblLevel12" style="position:absolute;top:355px;left:635px"></div>
                        	<div id="lnLevel5" style="width:120px;height:1px;position:absolute;top:229px;left:550px;background-color:red;display:none"></div>
                        </div>
                    </div>
                    <div id="barchart6" class="barchart_item">
                        <h6>7 & 14</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="level6" style="width:40px;height:130px;float:left"></div>
                        	<div id="lvAvg6" style="width:40px;height:130px;float:left"></div>
                        	<div id="level13" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblLevel6" style="position:absolute;top:543px;left:555px"></div>
                        	<div id="lvAvgData6" style="position:absolute;top:255px;left:595px"></div>
                        	<div id="lblLevel13" style="position:absolute;top:543px;left:635px"></div>
                        	<div id="lnLevel6" style="width:120px;height:1px;position:absolute;top:416px;left:550px;background-color:red;display:none"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_gap">
                </div>
                <div class="barchart_block">
                    <div id="barchart7" class="barchart_item">
                        <h6>1 & 8</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="flux0" style="width:40px;height:130px;float:left"></div>
                        	<div id="fluxAvg0" style="width:40px;height:130px;float:left"></div>
                        	<div id="flux7" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblFlux0" style="position:absolute;top:355px;left:712px"></div>
                        	<div id="lblFlux7" style="position:absolute;top:355px;left:799px"></div>
                        	<div id="lnFlux0" style="width:120px;height:1px;position:absolute;top:229px;left:709px;background-color:#A8A4D1;display:none"></div>
                        </div>
                    </div>
                    <div id="barchart8" class="barchart_item">
                        <h6>2 & 9</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="flux1" style="width:40px;height:130px;float:left"></div>
                        	<div id="fluxAvg1" style="width:40px;height:130px;float:left"></div>
                        	<div id="flux8" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblFlux1" style="position:absolute;top:543px;left:712px"></div>
                        	<div id="lblFlux8" style="position:absolute;top:543px;left:799px"></div>
                        	<div id="lnFlux1" style="width:120px;height:1px;position:absolute;top:416px;left:709px;background-color:#A8A4D1;display:none"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_block">
                    <h5 id="lblFluxAvg">
                        <span>FLUX AVG</span>
                        <strong>50.74</strong>
                    </h5>
                    <div id="barchart9" class="barchart_item">
                        <h6>3 & 10</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="flux2" style="width:40px;height:130px;float:left"></div>
                        	<div id="fluxAvg2" style="width:40px;height:130px;float:left"></div>
                        	<div id="flux9" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblFlux2" style="position:absolute;top:275px;left:852px"></div>
                        	<div id="lblFlux9" style="position:absolute;top:275px;left:941px"></div>
                        	<div id="lnFlux2" style="width:120px;height:1px;position:absolute;top:149px;left:849px;background-color:#A8A4D1;display:none"></div>
                        </div>
                    </div>
                    <div id="barchart10" class="barchart_item">
                        <h6>4 & 11</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="flux3" style="width:40px;height:130px;float:left"></div>
                        	<div id="fluxAvg3" style="width:40px;height:130px;float:left"></div>
                        	<div id="flux10" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblFlux3" style="position:absolute;top:463px;left:852px"></div>
                        	<div id="lblFlux10" style="position:absolute;top:463px;left:941px"></div>
                        	<div id="lnFlux3" style="width:120px;height:1px;position:absolute;top:336px;left:849px;background-color:#A8A4D1;display:none"></div>
                        </div>
                    </div>
                    <div id="barchart11" class="barchart_item">
                        <h6>5 & 12</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="flux4" style="width:40px;height:130px;float:left"></div>
                        	<div id="fluxAvg4" style="width:40px;height:130px;float:left"></div>
                        	<div id="flux11" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblFlux4" style="position:absolute;top:651px;left:852px"></div>
                        	<div id="lblFlux11" style="position:absolute;top:651px;left:941px"></div>
                        	<div id="lnFlux4" style="width:120px;height:1px;position:absolute;top:523px;left:849px;background-color:#A8A4D1;display:none"></div>
                        </div>
                    </div>
                </div>
                <div class="barchart_block">
                    <div id="barchart12" class="barchart_item">
                        <h6>6 & 13</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="flux5" style="width:40px;height:130px;float:left"></div>
                        	<div id="fluxAvg5" style="width:40px;height:130px;float:left"></div>
                        	<div id="flux12" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblFlux5" style="position:absolute;top:355px;left:991px"></div>
                        	<div id="lblFlux12" style="position:absolute;top:355px;left:1078px"></div>
                        	<div id="lnFlux5" style="width:120px;height:1px;position:absolute;top:229px;left:988px;background-color:#A8A4D1;display:none"></div>
                        </div>
                    </div>
                    <div id="barchart13" class="barchart_item">
                        <h6>7 & 14</h6>
                        <div class="barchart" style="width:120px;height:160px;">
                        	<div id="flux6" style="width:40px;height:130px;float:left"></div>
                        	<div id="fluxAvg6" style="width:40px;height:130px;float:left"></div>
                        	<div id="flux13" style="width:40px;height:130px;float:left"></div>
                        	<div id="lblFlux6" style="position:absolute;top:543px;left:991px"></div>
                        	<div id="lblFlux13" style="position:absolute;top:543px;left:1078px"></div>
                        	<div id="lnFlux6" style="width:120px;height:1px;position:absolute;top:416px;left:988px;background-color:#A8A4D1;display:none"></div>
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

