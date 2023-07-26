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
var hogiHeader = '${UserInfo.hogi}' != "undefined" && '${UserInfo.hogi}' != ''   ? '${UserInfo.hogi}' : "3";
var xyHeader = '${UserInfo.xyGubun}' != "undefined" && '${UserInfo.xyGubun}' != ''  ? '${UserInfo.xyGubun}' : "X";
var lblDataListAjax = {};
var DccTagInfoListAjax = {};
var lblVoltsAjax = {};
var lblBinaryAjax = {};
var lblCountListAjax = {};
var swSort = false;
var selectedID = '';
var ioListArray = [];
var bGroupFlag = false;

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
		
		var comSubmit = new ComSubmit("numericalFrm");
		comSubmit.setUrl('/dcc/trend/numericallist');
		comSubmit.addParam("sHogi",hogiHeader);
		comSubmit.addParam("sXYGubun",xyHeader);
		comSubmit.submit();
	});
	
	$(document.body).delegate('#4', 'click', function() {
		hogiHeader = '4';
		
		var comSubmit = new ComSubmit("numericalFrm");
		comSubmit.setUrl('/dcc/trend/numericallist');
		comSubmit.addParam("sHogi",hogiHeader);
		comSubmit.addParam("sXYGubun",xyHeader);
		comSubmit.submit();
	});
	
	$(document.body).delegate('#X', 'click', function() {
		xyHeader = 'X';
		
		var comSubmit = new ComSubmit("numericalFrm");
		comSubmit.setUrl('/dcc/trend/numericallist');
		comSubmit.addParam("sHogi",hogiHeader);
		comSubmit.addParam("sXYGubun",xyHeader);
		comSubmit.submit();
	});
	
	$(document.body).delegate('#Y', 'click', function() {
		xyHeader = 'Y';
		
		var comSubmit = new ComSubmit("numericalFrm");
		comSubmit.setUrl('/dcc/trend/numericallist');
		comSubmit.addParam("sHogi",hogiHeader);
		comSubmit.addParam("sXYGubun",xyHeader);
		comSubmit.submit();
	});
	
	var lblDateVal = '${SearchTime}';
	$("#lblDate").text(lblDateVal);
	$("#lblDate").css('color','${ForeColor}');
	
	$(document.body).delegate("#setFrmIO","click",function() {
		timerOn = false;
		gHogi = $("#cboHogi option:selected").val();
		gXYGubun = $("#cboXYGubun option:selected").val();
		gIOType = $("#cboIOType option:selected").val();
		openModal('modal_1');
		
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
  	
  	setTimer(hogiHeader,xyHeader,5000);
	
});


function setTimer(hogiHeader,xyHeader,interval) {
	
	if( interval > 0 ) {
		setTimeout(function run() {
			if( timerOn ) {
				//var	comSubmit	=	new ComSubmit("numericalFrm");
				//comSubmit.setUrl("/dcc/trend/numericallist");
				//comSubmit.submit();
				var comAjax = new ComAjax("numericalFrm");
				comAjax.setUrl('/dcc/trend/reloadNumericallist');
				//comAjax.addParam("sHogi",hogiHeader);
				//comAjax.addParam("sXYGubun",xyHeader);
				comAjax.setCallback('trendCallback');
				comAjax.ajax();
			}
			
			setTimeout(run, interval);
		},interval);
	} else {
		setTimeout(function run() {
			if( timerOn ) {
				//var	comSubmit	=	new ComSubmit("numericalFrm");
				//comSubmit.setUrl("/dcc/trend/numericallist");
				//comSubmit.submit();
				var comAjax = new ComAjax("numericalFrm");
				comAjax.setUrl('/dcc/trend/reloadNumericallist');
				//comAjax.addParam("sHogi",hogiHeader);
				//comAjax.addParam("sXYGubun",xyHeader);
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
			$("#lblType"+i).text(lblDataListAjax[i].type);
			$("#lblDccID"+i).text(lblDataListAjax[i].dccId);
			$("#lblAddress"+i).text(lblDataListAjax[i].addr);
			if( lblDataListAjax[i].type == 'DT' || lblDataListAjax[i].type == 'DO' || lblDataListAjax[i].type == 'SC' ) {
				$("#lblBinary"+i).text(lblBinaryAjax[i]);
			} else {
				$("#lblVolts"+i).text(lblVoltsAjax[i]);
				$("#lblCountList"+i).text(lblCountListAjax[i]);
				$("#lblData"+i).text(convFormat(lblDataListAjax[i].fValue,4));
				$("#lblUnit"+i).text(lblDataListAjax[i].unit);
			}
		}
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
	
	comAjax.addParam("type", 'N');
	comAjax.addParam("sUGrpNo", '1');
	comAjax.setUrl("/dcc/trend/cmdOK");
	comAjax.addParam("hogiHeader", hogiHeader);
	comAjax.addParam("xyHeader", xyHeader);
	comAjax.addParam("sUGrpName", 'NUMERICAL VARIABLES');
	comAjax.addParam("sGrpID", '${UserInfo.id}');
	comAjax.addParam("sMenuNo", '25');
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
		$("#modal_loading").css("display","");
	} else if( str != 'modal_3' ) {
		$("#txtTitle").val('NUMERICAL VARIABLES');
		
		//if( grpId != 'null' && typeof grpId != 'undefined' ) {
			var comAjax = new ComAjax("showTagFrm");
			comAjax.setUrl("/dcc/trend/getTagCall");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("txtTimeGap", '5');
			comAjax.addParam("dive", 'D');
			comAjax.addParam("sGrpID", '${UserInfo.id}');
			comAjax.addParam("sMenuNo", '25');
			comAjax.addParam("sUGrpNo", '1');
			comAjax.setCallback("mbr_getTagCallback");
			comAjax.ajax();
		//}
		
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
			} else if( str != 'modal_3' ) {
				timerOn = true;
			} else {
				swSort = false;
			}
			
			setTimeout(function() {
				resolve();
			},100);
		});
	}
	
	closePart().then(function() {
		closeLayer(str);
	});
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

