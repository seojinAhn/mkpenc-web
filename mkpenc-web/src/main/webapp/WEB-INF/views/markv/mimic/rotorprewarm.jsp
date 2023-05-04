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
<script type="text/javascript" src="<c:url value="/resources/js/mimic.js" />" charset="utf-8"></script>
<script type="text/javascript">
var timerOn = true; //true로 변경
var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

var tMarkTagSeq = [	
	${MarkTagInfoList[0].iSeq},${MarkTagInfoList[1].iSeq},${MarkTagInfoList[2].iSeq},${MarkTagInfoList[3].iSeq},${MarkTagInfoList[4].iSeq},
	${MarkTagInfoList[5].iSeq},${MarkTagInfoList[6].iSeq},${MarkTagInfoList[7].iSeq},${MarkTagInfoList[8].iSeq},${MarkTagInfoList[9].iSeq},
	${MarkTagInfoList[10].iSeq},${MarkTagInfoList[11].iSeq},${MarkTagInfoList[12].iSeq},${MarkTagInfoList[13].iSeq},${MarkTagInfoList[14].iSeq},
	${MarkTagInfoList[15].iSeq},${MarkTagInfoList[16].iSeq},${MarkTagInfoList[17].iSeq},${MarkTagInfoList[18].iSeq},${MarkTagInfoList[19].iSeq},
	${MarkTagInfoList[20].iSeq},${MarkTagInfoList[21].iSeq}
];

var tMarkTagXy = [
	'${MarkTagInfoList[0].XYGubun}','${MarkTagInfoList[1].XYGubun}','${MarkTagInfoList[2].XYGubun}','${MarkTagInfoList[3].XYGubun}','${MarkTagInfoList[4].XYGubun}',
	'${MarkTagInfoList[5].XYGubun}','${MarkTagInfoList[6].XYGubun}','${MarkTagInfoList[7].XYGubun}','${MarkTagInfoList[8].XYGubun}','${MarkTagInfoList[9].XYGubun}',
	'${MarkTagInfoList[10].XYGubun}','${MarkTagInfoList[11].XYGubun}','${MarkTagInfoList[12].XYGubun}','${MarkTagInfoList[13].XYGubun}','${MarkTagInfoList[14].XYGubun}',
	'${MarkTagInfoList[15].XYGubun}','${MarkTagInfoList[16].XYGubun}','${MarkTagInfoList[17].XYGubun}','${MarkTagInfoList[18].XYGubun}','${MarkTagInfoList[19].XYGubun}',
	'${MarkTagInfoList[20].XYGubun}','${MarkTagInfoList[21].XYGubun}'
];

