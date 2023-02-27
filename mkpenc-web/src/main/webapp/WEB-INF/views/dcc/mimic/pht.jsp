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
<script type="text/javascript">
var timerOn = false; //true로 변경
var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

var tDccTagSeq = [
	${DccTagInfoList[0].iSeq},${DccTagInfoList[1].iSeq},${DccTagInfoList[2].iSeq},${DccTagInfoList[3].iSeq},${DccTagInfoList[4].iSeq},
	${DccTagInfoList[5].iSeq},${DccTagInfoList[6].iSeq},${DccTagInfoList[7].iSeq},${DccTagInfoList[8].iSeq},${DccTagInfoList[9].iSeq},
	${DccTagInfoList[10].iSeq},${DccTagInfoList[11].iSeq},${DccTagInfoList[12].iSeq},${DccTagInfoList[13].iSeq},${DccTagInfoList[14].iSeq},
	${DccTagInfoList[15].iSeq},${DccTagInfoList[16].iSeq},${DccTagInfoList[17].iSeq},${DccTagInfoList[18].iSeq},${DccTagInfoList[19].iSeq},
	${DccTagInfoList[20].iSeq},${DccTagInfoList[21].iSeq},${DccTagInfoList[22].iSeq},${DccTagInfoList[23].iSeq},${DccTagInfoList[24].iSeq},
	${DccTagInfoList[25].iSeq},${DccTagInfoList[26].iSeq},${DccTagInfoList[27].iSeq},${DccTagInfoList[28].iSeq},${DccTagInfoList[29].iSeq},
	${DccTagInfoList[30].iSeq},${DccTagInfoList[31].iSeq}
];
var tDccTagXy = [
	'${DccTagInfoList[0].XYGubun}','${DccTagInfoList[1].XYGubun}','${DccTagInfoList[2].XYGubun}','${DccTagInfoList[3].XYGubun}','${DccTagInfoList[4].XYGubun}',
	'${DccTagInfoList[5].XYGubun}','${DccTagInfoList[6].XYGubun}','${DccTagInfoList[7].XYGubun}','${DccTagInfoList[8].XYGubun}','${DccTagInfoList[9].XYGubun}',
	'${DccTagInfoList[10].XYGubun}','${DccTagInfoList[11].XYGubun}','${DccTagInfoList[12].XYGubun}','${DccTagInfoList[13].XYGubun}','${DccTagInfoList[14].XYGubun}',
	'${DccTagInfoList[15].XYGubun}','${DccTagInfoList[16].XYGubun}','${DccTagInfoList[17].XYGubun}','${DccTagInfoList[18].XYGubun}','${DccTagInfoList[19].XYGubun}',
	'${DccTagInfoList[20].XYGubun}','${DccTagInfoList[21].XYGubun}','${DccTagInfoList[22].XYGubun}','${DccTagInfoList[23].XYGubun}','${DccTagInfoList[24].XYGubun}',
	'${DccTagInfoList[25].XYGubun}','${DccTagInfoList[26].XYGubun}','${DccTagInfoList[27].XYGubun}','${DccTagInfoList[28].XYGubun}','${DccTagInfoList[29].XYGubun}',
	'${DccTagInfoList[30].XYGubun}','${DccTagInfoList[31].XYGubun}'
];
var tToolTipText = [
	"${DccTagInfoList[0].Descr}[${DccTagInfoList[0].Hogi}:${DccTagInfoList[0].IOTYPE}-${DccTagInfoList[0].ADDRESS}:${DccTagInfoList[0].IOBIT}]"
	,"${DccTagInfoList[1].Descr}[${DccTagInfoList[1].Hogi}:${DccTagInfoList[1].IOTYPE}-${DccTagInfoList[1].ADDRESS}:${DccTagInfoList[1].IOBIT}]"
	,"${DccTagInfoList[2].Descr}[${DccTagInfoList[2].Hogi}:${DccTagInfoList[2].IOTYPE}-${DccTagInfoList[2].ADDRESS}:${DccTagInfoList[2].IOBIT}]"
	,"${DccTagInfoList[3].Descr}[${DccTagInfoList[3].Hogi}:${DccTagInfoList[3].IOTYPE}-${DccTagInfoList[3].ADDRESS}:${DccTagInfoList[3].IOBIT}]"
	,"${DccTagInfoList[4].Descr}[${DccTagInfoList[4].Hogi}:${DccTagInfoList[4].IOTYPE}-${DccTagInfoList[4].ADDRESS}:${DccTagInfoList[4].IOBIT}]"
	,"${DccTagInfoList[5].Descr}[${DccTagInfoList[5].Hogi}:${DccTagInfoList[5].IOTYPE}-${DccTagInfoList[5].ADDRESS}:${DccTagInfoList[5].IOBIT}]"
	,"${DccTagInfoList[6].Descr}[${DccTagInfoList[6].Hogi}:${DccTagInfoList[6].IOTYPE}-${DccTagInfoList[6].ADDRESS}:${DccTagInfoList[6].IOBIT}]"
	,"${DccTagInfoList[7].Descr}[${DccTagInfoList[7].Hogi}:${DccTagInfoList[7].IOTYPE}-${DccTagInfoList[7].ADDRESS}:${DccTagInfoList[7].IOBIT}]"
	,"${DccTagInfoList[8].Descr}[${DccTagInfoList[8].Hogi}:${DccTagInfoList[8].IOTYPE}-${DccTagInfoList[8].ADDRESS}:${DccTagInfoList[8].IOBIT}]"
	,"${DccTagInfoList[9].Descr}[${DccTagInfoList[9].Hogi}:${DccTagInfoList[9].IOTYPE}-${DccTagInfoList[9].ADDRESS}:${DccTagInfoList[9].IOBIT}]"
	,"${DccTagInfoList[10].Descr}[${DccTagInfoList[10].Hogi}:${DccTagInfoList[10].IOTYPE}-${DccTagInfoList[10].ADDRESS}:${DccTagInfoList[10].IOBIT}]"
	,"${DccTagInfoList[11].Descr}[${DccTagInfoList[11].Hogi}:${DccTagInfoList[11].IOTYPE}-${DccTagInfoList[11].ADDRESS}:${DccTagInfoList[11].IOBIT}]"
	,"${DccTagInfoList[12].Descr}[${DccTagInfoList[12].Hogi}:${DccTagInfoList[12].IOTYPE}-${DccTagInfoList[12].ADDRESS}:${DccTagInfoList[12].IOBIT}]"
	,"${DccTagInfoList[13].Descr}[${DccTagInfoList[13].Hogi}:${DccTagInfoList[13].IOTYPE}-${DccTagInfoList[13].ADDRESS}:${DccTagInfoList[13].IOBIT}]"
	,"${DccTagInfoList[14].Descr}[${DccTagInfoList[14].Hogi}:${DccTagInfoList[14].IOTYPE}-${DccTagInfoList[14].ADDRESS}:${DccTagInfoList[14].IOBIT}]"
	,"${DccTagInfoList[15].Descr}[${DccTagInfoList[15].Hogi}:${DccTagInfoList[15].IOTYPE}-${DccTagInfoList[15].ADDRESS}:${DccTagInfoList[15].IOBIT}]"
	,"${DccTagInfoList[16].Descr}[${DccTagInfoList[16].Hogi}:${DccTagInfoList[16].IOTYPE}-${DccTagInfoList[16].ADDRESS}:${DccTagInfoList[16].IOBIT}]"
	,"${DccTagInfoList[17].Descr}[${DccTagInfoList[17].Hogi}:${DccTagInfoList[17].IOTYPE}-${DccTagInfoList[17].ADDRESS}:${DccTagInfoList[17].IOBIT}]"
	,"${DccTagInfoList[18].Descr}[${DccTagInfoList[18].Hogi}:${DccTagInfoList[18].IOTYPE}-${DccTagInfoList[18].ADDRESS}:${DccTagInfoList[18].IOBIT}]"
	,"${DccTagInfoList[19].Descr}[${DccTagInfoList[19].Hogi}:${DccTagInfoList[19].IOTYPE}-${DccTagInfoList[19].ADDRESS}:${DccTagInfoList[19].IOBIT}]"
	,"${DccTagInfoList[20].Descr}[${DccTagInfoList[20].Hogi}:${DccTagInfoList[20].IOTYPE}-${DccTagInfoList[20].ADDRESS}:${DccTagInfoList[20].IOBIT}]"
	,"${DccTagInfoList[21].Descr}[${DccTagInfoList[21].Hogi}:${DccTagInfoList[21].IOTYPE}-${DccTagInfoList[21].ADDRESS}:${DccTagInfoList[21].IOBIT}]"
	,"${DccTagInfoList[22].Descr}[${DccTagInfoList[22].Hogi}:${DccTagInfoList[22].IOTYPE}-${DccTagInfoList[22].ADDRESS}:${DccTagInfoList[22].IOBIT}]"
	,"${DccTagInfoList[23].Descr}[${DccTagInfoList[23].Hogi}:${DccTagInfoList[23].IOTYPE}-${DccTagInfoList[23].ADDRESS}:${DccTagInfoList[23].IOBIT}]"
	,"${DccTagInfoList[24].Descr}[${DccTagInfoList[24].Hogi}:${DccTagInfoList[24].IOTYPE}-${DccTagInfoList[24].ADDRESS}:${DccTagInfoList[24].IOBIT}]"
	,"${DccTagInfoList[25].Descr}[${DccTagInfoList[25].Hogi}:${DccTagInfoList[25].IOTYPE}-${DccTagInfoList[25].ADDRESS}:${DccTagInfoList[25].IOBIT}]"
	,"${DccTagInfoList[26].Descr}[${DccTagInfoList[26].Hogi}:${DccTagInfoList[26].IOTYPE}-${DccTagInfoList[26].ADDRESS}:${DccTagInfoList[26].IOBIT}]"
	,"${DccTagInfoList[27].Descr}[${DccTagInfoList[27].Hogi}:${DccTagInfoList[27].IOTYPE}-${DccTagInfoList[27].ADDRESS}:${DccTagInfoList[27].IOBIT}]"
	,"${DccTagInfoList[28].Descr}[${DccTagInfoList[28].Hogi}:${DccTagInfoList[28].IOTYPE}-${DccTagInfoList[28].ADDRESS}:${DccTagInfoList[28].IOBIT}]"
	,"${DccTagInfoList[29].Descr}[${DccTagInfoList[29].Hogi}:${DccTagInfoList[29].IOTYPE}-${DccTagInfoList[29].ADDRESS}:${DccTagInfoList[29].IOBIT}]"
	,"${DccTagInfoList[30].Descr}[${DccTagInfoList[30].Hogi}:${DccTagInfoList[30].IOTYPE}-${DccTagInfoList[30].ADDRESS}:${DccTagInfoList[30].IOBIT}]"
	,"${DccTagInfoList[31].Descr}[${DccTagInfoList[31].Hogi}:${DccTagInfoList[31].IOTYPE}-${DccTagInfoList[31].ADDRESS}:${DccTagInfoList[31].IOBIT}]"
];

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
	
	var lblDateVal = '${SearchTime}';
	$("#lblDate").text(lblDateVal);
	
	$(document.body).delegate('#3', 'click', function() {
		setTimer('3',xyHeader,0);
	});
	$(document.body).delegate('#4', 'click', function() {
		setTimer('4',xyHeader,0);
	});
	$(document.body).delegate('#X', 'click', function() {
		setTimer(hogiHeader,'X',0);
	});
	$(document.body).delegate('#Y', 'click', function() {
		setTimer(hogiHeader,'Y',0);
	});
		$(document.body).delegate('#phtdiv span', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			if( cId != null && cId != '' && cId != 'undefined' ) {
				showTag(cId,tDccTagSeq[cId]);
			}
		});
		
		$(document.body).delegate('#tagSearchTable tr', 'click', function() {
			for( var t=0;t<selectTag.length;t++ ) {
				for( var c=0;c<7;c++ ) {
					if( selectTag[t].name == "hogi" ) {
						if( $(this).children()[c].id == "tagHogi" ) {
							selectTag[t].value = $(this).children()[c].innerText;
						}
					}
					if( selectTag[t].name == "xyGubun" ) {
						if( $(this).children()[c].id == "tagXyGubun" ) {
							selectTag[t].value = $(this).children()[c].innerText;
						}
					}
					if( selectTag[t].name == "loopName" ) {
						if( $(this).children()[c].id == "tagLoopName" ) {
							selectTag[t].value = $(this).children()[c].innerText;
						}
					}
					if( selectTag[t].name == "ioType" ) {
						if( $(this).children()[c].id == "tagIoType" ) {
							selectTag[t].value = $(this).children()[c].innerText;
						}
					}
					if( selectTag[t].name == "address" ) {
						if( $(this).children()[c].id == "tagAddress" ) {
							selectTag[t].value = $(this).children()[c].innerText;
						}
					}
					if( selectTag[t].name == "ioBit" ) {
						if( $(this).children()[c].id == "tagIoBit" ) {
							selectTag[t].value = $(this).children()[c].innerText;
						}
					}
					if( selectTag[t].name == "descr" ) {
						if( $(this).children()[c].id == "tagDescr" ) {
							selectTag[t].value = $(this).children()[c].innerText;
						}
					}
				}
			}
		});
		
		$("#tagSearch").click(function() {
			tagSearchEvent();
		});
		$("#saveVarTable").click(function() {
			saveTag();
		});
		$("#tagFind").click(function() {
			tagFind(0);
		});
		$("#tagFindAll").click(function() {
			tagFind(1);
		});
		$("#tagSearchSelect").click(function() {
			tagSelect();
		});
		
		$(document.body).delegate('#tagSearchList tr', 'dblclick', function() {
			tagSelect();
		});
		
		setTimer(hogiHeader,xyHeader,5000);

});	


