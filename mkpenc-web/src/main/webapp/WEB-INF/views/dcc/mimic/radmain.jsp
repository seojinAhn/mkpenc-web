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
var timerOn = true //true로 변경
var hogiHeader = '${UserInfo.hogi}' != "undefined" && '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
var xyHeader = '${UserInfo.xyGubun}' != "undefined" && '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";

var tDccTagSeq = [
	${DccTagInfoList[0].iSeq},${DccTagInfoList[1].iSeq},${DccTagInfoList[2].iSeq},${DccTagInfoList[3].iSeq},${DccTagInfoList[4].iSeq},
	${DccTagInfoList[5].iSeq},${DccTagInfoList[6].iSeq},${DccTagInfoList[7].iSeq},${DccTagInfoList[8].iSeq},${DccTagInfoList[9].iSeq},
	${DccTagInfoList[10].iSeq},${DccTagInfoList[11].iSeq},${DccTagInfoList[12].iSeq},${DccTagInfoList[13].iSeq},${DccTagInfoList[14].iSeq},
	${DccTagInfoList[15].iSeq},${DccTagInfoList[16].iSeq},${DccTagInfoList[17].iSeq}
];
var tDccTagXy = [
	'${DccTagInfoList[0].XYGubun}','${DccTagInfoList[1].XYGubun}','${DccTagInfoList[2].XYGubun}','${DccTagInfoList[3].XYGubun}','${DccTagInfoList[4].XYGubun}',
	'${DccTagInfoList[5].XYGubun}','${DccTagInfoList[6].XYGubun}','${DccTagInfoList[7].XYGubun}','${DccTagInfoList[8].XYGubun}','${DccTagInfoList[9].XYGubun}',
	'${DccTagInfoList[10].XYGubun}','${DccTagInfoList[11].XYGubun}','${DccTagInfoList[12].XYGubun}','${DccTagInfoList[13].XYGubun}','${DccTagInfoList[14].XYGubun}',
	'${DccTagInfoList[15].XYGubun}','${DccTagInfoList[16].XYGubun}','${DccTagInfoList[17].XYGubun}'
];
var tToolTipText = [
	"${DccTagInfoList[0].toolTip}"	,"${DccTagInfoList[1].toolTip}"	,"${DccTagInfoList[2].toolTip}"	,"${DccTagInfoList[3].toolTip}"	,"${DccTagInfoList[4].toolTip}"
	,"${DccTagInfoList[5].toolTip}"	,"${DccTagInfoList[6].toolTip}"	,"${DccTagInfoList[7].toolTip}"	,"${DccTagInfoList[8].toolTip}"	,"${DccTagInfoList[9].toolTip}"
	,"${DccTagInfoList[10].toolTip}"	,"${DccTagInfoList[11].toolTip}"	,"${DccTagInfoList[12].toolTip}"	,"${DccTagInfoList[13].toolTip}"	,"${DccTagInfoList[14].toolTip}"
	,"${DccTagInfoList[15].toolTip}"	,"${DccTagInfoList[16].toolTip}"	,"${DccTagInfoList[17].toolTip}"	
];

var DccTagInfoListAjax = {};
var lblDataListAjax = {};

