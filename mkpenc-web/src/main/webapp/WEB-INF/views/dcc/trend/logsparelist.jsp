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
<script type="text/javascript">
var timerOn = true; //true로 변경
var hogiHeader = '${UserInfo.hogi}' != "undefined" ? '${UserInfo.hogi}' : "3";
var xyHeader = '${UserInfo.xyGubun}' != "undefined" ? '${UserInfo.xyGubun}' : "X";
var lblDataListAjax = {};
var DccTagInfoListAjax = {};
var ioListArray = [];
var bGroupFlag = false;
var swSort = false;

$(function () {
	
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
	
	$(document.body).delegate('#3', 'click', function() {
		hogiHeader = '3';
		var selGrpNo = $("#cboUGrpName option:selected").val() == '' ? '1' : $("#cboUGrpName option:selected").val();
		
		var comSubmit = new ComSubmit("trendLogFrm");
		comSubmit.setUrl('/dcc/trend/logsparelist');
		comSubmit.addParam('sUGrpNo',selGrpNo);
		comSubmit.submit();
	});
	
	$(document.body).delegate('#4', 'click', function() {
		hogiHeader = '4';
		var selGrpNo = $("#cboUGrpName option:selected").val() == '' ? '1' : $("#cboUGrpName option:selected").val();
		
		var comSubmit = new ComSubmit("trendLogFrm");
		comSubmit.setUrl('/dcc/trend/logsparelist');
		comSubmit.addParam('sUGrpNo',selGrpNo);
		comSubmit.submit();
	});
	
	$(document.body).delegate('#X', 'click', function() {
		xyHeader = 'X';
		var selGrpNo = $("#cboUGrpName option:selected").val() == '' ? '1' : $("#cboUGrpName option:selected").val();
		
		var comSubmit = new ComSubmit("trendLogFrm");
		comSubmit.setUrl('/dcc/trend/logsparelist');
		comSubmit.addParam('sUGrpNo',selGrpNo);
		comSubmit.submit();
	});
	
	$(document.body).delegate('#Y', 'click', function() {
		xyHeader = 'Y';
		var selGrpNo = $("#cboUGrpName option:selected").val() == '' ? '1' : $("#cboUGrpName option:selected").val();
		
		var comSubmit = new ComSubmit("trendLogFrm");
		comSubmit.setUrl('/dcc/trend/logsparelist');
		comSubmit.addParam('sUGrpNo',selGrpNo);
		comSubmit.submit();
	});
	
	var lblDateVal = '${ScanTime}';
	$("#lblDate").text(lblDateVal);
	$("#lblDate").css('color','${ForeColor}');
	
  	$("#cboUGrpName").change(function(){
  		$("#trendLogFrm").empty();
  		if($("#cboUGrpName option:selected").val() != ""){

  			//var	comSubmit	=	new ComSubmit("trendLogFrm");
			//comSubmit.setUrl("/dcc/trend/logsharelist");
			//comSubmit.submit();
			var comAjax = new ComAjax("trendLogFrm");
			comAjax.setUrl('/dcc/trend/reloadLogsparelist');
			comAjax.addParam("sUGrpNo",$("#cboUGrpName option:selected").val());
			comAjax.addParam("sHogi",hogiHeader);
			comAjax.addParam("sXYGubun",xyHeader);
			comAjax.addParam("sGrpID",'${UserInfo.id}');
			comAjax.addParam("sMenuNo",'24');
			comAjax.addParam("sDive",'D');
			comAjax.setCallback('trendCallback');
			comAjax.ajax();
  		}
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
  	
  	$(document.body).delegate('#ES2', 'click', function() {
  		$("#eTimeGap").val('0.5');
  	});
  	
  	$(document.body).delegate('#EM5', 'click', function() {
  		$("#eTimeGap").val('300');
  	});
  	
  	$(document.body).delegate('#ES5', 'click', function() {
  		$("#eTimeGap").val('5');
  	});
  	
  	$(document.body).delegate('#EH1', 'click', function() {
  		$("#eTimeGap").val('3600');
  	});
  	
  	$(document.body).delegate('#EM1', 'click', function() {
  		$("#eTimeGap").val('60');
  	});

  	$(document.body).delegate('#CT', 'click', function() {
  		$("#eTimeGap").val($("#excelTimeGap").val());
  	});
  	
  	$(document.body).delegate('#excelTimeGap', 'click', function() {
  		$("input:radio[id='CT']").prop("checked",true);
  		$("#excelTimeGap").focus();
  	});
  	
  	$(document.body).delegate('#excelTimeGap', 'change', function() {
  		if( $("input:radio[id='CT']").is(":checked") ) {
  			$("#eTimeGap").val($("#excelTimeGap").val());
  		}
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
  	
	setTimer(5000);
	
});

function setTimer(interval) {
	
	if( interval > 0 ) {
		setTimeout(function run() {
			if( timerOn ) {
		  		$("#trendLogFrm").empty();
				//var	comSubmit	=	new ComSubmit("trendLogFrm");
				//comSubmit.setUrl("/dcc/trend/logfixedlist");
				//comSubmit.submit();
				var comAjax = new ComAjax("trendLogFrm");
				comAjax.setUrl('/dcc/trend/reloadLogsparelist');
				comAjax.addParam("sUGrpNo",$("#cboUGrpName option:selected").val());
				comAjax.addParam("sHogi",hogiHeader);
				comAjax.addParam("sXYGubun",xyHeader);
				comAjax.addParam("sGrpID",'${UserInfo.id}');
				comAjax.addParam("sMenuNo",'24');
				comAjax.addParam("sDive",'D');
				comAjax.setCallback('trendCallback');
				comAjax.ajax();
			}
			
			setTimeout(run, interval);
		},interval);
	} else {
		setTimeout(function run() {
			if( timerOn ) {
		  		$("#trendLogFrm").empty();
				//var	comSubmit	=	new ComSubmit("trendLogFrm");
				//comSubmit.setUrl("/dcc/trend/logfixedlist");
				//comSubmit.submit();
				var comAjax = new ComAjax("trendLogFrm");
				comAjax.setUrl('/dcc/trend/reloadLogsparelist');
				comAjax.addParam("sUGrpNo",$("#cboUGrpName option:selected").val());
				comAjax.addParam("sHogi",hogiHeader);
				comAjax.addParam("sXYGubun",xyHeader);
				comAjax.addParam("sGrpID",'${UserInfo.id}');
				comAjax.addParam("sMenuNo",'24');
				comAjax.addParam("sDive",'D');
				comAjax.setCallback('trendCallback');
				comAjax.ajax();
			}
			
			setTimeout(run, 5000);
		},5000);
	}
}

function setLblDate(hogiHeader,xyHeader,time,color) {
	$("#lblDate").text(time);
	$("#lblDate").css('color',color);
}

function setData() {
	for( var i=0;i<lblDataListAjax.length;i++ ) {
		if( typeof lblDataListAjax[i] != 'undefined' ) {
			$("#lblDesc"+i).text(lblDataListAjax[i].desc);
			$("#lblType"+i).text(lblDataListAjax[i].type);
			$("#lblAddress"+i).text(lblDataListAjax[i].address);
			$("#lblData"+i).text(lblDataListAjax[i].fValue);
			$("#lblUnit"+i).text(lblDataListAjax[i].unit);
		}
	}
}

function openModal(str) {
	timerOn = false;
	if( str == 'modal_1' ) {
		var grpId = $("#cboUGrpName option:selected").val();
		
		var tmpGrpName = $("#cboUGrpName option:selected").text();
		var selGrpName = tmpGrpName.substring(tmpGrpName.indexOf('&nbsp;')+5,tmpGrpName.length);
		
		if( grpId != '' ) $("#txtTitle").val(selGrpName);
		
		if( grpId != '' && typeof grpId != 'undefined' ) {
			var comAjax = new ComAjax("showTagFrm");
			comAjax.setUrl("/dcc/trend/getTagCall");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("txtTimeGap", '5');
			comAjax.addParam("dive", 'D');
			comAjax.addParam("sGrpID", '${UserInfo.id}');
			comAjax.addParam("sMenuNo", '24');
			comAjax.addParam("sUGrpNo", grpId);
			comAjax.setCallback("mbr_getTagCallback");
			comAjax.ajax();
		}
		
		if( $("#lvIolistTable")[0].children.length == 0 ) {
			setTagTableClear();
		}
	} else if( str == 'modal_2' ) {
		var d = new Date();
		var endDateStr = d.getFullYear()+'-'+convNum(d.getMonth()+1,2)+'-'+convNum(d.getDate(),3)+' '+convNum(d.getHours(),0)+':'+convNum(d.getMinutes(),1)+':'+convNum(d.getSeconds(),1);
		var s = new Date(d.setHours(d.getHours()-1));
		var startDateStr = s.getFullYear()+'-'+convNum(s.getMonth()+1,2)+'-'+convNum(s.getDate(),3)+' '+convNum(s.getHours(),0)+':'+convNum(s.getMinutes(),1)+':'+convNum(s.getSeconds(),1);
		
		$("#excelSDate").val(startDateStr);
		$("#excelEDate").val(endDateStr);
		$("#excelTimeGap").val('5');
		
		$("#excelFileName").val('DCC_TL_'+convNum(d.getMonth()+1,2)+'_'+convNum(d.getDate(),3)+'.xlsx');
	} else if( str == 'modal_loading' ) {
		$("#modal_loading").css("display","");
	}
	openLayer(str);
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
	comAjax.addParam("txtTimeGap", '5');
	comAjax.addParam("sGrpID", '${UserInfo.id}');
	comAjax.addParam("Fixed", 'S');
	comAjax.addParam("sMenuNo", '24');
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

function closeModal(str) {
	function closePart() {
		return new Promise(function(resolve,reject) {
			//textClear(str);
			if( str == 'modal_loading' ) {
				$("#modal_loading").css("display","none");
			} else if( str == 'modal_4' ){
				openModal('modal_loading');
			} else if( str != 'modal_3' ) {
				//timerOn = true;
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
				//$("#sUGrpNo").val(grpNo);
				activeCharts = [];
				for( var i=0;i<xAxis.length;i++ ) {
					activeCharts.push(i);
				}
				
				cboUGrpName_click(0);
				cboUGrpName_change();
			//}
		}
		timerOn = true;
	});
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

function toCSV() {
	function prePart() {
		return new Promise(function(resolve,reject) {
			if( $("#mouse_area").css("display") != 'none' ) $("#mouse_area").css("display","none");
			
			var selGrpName = $("#cboUGrpName option:selected").val();
		
			if( typeof selGrpName == 'undefined' ) selGrpName = $("#cboUGrpName option:eq(1)").val();
			
			var startDate = "";
			var endDate = "";
			if( $("#excelSDate").val() != null && typeof $("#excelSDate").val() != 'undefined' ) {
				startDate = $("#excelSDate").val();//+':00.000';
				endDate = $("#excelEDate").val();//+':00.000';
			}
			
			var dateRegEx = /^\d{4}-[0-1]{1}[0-9]{1}-[0-3]{1}[0-9]{1}\s[0-2]{1}[0-9]{1}:[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}$/;
			
			if( !dateRegEx.test(startDate) ) {
				alert('시작 시간이 잘못되었습니다.');
				$("#excelSDate").focus();
				return;
			}
			
			if( !dateRegEx.test(endDate) ) {
				alert('끝 시간이 잘못되었습니다.');
				$("#excelEDate").focus();
				return;
			}
			
			var sD = new Date(startDate);
			var eD = new Date(endDate);
			if( sD > eD ) {
				alert('입력된 시간 설정 구간이 잘못되었습니다.');
				$("#excelSDate").focus();
				return;
			}
			
			if( $("#excelFileName").val() == '' ) {
				alert('파일명을 입력하십시오.');
				$("#excelFileName").focus();
				return;
			}
			
			if( $("input:radio[id='CT']").is(":checked") && $("#excelTimeGap").val()*1 < 5 && $("#excelTimeGap").val() != '0.5' ) {
				alert('0.5초이외의 5초이하는 지정할 수 없습니다.');
				$("#excelTimeGap").focus();
				return;
			}
			
			//var gTimeGap = $("input:radio[id='CT']").is(":checked") ? $("#excelTimeGap").val() : $("#eTimeGap").val();
			
			var comSubmit = new ComSubmit("selGrpFrm");
			comSubmit.setUrl("/dcc/trend/lsExcelExport");
			//comSubmit.addParam("hogiHeader", hogiHeader);
			//comSubmit.addParam("xyHeader", xyHeader);
			comSubmit.addParam("txtTimeGap", $("#eTimeGap").val());
			comSubmit.addParam("startDate", startDate);
			comSubmit.addParam("endDate", endDate);
			comSubmit.addParam('sUGrpNo',selGrpName);
			comSubmit.addParam('sGrpID','${UserInfo.id}');
			comSubmit.addParam('sMenuNo','24');
			comSubmit.addParam('fixed','F');
			comSubmit.addParam('fileName',$("#excelFileName").val());
			comSubmit.submit();
			
			setTimeout(function() {
				resolve();
			},1000);
		});
	}
	
	prePart().then(function() {
		timerOn = true;
		closeModal('modal_2');
	});
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

function convAddr(str) {
	while( str.length < 3 ) {
		str = '0'+str;
	}
	
	return str;
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
				<h3>Trend Log(Spare)</h3>
				<div class="bc"><span>DCC</span><span>Trend</span><strong>Trend Log(Spare)</strong></div>
			</div>
			<!-- //page_title -->
			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<form id="selGrpFrm"></form>
				<form id="trendLogFrm" name="trendLogFrm">
				<input type = "hidden" id="sGrpID" name="sGrpID" value="Trend">
				<input type = "hidden" id="sMenuNo" name="sMenuNo" value = "24">
				<input type = "hidden" id="sDive" name="sDive" value = "D">
				<input type = "hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi }">
				<input type = "hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun }">
				</form>
				<div class="list_head">
					<div class="list_info">
                         <select style="width:400px;" id="cboUGrpName" name="cboUGrpName">
                            <option  value="">그룹을 선택하세요</option>
                           		<c:forEach var="GroupName" items="${GroupNameList}">
                           			<c:choose>
			                           		 <c:when test="${GroupName.UGrpNo eq BaseSearch.sUGrpNo }">
			                            			<option  value="${GroupName.UGrpNo}" selected>${UserInfo.hogi}-<fmt:formatNumber type="number" pattern="#000" value ="${GroupName.UGrpNo}"/>&nbsp;${GroupName.UGrpName}</option>
			                            	</c:when>
			                            	<c:when test="${GroupName.UGrpNo ne BaseSearch.sUGrpNo }">
			                            			<option  value="${GroupName.UGrpNo}">${UserInfo.hogi}-<fmt:formatNumber type="number" pattern="#000" value ="${GroupName.UGrpNo}"/>&nbsp;${GroupName.UGrpName}</option>
			                            	</c:when>
                                	</c:choose>
                                </c:forEach>
                        </select>
					</div>
				</div>
				<!-- //list_head -->
            </div>
            <!-- //list_wrap -->
            <!-- fx_layout -->

                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" id="mnuAddGroup">그룹추가</a></li>
                        <li><a href="#none" onclick="openModal('modal_1');">변수설정</a></li>
                        <li><a href="#none" onclick="openModal('modal_2');">엑셀로 저장</a></li>
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
                
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- list_table -->
                    <table class="list_table">
                        <colgroup>
                            <col width="60px"/>
                            <col />
                            <col width="60px"/>
                            <col width="80px"/>
                            <col width="240px"/>
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Descrption</th>
                                <th>Type</th>
                                <th>ADDR.</th>
                                <th>Value</th>
                            </tr>
                        </thead>
                        <tbody id="trendLogList" name = "trendLogList">
                   			 <c:forEach var="idx"  varStatus="status"  begin="0" end="24" step="1">
                                <tr>
                                    <td class="tc">${status.count}</td>
                                    <td><label id="lblDesc${idx}">${lblDataList[idx].desc}</label></td>
                                    <td class="tc"><label id="lblType${idx}">${lblDataList[idx].type}</label></td>
                                    <td class="tc"><label id="lblAddress${idx}">${lblDataList[idx].address}</label></td>
                                    <td>
                                        <div class="fx_form">
                                            <label id="lblData${idx}" class="full flex_end">${lblDataList[idx].fValue}</label>
                                            <label id="lblUnit${idx}" class="full">${lblDataList[idx].unit}</label>
                                        </div>
                                    </td>
                                </tr>
                                </c:forEach>
                          </tbody>
                    </table>
                    <!-- //list_table -->
                </div>
                <div class="fx_block">
                    <!-- list_table -->
                    <table class="list_table">
                        <colgroup>
                            <col width="60px"/>
                            <col />
                            <col width="60px"/>
                            <col width="80px"/>
                            <col width="240px"/>
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Descrption</th>
                                <th>Type</th>
                                <th>ADDR.</th>
                                <th>Value</th>
                            </tr>
                        </thead>
                        <tbody id="trendLogList" name = "trendLogList">
                            <c:forEach var="idx"  varStatus="status"  begin="25" end="49"  step="1">
                                <tr>
                                    <td class="tc">${status.count + 25}</td>
                                    <td><label id="lblDesc${idx}">${lblDataList[idx].desc}</label></td>
                                    <td class="tc"><label id="lblDesc${idx}">${lblDataList[idx].type}</label></td>
                                    <td class="tc"><label id="lblDesc${idx}">${lblDataList[idx].address}</label></td>
                                    <td>
                                        <div class="fx_form">
                                            <label id="lblData${idx}" class="full flex_end">${lblDataList[idx].fValue}</label>
                                            <label id="lblUnit${idx}" class="full">${lblDataList[idx].unit}</label>
                                        </div>
                                    </td>
                                </tr>
                                </c:forEach>                                
                          </tbody>
                    </table>
                    <!-- //list_table -->
                </div>
            </div>
            <!-- //fx_layout -->
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
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>엑셀로 저장</h3>
        <a onclick="closeModal('modal_2');" title="Close"></a>
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
                                    <input id="excelSDate" type="text">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>끝 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <input id="excelEDate" type="text">
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
                                    <label><input id="ES2" type="radio" name="radio">0.5초 데이타</label>
                                    <label><input id="EM5" type="radio" name="radio">5분 데이타</label>
                                    <label><input id="ES5" type="radio" name="radio" checked>5초 데이타</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input id="EH1" type="radio" name="radio">1시간 데이타</label>
                                    <label><input id="EM1" type="radio" name="radio">1분 데이타</label>
                                    <label><input id="CT" type="radio" name="radio">직접입력</label>
                                    <input id="excelTimeGap" type="text" class="tr fx_none" style="width:60px; value="5">
                                    <input id="eTimeGap" type="hidden" value="5">
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
                <input id="excelFileName" type="text" />
                <!-- <a id="selectFile" href="#none" class="btn_list">파일선택</a> -->
            </div>
        </div>
        <!-- //file_upload -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary" onclick="javascript:toCSV();">저장</a>
        <a href="#none" class="btn_page" onclick="closeModal('modal_2');">닫기</a>
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

<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

