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

<link rel="stylesheet" href="/resources/sbchart/sbchart.css">
<script type="text/javascript" src="/resources/sbchart/sbchart.js"></script>

<script type="text/javascript">
	var hogiHeader = '${UserInfo.hogi}' != "undefined" && '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
	var xyHeader = '${UserInfo.xyGubun}' != "undefined" && '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";
	var currentSelGrp = "";
	var grpNos = [];
	var selGrpNm = "";
	var colorList = ['#801517','#B9529F','#1EBCBE','#282A73','#ED1E24','#7A57A4','#70CBD1','#364CA0'];
	var bGroupFlag = false;
	var hideLegnedItems = [];
	var lastGrp = '';
	var swSort = false;
	var gHogi,gXYGubun;
	var gIOType = 'AI';
	var ioEn = false;
	var scEn = false;
	var gChartConfig = {};
	var xPos = '';
	var gFinish = 0;
	var isTimer = false;
	var progressPos = 0;
	var gInterval = 5000;
	var timer;
	var showX = true;
	var showY = true;
	var lineBold = 1;
	var setCrossHair = false;
	var selectedID = '';
	var ioListArray = [];
	var xData = [];
	var xAxis = [];
	var updatedGrpNo = '0';
	var activeCharts = [];
	var tiSeq,tHogi,tXy,tIOType,tLoopName,tDescr,tAddr,tBit,tMinVal,tMaxVal,tCore;
	var locationHost;
	var customRange = [];
	var selTdID = '';
	var lblDataListAjax = {};
	var DccTagInfoListAjax = {};
	var maxListAjax = {};
	var minListAjax = {};
	var tagMaxListAjax = {};
	var tagMinListAjax = {};
	var dtabMaxListAjax = {};
	var dtabMinListAjax = {};
	var timerOn = false;
	
	var chart;
	var chart2;
	var charts = [];
	
	$(function() {
		
		locationHost = window.location.host;
		
		if( locationHost.indexOf('222') > -1 ) {
			$(document.body).delegate('#4','click',function() {
				hogiHeader = '4';
			});
		} else {
			$(document.body).delegate('#3','click',function() {
				hogiHeader = '3';
			});
		}
		
		if( '${BaseSearch.gHis}' == 'H' ) {
			$("input:radio[id='H']").prop("checked",true);
			//cmdHistorical_click();
		} else {
			$("input:radio[id='R']").prop("checked",true);
			//cmdReal_click();
		}
		
		/*if( $("input:radio[id='4']").is(":checked") ) {
			hogiHeader = "4";
		} else {
			hogiHeader = "3";
		}
		if( $("input:radio[id='Y']").is(":checked") ) {
			xyHeader = "Y";
		} else {
			xyHeader = "X";
		}*/
		
		currentSelGrp = $("#cboUGrpName option:selected").val();
		
		var grpList = '${DccGroupList}'.split(', groupNo=');
		for( var i=1;i<grpList.length;i++ ) {
			grpNos.push('opt'+grpList[i].substr(0,grpList[i].indexOf('}')));
		}
		
		$(document.body).delegate('#3', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '3';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#4', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '4';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#X', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'X';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#Y', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'Y';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate("#setFrmIO","click",function() {
			gHogi = $("#cboHogi option:selected").val();
			gXYGubun = $("#cboXYGubun option:selected").val();
			gIOType = $("#cboIOType option:selected").val();
			openModal('modal_1');
			
			if( $("#mouse_area").css("display") != 'none' ) $("#mouse_area").css("display","none");
		});
		
		$(document.body).delegate('#cboUGrpName', 'click', function() {
			cboUGrpName_click(0);
		});
		
		$(document.body).on("change", "#cboUGrpName", function() {
			cboUGrpName_change();
		});
		
		$(document.body).delegate('#cmdUp', 'click', function() {
			cmdUp_click();
		});
		
		$(document.body).delegate('#cmdDown', 'click', function() {
			cmdDown_click();
		});
		
		$(document.body).delegate('#cmdInsert', 'click', function() {
			cmdInsert_click(1);
		});
		
		$(document.body).delegate('#cmdDelete', 'click', function() {
			cmdDelete_click(1);
		});
		
		$(document.body).delegate('#cmdUpdate', 'click', function() {
			cmdUpdate_click();
		});
		
		$(document.body).delegate('#cmdOk', 'click', function() {
			cmdOK_click();
		});
		
		$(document.body).delegate('#cmdGroupInsert', 'click', function() {
			bGroupFlag = true;
			$("#txtTitle").val('');
			
			var tableBody = '';
			for( var t=0;t<8;t++ ) {
				tableBody += '<tr>'
						   + '	<td class="tc"></td>'
						   + '	<td class="tc"></td>'
						   + '	<td></td>'
						   + '	<td class="tc"></td>'
						   + '	<td class="tc"></td>'
						   + '	<td class="tc"></td>'
						   + '	<td class="tc"></td>'
						   + '	<td class="tc"></td>'
						   + '	<td class="tc"></td>'
						   + '	<td class="tc" style="display:none"></td>'
						   + '</tr>';
			}
			
			$("#lvIolistTable").empty();
			$("#lvIolistTable").append(tableBody);
		});
		
		$(document.body).delegate('#tagFind', 'click', function() {
			tagFind_click();
		});
		
		$(document.body).delegate('#tagFindAll', 'click', function() {
			tagFindAll_click();
		});
		
		$(document.body).delegate('#lvIOListTable tr', 'click', function() {
			$(this).addClass("highlight");
			$(this).siblings().removeClass("highlight");
		
			//var ioListArray = getLvIOList();
			if( ioListArray.length > 0 ) {
				if(this.id != 'itemHeaders') {
					selectedID = $(this).context.children[9].textContent+'_'+$(this).context.children[0].textContent;
					swSort = true;
					
					//var gubun = $(this).context.children[0].textContent == '' ? 'D' : $(this).context.children[0].textContent;
					$("#cboHogi").val($(this).context.children[0].textContent == '' ? '${UserInfo.hogi}': $(this).context.children[0].textContent);
					$("#cboXYGubun").val($(this).context.children[1].textContent == '' ? '${UserInfo.xyGubun}' : $(this).context.children[1].textContent);
					$("#txtLOOPNAME").val($(this).context.children[2].textContent);
					$("#cboIOType").val($(this).context.children[3].textContent == '' ? gIOType : $(this).context.children[3].textContent);
					$("#txtADDRESS").val($(this).context.children[4].textContent);
					if( $("#cboIOType").val() == 'DI' || $("#cboIOType").val() == 'DO' || $("#cboIOType").val() == 'SC' ) {
						ioEn = true;
						$("#txtIOBIT").attr("disabled",false);
						$("#txtIOBIT").val($(this).context.children[5].textContent);
					} else {
						ioEn = false;
						$("#txtIOBIT").attr("disabled",true);
						$("#txtIOBIT").val('');
					}
					$("#txtMin").val($(this).context.children[6].textContent);
					$("#txtMax").val($(this).context.children[7].textContent);
					if( $(this).context.children[8].textContent == '1' ) {
						$("#chkSaveCore").prop("checked",true);
					}
					$("#txtISeq").val($(this).context.children[9].textContent);
					//$("#txtGUBUN").val(gubun);
					
					if( $("#cboIOType").val() == 'SC' ) {
						scEn = true;
						$("#chkSaveCore").attr("disabled",false);
						if( $("input:checkbox[id='chkSaveCore']").is(":checked") ) {
							ioEn = true;
							$("#txtIOBIT").attr("disabled",false);
						} else {
							ioEn = false;
							$("#txtIOBIT").attr("disabled",true);
						}
					} else {
						scEn = false;
						$("#chkSaveCore").attr("disabled",true);
					}
					
					gIOType = $("#cboIOType").val();
					
					txtADDRESS_LostFocus();
					
					swSort = false;
				}
			}
		});
		
		$(document.body).delegate('#txtMax','keypress',function() {
			if( window.event.keyCode == 13 ) {
				if( $("#txtADDRESS").val() != '' && typeof $("#txtADDRESS").val() != 'undefined' ) {
					cmdUpdate_click();
				}
			}
		});
		
		$(document.body).delegate('#txtMin','keypress',function() {
			if( window.event.keyCode == 13 ) {
				if( $("#txtADDRESS").val() != '' && typeof $("#txtADDRESS").val() != 'undefined' ) {
					cmdUpdate_click();
				}
			}
		});
		
		$(document.body).delegate('#tagSearchList tr','click',function() {
			$(this).addClass("highlight");
			$(this).siblings().removeClass("highlight");
			
			tHogi = $(this).context.children[0].textContent == '' ? '${UserInfo.hogi}': $(this).context.children[0].textContent;
			tXy = $(this).context.children[1].textContent == '' ? '${UserInfo.xyGubun}' : $(this).context.children[1].textContent;
			tLoopName = $(this).context.children[2].textContent;
			tDescr = $(this).context.children[3].textContent;
			tIOType = $(this).context.children[4].textContent == '' ? gIOType : $(this).context.children[4].textContent;
			tAddr = $(this).context.children[5].textContent;
			tBit = $(this).context.children[6].textContent;
			tMinVal = $(this).context.children[7].textContent;
			tMaxVal = $(this).context.children[8].textContent;
			tCore = $(this).context.children[9].textContent;
			tiSeq = $(this).context.id.substring(2,$(this).context.id.length);
		});
		
		$(document.body).delegate('#tagSearchSelect','click',function() {
			$("#cboHogi").val(tHogi);
			$("#cboXYGubun").val(tXy);
			$("#txtLOOPNAME").val(tLoopName == '' ? tIOType+' '+tAddr+' '+tBit: tLoopName);
			$("#cboIOType").val(tIOType);
			$("#txtADDRESS").val(tAddr);
			$("#txtIOBIT").val(tBit);
			$("#txtMin").val(tMinVal);
			$("#txtMax").val(tMaxVal);
			if( tCore == '1' ) {
				$("#chkSaveCore").prop("checked",true);
			}
			$("#txtISeq").val(tiSeq);
	
			if( tIOType == 'DI' || tIOType == 'DO' ) {
				$("#txtMin").val("0");
				$("#txtMax").val("1");
			}
			
			if( tIOType == 'DI' || tIOType == 'DO' || (tIOType == 'SC' && tCore == '1') ) {
				$("#txtIOBIT").attr("disabled",false);
			} else {
				$("#txtIOBIT").attr("disabled",true);
				$("#txtIOBIT").val('');
			}
			if( tIOType == "SC" ) {
				$("#chkSaveCore").attr("disabled",false);
				if( tCore == '1' ) {
					$("#txtIOBIT").attr("disabled",false);
				} else {
					$("#txtIOBIT").attr("disabled",true);
				}
			} else {
				$("#chkSaveCore").attr("disabled",true);
			}
			
			gIOType = $("#cboIOType").val();
			
			closeModal('modal_3');
		});
		
		//setTimer(1);
		//doInterval(gInterval);
		
	});
		
	function setTimer(num){
		if( num == 0 ) {
			var is4Hogi = $("input:radio[id='4']").is(":checked");
			var isY = $("input:radio[id='Y']").is(":checked");
			
			//var comSubmit = new ComSubmit("selGrpFrm");
			
			if( is4Hogi ) {
				if( hogiHeader != '4' ) {
					hogiHeader = '4';
				}
			} else {
				if( hogiHeader != '3' ) {
					hogiHeader = '3';
				}
			}
			if( isY ) {
				if( xyHeader != 'Y' ) {
					xyHeader = 'Y';
				}
			} else {
				if( xyHeader != 'X' ) {
					xyHeader = 'X';
				}
			}
			
			var grpNo = $("#cboUGrpName option:selected").val();
	
			var comAjax = new ComAjax("reloadGrpFrm");
			comAjax.addParam('hogiHeader',hogiHeader);
			comAjax.addParam('xyHeader',xyHeader);
			comAjax.addParam('sHogi',hogiHeader);
			comAjax.addParam('sXYGubun',xyHeader);
			comAjax.addParam('uMenuNo','32');
			comAjax.addParam('fixed','S');
			comAjax.addParam('sGrpID','${UserInfo.id}');
			comAjax.addParam('uGrpNo',grpNo);
			comAjax.setUrl('/dcc/trend/reloadGrp');
			comAjax.setCallback('mbr_reloadGrpCallback');
			comAjax.ajax();
			
			$("#cboUGrpName").val(grpNo);
	
			if( $("input:radio[id='H']").is(":checked") ) {
				cmdHistorical_click();
			} else {
				doInterval();
			}
		} else {
			if( $("input:radio[id='H']").is(":checked") ) {
				cmdHistorical_click();
			} else {
				doInterval();
			}
		}
	}
		
	function doInterval() {
		timer = setTimeout(function run() {
				triggerChart();
				//console.log('tick >>> '+lastGrp);
			//comAjax.ajax();
			setTimeout(run, gInterval);
		}, gInterval);
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
	
	function pressAddr() {
		if( window.event.keyCode == 13 ) {
			txtADDRESS_LostFocus();
		}
	}
	
	function txtADDRESS_LostFocus() {
		if( gIOType == "DI" || gIOType == "DO" || gIOType == "SC" ) {
			ioEn = true;
			$("#txtIOBIT").attr("disabled",false);
		} else {
			$("#txtIOBIT").val('');
		}
		if( gIOType == "SC" ) {
			scEn = true;
			$("#chkSaveCore").attr("disabled",false);
			if( $("#chkSaveCore").is('checked') ) {
				ioEn = true;
				$("#txtIOBIT").attr("disabled",false);
			} else {
				ioEn = false;
				$("#txtIOBIT").attr("disabled",true);
			}
		} else {
			scEn = false;
			$("#chkSaveCore").attr("disabled",true);
		}
		
		$("#txtADDRESS").css("color","black");
		if( $("#txtADDRESS").val() == '' || $("#txtADDRESS").val() == null ) {
			$("#txtMax").val('');
			$("#txtMin").val('');
			$("#txtIOBIT").val('');
			$("#txtISeq").val('');
			$("#txtGUBUN").val('');
			$("#txtMax").css("background","#FFFFFF");
			$("#txtMin").css("background","#FFFFFF");
			$("#txtADDRESS").css("color","#000000");
		} else {
			if( ioEn ) {
				if( $("#txtIOBIT").val() != '' && typeof $("#txtIOBIT").val() != 'undefined' ) {
					ssql(swSort);
				} else {
					$("#txtMax").val('');
					$("#txtMin").val('');
					$("#txtIOBIT").val('');
					$("#txtIOBIT").focus();
				}
			} else {
				ssql(swSort);
			}
		}
	}
	
	function ssql(swSort) {
		//console.log(swSort);
	
		$("#txtADDRESS").css("color","black");
		$("#txtMax").css("background","#FFFFFF");
		$("#txtMin").css("background","#FFFFFF");
		
		var ioType = gIOType;
		if( typeof ioType == 'undefined' ) ioType = 'AI';
		//if( ioType == 'AO' ) ioType = 'DT';
		
		if( swSort ) {
			if($("input:checkbox[id='chkSaveCore']").is(":checked") ) {
				$("#txtADDRESS").css("color","#FF00FF");
			} else {
				$("#txtADDRESS").css("color","#000000");
			}
		} else {
			//var page = typeof $("#pageNo2").val() == 'undefined' ? 1 : 2;
			var comAjax = new ComAjax("ioListForm");
			comAjax.setUrl("/dcc/trend/ssql");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("ioType", ioType);
			comAjax.addParam("cboHogi", typeof $("#cboHogi option:selected").val() == 'undefined' ? '' : $("#cboHogi option:selected").val());
			comAjax.addParam("cboXY", typeof $("#cboXYGubun option:selected").val() == 'undefined' ? '' : $("#cboXYGubun option:selected").val());
			comAjax.addParam("ioBit", typeof $("#txtIOBIT").val() == 'undefined' ? '' : $("#txtIOBIT").val() );
			comAjax.addParam("SaveCore", $("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0");
			comAjax.addParam("address", typeof $("#txtADDRESS").val() == 'undefined' ? "" : $("#txtADDRESS").val());
			comAjax.setCallback("mbr_ssqlCallback");
			comAjax.ajax();
			
			setIOAjax();
		}
	}
	
	function setIOAjax() {
		if( $("#ajaxHogi").val() != null ) $("#cboHogi").val($("#ajaxHogi").val()).prop("selected",true);
		if( $("#ajaxXYGubun").val() != null ) $("#cboXYGubun").val($("#ajaxXYGubun").val()).prop("selected",true);
		if( $("#ajaxLoopName").val() != null ) $("#txtLOOPNAME").val($("#ajaxLoopName").val());
		if( $("#ajaxIOType").val() != null || typeof $("#ajaxIOType").val() == 'undefined' ) $("#cboIOType").val($("#ajaxIOType").val()).prop("selected",true);
		if( $("#ajaxAddress").val() != null ) $("#txtADDRESS").val($("#ajaxAddress").val());
		//if( $("#ajaxIOBit").val() != null ) $("#txtIOBIT").val($("#ajaxIOBit").val());
		if( $("#ajaxMin").val() != null ) $("#txtMin").val($("#ajaxMin").val());
		if( $("#ajaxMax").val() != null ) $("#txtMax").val($("#ajaxMax").val());
		if( $("#ajaxSaveCore").val() == '1' ) $("input:checkbox[id='chkSaveCore']").prop("checked",true);
		if( $("#ajaxISeq").val() != null ) $("#txtISeq").val($("#ajaxISeq").val());
		
		if( $("#ajaxFastIoChk").val() == '1' ) {
			$("#txtADDRESS").css("color","#FF00FF");
		} else {
			$("#txtADDRESS").css("color","#000000");
		}
		$("#txtMin").css("background","#FFFFFF");
		$("#txtMax").css("background","#FFFFFF");
	}
	
	function getSub(data,seq) {
		var tmpData = JSON.parse(JSON.stringify(data));
		var tmpVal = tmpData[seq][DccTagInfoListAjax[seq].dataLoop];
		var range = Math.abs(maxListAjax[seq]*1 - minListAjax[seq]*1);
		var lowVal = maxListAjax[seq]*1 > minListAjax[seq]*1 ? minListAjax[seq]*1 : maxListAjax[seq]*1;
		var convVal = 0;

		/*console.log(tmpData);
		console.log(tmpData[seq]);
		console.log(lblDataListAjax[seq]);
		console.log(DccTagInfoListAjax[seq]);
		console.log(tmpVal+', '+range+', '+lowVal+', '+convVal);*/
		
		if( tmpVal == 'undefined' || typeof tmpVal == 'undefined' || tmpVal == null || tmpVal == 'null' ) {
			convVal = 100;
		} else {
			if( range != 0 ) {
				convVal = (tmpVal-lowVal)/range*100;
			} else {
				convVal = 100;
			}
		}
		
		var tmp = {
			name: tmpData[seq].name,
			data: convVal
		}
		
		return tmp;
	}
	
	function cboUGrpName_click(type) {
		for( var i=1;i<21;i++ ) {
			$("#loading"+i).css("backgroundColor","rgb(255, 255, 255)");
		}
	
		var selGrpName = $("#cboUGrpName option:selected").val();
		var his = $("input:radio[id='H']").is(":checked") ? 'H' : 'R';
		
		if( selGrpName != lastGrp || type == 1 ) {
			//console.log('trigger');
			triggerChart();
		}
	}
	
	function cboUGrpName_blur() {
		closeModal('modal_loading');
	}
	
	function cboUGrpName_change() {
		var his = $("input:radio[id='H']").is(":checked") ? 'H' : 'R';
		customRange = [];
		
		function doModal() {
			return new Promise(function(resolve,reject) {
				openModal('modal_loading');
				
				setTimeout(function() {
					resolve();
				},500);
			});
		}
		
		doModal().then(function() {
			triggerChart();
		
			closeModal('modal_loading');
		});
	}

	function createChart2(xData,axisConfigs){
		
		function chartPart() {
			return new Promise(function(resolve,reject) {
				var len = xData.length-1;
				var unit = Math.floor(len/10);
				var pointF = '';
				var xDataSub = [];
				
				var chartConfigs = [];
				
				for( var ci=0;ci<lblDataListAjax.length;ci++ ) {
					var isReverse = false;
					var refColor = '';
					var reverseColor = '';
					if( minListAjax[ci]*1 < maxListAjax[ci] ) {
						isReverse = false;
						refColor = '#81DE81';
						reverseColor = '#E7EAEC';
					} else {
						isReverse = true;
						refColor = '#E7EAEC';
						reverseColor = '#81DE81';
					}
					var chartConfig = {};
					var xDataSub = getSub(xData,ci);
					chartConfig = {
						global: {
							svg: {
								classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
							},
							size: {
								width: 890,
								height: 30
							},
							color: {
								pattern: [refColor]
							}
						},
						data: {
							type: 'bar', // 차트의 타입을 설정 
							json: [xDataSub], // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
							keys: { // json 형태의 데이터를 사용 시, 필수로 keys 속성을 사용해야 함
								x: "name", // 각각의 x축 이름을 chartData의 name값으로 설정 
								value: ['data'] // chartData의 2015, 2016, 2017 데이터를 보여주도록 설정
							}
						},
						grid: {
							x:{show:false},
							y:{show:false}
						},
						extend: {
							bar: {
								useBackground: true,
								yDirectionReverse: isReverse,
								background: {
									color: reverseColor,
									strokeColor: refColor,
									strokeWidth: 0
								}
							}
						},
						legend: {
							show: false
						},
						tooltip: {
							show: false
						}
					};
					
					chartConfig['axis'] = axisConfigs[ci];
					
					chartConfigs.splice(ci,1,chartConfig);
				}
		        
		        for( var cf=0;cf<lblDataListAjax.length;cf++ ) {
					var areaId = "#chartArea"+cf;
					if( DccTagInfoListAjax[cf].dataLoop != '' && !isNaN(chartConfigs[cf]['data']['json'][0]['data']) ) {

						//console.log(chartConfigs[cf]);
						gChartConfig = chartConfigs;
						chart = new sb.chart(areaId, chartConfigs[cf]); // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
						chart.render(); // render 메소드를 사용해야 차트가 그려짐 (동적으로 사용 시에도 마지막에 꼭 render()를 써줘야 변경한 값들이 반영되어 보여집니다.)
						charts.splice(cf,1,chart);
					} else {
						chartConfigNull = {
							global: {
								svg: {
									classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
								},
								size: {
									width: 890,
									height: 30
								},
								color: {
									pattern: ["#E7EAEC"]
								}
							},
							data: {
								type: 'bar', // 차트의 타입을 설정 
								json: [{name:'0', data:100}], // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
								keys: { // json 형태의 데이터를 사용 시, 필수로 keys 속성을 사용해야 함
									x: "name", // 각각의 x축 이름을 chartData의 name값으로 설정 
									value: ['data'] // chartData의 2015, 2016, 2017 데이터를 보여주도록 설정
								}
							},
							axis: {
								rotated:true,
								x:{
									show:false,
									padding:0
								},
								y:{
									show:false,
									min:0,
									max:100,
									padding:0
								}
							},	
							grid: {
								x:{show:false},
								y:{show:false}
							},
							extend: {
								bar: {
									useBackground: true,
									yDirectionReverse: true,
									background: {
										color: '#81DE81',
										strokeColor: '#E7EAEC',
										strokeWidth: 0
									}
								}
							},
							legend: {
								show: false
							},
							tooltip: {
								show: false
							}
						};
						chart = new sb.chart(areaId, chartConfigNull); // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
						chart.render(); // render 메소드를 사용해야 차트가 그려짐 (동적으로 사용 시에도 마지막에 꼭 render()를 써줘야 변경한 값들이 반영되어 보여집니다.)
						charts.splice(cf,1,chart);
					}
				}
		        
				for( var k=0;k<16-lblDataListAjax.length;k++ ) {
	        		$("#tagNameData"+(15-k)).text('');
	        		$("#lblData"+(15-k)).text('');
	        		$("#minData"+(15-k)).text('');
	        		$("#maxData"+(15-k)).text('');
	        		$("#unitData"+(15-k)).text('');
	        	}

		        resolve();
			});
		}
		
		chartPart().then(function() {
			
			closeModal('modal_loading');
		});
	}
	
	function triggerChart() {
		var selGrpName = $("#cboUGrpName option:selected").val();
		lastGrp = selGrpName;
		
		if( selGrpName != 'null' ) {
			var startDate = "";
			var endDate = "";
			if( $("#selectSDate").val() != null && typeof $("#selectSDate").val() != 'undefined' && $("#selectSDate").val() != '' ) {
				startDate = $("#selectSDate").val();//+':00.000';
				endDate = $("#selectEDate").val();//+':00.000';
				
				if( startDate.length < 19 ) startDate = startDate+':00.000';
				if( endDate.length < 19 ) endDate = endDate+':00.000';
			}
			
			xData = [];
			
			var comAjax = new ComAjax("selGrpFrm");
			comAjax.setUrl("/dcc/trend/changeGrpNameBar");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("startDate", startDate);
			comAjax.addParam("endDate", endDate);
			comAjax.addParam('sUGrpNo',selGrpName);
			comAjax.addParam("fixed",'S');
			comAjax.addParam("sMenuNo",'32');
			comAjax.addParam("sGrpID",'${UserInfo.id}');
			comAjax.setCallback("trendCallback");
			comAjax.ajax();
			
			var axisConfigs = [];
			var axisConfig = {};
			var axesInfo = {};

			var chartAreaBody = $("#divChart");
			var chartAreaBodyStr = '';
			var total = lblDataListAjax.length < 8 ? 8 : lblDataListAjax.length;
			for( var c=0;c<total;c++ ) {
				chartAreaBodyStr += '<div id="chartArea'+c+'" style="height:30px;width:900px"></div>';
			}
			
			chartAreaBody.empty();
			chartAreaBody.append(chartAreaBodyStr);
			
			for( var ty=1;ty<lblDataListAjax.length+1;ty++ ) {
				var minVal = minListAjax[ty-1]*1;
				var maxVal = maxListAjax[ty-1]*1;// > minVal ? hVal[ty-1]*1 : minVal+1;
				var yInfos = {
					show: false,
					min: 0,
					max: 100,
					padding: 0
				}
				
				axisConfig['y'] = yInfos;
				var tmpAxisConf = JSON.parse(JSON.stringify(axisConfig));
				
				axesInfo['y'] = DccTagInfoListAjax[ty-1].dataLoop;
				tmpAxisConf['axes'] = JSON.parse(JSON.stringify(axesInfo));
				tmpAxisConf['rotated'] = true;
				tmpAxisConf['x'] = {
					show:false,
					padding: 0
				};
				
				axisConfigs.push(tmpAxisConf);
			}

			for( var j=0;j<lblDataListAjax.length;j++ ) {
				
				var tJson = {};
				tJson['name'] = $("#lblDate").text().substring(5);
				for( var ti=1;ti<=lblDataListAjax.length;ti++ ) {
					var key = DccTagInfoListAjax[j].dataLoop;
					var val = lblDataListAjax[j].fValue*1;
					tJson[key] = val;
				}
				xData.push(tJson);
			}
			
			xPos = xData[0].name+'||'+xData[xData.length-1].name;
	
			axisConfig['axes'] = axesInfo;
			if( xData[0].name != "" && xData[0].name != "undefined" ) createChart2(xData,axisConfigs);
		} else {
		}
	}
	
	function textClear(str) {
		swSort = true;
		
		if( str != 'modal_3' ) {
			$("#ajaxHogi").val('3');
			$("#ajaxXYGubun").val('X');
			$("#ajaxLoopName").val('');
			$("#ajaxIOType").val('AI');
			$("#ajaxAddress").val('');
			$("#ajaxIOBit").val('');
			$("#ajaxMin").val('');
			$("#ajaxMax").val('');
			$("#ajaxSaveCore").val('');
			$("#ajaxFastIoChk").val('');
			$("#ajaxISeq").val('');
	
			$("#iSeqMod").val('|==SEP==|');
			$("#xyGubunMod").val('|==SEP==|');
			$("#DescrMod").val('|==SEP==|');
			$("#ioTypeod").val('|==SEP==|');
			$("#addressMod").val('|==SEP==|');
			$("#ioBitMod").val('|==SEP==|');
			$("#minValMod").val('|==SEP==|');
			$("#maxValMod").val('|==SEP==|');
			$("#saveCoreMod").val('|==SEP==|');
			$("#gubunMod").val('|==SEP==|');
			$("#iSeqMod").val('|==SEP==|');
		} else {
			$("#cboTagHogi").val('3');
			$("#cboTagIOType").val('AI');
			$("#chkOpt1").prop('chkeced',false);
			$("#chkOpt2").prop('chkeced',false);
			$("#findData").val('');
		}
		
		//$("#txtISeq").val('');
		$("#cboHogi").val('3');
		$("#cboXYGubun").val('X');
		$("#txtLOOPNAME").val('');
		$("#cboIOType").val('AI');
		$("#txtADDRESS").val('');
		$("#txtIOBIT").val('');
		$("#txtMin").val('');
		$("#txtMax").val('');
		$("input:checkbox[id='chkSaveCore']").prop("checked",false);
		
		swSort = false;
	}
	
	function cmdInsert_click(type) {
		var iSeqAdd = $("#txtISeq").val();
		//var gubunAdd = $("#txtGUBUN").val();
		var gubunAdd = 'D';
		var hogiAdd = $("#cboHogi option:selected").val();
		var xyGubunAdd = $("#cboXYGubun option:selected").val();
		var DescrAdd = $("#txtLOOPNAME").val();
		var ioTypeAdd = $("#cboIOType option:selected").val();
		var addressAdd = $("#txtADDRESS").val();
		var ioBitAdd = $("#txtIOBIT").val() == '' ? '0' : $("#txtIOBIT").val();
		var minValAdd = $("#txtMin").val();
		var maxValAdd = $("#txtMax").val();
		var saveCoreAdd = $("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0";
		
		if( iSeqAdd == '' || hogiAdd == '' ) {
			alert('태그를 선택하십시요.');
			return;
		}
		if( minValAdd != 'undefined' && minValAdd != null && typeof minValAdd != 'undefined' ) {
			if( isNaN(minValAdd) ) {
				alert('MIN, MAX 값이 잘못되었습니다.');
				return;
			}
		}
		if( maxValAdd != 'undefined' && maxValAdd != null && typeof maxValAdd != 'undefined' ) {
			if( isNaN(maxValAdd) ) {
				alert('MIN, MAX 값이 잘못되었습니다.');
				return;
			}
		}
		if( $.trim(minValAdd) == '' ) {
			$("#txtMin").val('0');
			minValAdd = '0';
		}
		if( $.trim(maxValAdd) == '' ) {
			if( ioTypeAdd == 'DI' || ioTypeAdd == 'DO' || (ioTypeAdd == 'SC' && saveCoreAdd == '1') ) {
				$("#txtMax").val('1');
				maxValAdd = '1';
			} else if( ioTypeAdd == 'SC' ) {
				$("#txtMax").val('65535');
				maxValAdd = '65535';
			} else if( ioTypeAdd == 'DT' ) {
				$("#txtMax").val('1.5');
				maxValAdd = '1.5';
			} else {
				$("#txtMax").val('100');
				maxValAdd = '100';
			}
		}
		if( (ioTypeAdd == 'SC' && saveCoreAdd == '1') ) {
			if( $.trim(ioBitAdd) == '' ) {
				alert('IOBIT을 입력하십시요.');
				$("#txtIOBIT").focus();
				return;
			}
		} else if( ioTypeAdd == 'SC' ) {
			$("#txtIOBIT").val('');
			ioBitAdd = '';
		}
		if( $.trim(DescrAdd) == '' ) {
			if( ioBitAdd != '' ) {
				DescrAdd = ioTypeAdd+' '+addressAdd+':'+ioBitAdd;
			} else {
				DescrAdd = ioTypeAdd+' '+addressAdd;
			}
		}
		
		var addData = {
			'hogi': hogiAdd
			,'xyGubun': xyGubunAdd
			,'Descr': DescrAdd
			,'ioType': ioTypeAdd
			,'address': addressAdd
			,'ioBit': ioBitAdd
			,'minVal': minValAdd
			,'maxVal': maxValAdd
			,'saveCoreChk': saveCoreAdd
			,'iSeq': iSeqAdd
		};

		setAddedItem(addData,iSeqAdd,hogiAdd);
		
		textClear();
	}
	
	function setAddedItem(data,iSeqAdd,hogiAdd) {
		var selISeq = ($("#lvIolistTable")[0].children[0].id).split('_')[0].replace('tr','');
		var selHogi = ($("#lvIolistTable")[0].children[0].id).split('_')[1];
		var cnt = 0;

		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id.indexOf('tr') > -1 ) {
				cnt++;
			}
		}
		
		var totalCnt = cnt >= ioListArray.length ? cnt : ioListArray.length;
		var dupChk = [0,0];
		for( var l=0;l<totalCnt;l++ ) {
			if( selISeq == iSeqAdd+'' ) {
				dupChk[0] = 1;
			}

			if( selHogi == hogiAdd+'' ) {
				dupChk[1] = 1;
			}
		}

		if( dupChk[0] == 1 && dupChk[1] == 1 ) {
			alert('이미 설정되어 있습니다.');
			dupChk = [0,0];
			return;
		}

		var idList = ['hogi','xyGubun','loopName','ioType','address','ioBit','minVal','maxVal','saveCoreChk','iSeq'];
		
		if( cnt < 8 ) {
			$("#lvIolistTable")[0].children[cnt].id = 'tr'+data.iSeq+'_'+data.hogi;
			for( var j=0;j<$("#lvIolistTable")[0].children[cnt].children.length;j++ ) {
				$("#lvIolistTable")[0].children[cnt].children[j].children[0].id = data.iSeq+idList[j]+data.hogi;
				if( j == 2 ) {
					$("#lvIolistTable")[0].children[cnt].children[j].children[0].textContent = data.Descr;
				} else {
					$("#lvIolistTable")[0].children[cnt].children[j].children[0].textContent = data[idList[j]];
				}
			}
		} else {
			tBody = $("#lvIolistTable");
			newRowStr = '<tr>'
					  + ' <td class="tc"><label></label></td>'
					  + ' <td class="tc"><label></label></td>'
					  + ' <td><label></label></td>'
					  + ' <td class="tc"><label></label></td>'
					  + ' <td class="tc"><label></label></td>'
					  + ' <td class="tc"><label></label></td>'
					  + ' <td class="tc"><label></label></td>'
					  + ' <td class="tc"><label></label></td>'
					  + ' <td class="tc"><label></label></td>'
					  + ' <td style="display:none"><label></label></td>'
					  + '</tr>';
			tBody.append(newRowStr);
			
			$("#lvIolistTable")[0].children[cnt].id = 'tr'+data.iSeq+'_'+data.hogi;
			for( var j=0;j<$("#lvIolistTable")[0].children[cnt].children.length;j++ ) {
				$("#lvIolistTable")[0].children[cnt].children[j].children[0].id = data.iSeq+idList[j]+data.hogi;
				if( j == 2 ) {
					$("#lvIolistTable")[0].children[cnt].children[j].children[0].textContent = data.Descr;
				} else {
					$("#lvIolistTable")[0].children[cnt].children[j].children[0].textContent = data[idList[j]];
				}
			}
		}
	}
		
	function cmdDelete_click(type) {
		if( ioListArray.length > 0 ) {
			var iSeqDel = $("#txtISeq").val();
			//var gubunDel = $("#txtGUBUN").val();
			var gubunDel = 'D';
			var hogiDel = $("#cboHogi option:selected").val();
			var xyGubunDel = $("#cboXYGubun option:selected").val();
			var DescrDel = $("#txtLOOPNAME").val();
			var ioTypeDel = $("#cboIOType option:selected").val();
			var addressDel = $("#txtADDRESS").val();
			var ioBitDel = $("#txtIOBIT").val();
			var minValDel = $("#txtMin").val();
			var maxValDel = $("#txtMax").val();
			var saveCoreDel = $("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0";
			
			var selectedIseq = '';
			var selectedHogi = '';
			if( selectedID != '' ) {
				selectedIseq = selectedID.split('_')[0];
				selectedHogi = selectedID.split('_')[1];
			}
			
			var delData = {
				'iSeq': iSeqDel,
				'hogi': selectedHogi
			};
			
			setDelItem(delData);
			
			textClear();
		}
	}
	
	function setDelItem(data) {
		var selISeq = ($("#lvIolistTable")[0].children[0].id).split('_')[0].replace('tr','');
		var selHogi = ($("#lvIolistTable")[0].children[0].id).split('_')[1];
		var cnt = 0;
		
		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id.indexOf('tr') > -1 ) {
				cnt++;
			}
		}

		var idList = ['hogi','xyGubun','loopName','ioType','address','ioBit','minVal','maxVal','saveCoreChk','iSeq'];

		var isAfter = false;
		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id == 'tr'+data.iSeq+'_'+data.hogi ) {
				for( var j=0;j<$("#lvIolistTable")[0].children[i].children.length;j++ ) {
					if( i >= cnt-1 ) {
						$("#lvIolistTable")[0].children[i].children[j].children[0].id = i+idList[j]+i;
						$("#lvIolistTable")[0].children[i].children[j].children[0].textContent = '';
					} else {
						$("#lvIolistTable")[0].children[i].children[j].children[0].id = $("#lvIolistTable")[0].children[i+1].children[j].children[0].id;
						$("#lvIolistTable")[0].children[i].children[j].children[0].textContent = $("#lvIolistTable")[0].children[i+1].children[j].children[0].textContent;
					}
				}
				isAfter = true;
				$("#lvIolistTable")[0].children[i].id = $("#lvIolistTable")[0].children[i+1].id;
			} else if( isAfter ) {
				for( var j=0;j<$("#lvIolistTable")[0].children[i].children.length;j++ ) {
					if( i >= cnt-1 ) {
						$("#lvIolistTable")[0].children[i].children[j].children[0].id = i+idList[j]+i;
						$("#lvIolistTable")[0].children[i].children[j].children[0].textContent = '';
					} else {
						$("#lvIolistTable")[0].children[i].children[j].children[0].id = $("#lvIolistTable")[0].children[i+1].children[j].children[0].id;
						$("#lvIolistTable")[0].children[i].children[j].children[0].textContent = $("#lvIolistTable")[0].children[i+1].children[j].children[0].textContent;
					}
				}
				$("#lvIolistTable")[0].children[i].id = typeof $("#lvIolistTable")[0].children[i+1] == 'undefined' ? '' : $("#lvIolistTable")[0].children[i+1].id;
			}
		}
	}
	
	function cmdUpdate_click() {
		if( ioListArray.length > 0 ) {
			var iSeqUpd = $("#txtISeq").val();
			//var gubunDel = $("#txtGUBUN").val();
			var gubunUpd = 'D';
			var hogiUpd = $("#cboHogi option:selected").val();
			var xyGubunUpd = $("#cboXYGubun option:selected").val();
			var DescrUpd = $("#txtLOOPNAME").val();
			var ioTypeUpd = $("#cboIOType option:selected").val();
			var addressUpd = $("#txtADDRESS").val();
			var ioBitUpd = $("#txtIOBIT").val() == '' ? '0' : $("#txtIOBIT").val();
			var minValUpd = $("#txtMin").val();
			var maxValUpd = $("#txtMax").val();
			var bSaveCore = $("input:checkbox[id='chkSaveCore']").is(":checked");
			var saveCoreUpd = bSaveCore ? "1" : "0";
			
			if( $.trim($("#txtMin").val()) == '' ) $("#txtMin").val('0');
			if( $.trim($("#txtMin").val()) == '' ) {
				if( ioTypeUpd == 'DI' || ioTypeUpd == 'DO' || (ioTypeUpd == 'SC' && !bSaveCore) ) {
					$("#txtMax").val('1');
				} else if( ioTypeUpd == 'SC' ) {
					$("#txtMax").val('65535');
				} else if( ioTypeUpd == 'DT' ) {
					$("#txtMax").val('1.5');
				} else {
					$("#txtMax").val('100');
				}
			}
			if( ioTypeUpd == 'SC' && !bSaveCore ) {
				if( $.trim($("#txtIOBIT").val()) == '' ) {
					alert('IOBIT을 입력하십시요');
					$("#txtIOBIT").focus();
					return;
				}
			} else if( ioTypeUpd == 'SC' ) {
				$("#txtIOBIT").val('');
			}
			if( $("#txtMin").val() != 'undefined' && $("#txtMin").val() != null && typeof $("#txtMin").val() != 'undefined' ) {
				if( isNaN($("#txtMin").val()) ) {
					alert('MIN, MAX 값이 잘못되었습니다.');
					return;
				}
			}
			if( $("#txtMax").val() != 'undefined' && $("#txtMax").val() != null && typeof $("#txtMax").val() != 'undefined' ) {
				if( isNaN($("#txtMax").val()) ) {
					alert('MIN, MAX 값이 잘못되었습니다.');
					return;
				}
			}
			if( $.trim($("#txtLOOPNAME").val()) == '' ) {
				if( $.trim($("#txtIOBIT").val()) != '' ) {
					$("#txtLOOPNAME").val(valIOType+' '+$("#txtADDRESS").val()+':'+$("#txtIOBIT").val());
				} else {
					$("#txtLOOPNAME").val(valIOType+' '+$("#txtADDRESS").val());
				}
			}
			
			updData = {
				'hogi': hogiUpd
				,'xyGubun': xyGubunUpd
				,'Descr': DescrUpd
				,'ioType': ioTypeUpd
				,'address': addressUpd
				,'ioBit': ioBitUpd
				,'minVal': minValUpd
				,'maxVal': maxValUpd
				,'saveCoreChk': saveCoreUpd
				,'iSeq': iSeqUpd
			};
			
			setUpdatedItem(updData);
			
			textClear();
		}
	}
	
	function setUpdatedItem(data) {
		var cnt = 0;
		
		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id.indexOf('tr') > -1 ) {
				cnt++;
			}
		}

		var idList = ['hogi','xyGubun','loopName','ioType','address','ioBit','minVal','maxVal','saveCoreChk','iSeq'];

		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id == 'tr'+data.iSeq+'_'+data.hogi ) {
				var selISeq = ($("#lvIolistTable")[0].children[i].id).split('_')[0].replace('tr','');
				var selHogi = ($("#lvIolistTable")[0].children[i].id).split('_')[1];
				for( var j=0;j<$("#lvIolistTable")[0].children[i].children.length;j++ ) {
					if( j == 2 ) {
						//$("#lvIolistTable")[0].children[i].children[j].children[0].textContent = data.Descr;
						$("#"+selISeq+idList[j]+selHogi).text(data.Descr);
					} else {
						//$("#lvIolistTable")[0].children[i].children[j].children[0].textContent = data[idList[j]];
						$("#"+selISeq+idList[j]+selHogi).text(data[idList[j]]);
					}
				}
			}
		}
	}
	
	function cmdOK_click() {
		//ioListArray = [];
		if( $("#txtTitle").val() == '' ) {
			alert('제목을 입력하십시요');
			$("#txtTitle").focus();
			return;
		}

		var tbInfo =  $("#lvIolistTable")[0].children;
		var cnt = 0;

		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id.indexOf('tr') > -1 ) {
				cnt++;
			}
		}
		
		var totalCnt = cnt >= ioListArray.length ? cnt : ioListArray.length;
		var txtISeqMod = '';
		var txtHogiMod = '';
		var txtXyGubunMod = '';
		var txtDescrMod = '';
		var txtIoTypeMod = '';
		var txtAddressMod = '';
		var txtIoBitMod = '';
		var txtMinValMod = '';
		var txtMaxValMod = '';
		var txtSaveCoreMod = '';
		
		var idList = ['hogi','xyGubun','loopName','ioType','address','ioBit','minVal','maxVal','saveCoreChk','iSeq'];

		for( var k=0;k<totalCnt;k++ ) {
			if( typeof tbInfo[k] != 'undefined' ) {
				if( k < totalCnt-1 ) {
					txtISeqMod += tbInfo[k].children[9].textContent + '|';
					txtHogiMod += tbInfo[k].children[0].textContent + '|';
					txtXyGubunMod += tbInfo[k].children[1].textContent + '|';
					txtDescrMod += tbInfo[k].children[2].textContent + '|';
					txtIoTypeMod += tbInfo[k].children[3].textContent + '|';
					txtAddressMod += tbInfo[k].children[4].textContent + '|';
					txtIoBitMod += tbInfo[k].children[5].textContent + '|';
					txtMinValMod += tbInfo[k].children[6].textContent + '|';
					txtMaxValMod += tbInfo[k].children[7].textContent + '|';
					txtSaveCoreMod += tbInfo[k].children[8].textContent + '|';
				} else {
					txtISeqMod += tbInfo[k].children[9].textContent;
					txtHogiMod += tbInfo[k].children[0].textContent;
					txtXyGubunMod += tbInfo[k].children[1].textContent;
					txtDescrMod += tbInfo[k].children[2].textContent;
					txtIoTypeMod += tbInfo[k].children[3].textContent;
					txtAddressMod += tbInfo[k].children[4].textContent;
					txtIoBitMod += tbInfo[k].children[5].textContent;
					txtMinValMod += tbInfo[k].children[6].textContent;
					txtMaxValMod += tbInfo[k].children[7].textContent;
					txtSaveCoreMod += tbInfo[k].children[8].textContent;
				}
			}
		}

		var comAjax = new ComAjax("mngGrpFrm");
		
		if( bGroupFlag ) {
			comAjax.addParam("type", 'I');
		} else {
			comAjax.addParam("type", 'U');
			comAjax.addParam("sUGrpNo", $("#cboUGrpName option:selected").val());
		}

		comAjax.setUrl("/dcc/trend/cmdOK");
		comAjax.addParam("hogiHeader", hogiHeader);
		comAjax.addParam("xyHeader", xyHeader);
		comAjax.addParam("sUGrpName", $("#txtTitle").val());
		comAjax.addParam("sGrpID", '${UserInfo.id}');
		comAjax.addParam("Fixed", 'S');
		comAjax.addParam("sMenuNo", '32');
		comAjax.addParam("iSeqMod", txtISeqMod);
		comAjax.addParam("hogiMod", txtHogiMod);
		comAjax.addParam("xyGubunMod", txtXyGubunMod);
		comAjax.addParam("descrMod", txtDescrMod);
		comAjax.addParam("ioTypeMod", txtIoTypeMod);
		comAjax.addParam("addressMod", txtAddressMod);
		comAjax.addParam("ioBitMod", txtIoBitMod);
		comAjax.addParam("minValMod", txtMinValMod);
		comAjax.addParam("maxValMod", txtMaxValMod);
		comAjax.addParam("saveCoreMod", txtSaveCoreMod);
		comAjax.setCallback("mngGroupCallback");
		comAjax.ajax();
		
		bGroupFlag = false;
	}
	
	function openModal(str) {
		if( str == 'modal_loading' ) {
			/*openLayer(str);
			
			progressPos = Math.floor(Math.random()*3)+6;
			sleep(200).then(function() {
				fillProgress(1,progressPos);
			});
			sleep(1000).then(() => fillProgress(progressPos,progressPos+4));
			sleep(1000).then(() => fillProgress(progressPos+4,progressPos+7));
			sleep(1000).then(() => fillProgress(progressPos+7,21));*/
			$("#modal_loading").css("display","");
		} else if( str == 'modal_4' ) {
			openLayer("modal_4");
			var adY = ($("#modal_4").innerHeight()-110)/2-85;
			var udY = ($("#modal_4").innerHeight()-110)/2-85;
			
			$("#addGroup").css("margin-top",adY+20);
			$("#upGroup").css("margin-top",udY);
			
			Group_Get('${UserInfo.id}',0);
			Group_Get($("#cboReference option:eq(0)").val(),1);
		
		} else if( str != 'modal_3' ) {
			var grpId = $("#cboUGrpName option:selected").val();
			
			var tmpGrpName = $("#cboUGrpName option:selected").text();
			var selGrpName = tmpGrpName.substring(tmpGrpName.indexOf(' ')+1,tmpGrpName.length);
			
			$("#txtTitle").val(selGrpName);
			
			if( grpId != 'null' && typeof grpId != 'undefined' ) {
				var comAjax = new ComAjax("showTagFrm");
				comAjax.setUrl("/dcc/trend/getTagCall");
				comAjax.addParam("hogiHeader", hogiHeader);
				comAjax.addParam("xyHeader", xyHeader);
				comAjax.addParam("txtTimeGap", '5');
				comAjax.addParam("dive", 'D');
				comAjax.addParam("sGrpID", '${UserInfo.id}');
				comAjax.addParam("sMenuNo", '32');
				comAjax.addParam("sUGrpNo", grpId);
				comAjax.setCallback("mbr_getTagCallback");
				comAjax.ajax();
			}
			
			openLayer(str);
		} else {
			swSort = true;
			openLayer(str);
			$("#findData").focus();
		}
	}
	
	function closeModal(str) {
		function closePart() {
			return new Promise(function(resolve,reject) {
				//textClear(str);
				if( str == 'modal_loading' ) {
					$("#modal_loading").css("display","none");
				} else if( str != 'modal_3' ) {
					//cmdOK_click();
				} else {
					swSort = false;
				}
				
				closeLayer(str);
				
				setTimeout(function() {
					resolve();
				},500);
			});
		}
		
		closePart().then(function() {
			if( str == 'modal_4' ) {
				var totalCnt = $("#gguCheckbox0").val()*1;
				var grpNo = '';
	
				for( var i=0;i<totalCnt;i++ ) {
					for( var j=0;j<$("#lvGroup")[0].children.length;j++ ) {
						if( selTdID == $("#lvGroup")[0].children[j].children[1].id ) {
							var curID = $("#lvGroup")[0].children[j].children[1].id;
	
							grpNo = $("#"+curID).text();
						}
					}
				}
				
				if( grpNo != '' ) {
					$("#cboUGrpName").val(grpNo);
					
					cboUGrpName_click(0);
					cboUGrpName_change();
				}
			}
		});
	}
	
	function toCSV() {
		if( $("#mouse_area").css("display") != 'none' ) $("#mouse_area").css("display","none");
		
		var selGrpName = $("#cboUGrpName option:selected").val();
		var his = $("input:radio[id='H']").is(":checked") ? 'H' : 'R';
	
		if( typeof selGrpName == 'undefined' ) selGrpName = $("#cboUGrpName option:eq(0)").val();
		
		var startDate = "";
		var endDate = "";
		if( $("#selectSDate").val() != null && typeof $("#selectSDate").val() != 'undefined' ) {
			startDate = $("#selectSDate").val();//+':00.000';
			endDate = $("#selectEDate").val();//+':00.000';
			
			if( startDate != '' && startDate != null ) {
				if( startDate.length < 19 ) startDate += ':00';
				if( endDate.length < 19 ) endDate += ':00';
			}
		}
		
		var comSubmit = new ComSubmit("selGrpFrm");
		comSubmit.setUrl("/dcc/trend/bfExcelExport");
		//comSubmit.addParam("hogiHeader", hogiHeader);
		//comSubmit.addParam("xyHeader", xyHeader);
		comSubmit.addParam("startDate", startDate);
		comSubmit.addParam("endDate", endDate);
		comSubmit.addParam("sGrpID", '${UserInfo.id}');
		comSubmit.addParam("sMenuNo", '32');
		comSubmit.addParam('sUGrpNo',selGrpName);
		comSubmit.addParam("gHis",his);
		//comSubmit.submit();
	}
	
	function setLblDate(hogi,xy,m_time,color) {
		var lblDateVal = hogi+xy+' '+m_time;
		$("#lblDate").text(lblDateVal);
		var diff = new Date().getTime() - new Date(m_time).getTime();
		if( diff / 1800000 > 1 ) {
			$("#lblDate").css('color','#e85516');
		} else {
			$("#lblDate").css('color','#05c8be');
		}
	}
	
	function cmdUp_click() {
		
		var cnt = 0;
		
		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id.indexOf('tr') > -1 ) {
				cnt++;
			}
		}

		var selectedIseq = '';
		var selectedHogi = '';
		if( selectedID != '' ) {
			selectedIseq = selectedID.split('_')[0];
			selectedHogi = selectedID.split('_')[1];
		}
		
		var curData;
		var targetData;
		var trId = '';
		var pos = 0;
		var trigger = false;
		
		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id == 'tr'+selectedIseq+'_'+selectedHogi ) {
				if( cnt >= 1 && i > 0 ) {
					pos = i;
					curData = {
						'hogi': $("#lvIolistTable")[0].children[i].children[0].textContent
						,'xyGubun': $("#lvIolistTable")[0].children[i].children[1].textContent
						,'Descr': $("#lvIolistTable")[0].children[i].children[2].textContent
						,'ioType': $("#lvIolistTable")[0].children[i].children[3].textContent
						,'address': $("#lvIolistTable")[0].children[i].children[4].textContent
						,'ioBit': $("#lvIolistTable")[0].children[i].children[5].textContent
						,'minVal': $("#lvIolistTable")[0].children[i].children[6].textContent
						,'maxVal': $("#lvIolistTable")[0].children[i].children[7].textContent
						,'saveCoreChk': $("#lvIolistTable")[0].children[i].children[8].textContent
						,'iSeq': $("#lvIolistTable")[0].children[i].children[9].textContent	
					};
					
					targetData = {
						'hogi': $("#lvIolistTable")[0].children[i-1].children[0].textContent
						,'xyGubun': $("#lvIolistTable")[0].children[i-1].children[1].textContent
						,'Descr': $("#lvIolistTable")[0].children[i-1].children[2].textContent
						,'ioType': $("#lvIolistTable")[0].children[i-1].children[3].textContent
						,'address': $("#lvIolistTable")[0].children[i-1].children[4].textContent
						,'ioBit': $("#lvIolistTable")[0].children[i-1].children[5].textContent
						,'minVal': $("#lvIolistTable")[0].children[i-1].children[6].textContent
						,'maxVal': $("#lvIolistTable")[0].children[i-1].children[7].textContent
						,'saveCoreChk': $("#lvIolistTable")[0].children[i-1].children[8].textContent
						,'iSeq': $("#lvIolistTable")[0].children[i-1].children[9].textContent	
					};
					trigger = true;
				}
				selectedID = trigger ? curData.iSeq+'_'+curData.hogi : selectedID;
			}
		}
		
		if( trigger ) setMovedItem(pos,pos-1,$("#lvIolistTable")[0].children,curData,targetData);
	}
	
	function cmdDown_click() {
		var cnt = 0;
		
		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id.indexOf('tr') > -1 ) {
				cnt++;
			}
		}

		var selectedIseq = '';
		var selectedHogi = '';
		if( selectedID != '' ) {
			selectedIseq = selectedID.split('_')[0];
			selectedHogi = selectedID.split('_')[1];
		}
		
		var curData;
		var targetData;
		var pos = 0;
		var trigger = false;
		
		for( var i=0;i<$("#lvIolistTable")[0].children.length;i++ ) {
			if( $("#lvIolistTable")[0].children[i].id == 'tr'+selectedIseq+'_'+selectedHogi ) {
				if( cnt >= 1 && i < cnt-1 ) {
					pos = i;
					curData = {
						'hogi': $("#lvIolistTable")[0].children[i].children[0].textContent
						,'xyGubun': $("#lvIolistTable")[0].children[i].children[1].textContent
						,'Descr': $("#lvIolistTable")[0].children[i].children[2].textContent
						,'ioType': $("#lvIolistTable")[0].children[i].children[3].textContent
						,'address': $("#lvIolistTable")[0].children[i].children[4].textContent
						,'ioBit': $("#lvIolistTable")[0].children[i].children[5].textContent
						,'minVal': $("#lvIolistTable")[0].children[i].children[6].textContent
						,'maxVal': $("#lvIolistTable")[0].children[i].children[7].textContent
						,'saveCoreChk': $("#lvIolistTable")[0].children[i].children[8].textContent
						,'iSeq': $("#lvIolistTable")[0].children[i].children[9].textContent	
					};
					
					targetData = {
						'hogi': $("#lvIolistTable")[0].children[i+1].children[0].textContent
						,'xyGubun': $("#lvIolistTable")[0].children[i+1].children[1].textContent
						,'Descr': $("#lvIolistTable")[0].children[i+1].children[2].textContent
						,'ioType': $("#lvIolistTable")[0].children[i+1].children[3].textContent
						,'address': $("#lvIolistTable")[0].children[i+1].children[4].textContent
						,'ioBit': $("#lvIolistTable")[0].children[i+1].children[5].textContent
						,'minVal': $("#lvIolistTable")[0].children[i+1].children[6].textContent
						,'maxVal': $("#lvIolistTable")[0].children[i+1].children[7].textContent
						,'saveCoreChk': $("#lvIolistTable")[0].children[i+1].children[8].textContent
						,'iSeq': $("#lvIolistTable")[0].children[i+1].children[9].textContent	
					};
					trigger = true;
				}
				selectedID = trigger ? curData.iSeq+'_'+curData.hogi : selectedID;
			}
		}
		
		if( trigger ) setMovedItem(pos,pos+1,$("#lvIolistTable")[0].children,curData,targetData);
	}
	
	function setMovedItem(curP,tarP,tbInfo,curData,targetData) {
		var idList = ['hogi','xyGubun','loopName','ioType','address','ioBit','minVal','maxVal','saveCoreChk','iSeq'];
		
		tbInfo[curP].id = 'tr'+targetData.iSeq+'_'+targetData.hogi;
		for( var j=0;j<tbInfo[curP].children.length;j++ ) {
			tbInfo[curP].children[j].id = targetData.iSeq+idList[j]+targetData.hogi;
			if( j == 2 ) {
				tbInfo[curP].children[j].textContent = targetData.Descr;
			} else {
				tbInfo[curP].children[j].textContent = targetData[idList[j]];
			}
		}

		tbInfo[tarP].id = 'tr'+curData.iSeq+'_'+curData.hogi;
		for( var j=0;j<tbInfo[tarP].children.length;j++ ) {
			tbInfo[tarP].children[j].id = curData.iSeq+idList[j]+curData.hogi;
			if( j == 2 ) {
				tbInfo[tarP].children[j].textContent = curData.Descr;
			} else {
				tbInfo[tarP].children[j].textContent = curData[idList[j]];
			}
		}

		$("#"+tbInfo[tarP].id).addClass("highlight");
		$("#"+tbInfo[tarP].id).siblings().removeClass("highlight");
	}
	
	function tagFind_click() {
		var comAjax = new ComAjax('tagSearchForm');
		comAjax.setUrl('/dcc/trend/tagFind');
		comAjax.addParam('hogiHeader',hogiHeader);
		comAjax.addParam('xyHeader',xyHeader);
		comAjax.addParam('type','0');
		comAjax.addParam('tagHogi',typeof $("#cboTagHogi option:selected") == 'undefined' ? '3' : $("#cboTagHogi option:selected").val());
		comAjax.addParam('tagIOType',typeof $("#cboTagIOType option:selected") == 'undefined' ? 'AI' : $("#cboTagIOType option:selected").val());
		comAjax.addParam('findData',$("#findData").val());
		comAjax.addParam('bAll','0');
		comAjax.addParam('chkOpt1',$("input:checkbox[id='chkOpt1']").is(":checked") ? '1' : '0');
		comAjax.addParam('chkOpt2',$("input:checkbox[id='chkOpt2']").is(":checked") ? '1' : '0');
		comAjax.setCallback('mbr_tagFindCallback');
		comAjax.ajax();
	}
	
	function tagFindAll_click() {
		var comAjax = new ComAjax('tagSearchForm');
		comAjax.setUrl('/dcc/trend/tagFind');
		comAjax.addParam('hogiHeader',hogiHeader);
		comAjax.addParam('xyHeader',xyHeader);
		comAjax.addParam('type','1');
		comAjax.setCallback('mbr_tagFindCallback');
		comAjax.ajax();
	}
	
	function cutData(val,len) {
		if( (val+'').indexOf('.') == -1 || (val - Math.floor(val)).toFixed(6) == 0 ) {
		
			return Math.floor(val);
		} else {
			if( val.indexOf('E') > -1 ) {
				var tTmp = (val+'').split('E');
				var tSub = '';
				var fTmp = '';
				
				tSub = tTmp[0].split('.');
				fTmp = (tSub[0]+'.'+tSub[1].substring(0,len+tTmp[1]*1))*Math.pow(10,tTmp[1]*1);
				
				return fTmp.toFixed(len);
			} else {
				var tTmp = (val*1).toFixed(len)+'';
				var cnt = 0;
				
				for( var i=0;i<tTmp.length;i++ ) {
					if( tTmp.substr(i*-1)*1 == 0 ) cnt++;
				}
				
				return tTmp.substring(0,tTmp.length-cnt);
			}
		}
	}
	
	function setData() {
		drawReset();
		
		for( var i=0;i<lblDataListAjax.length;i++ ) {
			$("#tagNameData"+i).text(DccTagInfoListAjax[i].dataLoop);
			$("#lblData"+i).text(lblDataListAjax[i].fValue);
			$("#lblData"+i).prop("title",DccTagInfoListAjax[i].toolTip);
			$("#minData"+i).text(minListAjax[i]);
			$("#maxData"+i).text(maxListAjax[i]);
			$("#unitData"+i).text(DccTagInfoListAjax[i].unit);
			
			if( DccTagInfoListAjax[i].alarmType == '1' || DccTagInfoListAjax[i].alarmType == '7' || DccTagInfoListAjax[i].alarmType == '4' ) {
				drawLimit1(i);
				if( tagMaxListAjax[i]*1 > -99999 ) {
					if( !isNaN(lblDataListAjax[i].fValue) ) {
						if( lblDataListAjax[i].fValue*1 > tagMaxListAjax[i]*1 ) {
							$("#lblData"+i).css("color","#FF0000");
						} else {
							$("#lblData"+i).css("color","#B20978");
						}
					}
				}
			} else if( DccTagInfoListAjax[i].alarmType == '2' || DccTagInfoListAjax[i].alarmType == '8' || DccTagInfoListAjax[i].alarmType == '5' ) {
				drawLimit2(i);
				if( tagMinListAjax[i]*1 > -99999 ) {
					if( !isNaN(lblDataListAjax[i].fValue) ) {
						if( lblDataListAjax[i].fValue*1 < tagMinListAjax[i]*1 ) {
							$("#lblData"+i).css("color","#FF0000");
						} else {
							$("#lblData"+i).css("color","#B20978");
						}
					}
				}
			} else if( DccTagInfoListAjax[i].alarmType == '3' || DccTagInfoListAjax[i].alarmType == '6' ) {
				drawLimit1(i);
				drawLimit2(i);
				if( tagMaxListAjax[i]*1 > -99999 && tagMinListAjax[i]*1 > -99999 ) {
					if( !isNaN(lblDataListAjax[i].fValue) ) {
						if( lblDataListAjax[i].fValue*1 > tagMaxListAjax[i]*1 || lblDataListAjax[i].fValue*1 < tagMinListAjax[i]*1 ) {
							$("#lblData"+i).css("color","#FF0000");
						} else {
							$("#lblData"+i).css("color","#B20978");
						}
					}
				}
			}
		}
	}
	
	function drawReset() {
		for( var i=0;i<16;i++ ) {
			$("#limit1Data"+i).css("display","none");
			$("#limit2Data"+i).css("display","none");
		}
	}
	
	function drawLimit1(index) {
		var iMin = $("#minData"+index).text();
		var iMax = $("#maxData"+index).text();
		var tagMax = tagMaxListAjax[index];
		var lblData = $("#lblData"+index).text();
		if( !isNaN(iMin) && !isNaN(iMax) && tagMax*1 > -32768 && !isNaN(lblData) && (iMax*1 - iMin*1 != 0) ) {
			var rate = (tagMax*1 - iMin*1)/(iMax*1 - iMin*1);
			if( rate > 0 ) {
				$("#limit1Data"+index).css("display","");
				var mul = Math.round(rate*882);
				if( rate < 1 ) {
					$("#limit1Data"+index).css("left",mul);
					$("#limit1Data"+index).css("width",882-mul);
				} else {
					//
				}
			}
		}
	}
	
	function drawLimit2(index) {
		var iMin = $("#minData"+index).text();
		var iMax = $("#maxData"+index).text();
		var tagMin = tagMinListAjax[index];
		var lblData = $("#lblData"+index).text();
		if( !isNaN(iMin) && !isNaN(iMax) && tagMin*1 > -32768 && !isNaN(lblData) && (iMax*1 - iMin*1 != 0) ) {
			var rate = (tagMin*1 - iMin*1)/(iMax*1 - iMin*1);
			if( rate > 0 ) {
				$("#limit2Data"+index).css("display","");
				var mul = Math.round(rate*882);
				if( rate < 1 ) {
					//$("#limit1Data"+index).css("left",mul);
					$("#limit2Data"+index).css("width",882-mul);
				} else {
					//
				}
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
				<h3>BARCHART</h3>
				<div class="bc"><span>DCC</span><span>Trend</span><strong>BARCHART SPARE</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<form id="selGrpFrm" type="hidden"></form>
			<div class="fx_srch_wrap b_type" style="margin-bottom:10px">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item no_label">	
                            <div class="fx_form">
                                <select id="cboUGrpName" onBlur="javascript:cboUGrpName_blur()">
                                <option id="init" value="null"></option>
                                <c:forEach var="grpInfo" items="${DccGroupList}">
                                	<option id="opt${grpInfo.groupNo}" value="${grpInfo.groupNo}">${grpInfo.groupName}</option>
                                </c:forEach>
                                </select>
                            </div>
                            <div class="fx_form"></div>
                            <div class="fx_form"></div>
						</div>
					</div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->
			<div id="tagNameArea">
				<div><label id="tagNameData0" style="position:absolute;top:140px;left:100px"></label></div>
				<div><label id="tagNameData1" style="position:absolute;top:170px;left:100px"></label></div>
				<div><label id="tagNameData2" style="position:absolute;top:200px;left:100px"></label></div>
				<div><label id="tagNameData3" style="position:absolute;top:230px;left:100px"></label></div>
				<div><label id="tagNameData4" style="position:absolute;top:260px;left:100px"></label></div>
				<div><label id="tagNameData5" style="position:absolute;top:290px;left:100px"></label></div>
				<div><label id="tagNameData6" style="position:absolute;top:320px;left:100px"></label></div>
				<div><label id="tagNameData7" style="position:absolute;top:350px;left:100px"></label></div>
				<div><label id="tagNameData8" style="position:absolute;top:380px;left:100px"></label></div>
				<div><label id="tagNameData9" style="position:absolute;top:410px;left:100px"></label></div>
				<div><label id="tagNameData10" style="position:absolute;top:440px;left:100px"></label></div>
				<div><label id="tagNameData11" style="position:absolute;top:470px;left:100px"></label></div>
				<div><label id="tagNameData12" style="position:absolute;top:500px;left:100px"></label></div>
				<div><label id="tagNameData13" style="position:absolute;top:530px;left:100px"></label></div>
				<div><label id="tagNameData14" style="position:absolute;top:560px;left:100px"></label></div>
				<div><label id="tagNameData15" style="position:absolute;top:590px;left:100px"></label></div>
			</div>
			<div id="lblDataArea" style="position:absolute;top:142px;left:190px;width:45px;text-align:right;color:#B20978">
				<div><label id="lblData0">0.0</label></div>
				<div style="position:absolute;top:30px;width:45px;text-align:right"><label id="lblData1">0.0</label></div>
				<div style="position:absolute;top:60px;width:45px;text-align:right"><label id="lblData2">0.0</label></div>
				<div style="position:absolute;top:90px;width:45px;text-align:right"><label id="lblData3">0.0</label></div>
				<div style="position:absolute;top:120px;width:45px;text-align:right"><label id="lblData4">0.0</label></div>
				<div style="position:absolute;top:150px;width:45px;text-align:right"><label id="lblData5">0.0</label></div>
				<div style="position:absolute;top:180px;width:45px;text-align:right"><label id="lblData6">0.0</label></div>
				<div style="position:absolute;top:210px;width:45px;text-align:right"><label id="lblData7">0.0</label></div>
				<div style="position:absolute;top:240px;width:45px;text-align:right"><label id="lblData8">0.0</label></div>
				<div style="position:absolute;top:270px;width:45px;text-align:right"><label id="lblData9">0.0</label></div>
				<div style="position:absolute;top:300px;width:45px;text-align:right"><label id="lblData10">0.0</label></div>
				<div style="position:absolute;top:330px;width:45px;text-align:right"><label id="lblData11">0.0</label></div>
				<div style="position:absolute;top:360px;width:45px;text-align:right"><label id="lblData12">0.0</label></div>
				<div style="position:absolute;top:390px;width:45px;text-align:right"><label id="lblData13">0.0</label></div>
				<div style="position:absolute;top:420px;width:45px;text-align:right"><label id="lblData14">0.0</label></div>
				<div style="position:absolute;top:450px;width:45px;text-align:right"><label id="lblData15">0.0</label></div>
			</div>
			<div id="minArea" style="position:absolute;top:131px;left:250px;width:45px;text-align:left">
				<div><label id="minData0">0.0</label></div>
				<div style="position:absolute;top:30px;width:45px;text-align:left"><label id="minData1">0.0</label></div>
				<div style="position:absolute;top:60px;width:45px;text-align:left"><label id="minData2">0.0</label></div>
				<div style="position:absolute;top:90px;width:45px;text-align:left"><label id="minData3">0.0</label></div>
				<div style="position:absolute;top:120px;width:45px;text-align:left"><label id="minData4">0.0</label></div>
				<div style="position:absolute;top:150px;width:45px;text-align:left"><label id="minData5">0.0</label></div>
				<div style="position:absolute;top:180px;width:45px;text-align:left"><label id="minData6">0.0</label></div>
				<div style="position:absolute;top:210px;width:45px;text-align:left"><label id="minData7">0.0</label></div>
				<div style="position:absolute;top:240px;width:45px;text-align:left"><label id="minData8">0.0</label></div>
				<div style="position:absolute;top:270px;width:45px;text-align:left"><label id="minData9">0.0</label></div>
				<div style="position:absolute;top:300px;width:45px;text-align:left"><label id="minData10">0.0</label></div>
				<div style="position:absolute;top:330px;width:45px;text-align:left"><label id="minData11">0.0</label></div>
				<div style="position:absolute;top:360px;width:45px;text-align:left"><label id="minData12">0.0</label></div>
				<div style="position:absolute;top:390px;width:45px;text-align:left"><label id="minData13">0.0</label></div>
				<div style="position:absolute;top:420px;width:45px;text-align:left"><label id="minData14">0.0</label></div>
				<div style="position:absolute;top:450px;width:45px;text-align:left"><label id="minData15">0.0</label></div>
			</div>
			<div id="maxArea" style="position:absolute;top:131px;left:1085px;width:45px;text-align:right">
				<div><label id="maxData0">100.0</label></div>
				<div style="position:absolute;top:30px;width:45px;text-align:right"><label id="maxData1">100.0</label></div>
				<div style="position:absolute;top:60px;width:45px;text-align:right"><label id="maxData2">100.0</label></div>
				<div style="position:absolute;top:90px;width:45px;text-align:right"><label id="maxData3">100.0</label></div>
				<div style="position:absolute;top:120px;width:45px;text-align:right"><label id="maxData4">100.0</label></div>
				<div style="position:absolute;top:150px;width:45px;text-align:right"><label id="maxData5">100.0</label></div>
				<div style="position:absolute;top:180px;width:45px;text-align:right"><label id="maxData6">100.0</label></div>
				<div style="position:absolute;top:210px;width:45px;text-align:right"><label id="maxData7">100.0</label></div>
				<div style="position:absolute;top:240px;width:45px;text-align:right"><label id="maxData8">100.0</label></div>
				<div style="position:absolute;top:270px;width:45px;text-align:right"><label id="maxData9">100.0</label></div>
				<div style="position:absolute;top:300px;width:45px;text-align:right"><label id="maxData10">100.0</label></div>
				<div style="position:absolute;top:330px;width:45px;text-align:right"><label id="maxData11">100.0</label></div>
				<div style="position:absolute;top:360px;width:45px;text-align:right"><label id="maxData12">100.0</label></div>
				<div style="position:absolute;top:390px;width:45px;text-align:right"><label id="maxData13">100.0</label></div>
				<div style="position:absolute;top:420px;width:45px;text-align:right"><label id="maxData14">100.0</label></div>
				<div style="position:absolute;top:450px;width:45px;text-align:right"><label id="maxData15">100.0</label></div>
			</div>
			<div id="unitArea" style="position:absolute;top:140px;left:1150px;width:45px;text-align:left">
				<div><label id="unitData0"></label></div>
				<div style="position:absolute;top:30px;width:45px;text-align:left"><label id="unitData1"></label></div>
				<div style="position:absolute;top:60px;width:45px;text-align:left"><label id="unitData2"></label></div>
				<div style="position:absolute;top:90px;width:45px;text-align:left"><label id="unitData3"></label></div>
				<div style="position:absolute;top:120px;width:45px;text-align:left"><label id="unitData4"></label></div>
				<div style="position:absolute;top:150px;width:45px;text-align:left"><label id="unitData5"></label></div>
				<div style="position:absolute;top:180px;width:45px;text-align:left"><label id="unitData6"></label></div>
				<div style="position:absolute;top:210px;width:45px;text-align:left"><label id="unitData7"></label></div>
				<div style="position:absolute;top:240px;width:45px;text-align:left"><label id="unitData8"></label></div>
				<div style="position:absolute;top:270px;width:45px;text-align:left"><label id="unitData9"></label></div>
				<div style="position:absolute;top:300px;width:45px;text-align:left"><label id="unitData10"></label></div>
				<div style="position:absolute;top:330px;width:45px;text-align:left"><label id="unitData11"></label></div>
				<div style="position:absolute;top:360px;width:45px;text-align:left"><label id="unitData12"></label></div>
				<div style="position:absolute;top:390px;width:45px;text-align:left"><label id="unitData13"></label></div>
				<div style="position:absolute;top:420px;width:45px;text-align:left"><label id="unitData14"></label></div>
				<div style="position:absolute;top:450px;width:45px;text-align:left"><label id="unitData15"></label></div>
			</div>
			<div id="limit1Area" style="position:absolute;top:145px;left:248px;text-align:left">
				<div style="width:882px;height:2px;background:red;position:absolute;display:none" id="limit1Data0"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:30px;text-align:left;display:none" id="limit1Data1"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:60px;text-align:left;display:none" id="limit1Data2"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:90px;text-align:left;display:none" id="limit1Data3"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:120px;text-align:left;display:none" id="limit1Data4"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:150px;text-align:left;display:none" id="limit1Data5"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:180px;text-align:left;display:none" id="limit1Data6"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:210px;text-align:left;display:none" id="limit1Data7"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:240px;text-align:left;display:none" id="limit1Data8"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:270px;text-align:left;display:none" id="limit1Data9"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:300px;text-align:left;display:none" id="limit1Data10"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:330px;text-align:left;display:none" id="limit1Data11"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:360px;text-align:left;display:none" id="limit1Data12"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:390px;text-align:left;display:none" id="limit1Data13"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:420px;text-align:left;display:none" id="limit1Data14"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:450px;text-align:left;display:none" id="limit1Data15"></div>
			</div>
			<div id="limit2Area" style="position:absolute;top:145px;left:248px;text-align:left">
				<div style="width:882px;height:2px;background:red;position:absolute;display:none" id="limit2Data0"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:30px;text-align:left;display:none" id="limit2Data1"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:60px;text-align:left;display:none" id="limit2Data2"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:90px;text-align:left;display:none" id="limit2Data3"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:120px;text-align:left;display:none" id="limit2Data4"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:150px;text-align:left;display:none" id="limit2Data5"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:180px;text-align:left;display:none" id="limit2Data6"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:210px;text-align:left;display:none" id="limit2Data7"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:240px;text-align:left;display:none" id="limit2Data8"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:270px;text-align:left;display:none" id="limit2Data9"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:300px;text-align:left;display:none" id="limit2Data10"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:330px;text-align:left;display:none" id="limit2Data11"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:360px;text-align:left;display:none" id="limit2Data12"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:390px;text-align:left;display:none" id="limit2Data13"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:420px;text-align:left;display:none" id="limit2Data14"></div>
				<div style="width:882px;height:2px;background:red;position:absolute;top:450px;text-align:left;display:none" id="limit2Data15"></div>
			</div>
			<!-- chart_wrap_area -->
			<div id="divChart" class="chart_wrap_area">
				<div id="chartArea0" style="height:30px;width:900px"></div>
				<div id="chartArea1" style="height:30px;width:900px"></div>
				<div id="chartArea2" style="height:30px;width:900px"></div>
				<div id="chartArea3" style="height:30px;width:900px"></div>
				<div id="chartArea4" style="height:30px;width:900px"></div>
				<div id="chartArea5" style="height:30px;width:900px"></div>
				<div id="chartArea6" style="height:30px;width:900px"></div>
				<div id="chartArea7" style="height:30px;width:900px"></div>
				<div id="chartArea8" style="height:30px;width:900px"></div>
				<div id="chartArea9" style="height:30px;width:900px"></div>
				<div id="chartArea10" style="height:30px;width:900px"></div>
				<div id="chartArea11" style="height:30px;width:900px"></div>
				<div id="chartArea12" style="height:30px;width:900px"></div>
				<div id="chartArea13" style="height:30px;width:900px"></div>
				<div id="chartArea14" style="height:30px;width:900px"></div>
				<div id="chartArea15" style="height:30px;width:900px"></div>
            </div>
            <!-- //chart_wrap_area -->
		</div>
		<!-- //contents -->
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" id="mnuAddGroup">그룹추가</a></li>
                        <li><a href="#none" id="setFrmIO">변수설정</a></li>
                        <li><a href="#none" onclick="javascript:toCSV()">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->
                <!-- Loading -->
                <div class="loader_wrap" id="modal_loading" style="display:none">
                	<div class="loader_circle"></div>
                	<div class="loader_line_mask">
                		<div class="loader_line"></div>
                	</div>
               	</div>
               	<!-- //Loading -->
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
	    <h3>변수설정</h3>
        <a onclick="closeModal('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <form id="showTagFrm" type="hidden"></form>
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>Title</th>
                    <td>
                        <div class="fx_form">
                            <input id="txtTitle" type="text" value="${LvIOList[0].title}">
                            <a class="btn_list" id="cmdGroupInsert" herf="none">그룹추가</a>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->        
        <!-- list_wrap -->
        <div class="list_wrap" style="overflow-y:auto;max-height:258px">
            <!-- list_table -->
            <table id="lvIOListTable" class="list_table">
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
                    <tr id="itemHeaders">
                        <th style="background-color:#2e5ce0;color:#ffffff">HOGI</th>
                        <th style="background-color:#2e5ce0;color:#ffffff">XY</th>
                        <th style="background-color:#2e5ce0;color:#ffffff">사용자지정이름</th>
                        <th style="background-color:#2e5ce0;color:#ffffff">TYPE</th>
                        <th style="background-color:#2e5ce0;color:#ffffff">ADDR</th>
                        <th style="background-color:#2e5ce0;color:#ffffff">BIT</th>
                        <th style="background-color:#2e5ce0;color:#ffffff">MIN</th>
                        <th style="background-color:#2e5ce0;color:#ffffff">MAX</th>
                        <th style="background-color:#2e5ce0;color:#ffffff">SCBIT</th>
                    </tr>
                </thead>
                <tbody id="lvIolistTable">
                <c:forEach var="oListItem" items="${LvIOList}">
                    <tr>
                        <td id="${oListItem.iSeq}hogi${oListItem.hogi}" class="tc">${oListItem.hogi}</td>
                        <td id="${oListItem.iSeq}xyGubun${oListItem.hogi}" class="tc">${oListItem.xyGubun}</td>
                        <td id="${oListItem.iSeq}descr${oListItem.hogi}">${oListItem.Descr}</td>
                        <td id="${oListItem.iSeq}ioType${oListItem.hogi}" class="tc">${oListItem.ioType}</td>
                        <td id="${oListItem.iSeq}address${oListItem.hogi}" class="tc">${oListItem.address}</td>
                        <td id="${oListItem.iSeq}ioBit${oListItem.hogi}" class="tc">${oListItem.ioBit}</td>
                        <td id="${oListItem.iSeq}minVal${oListItem.hogi}" class="tc">${oListItem.minVal}</td>
                        <td id="${oListItem.iSeq}maxVal${oListItem.hogi}" class="tc">${oListItem.maxVal}</td>
                        <td id="${oListItem.iSeq}saveCoreChk${oListItem.hogi}" class="tc">${oListItem.SaveCoreChk}</td>
                        <td id="${oListItem.iSeq}iSeq${oListItem.hogi}" style="display:none">${oListItem.iSeq}</td>
                    </tr>
                </c:forEach>
                <c:forEach var="i" begin="1" end="8" step="1">
                    <tr>
                        <td class="tc"><label id="${i}hogi${i}"></label></td>
                        <td class="tc"><label id="${i}xyGubun${i}"></label></td>
                        <td><label id="${i}descr${i}"></label></td>
                        <td class="tc"><label id="${i}ioType${i}"></label></td>
                        <td class="tc"><label id="${i}address${i}"></label></td>
                        <td class="tc"><label id="${i}ioBit${i}"></label></td>
                        <td class="tc"><label id="${i}minVal${i}"></label></td>
                        <td class="tc"><label id="${i}maxVal${i}"></label></td>
                        <td class="tc"><label id="${i}saveCoreChk${i}"></label></td>
                        <td style="display:none"><label id="${i}iSeq${i}"></label></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <form id="ioListForm">
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
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>Type</th>
                        <th>Address</th>
                        <th>Bit</th>
                        <th>Min</th>
                        <th>Max</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody id="filterBody">
                    <tr>
                        <td>
                            <select id="cboHogi">
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>                        
                        </td>
                        <td>
                            <select id="cboXYGubun">
                                <option value="X">X</option>
                                <option value="Y">Y</option>
                            </select>                        
                        </td>
                        <td><input id="txtLOOPNAME" type="text"></td>
                        <td>
                            <select id="cboIOType">
                                <option value="AI">AI</option>
                                <option value="AO">AO</option>
                                <option value="DI">DI</option>
                                <option value="DO">DO</option>
                                <option value="SC">SC</option>
                                <option value="DT">DT</option>
                            </select>                        
                        </td>
                        <td><input id="txtADDRESS" type="text" class="tc" onkeypress="javascript:pressAddr()"></td>
                        <td class="tc"><input id="txtIOBIT" type="text" class="tc"></td>
                        <td class="tc"><input id="txtMin" type="text" class="tc"></td>
                        <td class="tc"><input id="txtMax" type="text" class="tc"></td>
                        <td class="tc"><input id="chkSaveCore" type="checkbox"></td>
                    </tr>
                </tbody>
            </table>
            <form id="ioListModForm">
            <table>
            	<tbody id="ioListAjax">
            	<tr>
            		<td style="display:none">
            			<input type="hidden" id="ajaxHogi" type="text" value="">
            			<input type="hidden" id="ajaxXYGubun" type="text" value="">
            			<input type="hidden" id="ajaxLoopName" type="text" value="">
            			<input type="hidden" id="ajaxIOType" type="text" value="">
            			<input type="hidden" id="ajaxAddress" type="text" value="">
            			<input type="hidden" id="ajaxIOBit" type="text" value="">
	                    <input type="hidden" id="ajaxMin" type="text" value="">
	                    <input type="hidden" id="ajaxMax" type="text" value="">
	                    <input type="hidden" id="ajaxSaveCore" type="text" value="">
	                    <input type="hidden" id="ajaxFastIoChk" type="text" value="">
	                    <input type="hidden" id="ajaxISeq" type="text" value="">
            		</td>
            	</tr>
            	</tbody>
            </table>
            </form>
            <table>
            	<tbody id="ioLisMod">
            	<tr>
            		<td style="display:none">
						<input type="hidden" id="hogiMod" type="text" value="">
						<input type="hidden" id="xyGubunMod" type="text" value="">
						<input type="hidden" id="DescrMod" type="text" value="">
						<input type="hidden" id="ioTypeMod" type="text" value="">
						<input type="hidden" id="addressMod" type="text" value="">
						<input type="hidden" id="ioBitMod" type="text" value="">
						<input type="hidden" id="minValMod" type="text" value="">
						<input type="hidden" id="maxValMod" type="text" value="">
						<input type="hidden" id="saveCoreMod" type="text" value="">
						<input type="hidden" id="gubunMod" type="text" value="">
						<input type="hidden" id="iSeqMod" type="text" value="">
					</td>
            	</tr>
            	</tbody>
            </table>
            <!-- //list_table -->
            <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" onclick="openModal('modal_3')">Tag Search</a>
                    <input class="tc" id="txtISeq" type="hidden">
                </div>
                <div class="button">
                    <a class="btn_list" id="cmdInsert" href="#none">추가</a>
                    <a class="btn_list" id="cmdUpdate" href="#none">수정</a>
                    <a class="btn_list" id="cmdDelete" href="#none">삭제</a>
                    <a class="btn_list" id="cmdUp" href="#none">위</a>
                    <a class="btn_list" id="cmdDown" href="#none">아래</a>
                </div>
            </div>
            </form>
            <!-- //list_bottom -->            
        </div>
        <!-- //list_wrap -->              
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" id="cmdOk" class="btn_page primary">저장</a>
        <a href="#none" id="cmdCancel" class="btn_page" onclick="closeModal('modal_1');">닫기</a>
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
<div class="layer_pop_wrap big" id="modal_3">
    <!-- header_wrap -->
<div class="pop_header">
   <h3>태그목록</h3>
        <a onclick="closeModal('modal_3');" title="Close"></a>
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
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="80px"/>
                    <col width="60px"/>
                    <col />
                    <col width="140px"/>
                    <col width="60px"/>
                    <col width="120px"/>
                </colgroup>
                <tr>
                    <th>호기</th>
	                <td>
	                    <select id="cboTagHogi">
	                        <option value="3">3</option>
	                        <option value="4">4</option>
	                    </select>                        
	                </td>
	                <td>
	                    <select id="cboTagIOType">
	                        <option value="All">전체</option>
	                        <option value="AI">AI</option>
	                        <option value="AO">AO</option>
	                        <option value="DI">DI</option>
	                        <option value="DO">DO</option>
	                        <option value="SC">SC</option>
	                        <option value="DT">DT</option>
	                    </select>                        
	                </td>
                    <th>검색어</th>
                    <td>
                        <div class="fx_form">
                          <input type="text" id="findData" name="findData">
                        </div>
                    </td>
                    <td>
	                   <div class="button">
	                   	<a class="btn_list" href="#none" id="tagFind" name="tagFind">검색</a>
	                   	<a class="btn_list" href="#none" id="tagFindAll" name="tagFindAll">Fast All</a>
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
                    <col />
                    <col width="60px"/>
                    <col width="80px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>LOOP NAME</th>
                        <th>DESCR</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody id="tagSearchList" name="tagSearchList">
                <tr>
	                <td class="tc" id="tagHogi"></td>
	                <td class="tc" id="tagXyGubun"></td>
	                <td class="tc" id="tagLoopName"></td>
	                <td class="tc" id="tagDescr"></td>
	                <td class="tc" id="tagIoType"></td>
	                <td class="tc" id="tagAddress"></td>
	                <td class="tc" id="tagIoBit"></td>
	                <td class="tc" id="tagMin"></td>
	                <td class="tc" id="tagMax"></td>
	                <td class="tc" id="tagSaveCore"></td>
                </tr>
                </tbody>
            </table>
            <!-- //list_table -->
             <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                </div>
                <div class="button">
                    <a href="#none" class="btn_page" id="tagSearchSelect" name="tagSearchSelect">선택</a>
        			<a href="#none" class="btn_page" onclick="closeModal('modal_3');">닫기</a>
                </div>
            </div>
            <!-- //list_bottom -->
        </div>
        <!-- //list_wrap -->      
</div>
<!-- pop_contents -->
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

