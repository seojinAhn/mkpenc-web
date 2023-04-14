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
		${DccTagInfoList[60].iSeq},${DccTagInfoList[61].iSeq},${DccTagInfoList[62].iSeq},${DccTagInfoList[63].iSeq},${DccTagInfoList[64].iSeq},
		${DccTagInfoList[65].iSeq},${DccTagInfoList[66].iSeq}
	];	
	
	var tDccTrendValue = [
		'${lblDataList[0].fValue}','${lblDataList[1].fValue}','${lblDataList[2].fValue}','${lblDataList[3].fValue}','${lblDataList[4].fValue}',
		'${lblDataList[5].fValue}','${lblDataList[6].fValue}','${lblDataList[7].fValue}','${lblDataList[8].fValue}','${lblDataList[9].fValue}',
		'${lblDataList[10].fValue}','${lblDataList[11].fValue}','${lblDataList[12].fValue}','${lblDataList[13].fValue}','${lblDataList[14].fValue}',
		'${lblDataList[15].fValue}','${lblDataList[16].fValue}','${lblDataList[17].fValue}','${lblDataList[18].fValue}','${lblDataList[19].fValue}',
		'${lblDataList[20].fValue}','${lblDataList[21].fValue}','${lblDataList[22].fValue}','${lblDataList[23].fValue}','${lblDataList[24].fValue}',
		'${lblDataList[25].fValue}','${lblDataList[26].fValue}','${lblDataList[27].fValue}','${lblDataList[28].fValue}','${lblDataList[29].fValue}',
		'${lblDataList[30].fValue}','${lblDataList[31].fValue}','${lblDataList[32].fValue}','${lblDataList[33].fValue}','${lblDataList[34].fValue}',
		'${lblDataList[35].fValue}','${lblDataList[36].fValue}','${lblDataList[37].fValue}','${lblDataList[38].fValue}','${lblDataList[39].fValue}',
		'${lblDataList[40].fValue}','${lblDataList[41].fValue}','${lblDataList[42].fValue}','${lblDataList[43].fValue}','${lblDataList[44].fValue}',
		'${lblDataList[45].fValue}','${lblDataList[46].fValue}','${lblDataList[47].fValue}','${lblDataList[48].fValue}','${lblDataList[49].fValue}',
		'${lblDataList[50].fValue}','${lblDataList[51].fValue}','${lblDataList[52].fValue}','${lblDataList[53].fValue}','${lblDataList[54].fValue}',
		'${lblDataList[55].fValue}','${lblDataList[56].fValue}','${lblDataList[57].fValue}','${lblDataList[58].fValue}','${lblDataList[59].fValue}',
		'${lblDataList[60].fValue}','${lblDataList[61].fValue}','${lblDataList[62].fValue}','${lblDataList[63].fValue}','${lblDataList[64].fValue}',
		'${lblDataList[65].fValue}','${lblDataList[66].fValue}'
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
		'${DccTagInfoList[60].XYGubun}','${DccTagInfoList[61].XYGubun}','${DccTagInfoList[62].XYGubun}','${DccTagInfoList[63].XYGubun}','${DccTagInfoList[64].XYGubun}',
		'${DccTagInfoList[65].XYGubun}','${DccTagInfoList[66].XYGubun}'
	];
	
	var tToolTipText = [
		'${DccTagInfoList[0].toolTip}'		,'${DccTagInfoList[1].toolTip}'		,'${DccTagInfoList[2].toolTip}'		,'${DccTagInfoList[3].toolTip}'		,'${DccTagInfoList[4].toolTip}'
		,'${DccTagInfoList[5].toolTip}'		,'${DccTagInfoList[6].toolTip}'		,'${DccTagInfoList[7].toolTip}'		,'${DccTagInfoList[8].toolTip}'		,'${DccTagInfoList[9].toolTip}'
		,'${DccTagInfoList[10].toolTip}'		,'${DccTagInfoList[11].toolTip}'		,'${DccTagInfoList[12].toolTip}'		,'${DccTagInfoList[13].toolTip}'		,'${DccTagInfoList[14].toolTip}'
		,'${DccTagInfoList[15].toolTip}'		,'${DccTagInfoList[16].toolTip}'		,'${DccTagInfoList[17].toolTip}'		,'${DccTagInfoList[18].toolTip}'		,'${DccTagInfoList[19].toolTip}'
		,'${DccTagInfoList[20].toolTip}'		,'${DccTagInfoList[21].toolTip}'		,'${DccTagInfoList[22].toolTip}'		,'${DccTagInfoList[23].toolTip}'		,'${DccTagInfoList[24].toolTip}'
		,'${DccTagInfoList[25].toolTip}'		,'${DccTagInfoList[26].toolTip}'		,'${DccTagInfoList[27].toolTip}'		,'${DccTagInfoList[28].toolTip}'		,'${DccTagInfoList[29].toolTip}'
		,'${DccTagInfoList[30].toolTip}'		,'${DccTagInfoList[31].toolTip}'		,'${DccTagInfoList[32].toolTip}'		,'${DccTagInfoList[33].toolTip}'		,'${DccTagInfoList[34].toolTip}'
		,'${DccTagInfoList[35].toolTip}'		,'${DccTagInfoList[36].toolTip}'		,'${DccTagInfoList[37].toolTip}'		,'${DccTagInfoList[38].toolTip}'		,'${DccTagInfoList[39].toolTip}'
		,'${DccTagInfoList[40].toolTip}'		,'${DccTagInfoList[41].toolTip}'		,'${DccTagInfoList[42].toolTip}'		,'${DccTagInfoList[43].toolTip}'		,'${DccTagInfoList[44].toolTip}'
		,'${DccTagInfoList[45].toolTip}'		,'${DccTagInfoList[46].toolTip}'		,'${DccTagInfoList[47].toolTip}'		,'${DccTagInfoList[48].toolTip}'		,'${DccTagInfoList[49].toolTip}'
		,'${DccTagInfoList[50].toolTip}'		,'${DccTagInfoList[51].toolTip}'		,'${DccTagInfoList[52].toolTip}'		,'${DccTagInfoList[53].toolTip}'		,'${DccTagInfoList[54].toolTip}'
		,'${DccTagInfoList[55].toolTip}'		,'${DccTagInfoList[56].toolTip}'		,'${DccTagInfoList[57].toolTip}'		,'${DccTagInfoList[58].toolTip}'		,'${DccTagInfoList[59].toolTip}'
		,'${DccTagInfoList[60].toolTip}'		,'${DccTagInfoList[61].toolTip}'		,'${DccTagInfoList[62].toolTip}'		,'${DccTagInfoList[63].toolTip}'		,'${DccTagInfoList[64].toolTip}'
		,'${DccTagInfoList[65].toolTip}'		,'${DccTagInfoList[66].toolTip}'
	];
	
	var selectTag = [{name:"hogi",value:""},{name:"xyGubun",value:""},{name:"loopName",value:""},{name:"ioType",value:""}
					,{name:"address",value:""},{name:"ioBit",value:""},{name:"descr",value:""}];
	
	var lblSP = ['7550','0.0334','0','10.24','1.08','4 OF 14'];
	var lblSPUnit = ['M','D/S','M','MPA','FFP','AT LEAST'];
	var lblFP = ['0.0','0.01','0.0','0.005','0.0','0.005','0.005','0.0','0.02'];
	
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
	
	function getToolTipText(id) {
		var tooltipText = '';
		var mod = '';
		
		if( id*1 < 3 ) {
			tooltipText = '1||'+tToolTipText[0];//+','+tToolTipText[1]+','+tToolTipText[2];
		} else if( id*1 > 2 && id*1 < 6 ) {
			tooltipText = '4||'+tToolTipText[3];//+','+tToolTipText[4]+','+tToolTipText[5];
		} else if( id*1 > 11 && id*1 < 24 ) {
			mod = id*1 - (id*1)%3;
			tooltipText = (mod+1)+'||'+tToolTipText[tDccTrendValue[mod+1]];
		} else if( id*1 > 27 && id*1 < 56 ) {
			mod = id*1 - (id*1)%2;
			tooltipText = (mod+1)+'||'+tToolTipText[tDccTrendValue[mod+1]];
		} else {
			tooltipText = id+'||'+tToolTipText[id*1];
		}
		
		return tooltipText;
	}
	
	function showTooltip(id) {
		var tooltipText;

		if( id != 'undefined' && id != null && id != '' ) {
			if( id == '0' || id == '3') {
				tooltipText = tToolTipText[id*1]+','+tToolTipText[id*1+1]+','+tToolTipText[id*1+2];
			} else if ( id == '1' || id == '2' || id == '4' || id == '5' ) {
				tooltipText = "";
			} else if( id == '12' || id == '15' || id == '18' || id == '21' || id == '28' || id == '30'
					|| id == '32' || id == '34' || id == '36' || id == '38' || id == '40' || id == '42'
					|| id == '44' || id == '46' || id == '48' || id == '50' || id == '52' || id == '54') {
				tooltipText = tToolTipText[tDccTrendValue[id*1+1]];
			} else if( id.indexOf('lbl') > -1 || id.indexOf('shp') > -1 ){
				tooltipText = "";
			} else {
				tooltipText = tToolTipText[id*1];
			}
			
			if( tooltipText.indexOf(":]") > -1 ) {
				tooltipText = tooltipText.replace(":]","]");
			}
			
			if( id != 'undefined' && id != null && id != '' ) {
				$("#"+id).attr("title",tooltipText);
			}
		}
	}
	
	function toCSV() {
		var	comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl("/dcc/status/stbExcelExport");
		comSubmit.submit();
	}
	
	function setConst() {
		$("#lblSP0").text(lblSP[0]);
		$("#lblSP1").text(lblSP[1]);
		$("#lblSP2").text(lblSP[2]);
		$("#lblSP3").text(lblSP[3]);
		$("#lblSP4").text(lblSP[4]);
		$("#lblSP5").text(lblSP[5]);
		
		$("#lblSPUnit0").text(lblSPUnit[0]);
		$("#lblSPUnit1").text(lblSPUnit[1]);
		$("#lblSPUnit2").text(lblSPUnit[2]);
		$("#lblSPUnit3").text(lblSPUnit[3]);
		$("#lblSPUnit4").text(lblSPUnit[4]);
		$("#lblSPUnit5").text(lblSPUnit[5]);
		
		$("#lblFP0").text(lblFP[0]);
		$("#lblFP1").text(lblFP[1]);
		$("#lblFP2").text(lblFP[2]);
		$("#lblFP3").text(lblFP[3]);
		$("#lblFP4").text(lblFP[4]);
		$("#lblFP5").text(lblFP[5]);
		$("#lblFP6").text(lblFP[6]);
		$("#lblFP7").text(lblFP[7]);
		$("#lblFP8").text(lblFP[8]);
		
		$("#shpIND0").attr("class","st_label st_cond_out");
		$("#shpIND1").attr("class","st_label st_cond_out");
		$("#shpIND2").attr("class","st_label st_cond_out");
		$("#shpIND3").attr("class","st_label st_cond_out");
		$("#shpIND4").attr("class","st_label st_cond_out");
		$("#shpIND5").attr("class","st_label st_cond_out");
		$("#shpIND6").attr("class","st_label st_cond_out");
		$("#shpIND7").attr("class","st_label st_cond_out");
		$("#shpIND8").attr("class","st_label st_cond_out");
		
		var in0,in1,in2,in3,in4,in5,in6,in7,in8 = false;
		var iy0,iy1,iy2,iy3,iy4,iy5,iy6,iy7,iy8 = false;
		var val6 = tDccTrendValue[6] == 'ON' ? 1 : 0;
		var val7 = tDccTrendValue[7] == 'ON' ? 1 : 0;
		var val8 = tDccTrendValue[8] == 'ON' ? 1 : 0;
		var val9 = tDccTrendValue[9] == 'ON' ? 1 : 0;
		
		in0 = 10**(tDccTrendValue[65]*1) < lblFP[0]*1 ? true : false;
		in1 = 10**(tDccTrendValue[65]*1) < lblFP[1]*1 ? true : false;
		in2 = 10**(tDccTrendValue[65]*1) < lblFP[2]*1 ? true : false;
		in3 = 10**(tDccTrendValue[65]*1) < lblFP[3]*1 ? true : false;
		in4 = 10**(tDccTrendValue[65]*1) < lblFP[4]*1 ? true : false;
		in5 = 10**(tDccTrendValue[65]*1) < lblFP[5]*1 ? true : false;
		in6 = 10**(tDccTrendValue[65]*1) < lblFP[6]*1 ? true : false;
		in7 = 10**(tDccTrendValue[65]*1) < lblFP[7]*1 ? true : false;
		in8 = 10**(tDccTrendValue[65]*1) < lblFP[8]*1 ? true : false;
		iy0 = (tDccTrendValue[0] == 'YES' || tDccTrendValue[3] == 'YES') ? true : false;
		iy1 = (val6 + val8 < 2 || val7 + val9 < 2) ? true : false;
		iy2 = (val6 + val7 < 1 || val7 + val9 < 1) ? true : false;
		if( isNaN(tDccTrendValue[61]*1) ) {
			iy5 = (tDccTrendValue[12]*1 < tDccTrendValue[61]*1) ? true : false;
		}
		iy8 = (tDccTrendValue[56] == 'YES') ? true : false;
		
		if( iy0 ) {
			$("#shpIND0").attr("class","st_label st_yes");
		} else {
			if( in0 ) {
				$("#shpIND0").attr("class","st_label st_no");
			} else {
				$("#shpIND0").attr("class","st_label st_cond_out");
			}
		}
		if( iy1 ) {
			$("#shpIND1").attr("class","st_label st_yes");
		} else {
			if( in1 ) {
				$("#shpIND1").attr("class","st_label st_no");
			} else {
				$("#shpIND1").attr("class","st_label st_cond_out");
			}
		}
		if( iy2 ) {
			$("#shpIND2").attr("class","st_label st_yes");
		} else {
			if( in2 ) {
				$("#shpIND2").attr("class","st_label st_no");
			} else {
				$("#shpIND2").attr("class","st_label st_cond_out");
			}
		}
		if( in3 ) {
			$("#shpIND3").attr("class","st_label st_no");
		} else {
			$("#shpIND3").attr("class","st_label st_cond_out");
		}
		if( in4 ) {
			$("#shpIND4").attr("class","st_label st_no");
		} else {
			$("#shpIND4").attr("class","st_label st_cond_out");
		}
		if( iy5 ) {
			$("#shpIND5").attr("class","st_label st_yes");
		} else {
			if( in5 ) {
				$("#shpIND5").attr("class","st_label st_no");
			} else {
				$("#shpIND5").attr("class","st_label st_cond_out");
			}
		}
		if( in6 ) {
			$("#shpIND6").attr("class","st_label st_no");
		} else {
			$("#shpIND6").attr("class","st_label st_cond_out");
		}
		if( in7 ) {
			$("#shpIND7").attr("class","st_label st_no");
		} else {
			$("#shpIND7").attr("class","st_label st_cond_out");
		}
		if( iy8 ) {
			$("#shpIND8").attr("class","st_label st_yes");
		} else {
			if( in8 ) {
				$("#shpIND8").attr("class","st_label st_no");
			} else {
				$("#shpIND8").attr("class","st_label st_cond_out");
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

		setConst();

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
		$(document.body).delegate('#dccStatusSTBForm label', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			cId = getToolTipText(cId).split("||")[0];
			if( cId != null && cId != '' && cId != 'undefined' && cId.indexOf('lbl') == -1 && cId.indexOf('shp') == -1 ) {
				showTag(cId,tDccTagSeq[cId]);
			}
		});
		$(document.body).delegate('#dccStatusSTBForm label', 'mouseover focus', function() {
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
					comSubmit.setUrl("/dcc/status/stepbackstatus");
					comSubmit.addParam("hogiHeader",hogiHeader);
					comSubmit.addParam("xyHeader",xyHeader);
					comSubmit.submit();
				}
			},interval);
		} else {
			var	comSubmit	=	new ComSubmit("reloadFrm");
			comSubmit.setUrl("/dcc/status/stepbackstatus");
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
		
		comSubmit.setUrl("/dcc/status/stbSaveTag");
		comSubmit.ajax();
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
		
		comAjax.setUrl("/dcc/status/stbTagSearch");
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
		
		comAjax.setUrl("/dcc/status/stbTagFind");
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
		comSubmit.setUrl("/dcc/status/stepbackstatus");
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
				<h3>STEPBACK STATUS</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>STEPBACK STATUS</strong></div>
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
				<!-- form_head -->
                <form id="reloadFrm" style="display:none"></form>
                <form id="dccStatusSTBForm">
				<div class="form_head">
					<div class="form_info">
                        <div class="fx_legend">
                            <ul>
                                <li class="title">INDICATOR</li>
                                <li class="no">NO</li>
                                <li class="yes">YES</li>
                                <li class="cond_out">COND-OUT</li>
                            </ul>
                        </div>
                        <div class="fx_legend txt_type">
                            <ul>
                                <li class="title">MCA</li>
                                <li>1)&nbsp;<label id="57" style="font-weight:500;">${lblDataList[57].fValue}</label></li>
                                <li>2)&nbsp;<label id="58" style="font-weight:500;">${lblDataList[58].fValue}</label></li>
                                <li>3)&nbsp;<label id="59" style="font-weight:500;">${lblDataList[59].fValue}</label></li>
                                <li>4)&nbsp;<label id="60" style="font-weight:500;">${lblDataList[60].fValue}</label></li>
                            </ul>
                        </div>
					</div>
				</div>
				<!-- //form_head -->                      
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col />
                        <col width="200px" />
                        <col width="100px" />
                        <col width="200px" />
                        <col width="100px" />
                        <col width="200px" />
                        <col width="200px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>PARAMETER</th>
                            <th>SETPOINT</th>
                            <th colspan="4">STATUS</th>
                            <th>END FP</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span id="shpIND0" class="st_label st_no"></span>
                                    <label>RX TRIP</label>
                                </div>
                            </th>
                            <td class="tc">-----------</td>
                            <th class="tc">SDS #1</th>
                            <td class="tc"><label id="0">${lblDataList[0].fValue}</label></td>
                            <th class="tc">SDS #2</th>
                            <td class="tc"><label id="3">${lblDataList[3].fValue}</label></td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP0" class="double">0.0</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span id="shpIND1" class="st_label st_no"></span>
                                    <label>PHT 1P TRIP</label>
                                </div>
                            </th>
                            <td class="tc">-----------</td>
                            <th class="tc">PHP #1</th>
                            <td class="tc"><label id="6">${lblDataList[6].fValue}</label></td>
                            <th class="tc">PHP #2</th>
                            <td class="tc"><label id="7">${lblDataList[7].fValue}</label></td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP1" class="double">0.01</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span id="shpIND2" class="st_label st_no"></span>
                                    <label>PHT 2P TRIP</label>
                                </div>
                            </th>
                            <td class="tc">-----------</td>
                            <th class="tc">PHP #3</th>
                            <td class="tc"><label id="8">${lblDataList[8].fValue}</label></td>
                            <th class="tc">PHP #4</th>
                            <td class="tc"><label id="9">${lblDataList[9].fValue}</label></td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP2" class="double">0.0</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span id="shpIND3" class="st_label st_no"></span>
                                    <label>MOD LVL LO</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP0" class="full flex_end"></label>
                                    <label id="lblSPUnit0" class="full"></label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label id="10" class="double flex_end">${lblDataList[10].fValue}</label>
                                    <label class="full"></label>
                                </div>   
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP3" class="double">0.005</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span id="shpIND4" class="st_label st_no"></span>
                                    <label>LOG RATE HI</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP1" class="full flex_end"></label>
                                    <label id="lblSPUnit1" class="full"></label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label id="11" class="double flex_end">${lblDataList[11].fValue}</label>
                                    <label class="full"></label>
                                </div>   
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP4" class="double"0.0></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2">
                                <div class="fx_form">
                                    <span id="shpIND5" class="st_label st_yes"></span>
                                    <label>SG LVL LO</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="2">
                                <div class="fx_form">
                                    <label id="61" class="full flex_end">${lblDataList[61].fValue}</label>
                                    <label id="lblSPUnit2" class="full"></label>
                                </div>                                  
                            </td>
                            <th class="tc">SG #1</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="12" class="double flex_end">${lblDataList[12].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">SG #2</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="15" class="double flex_end">${lblDataList[15].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td rowspan="2">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP5" class="double">0.005</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">SG #3</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="18" class="double flex_end">${lblDataList[18].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">SG #4</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="21" class="double flex_end">${lblDataList[21].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2">
                                <div class="fx_form">
                                    <span id="shpIND6" class="st_label st_cond_out"></span>
                                    <label>HT PR HI</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="2">
                                <div class="fx_form">
                                    <label id="lblSP3" class="full flex_end"></label>
                                    <label id="lblSPUnit3" class="full"></label>
                                </div>                                  
                            </td>
                            <th class="tc">ROH #1</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="24" class="double flex_end">${lblDataList[24].TVALUE25}</label>
                                    <label class="full"></label>
                                </div>                                  
                            </td>
                            <th class="tc">ROH #2</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="25" class="double flex_end">${lblDataList[25].fValue}</label>
                                    <label class="full"></label>
                                </div>                                  
                            </td>
                            <td rowspan="2">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP6" class="double">0.005</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">ROH #3</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="26" class="double flex_end">${lblDataList[26].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">ROH #4</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="27" class="double flex_end">${lblDataList[27].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="7">
                                <div class="fx_form">
                                    <span id="shpIND7" class="st_label st_no"></span>
                                    <label>ZONE PWR HI</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="7">
                                <div class="fx_form_column">
                                    <div class="fx_form">
                                        <label id="lblSP4" class="full flex_end"></label>
                                        <label id="lblSPUnit4" class="full"></label>
                                    </div>
                                    <div class="fx_form">
                                        <label id="lblSPUnit5" class="full flex_center"></label>
                                    </div>
                                    <div class="fx_form">
                                        <label id="lblSP5" class="full flex_center"></label>
                                    </div>
                                </div>
                            </td>
                            <th class="tc">Z #01</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="28" class="double flex_end">${lblDataList[28].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #08</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="42" class="double flex_end">${lblDataList[42].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td rowspan="7">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP7" class="double">0.0</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #02</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="30" class="double flex_end">${lblDataList[30].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #09</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="44" class="double flex_end">${lblDataList[44].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #03</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="32" class="double flex_end">${lblDataList[32].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #10</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="46" class="double flex_end">${lblDataList[46].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #04</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="34" class="double flex_end">${lblDataList[34].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #11</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="48" class="double flex_end">${lblDataList[48].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #05</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="36" class="double flex_end">${lblDataList[36].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #12</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="50" class="double flex_end">${lblDataList[50].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #06</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="38" class="double flex_end">${lblDataList[38].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #13</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="52" class="double flex_end">${lblDataList[52].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #07</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="40" class="double flex_end">${lblDataList[40].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #14</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="54" class="double flex_end">${lblDataList[54].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span id="shpIND8" class="st_label st_no"></span>
                                    <label>TEST</label>
                                </div>
                            </th>
                            <td class="tc"></td>
                            <td class="tc" colspan="4"><label id="56">${lblDataList[56].fValue}</label></td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP8" class="double">0.02</label>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                </form>
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
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>s
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

