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
		'${DccTagInfoList[0].xyGubun}','${DccTagInfoList[1].xyGubun}','${DccTagInfoList[2].xyGubun}','${DccTagInfoList[3].xyGubun}','${DccTagInfoList[4].xyGubun}',
		'${DccTagInfoList[5].xyGubun}','${DccTagInfoList[6].xyGubun}','${DccTagInfoList[7].xyGubun}','${DccTagInfoList[8].xyGubun}','${DccTagInfoList[9].xyGubun}',
		'${DccTagInfoList[10].xyGubun}','${DccTagInfoList[11].xyGubun}','${DccTagInfoList[12].xyGubun}','${DccTagInfoList[13].xyGubun}','${DccTagInfoList[14].xyGubun}',
		'${DccTagInfoList[15].xyGubun}','${DccTagInfoList[16].xyGubun}','${DccTagInfoList[17].xyGubun}','${DccTagInfoList[18].xyGubun}','${DccTagInfoList[19].xyGubun}',
		'${DccTagInfoList[20].xyGubun}','${DccTagInfoList[21].xyGubun}','${DccTagInfoList[22].xyGubun}','${DccTagInfoList[23].xyGubun}','${DccTagInfoList[24].xyGubun}',
		'${DccTagInfoList[25].xyGubun}','${DccTagInfoList[26].xyGubun}','${DccTagInfoList[27].xyGubun}','${DccTagInfoList[28].xyGubun}','${DccTagInfoList[29].xyGubun}',
		'${DccTagInfoList[30].xyGubun}','${DccTagInfoList[31].xyGubun}','${DccTagInfoList[32].xyGubun}','${DccTagInfoList[33].xyGubun}','${DccTagInfoList[34].xyGubun}',
		'${DccTagInfoList[35].xyGubun}','${DccTagInfoList[36].xyGubun}','${DccTagInfoList[37].xyGubun}','${DccTagInfoList[38].xyGubun}','${DccTagInfoList[39].xyGubun}',
		'${DccTagInfoList[40].xyGubun}','${DccTagInfoList[41].xyGubun}','${DccTagInfoList[42].xyGubun}','${DccTagInfoList[43].xyGubun}','${DccTagInfoList[44].xyGubun}',
		'${DccTagInfoList[45].xyGubun}','${DccTagInfoList[46].xyGubun}','${DccTagInfoList[47].xyGubun}','${DccTagInfoList[48].xyGubun}','${DccTagInfoList[49].xyGubun}',
		'${DccTagInfoList[50].xyGubun}','${DccTagInfoList[51].xyGubun}','${DccTagInfoList[52].xyGubun}','${DccTagInfoList[53].xyGubun}','${DccTagInfoList[54].xyGubun}',
		'${DccTagInfoList[55].xyGubun}','${DccTagInfoList[56].xyGubun}','${DccTagInfoList[57].xyGubun}','${DccTagInfoList[58].xyGubun}','${DccTagInfoList[59].xyGubun}',
		'${DccTagInfoList[60].xyGubun}','${DccTagInfoList[61].xyGubun}','${DccTagInfoList[62].xyGubun}','${DccTagInfoList[63].xyGubun}','${DccTagInfoList[64].xyGubun}'
	];
	
	var tToolTipText = [
		"${DccTagInfoList[0].descr}[${DccTagInfoList[0].hogi}:${DccTagInfoList[0].ioType}-${DccTagInfoList[0].address}:${DccTagInfoList[0].ioBit}]"
		,"${DccTagInfoList[1].descr}[${DccTagInfoList[1].hogi}:${DccTagInfoList[1].ioType}-${DccTagInfoList[1].address}:${DccTagInfoList[1].ioBit}]"
		,"${DccTagInfoList[2].descr}[${DccTagInfoList[2].hogi}:${DccTagInfoList[2].ioType}-${DccTagInfoList[2].address}:${DccTagInfoList[2].ioBit}]"
		,"${DccTagInfoList[3].descr}[${DccTagInfoList[3].hogi}:${DccTagInfoList[3].ioType}-${DccTagInfoList[3].address}:${DccTagInfoList[3].ioBit}]"
		,"${DccTagInfoList[4].descr}[${DccTagInfoList[4].hogi}:${DccTagInfoList[4].ioType}-${DccTagInfoList[4].address}:${DccTagInfoList[4].ioBit}]"
		,"${DccTagInfoList[5].descr}[${DccTagInfoList[5].hogi}:${DccTagInfoList[5].ioType}-${DccTagInfoList[5].address}:${DccTagInfoList[5].ioBit}]"
		,"${DccTagInfoList[6].descr}[${DccTagInfoList[6].hogi}:${DccTagInfoList[6].ioType}-${DccTagInfoList[6].address}:${DccTagInfoList[6].ioBit}]"
		,"${DccTagInfoList[7].descr}[${DccTagInfoList[7].hogi}:${DccTagInfoList[7].ioType}-${DccTagInfoList[7].address}:${DccTagInfoList[7].ioBit}]"
		,"${DccTagInfoList[8].descr}[${DccTagInfoList[8].hogi}:${DccTagInfoList[8].ioType}-${DccTagInfoList[8].address}:${DccTagInfoList[8].ioBit}]"
		,"${DccTagInfoList[9].descr}[${DccTagInfoList[9].hogi}:${DccTagInfoList[9].ioType}-${DccTagInfoList[9].address}:${DccTagInfoList[9].ioBit}]"
		,"${DccTagInfoList[10].descr}[${DccTagInfoList[10].hogi}:${DccTagInfoList[10].ioType}-${DccTagInfoList[10].address}:${DccTagInfoList[10].ioBit}]"
		,"${DccTagInfoList[11].descr}[${DccTagInfoList[11].hogi}:${DccTagInfoList[11].ioType}-${DccTagInfoList[11].address}:${DccTagInfoList[11].ioBit}]"
		,"${DccTagInfoList[12].descr}[${DccTagInfoList[12].hogi}:${DccTagInfoList[12].ioType}-${DccTagInfoList[12].address}:${DccTagInfoList[12].ioBit}]"
		,"${DccTagInfoList[13].descr}[${DccTagInfoList[13].hogi}:${DccTagInfoList[13].ioType}-${DccTagInfoList[13].address}:${DccTagInfoList[13].ioBit}]"
		,"${DccTagInfoList[14].descr}[${DccTagInfoList[14].hogi}:${DccTagInfoList[14].ioType}-${DccTagInfoList[14].address}:${DccTagInfoList[14].ioBit}]"
		,"${DccTagInfoList[15].descr}[${DccTagInfoList[15].hogi}:${DccTagInfoList[15].ioType}-${DccTagInfoList[15].address}:${DccTagInfoList[15].ioBit}]"
		,"${DccTagInfoList[16].descr}[${DccTagInfoList[16].hogi}:${DccTagInfoList[16].ioType}-${DccTagInfoList[16].address}:${DccTagInfoList[16].ioBit}]"
		,"${DccTagInfoList[17].descr}[${DccTagInfoList[17].hogi}:${DccTagInfoList[17].ioType}-${DccTagInfoList[17].address}:${DccTagInfoList[17].ioBit}]"
		,"${DccTagInfoList[18].descr}[${DccTagInfoList[18].hogi}:${DccTagInfoList[18].ioType}-${DccTagInfoList[18].address}:${DccTagInfoList[18].ioBit}]"
		,"${DccTagInfoList[19].descr}[${DccTagInfoList[19].hogi}:${DccTagInfoList[19].ioType}-${DccTagInfoList[19].address}:${DccTagInfoList[19].ioBit}]"
		,"${DccTagInfoList[20].descr}[${DccTagInfoList[20].hogi}:${DccTagInfoList[20].ioType}-${DccTagInfoList[20].address}:${DccTagInfoList[20].ioBit}]"
		,"${DccTagInfoList[21].descr}[${DccTagInfoList[21].hogi}:${DccTagInfoList[21].ioType}-${DccTagInfoList[21].address}:${DccTagInfoList[21].ioBit}]"
		,"${DccTagInfoList[22].descr}[${DccTagInfoList[22].hogi}:${DccTagInfoList[22].ioType}-${DccTagInfoList[22].address}:${DccTagInfoList[22].ioBit}]"
		,"${DccTagInfoList[23].descr}[${DccTagInfoList[23].hogi}:${DccTagInfoList[23].ioType}-${DccTagInfoList[23].address}:${DccTagInfoList[23].ioBit}]"
		,"${DccTagInfoList[24].descr}[${DccTagInfoList[24].hogi}:${DccTagInfoList[24].ioType}-${DccTagInfoList[24].address}:${DccTagInfoList[24].ioBit}]"
		,"${DccTagInfoList[25].descr}[${DccTagInfoList[25].hogi}:${DccTagInfoList[25].ioType}-${DccTagInfoList[25].address}:${DccTagInfoList[25].ioBit}]"
		,"${DccTagInfoList[26].descr}[${DccTagInfoList[26].hogi}:${DccTagInfoList[26].ioType}-${DccTagInfoList[26].address}:${DccTagInfoList[26].ioBit}]"
		,"${DccTagInfoList[27].descr}[${DccTagInfoList[27].hogi}:${DccTagInfoList[27].ioType}-${DccTagInfoList[27].address}:${DccTagInfoList[27].ioBit}]"
		,"${DccTagInfoList[28].descr}[${DccTagInfoList[28].hogi}:${DccTagInfoList[28].ioType}-${DccTagInfoList[28].address}:${DccTagInfoList[28].ioBit}]"
		,"${DccTagInfoList[29].descr}[${DccTagInfoList[29].hogi}:${DccTagInfoList[29].ioType}-${DccTagInfoList[29].address}:${DccTagInfoList[29].ioBit}]"
		,"${DccTagInfoList[30].descr}[${DccTagInfoList[30].hogi}:${DccTagInfoList[30].ioType}-${DccTagInfoList[30].address}:${DccTagInfoList[30].ioBit}]"
		,"${DccTagInfoList[31].descr}[${DccTagInfoList[31].hogi}:${DccTagInfoList[31].ioType}-${DccTagInfoList[31].address}:${DccTagInfoList[31].ioBit}]"
		,"${DccTagInfoList[32].descr}[${DccTagInfoList[32].hogi}:${DccTagInfoList[32].ioType}-${DccTagInfoList[32].address}:${DccTagInfoList[32].ioBit}]"
		,"${DccTagInfoList[33].descr}[${DccTagInfoList[33].hogi}:${DccTagInfoList[33].ioType}-${DccTagInfoList[33].address}:${DccTagInfoList[33].ioBit}]"
		,"${DccTagInfoList[34].descr}[${DccTagInfoList[34].hogi}:${DccTagInfoList[34].ioType}-${DccTagInfoList[34].address}:${DccTagInfoList[34].ioBit}]"
		,"${DccTagInfoList[35].descr}[${DccTagInfoList[35].hogi}:${DccTagInfoList[35].ioType}-${DccTagInfoList[35].address}:${DccTagInfoList[35].ioBit}]"
		,"${DccTagInfoList[36].descr}[${DccTagInfoList[36].hogi}:${DccTagInfoList[36].ioType}-${DccTagInfoList[36].address}:${DccTagInfoList[36].ioBit}]"
		,"${DccTagInfoList[37].descr}[${DccTagInfoList[37].hogi}:${DccTagInfoList[37].ioType}-${DccTagInfoList[37].address}:${DccTagInfoList[37].ioBit}]"
		,"${DccTagInfoList[38].descr}[${DccTagInfoList[38].hogi}:${DccTagInfoList[38].ioType}-${DccTagInfoList[38].address}:${DccTagInfoList[38].ioBit}]"
		,"${DccTagInfoList[39].descr}[${DccTagInfoList[39].hogi}:${DccTagInfoList[39].ioType}-${DccTagInfoList[39].address}:${DccTagInfoList[39].ioBit}]"
		,"${DccTagInfoList[40].descr}[${DccTagInfoList[40].hogi}:${DccTagInfoList[40].ioType}-${DccTagInfoList[40].address}:${DccTagInfoList[40].ioBit}]"
		,"${DccTagInfoList[41].descr}[${DccTagInfoList[41].hogi}:${DccTagInfoList[41].ioType}-${DccTagInfoList[41].address}:${DccTagInfoList[41].ioBit}]"
		,"${DccTagInfoList[42].descr}[${DccTagInfoList[42].hogi}:${DccTagInfoList[42].ioType}-${DccTagInfoList[42].address}:${DccTagInfoList[42].ioBit}]"
		,"${DccTagInfoList[43].descr}[${DccTagInfoList[43].hogi}:${DccTagInfoList[43].ioType}-${DccTagInfoList[43].address}:${DccTagInfoList[43].ioBit}]"
		,"${DccTagInfoList[44].descr}[${DccTagInfoList[44].hogi}:${DccTagInfoList[44].ioType}-${DccTagInfoList[44].address}:${DccTagInfoList[44].ioBit}]"
		,"${DccTagInfoList[45].descr}[${DccTagInfoList[45].hogi}:${DccTagInfoList[45].ioType}-${DccTagInfoList[45].address}:${DccTagInfoList[45].ioBit}]"
		,"${DccTagInfoList[46].descr}[${DccTagInfoList[46].hogi}:${DccTagInfoList[46].ioType}-${DccTagInfoList[46].address}:${DccTagInfoList[46].ioBit}]"
		,"${DccTagInfoList[47].descr}[${DccTagInfoList[47].hogi}:${DccTagInfoList[47].ioType}-${DccTagInfoList[47].address}:${DccTagInfoList[47].ioBit}]"
		,"${DccTagInfoList[48].descr}[${DccTagInfoList[48].hogi}:${DccTagInfoList[48].ioType}-${DccTagInfoList[48].address}:${DccTagInfoList[48].ioBit}]"
		,"${DccTagInfoList[49].descr}[${DccTagInfoList[49].hogi}:${DccTagInfoList[49].ioType}-${DccTagInfoList[49].address}:${DccTagInfoList[49].ioBit}]"
		,"${DccTagInfoList[50].descr}[${DccTagInfoList[50].hogi}:${DccTagInfoList[50].ioType}-${DccTagInfoList[50].address}:${DccTagInfoList[50].ioBit}]"
		,"${DccTagInfoList[51].descr}[${DccTagInfoList[51].hogi}:${DccTagInfoList[51].ioType}-${DccTagInfoList[51].address}:${DccTagInfoList[51].ioBit}]"
		,"${DccTagInfoList[52].descr}[${DccTagInfoList[52].hogi}:${DccTagInfoList[52].ioType}-${DccTagInfoList[52].address}:${DccTagInfoList[52].ioBit}]"
		,"${DccTagInfoList[53].descr}[${DccTagInfoList[53].hogi}:${DccTagInfoList[53].ioType}-${DccTagInfoList[53].address}:${DccTagInfoList[53].ioBit}]"
		,"${DccTagInfoList[54].descr}[${DccTagInfoList[54].hogi}:${DccTagInfoList[54].ioType}-${DccTagInfoList[54].address}:${DccTagInfoList[54].ioBit}]"
		,"${DccTagInfoList[55].descr}[${DccTagInfoList[55].hogi}:${DccTagInfoList[55].ioType}-${DccTagInfoList[55].address}:${DccTagInfoList[55].ioBit}]"
		,"${DccTagInfoList[56].descr}[${DccTagInfoList[56].hogi}:${DccTagInfoList[56].ioType}-${DccTagInfoList[56].address}:${DccTagInfoList[56].ioBit}]"
		,"${DccTagInfoList[57].descr}[${DccTagInfoList[57].hogi}:${DccTagInfoList[57].ioType}-${DccTagInfoList[57].address}:${DccTagInfoList[57].ioBit}]"
		,"${DccTagInfoList[58].descr}[${DccTagInfoList[58].hogi}:${DccTagInfoList[58].ioType}-${DccTagInfoList[58].address}:${DccTagInfoList[58].ioBit}]"
		,"${DccTagInfoList[59].descr}[${DccTagInfoList[59].hogi}:${DccTagInfoList[59].ioType}-${DccTagInfoList[59].address}:${DccTagInfoList[59].ioBit}]"
		,"${DccTagInfoList[60].descr}[${DccTagInfoList[60].hogi}:${DccTagInfoList[60].ioType}-${DccTagInfoList[60].address}:${DccTagInfoList[60].ioBit}]"
		,"${DccTagInfoList[61].descr}[${DccTagInfoList[61].hogi}:${DccTagInfoList[61].ioType}-${DccTagInfoList[61].address}:${DccTagInfoList[61].ioBit}]"
		,"${DccTagInfoList[62].descr}[${DccTagInfoList[62].hogi}:${DccTagInfoList[62].ioType}-${DccTagInfoList[62].address}:${DccTagInfoList[62].ioBit}]"
		,"${DccTagInfoList[63].descr}[${DccTagInfoList[63].hogi}:${DccTagInfoList[63].ioType}-${DccTagInfoList[63].address}:${DccTagInfoList[63].ioBit}]"
		,"${DccTagInfoList[64].descr}[${DccTagInfoList[64].hogi}:${DccTagInfoList[64].ioType}-${DccTagInfoList[64].address}:${DccTagInfoList[64].ioBit}]"
	];
	
	var selectTag = [{name:"hogi",value:""},{name:"xyGubun",value:""},{name:"loopName",value:""},{name:"ioType",value:""}
					,{name:"address",value:""},{name:"ioBit",value:""},{name:"descr",value:""}];
	
	function showTag(tagNo,iSeq) {
		//console.log('tagNo :: '+tagNo+' | iSeq :: '+iSeq);
		if(${UserInfo.grade} == '1' || ${UserInfo.grade} == '2') { // 나중에 grade 1 은 삭제할 것
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
		comSubmit.setUrl("/dcc/status/sglExcelExport");
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
		$(document.body).delegate('#dccStatusSGL1 label', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			if( cId != null && cId != '' && cId != 'undefined' ) {
				showTag(cId,tDccTagSeq[cId]);
			}
		});
		$(document.body).delegate('#dccStatusSGL1 label', 'mouseover focus', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			showTooltip(cId);
		});
		$(document.body).delegate('#dccStatusSGL2 label', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			if( cId != null && cId != '' && cId != 'undefined' ) {
				showTag(cId,tDccTagSeq[cId]);
			}
		});
		$(document.body).delegate('#dccStatusSGL2 label', 'mouseover focus', function() {
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
					comSubmit.setUrl("/dcc/status/sgl");
					comSubmit.addParam("hogiHeader",hogiHeader);
					comSubmit.addParam("xyHeader",xyHeader);
					comSubmit.submit();
				}
			},interval);
		} else {
			var	comSubmit	=	new ComSubmit("reloadFrm");
			comSubmit.setUrl("/dcc/status/sgl");
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
		
		comSubmit.setUrl("/dcc/status/sglSaveTag");
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
                <form id="reloadFrm" style="display:none"></form>
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
                            <td class="tr"><label id="0" class="full flex_end">${DccLogTrendInfoList[0].TVALUE1}</label></td>
                            <td class="tr"><label id="1" class="full flex_end">${DccLogTrendInfoList[0].TVALUE2}</label></td>
                            <td class="tr"><label id="2" class="full flex_end">${DccLogTrendInfoList[0].TVALUE3}</label></td>
                            <td class="tr"><label id="3" class="full flex_end">${DccLogTrendInfoList[0].TVALUE4}</label></td>
                        </tr>
                        <tr>
                            <th>SETPOINT (M)</th>
                            <td class="tr"><label id="4" class="full flex_end">${DccLogTrendInfoList[0].TVALUE5}</label></td>
                            <td class="tr"><label id="4" class="full flex_end">${DccLogTrendInfoList[0].TVALUE5}</label></td>
                            <td class="tr"><label id="4" class="full flex_end">${DccLogTrendInfoList[0].TVALUE5}</label></td>
                            <td class="tr"><label id="4" class="full flex_end">${DccLogTrendInfoList[0].TVALUE5}</label></td>
                        </tr>
                        <tr>
                            <th>ERROR (M)</th>
                            <td class="tr"><label id="5" class="full flex_end">${DccLogTrendInfoList[0].TVALUE6}</label></td>
                            <td class="tr"><label id="6" class="full flex_end">${DccLogTrendInfoList[0].TVALUE7}</label></td>
                            <td class="tr"><label id="7" class="full flex_end">${DccLogTrendInfoList[0].TVALUE8}</label></td>
                            <td class="tr"><label id="8" class="full flex_end">${DccLogTrendInfoList[0].TVALUE9}</label></td>
                        </tr>
                        <tr>
                            <th>STEAM (PERU)</th>
                            <td class="tr"><label id="9" class="full flex_end">${DccLogTrendInfoList[0].TVALUE10}</label></td>
                            <td class="tr"><label id="10" class="full flex_end">${DccLogTrendInfoList[0].TVALUE11}</label></td>
                            <td class="tr"><label id="11" class="full flex_end">${DccLogTrendInfoList[0].TVALUE12}</label></td>
                            <td class="tr"><label id="12" class="full flex_end">${DccLogTrendInfoList[0].TVALUE13}</label></td>
                        </tr>
                        <tr>
                            <th>FEEDWTR (PERU)</th>
                            <td class="tr"><label id="13" class="full flex_end">${DccLogTrendInfoList[0].TVALUE14}</label></td>
                            <td class="tr"><label id="14" class="full flex_end">${DccLogTrendInfoList[0].TVALUE15}</label></td>
                            <td class="tr"><label id="15" class="full flex_end">${DccLogTrendInfoList[0].TVALUE16}</label></td>
                            <td class="tr"><label id="16" class="full flex_end">${DccLogTrendInfoList[0].TVALUE17}</label></td>
                        </tr>
                        <tr>
                            <th>COMP. LIFT (%)</th>
                            <td class="tr"><label id="17" class="full flex_end">${DccLogTrendInfoList[0].TVALUE18}</label></td>
                            <td class="tr"><label id="18" class="full flex_end">${DccLogTrendInfoList[0].TVALUE19}</label></td>
                            <td class="tr"><label id="19" class="full flex_end">${DccLogTrendInfoList[0].TVALUE20}</label></td>
                            <td class="tr"><label id="20" class="full flex_end">${DccLogTrendInfoList[0].TVALUE21}</label></td>
                        </tr>
                        <tr>
                            <th>INT. LIFT (%)</th>
                            <td class="tr"><label id="21" class="full flex_end">${DccLogTrendInfoList[0].TVALUE22}</label></td>
                            <td class="tr"><label id="22" class="full flex_end">${DccLogTrendInfoList[0].TVALUE23}</label></td>
                            <td class="tr"><label id="23" class="full flex_end">${DccLogTrendInfoList[0].TVALUE24}</label></td>
                            <td class="tr"><label id="24" class="full flex_end">${DccLogTrendInfoList[0].TVALUE25}</label></td>
                        </tr>
                        <tr>
                            <th>MAS BLNCE (FS)</th>
                            <td class="tr"><label id="25" class="full flex_end">${DccLogTrendInfoList[0].TVALUE26}</label></td>
                            <td class="tr"><label id="26" class="full flex_end">${DccLogTrendInfoList[0].TVALUE27}</label></td>
                            <td class="tr"><label id="27" class="full flex_end">${DccLogTrendInfoList[0].TVALUE28}</label></td>
                            <td class="tr"><label id="28" class="full flex_end">${DccLogTrendInfoList[0].TVALUE29}</label></td>
                        </tr>
                        <tr>
                            <th>SMALL VLV (%)</th>
                            <td class="tr"><label id="29" class="full flex_end">${DccLogTrendInfoList[0].TVALUE30}</label></td>
                            <td class="tr"><label id="30" class="full flex_end">${DccLogTrendInfoList[0].TVALUE31}</label></td>
                            <td class="tr"><label id="31" class="full flex_end">${DccLogTrendInfoList[0].TVALUE32}</label></td>
                            <td class="tr"><label id="32" class="full flex_end">${DccLogTrendInfoList[0].TVALUE33}</label></td>
                        </tr>
                        <tr>
                            <th>LARGE VLV (%)</th>
                            <td class="tr"><label id="33" class="full flex_end">${DccLogTrendInfoList[0].TVALUE34}</label></td>
                            <td class="tr"><label id="34" class="full flex_end">${DccLogTrendInfoList[0].TVALUE35}</label></td>
                            <td class="tr"><label id="35" class="full flex_end">${DccLogTrendInfoList[0].TVALUE36}</label></td>
                            <td class="tr"><label id="36" class="full flex_end">${DccLogTrendInfoList[0].TVALUE37}</label></td>
                        </tr>
                        <tr>
                            <th>STEPBK MARG (M)</th>
                            <td class="tr"><label id="37" class="full flex_end">${DccLogTrendInfoList[0].TVALUE38}</label></td>
                            <td class="tr"><label id="38" class="full flex_end">${DccLogTrendInfoList[0].TVALUE39}</label></td>
                            <td class="tr"><label id="39" class="full flex_end">${DccLogTrendInfoList[0].TVALUE40}</label></td>
                            <td class="tr"><label id="40" class="full flex_end">${DccLogTrendInfoList[0].TVALUE41}</label></td>
                        </tr>
                        <tr>
                            <th>SG LCV TRAIN</th>
                            <td class="tr"><label id="41" class="full flex_end">${DccLogTrendInfoList[0].TVALUE42}</label></td>
                            <td class="tr"><label id="42" class="full flex_end">${DccLogTrendInfoList[0].TVALUE43}</label></td>
                            <td class="tr"><label id="43" class="full flex_end">${DccLogTrendInfoList[0].TVALUE44}</label></td>
                            <td class="tr"><label id="44" class="full flex_end">${DccLogTrendInfoList[0].TVALUE45}</label></td>
                        </tr>
                        <tr>
                            <th>SG LEVEL HI</th>
                            <td class="tr"><label id="45" class="full flex_end">${DccLogTrendInfoList[0].TVALUE46}</label></td>
                            <td class="tr"><label id="46" class="full flex_end">${DccLogTrendInfoList[0].TVALUE47}</label></td>
                            <td class="tr"><label id="47" class="full flex_end">${DccLogTrendInfoList[0].TVALUE48}</label></td>
                            <td class="tr"><label id="48" class="full flex_end">${DccLogTrendInfoList[0].TVALUE49}</label></td>
                        </tr>
                        <tr>
                            <th>FD LINE BREAK</th>
                            <td class="tr"><label id="49" class="full flex_end">${DccLogTrendInfoList[0].TVALUE50}</label></td>
                            <td class="tr"><label id="50" class="full flex_end">${DccLogTrendInfoList[0].TVALUE51}</label></td>
                            <td class="tr"><label id="51" class="full flex_end">${DccLogTrendInfoList[0].TVALUE52}</label></td>
                            <td class="tr"><label id="52" class="full flex_end">${DccLogTrendInfoList[0].TVALUE53}</label></td>
                        </tr>
                        <tr>
                            <th>SG PR (MARG)</th>
                            <td class="tr"><label id="53" class="full flex_end">${DccLogTrendInfoList[0].TVALUE54}</label></td>
                            <td class="tr"><label id="54" class="full flex_end">${DccLogTrendInfoList[0].TVALUE55}</label></td>
                            <td class="tr"><label id="55" class="full flex_end">${DccLogTrendInfoList[0].TVALUE56}</label></td>
                            <td class="tr"><label id="56" class="full flex_end">${DccLogTrendInfoList[0].TVALUE57}</label></td>
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
                        <td class="tr"><label id="57" class="full flex_end">${DccLogTrendInfoList[0].TVALUE58}</label></td>
                        <th class="tc">P2</th>
                        <td class="tr"><label id="58" class="full flex_end">${DccLogTrendInfoList[0].TVALUE59}</label></td>
                        <th class="tc">P3</th>
                        <td class="tr"><label id="59" class="full flex_end">${DccLogTrendInfoList[0].TVALUE60}</label></td>
                    </tr>
                    <tr>
                        <th>DISCH. FL (KG/S)</th>
                        <th class="tc">P1</th>
                        <td class="tr"><label id="60" class="full flex_end">${DccLogTrendInfoList[0].TVALUE61}</label></td>
                        <th class="tc">P2</th>
                        <td class="tr"><label id="61" class="full flex_end">${DccLogTrendInfoList[0].TVALUE62}</label></td>
                        <th class="tc">P3</th>
                        <td class="tr"><label id="62" class="full flex_end">${DccLogTrendInfoList[0].TVALUE63}</label></td>
                    </tr>
                </table>
                <!-- //form_table --> 
            </div>
            <!-- //form_wrap -->
            <div class="fx_form full flex_end">
                <label class="title">REACTOR POWER</label>
                <label id="63" class="full flex_end">${DccLogTrendInfoList[0].TVALUE64}</label>
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

