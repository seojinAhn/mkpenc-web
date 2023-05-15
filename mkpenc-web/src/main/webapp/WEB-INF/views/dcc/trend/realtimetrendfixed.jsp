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
<script type="text/javascript" src="<c:url value="/resources/js/trend.js" />" charset="utf-8"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/datetimepicker/jquery.datetimepicker.css" />">
<script type="text/javascript" src="<c:url value="/resources/datetimepicker/jquery.datetimepicker.full.min.js" />" charset="utf-8"></script>

<link rel="stylesheet" href="/resources/sbchart/sbchart.css">
<script type="text/javascript" src="/resources/sbchart/sbchart.js"></script>

<script type="text/javascript">
	var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
	var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";
	var currentSelGrp = "";
	var grpNos = [];
	var selGrpNm = "";
	var colorList = ['#801517','#B9529F','#1EBCBE','#282A73','#ED1E24','#7A57A4','#70CBD1','#364CA0'];
	var bGroupFlag = false;
	var swSort;
	
	var chart;

	$(function() {
		//createChart();
		//var iid=0;
		//var str = '${DccGroupList[0]}';
		//var ss = str.replace(/{/gi,'').replace(/}/gi,'').split(', ');
		//for( var dd=0;dd<ss.length;dd++ ) {
		//	console.log(ss[dd].split("=")[1]);
		//}
		
		if( '${BaseSearch.gHis}' == 'H' ) {
			$("input:radio[id='H']").prop("checked",true);
			cmdHistorical_click();
		} else {
			$("input:radio[id='R']").prop("checked",true);
			cmdReal_click();
		}
		
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
		
		currentSelGrp = $("#cboUGrpName option:selected").val();
		
		var grpList = '${DccGroupList}'.split(', groupNo=');
		for( var i=1;i<grpList.length;i++ ) {
			grpNos.push('opt'+grpList[i].substr(0,grpList[i].indexOf('}')));
		}
		
		var sDtm,eDtm,eDate,eHour,eMin;
		if( isNull('${BaseSearch.startDate}') && !isNull('${BaseSearch.endDate}') ) {
			eDate = '${BaseSearch.endDate}'.split(' ')[0];
			eHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			eMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			eDtm = new Date(eDate.split('-')[0]*1, eDate.split('-')[1]*1, eDate.split('-')[2]*1);
			sDtm = new Date(eDtm.setDate(eDtm.getDate()-3));
			$("#selectSDate").val(sDtm.getFullYear()+'-'+convNum(sDtm.getMonth()+1,2)+'-'+convNum(sDtm.getDate(),3)+' '+convNum(eHour,0)+':'+convNum(eMin,1));
			$("#selectEDate").val(eDate+' '+convNum(eHour,0)+':'+convNum(eMin,1));
		} else if( !isNull('${BaseSearch.startDate}') && isNull('${BaseSearch.endDate}') ) {
			sDate = '${BaseSearch.endDate}'.split(' ')[0];
			sHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			sMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			sDtm = new Date(eDate.split('-')[0]*1, eDate.split('-')[1]*1, eDate.split('-')[2]*1);
			eDtm = new Date(sDtm.setDate(sDtm.getDate()+3));
			$("#selectSDate").val(sDate+' '+convNum(sHour,0)+':'+convNum(sMin,1));
			$("#selectEDate").val(eDtm.getFullYear()+'-'+convNum(eDtm.getMonth()+1,2)+'-'+convNum(eDtm.getDate(),3)+' '+convNum(eHour,0)+':'+convNum(eMin,1));
			$("#selectEHour").val(convNum(sHour,0));
			$("#selectEMinute").val(convNum(sMin,1));
		} else if( !isNull('${BaseSearch.startDate}') && !isNull('${BaseSearch.endDate}') ) {
			sDate = '${BaseSearch.startDate}'.split(' ')[0];
			sHour = '${BaseSearch.startDate}'.split(' ')[1].split(':')[0];
			sMin = '${BaseSearch.startDate}'.split(' ')[1].split(':')[1];
			eDate = '${BaseSearch.endDate}'.split(' ')[0];
			eHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			eMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			$("#selectSDate").val(sDate+' '+convNum(sHour,0)+':'+convNum(sMin,1));
			$("#selectEDate").val(eDate+' '+convNum(eHour,0)+':'+convNum(eMin,1));
		} else {
			var eDtm = new Date();
			var sDtm = new Date();
			sDtm = new Date(sDtm.setDate(sDtm.getDate()-3));
			$("#selectSDate").val(sDtm.getFullYear()+'-'+convNum(sDtm.getMonth()+1,2)+'-'+convNum(sDtm.getDate(),3)+' '+convNum(sDtm.getHours(),0)+':'+convNum(sDtm.getMinutes(),1));
			$("#selectEDate").val(eDtm.getFullYear()+'-'+convNum(eDtm.getMonth()+1,2)+'-'+convNum(eDtm.getDate(),3)+' '+convNum(eDtm.getHours(),0)+':'+convNum(eDtm.getMinutes(),1));
		}
		
		jQuery.datetimepicker.setLocale('ko');
		
		$('#selectSDate').datetimepicker(DatetimepickerDefaults({}));
		$('#selectEDate').datetimepicker(DatetimepickerDefaults({}));
		
		$(document.body).delegate('#chkUseGap', 'click', function() {
			chkUseGap_click($("input:checkbox[id='chkUseGap']").is(":checked"));
		});
		
		$(document.body).delegate('#R', 'click', function() {
			$("#cmdHistorical").css("display","");
			$("#cmdReal").css("display","none");
			$("#divUseGap").css("display","none");
			$("#searchDate").css("display","none");
			$("#txtTimeGap").attr("disabled",false);
		});
		
		$(document.body).delegate('#H', 'click', function() {
			//cmdHistorical_click();
			$("#cmdHistorical").css("display","none");
			$("#cmdReal").css("display","");
			$("#divUseGap").css("display","");
			$("#searchDate").css("display","");
			$("#txtTimeGap").attr("disabled",true);
		});
		
		$(document.body).delegate('#3', 'click', function() {
			var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '3';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#4', 'click', function() {
			var uGrpName = $("#cboUGrpName option:selected").val();
			hogiHeader = '4';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#X', 'click', function() {
			var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'X';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#Y', 'click', function() {
			var uGrpName = $("#cboUGrpName option:selected").val();
			xyHeader = 'Y';
			
			//callBody(typeof uGrpName == 'undefined' ? '2' : uGrpName);
		});
		
		$(document.body).delegate('#cmdReal', 'click', function() {
			var selGrpName = $("#cboUGrpName option:selected").val();
			
			if( typeof selGrpName == 'undefined' ) selGrpName = $("#cboUGrpName option:eq(0)").val();
			
			var startDate = "";
			var endDate = "";
			if( $("#selectSDate").val() != null && typeof $("#selectSDate").val() != 'undefined' ) {
				startDate = $("#selectSDate").val()+':00.000';
				endDate = $("#selectEDate").val()+':00.000';
			}
			
			var comAjax = new ComAjax("selGrpFrm");
			comAjax.setUrl("/dcc/trend/changeGrpName");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("startDate", startDate);
			comAjax.addParam("endDate", endDate);
			comAjax.addParam('sUGrpNo',selGrpName);
			comAjax.setCallback("mbr_RuntimerEventCallback");
			comAjax.ajax();
			
			createChart($("#testArea").text());
		});
		
		$(document.body).delegate('#cmdHistorical', 'click', function() {
			var selGrpName = $("#cboUGrpName option:selected").val();
			
			if( typeof selGrpName == 'undefined' ) selGrpName = $("#cboUGrpName option:eq(0)").val();
			
			var startDate = "";
			var endDate = "";
			if( $("#selectSDate").val() != null && typeof $("#selectSDate").val() != 'undefined' ) {
				startDate = $("#selectSDate").val()+':00.000';
				endDate = $("#selectEDate").val()+':00.000';
			}
			
			var comAjax = new ComAjax("selGrpFrm");
			comAjax.setUrl("/dcc/trend/changeGrpName");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("startDate", startDate);
			comAjax.addParam("endDate", endDate);
			comAjax.addParam('sUGrpNo',selGrpName);
			comAjax.setCallback("mbr_RuntimerEventCallback");
			comAjax.ajax();
			
			createChart($("#testArea").text());
		});
		
		$(document.body).on("change", "#cboUGrpName", function() {
			var selGrpName = $("#cboUGrpName option:selected").val();
			
			var startDate = "";
			var endDate = "";
			if( $("#selectSDate").val() != null && typeof $("#selectSDate").val() != 'undefined' ) {
				startDate = $("#selectSDate").val()+':00.000';
				endDate = $("#selectEDate").val()+':00.000';
			}
			
			var comAjax = new ComAjax("selGrpFrm");
			comAjax.setUrl("/dcc/trend/changeGrpName");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("startDate", startDate);
			comAjax.addParam("endDate", endDate);
			comAjax.addParam('sUGrpNo',selGrpName);
			comAjax.setCallback("mbr_RuntimerEventCallback");
			comAjax.ajax();
			
			createChart($("#testArea").text());
		});

		$(document.body).delegate('#cmdUp', 'click', function() {
			cmdUp_click();
		});
		
		$(document.body).delegate('#cmdDown', 'click', function() {
			cmdDown_click();
		});
		
		$(document.body).delegate('#cmdInsert', 'click', function() {
			cmdInsert_click(1);
		});
		
		$(document.body).delegate('#cmdDelete', 'click', function() {
			cmdDelete_click(1);
		});
		
		$(document.body).delegate('#cmdUpdate', 'click', function() {
			cmdUpdate_click();
		});
		
		$(document.body).delegate('#cmdOk', 'click', function() {
			cmdOK_click();
		});
	});
	
	function cmdHistorical_click() {
		$("#cmdHistorical").css("display","none");
		$("#cmdReal").css("display","");
		$("#divUseGap").css("display","");
		$("#searchDate").css("display","");
		$("#txtTimeGap").attr("disabled",true);
	}
	
	function cmdReal_click() {
		//$("#cmdHistorical").css("display","");
		//$("#cmdReal").css("display","none");
		//$("#divUseGap").css("display","none");
		//$("#searchDate").css("display","none");
		//$("#txtTimeGap").attr("disabled",false);
		
		if( $("#txtTimeGap").val() == "0.5" ) {
			var size = $("#lblValue0").attr("value");
			for( var i=0;i<size;i++ ) {
				if( $("#lblTagName"+i).attr("value") != '1' ) {
					alert('태그 전체가 0.5초 태그가 아닙니다. 5초이상을 입력하세요');
					break;
				}
			}
		}
	}
	
	function ssql(swSort) {
		$("#txtADDRESS").css("color","black");
		$("#txtMax").css("background","#FFFFFF");
		$("#txtMin").css("background","#FFFFFF");
		
		var ioType = gIOType;
		if( typeof ioType == 'undefined' ) ioType = 'AI';
		if( ioType == 'AO' ) ioType = 'DT';
		
		if( swSort ) {
			if($("input:checkbox[id='chkSaveCore']").is(":checked") ) {
				$("#txtADDRESS").css("color","#FF00FF");
			} else {
				$("#txtADDRESS").css("color","#800000");
			}
		} else {
			var page = typeof $("#pageNo2").val() == 'undefined' ? 1 : 2;
			var comAjax = new ComAjax("ioListForm");
			comAjax.setUrl("/dcc/trend/ssql");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("ioType", ioType);
			comAjax.addParam("ioBit", typeof $("#txtIOBIT").val() == 'undefined' ? '' : $("#txtIOBIT").val() );
			comAjax.addParam("SaveCore", $("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0");
			comAjax.addParam("address", typeof $("#txtADDRESS").val() == 'undefined' ? "" : $("#txtADDRESS").val());
			comAjax.setCallback("mbr_ssqlCallback");
			comAjax.ajax();
			
			setIOAjax();
		}
	}
	
	function setIOAjax() {
		if( $("#ajaxHogi").val() != null ) $("#cboHogi").val($("#ajaxHogi").val()).prop("selected",true);
		if( $("#ajaxXYGubun").val() != null ) $("#cboXYGubun").val($("#ajaxXYGubun").val()).prop("selected",true);
		if( $("#ajaxLoopName").val() != null ) $("#txtLOOPNAME").val($("#ajaxLoopName").val());
		if( $("#ajaxIOType").val() != null || typeof $("#ajaxIOType").val() == 'undefined' ) $("#cboIOType").val($("#ajaxIOType").val()).prop("selected",true);
		if( $("#ajaxAddress").val() != null ) $("#txtADDRESS").val($("#ajaxAddress").val());
		if( $("#ajaxIOBit").val() != null ) $("#txtIOBIT").val($("#ajaxIOBit").val());
		if( $("#ajaxMin").val() != null ) $("#txtMin").val($("#ajaxMin").val());
		if( $("#ajaxMax").val() != null ) $("#txtMax").val($("#ajaxMax").val());
		if( $("#ajaxSaveCore").val() == '1' ) $("input:checkbox[id='chkSaveCore']").prop("checked",true);
		
		if( $("#ajaxFastIoChk").val() == '1' ) {
			$("#txtADDRESS").css("color","#FF00FF");
		} else {
			$("#txtADDRESS").css("color","#800000");
		}
		$("#txtMin").css("background","#FFFFFF");
		$("#txtMax").css("background","#FFFFFF");
	}
	
	function DatetimepickerDefaults(opts) {
	    return $.extend({},{
	    format:'Y-m-d H:i:00',
		formatTime:'H:i:00',
	    formatDate:'Y-m-d',
		step : 1,
		monthChangeSpinner:true,
	    sideBySide: true
	    
	    }, opts);
	}
	
	function convNum(num,type) {
		var tmp = num*1;
		if( type == 0 ) {
			if( tmp > 23 ) tmp = tmp - 24;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		} else if( type == 1 ) {
			if( tmp > 59 ) tmp = tmp - 60;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		} else if( type == 2 ) {
			if( tmp > 12 ) tmp = tmp - 12;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		} else if( type == 3 ) {
			if( tmp > 31 ) tmp = tmp - 31;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		}
		return num;
	}
	
	function isNull(str) {
		if( str == null || str == '' || str == 'undefined' ) {
			return true;
		} else {
			return false;
		}
	}
	
	function chkUseGap_click(type) {
		if( type == true ) {
			$("#txtTimeGap").attr("disabled",false);
			$("#selectSDate").attr("disabled",true);
		} else {
			$("#txtTimeGap").attr("disabled",true);
			$("#selectSDate").attr("disabled",false);
		}
	}

	function createChart(data){
		var xValues = data.split("},{");
		var str0 = xValues[0];
		var strLast = xValues[xValues.length-1];
		
		str0 = str0.substring(1,str0.length);
		strLast = strLast.substring(0,strLast.length-1);
		
		xValues.splice(0,1,str0);
		xValues.splice(xValues.length-1,1,strLast);

		var xData = [];
		var xAxis = [];
		for( var j=0;j<xValues.length;j++ ) {
			var xJson = xValues[j].split(', ');
			
			var tJson = {};
			tJson.name = xJson[0];
			for( var ti=0;ti<xJson.length;ti++ ) {
				var key = xJson[ti].split('=')[0];
				var val = (xJson[ti].split('=')[1])*1;
				tJson[key] = val;
			}
			
			xData.push(tJson);
			if( j == 0 ) {		
				for( var d=1;d<xJson.length;d++ ) {
					xAxis.push(xJson[d].split('=')[0]);
				}
			}
		}
		
		var chartConfig = {
			global: {
				svg: {
					classname: 'customClass' // 해당 차트의 svg 태그에 커스텀 클래스 설정
				},
				size: {
					width: 840,
					height: 600
				}
			},
			data: {
				type: 'line', // 차트의 타입을 설정 
				json: xData, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
				keys: { // json 형태의 데이터를 사용 시, 필수로 keys 속성을 사용해야 함
					x: "name", // 각각의 x축 이름을 chartData의 name값으로 설정 
					value: xAxis // chartData의 2015, 2016, 2017 데이터를 보여주도록 설정
				}
			},
			extend: {
				bar: {
					topRadius: 15
				}
			},
			axis: {
				//x:{type:'category'}
				x:{show:false}
			},
			grid: {
				x:{show:false},
				y:{show:false}
			}
		};
		chart = new sb.chart("#chartArea", chartConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 xhart config 객체명 기입
		chart.render(); // render 메소드를 사용해야 차트가 그려짐 (동적으로 사용 시에도 마지막에 꼭 render()를 써줘야 변경한 값들이 반영되어 보여집니다.)
	}

	var chartData = [
		{name: '서울', 2015: 10, 2016: 20, 2017: 30},
		{name: '경기', 2015: 30, 2016: 10, 2017: 20},
		{name: '인천', 2015: 20, 2016: 30, 2017: 10},
	]
	
	function loadTrendDataArray(data) {
		var arrTrendData = data;
		
		console.log('trend data :: '+arrTrendData);
	}
	
	function cmdOK_click() {
		
	}
	
	function getLvIOList() {
		var tmpArray = '${LvIOList}'.replace('[{','').replace('}]','').split('}, {');
		var ioListArray = [];
		var ioListArraySub = [];
		for( var i=0;i<tmpArray.length;i++ ) {
			var tmpSub = tmpArray[i].split(', ');
			for( var j=0;j<tmpSub.length;j++ ) {
				var k = tmpSub[j].split('=')[0];
				var v = tmpSub[j].split('=')[1];
				ioListArraySub.push({key:k,value:v});
			}
			ioListArray.push(ioListArraySub);
			ioListArraySub = [];
		}
		
		return ioListArray;
	}
		
	function removeModData(array,str) {
		if( str != '' ) {
			var set = new Set(array);
			var newArr = [...set];
	
			for( var i=0;i<newArr.length;i++ ) {
				if( newArr[i] == str ) {
					return true;
				}
			}
			return false;
		} else {
			return false;
		}
	}
	
	function textClear(str) {
		swSort = true;
		
		if( str != 'modal_3' ) {
			$("#ajaxHogi").val('3');
			$("#ajaxXYGubun").val('X');
			$("#ajaxLoopName").val('');
			$("#ajaxIOType").val('AI');
			$("#ajaxAddress").val('');
			$("#ajaxIOBit").val('');
			$("#ajaxMin").val('');
			$("#ajaxMax").val('');
			$("#ajaxSaveCore").val('');
			$("#ajaxFastIoChk").val('');
			$("#ajaxISeq").val('');

			$("#iSeqMod").val('|==SEP==|');
			$("#xyGubunMod").val('|==SEP==|');
			$("#DescrMod").val('|==SEP==|');
			$("#ioTypeod").val('|==SEP==|');
			$("#addressMod").val('|==SEP==|');
			$("#ioBitMod").val('|==SEP==|');
			$("#minValMod").val('|==SEP==|');
			$("#maxValMod").val('|==SEP==|');
			$("#saveCoreMod").val('|==SEP==|');
			$("#gubunMod").val('|==SEP==|');
			$("#iSeqMod").val('|==SEP==|');
		} else {
			$("#cboTagHogi").val('3');
			$("#cboTagIOType").val('AI');
			$("#chkOpt1").prop('chkeced',false);
			$("#chkOpt2").prop('chkeced',false);
			$("#findData").val('');
		}
		
		$("#txtISeq").val('');
		$("#cboHogi").val('3');
		$("#cboXYGubun").val('X');
		$("#txtLOOPNAME").val('');
		$("#cboIOType").val('AI');
		$("#txtADDRESS").val('');
		$("#txtIOBIT").val('');
		$("#txtMin").val('');
		$("#txtMax").val('');
		$("input:checkbox[id='chkSaveCore']").prop("checked",false);
		
		swSort = false;
	}
	
	function cmdInsert_click(type) {
		var ioListArray = getLvIOList();
		
		var data = '';
		var gubun = $("#txtGUBUN").val() == '' ? 'D' : $("#txtGUBUN").val();
		
		var iSeqAdd = $("#txtISeq").val();
		//var gubunAdd = $("#txtGUBUN").val();
		var gubunAdd = 'D';
		var hogiAdd = $("#cboHogi option:selected").val();
		var xyGubunAdd = $("#cboXYGubun option:selected").val();
		var DescrAdd = $("#txtLOOPNAME").val();
		var ioTypeAdd = $("#cboIOType option:selected").val();
		var addressAdd = $("#txtADDRESS").val();
		var ioBitAdd = $("#txtIOBIT").val();
		var minValAdd = $("#txtMin").val();
		var maxValAdd = $("#txtMax").val();
		var saveCoreAdd = $("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0";
		
		if( iSeqAdd == '' || hogiAdd == '' ) {
			alert('태그를 선택하십시요.');
			return;
		}
		if( minValAdd != 'undefined' && minValAdd != null && typeof minValAdd != 'undefined' ) {
			if( isNaN(minValAdd) ) {
				alert('MIN, MAX 값이 잘못되었습니다.');
				return;
			}
		}
		if( maxValAdd != 'undefined' && maxValAdd != null && typeof maxValAdd != 'undefined' ) {
			if( isNaN(maxValAdd) ) {
				alert('MIN, MAX 값이 잘못되었습니다.');
				return;
			}
		}
		if( $.trim(minValAdd) == '' ) minValAdd = '0';
		if( $.trim(maxValAdd) == '' ) {
			if( ioTypeAdd == 'DI' || ioTypeAdd == 'DO' || (ioTypeAdd == 'SC' && saveCoreAdd == '1') ) {
				maxValAdd = '1';
			} else if( (ioTypeAdd == 'SC' && saveCoreAdd == '0') ) {
				maxValAdd = '65535';
			} else if( ioTypeAdd == 'DT' ) {
				maxValAdd = '1.5';
			} else {
				maxValAdd = '100';
			}
		}
		if( (ioTypeAdd == 'SC' && saveCoreAdd == '1') ) {
			if( $.trim(ioBitAdd) == '' ) {
				alert('IOBIT을 입력하십시요.');
				return;
			}
		} else if( (ioTypeAdd == 'SC' && saveCoreAdd == '0') ) {
			ioBitAdd = '';
		}
		if( $.trim(DescrAdd) == '' ) {
			if( ioBitAdd != '' ) {
				DescrAdd = ioTypeAdd+' '+addressAdd+':'+ioBitAdd;
			} else {
				DescrAdd = ioTypeAdd+' '+addressAdd;
			}
		}
		
		var iSeqMod = $("#iSeqMod").val().split('==SEP==');
		var gubunMod = $("#gubunMod").val().split('==SEP==');
		var hogiMod = $("#hogiMod").val().split('==SEP==');
		var xyGubunMod = $("#xyGubunMod").val().split('==SEP==');
		var DescrMod = $("#DescrMod").val().split('==SEP==');
		var ioTypeMod = $("#ioTypeMod").val().split('==SEP==');
		var addressMod = $("#addressMod").val().split('==SEP==');
		var ioBitMod = $("#ioBitMod").val().split('==SEP==');
		var minValMod = $("#minValMod").val().split('==SEP==');
		var maxValMod = $("#maxValMod").val().split('==SEP==');
		var saveCoreMod = $("#saveCoreMod").val().split('==SEP==');
		
		var dupChk = 0;
		if( !removeModData(iSeqMod[0].split('|'),iSeqAdd) ) {
			for( var l=0;l<ioListArray.length;l++ ) {
				for( var sl=0;sl<ioListArray[l].length;sl++ ) {
					if( ioListArray[l][sl].key == 'iSeq' ) {
						if( ioListArray[l][sl].value == iSeqAdd ) {
							dupChk++;
						}
					} else if( ioListArray[l][sl].key == 'hogi' ) {
						if( ioListArray[l][sl].value == hogiAdd ) {
							if( dupChk < 1 ) dupChk++;
						}
					}
				}
			}
			
			if( dupChk > 1 ) {
				alert('이미 설정되어 있습니다.');
				dupChk = 0;
				return;
			}
			
			if( iSeqMod[0] != '|' ) {
				iSeqAdd += '|'+ iSeqMod[0];
				gubunAdd += '|'+ gubunMod[0];
				hogiAdd += '|'+ hogiMod[0];
				xyGubunAdd += '|'+ xyGubunMod[0];
				DescrAdd += '|'+ DescrMod[0];
				ioTypeAdd += '|'+ ioTypeMod[0];
				addressAdd += '|'+ addressMod[0];
				ioBitAdd += '|'+ ioBitMod[0];
				minValAdd += '|'+ minValMod[0];
				maxValAdd += '|'+ maxValMod[0];
				saveCoreAdd += '|'+ saveCoreMod[0];
			} else {
				iSeqAdd += '|';
				gubunAdd += '|';
				hogiAdd += '|';
				xyGubunAdd += '|';
				DescrAdd += '|';
				ioTypeAdd += '|';
				addressAdd += '|';
				ioBitAdd += '|';
				minValAdd += '|';
				maxValAdd += '|';
				saveCoreAdd += '|';
			}
		}
		
		var listCnt = iSeqMod[0].split('|').length + ioListArray.length;
		if( typeof iSeqMod[1] != 'undefined' ) listCnt -= iSeqMod[1].split('|').length;
		
		if( type != 0 ) {
			if( listCnt > 7 ) {
				alert('8개 까지만 지정할수 있습니다.');
				return;
			}
		}
		
		$("#iSeqMod").val(iSeqMod[1] == '' ? iSeqAdd + '==SEP==|' : iSeqAdd + '==SEP==' + iSeqMod[1]);
		$("#gubunMod").val(gubunMod[1] == '' ? gubunAdd + '==SEP==|' : gubunAdd + '==SEP==' + gubunMod[1]);
		$("#hogiMod").val(hogiMod[1] == '' ? hogiAdd + '==SEP==|' : hogiAdd + '==SEP==' + hogiMod[1]);
		$("#xyGubunMod").val(xyGubunMod[1] == '' ? xyGubunAdd + '==SEP==|' : xyGubunAdd + '==SEP==' + xyGubunMod[1]);
		$("#DescrMod").val(DescrMod[1] == '' ? DescrAdd + '==SEP==|' : DescrAdd + '==SEP==' + DescrMod[1]);
		$("#ioTypeMod").val(ioTypeMod[1] == '' ? ioTypeAdd + '==SEP==|' : ioTypeAdd + '==SEP==' + ioTypeMod[1]);
		$("#addressMod").val(addressMod[1] == '' ? addressAdd + '==SEP==|' : addressAdd + '==SEP==' + addressMod[1]);
		$("#ioBitMod").val(ioBitMod[1] == '' ? ioBitAdd + '==SEP==|' : ioBitAdd + '==SEP==' + ioBitMod[1]);
		$("#minValMod").val(minValMod[1] == '' ? minValAdd + '==SEP==|' : minValAdd + '==SEP==' + minValMod[1]);
		$("#maxValMod").val(maxValMod[1] == '' ? maxValAdd + '==SEP==|' : maxValAdd + '==SEP==' + maxValMod[1]);
		$("#saveCoreMod").val(saveCoreMod[1] == '' ? saveCoreAdd + '==SEP==|' : saveCoreAdd + '==SEP==' + saveCoreMod[1]);

		if( type == 1 ) {
			var comAjax = new ComAjax("ioListModForm");
			comAjax.setUrl("/dcc/trend/cmdInsert");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("iSeqMod", $("#iSeqMod").val());
			comAjax.addParam("gubunMod", $("#gubunMod").val());
			comAjax.addParam("hogiMod", $("#hogiMod").val());
			comAjax.addParam("xyGubunMod", $("#xyGubunMod").val());
			comAjax.addParam("descrMod", $("#DescrMod").val());
			comAjax.addParam("ioTypeMod", $("#ioTypeMod").val());
			comAjax.addParam("addressMod", $("#addressMod").val());
			comAjax.addParam("ioBitMod", $("#ioBitMod").val());
			comAjax.addParam("minValMod", $("#minValMod").val());
			comAjax.addParam("maxValMod", $("#maxValMod").val());
			comAjax.addParam("saveCoreMod", $("#saveCoreMod").val());
			comAjax.setCallback("mbr_cmdEventCallback");
			comAjax.ajax();
			
			textClear();
		}
	}
		
	function cmdDelete_click(type) {
		var ioListArray = getLvIOList();
		
		if( ioListArray.length > 0 ) {
			var data = '';
			var gubun = $("#txtGUBUN").val() == '' ? 'D' : $("#txtGUBUN").val();
			
			var iSeqAdd = $("#txtISeq").val();
			var gubunAdd = $("#txtGUBUN").val();
			var hogiAdd = $("#cboHogi option:selected").val();
			var xyGubunAdd = $("#cboXYGubun option:selected").val();
			var DescrAdd = $("#txtLOOPNAME").val();
			var ioTypeAdd = $("#cboIOType option:selected").val();
			var addressAdd = $("#txtADDRESS").val();
			var ioBitAdd = $("#txtIOBIT").val();
			var minValAdd = $("#txtMin").val();
			var maxValAdd = $("#txtMax").val();
			var saveCoreAdd = $("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0";
			
			var iSeqMod = $("#iSeqMod").val().split('==SEP==');
			var gubunMod = $("#gubunMod").val().split('==SEP==');
			var hogiMod = $("#hogiMod").val().split('==SEP==');
			var xyGubunMod = $("#xyGubunMod").val().split('==SEP==');
			var DescrMod = $("#DescrMod").val().split('==SEP==');
			var ioTypeMod = $("#ioTypeMod").val().split('==SEP==');
			var addressMod = $("#addressMod").val().split('==SEP==');
			var ioBitMod = $("#ioBitMod").val().split('==SEP==');
			var minValMod = $("#minValMod").val().split('==SEP==');
			var maxValMod = $("#maxValMod").val().split('==SEP==');
			var saveCoreMod = $("#saveCoreMod").val().split('==SEP==');
			
			if( typeof iSeqMod[1] != 'undefined' ) {
				if( !removeModData(iSeqMod[1].split('|'),iSeqAdd) ) {
					iSeqAdd += '|'+iSeqMod[1];
					gubunAdd += '|'+gubunMod[1];
					hogiAdd += '|'+hogiMod[1];
					xyGubunAdd += '|'+xyGubunMod[1];
					DescrAdd += '|'+DescrMod[1];
					ioTypeAdd += '|'+ioTypeMod[1];
					addressAdd += '|'+addressMod[1];
					ioBitAdd += '|'+ioBitMod[1];
					minValAdd += '|'+minValMod[1];
					maxValAdd += '|'+maxValMod[1];
					saveCoreAdd += '|'+saveCoreMod[1];
				}
			} else {
				iSeqAdd += '|';
				gubunAdd += '|';
				hogiAdd += '|';
				xyGubunAdd += '|';
				DescrAdd += '|';
				ioTypeAdd += '|';
				addressAdd += '|';
				ioBitAdd += '|';
				minValAdd += '|';
				maxValAdd += '|';
				saveCoreAdd += '|';
			}
			
			$("#iSeqMod").val(iSeqMod[0] == '' ? '|==SEP=='+iSeqAdd : iSeqMod[0]+'==SEP=='+iSeqAdd);
			$("#gubunMod").val(gubunMod[0] == '' ? '|==SEP=='+gubunAdd : gubunMod[0]+'==SEP=='+gubunAdd);
			$("#hogiMod").val(hogiMod[0] == '' ? '|==SEP=='+hogiAdd : hogiMod[0]+'==SEP=='+hogiAdd);
			$("#xyGubunMod").val(xyGubunMod[0] == '' ? '|==SEP=='+xyGubunAdd : xyGubunMod[0]+'==SEP=='+xyGubunAdd);
			$("#DescrMod").val(DescrMod[0] == '' ? '|==SEP=='+DescrAdd : DescrMod[0]+'==SEP=='+DescrAdd);
			$("#ioTypeMod").val(ioTypeMod[0] == '' ? '|==SEP=='+ioTypeAdd : ioTypeMod[0]+'==SEP=='+ioTypeAdd);
			$("#addressMod").val(addressMod[0] == '' ? '|==SEP=='+addressAdd : addressMod[0]+'==SEP=='+addressAdd);
			$("#ioBitMod").val(ioBitMod[0] == '' ? '|==SEP=='+ioBitAdd : ioBitMod[0]+'==SEP=='+ioBitAdd);
			$("#minValMod").val(minValMod[0] == '' ? '|==SEP=='+minValAdd : minValMod[0]+'==SEP=='+minValAdd);
			$("#maxValMod").val(maxValMod[0] == '' ? '|==SEP=='+maxValAdd : maxValMod[0]+'==SEP=='+maxValAdd);
			$("#saveCoreMod").val(saveCoreMod[0] == '' ? '|==SEP=='+saveCoreAdd : saveCoreMod[0]+'==SEP=='+saveCoreAdd);
	
			if( type == 1 ) {
				var comAjax = new ComAjax("ioListModForm");
				comAjax.setUrl("/dcc/trend/cmdInsert");
				comAjax.addParam("hogiHeader", hogiHeader);
				comAjax.addParam("xyHeader", xyHeader);
				comAjax.addParam("iSeqMod", $("#iSeqMod").val());
				comAjax.addParam("gubunMod", $("#gubunMod").val());
				comAjax.addParam("hogiMod", $("#hogiMod").val());
				comAjax.addParam("xyGubunMod", $("#xyGubunMod").val());
				comAjax.addParam("descrMod", $("#DescrMod").val());
				comAjax.addParam("ioTypeMod", $("#ioTypeMod").val());
				comAjax.addParam("addressMod", $("#addressMod").val());
				comAjax.addParam("ioBitMod", $("#ioBitMod").val());
				comAjax.addParam("minValMod", $("#minValMod").val());
				comAjax.addParam("maxValMod", $("#maxValMod").val());
				comAjax.addParam("saveCoreMod", $("#saveCoreMod").val());
				comAjax.setCallback("mbr_cmdEventCallback");
				comAjax.ajax();
				
				textClear();
			}
		}
	}
	
	function cmdUpdate_click() {
		var ioListArray = getLvIOList();
		if( ioListArray.length > 0 ) {
		
			var seletedIseq = '';
			var seletedHogi = '';
			if( selectedID != '' ) {
				seletedIseq = selectedID.split('_')[0];
				seletedHogi = selectedID.split('_')[1];
			}
			
			var valIOType = $("#cboIOType option:selected").val();
			var bSaveCore = $("input:checkbox[id='chkSaveCore']").is(":checked");
			
			if( $.trim($("#txtMin").val()) == '' ) $("#txtMin").val('0');
			if( valIOType == 'DI' || valIOType == 'DO' ) {
				$("#txtMax").val('1');
			} else if( valIOType == 'SC' && !bSaveCore ) {
				$("#txtMax").val('65535');
				$("#txtIOBIT").val('');
			} else if( valIOType == 'DT' ) {
				$("#txtMax").val('1.5');
			} else {
				$("#txtMax").val('100');
			}
			if( valIOType == 'SC' && !bSaveCore ) {
				$("#txtMax").val('1');
				if( $.trim($("#txtIOBIT").val()) == '' ) {
					alert('IOBIT을 입력하십시요');
					return;
				}
			}
			if( $.trim($("#txtLOOPNAME").val()) == '' ) {
				if( $.trim($("#txtIOBIT").val()) != '' ) {
					$("#txtLOOPNAME").val(valIOType+' '+$("#txtADDRESS").val()+':'+$("#txtIOBIT").val());
				} else {
					$("#txtLOOPNAME").val(valIOType+' '+$("#txtADDRESS").val());
				}
			} 
			
			cmdDelete_click(0);
			cmdInsert_click(0);
			
			$("#"+seletedIseq+"iSeq"+seletedHogi).text($("#txtISeq").val());
			$("#"+seletedIseq+"gubun"+seletedHogi).text($("#txtGUBUN").val());
			$("#"+seletedIseq+"hogi"+seletedHogi).text($("#cboHogi option:selected").val());
			$("#"+seletedIseq+"xyGubun"+seletedHogi).text($("#cboXYGubun option:selected").val());
			$("#"+seletedIseq+"descr"+seletedHogi).text($("#txtLOOPNAME").val());
			$("#"+seletedIseq+"ioType"+seletedHogi).text($("#cboIOType option:selected").val());
			$("#"+seletedIseq+"address"+seletedHogi).text($("#txtADDRESS").val());
			$("#"+seletedIseq+"ioBit"+seletedHogi).text($("#txtIOBIT").val());
			$("#"+seletedIseq+"minVal"+seletedHogi).text($("#txtMin").val());
			$("#"+seletedIseq+"maxVal"+seletedHogi).text($("#txtMax").val());
			$("#"+seletedIseq+"saveCoreChk"+seletedHogi).text($("input:checkbox[id='chkSaveCore']").is(":checked") ? "1" : "0");
			
			textClear();
		}
	}
	
	function cmdOK_click() {
		if( bGroupFlag ) {
			//group
		} else {
			if( $("#txtTitle").val() == '' ) {
				alert('제목을 입력하십시요 (IO Setting)');
				return;
			}
			
			/*
			var ioListArray = getLvIOList();
			for( var i=0;i<ioListArray.length;i++ ) {
				if( ioListArray[i].key == 'gubun' ) {
					if( ioListArray[i].value == 'M' ) {
						bFlagM = true;
					}
				}
				if( ioListArray[i].key == 'gubun' ) {
					if( ioListArray[i].value == 'D' ) {
						bFlagD = true;
					}
				}
			}
			
			if( !bFlagM ) {
				alert('DCC, MARK-V 비교트랜드 입니다. MARK-V 태그가 설정되지 않았습니다. (태그설정)');
				return;
			}
			if( !bFlagD ) {
				alert('DCC, MARK-V 비교트랜드 입니다. DCC 태그가 설정되지 않았습니다. (태그설정)');
				return;
			}
			*/
			
			var comAjax = new ComAjax("ioListModForm");
			comAjax.setUrl("/dcc/trend/cmdOK");
			comAjax.addParam("hogiHeader", hogiHeader);
			comAjax.addParam("xyHeader", xyHeader);
			comAjax.addParam("iSeqMod", $("#iSeqMod").val() == '' ? "|==SEP==|" : $("#iSeqMod").val());
			comAjax.addParam("gubunMod", $("#gubunMod").val() == '' ? "|==SEP==|" : $("#gubunMod").val());
			comAjax.addParam("hogiMod", $("#hogiMod").val() == '' ? "|==SEP==|" : $("#hogiMod").val());
			comAjax.addParam("xyGubunMod", $("#xyGubunMod").val() == '' ? "|==SEP==|" : $("#xyGubunMod").val());
			comAjax.addParam("descrMod", $("#DescrMod").val() == '' ? "|==SEP==|" : $("#DescrMod").val());
			comAjax.addParam("ioTypeMod", $("#ioTypeMod").val() == '' ? "|==SEP==|" : $("#ioTypeMod").val());
			comAjax.addParam("addressMod", $("#addressMod").val() == '' ? "|==SEP==|" : $("#addressMod").val());
			comAjax.addParam("ioBitMod", $("#ioBitMod").val() == '' ? "|==SEP==|" : $("#ioBitMod").val());
			comAjax.addParam("minValMod", $("#minValMod").val() == '' ? "|==SEP==|" : $("#minValMod").val());
			comAjax.addParam("maxValMod", $("#maxValMod").val() == '' ? "|==SEP==|" : $("#maxValMod").val());
			comAjax.addParam("saveCoreMod", $("#saveCoreMod").val() == '' ? "|==SEP==|" : $("#saveCoreMod").val());
			if( $("input:checkbox[id=chkHogi]").is(":checked") ) {
				comAjax.addParam("chkHogi", "1");
			}
			comAjax.setCallback("mbr_cmdEventCallback");
			comAjax.ajax();
		}
	}
	
	function openModal(str) {
		if( str != 'modal_3' ) {
			openLayer(str);
			
		} else {
			swSort = true;
			openLayer(str);
		}
	}
	
	function closeModal(str) {
		//textClear(str);
		
		if( str != 'modal_3' ) {
			cmdOK_click();
		} else {
			swSort = false;
		}
		
		closeLayer(str);
	}
	
	function checkbox_click(data) {
		console.log($("input:checkbox[id='"+data+"']").is(":checked"));
		var idx = data.substring(11,data.length);
		console.log($("#lblTagName"+idx).text());
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
				<h3>REALTIME TREND</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>REALTIME TREND</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<form id="selGrpFrm" type="hidden"></form>
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
                            <label>구분</label>
                            <div class="fx_form">
							    <label>
                                    <input id="R" value="R" type="radio" name="type">
                                    실시간
                                </label>
							    <label>
                                    <input id="H" value="H" type="radio" name="type">
                                    과거검색
                                </label>
                            </div>
						</div>
						<div class="fx_srch_item">
				    		<label id="divUseGap" style="display:none">
                                <input id="chkUseGap" type="checkbox" name="type">
                                &nbsp;주기설정
                            </label>
							<label>주기</label>
							<div class="class="fx_form">
							<label>
                            	<input id="txtTimeGap" type="text" value="5">
                            	<font style="padding-top:5px;">&nbsp;초</font>
                            </label>
                            </div>
						</div>
						<div id="searchDate" class="fx_srch_item" style="display:none">
							<label>검색기간</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id="selectSDate" name="selectSDate" readonly>
                                	<label>~</label>
                                    <input type="text" id="selectEDate" name="selectEDate" readonly>
                                </div>
                            </div>
						</div>
						<div class="fx_srch_item"></div>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a id="cmdReal" href="#none" onclick="javascript:cmdReal_click();" class="btn_srch">Search</a>
					<a id="cmdHistorical" href="#none" onclick="javascript:cmdHistorical_click();" class="btn_srch" style="display:none">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap b_type">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item no_label">	
                            <div class="fx_form">
                                <select id="cboUGrpName">
                                <c:forEach var="grpInfo" items="${DccGroupList}">
                                	<option id="opt${grpInfo.groupNo}" value="${grpInfo.groupNo}">${grpInfo.groupName}</option>
                                </c:forEach>
                                </select>
                                <a href="#none" class="btn_list">새창으로</a>
                                <a href="#none" class="btn_list">Range 저장</a>
                                <label>
                                    <input id="chkCross" type="checkbox">
                                    십자선
                                </label>
                            </div>
						</div>
						<div class="fx_srch_item"></div>
					</div>
					<div class="fx_srch_row" id="lblBody1">
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_1" style="display:none"><!-- color : #801517 -->
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_2" style="display:none"><!-- color : #B9529F -->
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_3" style="display:none"><!-- color : #1EBCBE -->
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_4" style="display:none"><!-- color : #282A73 -->
                            </div>
						</div>
					</div>
					<div class="fx_srch_row" id="lblBody2">
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_5" style="display:none"><!-- color : #ED1E24 -->
                            </div>
                        </div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_6" style="display:none"><!-- color : #7A57A4 -->
                            </div>
                        </div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_7" style="display:none"><!-- color : #70CBD1 -->
                            </div>
                        </div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_8" style="display:none"><!-- color : #364CA0 -->
                            </div>
                        </div>
					</div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->
			<div id="rangeHi">
			</div>
			<!-- chart_wrap_area -->
			<div class="chart_wrap_area">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_1');">변수설정</a></li>
                        <li><a href="#none" onclick="openLayer('modal_2');">엑셀로 저장</a></li>
                    </ul>
                    <ul>
                        <li class="check active"><a href="#none">X축 격자</a></li>
                        <li class="check active"><a href="#none">Y축 격자</a></li>
                        <li class="check"><a href="#none">선 굵게</a></li>
                    </ul>
                    <ul>
                        <li><a href="#none">그래프 인쇄</a></li>
                        <li><a href="#none">그래프 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 --> 
                <div id="chartArea"></div>
            </div>
            <input id="testArea" type="hidden"></input>
            <!-- //chart_wrap_area -->
			<div id="rangeLow">
			</div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<script type="text/javascript" src="<c:url value="/resources/js/footer.js" />" charset="utf-8"></script>
	<!-- //footer -->
</div>
<!--  //wrap  -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_123">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>변수설정</h3>
        <a onclick="closeLayer('modal_123');" title="Close"></a>
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
                    <th>Title</th>
                    <td>
                        <div class="fx_form">
                            <input type="text">
                            <a class="btn_list" herf="none">그룹추가</a>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <select>
                                <option>3</option>
                            </select>
                        </td>
                        <td>
                            <select>
                                <option>X</option>
                            </select>
                        </td>
                        <td><input type="text"></td>
                        <td>
                            <select>
                                <option>AI</option>
                            </select>
                        </td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td class="tc"><input type="checkbox"></td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
            <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none">Tag Search</a>
                </div>
                <div class="button">
                    <a class="btn_list" href="#none">추가</a>
                    <a class="btn_list" href="#none">수정</a>
                    <a class="btn_list" href="#none">삭제</a>
                    <a class="btn_list" href="#none">위</a>
                    <a class="btn_list" href="#none">아래</a>
                </div>
            </div>
            <!-- //list_bottom -->
        </div>
        <!-- //list_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_123');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>변수설정</h3>
        <a onclick="closeModal('modal_1');" title="Close"></a>
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
                    <th>Title</th>
                    <td>
                        <div class="fx_form">
                            <input id="txtTitle" type="text" value="${LvIOList[0].title}">
                            <a class="btn_list" id="cmdGroupInsert" herf="none">그룹추가</a>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->        
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table id="lvIOListTable" class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr id="itemHeaders">
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody id="lvIolistTable">
                <c:forEach var="oListItem" items="${LvIOList}">
                    <tr>
                        <td id="${oListItem.iSeq}hogi${oListItem.hogi}" class="tc">${oListItem.hogi}</td>
                        <td id="${oListItem.iSeq}xyGubun${oListItem.hogi}" class="tc">${oListItem.xyGubun}</td>
                        <td id="${oListItem.iSeq}descr${oListItem.hogi}">${oListItem.Descr}</td>
                        <td id="${oListItem.iSeq}ioType${oListItem.hogi}" class="tc">${oListItem.ioType}</td>
                        <td id="${oListItem.iSeq}address${oListItem.hogi}" class="tc">${oListItem.address}</td>
                        <td id="${oListItem.iSeq}ioBit${oListItem.hogi}" class="tc">${oListItem.ioBit}</td>
                        <td id="${oListItem.iSeq}minVal${oListItem.hogi}" class="tc">${oListItem.minVal}</td>
                        <td id="${oListItem.iSeq}maxVal${oListItem.hogi}" class="tc">${oListItem.maxVal}</td>
                        <td id="${oListItem.iSeq}saveCoreChk${oListItem.hogi}" class="tc">${oListItem.SaveCoreChk}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <form id="ioListForm">
            <table class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>Type</th>
                        <th>Address</th>
                        <th>Bit</th>
                        <th>Min</th>
                        <th>Max</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody id="filterBody">
                    <tr>
                        <td>
                            <select id="cboHogi">
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>                        
                        </td>
                        <td>
                            <select id="cboXYGubun">
                                <option value="X">X</option>
                                <option value="Y">Y</option>
                            </select>                        
                        </td>
                        <td><input id="txtLOOPNAME" type="text"></td>
                        <td>
                            <select id="cboIOType">
                                <option value="AI">AI</option>
                                <option value="DT">DT</option>
                            </select>                        
                        </td>
                        <td><input id="txtADDRESS" type="text" class="tc"></td>
                        <td class="tc"><input id="txtIOBIT" type="text" class="tc"></td>
                        <td class="tc"><input id="txtMin" type="text" class="tc"></td>
                        <td class="tc"><input id="txtMax" type="text" class="tc"></td>
                        <td class="tc"><input id="chkSaveCore" type="checkbox"></td>
                    </tr>
                </tbody>
            </table>
            <form id="ioListModForm">
            <table>
            	<tbody id="ioListAjax">
            	<tr>
            		<td style="display:none">
            			<input type="hidden" id="ajaxHogi" type="text" value="">
            			<input type="hidden" id="ajaxXYGubun" type="text" value="">
            			<input type="hidden" id="ajaxLoopName" type="text" value="">
            			<input type="hidden" id="ajaxIOType" type="text" value="">
            			<input type="hidden" id="ajaxAddress" type="text" value="">
            			<input type="hidden" id="ajaxIOBit" type="text" value="">
	                    <input type="hidden" id="ajaxMin" type="text" value="">
	                    <input type="hidden" id="ajaxMax" type="text" value="">
	                    <input type="hidden" id="ajaxSaveCore" type="text" value="">
	                    <input type="hidden" id="ajaxFastIoChk" type="text" value="">
	                    <input type="hidden" id="ajaxISeq" type="text" value="">
            		</td>
            	</tr>
            	</tbody>
            </table>
            </form>
            <table>
            	<tbody id="ioLisMod">
            	<tr>
            		<td style="display:none">
						<input type="hidden" id="hogiMod" type="text" value="">
						<input type="hidden" id="xyGubunMod" type="text" value="">
						<input type="hidden" id="DescrMod" type="text" value="">
						<input type="hidden" id="ioTypeMod" type="text" value="">
						<input type="hidden" id="addressMod" type="text" value="">
						<input type="hidden" id="ioBitMod" type="text" value="">
						<input type="hidden" id="minValMod" type="text" value="">
						<input type="hidden" id="maxValMod" type="text" value="">
						<input type="hidden" id="saveCoreMod" type="text" value="">
						<input type="hidden" id="gubunMod" type="text" value="">
						<input type="hidden" id="iSeqMod" type="text" value="">
					</td>
            	</tr>
            	</tbody>
            </table>
            <!-- //list_table -->
            <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" onclick="openModal('modal_3')">Tag Search</a>
                </div>
                <div class="button">
                    <a class="btn_list" id="cmdInsert" href="#none">추가</a>
                    <a class="btn_list" id="cmdUpdate" href="#none">수정</a>
                    <a class="btn_list" id="cmdDelete" href="#none">삭제</a>
                    <a class="btn_list" id="cmdUp" href="#none">위</a>
                    <a class="btn_list" id="cmdDown" href="#none">아래</a>
                </div>
            </div>
            </form>
            <!-- //list_bottom -->            
        </div>
        <!-- //list_wrap -->              
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" id="cmdOk" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="javascript:closeModal('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_3">
    <!-- header_wrap -->
<div class="pop_header">
   <h3>태그목록</h3>
        <a onclick="closeModal('modal_3');" title="Close"></a>
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
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="80px"/>
                    <col width="60px"/>
                    <col />
                    <col width="140px"/>
                    <col width="60px"/>
                    <col width="120px"/>
                </colgroup>
                <tr>
                    <th>호기</th>
	                <td>
	                    <select id="cboTagHogi">
	                        <option value="3">3</option>
	                        <option value="4">4</option>
	                    </select>                        
	                </td>
	                <td>
	                    <select id="cboTagIOType">
	                        <option value="All">전체</option>
	                        <option value="AI">AI</option>
	                        <option value="AO">AO</option>
	                        <option value="DI">DI</option>
	                        <option value="DO">DO</option>
	                        <option value="CI">CI</option>
	                        <option value="SC">SC</option>
	                        <option value="DT">DT</option>
	                    </select>                        
	                </td>
                    <th>검색어</th>
                    <td>
                        <div class="fx_form">
                          <input type="text" id="findData" name="findData">
                        </div>
                    </td>
                    <td>
	                   <div class="button">
	                   	<a class="btn_list" href="#none" id="tagFind" name="tagFind">검색</a>
	                   	<a class="btn_list" href="#none" id="tagFindAll" name="tagFindAll">Fast All</a>
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
                    <col />
                    <col width="60px"/>
                    <col width="80px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>LOOP NAME</th>
                        <th>DESCR</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody id="tagSearchList" name="tagSearchList">
                <tr>
	                <td class="tc" id="tagHogi"></td>
	                <td class="tc" id="tagXyGubun"></td>
	                <td class="tc" id="tagLoopName"></td>
	                <td class="tc" id="tagDescr"></td>
	                <td class="tc" id="tagIoType"></td>
	                <td class="tc" id="tagAddress"></td>
	                <td class="tc" id="tagIoBit"></td>
	                <td class="tc" id="tagMin"></td>
	                <td class="tc" id="tagMax"></td>
	                <td class="tc" id="tagSaveCore"></td>
                </tr>
                </tbody>
            </table>
            <!-- //list_table -->
             <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                </div>
                <div class="button">
                    <a href="#none" class="btn_page" id="tagSearchSelect" name="tagSearchSelect">선택</a>
        			<a href="#none" class="btn_page" onclick="closeModal('modal_3');">닫기</a>
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

