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
	${DccTagInfoList[5].iSeq},${DccTagInfoList[6].iSeq},${DccTagInfoList[7].iSeq}
];
var tDccTagXy = [
	'${DccTagInfoList[0].XYGubun}','${DccTagInfoList[1].XYGubun}','${DccTagInfoList[2].XYGubun}','${DccTagInfoList[3].XYGubun}','${DccTagInfoList[4].XYGubun}',
	'${DccTagInfoList[5].XYGubun}','${DccTagInfoList[6].XYGubun}','${DccTagInfoList[7].XYGubun}'
];
var tToolTipText = [
	"${DccTagInfoList[0].toolTip}"	,"${DccTagInfoList[1].toolTip}"	,"${DccTagInfoList[2].toolTip}"	,"${DccTagInfoList[3].toolTip}"	,"${DccTagInfoList[4].toolTip}"
	,"${DccTagInfoList[5].toolTip}"	,"${DccTagInfoList[6].toolTip}"	,"${DccTagInfoList[7].toolTip}"	
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
		$(document.body).delegate('#rb1fdiv span', 'dblclick', function() {
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
				var	comSubmit	=	new ComSubmit("rb1fFrm");
				comSubmit.setUrl("/dcc/mimic/rb1f");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("rb1fFrm");
		comSubmit.setUrl("/dcc/mimic/rb1f");
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
	
	comSubmit.setUrl("/dcc/mimic/rb1fSaveTag");
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
	var	comSubmit	=	new ComSubmit("rb1fFrm");
	comSubmit.setUrl("/dcc/mimic/rb1f");
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
	var	comSubmit = new ComSubmit("rb1fFrm");
	comSubmit.setUrl("/dcc/mimic/rb1fExcelExport");
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
				<h3>RB 1F</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>RADIATION</span><strong>RB 1F</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap rb_1f" id="rb1fdiv">
			<form id="rb1fFrm" style="display:none"></form> 
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- //range_slider -->       
                <div class="toggle_block chart_block small wide" style="top:156px;left:370px;">
                    <h4>RT-05 (R-104)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span id="0">${lblDataList[0].fValue}</span>
                                <span>${DccTagInfoList[0].unit}</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>${DccTagInfoList[0].DataLimit1}</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>${DccTagInfoList[0].DataLimit2}</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:220px;left:150px;">
                    <h4>RT-18 (R-114)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span id="3">${lblDataList[3].fValue}</span>
                                <span>${DccTagInfoList[3].unit}</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>${DccTagInfoList[3].DataLimit1}</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>${DccTagInfoList[3].DataLimit2}</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:300px;left:304px;">
                    <h4>RT-01 (R-001)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span id="2">${lblDataList[2].fValue}</span>
                                <span>${DccTagInfoList[2].unit}</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>${DccTagInfoList[2].DataLimit1}</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>${DccTagInfoList[2].DataLimit2}</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:400px;left:150px;">
                    <h4>RT-19 (R-115)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span id="1">${lblDataList[1].fValue}</span>
                                <span>${DccTagInfoList[1].unit}</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>${DccTagInfoList[1].DataLimit1}</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>${DccTagInfoList[1].DataLimit2}</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:480px;left:370px;">
                    <h4>RT-04 (R-103)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span id="4">${lblDataList[4].fValue}</span>
                                <span>${DccTagInfoList[4].unit}</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>${DccTagInfoList[4].DataLimit1}</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>${DccTagInfoList[4].DataLimit2}</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:150px;right:330px;">
                    <h4>RT-08 (R-108)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span id="7">${lblDataList[7].fValue}</span>
                                <span>${DccTagInfoList[7].unit}</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>${DccTagInfoList[7].DataLimit1}</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>${DccTagInfoList[7].DataLimit2}</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:314px;right:270px;">
                    <h4>RT-11 (R-112)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span id="6">${lblDataList[6].fValue}</span>
                                <span>${DccTagInfoList[6].unit}</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>${DccTagInfoList[6].DataLimit1}</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>${DccTagInfoList[6].DataLimit2}</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:464px;right:330px;">
                    <h4>RT-06</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span id="5">${lblDataList[5].fValue}</span>
                                <span>${DccTagInfoList[5].unit}</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>${DccTagInfoList[5].DataLimit1}</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>${DccTagInfoList[5].DataLimit2}</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
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