var tToolTipText = [
	"${MarkTagInfoList[0].toolTip}"	,"${MarkTagInfoList[1].toolTip}"	,"${MarkTagInfoList[2].toolTip}"	,"${MarkTagInfoList[3].toolTip}"
	,"${MarkTagInfoList[4].toolTip}"	,"${MarkTagInfoList[5].toolTip}"	,"${MarkTagInfoList[6].toolTip}"	,"${MarkTagInfoList[7].toolTip}"
	,"${MarkTagInfoList[8].toolTip}"	,"${MarkTagInfoList[9].toolTip}"	,"${MarkTagInfoList[10].toolTip}"	,"${MarkTagInfoList[11].toolTip}"	
	,"${MarkTagInfoList[12].toolTip}"	,"${MarkTagInfoList[13].toolTip}"	,"${MarkTagInfoList[14].toolTip}"	,"${MarkTagInfoList[15].toolTip}"
	,"${MarkTagInfoList[16].toolTip}"	,"${MarkTagInfoList[17].toolTip}"	,"${MarkTagInfoList[18].toolTip}"	,"${MarkTagInfoList[19].toolTip}"
	,"${MarkTagInfoList[20].toolTip}"	,"${MarkTagInfoList[21].toolTip}"
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
	
	
	$(document.body).delegate('#rotorprewarmFrm_div label', 'dblclick', function() {		
		var cId = this.id.indexOf('fValue') > -1 ? this.id.substring(4) : this.id;
		if( cId != null && cId != '' && cId != 'undefined' ) {			
			if( cId != 3 && cId != 4 && cId != 5 ) {
				showTag(cId,tMarkTagSeq[cId]);
			}
		}
	});
	
	//showTag1 추가 시작
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
	
	$(document.body).delegate('#tagSearchTable tr', 'click', function() {
		for( var t=0;t<selectTag.length;t++ ) {
			for( var c=0;c<8;c++ ) {
				if( selectTag[t].name == "iSeq" ) {
					if( $(this).children()[c].id == "tagISeq" ) {
						selectTag[t].value = $(this).children()[c].innerText;
					}
				}
				if( selectTag[t].name == "register" ) {
					if( $(this).children()[c].id == "tagRegister" ) {
						selectTag[t].value = $(this).children()[c].innerText;
					}
				}
				if( selectTag[t].name == "iOBit" ) {
					if( $(this).children()[c].id == "tagIOBit" ) {
						selectTag[t].value = $(this).children()[c].innerText;
					}
				}
				if( selectTag[t].name == "signalName" ) {
					if( $(this).children()[c].id == "tagSignalName" ) {
						selectTag[t].value = $(this).children()[c].innerText;
					}
				}
				if( selectTag[t].name == "signalDesc" ) {
					if( $(this).children()[c].id == "tagSignalDesc" ) {
						selectTag[t].value = $(this).children()[c].innerText;
					}
				}
				if( selectTag[t].name == "d0" ) {
					if( $(this).children()[c].id == "tagD0" ) {
						selectTag[t].value = $(this).children()[c].innerText;
					}
				}
				if( selectTag[t].name == "d1" ) {
					if( $(this).children()[c].id == "tagD1" ) {
						selectTag[t].value = $(this).children()[c].innerText;
					}
				}
				if( selectTag[t].name == "bSCal" ) {
					if( $(this).children()[c].id == "tagBSCal" ) {
						selectTag[t].value = $(this).children()[c].innerText;
					}
				}
			}
		}
	});
	
	$(document.body).delegate('#tagSearchList tr', 'dblclick', function() {
		tagSelect();
	});	
	
	//showTag1 추가끝
	
	setTimer(hogiHeader,xyHeader,5000);

});	

