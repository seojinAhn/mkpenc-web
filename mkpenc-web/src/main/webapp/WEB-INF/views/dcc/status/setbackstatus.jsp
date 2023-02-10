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
		${DccTagInfoList[55].iSeq}
	];
	
	var tDccTrendValue = [
		'${DccLogTrendInfoList[0].TVALUE1}','${DccLogTrendInfoList[0].TVALUE2}','${DccLogTrendInfoList[0].TVALUE3}','${DccLogTrendInfoList[0].TVALUE4}',
		'${DccLogTrendInfoList[0].TVALUE5}','${DccLogTrendInfoList[0].TVALUE6}','${DccLogTrendInfoList[0].TVALUE7}','${DccLogTrendInfoList[0].TVALUE8}',
		'${DccLogTrendInfoList[0].TVALUE9}','${DccLogTrendInfoList[0].TVALUE10}','${DccLogTrendInfoList[0].TVALUE11}','${DccLogTrendInfoList[0].TVALUE12}',
		'${DccLogTrendInfoList[0].TVALUE13}','${DccLogTrendInfoList[0].TVALUE14}','${DccLogTrendInfoList[0].TVALUE15}','${DccLogTrendInfoList[0].TVALUE16}',
		'${DccLogTrendInfoList[0].TVALUE17}','${DccLogTrendInfoList[0].TVALUE18}','${DccLogTrendInfoList[0].TVALUE19}','${DccLogTrendInfoList[0].TVALUE20}',
		'${DccLogTrendInfoList[0].TVALUE21}','${DccLogTrendInfoList[0].TVALUE22}','${DccLogTrendInfoList[0].TVALUE23}','${DccLogTrendInfoList[0].TVALUE24}',
		'${DccLogTrendInfoList[0].TVALUE25}','${DccLogTrendInfoList[0].TVALUE26}','${DccLogTrendInfoList[0].TVALUE27}','${DccLogTrendInfoList[0].TVALUE28}',
		'${DccLogTrendInfoList[0].TVALUE29}','${DccLogTrendInfoList[0].TVALUE30}','${DccLogTrendInfoList[0].TVALUE31}','${DccLogTrendInfoList[0].TVALUE32}',
		'${DccLogTrendInfoList[0].TVALUE33}','${DccLogTrendInfoList[0].TVALUE34}','${DccLogTrendInfoList[0].TVALUE35}','${DccLogTrendInfoList[0].TVALUE36}',
		'${DccLogTrendInfoList[0].TVALUE37}','${DccLogTrendInfoList[0].TVALUE38}','${DccLogTrendInfoList[0].TVALUE39}','${DccLogTrendInfoList[0].TVALUE40}',
		'${DccLogTrendInfoList[0].TVALUE41}','${DccLogTrendInfoList[0].TVALUE42}','${DccLogTrendInfoList[0].TVALUE43}','${DccLogTrendInfoList[0].TVALUE44}',
		'${DccLogTrendInfoList[0].TVALUE45}','${DccLogTrendInfoList[0].TVALUE46}','${DccLogTrendInfoList[0].TVALUE47}','${DccLogTrendInfoList[0].TVALUE48}',
		'${DccLogTrendInfoList[0].TVALUE49}','${DccLogTrendInfoList[0].TVALUE50}','${DccLogTrendInfoList[0].TVALUE51}','${DccLogTrendInfoList[0].TVALUE52}',
		'${DccLogTrendInfoList[0].TVALUE53}','${DccLogTrendInfoList[0].TVALUE54}','${DccLogTrendInfoList[0].TVALUE55}'
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
		'${DccTagInfoList[55].xyGubun}'
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
	];
	
	var selectTag = [{name:"hogi",value:""},{name:"xyGubun",value:""},{name:"loopName",value:""},{name:"ioType",value:""}
					,{name:"address",value:""},{name:"ioBit",value:""},{name:"descr",value:""}];
	
	var lblSP = ['0.28','1.1','0.827','3.9','79','109.7','2440','4.83','1.1','0.2'];
	var lblSPUnit = ['MPA','FFP','MPA','MPA','℃','M','MM','MPA','FFP','TILT','FFP'];
	var lblFP = ['0.02','0.6','0.6','0.02','0.02','0.02','0.02','0.08','0.6','0.6','0.02'];
	
	function showTag(tagNo,iSeq) {
		if(${UserInfo.grade} == '1' || ${UserInfo.grade} == '2') { // 나중에 grade 1 은 삭제할 것
			timerOn = false;
			$("#tagNo").val(tagNo);
			var infos = getToolTipText(tagNo).split("||")[1];
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
	
	function getToolTipText(id) {
		var tooltipText = '';
		var mod = '';
		
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

		return tooltipText;
	}
	
	function showTooltip(id) {
		var tooltipText;

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
				$("#"+id).attr("title",tooltipText);
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
		$(document.body).delegate('#dccStatusSBForm label', 'dblclick', function() {
			var cId = this.id.indexOf('unit') > -1 ? this.id.substring(4) : this.id;
			cId = getToolTipText(cId).split("||")[0];
			if( cId != null && cId != '' && cId != 'undefined' && cId.indexOf('lbl') == -1 && cId.indexOf('shp') == -1 ) {
				showTag(cId,tDccTagSeq[cId]);
			}
		});
		$(document.body).delegate('#dccStatusSBForm label', 'mouseover focus', function() {
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
					comSubmit.setUrl("/dcc/status/setbackstatus");
					comSubmit.addParam("hogiHeader",hogiHeader);
					comSubmit.addParam("xyHeader",xyHeader);
					comSubmit.submit();
				}
			},interval);
		} else {
			var	comSubmit	=	new ComSubmit("reloadFrm");
			comSubmit.setUrl("/dcc/status/setbackstatus");
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
	
	function closeModal() {
		var	comSubmit	=	new ComSubmit("reloadFrm");
		comSubmit.setUrl("/dcc/status/setbackstatus");
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
				<h3><a href="javascript:openLayer('modal_4')">SETBACK STATUS</a></h3>
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
				</div>
				<!-- //form_head -->   
                <form id="reloadFrm" style="display:none"></form>
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
                                    <span id="shpIND0" class="st_label st_no"></span>
                                    <label>MOD DP LO</label>
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
                                    <label id="0" class="double flex_end">${DccLogTrendInfoList[0].TVALUE1}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP0" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip1" class="fx_form">
                                    <span id="shpIND1" class="st_label st_no"></span>
                                    <label>LOCAL N HI</label>
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
                                    <label id="3" class="double flex_end">${DccLogTrendInfoList[0].TVALUE4}</label>
                                    <label class="full"></label>
                                </div>                                
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP1" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip2" class="fx_form">
                                    <span id="shpIND2" class="st_label st_no"></span>
                                    <label>ZONE FAIL</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP2" class="full flex_end"></label>
                                    <label id="lblSPUnit2" class="full"></label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label id="5" class="double flex_end">${DccLogTrendInfoList[0].TVALUE6}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP2" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip3" class="fx_form">
                                    <span id="shpIND3" class="st_label st_no"></span>
                                    <label>D/C PR HI</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP3" class="full flex_end"></label>
                                    <label id="lblSPUnit3" class="full"></label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label id="8" class="double flex_end">${DccLogTrendInfoList[0].TVALUE9}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP3" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip4" class="fx_form">
                                    <span id="shpIND4" class="st_label st_no"></span>
                                    <label>MOD TEMP HI</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP4" class="full flex_end"></label>
                                    <label id="lblSPUnit4" class="full"></label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label id="11" class="double flex_end">${DccLogTrendInfoList[0].TVALUE12}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP4" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip5" class="fx_form">
                                    <span id="shpIND5" class="st_label st_no"></span>
                                    <label>ESC LVL LO</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP5" class="full flex_end"></label>
                                    <label id="lblSPUnit5" class="full"></label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label id="14" class="double flex_end">${DccLogTrendInfoList[0].TVALUE15}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP5" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip6" class="fx_form">
                                    <span id="shpIND6" class="st_label st_no"></span>
                                    <label>D/A LVL LO</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="lblSP6" class="full flex_end"></label>
                                    <label id="lblSPUnit6" class="full"></label>
                                </div>
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label id="18" class="double flex_end">${DccLogTrendInfoList[0].TVALUE19}</label>
                                    <label class="full"></label>
                                </div>                                
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP6" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2">
                                <div id="imgTooltip7" class="fx_form">
                                    <span id="shpIND7" class="st_label st_yes"></span>
                                    <label>SG PR HI</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="2">
                                <div class="fx_form">
                                    <label id="lblSP7" class="full flex_end"></label>
                                    <label id="lblSPUnit7" class="full"></label>
                                </div>                                  
                            </td>
                            <th class="tc">SG #1</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="21" class="double flex_end">${DccLogTrendInfoList[0].TVALUE22}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">SG #2</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="22" class="double flex_end">${DccLogTrendInfoList[0].TVALUE23}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td rowspan="2">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP7" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">SG #3</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="23" class="double flex_end">${DccLogTrendInfoList[0].TVALUE24}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">SG #4</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="24" class="double flex_end">${DccLogTrendInfoList[0].TVALUE25}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2">
                                <div id="imgTooltip8" class="fx_form">
                                    <span id="shpIND8" class="st_label st_cond_out"></span>
                                    <label>TBN TRIP PLU</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="2">---------------</td>
                            <th colspan="2">TBN TRIP</th>
                            <td class="tc" colspan="2"><label id="25">${DccLogTrendInfoList[0].TVALUE26}</label></td>
                            <td rowspan="2">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP8" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="bd_l_line" colspan="2">PWE LOAD UNBALANCE</th>
                            <td class="tc" colspan="2"><label id="28">${DccLogTrendInfoList[0].TVALUE29}</label></td>
                        </tr>
                        <tr>
                            <th rowspan="7">
                                <div id="imgTooltip9" class="fx_form">
                                    <span id="shpIND9" class="st_label st_no"></span>
                                    <label>SPATIAL OF NORMAL</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="7">
                                <div class="fx_form_column">
                                    <div class="fx_form">
                                        <label id="lblSP8" class="full flex_end"></label>
                                        <label id="lblSPUnit8" class="full"></label>
                                    </div>
                                    <div class="fx_form">
                                        <label id="lblSPUnit9" class="full flex_center"></label>
                                    </div>
                                    <div class="fx_form">
                                        <label id="lblSP9" class="full flex_end"></label>
                                        <label id="lblSPUnit10" class="full"></label>
                                    </div>
                                </div>
                            </td>
                            <th class="tc">PIC01</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="29" class="double flex_end">${DccLogTrendInfoList[0].TVALUE30}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC08</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="36" class="double flex_end">${DccLogTrendInfoList[0].TVALUE37}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td rowspan="7">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP9" class="double"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC02</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="30" class="double flex_end">${DccLogTrendInfoList[0].TVALUE31}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC09</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="37" class="double flex_end">${DccLogTrendInfoList[0].TVALUE38}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC03</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="31" class="double flex_end">${DccLogTrendInfoList[0].TVALUE32}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC10</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="38" class="double flex_end">${DccLogTrendInfoList[0].TVALUE39}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC04</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="32" class="double flex_end">${DccLogTrendInfoList[0].TVALUE33}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC11</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="39" class="double flex_end">${DccLogTrendInfoList[0].TVALUE40}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC05</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="33" class="double flex_end">${DccLogTrendInfoList[0].TVALUE34}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC12</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="40" class="double flex_end">${DccLogTrendInfoList[0].TVALUE41}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC06</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="34" class="double flex_end">${DccLogTrendInfoList[0].TVALUE35}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC13</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="41" class="double flex_end">${DccLogTrendInfoList[0].TVALUE42}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">PIC07</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="35" class="double flex_end">${DccLogTrendInfoList[0].TVALUE36}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">PIC14</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label id="42" class="double flex_end">${DccLogTrendInfoList[0].TVALUE43}</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div id="imgTooltip10" class="fx_form">
                                    <span id="shpIND10" class="st_label st_no"></span>
                                    <label>MANUAL</label>
                                </div>
                            </th>
                            <td class="tc">----------------</td>
                            <td class="tc" colspan="4"><label id="43">${DccLogTrendInfoList[0].TVALUE44}</label></td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label id="lblFP10" class="double"></label>
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


