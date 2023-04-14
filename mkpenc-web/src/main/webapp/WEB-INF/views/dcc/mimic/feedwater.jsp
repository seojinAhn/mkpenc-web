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
	${DccTagInfoList[30].iSeq},${DccTagInfoList[31].iSeq},${DccTagInfoList[32].iSeq},${DccTagInfoList[33].iSeq},${DccTagInfoList[34].iSeq},
	${DccTagInfoList[35].iSeq},${DccTagInfoList[36].iSeq},${DccTagInfoList[37].iSeq},${DccTagInfoList[38].iSeq},${DccTagInfoList[39].iSeq},
	${DccTagInfoList[40].iSeq}
];
var tDccTagXy = [
	'${DccTagInfoList[0].XYGubun}','${DccTagInfoList[1].XYGubun}','${DccTagInfoList[2].XYGubun}','${DccTagInfoList[3].XYGubun}','${DccTagInfoList[4].XYGubun}',
	'${DccTagInfoList[5].XYGubun}','${DccTagInfoList[6].XYGubun}','${DccTagInfoList[7].XYGubun}','${DccTagInfoList[8].XYGubun}','${DccTagInfoList[9].XYGubun}',
	'${DccTagInfoList[10].XYGubun}','${DccTagInfoList[11].XYGubun}','${DccTagInfoList[12].XYGubun}','${DccTagInfoList[13].XYGubun}','${DccTagInfoList[14].XYGubun}',
	'${DccTagInfoList[15].XYGubun}','${DccTagInfoList[16].XYGubun}','${DccTagInfoList[17].XYGubun}','${DccTagInfoList[18].XYGubun}','${DccTagInfoList[19].XYGubun}',
	'${DccTagInfoList[20].XYGubun}','${DccTagInfoList[21].XYGubun}','${DccTagInfoList[22].XYGubun}','${DccTagInfoList[23].XYGubun}','${DccTagInfoList[24].XYGubun}',
	'${DccTagInfoList[25].XYGubun}','${DccTagInfoList[26].XYGubun}','${DccTagInfoList[27].XYGubun}','${DccTagInfoList[28].XYGubun}','${DccTagInfoList[29].XYGubun}',
	'${DccTagInfoList[30].XYGubun}','${DccTagInfoList[31].XYGubun}','${DccTagInfoList[32].XYGubun}','${DccTagInfoList[33].XYGubun}','${DccTagInfoList[34].XYGubun}',
	'${DccTagInfoList[35].XYGubun}','${DccTagInfoList[36].XYGubun}','${DccTagInfoList[37].XYGubun}','${DccTagInfoList[38].XYGubun}','${DccTagInfoList[39].XYGubun}',
	'${DccTagInfoList[40].XYGubun}'
];
var tToolTipText = [
	"${DccTagInfoList[0].toolTip}"	,"${DccTagInfoList[1].toolTip}"	,"${DccTagInfoList[2].toolTip}"	,"${DccTagInfoList[3].toolTip}"	,"${DccTagInfoList[4].toolTip}"
	,"${DccTagInfoList[5].toolTip}"	,"${DccTagInfoList[6].toolTip}"	,"${DccTagInfoList[7].toolTip}"	,"${DccTagInfoList[8].toolTip}"	,"${DccTagInfoList[9].toolTip}"
	,"${DccTagInfoList[10].toolTip}"	,"${DccTagInfoList[11].toolTip}"	,"${DccTagInfoList[12].toolTip}"	,"${DccTagInfoList[13].toolTip}"	,"${DccTagInfoList[14].toolTip}"
	,"${DccTagInfoList[15].toolTip}"	,"${DccTagInfoList[16].toolTip}"	,"${DccTagInfoList[17].toolTip}"	,"${DccTagInfoList[18].toolTip}"	,"${DccTagInfoList[19].toolTip}"
	,"${DccTagInfoList[20].toolTip}"	,"${DccTagInfoList[21].toolTip}"	,"${DccTagInfoList[22].toolTip}"	,"${DccTagInfoList[23].toolTip}"	,"${DccTagInfoList[24].toolTip}"
	,"${DccTagInfoList[25].toolTip}"	,"${DccTagInfoList[26].toolTip}"	,"${DccTagInfoList[27].toolTip}"	,"${DccTagInfoList[28].toolTip}"	,"${DccTagInfoList[29].toolTip}"
	,"${DccTagInfoList[30].toolTip}"	,"${DccTagInfoList[31].toolTip}"	,"${DccTagInfoList[32].toolTip}"	,"${DccTagInfoList[33].toolTip}"	,"${DccTagInfoList[34].toolTip}"
	,"${DccTagInfoList[35].toolTip}"	,"${DccTagInfoList[36].toolTip}"	,"${DccTagInfoList[37].toolTip}"	,"${DccTagInfoList[38].toolTip}"	,"${DccTagInfoList[39].toolTip}"
	,"${DccTagInfoList[40].toolTip}"	
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

		$(document.body).delegate('#feedwaterdiv span', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			if( cId != null && cId != '' && cId != 'undefined' ) {
				showTag(cId,tDccTagSeq[cId]);
			}
		});
		$(document.body).delegate('#feedwaterdiv label', 'dblclick', function() {
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
				var	comSubmit	=	new ComSubmit("feedwaterFrm");
				comSubmit.setUrl("/dcc/mimic/feedwater");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("feedwaterFrm");
		comSubmit.setUrl("/dcc/mimic/feedwater");
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
	
	comSubmit.setUrl("/dcc/mimic/feedwaterSaveTag");
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
	var	comSubmit	=	new ComSubmit("feedwaterFrm");
	comSubmit.setUrl("/dcc/mimic/feedwater");
	comSubmit.submit();
}

var selectTag = [{name:"hogi",value:""},{name:"xyGubun",value:""},{name:"loopName",value:""},{name:"ioType",value:""}
				,{name:"address",value:""},{name:"ioBit",value:""},{name:"descr",value:""}];


function showTag(tagNo,iSeq) {
	
	if(${UserInfo.grade} == '1' || ${UserInfo.grade} == '2') { // 나중에 grade 1 은 삭제할 것
		timerOn = false;
	
		$("#tagNo").val(tagNo);
		
		var toolTip = tToolTipText[tagNo];
		var strDescr = toolTip.substring(0, toolTip.lastIndexOf('['));
		var infos =  toolTip.substring(toolTip.lastIndexOf('[')+1, toolTip.lastIndexOf(']')).split(":");

		$("#txtHogi").val(infos[0]);
        $("#txtXyGubun").val(tDccTagXy[tagNo]);
        $("#txtDescr").val(strDescr);
        $("#txtIoType").val(infos[1].substring(0,infos[1].indexOf('-')));
        $("#txtAddress").val(infos[1].substring(infos[1].indexOf('-')+1));
        if(infos[2] != null){
         	$("#txtIoBit").val(infos[2]);
        }else {
         	$("#txtIoBit").val("");
        }
        
		openLayer('modal_2');
	} else {
		console.log('Not enough permission...');
	}
}	

function toCSV() {
	var	comSubmit = new ComSubmit("feedwaterFrm");
	comSubmit.setUrl("/dcc/mimic/feedwaterExcelExport");
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
				<h3>FEED WATER</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>SECONDARY</span><strong>FEED WATER</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap feed_water" id="feedwaterdiv">
			<form id="feedwaterFrm" style="display:none"></form> 
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="/dcc/mimic/mainsteam" class="link_txt" style="top:34px;right:170px;">SG Main System<br>Pressure System</a>
                <a href="/dcc/mimic/condensate" class="link_txt" style="top:384px;right:170px;">Condensate System</a>
                <!-- ///range_slider -->              
                <div class="chart_block small" style="top:76px;left:256px;">
                    <h4>SG 1</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label id="0">${lblDataList[0].fValue}</label>
                                <span>${DccTagInfoList[0].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LE</span>
                                <label id="1">${lblDataList[1].fValue}</label>
                                <span>${DccTagInfoList[1].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>INT</span>
                                <label id="2">${lblDataList[2].fValue}</label>
                                <span>${DccTagInfoList[2].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W T</span>
                                <label id="3">${lblDataList[3].fValue}</label>
                                <span>${DccTagInfoList[3].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W F</span>
                                <label id="4">${lblDataList[4].fValue}</label>
                                <span>${DccTagInfoList[4].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:76px;left:490px;">
                    <h4>SG 2</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label id="8">${lblDataList[8].fValue}</label>
                                <span>${DccTagInfoList[8].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LE</span>
                                <label id="9">${lblDataList[9].fValue}</label>
                                <span>${DccTagInfoList[9].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>INT</span>
                                <label id="10">${lblDataList[10].fValue}</label>
                                <span>${DccTagInfoList[10].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W T</span>
                                <label id="11">${lblDataList[11].fValue}</label>
                                <span>${DccTagInfoList[11].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W F</span>
                                <label id="12">${lblDataList[12].fValue}</label>
                                <span>${DccTagInfoList[12].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:76px;left:726px;">
                    <h4>SG 3</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label id="16">${lblDataList[16].fValue}</label>
                                <span>${DccTagInfoList[16].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LE</span>
                                <label id="17">${lblDataList[17].fValue}</label>
                                <span>${DccTagInfoList[17].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>INT</span>
                                <label id="18">${lblDataList[18].fValue}</label>
                                <span>${DccTagInfoList[18].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W T</span>
                                <label id="19">${lblDataList[19].fValue}</label>
                                <span>${DccTagInfoList[19].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W F</span>
                                <label id="20">${lblDataList[20].fValue}</label>
                                <span>${DccTagInfoList[20].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:76px;right:256px;">
                    <h4>SG 4</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label id="24">${lblDataList[24].fValue}</label>
                                <span>${DccTagInfoList[24].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LE</span>
                                <label id="25">${lblDataList[25].fValue}</label>
                                <span>${DccTagInfoList[25].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>INT</span>
                                <label id="26">${lblDataList[26].fValue}</label>
                                <span>${DccTagInfoList[26].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W T</span>
                                <label id="27">${lblDataList[27].fValue}</label>
                                <span>${DccTagInfoList[27].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W F</span>
                                <label id="28">${lblDataList[28].fValue}</label>
                                <span>${DccTagInfoList[28].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block small" style="top:470px;left:214px;">
                    <h4>Pp 101 Flow</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Disch</span>
                                <label id="32">${lblDataList[32].fValue}</label>
                                <span>${DccTagInfoList[32].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REC</span>
                                <label id="33">${lblDataList[33].fValue}</label>
                                <span>${DccTagInfoList[33].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:470px;left:424px;">
                    <h4>Pp 102 Flow</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Disch</span>
                                <label id="34">${lblDataList[34].fValue}</label>
                                <span>${DccTagInfoList[34].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REC</span>
                                <label id="35">${lblDataList[35].fValue}</label>
                                <span>${DccTagInfoList[35].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:470px;left:608px;">
                    <h4>Pp 103 Flow</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Disch</span>
                                <label id="36">${lblDataList[36].fValue}</label>
                                <span>${DccTagInfoList[36].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REC</span>
                                <label id="37">${lblDataList[37].fValue}</label>
                                <span>${DccTagInfoList[37].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:504px;left:808px;">
                    <h4>Pp 104 Flow</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Disch</span>
                                <label id="38">${lblDataList[38].fValue}</label>
                                <span>${DccTagInfoList[38].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REC</span>
                                <label id="39">${lblDataList[39].fValue}</label>
                                <span>${DccTagInfoList[39].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:460px;right:168px;">
                    <h4>Deaerator</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label id="40">${lblDataList[40].fValue}</label>
                                <span>${DccTagInfoList[40].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:170px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="5">${lblDataList[5].fValue}</span>
                                <span>${DccTagInfoList[5].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:240px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="6">${lblDataList[6].fValue}</span>
                                <span>${DccTagInfoList[6].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:308px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="7">${lblDataList[7].fValue}</span>
                                <span>${DccTagInfoList[7].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:408px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="13">${lblDataList[13].fValue}</span>
                                <span>${DccTagInfoList[13].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:476px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="14">${lblDataList[14].fValue}</span>
                                <span>${DccTagInfoList[14].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:546px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="15">${lblDataList[15].fValue}</span>
                                <span>${DccTagInfoList[15].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:646px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="21">${lblDataList[21].fValue}</span>
                                <span>${DccTagInfoList[21].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:716px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="22">${lblDataList[22].fValue}</span>
                                <span>${DccTagInfoList[22].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:784px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="23">${lblDataList[23].fValue}</span>
                                <span>${DccTagInfoList[23].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:884px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="29">${lblDataList[29].fValue}</span>
                                <span>${DccTagInfoList[29].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:956px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="30">${lblDataList[30].fValue}</span>
                                <span>${DccTagInfoList[30].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:1028px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span id="31">${lblDataList[31].fValue}</span>
                                <span>${DccTagInfoList[31].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
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