function setTimer(hogiHeader,xyHeader,interval) {
	if( interval > 0 ) {
		setTimeout(function() {
			if( timerOn ) {
				var	comSubmit	=	new ComSubmit("phtFrm");
				comSubmit.setUrl("/dcc/mimic/pht");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("phtFrm");
		comSubmit.setUrl("/dcc/mimic/pht");
		comSubmit.addParam("hogiHeader",hogiHeader);
		comSubmit.addParam("xyHeader",xyHeader);
		comSubmit.submit();
	}
}

function saveTag() {
	var comSubmit = new ComSubmit("setIOForm");
	var frm = document.getElementById("setIOForm");
	
	if($("#txtHogi").val() == 'undefined') {
		comSubmit.addParam("txtHogi",frm.txtHogi.value);
	}
	if($("#txtXyGubun").val() == 'undefined') {
		comSubmit.addParam("txtXyGubun",frm.txtXyGubun.value);
	}
	if($("#txtDescr").val() == 'undefined') {
		comSubmit.addParam("txtDescr",frm.txtDescr.value);
	}
	if($("#txtIoType").val() == 'undefined') {
		comSubmit.addParam("txtIoType",frm.txtIoType.value);
	}
	if($("#txtAddress").val() == 'undefined') {
		comSubmit.addParam("txtAddress",frm.txtAddress.value);
	}
	if($("#txtIoBit").val() == 'undefined') {
		comSubmit.addParam("txtIoBit",frm.txtIoBit.value);
	}
	if($("#xyAll").is(":checked")){
		comSubmit.addParam("chkXy","1");
	}
	
	comSubmit.setUrl("/dcc/mimic/phtSaveTag");
	comSubmit.addParam("hogiHeader",hogiHeader);
	comSubmit.addParam("xyHeader",xyHeader);
	comSubmit.submit();
}

function tagSearchEvent(){
	var comAjax = new ComAjax("setIOForm");
	var tHogi = $("#txtHogi").val()*1;
	var tAddress = $("#txtAddress").val()*1;
	
	if( gfn_isEmpty("txtHogi") ) {
		alert("호기를 입력하세요...");
		$("#txtHogi").focus();
		return;
	}
	if( !$.isNumeric(tHogi) ) {
		alert("호기는 정상적인 숫자로 입력하세요...");
		$("#txtHogi").focus();
		return;
	}
	if( gfn_isEmpty("txtAddress") ) {
		alert("Address를 입력하세요...");
		$("#txtAddress").focus();
		return;
	}
	if( !$.isNumeric(tAddress) ){
		alert("Address는 정상적인 숫자로 입력하세요...");
		$("#txtAddress").focus();
		return;
	}
	
	comAjax.setUrl("/dcc/mimic/tagSearch");
	comAjax.setCallback("tagSearchCallback");
	comAjax.ajax();
}

function tagFind(type) {
	var comAjax = new ComAjax("tagSearchForm");
	if( type == 0 ) {
		comAjax.addParam("findAll","0");
	} else if( type == 1 ) {
		comAjax.addParam("findAll","1");
	}
	
	comAjax.addParam("txtHogi",$("#txtHogi").val());
	comAjax.addParam("searchStr",$("#findData").val());
	
	comAjax.setUrl("/dcc/mimic/tagFind");
	comAjax.setCallback("tagFindCallback");
	comAjax.ajax();
}

function tagSelect() {
	for( var tr=0;tr<selectTag.length;tr++ ) {
		if( selectTag[tr].name == "hogi" ) $("#txtHogi").val(selectTag[tr].value);
		if( selectTag[tr].name == "xyGubun" ) $("#txtXyGubun").val(selectTag[tr].value);
		if( selectTag[tr].name == "descr" ) $("#txtDescr").val(selectTag[tr].value);
		if( selectTag[tr].name == "ioType" ) $("#txtIoType").val(selectTag[tr].value);
		if( selectTag[tr].name == "address" ) $("#txtAddress").val(selectTag[tr].value);
		if( selectTag[tr].name == "ioBit" ) $("#txtIoBit").val(selectTag[tr].value);
	}
	closeLayer('modal_3');
}

function closeModal() {
	var	comSubmit	=	new ComSubmit("phtFrm");
	comSubmit.setUrl("/dcc/mimic/pht");
	comSubmit.submit();
}

var selectTag = [{name:"hogi",value:""},{name:"xyGubun",value:""},{name:"loopName",value:""},{name:"ioType",value:""}
				,{name:"address",value:""},{name:"ioBit",value:""},{name:"descr",value:""}];

function showTag(tagNo,iSeq) {
	if(${UserInfo.grade} == '1' || ${UserInfo.grade} == '2') { // 나중에 grade 1 은 삭제할 것
		timerOn = false;
		$("#tagNo").val(tagNo);
		var infos = tToolTipText[tagNo];
		$("#txtHogi").val(infos.substring(infos.indexOf('[')+1,infos.indexOf(':')));
        $("#txtXyGubun").val(tDccTagXy[tagNo]);
        $("#txtDescr").val(infos.substring(0,infos.indexOf('[')));
        $("#txtIoType").val(infos.substring(infos.indexOf(':')+1,infos.indexOf('-')));
        $("#txtAddress").val(infos.substring(infos.indexOf('-')+1,infos.lastIndexOf(':')));
        $("#txtIoBit").val(infos.substring(infos.lastIndexOf(':')+1,infos.indexOf(']')));
		openLayer('modal_2');
	} else {
		console.log('Not enough permission...');
	}
}

function toCSV() {
	var	comSubmit = new ComSubmit("phtFrm");
	comSubmit.setUrl("/dcc/mimic/phtExcelExport");
	comSubmit.submit();
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
				<h3>PRIMARY HEAT TRANSPORT SYSTEM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>PRIMARY</span><strong>PRIMARY HEAT TRANSPORT SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap pht" id="phtdiv">
			<form id="phtFrm" style="display:none"></form>
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- //range_slider -->              
                <a href="/dcc/mimic/phtpuri" class="link_btn link_01"></a>
                <a href="/dcc/mimic/phtctrl" class="link_btn link_02"></a>
                <div class="chart_block" style="top:324px;left:646px;width:auto;">
                    <div class="chart_block_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>RX PWR :</span>
                                <span>0.8593</span>
                                <span class="unit">FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:30px;left:160px;">
                    <h4>Pp Speed</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>1</span>
                                <span id="0">${lblDataList[0].fValue}</span>
                                <span>${DccTagInfoList[0].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>2</span>
                                <span id="17">${lblDataList[17].fValue}</span>
                                <span>${DccTagInfoList[17].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>3</span>
                                <span id="11">${lblDataList[11].fValue}</span>
                                <span>${DccTagInfoList[11].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>4</span>
                                <span id="31">${lblDataList[31].fValue}</span>
                                <span>${DccTagInfoList[31].Unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:200px;left:160px;">
                    <h4>Purification</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span id="5">${lblDataList[5].fValue}</span>
                                <span>${DccTagInfoList[5].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F</span>
                                <span id="6">${lblDataList[6].fValue}</span>
                                <span>${DccTagInfoList[6].Unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:420px;left:160px;">
                    <h4>RX △T</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>H 1-4</span>
                                <span id="12">${lblDataList[12].fValue}</span>
                                <span>${DccTagInfoList[12].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>H 2-3</span>
                                <span id="13">${lblDataList[13].fValue}</span>
                                <span>${DccTagInfoList[13].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>H 5-8</span>
                                <span id="15">${lblDataList[15].fValue}</span>
                                <span>${DccTagInfoList[15].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>H 6-7</span>
                                <span id="16">${lblDataList[16].fValue}</span>
                                <span>${DccTagInfoList[16].Unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small double" style="top:60px;left:560px;">
                    <h4>RX Inlet HD</h4>
                    <div class="chart_block_contents fx_row">
                        <div class="fx_block">
                            <div class="summary">
                                <p>
                                    <span>HD2 T</span>
                                    <span id="3">${lblDataList[3].fValue}</span>
                                	<span>${DccTagInfoList[3].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD4 T</span>
                                    <span id="18">${lblDataList[18].fValue}</span>
                                	<span>${DccTagInfoList[18].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD6 T</span>
                                    <span id="9">${lblDataList[9].fValue}</span>
                                	<span>${DccTagInfoList[9].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD8 T</span>
                                    <span id="27">${lblDataList[27].fValue}</span>
                                	<span>${DccTagInfoList[27].Unit}</span>
                                </p>
                            </div>
                        </div>
                        <div class="fx_block">
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span id="4">${lblDataList[4].fValue}</span>
                                	<span>${DccTagInfoList[4].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span id="19">${lblDataList[19].fValue}</span>
                                	<span>${DccTagInfoList[19].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span id="10">${lblDataList[10].fValue}</span>
                                	<span>${DccTagInfoList[10].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span id="28">${lblDataList[28].fValue}</span>
                                	<span>${DccTagInfoList[28].Unit}</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart_block small double" style="top:480px;left:560px;">
                    <h4>RX Outlet HD</h4>
                    <div class="chart_block_contents fx_row">
                        <div class="fx_block">
                            <div class="summary">
                                <p>
                                    <span>HD1 T</span>
                                    <span id="1">${lblDataList[1].fValue}</span>
                                	<span>${DccTagInfoList[1].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD3 T</span>
                                    <span id="20">${lblDataList[20].fValue}</span>
                                	<span>${DccTagInfoList[20].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD5 T</span>
                                    <span id="7">${lblDataList[7].fValue}</span>
                                	<span>${DccTagInfoList[7].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD7T</span>
                                    <span id="29">${lblDataList[29].fValue}</span>
                                	<span>${DccTagInfoList[29].Unit}</span>
                                </p>
                            </div>
                        </div>
                        <div class="fx_block">
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span id="2">${lblDataList[2].fValue}</span>
                                	<span>${DccTagInfoList[2].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span id="21">${lblDataList[21].fValue}</span>
                                	<span>${DccTagInfoList[21].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span id="8">${lblDataList[8].fValue}</span>
                                	<span>${DccTagInfoList[8].Unit}</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span id="30">${lblDataList[30].fValue}</span>
                                	<span>${DccTagInfoList[30].Unit}</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:440px;right:120px;">
                    <h4>PZR</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>p</span>
                                <span id="25">${lblDataList[25].fValue}</span>
                                <span>${DccTagInfoList[25].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Pe</span>
                                <span id="26">${lblDataList[26].fValue}</span>
                                <span>${DccTagInfoList[26].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Ls</span>
                                <span id="22">${lblDataList[22].fValue}</span>
                                <span>${DccTagInfoList[22].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span id="23">${lblDataList[23].fValue}</span>
                                <span>${DccTagInfoList[23].Unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Le</span>
                                <span id="24">${lblDataList[24].fValue}</span>
                                <span>${DccTagInfoList[24].Unit}</span>
                            </p>
                        </div>
                    </div>
                </div>                
            </div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_2">
    <!-- header_wrap -->
<div class="pop_header">
   <h3>태그정보</h3>
        <a onclick="javascript:closeModal();" title="Close"></a>
    </div>
<!-- //header_wrap -->
<!-- pop_contents -->
<div class="pop_contents" style="max-height:460px;">
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <form id="setIOForm" name="setIOForm">
            <input type ="hidden" id="tagNo" name="tagNo">
            <table class="list_table" id=setVarTable" name="setVarTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="60px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>XY<br>모두적용</th>
                        <th>DESCR</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>검색</th>
                    </tr>
                </thead>
                <tbody id="tagInfos">
                    <tr>
                        <td><input style='text-align:center' type="text" id="txtHogi" name="txtHogi"></td>
                        <td><input style='text-align:center' type="text" id="txtXyGubun" name="txtXyGubun"></td>
                        <td style="text-align:center"><input type="checkbox" id="xyAll" name="xyAll" value="1"></td>
                        <td><input type="text" id="txtDescr" name="txtDescr"></td>
                        <td><input style='text-align:center' type="text" id="txtIoType" name="txtIoType"></td>
                        <td><input style='text-align:center' type="text" id="txtAddress" name="txtAddress"></td>
                        <td><input style='text-align:center' type="text" id="txtIoBit" name="txtIoBit"></td>
                        <td style="text-align:center">
                        	<div class="button">
                    			<a href="#none" class="btn_list" id="tagSearch" name="tagSearch">검색</a>
                    		</div>
                        </td>
                    </tr>
                </tbody>
            </table>
            </form>
             <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" onclick="openLayer('modal_3');">Tag Search</a>
				</div>
  				<div class="button">                    
                    <a href="#none" class="btn_page" id="saveVarTable" name="saveVarTable">저장</a>
        			<a href="#none" class="btn_page" onclick="javascript:closeModal();">닫기</a>
                </div>
            </div>
            <!-- //list_bottom -->
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->
</div>
<!-- pop_contents -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_3">
    <!-- header_wrap -->
<div class="pop_header">
   <h3>태그목록</h3>
        <a onclick="closeLayer('modal_3');" title="Close"></a>
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
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>검색어</th>
                    <td>
                        <div class="fx_form">
                          <input type="text" id="findData" name="findData">
                        </div>
                    </td>
                    <td>
	                   <div class="button">
	                   	<a class="btn_list" href="#none" id="tagFind" name="tagFind">검색</a>
	                   </div>
                    </td>
                    <th>검색옵션</th>
                    <td>
                		<div class="fx_form">
                          <input type="checkbox" id="chkOpt1" name="chkOpt1" value="1"> 태그명
                          <input type="checkbox" id="chkOpt2" name="chkOpt2" value="1"> 태그설명
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
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col />
                </colgroup>
                <thead>
                    <tr>
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>LOOP NAME</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>DESCR</th>
                    </tr>
                </thead>
                <tbody id="tagSearchList" name="tagSearchList">
                <tr>
                <td class="tc" id="tagHogi" name="tagHogi"></td>
                <td class="tc" id="tagXyGubun" name="tagXyGubun"></td>
                <td class="tc" id="tagLoopName" name="tagLoopName"></td>
                <td class="tc" id="tagIoType" name="tagIoType"></td>
                <td class="tc" id="tagAddress" name="tagAddress"></td>
                <td class="tc" id="tagIoBit" name="tagIoBit"></td>
                <td class="tc" id="tagDescr" name="tagDescr"></td>
                </tr>
                </tbody>
            </table>
            <!-- //list_table -->
             <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" id="tagFindAll" name="tagFindAll">전체리스트</a>
                </div>
                <div class="button">
                    <a href="#none" class="btn_page" id="tagSearchSelect" name="tagSearchSelect">선택</a>
        			<a href="#none" class="btn_page" onclick="closeLayer('modal_3');">닫기</a>
                </div>
            </div>
            <!-- //list_bottom -->
        </div>
        <!-- //list_wrap -->      
</div>
<!-- pop_contents -->
</div>
<!-- //layer_pop_wrap -->

<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

