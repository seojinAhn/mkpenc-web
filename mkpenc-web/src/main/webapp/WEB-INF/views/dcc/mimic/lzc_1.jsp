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

var timerOn = true; //true로 변경
var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

var tDccTagSeq = [
	${DccTagInfoList[0].iSeq},${DccTagInfoList[1].iSeq},${DccTagInfoList[2].iSeq},${DccTagInfoList[3].iSeq},${DccTagInfoList[4].iSeq},
	${DccTagInfoList[5].iSeq},${DccTagInfoList[6].iSeq},${DccTagInfoList[7].iSeq},${DccTagInfoList[8].iSeq},${DccTagInfoList[9].iSeq},
	${DccTagInfoList[10].iSeq},${DccTagInfoList[11].iSeq},${DccTagInfoList[12].iSeq},${DccTagInfoList[13].iSeq}
];
var tDccTagXy = [
	'${DccTagInfoList[0].XYGubun}','${DccTagInfoList[1].XYGubun}','${DccTagInfoList[2].XYGubun}','${DccTagInfoList[3].XYGubun}','${DccTagInfoList[4].XYGubun}',
	'${DccTagInfoList[5].XYGubun}','${DccTagInfoList[6].XYGubun}','${DccTagInfoList[7].XYGubun}','${DccTagInfoList[8].XYGubun}','${DccTagInfoList[9].XYGubun}',
	'${DccTagInfoList[10].XYGubun}','${DccTagInfoList[11].XYGubun}','${DccTagInfoList[12].XYGubun}','${DccTagInfoList[13].XYGubun}'
];


var tToolTipText = [
	"${DccTagInfoList[0].toolTip}"	,"${DccTagInfoList[1].toolTip}"	,"${DccTagInfoList[2].toolTip}"	,"${DccTagInfoList[3].toolTip}"
	,"${DccTagInfoList[4].toolTip}"	,"${DccTagInfoList[5].toolTip}"	,"${DccTagInfoList[6].toolTip}"	,"${DccTagInfoList[7].toolTip}"
	,"${DccTagInfoList[8].toolTip}"	,"${DccTagInfoList[9].toolTip}"	,"${DccTagInfoList[10].toolTip}"	,"${DccTagInfoList[11].toolTip}"
	,"${DccTagInfoList[12].toolTip}"	,"${DccTagInfoList[13].toolTip}"
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
	
	$(document.body).delegate('#lzc_1div span', 'dblclick', function() {
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
				var	comSubmit	=	new ComSubmit("lzc_1Frm");
				comSubmit.setUrl("/dcc/mimic/lzc_1");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("lzc_1Frm");
		comSubmit.setUrl("/dcc/mimic/lzc_1");
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
	
	comSubmit.setUrl("/dcc/mimic/lzc_1SaveTag");
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
	var	comSubmit	=	new ComSubmit("lzc_1Frm");
	comSubmit.setUrl("/dcc/mimic/lzc_1");
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
	var	comSubmit = new ComSubmit("lzc_1Frm");
	comSubmit.setUrl("/dcc/mimic/lzc_1ExcelExport");
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
				<h3>LIQUID ZONE CONTROL SYSTEM I</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>PRIMARY</span><strong>LIQUID ZONE CONTROL SYSTEM I</strong></div>
			</div>
			<!-- //page_title -->
			
			<div class="img_wrap lzc_i" id="lzc_1div">
			<form id="lzc_1Frm" style="display:none"></form> 
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="/dcc/mimic/lzc_2" class="link_btn link_01"></a>
                <!-- ///range_slider -->    
      
                <div class="chart_block" style="top:20px;left:150px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                             <p>
                                <span>P : </span>
                                <span id="0">${lblDataList[0].fValue} &nbsp;${DccTagInfoList[0].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:200px;left:270px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
	                          <p>
	                             <span>P : </span>
	                             <span id="0">${lblDataList[1].fValue} &nbsp;${DccTagInfoList[1].unit}</span>
	                          </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="bottom:120px;left:320px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>T : </span>
                                <span id="10">${lblDataList[10].fValue} &nbsp;${DccTagInfoList[10].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="bottom:120px;left:320px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>C : </span>
                                <span id="8">${lblDataList[8].fValue} &nbsp;${DccTagInfoList[8].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:30px;right:540px;">
                    <h4>R.U</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>In T : </span>
                                <span id="2">${lblDataList[2].fValue} &nbsp;${DccTagInfoList[2].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Out T</span>
                                <span id="4">${lblDataList[4].fValue} &nbsp;${DccTagInfoList[4].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:320px;left:425px;">
                    <h4>Delay Tank</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span id="6">${lblDataList[6].fValue} &nbsp;${DccTagInfoList[6].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>P</span>
                                <span id="7">${lblDataList[7].fValue} &nbsp;${DccTagInfoList[7].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:150px;right:250px;">
                    <h4>He Tank</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>P : </span>
                                <span id="3">${lblDataList[3].fValue} &nbsp;${DccTagInfoList[3].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span id="5">${lblDataList[5].fValue} &nbsp;${DccTagInfoList[5].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:450px;right:150px;">
                    <h4>H2O Pp Disch</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Pr. A</span>
                                <span id="11">${lblDataList[11].fValue} &nbsp;${DccTagInfoList[11].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>B</span>
                                <span id="12">${lblDataList[12].fValue} &nbsp;${DccTagInfoList[12].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>C</span>
                                <span id="13">${lblDataList[13].fValue} &nbsp;${DccTagInfoList[13].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span id="9">${lblDataList[9].fValue} &nbsp;${DccTagInfoList[9].unit}</span>
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