function setTimer(hogiHeader,xyHeader,interval) {
	if( interval > 0 ) {
		setTimeout(function() {
			if( timerOn ) {
				var	comSubmit	=	new ComSubmit("rotorprewarmFrm");
				comSubmit.setUrl("/markv/mimic/rotorprewarm");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("rotorprewarmFrm");
		comSubmit.setUrl("/markv/mimic/rotorprewarm");
		comSubmit.addParam("hogiHeader",hogiHeader);
		comSubmit.addParam("xyHeader",xyHeader);
		comSubmit.submit();
	}
}

//showTag2 추가시작
var selectTag = [{name:"iSeq",value:""},{name:"register",value:""},{name:"iOBit",value:""},{name:"signalName",value:""}
				,{name:"signalDesc",value:""},{name:"d0",value:""},{name:"d1",value:""},{name:"bSCal",value:""}];

function tagSelect() {
	for( var tr=0;tr<selectTag.length;tr++ ) {
		if( selectTag[tr].name == "iSeq" ) $("#txtISeq").val(selectTag[tr].value);
		if( selectTag[tr].name == "register" ) $("#txtRegister").val(selectTag[tr].value);
		if( selectTag[tr].name == "iOBit" ) $("#txtIOBit").val(selectTag[tr].value);
		if( selectTag[tr].name == "signalName" ) $("#txtSignalName").val(selectTag[tr].value);
		if( selectTag[tr].name == "signalDesc" ) $("#txtSignalDesc").val(selectTag[tr].value);
		if( selectTag[tr].name == "d0" ) $("#txtD0").val(selectTag[tr].value);
		if( selectTag[tr].name == "d1" ) $("#txtD1").val(selectTag[tr].value);
		if( selectTag[tr].name == "bSCal" ) $("#txtBSCal").val(selectTag[tr].value).prop("selected",true);
	}
	closeLayer('modal_2');
}

function tagFind(type) {
	var pHogi;
	var comAjax = new ComAjax("tagSearchForm");
	if( type == 0 ) {
		comAjax.addParam("findAll","0");
	} else if( type == 1 ) {
		comAjax.addParam("findAll","1");
	}
	
	comAjax.addParam("txtHogi", '${BaseSearch.sHogi}');
	comAjax.addParam("searchStr", $("#findData").val());
	
	comAjax.setUrl("/markv/mimic/markvTagFind");
	comAjax.setCallback("tagFindMarkCallback");
	comAjax.ajax();
}

function getSaveCoreInfo(tagNo,iSeq) {
	var comAjax = new ComAjax("tagSearchForm");
	comAjax.addParam("sSeq", tagNo);	//iSeq 값 넣어야됨
	comAjax.addParam("sHogi", '${BaseSearch.sHogi}');
	comAjax.addParam("sScreenId", '${BaseSearch.sGrpID}');
	comAjax.addParam("sMenuNo", '${BaseSearch.sMenuNo}');
	comAjax.addParam("sGrpNo", '${BaseSearch.sUGrpNo}');
	
	comAjax.setUrl("/markv/mimic/getSaveCoreInfo");
	comAjax.setCallback("getSaveCoreInfoCallback");
	comAjax.ajax();
}

function getSaveCoreInfoCallback(data){
	
	if(data.saveCoreChk != null) rSaveCoreInfo = data.saveCoreChk.trim();
	
}

function saveTag() {
	var comSubmit = new ComSubmit("setIOForm");
	var frm = document.getElementById("setIOForm");
	
	comSubmit.addParam("rUrl", 'rotorprewarm');	//return param 해당파일명 입력
	comSubmit.addParam("sSeq", $("#txtTagNo").val());
	comSubmit.addParam("sTagNo", $("#txtTagNo").val());
	comSubmit.addParam("sHogi", '${BaseSearch.sHogi}');
	comSubmit.addParam("sScreenId", '${BaseSearch.sGrpID}');
	comSubmit.addParam("sMenuNo", '${BaseSearch.sMenuNo}');
	comSubmit.addParam("sGrpNo", '${BaseSearch.sUGrpNo}');
	comSubmit.addParam("txtCboCode", $("#txtCboCode option").size());
	
	if($("#txtD0").val() == 'undefined') {
		comSubmit.addParam("txtD0",frm.txtD0.value);
	}
	if($("#txtD1").val() == 'undefined') {
		comSubmit.addParam("txtD1",frm.txtD1.value);
	}
	if($("#txtBSCal").val() == 'undefined') {
		comSubmit.addParam("txtBSCal",frm.txtBSCal.value);
	}
	if($("#txtOptVal").val() == 'undefined') {
		comSubmit.addParam("txtOptVal",frm.txtOptVal.value);
	}
	
	comSubmit.setUrl("/markv/mimic/markvSaveTag");
	comSubmit.addParam("hogiHeader",hogiHeader);
	comSubmit.addParam("xyHeader",xyHeader);
	comSubmit.submit();
}

function showTag(tagNo,iSeq) {
	if(${UserInfo.grade} == '1' || ${UserInfo.grade} == '2') { // 나중에 grade 1 은 삭제할 것
		timerOn = false;
		$("#txtTagNo").val(tagNo);
		$("#txtIseq").val(iSeq);
		$("#txtSignalName").val(${MarkTagInfoList[tagNo].txtSignalName});
		$("#txtSignalDesc").val(${MarkTagInfoList[tagNo].txtSignalDesc});
		$("#txtD0").val(${MarkTagInfoList[tagNo].txtD0});
		$("#txtD1").val(${MarkTagInfoList[tagNo].txtD1});
		
		$("#tagNo").val(tagNo);
		var infos = tToolTipText[tagNo];
		$("#txtHogi").val(infos.substring(infos.indexOf('[')+1,infos.indexOf(':')));
        $("#txtDescr").val(infos.substring(0,infos.indexOf('[')));
        $("#txtIoType").val(infos.substring(infos.indexOf(':')+1,infos.indexOf('-')));
        $("#txtAddress").val(infos.substring(infos.indexOf('-')+1,infos.lastIndexOf(':')));
        $("#txtIoBit").val(infos.substring(infos.lastIndexOf(':')+1,infos.indexOf(']')));
        
        getSaveCoreInfo(tagNo,iSeq);
		openLayer('modal_1');
	} else {
		console.log('Not enough permission...');
	}
}

//showTag2 추가끝

</script>

</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-markv-header.jspf" %>
	<!-- header_wrap -->
		
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>ROTOR PREWARMING</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>ROTOR PREWARMING</strong></div>
			</div>
			<!-- //page_title -->

			
			<form id="modeselectionFrm" style="display:none"></form>
            <!-- fx_layout -->
            <div class="fx_layout w_full" id="rotorprewarmFrm_div">
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>ROTOR BORE TEMPERATURE</h4>
                        <div class="line_table_block">
                            <h5></h5>
                            <h5>AVTUAL</h5>
                            <h5>DESIRED</h5>
                        </div>
                        <div class="line_table_block">
                            <h6>HP</h6>
                            <div class="summary">
                                <p>
                                    <label id="0"><c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label id="3"><c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if></label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP INL</h6>
                            <div class="summary">
                                <p>
                                    <label id="1"><c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label id="4"><c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if></label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP EXH</h6>
                            <div class="summary">
                                <p>
                                    <label id="2"><c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label id="5"><c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if></label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h5>ROTOR</h5>
                            <h5>SURF TEMP</h5>
                            <h5>BORE TEMP RATE</h5>
                        </div>
                        <div class="line_table_block">
                            <h6>HP</h6>
                            <div class="summary">
                                <p>
                                    <label id="6"><c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label id="9"><c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if></label>
                                    <span>C/HR</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP INL</h6>
                            <div class="summary">
                                <p>
                                    <label id="7"><c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label id="10"><c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if></label>
                                    <span>C/HR</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP EXH</h6>
                            <div class="summary">
                                <p>
                                    <label id="8"><c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label id="11"><c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if></label>
                                    <span>C/HR</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h6 class="double">MAIN STEAM PRESSURE</h6>
                            <div class="summary">
                                <p>
                                    <label id="12"><c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if></label>
                                    <span>bar</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">MAIN STEAM TEMPERATURE</h6>
                            <div class="summary">
                                <p>
                                    <label id="13"><c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">ECCENTRICITY</h6>
                            <div class="summary">
                                <p>
                                    <label id="14"><c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if></label>
                                    <span>mm</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block center">
                    <div class="chart_wrap_area line" style="height:284px;">
                        <div class="barchart_layout no_line">
                            <div class="barchart_block">
                                <div class="barchart_item">
                                    <h6>CHEST PRESS</h6>
                                    <div class="barchart" style="width:120px;height:180px;">차트</div>
                                    <div class="summary">
                                        <p>
                                            <label id="15"><c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                    		<c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if></label>
                                            <span>bar</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="barchart_gap">
                            </div>
                            <div class="barchart_block">
                                <div class="barchart_item">
                                    <h6>HP EXH PRESS</h6>
                                    <div class="barchart" style="width:120px;height:180px;">차트</div>
                                    <div class="summary">
                                        <p>
                                            <label id="16"><c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                    		<c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if></label>
                                            <span>bar</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="barchart_gap">
                            </div>
                            <div class="barchart_block">
                                <div class="barchart_item">
                                    <h6>SPEED</h6>
                                    <div class="barchart" style="width:120px;height:180px;">차트</div> 
                                    <div class="summary">
                                        <p>
                                            <label id="17"><c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                    		<c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if></label>
                                            <span>rpm</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table" style="width:280px;">
                        <div class="line_table_block">
                            <h5>ROTOR PREWARMING</h5>
                        </div>
                        <div class="line_table_block">
                            <div class="summary">
                                <p class="side">
                                    <label id="19"><c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if></label>
                                    <span>MSV</span>
                                    <label id="20"><c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if></label>
                                    <label id="21"><c:if test="${lblDataList[21].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[21].fValue ne null}">${lblDataList[21].fValue}</c:if></label>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="rotor_off" name="switch_onoff" value="" checked/>
                                    <label class="full" for="rotor_off">OFF</label>
                                    <input type="radio" id="rotor_on" name="switch_onoff" value="" />
                                    <label class="full" for="rotor_on">ON</label>
                                </div>
                            </div>
                            <div class="block_item">
                                <div class="summary">
                                    <p>
                                        <label id="18"><c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                        <c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if></label>
                                        <span class="fx_none">%</span>
                                    </p>
                                </div>
                                <div class="switch_button">
                                    <input type="radio" id="rotor_raise" name="switch_rl" value="" checked/>
                                    <label class="full" for="rotor_raise">RAISE</label>
                                    <input type="radio" id="rotor_lower" name="switch_rl" value="" />
                                    <label class="full" for="rotor_lower">LOWER</label>
                                </div>
                            </div>
                        </div>
                    </div>                      
                </div>
            </div>
            <!-- //fx_layout -->
                
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->

<!-- showTag3 추가시작 -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태그정보</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <form id="setIOForm" name="setIOForm">
            <input type="hidden" id="txtISeq" name="txtISeq">
            <input type="hidden" id="txtIOBit" name="txtIOBit">
            <input type="hidden" id="txtHogi" name="txtHogi">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>태그번호</th>
                    <td>
                        <div class="fx_form">
                            <input type="text" id="txtTagNo" name="txtTagNo">
                            <a class="btn_list" herf="none" onclick="openLayer('modal_2');">태그찾기</a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>태그명</th>
                    <td><input type="text" id="txtSignalName" name="txtSignalName"></td>
                </tr>
                <tr>
                    <th>태그설명</th>
                    <td><input type="text" id="txtSignalDesc" name="txtSignalDesc"></td>
                </tr>
                <tr>
                    <th>표현방식</th>
                    <td>
                        <div class="fx_form_multi">
                            <div class="fx_form">
                                <label>
                                    <input type="radio" id="txtOptVal0" name="txtOptVal" value="0" checked="checked">
                                    수치표현
                                </label>
                                <label>
                                    <input type="radio" id="txtOptVal1" name="txtOptVal" value="1">
                                    문자표현
                                </label>
                                <label>
                                    <input type="radio" id="txtOptVal2" name="txtOptVal" value="2">
                                    문자표현(A)
                                </label>
                                <a class="btn_list" herf="none" onclick="openLayer('modal_3');">문자(A) 표현관리</a>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>소수점 자리수</th>
                    <td>
                        <select class="fx_none" style="width:120px;" id="txtBSCal" name="txtBSCal">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                        </select>                        
                    </td>
                </tr>
                <tr>
                    <th>0 상태 문자표현(0)</th>
                    <td><input type="text" id="txtD0" name="txtD0"></td>
                </tr>
                <tr>
                    <th>1 상태 문자표현(0)</th>
                    <td><input type="text" id="txtD1" name="txtD1"></td>
                </tr>
                <tr>
                    <th>문자표현(A)</th>
                    <td>
                        <div class="fx_form">
                            <select class="fx_none" style="width:260px;" id="txtCboCode" name="txtCboCode">
							    <c:forEach items="${tagComboCodeList}" var="tagComboCodeList">
							      <option value="${tagComboCodeList.code2}">${tagComboCodeList.codedesc}</option>
							    </c:forEach>
							</select>
                            <select class="fx_none" style="width:260px;" id="txtCboDesc" name="txtCboDesc" varStatus="status">
                                <c:forEach items="${tagComboDescList}" var="tagComboDescList">
							      <option value="${status.count}">${tagComboDescList.codedesc}</option>
							    </c:forEach>
                            </select>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
            </form>
        </div>
        <!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary" id="saveVarTable" name="saveVarTable">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
        <a href="#none" class="btn_page">Command1</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태그목록</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<form id="tagSearchForm" name="tagSearchForm">	
        <!-- fx_srch_wrap -->
        <div class="fx_srch_wrap">
            <div class="fx_srch_form">
                <div class="fx_srch_row">
                    <div class="fx_srch_item">
                        <label>검색옵션</label>
                        <div class="fx_form">
                            <label>
                                <input type="checkbox" id="chkOpt0" name="chkOpt0" value="1">
                                태그명
                            </label>
                            <label>
                                <input type="checkbox"  id="chkOpt1" name="chkOpt1" value="1">
                                태그설명
                            </label>
                        </div>
                    </div>
                    <div class="fx_srch_item">
                        <label>검색어</label>
                        <input type="text" id="findData" name="findData">
                    </div>
                </div>
            </div>
            <!-- fx_srch_button -->
            <div class="fx_srch_button">
                <a class="btn_srch" id="tagFind" name="tagFind">Search</a>
            </div>
            <!-- //fx_srch_button -->
        </div>
        </form>
        <!-- //fx_srch_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table_scroll -->
            <div class="list_table_scroll">                
                <!-- list_table -->
                <table class="list_table" id="tagSearchTable" name="tagSearchTable">
                    <colgroup>
                        <col width="130px"/>
                        <col width="130px"/>
                        <col width="130px"/>
                        <col width="130px"/>
                        <col width="130px"/>
                        <col width="130px"/>
                        <col width="130px"/>
                        <col width="130px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>ISEQ</th>
                            <th>REGI</th>
                            <th>BIT</th>
                            <th>태그명</th>
                            <th>태그설명</th>
                            <th>D0</th>
                            <th>D1</th>
                            <th>BSCALE</th>
                        </tr>
                    </thead>
                    <tbody id="tagSearchList" name="tagSearchList">
                        <tr>
                            <td class="tc" id="tagISeq" name="tagISeq"></td>
                            <td class="tc" id="tagRegister" name="tagRegister"></td>
                            <td class="tc" id="tagIOBit" name="tagIOBit"></td>
                            <td class="tc" id="tagSignalName" name="tagSignalName"></td>
                            <td class="tc" id="tagSignalDesc" name="tagSignalDesc"></td>
                            <td class="tc" id="tagD0" name="tagD0"></td>
                            <td class="tc" id="tagD1" name="tagD1"></td>
                            <td class="tc" id="tagBSCal" name="tagBSCal"></td>
                        </tr>
                    </tbody>
                </table>
                <!-- //list_table -->
            </div>
                <!-- //list_table_scroll -->
        </div>
        <!-- //list_wrap -->        
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page" id="tagFindAll" name="tagFindAll">전체리스트</a>
        <a href="#none" class="btn_page primary" id="tagSearchSelect" name="tagSearchSelect">선택</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_3">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>Analog 문자표현 그룹관리</h3>
        <a onclick="closeLayer('modal_3');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        
        <!-- layout_table -->
        <table class="layout_table">
            <colgroup>
                <col />
                <col />
            </colgroup>
            <tbody>
                <tr>
                    <td>

                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <h4>그룹목록</h4>
                            </div>
                            <!-- //list_head --> 
                        </div>                
                        <!-- fx_srch_wrap -->
                        <div class="fx_srch_wrap b_type">	
                            <div class="fx_srch_form">
                                <div class="fx_srch_row">
                                    <div class="fx_srch_item">
                                        <label>그룹</label>
                                        <div class="fx_form">
                                            <input type="text" class="fx_none" style="width:50px;">
                                            <input type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //fx_srch_wrap -->                
                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <!-- button -->
                                <div class="button">
                                    <a class="btn_list primary" href="#none">추가</a>
                                    <a class="btn_list" href="#none">수정</a>
                                    <a class="btn_list" href="#none">삭제</a>
                                </div>
                                <!-- button -->
                            </div>
                            <!-- //list_head -->            
                            <!-- list_table_scroll -->
                            <div class="list_table_scroll">
                                <!-- list_table -->
                                <table class="list_table">
                                    <colgroup>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <!-- //list_table -->
                            </div>
                                <!-- //list_table_scroll -->
                        </div>
                        <!-- //list_wrap -->
                        
                    </td>
                    <td>

                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <h4>표현문자목록</h4>
                            </div>
                            <!-- //list_head --> 
                        </div>                
                        <!-- fx_srch_wrap -->
                        <div class="fx_srch_wrap b_type">	
                            <div class="fx_srch_form">
                                <div class="fx_srch_row">
                                    <div class="fx_srch_item">
                                        <label>표현문자</label>
                                        <div class="fx_form">
                                            <input type="text" class="fx_none" style="width:50px;">
                                            <input type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //fx_srch_wrap -->                
                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <!-- button -->
                                <div class="button">
                                    <a class="btn_list primary" href="#none">추가</a>
                                    <a class="btn_list" href="#none">수정</a>
                                    <a class="btn_list" href="#none">삭제</a>
                                </div>
                                <!-- button -->
                            </div>
                            <!-- //list_head -->            
                            <!-- list_table_scroll -->
                            <div class="list_table_scroll">                
                                <!-- list_table -->
                                <table class="list_table">
                                    <colgroup>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <!-- //list_table -->
                            </div>
                                <!-- //list_table_scroll -->
                        </div>
                        <!-- //list_wrap -->
                        
                    </td>
                </tr>
            </tbody>
        </table>

	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">선택</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_3');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- showTag3 추가끝 -->


<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>
