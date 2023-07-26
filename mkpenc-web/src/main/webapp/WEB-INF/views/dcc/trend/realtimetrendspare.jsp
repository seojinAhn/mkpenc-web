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
<style type="text/css">
	@page {
		size: A3 landscape;
		margin: [5 10 5 10];
	}
	
	@media print {
		body {
			overflow: hidden;
		}
		* {
			-webkit-print-color-adjust: exact;
			print-color-adjust: exact;
		}
		header-wrap, footer-wrap, page-title, .no-print { display:none }
		.page {
			object-fit: contain;
			background: initial;
			page-break-before: avoid;
			page-break-after: avoid;
			page-break-inside: avoid;
		}
		.print {
			zoom: 75%;
		}
	}
</style>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/datetimepicker/jquery.datetimepicker.css" />">
<script type="text/javascript" src="<c:url value="/resources/datetimepicker/jquery.datetimepicker.full.min.js" />" charset="utf-8"></script>

<link rel="stylesheet" href="/resources/sbchart/sbchart.css">
<script type="text/javascript" src="/resources/sbchart/sbchart.js"></script>

<script src="/resources/html2canvas/html2canvas.min.js"></script>
<script src="/resources/html2canvas/html2pdf.bundle.js"></script>

<script type="text/javascript">
	var hogiHeader = '${UserInfo.hogi}' != "undefined" && '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
	var xyHeader = '${UserInfo.xyGubun}' != "undefined" && '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";
	var currentSelGrp = "";
	var grpNos = [];
	var selGrpNm = "";
	var colorList = ['#801517','#B9529F','#1EBCBE','#282A73','#ED1E24','#7A57A4','#70CBD1','#364CA0'];
	var bGroupFlag = false;
	var hideLegnedItems = [];
	var timerOn = false;
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
	var isInit = true;
	var rTerm = '5';
	var hTerm = '5';
	var mvCnt = 0;
	var rUseGap = false;
	var hUseGap = false;
	var gotReal = false;
	var tXData = [];
	
	var chart;
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
		
		var sDtm,eDtm,eDate,eHour,eMin;
		
		jQuery.datetimepicker.setLocale('ko');
		
		$('#selectSDate').datetimepicker(DatetimepickerDefaults({}));
		$('#selectEDate').datetimepicker(DatetimepickerDefaults({}));
		
		$(document.body).delegate('#chkUseGap', 'click', function() {
			chkUseGap_click($("input:checkbox[id='chkUseGap']").is(":checked"));
		});
		
		$(document.body).delegate('#R', 'click', function() {
			$("#trendTitle").text('REALTIME TREND');
			//$("#trendPath").empty().append('<span>DCC</span><span>Status</span><strong>REALTIME TREND</strong>');
			$("#txtTimeGapI").val(rTerm);
			if( rUseGap ) $("#input:radio[id='R']").prop("checked",true);
			
			if( gInterval*1 != rTerm*1000 ) gInterval = rTerm*1000;
			
			timerOn = true;
			var alreadyClicked = $("input:radio[id='R']").is(":checked") ? true : false;
			$("#selectSDate").val('');
			$("#selectEDate").val('');
			
			$("#cmdHistorical").css("display","none");
			$("#cmdReal").css("display","");
			$("#divUseGap").css("display","none");
			$("#searchDate").css("display","none");
			$("#mv_prev").css("display","none");
			$("#mv_next").css("display","none");
			$("#txtTimeGapI").attr("disabled",false);
			
			function modalPart() {
				return new Promise(function(resolve,reject) {
					openModal('modal_loading');
					
					setTimeout(function() {
						resolve();
					},100);
				});
			}
			
			modalPart().then(function() {
			//if( !alreadyClicked ) {
				//var mskEDtm = new Date();
				//var mskSDtm = new Date();
				//mskSDtm.setSeconds(mskSDtm.getSeconds()-5*840);
	
				//$("#selectSDate").val(mskSDtm.getFullYear()+'-'+convNum(mskSDtm.getMonth(),2)+'-'+convNum(mskSDtm.getDate(),3)+' '+convNum(mskSDtm.getHours(),0)+':'+convNum(mskSDtm.getMinutes(),1)+':'+convNum(mskSDtm.getSeconds(),1));
				//$("#selectEDate").val(mskEDtm.getFullYear()+'-'+convNum(mskEDtm.getMonth(),2)+'-'+convNum(mskEDtm.getDate(),3)+' '+convNum(mskEDtm.getHours(),0)+':'+convNum(mskEDtm.getMinutes(),1)+':'+convNum(mskEDtm.getSeconds(),1));

				var selGrpName = $("#cboUGrpName option:selected").val();
				if( selGrpName != 'null' ) {
					isInit = false;
					triggerChart('R');
					
					//timerOn = true;
				} else {
					closeModal('modal_loading');
				}
			//}
			});
		});
		
		$(document.body).delegate('#H', 'click', function() {
			$("#trendTitle").text('HISTORICAL TREND');
			//$("#trendPath").empty().append('<span>DCC</span><span>Status</span><strong>HISTORICAL TREND</strong>');
			$("#txtTimeGapI").val(hTerm);
			if( hUseGap ) $("#input:radio[id='H']").prop("checked",true);

			if( gInterval*1 != hTerm*1000 ) gInterval = hTerm*1000;
			
			timerOn = false;
			setInitSelectDate();
			var alreadyClicked = $("input:radio[id='H']").is(":checked") ? true : false;
			//console.log(alreadyClicked);
			
			//cmdHistorical_click();
			$("#cmdHistorical").css("display","");
			$("#cmdReal").css("display","none");
			$("#divUseGap").css("display","");
			$("#searchDate").css("display","");
			$("#mv_prev").css("display","");
			$("#mv_next").css("display","none");
			$("#txtTimeGapI").attr("disabled",true);
			
			var comAjax = new ComAjax("scanTimeFrm");
			comAjax.setUrl("/dcc/trend/getScanTime");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.setCallback("mbr_ScanTimeCallback");
			comAjax.ajax();
				
			if( !alreadyClicked ) {
				
				var curScanTime = $("#scanTimeGot").val();
				var txtTimeGap = $("#txtTimeGapI").val() == null ? 5 : $("#txtTimeGapI").val();
				var pDate = curScanTime.split(' ')[0];
				var pHour = curScanTime.split(' ')[1].split(':')[0];
				var pMin = curScanTime.split(' ')[1].split(':')[1];
				var pSec = curScanTime.split(' ')[1].split(':')[2];
				var mskEDtm = new Date(pDate.split('-')[0]*1, pDate.split('-')[1]*1-1, pDate.split('-')[2]*1, pHour, pMin, pSec);
				var mskSDtm = new Date(pDate.split('-')[0]*1, pDate.split('-')[1]*1-1, pDate.split('-')[2]*1, pHour, pMin, pSec);
				mskSDtm.setSeconds(mskSDtm.getSeconds()-txtTimeGap*840);
	
				var hisStartDate = mskSDtm.getFullYear()+'-'+convNum(mskSDtm.getMonth()+1,2)+'-'+convNum(mskSDtm.getDate(),3)+' '+convNum(mskSDtm.getHours(),0)+':'+convNum(mskSDtm.getMinutes(),1)+':'+convNum(mskSDtm.getSeconds(),1);
				var hisEndDate = mskEDtm.getFullYear()+'-'+convNum(mskEDtm.getMonth()+1,2)+'-'+convNum(mskEDtm.getDate(),3)+' '+convNum(mskEDtm.getHours(),0)+':'+convNum(mskEDtm.getMinutes(),1)+':'+convNum(mskEDtm.getSeconds(),1);
				
				$("#selectSDate").val(hisStartDate);
				$("#selectEDate").val(hisEndDate);
	
				setLblDate(hogiHeader,xyHeader,hisEndDate);

				isInit = false;
				triggerChart('H');
			}
		});
		
		$(document.body).delegate('#txtTimeGapI','change',function() {
			xData = [];
			if( $("input:radio[id='H']").is(":checked") ) {
				hTerm = $("#txtTimeGapI").val();
			} else {
				rTerm = $("#txtTimeGapI").val();
			}
		});
		
		$(document.body).delegate('#3', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '3';
			xData = [];
			
			if( $("#cboUGrpName option:selected").val() != 'null' ) {
				if( $("#input:radio[id='H']").is("checked") ) {
					triggerChart('H');
				} else {
					triggerChart('R');
				}
			}
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#4', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '4';
			xData = [];
			
			if( $("#cboUGrpName option:selected").val() != 'null' ) {
				if( $("#input:radio[id='H']").is("checked") ) {
					triggerChart('H');
				} else {
					triggerChart('R');
				}
			}
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#X', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'X';
			xData = [];
			
			if( $("#cboUGrpName option:selected").val() != 'null' ) {
				if( $("#input:radio[id='H']").is("checked") ) {
					triggerChart('H');
				} else {
					triggerChart('R');
				}
			}
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#Y', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'Y';
			xData = [];
			
			if( $("#cboUGrpName option:selected").val() != 'null' ) {
				if( $("#input:radio[id='H']").is("checked") ) {
					triggerChart('H');
				} else {
					triggerChart('R');
				}
			}
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate("#selectSDate","change",function() {
			var strSDtm = $("#selectSDate").val();
			var strEDtm = $("#selectEDate").val();
			
			var sDt = strSDtm.split('-');
			var sTm = sDt[2].split(' ')[1].split(':');
			var sSec = 0;
			if( sTm.length == 3 ) sSec = sTm[2].indexOf('.') > -1 ? sTm[2].substring(0,sTm[2].indexOf('.'))*1 : sTm[2]*1;
			
			var eDt = strEDtm.split('-');
			var eTm = eDt[2].split(' ')[1].split(':');
			var eSec = 0;
			if( eTm.length == 3 ) eSec = eTm[2].indexOf('.') > -1 ? eTm[2].substring(0,eTm[2].indexOf('.'))*1 : eTm[2]*1;
			
			var sDtm = new Date(sDt[0]*1, sDt[1]*1-1, sDt[2].split(' ')[0]*1, sTm[0]*1, sTm[1]*1, sSec);
			var eDtm = new Date(eDt[0]*1, eDt[1]*1-1, eDt[2].split(' ')[0]*1, eTm[0]*1, eTm[1]*1, eSec);
			
			if( eDtm > sDtm ) {
				$("#txtTimeGapI").val(Math.round((eDtm-sDtm)/840000) < 5 ? 5 : Math.round((eDtm-sDtm)/840000));
			}
		});
		
		$(document.body).delegate("#selectEDate","change",function() {
			var strSDtm = $("#selectSDate").val();
			var strEDtm = $("#selectEDate").val();
			
			var sDt = strSDtm.split('-');
			var sTm = sDt[2].split(' ')[1].split(':');
			var sSec = 0;
			if( sTm.length == 3 ) sSec = sTm[2].indexOf('.') > -1 ? sTm[2].substring(0,sTm[2].indexOf('.'))*1 : sTm[2]*1;
			
			var eDt = strEDtm.split('-');
			var eTm = eDt[2].split(' ')[1].split(':');
			var eSec = 0;
			if( eTm.length == 3 ) eSec = eTm[2].indexOf('.') > -1 ? eTm[2].substring(0,eTm[2].indexOf('.'))*1 : eTm[2]*1;
			
			var sDtm = new Date(sDt[0]*1, sDt[1]*1-1, sDt[2].split(' ')[0]*1, sTm[0]*1, sTm[1]*1, sSec);
			var eDtm = new Date(eDt[0]*1, eDt[1]*1-1, eDt[2].split(' ')[0]*1, eTm[0]*1, eTm[1]*1, eSec);
			
			if( eDtm > sDtm ) {
				$("#txtTimeGapI").val(Math.round((eDtm-sDtm)/840000) < 5 ? 5 : Math.round((eDtm-sDtm)/840000));
			}
		});
		
		$(document.body).delegate("#setFrmIO","click",function() {
			timerOn = false;
			gHogi = $("#cboHogi option:selected").val();
			gXYGubun = $("#cboXYGubun option:selected").val();
			gIOType = $("#cboIOType option:selected").val();
			openModal('modal_1');
			
			if( $("#mouse_area").css("display") != 'none' ) $("#mouse_area").css("display","none");
		});
		
		$(document.body).delegate("#mnuAddGroup","click",function() {
			timerOn = false;
			bGroupFlag = true;
			//gHogi = $("#cboHogi option:selected").val();
			//gXYGubun = $("#cboXYGubun option:selected").val();
			//gIOType = $("#cboIOType option:selected").val();
			
			setTagTableClear();
			openLayer('modal_1');
			
			if( $("#mouse_area").css("display") != 'none' ) $("#mouse_area").css("display","none");
		});
		
		$(document.body).delegate('#cboHogi', 'change', function() {
			//console.log($("#cboHogi option:selected").val()+' | '+swSort);
			//console.log(gXYGubun+' | '+$("#cboIOType option:selected")+' | '+$("#txtADDRESS").val());
			if( $("#cboHogi option:selected").val() != '' && !swSort ) {
				gHogi = $("#cboHogi option:selected").val() != '4' ? '3' : '4';
				if( typeof gXYGubun != 'undefined' && typeof $("#cboIOType option:selected") != 'undefined' && $("#txtADDRESS").val() != '' ) {
					ssql(false);
				}
			}
		});
		
		//$("#cboXYGubun").change(function() {
		$(document.body).delegate('#cboXYGubun', 'change', function() {
			if( $("#cboXYGubun option:selected").val() != '' && !swSort ) {
				gXYGubun = $("#cboXYGubun option:selected").val() != 'Y' ? 'X' : 'Y';
				if( $("#txtADDRESS").val() != '' ) {
					ssql(false);
				}
			}
		});
		
		//$("#chkSaveCore").change(function() {
		$(document.body).delegate('#chkSaveCore', 'change', function() {
			if( $("input:checkbox[id='chkSaveCore']").is(":checked") ) {
				ioEn = true;
				$("#txtIOBIT").attr("disabled",false);
			} else {
				ioEn = false;
				$("#txtIOBIT").attr("disabled",true);
			}
		});
		
		//$("#cboIOType").change(function() {
		$(document.body).delegate('#cboIOType', 'change', function() {
			if( $("#cboIOType option:selected").val() == '' || !swSort ) {
				ioEn = false;
				scEn = false;
				gIOType = $("#cboIOType option:selected").val();
				if( typeof gHogi == 'undefined' || gHogi == '' ) {
					alert('호기를 선택해주세요');
					return;
				}
				if( typeof gXYGubun == 'undefined' || gXYGubun == ''  ) {
					alert('X Y를 선택해주세요');
					return;
				}
				if( typeof gIOType == 'undefined' || gIOType == ''  ) {
					alert('IO TYPE을 선택해주세요');
					return;
				}
				if( gIOType == 'DI' || gIOType == 'DO' || gIOType == 'SC' ) {
					ioEn = true;
					$("#txtIOBIT").attr("disabled",false);
				} else {
					ioEn = false;
					$("#txtIOBIT").attr("disabled",true);
					if( $("#txtLOOPNAME").val() == '' ) $("#txtIOBIT").val('');
				}
				if( gIOType == 'SC' ) {
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
				$("#txtLOOPNAME").val('');
				$("#txtMax").val('');
				$("#txtMin").val('');
				$("#txtIOBIT").val('');
				$("#txtADDRESS").val('');
				$("input:checkbox[id='chkSaveCore']").prop("checked",false);
				
				if( !$("#txtADDRESS").attr("disabled") ) $("#txtADDRESS").focus();
			}
		});
		
		$(document.body).delegate('#cmdReal', 'click', function() {
			function modalPart() {
				return new Promise(function(resolve,reject) {
					openModal('modal_loading');
					
					setTimeout(function() {
						resolve();
					},100);
				});
			}
			
			modalPart().then(function() {
				if( $("#cboUGrpName option:selected").val() != 'null' ) {
					cmdReal_click();
				} else {
					closeModal('modal_loading');
				}
			});
		});
		
		$(document.body).delegate('#cmdHistorical', 'click', function() {
			function modalPart() {
				return new Promise(function(resolve,reject) {
					openModal('modal_loading');
					
					setTimeout(function() {
						resolve();
					},100);
				});
			}
			
			modalPart().then(function() {
				if( $("#cboUGrpName option:selected").val() != 'null' ) {
					cmdHistorical_click();
				} else {
					closeModal('modal_loading');
				}
			});
		});
		
		$(document.body).delegate('#cboUGrpName', 'click', function() {
			cboUGrpName_click(0);
		});
		
		$(document.body).on("change", "#cboUGrpName", function() {
			cboUGrpName_change();
		});
		
		$(document.body).delegate('#cboReference','change',function() {
			Group_Get($("#cboReference").val(),1);
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
		
		$(document.body).delegate('#upGroup', 'click', function() {
			upGroup_click();
		});
		
		$(document.body).delegate('#downGroup', 'click', function() {
			downGroup_click();
		});
		
		$(document.body).delegate('#addGroup', 'click', function() {
			addGroup_click();
		});
		
		$(document.body).delegate('#delGroup', 'click', function() {
			delGroup_click();
		});
		
		$(document.body).delegate('#updateGroup', 'click', function() {
			updateGroup_click();
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
		
		$(document.body).delegate('#refGroupList tr','click',function() {
			$(this).addClass("highlight");
			$(this).siblings().removeClass("highlight");
		});
		
		$(document.body).delegate('#myGroupList tr','click',function() {
			$(this).addClass("highlight");
			$(this).siblings().removeClass("highlight");

			$("#txtGrpNo").val($(this).context.children[1].textContent+'');
			$("#txtGrpName").val($(this).context.children[2].textContent+'');
			
			selTdID = $(this)[0].children[1].children[0].id;
		});
		
		/*timer = setInterval(function () {
			console.log(timerOn+', '+gInterval);
		
			if( timerOn && lastGrp != 'null' ) {
				triggerChart('R');
				//if( !$("input:radio[id='H']").is(":checked") ) {
				//	console.log('tick >>> '+lastGrp);
				//}
			}
			//comAjax.ajax();
		}, gInterval);*/
		
		setTimer(1);
		//doInterval(gInterval);
		
	});
		
	function Group_Get(sID,type) {
		var comAjax = new ComAjax("selGrpFrm");
		comAjax.setUrl('/dcc/trend/groupGet');
		comAjax.addParam('hogiHeader',hogiHeader);
		comAjax.addParam('xyHeader',xyHeader);
		comAjax.addParam('gMenuNo','22');
		comAjax.addParam('type',type);
		comAjax.addParam('gID',sID);
		comAjax.setCallback('mbr_groupGetCallBack');
		comAjax.ajax();
	}
		
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
			comAjax.addParam('uMenuNo','22');
			comAjax.addParam('fixed','S');
			comAjax.addParam('his',$("input:radio[id='H']").is(":checked") ? 'H' : 'R');
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
		
	function doInterval(time) {
		if( time == '' || typeof time == 'undefined' ) {
			timer = setTimeout(function run() {
			//timer = setInterval(function run() {
				if( timerOn && lastGrp != 'null' ) {
					isInit = false;
					triggerChart('R');
					//if( !$("input:radio[id='H']").is(":checked") ) {
					//	console.log('tick >>> '+lastGrp);
					//}
				}
				//comAjax.ajax();
				setTimeout(run, gInterval);
			}, gInterval);
		} else {
			timer = setTimeout(function run() {
			//timer = setInterval(function run() {
				if( timerOn && lastGrp != 'null' ) {
					isInit = false;
					triggerChart('R');
					//if( !$("input:radio[id='H']").is(":checked") ) {
					//	console.log('tick >>> '+lastGrp);
					//}
				}
				//comAjax.ajax();
				setTimeout(run, time);
			}, time);
		}
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
	
	function rangeCustom(id,type) {
		var goFlag = false;
		if( type == 1 ) {
			goFlag = true;
		} else {
			if( window.event.keyCode == 13 ) {
				goFlag = true;
			}
		}
		
		if( goFlag ) {
			var mId = $("#"+id).val();
			var num = 0;
			var loHi = 0;
			
			function chartPart() {
				return new Promise(function(resolve,reject) {
					if( id.indexOf('Hi') > -1 ) {
						num = id.replace('Hi','')*1;
						loHi = 1;
					} else if( id.indexOf('Low') > -1 ) {
						num = id.replace('Low','')*1;
						loHi = 0;
					}
			
					var newConfig = JSON.parse(JSON.stringify(gChartConfig));
					for( var ni=0;ni<gChartConfig.length;ni++ ) {
						if( loHi == 1 ) {
							minVal = $("#Low"+num).val()*1;
							if( ni == num-1 ) {
								newConfig[ni]['axis']['y'] = {
									show: false,
									min: minVal,
									max: mId*1,
									padding: 0,
									tick: {
										count: 11
									},
									domain: false
								};
							}
						} else {
							maxVal = $("#Hi"+num).val()*1;
							if( ni == num-1 ) {
								newConfig[ni]['axis']['y'] = {
									show: false,
									min: mId*1,
									max: maxVal,
									padding: 0,
									tick: {
										count: 11
									},
									domain: false
								};
							}
						}
						newConfig[ni]['hideLegendItems'] = hideLegnedItems;
					}
					
					gChartConfig = JSON.parse(JSON.stringify(newConfig));
					for( var i=0;i<gChartConfig.length;i++ ) {
						chart = new sb.chart("#chartArea"+i, newConfig[i]) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
						/*chart.axis({x: {
							type:'category',
							show: false,
							padding: 0,
							tick: {
								count: 21
							}
						}}).render();
						chart.data({hideLegendItems:hideLegnedItems}).render();*/
						chart.render();
						charts.splice(i,1,chart);
					}
					
					resolve();
				});
			}
			
			chartPart().then(function() {
				var rangeInfo = {};
				var chkr = 0;
				for( var r=0;r<customRange.length;r++ ) {
					if( typeof customRange[r] != 'undefined' ) {
						if( customRange[r].name == id ) {
							chkr = r;
						}
					}
				}
				rangeInfo['name'] = id;
				//rangeInfo['value'] = $("#"+id).val();
				rangeInfo['value'] = mId;
				if( chkr == 0 ) {
					customRange.push(rangeInfo);
				} else {
					customRange[chkr].value = mId;
				}
	
				for( var cs=1;cs<gChartConfig.length;cs++ ) {
					$("#chartArea"+cs).css("position","absolute");
					$("#chartArea"+cs).css("top","259px");
					$("#chartArea"+cs).css("left","90px");
					$("#chartArea"+cs).css("z-index",cs);
				}
		
				$("#chartArea0").css("z-index","99");
			});
		}
	}
	
	function pressAddr() {
		if( window.event.keyCode == 13 ) {
			txtADDRESS_LostFocus();
		}
	}

	function txtADDRESS_LostFocus() {
		//ioEn = false;
		//scEn = false;
		//swSort = false;

		//if( gubun == 'D' ) {
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
			//swSort = true;
		//}
		
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
	
	function dateAdd(type,interval,date) {
		if( date != '' && typeof date == 'string' ) {
			date = date.replace(/{/gi,'');
			interval = interval*1;

			var aDtm,cDtm,cDate,cHour,cMin,cSec;
			cDate = date.split(' ')[0];
			cHour = date.split(' ')[1].split(':')[0];
			cMin = date.split(' ')[1].split(':')[1];
			cSec = date.split(' ')[1].split(':')[2];
			cDtm = new Date(cDate.split('-')[0]*1, cDate.split('-')[1]*1-1, cDate.split('-')[2]*1, cHour*1, cMin*1, cSec*1);
			
			if( type == 's' ) {
				cDtm.setSeconds(cDtm.getSeconds()+interval);
			} else if( type == 'n' ) {
				cDtm.setMinutes(cDtm.getMinutes()+interval);
			} else if( type == 'h' ) {
				cDtm.setHours(cDtm.getHours()+interval);
			} else if( type == 'd' ) {
				cDtm.setDate(cDtm.getDate()+interval);
			} else if( type == 'm' ) {
				cDtm.setMonth(cDtm.getMonth()+interval);
			} else if( type == 'y' ) {
				cDtm.setFullYear(cDtm.getFullYear()+interval);
			}
			
			return cDtm.getFullYear()+'-'+convNum(cDtm.getMonth()*1+1,2)+'-'+convNum(cDtm.getDate(),3)+' '+convNum(cDtm.getHours(),0)+':'+convNum(cDtm.getMinutes(),1)+':'+convNum(cDtm.getSeconds(),1);
		} else if( date != '' && typeof date == 'object' ) {
			if( type == 's' ) {
				date.setSeconds(date.getSeconds()+interval);
			} else if( type == 'n' ) {
				date.setMinutes(date.getMinutes()+interval);
			} else if( type == 'h' ) {
				date.setHours(date.getHours()+interval);
			} else if( type == 'd' ) {
				date.setDate(date.getDate()+interval);
			} else if( type == 'm' ) {
				date.setMonth(date.getMonth()+interval);
			} else if( type == 'y' ) {
				date.setFullYear(date.getFullYear()+interval);
			}
			
			return date.getFullYear()+'-'+convNum(date.getMonth()*1+1,2)+'-'+convNum(date.getDate(),3)+' '+convNum(date.getHours(),0)+':'+convNum(date.getMinutes(),1)+':'+convNum(date.getSeconds(),1);
		} else {
			return '';
		}
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
			if( $("input:radio[id='H']").is(":checked") ) {
				hUseGap = true;
				hTerm = $("#txtTimeGapI").val();
			} else {
				rUseGap = true;
				rTerm = $("#txtTimeGapI").val();
			}
			$("#txtTimeGapI").attr("disabled",false);
			$("#selectSDate").attr("disabled",true);
		} else {
			if( $("input:radio[id='H']").is(":checked") ) {
				hUseGap = false;
				hTerm = $("#txtTimeGapI").val();
			} else {
				rUseGap = false;
				rTerm = $("#txtTimeGapI").val();
			}
			$("#txtTimeGapI").attr("disabled",true);
			$("#selectSDate").attr("disabled",false);
		}
	}
	
	function setInitSelectDate() {
		var sGap = $("#txtTimeGapI").val();
	
		if( isNull('${BaseSearch.startDate}') && !isNull('${BaseSearch.endDate}') ) {
			eDate = '${BaseSearch.endDate}'.split(' ')[0];
			eHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			eMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			eDtm = new Date(eDate.split('-')[0]*1, eDate.split('-')[1]*1-1, eDate.split('-')[2]*1);
			//sDtm = new Date(eDtm.setDate(eDtm.getDate()-3));
			sDtm = new Date(eDtm.setSeconds(eDtm.getSeconds()-sGap*840));
			$("#selectSDate").val(sDtm.getFullYear()+'-'+convNum(sDtm.getMonth()+1,2)+'-'+convNum(sDtm.getDate(),3)+' '+convNum(eHour,0)+':'+convNum(eMin,1));
			$("#selectEDate").val(eDate+' '+convNum(eHour,0)+':'+convNum(eMin,1));
		} else if( !isNull('${BaseSearch.startDate}') && isNull('${BaseSearch.endDate}') ) {
			sDate = '${BaseSearch.endDate}'.split(' ')[0];
			sHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			sMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			sDtm = new Date(eDate.split('-')[0]*1, eDate.split('-')[1]*1-1, eDate.split('-')[2]*1);
			//eDtm = new Date(sDtm.setDate(sDtm.getDate()+3));
			eDtm = new Date(sDtm.setSeconds(sDtm.getSeconds()+sGap*840));
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
			//sDtm = new Date(sDtm.setDate(sDtm.getDate()-3));
			sDtm = new Date(sDtm.setSeconds(sDtm.getSeconds()-sGap*840));
			$("#selectSDate").val(sDtm.getFullYear()+'-'+convNum(sDtm.getMonth()+1,2)+'-'+convNum(sDtm.getDate(),3)+' '+convNum(sDtm.getHours(),0)+':'+convNum(sDtm.getMinutes(),1));
			$("#selectEDate").val(eDtm.getFullYear()+'-'+convNum(eDtm.getMonth()+1,2)+'-'+convNum(eDtm.getDate(),3)+' '+convNum(eDtm.getHours(),0)+':'+convNum(eDtm.getMinutes(),1));
		}
	}
	
	function getSub(data,tagNm,seq,type) {
		var tmpData = JSON.parse(JSON.stringify(data));
		var rtv = [];
		var tmp = {
			'axes': {
				'y':{}
			},
			'y': {}
		};
		
		if( type == 0 ) {
			for( var i=0;i<tmpData.length;i++ ) {
				tmp['name'] = tmpData[i].name;
				tmp[tagNm] = tmpData[i][tagNm];
				var tmpArray = JSON.parse(JSON.stringify(tmp));
	
				rtv.splice(i,1,tmpArray);
			}
		} else {
			for( var i=0;i<Object.keys(tmpData).length-1;i++ ) {
				tmp['axes']['y'] = tagNm;
				
				if( i == seq ) {
					var tKey = 'y'+(seq+1);
					tmp['y'] = tmpData[tKey];
					
					return tmp;
				}
			}
		}
		
		return rtv;
	}
	
	function cboUGrpName_click(type) {
		for( var i=1;i<21;i++ ) {
			$("#loading"+i).css("backgroundColor","rgb(255, 255, 255)");
		}
	
		timerOn = false;
		var selGrpName = $("#cboUGrpName option:selected").val();
		var his = $("input:radio[id='H']").is(":checked") ? 'H' : 'R';
		
		if( selGrpName != lastGrp || type == 1 ) {
			isInit = true;
			triggerChart(his);
			
			if( his == 'R' ) {
				timerOn = true;
			} else {
				tiemrOn = false;
			}
		}
	}
	
	function cboUGrpName_blur() {
		if( !$("input:radio[id='H']").is(":checked") ) {
			timerOn = true;
		} else {
			tiemrOn = false;
		}
		closeModal('modal_loading');
	}
	
	function cboUGrpName_change() {
		var his = $("input:radio[id='H']").is(":checked") ? 'H' : 'R';
		customRange = [];
		
		function doModal() {
			return new Promise(function(resolve,reject) {
				openModal('modal_loading');
				xData = [];
				
				setTimeout(function() {
					resolve();
				},100);
			});
		}
		
		doModal().then(function() {
			isInit = true;
			triggerChart(his);
			if( his == 'R' ) {
				timerOn = true;
			} else {
				tiemrOn = false;
			}
		
			closeModal('modal_loading');
		});
	}
		
	function createChart2(data,xAxis,axisConfig,his){
		if( his == 'R' ) {
			gotReal = true;
		} else {
			gotReal = false;
		}
		$("#lblBody3").css("display","none");
		$("#lblBody4").css("display","none");
		var chartCnt = xAxis.length;
		
		function chartPart() {
			return new Promise(function(resolve,reject) {
				var colorSet = ['#801517','#B9529F','#1EBCBE','#282A73','#ED1E24','#7A57A4','#70CBD1','#364CA0'];
				for( var cc=8;cc<xAxis.length;cc++ ) {
					colorSet.push('#F'+(cc%9)+(9-cc%9)+(9-cc%9)+(cc%9)+'A');
				}
				
				var len = data.length-1;
				var unit = Math.floor(len/10);
				var buffer = 0;
				var pointF = '';
				var xDataSub = [];
				
				var viewItems = [];
				var setLinesWidth = [];
				for( var vi=0;vi<xAxis.length;vi++ ) {
					if( vi == 0 ) {
						setLinesWidth.splice(0,1,{"key":xAxis[0], "width":lineBold});
					} else {
						setLinesWidth.splice(vi,1,{"key":xAxis[vi], "width":0});
					}
				}
				
				for( var d=1;d<12;d++ ) {
					//var pos = (d-1)*unit+Math.floor(d/2)+d%2;
					if( len - unit*10 > 0 ) buffer = Math.floor(d/2)-1;
					var pos = (d-1)*unit+buffer;
					if( d == 1 ) {
						pointF = data[0].name.split(' ');
					} else if( d > 1 && d < 11 ) {
						pointF = data[pos].name.split(' ');
					} else {
						pointF = data[len].name.split(' ');
					}
					var fMonDay = pointF[0].substring(pointF[0].indexOf('-')+1,pointF[0].length);
					var fTime = pointF[1];
					
					$("#dPoint"+d).text(fMonDay);
					$("#tPoint"+d).text(fTime);
				}
				
				var chartConfigs = [];
				
				for( var ci=0;ci<xAxis.length;ci++ ) {
					//for( var ci=1;ci<xAxis.length;ci++ ) {
					var chartConfig = {};
					if( ci == 0 ) {
						chartConfig = {
							global: {
								svg: {
									classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
								},
								size: {
									width: 1200,
									height: 400
								},
								color: {
									pattern: colorSet
								},
								background: {
									src: "rgba(255,255,255,0)"
								},
								crosshair: {
									show: setCrossHair,
									dotted: false
								}
							},
							data: {
								type: 'line', // 차트의 타입을 설정 
								json: data, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
								keys: { // json 형태의 데이터를 사용 시, 필수로 keys 속성을 사용해야 함
									x: "name", // 각각의 x축 이름을 chartData의 name값으로 설정 
									value: xAxis // chartData의 2015, 2016, 2017 데이터를 보여주도록 설정
								}
							},
							axis: {
								x: {
									show: false,
									padding: 0,
									tick: {
										count: 21
									}
								}
							},
							extend: {
								line: {
									hideCircle: true,
									setLinesWidth: setLinesWidth
								}
							},
							grid: {
								x:{show:false},
								y:{show:false}
							},
							legend: {
								show: false
							}
						};
					} else {
						var xDataSub = getSub(data,xAxis[ci],0,0);
						chartConfig = {
							global: {
								svg: {
									classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
								},
								size: {
									width: 1200,
									height: 400
								},
								color: {
									pattern: [colorSet[ci]]
								},
								background: {
									src: "rgba(255,255,255,0)"
								},
								crosshair: {
									show: setCrossHair,
									dotted: false
								}
							},
							data: {
								type: 'line', // 차트의 타입을 설정 
								json: xDataSub, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
								keys: { // json 형태의 데이터를 사용 시, 필수로 keys 속성을 사용해야 함
									x: "name", // 각각의 x축 이름을 chartData의 name값으로 설정 
									value: [xAxis[ci]] // chartData의 2015, 2016, 2017 데이터를 보여주도록 설정
								}
							},
							axis: {
								x: {
									show: false,
									padding: 0,
									tick: {
										count: 21
									}
								}
							},
							extend: {
								line: {
									hideCircle: true,
									setLinesWidthAll: lineBold
								}
							},
							grid: {
								x:{show:false},
								y:{show:false}
							},
							legend: {
								show: false
							}
						};
					}
					
					chartConfigs.splice(ci,1,chartConfig);
				}
				
				var divStr = '';
		        for( var cc=0;cc<chartCnt;cc++ ) {
		        	divStr += '<div id="chartArea'+cc+'"></div>';
		        	
		        	if( cc == chartCnt-1 ) {
		        		divStr += '<div><br><br><br></div>';
		        	}
		        }
		        $("#chart_wrap_area").empty();
		        $("#chart_wrap_area").append(divStr);
		        
		        for( var cf=0;cf<chartCnt;cf++ ) {
					var newAxisConfig = {};
					if( cf > 0 ) {
						newAxisConfig = getSub(axisConfig,xAxis[cf],cf,1);
						newAxisConfig['x'] = {
							type:'category',
							show: false,
							padding: 0,
							tick: {
								count: 21
							}
						};
						chartConfigs[cf]['axis'] = newAxisConfig;
					} else {
						axisConfig['x'] = {
							type:'category',
							show: false,
							padding: 0,
							tick: {
								count: 21
							}
						};
						chartConfigs[cf]['axis'] = axisConfig;
					}
					chartConfigs[cf]['data']['hideLegendItems'] = hideLegnedItems;
					gChartConfig = chartConfigs;
					var areaId = "#chartArea"+cf;
					chart = new sb.chart(areaId, chartConfigs[cf]); // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
					/*chart.axis({x: {
						type:'category',
						show: false,
						padding: 0,
						tick: {
							count: 21
						}
					}}).render();*/ // render 메소드를 사용해야 차트가 그려짐 (동적으로 사용 시에도 마지막에 꼭 render()를 써줘야 변경한 값들이 반영되어 보여집니다.)
					//chart.data({hideLegendItems:hideLegnedItems}).render();
					chart.render();
					charts.splice(cf,1,chart);
				}
		        
		        resolve();
			});
		}
		
		chartPart().then(function() {
			if( customRange.length > 0 ) {
				for( var cr=0;cr<customRange.length;cr++ ) {
					if( customRange[cr] != 'undefined' ) {
						$("#"+customRange[cr].name).val(customRange[cr].value*1);
						rangeCustom(customRange[cr].name,1);
					}
				}
			}
			
			for( var cs=1;cs<chartCnt;cs++ ) {
				$("#chartArea"+cs).css("position","absolute");
				$("#chartArea"+cs).css("top","259px");
				$("#chartArea"+cs).css("left","90px");
				$("#chartArea"+cs).css("z-index",cs);
			}
	
			$("#chartArea0").css("z-index","99");
			$("#chartBack").css("display","");
	
			if( !isInit ) {
				setCheckboxes(xAxis.length);
			} else {
				for( var ac=0;ac<xAxis.length;ac++ ) {
					if( activeCharts[ac] != ac ) activeCharts.splice(ac,0,ac);
				}
			}
			
			if( showX ) {
				$("#xAxisArea").css("display","");
			} else {
				$("#xAxisArea").css("display","none");
			}
			if( showY ) {
				$("#yAxisArea").css("display","");
			} else {
				$("#yAxisArea").css("display","none");
			}
			moveMore();
			closeModal('modal_loading');
			isInit = false;
		});
	}
		
	function removeModData(array,str) {
		if( str != '' ) {
			var set = new Set(array);
			var newArr = [...set];
	
			for( var i=0;i<newArr.length;i++ ) {
				if( newArr[i] == str ) {
					return true;
				}
			}
			return false;
		} else {
			return false;
		}
	}
	
	function triggerChart(his) {
		//var oldXData = JSON.parse(JSON.stringify(xData));
		var selGrpName = $("#cboUGrpName option:selected").val();
		//console.log(selGrpName);
		lastGrp = selGrpName;
		var sTimeGap = $("input:radio[id='H']").is(":checked") ? hTerm : rTerm;
		
		if( selGrpName != 'null' ) {
			var startDate = "";
			var endDate = "";
			if( $("#selectSDate").val() != null && typeof $("#selectSDate").val() != 'undefined' && $("#selectSDate").val() != '' ) {
				startDate = $("#selectSDate").val();//+':00.000';
				endDate = $("#selectEDate").val();//+':00.000';
				
				if( startDate.length < 19 ) startDate = startDate+':00.000';
				if( endDate.length < 19 ) endDate = endDate+':00.000';
			}
			
			/*var isRealtime = 'N';
			if( gotReal && oldXData.length > 800 ) {
				startDate = oldXData[oldXData.length-1].name;
				endDate = dateAdd('s',0,new Date());
				//if( dateDiff(startDate,endDate) < gInterval ) startDate = oldXData[oldXData.length-2].name;
				for( var c=2;c<4;c++ ) {
					//console.log(endDate+' - '+startDate+' = '+dateDiff(startDate,endDate)+' :: '+gInterval);
					if( dateDiff(startDate,endDate) < gInterval || dateDiff(startDate,endDate) == 0 ) {
						startDate = oldXData[oldXData.length-c].name;
					}
					//console.log(startDate);
				}
				isRealtime = 'Y';
			}*/

			tXData = [];
			var comAjax = new ComAjax("selGrpFrm");
			comAjax.setUrl("/dcc/trend/changeGrpName");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("startDate", startDate);
			comAjax.addParam("endDate", endDate);
			comAjax.addParam("txtTimeGap", sTimeGap);
			comAjax.addParam('sUGrpNo',selGrpName);
			//comAjax.addParam('isRealtime',isRealtime);
			comAjax.addParam("fixed",'S');
			comAjax.addParam("sMenuNo",'22');
			comAjax.addParam("sGrpID",'${UserInfo.id}');
			comAjax.addParam("gHis",his);
			comAjax.setCallback("mbr_RuntimerEventCallback");
			comAjax.ajax();

			//progressPos = Math.floor(Math.random()*3)+6;
			//createChart($("#testArea").text());
			
			var axisConfigs = [];
			var axisConfig = {};
			var axesInfo = {};
			/*axisConfig['x'] = {
				show: false,
				padding: 0,
				tick: {
					count: 21
				}
			};*/
			
			/*var xValues = $("#testArea").text().split("},{");
			var str0 = xValues[0];
			var strLast = xValues[xValues.length-1];
			
			str0 = str0.substring(1,str0.length);
			strLast = strLast.substring(0,strLast.length-1);
			
			xValues.splice(0,1,str0);
			xValues.splice(xValues.length-1,1,strLast);*/
	
			xData = [];
			xAxis = [];
			//var divCnt = Math.ceil((xValues[0].split(', ').length-1)/2);
			
			var hVal = $("#maxList").text().split(',');
			var lVal = $("#minList").text().split(',');
			/*var initMin = 0;
			var initMax = 0;
			
			for( var ty=1;ty<hVal.length+1;ty++ ) {
				if( initMin > lVal[ty-1]*1 ) initMin = lVal[ty-1]*1;
				if( initMax < hVal[ty-1]*1 ) initMax = hVal[ty-1]*1;
			}*/
			
			for( var ty=1;ty<hVal.length+1;ty++ ) {
				var minVal = lVal[ty-1]*1;
				var maxVal = hVal[ty-1]*1;// > minVal ? hVal[ty-1]*1 : minVal+1;
				var yInfos = {
					show: false,
					min: minVal,
					max: maxVal,
					padding: 0,
					tick: {
						count: 11
					},
					domain: false
				}
				
				if( ty == 1 ) {
					/*axisConfig['y'] = {
						show: false,
						padding: 0,
						tick: {
							count: 11
						},
						domain: false
					};*/
					axisConfig['y'] = yInfos;
				} else {
					var tKey = 'y'+ty;
					axisConfig[tKey] = yInfos;
				}
			}
			
			for( var j=0;j<tXData.length;j++ ) {
				if( j == 0 ) {
					var objectSize = Object.keys(tXData[0]).length;
				
					for( var d=1;d<objectSize;d++ ) {
						var tag = Object.keys(tXData[0])[d];
					
						xAxis.push(tag);
						
						if( d == 1 ) {
							axesInfo['y'] = tag;
						} else {
							var tKey = 'y'+d;
							axesInfo[tKey] = tag;
						}
					}
				}
			}
			
			/*if( xValues[0].length > 0 ) {
				for( var j=0;j<xValues.length;j++ ) {
					
					var xJson = xValues[j].split(', ');
					
					var tJson = {};
					tJson['name'] = xJson[0];
					for( var ti=1;ti<xJson.length;ti++ ) {
						var key = xJson[ti].split('=')[0];
						var val = (xJson[ti].split('=')[1])*1;
						tJson[key] = val;
					}
					
					tXData.push(tJson);
					if( j == 0 ) {
						for( var d=1;d<xJson.length;d++ ) {
							xAxis.push(xJson[d].split('=')[0]);
							
							if( d == 1 ) {
								axesInfo['y'] = xJson[d].split('=')[0];
							} else {
								var tKey = 'y'+d;
								axesInfo[tKey] = xJson[d].split('=')[0];
							}
						}
					}
				}*/
			/*} else {
				if( gotReal && oldXData.length > 800 ) {
					for( var d=1;d<Object.keys(oldXData[0]).length;d++ ) {
						xAxis.push(Object.keys(oldXData[0])[d]);
						
						if( d == 1 ) {
							axesInfo['y'] = Object.keys(oldXData[0])[d];
						} else {
							var tKey = 'y'+d;
							axesInfo[tKey] = Object.keys(oldXData[0])[d];
						}
					}
				}*/
			//}
			
			/*var xData2 = [];
			if( gotReal && oldXData.length > 0 ) {
				var tmpXData = JSON.parse(JSON.stringify(tXData));
				var xDataSize = tmpXData.length;
				
				if( xDataSize > 0 ) {
					if( tmpXData[0].name == oldXData[oldXData.length-1].name ) xDataSize--;
					oldXData.splice(0,xDataSize);
				} else {
					oldXData.splice(0,1);
				}
				
				for( var o=0;o<oldXData.length;o++ ) {
					xData2.push(oldXData[o]);
				}
				
				if( xDataSize > 0 ) {
					for( var n=0;n<xDataSize;n++ ) {
						if( xDataSize == 1 ) {
							var dif = Math.abs(dateDiff(tmpXData[0].name,oldXData[oldXData.length-1].name));
							if( dif < gInterval ) {
								var lastTmpData = JSON.parse(JSON.stringify(tmpXData[n]));
								//lastTmpData.name = oldXData[oldXData.length-1].name
								
								var lastFinalData = dateAdd('s',$("#txtTimeGapI").val(),tmpXData[n].name);
								tmpXData[n].name = lastFinalData;
								
								xData2.push(tmpXData[n]);
							}
						} else {
							var dif = Math.abs(dateDiff(tmpXData[0].name,xData2[xData2.length-1].name));
							if( dif < gInterval && dif > 0 && n == 0 ) {
								xData2.splice(xData2.length-1,1,tmpXData[0]);
								//xData2.push(tmpXData[n]);
							} else {
								xData2.push(tmpXData[n]);
							}
						}
					}
				} else {
					var lastTmpData = JSON.parse(JSON.stringify(oldXData[oldXData.length-1]));
					//lastTmpData.name = oldXData[oldXData.length-1].name
					
					var lastFinalData = dateAdd('s',$("#txtTimeGapI").val(),lastTmpData.name);
					lastTmpData.name = lastFinalData;
					
					xData2.push(lastTmpData);
				}
				xData = JSON.parse(JSON.stringify(xData2));
			} else {*/
				xData = JSON.parse(JSON.stringify(tXData));
			//}

			//console.log(xData[xData.length-1].name);
			if( xData.length > 0 ) {
				setLblDate(hogiHeader,xyHeader,xData[xData.length-1].name);

				xPos = xData[0].name+'||'+xData[xData.length-1].name;
	
				axisConfig['axes'] = axesInfo;
	
				if( xData[0].name != "" && xData[0].name != "undefined" ) createChart2(xData,xAxis,axisConfig,his);
			}
		} else {
			timerOn = false;
		}
	}
	
	function dateDiff(date1, date2) {
		var d1 = new Date(date1.replace(/{/gi,'').replace(/}/gi,''));
		var d2 = new Date(date2.replace(/{/gi,'').replace(/}/gi,''));
		
		return d2-d1;
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
	
	function cmdReal_click() {
		var sGap = $("#txtTimeGapI").val();
		
		if( gInterval*1 != sGap*1000 ) gInterval = sGap*1000;
		
		if( sGap == "0.5" ) {
			var size = xAxis.length;
			for( var i=0;i<size;i++ ) {
				if( $("#lblTagName"+i).attr("value") != '1' ) {
					alert('태그 전체가 0.5초 태그가 아닙니다. 5초이상을 입력하세요');
					break;
				}
			}
		}
		
		var mskEDtm = new Date();
		var mskSDtm = new Date();
		
		if( isNaN(sGap) ) {
			alert('검색기간 설정이 잘못되었습니다.');
			$("#txtTimeGapI").focus();
		} else {
			mskSDtm.setSeconds(mskSDtm.getSeconds()-sGap*840);

			$("#selectSDate").val(mskSDtm.getFullYear()+'-'+convNum(mskSDtm.getMonth()+1,2)+'-'+convNum(mskSDtm.getDate(),3)+' '+convNum(mskSDtm.getHours(),0)+':'+convNum(mskSDtm.getMinutes(),1)+':'+convNum(mskSDtm.getSeconds(),1));
			$("#selectEDate").val(mskEDtm.getFullYear()+'-'+convNum(mskEDtm.getMonth()+1,2)+'-'+convNum(mskEDtm.getDate(),3)+' '+convNum(mskEDtm.getHours(),0)+':'+convNum(mskEDtm.getMinutes(),1)+':'+convNum(mskEDtm.getSeconds(),1));

			isInit = false;
			triggerChart('R');
			
			timerOn = true;
		}
	}
	
	function cmdHistorical_click() {
		timerOn = false;
		
		var sGap = $("#txtTimeGapI").val();
		
		if( gInterval*1 != sGap*1000 ) gInterval = sGap*1000;;
		
		var strSDtm = $("#selectSDate").val();
		var strEDtm = $("#selectEDate").val();
		
		var sDt = strSDtm.split('-');
		var sTm = sDt[2].split(' ')[1].split(':');
		var sSec = 0;
		if( sTm.length == 3 ) sSec = sTm[2].indexOf('.') > -1 ? sTm[2].substring(0,sTm[2].indexOf('.'))*1 : sTm[2]*1;
		
		var eDt = strEDtm.split('-');
		var eTm = eDt[2].split(' ')[1].split(':');
		var eSec = 0;
		if( eTm.length == 3 ) eSec = eTm[2].indexOf('.') > -1 ? eTm[2].substring(0,eTm[2].indexOf('.'))*1 : eTm[2]*1;
		
		var sDtm = new Date(sDt[0]*1, sDt[1]*1-1, sDt[2].split(' ')[0]*1, sTm[0]*1, sTm[1]*1, sSec);
		var eDtm = new Date(eDt[0]*1, eDt[1]*1-1, eDt[2].split(' ')[0]*1, eTm[0]*1, eTm[1]*1, eSec);
		
		//console.log(sDtm+', '+eDtm);
		
		if( eDtm - sDtm < 0 ) {
			alert('검색기간 설정이 잘못되었습니다.');
			$("#selectEDate").focus();
		} else if( isNaN(sGap) ) {
			alert('검색기간 설정이 잘못되었습니다.');
			$("#txtTimeGapI").focus();
		} else if( Math.abs((eDtm - sDtm)/(30*24*60*60*1000)) > 20 ) {
			alert('시작일자가 20개월 이전입니다. 20개월 이전은 1분이상 주기만 볼 수 있습니다');
			if( sGap*1 < 60 ) {
				$("#txtTimeGapI").val('60');
			}
		} else if( sGap*1 < 5 ) {
			var size = xAxis.length;
			for( var i=0;i<size;i++ ) {
				if( $("#lblTagName"+i).attr("value") != '1' ) {
					alert('태그 전체가 0.5초 태그가 아닙니다. 5초이상을 입력하세요');
					break;
				}
			}
		} else {

			$("#mv_prev").css("display","");
			$("#mv_next").css("display","none");
			
			var selGrpName = $("#cboUGrpName option:selected").val();
			
			if( typeof selGrpName == 'undefined' ) selGrpName = $("#cboUGrpName option:eq(0)").val();
			
			doHistorical(0,strEDtm);
		}

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
		comAjax.addParam("sMenuNo", '22');
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
	
	function doHistorical(type,refTime) {
		
		var hisFStartDate = '';
		var hisFEndDate = '';
		var hisCStartDate = '';
		var hisCEndDate = '';

		var useGap = $("input:checkbox[id='chkUseGap']").is(":checked");
	
		var fixScanTime = refTime;
		var txtTimeGap = $("#txtTimeGapI").val() == null ? 5 : $("#txtTimeGapI").val();
		var fDate = fixScanTime.split(' ')[0];
		var fHour = fixScanTime.split(' ')[1].split(':')[0];
		var fMin = fixScanTime.split(' ')[1].split(':')[1];
		var fSec = fixScanTime.split(' ')[1].split(':').length == 3 ? fixScanTime.split(' ')[1].split(':')[2] : "0";
		var mskFEDtm = new Date(fDate.split('-')[0]*1, fDate.split('-')[1]*1-1, fDate.split('-')[2]*1, fHour*1, fMin*1, fSec*1);
		var mskFSDtm = new Date(fDate.split('-')[0]*1, fDate.split('-')[1]*1-1, fDate.split('-')[2]*1, fHour*1, fMin*1, fSec*1);
		
		if( type == 0 ) {
			if( useGap ) {
				mskFSDtm.setSeconds(mskFSDtm.getSeconds()-txtTimeGap*840);
			}
		} else if( type == 2 ) {
				mskFSDtm.setSeconds(mskFSDtm.getSeconds()-txtTimeGap*840);
		} else {
				mskFEDtm.setSeconds(mskFEDtm.getSeconds()+txtTimeGap*840);
		}

		var comAjax = new ComAjax("scanTimeFrm");
		comAjax.setUrl("/dcc/trend/getScanTime");
		comAjax.addParam("hogiHeader", hogiHeader);
		comAjax.addParam("xyHeader", xyHeader);
		comAjax.setCallback("mbr_ScanTimeCallback");
		comAjax.ajax();
		
		var curScanTime = $("#scanTimeGot").val();
		//var txtTimeGap = $("#txtTimeGap").val() == null ? 5 : $("#txtTimeGap").val();
		var cDate = curScanTime.split(' ')[0];
		var cHour = curScanTime.split(' ')[1].split(':')[0];
		var cMin = curScanTime.split(' ')[1].split(':')[1];
		var cSec = curScanTime.split(' ')[1].split(':')[2];
		var mskCEDtm = new Date(cDate.split('-')[0]*1, cDate.split('-')[1]*1-1, cDate.split('-')[2]*1, cHour, cMin, cSec);
		var mskCSDtm = new Date(cDate.split('-')[0]*1, cDate.split('-')[1]*1-1, cDate.split('-')[2]*1, cHour, cMin, cSec);
		if( type == 0 || type == 2 ) {
			if( useGap ) {
				mskCSDtm.setSeconds(mskCSDtm.getSeconds()-txtTimeGap*840);
			}
		} else {
			mskCSDtm.setSeconds(mskCSDtm.getSeconds()-txtTimeGap*840);
		}

		hisFStartDate = mskFSDtm.getFullYear()+'-'+convNum(mskFSDtm.getMonth()+1,2)+'-'+convNum(mskFSDtm.getDate(),3)+' '+convNum(mskFSDtm.getHours(),0)+':'+convNum(mskFSDtm.getMinutes(),1)+':'+convNum(mskFSDtm.getSeconds(),1);
		hisFEndDate = mskFEDtm.getFullYear()+'-'+convNum(mskFEDtm.getMonth()+1,2)+'-'+convNum(mskFEDtm.getDate(),3)+' '+convNum(mskFEDtm.getHours(),0)+':'+convNum(mskFEDtm.getMinutes(),1)+':'+convNum(mskFEDtm.getSeconds(),1);

		hisCStartDate = mskCSDtm.getFullYear()+'-'+convNum(mskCSDtm.getMonth()+1,2)+'-'+convNum(mskCSDtm.getDate(),3)+' '+convNum(mskCSDtm.getHours(),0)+':'+convNum(mskCSDtm.getMinutes(),1)+':'+convNum(mskCSDtm.getSeconds(),1);
		hisCEndDate = mskCEDtm.getFullYear()+'-'+convNum(mskCEDtm.getMonth()+1,2)+'-'+convNum(mskCEDtm.getDate(),3)+' '+convNum(mskCEDtm.getHours(),0)+':'+convNum(mskCEDtm.getMinutes(),1)+':'+convNum(mskCEDtm.getSeconds(),1);
		
		if( useGap || type > 1 ) {
			if( mskFEDtm > mskCEDtm ) {
				$("#selectSDate").val(hisCStartDate);
				$("#selectEDate").val(hisCEndDate);
			} else {
				$("#selectSDate").val(hisFStartDate);
				$("#selectEDate").val(hisFEndDate);
			}
		}

		isInit = false;
		triggerChart('H');
		
		setLblDate(hogiHeader,xyHeader,hisCEndDate);
		
		if( mskCEDtm - mskFEDtm > 0 ) {
			$("#mv_next").css("display","");
		}
		
		$("#scanTimeGot").val(fixScanTime);
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
				comAjax.addParam("txtTimeGap", $("#txtTimeGapI").val());
				comAjax.addParam("dive", 'D');
				comAjax.addParam("sGrpID", '${UserInfo.id}');
				comAjax.addParam("sMenuNo", '22');
				comAjax.addParam("sUGrpNo", grpId);
				comAjax.setCallback("mbr_getTagCallback");
				comAjax.ajax();
			}
			
			if( $("#lvIolistTable")[0].children.length == 0 ) {
				setTagTableClear();
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
				} else if( str == 'modal_4' ){
					openModal('modal_loading');
				} else if( str != 'modal_3' ) {
					//cmdOK_click();
					if( $("input:radio[id='H']").is(":checked") ) {
						timerOn = false;	
					} else {
						timerOn = true;
					}
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
				/*var totalCnt = $("#gguCheckbox0").val()*1;
				var grpNo = '';
	
				for( var i=0;i<totalCnt;i++ ) {
					for( var j=0;j<$("#lvGroup")[0].children.length;j++ ) {
						if( selTdID == $("#lvGroup")[0].children[j].children[1].id ) {
							var curID = $("#lvGroup")[0].children[j].children[1].id;
	
							grpNo = $("#"+curID).text();
						}
					}
				}*/
				
				//if( grpNo != '' ) {
					//$("#cboUGrpName").val(grpNo);
					activeCharts = [];
					for( var i=0;i<xAxis.length;i++ ) {
						activeCharts.push(i);
					}
					
					cboUGrpName_click(0);
					cboUGrpName_change();
				//}
			}
		});
	}
	
	function setCheckboxes(cnt) {
		for( var i=0;i<cnt;i++ ) {
			$("#lblCheckbox"+i).prop("checked",false);
		
			var cursor = activeCharts.indexOf(i);
			if( cursor > -1 ) {
				$("#lblCheckbox"+activeCharts[cursor]).prop("checked",true);
			}
			
			checkbox_click('lblCheckbox'+i);
		}
	}
	
	function checkbox_click(data) {
		var isChecked = $("input:checkbox[id='"+data+"']").is(":checked");
		var idx = data.substring(11,data.length);
		var chkr = -1;
		for( var c=0;c<activeCharts.length;c++ ) {
			if( activeCharts[c]*1 == idx*1 ) {
				chkr = c;
			}
		}
		if( isChecked ) {
			if( chkr < 0 ) activeCharts.push(idx*1);
		} else {
			if( chkr > -1 ) activeCharts.splice(chkr*1,1);
		}
		
		if( idx == 0 ) {
			var newConfig = JSON.parse(JSON.stringify(gChartConfig));
			newConfig[0]['extend']['line']['setLinesWidth'][0]['width'] = isChecked ? 1 : 0;
			
			gChartConfig = JSON.parse(JSON.stringify(newConfig));
			chart = new sb.chart("#chartArea0", newConfig[0]) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.axis({x: {
				type:'category',
				show: false,
				padding: 0,
				tick: {
					count: 21
				}
			}}).render();
			charts.splice(0,1,chart);
			
			for( var cs=1;cs<gChartConfig.length;cs++ ) {
				$("#chartArea"+cs).css("position","absolute");
				$("#chartArea"+cs).css("top","259px");
				$("#chartArea"+cs).css("left","90px");
				$("#chartArea"+cs).css("z-index",cs);
			}
			
			$("#chartArea0").css("z-index","99");
		} else {
			if( isChecked ) {
				$("#chartArea"+idx).css("opacity",1);
			} else {
				$("#chartArea"+idx).css("opacity",0);
			}
		}
	}
	
	function showCrossHair() {
		setCrossHair = $("input:checkbox[id='chkCross']").is(":checked");
		
		var newConfig = JSON.parse(JSON.stringify(gChartConfig));
		newConfig[0]['global']['crosshair']['show'] = setCrossHair;
		newConfig[0]['global']['crosshair']['dotted'] = false;
		newConfig[0]['hideLegendItems'] = hideLegnedItems;
		
		gChartConfig = JSON.parse(JSON.stringify(newConfig));
		//for( var i=0;i<gChartConfig.length;i++ ) {
			chart = new sb.chart("#chartArea0", newConfig[0]) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			/*chart.axis({x: {
				type:'category',
				show: false,
				padding: 0,
				tick: {
					count: 21
				}
			}}).render();*/
			//chart.data({hideLegendItems:hideLegnedItems}).render();
			chart.render();
			charts.splice(0,1,chart);
		//}

		for( var cs=1;cs<gChartConfig.length;cs++ ) {
			$("#chartArea"+cs).css("position","absolute");
			$("#chartArea"+cs).css("top","259px");
			$("#chartArea"+cs).css("left","90px");
			$("#chartArea"+cs).css("z-index",cs);
		}
		
		$("#chartArea0").css("z-index","99");
	}
	
	function makeBold() {

		if( $("#mouse_area").css("display") != 'none' ) $("#mouse_area").css("display","none");
		
		if( $("#toggleBold").prop("class") == "check" ) {
			$("#toggleBold").attr("class","check active");
			lineBold = 2;
			setLineWidth(lineBold);
		} else {
			$("#toggleBold").attr("class","check");
			lineBold = 1;
			setLineWidth(lineBold);
		}
		
		//chart.global({crosshair:{show:isChecked,dotted:false}}).render();
	}
	
	function toggleAxis(type) {
		if( $("#mouse_area").css("display") != 'none' ) $("#mouse_area").css("display","none");

		var newConfig = JSON.parse(JSON.stringify(gChartConfig));
		if( type == 'x' ) {
			if( $("#toggleXAxis").prop("class") == "check" ) {
				$("#toggleXAxis").attr("class","check active");
				showX = true;
				$("#xAxisArea").css("display","");
				//newConfig[0]['grid']['x']['show'] = showX;
			} else {
				$("#toggleXAxis").attr("class","check");
				showX = false;
				$("#xAxisArea").css("display","none");
				//newConfig[0]['grid']['x']['show'] = showX;
			}
		} else {
			if( $("#toggleYAxis").prop("class") == "check" ) {
				$("#toggleYAxis").attr("class","check active");
				showY = true;
				$("#yAxisArea").css("display","");
				//newConfig[0]['grid']['y']['show'] = showY;
			} else {
				$("#toggleYAxis").attr("class","check");
				showY = false;
				$("#yAxisArea").css("display","none");
				//newConfig[0]['grid']['y']['show'] = showY;
			}
		}
		
		/*gChartConfig = JSON.parse(JSON.stringify(newConfig));
		for( var i=0;i<gChartConfig.length;i++ ) {
			chart = new sb.chart("#chartArea0", newConfig[0]) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			chart.axis({x: {
				type:'category',
				show: false,
				padding: 0,
				tick: {
					count: 21
				}
			}}).render();
			chart.data({hideLegendItems:hideLegnedItems}).render();
			charts.splice(0,1,chart);
		}
		
		for( var cs=1;cs<gChartConfig.length;cs++ ) {
			$("#chartArea"+cs).css("position","absolute");
			$("#chartArea"+cs).css("top","259px");
			$("#chartArea"+cs).css("left","90px");
			$("#chartArea"+cs).css("z-index",cs);
		}
		
		$("#chartArea0").css("z-index","99");*/	
	}
	
	function setLineWidth(size) {
		var newConfig = JSON.parse(JSON.stringify(gChartConfig));
		for( var ni=0;ni<gChartConfig.length;ni++ ) {
			if( ni == 0 ) {
				newConfig[ni]['extend']['line']['setLinesWidth'][0]['width'] = size;
			} else {
				newConfig[ni]['extend']['line']['setLinesWidthAll'] = size;
			}
			newConfig[ni]['hideLegendItems'] = hideLegnedItems;
		}
		
		gChartConfig = JSON.parse(JSON.stringify(newConfig));
		for( var i=0;i<gChartConfig.length;i++ ) {
			chart = new sb.chart("#chartArea"+i, newConfig[i]) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
			/*chart.axis({x: {
				type:'category',
				show: false,
				padding: 0,
				tick: {
					count: 21
				}
			}}).render();*/
			//chart.data({hideLegendItems:hideLegnedItems}).render();
			chart.render();
			charts.splice(i,1,chart);
		}
		
		for( var cs=1;cs<gChartConfig.length;cs++ ) {
			$("#chartArea"+cs).css("position","absolute");
			$("#chartArea"+cs).css("top","259px");
			$("#chartArea"+cs).css("left","90px");
			$("#chartArea"+cs).css("z-index",cs);
		}

		$("#chartArea0").css("z-index","99");
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
		comSubmit.setUrl("/dcc/trend/tsExcelExport");
		//comSubmit.addParam("hogiHeader", hogiHeader);
		//comSubmit.addParam("xyHeader", xyHeader);
		comSubmit.addParam("txtTimeGap", $("#txtTimeGapI").val());
		comSubmit.addParam("startDate", startDate);
		comSubmit.addParam("endDate", endDate);
		comSubmit.addParam('sUGrpNo',selGrpName);
		comSubmit.addParam('sGrpID','${UserInfo.id}');
		comSubmit.addParam("gHis",his);
		comSubmit.addParam('sMenuNo','22');
		comSubmit.addParam('fixed','S');
		comSubmit.submit();
	}
	
	function openWindowPop() {
		var url = 'realtimetrendspare';
		var name = 'rttf_pop';
		var options = 'width=1380, height=660, status=no, menubar=no, toolbar=no, resizable=no, scrollbars=no';
		
		window.open(url, name, options);
	}
	
	function setLblDate(hogi,xy,m_time) {
		var lblDateVal = hogi+xy+' '+m_time.replace(/{/gi,'').replace(/}/gi,'');
		$("#lblDate").text(lblDateVal);
		var diff = new Date().getTime() - new Date(m_time.replace(/{/gi,'').replace(/}/gi,'')).getTime();
		if( diff / 1800000 > 1 ) {
			$("#lblDate").css('color','#e85516');
		} else {
			$("#lblDate").css('color','#05c8be');
		}
	}
	
	function moveChart(id) {
		function modalPart() {
			return new Promise(function(resolve,reject) {
				openModal('modal_loading');
				
				setTimeout(function() {
					resolve();
				},100);
			});
		}
	
		modalPart().then(function() {
			var datePos = xPos.split('||');
			
			if( id.indexOf('prev') > -1 ) {
			
				doHistorical(2,datePos[0]);
			} else {
				doHistorical(3,datePos[1]);
			}
			
			//console.log(id+' :: '+xPos.split('||')[0]+' :: '+xPos.split('||')[1]);
		});
	}
	
	function setIntervalTime(time) {
		if( window.event.keyCode == 13 ) {
			function modalPart() {
				return new Promise(function(resolve,reject) {
					openModal('modal_loading');
					clearInterval(timer);
					
					setTimeout(function() {
						resolve();
					},100);
				});
			}
			
			modalPart().then(function() {
				gInterval = time*1000;

				if( $("#cboUGrpName").val() != 'null' ) {
					var isHistorical = $("input:radio[id='H']").is(":checked");
					if( isHistorical ) {
						cmdHistorical_click();
					} else {
						//doInterval(gInterval);
						cmdReal_click();
					}
				} else {
					closeModal('modal_loading');
				}
			});
		}
	}
	
	function getArrayValue(array,key) {
		var val;
		for( var i=0;i<array.length;i++ ) {
			if( array[i].key  == key ) {
				val = array[i].value;
			}
		}
		return val;
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
	
	function upGroup_click() {
		var totalCnt = $("#gguCheckbox0").val()*1;
		var grpNmD = '';
		var grpNoD = '';
		var grpNmU = '';
		var grpNoU = '';
		
		for( var i=0;i<totalCnt;i++ ) {
			for( var j=0;j<$("#lvGroup")[0].children.length;j++ ) {
				if( typeof $("#lvGroup")[0].children[j].children[1].children[0] != 'undefined' ) {
					if( ('gguGrpNo'+i) == $("#lvGroup")[0].children[j].children[1].children[0].id ) {
						if( j >= 1 && selTdID == $("#lvGroup")[0].children[j].children[1].children[0].id ) {
							var curID = $("#lvGroup")[0].children[j].children[1].children[0].id;
							var preID = $("#lvGroup")[0].children[j-1].children[1].children[0].id;

							grpNmD = $("#"+curID.replace('No','Name')).text().replace(/&/gi, '#amp;');
							grpNoD = $("#"+curID).text();
							grpNmU = $("#"+preID.replace('No','Name')).text().replace(/&/gi, '#amp;');
							grpNoU = $("#"+preID).text();
							
							//console.log('cur :: '+grpNmD+', '+grpNoD+' || '+'pre :: '+grpNmU+', '+grpNoU);
							
							var comAjax = new ComAjax('mngGrpFrm');
							comAjax.setUrl('/dcc/trend/upGroup');
							comAjax.addParam('sMenuNo','22');
							comAjax.addParam('groupNameList',grpNmD+'|'+grpNmU);
							comAjax.addParam('groupNoList',grpNoD+'|'+grpNoU);
							comAjax.addParam('sGrpID','${UserInfo.id}');
							comAjax.addParam('refID',$("#cboReference option:selected").val());
							comAjax.setCallback('mngGroupCallback');
							comAjax.ajax();
						}
					}
				}
			}
		}
	}
	
	function downGroup_click() {
		var totalCnt = $("#gguCheckbox0").val()*1;
		var grpNmD = '';
		var grpNoD = '';
		var grpNmU = '';
		var grpNoU = '';
		
		var isMoved = false;
		for( var i=0;i<totalCnt;i++ ) {
			for( var j=0;j<$("#lvGroup")[0].children.length;j++ ) {
				if( typeof $("#lvGroup")[0].children[j].children[1].children[0] != 'undefined' ) {
					if( ('gguGrpNo'+i) == $("#lvGroup")[0].children[j].children[1].children[0].id ) {
						if( selTdID == $("#lvGroup")[0].children[j].children[1].children[0].id && !isMoved ) {
						//if( j <= $("#lvGroup")[0].children[j].children.length-1 && selTdID == $("#lvGroup")[0].children[j].children[1].children[0].id && !isMoved ) {
							var curID = $("#lvGroup")[0].children[j].children[1].children[0].id;
							var nextID = $("#lvGroup")[0].children[j+1].children[1].children[0].id;

							grpNmD = $("#"+nextID.replace('No','Name')).text().replace(/&/gi, '#amp;');
							grpNoD = $("#"+nextID).text();
							grpNmU = $("#"+curID.replace('No','Name')).text().replace(/&/gi, '#amp;');
							grpNoU = $("#"+curID).text();
							
							//console.log('cur :: '+grpNmD+', '+grpNoD+' || '+'pre :: '+grpNmU+', '+grpNoU); 
							
							var comAjax = new ComAjax('mngGrpFrm');
							comAjax.setUrl('/dcc/trend/downGroup');
							comAjax.addParam('sMenuNo','22');
							comAjax.addParam('groupNameList',grpNmD+'|'+grpNmU);
							comAjax.addParam('groupNoList',grpNoD+'|'+grpNoU);
							comAjax.addParam('sGrpID','${UserInfo.id}');
							comAjax.addParam('refID',$("#cboReference option:selected").val());
							comAjax.setCallback('mngGroupCallback');
							comAjax.ajax();
							
							isMoved = true;
						}
					}
				}
			}
		}
	}
	
	function addGroup_click() {
		var totalCnt = $("#ggrCheckbox0").val()*1;
		var grpNmList = '';
		var grpNoList = '';
		
		for( var i=0;i<totalCnt;i++ ) {
			if( $("#ggrCheckbox"+i).is(":checked") ) {
				grpNmList += $("#ggrGrpName"+i).text().replace(/&/gi, '#amp;') + '|';
				grpNoList += $("#ggrGrpNo"+i).text() + '|';
			}
		}
	
		var comAjax = new ComAjax('mngGrpFrm');
		comAjax.setUrl('/dcc/trend/addGroup');
		comAjax.addParam('sMenuNo','22');
		comAjax.addParam('groupNameList',grpNmList);
		comAjax.addParam('groupNoList',grpNoList);
		comAjax.addParam('sGrpID','${UserInfo.id}');
		comAjax.addParam('refID',$("#cboReference option:selected").val());
		comAjax.setCallback('mngGroupCallback');
		comAjax.ajax();
	}
	
	function delGroup_click() {
		if( confirm('그룹을 삭제하면 하위 태그까지 삭제됩니다. 삭제하시겠습니까?') ) {
			var total = $("#gguCheckbox0").val()*1;
			var grpNoList = '';
			
			for( var i=0;i<total;i++ ) {
				if( $("#gguCheckbox"+i).is(":checked") ) {
					grpNoList += $("#gguGrpNo"+i).text() + '|';
				}
			}
		
			var comAjax = new ComAjax('mngGrpFrm');
			comAjax.setUrl('/dcc/trend/delGroup');
			comAjax.addParam('sMenuNo','22');
			comAjax.addParam('groupNoList',grpNoList);
			comAjax.addParam('sGrpID','${UserInfo.id}');
			comAjax.addParam('refID',$("#cboReference option:selected").val());
			comAjax.setCallback('mngGroupCallback');
			comAjax.ajax();
		} else {
			clearCheckbox(total);
		}
	}
	
	function selectManageGroup(type,id) {
		var tableNm = '';
		var selectID = '';
		if( type == 0 || type == 2 ) {
			tableNm = 'lvReference';
			selectID = 'ggrGrpNo';
		} else {
			tableNm = 'lvGroup';
			selectID = 'gguGrpNo';
		}

		if( type == 0 || type == 1 ) {
			var chkId = $("#"+id)[0].children[0].children[0].id;
			$("#"+chkId).prop("checked",true);
		}
		
		selTdID = $("#"+id)[0].children[1].children[0].id;
		$("#"+id).attr("class","highlight");
		
		$("#cboUGrpName").val($("#"+selTdID).text());
	}
	
	function clearCheckbox(total) {
		for( var i=0;i<total;i++ ) {
			$("#gguCheckbox"+i).prop("checked",false);
		}
	}
	
	function updateGroup_click() {
		if( $("#txtGrpNo").val() == '' || typeof $("#txtGrpNo").val() == 'undefined' ) {
			alert('변경할 그룹번호을 입력하여 주십시요!');
			$("#txtGrpNo").focus();
			return;
		} else {
			if( isNaN($("#txtGrpNo").val()) ) {
				alert('그룹번호는 숫자만 입력이 가능합니다.');
				$("#txtGrpNo").focus();
				return;
			}
		}
		
		if( $("#txtGrpName").val() == '' || typeof $("#txtGrpName").val() == 'undefined' ) {
			alert('변경할 그룹명을 입력하여 주십시요!');
			$("#txtGrpName").focus();
			return;
		}
		
		var uGrpNo = $("#txtGrpNo").val();
		var uGrpName = $("#txtGrpName").val();

		var totalCnt = $("#gguCheckbox0").val()*1;
		var curGrpNm = '';
		var curGrpNo = '';
		
		var sGrpNo = '';
		var sGrpName = '';

		for( var i=0;i<totalCnt;i++ ) {
			for( var j=0;j<$("#lvGroup")[0].children.length;j++ ) {
				if( typeof $("#lvGroup")[0].children[j].children[1].children[0] != 'undefined' ) {
					if( selTdID == $("#lvGroup")[0].children[j].children[1].children[0].id ) {
						var curID = $("#lvGroup")[0].children[j].children[1].children[0].id;
	
						curGrpNm = $("#"+curID.replace('No','Name')).text().replace(/&/gi, '#amp;');
						curGrpNo = $("#"+curID).text();
					}
				}
			}
		}
		
		if( uGrpNo*1 == curGrpNo*1 ) {
			var comAjax = new ComAjax('mngGrpFrm');
			comAjax.setUrl('/dcc/trend/updateGroup');
			comAjax.addParam('sMenuNo','22');
			comAjax.addParam('groupNameList',uGrpName);
			comAjax.addParam('groupNoList',uGrpNo);
			comAjax.addParam('type','0');
			comAjax.addParam('sGrpID','${UserInfo.id}');
			comAjax.setCallback('mngGroupCallback');
			comAjax.ajax();
		} else {
			var iCha = 0;
			for( var j=0;j<totalCnt;j++ ) {
				if( uGrpNo*1 == $("#gguGrpNo"+j).text()*1 ) {
					sGrpName = $("#gguGrpName"+j).text();
					iCha = j+1;
				}
			}
			
			if( iCha == 0 ) {
				alert('변경할 그룹번호가 존재하지 않습니다.');
				$("#txtGrpNo").focus();
				return;
			}
			
			var totalCnt = $("#gguCheckbox0").val()*1;
			var grpNmN = $("#txtGrpName").val().replace(/&/gi, '#amp;');
			var grpNoN = $("#txtGrpNo").val();
			var grpNmO = $("#"+selTdID.replace('No','Name')).text().replace(/&/gi, '#amp;');
			var grpNoO = $("#"+selTdID).text();
			
			//console.log('cur :: '+grpNmD+', '+grpNoD+' || '+'pre :: '+grpNmU+', '+grpNoU);
			
			var comAjax = new ComAjax('mngGrpFrm');
			comAjax.setUrl('/dcc/trend/updateGroup');
			comAjax.addParam('sMenuNo','22');
			comAjax.addParam('groupNameList',grpNmO+'|'+grpNmN);
			comAjax.addParam('groupNoList',grpNoO+'|'+grpNoN);
			comAjax.addParam('type','1');
			comAjax.addParam('sGrpID','${UserInfo.id}');
			comAjax.setCallback('mngGroupCallback');
			comAjax.ajax();
		}
	}
	
	function saveRange() {
		var tagCnt = xAxis.length;
		var newRangeList = '';
		var tmp = '';
		
		for( var i=0;i<tagCnt;i++ ) {
			
			newRangeList += $("#lblTagName"+i).text().substring(3,$("#lblTagName"+i).text().length) + '|'
						  + $("#lblValue"+i).attr('value').split('_')[0] + '|'
						  + $("#lblValue"+i).attr('value').split('_')[1] + '|'
						  + $("#lblValue"+i).attr('value').split('_')[2] + '|'
						  + $("#Hi"+(i+1)).val() + '|'
						  + $("#Low"+(i+1)).val();
			
			if( i < tagCnt-1 ) {
				newRangeList += '$SEP$';
			}
		}
		var uGrpNo = $("#cboUGrpName option:selected").val();
		//console.log(newRangeList);
		
		var comAjax = new ComAjax('rangeFrm');
		comAjax.setUrl('/dcc/trend/saveRange');
		comAjax.addParam('hogiHeader',hogiHeader);
		comAjax.addParam('xyHeader',xyHeader);
		comAjax.addParam('gID','${UserInfo.id}');
		comAjax.addParam('gHis',$("input:radio[id='H']").is(":checked") ? 'H' : 'R');
		comAjax.addParam('gFixed','S');
		comAjax.addParam('sMenuNo','22');
		comAjax.addParam('sUGrpNo',uGrpNo);
		comAjax.addParam('rangeList',newRangeList);
		comAjax.setCallback('mbr_saveRangeCallback');
		comAjax.ajax();
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
	
	function setTagTableClear() {
		$("#txtTitle").val('');
		
		tblBody = $("#lvIolistTable");
		tblBodyStr = '';

		for( var i=0;i<8;i++ ) {
        	tblBodyStr += '<tr>'
						+ '	<td id="'+i+'hogi'+i+'" class="tc"><label></label></td>'
						+ '	<td id="'+i+'xyGubun'+i+'" class="tc"><label></label></td>'
						+ '	<td id="'+i+'descr'+i+'"><label></label></td>'
						+ '	<td id="'+i+'ioType'+i+'" class="tc"><label></label></td>'
						+ '	<td id="'+i+'address'+i+'" class="tc"><label></label></td>'
						+ '	<td id="'+i+'ioBit'+i+'" class="tc"><label></label></td>'
						+ '	<td id="'+i+'minVal'+i+'" class="tc"><label></label></td>'
						+ '	<td id="'+i+'maxVal'+i+'" class="tc"><label></label></td>'
						+ '	<td id="'+i+'saveCoreChk'+i+'" class="tc"><label></label></td>'
						+ '	<td id="'+i+'iSeq'+i+'" style="display:none"><label></label></td>'
						+ '</tr>';
        }
        
        tblBody.empty();
        tblBody.append(tblBodyStr);
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
	
	function moveMore() {
		if( $("#lblBody3")[0].children.length > 0 ) {
			$("#lblBody3").css("display","");
		} else {
			$("#lblBody3").css("display","none");
		}
		if( $("#lblBody4")[0].children.length > 0 ) {
			$("#lblBody4").css("display","");
		} else {
			$("#lblBody4").css("display","none");
		}
		
		var is3 = $("#lblBody3")[0].style.display != 'none' ? 1 : 0;
		var is4 = $("#lblBody4")[0].style.display != 'none' ? 1 : 0;
		var chartBackTop = '264';
		var xAxisAreaTop = '264';
		var yAxisAreaTop = '264';
		if( is3 == 1 && is4 == 1 ) {
			mvCnt = 2;
		} else if( is3 == 1 && is4 == 0 ) {
			mvCnt = 1;
		} else {
			mvCnt = 0;
		}
		
		var factor = 0;
		if( xAxis.length > 4 && is3 == 0 ) {
			factor = 2;
		}
		
		//console.log(chartBackTop+', '+is3+' + '+is4+' = '+mvCnt+' :: '+xAxis.length+' > '+factor);
		
		if( mvCnt > 0 ) {
			$("#rangeHi").css("position",'absolute');
			$("#rangeHi").css("top",(mvCnt*36)+'px');
			$("#rangeLow").css("position",'absolute');
			$("#rangeLow").css("top",(40+mvCnt*36)+'px');
			$("#pagingArea").css("position",'absolute');
			$("#pagingArea").css("top",(40+mvCnt*36)+'px');
			$("#MonthDayArea").css("position",'absolute');
			$("#MonthDayArea").css("top",(40+mvCnt*36)+'px');
			for( var i=1;i<12;i++ ) {
				$("#dPoint"+i).css("width",'32px');
			}
			$("#TimeArea").css("position",'absolute');
			$("#TimeArea").css("top",(40+mvCnt*36)+'px');
			$("#chartBack").css("top",(chartBackTop*1+mvCnt*36)+'px');
			$("#xAxisArea").css("top",(xAxisAreaTop*1+mvCnt*36)+'px');
			$("#yAxisArea").css("top",(yAxisAreaTop*1+mvCnt*36)+'px');
		} else {
			$("#rangeHi").css("position",'absolute');
			$("#rangeHi").css("top",'0px');
			$("#rangeLow").css("position",'absolute');
			$("#rangeLow").css("top",'40px');
			$("#pagingArea").css("position",'absolute');
			$("#pagingArea").css("top",'40px');
			$("#MonthDayArea").css("position",'absolute');
			$("#MonthDayArea").css("top",'40px');
			//for( var i=1;i<12;i++ ) {
			//	$("#dPoint"+i).css("width",'32px');
			//}
			$("#TimeArea").css("position",'absolute');
			$("#TimeArea").css("top",'40px');
			$("#chartBack").css("top",264+factor*1+'px');
			$("#xAxisArea").css("top",264+factor*1+'px');
			$("#yAxisArea").css("top",264+factor*1+'px');
		}
	}
	
	function toPDF() {
		window.onbeforeprint = function() {
			$("#headerArea").css("display","none");
			$("#footerArea").css("display","none");
			//$("#page_title").css("display","none");
		}
		
		window.onafterprint = function() {
			function doHtml() {
				return new Promise(function(resolve,reject) {
					//document.body.innerHTML = initBodyHtml;
					
					resolve();
					
				});
			}
					
			doHtml().then(function() {
				$("#headerArea").css("display","");
				$("#footerArea").css("display","");
				//$("#page_title").css("display","");
				
				setTimeout(function() {
					for( var cs=1;cs<xAxis.length;cs++ ) {
						$("#chartArea"+cs).css("position","absolute");
						$("#chartArea"+cs).css("top","259px");
						$("#chartArea"+cs).css("left","90px");
						$("#chartArea"+cs).css("z-index",cs);
					}
		
					$("#chartArea0").css("z-index","99");
					$("#chartBack").css("display","");
					
					if( $("input:radio[id='H']").is(":checked") ) {
						timerOn = false;
					} else {
						timerOn = true;
					}
					//closeModal('modal_loading');
				},200);
			});
		}
		 
		timerOn = false;
		closeModal('mouse_area');
		 
		window.print();
		
		openModal('modal_loading');
		if( $("input:radio[id='H']").is(":checked") ) {
			timerOn = false;
		} else {
			timerOn = true;
		}
		closeModal('modal_loading');
	}
	
	function toIMG() {
	 	timerOn = false;
	 	
	 	function doModal() {
	 		return new Promise(function(resolve,reject) {
	 			openModal('modal_loading');
				closeModal('mouse_area');
				
				setTimeout(function() {
					resolve();
				},500);
			});
	 	}

	 	doModal().then(function() {
			//html2canvas($("#captureArea")[0]).then(canvas => {
				//saveAs(canvas.toDataURL('image/jpg'),"lime.jpg"); //다운로드 되는 이미지 파일 이름 지정
				//saveAs(canvas.toDataURL(),"trendFixed.jpg"); //다운로드 되는 이미지 파일 이름 지정
			//});
	 		// Get the element.
			var element = document.getElementById('captureArea');
			
			// Generate the PDF.
			html2pdf().from(element).set({
				margin: [5, 10, 5, 10],
				filename: 'trend_spare.pdf',
				pagebreak: { mode: 'avoid-all' },
				image: { type: 'jpeg', quality: 1 },
				html2canvas: {
					useCORS: true,
					scrollY: 0,
					scale: 1,
					dpi: 300,
					letterRendering: true,
					allowTaint: false
				},
				jsPDF: {orientation: 'portrait', unit: 'mm', format: 'a4', compressPDF: true}
			}).save();
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
			
			if( $("input:radio[id='H']").is(":checked") ) {
				timerOn = false;
			} else {
				timerOn = true;
			}
			closeModal('modal_loading');
		} else {
			window.open(uri);
		}
	}
</script>

</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<div id="headerArea">
	<%@ include file="/WEB-INF/views/include/include-dcc-header.jspf" %>
	</div>
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div id="captureArea" class="contents">
			<!-- page_title -->
			<div id="page_title" class="page_title" style="max-height:45px;margin-bottom:10px">
				<h3 id="trendTitle">REALTIME TREND</h3>
				<div id="trendPath" class="bc"><span>DCC</span><span>Trend</span><strong>TREND SPARE</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<form id="windowPopForm" type="hidden">
				<input type="hidden" id="baseSearchParam" value="${BaseSearch}">
			</form>
			<form id="selGrpFrm" type="hidden"></form>
			<form id="scanTimeFrm" type="hidden"></form>
			<label id="scanTimed" style="display:none"></label>
			<div class="fx_srch_wrap" style="max-height:60px;margin-bottom:10px">	
				<div class="fx_srch_form" style="margin-top:-5px">
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
                            	<input id="txtTimeGapI" type="text" value="5" onkeypress="javascript:setIntervalTime(this.value);">
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
					<a id="cmdReal" href="#none" class="btn_srch">Search</a>
					<a id="cmdHistorical" href="#none" class="btn_srch" style="display:none">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->
			<!-- fx_srch_wrap -->
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
                                <a href="#none" class="btn_list" onclick="javascript:openWindowPop()">새창으로</a>
                                <a href="#none" class="btn_list" onclick="javascript:saveRange()">Range 저장</a>
                                <label>
                                    <input id="chkCross" type="checkbox" onclick="javascript:showCrossHair()">
                                    십자선
                                </label>
                            </div>
						</div>
						<div class="fx_srch_item" style="text-align:right;display:inline-block">
                       		<a id="cmdGroup" href="#none" class="btn_list" onclick="javascript:openModal('modal_4')">그룹관리</a>
                        </div>
					</div>
					<div class="fx_srch_row" id="lblBody1">
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_1" style="display:none"><!-- color : #801517 -->
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_2" style="display:none"><!-- color : #B9529F -->
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_3" style="display:none"><!-- color : #1EBCBE -->
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_4" style="display:none"><!-- color : #282A73 -->
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
					<div class="fx_srch_row" id="lblBody3" style="display:none"></div>
					<div class="fx_srch_row" id="lblBody4" style="display:none"></div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->
			<div id="rangeHi"></div>
			<!-- chart_wrap_area -->
			<div id="chart_wrap_area" class="chart_wrap_area">
                <div id="chartArea"></div>
                <div><br><br><br></div>
            </div>
            <div id="chartBack" style="width:1184px;height:384px;position:absolute;top:264px;left:98px;background-color:#f5f5f5;display:none;z-index:0"></div>
            <div data-html2canvas-ignore="true">
            <input id="testArea" type="hidden"></input>
            <input id="minList" type="hidden"></input>
            <input id="maxList" type="hidden"></input>
            <input id="FHiAlarm" type="hidden"></input>
            <input id="FLoAlarm" type="hidden"></input>
            <input id="FDtabHi" type="hidden"></input>
            <input id="FDtabLo" type="hidden"></input>
            <input id="testArea" type="hidden"></input>
            </div>
            <!-- //chart_wrap_area -->
			<div id="rangeLow"></div>
			<div class="button" id="pagingArea">
				<a id="mv_prev" class="first" href="#" onclick="javascript:moveChart(this.id)" style="display:none;position:absolute;top:619px;left:40px;width:30px;height:30px;background:url(../../resources/images/common/ico_first.svg) no-repeat center center;border:1px solid rgba(0,0,0,0.1);"></a>
				<a id="mv_next" class="last" href="#" onclick="javascript:moveChart(this.id)" style="display:none;position:absolute;top:619px;left:1310px;width:30px;height:30px;background:url(../../resources/images/common/ico_last.svg) no-repeat center center;border:1px solid rgba(0,0,0,0.1);"></a>
			</div>
            <div id="MonthDayArea">
            	<div id="dPoint1" style="position:absolute;top:620px;left:90px;text-align:center;width:32px"></div>
            	<div id="dPoint2" style="position:absolute;top:620px;left:203px;text-align:center;width:32px"></div>
            	<div id="dPoint3" style="position:absolute;top:620px;left:321px;text-align:center;width:32px"></div>
            	<div id="dPoint4" style="position:absolute;top:620px;left:439px;text-align:center;width:32px"></div>
            	<div id="dPoint5" style="position:absolute;top:620px;left:557px;text-align:center;width:32px"></div>
            	<div id="dPoint6" style="position:absolute;top:620px;left:675px;text-align:center;width:32px"></div>
            	<div id="dPoint7" style="position:absolute;top:620px;left:793px;text-align:center;width:32px"></div>
            	<div id="dPoint8" style="position:absolute;top:620px;left:911px;text-align:center;width:32px"></div>
            	<div id="dPoint9" style="position:absolute;top:620px;left:1029px;text-align:center;width:32px"></div>
            	<div id="dPoint10" style="position:absolute;top:620px;left:1147px;text-align:center;width:32px"></div>
            	<div id="dPoint11" style="position:absolute;top:620px;left:1260px;text-align:center;width:32px"></div>
            </div>
            <div id="TimeArea">
            	<div id="tPoint1" style="position:absolute;top:635px;left:82px;text-align:center"></div>
            	<div id="tPoint2" style="position:absolute;top:635px;left:195px;text-align:center"></div>
            	<div id="tPoint3" style="position:absolute;top:635px;left:313px;text-align:center"></div>
            	<div id="tPoint4" style="position:absolute;top:635px;left:431px;text-align:center"></div>
            	<div id="tPoint5" style="position:absolute;top:635px;left:549px;text-align:center"></div>
            	<div id="tPoint6" style="position:absolute;top:635px;left:667px;text-align:center"></div>
            	<div id="tPoint7" style="position:absolute;top:635px;left:785px;text-align:center"></div>
            	<div id="tPoint8" style="position:absolute;top:635px;left:903px;text-align:center"></div>
            	<div id="tPoint9" style="position:absolute;top:635px;left:1021px;text-align:center"></div>
            	<div id="tPoint10" style="position:absolute;top:635px;left:1139px;text-align:center"></div>
            	<div id="tPoint11" style="position:absolute;top:635px;left:1252px;text-align:center"></div>
            </div>
            <div id="xAxisArea" style="display:none;position:absolute;top:264px;left:98px">
            	<div id="xPoint1" style="position:absolute;left:58px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint2" style="position:absolute;left:117px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint3" style="position:absolute;left:176px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint4" style="position:absolute;left:235px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint5" style="position:absolute;left:294px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint6" style="position:absolute;left:354px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint7" style="position:absolute;left:413px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint8" style="position:absolute;left:472px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint9" style="position:absolute;left:531px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint10" style="position:absolute;left:590px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint11" style="position:absolute;left:649px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint12" style="position:absolute;left:709px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint13" style="position:absolute;left:768px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint14" style="position:absolute;left:827px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint15" style="position:absolute;left:886px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint16" style="position:absolute;left:945px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint17" style="position:absolute;left:1004px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint18" style="position:absolute;left:1064px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint19" style="position:absolute;left:1123px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            	<div id="xPoint19" style="position:absolute;left:1182px;text-align:center;width:2px;height:385px;background:rgba(225,225,225,0.5)"></div>
            </div>
            <div id="yAxisArea" style="display:none;position:absolute;top:264px;left:98px">
            	<div id="yPoint1" style="position:absolute;top:41px;text-align:center;width:1184px;height:2px;background:rgba(225,225,225,0.5)"></div>
            	<div id="yPoint2" style="position:absolute;top:84px;text-align:center;width:1184px;height:2px;background:rgba(225,225,225,0.5)"></div>
            	<div id="yPoint3" style="position:absolute;top:126px;text-align:center;width:1184px;height:2px;background:rgba(225,225,225,0.5)"></div>
            	<div id="yPoint4" style="position:absolute;top:170px;text-align:center;width:1184px;height:2px;background:rgba(225,225,225,0.5)"></div>
            	<div id="yPoint5" style="position:absolute;top:213px;text-align:center;width:1184px;height:2px;background:rgba(225,225,225,0.5)"></div>
            	<div id="yPoint6" style="position:absolute;top:256px;text-align:center;width:1184px;height:2px;background:rgba(225,225,225,0.5)"></div>
            	<div id="yPoint7" style="position:absolute;top:299px;text-align:center;width:1184px;height:2px;background:rgba(225,225,225,0.5)"></div>
            	<div id="yPoint8" style="position:absolute;top:341px;text-align:center;width:1184px;height:2px;background:rgba(225,225,225,0.5)"></div>
            </div>
		</div>
		<!-- //contents -->
		
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" id="mnuAddGroup">그룹추가</a></li>
                        <li><a href="#none" id="setFrmIO">변수설정</a></li>
                        <li><a href="#none" onclick="javascript:toCSV()">엑셀로 저장</a></li>
                    </ul>
                    <ul>
                        <li id="toggleXAxis" class="check active" onclick="javascript:toggleAxis('x')"><a href="#none">X축 격자</a></li>
                        <li id="toggleYAxis" class="check active" onclick="javascript:toggleAxis('y')"><a href="#none">Y축 격자</a></li>
                        <li id="toggleBold" class="check" onclick="javascript:makeBold()"><a href="#none">선 굵게</a></li>
                    </ul>
                    <ul>
                        <li><a id="printChart" href="#none" onclick="javascript:toPDF()">그래프 인쇄</a></li>
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
	<div id="footerArea">
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	</div>
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
<div class="layer_pop_wrap big" id="modal_4">
    <!-- header_wrap -->
<div class="pop_header">
   <h3>그룹관리</h3>
        <a onclick="closeModal('modal_4');" title="Close"></a>
    </div>
<!-- //header_wrap -->
<!-- pop_contents -->
<div class="pop_contents" style="max-height:654px;">
        <!-- form_wrap -->
        <div style="width:450px;float:left">
            <!-- form_table -->
            <div style="margin-bottom:12px">
            	<label>참조대상</label>
	            <select id="cboReference" style="margin-top:5px;">
	                <option value="ro3">RO차장</option>
	                <option value="to4">TO차장</option>
	            </select>
            </div>
            <div class="list_table_scroll" style="max-height:417px">
            <form id="mngGrpForm" name="mngGrpForm">
            <table id="refGroupList" class="list_table">
                <colgroup>
                    <col width="30px"/>
                    <col />
                </colgroup>
                <thead>
                	<tr>
						<th></th>
						<th>그룹명</th>
					</tr>
				</thead>
				<tbody id="lvReference">
            	</tbody>
            </table>
            </form>
            </div>
            <!-- //form_table -->
        </div>
        <div style="height:290px;width:30px;margin-top:10px;margin-left:10px;float:left;text-align:center;vertical-align:middle">
	        <div id="addGroup" class="button" style="height:50px;width:36px;margin-top:185px">
		        <a href="#" class="btn_page" style="height:50px;width:36px;"><img src="/resources/images/common/ico_last.svg"></a>
		    </div>
		    <div id="delGroup" class="button" style="height:50px;width:36px;margin-top:10px">
		        <a href="#" class="btn_page" style="height:50px;width:36px;"><img src="/resources/images/common/ico_first.svg"></a>
		    </div>
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div style="width:480px;float:right">
	        <div>
                <div>
                	<label style="width:50px;">번호</label>
                	<input id="txtGrpNo" style="width:50px" type="text">&nbsp;&nbsp;
                	<label style="width:50px;">그룹명</label>
               		<input id="txtGrpName" style="width:290px" type="text">
                <div id="updateGroup" class="button" style="text-align:right;float:right;margin-top:-3px;margin-bottom:5px;">
        			<a href="#none" class="btn_page">수정</a>
                </div>
                </div>
	        </div>
            <!-- list_table -->
            <div class="list_table_scroll" style="float:left;width:430px;max-height:436px;margin-top:10px">
            <table id="myGroupList" class="list_table" style="height:258px;float:left">
                <colgroup>
                    <col width="30px"/>
                    <col width="50px"/>
                    <col />
                </colgroup>
                <thead>
                    <tr>
                        <th></th>
                        <th>번호</th>
                        <th>그룹명</th>
                    </tr>
                </thead>
                <tbody id="lvGroup">
                </tbody>
            </table>
            </div>
            <!-- //list_table -->
             <!-- list_bottom -->
            <!-- //list_bottom -->
	                <div style="float:right">
	                	<div id="upGroup" class="button" style="height:50px;width:36px;margin-top:160px">
				        	<a href="#" class="btn_page" style="height:50px;width:36px"><img src="/resources/images/common/fnc_coll.svg" style="width:20px"></a>
					    </div>
					    <div id="downGroup" class="button" style="height:50px;width:36px;margin-top:10px">
					        <a href="#" class="btn_page" style="height:50px;width:36px"><img src="/resources/images/common/fnc_exp.svg" style="width:20px"></a>
					    </div>
	                </div>
        </div>
            <div class="list_bottom">
                <div class="button">
                </div>
                <div class="button" style="width:984px">
        			<a href="#none" class="btn_page" onclick="closeModal('modal_4');" style="width:984px;margin-top:10px">화면닫기</a>
                </div>
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

