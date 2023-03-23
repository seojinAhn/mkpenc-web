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
<script type="text/javascript" src="<c:url value="/resources/js/tip.js" />" charset="utf-8"></script>
<script type="text/javascript">
	// combobox definiton -> createSelect function
	var nList=["0:Commssion","1:Not Commission"];
	var AITypeList=["0:None",
				"1:High",
				"2:Low",
				"3:High/Low",
				"4:High DTAB",
				"5:Low DTAB",
				"6:High/Low DTAB",
				"7:High/Very High",
				"8:Low/Very Low",
				"9:Irrational"];
	var CITypeList=["0:Alarm on Opening",
				"1:Alarm on Closing"];
	var AIPrioList=["0:Printer only","1:Minor","2:Safety","3:Major"];
	var CIPrioList=["0:Undef","1:Minor","2:Safety","3:Major"];
	var crList=["0:None","1:Conditioned"];
	var AIGrpList=["0:None",
				"1:Reactor and PHT",
				"2:Turbine and boilers",
				"3:Safety",
				"4:Electrical",
				"5:Auxiliaries"];
	var CIGrpList=["0:None",
				"1:Reactor and PHT",
				"2:SG/Turbine",
				"3:Safety",
				"4:Electrical",
				"5:Auxiliaries"];
	var trList=["0:Seconds","1:Milliseconds"];
	var wibaList=["0:OUT","1:IN"];
	var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
	var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

	function sendPage(type){
		if( type == 0 ) {
			var iHogiVal = $("#iHogi option:selected").val();
			var	comSubmit	=	new ComSubmit("iolistForm");
			comSubmit.setUrl("/dcc/tip/iolist");
			comSubmit.addParam("iHogi",iHogiVal);
			//comSubmit.addParam("xyGubun",$("input[name='xyGubun']:checked").val());
			comSubmit.addParam("ioType",$("#ioType option:selected").val());
			if( $("#address").val().includes('-') ) {
				var transAddress = $("#address").val().split("\-");
				comSubmit.addParam("address",transAddress[0]);
				comSubmit.addParam("address2",transAddress[1]);
				comSubmit.addParam("addressType","dash");
			} else if( $("#address").val().includes(',') ) {
				var transAddress = $("#address").val();//.replace(/,/gi,"','");
				console.log(transAddress);
				comSubmit.addParam("address",transAddress);
				comSubmit.addParam("addressType","comma");
			} else {
				comSubmit.addParam("address",$("#address").val());
				comSubmit.addParam("addressType","none");
			}
			comSubmit.addParam("searchKey_1",$("#searchKey_1").val());
			comSubmit.addParam("searchWord_1",$("#searchWord_1").val());
			comSubmit.addParam("searchKey_2",$("#searchKey_2").val());
			comSubmit.addParam("searchWord_2",$("#searchWord_2").val());
			comSubmit.addParam("searchKey_3",$("#searchKey_3").val());
			comSubmit.addParam("searchWord_3",$("#searchWord_3").val());
			comSubmit.addParam("ioBit",$("#tIoBit").val());
			comSubmit.addParam("hogiHeader",iHogiVal);
			if( $("#xyGubunX").val() == "X" ) {
				comSubmit.addParam("xyHeader",$("#xyGubunX").val());
			} else {
				comSubmit.addParam("xyHeader",$("#xyGubunY").val());
			}
			comSubmit.submit();
		} else if( type == 1 ) {
			var	comSubmit	=	new ComSubmit("iolistForm");
			comSubmit.setUrl("/dcc/tip/iolist");
			comSubmit.addParam("hogiHeader",hogiHeader);
			comSubmit.addParam("xyHeader",xyHeader);
			comSubmit.submit();
		}
	}
	
	function isEmpty(str) {
		if( str == "undefined" || str == null || str == "" ) {
			return true;
		} else {
			return false;
		}
	}
	
	function isValidAddr(address) {
		var regexNumeric = /^[0-9]+$/gi;
		var regexDash = /^[0-9]+[\-]*[0-9]+$/gi;
		var regexComma = /^[0-9]+(,[0-9]+)+$/gi;
		
		if ( regexNumeric.test(address) ) {
			return 0;
		} else if( regexComma.test(address) && regexDash.test(address) ) {
			return 1;	
		} else if ( !regexComma.test(address) && regexDash.test(address) ) {
			var transAddress = $("#address").val().split("\-");
			if( transAddress[0] > transAddress[1] ) {
				return 4;
			}
			return 2;
		} else if ( regexComma.test(address) && !regexDash.test(address) ) {
			return 3;
		} else if ( !regexComma.test(address) && !regexDash.test(address) ) {
			return 4;
		}
	}
	
	function createSelect(id,list) {
		if( id == "type" ) {
			$("#tType").empty();
			//$("#tType").append( '<option></option>' );
			for( var i=0;i<list.length;i++ ){
				$("#tType").append( '<option value='+list[i].split(":")[0]+'>'+list[i].split(":")[1]+'</option>');
			}
		} else if( id == "tr" ) {
			$("#tTr").empty();
			//$("#tType").append( '<option></option>' );
			for( var i=0;i<list.length;i++ ){
				$("#tTr").append( '<option value='+list[i].split(":")[0]+'>'+list[i].split(":")[1]+'</option>');
			}
		} else if( id == "cr" ) {
			$("#tCr").empty();
			//$("#tType").append( '<option></option>' );
			for( var i=0;i<list.length;i++ ){
				$("#tCr").append( '<option value='+list[i].split(":")[0]+'>'+list[i].split(":")[1]+'</option>');
			}
		} else if( id == "group" ) {
			$("#tGroup").empty();
			//$("#tType").append( '<option></option>' );
			for( var i=0;i<list.length;i++ ){
				$("#tGroup").append( '<option value='+list[i].split(":")[0]+'>'+list[i].split(":")[1]+'</option>');
			}
		} else if( id == "n" ) {
			$("#tN").empty();
			//$("#tType").append( '<option></option>' );
			for( var i=0;i<list.length;i++ ){
				$("#tN").append( '<option value='+list[i].split(":")[0]+'>'+list[i].split(":")[1]+'</option>');
			}
		} else if( id == "prio" ) {
			$("#tPriority").empty();
			//$("#tType").append( '<option></option>' );
			for( var i=0;i<list.length;i++ ){
				$("#tPriority").append( '<option value='+list[i].split(":")[0]+'>'+list[i].split(":")[1]+'</option>');
			}
		} else if( id == "wiba" ) {
			$("#tWba").empty();
			//$("#tType").append( '<option></option>' );
			for( var i=0;i<list.length;i++ ){
				$("#tWba").append( '<option value='+list[i].split(":")[0]+'>'+list[i].split(":")[1]+'</option>');
			}
		}
	}
	
	function excelExport(){
		if (confirm("검색 조건으로 파일을 다운로드 합니다..!!")) {
			var	comSubmit	=	new ComSubmit("iolistForm");
			comSubmit.setUrl("/dcc/tip/iolistExcelExport");
			comSubmit.submit();
		}else {
			alert("선택한 파일의 다운로드를 취소 합니다..!!");
		}
	}
	
	function initSearch(type) {
		$("#address").val('');
		$("#searchKey_1 option:eq(0)").prop("selected",true);
		$("#searchKey_2 option:eq(0)").prop("selected",true);
		$("#searchKey_3 option:eq(0)").prop("selected",true);
		$("#searchWord_1").val('');
		$("#searchWord_2").val('');
		$("#searchWord_3").val('');
		
		$("#tAddress").val("");
		$("#tRev").val("");
		$("#tType").val("");
		$("#tEqu").val("");
		$("#tDescr").val("");
		$("#tGroup").val("");
		$("#tBscal").val("");
		$("#tMessage").val("");
		$("#tWindows").val("");
		$("#tWba").val("");
		$("#tDrawing").val("");
		$("#tLoopName").val("");
		$("#tPriority").val("");
		$("#tDevice").val("");
		$("#tUnit").val("");
		$("#tLimit1").val("");
		$("#tPurpose").val("");
		$("#tVlow").val("");
		$("#tElow").val("");
		$("#tLimit2").val("");
		$("#tProgram").val("");
		$("#tConv").val("");
		$("#tRtd").val("");
		$("#tJ").val("");
		$("#tIseq").val("");
		$("#tIhogi").val("");
		$("#tXygubun").val("");
		$("#tIotype").val("");
		$("#tTr").val("");
		$("#tCr").val("");
		$("#tIoBit").val("");
		$("#tCom1").val("");
		$("#tCom2").val("");
		$("#tN").val("");
		$("#tCondition").val("");
	}
	
	function convertNum(type,id,str) {
		if( id == 'type' ) {
			if( type == 'AI' ) {
				if( str == 'None' ) return 0;
				if( str == 'High' ) return 1;
				if( str == 'Low' ) return 2;
				if( str == 'High/Low' ) return 3;
				if( str == 'High DTAB' ) return 4;
				if( str == 'Low DTAB' ) return 5;
				if( str == 'High/Low DTAB' ) return 6;
				if( str == 'High/Very High' ) return 7;
				if( str == 'Low/Very Low' ) return 8;
				if( str == 'Irrational' ) return 9;
			} else if( type == 'CI' ) {
				if( str == 'Alarm on Opening' ) return 0;
				if( str == 'Alarm on Closing' ) return 1;
			}
		} else if( id == 'n' ) {
			if( str == 'Commssion' ) return 0;
			if( str == 'Not Commission' ) return 1;
		} else if( id == 'prio' ) {
			if( type == 'AI' ) {
				if( str == 'Printer only' ) return 0;
			} else if( type == 'CI' ) {
				if( str == 'Undef' ) return 0;
			}
			if( str == 'Minor' ) return 1;
			if( str == 'Safety' ) return 2;
			if( str == 'Major' ) return 3;
		} else if( id == 'cr' ) {
			if( str == 'None' ) return 0;
			if( str == 'Conditioned' ) return 1;
		} else if( id == 'tr' ) {
			if( str == 'Seconds' ) return 0;
			if( str == 'Milliseconds' ) return 1;
		} else if( id == 'grp' ) {
			if( str == 'None' ) return 0;
			if( str == 'Reactor and PHT' ) return 1;
			if( str == 'Safety' ) return 3;
			if( str == 'Electrical' ) return 4;
			if( str == 'Auxiliaries' ) return 5;
			if( type == 'AI' ) {
				if( str == 'Turbine and boilers' ) return 2;
			} else if( type == 'CI' ) {
				if( str == 'SG/Turbine' ) return 2;
			}
		} else if( id == 'wiba' ) {
			if( str == 'OUT' ) return 0;
			if( str == 'IN' ) return 1;
		}
	}
	
	$(function() {
		if( $("#hogiHeader4").attr("class") == 'current' && $("#hogiHeader4").attr("class") != 'undefined' && $("#hogiHeader4").attr("class") != '') {
			hogiHeader = "4";
			$("#iHogi").val("4").prop("selected",true);
		} else {
			hogiHeader = "3";
			$("#iHogi").val("3").prop("selected",true);
		}
		
		if( $("input:checkbox[id='xy']").is(":checked") ) {
			xyHeader = "Y";
			$("#xyGubunX").prop("checked",false);
			$("#xyGubunY").prop("checked",true);
			$("#xyGubunX").val("");
			$("#xyGubunY").val("Y");
			$("#FTAI").css("display","none");
			$("#FTDT").css("display","none");
		} else {
			xyHeader = "X";
			$("#xyGubunX").prop("checked",true);
			$("#xyGubunY").prop("checked",false);
			$("#xyGubunX").val("X");
			$("#xyGubunY").val("");
			$("#FTAI").css("display","");
			$("#FTDT").css("display","");
		}
		
		if($("#ioType option:selected").val() == "AI" || $("#ioType option:selected").val() == "FTAI" || $("#ioType option:selected").val() == "") {
			createSelect("n",nList);
			createSelect("type",AITypeList);
			createSelect("prio",AIPrioList);
			createSelect("cr",crList);
			createSelect("group",AIGrpList);
		} else if($("#ioType option:selected").val() == "CI") {
			createSelect("tr",trList);
			createSelect("type",CITypeList);
			createSelect("prio",CIPrioList);
			createSelect("cr",crList);
			createSelect("group",CIGrpList);
		}

		if($("#ioType option:selected").val() != "DT" && $("#ioType option:selected").val() != "FTDT") {
			createSelect("wiba",wibaList);
		}
		
		$(document.body).delegate('#hogiHeader3', 'click', function() {
			hogiHeader = "3";
			sendPage(1);
		});
		$(document.body).delegate('#hogiHeader4', 'click', function() {
			hogiHeader = "4";
			sendPage(1);
		});
		$(document.body).delegate('#xy', 'click', function() {
			if( $("input:checkbox[id='xy']").is(":checked") ) {
				xyHeader = "Y";
				$("#xyGubunY").prop("checked",true);
				$("#xyGubunX").prop("checked",false);
				$("#xyGubunY").val("Y");
				$("#xyGubunX").val("");
				$("#FTAI").css("display","none");
				$("#FTDT").css("display","none");
			} else {
				xyHeader = "X";
				$("#xyGubunX").prop("checked",true);
				$("#xyGubunY").prop("checked",false);
				$("#xyGubunY").val("");
				$("#xyGubunX").val("X");
				$("#FTAI").css("display","");
				$("#FTDT").css("display","");
			}
			sendPage(1);
		});
		$(document.body).delegate('#xyGubunX', 'click', function() {
			$("input:checkbox[id='xy']").prop("checked",false);
			$("#xyGubunX").val("X");
			$("#xyGubunY").val("");
			$("#FTAI").css("display","");
			$("#FTDT").css("display","");
		});
		$(document.body).delegate('#xyGubunY', 'click', function() {
			$("input:checkbox[id='xy']").prop("checked",true);
			$("#xyGubunX").val("");
			$("#xyGubunY").val("Y");
			$("#FTAI").css("display","none");
			$("#FTDT").css("display","none");
		});
		$(document.body).delegate('#dccIolistTable tr', 'click', function() {
			if(this.id != 'itemHeaders') {
				if( $("#ioType option:selected").val() == "AI" || $("#ioType option:selected").val() == "FTAI" ) {
					$("#tAddress").val($(this).children().eq(0).text());
					$("#tRev").val($(this).children().eq(3).text());
					$("#tType").val(convertNum('AI','type',$(this).children().eq(13).text()));
					$("#tEqu").val($(this).children().eq(16).text());
					$("#tDescr").val($(this).children().eq(1).text());
					$("#tGroup").val(convertNum('AI','grp',$(this).children().eq(14).text()));
					$("#tBscal").val($(this).children().eq(17).text());
					$("#tMessage").val($(this).children().eq(2).text());
					$("#tWindows").val($(this).children().eq(18).text());
					$("#tWba").val(convertNum('AI','wiba',$(this).children().eq(19).text()));
					$("#tDrawing").val($(this).children().eq(4).text());
					$("#tLoopName").val($(this).children().eq(5).text());
					$("#tPriority").val(convertNum('AI','prio',$(this).children().eq(15).text()));
					$("#tDevice").val($(this).children().eq(6).text());
					$("#tUnit").val($(this).children().eq(20).text());
					$("#tLimit1").val($(this).children().eq(21).text());
					$("#tPurpose").val($(this).children().eq(23).text());
					$("#tVlow").val($(this).children().eq(8).text());
					$("#tElow").val($(this).children().eq(10).text());
					$("#tVhigh").val($(this).children().eq(9).text());
					$("#tEhigh").val($(this).children().eq(11).text());
					$("#tLimit2").val($(this).children().eq(22).text());
					$("#tProgram").val($(this).children().eq(24).text());
					$("#tConv").val($(this).children().eq(12).text());
					$("#tRtd").val($(this).children().eq(25).text());
					$("#tJ").val($(this).children().eq(26).text());
					$("#tProcess").val($(this).children().eq(32).text());
					$("#tReason").val($(this).children().eq(30).text());
					$("#tDone").val($(this).children().eq(31).text());
					$("#tCr").val(convertNum('AI','cr',$(this).children().eq(34).text()));
					$("#tN").val(convertNum('AI','n',$(this).children().eq(38).text()));
				} else if( $("#ioType option:selected").val() == "AO" ) {
					$("#tAddress").val($(this).children().eq(0).text());
					$("#tRev").val($(this).children().eq(3).text());
					$("#tDescr").val($(this).children().eq(1).text());
					$("#tWba").val(convertNum('AI','wiba',$(this).children().eq(19).text()));
					$("#tDrawing").val($(this).children().eq(4).text());
					$("#tDevice").val($(this).children().eq(6).text());
					$("#tPurpose").val($(this).children().eq(23).text());
					$("#tCtrlName").val($(this).children().eq(40).text());
					$("#tInterlock").val($(this).children().eq(41).text());
					$("#tFeedback").val($(this).children().eq(42).text());
				} else if( $("#ioType option:selected").val() == "CI" ) {
					$("#tAddress").val($(this).children().eq(0).text());
					$("#tRev").val($(this).children().eq(3).text());
					$("#tType").val(convertNum('CI','type',$(this).children().eq(13).text()));
					$("#tGroup").val(convertNum('CI','grp',$(this).children().eq(14).text()));
					$("#tMessage").val($(this).children().eq(2).text());
					$("#tWba").val(convertNum('AI','wiba',$(this).children().eq(19).text()));
					$("#tDrawing").val($(this).children().eq(4).text());
					$("#tPriority").val(convertNum('CI','prio',$(this).children().eq(15).text()));
					$("#tDevice").val($(this).children().eq(6).text());
					$("#tProcess").val($(this).children().eq(32).text());
					$("#tReason").val($(this).children().eq(30).text());
					$("#tDone").val($(this).children().eq(31).text());
					$("#tTr").val(convertNum('CI','tr',$(this).children().eq(33).text()));
					$("#tCr").val(convertNum('CI','cr',$(this).children().eq(34).text()));
					$("#tCondition").val($(this).children().eq(39).text());
				} else if( $("#ioType option:selected").val() == "DI" ) {
					$("#tAddress").val($(this).children().eq(0).text());
					$("#tRev").val($(this).children().eq(3).text());
					$("#tDescr").val($(this).children().eq(1).text());
					$("#tWba").val(convertNum('AI','wiba',$(this).children().eq(19).text()));
					$("#tDrawing").val($(this).children().eq(4).text());
					$("#tDevice").val($(this).children().eq(6).text());
					$("#tPurpose").val($(this).children().eq(23).text());
					$("#tIoBit").val($(this).children().eq(35).text());
					$("#tCtrlName").val($(this).children().eq(40).text());
					$("#tInterlock").val($(this).children().eq(41).text());
					$("#tIndicate").val($(this).children().eq(44).text());
				} else if( $("#ioType option:selected").val() == "DO" ) {
					$("#tAddress").val($(this).children().eq(0).text());
					$("#tRev").val($(this).children().eq(3).text());
					$("#tDescr").val($(this).children().eq(1).text());
					$("#tWba").val(convertNum('AI','wiba',$(this).children().eq(19).text()));
					$("#tDrawing").val($(this).children().eq(4).text());
					$("#tDevice").val($(this).children().eq(6).text());
					$("#tPurpose").val($(this).children().eq(23).text());
					$("#tIoBit").val($(this).children().eq(35).text());
					$("#tCtrlName").val($(this).children().eq(40).text());
					$("#tInterlock").val($(this).children().eq(41).text());
				} else if( $("#ioType option:selected").val() == "DT" || $("#ioType option:selected").val() == "FTDT" ) {
					$("#tAddress").val($(this).children().eq(0).text());
					$("#tDescr").val($(this).children().eq(1).text());
					$("#tLoopName").val($(this).children().eq(5).text());
					$("#tProgram").val($(this).children().eq(24).text());
				}
				$("#tIseq").val($(this).children().eq(27).text());
				$("#tIhogi").val($(this).children().eq(28).text());
				$("#tXygubun").val($(this).children().eq(7).text());
				$("#tIotype").val($(this).children().eq(29).text());
			}
		});
		
		$("#iolistSearch").click(function(){
			 sendPage(0);
		});
		
		$("#initSearch").click(function(){
			initSearch(0);
		});
		
		/* $("#iolistModify").click(function(){
			
			console.log($("#tType option:selected").val());
			
			//if(!inputVaildationCheck()){
			//	return;
			//}
			
			if (confirm("I/O List를 저장 합니다..!!")) {
				var	comSubmit	=	new ComSubmit("iolistModifyForm");
				comSubmit.setUrl("/dcc/tip/iolistModify");
				if( !isEmpty($("#tIseq").val()) ) comSubmit.addParam("iSeq",$("#tIseq").val());
				if( !isEmpty($("#tType option:selected").val()) && $("#tType option:selected").val() != 'undefined') comSubmit.addParam("type",$("#tType option:selected").val());
				if( !isEmpty($("#tAddress").val()) ) comSubmit.addParam("address",$("#tAddress").val());
				if( !isEmpty($("#tRev").val()) ) comSubmit.addParam("rev",$("#tRev").val());
				if( !isEmpty($("#tEqu").val()) ) comSubmit.addParam("equ",$("#tEqu").val());
				if( !isEmpty($("#tDescr").val()) ) comSubmit.addParam("descr",$("#tDescr").val());
				if( !isEmpty($("#tGroup option:selected").val()) && $("#tGroup option:selected").val() != 'undefined' ) comSubmit.addParam("ioGroup",$("#tGroup option:selected").val());
				if( !isEmpty($("#tBscal").val()) ) comSubmit.addParam("bscal",$("#tBscal").val());
				if( !isEmpty($("#tMessage").val()) ) comSubmit.addParam("message",$("#tMessage").val());
				if( !isEmpty($("#tWindows").val()) ) comSubmit.addParam("winodw",$("#tWindows").val());
				if( !isEmpty($("#tWba").val()) ) comSubmit.addParam("wiba",$("#tWba").val());
				if( !isEmpty($("#tDrawing").val()) ) comSubmit.addParam("drawing",$("#tDrawing").val());
				if( !isEmpty($("#tLoopName").val()) ) comSubmit.addParam("loopName",$("#tLoopName").val());
				if( !isEmpty($("#tPriority option:selected").val()) && $("#tPriority option:selected").val() != 'undefined' ) comSubmit.addParam("priority",$("#tPriority option:selected").val());
				if( !isEmpty($("#tDevice").val()) ) comSubmit.addParam("device",$("#tDevice").val());
				if( !isEmpty($("#tLimit1").val()) ) comSubmit.addParam("limit1",$("#tLimit1").val());
				if( !isEmpty($("#tPurpose").val()) ) comSubmit.addParam("purpose",$("#tPurpose").val());
				if( !isEmpty($("#tVlow").val()) ) comSubmit.addParam("vLow",$("#tVlow").val());
				if( !isEmpty($("#tElow").val()) ) comSubmit.addParam("eLow",$("#tElow").val());
				if( !isEmpty($("#tVHigh").val()) ) comSubmit.addParam("vHigh",$("#tVHigh").val());
				if( !isEmpty($("#tEHigh").val()) ) comSubmit.addParam("eHigh",$("#tEHigh").val());
				if( !isEmpty($("#tLimit2").val()) ) comSubmit.addParam("limit2",$("#tLimit2").val());
				if( !isEmpty($("#tProgram").val()) ) comSubmit.addParam("program",$("#tProgram").val());
				if( !isEmpty($("#tConv").val()) ) comSubmit.addParam("conv",$("#tConv").val());
				if( !isEmpty($("#tUnit").val()) ) comSubmit.addParam("unit",$("#tUnit").val());
				if( !isEmpty($("#tRtd").val()) ) comSubmit.addParam("rtd",$("#tRtd").val());
				if( !isEmpty($("#tJ").val()) ) comSubmit.addParam("j",$("#tJ").val());
				if( !isEmpty($("#tIhogi").val()) ) comSubmit.addParam("iHogi",$("#tIhogi").val());
				if( !isEmpty($("#tXygubun").val()) ) comSubmit.addParam("xyGubun",$("#tXygubun").val());
				if( !isEmpty($("#tIotype").val()) ) comSubmit.addParam("ioType",$("#tIotype").val());
				if( !isEmpty($("#tTr option:selected").val()) && $("#tTr option:selected").val() != 'undefined' ) comSubmit.addParam("tr",$("#tTr option:selected").val());
				if( !isEmpty($("#tCr option:selected").val()) && $("#tCr option:selected").val() != 'undefined' ) comSubmit.addParam("cr",$("#tCr option:selected").val());
				if( !isEmpty($("#tIoBit").val()) ) comSubmit.addParam("iobit",$("#tIoBit").val());
				if( !isEmpty($("#tCom1").val()) ) comSubmit.addParam("com1",$("#tCom1").val());
				if( !isEmpty($("#tCom2").val()) ) comSubmit.addParam("com2",$("#tCom2").val());
				if( !isEmpty($("#tN option:selected").val()) && $("#tN option:selected").val() != 'undefined' ) comSubmit.addParam("n",$("#tN option:selected").val());
				if( !isEmpty($("#tCondition").val()) ) comSubmit.addParam("condition",$("#tCondition").val());
				if( !isEmpty($("#tCtrlName").val()) ) comSubmit.addParam("ctrlName",$("#tCtrlName").val());
				if( !isEmpty($("#tInterlock").val()) ) comSubmit.addParam("interlock",$("#tInterlock").val());
				if( !isEmpty($("#tFeedback").val()) ) comSubmit.addParam("feedback",$("#tFeedback").val());
				if( !isEmpty($("#tAlarmCond").val()) ) comSubmit.addParam("alarmCond",$("#tAlarmCond").val());
				if( !isEmpty($("#tIndicate").val()) ) comSubmit.addParam("indicate",$("#tIndicate").val());
				if( !isEmpty($("#tProcess").val()) ) comSubmit.addParam("zText3",$("#tProcess").val());
				if( !isEmpty($("#tReason").val()) ) comSubmit.addParam("zText1",$("#tReason").val());
				if( !isEmpty($("#tDone").val()) ) comSubmit.addParam("zText2",$("#tDone").val());
				comSubmit.submit();
			}else {
				alert("I/O List 저장을 취소 합니다...!!");
			}
			
		}); */
		
		$("#iHogi").change(function(){;
	
			if($("#iHogi option:selected").val() == ""){
				$("#iHogi").val("");
			} else if( $("#iHogi option:selected").val() == "3" ){
				$("#hogiHeader3").attr("class","current");
				$("#hogiHeader4").attr("class","");
			} else if( $("#iHogi option:selected").val() == "4" ){
				$("#hogiHeader3").attr("class","");
				$("#hogiHeader4").attr("class","current");
			}
		});
		
		/*$("input[name='xyGubun']").change(function(){
	
			if($("input[name='xyGubun']:checked").val() == ""){
				console.log("NA");
				//$("input[name=sXY]");
			} else if($("input[name='xyGubun']:checked").val() == "X"){
				console.log("X");
				$("input:checkbox[id='xy']").prop("checked",false);
				$("#xyGubunX").val("X");
				$("#xyGubunY").val("");
				$("#FTAI").css("display","");
				$("#FTDT").css("display","");
			} else if($("input[name='xyGubun']:checked").val() == "Y"){
				console.log("Y");
				$("input:checkbox[id='xy']").prop("checked",true);
				$("#xyGubunX").val("");
				$("#xyGubunY").val("Y");
				$("#FTAI").css("display","none");
				$("#FTDT").css("display","none");
			}
		});*/
		
		$("#address").change(function() {
			
			if(isValidAddr($("#address").val()) == 1 || isValidAddr($("#address").val()) == 4) {
				alert('정상값을 입력하십시오....');
			};
		});
		
		$("#ioType").change(function(){
			
			if($("#ioType option:selected").val() == ""){
				$("#divAI").css("display","");
				$("#divAO").css("display","none");
				$("#divCI").css("display","none");
				$("#divDI").css("display","none");
				$("#divDT").css("display","none");
			} else if($("#ioType option:selected").val() == "AI"){
				$("#divAI").css("display","");
				$("#divAO").css("display","none");
				$("#divCI").css("display","none");
				$("#divDI").css("display","none");
				$("#divDT").css("display","none");
			} else if($("#ioType option:selected").val() == "AO"){
				$("#divAI").css("display","none");
				$("#divAO").css("display","");
				$("#divCI").css("display","none");
				$("#divDI").css("display","none");
				$("#divDT").css("display","none");
			} else if($("#ioType option:selected").val() == "CI"){
				$("#divAI").css("display","none");
				$("#divAO").css("display","none");
				$("#divCI").css("display","");
				$("#divDI").css("display","none");
				$("#divDT").css("display","none");
			} else if($("#ioType option:selected").val() == "DI"){
				$("#divAI").css("display","none");
				$("#divAO").css("display","none");
				$("#divCI").css("display","none");
				$("#divDI").css("display","");
				$("#divDT").css("display","none");
			} else if($("#ioType option:selected").val() == "DO"){
				$("#divAI").css("display","none");
				$("#divAO").css("display","none");
				$("#divCI").css("display","none");
				$("#divDI").css("display","");
				$("#divDT").css("display","none");
			} else if($("#ioType option:selected").val() == "DT"){
				$("#divAI").css("display","none");
				$("#divAO").css("display","none");
				$("#divCI").css("display","none");
				$("#divDI").css("display","none");
				$("#divDT").css("display","");
			} else if($("#ioType option:selected").val() == "FTAI"){
				$("#divAI").css("display","");
				$("#divAO").css("display","none");
				$("#divCI").css("display","none");
				$("#divDI").css("display","none");
				$("#divDT").css("display","none");
			} else if($("#ioType option:selected").val() == "FTDT"){
				$("#divAI").css("display","none");
				$("#divAO").css("display","none");
				$("#divCI").css("display","none");
				$("#divDI").css("display","none");
				$("#divDT").css("display","");
			}
			initSearch(1);
			sendPage();
		});
	});
	
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
				<h3>I/O LIST</h3>
				<div class="bc"><span>DCC</span><span>Tip</span><strong>I/O LIST</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
				<form id="iolistForm" name="iolistForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>호기선택</label>
                            <div class="fx_form_multi">
                                <select id="iHogi" style="width:90px">
									<c:if test="${BaseSearch.iHogi eq '3' or empty BaseSearch.iHogi}">
										<option value="3" selected>3호기</option>
									</c:if>
									<c:if test="${BaseSearch.iHogi ne '3' and not empty BaseSearch.iHogi}">
										<option value="3" >3호기</option>
									</c:if>
									<c:if test="${BaseSearch.iHogi eq '4'}">
										<option value="4" selected>4호기</option>
									</c:if>
									<c:if test="${BaseSearch.iHogi ne '4'}">
										<option value="4" >4호기</option>
									</c:if>
                                </select>
                                <div class="fx_form">
                                	<c:if test="${BaseSearch.xyGubun eq 'X' or empty BaseSearch.xyGubun}">
	                                    <label><input type="radio" id="xyGubunX" name="xyGubun" value="X" checked>X</label>
                                    </c:if>
                                	<c:if test="${BaseSearch.xyGubun ne 'X' and not empty BaseSearch.xyGubun}">
	                                    <label><input type="radio" id="xyGubunX" name="xyGubun" value="X">X</label>
                                    </c:if>
                                    <c:if test="${BaseSearch.xyGubun eq 'Y'}">
	                                    <label><input type="radio" id="xyGubunY" name="xyGubun" value="Y" checked>Y</label>
	                                </c:if>
                                    <c:if test="${BaseSearch.xyGubun ne 'Y'}">
	                                    <label><input type="radio" id="xyGubunY" name="xyGubun" value="Y">Y</label>
	                                </c:if>
                                </div>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>Acess Field</label>
							<select id="ioType">
								<c:if test="${BaseSearch.ioType eq 'AI' }">
									<option id="AI" value="AI" selected>Analog Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType ne 'AI' }">
									<option id="AI" value="AI">Analog Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType eq 'AO' }">
									<option id="AO" value="AO" selected>Analog Outputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType ne 'AO' }">
									<option id="AO" value="AO">Analog Outputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType eq 'CI' }">
									<option id="CI" value="CI" selected>Contact Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType ne 'CI' }">
									<option id="CI" value="CI">Contact Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType eq 'DI' }">
									<option id="DI" value="DI" selected>Digital Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType ne 'DI' }">
									<option id="DI" value="DI">Digital Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType eq 'DO' }">
									<option id="DO" value="DO" selected>Digital Outputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType ne 'DO' }">
									<option id="DO" value="DO">Digital Outputs</option>
								</c:if>
								<c:if test="${BaseSearch.ioType eq 'DT' }">
									<option id="DT" value="DT" selected>DTAB</option>
								</c:if>
								<c:if test="${BaseSearch.ioType ne 'DT' }">
									<option id="DT" value="DT">DTAB</option>
								</c:if>
								<c:if test="${BaseSearch.ioType eq 'FTAI' }">
									<option id="FTAI" value="FTAI" selected>FAST AI</option>
								</c:if>
								<c:if test="${BaseSearch.ioType ne 'FTAI' }">
									<option id="FTAI" value="FTAI">FAST AI</option>
								</c:if>
								<c:if test="${BaseSearch.ioType eq 'FTDT' }">
									<option id="FTDT" value="FTDT" selected>FAST DT</option>
								</c:if>
								<c:if test="${BaseSearch.ioType ne 'FTDT' }">
									<option id="FTDT" value="FTDT">FAST DT</option>
								</c:if>
							</select>
						</div>
						<div class="fx_srch_item">
							<label>Address</label>
                            <div class="fx_form">
                                <input id="address" type="text" value="${BaseSearch.address}">
                                <label>0-0</label>
                            </div>
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label class="label_select">
                                <select id="searchKey_1">
                                <c:forEach var="dccIoColumnInfo" items="${DccIoColumnList}">
                                	<c:if test="${BaseSearch.searchKey_1 eq dccIoColumnInfo.columnName}">
                                   	<option value="${dccIoColumnInfo.columnName}" selected>${dccIoColumnInfo.columnName}</option>
                                	</c:if>
                                	<c:if test="${BaseSearch.searchKey_1 ne dccIoColumnInfo.columnName}">
                                   	<option value="${dccIoColumnInfo.columnName}">${dccIoColumnInfo.columnName}</option>
                                	</c:if>
                                </c:forEach>
                                </select>
                            </label>
                            <input id="searchWord_1" type="text" value="${BaseSearch.searchWord_1}">
						</div>
						<div class="fx_srch_item">
							<label class="label_select">
                                <select id="searchKey_2">
                                <c:forEach var="dccIoColumnInfo" items="${DccIoColumnList}">
                                	<c:if test="${BaseSearch.searchKey_2 eq dccIoColumnInfo.columnName}">
                                   	<option value="${dccIoColumnInfo.columnName}" selected>${dccIoColumnInfo.columnName}</option>
                                	</c:if>
                                	<c:if test="${BaseSearch.searchKey_2 ne dccIoColumnInfo.columnName}">
                                   	<option value="${dccIoColumnInfo.columnName}">${dccIoColumnInfo.columnName}</option>
                                	</c:if>
                                </c:forEach>
                                </select>
                            </label>
                            <input id="searchWord_2" type="text" value="${BaseSearch.searchWord_2}">
						</div>
						<div class="fx_srch_item">
							<label class="label_select">
                                <select id="searchKey_3">
                                <c:forEach var="dccIoColumnInfo" items="${DccIoColumnList}">
                                	<c:if test="${BaseSearch.searchKey_3 eq dccIoColumnInfo.columnName}">
                                   	<option value="${dccIoColumnInfo.columnName}" selected>${dccIoColumnInfo.columnName}</option>
                                	</c:if>
                                	<c:if test="${BaseSearch.searchKey_3 ne dccIoColumnInfo.columnName}">
                                   	<option value="${dccIoColumnInfo.columnName}">${dccIoColumnInfo.columnName}</option>
                                	</c:if>
                                </c:forEach>
                                </select>
                            </label>
                            <input id="searchWord_3" type="text" value="${BaseSearch.searchWord_3}">
						</div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_reset" title="초기화" id="initSearch"></a>
					<a class="btn_srch" id="iolistSearch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->            
			<!-- list_wrap -->
			<div class="list_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_1');">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>${DccIolistList.size()}</strong></label>
					</div>
                    <!-- button -->
                    <div class="button">
                        <!-- <a class="btn_list primary" href="#none" id="iolistModify" name="iolistModify">저장</a>
                        <a class="btn_list excel_up" href="#none">엑셀일괄등록</a> -->
                        <a class="btn_list excel_down" href="javascript:excelExport()">엑셀다운로드</a>
                    </div>
                    <!-- button -->                      
				</div>
                <!-- //list_head -->
                <!-- list_table -->
                <c:if test="${BaseSearch.ioType eq 'AI' or BaseSearch.ioType eq 'FTAI' or BaseSearch.ioType eq null}">
                <div class="list_table_scroll" id="divAI">
                <table id="dccIolistTable" class="list_table">
                    <colgroup>
                        <col width="40px"/>
                        <col width="300px"/>
                        <col width="240px"/>
                        <col width="40px"/>
                        <col width="240px"/>
                        <col width="240px"/>
                        <col width="240px"/>
                        <col width="40px"/>
                        <col width="50px"/>
                        <col width="50px"/>
                        <col width="50px"/>
                        <col width="50px"/>
                        <col width="80px"/>
                        <col width="120px"/>
                        <col width="120px"/>
                        <col width="120px"/>
                    </colgroup>
                    <thead>
                        <tr id="itemHeaders">
                            <th>ADDR</th>
                            <th>DESCR</th>
                            <th>MESSAGE</th>
                            <th>REV</th>
                            <th>DRAWING</th>
                            <th>LOOPNAME</th>
                            <th>DEVICE</th>
                            <th>XYGUBUN</th>
                            <th>VLOW</th>
                            <th>VHIGH</th>
                            <th>ELOW</th>
                            <th>EHIGH</th>
                            <th>CONV</th>
                            <th>TYPE</th>
                            <th>IOGROUP</th>
                            <th>PRIORITY</th>
                        </tr>
                    </thead>
                    <tbody>
					<c:forEach var="dccIolistInfo" items="${DccIolistList}">
                    	<tr>
                            <td class="tc">${dccIolistInfo.address}</td>
                            <td class="tc">${dccIolistInfo.descr}</td>
                            <td class="tc">${dccIolistInfo.message}</td>
                            <td class="tc">${dccIolistInfo.rev}</td>
                            <td class="tc">${dccIolistInfo.drawing}</td>
                            <td class="tc">${dccIolistInfo.loopName}</td>
                            <td class="tc">${dccIolistInfo.device}</td>
                            <td class="tc">${dccIolistInfo.xyGubun}</td>
                            <td class="tc">${dccIolistInfo.vLow}</td>
                            <td class="tc">${dccIolistInfo.vHigh}</td>
                            <td class="tc">${dccIolistInfo.eLow}</td>                          
                            <td class="tc">${dccIolistInfo.eHigh}</td>
                            <td class="tc">${dccIolistInfo.conv}</td>
                            <td class="tc">${dccIolistInfo.type}</td>
                            <td class="tc">${dccIolistInfo.ioGroup}</td>
                            <td class="tc">${dccIolistInfo.priority}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.equ}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.bscal}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.window}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.wiba}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.unit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.purpose}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.program}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.rtd}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.j}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iSeq}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iHogi}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioType}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText3}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.tr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.cr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioBit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.n}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.condition}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ctrlName}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.interlock}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.feedback}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.alarmCond}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.indicate}</td>
                        </tr>
                    </c:forEach>
                    <c:set var="rowMax" value="5" />
                    <c:set var="itemCnt" value="${DccIolistList.size()}" />
                    <c:if test="${itemCnt < 5}">
                    <c:forEach var="i" begin="1" end="${rowMax-itemCnt}" step="1">
                    	<tr>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    	</tr>
                    </c:forEach>
                    </c:if>
                    </tbody>
                </table>
                </div>
                </c:if>
                <c:if test="${BaseSearch.ioType eq 'AO'}">
                <div class="list_table_scroll" id="divAO">
                <table id="dccIolistTable" class="list_table">
                    <colgroup>
                        <col width="40px"/>
                        <col width="300px"/>
                        <col width="40px"/>
                        <col width="240px"/>
                        <col width="240px"/>
                        <col width="60px"/>
                        <col width="60px"/>
                    </colgroup>
                    <thead>
                        <tr id="itemHeaders">
                            <th>ADDR</th>
                            <th>DESCR</th>
                            <th>REV</th>
                            <th>DRAWING</th>
                            <th>DEVICE</th>
                            <th>XYGUBUN</th>
                            <th>PURPOSE</th>
                        </tr>
                    </thead>
                    <tbody>
					<c:forEach var="dccIolistInfo" items="${DccIolistList}">
                    	<tr>
                            <td class="tc">${dccIolistInfo.address}</td>
                            <td class="tc">${dccIolistInfo.descr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.message}</td>
                            <td class="tc">${dccIolistInfo.rev}</td>                          
                            <td class="tc">${dccIolistInfo.drawing}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.loopName}</td>
                            <td class="tc">${dccIolistInfo.device}</td>
                            <td class="tc">${dccIolistInfo.xyGubun}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.vLow}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.vHigh}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.eLow}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.eHigh}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.conv}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.type}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioGroup}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.priority}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.equ}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.bscal}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.window}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.wiba}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.unit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit2}</td>
                            <td class="tc">${dccIolistInfo.purpose}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.program}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.rtd}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.j}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iSeq}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iHogi}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioType}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText3}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.tr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.cr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioBit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.n}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.condition}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ctrlName}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.interlock}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.feedback}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.alarmCond}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.indicate}</td>
                        </tr>
                    </c:forEach>
                    <c:set var="rowMax" value="5" />
                    <c:set var="itemCnt" value="${DccIolistList.size()}" />
                    <c:if test="${itemCnt < 5}">
                    <c:forEach var="i" begin="1" end="${rowMax-itemCnt}" step="1">
                    	<tr>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    	</tr>
                    </c:forEach>
                    </c:if>
                    </tbody>
                </table>
                </div>
                </c:if>
                <c:if test="${BaseSearch.ioType eq 'CI'}">
                <div class="list_table_scroll" id="divCI">
                <table id="dccIolistTable" class="list_table">
                    <colgroup>
                        <col width="40px"/>
                        <col width="240px"/>
                        <col width="240px"/>
                        <col width="240px"/>
                        <col width="120px"/>
                        <col width="120px"/>
                        <col width="120px"/>
                        <col width="100px"/>
                        <col width="80px"/>
                    </colgroup>
                    <thead>
                        <tr id="itemHeaders">
                            <th>ADDR</th>
                            <th>MESSAGE</th>
                            <th>DRAWING</th>
                            <th>DEVICE</th>
                            <th>TYPE</th>
                            <th>IOGROUP</th>
                            <th>PRIORITY</th>
                            <th>TR</th>
                            <th>CR</th>
                        </tr>
                    </thead>
                    <tbody>
					<c:forEach var="dccIolistInfo" items="${DccIolistList}">
                    	<tr>
                            <td class="tc">${dccIolistInfo.address}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.descr}</td>
                            <td class="tc">${dccIolistInfo.message}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.rev}</td>                          
                            <td class="tc">${dccIolistInfo.drawing}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.loopName}</td>
                            <td class="tc">${dccIolistInfo.device}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.xyGubun}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.vLow}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.vHigh}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.eLow}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.eHigh}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.conv}</td>
                            <td class="tc">${dccIolistInfo.type}</td>
                            <td class="tc">${dccIolistInfo.ioGroup}</td>
                            <td class="tc">${dccIolistInfo.priority}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.equ}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.bscal}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.window}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.wiba}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.unit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.purpose}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.program}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.rtd}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.j}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iSeq}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iHogi}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioType}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText3}</td>
                            <td class="tc">${dccIolistInfo.tr}</td>
                            <td class="tc">${dccIolistInfo.cr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioBit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.n}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.condition}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ctrlName}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.interlock}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.feedback}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.alarmCond}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.indicate}</td>
                        </tr>
                    </c:forEach>
                    <c:set var="rowMax" value="5" />
                    <c:set var="itemCnt" value="${DccIolistList.size()}" />
                    <c:if test="${itemCnt < 5}">
                    <c:forEach var="i" begin="1" end="${rowMax-itemCnt}" step="1">
                    	<tr>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    	</tr>
                    </c:forEach>
                    </c:if>
                    </tbody>
                </table>
                </div>
                </c:if>
                <c:if test="${BaseSearch.ioType eq 'DI' or BaseSearch.ioType eq 'DO'}">
                <div class="list_table_scroll" id="divDI">
                <table id="dccIolistTable" class="list_table">
                    <colgroup>
                        <col width="40px"/>
                        <col width="300px"/>
                        <col width="40px"/>
                        <col width="240px"/>
                        <col width="240px"/>
                        <col width="40px"/>
                        <col width="40px"/>
                    </colgroup>
                    <thead>
                        <tr id="itemHeaders">
                            <th>ADDR</th>
                            <th>DESCR</th>
                            <th>REV</th>
                            <th>DRAWING</th>
                            <th>DEVICE</th>
                            <th>XYGUBUN</th>
                            <th>IOBIT</th>
                        </tr>
                    </thead>
                    <tbody>
					<c:forEach var="dccIolistInfo" items="${DccIolistList}">
                    	<tr>
                            <td class="tc">${dccIolistInfo.address}</td>
                            <td class="tc">${dccIolistInfo.descr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.message}</td>
                            <td class="tc">${dccIolistInfo.rev}</td>                          
                            <td class="tc">${dccIolistInfo.drawing}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.loopName}</td>
                            <td class="tc">${dccIolistInfo.device}</td>
                            <td class="tc">${dccIolistInfo.xyGubun}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.vLow}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.vHigh}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.eLow}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.eHigh}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.conv}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.type}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioGroup}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.priority}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.equ}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.bscal}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.window}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.wiba}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.unit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.purpose}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.program}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.rtd}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.j}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iSeq}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iHogi}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioType}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText3}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.tr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.cr}</td>
                            <td class="tc">${dccIolistInfo.ioBit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.n}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.condition}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ctrlName}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.interlock}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.feedback}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.alarmCond}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.indicate}</td>
                        </tr>
                    </c:forEach>
                    <c:set var="rowMax" value="5" />
                    <c:set var="itemCnt" value="${DccIolistList.size()}" />
                    <c:if test="${itemCnt < 5}">
                    <c:forEach var="i" begin="1" end="${rowMax-itemCnt}" step="1">
                    	<tr>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    	</tr>
                    </c:forEach>
                    </c:if>
                    </tbody>
                </table>
                </div>
                </c:if>
                <c:if test="${BaseSearch.ioType eq 'DT' or BaseSearch.ioType eq 'FTDT' }">
                <div class="list_table_scroll" id="divDT">
                <table id="dccIolistTable" class="list_table">
                    <colgroup>
                        <col width="40px"/>
                        <col width="300px"/>
                        <col width="240px"/>
                        <col width="150px"/>
                    </colgroup>
                    <thead>
                        <tr id="itemHeaders">
                            <th>ADDR</th>
                            <th>DESCR</th>
                            <th>LOOPNAME</th>
                            <th>PROGRAM</th>
                        </tr>
                    </thead>
                    <tbody>
					<c:forEach var="dccIolistInfo" items="${DccIolistList}">
                    	<tr>
                            <td class="tc">${dccIolistInfo.address}</td>
                            <td class="tc">${dccIolistInfo.descr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.message}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.rev}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.drawing}</td>
                            <td class="tc">${dccIolistInfo.loopName}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.device}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.xyGubun}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.vLow}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.vHigh}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.eLow}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.eHigh}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.conv}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.type}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioGroup}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.priority}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.equ}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.bscal}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.window}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.wiba}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.unit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.limit2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.purpose}</td>
                            <td class="tc">${dccIolistInfo.program}</td>                          
                            <td class="tc" style="display:none">${dccIolistInfo.rtd}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.j}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iSeq}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.iHogi}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioType}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.zText3}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.tr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.cr}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ioBit}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com1}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.com2}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.n}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.condition}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.ctrlName}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.interlock}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.feedback}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.alarmCond}</td>
                            <td class="tc" style="display:none">${dccIolistInfo.indicate}</td>
                        </tr>
                    </c:forEach>
                    <c:set var="rowMax" value="5" />
                    <c:set var="itemCnt" value="${DccIolistList.size()}" />
                    <c:if test="${itemCnt < 5}">
                    <c:forEach var="i" begin="1" end="${rowMax-itemCnt}" step="1">
                    	<tr>
                    		<td class="tc"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    		<td class="tc" style="display:none"></td>
                    	</tr>
                    </c:forEach>
                    </c:if>
                    </tbody>
                </table>
                </div>
                </c:if>
                <!-- //list_table -->
			</div>
			<!-- //list_wrap -->
            <!-- form_wrap -->
            <c:if test="${BaseSearch.ioType eq 'AI' or BaseSearch.ioType eq 'FTAI' or BaseSearch.ioType eq null}">
            <div class="form_wrap">
			<form id="iolistModifyForm" name="iolistModifyForm">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="tAddress" value="" disabled></td>
                        <th>REV</th>
                        <td><input type="text" id="tRev" value=""></td>
                        <th>TYPE</th>
                        <td>
                        	<select id="tType">
                        		<option></option>
                            </select>
                        </td>
                        <th>EQU#</th>
                        <td><input type="text" id="tEqu" value=""></td>
                    </tr>
                    <tr>
                        <th>DESCR</th>
                        <td colspan="3"><input type="text" id="tDescr" value=""></td>
                        <th>GROUP</th>
                        <td>
                        	<select id="tGroup">
                        		<option></option>
                            </select>
                        </td>
                        <th>B-SCAL</th>
                        <td><input type="text" id="tBscal" value=""></td>
                    </tr>
                    <tr>
                        <th>MESSAGE</th>
                        <td colspan="3"><input type="text" id="tMessage" value=""></td>
                        <th>WINDOWS</th>
                        <td><input type="text" id="tWindows" value=""></td>
                        <th>WBA</th>
                        <td>
                        	<select id="tWba">
                        		<option></option>
                            </select>
                        </td>
                    </tr>                    
                    <tr>
                        <th>DRAWING</th>
                        <td><input type="text" id="tDrawing" value=""></td>
                        <th>LOOPNAME</th>
                        <td><input type="text" id="tLoopName" value=""></td>
                        <th>PRIORITY</th>
                        <td>
                        	<select id="tPriority">
                        		<option></option>
                            </select>
                        </td>
                        <th>DEVICE</th>
                        <td><input type="text" id="tDevice" value=""></td>
                    </tr>
                    <tr>
                        <th>DCC</th>
                        <td><input type="text" id="tXygubun" value=""></td>
                        <th>UNIT</th>
                        <td><input type="text" id="tUnit" value=""></td>
                        <th>CR</th>
                        <td>
                        	<select id="tCr">
                        		<option></option>
                            </select>
                        </td>
                        <th>PURPOSE</th>
                        <td><input type="text" id="tPurpose" value=""></td>
                    </tr>
                    <tr>
                        <th>VLOW</th>
                        <td><input type="text" id="tVlow" value=""></td>
                        <th>ELOW</th>
                        <td><input type="text" id="tElow" value=""></td>
                        <th>LIMIT 1</th>
                        <td><input type="text" id="tLimit1" value=""></td>
                        <th>PROGRAM</th>
                        <td><input type="text" id="tProgram" value=""></td>
                    </tr>
                    <tr>
                        <th>VHIGH</th>
                        <td><input type="text" id="tVhigh" value=""></td>
                        <th>EHIGH</th>
                        <td><input type="text" id="tEhigh" value=""></td>
                        <th>LIMIT 2</th>
                        <td><input type="text" id="tLimit2" value=""></td>
                        <th>N</th>
                        <td>
                        	<select id="tN">
                        		<option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>CONV</th>
                        <td><input type="text" id="tConv" value=""></td>
                        <th>RTD</th>
                        <td><input type="text" id="tRtd" value=""></td>
                        <th>J</th>
                        <td><input type="text" id="tJ" value=""></td>
                        <th>관련절차서</th>
                        <td><input type="text" id="tProcess" value=""></td>
                    </tr>
                    <tr>
                        <th>원인</th>
                        <td colspan="3">
                            <textarea id="tReason" value=""></textarea>
                        </td>
                        <th>조치</th>
                        <td colspan="3">
                            <textarea id="tDone" value=""></textarea>
                        </td>
                        <td style="display:none"><input type="hidden" id="tIseq" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIhogi" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIotype" value=""></td>
                    </tr>
                </table>
                <!-- //form_table -->
            </form>
            </div>
            </c:if>
            <c:if test="${BaseSearch.ioType eq 'AO' }">
            <div class="form_wrap">
			<form id="iolistModifyForm" name="iolistModifyForm">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="tAddress" value="" disabled></td>
                        <th>REV</th>
                        <td><input type="text" id="tRev" value=""></td>
                        <th>DCC</th>
                        <td><input type="text" id="tXygubun" value=""></td>
                        <th>PURPOSE</th>
                        <td><input type="text" id="tPurpose" value=""></td>
                    </tr>
                    <tr>
                        <th>DESCR</th>
                        <td colspan="3"><input type="text" id="tDescr" value=""></td>
                        <th>CTRLNAME</th>
                        <td><input type="text" id="tCrtlName" value=""></td>
                        <th>INTERLOCK</th>
                        <td><input type="text" id="tInterlock" value=""></td>
                    </tr>
                    <tr>
                        <th>DRAWING</th>
                        <td><input type="text" id="tDrawing" value=""></td>
                        <th>DEVICE</th>
                        <td><input type="text" id="tDevice" value=""></td>
                        <th>FEEDBACK</th>
                        <td><input type="text" id="tFeedback" value=""></td>
                        <th>WBA</th>
                        <td>
                        	<select id="tWba">
                        		<option></option>
                            </select>
                        </td>
                        <td style="display:none"><input type="hidden" id="tIseq" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIhogi" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIotype" value=""></td>
                    </tr>
                </table>
                <!-- //form_table -->
            </form>
            </div>
            </c:if>
            <c:if test="${BaseSearch.ioType eq 'CI' }">
            <div class="form_wrap">
			<form id="iolistModifyForm" name="iolistModifyForm">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="tAddress" value="" disabled></td>
                        <th>CR</th>
                        <td>
                        	<select id="tCr">
                        		<option></option>
                            </select>
                        </td>
                        <th>WBA</th>
                        <td>
                        	<select id="tWba">
                        		<option></option>
                            </select>
                        </td>
                        <th>GROUP</th>
                        <td>
                        	<select id="tGroup">
                        		<option></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>MESSAGE</th>
                        <td colspan="7"><input type="text" id="tMessage" value=""></td>
                    </tr>
                    <tr>
                        <th>DRAWING</th>
                        <td><input type="text" id="tDrawing" value=""></td>
                        <th>REV</th>
                        <td><input type="text" id="tRev" value=""></td>
                        <th>TR</th>
                        <td>
                        	<select id="tTr">
                        		<option></option>
                            </select>
                        </td>
                        <th>PRIORITY</th>
                        <td>
                        	<select id="tPriority">
                        		<option></option>
                            </select>
                        </td>
                    </tr>                    
                    <tr>
                        <th>DEVICE</th>
                        <td><input type="text" id="tDevice" value=""></td>
                        <th>CONDITION</th>
                        <td><input type="text" id="tCondition" value=""></td>
                        <th>TYPE</th>
                        <td>
                        	<select id="tType">
                        		<option></option>
                            </select>
                        </td>
                        <th>관련절차서</th>
                        <td><input type="text" id="tProcess" value=""></td>
                    </tr>
                    <tr>
                        <th>원인</th>
                        <td colspan="3">
                            <textarea id="tReason" value=""></textarea>
                        </td>
                        <th>조치</th>
                        <td colspan="3">
                            <textarea id="tDone" value=""></textarea>
                        </td>
                        <td style="display:none"><input type="hidden" id="tIseq" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIhogi" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIotype" value=""></td>
                    </tr>
                </table>
                <!-- //form_table -->
            </form>
            </div>
            </c:if>
            <c:if test="${BaseSearch.ioType eq 'DI' }">
            <div class="form_wrap">
			<form id="iolistModifyForm" name="iolistModifyForm">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="tAddress" value="" disabled></td>
                        <th>REV</th>
                        <td><input type="text" id="tRev" value=""></td>
                        <th>PURPOSE</th>
                        <td><input type="text" id="tPurpose" value=""></td>
                        <th>CTRLNAME</th>
                        <td><input type="text" id="tCrtlName" value=""></td>
                    </tr>
                    <tr>
                        <th>DESCR</th>
                        <td colspan="7"><input type="text" id="tDescr" value=""></td>
                    </tr>
                    <tr>
                        <th>IOBIT</th>
                        <td><input type="text" id="tIoBit" value=""></td>
                        <th>DRAWING</th>
                        <td><input type="text" id="tDrawing" value=""></td>
                        <th>ALARMCOND</th>
                        <td><input type="text" id="tAlarmCond" value=""></td>
                        <th>INDICATE</th>
                        <td><input type="text" id="tIndicate" value=""></td>
                    </tr>                    
                    <tr>
                        <th>DEVICE</th>
                        <td><input type="text" id="tDevice" value=""></td>
                        <th>DCC</th>
                        <td><input type="text" id="tXygubun" value=""></td>
                        <th>WBA</th>
                        <td>
                        	<select id="tWba">
                        		<option></option>
                            </select>
                        </td>
                        <th></th><td></td>
                        <td style="display:none"><input type="hidden" id="tIseq" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIhogi" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIotype" value=""></td>
                    </tr>
                </table>
                <!-- //form_table -->
            </form>
            </div>
            </c:if>
            <c:if test="${BaseSearch.ioType eq 'DO' }">
            <div class="form_wrap">
			<form id="iolistModifyForm" name="iolistModifyForm">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="tAddress" value="" disabled></td>
                        <th>REV</th>
                        <td><input type="text" id="tRev" value=""></td>
                        <th>DEVICE</th>
                        <td><input type="text" id="tDevice" value=""></td>
                        <th>DCC</th>
                        <td><input type="text" id="tXygubun" value=""></td>
                    </tr>
                    <tr>
                        <th>DESCR</th>
                        <td colspan="3"><input type="text" id="tDescr" value=""></td>
                        <th>PURPOSE</th>
                        <td><input type="text" id="tPurpose" value=""></td>
                        <th>CTRLNAME</th>
                        <td><input type="text" id="tCrtlName" value=""></td>
                    </tr>
                    <tr>
                        <th>IOBIT</th>
                        <td><input type="text" id="tIoBit" value=""></td>
                        <th>DRAWING</th>
                        <td><input type="text" id="tDrawing" value=""></td>
                        <th>INTERLOCK</th>
                        <td><input type="text" id="tInterlock" value=""></td>
                        <th>WBA</th>
                        <td>
                        	<select id="tWba">
                        		<option></option>
                            </select>
                        </td>
                        <td style="display:none"><input type="hidden" id="tIseq" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIhogi" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIotype" value=""></td>
                    </tr>
                </table>
                <!-- //form_table -->
            </form>
            </div>
            </c:if>
            <c:if test="${BaseSearch.ioType eq 'DT' or BaseSearch.ioType eq 'FTDT'}">
            <div class="form_wrap">
			<form id="iolistModifyForm" name="iolistModifyForm">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="tAddress" value="" disabled></td>
                        <th>PROGRAM</th>
                        <td><input type="text" id="tProgram" value=""></td>
                        <th>LOOPNAME</th>
                        <td><input type="text" id="tLoopName" value=""></td>
                        <th></th><td></td>
                    </tr>
                    <tr>
                        <th>DESCR</th>
                        <td colspan="7"><input type="text" id="tDescr" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIseq" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIhogi" value=""></td>
                        <td style="display:none"><input type="hidden" id="tIotype" value=""></td>
                    </tr>
                </table>
                <!-- //form_table -->
            </form>
            </div>
            </c:if>
            <!-- //form_wrap -->
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
<div class="layer_pop_wrap large" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>엑셀로 저장</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
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
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

