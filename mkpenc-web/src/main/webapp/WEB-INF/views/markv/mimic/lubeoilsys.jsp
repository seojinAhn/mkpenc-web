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

var tMarkTagSeq = [	
	${MarkTagInfoList[0].iSeq},${MarkTagInfoList[1].iSeq},${MarkTagInfoList[2].iSeq},${MarkTagInfoList[3].iSeq},${MarkTagInfoList[4].iSeq},
	${MarkTagInfoList[5].iSeq},${MarkTagInfoList[6].iSeq},${MarkTagInfoList[7].iSeq},${MarkTagInfoList[8].iSeq},${MarkTagInfoList[9].iSeq},
	${MarkTagInfoList[10].iSeq},${MarkTagInfoList[11].iSeq}
];

var tMarkTagXy = [
	'${MarkTagInfoList[0].XYGubun}','${MarkTagInfoList[1].XYGubun}','${MarkTagInfoList[2].XYGubun}','${MarkTagInfoList[3].XYGubun}','${MarkTagInfoList[4].XYGubun}',
	'${MarkTagInfoList[5].XYGubun}','${MarkTagInfoList[6].XYGubun}','${MarkTagInfoList[7].XYGubun}','${MarkTagInfoList[8].XYGubun}','${MarkTagInfoList[9].XYGubun}',
	'${MarkTagInfoList[10].XYGubun}','${MarkTagInfoList[11].XYGubun}'
];


var tToolTipText = [
	"${MarkTagInfoList[0].toolTip}"	,"${MarkTagInfoList[1].toolTip}"	,"${MarkTagInfoList[2].toolTip}"	,"${MarkTagInfoList[3].toolTip}"
	,"${MarkTagInfoList[4].toolTip}"	,"${MarkTagInfoList[5].toolTip}"	,"${MarkTagInfoList[6].toolTip}"	,"${MarkTagInfoList[7].toolTip}"
	,"${MarkTagInfoList[8].toolTip}"	,"${MarkTagInfoList[9].toolTip}"	,"${MarkTagInfoList[10].toolTip}"	,"${MarkTagInfoList[11].toolTip}"	
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

	$(document.body).delegate('#lubeoilsys_div span', 'dblclick', function() {		
		var cId = this.id.indexOf('fValue') > -1 ? this.id.substring(4) : this.id;
		if( cId != null && cId != '' && cId != 'undefined' ) {
			showTag(cId,tMarkTagSeq[cId]);
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
	
	setTimer(hogiHeader,xyHeader,5000);

});	

function setTimer(hogiHeader,xyHeader,interval) {
	if( interval > 0 ) {
		setTimeout(function() {
			if( timerOn ) {
				var	comSubmit	=	new ComSubmit("lubeoilsysFrm");
				comSubmit.setUrl("/markv/mimic/lubeoilsys");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("lubeoilsysFrm");
		comSubmit.setUrl("/markv/mimic/lubeoilsys");
		comSubmit.addParam("hogiHeader",hogiHeader);
		comSubmit.addParam("xyHeader",xyHeader);
		comSubmit.submit();
	}
}


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
	//var radioVal = $('input[name=txtOptVal]:checked').val();
	
	comSubmit.addParam("sSeq", $("#txtTagNo").val());
	comSubmit.addParam("sTagNo", $("#txtTagNo").val());
	comSubmit.addParam("sHogi", '${BaseSearch.sHogi}');
	comSubmit.addParam("sScreenId", '${BaseSearch.sGrpID}');
	comSubmit.addParam("sMenuNo", '${BaseSearch.sMenuNo}');
	comSubmit.addParam("sGrpNo", '${BaseSearch.sUGrpNo}');
	comSubmit.addParam("rUrl", 'lubeoilsys');
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
	$("#setIOForm")[0].reset();
	
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
				<h3>LUBE OIL SYSTEM</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><strong>LUBE OIL SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<form id="lubeoilsysFrm" style="display:none"></form>
			<div class="img_wrap lube_oil_sys" id="lubeoilsys_div">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->
                <div class="chart_block small single" style="top:202px;left:324px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span id="0" class="fx_full" ><c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if></span>
                                <span>bar</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:246px;left:324px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span id="1" class="fx_full"><c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if></span>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:128px;left:846px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span id="3" class="fx_full"><c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if></span>
                                <span>rpm</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:310px;right:160px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span id="9" class="fx_full"><c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if></span>
                                <span></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:560px;right:160px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span id="10" class="fx_full"><c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if></span>
                                <span>bar</span>
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


<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