$(function () {
	$(document.body).delegate('#3', 'click', function() {
		hogiHeader = '3';
		
		var comAjax = new ComAjax("radmainFrm");
		comAjax.setUrl('/dcc/mimic/reloadRadmain');
		comAjax.addParam("sHogi",hogiHeader);
		comAjax.addParam("sXYGubun",xyHeader);
		comAjax.setCallback('mimicCallback');
		comAjax.ajax();
		
		setHideRef();
	});
	
	$(document.body).delegate('#4', 'click', function() {
		hogiHeader = '4';
		
		var comAjax = new ComAjax("radmainFrm");
		comAjax.setUrl('/dcc/mimic/reloadRadmain');
		comAjax.addParam("sHogi",hogiHeader);
		comAjax.addParam("sXYGubun",xyHeader);
		comAjax.setCallback('mimicCallback');
		comAjax.ajax();
		
		setHideRef();
	});
	
	$(document.body).delegate('#X', 'click', function() {
		xyHeader = 'X';
		
		var comAjax = new ComAjax("radmainFrm");
		comAjax.setUrl('/dcc/mimic/reloadRadmain');
		comAjax.addParam("sHogi",hogiHeader);
		comAjax.addParam("sXYGubun",xyHeader);
		comAjax.setCallback('mimicCallback');
		comAjax.ajax();
		
		setHideRef();
	});
	
	$(document.body).delegate('#Y', 'click', function() {
		xyHeader = 'Y';
		
		var comAjax = new ComAjax("radmainFrm");
		comAjax.setUrl('/dcc/mimic/reloadRadmain');
		comAjax.addParam("sHogi",hogiHeader);
		comAjax.addParam("sXYGubun",xyHeader);
		comAjax.setCallback('mimicCallback');
		comAjax.ajax();
		
		setHideRef();
	});

	setHideRef();
	
		var lblDateVal = '${SearchTime}';
		$("#lblDate").text(lblDateVal);
		$("#lblDate").css('color','${ForeColor}');
	
		$(document.body).delegate('#radmaindiv span', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			if( cId != null && cId != '' && cId != 'undefined' ) {
				//showTag(cId,tDccTagSeq[cId]);
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
		
		setTimer(5000);

});	

function setHideRef() {
	var isData = 0;
	var isUnit = 0;

	for( var i=7;i<11;i++ ) {
		if( $("#lblData"+i).text() != '' ) {
			isData++;
		}
		if( $("#lblUnit"+i).text() != '' ) {
			isUnit++;
		}
	}
	
	if( isData == 0 && isUnit == 0 ) {
		$("#divRef").css("display","none");
	} else {
		$("#divRef").css("display","");
	}
}


function setTimer(interval) {
	if( interval > 0 ) {
		setTimeout(function run() {
			if( timerOn ) {
				//var	comSubmit	=	new ComSubmit("radmainFrm");
				//comSubmit.setUrl("/dcc/mimic/radmain");
				//comSubmit.submit();
				var comAjax = new ComAjax("radmainFrm");
				comAjax.setUrl('/dcc/mimic/reloadRadmain');
				comAjax.addParam("sHogi",hogiHeader);
				comAjax.addParam("sXYGubun",xyHeader);
				comAjax.setCallback('mimicCallback');
				comAjax.ajax();
				
				setHideRef();
			}
			
			setTimeout(run, interval);
		},interval);
	} else {
		setTimeout(function run() {
			if( timerOn ) {
				//var	comSubmit	=	new ComSubmit("radmainFrm");
				//comSubmit.setUrl("/dcc/mimic/radmain");
				//comSubmit.submit();
				var comAjax = new ComAjax("radmainFrm");
				comAjax.setUrl('/dcc/mimic/reloadRadmain');
				comAjax.addParam("sHogi",hogiHeader);
				comAjax.addParam("sXYGubun",xyHeader);
				comAjax.setCallback('mimicCallback');
				comAjax.ajax();
				
				setHideRef();
			}
			
			setTimeout(run, 5000);
		},5000);
	}
}

function setData() {
	for( var i=0;i<lblDataListAjax.length;i++ ) {
		$("#lblData"+i).text(lblDataListAjax[i].fValue);
		$("#lblUnit"+i).text(DccTagInfoListAjax[i].unit);
		$("#lblData"+i).prop('title',DccTagInfoListAjax[i].toolTip);
	}
}

function setDate(time,color) {
	$("#lblDate").text(time);
	$("#lblDate").css('color',color);
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
	
	comSubmit.setUrl("/dcc/mimic/radmainSaveTag");
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
	var	comSubmit	=	new ComSubmit("radmainFrm");
	comSubmit.setUrl("/dcc/mimic/radmain");
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
	var	comSubmit = new ComSubmit("radmainFrm");
	comSubmit.setUrl("/dcc/mimic/radmainExcelExport");
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
				<h3>RADIATION SYSTEM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>RADIATION</span><strong>RADIATION SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap radiation_system" id="radmaindiv">
			<form id="radmainFrm" style="display:none">
			<input type="hidden" id="sDive" name="sDive" value="${BaseSearch.sDive}">
			<input type="hidden" id="sMenuNo" name="sMenuNo" value="${BaseSearch.sMenuNo}">
			<input type="hidden" id="sGrpID" name="sGrpID" value="${BaseSearch.sGrpID}">
			<input type="hidden" id="sUGrpNo" name="sUGrpNo" value="${BaseSearch.sUGrpNo}">	
			</form> 
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="/dcc/mimic/rbbase">RB Base</a></li>
                        <li><a href="/dcc/mimic/rb1f">RB 1F</a></li>
                        <li><a href="/dcc/mimic/rb2f">RB 2F</a></li>
                        <li><a href="/dcc/mimic/rb3f">RB 3F</a></li>
                        <li><a href="/dcc/mimic/rb4f">RB 4F</a></li>
                        <li><a href="/dcc/mimic/rb5f">RB 5F</a></li>
                        <li><a href="/dcc/mimic/sbbase">SB Base</a></li>
                    </ul>
                    <ul>
                        <li><a href="#none" onclick="javascript:toCSV();">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                  
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->
                <div class="chart_block small wide" style="top:140px;left:180px;">
                    <h4>배기중 방사능 농도</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>불활성 기체</span>
                                <span id="lblData13" title="${DccTagInfoList[13].toolTip}">${lblDataList[13].fValue}</span>
                                <span id="lblUnit13">${DccTagInfoList[13].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>삼중수소</span>
                                <span id="lblData14" title="${DccTagInfoList[14].toolTip}">${lblDataList[14].fValue}</span>
                                <span id="lblUnit14">${DccTagInfoList[14].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block small" style="top:40px;left:550px;">
                    <h4>기체폐기물 배출율</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span id="lblData0" title="${DccTagInfoList[0].toolTip}">${lblDataList[0].fValue}</span>
                                <span id="lblUnit0">${DccTagInfoList[0].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:40px;left:720px;">
                    <h4>금일방사능 배출량</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>입자</span>
                                <span id="lblData1" title="${DccTagInfoList[1].toolTip}">${lblDataList[1].fValue}</span>
                                <span id="lblUnit1">${DccTagInfoList[1].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>옥소</span>
                                <span id="lblData2" title="${DccTagInfoList[2].toolTip}">${lblDataList[2].fValue}</span>
                                <span id="lblUnit2">${DccTagInfoList[2].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>불활성 기체</span>
                                <span id="lblData3" title="${DccTagInfoList[3].toolTip}">${lblDataList[3].fValue}</span>
                                <span id="lblUnit3">${DccTagInfoList[3].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div id="divRef" class="chart_block small wider" style="top:0px;right:60px;display:none">
                    <h4>일일배출 제한치(DEL)에 대한 비율</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>기체 입자 : 5.18E-5 TBq 의</span>
                                <span id="lblData7" title="${DccTagInfoList[7].toolTip}">${lblDataList[7].fValue}</span>
                                <span id="lblUnit7">${DccTagInfoList[7].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>기체 옥소 : 2.22E-5 TBq 의</span>
                                <span id="lblData8 title="${DccTagInfoList[8].toolTip}">${lblDataList[8].fValue}</span>
                                <span id="lblUnit8">${DccTagInfoList[8].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>불활성 기체 : 2.26E+0 TBq Mev의</span>
                                <span id="lblData9" title="${DccTagInfoList[9].toolTip}">${lblDataList[9].fValue}</span>
                                <span id="lblUnit9">${DccTagInfoList[9].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>액체 전베타.감마: 2.70E-4 TBq 의</span>
                                <span id="lblData10" title="${DccTagInfoList[10].toolTip}">${lblDataList[10].fValue}</span>
                                <span id="lblUnit10">${DccTagInfoList[10].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:150px;right:160px;">
                    <h4>금일방사능 배출량</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>입자</span>
                                <span id="lblData4" title="${DccTagInfoList[4].toolTip}">${lblDataList[4].fValue}</span>
                                <span id="lblUnit4">${DccTagInfoList[4].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>옥소</span>
                                <span id="lblData5" title="${DccTagInfoList[5].toolTip}">${lblDataList[5].fValue}</span>
                                <span id="lblUnit5">${DccTagInfoList[5].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>불활성 기체</span>
                                <span id="lblData6" title="${DccTagInfoList[6].toolTip}">${lblDataList[6].fValue}</span>
                                <span id="lblUnit6">${DccTagInfoList[6].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="bottom:160px;right:60px;">
                    <h4>액체배출 유량</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                        <c:if test="${lblDataList[11].fValue ne null or DccTagInfoList[11].unit ne null}">
                            <p>
                                <span></span>
                                <span id="lblData11" title="${DccTagInfoList[11].toolTip}">${lblDataList[11].fValue}</span>
                                <span id="lblUnit11">${DccTagInfoList[11].unit}</span>
                            </p>
                        </div>
                        </c:if>
                        <c:if test="${lblDataList[11].fValue eq null and DccTagInfoList[11].unit eq null}">
                            <p>
                                <span></span>
                                <span id="lblData11" title="" style="color:#ffffff">N/A</span>
                                <span id="lblUnit11"></span>
                            </p>
                        </div>
                        </c:if>
                    </div>
                </div>
                <div class="chart_block small wide" style="bottom:60px;right:60px;">
                    <h4>금일 방사능 배출량</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>전베타.감마</span>
                                <span id="lblData12" title="${DccTagInfoList[12].toolTip}">${lblDataList[12].fValue}</span>
                                <span id="lblUnit12">${DccTagInfoList[12].unit}</span>
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
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

