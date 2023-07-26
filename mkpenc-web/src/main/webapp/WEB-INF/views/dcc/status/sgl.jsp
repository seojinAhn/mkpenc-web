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
		${DccTagInfoList[15].iSeq},${DccTagInfoList[16].iSeq},${DccTagInfoList[17].iSeq},${DccTagInfoList[18].iSeq},${DccTagInfoList[19].iSeq},
		${DccTagInfoList[20].iSeq},${DccTagInfoList[21].iSeq},${DccTagInfoList[22].iSeq},${DccTagInfoList[23].iSeq},${DccTagInfoList[24].iSeq},
		${DccTagInfoList[25].iSeq},${DccTagInfoList[26].iSeq},${DccTagInfoList[27].iSeq},${DccTagInfoList[28].iSeq},${DccTagInfoList[29].iSeq},
		${DccTagInfoList[30].iSeq},${DccTagInfoList[31].iSeq},${DccTagInfoList[32].iSeq},${DccTagInfoList[33].iSeq},${DccTagInfoList[34].iSeq},
		${DccTagInfoList[35].iSeq},${DccTagInfoList[36].iSeq},${DccTagInfoList[37].iSeq},${DccTagInfoList[38].iSeq},${DccTagInfoList[39].iSeq},
		${DccTagInfoList[40].iSeq},${DccTagInfoList[41].iSeq},${DccTagInfoList[42].iSeq},${DccTagInfoList[43].iSeq},${DccTagInfoList[44].iSeq},
		${DccTagInfoList[45].iSeq},${DccTagInfoList[46].iSeq},${DccTagInfoList[47].iSeq},${DccTagInfoList[48].iSeq},${DccTagInfoList[49].iSeq},
		${DccTagInfoList[50].iSeq},${DccTagInfoList[51].iSeq},${DccTagInfoList[52].iSeq},${DccTagInfoList[53].iSeq},${DccTagInfoList[54].iSeq},
		${DccTagInfoList[55].iSeq},${DccTagInfoList[56].iSeq},${DccTagInfoList[57].iSeq},${DccTagInfoList[58].iSeq},${DccTagInfoList[59].iSeq},
		${DccTagInfoList[60].iSeq},${DccTagInfoList[61].iSeq},${DccTagInfoList[62].iSeq},${DccTagInfoList[63].iSeq},${DccTagInfoList[64].iSeq}
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
		'${DccTagInfoList[40].XYGubun}','${DccTagInfoList[41].XYGubun}','${DccTagInfoList[42].XYGubun}','${DccTagInfoList[43].XYGubun}','${DccTagInfoList[44].XYGubun}',
		'${DccTagInfoList[45].XYGubun}','${DccTagInfoList[46].XYGubun}','${DccTagInfoList[47].XYGubun}','${DccTagInfoList[48].XYGubun}','${DccTagInfoList[49].XYGubun}',
		'${DccTagInfoList[50].XYGubun}','${DccTagInfoList[51].XYGubun}','${DccTagInfoList[52].XYGubun}','${DccTagInfoList[53].XYGubun}','${DccTagInfoList[54].XYGubun}',
		'${DccTagInfoList[55].XYGubun}','${DccTagInfoList[56].XYGubun}','${DccTagInfoList[57].XYGubun}','${DccTagInfoList[58].XYGubun}','${DccTagInfoList[59].XYGubun}',
		'${DccTagInfoList[60].XYGubun}','${DccTagInfoList[61].XYGubun}','${DccTagInfoList[62].XYGubun}','${DccTagInfoList[63].XYGubun}','${DccTagInfoList[64].XYGubun}'
	];
	
	var tToolTipText = [
		"${DccTagInfoList[0].toolTip}"		,"${DccTagInfoList[1].toolTip}"		,"${DccTagInfoList[2].toolTip}"		,"${DccTagInfoList[3].toolTip}"		,"${DccTagInfoList[4].toolTip}"
		,"${DccTagInfoList[5].toolTip}"		,"${DccTagInfoList[6].toolTip}"		,"${DccTagInfoList[7].toolTip}"		,"${DccTagInfoList[8].toolTip}"		,"${DccTagInfoList[9].toolTip}"
		,"${DccTagInfoList[10].toolTip}"		,"${DccTagInfoList[11].toolTip}"		,"${DccTagInfoList[12].toolTip}"		,"${DccTagInfoList[13].toolTip}"		,"${DccTagInfoList[14].toolTip}"
		,"${DccTagInfoList[15].toolTip}"		,"${DccTagInfoList[16].toolTip}"		,"${DccTagInfoList[17].toolTip}"		,"${DccTagInfoList[18].toolTip}"		,"${DccTagInfoList[19].toolTip}"
		,"${DccTagInfoList[20].toolTip}"		,"${DccTagInfoList[21].toolTip}"		,"${DccTagInfoList[22].toolTip}"		,"${DccTagInfoList[23].toolTip}"		,"${DccTagInfoList[24].toolTip}"
		,"${DccTagInfoList[25].toolTip}"		,"${DccTagInfoList[26].toolTip}"		,"${DccTagInfoList[27].toolTip}"		,"${DccTagInfoList[28].toolTip}"		,"${DccTagInfoList[29].toolTip}"
		,"${DccTagInfoList[30].toolTip}"		,"${DccTagInfoList[31].toolTip}"		,"${DccTagInfoList[32].toolTip}"		,"${DccTagInfoList[33].toolTip}"		,"${DccTagInfoList[34].toolTip}"
		,"${DccTagInfoList[35].toolTip}"		,"${DccTagInfoList[36].toolTip}"		,"${DccTagInfoList[37].toolTip}"		,"${DccTagInfoList[38].toolTip}"		,"${DccTagInfoList[39].toolTip}"
		,"${DccTagInfoList[40].toolTip}"		,"${DccTagInfoList[41].toolTip}"		,"${DccTagInfoList[42].toolTip}"		,"${DccTagInfoList[43].toolTip}"		,"${DccTagInfoList[44].toolTip}"
		,"${DccTagInfoList[45].toolTip}"		,"${DccTagInfoList[46].toolTip}"		,"${DccTagInfoList[47].toolTip}"		,"${DccTagInfoList[48].toolTip}"		,"${DccTagInfoList[49].toolTip}"
		,"${DccTagInfoList[50].toolTip}"		,"${DccTagInfoList[51].toolTip}"		,"${DccTagInfoList[52].toolTip}"		,"${DccTagInfoList[53].toolTip}"		,"${DccTagInfoList[54].toolTip}"
		,"${DccTagInfoList[55].toolTip}"		,"${DccTagInfoList[56].toolTip}"		,"${DccTagInfoList[57].toolTip}"		,"${DccTagInfoList[58].toolTip}"		,"${DccTagInfoList[59].toolTip}"
		,"${DccTagInfoList[60].toolTip}"		,"${DccTagInfoList[61].toolTip}"		,"${DccTagInfoList[62].toolTip}"		,"${DccTagInfoList[63].toolTip}"		,"${DccTagInfoList[64].toolTip}"
	];
	
	var lblDataListAjax = {};
	var DccTagInfoListAjax = {};
	
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
	
	/*function showTooltip(id) {
		var tooltipText;

		tooltipText = tToolTipText[id*1];
		
		if( tooltipText.indexOf(":]") > -1 ) {
			tooltipText = tooltipText.replace(":]","]");
		}
		$("#"+id).attr("title",tooltipText);
	}*/
	
	function toCSV() {
		var	comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl("/dcc/status/sglExcelExport");
		comSubmit.submit();
	}

	$(function(){

		$("#lblDate").text('${SearchTime}');
		$("#lblDate").css('color','${ForeColor}');

		$(document.body).delegate('#dccStatusSGL1 label', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			if( cId != null && cId != '' && cId != 'undefined' ) {
				//showTag(cId,tDccTagSeq[cId]);
			}
		});
		$(document.body).delegate('#dccStatusSGL1 label', 'mouseover focus', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			//showTooltip(cId);
		});
		$(document.body).delegate('#dccStatusSGL2 label', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			if( cId != null && cId != '' && cId != 'undefined' ) {
				//showTag(cId,tDccTagSeq[cId]);
			}
		});
		$(document.body).delegate('#dccStatusSGL2 label', 'mouseover focus', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			//showTooltip(cId);
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
		
		setTimer(5000)

	});
	
	function setTimer(interval) {
		if( interval > 0 ) {
			setTimeout(function run() {
				if( timerOn ) {
					//var	comSubmit	=	new ComSubmit("reloadFrm");
					//comSubmit.setUrl("/dcc/status/sgl");
					//comSubmit.submit();
					var comAjax = new ComAjax("reloadFrm");
					comAjax.setUrl('/dcc/status/reloadSgl');
					//comAjax.addParam("sHogi",hogiHeader);
					//comAjax.addParam("sXYGubun",xyHeader);
					comAjax.setCallback('statusCallback');
					comAjax.ajax();
				}
				
				setTimeout(run, interval);
			},interval);
		} else {
			setTimeout(function run() {
				if( timerOn ) {
					//var	comSubmit	=	new ComSubmit("reloadFrm");
					//comSubmit.setUrl("/dcc/status/sgl");
					//comSubmit.submit();
					var comAjax = new ComAjax("reloadFrm");
					comAjax.setUrl('/dcc/status/reloadSgl');
					//comAjax.addParam("sHogi",hogiHeader);
					//comAjax.addParam("sXYGubun",xyHeader);
					comAjax.setCallback('statusCallback');
					comAjax.ajax();
				}
				
				setTimeout(run, 5000);
			},5000);
		}
	}
	
	function setFormat(val,format) {
		var rtv = '';
		if( val.indexOf('.') > -1 ) {
			var tmp = val.split('.');
			rtv = tmp[0]+'.';
			
			if( tmp[1].length < format+1 ) {
				rtv += tmp[1];
				for( var i=0;i<format-tmp[1].length;i++ ) {
					rtv += '0';
				}
			} else {
				rtv += tmp[1].substring(0,format);
			}
		} else {
			rtv = val+'.';
			
			for( var i=0;i<format;i++ ) {
				rtv += '0';
			}
		}
		return rtv;
	}

	function setDate(time,color) {
		$("#lblDate").text(time);
		$("#lblDate").css('color',color);
	}

	function setData() {
		for( var i=0;i<lblDataListAjax.length;i++ ) {
			if( i > 32 && i < 37 ) {
				$("#lblData"+i).text(setFormat(lblDataListAjax[i].fValue,2));
			} else if( i > 36 && i < 41 ) {
				$("#lblData"+i).text(setFormat(lblDataListAjax[i].fValue,3));
			} else if( i > 40 && i < 45 ) {
				if( lblDataListAjax[i].fValue*1 == 0 ) {
					$("#lblData"+i).text('A');
				} else {
					$("#lblData"+i).text('C');
				}
			} else if( i > 44 && i < 53 ) {
				if( lblDataListAjax[i].fValue*1 == 0 ) {
					$("#lblData"+i).text('NO');
				} else {
					$("#lblData"+i).text('YES');
				}
			} else if( i > 52 && i < 57 ) {
				$("#lblData"+i).text(setFormat(lblDataListAjax[i].fValue,3));
			} else if( i > 56 && i < 63 ) {
				$("#lblData"+i).text(setFormat(lblDataListAjax[i].fValue,2));
			} else if( i == 63 ) {
				$("#lblData"+i).text(setFormat(lblDataListAjax[i].fValue,4));
			} else {
				$("#lblData"+i).text(lblDataListAjax[i].fValue);
			}
			for( var j=0;j<3;j++ ) {
				$("#lblCopy"+j).text(lblDataListAjax[4].fValue);
			}
			$("#lblData"+i).prop('title',DccTagInfoListAjax[i].toolTip);
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
		
		comSubmit.setUrl("/dcc/status/sglSaveTag");
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
		
		comAjax.setUrl("/dcc/status/sglTagSearch");
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
		
		comAjax.setUrl("/dcc/status/sglTagFind");
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
		comSubmit.setUrl("/dcc/status/sgl");
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
				<h3 id="testclick" name="testclick">SG LEVEL CONTROL STATUS</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>SG LEVEL CONTROL STATUS</strong></div>
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
                <form id="reloadFrm" style="display:none">
                <input type="hidden" id="gubun" name="gubun" value="${BaseSearch.gubun}">
				<input type="hidden" id="menuNo" name="menuNo" value="${BaseSearch.menuNo}">
				<input type="hidden" id="grpId" name="grpId" value="${BaseSearch.grpId}">
				<input type="hidden" id="grpNo" name="grpNo" value="${BaseSearch.grpNo}">
				</form>
                <table id="dccStatusSGL1" class="form_table">
                    <colgroup>
                        <col width="260px" />
                        <col />
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>SG NO</th>
                            <th>1</th>
                            <th>2</th>
                            <th>3</th>
                            <th>4</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>LEVEL (M)</th>
                            <td class="tr"><label id="lblData0" title="${DccTagInfoList[0].toolTip}" class="full flex_end">${lblDataList[0].fValue}</label></td>
                            <td class="tr"><label id="lblData1" title="${DccTagInfoList[1].toolTip}" class="full flex_end">${lblDataList[1].fValue}</label></td>
                            <td class="tr"><label id="lblData2" title="${DccTagInfoList[2].toolTip}" class="full flex_end">${lblDataList[2].fValue}</label></td>
                            <td class="tr"><label id="lblData0" title="${DccTagInfoList[0].toolTip}" class="full flex_end">${lblDataList[3].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>SETPOINT (M)</th>
                            <td class="tr"><label id="lblData4" title="${DccTagInfoList[4].toolTip}" class="full flex_end">${lblDataList[4].fValue}</label></td>
                            <td class="tr"><label id="lblCopy0" title="${DccTagInfoList[4].toolTip}" class="full flex_end">${lblDataList[4].fValue}</label></td>
                            <td class="tr"><label id="lblCopy1" title="${DccTagInfoList[4].toolTip}" class="full flex_end">${lblDataList[4].fValue}</label></td>
                            <td class="tr"><label id="lblCopy2" title="${DccTagInfoList[4].toolTip}" class="full flex_end">${lblDataList[4].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>ERROR (M)</th>
                            <td class="tr"><label id="lblData5" title="${DccTagInfoList[5].toolTip}" class="full flex_end">${lblDataList[5].fValue}</label></td>
                            <td class="tr"><label id="lblData6" title="${DccTagInfoList[6].toolTip}" class="full flex_end">${lblDataList[6].fValue}</label></td>
                            <td class="tr"><label id="lblData7" title="${DccTagInfoList[7].toolTip}" class="full flex_end">${lblDataList[7].fValue}</label></td>
                            <td class="tr"><label id="lblData8" title="${DccTagInfoList[8].toolTip}" class="full flex_end">${lblDataList[8].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>STEAM (PERU)</th>
                            <td class="tr"><label id="lblData9" title="${DccTagInfoList[9].toolTip}" class="full flex_end">${lblDataList[9].fValue}</label></td>
                            <td class="tr"><label id="lblData10" title="${DccTagInfoList[10].toolTip}" class="full flex_end">${lblDataList[10].fValue}</label></td>
                            <td class="tr"><label id="lblData11" title="${DccTagInfoList[11].toolTip}" class="full flex_end">${lblDataList[11].fValue}</label></td>
                            <td class="tr"><label id="lblData12" title="${DccTagInfoList[12].toolTip}" class="full flex_end">${lblDataList[12].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>FEEDWTR (PERU)</th>
                            <td class="tr"><label id="lblData13" title="${DccTagInfoList[13].toolTip}" class="full flex_end">${lblDataList[13].fValue}</label></td>
                            <td class="tr"><label id="lblData14" title="${DccTagInfoList[14].toolTip}" class="full flex_end">${lblDataList[14].fValue}</label></td>
                            <td class="tr"><label id="lblData15" title="${DccTagInfoList[15].toolTip}" class="full flex_end">${lblDataList[15].fValue}</label></td>
                            <td class="tr"><label id="lblData16" title="${DccTagInfoList[16].toolTip}" class="full flex_end">${lblDataList[16].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>COMP. LIFT (%)</th>
                            <td class="tr"><label id="lblData17" title="${DccTagInfoList[17].toolTip}" class="full flex_end">${lblDataList[17].fValue}</label></td>
                            <td class="tr"><label id="lblData18" title="${DccTagInfoList[18].toolTip}" class="full flex_end">${lblDataList[18].fValue}</label></td>
                            <td class="tr"><label id="lblData19" title="${DccTagInfoList[19].toolTip}" class="full flex_end">${lblDataList[19].fValue}</label></td>
                            <td class="tr"><label id="lblData20" title="${DccTagInfoList[20].toolTip}" class="full flex_end">${lblDataList[20].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>INT. LIFT (%)</th>
                            <td class="tr"><label id="lblData21" title="${DccTagInfoList[21].toolTip}" class="full flex_end">${lblDataList[21].fValue}</label></td>
                            <td class="tr"><label id="lblData22" title="${DccTagInfoList[22].toolTip}" class="full flex_end">${lblDataList[22].fValue}</label></td>
                            <td class="tr"><label id="lblData23" title="${DccTagInfoList[23].toolTip}" class="full flex_end">${lblDataList[23].fValue}</label></td>
                            <td class="tr"><label id="lblData24" title="${DccTagInfoList[24].toolTip}" class="full flex_end">${lblDataList[24].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>MAS BLNCE (FS)</th>
                            <td class="tr"><label id="lblData25" title="${DccTagInfoList[25].toolTip}" class="full flex_end">${lblDataList[25].fValue}</label></td>
                            <td class="tr"><label id="lblData26" title="${DccTagInfoList[26].toolTip}" class="full flex_end">${lblDataList[26].fValue}</label></td>
                            <td class="tr"><label id="lblData27" title="${DccTagInfoList[27].toolTip}" class="full flex_end">${lblDataList[27].fValue}</label></td>
                            <td class="tr"><label id="lblData28" title="${DccTagInfoList[28].toolTip}" class="full flex_end">${lblDataList[28].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>SMALL VLV (%)</th>
                            <td class="tr"><label id="lblData29" title="${DccTagInfoList[29].toolTip}" class="full flex_end">${lblDataList[29].fValue}</label></td>
                            <td class="tr"><label id="lblData30" title="${DccTagInfoList[30].toolTip}" class="full flex_end">${lblDataList[30].fValue}</label></td>
                            <td class="tr"><label id="lblData31" title="${DccTagInfoList[31].toolTip}" class="full flex_end">${lblDataList[31].fValue}</label></td>
                            <td class="tr"><label id="lblData32" title="${DccTagInfoList[32].toolTip}" class="full flex_end">${lblDataList[32].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>LARGE VLV (%)</th>
                            <td class="tr"><label id="lblData33" title="${DccTagInfoList[33].toolTip}" class="full flex_end">${lblDataList[33].fValue}</label></td>
                            <td class="tr"><label id="lblData34" title="${DccTagInfoList[34].toolTip}" class="full flex_end">${lblDataList[34].fValue}</label></td>
                            <td class="tr"><label id="lblData35" title="${DccTagInfoList[35].toolTip}" class="full flex_end">${lblDataList[35].fValue}</label></td>
                            <td class="tr"><label id="lblData36" title="${DccTagInfoList[63].toolTip}" class="full flex_end">${lblDataList[36].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>STEPBK MARG (M)</th>
                            <td class="tr"><label id="lblData37" title="${DccTagInfoList[37].toolTip}" class="full flex_end">${lblDataList[37].fValue}</label></td>
                            <td class="tr"><label id="lblData38" title="${DccTagInfoList[38].toolTip}" class="full flex_end">${lblDataList[38].fValue}</label></td>
                            <td class="tr"><label id="lblData39" title="${DccTagInfoList[39].toolTip}" class="full flex_end">${lblDataList[39].fValue}</label></td>
                            <td class="tr"><label id="lblData40" title="${DccTagInfoList[40].toolTip}" class="full flex_end">${lblDataList[40].fValue}</label></td>
                        </tr>
                        <tr>
                            <th>SG LCV TRAIN</th>
                            <td class="tr"><label id="lblData41" title="${DccTagInfoList[41].toolTip}" class="full flex_end"><c:if test="${lblDataList[41].fValue eq '0.00000'}">A</c:if>
                            	<c:if test="${lblDataList[41].fValue ne '0.00000'}">C</c:if></label></td>
                            <td class="tr"><label id="lblData42" title="${DccTagInfoList[42].toolTip}" class="full flex_end"><c:if test="${lblDataList[42].fValue eq '0.00000'}">A</c:if>
                            	<c:if test="${lblDataList[42].fValue ne '0.00000'}">C</c:if></label></td>
                            <td class="tr"><label id="lblData43" title="${DccTagInfoList[43].toolTip}" class="full flex_end"><c:if test="${lblDataList[43].fValue eq '0.00000'}">A</c:if>
                            	<c:if test="${lblDataList[43].fValue ne '0.00000'}">C</c:if></label></td>
                            <td class="tr"><label id="lblData44" title="${DccTagInfoList[44].toolTip} class="full flex_end"><c:if test="${lblDataList[44].fValue eq '0.00000'}">A</c:if>
                            	<c:if test="${lblDataList[44].fValue ne '0.00000'}">C</c:if></label></td>
                        </tr>
                        <tr>
                            <th>SG LEVEL HI</th>
                            <td class="tr"><label id="lblData45" title="${DccTagInfoList[45].toolTip}" class="full flex_end"><c:if test="${lblDataList[45].fValue eq '0.00000'}">NO</c:if>
                            	<c:if test="${lblDataList[45].fValue ne '0.00000'}">YES</c:if></label></td>
                            <td class="tr"><label id="lblData46" title="${DccTagInfoList[46].toolTip}" class="full flex_end"><c:if test="${lblDataList[46].fValue eq '0.00000'}">NO</c:if>
                            	<c:if test="${lblDataList[46].fValue ne '0.00000'}">YES</c:if></label></td>
                            <td class="tr"><label id="lblData47" title="${DccTagInfoList[47].toolTip}" class="full flex_end"><c:if test="${lblDataList[47].fValue eq '0.00000'}">NO</c:if>
                            	<c:if test="${lblDataList[47].fValue ne '0.00000'}">YES</c:if></label></td>
                            <td class="tr"><label id="lblData48" title="${DccTagInfoList[48].toolTip}" class="full flex_end"><c:if test="${lblDataList[48].fValue eq '0.00000'}">NO</c:if>
                            	<c:if test="${lblDataList[48].fValue ne '0.00000'}">YES</c:if></label></td>
                        </tr>
                        <tr>
                            <th>FD LINE BREAK</th>
                            <td class="tr"><label id="lblData49" title="${DccTagInfoList[49].toolTip}" class="full flex_end"><c:if test="${lblDataList[49].fValue eq 0}">NO</c:if></label>
                            	<c:if test="${lblDataList[49].fValue ne 0}">YES</c:if></label></td>
                            <td class="tr"><label id="lblData50" title="${DccTagInfoList[50].toolTip}" class="full flex_end"><c:if test="${lblDataList[50].fValue eq 0}">NO</c:if></label>
                            	<c:if test="${lblDataList[50].fValue ne 0}">YES</c:if></label></td>
                            <td class="tr"><label id="lblData51" title="${DccTagInfoList[51].toolTip}" class="full flex_end"><c:if test="${lblDataList[51].fValue eq 0}">NO</c:if></label>
                            	<c:if test="${lblDataList[51].fValue ne 0}">YES</c:if></label></td>
                            <td class="tr"><label id="lblData52" title="${DccTagInfoList[52].toolTip}" class="full flex_end"><c:if test="${lblDataList[52].fValue eq 0}">NO</c:if></label>
                            	<c:if test="${lblDataList[52].fValue ne 0}">YES</c:if></label></td>
                        </tr>
                        <tr>
                            <th>SG PR (MARG)</th>
                            <td class="tr"><label id="lblData53" title="${DccTagInfoList[53].toolTip}" class="full flex_end">${lblDataList[53].fValue}</label></td>
                            <td class="tr"><label id="lblData54" title="${DccTagInfoList[54].toolTip}" class="full flex_end">${lblDataList[54].fValue}</label></td>
                            <td class="tr"><label id="lblData55" title="${DccTagInfoList[55].toolTip}" class="full flex_end">${lblDataList[55].fValue}</label></td>
                            <td class="tr"><label id="lblData56" title="${DccTagInfoList[56].toolTip}" class="full flex_end">${lblDataList[56].fValue}</label></td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
                <!-- form_table -->
                <table id="dccStatusSGL2" class="form_table mt_none">
                    <colgroup>
                        <col width="260px" />
                        <col width="60px" />
                        <col />
                        <col width="60px" />
                        <col />
                        <col width="60px" />
                        <col />
                    </colgroup>
                    <tr>
                        <th>RECR. FL (KG/S)</th>
                        <th class="tc">P1</th>
                        <td class="tr"><label id="lblData57" title="${DccTagInfoList[57].toolTip}" class="full flex_end">${lblDataList[57].fValue}</label></td>
                        <th class="tc">P2</th>
                        <td class="tr"><label id="lblData58" title="${DccTagInfoList[58].toolTip}" class="full flex_end">${lblDataList[58].fValue}</label></td>
                        <th class="tc">P3</th>
                        <td class="tr"><label id="lblData59" title="${DccTagInfoList[59].toolTip}" class="full flex_end">${lblDataList[59].fValue}</label></td>
                    </tr>
                    <tr>
                        <th>DISCH. FL (KG/S)</th>
                        <th class="tc">P1</th>
                        <td class="tr"><label id="lblData60" title="${DccTagInfoList[60].toolTip}" class="full flex_end">${lblDataList[60].fValue}</label></td>
                        <th class="tc">P2</th>
                        <td class="tr"><label id="lblData61" title="${DccTagInfoList[61].toolTip}" class="full flex_end">${lblDataList[61].fValue}</label></td>
                        <th class="tc">P3</th>
                        <td class="tr"><label id="lblData262" title="${DccTagInfoList[62].toolTip}" class="full flex_end">${lblDataList[62].fValue}</label></td>
                    </tr>
                </table>
                <!-- //form_table --> 
            </div>
            <!-- //form_wrap -->
            <div class="fx_form full flex_end">
                <label class="title">REACTOR POWER</label>
                <label id="lblData63" title="${DccTagInfoList[4].toolTip}" class="full flex_end">${lblDataList[63].fValue}</label>
                <label>FP</label>
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