function convFormat(data,len) {
	var tData = data+'';
	var rtv = "";
	
	if( tData.indexOf(".") > -1 ) {
		var tmp = tData.split(".");
		var underDot = tmp[1];
		var fixed = "";
		if( tmp[1].length > len ) {
			if( underDot.substr(len-1,1)*1 > 4 ) {
				fixed = tmp[1].substr(0,len)*1+1;
				for( var i=0;i<4;i++ ) {
					if( (fixed+'').substr(-1) == '0' ) {
						fixed = fixed.substr(0,3-i);
					}
				}
			} else {
				fixed = tmp[1].substr(0,len);
				for( var i=0;i<4;i++ ) {
					if( (fixed+'').substr(-1) == '0' ) {
						fixed = fixed.substr(0,3-i);
					}
				}
			}
			
			rtv = tmp[0]+"."+fixed;
		} else {
			rtv = tData;
		}
	} else {
		rtv = tData;
	}
	
	return rtv;
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
				<h3>NUMERICAL</h3>
				<div class="bc"><span>DCC</span><span>Trend</span><strong>NUMERICAL</strong></div>
			</div>
			<!-- //page_title -->
			<!-- list_wrap -->
			<div class="list_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="javascript:openModal('modal_1');">변수설정</a></li>
                        <li><a href="#none">엑셀로 저장</a></li>
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
				<!-- list_head -->
				<form id="numericalFrm" name="numericalFrm"></form>
				<div class="list_head">
					<div class="list_info">
                        <div class="fx_legend">
                            <ul>
                                <li class="low">Low</li>
                                <li class="high">High</li>
                            </ul>
                        </div>
					</div>
				</div>
				<!-- //list_head -->                
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="40px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="140px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>No</th>                            
                            <th>TYPE</th>
                            <th>DCC ID</th>
                            <th>ADDR</th>
                            <th>VOLTS</th>
                            <th>COUNT</th>
                            <th>ENG VALUE</th>
                            <th>UNIT</th>
                        </tr>
                    </thead>
                    <tbody>
                     <tbody id="numericalList" name = "numericalList">
                     <c:forEach var="lblData" items="${lblDataList}"   varStatus="status"  >
                        <tr>
                            <td class="tc">${status.count}</td>
                            <td class="tc"><label id="lblType${status.index}">${lblData.type}</label></td>
                            <td class="tc"><label id="lblDccID${status.index}">${lblData.dccId}</label></td>
                            <td class="tc"><label id="lblAddr${status.index}">${lblData.addr}</label></td>
                            
                              <c:choose>
                            	   <c:when test="${lblData.type eq 'DT' or  lblData.type eq 'DO' or  lblData.type eq 'SC' }">
                            			<td class="tc" colspan="4"><label id="lblBinary${status.index-1}">${lblBinary[status.index]}</label></td>
                            	</c:when>
                            	<c:otherwise>
                            			<td class="tc"><label id="lblVolts${status.index}">${lblVolts[status.index]}</label></td>
										<td class="tc"><label id="lblCountList${status.index}">${lblCountList[status.index]}</label></td>
			                            <td class="tc"><label id="lblData${status.index}"><fmt:formatNumber type="number" pattern="#.####" value ="${lblData.fValue}"/></label></td>
			                            <td class="tc"><label id="lblUnit${status.index}">${lblData.unit}</label></td>
                            	</c:otherwise>
                            </c:choose>
                            
                            
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- //list_table -->
            </div>
            <!-- //list_wrap -->
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

