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

	var timerOn = false;
	var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
	var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

	var tDccTagSeq = [
		${DccTagInfoList[0].iSeq},${DccTagInfoList[1].iSeq},${DccTagInfoList[2].iSeq},${DccTagInfoList[3].iSeq},${DccTagInfoList[4].iSeq},
		${DccTagInfoList[5].iSeq},${DccTagInfoList[6].iSeq},${DccTagInfoList[7].iSeq},${DccTagInfoList[8].iSeq},${DccTagInfoList[9].iSeq},
		${DccTagInfoList[10].iSeq},${DccTagInfoList[11].iSeq},${DccTagInfoList[12].iSeq},${DccTagInfoList[13].iSeq},${DccTagInfoList[14].iSeq},
		${DccTagInfoList[15].iSeq},${DccTagInfoList[16].iSeq},${DccTagInfoList[17].iSeq},${DccTagInfoList[18].iSeq},${DccTagInfoList[19].iSeq},
		${DccTagInfoList[20].iSeq},${DccTagInfoList[21].iSeq},${DccTagInfoList[22].iSeq},${DccTagInfoList[23].iSeq},${DccTagInfoList[24].iSeq},
		${DccTagInfoList[25].iSeq},${DccTagInfoList[26].iSeq},${DccTagInfoList[27].iSeq}
	];
	
	var tDccTrendValue = [
		'${lblDataList[0].fValue}','${lblDataList[1].fValue}','${lblDataList[2].fValue}','${lblDataList[3].fValue}','${lblDataList[4].fValue}',
		'${lblDataList[5].fValue}','${lblDataList[6].fValue}','${lblDataList[7].fValue}','${lblDataList[8].fValue}','${lblDataList[9].fValue}',
		'${lblDataList[10].fValue}','${lblDataList[11].fValue}','${lblDataList[12].fValue}','${lblDataList[13].fValue}','${lblDataList[14].fValue}',
		'${lblDataList[15].fValue}','${lblDataList[16].fValue}','${lblDataList[17].fValue}','${lblDataList[18].fValue}','${lblDataList[19].fValue}',
		'${lblDataList[20].fValue}','${lblDataList[21].fValue}','${lblDataList[22].fValue}','${lblDataList[23].fValue}','${lblDataList[24].fValue}',
		'${lblDataList[25].fValue}','${lblDataList[26].fValue}','${lblDataList[27].fValue}'
	];
	
	var tDccTagXy = [
		'${DccTagInfoList[0].XYGubun}','${DccTagInfoList[1].XYGubun}','${DccTagInfoList[2].XYGubun}','${DccTagInfoList[3].XYGubun}','${DccTagInfoList[4].XYGubun}',
		'${DccTagInfoList[5].XYGubun}','${DccTagInfoList[6].XYGubun}','${DccTagInfoList[7].XYGubun}','${DccTagInfoList[8].XYGubun}','${DccTagInfoList[9].XYGubun}',
		'${DccTagInfoList[10].XYGubun}','${DccTagInfoList[11].XYGubun}','${DccTagInfoList[12].XYGubun}','${DccTagInfoList[13].XYGubun}','${DccTagInfoList[14].XYGubun}',
		'${DccTagInfoList[15].XYGubun}','${DccTagInfoList[16].XYGubun}','${DccTagInfoList[17].XYGubun}','${DccTagInfoList[18].XYGubun}','${DccTagInfoList[19].XYGubun}',
		'${DccTagInfoList[20].XYGubun}','${DccTagInfoList[21].XYGubun}','${DccTagInfoList[22].XYGubun}','${DccTagInfoList[23].XYGubun}','${DccTagInfoList[24].XYGubun}',
		'${DccTagInfoList[25].XYGubun}','${DccTagInfoList[26].XYGubun}','${DccTagInfoList[27].XYGubun}'
	];
	
	var tToolTipText = [
		"${DccTagInfoList[0].toolTip}"		,"${DccTagInfoList[1].toolTip}"		,"${DccTagInfoList[2].toolTip}"		,"${DccTagInfoList[3].toolTip}"		,"${DccTagInfoList[4].toolTip}"
		,"${DccTagInfoList[5].toolTip}"		,"${DccTagInfoList[6].toolTip}"		,"${DccTagInfoList[7].toolTip}"		,"${DccTagInfoList[8].toolTip}"		,"${DccTagInfoList[9].toolTip}"
		,"${DccTagInfoList[10].toolTip}"		,"${DccTagInfoList[11].toolTip}"		,"${DccTagInfoList[12].toolTip}"		,"${DccTagInfoList[13].toolTip}"		,"${DccTagInfoList[14].toolTip}"
		,"${DccTagInfoList[15].toolTip}"		,"${DccTagInfoList[16].toolTip}"		,"${DccTagInfoList[17].toolTip}"		,"${DccTagInfoList[18].toolTip}"		,"${DccTagInfoList[19].toolTip}"
		,"${DccTagInfoList[20].toolTip}"		,"${DccTagInfoList[21].toolTip}"		,"${DccTagInfoList[22].toolTip}"		,"${DccTagInfoList[23].toolTip}"		,"${DccTagInfoList[24].toolTip}"
		,"${DccTagInfoList[25].toolTip}"		,"${DccTagInfoList[26].toolTip}"		,"${DccTagInfoList[27].toolTip}"
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
		comSubmit.setUrl("/dcc/status/rrsExcelExport");
		comSubmit.submit();
	}
	
	function setFontColor() {
		
		var tDccTagAlarm = [
			${DccTagInfoList[0].alarmType},${DccTagInfoList[1].alarmType},${DccTagInfoList[2].alarmType},${DccTagInfoList[3].alarmType},${DccTagInfoList[4].alarmType},
			${DccTagInfoList[5].alarmType},${DccTagInfoList[6].alarmType},${DccTagInfoList[7].alarmType},${DccTagInfoList[8].alarmType},${DccTagInfoList[9].alarmType},
			${DccTagInfoList[10].alarmType},${DccTagInfoList[11].alarmType},${DccTagInfoList[12].alarmType},${DccTagInfoList[13].alarmType},${DccTagInfoList[14].alarmType},
			${DccTagInfoList[15].alarmType},${DccTagInfoList[16].alarmType},${DccTagInfoList[17].alarmType},${DccTagInfoList[18].alarmType},${DccTagInfoList[19].alarmType},
			${DccTagInfoList[20].alarmType},${DccTagInfoList[21].alarmType},${DccTagInfoList[22].alarmType},${DccTagInfoList[23].alarmType},${DccTagInfoList[24].alarmType},
			${DccTagInfoList[25].alarmType},${DccTagInfoList[26].alarmType},${DccTagInfoList[27].alarmType}
		];
		
		var tDccTagLimit1 = [
			${DccTagInfoList[0].dataLimit1},${DccTagInfoList[1].dataLimit1},${DccTagInfoList[2].dataLimit1},${DccTagInfoList[3].dataLimit1},${DccTagInfoList[4].dataLimit1},
			${DccTagInfoList[5].dataLimit1},${DccTagInfoList[6].dataLimit1},${DccTagInfoList[7].dataLimit1},${DccTagInfoList[8].dataLimit1},${DccTagInfoList[9].dataLimit1},
			${DccTagInfoList[10].dataLimit1},${DccTagInfoList[11].dataLimit1},${DccTagInfoList[12].dataLimit1},${DccTagInfoList[13].dataLimit1},${DccTagInfoList[14].dataLimit1},
			${DccTagInfoList[15].dataLimit1},${DccTagInfoList[16].dataLimit1},${DccTagInfoList[17].dataLimit1},${DccTagInfoList[18].dataLimit1},${DccTagInfoList[19].dataLimit1},
			${DccTagInfoList[20].dataLimit1},${DccTagInfoList[21].dataLimit1},${DccTagInfoList[22].dataLimit1},${DccTagInfoList[23].dataLimit1},${DccTagInfoList[24].dataLimit1},
			${DccTagInfoList[25].dataLimit1},${DccTagInfoList[26].dataLimit1},${DccTagInfoList[27].dataLimit1}
		];
		
		var tDccTagLimit2 = [
			${DccTagInfoList[0].dataLimit2},${DccTagInfoList[1].dataLimit2},${DccTagInfoList[2].dataLimit2},${DccTagInfoList[3].dataLimit2},${DccTagInfoList[4].dataLimit2},
			${DccTagInfoList[5].dataLimit2},${DccTagInfoList[6].dataLimit2},${DccTagInfoList[7].dataLimit2},${DccTagInfoList[8].dataLimit2},${DccTagInfoList[9].dataLimit2},
			${DccTagInfoList[10].dataLimit2},${DccTagInfoList[11].dataLimit2},${DccTagInfoList[12].dataLimit2},${DccTagInfoList[13].dataLimit2},${DccTagInfoList[14].dataLimit2},
			${DccTagInfoList[15].dataLimit2},${DccTagInfoList[16].dataLimit2},${DccTagInfoList[17].dataLimit2},${DccTagInfoList[18].dataLimit2},${DccTagInfoList[19].dataLimit2},
			${DccTagInfoList[20].dataLimit2},${DccTagInfoList[21].dataLimit2},${DccTagInfoList[22].dataLimit2},${DccTagInfoList[23].dataLimit2},${DccTagInfoList[24].dataLimit2},
			${DccTagInfoList[25].dataLimit2},${DccTagInfoList[26].dataLimit2},${DccTagInfoList[27].dataLimit2}
		];
		
		for( var fi=0;fi<28;fi++ ) {
			if( tDccTrendValue[fi] != -99999 ) {
				if( tDccTagAlarm[fi] == 1 || tDccTagAlarm[fi] == 7 || tDccTagAlarm[fi] == 4 ) {
					if( tDccTrendValue[fi] >= tDccTagLimit1[fi] ) {
						$("#"+fi).css("color","#e85516");
					} else {
						$("#"+fi).css("color","#594ccd");
					}
				} else if( tDccTagAlarm[fi] == 2 || tDccTagAlarm[fi] == 8 || tDccTagAlarm[fi] == 5 ) {
					if( tDccTrendValue[fi] <= tDccTagLimit1[fi] ) {
						$("#"+fi).css("color","#e85516");
					} else {
						$("#"+fi).css("color","#594ccd");
					}
				} else if( tDccTagAlarm[fi] == 3 || tDccTagAlarm[fi] == 9 || tDccTagAlarm[fi] == 6 ) {
					if( tDccTagLimit2[fi] != null && tDccTagLimit2[fi] != '' ) {
						if( tDccTrendValue[fi] > tDccTagLimit1[fi] || tDccTrendValue[fi] < tDccTagLimit2[fi]) {
							$("#"+fi).css("color","#e85516");
						} else {
							$("#"+fi).css("color","#594ccd");
						}
					} else {
						if( tDccTrendValue[fi] > tDccTagLimit1[fi] ) {
							$("#"+fi).css("color","#e85516");
						} else {
							$("#"+fi).css("color","#594ccd");
						}
					}
				}
			}
		}
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
		var diff = new Date().getTime() - new Date('${DccLogTrendInfoList[0].SCANTIME}').getTime();
		if( diff / 1800000 > 1 ) {
			$("#lblDate").css('color','#e85516');
		} else {
			$("#lblDate").css('color','#05c8be');
		}
		
		setFontColor();
		
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
		
		$(document.body).delegate('#dccStatusRRSForm label', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			if( cId != null && cId != '' && cId != 'undefined' ) {
				showTag(cId,tDccTagSeq[cId]);
			}
		});
		$(document.body).delegate('#dccStatusRRSForm label', 'mouseover focus', function() {
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
					comSubmit.setUrl("/dcc/status/rrs");
					comSubmit.addParam("hogiHeader",hogiHeader);
					comSubmit.addParam("xyHeader",xyHeader);
					comSubmit.submit();
				}
			},interval);
		} else {
			var	comSubmit	=	new ComSubmit("reloadFrm");
			comSubmit.setUrl("/dcc/status/rrs");
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
		
		comSubmit.setUrl("/dcc/status/rrsSaveTag");
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

		comAjax.setUrl("/dcc/status/rrsTagSearch");
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
		
		comAjax.setUrl("/dcc/status/rrsTagFind");
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
		comSubmit.setUrl("/dcc/status/rrs");
		comSubmit.submit();
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
				<h3>LOAD CONTROL</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>LOAD CONTROL</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap load_control">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="#none" class="link_btn link_01"></a>
                <!-- ///range_slider -->              
                <div class="chart_block small wide" style="top:50px;left:140px;">
                    <h4>MAIN STEAM</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESS</span>
                                <label onclick="openLayer('modal_1');" class="link"><c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if></label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label><c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if></label>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:136px;left:140px;">
                    <h4>FIRST STAGE</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESS</span>
                                <label><c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if></label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label><c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if></label>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:222px;left:140px;">
                    <h4>REHEATERINLET</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESS</span>
                                <label><c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if></label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label><c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if></label>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:60px;left:560px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>CV DEMAND</span>
                                <label><c:if test="${lblDataList[29].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[29].fValue ne null}">${lblDataList[29].fValue}</c:if></label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:290px;left:560px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>IV DEMAND</span>
                                <label><c:if test="${lblDataList[30].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[30].fValue ne null}">${lblDataList[30].fValue}</c:if></label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:130px;left:390px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>1</span>
                                <label><c:if test="${lblDataList[21].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[21].fValue ne null}">${lblDataList[21].fValue}</c:if></label>
                                <span class="per">%</span>
                                <label><c:if test="${lblDataList[25].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[25].fValue ne null}">${lblDataList[25].fValue}</c:if></label>
                                <span class="per">%</span>
                            </p>
                            <p>
                                <span>2</span>
                                <label><c:if test="${lblDataList[22].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[22].fValue ne null}">${lblDataList[22].fValue}</c:if></label>
                                 <span class="per">%</span>
                                <label><c:if test="${lblDataList[26].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[26].fValue ne null}">${lblDataList[26].fValue}</c:if></label>
                                <span class="per">%</span>
                            </p>
                            <p>
                                <span>3</span>
                                <label><c:if test="${lblDataList[23].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[23].fValue ne null}">${lblDataList[23].fValue}</c:if></label>
                                <span class="per">%</span>
                                <label><c:if test="${lblDataList[27].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[27].fValue ne null}">${lblDataList[27].fValue}</c:if></label>
                                 <span class="per">%</span>
                            </p>
                            <p>
                                <span>4</span>
                                <label><c:if test="${lblDataList[24].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[24].fValue ne null}">${lblDataList[24].fValue}</c:if></label>
                                 <span class="per">%</span>
                                <label><c:if test="${lblDataList[28].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[28].fValue ne null}">${lblDataList[28].fValue}</c:if></label>
                                 <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block small wide" style="top:50px;left:800px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>BREAKER</span>
                                <label><c:if test="${lblDataList[31].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[31].fValue ne null}">${lblDataList[31].fValue}</c:if></label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPEED</span>
                                <label><c:if test="${lblDataList[32].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[32].fValue ne null}">${lblDataList[32].fValue}</c:if></label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MODE</span>
                                <label><c:if test="${lblDataList[33].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[33].fValue ne null}">${lblDataList[33].fValue}</c:if></label>
                                <span></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:50px;right:160px;">
                    <h4>GENERATOR</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[34].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[34].fValue ne null}">${lblDataList[34].fValue}</c:if></label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[35].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[35].fValue ne null}">${lblDataList[35].fValue}</c:if></label>
                                <span>MVAR</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[36].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[36].fValue ne null}">${lblDataList[36].fValue}</c:if></label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[37].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[37].fValue ne null}">${lblDataList[37].fValue}</c:if></label>
                                <span>Hz</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[38].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[38].fValue ne null}">${lblDataList[38].fValue}</c:if></label>
                                <span>PF</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small half" style="top:330px;left:140px;">
                    <h4>AUTO TURBINE STARTUP</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>RECOM ACC</span>
                                <label><c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LOADING RATE</span>
                                <label><c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if></label>
                                <span>MW/MIN</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MAX STRESS</span>
                                <label><c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if></label>
                                <span>PCT</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPEED / LOAD HOLD</span>
                                <label><c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPEED / LOAD STAT</span>
                                <label><c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>TURBINE LIMIT STAT</span>
                                <label><c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LOAD CONTROL MODE</span>
                                <label><c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>TSPL_P</span>
                                <label><c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if></label>
                                <span>AT</span>
                                <label><c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if></label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MWL</span>
                                <label><c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if></label>
                                <span>AT</span>
                                <label><c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if></label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>VPL</span>
                                <label><c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if></label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>TRIP SYSTEM STAT</span>
                                <label><c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if></label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MAX VIBRATION</span>
                                <label><c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if></label>
                                <span>mm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACCELERATION</span>
                                <label><c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if></label>
                                <span>RPM/M</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="fx_layout no_mg" style="position:absolute;top:330px;left:660px;width:560px;height:366px;">
                    <div class="fx_block">
                        <div class="chart_block small fx_full">
                            <h4>VPL</h4>
                            <div class="chart_block_contents">
                                <div class="switch_button">
	                                <c:if test="${lblDataList[43].fValue eq 1}">
	                                    <input type="radio" id="cancel_vpl" name="switch_vpl" value="" checked/>
	                                    <label for="cancel_vpl" title="${MarkTagInfoList[43].toolTip}">CANCEL</label>
	                                </c:if>
	                                <c:if test="${lblDataList[43].fValue ne 1}">
	                                    <input type="radio" id="cancel_vpl" name="switch_vpl" value=""/>
	                                    <label for="cancel_vpl">CANCEL</label>
	                                </c:if>
	                                
	                                <c:if test="${lblDataList[44].fValue eq 1}">
	                                    <input type="radio" id="control_vpl" name="switch_vpl" value="" checked />
	                                    <label for="control_vpl" title="${MarkTagInfoList[43].toolTip}">CONTROL</label>
	                                </c:if>
	                                 <c:if test="${lblDataList[44].fValue ne 1}">
	                                    <input type="radio" id="control_vpl" name="switch_vpl" value="" />
	                                    <label for="control_vpl">CONTROL</label>
	                                </c:if>
	                                   
	                                <c:if test="${lblDataList[45].fValue eq 1}">                                      
	                                    <input type="radio" id="track_vpl" name="switch_vpl" value="" checked/>
	                                    <label for="track_vpl"  title="${MarkTagInfoList[45].toolTip}">TRACK</label>
	                                </c:if>
	                                <c:if test="${lblDataList[45].fValue ne 1}">                                      
	                                    <input type="radio" id="track_vpl" name="switch_vpl" value="" />
	                                    <label for="track_vpl">TRACK</label>
	                                </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h4>GOV. NON-REGUL</h4>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                               		<c:if test="${lblDataList[46].fValue eq null || lblDataList[46].fValue eq 0}">
			                            <input type="radio" id="yes_gov" name="switch_gov" value="" checked/>
	                                    <label for="yes_gov" title="${MarkTagInfoList[46].toolTip}">OFF</label>
	                                    <input type="radio" id="no_gov" name="switch_gov" value="" />
	                                    <label for="no_gov">ON</label>
	                                </c:if>    
	                                <c:if test="${lblDataList[46].fValue ne null && lblDataList[46].fValue eq 1}">
		                                <input type="radio" id="yes_gov" name="switch_gov" value="" />
	                                    <label for="yes_gov" >OFF</label>
	                                    <input type="radio" id="no_gov" name="switch_gov" value="" checked/>
	                                    <label for="no_gov" title="${MarkTagInfoList[46].toolTip}" >ON</label>
	                                </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h4>MOTORING</h4>
                            <div class="chart_block_contents">
                                <div class="summary">
                                    <p>
                                        <label><c:if test="${lblDataList[39].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[39].fValue ne null}">${lblDataList[39].fValue}</c:if></label>
                                        <span>MW</span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small fx_full">
                            <h4>LOAD STATUS</h4>
                            <div class="chart_block_contents">
                                <h6>LOAD HOLD</h6>
                                <div class="switch_button">
                                	<c:if test="${lblDataList[47].fValue eq null || lblDataList[47].fValue eq 0}">
			                            <input type="radio" id="yes_load" name="switch_load" value="" checked/>
	                                    <label for="yes_load" title="${MarkTagInfoList[47].toolTip}">OFF</label>
	                                    <input type="radio" id="no_load" name="switch_load" value="" />
	                                    <label for="no_load">ON</label>
	                                </c:if>    
	                                <c:if test="${lblDataList[47].fValue ne null && lblDataList[47].fValue eq 1}">
		                                <input type="radio" id="yes_load" name="switch_load" value="" />
	                                    <label for="yes_load">OFF</label>
	                                    <input type="radio" id="no_load" name="switch_load" value="" checked/>
	                                    <label for="no_load" title="${MarkTagInfoList[47].toolTip}">ON</label>
	                                </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h4>RAPID UN-LOAD</h4>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                <c:if test="${lblDataList[48].fValue eq null || lblDataList[48].fValue eq 0}">
                                    <input type="radio" id="yes_rapid" name="switch_rapid" value="" checked/>
                                    <label for="yes_rapid" title="${MarkTagInfoList[48].toolTip}">OFF</label>
                                    <input type="radio" id="no_rapid" name="switch_rapid" value="" />
                                    <label for="no_rapid">ON</label>
                                </c:if>
                                <c:if test="${lblDataList[48].fValue ne null && lblDataList[48].fValue eq 1}">
                                 	<input type="radio" id="yes_rapid" name="switch_rapid" value="" />
                                    <label for="yes_rapid">OFF</label>
                                    <input type="radio" id="no_rapid" name="switch_rapid" value="" checked/>
                                    <label for="no_rapid"  title="${MarkTagInfoList[48].toolTip}">ON</label>
                                </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h4>M-WATT CONTROL</h4>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                	<c:if test="${lblDataList[49].fValue eq null || lblDataList[49].fValue eq 0}">
			                            <input type="radio" id="yes_watt" name="switch_watt" value="" checked/>
	                                    <label for="yes_watt" title="${MarkTagInfoList[49].toolTip}">OFF</label>
	                                    <input type="radio" id="no_watt" name="switch_watt" value="" />
	                                    <label for="no_watt">ON</label>
	                                </c:if>    
	                                <c:if test="${lblDataList[49].fValue ne null && lblDataList[49].fValue eq 1}">
		                                <input type="radio" id="yes_watt" name="switch_watt" value="" />
	                                    <label for="yes_watt">OFF</label>
	                                    <input type="radio" id="no_watt" name="switch_watt" value="" checked/>
	                                    <label for="no_watt" title="${MarkTagInfoList[49].toolTip}">ON</label>
	                                </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small fx_full">
                            <h4>LOAD CONTROL</h4>
                            <div class="chart_block_contents fx_row" style="padding-top:11px;">
                                <div class="com_block">
                                    <h6>TARGET</h6>
                                    <div class="switch_button">
                                        <input type="radio" id="target" name="switch_target_rate" value="" />
                                        <label class="full" for="target">MW</label>
                                    </div>
                                    <div class="summary" style="height:56px;">
                                        <p>
                                            <label><c:if test="${lblDataList[40].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[40].fValue ne null}">${lblDataList[40].fValue}</c:if></label>
                                        </p>
                                    </div>
                                    <div class="switch_button">
                                    	<c:if test="${lblDataList[50].fValue eq 1}">
		                                    <input type="radio" id="target_raise" name="switch_target" value="" checked/>
                                        	<label class="full" for="target_raise" title="${MarkTagInfoList[50].toolTip}">RAISE</label>
		                                </c:if>
		                                <c:if test="${lblDataList[50].fValue ne 1}">
		                                  	<input type="radio" id="target_raise" name="switch_target" value=""/>
                                        <label class="full" for="target_raise">RAISE</label>
		                                </c:if>   
                                        <span class="ico_transper"></span>
                                        <c:if test="${lblDataList[51].fValue eq 1}">
		                                   	<input type="radio" id="target_lower" name="switch_target" value="" checked/>
                                        <label class="full" for="target_lower" title="${MarkTagInfoList[51].toolTip}">LOWER</label>
		                                </c:if>
		                                <c:if test="${lblDataList[51].fValue ne 1}">
		                                    <input type="radio" id="target_lower" name="switch_target" value="" />
                                        	<label class="full" for="target_lower">LOWER</label>
		                                </c:if>   
                                    </div>                                    
                                </div>
                                <div class="com_block">
                                    <h6>RATE</h6>
                                    <div class="switch_button">
                                        <input type="radio" id="rate" name="switch_target_rate" value="" />
                                        <label class="full" for="rate">MW/mn</label>
                                    </div>
                                    <div class="summary" style="height:56px;">
                                        <p>
                                            <label><c:if test="${lblDataList[41].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[41].fValue ne null}">${lblDataList[41].fValue}</c:if></label>
                                        </p>
                                        <p>
                                            <label><c:if test="${lblDataList[42].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[42].fValue ne null}">${lblDataList[42].fValue}</c:if></label>
                                        </p>
                                    </div>
                                    <div class="switch_button">
                                    <c:if test="${lblDataList[52].fValue eq 1}">
		                                    <input type="radio" id="rate_raise" name="switch_rate" value="" checked/>
                                        	<label class="full" for="target_raise" title="${MarkTagInfoList[52].toolTip}">RAISE</label>
		                                </c:if>
		                                <c:if test="${lblDataList[52].fValue ne 1}">
		                                  	<input type="radio" id="rate_raise" name="switch_rate" value=""/>
                                        <label class="full" for="target_raise">RAISE</label>
		                                </c:if>   
                                        <span class="ico_transper"></span>
                                        <c:if test="${lblDataList[53].fValue eq 1}">
		                                   	<input type="radio" id="rate_lower" name="switch_rate" value="" checked/>
                                        <label class="full" for="target_lower" title="${MarkTagInfoList[53].toolTip}">LOWER</label>
		                                </c:if>
		                                <c:if test="${lblDataList[53].fValue ne 1}">
		                                    <input type="radio" id="rate_lower" name="switch_rate" value="" />
                                        	<label class="full" for="rate_lower">LOWER</label>
		                                </c:if> 
                                    </div>                                    
                                </div>
                            </div>
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
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>태그번호</th>
                    <td>
                        <div class="fx_form">
                            <input type="text">
                            <a class="btn_list" herf="none" onclick="openLayer('modal_2');">태그찾기</a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>태그명</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>태그설명</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>표현방식</th>
                    <td>
                        <div class="fx_form_multi">
                            <div class="fx_form">
                                <label>
                                    <input type="radio" name="type">
                                    수치표현
                                </label>
                                <label>
                                    <input type="radio" name="type">
                                    문자표현
                                </label>
                                <label>
                                    <input type="radio" name="type">
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
                        <select class="fx_none" style="width:120px;">
                            <option>0000</option>
                        </select>                        
                    </td>
                </tr>
                <tr>
                    <th>0 상태 문자표현(0)</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>1 상태 문자표현(0)</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>문자표현(A)</th>
                    <td>
                        <div class="fx_form">
                            <select class="fx_none" style="width:260px;">
                                <option>0000</option>
                            </select>
                            <select>
                                <option>0000</option>
                            </select>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
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
        <!-- fx_srch_wrap -->
        <div class="fx_srch_wrap">	
            <div class="fx_srch_form">
                <div class="fx_srch_row">
                    <div class="fx_srch_item">
                        <label>검색옵션</label>
                        <div class="fx_form">
                            <label>
                                <input type="checkbox" name="type">
                                태그명
                            </label>
                            <label>
                                <input type="checkbox" name="type">
                                태그설명
                            </label>
                        </div>
                    </div>
                    <div class="fx_srch_item">
                        <label>검색어</label>
                        <input type="text">
                    </div>
                </div>
            </div>
            <!-- fx_srch_button -->
            <div class="fx_srch_button">
                <a class="btn_srch">Search</a>
            </div>
            <!-- //fx_srch_button -->
        </div>
        <!-- //fx_srch_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
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
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page">전체리스트</a>
        <a href="#none" class="btn_page primary">선택</a>
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

