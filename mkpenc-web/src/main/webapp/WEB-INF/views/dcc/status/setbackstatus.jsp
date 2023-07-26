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
	var type = 1;
	
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
		${DccTagInfoList[55].iSeq}
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
		'${lblDataList[55].fValue}'
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
		'${DccTagInfoList[55].XYGubun}'
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
		,"${DccTagInfoList[55].toolTip}"
	];
	
	var dccGrpTagListAjax = {};
	var lblDataListAjax = {};
	var lblConvListAjax = {};
	
	var selectTag = [{name:"hogi",value:""},{name:"xyGubun",value:""},{name:"loopName",value:""},{name:"ioType",value:""}
					,{name:"address",value:""},{name:"ioBit",value:""},{name:"descr",value:""}];
	
	var lblSP = ['0.28','1.1','0.827','3.9','79','109.7','2440','4.83','1.1','0.2'];
	var lblSPUnit = ['MPA','FFP','MPA','MPA','℃','M','MM','MPA','FFP','TILT','FFP'];
	var lblFP = ['0.02','0.6','0.6','0.02','0.02','0.02','0.02','0.08','0.6','0.6','0.02'];
	
	function showTag(tagNo,iSeq) {

		if(${UserInfo.grade} == '1' || ${UserInfo.grade} == '2') { // 나중에 grade 1 은 삭제할 것
			timerOn = false;
		
			$("#tagNo").val(tagNo);
			
			var toolTip = type == 1 ? tToolTipText[tagNo] : dccGrpTagListAjax[tagNo].toolTip;
			var strDescr = toolTip.substring(0, toolTip.lastIndexOf('['));
			var infos =  toolTip.substring(toolTip.lastIndexOf('[')+1, toolTip.lastIndexOf(']')).split(":");

			$("#txtHogi").val(infos[0]);
	        $("#txtXyGubun").val(type == 1 ? tDccTagXy[tagNo] : dccGrpTagListAjax[tagNo].xyGubun);
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
		
		if( type == 1 ) {
			if( id*1 > 2 && id*1 < 5 ) {
				tooltipText = '3||'+tToolTipText[0];//+','+tToolTipText[1];
			} else if( id*1 > 24 && id*1 < 28 ) {
				tooltipText = '25||'+tToolTipText[25];//+','+tToolTipText[26]+','+tToolTipText[27];
			} else if( id*1 < 2 || (id*1 > 17 && id*1 < 21) ) {
				mod = id*1 - (id*1)%3;
				tooltipText = (mod+1)+'||'+tToolTipText[tDccTrendValue[mod+1]];
			} else if( id*1 > 4 && id*1 < 14 ) {
				mod = id*1 - (id*1+1)%3;
				tooltipText = (mod+1)+'||'+tToolTipText[tDccTrendValue[mod+1]];
			} else if( id*1 > 13 && id*1 < 18 ) {
				mod = id*1 - (id*1+2)%4;
				tooltipText = (mod+1)+'||'+tToolTipText[tDccTrendValue[mod+1]];
			} else {
				tooltipText = id+'||'+tToolTipText[id*1];
			}
		} else {
			if( id*1 > 2 && id*1 < 5 ) {
				tooltipText = '3||'+dccGrpTagList[0].toolTip;//+','+tToolTipText[1];
			} else if( id*1 > 24 && id*1 < 28 ) {
				tooltipText = '25||'+dccGrpTagList[25].toolTip;//+','+tToolTipText[26]+','+tToolTipText[27];
			} else if( id*1 < 2 || (id*1 > 17 && id*1 < 21) ) {
				mod = id*1 - (id*1)%3;
				tooltipText = (mod+1)+'||'+dccGrpTagList[lblDatListAjax[mod+1].fValue*1].toolTip;
			} else if( id*1 > 4 && id*1 < 14 ) {
				mod = id*1 - (id*1+1)%3;
				tooltipText = (mod+1)+'||'+dccGrpTagList[lblDatListAjax[mod+1].fValue*1].toolTip;
			} else if( id*1 > 13 && id*1 < 18 ) {
				mod = id*1 - (id*1+2)%4;
				tooltipText = (mod+1)+'||'+dccGrpTagList[lblDatListAjax[mod+1].fValue*1].toolTip;
			} else {
				tooltipText = id+'||'+dccGrpTagList[id*1].toolTip;
			}
		}

		return tooltipText;
	}
	
	function showTooltip(id) {
		var tooltipText;

		if( type == 1 ) {
			if( id != 'undefined' && id != null && id != '' ) {
				if( id == '3' ) {
					tooltipText = tToolTipText[id*1]+', '+tToolTipText[id*1+1];
				} else if( id == '25') {
					tooltipText = tToolTipText[id*1]+', '+tToolTipText[id*1+1]+', '+tToolTipText[id*1+2];
				} else if ( id == '1' || id == '2' || id == '4' || id == '6' || id == '7' ) {
					tooltipText = "";
				} else if( id == '0' || id == '5' || id == '8' || id == '11' || id == '14' || id == '18') {
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
					$("#lbl"+id).attr("title",tooltipText);
				}
			}
		} else {
			if( id != 'undefined' && id != null && id != '' ) {
				if( id == '3' ) {
					tooltipText = dccGrpTagList[id*1].toolTip+', '+dccGrpTagList[id*1+1].toolTip;
				} else if( id == '25') {
					tooltipText = dccGrpTagList[id*1].toolTip+', '+dccGrpTagList[id*1+1].toolTip+', '+dccGrpTagList[id*1+2].toolTip;
				} else if ( id == '1' || id == '2' || id == '4' || id == '6' || id == '7' ) {
					tooltipText = "";
				} else if( id == '0' || id == '5' || id == '8' || id == '11' || id == '14' || id == '18') {
					tooltipText = dccGrpTagList[lblDataListAjax[id*1+1].fValue*1].toolTip;
				} else if( id.indexOf('lbl') > -1 || id.indexOf('shp') > -1 ){
					tooltipText = "";
				} else {
					tooltipText = dccGrpTagList[id*1].toolTip;
				}
				
				if( tooltipText.indexOf(":]") > -1 ) {
					tooltipText = tooltipText.replace(":]","]");
				}
				
				if( id != 'undefined' && id != null && id != '' ) {
					$("#lbl"+id).attr("title",tooltipText);
				}
			}
		}
	}
	
	function toCSV() {
		var	comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl("/dcc/status/sbExcelExport");
		comSubmit.submit();
	}
	
	function setConst() {
		$("#lblSP0").text(lblSP[0]);
		$("#lblSP1").text(lblSP[1]);
		$("#lblSP2").text(lblSP[2]);
		$("#lblSP3").text(lblSP[3]);
		$("#lblSP4").text(lblSP[4]);
		$("#lblSP5").text(lblSP[5]);
		$("#lblSP6").text(lblSP[6]);
		$("#lblSP7").text(lblSP[7]);
		$("#lblSP8").text(lblSP[8]);
		$("#lblSP9").text(lblSP[9]);
		$("#lblSP10").text(lblSP[10]);
		
		$("#lblSPUnit0").text(lblSPUnit[0]);
		$("#lblSPUnit1").text(lblSPUnit[1]);
		$("#lblSPUnit2").text(lblSPUnit[2]);
		$("#lblSPUnit3").text(lblSPUnit[3]);
		$("#lblSPUnit4").text(lblSPUnit[4]);
		$("#lblSPUnit5").text(lblSPUnit[5]);
		$("#lblSPUnit6").text(lblSPUnit[6]);
		$("#lblSPUnit7").text(lblSPUnit[7]);
		$("#lblSPUnit8").text(lblSPUnit[8]);
		$("#lblSPUnit9").text(lblSPUnit[9]);
		$("#lblSPUnit10").text(lblSPUnit[10]);
		
		$("#lblFP0").text(lblFP[0]);
		$("#lblFP1").text(lblFP[1]);
		$("#lblFP2").text(lblFP[2]);
		$("#lblFP3").text(lblFP[3]);
		$("#lblFP4").text(lblFP[4]);
		$("#lblFP5").text(lblFP[5]);
		$("#lblFP6").text(lblFP[6]);
		$("#lblFP7").text(lblFP[7]);
		$("#lblFP8").text(lblFP[8]);
		$("#lblFP9").text(lblFP[9]);
		$("#lblFP10").text(lblFP[10]);

		$("#imgTooltip0").attr("title",tToolTipText[44]);
		$("#imgTooltip1").attr("title",tToolTipText[45]);
		$("#imgTooltip2").attr("title",tToolTipText[46]);
		$("#imgTooltip3").attr("title",tToolTipText[47]);
		$("#imgTooltip4").attr("title",tToolTipText[48]);
		$("#imgTooltip5").attr("title",tToolTipText[49]);
		$("#imgTooltip6").attr("title",tToolTipText[50]);
		$("#imgTooltip7").attr("title",tToolTipText[51]);
		$("#imgTooltip8").attr("title",tToolTipText[52]);
		$("#imgTooltip9").attr("title",tToolTipText[53]);
		$("#imgTooltip10").attr("title",tToolTipText[54]);

		/*if( type == 1 ) {
			if( tDccTrendValue[44]*1 == 0 ) {
				$("#shpIND0").attr("class","st_label st_no");
			} else {
				$("#shpIND0").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[45]*1 == 0 ) {
				$("#shpIND1").attr("class","st_label st_no");
			} else {
				$("#shpIND1").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[46]*1 == 0 ) {
				$("#shpIND2").attr("class","st_label st_no");
			} else {
				$("#shpIND2").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[47]*1 == 0 ) {
				$("#shpIND3").attr("class","st_label st_no");
			} else {
				$("#shpIND3").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[48]*1 == 0 ) {
				$("#shpIND4").attr("class","st_label st_no");
			} else {
				$("#shpIND4").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[49]*1 == 0 ) {
				$("#shpIND5").attr("class","st_label st_no");
			} else {
				$("#shpIND5").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[50]*1 == 0 ) {
				$("#shpIND6").attr("class","st_label st_no");
			} else {
				$("#shpIND6").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[51]*1 == 0 ) {
				$("#shpIND7").attr("class","st_label st_no");
			} else {
				$("#shpIND7").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[52]*1 == 0 ) {
				$("#shpIND8").attr("class","st_label st_no");
			} else {
				$("#shpIND8").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[53]*1 == 0 ) {
				$("#shpIND9").attr("class","st_label st_no");
			} else {
				$("#shpIND9").attr("class","st_label st_yes");
			}
			if( tDccTrendValue[54]*1 == 0 ) {
				$("#shpIND10").attr("class","st_label st_no");
			} else {
				$("#shpIND10").attr("class","st_label st_yes");
			}
		} else {
			if( lblDataListAjax[44].fValue*1 == 0 ) {
				$("#shpIND0").attr("class","st_label st_no");
			} else {
				$("#shpIND0").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[45].fValue*1 == 0 ) {
				$("#shpIND1").attr("class","st_label st_no");
			} else {
				$("#shpIND1").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[46].fValue == 0 ) {
				$("#shpIND2").attr("class","st_label st_no");
			} else {
				$("#shpIND2").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[47].fValue == 0 ) {
				$("#shpIND3").attr("class","st_label st_no");
			} else {
				$("#shpIND3").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[48].fValue == 0 ) {
				$("#shpIND4").attr("class","st_label st_no");
			} else {
				$("#shpIND4").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[49].fValue == 0 ) {
				$("#shpIND5").attr("class","st_label st_no");
			} else {
				$("#shpIND5").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[50].fValue == 0 ) {
				$("#shpIND6").attr("class","st_label st_no");
			} else {
				$("#shpIND6").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[51].fValue == 0 ) {
				$("#shpIND7").attr("class","st_label st_no");
			} else {
				$("#shpIND7").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[52].fValue == 0 ) {
				$("#shpIND8").attr("class","st_label st_no");
			} else {
				$("#shpIND8").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[53].fValue == 0 ) {
				$("#shpIND9").attr("class","st_label st_no");
			} else {
				$("#shpIND9").attr("class","st_label st_yes");
			}
			if( lblDataListAjax[54].fValue == 0 ) {
				$("#shpIND10").attr("class","st_label st_no");
			} else {
				$("#shpIND10").attr("class","st_label st_yes");
			}
		}*/
	}
	
	$(function(){
		
		$("#lblDate").text('${SearchTime}');
		$("#lblDate").css('color','${ForeColor}');	

		setConst();

		$(document.body).delegate('#dccStatusSBForm label', 'dblclick', function() {

			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			cId = getToolTipText(cId).split("||")[0];
			if( cId != null && cId != '' && cId != 'undefined' && cId.indexOf('lbl') == -1 && cId.indexOf('shp') == -1 ) {
				if( type == 1 ) {
					//showTag(cId,tDccTagSeq[cId]);
				} else {
					//showTag(cId,dccGrpTagListAjax[cId].iSeq*1);
				}
			}
		});
		$(document.body).delegate('#dccStatusSBForm label', 'mouseover focus', function() {
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
		
		setTimer(5000);
	});
		
	function setTimer(interval) {
		if( interval > 0 ) {
			setInterval(function() {
				if( timerOn ) {
					//var	comSubmit	=	new ComSubmit("reloadFrm");
					//comSubmit.setUrl("/dcc/status/setbackstatus");
					//comSubmit.submit();
					
					var	comAjax	=	new ComAjax("reloadFrm");
					comAjax.setUrl("/dcc/status/reloadSetback");
					comAjax.addParam("hogi",$("input:radio[id='4']").is(":checked") ? '4' : '3');
					comAjax.addParam("xyGubun",$("input:radio[id='Y']").is(":checked") ? 'Y' : 'X');
					comAjax.addParam("menuNo",'11');
					comAjax.addParam("grpNo",'13');
					comAjax.addParam("grpId",'mimic');
					comAjax.setCallback("mbr_statusCallback");
					comAjax.ajax();
				}
			},interval);
		} else {
			//var	comSubmit	=	new ComSubmit("reloadFrm");
			//comSubmit.setUrl("/dcc/status/setbackstatus");
			//comSubmit.submit();
			
			var	comAjax	=	new ComAjax("reloadFrm");
			comAjax.setUrl("/dcc/status/reloadSetback");
			comAjax.addParam("hogi",$("input:radio[id='4']").is(":checked") ? '4' : '3');
			comAjax.addParam("xyGubun",$("input:radio[id='Y']").is(":checked") ? 'Y' : 'X');
			comAjax.addParam("menuNo",'11');
			comAjax.addParam("grpNo",'13');
			comAjax.addParam("grpId",'mimic');
			comAjax.setCallback("mbr_statusCallback");
			comAjax.ajax();
		}
	}
	
	function setDate(time,color) {
		$("#lblDate").text(time);
		$("#lblDate").css("color",color);
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
		
		comSubmit.setUrl("/dcc/status/sbSaveTag");
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
		
		comAjax.setUrl("/dcc/status/sbTagSearch");
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
		
		comAjax.setUrl("/dcc/status/sbTagFind");
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
	
	function closeModal(str) {
		//var	comSubmit	=	new ComSubmit("reloadFrm");
		//comSubmit.setUrl("/dcc/status/setbackstatus");
		//comSubmit.submit();
		closeLayer(str);
	}
	
	function convFormat(num,len) {
		var rtv = num;
		
		for( var i=0;i<len*2+1;i++ ) {
			if( i < len ) {
				rtv = rtv*10;
			} else if( i == len ) {
				rtv = Math.round(rtv);
			} else {
				rtv = rtv/10;
			}
		}
		
		return rtv.toFixed(4);
	}
	
	function setLblDataAjax(type) {
		if( type == 0 ) {
			for( var i=0;i<43;i++ ) {
				if( i != 3 ) {
					if( typeof $("#lbl"+i) != 'undefined' ) {
						$("#lbl"+i).text(lblDataListAjax[i].fValue);
						$("#lbl"+i).attr("title",dccGrpTagListAjax[i].toolTip);
					}
				} else {
					if( typeof $("#lbl"+i) != 'undefined' ) {
						$("#lbl3").text(convFormat(lblConvListAjax[0].fValue*1,4));
					}
				}
				
				if( i >= 0 && i < 3 ) {
					if( lblDataListAjax[i].visible ) {
						$("#lbl"+i).css("display","");
					} else {
						$("#lbl"+i).css("display","none");
					}
				}
				
				if( i >= 5 && i < 8 ) {
					if( lblDataListAjax[i].visible ) {
						$("#lbl"+i).css("display","");
					} else {
						$("#lbl"+i).css("display","none");
					}
				}
				
				if( i >= 8 && i < 11 ) {
					if( lblDataListAjax[i].visible ) {
						$("#lbl"+i).css("display","");
					} else {
						$("#lbl"+i).css("display","none");
					}
				}
				
				if( i >= 11 && i < 14 ) {
					if( lblDataListAjax[i].visible ) {
						$("#lbl"+i).css("display","");
					} else {
						$("#lbl"+i).css("display","none");
					}
				}
				
				if( i >= 14 && i < 18 ) {
					if( lblDataListAjax[i].visible ) {
						$("#lbl"+i).css("display","");
					} else {
						$("#lbl"+i).css("display","none");
					}
				}
				
				if( i >= 18 && i < 21 ) {
					if( lblDataListAjax[i].visible ) {
						$("#lbl"+i).css("display","");
					} else {
						$("#lbl"+i).css("display","none");
					}
				}
			}
			
			for( var j=1;j<lblConvListAjax.length;j++ ) {
				$("#conv"+j).text(lblConvListAjax[j].fValue);
				$("#conv"+j).attr("title",lblConvListAjax[j].Tooltip);
			}
		}
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
				<h3>SETBACK STATUS</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>SETBACK STATUS</strong></div>
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
				<div class="form_head">
					<div class="form_info">
                        <div class="fx_legend">
                            <ul>
                                <li class="title">INDICATOR</li>
                                <li class="no">NO</li>
                                <li class="yes">YES</li>
                            </ul>
                        </div>
					</div>
					<div class="fx_srch_button" style="display:flex;flex:1;justify-content:flex-end">
						<a class="btn_list" id="openInfo" name="openInfo" href="#" onclick="javascript:openLayer('modal_4')">SETBACK 정보보기</a>
					</div>
				</div>
				<!-- //form_head -->   
                <form id="reloadFrm" style="display:none">
                <input type="hidden" id="gubun" name="gubun" value="${BaseSearch.gubun}">
				<input type="hidden" id="menuNo" name="menuNo" value="${BaseSearch.menuNo}">
				<input type="hidden" id="grpId" name="grpId" value="${BaseSearch.grpId}">
				<input type="hidden" id="grpNo" name="grpNo" value="${BaseSearch.grpNo}">
				</form>
                <form id="dccStatusSBForm">
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
                                <div id="imgTooltip0" class="fx_form">
                                	<c:if test="${shpIND[0] eq true}">
	                                    <span id="shpIND0" class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[0] eq false}">
	                                    <span id="shpIND0" class="st_label st_no"></span>
	                                </c:if>
                                    <label>MOD DP LO</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP0" class="full flex_end">0.28</label>
                                    <label id="lblSPUnit0" class="full">MPA</label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                	<c:if test="${lblDataList[0].visible eq true}">
                                    	<label id="lbl0" class="double flex_end" title="${DccTagInfoList[0].toolTip}">${lblDataList[0].fValue}</label>
                                    	<label id="lbl1" class="double flex_end" title="${DccTagInfoList[1].toolTip}" style="display:none">${lblDataList[1].fValue}</label>
                                    	<label id="lbl2" class="double flex_end" title="${DccTagInfoList[2].toolTip}" style="display:none">${lblDataList[2].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[1].visible eq true}">
                                    	<label id="lbl0" class="double flex_end" title="${DccTagInfoList[0].toolTip}" style="display:none">${lblDataList[0].fValue}</label>
                                    	<label id="lbl1" class="double flex_end" title="${DccTagInfoList[1].toolTip}">${lblDataList[1].fValue}</label>
                                    	<label id="lbl2" class="double flex_end" title="${DccTagInfoList[2].toolTip}" style="display:none">${lblDataList[2].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[2].visible eq true}">
                                    	<label id="lbl0" class="double flex_end" title="${DccTagInfoList[0].toolTip}" style="display:none">${lblDataList[0].fValue}</label>
                                    	<label id="lbl1" class="double flex_end" title="${DccTagInfoList[1].toolTip}" style="display:none">${lblDataList[1].fValue}</label>
                                    	<label id="lbl2" class="double flex_end" title="${DccTagInfoList[2].toolTip}">${lblDataList[2].fValue}</label>
                                    </c:if>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP0" class="double">0.02</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip1" class="fx_form">
                               		<c:if test="${shpIND[1] eq true}">
	                                    <span id="shpIND1"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[1] eq false}">
	                                    <span id="shpIND1"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>LOCAL N HI</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP1" class="full flex_end">1.1</label>
                                    <label id="lblSPUnit1" class="full">FFP</label>
                                </div>
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label id="lbl3" class="double flex_end" title="${lblConvList[0].Tooltip}"><fmt:formatNumber value="${lblConvList[0].fValue}" pattern="##.####"></fmt:formatNumber></label>
                                    <label class="full"></label>
                                </div>                                
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP1" class="double">0.6</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip2" class="fx_form">
                                	<c:if test="${shpIND[2] eq true}">
	                                    <span id="shpIND2"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[2] eq false}">
	                                    <span id="shpIND2"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>ZONE FAIL</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP2" class="full flex_end">0.827</label>
                                    <label id="lblSPUnit2" class="full">MPA</label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                	<c:if test="${lblDataList[5].visible eq true}">
                                    	<label id="lbl5" class="double flex_end" title="${DccTagInfoList[5].toolTip}">${lblDataList[5].fValue}</label>
                                    	<label id="lbl6" class="double flex_end" title="${DccTagInfoList[6].toolTip}" style="display:none">${lblDataList[6].fValue}</label>
                                    	<label id="lbl7" class="double flex_end" title="${DccTagInfoList[7].toolTip}" style="display:none">${lblDataList[7].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[6].visible eq true}">
                                    	<label id="lbl5" class="double flex_end" title="${DccTagInfoList[5].toolTip}" style="display:none">${lblDataList[5].fValue}</label>
                                    	<label id="lbl6" class="double flex_end" title="${DccTagInfoList[6].toolTip}">${lblDataList[6].fValue}</label>
                                    	<label id="lbl7" class="double flex_end" title="${DccTagInfoList[7].toolTip}" style="display:none">${lblDataList[7].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[7].visible eq true}">
                                    	<label id="lbl5" class="double flex_end" title="${DccTagInfoList[5].toolTip}" style="display:none">${lblDataList[5].fValue}</label>
                                    	<label id="lbl6" class="double flex_end" title="${DccTagInfoList[6].toolTip}" style="display:none">${lblDataList[6].fValue}</label>
                                    	<label id="lbl7" class="double flex_end" title="${DccTagInfoList[7].toolTip}">${lblDataList[7].fValue}</label>
                                    </c:if>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP2" class="double">0.6</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip3" class="fx_form">
                                	<c:if test="${shpIND[3] eq true}">
	                                    <span id="shpIND3"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[3] eq false}">
	                                    <span id="shpIND3"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>D/C PR HI</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP3" class="full flex_end">3.9</label>
                                    <label id="lblSPUnit3" class="full">MPA</label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                	<c:if test="${lblDataList[8].visible eq true}">
                                    	<label id="lbl8" class="double flex_end" title="${DccTagInfoList[8].toolTip}">${lblDataList[8].fValue}</label>
                                    	<label id="lbl9" class="double flex_end" title="${DccTagInfoList[9].toolTip}" style="display:none">${lblDataList[9].fValue}</label>
                                    	<label id="lbl10" class="double flex_end" title="${DccTagInfoList[10].toolTip}" style="display:none">${lblDataList[10].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[9].visible eq true}">
                                    	<label id="lbl8" class="double flex_end" title="${DccTagInfoList[8].toolTip}" style="display:none">${lblDataList[8].fValue}</label>
                                    	<label id="lbl9" class="double flex_end" title="${DccTagInfoList[9].toolTip}">${lblDataList[9].fValue}</label>
                                    	<label id="lbl10" class="double flex_end" title="${DccTagInfoList[10].toolTip}" style="display:none">${lblDataList[10].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[10].visible eq true}">
                                    	<label id="lbl8" class="double flex_end" title="${DccTagInfoList[8].toolTip}" style="display:none">${lblDataList[8].fValue}</label>
                                    	<label id="lbl9" class="double flex_end" title="${DccTagInfoList[9].toolTip}" style="display:none">${lblDataList[9].fValue}</label>
                                    	<label id="lbl10" class="double flex_end" title="${DccTagInfoList[10].toolTip}">${lblDataList[10].fValue}</label>
                                    </c:if>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP3" class="double">0.02</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip4" class="fx_form">
                                	<c:if test="${shpIND[4] eq true}">
	                                    <span id="shpIND4"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[4] eq false}">
	                                    <span id="shpIND4"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>MOD TEMP HI</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP4" class="full flex_end">79</label>
                                    <label id="lblSPUnit4" class="full">°C</label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                	<c:if test="${lblDataList[11].visible eq true}">
                                    	<label id="lbl11" class="double flex_end" title="${DccTagInfoList[11].toolTip}">${lblDataList[11].fValue}</label>
                                    	<label id="lbl12" class="double flex_end" title="${DccTagInfoList[12].toolTip}" style="display:none">${lblDataList[12].fValue}</label>
                                    	<label id="lbl13" class="double flex_end" title="${DccTagInfoList[13].toolTip}" style="display:none">${lblDataList[13].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[12].visible eq true}">
                                    	<label id="lbl11" class="double flex_end" title="${DccTagInfoList[11].toolTip}" style="display:none">${lblDataList[11].fValue}</label>
                                    	<label id="lbl12" class="double flex_end" title="${DccTagInfoList[12].toolTip}">${lblDataList[12].fValue}</label>
                                    	<label id="lbl13" class="double flex_end" title="${DccTagInfoList[13].toolTip}" style="display:none">${lblDataList[13].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[13].visible eq true}">
                                    	<label id="lbl11" class="double flex_end" title="${DccTagInfoList[11].toolTip}" style="display:none">${lblDataList[11].fValue}</label>
                                    	<label id="lbl12" class="double flex_end" title="${DccTagInfoList[12].toolTip}" style="display:none">${lblDataList[12].fValue}</label>
                                    	<label id="lbl13" class="double flex_end" title="${DccTagInfoList[13].toolTip}">${lblDataList[13].fValue}</label>
                                    </c:if>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP4" class="double">0.02</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip5" class="fx_form">
                                	<c:if test="${shpIND[5] eq true}">
	                                    <span id="shpIND5"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[5] eq false}">
	                                    <span id="shpIND5"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>ESC LVL LO</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP5" class="full flex_end">109.7</label>
                                    <label id="lblSPUnit5" class="full">M</label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                	<c:if test="${lblDataList[14].visible eq true}">
                                    	<label id="lbl14" class="double flex_end" title="${DccTagInfoList[14].toolTip}">${lblDataList[14].fValue}</label>
                                    	<label id="lbl15" class="double flex_end" title="${DccTagInfoList[15].toolTip}" style="display:none">${lblDataList[15].fValue}</label>
                                    	<label id="lbl16" class="double flex_end" title="${DccTagInfoList[16].toolTip}" style="display:none">${lblDataList[16].fValue}</label>
                                    	<label id="lbl17" class="double flex_end" title="${DccTagInfoList[17].toolTip}" style="display:none">${lblDataList[17].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[15].visible eq true}">
                                    	<label id="lbl14" class="double flex_end" title="${DccTagInfoList[14].toolTip}" style="display:none">${lblDataList[14].fValue}</label>
                                    	<label id="lbl15" class="double flex_end" title="${DccTagInfoList[15].toolTip}">${lblDataList[15].fValue}</label>
                                    	<label id="lbl16" class="double flex_end" title="${DccTagInfoList[16].toolTip}" style="display:none">${lblDataList[16].fValue}</label>
                                    	<label id="lbl17" class="double flex_end" title="${DccTagInfoList[17].toolTip}" style="display:none">${lblDataList[17].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[16].visible eq true}">
                                    	<label id="lbl14" class="double flex_end" title="${DccTagInfoList[14].toolTip}" style="display:none">${lblDataList[14].fValue}</label>
                                    	<label id="lbl15" class="double flex_end" title="${DccTagInfoList[15].toolTip}" style="display:none">${lblDataList[15].fValue}</label>
                                    	<label id="lbl16" class="double flex_end" title="${DccTagInfoList[16].toolTip}">${lblDataList[16].fValue}</label>
                                    	<label id="lbl17" class="double flex_end" title="${DccTagInfoList[17].toolTip}" style="display:none">${lblDataList[17].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[17].visible eq true}">
                                    	<label id="lbl14" class="double flex_end" title="${DccTagInfoList[14].toolTip}" style="display:none">${lblDataList[14].fValue}</label>
                                    	<label id="lbl15" class="double flex_end" title="${DccTagInfoList[15].toolTip}" style="display:none">${lblDataList[15].fValue}</label>
                                    	<label id="lbl16" class="double flex_end" title="${DccTagInfoList[16].toolTip}" style="display:none">${lblDataList[16].fValue}</label>
                                    	<label id="lbl17" class="double flex_end" title="${DccTagInfoList[17].toolTip}">${lblDataList[17].fValue}</label>
                                    </c:if>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP5" class="double">0.02</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip6" class="fx_form">
                                	<c:if test="${shpIND[6] eq true}">
	                                    <span id="shpIND6"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[6] eq false}">
	                                    <span id="shpIND6"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>D/A LVL LO</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP6" class="full flex_end">2440</label>
                                    <label id="lblSPUnit6" class="full">MM</label>
                                </div>
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                	<c:if test="${lblDataList[18].visible eq true}">
                                    	<label id="lbl18" class="double flex_end" title="${DccTagInfoList[18].toolTip}">${lblDataList[18].fValue}</label>
                                    	<label id="lbl19" class="double flex_end" title="${DccTagInfoList[19].toolTip}" style="display:none">${lblDataList[19].fValue}</label>
                                    	<label id="lbl20" class="double flex_end" title="${DccTagInfoList[20].toolTip}" style="display:none">${lblDataList[20].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[19].visible eq true}">
                                    	<label id="lbl18" class="double flex_end" title="${DccTagInfoList[18].toolTip}" style="display:none">${lblDataList[18].fValue}</label>
                                    	<label id="lbl19" class="double flex_end" title="${DccTagInfoList[19].toolTip}">${lblDataList[19].fValue}</label>
                                    	<label id="lbl20" class="double flex_end" title="${DccTagInfoList[20].toolTip}" style="display:none">${lblDataList[20].fValue}</label>
                                    </c:if>
                                    <c:if test="${lblDataList[20].visible eq true}">
                                    	<label id="lbl18" class="double flex_end" title="${DccTagInfoList[18].toolTip}" style="display:none">${lblDataList[18].fValue}</label>
                                    	<label id="lbl19" class="double flex_end" title="${DccTagInfoList[19].toolTip}" style="display:none">${lblDataList[19].fValue}</label>
                                    	<label id="lbl20" class="double flex_end" title="${DccTagInfoList[20].toolTip}">${lblDataList[20].fValue}</label>
                                    </c:if>

                                    <label class="full"></label>
                                </div>                                
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP6" class="double">0.02</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2">
                                <div id="imgTooltip7" class="fx_form">
                                	<c:if test="${shpIND[7] eq true}">
	                                    <span id="shpIND7"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[7] eq false}">
	                                    <span id="shpIND7"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>SG PR HI</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="2">
                                <div class="fx_form">
                                    <label id="lblSP7" class="full flex_end">4.83</label>
                                    <label id="lblSPUnit7" class="full">MPA</label>
                                </div>                                  
                            </td>
                            <th class="tc">SG #1</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl21" class="double flex_end" title="${DccTagInfoList[21].toolTip}">${lblDataList[21].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">SG #2</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl22" class="double flex_end" title="${DccTagInfoList[22].toolTip}">${lblDataList[22].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td rowspan="2">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP7" class="double">0.00</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">SG #3</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl23" class="double flex_end" title="${DccTagInfoList[23].toolTip}">${lblDataList[23].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">SG #4</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl24" class="double flex_end" title="${DccTagInfoList[24].toolTip}">${lblDataList[24].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2">
                                <div id="imgTooltip8" class="fx_form">
                                	<c:if test="${shpIND[8] eq true}">
	                                    <span id="shpIND8"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[8] eq false}">
	                                    <span id="shpIND8"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>TBN TRIP PLU</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="2">---------------</td>
                            <th colspan="2">TBN TRIP</th>
                            <td class="tc" colspan="2"><label id="conv1" title="${lblConvList[1].Tooltip}">${lblConvList[1].fValue}</label></td>
                            <td rowspan="2">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP8" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="bd_l_line" colspan="2">PWE LOAD UNBALANCE</th>
                            <td class="tc" colspan="2"><label id="conv2" title="${lblConvList[2].Tooltip}">${lblConvList[2].fValue}</label></td>
                        </tr>
                        <tr>
                            <th rowspan="7">
                                <div id="imgTooltip9" class="fx_form">
                                	<c:if test="${shpIND[9] eq true}">
	                                    <span id="shpIND9"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[9] eq false}">
	                                    <span id="shpIND9"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>SPATIAL OF NORMAL</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="7">
                                <div class="fx_form_column">
                                    <div class="fx_form">
                                        <label id="lblSP8" class="full flex_end">1.1</label>
                                        <label id="lblSPUnit8" class="full">FFP</label>
                                    </div>
                                    <div class="fx_form">
                                        <label id="lblSPUnit9" class="full flex_center">TILT</label>
                                    </div>
                                    <div class="fx_form">
                                        <label id="lblSP9" class="full flex_end">0.2</label>
                                        <label id="lblSPUnit10" class="full">FFP</label>
                                    </div>
                                </div>
                            </td>
                            <th class="tc">PIC01</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl29" class="double flex_end" title="${DccTagInfoList[29].toolTip}">${lblDataList[29].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC08</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl36" class="double flex_end" title="${DccTagInfoList[36].toolTip}">${lblDataList[36].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td rowspan="7">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP9" class="double">0.6</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC02</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl30" class="double flex_end" title="${DccTagInfoList[30].toolTip}">${lblDataList[30].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC09</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl37" class="double flex_end" title="${DccTagInfoList[37].toolTip}">${lblDataList[37].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC03</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl31" class="double flex_end" title="${DccTagInfoList[31].toolTip}">${lblDataList[31].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC10</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl38" class="double flex_end" title="${DccTagInfoList[38].toolTip}">${lblDataList[38].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC04</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl32" class="double flex_end" title="${DccTagInfoList[32].toolTip}">${lblDataList[32].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC11</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl39" class="double flex_end" title="${DccTagInfoList[39].toolTip}">${lblDataList[39].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC05</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl33" class="double flex_end" title="${DccTagInfoList[33].toolTip}">${lblDataList[33].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC12</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl40" class="double flex_end" title="${DccTagInfoList[40].toolTip}">${lblDataList[40].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC06</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl34" class="double flex_end" title="${DccTagInfoList[34].toolTip}">${lblDataList[34].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC13</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl41" class="double flex_end" title="${DccTagInfoList[41].toolTip}">${lblDataList[41].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC07</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl35" class="double flex_end" title="${DccTagInfoList[35].toolTip}">${lblDataList[35].fValue}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC14</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lbl42" class="double flex_end" title="${DccTagInfoList[42].toolTip}">${lblDataList[42].fValue}</label> 
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip10" class="fx_form">
                                	<c:if test="${shpIND[10] eq true}">
	                                    <span id="shpIND10"  class="st_label st_yes"></span>
	                                </c:if>
	                                <c:if test="${shpIND[10] eq false}">
	                                    <span id="shpIND10"  class="st_label st_no"></span>
	                                </c:if>
                                    <label>MANUAL</label>
                                </div>
                            </th>
                            <td class="tc">----------------</td>
                            <td class="tc" colspan="4"><label id="conv3" title="${lblConvList[3].Tooltip}">${lblConvList[3].fValue}</label></td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP10" class="double">0.02</label>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
                </form>
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
        <a onclick="javascript:closeModal('modal_2');" title="Close"></a>
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
        			<a href="#none" class="btn_page" onclick="javascript:closeModal('modal_3');">닫기</a>
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

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_4">
    <!-- header_wrap -->
<div class="pop_header">
   <h3>SETBACK 정보</h3>
        <a onclick="closeLayer('modal_4');" title="Close"></a>
</div>
<!-- //header_wrap -->
<!-- pop_contents -->
<div class="pop_contents" style="max-height:700px;">
	<!-- form_wrap -->
	<div class="form_wrap">
 		<!-- form_table -->
		<form id="setbackinfo" name="setbackinfo">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td valign="top" align="center">
					<table class="form_table">
	                    <colgroup>
	                        <col width="100px" />
	                        <col width="100px" />
	                        <col width="100px" />
	                        <col width="300px" />
	                        <col width="100px" />
	                    </colgroup>
						<thead>
							<tr>
								<th>FLAG</th>
								<th>PARAMETER</th>
								<th>SETPOINT</th>
								<th>STATUS</th>
								<th>END FP</th>
							</tr>
						</thead>
	
						<tr>
							<td class="tc">SC3134-O6</td>
							<td style="text-align:left;padding-left:20px">■ MOD DP LO</td>
							<td class="tc">0.28 MPA</td>
							<td class="tc">AI 1307, 2430, 3076의 중간값</td>
							<td class="tc">0.02</td>
						</tr>
	
						<tr>
							<td class="tc">SC3134-O0</td>
							<td style="text-align:left;padding-left:20px">■ LOC N HI</td>
							<td class="tc">1.1 FFP</td>
							<td class="tc">(PLIMIT / PLNMAX) * PLIN<br>(1.1B1 / SC3142-B00) * SC3137-B00 Bscale : B1</td>
							<td class="tc">0.6</td>
						</tr>
	
						<tr>
							<td class="tc">SC3134-O1</td>
							<td style="text-align:left;padding-left:20px">■ ZONE FAIL</td>
							<td class="tc">0.827 MPAG</td>
							<td class="tc">AI 1201, 2402, 3017의 중간값</td>
							<td class="tc">0.02</td>
						</tr>
	
						<tr>
							<td class="tc">SC3134-10</td>
							<td style="text-align:left;padding-left:20px">■ D/C PR HI</td>
							<td class="tc">3.9 MPAG</td>
							<td class="tc">AI 1124, 634, 1126의 중간값</td>
							<td class="tc">0.02</td>
						</tr>
	
	
						<tr>
							<td class="tc">SC3134-05</td>
							<td style="text-align:left;padding-left:20px">■ MOD TM HI</td>
							<td class="tc">79 C</td>
							<td class="tc">AI 1305, 2426, 3117의 중간값</td>
							<td class="tc">0.02</td>
						</tr>
	
						<tr>
							<td class="tc">SC3134-09</td>
							<td style="text-align:left;padding-left:20px">■ ESC LV LO</td>
							<td class="tc">109.7 M</td>
							<td class="tc">AI 1344, 1345, 1346, 1347 중 제일 작은값</td>
							<td class="tc">0.02</td>
						</tr>
	
						<tr>
							<td class="tc">SC3134-03</td>
							<td style="text-align:left;padding-left:20px">■ D/A LV LO</td>
							<td class="tc">2440 MM</td>
							<td class="tc">AI 1327, 2516, 3133의 중간값</td>
							<td class="tc">0.02</td>
						</tr>
	
						<tr>
							<td class="tc">SC3134-04</td>
							<td style="text-align:left;padding-left:20px">■ S/G PR HI</td>
							<td class="tc">4.83 MPA</td>
							<td class="tc">SG1 : AI 1276,&nbsp;&nbsp;&nbsp;SG2 : AI 2435<br>
							                                                           SG3 : AI 1277,&nbsp;&nbsp;&nbsp;SG4 : AI 2436</td>
							<td class="tc">0.08</td>
						</tr>
	
						<tr>
							<td class="tc">SC3134-08</td>
							<td style="text-align:left;padding-left:20px">■ TBN TRIP PLU</td>
							<td class="tc">------</td>
							<td class="tc">DI 40-13, 14, 15 중 2개 이상이 1 이면 YES, 0 이면 NO<br>
							                                                           DI 41-00 값이 0 이면 NO, 1 이면 YES</td>
							<td class="tc">0.6</td>
						</tr>
	
						<tr>
							<td class="tc">SC3134-02</td>
							<td style="text-align:left;padding-left:20px">■ SPATIAL<br>&nbsp;&nbsp;&nbsp;&nbsp;OFF NORMAL</td>
							<td class="tc">1.1 FFP<br>TILT<br>0.2 FFP</td>
							<td class="tc">PIC01 : DTAB13,&nbsp;&nbsp;&nbsp;PIC08 : DTAB22<br>
										   PIC02 : DTAB14,&nbsp;&nbsp;&nbsp;PIC09 : DTAB23<br>
										   PIC03 : DTAB15,&nbsp;&nbsp;&nbsp;PIC10 : DTAB24<br>
										   PIC04 : DTAB16,&nbsp;&nbsp;&nbsp;PIC11 : DTAB25<br>
										   PIC05 : DTAB17,&nbsp;&nbsp;&nbsp;PIC12 : DTAB26<br>
										   PIC06 : DTAB20,&nbsp;&nbsp;&nbsp;PIC13 : DTAB27<br>
										   PIC07 : DTAB21,&nbsp;&nbsp;&nbsp;PIC14 : DTAB30</td>
							<td class="tc">0.6</td>
						</tr>
	
						<tr>
							<td class="tc">SC3134-07</td>
							<td style="text-align:left;padding-left:20px">■ MANUAL</td>
							<td class="tc">------</td>
							<td class="tc">DI 63-13 값이 0이면 NO, 1이면 YES</td>
							<td class="tc">0.02</td>
						</tr>
	
						<tr>
							<td style="padding-left:20px" colspan="5">
								FLAG : 파라미터 앞에 파란색 주황색 색깔 지정하는 것이며, SC3134 비트 0부터 15까지 각 파라미터를 표시함.<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 이면 NO 파란색, 1 이면 YES 주황색입니다. 
							</td>
						</tr>
					</table>
				</td></tr>
			</table>
		</form>    
	</div>
</div>
<!-- pop_contents -->
<!-- //layer_pop_wrap -->

<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>


