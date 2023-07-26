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

<script src="/resources/html2canvas/html2canvas.min.js"></script>
<script src="/resources/html2canvas/html2pdf.bundle.js"></script>

<script type="text/javascript">
	var hogiHeader = '${UserInfo.hogi}' != "undefined" || '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
	var xyHeader = '${UserInfo.xyGubun}' != "undefined" || '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";
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
	var timerOn = true;
	var gInterval = 5000;
	var searchTime = '${SearchTime}';
	var lblDataListAjax = {};
	var lblDataList = [];
	
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
	
	function reloadAjax(type) {
		setLabelData(lblDataListAjax,1);
		
		createChart(lblDataListAjax,1);
	}
	
	function setTimer(num) {
		if( num == 0 && timerOn ) {
			setInterval(function() {
				var comAjax = new ComAjax("reloadFrm");
				comAjax.setUrl("/dcc/status/reloadAdjrod");
				comAjax.addParam("hogiHeader", hogiHeader);
				comAjax.addParam("xyHeader", xyHeader);
				comAjax.addParam("hogi", hogiHeader);
				comAjax.addParam("xyGubun", xyHeader);
				comAjax.addParam("gubun", 'D');
				comAjax.addParam("menuNo", '11');
				comAjax.addParam("grpID", 'mimic');
				comAjax.addParam("grpNo", '10');
				comAjax.setCallback('mbr_chartCallback');
				//comAjax.ajax();
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
	
	function setLabelData(data,type) {
		if( type == 0 ) {
			if( data[21].split("=")[1]*1 == 0 ) {
				$("#imgAdjuster").text('MANUAL');
			} else {
				$("#imgAdjuster").text('AUTO');
			}
			
			if( data[22].split("=")[1]*1 == 0 ) {
				$("#imgSpeed").css("display","");
			} else {
				$("#imgSpeed").css("display","none");
			}
			
			for( var i=0;i<21;i++ ) {
				$("#lblRod"+i).text(convFormat(data[i].split("=")[1]*1,bScales[i]));
				$("#lblRod"+i).attr("title",toolTipText[i]);
			}
			
			for( var j=23;j<data.length;j++ ) {
				var tmp = data[j].split("=")[1]*1;
				var rest = (j-23) % 6;
				var intPart = (j-23 - rest)/6;
				if( rest == 0 ) {
					if( tmp < 1 ) $("#lblStatus"+(intPart)).text('I');
				} else if( rest == 1 ) {
					if( tmp < 1 ) $("#lblStatus"+(intPart)).text('O');
				} else if( rest == 2 ) {
					if( tmp > 0 ) $("#lblStatus"+(intPart)).text('S');
				} else if( rest == 3 ) {
					if( tmp > 0 ) $("#lblStatus"+(intPart)).text('X');
				} else if( rest == 5 ) {
					if( tmp > 0 ) $("#lblDrive"+(intPart)).text('I');
				} else if( rest == 6 ) {
					if( tmp > 0 ) {
						$("#lblDrive"+(intPart)).text('O');
					} else {
						if( !isNaN(tmp) && tmp < 0 ) {
							$("#lblDrive"+(intPart)).text('');
						}
					}
				}
			}
		} else {
			if( data[21].fValue*1 == 0 ) {
				$("#imgAdjuster").text('MANUAL');
			} else {
				$("#imgAdjuster").text('AUTO');
			}
			
			if( data[22].fValue*1 == 0 ) {
				$("#imgSpeed").css("display","");
			} else {
				$("#imgSpeed").css("display","none");
			}
			
			for( var i=0;i<21;i++ ) {
				$("#lblRod"+i).text(convFormat(data[i].fValue*1,bScales[i]));
				$("#lblRod"+i).attr("title",toolTipText[i]);
			}
			
			for( var j=23;j<data.length;j++ ) {
				var tmp = data[j].fValue*1;
				var rest = (j-23) % 6;
				var intPart = (j-23 - rest)/6;
				if( rest == 0 ) {
					if( tmp < 1 ) $("#lblStatus"+(intPart)).text('I');
				} else if( rest == 1 ) {
					if( tmp < 1 ) $("#lblStatus"+(intPart)).text('O');
				} else if( rest == 2 ) {
					if( tmp > 0 ) $("#lblStatus"+(intPart)).text('S');
				} else if( rest == 3 ) {
					if( tmp > 0 ) $("#lblStatus"+(intPart)).text('X');
				} else if( rest == 5 ) {
					if( tmp > 0 ) $("#lblDrive"+(intPart)).text('I');
				} else if( rest == 6 ) {
					if( tmp > 0 ) {
						$("#lblDrive"+(intPart)).text('O');
					} else {
						if( !isNaN(tmp) && tmp < 0 ) {
							$("#lblDrive"+(intPart)).text('');
						}
					}
				}
			}
		}
	}
	
	function createChart(xData,type) {
		var rodData = [];
		
		var colorSet = ['#8AD4E4','#FEC87F','#A8A4D1'];
		var minVal = 0;
		var maxVal = 100;
		
		for( var i=0;i<21;i++ ) {
			if( type == 0 ) {
				rodData.splice(i,1,convFormat(xData[i].split("=")[1]*1,8));
			} else {
				rodData.splice(i,1,convFormat(xData[i].fValue*1,8));
			}
			
			var rodTmp = [{
				name: 'rod',
				data: convFormat(rodData[i]*1)*1
			}];
			
			var rodConfig = {
				global: {
					svg: {
						classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
					},
					size: {
						width: 80,
						height: 172
					},
					color: {
						pattern: ['#A8A4D1']
					}
				},
				data: {
					type: 'bar', // 차트의 타입을 설정 
					json: rodTmp, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
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
						min: 0,
						max: 100
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
				},
				extend: {
					bar: {
						useBackground: true,
						background: {
							strokeWidth: 1,
							strokeColor: 'black'
						}
					}
				}
			};
			
			chart = new sb.chart("#rodChart"+i, rodConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.render();
		}
	}
	
	function toCSV() {
		timerOn = false;
		var comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl('/dcc/status/adjrodExcelExport');
		comSubmit.addParam("hogi",hogiHeader);
		comSubmit.addParam("xyGubun",xyHeader);
		comSubmit.submit();
		timerOn = true;
	}
	
	function toIMG() {
	 	timerOn = false;
		
		function doModal() {
			return new Promise(function(resolve,reject) {
				openModal('modal_loading');
				closeLayer('mouse_area');
				
				setTimeout(function() {
					resolve();
				},500);
			});
		}
		
		var d = new Date();
		var now = d.getFullYear()+convNum(d.getMonth()+1,2)+convNum(d.getDate(),3)+convNum(d.getHours(),0)+convNum(d.getMinutes(),1)+convNum(d.getSeconds(),1);
		
		doModal().then(function() {
			html2canvas($("#captureArea")[0]).then(canvas => {
				//saveAs(canvas.toDataURL('image/jpg'),"lime.jpg"); //다운로드 되는 이미지 파일 이름 지정
				saveAs(canvas.toDataURL(),"Status_AR_("+now+").jpg"); //다운로드 되는 이미지 파일 이름 지정
			});
			timerOn = true;
		});
	}
	
	function saveAs(uri, filename) {
		// 캡처된 파일을 이미지 파일로 내보냄
		var link = document.createElement('a');
		if (typeof link.download === 'string') {
			link.href = uri;
			link.download = filename;
			document.body.appendChild(link);
			link.click();
			document.body.removeChild(link);
			closeModal('modal_loading');
		} else {
			window.open(uri);
		}
	}
	
	function openModal(str) {
		/*openLayer(str);
		
		progressPos = Math.floor(Math.random()*3)+6;
		sleep(200).then(function() {
			fillProgress(1,progressPos);
		});
		sleep(1000).then(() => fillProgress(progressPos,progressPos+4));
		sleep(1000).then(() => fillProgress(progressPos+4,progressPos+7));
		sleep(1000).then(() => fillProgress(progressPos+7,21));*/
		$("#modal_loading").css("display","");
	}
	
	function closeModal(str) {
		$("#"+str).css("display","none");
	}
	
	function sleep(ms) {
		return new Promise((r) => setTimeout(r,ms));
	}
		
	function fillProgress(i,limit) {
		while( i < limit ) {
			$("#loading"+i).css("background-color","#2e5ce0");
			i++;
		}
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
		<div id="captureArea" class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>ADJUSTER ROD STATUS</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>ADJUSTER ROD STATUS</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap b_type">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item mg_left">
                            <div class="fx_form chart_sum color_1"><!-- color : #801517 -->
                                <span>STATUS</span>
                            </div>
						</div>
						<div class="fx_srch_item">
                            <div class="fx_form chart_sum color_1"><!-- color : #801517 -->
                                <span>I = FULL IN</span>
                            </div>
						</div>
						<div class="fx_srch_item">
                            <div class="fx_form chart_sum color_1"><!-- color : #801517 -->
                                <span>O = FULL IN</span>
                            </div>
						</div>
						<div class="fx_srch_item">
                            <div class="fx_form chart_sum color_1"><!-- color : #801517 -->
                                <span>S = FULL IN</span>
                            </div>
						</div>
						<div class="fx_srch_item">
                            <div class="fx_form chart_sum color_1"><!-- color : #801517 -->
                                <span>X = OUT OF SERVICE</span>
                            </div>
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item mg_left">
                            <div class="fx_form chart_sum color_3"><!-- color : #0e9fa1 -->
                                <span>DRIVE</span>
                            </div>
						</div>
						<div class="fx_srch_item">
                            <div class="fx_form chart_sum color_3"><!-- color : #0e9fa1 -->
                                <span>I = IN REQUESTED</span>
                            </div>
						</div>
						<div class="fx_srch_item">
                            <div class="fx_form chart_sum color_3"><!-- color : #0e9fa1 -->
                                <span>O = OUT REQUESTED</span>
                            </div>
						</div>
						<div class="fx_srch_item">
                            <div class="fx_form chart_sum color_5"><!-- color : #ED1E24 -->
                                <span>SIGNFICANT ADJ</span>
                            </div>
						</div>
						<div class="fx_srch_item"></div>
					</div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->
            <!-- barchart_layout -->
            <div class="barchart_layout line full">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="javascript:toCSV();">엑셀로 저장</a></li>
                        <li><a href="#none" onclick="javascript:toIMG();">화면저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->
                <div class="barchart_line_wrap">
                    <div class="barchart_legend left">
                        <span>0</span>
                        <span>20</span>
                        <span>40</span>
                        <span>60</span>
                        <span>80</span>
                        <span>100</span>
                    </div>
                    <div class="barchart_line">
                        <span class="red">11</span>
                        <div id="rodChart10" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod10">100.71</label></span>
                        <span><label id="lblDrive10">I10</label></span>
                        <span><label id="lblStatus10">X10</label></span>
                    </div>
                    <div class="barchart_line">
                        <span>15</span>
                        <div id="rodChart14" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod14">100.71</label></span>
                        <span><label id="lblDrive14">I14</label></span>
                        <span><label id="lblStatus14">X14</label></span>
                    </div>
                    <div class="barchart_line">
                        <span>7</span>
                        <div id="rodChart6" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod6">100.71</label></span>
                        <span><label id="lblDrive6">I6</label></span>
                        <span><label id="lblStatus6">X6</label></span>
                    </div>
                    <div class="barchart_line">
                        <span>1</span>
                        <div id="rodChart0" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod0">100.71</label></span>
                        <span><label id="lblDrive0">I0</label></span>
                        <span><label id="lblStatus0">X0</label></span>
                    </div>
                    <div class="barchart_line">
                        <span>21</span>
                        <div id="rodChart20" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod20">100.71</label></span>
                        <span><label id="lblDrive20">I20</label></span>
                        <span><label id="lblStatus20">X20</label></span>
                    </div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line">
                        <span class="red">2</span>
                        <div id="rodChart1" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod1">100.71</label></span>
                        <span><label id="lblDrive1">I1</label></span>
                        <span><label id="lblStatus1">X1</label></span>
                    </div>
                    <div class="barchart_line">
                        <span class="red">18</span>
                        <div id="rodChart17" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod17">100.71</label></span>
                        <span><label id="lblDrive17">I17</label></span>
                        <span><label id="lblStatus17">X17</label></span>
                    </div>
                    <div class="barchart_line">
                        <span class="red">6</span>
                        <div id="rodChart5" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod5">100.71</label></span>
                        <span><label id="lblDrive5">I5</label></span>
                        <span><label id="lblStatus5">X5</label></span>
                    </div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line">
                        <span class="red">16</span>
                        <div id="rodChart15" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod15">100.71</label></span>
                        <span><label id="lblDrive15">I15</label></span>
                        <span><label id="lblStatus15">X15</label></span>
                    </div>
                    <div class="barchart_line">
                        <span class="red">4</span>
                        <div id="rodChart3" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod3">100.71</label></span>
                        <span><label id="lblDrive3">I3</label></span>
                        <span><label id="lblStatus3">X3</label></span>
                    </div>
                    <div class="barchart_line">
                        <span class="red">20</span>
                        <div id="rodChart19" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span><label id="lblRod19">100.71</label></span>
                        <span><label id="lblDrive19">I19</label></span>
                        <span><label id="lblStatus19">X19</label></span>
                    </div>
                    <div class="barchart_legend right">
                        <span>ROD No</span>
                        <span class="green"><label id="imgSpeed">AUTO</label></span>
                        <span>SPEED</span>
                        <span>CONTROL</span>
                    </div>
                    <div class="barchart_legend fixed">
                        <span>% IN</span>
                        <span class="green">DRIVE</span>
                        <span>STATUS</span>
                        <span class="green mid">MODE</span>
                        <span>STATUS</span>
                        <span class="green">DRIVE</span>
                        <span>% IN</span>
                    </div>
                </div>
                <div class="barchart_line_middle"><label id="imgAdjuster">MANUAL</label></div>
                <div class="barchart_line_wrap rev">
                    <div class="barchart_legend left">
                        <span>0</span>
                        <span>20</span>
                        <span>40</span>
                        <span>60</span>
                        <span>80</span>
                        <span>100</span>
                    </div>                    
                    <div class="barchart_line">
                        <span><label id="lblStatus8">X8</label></span>
                        <span><label id="lblDrive8">I8</label></span>
                        <span><label id="lblRod8">100.71</label></span>
                        <div id="rodChart8" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span class="red">9</span>
                    </div>
                    <div class="barchart_line">
                        <span><label id="lblStatus12">X12</label></span>
                        <span><label id="lblDrive12">I12</label></span>
                        <span><label id="lblRod12">100.71</label></span>
                        <div id="rodChart12" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span class="red">13</span>
                    </div>
                    <div class="barchart_line">
                        <span><label id="lblStatus7">X7</label></span>
                        <span><label id="lblDrive7">I7</label></span>
                        <span><label id="lblRod7">100.71</label></span>
                        <div id="rodChart7" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span>8</span>
                    </div>
                    <div class="barchart_line">
                        <span><label id="lblStatus13">X13</label></span>
                        <span><label id="lblDrive13">I13</label></span>
                        <span><label id="lblRod13">100.71</label></span>
                        <div id="rodChart13" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span>14</span>
                    </div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line">
                        <span><label id="lblStatus2">X2</label></span>
                        <span><label id="lblDrive2">I2</label></span>
                        <span><label id="lblRod2">100.71</label></span>
                        <div id="rodChart2" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span class="red">3</span>
                    </div>
                    <div class="barchart_line">
                        <span><label id="lblStatus18">X18</label></span>
                        <span><label id="lblDrive18">I18</label></span>
                        <span><label id="lblRod18">100.71</label></span>
                        <div id="rodChart18" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span class="red">19</span>
                    </div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line">
                        <span><label id="lblStatus4">X4</label></span>
                        <span><label id="lblDrive4">I4</label></span>
                        <span><label id="lblRod4">100.71</label></span>
                        <div id="rodChart4" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span class="red">5</span>
                    </div>
                    <div class="barchart_line">
                        <span><label id="lblStatus16">X16</label></span>
                        <span><label id="lblDrive16">I16</label></span>
                        <span><label id="lblRod16">100.71</label></span>
                        <div id="rodChart16" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span class="red">17</span>
                    </div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line"></div>
                    <div class="barchart_line">
                        <span><label id="lblStatus11">X11</label></span>
                        <span><label id="lblDrive11">I11</label></span>
                        <span><label id="lblRod11">100.71</label></span>
                        <div id="rodChart11" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span class="red">12</span>
                    </div>
                    <div class="barchart_line">
                        <span><label id="lblStatus9">X9</label></span>
                        <span><label id="lblDrive9">I9</label></span>
                        <span><label id="lblRod9">100.71</label></span>
                        <div id="rodChart9" class="barchart" style="height:160px;padding-top:3px"></div>
                        <span class="red">10</span>
                    </div>
                    <div class="barchart_legend right">
                        <span>ROD No</span>
                    </div>                     
                </div>
            </div>
            <!-- //barchart_layout -->            
		</div>
		<!-- //contents -->
                <!-- Loading -->
                <div class="loader_wrap" id="modal_loading" style="display:none">
                	<div class="loader_circle"></div>
                	<div class="loader_line_mask">
                		<div class="loader_line"></div>
                	</div>
               	</div>
               	<!-- //Loading -->
	</div>
			<form id="reloadFrm" type="hidden"></form>
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

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_loading2" align="center">
<!-- pop_contents -->
<div class="pop_contents" style="max-height:460px;max-width:800px;">
<table style="display:table;width:100%;table-layout:fixed;border:1px solid rgba(0,0,0,0.1);height:50px">
	<tbody>
		<tr>
		<c:forEach var="i" begin="1" end="20" step="1">
			<td id="loading${i}" style="border:1px solid rgba(0,0,0,0.1);background-color:#ffffff;display:table-cell"></td>
		</c:forEach>
		</tr>
	</tbody>
</table>
</div>
<!-- pop_contents -->
</div>
<!-- //layer_pop_wrap -->
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

