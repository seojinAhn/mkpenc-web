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
	var timerOn = true;
	var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
	var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";
	
	var tDccTagSeq = [
		${DccTagInfoList[0].iSeq},${DccTagInfoList[1].iSeq},${DccTagInfoList[2].iSeq},${DccTagInfoList[3].iSeq},${DccTagInfoList[4].iSeq},
		${DccTagInfoList[5].iSeq},${DccTagInfoList[6].iSeq},${DccTagInfoList[7].iSeq},${DccTagInfoList[8].iSeq},${DccTagInfoList[9].iSeq},
		${DccTagInfoList[10].iSeq},${DccTagInfoList[11].iSeq},${DccTagInfoList[12].iSeq},${DccTagInfoList[13].iSeq},${DccTagInfoList[14].iSeq},
		${DccTagInfoList[15].iSeq},${DccTagInfoList[16].iSeq},${DccTagInfoList[17].iSeq},${DccTagInfoList[18].iSeq},${DccTagInfoList[19].iSeq}
	];
	
	var tDccTagXy = [
		'${DccTagInfoList[0].XYGubun}','${DccTagInfoList[1].XYGubun}','${DccTagInfoList[2].XYGubun}','${DccTagInfoList[3].XYGubun}','${DccTagInfoList[4].XYGubun}',
		'${DccTagInfoList[5].XYGubun}','${DccTagInfoList[6].XYGubun}','${DccTagInfoList[7].XYGubun}','${DccTagInfoList[8].XYGubun}','${DccTagInfoList[9].XYGubun}',
		'${DccTagInfoList[10].XYGubun}','${DccTagInfoList[11].XYGubun}','${DccTagInfoList[12].XYGubun}','${DccTagInfoList[13].XYGubun}','${DccTagInfoList[14].XYGubun}',
		'${DccTagInfoList[15].XYGubun}','${DccTagInfoList[16].XYGubun}','${DccTagInfoList[17].XYGubun}','${DccTagInfoList[18].XYGubun}','${DccTagInfoList[19].XYGubun}'
	];
	
	var tToolTipText = [
		"${DccTagInfoList[0].toolTip}"		,"${DccTagInfoList[1].toolTip}"		,"${DccTagInfoList[2].toolTip}"		,"${DccTagInfoList[3].toolTip}"		,"${DccTagInfoList[4].toolTip}"
		,"${DccTagInfoList[5].toolTip}"		,"${DccTagInfoList[6].toolTip}"		,"${DccTagInfoList[7].toolTip}"		,"${DccTagInfoList[8].toolTip}"		,"${DccTagInfoList[9].toolTip}"
		,"${DccTagInfoList[10].toolTip}"		,"${DccTagInfoList[11].toolTip}"		,"${DccTagInfoList[12].toolTip}"		,"${DccTagInfoList[13].toolTip}"		,"${DccTagInfoList[14].toolTip}"
		,"${DccTagInfoList[15].toolTip}"		,"${DccTagInfoList[16].toolTip}"		,"${DccTagInfoList[17].toolTip}"		,"${DccTagInfoList[18].toolTip}"		,"${DccTagInfoList[19].toolTip}"
	];
	
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
	
	function showTooltip(id) {
		var tooltipText;

		tooltipText = tToolTipText[id*1];
		
		if( tooltipText.indexOf(":]") > -1 ) {
			tooltipText = tooltipText.replace(":]","]");
		}
		$("#"+id).attr("title",tooltipText);
	}
	
	function toCSV() {
		var	comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl("/dcc/status/sgpExcelExport");
		comSubmit.submit();
	}

	$(function(){
		if( $("#hogiHeader4").attr("class") == 'current' && $("#hogiHeader4").attr("class") != 'undefined' && $("#hogiHeader4").attr("class") != '') {
			hogiHeader = "4";
		} else {
			hogiHeader = "3";
		}
		
		if( $("input:checkbox[id='xy']").is(":checked") ) {
			xyHeader = "Y";
		} else {
			xyHeader = "X";
		}
		
		var lblDateVal = '${BaseSearch.hogi}'+'${BaseSearch.xyGubun}'+' '+'${DccLogTrendInfoList[0].SCANTIME}';
		$("#lblDate").text(lblDateVal);
		
		$(document.body).delegate('#hogiHeader3', 'click', function() {
			setTimer('3',xyHeader,0);
		});
		$(document.body).delegate('#hogiHeader4', 'click', function() {
			setTimer('4',xyHeader,0);
		});
		$(document.body).delegate('#xy', 'click', function() {
			if( $("input:checkbox[id='xy']").is(":checked") ) {
				xyHeader = "Y";
			} else {
				xyHeader = "X";
			}
			setTimer(hogiHeader,xyHeader,0);
		});
		
		$(document.body).delegate('#dccStatusSGP label', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			if( cId != null && cId != '' && cId != 'undefined' ) {
				showTag(cId,tDccTagSeq[cId]);
			}
		});
		$(document.body).delegate('#dccStatusSGP label', 'mouseover focus', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			showTooltip(cId);
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
					var	comSubmit	=	new ComSubmit("reloadFrm");
					comSubmit.setUrl("/dcc/status/sgp");
					comSubmit.addParam("hogiHeader",hogiHeader);
					comSubmit.addParam("xyHeader",xyHeader);
					comSubmit.submit();
				}
			},interval);
		} else {
			var	comSubmit	=	new ComSubmit("reloadFrm");
			comSubmit.setUrl("/dcc/status/sgp");
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
		
		comSubmit.setUrl("/dcc/status/sgpSaveTag");
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
		
		comAjax.setUrl("/dcc/status/sgpTagSearch");
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
		
		comAjax.setUrl("/dcc/status/sgpTagFind");
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
		var	comSubmit	=	new ComSubmit("reloadFrm");
		comSubmit.setUrl("/dcc/status/sgp");
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
				<h3 id="testclick" name="testclick">SG PRESSURE CONTROL STATUS</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>SG PRESSURE CONTROL STATUS</strong></div>
			</div>
			<!-- //page_title -->
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="javascript:toCSV()">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->
                <!-- form_table -->
                <form id="reloadFrm" style="display:none"></form>
                <table id="dccStatusSGP" class="form_table">
                    <colgroup>
                        <col />
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>UNIT CONTROL MODE</th>
                            <th>ALTERNATE</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="row_color_a">
                            <th>SG PRESSURE SETPOINT</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="1" class="full flex_end">${lblDataList[1].fValue}</label>
                                    <label id="unit1" class="full">${DccTagInfoList[1].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr class="row_color_a">
                            <th>SG PRESSURE SETPOINT</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="2" class="full flex_end">${lblDataList[2].fValue}</label>
                                    <label id="unit2" class="full">${DccTagInfoList[2].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr class="row_color_a">
                            <th>SG PRESSURE ERROR</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="3" class="full flex_end">${lblDataList[3].fValue}</label>
                                    <label id="unit3" class="full">${DccTagInfoList[3].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>SGP CONTROL TURBINE</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="4" class="full flex_end">${lblDataList[4].fValue}</label>
                                    <label id="unit4" class="full">${DccTagInfoList[4].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>MK-V:AVAIL FOR DCC/MODE</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="5" class="full flex_end">${lblDataList[5].fValue}</label>
                                    <label id="unit5" class="full">${DccTagInfoList[5].unit}</label>
                                    <label id="6" class="full flex_end">${lblDataList[6].fValue}</label>
                                    <label id="unit6" class="full">${DccTagInfoList[6].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>REACTOR POWER SETPOINT</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="7" class="full flex_end">${lblDataList[7].fValue}</label>
                                    <label id="unit7" class="full">${DccTagInfoList[7].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>SETPOINT INTEGRAL</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="8" class="full flex_end">${lblDataList[8].fValue}</label>
                                    <label id="unit8" class="full">${DccTagInfoList[8].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>REACTOR POWER</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="9" class="full flex_end">${lblDataList[9].fValue}</label>
                                    <label id="unit9" class="full">${DccTagInfoList[9].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>TURBINE LOAD</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="10" class="full flex_end">${lblDataList[10].fValue}</label>
                                    <label id="unit10" class="full">${DccTagInfoList[10].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr class="row_color_a">
                            <th>SDV TOTAL LOAD</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="11" class="full flex_end">${lblDataList[11].fValue}</label>
                                    <label id="unit11" class="full">${DccTagInfoList[11].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr class="row_color_a">
                            <th>CSDV OPENING</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="12" class="full flex_end">${lblDataList[12].fValue}</label>
                                    <label id="unit12" class="full">${DccTagInfoList[12].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr class="row_color_a">
                            <th>ASDV OPENING</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="13" class="full flex_end">${lblDataList[13].fValue}</label>
                                    <label id="unit13" class="full">${DccTagInfoList[13].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th># OF VALVES ON MANUAL</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="14" class="full flex_end">${lblDataList[14].fValue}</label>
                                    <label id="unit14" class="full">${DccTagInfoList[14].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>POISON PREVENT MODE</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="15" class="full flex_end">${lblDataList[15].fValue}</label>
                                    <label id="unit15" class="full">${DccTagInfoList[15].unit}</label>
                                    <label id="16" class="full flex_end">${lblDataList[16].fValue}</label>
                                    <label id="unit16" class="full">${DccTagInfoList[16].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>PRESSURE SETPOINT MODE</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="17" class="full flex_end">${lblDataList[17].fValue}</label>
                                    <label id="unit17" class="full">${DccTagInfoList[17].unit}</label>
                                    <label id="18" class="full flex_end">${lblDataList[18].fValue}</label>
                                    <label id="unit18" class="full">${DccTagInfoList[18].unit}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>RATE OF SETPOINT CHANGE</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="19" class="full flex_end">${lblDataList[19].fValue}</label>
                                    <label id="unit19" class="full">${DccTagInfoList[19].unit}</label>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
            </div>
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

