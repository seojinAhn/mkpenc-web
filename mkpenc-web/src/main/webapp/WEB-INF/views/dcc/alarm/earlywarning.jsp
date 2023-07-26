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
<script type="text/javascript" src="<c:url value="/resources/js/alarm.js" />" charset="utf-8"></script>

<script type="text/javascript">
	var hogiHeader = '${UserInfo.hogi}' != "undefined" && '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
	var xyHeader = '${UserInfo.xyGubun}' != "undefined" && '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";
	var ioListArray = [];
	var selectedID = '';
	var swSort = false;
	var timerOn = false;

	var gHogi,gXYGubun;
	var gIOType = 'AI';
	var ioEn = false;
	var scEn = false;
	var swSort = false;
	var bGroupFlag = false;
	var bFlagM = false;
	var bFlagD = false;
	var selectedID = '';
	var selISeq,selHogi,selXYGubun,selLoopName,selDescr,selIOType,selAddress,selIOBit,selMin,selMax,selSaveCore;
	var modParam = [
		'${BaseSearch.iSeqMod}','${BaseSearch.gubunMod}','${BaseSearch.hogiMod}','${BaseSearch.xyGubunMod}','${BaseSearch.descrMod}',
		'${BaseSearch.ioTypeMod}','${BaseSearch.addressMod}','${BaseSearch.ioBitMod}','${BaseSearch.minValMod}','${BaseSearch.maxValMod}',
		'${BaseSearch.saveCoreMod}'
	];
	
	function setModParam() {
		if( modParam[0] != '' ) $("#iSeqMod").val(modParam[0]);
		if( modParam[1] != '' ) $("#gubunMod").val(modParam[1]);
		if( modParam[2] != '' ) $("#hogiMod").val(modParam[2]);
		if( modParam[3] != '' ) $("#xyGubunMod").val(modParam[3]);
		if( modParam[4] != '' ) $("#DescrMod").val(modParam[4]);
		if( modParam[5] != '' ) $("#ioTypeMod").val(modParam[5]);
		if( modParam[6] != '' ) $("#addressMod").val(modParam[6]);
		if( modParam[7] != '' ) $("#ioBitMod").val(modParam[7]);
		if( modParam[8] != '' ) $("#minValMod").val(modParam[8]);
		if( modParam[9] != '' ) $("#maxValMod").val(modParam[9]);
		if( modParam[10] != '' ) $("#saveCoreMod").val(modParam[10]);
	}
	
	function setLblDate(time,color) {
		
		//$("#lblDate").text('${UserInfo.hogi} ' + ' ${UserInfo.xyGubun}' + ' ${BaseSearch.startDate}' );
		//$("#lblDate").css('color','${ForeColor}');
		$("#lblDate").text(time );
		$("#lblDate").css('color',color);
		/*
		var diff = new Date().getTime() - new Date('${DccTagList[0].SCANTIME}').getTime();
		if( diff / 1800000 > 1 ) {
			$("#lblDate").css('color','#e85516');
		} else {
			$("#lblDate").css('color','#05c8be');
		}
		*/
	}
	
	$(function () {
		setModParam();
		
		$(document.body).delegate('#3', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '3';
			//console.log('click3 :: '+hogiHeader);
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#4', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '4';
			//console.log('click4 :: '+hogiHeader);
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#X', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'X';
			//console.log('clickX :: '+xyHeader);
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#Y', 'click', function() {
		//	var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'Y';
			//console.log('clickY :: '+xyHeader);
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		if( $("#txtTitle").val() == '' ) $("#txtTitle").val('경보 설정');
		
		$("#txtGUBUN").val('D');
		
		setLblDate('${ScanTime}','${ForeColor}');
		
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
			//console.log(typeof gXYGubun+':'+gXYGubun+' | '+ typeof $("#cboIOType option:selected")+':'+$("#cboIOType option:selected").val()+' | '+$("#txtADDRESS").val()+' | '+swSort);
			if( $("#cboHogi option:selected").val() != '' && !swSort ) {
				//console.log('1234');
				gHogi = $("#cboHogi option:selected").val() != '4' ? '3' : '4';
				if( typeof gXYGubun != 'undefined' && typeof $("#cboIOType option:selected") != 'undefined' && $("#txtADDRESS").val() != '' ) {
					ssql(false);
				}
			}
		});
		
		$(document.body).delegate('#cboXYGubun', 'change', function() {
			if( $("#cboXYGubun option:selected").val() != '' && !swSort ) {
				gXYGubun = $("#cboXYGubun option:selected").val() != 'Y' ? 'X' : 'Y';
				if( $("#txtADDRESS").val() != '' ) {
					ssql(false);
				}
			}
		});
		
		$(document.body).delegate('#chkSaveCore', 'change', function() {
			if( $("input:checkbox[id='chkSaveCore']").is(":checked") ) {
				ioEn = true;
				$("#txtIOBIT").attr("disabled",false);
			} else {
				ioEn = false;
				$("#txtIOBIT").attr("disabled",true);
			}
		});
		
		$(document.body).delegate('#cboIOType', 'change', function() {
			if( $("#cboIOType option:selected").val() != '' && !swSort ) {
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
					console.log(selectedID);
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
		
		/*$(document.body).delegate('#lvIOListTable tr', 'click', function() {
				var ioListArray = getLvIOList();
				if( ioListArray.length > 0 ) {
					if(this.id != 'itemHeaders') {
						selectedID = $(this).context.children[10].textContent+'_'+$(this).context.children[1].textContent;
						swSort = true;
						
						var gubun = $(this).context.children[0].textContent == '' ? 'D' : $(this).context.children[0].textContent;
						$("#cboHogi").val($(this).context.children[1].textContent == '' ? '${UserInfo.hogi}': $(this).context.children[1].textContent);
						$("#cboXYGubun").val($(this).context.children[2].textContent == '' ? '${UserInfo.xyGubun}' : $(this).context.children[2].textContent);
						$("#txtLOOPNAME").val($(this).context.children[3].textContent);
						$("#cboIOType").val($(this).context.children[4].textContent == '' ? gIOType : $(this).context.children[4].textContent);
						$("#txtADDRESS").val($(this).context.children[5].textContent);
						if( $("#cboIOType").val() == 'DI' || $("#cboIOType").val() == 'DO' || $("#cboIOType").val() == 'SC' ) {
							ioEn = true;
							$("#txtIOBIT").attr("disabled",false);
							$("#txtIOBIT").val($(this).context.children[6].textContent);
						} else {
							ioEn = false;
							$("#txtIOBIT").attr("disabled",true);
							$("#txtIOBIT").val('');
						}
						$("#txtMin").val($(this).context.children[7].textContent);
						$("#txtMax").val($(this).context.children[8].textContent);
						if( $(this).context.children[9].textContent == '1' ) {
							$("#chkSaveCore").prop("checked",true);
						}
						$("#txtISeq").val($(this).context.children[10].textContent);
						$("#txtGUBUN").val(gubun);
						
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
						
						txtADDRESS_LostFocus(gubun);
						
						swSort = false;
					}
				}
		});
		
		$(document.body).delegate('#cmdUp', 'click', function() {
			cmdUp_click();
		});
		
		$(document.body).delegate('#cmdDown', 'click', function() {
			cmdDown_click();
		});*/
		
		/*$(document.body).delegate('#cmdGroupInsert', 'click', function() {
			var currentTitle = $("#txtTitle").val();
			if( currentTitle == '' ) {
				alert('제목을 입력하십시오. IO Setting');
				return;
			} else {
				saveData('G',currentTitle);
			}
		});*/
		
		/*$(document.body).delegate('#cmdInsert', 'click', function() {
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
			cmdFind_click(0);
		});
		
		$(document.body).delegate('#tagFindAll', 'click', function() {
			cmdFind_click(1);
		});
		
		$(document.body).delegate('#tagSearchTable tr', 'click', function() {
			// selISeq,selHogi,selXYGubun,selLoopName,selDescr,selIOType,selAddress,selIOBit,selMin,selMax,selSaveCore;
			selISeq = $(this).children().eq(0).text();
			selHogi = $(this).children().eq(1).text();
			selXYGubun = $(this).children().eq(2).text();
			selLoopName = $(this).children().eq(3).text();
			selDescr = $(this).children().eq(4).text();
			selIOType = $(this).children().eq(5).text();
			selAddress = $(this).children().eq(6).text();
			selIOBit = $(this).children().eq(7).text();
			selMin = $(this).children().eq(8).text();
			selMax = $(this).children().eq(9).text();
			selSaveCore = $(this).children().eq(10).text();
		});
		
		$(document.body).delegate('#tagSearchSelect', 'click', function() {
			if( typeof selISeq == 'undefined' || selISeq == '' ) {
				alert('항목을 선택하십시오.');
				return;
			} else {
				$("#txtISeq").val(selISeq);
				$("#cboHogi").val(selHogi);
				$("#cboXYGubun").val(selXYGubun);
				$("#txtLOOPNAME").val(selLoopName);
				$("#cboIOType").val(selIOType != 'DT' ? 'AI' : selIOType);
				$("#txtADDRESS").val(selAddress);
				$("#txtIOBit").val(selIOBit);
				$("#txtMin").val(selMin);
				$("#txtMax").val(selMax);
				if( selSaveCore == '1' ) $("input:checkbox[id='chkSaveCore']").prop("checked",true);
			}
			
			closeModal('modal_3');
			cmdFind_click(2);
		});
		
		$("#cboHogi").change(function() {
			if( $("#cboHogi option:selected").val() == '' || !swSort ) {
				gHogi = $("#cboHogi option:selected").val() != '4' ? '3' : '4';
				if( typeof gXYGubun != 'undefined' && typeof gXYGubun != 'undefined' && $("#txtADDRESS").val() != '' ) {
					ssql(false);
				}
			}
		});
		
		$("#cboXYGubun").change(function() {
			if( $("#cboXYGubun option:selected").val() == '' || !swSort ) {
				gXYGubun = $("#cboXYGubun option:selected").val() != 'Y' ? 'X' : 'Y';
				if( $("#txtADDRESS").val() != '' ) {
					ssql(false);
				}
			}
		});
		
		$("#chkSaveCore").change(function() {
			if( $("input:checkbox[id='chkSaveCore']").is(":checked") ) {
				ioEn = true;
				$("#txtIOBIT").attr("disabled",false);
			} else {
				ioEn = false;
				$("#txtIOBIT").attr("disabled",true);
			}
		});
		
		$("#cboIOType").change(function() {
			if( $("#cboIOType option:selected").val() == '' || !swSort ) {
				ioEn = false;
				scEn = false;
				gIOType = $("#cboIOType option:selected").val();
				if( typeof gHogi == 'undefined' || gHogi == '' ) {
					alert('호기를 선택해주세요 (변수설정에러)');
					return;
				}
				if( typeof gXYGubun == 'undefined' || gXYGubun == ''  ) {
					alert('X Y를 선택해주세요 (변수설정에러)');
					return;
				}
				if( typeof gIOType == 'undefined' || gIOType == ''  ) {
					alert('IO TYPE을 선택해주세요 (변수설정에러)');
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
			}
		});*/
		
		var timer =0;
		
		timer = setInterval(function () {
			var pageNum = $("#pageNo2").val() == 'undefined' ? 2 : 1;
			var comAjax = new ComAjax("earlyWarningFrm");
			comAjax.setUrl("/dcc/alarm/runtimerEW");
			comAjax.addParam("pageNum", pageNum*1);
			comAjax.setCallback("mbr_RuntimerEventCallback");
			comAjax.ajax();
		}, 5000);
	 
	});
	
	function pageChange(page) {
		
		if( page == 1 ) {
			$("#pageNo1").val('');
			$("#pageNo2").val('2');
		}
		if( page == 2 ) {
			$("#pageNo1").val('1');
			$("#pageNo2").val('');
		}
		
		var comAjax = new ComAjax("earlyWarningFrm");
		comAjax.setUrl("/dcc/alarm/runtimerEW");
		comAjax.addParam("pageNum", page);
		comAjax.setCallback("mbr_RuntimerEventCallback");
		comAjax.ajax();
	}
	
	/*function txtADDRESS_LostFocus(gubun) {
		ioEn = false;
		scEn = false;
		swSort = false;

		if( gubun == 'D' ) {
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
				}
			} else {
				ssql(swSort);
			}
		}
	}
	
	function ssql(swSort) {
		$("#txtADDRESS").css("color","black");
		$("#txtMax").css("background","#FFFFFF");
		$("#txtMin").css("background","#FFFFFF");
		
		var ioType = gIOType;
		if( typeof ioType == 'undefined' ) ioType = 'AI';
		if( ioType == 'AO' ) ioType = 'DT';
		
		if( swSort ) {
			if($("input:checkbox[id='chkSaveCore']").is(":checked") ) {
				$("#txtADDRESS").css("color","#FF00FF");
			} else {
				$("#txtADDRESS").css("color","#000000");
			}
		} else {
			var page = typeof $("#pageNo2").val() == 'undefined' ? 1 : 2;
			var comAjax = new ComAjax("ioListForm");
			comAjax.setUrl("/dcc/alarm/ssql");
			comAjax.addParam("ioType", ioType);
			comAjax.addParam("ioBit", typeof $("#txtIOBIT").val() == 'undefined' ? '' : $("#txtIOBIT").val() );
			comAjax.addParam("SaveCore", $("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0");
			comAjax.addParam("address", typeof $("#txtADDRESS").val() == 'undefined' ? "" : $("#txtADDRESS").val());
			comAjax.setCallback("mbr_ssqlCallback");
			comAjax.ajax();
			
			setIOAjax();
		}
	}*/
	
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
	
	function setIOAjax() {
		if( $("#ajaxHogi").val() != null ) $("#cboHogi").val($("#ajaxHogi").val()).prop("selected",true);
		if( $("#ajaxXYGubun").val() != null ) $("#cboXYGubun").val($("#ajaxXYGubun").val()).prop("selected",true);
		if( $("#ajaxLoopName").val() != null ) $("#txtLOOPNAME").val($("#ajaxLoopName").val());
		if( $("#ajaxIOType").val() != null || typeof $("#ajaxIOType").val() == 'undefined' ) $("#cboIOType").val($("#ajaxIOType").val()).prop("selected",true);
		if( $("#ajaxAddress").val() != null ) $("#txtADDRESS").val($("#ajaxAddress").val());
		if( $("#ajaxIOBit").val() != null ) $("#txtIOBIT").val($("#ajaxIOBit").val());
		if( $("#ajaxMin").val() != null ) $("#txtMin").val($("#ajaxMin").val());
		if( $("#ajaxMax").val() != null ) $("#txtMax").val($("#ajaxMax").val());
		if( $("#ajaxSaveCore").val() == '1' ) $("input:checkbox[id='chkSaveCore']").prop("checked",true);
		
		if( $("#ajaxFastIoChk").val() == '1' ) {
			$("#txtADDRESS").css("color","#FF00FF");
		} else {
			$("#txtADDRESS").css("color","#000000");
		}
		$("#txtMin").css("background","#FFFFFF");
		$("#txtMax").css("background","#FFFFFF");
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
	
	function getArrayValue(array,key) {
		var val;
		for( var i=0;i<array.length;i++ ) {
			if( array[i].key  == key ) {
				val = array[i].value;
			}
		}
		return val;
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
	
	function getLvIOList() {
		var tmpArray = '${LvIOList}'.replace('[{','').replace('}]','').split('}, {');
		var ioListArray = [];
		var ioListArraySub = [];
		for( var i=0;i<tmpArray.length;i++ ) {
			var tmpSub = tmpArray[i].split(', ');
			for( var j=0;j<tmpSub.length;j++ ) {
				var k = tmpSub[j].split('=')[0];
				var v = tmpSub[j].split('=')[1];
				ioListArraySub.push({key:k,value:v});
			}
			ioListArray.push(ioListArraySub);
			ioListArraySub = [];
		}
		
		return ioListArray;
	}
		
	/*function cmdInsert_click(type) {
		var ioListArray = getLvIOList();
		
		var data = '';
		var gubun = $("#txtGUBUN").val() == '' ? 'D' : $("#txtGUBUN").val();
		
		var iSeqAdd = $("#txtISeq").val();
		//var gubunAdd = $("#txtGUBUN").val();
		var gubunAdd = 'D';
		var hogiAdd = $("#cboHogi option:selected").val();
		var xyGubunAdd = $("#cboXYGubun option:selected").val();
		var DescrAdd = $("#txtLOOPNAME").val();
		var ioTypeAdd = $("#cboIOType option:selected").val();
		var addressAdd = $("#txtADDRESS").val();
		var ioBitAdd = $("#txtIOBIT").val();
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
		if( $.trim(minValAdd) == '' ) minValAdd = '0';
		if( $.trim(maxValAdd) == '' ) {
			if( ioTypeAdd == 'DI' || ioTypeAdd == 'DO' || (ioTypeAdd == 'SC' && saveCoreAdd == '1') ) {
				maxValAdd = '1';
			} else if( (ioTypeAdd == 'SC' && saveCoreAdd == '0') ) {
				maxValAdd = '65535';
			} else if( ioTypeAdd == 'DT' ) {
				maxValAdd = '1.5';
			} else {
				maxValAdd = '100';
			}
		}
		if( (ioTypeAdd == 'SC' && saveCoreAdd == '1') ) {
			if( $.trim(ioBitAdd) == '' ) {
				alert('IOBIT을 입력하십시요.');
				return;
			}
		} else if( (ioTypeAdd == 'SC' && saveCoreAdd == '0') ) {
			ioBitAdd = '';
		}
		if( $.trim(DescrAdd) == '' ) {
			if( ioBitAdd != '' ) {
				DescrAdd = ioTypeAdd+' '+addressAdd+':'+ioBitAdd;
			} else {
				DescrAdd = ioTypeAdd+' '+addressAdd;
			}
		}
		
		var iSeqMod = $("#iSeqMod").val().split('==SEP==');
		var gubunMod = $("#gubunMod").val().split('==SEP==');
		var hogiMod = $("#hogiMod").val().split('==SEP==');
		var xyGubunMod = $("#xyGubunMod").val().split('==SEP==');
		var DescrMod = $("#DescrMod").val().split('==SEP==');
		var ioTypeMod = $("#ioTypeMod").val().split('==SEP==');
		var addressMod = $("#addressMod").val().split('==SEP==');
		var ioBitMod = $("#ioBitMod").val().split('==SEP==');
		var minValMod = $("#minValMod").val().split('==SEP==');
		var maxValMod = $("#maxValMod").val().split('==SEP==');
		var saveCoreMod = $("#saveCoreMod").val().split('==SEP==');
		
		var dupChk = 0;
		if( !removeModData(iSeqMod[0].split('|'),iSeqAdd) ) {
			for( var l=0;l<ioListArray.length;l++ ) {
				for( var sl=0;sl<ioListArray[l].length;sl++ ) {
					if( ioListArray[l][sl].key == 'iSeq' ) {
						if( ioListArray[l][sl].value == iSeqAdd ) {
							dupChk++;
						}
					} else if( ioListArray[l][sl].key == 'hogi' ) {
						if( ioListArray[l][sl].value == hogiAdd ) {
							if( dupChk < 1 ) dupChk++;
						}
					}
				}
			}
			
			if( dupChk > 1 ) {
				alert('이미 설정되어 있습니다.');
				dupChk = 0;
				return;
			}
			
			if( iSeqMod[0] != '|' ) {
				iSeqAdd += '|'+ iSeqMod[0];
				gubunAdd += '|'+ gubunMod[0];
				hogiAdd += '|'+ hogiMod[0];
				xyGubunAdd += '|'+ xyGubunMod[0];
				DescrAdd += '|'+ DescrMod[0];
				ioTypeAdd += '|'+ ioTypeMod[0];
				addressAdd += '|'+ addressMod[0];
				ioBitAdd += '|'+ ioBitMod[0];
				minValAdd += '|'+ minValMod[0];
				maxValAdd += '|'+ maxValMod[0];
				saveCoreAdd += '|'+ saveCoreMod[0];
			} else {
				iSeqAdd += '|';
				gubunAdd += '|';
				hogiAdd += '|';
				xyGubunAdd += '|';
				DescrAdd += '|';
				ioTypeAdd += '|';
				addressAdd += '|';
				ioBitAdd += '|';
				minValAdd += '|';
				maxValAdd += '|';
				saveCoreAdd += '|';
			}
		}
		
		var listCnt = iSeqMod[0].split('|').length + ioListArray.length;
		if( typeof iSeqMod[1] != 'undefined' ) listCnt -= iSeqMod[1].split('|').length;
		
		if( type != 0 ) {
			if( listCnt > 7 ) {
				alert('8개 까지만 지정할수 있습니다.');
				return;
			}
		}
		
		$("#iSeqMod").val(iSeqMod[1] == '' ? iSeqAdd + '==SEP==|' : iSeqAdd + '==SEP==' + iSeqMod[1]);
		$("#gubunMod").val(gubunMod[1] == '' ? gubunAdd + '==SEP==|' : gubunAdd + '==SEP==' + gubunMod[1]);
		$("#hogiMod").val(hogiMod[1] == '' ? hogiAdd + '==SEP==|' : hogiAdd + '==SEP==' + hogiMod[1]);
		$("#xyGubunMod").val(xyGubunMod[1] == '' ? xyGubunAdd + '==SEP==|' : xyGubunAdd + '==SEP==' + xyGubunMod[1]);
		$("#DescrMod").val(DescrMod[1] == '' ? DescrAdd + '==SEP==|' : DescrAdd + '==SEP==' + DescrMod[1]);
		$("#ioTypeMod").val(ioTypeMod[1] == '' ? ioTypeAdd + '==SEP==|' : ioTypeAdd + '==SEP==' + ioTypeMod[1]);
		$("#addressMod").val(addressMod[1] == '' ? addressAdd + '==SEP==|' : addressAdd + '==SEP==' + addressMod[1]);
		$("#ioBitMod").val(ioBitMod[1] == '' ? ioBitAdd + '==SEP==|' : ioBitAdd + '==SEP==' + ioBitMod[1]);
		$("#minValMod").val(minValMod[1] == '' ? minValAdd + '==SEP==|' : minValAdd + '==SEP==' + minValMod[1]);
		$("#maxValMod").val(maxValMod[1] == '' ? maxValAdd + '==SEP==|' : maxValAdd + '==SEP==' + maxValMod[1]);
		$("#saveCoreMod").val(saveCoreMod[1] == '' ? saveCoreAdd + '==SEP==|' : saveCoreAdd + '==SEP==' + saveCoreMod[1]);

		if( type == 1 ) {
			var comAjax = new ComAjax("ioListModForm");
			comAjax.setUrl("/dcc/alarm/cmdInsert");
			comAjax.addParam("iSeqMod", $("#iSeqMod").val());
			comAjax.addParam("gubunMod", $("#gubunMod").val());
			comAjax.addParam("hogiMod", $("#hogiMod").val());
			comAjax.addParam("xyGubunMod", $("#xyGubunMod").val());
			comAjax.addParam("descrMod", $("#DescrMod").val());
			comAjax.addParam("ioTypeMod", $("#ioTypeMod").val());
			comAjax.addParam("addressMod", $("#addressMod").val());
			comAjax.addParam("ioBitMod", $("#ioBitMod").val());
			comAjax.addParam("minValMod", $("#minValMod").val());
			comAjax.addParam("maxValMod", $("#maxValMod").val());
			comAjax.addParam("saveCoreMod", $("#saveCoreMod").val());
			comAjax.setCallback("mbr_cmdEventCallback");
			comAjax.ajax();
			
			textClear();
		}
	}
		
	function cmdDelete_click(type) {
		var ioListArray = getLvIOList();
		
		if( ioListArray.length > 0 ) {
			var data = '';
			var gubun = $("#txtGUBUN").val() == '' ? 'D' : $("#txtGUBUN").val();
			
			var iSeqAdd = $("#txtISeq").val();
			var gubunAdd = $("#txtGUBUN").val();
			var hogiAdd = $("#cboHogi option:selected").val();
			var xyGubunAdd = $("#cboXYGubun option:selected").val();
			var DescrAdd = $("#txtLOOPNAME").val();
			var ioTypeAdd = $("#cboIOType option:selected").val();
			var addressAdd = $("#txtADDRESS").val();
			var ioBitAdd = $("#txtIOBIT").val();
			var minValAdd = $("#txtMin").val();
			var maxValAdd = $("#txtMax").val();
			var saveCoreAdd = $("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0";
			
			var iSeqMod = $("#iSeqMod").val().split('==SEP==');
			var gubunMod = $("#gubunMod").val().split('==SEP==');
			var hogiMod = $("#hogiMod").val().split('==SEP==');
			var xyGubunMod = $("#xyGubunMod").val().split('==SEP==');
			var DescrMod = $("#DescrMod").val().split('==SEP==');
			var ioTypeMod = $("#ioTypeMod").val().split('==SEP==');
			var addressMod = $("#addressMod").val().split('==SEP==');
			var ioBitMod = $("#ioBitMod").val().split('==SEP==');
			var minValMod = $("#minValMod").val().split('==SEP==');
			var maxValMod = $("#maxValMod").val().split('==SEP==');
			var saveCoreMod = $("#saveCoreMod").val().split('==SEP==');
			
			if( typeof iSeqMod[1] != 'undefined' ) {
				if( !removeModData(iSeqMod[1].split('|'),iSeqAdd) ) {
					iSeqAdd += '|'+iSeqMod[1];
					gubunAdd += '|'+gubunMod[1];
					hogiAdd += '|'+hogiMod[1];
					xyGubunAdd += '|'+xyGubunMod[1];
					DescrAdd += '|'+DescrMod[1];
					ioTypeAdd += '|'+ioTypeMod[1];
					addressAdd += '|'+addressMod[1];
					ioBitAdd += '|'+ioBitMod[1];
					minValAdd += '|'+minValMod[1];
					maxValAdd += '|'+maxValMod[1];
					saveCoreAdd += '|'+saveCoreMod[1];
				}
			} else {
				iSeqAdd += '|';
				gubunAdd += '|';
				hogiAdd += '|';
				xyGubunAdd += '|';
				DescrAdd += '|';
				ioTypeAdd += '|';
				addressAdd += '|';
				ioBitAdd += '|';
				minValAdd += '|';
				maxValAdd += '|';
				saveCoreAdd += '|';
			}
			
			$("#iSeqMod").val(iSeqMod[0] == '' ? '|==SEP=='+iSeqAdd : iSeqMod[0]+'==SEP=='+iSeqAdd);
			$("#gubunMod").val(gubunMod[0] == '' ? '|==SEP=='+gubunAdd : gubunMod[0]+'==SEP=='+gubunAdd);
			$("#hogiMod").val(hogiMod[0] == '' ? '|==SEP=='+hogiAdd : hogiMod[0]+'==SEP=='+hogiAdd);
			$("#xyGubunMod").val(xyGubunMod[0] == '' ? '|==SEP=='+xyGubunAdd : xyGubunMod[0]+'==SEP=='+xyGubunAdd);
			$("#DescrMod").val(DescrMod[0] == '' ? '|==SEP=='+DescrAdd : DescrMod[0]+'==SEP=='+DescrAdd);
			$("#ioTypeMod").val(ioTypeMod[0] == '' ? '|==SEP=='+ioTypeAdd : ioTypeMod[0]+'==SEP=='+ioTypeAdd);
			$("#addressMod").val(addressMod[0] == '' ? '|==SEP=='+addressAdd : addressMod[0]+'==SEP=='+addressAdd);
			$("#ioBitMod").val(ioBitMod[0] == '' ? '|==SEP=='+ioBitAdd : ioBitMod[0]+'==SEP=='+ioBitAdd);
			$("#minValMod").val(minValMod[0] == '' ? '|==SEP=='+minValAdd : minValMod[0]+'==SEP=='+minValAdd);
			$("#maxValMod").val(maxValMod[0] == '' ? '|==SEP=='+maxValAdd : maxValMod[0]+'==SEP=='+maxValAdd);
			$("#saveCoreMod").val(saveCoreMod[0] == '' ? '|==SEP=='+saveCoreAdd : saveCoreMod[0]+'==SEP=='+saveCoreAdd);
	
			if( type == 1 ) {
				var comAjax = new ComAjax("ioListModForm");
				comAjax.setUrl("/dcc/alarm/cmdInsert");
				comAjax.addParam("iSeqMod", $("#iSeqMod").val());
				comAjax.addParam("gubunMod", $("#gubunMod").val());
				comAjax.addParam("hogiMod", $("#hogiMod").val());
				comAjax.addParam("xyGubunMod", $("#xyGubunMod").val());
				comAjax.addParam("descrMod", $("#DescrMod").val());
				comAjax.addParam("ioTypeMod", $("#ioTypeMod").val());
				comAjax.addParam("addressMod", $("#addressMod").val());
				comAjax.addParam("ioBitMod", $("#ioBitMod").val());
				comAjax.addParam("minValMod", $("#minValMod").val());
				comAjax.addParam("maxValMod", $("#maxValMod").val());
				comAjax.addParam("saveCoreMod", $("#saveCoreMod").val());
				comAjax.setCallback("mbr_cmdEventCallback");
				comAjax.ajax();
				
				textClear();
			}
		}
	}
	
	function cmdUpdate_click() {
		var ioListArray = getLvIOList();
		if( ioListArray.length > 0 ) {
		
			var seletedIseq = '';
			var seletedHogi = '';
			if( selectedID != '' ) {
				seletedIseq = selectedID.split('_')[0];
				seletedHogi = selectedID.split('_')[1];
			}
			
			var valIOType = $("#cboIOType option:selected").val();
			var bSaveCore = $("input:checkbox[id='chkSaveCore']").is(":checked");
			
			if( $.trim($("#txtMin").val()) == '' ) $("#txtMin").val('0');
			if( valIOType == 'DI' || valIOType == 'DO' ) {
				$("#txtMax").val('1');
			} else if( valIOType == 'SC' && !bSaveCore ) {
				$("#txtMax").val('65535');
				$("#txtIOBIT").val('');
			} else if( valIOType == 'DT' ) {
				$("#txtMax").val('1.5');
			} else {
				$("#txtMax").val('100');
			}
			if( valIOType == 'SC' && !bSaveCore ) {
				$("#txtMax").val('1');
				if( $.trim($("#txtIOBIT").val()) == '' ) {
					alert('IOBIT을 입력하십시요');
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
			
			cmdDelete_click(0);
			cmdInsert_click(0);
			
			$("#"+seletedIseq+"iSeq"+seletedHogi).text($("#txtISeq").val());
			$("#"+seletedIseq+"gubun"+seletedHogi).text($("#txtGUBUN").val());
			$("#"+seletedIseq+"hogi"+seletedHogi).text($("#cboHogi option:selected").val());
			$("#"+seletedIseq+"xyGubun"+seletedHogi).text($("#cboXYGubun option:selected").val());
			$("#"+seletedIseq+"descr"+seletedHogi).text($("#txtLOOPNAME").val());
			$("#"+seletedIseq+"ioType"+seletedHogi).text($("#cboIOType option:selected").val());
			$("#"+seletedIseq+"address"+seletedHogi).text($("#txtADDRESS").val());
			$("#"+seletedIseq+"ioBit"+seletedHogi).text($("#txtIOBIT").val());
			$("#"+seletedIseq+"minVal"+seletedHogi).text($("#txtMin").val());
			$("#"+seletedIseq+"maxVal"+seletedHogi).text($("#txtMax").val());
			$("#"+seletedIseq+"saveCoreChk"+seletedHogi).text($("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0");
			
			textClear();
		}
	}
	
	function cmdOK_click() {
		if( bGroupFlag ) {
			//group
		} else {
			if( $("#txtTitle").val() == '' ) {
				alert('제목을 입력하십시요 (IO Setting)');
				return;
			}
			
			
			//var ioListArray = getLvIOList();
			//for( var i=0;i<ioListArray.length;i++ ) {
			//	if( ioListArray[i].key == 'gubun' ) {
			//		if( ioListArray[i].value == 'M' ) {
			//			bFlagM = true;
			//		}
			//	}
			//	if( ioListArray[i].key == 'gubun' ) {
			//		if( ioListArray[i].value == 'D' ) {
			//			bFlagD = true;
			//		}
			//	}
			//}
			
			//if( !bFlagM ) {
			//	alert('DCC, MARK-V 비교트랜드 입니다. MARK-V 태그가 설정되지 않았습니다. (태그설정)');
			//	return;
			//}
			//if( !bFlagD ) {
			//	alert('DCC, MARK-V 비교트랜드 입니다. DCC 태그가 설정되지 않았습니다. (태그설정)');
			//	return;
			//}
			
			
			var comAjax = new ComAjax("ioListModForm");
			comAjax.setUrl("/dcc/alarm/cmdOK");
			comAjax.addParam("iSeqMod", $("#iSeqMod").val() == '' ? "|==SEP==|" : $("#iSeqMod").val());
			comAjax.addParam("gubunMod", $("#gubunMod").val() == '' ? "|==SEP==|" : $("#gubunMod").val());
			comAjax.addParam("hogiMod", $("#hogiMod").val() == '' ? "|==SEP==|" : $("#hogiMod").val());
			comAjax.addParam("xyGubunMod", $("#xyGubunMod").val() == '' ? "|==SEP==|" : $("#xyGubunMod").val());
			comAjax.addParam("descrMod", $("#DescrMod").val() == '' ? "|==SEP==|" : $("#DescrMod").val());
			comAjax.addParam("ioTypeMod", $("#ioTypeMod").val() == '' ? "|==SEP==|" : $("#ioTypeMod").val());
			comAjax.addParam("addressMod", $("#addressMod").val() == '' ? "|==SEP==|" : $("#addressMod").val());
			comAjax.addParam("ioBitMod", $("#ioBitMod").val() == '' ? "|==SEP==|" : $("#ioBitMod").val());
			comAjax.addParam("minValMod", $("#minValMod").val() == '' ? "|==SEP==|" : $("#minValMod").val());
			comAjax.addParam("maxValMod", $("#maxValMod").val() == '' ? "|==SEP==|" : $("#maxValMod").val());
			comAjax.addParam("saveCoreMod", $("#saveCoreMod").val() == '' ? "|==SEP==|" : $("#saveCoreMod").val());
			if( $("input:checkbox[id=chkHogi]").is(":checked") ) {
				comAjax.addParam("chkHogi", "1");
			}
			comAjax.setCallback("mbr_cmdEventCallback");
			comAjax.ajax();
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
		
		$("#txtISeq").val('');
		$("#txtGUBUN").val('');
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
	
	function cmdUp_click() {
		var ioListArray = getLvIOList();
		
		var currentSeq = $("#txtISeq").val() == '' ? getArrayValue(ioListArray[0],'iSeq') : $("#txtISeq").val();
		
		for( var k=0;k<ioListArray.length;k++ ) {
			if( currentSeq == getArrayValue(ioListArray[k],'iSeq') ) {
				var gubun = '';
				if( ioListArray.length > 2 && k > 0 ) {
					gubun = getArrayValue(ioListArray[k-1],'gubun');
					$("#cboHogi").val(getArrayValue(ioListArray[k-1],'hogi'));
					$("#cboXYGubun").val(getArrayValue(ioListArray[k-1],'xyGubun'));
					$("#txtLOOPNAME").val(getArrayValue(ioListArray[k-1],'Descr'));
					$("#cboIOType").val(getArrayValue(ioListArray[k-1],'ioType'));
					$("#txtADDRESS").val(getArrayValue(ioListArray[k-1],'address'));
					$("#txtIOBIT").val(getArrayValue(ioListArray[k-1],'ioBit'));
					$("#txtMin").val(getArrayValue(ioListArray[k-1],'minVal'));
					$("#txtMax").val(getArrayValue(ioListArray[k-1],'maxVal'));
					if( getArrayValue(ioListArray[k-1],'saveCoreChk') == '1' ) $("#chkSaveCore").prop("checked",true);
					$("#txtISeq").val(getArrayValue(ioListArray[k-1],'iSeq'));
					$("#txtGUBUN").val(gubun);
				} else {
					gubun = getArrayValue(ioListArray[k],'gubun');
				}
				
				txtADDRESS_LostFocus(gubun);
			}
		}
	}
	
	function cmdDown_click() {
		var ioListArray = getLvIOList();
		
		var currentSeq = $("#txtISeq").val() == '' ? getArrayValue(ioListArray[0],'iSeq') : $("#txtISeq").val();
		
		for( var k=0;k<ioListArray.length;k++ ) {
			if( currentSeq == getArrayValue(ioListArray[k],'iSeq') ) {
				var gubun = '';
				if( ioListArray.length > 2 && k != ioListArray.length-1 ) {
					gubun = getArrayValue(ioListArray[k+1],'gubun');
					$("#cboHogi").val(getArrayValue(ioListArray[k+1],'hogi'));
					$("#cboXYGubun").val(getArrayValue(ioListArray[k+1],'xyGubun'));
					$("#txtLOOPNAME").val(getArrayValue(ioListArray[k+1],'Descr'));
					$("#cboIOType").val(getArrayValue(ioListArray[k+1],'ioType'));
					$("#txtADDRESS").val(getArrayValue(ioListArray[k+1],'address'));
					$("#txtIOBIT").val(getArrayValue(ioListArray[k+1],'ioBit'));
					$("#txtMin").val(getArrayValue(ioListArray[k+1],'minVal'));
					$("#txtMax").val(getArrayValue(ioListArray[k+1],'maxVal'));
					if( getArrayValue(ioListArray[k+1],'saveCoreChk') == '1' ) $("#chkSaveCore").prop("checked",true);
					$("#txtISeq").val(getArrayValue(ioListArray[k+1],'iSeq'));
					$("#txtGUBUN").val(gubun);
				} else {
					gubun = getArrayValue(ioListArray[k],'gubun');
				}
				
				txtADDRESS_LostFocus(gubun);
			}
		}
	}*/
	
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

		for( var i=0;i<tbInfo.length;i++ ) {
			if( tbInfo[i].id.indexOf('tr') > -1 ) {
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
			comAjax.addParam("sUGrpNo", "1");
		}

		comAjax.setUrl("/dcc/alarm/cmdOK");
		comAjax.addParam("hogiHeader", hogiHeader);
		comAjax.addParam("xyHeader", xyHeader);
		comAjax.addParam("sUGrpName", '경보 설정');
		comAjax.addParam("sGrpID", '${UserInfo.id}');
		comAjax.addParam("sMenuNo", '65');
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
	
	/*function openModal(str) {
		if( str != 'modal_3' ) {
			openLayer(str);
			
		} else {
			swSort = true;
			openLayer(str);
		}
	}
	
	function closeModal(str) {
		textClear(str);
		
		if( str != 'modal_3' ) {
			//cmdOK_click();
		} else {
			swSort = false;
		}
		
		closeLayer(str);
	}*/
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
		} else if( str != 'modal_3' ) {
			$("#txtTitle").val('경보 설정');
			
			//if( grpId != 'null' && typeof grpId != 'undefined' ) {
				var comAjax = new ComAjax("showTagFrm");
				comAjax.setUrl("/dcc/alarm/getTagCall");
				comAjax.addParam("hogiHeader", hogiHeader);
				comAjax.addParam("xyHeader", xyHeader);
				comAjax.addParam("dive", 'D');
				comAjax.addParam("sGrpID", '${UserInfo.id}');
				comAjax.addParam("sMenuNo", '65');
				comAjax.addParam("sUGrpNo", '1');
				comAjax.setCallback("mbr_getTagCallback");
				comAjax.ajax();
			//}
			
			openLayer(str);
		} else {
			swSort = true;
			openLayer(str);
			$("#findData").focus();
		}
	}
	
	function closeModal(str) {
		//textClear(str);
		if( str == 'modal_loading' ) {
			$("#modal_loading").css("display","none");
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
	}
	
	function cmdUp_click() {
		var tbInfo = $("#lvIolistTable")[0].children;
		var cnt = 0;
		
		for( var i=0;i<tbInfo.length;i++ ) {
			if( tbInfo[i].id.indexOf('tr') > -1 ) {
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

		for( var i=0;i<tbInfo.length;i++ ) {
			if( tbInfo[i].id == 'tr'+selectedIseq+'_'+selectedHogi ) {
				if( cnt >= 1 && i > 0 ) {
					pos = i;
					curData = {
						'hogi': tbInfo[i].children[0].textContent
						,'xyGubun': tbInfo[i].children[1].textContent
						,'Descr': tbInfo[i].children[2].textContent
						,'ioType': tbInfo[i].children[3].textContent
						,'address': tbInfo[i].children[4].textContent
						,'ioBit': tbInfo[i].children[5].textContent
						,'minVal': tbInfo[i].children[6].textContent
						,'maxVal': tbInfo[i].children[7].textContent
						,'saveCoreChk': tbInfo[i].children[8].textContent
						,'iSeq': tbInfo[i].children[9].textContent	
					};
					
					targetData = {
						'hogi': tbInfo[i-1].children[0].textContent
						,'xyGubun': tbInfo[i-1].children[1].textContent
						,'Descr': tbInfo[i-1].children[2].textContent
						,'ioType': tbInfo[i-1].children[3].textContent
						,'address': tbInfo[i-1].children[4].textContent
						,'ioBit': tbInfo[i-1].children[5].textContent
						,'minVal': tbInfo[i-1].children[6].textContent
						,'maxVal': tbInfo[i-1].children[7].textContent
						,'saveCoreChk': tbInfo[i-1].children[8].textContent
						,'iSeq': tbInfo[i-1].children[9].textContent	
					};
					trigger = true;
				}
				selectedID = trigger ? curData.iSeq+'_'+curData.hogi : selectedID;
			}
		}

		if( trigger ) setMovedItem(pos,pos-1,tbInfo,curData,targetData);
	}
	
	function cmdDown_click() {
		var tbInfo = $("#lvIolistTable")[0].children;
		var cnt = 0;
		
		for( var i=0;i<tbInfo.length;i++ ) {
			if( tbInfo[i].id.indexOf('tr') > -1 ) {
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
		
		for( var i=0;i<tbInfo.length;i++ ) {
			if( tbInfo[i].id == 'tr'+selectedIseq+'_'+selectedHogi ) {
				if( cnt >= 1 && i < cnt-1 ) {
					pos = i;
					curData = {
						'hogi': tbInfo[i].children[0].textContent
						,'xyGubun': tbInfo[i].children[1].textContent
						,'Descr': tbInfo[i].children[2].textContent
						,'ioType': tbInfo[i].children[3].textContent
						,'address': tbInfo[i].children[4].textContent
						,'ioBit': tbInfo[i].children[5].textContent
						,'minVal': tbInfo[i].children[6].textContent
						,'maxVal': tbInfo[i].children[7].textContent
						,'saveCoreChk': tbInfo[i].children[8].textContent
						,'iSeq': tbInfo[i].children[9].textContent	
					};
					
					targetData = {
						'hogi': tbInfo[i+1].children[0].textContent
						,'xyGubun': tbInfo[i+1].children[1].textContent
						,'Descr': tbInfo[i+1].children[2].textContent
						,'ioType': tbInfo[i+1].children[3].textContent
						,'address': tbInfo[i+1].children[4].textContent
						,'ioBit': tbInfo[i+1].children[5].textContent
						,'minVal': tbInfo[i+1].children[6].textContent
						,'maxVal': tbInfo[i+1].children[7].textContent
						,'saveCoreChk': tbInfo[i+1].children[8].textContent
						,'iSeq': tbInfo[i+1].children[9].textContent	
					};
					trigger = true;
				}
				selectedID = trigger ? curData.iSeq+'_'+curData.hogi : selectedID;
			}
		}
		
		if( trigger ) setMovedItem(pos,pos+1,tbInfo,curData,targetData);
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
		comAjax.setUrl('/dcc/alarm/tagFind');
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
	
	/*function cmdFind_click(bAll) {
		var tmp = bAll;
		if( bAll == '2' ) {
			bAll = 0;
		} else {
			if( $.trim($("#findData").val()) == '' ) {
				alert('검색어를 입력하십시오.');
				return;
			}
		}
		
		var comAjax = new ComAjax("tagSearchForm");
		comAjax.setUrl("/dcc/alarm/tagFind");
		if( tmp == '2' ) {
			comAjax.addParam("tagHogi", '5');
		} else {
			comAjax.addParam("tagHogi", $("#cboTagHogi option:selected").val());
		}
		comAjax.addParam("tagIOType", $("#cboTagIOType option:selected").val());
		comAjax.addParam("bAll", bAll+'');
		//comAjax.addParam("findData", $.trim($("#findData").val()) );
		//comAjax.addParam("chkOpt1", $("input:checkbox[id='chkOpt1']").is(":checked") ? "1" : "0");
		//comAjax.addParam("chkOpt2", $("input:checkbox[id='chkOpt2']").is(":checked") ? "1" : "0");
		comAjax.setCallback("mbr_tagSearchCallback");
		comAjax.ajax();
	}*/
	
	function toCSV() {
		var comSubmit = new ComSubmit("earlyWarningFrm");
		comSubmit.setUrl("/dcc/alarm/ewExcelExport");
		comSubmit.submit();
	}
	
	function setTimer(num){
		pageChange(1);
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
				<h3>조기경보</h3>
				<div class="bc"><span>DCC</span><span>Alarm</span><strong>조기경보</strong></div>
			</div>
			<!-- //page_title -->
			<!-- list_wrap -->
			<div class="list_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" id="setFrmIO" onclick="openModal('modal_1');">변수설정</a></li>
                        <li><a href="#none" onclick="javascript:toCSV();">엑셀로 저장</a></li>
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
				<div class="list_head">
					<div class="list_info">
						<form id="earlyWarningFrm" name=earlyWarningFrm">
							<input type = "hidden" id="sGrpID" name="sGrpID" value="${UserInfo.id}">
							<input type = "hidden" id="sUGrpNo" name="sUGrpNo" value="1">
							<input type = "hidden" id="sMenuNo" name="sMenuNo" value = "65">
							<input type = "hidden" id="sDive" name="sDive" value = "D">
							<input type = "hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi}">
							<input type = "hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun}">
						</form>
                        <div class="fx_legend">
                            <ul>
                                <li class="low">Low</li>
                                <li class="high">High</li>
                            </ul>
                        </div>
					</div>
					<div id="btnBody" class="button">
					<c:if test="${tagSize >= 25 and BaseSearch.pageNum ne '2'}">
						<a class="btn_list primary" id="pageNo1" name="pageNo1" href="javascript:pageChange(2)">다음</a>
					</c:if>
					<c:if test="${BaseSearch.pageNum eq '2'}">
						<a class="btn_list primary" id="pageNo2" name="pageNo2" href="javascript:pageChange(1)">이전</a>
					</c:if>
					</div>
				</div>
				<!-- //list_head -->                
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="40px"/>
                        <col />
                        <col width="60px"/>
                        <col width="80px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="140px"/>
                        <col width="280px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>DESCRIPTION</th>
                            <th>TYPE</th>
                            <th>ADDR</th>
                            <th>MIN</th>
                            <th>경보 LOW</th>
                            <th>경보 HIGH</th>
                            <th>MAX</th>
                            <th>VALUE</th>
                        </tr>
                    </thead>
                    <tbody id="tagDccInfoList" name="tagDccInfoList">
                    	<c:forEach var="tagDccInfo" items="${DccTagList}" varStatus="status">
                        <tr>
                            <td class="tc">${tagDccInfo.rowNum}</td>
                            <td class="tc">${tagDccInfo.Descr}</td>
                            <td class="tc">${tagDccInfo.IOTYPE}</td>
                            <c:choose>
                            	<c:when test="${tagDccInfo.IOTYPE eq 'DI' or tagDccInfo.IOTYPE eq 'DO' }">
	                            	<td class="tc">${tagDccInfo.ADDRESS} : ${tagDccInfo.IOBIT}</td>
	                            </c:when>
	                            <c:otherwise>
                           			<td class="tc">${tagDccInfo.hogi}${tagDccInfo.xygubun}${tagDccInfo.ADDRESS}</td>
                           		</c:otherwise>
                            </c:choose>
                            <td class="tc"><fmt:formatNumber type="number" pattern="#.####" value ="${tagDccInfo.ELow}"/></td>
                            <td class="tc"><fmt:formatNumber type="number" pattern="#.####" value ="${tagDccInfo.MinVal}"/></td>
                            <td class="tc"><fmt:formatNumber type="number" pattern="#.####" value ="${tagDccInfo.MaxVal}"/></td>
                            <td class="tc"><fmt:formatNumber type="number" pattern="#.####" value ="${tagDccInfo.EHigh}"/></td>
                            <td class="tc" style="background:${tagDccInfo.BackColor}"><fmt:formatNumber type="number" pattern="#.####" value ="${tagDccInfo.Value}"/>&nbsp;${tagDccInfo.Unit}</td>
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