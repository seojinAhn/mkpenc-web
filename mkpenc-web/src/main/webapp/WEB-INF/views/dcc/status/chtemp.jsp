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
	var hogiHeader = '${UserInfo.hogi}' != "undefined" && '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
	var xyHeader = '${UserInfo.xyGubun}' != "undefined" && '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";
	var timerOn = false;
	var channelNoList = [
		147,333,145,335,143,337,
		181,363,180,364,118,253,63,368,174,370,173,371,
		151,329,149,331,179,365,177,367,175,363,141,339,139,341,
		152,328,150,330,148,332,146,211,21,336,142,338,140,340,138,342,
		153,362,111,289,109,291,107,293,105,295,103,297,101,299,99,301,172,343,
		326,182,283,110,290,108,292,106,366,176,296,102,298,100,300,98,372,136,
		286,183,327,71,247,69,249,67,251,65,255,61,257,59,259,57,261,137,373,96,
		113,275,112,245,70,248,68,250,66,334,144,256,60,258,58,260,56,302,55,31,
		31,244,30,297,29,205,27,207,25,209,23,213,19,215,17,217,15,219,97,220,54,221,
		202,73,203,72,204,28,205,26,209,24,294,104,214,18,216,16,218,14,262,13,263,154,
		154,361,184,325,114,285,74,243,32,201,64,254,11,222,53,254,95,304,135,374,171,344,
		324,185,360,155,284,115,242,75,200,33,252,62,223,10,255,52,305,94,345,170,375,134,
		156,359,186,323,116,283,76,241,34,199,22,212,9,224,51,266,93,306,133,376,169,346,
		322,187,353,157,282,117,240,77,198,35,210,20,225,8,267,50,307,92,347,168,377,132,
		321,183,357,153,281,118,239,75,197,36,226,7,268,49,308,91,348,167,378,131,
		159,356,189,320,119,280,79,238,37,196,6,227,40,269,90,309,130,379,166,349,
		150,319,160,279,120,237,80,195,38,228,5,270,47,310,83,350,129,380,
		355,161,318,121,278,81,236,39,194,4,229,46,271,88,311,128,351,165,
		317,162,277,122,235,62,193,40,230,3,272,45,312,87,352,127,
		316,123,276,83,234,41,192,2,231,44,273,86,313,126,
		354,163,315,124,275,84,274,85,314,125,353,164,
		233,42,191,1,232,43
	];
	var dataAddressList = [
		'${DccTagInfoList[0].ADDRESS}','${DccTagInfoList[1].ADDRESS}','${DccTagInfoList[2].ADDRESS}','${DccTagInfoList[3].ADDRESS}','${DccTagInfoList[4].ADDRESS}','${DccTagInfoList[5].ADDRESS}',
		'${DccTagInfoList[6].ADDRESS}','${DccTagInfoList[7].ADDRESS}','${DccTagInfoList[8].ADDRESS}','${DccTagInfoList[9].ADDRESS}','${DccTagInfoList[10].ADDRESS}','${DccTagInfoList[11].ADDRESS}','${DccTagInfoList[12].ADDRESS}','${DccTagInfoList[13].ADDRESS}','${DccTagInfoList[14].ADDRESS}','${DccTagInfoList[15].ADDRESS}','${DccTagInfoList[16].ADDRESS}','${DccTagInfoList[17].ADDRESS}',
		'${DccTagInfoList[18].ADDRESS}','${DccTagInfoList[19].ADDRESS}','${DccTagInfoList[20].ADDRESS}','${DccTagInfoList[21].ADDRESS}','${DccTagInfoList[22].ADDRESS}','${DccTagInfoList[23].ADDRESS}','${DccTagInfoList[24].ADDRESS}','${DccTagInfoList[25].ADDRESS}','${DccTagInfoList[26].ADDRESS}','${DccTagInfoList[27].ADDRESS}','${DccTagInfoList[28].ADDRESS}','${DccTagInfoList[29].ADDRESS}','${DccTagInfoList[30].ADDRESS}','${DccTagInfoList[31].ADDRESS}',
		'${DccTagInfoList[32].ADDRESS}','${DccTagInfoList[33].ADDRESS}','${DccTagInfoList[34].ADDRESS}','${DccTagInfoList[35].ADDRESS}','${DccTagInfoList[36].ADDRESS}','${DccTagInfoList[37].ADDRESS}','${DccTagInfoList[38].ADDRESS}','${DccTagInfoList[39].ADDRESS}','${DccTagInfoList[40].ADDRESS}','${DccTagInfoList[41].ADDRESS}','${DccTagInfoList[42].ADDRESS}','${DccTagInfoList[43].ADDRESS}','${DccTagInfoList[44].ADDRESS}','${DccTagInfoList[45].ADDRESS}','${DccTagInfoList[46].ADDRESS}','${DccTagInfoList[47].ADDRESS}',
		'${DccTagInfoList[48].ADDRESS}','${DccTagInfoList[49].ADDRESS}','${DccTagInfoList[50].ADDRESS}','${DccTagInfoList[51].ADDRESS}','${DccTagInfoList[52].ADDRESS}','${DccTagInfoList[53].ADDRESS}','${DccTagInfoList[54].ADDRESS}','${DccTagInfoList[55].ADDRESS}','${DccTagInfoList[56].ADDRESS}','${DccTagInfoList[57].ADDRESS}','${DccTagInfoList[58].ADDRESS}','${DccTagInfoList[59].ADDRESS}','${DccTagInfoList[60].ADDRESS}','${DccTagInfoList[61].ADDRESS}','${DccTagInfoList[62].ADDRESS}','${DccTagInfoList[63].ADDRESS}','${DccTagInfoList[64].ADDRESS}','${DccTagInfoList[65].ADDRESS}',
		'${DccTagInfoList[66].ADDRESS}','${DccTagInfoList[67].ADDRESS}','${DccTagInfoList[68].ADDRESS}','${DccTagInfoList[69].ADDRESS}','${DccTagInfoList[70].ADDRESS}','${DccTagInfoList[71].ADDRESS}','${DccTagInfoList[72].ADDRESS}','${DccTagInfoList[73].ADDRESS}','${DccTagInfoList[74].ADDRESS}','${DccTagInfoList[75].ADDRESS}','${DccTagInfoList[76].ADDRESS}','${DccTagInfoList[77].ADDRESS}','${DccTagInfoList[78].ADDRESS}','${DccTagInfoList[79].ADDRESS}','${DccTagInfoList[80].ADDRESS}','${DccTagInfoList[81].ADDRESS}','${DccTagInfoList[82].ADDRESS}','${DccTagInfoList[83].ADDRESS}',
		'${DccTagInfoList[84].ADDRESS}','${DccTagInfoList[85].ADDRESS}','${DccTagInfoList[86].ADDRESS}','${DccTagInfoList[87].ADDRESS}','${DccTagInfoList[88].ADDRESS}','${DccTagInfoList[89].ADDRESS}','${DccTagInfoList[90].ADDRESS}','${DccTagInfoList[91].ADDRESS}','${DccTagInfoList[92].ADDRESS}','${DccTagInfoList[93].ADDRESS}','${DccTagInfoList[94].ADDRESS}','${DccTagInfoList[95].ADDRESS}','${DccTagInfoList[96].ADDRESS}','${DccTagInfoList[97].ADDRESS}','${DccTagInfoList[98].ADDRESS}','${DccTagInfoList[99].ADDRESS}','${DccTagInfoList[100].ADDRESS}','${DccTagInfoList[101].ADDRESS}','${DccTagInfoList[102].ADDRESS}','${DccTagInfoList[103].ADDRESS}',
		'${DccTagInfoList[104].ADDRESS}','${DccTagInfoList[105].ADDRESS}','${DccTagInfoList[106].ADDRESS}','${DccTagInfoList[107].ADDRESS}','${DccTagInfoList[108].ADDRESS}','${DccTagInfoList[109].ADDRESS}','${DccTagInfoList[110].ADDRESS}','${DccTagInfoList[111].ADDRESS}','${DccTagInfoList[112].ADDRESS}','${DccTagInfoList[113].ADDRESS}','${DccTagInfoList[114].ADDRESS}','${DccTagInfoList[115].ADDRESS}','${DccTagInfoList[116].ADDRESS}','${DccTagInfoList[117].ADDRESS}','${DccTagInfoList[118].ADDRESS}','${DccTagInfoList[119].ADDRESS}','${DccTagInfoList[120].ADDRESS}','${DccTagInfoList[121].ADDRESS}','${DccTagInfoList[122].ADDRESS}','${DccTagInfoList[123].ADDRESS}',
		'${DccTagInfoList[124].ADDRESS}','${DccTagInfoList[125].ADDRESS}','${DccTagInfoList[126].ADDRESS}','${DccTagInfoList[127].ADDRESS}','${DccTagInfoList[128].ADDRESS}','${DccTagInfoList[129].ADDRESS}','${DccTagInfoList[130].ADDRESS}','${DccTagInfoList[131].ADDRESS}','${DccTagInfoList[132].ADDRESS}','${DccTagInfoList[133].ADDRESS}','${DccTagInfoList[134].ADDRESS}','${DccTagInfoList[135].ADDRESS}','${DccTagInfoList[136].ADDRESS}','${DccTagInfoList[137].ADDRESS}','${DccTagInfoList[138].ADDRESS}','${DccTagInfoList[139].ADDRESS}','${DccTagInfoList[140].ADDRESS}','${DccTagInfoList[141].ADDRESS}','${DccTagInfoList[142].ADDRESS}','${DccTagInfoList[143].ADDRESS}','${DccTagInfoList[144].ADDRESS}','${DccTagInfoList[145].ADDRESS}',
		'${DccTagInfoList[146].ADDRESS}','${DccTagInfoList[147].ADDRESS}','${DccTagInfoList[148].ADDRESS}','${DccTagInfoList[149].ADDRESS}','${DccTagInfoList[150].ADDRESS}','${DccTagInfoList[151].ADDRESS}','${DccTagInfoList[152].ADDRESS}','${DccTagInfoList[153].ADDRESS}','${DccTagInfoList[154].ADDRESS}','${DccTagInfoList[155].ADDRESS}','${DccTagInfoList[156].ADDRESS}','${DccTagInfoList[157].ADDRESS}','${DccTagInfoList[158].ADDRESS}','${DccTagInfoList[159].ADDRESS}','${DccTagInfoList[160].ADDRESS}','${DccTagInfoList[161].ADDRESS}','${DccTagInfoList[162].ADDRESS}','${DccTagInfoList[163].ADDRESS}','${DccTagInfoList[164].ADDRESS}','${DccTagInfoList[165].ADDRESS}','${DccTagInfoList[166].ADDRESS}','${DccTagInfoList[167].ADDRESS}',
		'${DccTagInfoList[168].ADDRESS}','${DccTagInfoList[169].ADDRESS}','${DccTagInfoList[170].ADDRESS}','${DccTagInfoList[171].ADDRESS}','${DccTagInfoList[172].ADDRESS}','${DccTagInfoList[173].ADDRESS}','${DccTagInfoList[174].ADDRESS}','${DccTagInfoList[175].ADDRESS}','${DccTagInfoList[176].ADDRESS}','${DccTagInfoList[177].ADDRESS}','${DccTagInfoList[178].ADDRESS}','${DccTagInfoList[179].ADDRESS}','${DccTagInfoList[180].ADDRESS}','${DccTagInfoList[181].ADDRESS}','${DccTagInfoList[182].ADDRESS}','${DccTagInfoList[183].ADDRESS}','${DccTagInfoList[184].ADDRESS}','${DccTagInfoList[185].ADDRESS}','${DccTagInfoList[186].ADDRESS}','${DccTagInfoList[187].ADDRESS}','${DccTagInfoList[188].ADDRESS}','${DccTagInfoList[189].ADDRESS}',
		'${DccTagInfoList[190].ADDRESS}','${DccTagInfoList[191].ADDRESS}','${DccTagInfoList[192].ADDRESS}','${DccTagInfoList[193].ADDRESS}','${DccTagInfoList[194].ADDRESS}','${DccTagInfoList[195].ADDRESS}','${DccTagInfoList[196].ADDRESS}','${DccTagInfoList[197].ADDRESS}','${DccTagInfoList[198].ADDRESS}','${DccTagInfoList[199].ADDRESS}','${DccTagInfoList[200].ADDRESS}','${DccTagInfoList[201].ADDRESS}','${DccTagInfoList[202].ADDRESS}','${DccTagInfoList[203].ADDRESS}','${DccTagInfoList[204].ADDRESS}','${DccTagInfoList[205].ADDRESS}','${DccTagInfoList[206].ADDRESS}','${DccTagInfoList[207].ADDRESS}','${DccTagInfoList[208].ADDRESS}','${DccTagInfoList[209].ADDRESS}','${DccTagInfoList[210].ADDRESS}','${DccTagInfoList[211].ADDRESS}',
		'${DccTagInfoList[212].ADDRESS}','${DccTagInfoList[213].ADDRESS}','${DccTagInfoList[214].ADDRESS}','${DccTagInfoList[215].ADDRESS}','${DccTagInfoList[216].ADDRESS}','${DccTagInfoList[217].ADDRESS}','${DccTagInfoList[218].ADDRESS}','${DccTagInfoList[219].ADDRESS}','${DccTagInfoList[220].ADDRESS}','${DccTagInfoList[221].ADDRESS}','${DccTagInfoList[222].ADDRESS}','${DccTagInfoList[223].ADDRESS}','${DccTagInfoList[224].ADDRESS}','${DccTagInfoList[225].ADDRESS}','${DccTagInfoList[226].ADDRESS}','${DccTagInfoList[227].ADDRESS}','${DccTagInfoList[228].ADDRESS}','${DccTagInfoList[229].ADDRESS}','${DccTagInfoList[230].ADDRESS}','${DccTagInfoList[231].ADDRESS}','${DccTagInfoList[232].ADDRESS}','${DccTagInfoList[233].ADDRESS}',
		'${DccTagInfoList[234].ADDRESS}','${DccTagInfoList[235].ADDRESS}','${DccTagInfoList[236].ADDRESS}','${DccTagInfoList[237].ADDRESS}','${DccTagInfoList[238].ADDRESS}','${DccTagInfoList[239].ADDRESS}','${DccTagInfoList[240].ADDRESS}','${DccTagInfoList[241].ADDRESS}','${DccTagInfoList[242].ADDRESS}','${DccTagInfoList[243].ADDRESS}','${DccTagInfoList[244].ADDRESS}','${DccTagInfoList[245].ADDRESS}','${DccTagInfoList[246].ADDRESS}','${DccTagInfoList[247].ADDRESS}','${DccTagInfoList[248].ADDRESS}','${DccTagInfoList[249].ADDRESS}','${DccTagInfoList[250].ADDRESS}','${DccTagInfoList[251].ADDRESS}','${DccTagInfoList[252].ADDRESS}','${DccTagInfoList[253].ADDRESS}','${DccTagInfoList[254].ADDRESS}','${DccTagInfoList[255].ADDRESS}',
		'${DccTagInfoList[256].ADDRESS}','${DccTagInfoList[257].ADDRESS}','${DccTagInfoList[258].ADDRESS}','${DccTagInfoList[259].ADDRESS}','${DccTagInfoList[260].ADDRESS}','${DccTagInfoList[261].ADDRESS}','${DccTagInfoList[262].ADDRESS}','${DccTagInfoList[263].ADDRESS}','${DccTagInfoList[264].ADDRESS}','${DccTagInfoList[265].ADDRESS}','${DccTagInfoList[266].ADDRESS}','${DccTagInfoList[267].ADDRESS}','${DccTagInfoList[268].ADDRESS}','${DccTagInfoList[269].ADDRESS}','${DccTagInfoList[270].ADDRESS}','${DccTagInfoList[271].ADDRESS}','${DccTagInfoList[272].ADDRESS}','${DccTagInfoList[273].ADDRESS}','${DccTagInfoList[274].ADDRESS}','${DccTagInfoList[275].ADDRESS}',
		'${DccTagInfoList[276].ADDRESS}','${DccTagInfoList[277].ADDRESS}','${DccTagInfoList[278].ADDRESS}','${DccTagInfoList[279].ADDRESS}','${DccTagInfoList[280].ADDRESS}','${DccTagInfoList[281].ADDRESS}','${DccTagInfoList[282].ADDRESS}','${DccTagInfoList[283].ADDRESS}','${DccTagInfoList[284].ADDRESS}','${DccTagInfoList[285].ADDRESS}','${DccTagInfoList[286].ADDRESS}','${DccTagInfoList[287].ADDRESS}','${DccTagInfoList[288].ADDRESS}','${DccTagInfoList[289].ADDRESS}','${DccTagInfoList[290].ADDRESS}','${DccTagInfoList[291].ADDRESS}','${DccTagInfoList[292].ADDRESS}','${DccTagInfoList[293].ADDRESS}','${DccTagInfoList[294].ADDRESS}','${DccTagInfoList[295].ADDRESS}',
		'${DccTagInfoList[296].ADDRESS}','${DccTagInfoList[297].ADDRESS}','${DccTagInfoList[298].ADDRESS}','${DccTagInfoList[299].ADDRESS}','${DccTagInfoList[300].ADDRESS}','${DccTagInfoList[301].ADDRESS}','${DccTagInfoList[302].ADDRESS}','${DccTagInfoList[303].ADDRESS}','${DccTagInfoList[304].ADDRESS}','${DccTagInfoList[305].ADDRESS}','${DccTagInfoList[306].ADDRESS}','${DccTagInfoList[307].ADDRESS}','${DccTagInfoList[308].ADDRESS}','${DccTagInfoList[309].ADDRESS}','${DccTagInfoList[310].ADDRESS}','${DccTagInfoList[311].ADDRESS}','${DccTagInfoList[312].ADDRESS}','${DccTagInfoList[313].ADDRESS}',
		'${DccTagInfoList[314].ADDRESS}','${DccTagInfoList[315].ADDRESS}','${DccTagInfoList[316].ADDRESS}','${DccTagInfoList[317].ADDRESS}','${DccTagInfoList[318].ADDRESS}','${DccTagInfoList[319].ADDRESS}','${DccTagInfoList[320].ADDRESS}','${DccTagInfoList[321].ADDRESS}','${DccTagInfoList[322].ADDRESS}','${DccTagInfoList[323].ADDRESS}','${DccTagInfoList[324].ADDRESS}','${DccTagInfoList[325].ADDRESS}','${DccTagInfoList[326].ADDRESS}','${DccTagInfoList[327].ADDRESS}','${DccTagInfoList[328].ADDRESS}','${DccTagInfoList[329].ADDRESS}','${DccTagInfoList[330].ADDRESS}','${DccTagInfoList[331].ADDRESS}',
		'${DccTagInfoList[332].ADDRESS}','${DccTagInfoList[333].ADDRESS}','${DccTagInfoList[334].ADDRESS}','${DccTagInfoList[335].ADDRESS}','${DccTagInfoList[336].ADDRESS}','${DccTagInfoList[337].ADDRESS}','${DccTagInfoList[338].ADDRESS}','${DccTagInfoList[339].ADDRESS}','${DccTagInfoList[340].ADDRESS}','${DccTagInfoList[341].ADDRESS}','${DccTagInfoList[342].ADDRESS}','${DccTagInfoList[343].ADDRESS}','${DccTagInfoList[344].ADDRESS}','${DccTagInfoList[345].ADDRESS}','${DccTagInfoList[346].ADDRESS}','${DccTagInfoList[347].ADDRESS}',
		'${DccTagInfoList[348].ADDRESS}','${DccTagInfoList[349].ADDRESS}','${DccTagInfoList[350].ADDRESS}','${DccTagInfoList[351].ADDRESS}','${DccTagInfoList[352].ADDRESS}','${DccTagInfoList[353].ADDRESS}','${DccTagInfoList[354].ADDRESS}','${DccTagInfoList[355].ADDRESS}','${DccTagInfoList[356].ADDRESS}','${DccTagInfoList[357].ADDRESS}','${DccTagInfoList[358].ADDRESS}','${DccTagInfoList[359].ADDRESS}','${DccTagInfoList[360].ADDRESS}','${DccTagInfoList[361].ADDRESS}',
		'${DccTagInfoList[362].ADDRESS}','${DccTagInfoList[363].ADDRESS}','${DccTagInfoList[364].ADDRESS}','${DccTagInfoList[365].ADDRESS}','${DccTagInfoList[366].ADDRESS}','${DccTagInfoList[367].ADDRESS}','${DccTagInfoList[368].ADDRESS}','${DccTagInfoList[369].ADDRESS}','${DccTagInfoList[370].ADDRESS}','${DccTagInfoList[371].ADDRESS}','${DccTagInfoList[372].ADDRESS}','${DccTagInfoList[373].ADDRESS}',
		'${DccTagInfoList[374].ADDRESS}','${DccTagInfoList[375].ADDRESS}','${DccTagInfoList[376].ADDRESS}','${DccTagInfoList[377].ADDRESS}','${DccTagInfoList[378].ADDRESS}','${DccTagInfoList[379].ADDRESS}'
	];
	var lblDataListAjax = {};
	var dccGrpTagListAjax = {};
	var gfAvg = 0;
	var gfTPMAvg = 0;
	var bMode = true;
	var bView = false;
	
	$(function() {
		$(document.body).delegate('#optModeA','click',function() {
			bMode = true;
			gfAvg = gfTPMAvg;
			setColor();
		});
		
		$(document.body).delegate('#optModeM','click',function() {
			bMode = false;
		});
		
		$(document.body).delegate('#optViewAI','click',function() {
			bView = true;
			setDataAddress();
		});
		
		$(document.body).delegate('#optViewINST','click',function() {
			bView = false;
			setChannelNo();
		});
		
		var timer =0;
		
		timer = setInterval(function () {
	 				
			// 화면초기화
			var comAjax = new ComAjax("safeVarSearch");
			comAjax.setUrl("/dcc/status/reloadTpm");
			comAjax.addParam("hogi",$("input:radio[id='4']").is(":checked") ? '4' : '3');
			comAjax.addParam("xyGubun",$("input:radio[id='Y']").is(":checked") ? 'Y' : 'X');
			comAjax.addParam("menuNo",'11');
			comAjax.addParam("grpNo",'14');
			comAjax.addParam("grpId",'mimic');
			comAjax.setCallback("mbr_statusCallback");
			comAjax.ajax();
			
			setColor();
			
		}, 5000);
		
		calAvg(-32768);
		setLblDate('','');
		setChannelNo();
		setColor();
	});
	
	function setChannelNo() {
		for( var i=0;i<380;i++ ) {
			$("#lblChannelNo"+i).text(channelNoList[i]+"");
		}
	}
	
	function setDataAddress(type) {
		if( type != 0 ) {
			for( var i=0;i<380;i++ ) {
				$("#lblChannelNo"+i).text(dataAddressList[i]+"");
			}
		} else {
			for( var i=0;i<380;i++ ) {
				$("#lblChannelNo"+i).text(dccGrpTagListAjax[i].ADDRESS);
			}
		}
	}
	
	function setLblDataAjax(type) {
		if( type == 0 ) {
			for( var i=0;i<380;i++ ) {
				$("#lblData"+i).text(lblDataListAjax[i].fValue);
			}
		}
	}
	
	function calAvg(avgAjax) {
		if( avgAjax == -32768 ) {
			var nCnt = 0;
			var fTotal = 0;
			
			for( var i=0;i<380;i++ ) {
				var tmp = $("#lblData"+i).text()*1;
				
				if( tmp != -32768 && !isNaN(tmp) ) {
					nCnt++;
					fTotal += tmp;
				}
			}

			gfTPMAvg = fTotal/nCnt;
		} else {
			gfTPMAvg = avgAjax;
		}
		
		$("#lblAvg").text(Math.round(gfTPMAvg*10000)/10000);
		
		if( bMode ) {
			gfAvg = gfTPMAvg;
		}
	}
	
	function setColor() {
		var fAvg = gfAvg;
		
		for( var i=0;i<380;i++ ) {
			var tmp = $("#lblData"+i).text();
			if( tmp == '' || tmp == '***IRR' ) {
				$("#Label"+i).css("background-color","#000000");
				$("#lblChannelNo"+i).css("color","#ffffff");
				$("#lblData"+i).css("color","#ffffff");
			} else {
				if( tmp != '***IRR' ) {
					$("#lblChannelNo"+i).css("color","#000000");
					$("#lblData"+i).css("color","#000000");
					
					var diff = tmp*1 - fAvg;
					if( diff > 3 ) {
						$("#Label"+i).attr("class","bg_r");
					} else if( diff < -3 ) {
						$("#Label"+i).attr("class","bg_g");
					} else {
						$("#Label"+i).attr("class","bg_y");
					}
				}
			}
		}
	}
	
	function setLblDate(time,color) {
		if( time == '' ) {
			time = '${SearchTime}';
			color = '${ForeColor}';
		}
		
		$("#lblDate").text(time);
		$("#lblDate").css('color',color);
	}
	
	function toCSV() {
		var comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl('/dcc/status/chtempExcelExport');
		comSubmit.addParam("hogi",hogiHeader);
		comSubmit.addParam("xyGubun",xyHeader);
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
				<h3>REACTOR CHANNEL TEMPERATURE MONITORING</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>REACTOR CHANNEL TEMPERATURE MONITORING</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div id="frmAvg" class="fx_srch_item">
							<label>AVG</label>
                            <div class="fx_form">
                                <label id="lblAvg">300.7248</label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>MODE</label>
                            <div class="fx_form">
                                <label>
                                    <input id="optModeA" type="radio" name="mode" checked>
                                    Auto
                                </label>
                                <label>
                                    <input id="optModeM" type="radio" name="mode">
                                    Manual
                                </label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>VIEW</label>
                            <div class="fx_form">
                                <label>
                                    <input id="optViewAI" type="radio" name="view">
                                    AI
                                </label>
                                <label>
                                    <input id="optViewINST" type="radio" name="view" checked>
                                    Instrument
                                </label>
                            </div>
						</div>
                    </div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->
            <!-- list_wrap -->
            <div class="list_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="javascript:toCSV();">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                     
                <!-- ch_temp_box -->
                <div class="ch_temp_box">
                    <ul>
                        <li></li>
                        <li>1</li>
                        <li>2</li>
                        <li>3</li>
                        <li>4</li>
                        <li>5</li>
                        <li>6</li>
                        <li>7</li>
                        <li>8</li>
                        <li>9</li>
                        <li>10</li>
                        <li>11</li>
                        <li>12</li>
                        <li>13</li>
                        <li>14</li>
                        <li>15</li>
                        <li>16</li>
                        <li>17</li>
                        <li>18</li>
                        <li>19</li>
                        <li>20</li>
                        <li>21</li>
                        <li>22</li>
                        <li></li>
                    </ul>
                    <ul>
                        <li>A</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li id="Label0" class="bg_y">
                            <span><label id="lblChannelNo0">147</label></span>
                            <span><label id="lblData0">${lblDataList[0].fValue}</label></span>
                        </li>
                        <li id="Label1" class="bg_y">
                            <span><label id="lblChannelNo1">333</label></span>
                            <span><label id="lblData1">${lblDataList[1].fValue}</label></span>
                        </li>
                        <li id="Label2" class="bg_y">
                            <span><label id="lblChannelNo2">145</label></span>
                            <span><label id="lblData2">${lblDataList[2].fValue}</label></span>
                        </li>
                        <li id="Label3" class="bg_y">
                            <span><label id="lblChannelNo3">143</label></span>
                            <span><label id="lblData3">${lblDataList[3].fValue}</label></span>
                        </li>
                        <li id="Label4" class="bg_y">
                            <span><label id="lblChannelNo4">337</label></span>
                            <span><label id="lblData4">${lblDataList[4].fValue}</label></span>
                        </li>
                        <li id="Label5" class="bg_r">
                            <span><label id="lblChannelNo5">147</label></span>
                            <span><label id="lblData5">${lblDataList[5].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>A</li>
                    </ul>
                    <ul>
                        <li>B</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li id="Label6" class="bg_y">
                            <span><label id="lblChannelNo6">181</label></span>
                            <span><label id="lblData6">${lblDataList[6].fValue}</label></span>
                        </li>
                        <li id="Label7" class="bg_y">
                            <span><label id="lblChannelNo7">363</label></span>
                            <span><label id="lblData7">${lblDataList[7].fValue}</label></span>
                        </li>
                        <li id="Label8" class="bg_y">
                            <span><label id="lblChannelNo8">180</label></span>
                            <span><label id="lblData8">${lblDataList[8].fValue}</label></span>
                        </li>
                        <li id="Label9" class="bg_y">
                            <span><label id="lblChannelNo9">364</label></span>
                            <span><label id="lblData9">${lblDataList[9].fValue}</label></span>
                        </li>
                        <li id="Label10" class="bg_y">
                            <span><label id="lblChannelNo10">118</label></span>
                            <span><label id="lblData10">${lblDataList[10].fValue}</label></span>
                        </li>
                        <li id="Label11" class="bg_y">
                            <span><label id="lblChannelNo11">253</label></span>
                            <span><label id="lblData11">${lblDataList[11].fValue}</label></span>
                        </li>
                        <li id="Label12" class="bg_y">
                            <span><label id="lblChannelNo12">63</label></span>
                            <span><label id="lblData12">${lblDataList[12].fValue}</label></span>
                        </li>
                        <li id="Label13" class="bg_y">
                            <span><label id="lblChannelNo13">147</label></span>
                            <span><label id="lblData13">${lblDataList[13].fValue}</label></span>
                        </li>
                        <li id="Label14" class="bg_y">
                            <span><label id="lblChannelNo14">147</label></span>
                            <span><label id="lblData14">${lblDataList[14].fValue}</label></span>
                        </li>
                        <li id="Label15" class="bg_y">
                            <span><label id="lblChannelNo15">147</label></span>
                            <span><label id="lblData15">${lblDataList[15].fValue}</label></span>
                        </li>
                        <li id="Label16" class="bg_y">
                            <span><label id="lblChannelNo16">147</label></span>
                            <span><label id="lblData16">${lblDataList[16].fValue}</label></span>
                        </li>
                        <li id="Label17" class="bg_y">
                            <span><label id="lblChannelNo17">147</label></span>
                            <span><label id="lblData17">${lblDataList[17].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>B</li>
                    </ul>
                    <ul>
                        <li>C</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li id="Label18" class="bg_y">
                            <span><label id="lblChannelNo18">147</label></span>
                            <span><label id="lblData18">${lblDataList[18].fValue}</label></span>
                        </li>
                        <li id="Label19" class="bg_y">
                            <span><label id="lblChannelNo19">147</label></span>
                            <span><label id="lblData19">${lblDataList[19].fValue}</label></span>
                        </li>
                        <li id="Label20" class="bg_y">
                            <span><label id="lblChannelNo20">147</label></span>
                            <span><label id="lblData20">${lblDataList[20].fValue}</label></span>
                        </li>
                        <li id="Label21" class="bg_y">
                            <span><label id="lblChannelNo21">147</label></span>
                            <span><label id="lblData21">${lblDataList[21].fValue}</label></span>
                        </li>
                        <li id="Label22" class="bg_y">
                            <span><label id="lblChannelNo22">147</label></span>
                            <span><label id="lblData22">${lblDataList[22].fValue}</label></span>
                        </li>
                        <li id="Label23" class="bg_y">
                            <span><label id="lblChannelNo23">147</label></span>
                            <span><label id="lblData23">${lblDataList[23].fValue}</label></span>
                        </li>
                        <li id="Label24" class="bg_y">
                            <span><label id="lblChannelNo24">147</label></span>
                            <span><label id="lblData24">${lblDataList[24].fValue}</label></span>
                        </li>
                        <li id="Label25" class="bg_y">
                            <span><label id="lblChannelNo25">147</label></span>
                            <span><label id="lblData25">${lblDataList[25].fValue}</label></span>
                        </li>
                        <li id="Label26" class="bg_y">
                            <span><label id="lblChannelNo26">147</label></span>
                            <span><label id="lblData26">${lblDataList[26].fValue}</label></span>
                        </li>
                        <li id="Label27" class="bg_y">
                            <span><label id="lblChannelNo27">147</label></span>
                            <span><label id="lblData27">${lblDataList[27].fValue}</label></span>
                        </li>
                        <li id="Label28" class="bg_y">
                            <span><label id="lblChannelNo28">147</label></span>
                            <span><label id="lblData28">${lblDataList[28].fValue}</label></span>
                        </li>
                        <li id="Label29" class="bg_r">
                            <span><label id="lblChannelNo29">147</label></span>
                            <span><label id="lblData29">${lblDataList[29].fValue}</label></span>
                        </li>
                        <li id="Label30" class="bg_r">
                            <span><label id="lblChannelNo30">147</label></span>
                            <span><label id="lblData30">${lblDataList[30].fValue}</label></span>
                        </li>
                        <li id="Label31" class="bg_y">
                            <span><label id="lblChannelNo31">147</label></span>
                            <span><label id="lblData31">${lblDataList[31].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>C</li>
                    </ul>
                    <ul>
                        <li>D</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li id="Label32" class="bg_y">
                            <span><label id="lblChannelNo32">147</label></span>
                            <span><label id="lblData32">${lblDataList[32].fValue}</label></span>
                        </li>
                        <li id="Label33" class="bg_r">
                            <span><label id="lblChannelNo33">147</label></span>
                            <span><label id="lblData33">${lblDataList[33].fValue}</label></span>
                        </li>
                        <li id="Label34" class="bg_r">
                            <span><label id="lblChannelNo34">147</label></span>
                            <span><label id="lblData34">${lblDataList[34].fValue}</label></span>
                        </li>
                        <li id="Label35" class="bg_y">
                            <span><label id="lblChannelNo35">147</label></span>
                            <span><label id="lblData35">${lblDataList[35].fValue}</label></span>
                        </li>
                        <li id="Label36" class="bg_g">
                            <span><label id="lblChannelNo36">147</label></span>
                            <span><label id="lblData36">${lblDataList[36].fValue}</label></span>
                        </li>
                        <li id="Label37" class="bg_y">
                            <span><label id="lblChannelNo37">147</label></span>
                            <span><label id="lblData37">${lblDataList[37].fValue}</label></span>
                        </li>
                        <li id="Label38" class="bg_y">
                            <span><label id="lblChannelNo38">147</label></span>
                            <span><label id="lblData38">${lblDataList[38].fValue}</label></span>
                        </li>
                        <li id="Label39" class="bg_g">
                            <span><label id="lblChannelNo39">147</label></span>
                            <span><label id="lblData39">${lblDataList[39].fValue}</label></span>
                        </li>
                        <li id="Label40" class="bg_g">
                            <span><label id="lblChannelNo40">147</label></span>
                            <span><label id="lblData40">${lblDataList[40].fValue}</label></span>
                        </li>
                        <li id="Label41" class="bg_y">
                            <span><label id="lblChannelNo41">147</label></span>
                            <span><label id="lblData41">${lblDataList[41].fValue}</label></span>
                        </li>
                        <li id="Label42" class="bg_y">
                            <span><label id="lblChannelNo42">147</label></span>
                            <span><label id="lblData42">${lblDataList[42].fValue}</label></span>
                        </li>
                        <li id="Label43" class="bg_y">
                            <span><label id="lblChannelNo43">147</label></span>
                            <span><label id="lblData43">${lblDataList[43].fValue}</label></span>
                        </li>
                        <li id="Label44" class="bg_r">
                            <span><label id="lblChannelNo44">147</label></span>
                            <span><label id="lblData44">${lblDataList[44].fValue}</label></span>
                        </li>
                        <li id="Label45" class="bg_r">
                            <span><label id="lblChannelNo45">147</label></span>
                            <span><label id="lblData45">${lblDataList[45].fValue}</label></span>
                        </li>
                        <li id="Label46" class="bg_y">
                            <span><label id="lblChannelNo46">147</label></span>
                            <span><label id="lblData46">${lblDataList[46].fValue}</label></span>
                        </li>
                        <li id="Label47" class="bg_y">
                            <span><label id="lblChannelNo47">147</label></span>
                            <span><label id="lblData47">${lblDataList[47].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>D</li>
                    </ul>
                    <ul>
                        <li>E</li>
                        <li></li>
                        <li></li>
                        <li id="Label48" class="bg_y">
                            <span><label id="lblChannelNo48">147</label></span>
                            <span><label id="lblData48">${lblDataList[48].fValue}</label></span>
                        </li>
                        <li id="Label49" class="bg_y">
                            <span><label id="lblChannelNo49">147</label></span>
                            <span><label id="lblData49">${lblDataList[49].fValue}</label></span>
                        </li>
                        <li id="Label50" class="bg_r">
                            <span><label id="lblChannelNo50">147</label></span>
                            <span><label id="lblData50">${lblDataList[50].fValue}</label></span>
                        </li>
                        <li id="Label51" class="bg_r">
                            <span><label id="lblChannelNo51">147</label></span>
                            <span><label id="lblData51">${lblDataList[51].fValue}</label></span>
                        </li>
                        <li id="Label52" class="bg_y">
                            <span><label id="lblChannelNo52">147</label></span>
                            <span><label id="lblData52">${lblDataList[52].fValue}</label></span>
                        </li>
                        <li id="Label53" class="bg_g">
                            <span><label id="lblChannelNo53">147</label></span>
                            <span><label id="lblData53">${lblDataList[53].fValue}</label></span>
                        </li>
                        <li id="Label54" class="bg_y">
                            <span><label id="lblChannelNo54">147</label></span>
                            <span><label id="lblData54">${lblDataList[54].fValue}</label></span>
                        </li>
                        <li id="Label55" class="bg_y">
                            <span><label id="lblChannelNo55">147</label></span>
                            <span><label id="lblData55">${lblDataList[55].fValue}</label></span>
                        </li>
                        <li id="Label56" class="bg_y">
                            <span><label id="lblChannelNo56">147</label></span>
                            <span><label id="lblData56">${lblDataList[56].fValue}</label></span>
                        </li>
                        <li id="Label57" class="bg_g">
                            <span><label id="lblChannelNo57">147</label></span>
                            <span><label id="lblData57">${lblDataList[57].fValue}</label></span>
                        </li>
                        <li id="Label58" class="bg_y">
                            <span><label id="lblChannelNo58">147</label></span>
                            <span><label id="lblData58">${lblDataList[58].fValue}</label></span>
                        </li>
                        <li id="Label59" class="bg_y">
                            <span><label id="lblChannelNo59">147</label></span>
                            <span><label id="lblData59">${lblDataList[59].fValue}</label></span>
                        </li>
                        <li id="Label60" class="bg_y">
                            <span><label id="lblChannelNo60">147</label></span>
                            <span><label id="lblData60">${lblDataList[60].fValue}</label></span>
                        </li>
                        <li id="Label61" class="bg_y">
                            <span><label id="lblChannelNo61">147</label></span>
                            <span><label id="lblData61">${lblDataList[61].fValue}</label></span>
                        </li>
                        <li id="Label62" class="bg_r">
                            <span><label id="lblChannelNo62">147</label></span>
                            <span><label id="lblData62">${lblDataList[62].fValue}</label></span>
                        </li>
                        <li id="Label63" class="bg_r">
                            <span><label id="lblChannelNo63">147</label></span>
                            <span><label id="lblData63">${lblDataList[63].fValue}</label></span>
                        </li>
                        <li id="Label64" class="bg_y">
                            <span><label id="lblChannelNo64">147</label></span>
                            <span><label id="lblData64">${lblDataList[64].fValue}</label></span>
                        </li>
                        <li id="Label65" class="bg_y">
                            <span><label id="lblChannelNo65">147</label></span>
                            <span><label id="lblData65">${lblDataList[65].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li>E</li>
                    </ul>
                    <ul>
                        <li>F</li>
                        <li></li>
                        <li></li>
                        <li id="Label66" class="bg_y">
                            <span><label id="lblChannelNo66">147</label></span>
                            <span><label id="lblData66">${lblDataList[66].fValue}</label></span>
                        </li>
                        <li id="Label67" class="bg_y">
                            <span><label id="lblChannelNo67">147</label></span>
                            <span><label id="lblData67">${lblDataList[67].fValue}</label></span>
                        </li>
                        <li id="Label68" class="bg_y">
                            <span><label id="lblChannelNo68">147</label></span>
                            <span><label id="lblData68">${lblDataList[68].fValue}</label></span>
                        </li>
                        <li id="Label69" class="bg_y">
                            <span><label id="lblChannelNo69">147</label></span>
                            <span><label id="lblData69">${lblDataList[69].fValue}</label></span>
                        </li>
                        <li id="Label70" class="bg_y">
                            <span><label id="lblChannelNo70">147</label></span>
                            <span><label id="lblData70">${lblDataList[70].fValue}</label></span>
                        </li>
                        <li id="Label71" class="bg_g">
                            <span><label id="lblChannelNo71">147</label></span>
                            <span><label id="lblData71">${lblDataList[71].fValue}</label></span>
                        </li>
                        <li id="Label72" class="bg_y">
                            <span><label id="lblChannelNo72">147</label></span>
                            <span><label id="lblData72">${lblDataList[72].fValue}</label></span>
                        </li>
                        <li id="Label73" class="bg_y">
                            <span><label id="lblChannelNo73">147</label></span>
                            <span><label id="lblData73">${lblDataList[73].fValue}</label></span>
                        </li>
                        <li id="Label74" class="bg_g">
                            <span><label id="lblChannelNo74">147</label></span>
                            <span><label id="lblData74">${lblDataList[74].fValue}</label></span>
                        </li>
                        <li id="Label75" class="bg_y">
                            <span><label id="lblChannelNo75">147</label></span>
                            <span><label id="lblData75">${lblDataList[75].fValue}</label></span>
                        </li>
                        <li id="Label76" class="bg_y">
                            <span><label id="lblChannelNo76">147</label></span>
                            <span><label id="lblData76">${lblDataList[76].fValue}</label></span>
                        </li>
                        <li id="Label77" class="bg_y">
                            <span><label id="lblChannelNo77">147</label></span>
                            <span><label id="lblData77">${lblDataList[77].fValue}</label></span>
                        </li>
                        <li id="Label78" class="bg_y">
                            <span><label id="lblChannelNo78">147</label></span>
                            <span><label id="lblData78">${lblDataList[78].fValue}</label></span>
                        </li>
                        <li id="Label79" class="bg_y">
                            <span><label id="lblChannelNo79">147</label></span>
                            <span><label id="lblData79">${lblDataList[79].fValue}</label></span>
                        </li>
                        <li id="Label80" class="bg_y">
                            <span><label id="lblChannelNo80">147</label></span>
                            <span><label id="lblData80">${lblDataList[80].fValue}</label></span>
                        </li>
                        <li id="Label81" class="bg_y">
                            <span><label id="lblChannelNo81">147</label></span>
                            <span><label id="lblData81">${lblDataList[81].fValue}</label></span>
                        </li>
                        <li id="Label82" class="bg_y">
                            <span><label id="lblChannelNo82">147</label></span>
                            <span><label id="lblData82">${lblDataList[82].fValue}</label></span>
                        </li>
                        <li id="Label83" class="bg_y">
                            <span><label id="lblChannelNo83">147</label></span>
                            <span><label id="lblData83">${lblDataList[83].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li>F</li>
                    </ul>
                    <ul>
                        <li>G</li>
                        <li></li>
                        <li id="Label84" class="bg_y">
                            <span><label id="lblChannelNo84">147</label></span>
                            <span><label id="lblData84">${lblDataList[84].fValue}</label></span>
                        </li>
                        <li id="Label85" class="bg_y">
                            <span><label id="lblChannelNo85">147</label></span>
                            <span><label id="lblData85">${lblDataList[85].fValue}</label></span>
                        </li>
                        <li id="Label86" class="bg_y">
                            <span><label id="lblChannelNo86">147</label></span>
                            <span><label id="lblData86">${lblDataList[86].fValue}</label></span>
                        </li>
                        <li id="Label87" class="bg_y">
                            <span><label id="lblChannelNo87">147</label></span>
                            <span><label id="lblData87">${lblDataList[87].fValue}</label></span>
                        </li>
                        <li id="Label88" class="bg_y">
                            <span><label id="lblChannelNo88">147</label></span>
                            <span><label id="lblData88">${lblDataList[88].fValue}</label></span>
                        </li>
                        <li id="Label89" class="bg_y">
                            <span><label id="lblChannelNo89">147</label></span>
                            <span><label id="lblData89">${lblDataList[89].fValue}</label></span>
                        </li>
                        <li id="Label90" class="bg_y">
                            <span><label id="lblChannelNo90">147</label></span>
                            <span><label id="lblData90">${lblDataList[90].fValue}</label></span>
                        </li>
                        <li id="Label91" class="bg_y">
                            <span><label id="lblChannelNo91">147</label></span>
                            <span><label id="lblData91">${lblDataList[91].fValue}</label></span>
                        </li>
                        <li id="Label92" class="bg_y">
                            <span><label id="lblChannelNo92">147</label></span>
                            <span><label id="lblData92">${lblDataList[92].fValue}</label></span>
                        </li>
                        <li id="Label93" class="bg_y">
                            <span><label id="lblChannelNo93">147</label></span>
                            <span><label id="lblData93">${lblDataList[93].fValue}</label></span>
                        </li>
                        <li id="Label94" class="bg_y">
                            <span><label id="lblChannelNo94">147</label></span>
                            <span><label id="lblData94">${lblDataList[94].fValue}</label></span>
                        </li>
                        <li id="Label95" class="bg_y">
                            <span><label id="lblChannelNo95">147</label></span>
                            <span><label id="lblData95">${lblDataList[95].fValue}</label></span>
                        </li>
                        <li id="Label96" class="bg_y">
                            <span><label id="lblChannelNo96">147</label></span>
                            <span><label id="lblData96">${lblDataList[96].fValue}</label></span>
                        </li>
                        <li id="Label97" class="bg_y">
                            <span><label id="lblChannelNo97">147</label></span>
                            <span><label id="lblData97">${lblDataList[97].fValue}</label></span>
                        </li>
                        <li id="Label98" class="bg_y">
                            <span><label id="lblChannelNo98">147</label></span>
                            <span><label id="lblData98">${lblDataList[98].fValue}</label></span>
                        </li>
                        <li id="Label99" class="bg_y">
                            <span><label id="lblChannelNo99">147</label></span>
                            <span><label id="lblData99">${lblDataList[99].fValue}</label></span>
                        </li>
                        <li id="Label100" class="bg_y">
                            <span><label id="lblChannelNo100">147</label></span>
                            <span><label id="lblData100">${lblDataList[100].fValue}</label></span>
                        </li>
                        <li id="Label101" class="bg_y">
                            <span><label id="lblChannelNo101">147</label></span>
                            <span><label id="lblData101">${lblDataList[101].fValue}</label></span>
                        </li>
                        <li id="Label102" class="bg_y">
                            <span><label id="lblChannelNo102">147</label></span>
                            <span><label id="lblData102">${lblDataList[102].fValue}</label></span>
                        </li>
                        <li id="Label103" class="bg_y">
                            <span><label id="lblChannelNo103">147</label></span>
                            <span><label id="lblData103">${lblDataList[103].fValue}</label></span>
                        </li>
                        <li></li>
                        <li>G</li>
                    </ul>
                    <ul>
                        <li>H</li>
                        <li></li>
                        <li id="Label104" class="bg_y">
                            <span><label id="lblChannelNo104">147</label></span>
                            <span><label id="lblData104">${lblDataList[104].fValue}</label></span>
                        </li>
                        <li id="Label105" class="bg_y">
                            <span><label id="lblChannelNo105">147</label></span>
                            <span><label id="lblData105">${lblDataList[105].fValue}</label></span>
                        </li>
                        <li id="Label106" class="bg_y">
                            <span><label id="lblChannelNo106">147</label></span>
                            <span><label id="lblData106">${lblDataList[106].fValue}</label></span>
                        </li>
                        <li id="Label107" class="bg_y">
                            <span><label id="lblChannelNo107">147</label></span>
                            <span><label id="lblData107">${lblDataList[107].fValue}</label></span>
                        </li>
                        <li id="Label108" class="bg_y">
                            <span><label id="lblChannelNo108">147</label></span>
                            <span><label id="lblData108">${lblDataList[108].fValue}</label></span>
                        </li>
                        <li id="Label109" class="bg_y">
                            <span><label id="lblChannelNo109">147</label></span>
                            <span><label id="lblData109">${lblDataList[109].fValue}</label></span>
                        </li>
                        <li id="Label110" class="bg_y">
                            <span><label id="lblChannelNo110">147</label></span>
                            <span><label id="lblData110">${lblDataList[110].fValue}</label></span>
                        </li>
                        <li id="Label111" class="bg_y">
                            <span><label id="lblChannelNo111">147</label></span>
                            <span><label id="lblData111">${lblDataList[111].fValue}</label></span>
                        </li>
                        <li id="Label112" class="bg_y">
                            <span><label id="lblChannelNo112">147</label></span>
                            <span><label id="lblData112">${lblDataList[112].fValue}</label></span>
                        </li>
                        <li id="Label113" class="bg_y">
                            <span><label id="lblChannelNo113">147</label></span>
                            <span><label id="lblData113">${lblDataList[113].fValue}</label></span>
                        </li>
                        <li id="Label114" class="bg_y">
                            <span><label id="lblChannelNo114">147</label></span>
                            <span><label id="lblData114">${lblDataList[114].fValue}</label></span>
                        </li>
                        <li id="Label115" class="bg_y">
                            <span><label id="lblChannelNo115">147</label></span>
                            <span><label id="lblData115">${lblDataList[115].fValue}</label></span>
                        </li>
                        <li id="Label116" class="bg_y">
                            <span><label id="lblChannelNo116">147</label></span>
                            <span><label id="lblData116">${lblDataList[116].fValue}</label></span>
                        </li>
                        <li id="Label117" class="bg_y">
                            <span><label id="lblChannelNo117">147</label></span>
                            <span><label id="lblData117">${lblDataList[117].fValue}</label></span>
                        </li>
                        <li id="Label118" class="bg_y">
                            <span><label id="lblChannelNo118">147</label></span>
                            <span><label id="lblData118">${lblDataList[118].fValue}</label></span>
                        </li>
                        <li id="Label119" class="bg_y">
                            <span><label id="lblChannelNo119">147</label></span>
                            <span><label id="lblData119">${lblDataList[119].fValue}</label></span>
                        </li>
                        <li id="Label120" class="bg_g">
                            <span><label id="lblChannelNo120">147</label></span>
                            <span><label id="lblData120">${lblDataList[120].fValue}</label></span>
                        </li>
                        <li id="Label121" class="bg_y">
                            <span><label id="lblChannelNo121">147</label></span>
                            <span><label id="lblData121">${lblDataList[121].fValue}</label></span>
                        </li>
                        <li id="Label122" class="bg_y">
                            <span><label id="lblChannelNo122">147</label></span>
                            <span><label id="lblData122">${lblDataList[122].fValue}</label></span>
                        </li>
                        <li id="Label123" class="bg_y">
                            <span><label id="lblChannelNo123">147</label></span>
                            <span><label id="lblData123">${lblDataList[123].fValue}</label></span>
                        </li>
                        <li></li>
                        <li>H</li>
                    </ul>
                    <ul>
                        <li>J</li>
                        <li id="Label124" class="bg_y">
                            <span><label id="lblChannelNo124">147</label></span>
                            <span><label id="lblData124">${lblDataList[124].fValue}</label></span>
                        </li>
                        <li id="Label125" class="bg_y">
                            <span><label id="lblChannelNo125">147</label></span>
                            <span><label id="lblData125">${lblDataList[125].fValue}</label></span>
                        </li>
                        <li id="Label126" class="bg_y">
                            <span><label id="lblChannelNo126">147</label></span>
                            <span><label id="lblData126">${lblDataList[126].fValue}</label></span>
                        </li>
                        <li id="Label127" class="bg_y">
                            <span><label id="lblChannelNo127">147</label></span>
                            <span><label id="lblData127">${lblDataList[127].fValue}</label></span>
                        </li>
                        <li id="Label128" class="bg_y">
                            <span><label id="lblChannelNo128">147</label></span>
                            <span><label id="lblData128">${lblDataList[128].fValue}</label></span>
                        </li>
                        <li id="Label129" class="bg_g">
                            <span><label id="lblChannelNo129">147</label></span>
                            <span><label id="lblData129">${lblDataList[129].fValue}</label></span>
                        </li>
                        <li id="Label130" class="bg_y">
                            <span><label id="lblChannelNo130">147</label></span>
                            <span><label id="lblData130">${lblDataList[130].fValue}</label></span>
                        </li>
                        <li id="Label131" class="bg_y">
                            <span><label id="lblChannelNo131">147</label></span>
                            <span><label id="lblData131">${lblDataList[131].fValue}</label></span>
                        </li>
                        <li id="Label132" class="bg_g">
                            <span><label id="lblChannelNo132">147</label></span>
                            <span><label id="lblData132">${lblDataList[132].fValue}</label></span>
                        </li>
                        <li id="Label133" class="bg_y">
                            <span><label id="lblChannelNo133">147</label></span>
                            <span><label id="lblData133">${lblDataList[133].fValue}</label></span>
                        </li>
                        <li id="Label134" class="bg_y">
                            <span><label id="lblChannelNo134">147</label></span>
                            <span><label id="lblData134">${lblDataList[134].fValue}</label></span>
                        </li>
                        <li id="Label135" class="bg_y">
                            <span><label id="lblChannelNo135">147</label></span>
                            <span><label id="lblData135">${lblDataList[135].fValue}</label></span>
                        </li>
                        <li id="Label136" class="bg_y">
                            <span><label id="lblChannelNo136">147</label></span>
                            <span><label id="lblData136">${lblDataList[136].fValue}</label></span>
                        </li>
                        <li id="Label137" class="bg_y">
                            <span><label id="lblChannelNo137">147</label></span>
                            <span><label id="lblData137">${lblDataList[137].fValue}</label></span>
                        </li>
                        <li id="Label138" class="bg_y">
                            <span><label id="lblChannelNo138">147</label></span>
                            <span><label id="lblData138">${lblDataList[138].fValue}</label></span>
                        </li>
                        <li id="Label139" class="bg_y">
                            <span><label id="lblChannelNo139">147</label></span>
                            <span><label id="lblData139">${lblDataList[139].fValue}</label></span>
                        </li>
                        <li id="Label140" class="bg_y">
                            <span><label id="lblChannelNo140">147</label></span>
                            <span><label id="lblData140">${lblDataList[140].fValue}</label></span>
                        </li>
                        <li id="Label141" class="bg_g">
                            <span><label id="lblChannelNo141">147</label></span>
                            <span><label id="lblData141">${lblDataList[141].fValue}</label></span>
                        </li>
                        <li id="Label142" class="bg_y">
                            <span><label id="lblChannelNo142">147</label></span>
                            <span><label id="lblData142">${lblDataList[142].fValue}</label></span>
                        </li>
                        <li id="Label143" class="bg_y">
                            <span><label id="lblChannelNo143">147</label></span>
                            <span><label id="lblData143">${lblDataList[143].fValue}</label></span>
                        </li>
                        <li id="Label144" class="bg_r">
                            <span><label id="lblChannelNo144">147</label></span>
                            <span><label id="lblData144">${lblDataList[144].fValue}</label></span>
                        </li>
                        <li id="Label145" class="bg_y">
                            <span><label id="lblChannelNo145">147</label></span>
                            <span><label id="lblData145">${lblDataList[145].fValue}</label></span>
                        </li>
                        <li>J</li>
                    </ul>
                    <ul>
                        <li>K</li>
                        <li id="Label146" class="bg_y">
                            <span><label id="lblChannelNo146">147</label></span>
                            <span><label id="lblData146">${lblDataList[146].fValue}</label></span>
                        </li>
                        <li id="Label147" class="bg_r">
                            <span><label id="lblChannelNo147">147</label></span>
                            <span><label id="lblData147">${lblDataList[147].fValue}</label></span>
                        </li>
                        <li id="Label148" class="bg_g">
                            <span><label id="lblChannelNo148">147</label></span>
                            <span><label id="lblData148">${lblDataList[148].fValue}</label></span>
                        </li>
                        <li id="Label149" class="bg_y">
                            <span><label id="lblChannelNo149">147</label></span>
                            <span><label id="lblData149">${lblDataList[149].fValue}</label></span>
                        </li>
                        <li id="Label150" class="bg_y">
                            <span><label id="lblChannelNo150">147</label></span>
                            <span><label id="lblData150">${lblDataList[150].fValue}</label></span>
                        </li>
                        <li id="Label151" class="bg_y">
                            <span><label id="lblChannelNo151">147</label></span>
                            <span><label id="lblData151">${lblDataList[151].fValue}</label></span>
                        </li>
                        <li id="Label152" class="bg_y">
                            <span><label id="lblChannelNo152">147</label></span>
                            <span><label id="lblData152">${lblDataList[152].fValue}</label></span>
                        </li>
                        <li id="Label153" class="bg_g">
                            <span><label id="lblChannelNo153">147</label></span>
                            <span><label id="lblData153">${lblDataList[153].fValue}</label></span>
                        </li>
                        <li id="Label154" class="bg_y">
                            <span><label id="lblChannelNo154">147</label></span>
                            <span><label id="lblData154">${lblDataList[154].fValue}</label></span>
                        </li>
                        <li id="Label155" class="bg_y">
                            <span><label id="lblChannelNo155">147</label></span>
                            <span><label id="lblData155">${lblDataList[155].fValue}</label></span>
                        </li>
                        <li id="Label156" class="bg_y">
                            <span><label id="lblChannelNo156">147</label></span>
                            <span><label id="lblData156">${lblDataList[156].fValue}</label></span>
                        </li>
                        <li id="Label157" class="bg_y">
                            <span><label id="lblChannelNo157">147</label></span>
                            <span><label id="lblData157">${lblDataList[157].fValue}</label></span>
                        </li>
                        <li id="Label158" class="bg_y">
                            <span><label id="lblChannelNo158">147</label></span>
                            <span><label id="lblData158">${lblDataList[158].fValue}</label></span>
                        </li>
                        <li id="Label159" class="bg_y">
                            <span><label id="lblChannelNo159">147</label></span>
                            <span><label id="lblData159">${lblDataList[159].fValue}</label></span>
                        </li>
                        <li id="Label160" class="bg_y">
                            <span><label id="lblChannelNo160">147</label></span>
                            <span><label id="lblData160">${lblDataList[160].fValue}</label></span>
                        </li>
                        <li id="Label161" class="bg_y">
                            <span><label id="lblChannelNo161">147</label></span>
                            <span><label id="lblData161">${lblDataList[161].fValue}</label></span>
                        </li>
                        <li id="Label162" class="bg_y">
                            <span><label id="lblChannelNo162">147</label></span>
                            <span><label id="lblData162">${lblDataList[162].fValue}</label></span>
                        </li>
                        <li id="Label163" class="bg_y">
                            <span><label id="lblChannelNo163">147</label></span>
                            <span><label id="lblData163">${lblDataList[163].fValue}</label></span>
                        </li>
                        <li id="Label164" class="bg_y">
                            <span><label id="lblChannelNo164">147</label></span>
                            <span><label id="lblData164">${lblDataList[164].fValue}</label></span>
                        </li>
                        <li id="Label165" class="bg_y">
                            <span><label id="lblChannelNo165">147</label></span>
                            <span><label id="lblData165">${lblDataList[165].fValue}</label></span>
                        </li>
                        <li id="Label166" class="bg_y">
                            <span><label id="lblChannelNo166">147</label></span>
                            <span><label id="lblData166">${lblDataList[166].fValue}</label></span>
                        </li>
                        <li id="Label167" class="bg_r">
                            <span><label id="lblChannelNo167">147</label></span>
                            <span><label id="lblData167">${lblDataList[167].fValue}</label></span>
                        </li>
                        <li>J</li>
                    </ul>
                    <ul>
                        <li>L</li>
                        <li id="Label168" class="bg_y">
                            <span><label id="lblChannelNo168">147</label></span>
                            <span><label id="lblData168">${lblDataList[168].fValue}</label></span>
                        </li>
                        <li id="Label169" class="bg_y">
                            <span><label id="lblChannelNo169">147</label></span>
                            <span><label id="lblData169">${lblDataList[169].fValue}</label></span>
                        </li>
                        <li id="Label170" class="bg_y">
                            <span><label id="lblChannelNo170">147</label></span>
                            <span><label id="lblData170">${lblDataList[170].fValue}</label></span>
                        </li>
                        <li id="Label171" class="bg_g">
                            <span><label id="lblChannelNo171">147</label></span>
                            <span><label id="lblData171">${lblDataList[171].fValue}</label></span>
                        </li>
                        <li id="Label172" class="bg_g">
                            <span><label id="lblChannelNo172">147</label></span>
                            <span><label id="lblData172">${lblDataList[172].fValue}</label></span>
                        </li>
                        <li id="Label173" class="bg_g">
                            <span><label id="lblChannelNo173">147</label></span>
                            <span><label id="lblData173">${lblDataList[173].fValue}</label></span>
                        </li>
                        <li id="Label174" class="bg_y">
                            <span><label id="lblChannelNo174">147</label></span>
                            <span><label id="lblData174">${lblDataList[174].fValue}</label></span>
                        </li>
                        <li id="Label175" class="bg_y">
                            <span><label id="lblChannelNo175">147</label></span>
                            <span><label id="lblData175">${lblDataList[175].fValue}</label></span>
                        </li>
                        <li id="Label176" class="bg_y">
                            <span><label id="lblChannelNo176">147</label></span>
                            <span><label id="lblData176">${lblDataList[176].fValue}</label></span>
                        </li>
                        <li id="Label177" class="bg_y">
                            <span><label id="lblChannelNo177">147</label></span>
                            <span><label id="lblData177">${lblDataList[177].fValue}</label></span>
                        </li>
                        <li id="Label178" class="bg_y">
                            <span><label id="lblChannelNo178">147</label></span>
                            <span><label id="lblData178">${lblDataList[178].fValue}</label></span>
                        </li>
                        <li id="Label179" class="bg_y">
                            <span><label id="lblChannelNo179">147</label></span>
                            <span><label id="lblData179">${lblDataList[179].fValue}</label></span>
                        </li>
                        <li id="Label180" class="bg_g">
                            <span><label id="lblChannelNo180">147</label></span>
                            <span><label id="lblData180">${lblDataList[180].fValue}</label></span>
                        </li>
                        <li id="Label181" class="bg_y">
                            <span><label id="lblChannelNo181">147</label></span>
                            <span><label id="lblData181">${lblDataList[181].fValue}</label></span>
                        </li>
                        <li id="Label182" class="bg_y">
                            <span><label id="lblChannelNo182">147</label></span>
                            <span><label id="lblData182">${lblDataList[182].fValue}</label></span>
                        </li>
                        <li id="Label183" class="bg_y">
                            <span><label id="lblChannelNo183">147</label></span>
                            <span><label id="lblData183">${lblDataList[183].fValue}</label></span>
                        </li>
                        <li id="Label184" class="bg_y">
                            <span><label id="lblChannelNo184">147</label></span>
                            <span><label id="lblData184">${lblDataList[184].fValue}</label></span>
                        </li>
                        <li id="Label185" class="bg_g">
                            <span><label id="lblChannelNo185">147</label></span>
                            <span><label id="lblData185">${lblDataList[185].fValue}</label></span>
                        </li>
                        <li id="Label186" class="bg_y">
                            <span><label id="lblChannelNo186">147</label></span>
                            <span><label id="lblData186">${lblDataList[186].fValue}</label></span>
                        </li>
                        <li id="Label187" class="bg_g">
                            <span><label id="lblChannelNo187">147</label></span>
                            <span><label id="lblData187">${lblDataList[187].fValue}</label></span>
                        </li>
                        <li id="Label188" class="bg_y">
                            <span><label id="lblChannelNo188">147</label></span>
                            <span><label id="lblData188">${lblDataList[188].fValue}</label></span>
                        </li>
                        <li id="Label189" class="bg_r">
                            <span><label id="lblChannelNo189">147</label></span>
                            <span><label id="lblData189">${lblDataList[189].fValue}</label></span>
                        </li>
                        <li>L</li>
                    </ul>
                    <ul>
                        <li>M</li>
                        <li id="Label190" class="bg_y">
                            <span><label id="lblChannelNo190">147</label></span>
                            <span><label id="lblData190">${lblDataList[190].fValue}</label></span>
                        </li>
                        <li id="Label191" class="bg_y">
                            <span><label id="lblChannelNo191">147</label></span>
                            <span><label id="lblData191">${lblDataList[191].fValue}</label></span>
                        </li>
                        <li id="Label192" class="bg_g">
                            <span><label id="lblChannelNo192">147</label></span>
                            <span><label id="lblData192">${lblDataList[192].fValue}</label></span>
                        </li>
                        <li id="Label193" class="bg_g">
                            <span><label id="lblChannelNo193">147</label></span>
                            <span><label id="lblData193">${lblDataList[193].fValue}</label></span>
                        </li>
                        <li id="Label194" class="bg_y">
                            <span><label id="lblChannelNo194">147</label></span>
                            <span><label id="lblData194">${lblDataList[194].fValue}</label></span>
                        </li>
                        <li id="Label195" class="bg_y">
                            <span><label id="lblChannelNo195">147</label></span>
                            <span><label id="lblData195">${lblDataList[195].fValue}</label></span>
                        </li>
                        <li id="Label196" class="bg_y">
                            <span><label id="lblChannelNo196">147</label></span>
                            <span><label id="lblData196">${lblDataList[196].fValue}</label></span>
                        </li>
                        <li id="Label197" class="bg_y">
                            <span><label id="lblChannelNo197">147</label></span>
                            <span><label id="lblData197">${lblDataList[197].fValue}</label></span>
                        </li>
                        <li id="Label198" class="bg_g">
                            <span><label id="lblChannelNo198">147</label></span>
                            <span><label id="lblData198">${lblDataList[198].fValue}</label></span>
                        </li>
                        <li id="Label199" class="bg_y">
                            <span><label id="lblChannelNo199">147</label></span>
                            <span><label id="lblData199">${lblDataList[199].fValue}</label></span>
                        </li>
                        <li id="Label200" class="bg_y">
                            <span><label id="lblChannelNo200">147</label></span>
                            <span><label id="lblData200">${lblDataList[200].fValue}</label></span>
                        </li>
                        <li id="Label201" class="bg_y">
                            <span><label id="lblChannelNo201">147</label></span>
                            <span><label id="lblData201">${lblDataList[201].fValue}</label></span>
                        </li>
                        <li id="Label202" class="bg_y">
                            <span><label id="lblChannelNo202">147</label></span>
                            <span><label id="lblData202">${lblDataList[202].fValue}</label></span>
                        </li>
                        <li id="Label203" class="bg_y">
                            <span><label id="lblChannelNo203">147</label></span>
                            <span><label id="lblData203">${lblDataList[203].fValue}</label></span>
                        </li>
                        <li id="Label204" class="bg_y">
                            <span><label id="lblChannelNo204">147</label></span>
                            <span><label id="lblData204">${lblDataList[204].fValue}</label></span>
                        </li>
                        <li id="Label205" class="bg_y">
                            <span><label id="lblChannelNo205">147</label></span>
                            <span><label id="lblData205">${lblDataList[205].fValue}</label></span>
                        </li>
                        <li id="Label206" class="bg_y">
                            <span><label id="lblChannelNo206">147</label></span>
                            <span><label id="lblData206">${lblDataList[206].fValue}</label></span>
                        </li>
                        <li id="Label207" class="bg_y">
                            <span><label id="lblChannelNo207">147</label></span>
                            <span><label id="lblData207">${lblDataList[207].fValue}</label></span>
                        </li>
                        <li id="Label208" class="bg_y">
                            <span><label id="lblChannelNo0">147</label></span>
                            <span><label id="lblData208">${lblDataList[208].fValue}</label></span>
                        </li>
                        <li id="Label209" class="bg_y">
                            <span><label id="lblChannelNo209">147</label></span>
                            <span><label id="lblData209">${lblDataList[209].fValue}</label></span>
                        </li>
                        <li id="Label210" class="bg_y">
                            <span><label id="lblChannelNo210">147</label></span>
                            <span><label id="lblData210">${lblDataList[210].fValue}</label></span>
                        </li>
                        <li id="Label211" class="bg_r">
                            <span><label id="lblChannelNo211">147</label></span>
                            <span><label id="lblData211">${lblDataList[211].fValue}</label></span>
                        </li>
                        <li>M</li>
                    </ul>
                    <ul>
                        <li>N</li>
                        <li id="Label212" class="bg_r">
                            <span><label id="lblChannelNo212">147</label></span>
                            <span><label id="lblData212">${lblDataList[212].fValue}</label></span>
                        </li>
                        <li id="Label213" class="bg_y">
                            <span><label id="lblChannelNo213">147</label></span>
                            <span><label id="lblData213">${lblDataList[213].fValue}</label></span>
                        </li>
                        <li id="Label214" class="bg_y">
                            <span><label id="lblChannelNo214">147</label></span>
                            <span><label id="lblData214">${lblDataList[214].fValue}</label></span>
                        </li>
                        <li id="Label215" class="bg_y">
                            <span><label id="lblChannelNo215">147</label></span>
                            <span><label id="lblData215">${lblDataList[215].fValue}</label></span>
                        </li>
                        <li id="Label216" class="bg_g">
                            <span><label id="lblChannelNo216">147</label></span>
                            <span><label id="lblData216">${lblDataList[216].fValue}</label></span>
                        </li>
                        <li id="Label217" class="bg_y">
                            <span><label id="lblChannelNo217">147</label></span>
                            <span><label id="lblData217">${lblDataList[217].fValue}</label></span>
                        </li>
                        <li id="Label218" class="bg_y">
                            <span><label id="lblChannelNo218">147</label></span>
                            <span><label id="lblData218">${lblDataList[218].fValue}</label></span>
                        </li>
                        <li id="Label219" class="bg_y">
                            <span><label id="lblChannelNo219">147</label></span>
                            <span><label id="lblData219">${lblDataList[219].fValue}</label></span>
                        </li>
                        <li id="Label220" class="bg_y">
                            <span><label id="lblChannelNo220">147</label></span>
                            <span><label id="lblData220">${lblDataList[220].fValue}</label></span>
                        </li>
                        <li id="Label221" class="bg_y">
                            <span><label id="lblChannelNo221">147</label></span>
                            <span><label id="lblData221">${lblDataList[221].fValue}</label></span>
                        </li>
                        <li id="Label222" class="bg_y">
                            <span><label id="lblChannelNo222">147</label></span>
                            <span><label id="lblData222">${lblDataList[222].fValue}</label></span>
                        </li>
                        <li id="Label223" class="bg_y">
                            <span><label id="lblChannelNo223">147</label></span>
                            <span><label id="lblData223">${lblDataList[223].fValue}</label></span>
                        </li>
                        <li id="Label224" class="bg_y">
                            <span><label id="lblChannelNo224">147</label></span>
                            <span><label id="lblData224">${lblDataList[224].fValue}</label></span>
                        </li>
                        <li id="Label225" class="bg_g">
                            <span><label id="lblChannelNo225">147</label></span>
                            <span><label id="lblData225">${lblDataList[225].fValue}</label></span>
                        </li>
                        <li id="Label226" class="bg_y">
                            <span><label id="lblChannelNo226">147</label></span>
                            <span><label id="lblData226">${lblDataList[226].fValue}</label></span>
                        </li>
                        <li id="Label227" class="bg_y">
                            <span><label id="lblChannelNo227">147</label></span>
                            <span><label id="lblData227">${lblDataList[227].fValue}</label></span>
                        </li>
                        <li id="Label228" class="bg_y">
                            <span><label id="lblChannelNo228">147</label></span>
                            <span><label id="lblData228">${lblDataList[228].fValue}</label></span>
                        </li>
                        <li id="Label229" class="bg_y">
                            <span><label id="lblChannelNo229">147</label></span>
                            <span><label id="lblData229">${lblDataList[229].fValue}</label></span>
                        </li>
                        <li id="Label230" class="bg_y">
                            <span><label id="lblChannelNo230">147</label></span>
                            <span><label id="lblData230">${lblDataList[230].fValue}</label></span>
                        </li>
                        <li id="Label231" class="bg_y">
                            <span><label id="lblChannelNo231">147</label></span>
                            <span><label id="lblData231">${lblDataList[231].fValue}</label></span>
                        </li>
                        <li id="Label232" class="bg_y">
                            <span><label id="lblChannelNo232">147</label></span>
                            <span><label id="lblData232">${lblDataList[232].fValue}</label></span>
                        </li>
                        <li id="Label233" class="bg_r">
                            <span><label id="lblChannelNo233">147</label></span>
                            <span><label id="lblData233">${lblDataList[233].fValue}</label></span>
                        </li>
                        <li>N</li>
                    </ul>
                    <ul>
                        <li>o</li>
                        <li id="Label234" class="bg_y">
                            <span><label id="lblChannelNo234">147</label></span>
                            <span><label id="lblData234">${lblDataList[234].fValue}</label></span>
                        </li>
                        <li id="Label235" class="bg_y">
                            <span><label id="lblChannelNo235">147</label></span>
                            <span><label id="lblData235">${lblDataList[235].fValue}</label></span>
                        </li>
                        <li id="Label236" class="bg_g">
                            <span><label id="lblChannelNo236">147</label></span>
                            <span><label id="lblData236">${lblDataList[236].fValue}</label></span>
                        </li>
                        <li id="Label237" class="bg_y">
                            <span><label id="lblChannelNo237">147</label></span>
                            <span><label id="lblData237">${lblDataList[237].fValue}</label></span>
                        </li>
                        <li id="Label238" class="bg_g">
                            <span><label id="lblChannelNo238">147</label></span>
                            <span><label id="lblData238">${lblDataList[238].fValue}</label></span>
                        </li>
                        <li id="Label239" class="bg_y">
                            <span><label id="lblChannelNo239">147</label></span>
                            <span><label id="lblData239">${lblDataList[239].fValue}</label></span>
                        </li>
                        <li id="Label240" class="bg_y">
                            <span><label id="lblChannelNo240">147</label></span>
                            <span><label id="lblData240">${lblDataList[240].fValue}</label></span>
                        </li>
                        <li id="Label241" class="bg_y">
                            <span><label id="lblChannelNo241">147</label></span>
                            <span><label id="lblData241">${lblDataList[241].fValue}</label></span>
                        </li>
                        <li id="Label242" class="bg_y">
                            <span><label id="lblChannelNo242">147</label></span>
                            <span><label id="lblData242">${lblDataList[242].fValue}</label></span>
                        </li>
                        <li id="Label243" class="bg_y">
                            <span><label id="lblChannelNo243">147</label></span>
                            <span><label id="lblData243">${lblDataList[243].fValue}</label></span>
                        </li>
                        <li id="Label244" class="bg_y">
                            <span><label id="lblChannelNo244">147</label></span>
                            <span><label id="lblData244">${lblDataList[244].fValue}</label></span>
                        </li>
                        <li id="Label245" class="bg_y">
                            <span><label id="lblChannelNo245">147</label></span>
                            <span><label id="lblData245">${lblDataList[245].fValue}</label></span>
                        </li>
                        <li id="Label246" class="bg_y">
                            <span><label id="lblChannelNo246">147</label></span>
                            <span><label id="lblData246">${lblDataList[246].fValue}</label></span>
                        </li>
                        <li id="Label247" class="bg_g">
                            <span><label id="lblChannelNo247">147</label></span>
                            <span><label id="lblData247">${lblDataList[247].fValue}</label></span>
                        </li>
                        <li id="Label248" class="bg_r">
                            <span><label id="lblChannelNo248">147</label></span>
                            <span><label id="lblData248">${lblDataList[248].fValue}</label></span>
                        </li>
                        <li id="Label249" class="bg_y">
                            <span><label id="lblChannelNo249">147</label></span>
                            <span><label id="lblData249">${lblDataList[249].fValue}</label></span>
                        </li>
                        <li id="Label250" class="bg_y">
                            <span><label id="lblChannelNo250">147</label></span>
                            <span><label id="lblData250">${lblDataList[250].fValue}</label></span>
                        </li>
                        <li id="Label251" class="bg_y">
                            <span><label id="lblChannelNo251">147</label></span>
                            <span><label id="lblData251">${lblDataList[251].fValue}</label></span>
                        </li>
                        <li id="Label252" class="bg_y">
                            <span><label id="lblChannelNo252">147</label></span>
                            <span><label id="lblData252">${lblDataList[252].fValue}</label></span>
                        </li>
                        <li id="Label253" class="bg_y">
                            <span><label id="lblChannelNo253">147</label></span>
                            <span><label id="lblData253">${lblDataList[253].fValue}</label></span>
                        </li>
                        <li id="Label254" class="bg_r">
                            <span><label id="lblChannelNo254">147</label></span>
                            <span><label id="lblData254">${lblDataList[254].fValue}</label></span>
                        </li>
                        <li id="Label255" class="bg_r">
                            <span><label id="lblChannelNo255">147</label></span>
                            <span><label id="lblData255">${lblDataList[255].fValue}</label></span>
                        </li>
                        <li>o</li>
                    </ul>
                    <ul>
                        <li>P</li>
                        <li></li>
                        <li id="Label256" class="bg_y">
                            <span><label id="lblChannelNo256">147</label></span>
                            <span><label id="lblData256">${lblDataList[256].fValue}</label></span>
                        </li>
                        <li id="Label257" class="bg_y">
                            <span><label id="lblChannelNo257">147</label></span>
                            <span><label id="lblData257">${lblDataList[257].fValue}</label></span>
                        </li>
                        <li id="Label258" class="bg_g">
                            <span><label id="lblChannelNo258">147</label></span>
                            <span><label id="lblData258">${lblDataList[258].fValue}</label></span>
                        </li>
                        <li id="Label259" class="bg_y">
                            <span><label id="lblChannelNo259">147</label></span>
                            <span><label id="lblData259">${lblDataList[259].fValue}</label></span>
                        </li>
                        <li id="Label260" class="bg_y">
                            <span><label id="lblChannelNo260">147</label></span>
                            <span><label id="lblData260">${lblDataList[260].fValue}</label></span>
                        </li>
                        <li id="Label261" class="bg_y">
                            <span><label id="lblChannelNo261">147</label></span>
                            <span><label id="lblData261">${lblDataList[261].fValue}</label></span>
                        </li>
                        <li id="Label262" class="bg_y">
                            <span><label id="lblChannelNo262">147</label></span>
                            <span><label id="lblData262">${lblDataList[262].fValue}</label></span>
                        </li>
                        <li id="Label263" class="bg_y">
                            <span><label id="lblChannelNo263">147</label></span>
                            <span><label id="lblData263">${lblDataList[263].fValue}</label></span>
                        </li>
                        <li id="Label264" class="bg_y">
                            <span><label id="lblChannelNo264">147</label></span>
                            <span><label id="lblData264">${lblDataList[264].fValue}</label></span>
                        </li>
                        <li id="Label265" class="bg_y">
                            <span><label id="lblChannelNo265">147</label></span>
                            <span><label id="lblData265">${lblDataList[265].fValue}</label></span>
                        </li>
                        <li id="Label266" class="bg_y">
                            <span><label id="lblChannelNo266">147</label></span>
                            <span><label id="lblData266">${lblDataList[266].fValue}</label></span>
                        </li>
                        <li id="Label267" class="bg_y">
                            <span><label id="lblChannelNo267">147</label></span>
                            <span><label id="lblData267">${lblDataList[267].fValue}</label></span>
                        </li>
                        <li id="Label268" class="bg_y">
                            <span><label id="lblChannelNo268">147</label></span>
                            <span><label id="lblData268">${lblDataList[268].fValue}</label></span>
                        </li>
                        <li id="Label269" class="bg_y">
                            <span><label id="lblChannelNo269">147</label></span>
                            <span><label id="lblData269">${lblDataList[269].fValue}</label></span>
                        </li>
                        <li id="Label270" class="bg_y">
                            <span><label id="lblChannelNo270">147</label></span>
                            <span><label id="lblData270">${lblDataList[270].fValue}</label></span>
                        </li>
                        <li id="Label271" class="bg_y">
                            <span><label id="lblChannelNo271">147</label></span>
                            <span><label id="lblData271">${lblDataList[271].fValue}</label></span>
                        </li>
                        <li id="Label272" class="bg_y">
                            <span><label id="lblChannelNo272">147</label></span>
                            <span><label id="lblData272">${lblDataList[272].fValue}</label></span>
                        </li>
                        <li id="Label273" class="bg_y">
                            <span><label id="lblChannelNo273">147</label></span>
                            <span><label id="lblData273">${lblDataList[273].fValue}</label></span>
                        </li>
                        <li id="Label274" class="bg_y">
                            <span><label id="lblChannelNo274">147</label></span>
                            <span><label id="lblData274">${lblDataList[274].fValue}</label></span>
                        </li>
                        <li id="Label275" class="bg_r">
                            <span><label id="lblChannelNo275">147</label></span>
                            <span><label id="lblData275">${lblDataList[275].fValue}</label></span>
                        </li>
                        <li></li>
                        <li>P</li>
                    </ul>
                    <ul>
                        <li>Q</li>
                        <li></li>
                        <li id="Label276" class="bg_y">
                            <span><label id="lblChannelNo276">147</label></span>
                            <span><label id="lblData276">${lblDataList[276].fValue}</label></span>
                        </li>
                        <li id="Label277" class="bg_y">
                            <span><label id="lblChannelNo277">147</label></span>
                            <span><label id="lblData277">${lblDataList[277].fValue}</label></span>
                        </li>
                        <li id="Label278" class="bg_y">
                            <span><label id="lblChannelNo278">147</label></span>
                            <span><label id="lblData278">${lblDataList[278].fValue}</label></span>
                        </li>
                        <li id="Label279" class="bg_g">
                            <span><label id="lblChannelNo279">147</label></span>
                            <span><label id="lblData279">${lblDataList[279].fValue}</label></span>
                        </li>
                        <li id="Label280" class="bg_g">
                            <span><label id="lblChannelNo280">147</label></span>
                            <span><label id="lblData280">${lblDataList[280].fValue}</label></span>
                        </li>
                        <li id="Label281" class="bg_y">
                            <span><label id="lblChannelNo281">147</label></span>
                            <span><label id="lblData281">${lblDataList[281].fValue}</label></span>
                        </li>
                        <li id="Label282" class="bg_y">
                            <span><label id="lblChannelNo282">147</label></span>
                            <span><label id="lblData282">${lblDataList[282].fValue}</label></span>
                        </li>
                        <li id="Label283" class="bg_y">
                            <span><label id="lblChannelNo283">147</label></span>
                            <span><label id="lblData283">${lblDataList[283].fValue}</label></span>
                        </li>
                        <li id="Label284" class="bg_y">
                            <span><label id="lblChannelNo284">147</label></span>
                            <span><label id="lblData284">${lblDataList[284].fValue}</label></span>
                        </li>
                        <li id="Label285" class="bg_y">
                            <span><label id="lblChannelNo285">147</label></span>
                            <span><label id="lblData285">${lblDataList[285].fValue}</label></span>
                        </li>
                        <li id="Label286" class="bg_y">
                            <span><label id="lblChannelNo286">147</label></span>
                            <span><label id="lblData286">${lblDataList[286].fValue}</label></span>
                        </li>
                        <li id="Label287" class="bg_y">
                            <span><label id="lblChannelNo287">147</label></span>
                            <span><label id="lblData287">${lblDataList[287].fValue}</label></span>
                        </li>
                        <li id="Label288" class="bg_y">
                            <span><label id="lblChannelNo288">147</label></span>
                            <span><label id="lblData288">${lblDataList[288].fValue}</label></span>
                        </li>
                        <li id="Label289" class="bg_y">
                            <span><label id="lblChannelNo289">147</label></span>
                            <span><label id="lblData289">${lblDataList[289].fValue}</label></span>
                        </li>
                        <li id="Label290" class="bg_y">
                            <span><label id="lblChannelNo290">147</label></span>
                            <span><label id="lblData290">${lblDataList[290].fValue}</label></span>
                        </li>
                        <li id="Label291" class="bg_g">
                            <span><label id="lblChannelNo291">147</label></span>
                            <span><label id="lblData291">${lblDataList[291].fValue}</label></span>
                        </li>
                        <li id="Label292" class="bg_y">
                            <span><label id="lblChannelNo292">147</label></span>
                            <span><label id="lblData292">${lblDataList[292].fValue}</label></span>
                        </li>
                        <li id="Label293" class="bg_g">
                            <span><label id="lblChannelNo293">147</label></span>
                            <span><label id="lblData293">${lblDataList[293].fValue}</label></span>
                        </li>
                        <li id="Label294" class="bg_y">
                            <span><label id="lblChannelNo294">147</label></span>
                            <span><label id="lblData294">${lblDataList[294].fValue}</label></span>
                        </li>
                        <li id="Label295" class="bg_y">
                            <span><label id="lblChannelNo295">147</label></span>
                            <span><label id="lblData295">${lblDataList[295].fValue}</label></span>
                        </li>
                        <li></li>
                        <li>Q</li>
                    </ul>
                    <ul>
                        <li>R</li>
                        <li></li>
                        <li></li>
                        <li id="Label296" class="bg_y">
                            <span><label id="lblChannelNo296">147</label></span>
                            <span><label id="lblData296">${lblDataList[296].fValue}</label></span>
                        </li>
                        <li id="Label297" class="bg_g">
                            <span><label id="lblChannelNo297">147</label></span>
                            <span><label id="lblData297">${lblDataList[297].fValue}</label></span>
                        </li>
                        <li id="Label298" class="bg_g">
                            <span><label id="lblChannelNo298">147</label></span>
                            <span><label id="lblData298">${lblDataList[298].fValue}</label></span>
                        </li>
                        <li id="Label299" class="bg_y">
                            <span><label id="lblChannelNo299">147</label></span>
                            <span><label id="lblData299">${lblDataList[299].fValue}</label></span>
                        </li>
                        <li id="Label300" class="bg_y">
                            <span><label id="lblChannelNo300">147</label></span>
                            <span><label id="lblData300">${lblDataList[300].fValue}</label></span>
                        </li>
                        <li id="Label301" class="bg_y">
                            <span><label id="lblChannelNo301">147</label></span>
                            <span><label id="lblData301">${lblDataList[301].fValue}</label></span>
                        </li>
                        <li id="Label302" class="bg_y">
                            <span><label id="lblChannelNo302">147</label></span>
                            <span><label id="lblData302">${lblDataList[302].fValue}</label></span>
                        </li>
                        <li id="Label303" class="bg_y">
                            <span><label id="lblChannelNo303">147</label></span>
                            <span><label id="lblData303">${lblDataList[303].fValue}</label></span>
                        </li>
                        <li id="Label304" class="bg_y">
                            <span><label id="lblChannelNo304">147</label></span>
                            <span><label id="lblData304">${lblDataList[304].fValue}</label></span>
                        </li>
                        <li id="Label305" class="bg_y">
                            <span><label id="lblChannelNo305">147</label></span>
                            <span><label id="lblData305">${lblDataList[305].fValue}</label></span>
                        </li>
                        <li id="Label306" class="bg_y">
                            <span><label id="lblChannelNo306">147</label></span>
                            <span><label id="lblData306">${lblDataList[306].fValue}</label></span>
                        </li>
                        <li id="Label307" class="bg_y">
                            <span><label id="lblChannelNo307">147</label></span>
                            <span><label id="lblData307">${lblDataList[307].fValue}</label></span>
                        </li>
                        <li id="Label308" class="bg_y">
                            <span><label id="lblChannelNo308">147</label></span>
                            <span><label id="lblData308">${lblDataList[308].fValue}</label></span>
                        </li>
                        <li id="Label309" class="bg_y">
                            <span><label id="lblChannelNo309">147</label></span>
                            <span><label id="lblData309">${lblDataList[309].fValue}</label></span>
                        </li>
                        <li id="Label310" class="bg_g">
                            <span><label id="lblChannelNo310">147</label></span>
                            <span><label id="lblData310">${lblDataList[310].fValue}</label></span>
                        </li>
                        <li id="Label311" class="bg_g">
                            <span><label id="lblChannelNo311">147</label></span>
                            <span><label id="lblData311">${lblDataList[311].fValue}</label></span>
                        </li>
                        <li id="Label312" class="bg_r">
                            <span><label id="lblChannelNo312">147</label></span>
                            <span><label id="lblData312">${lblDataList[312].fValue}</label></span>
                        </li>
                        <li id="Label313" class="bg_y">
                            <span><label id="lblChannelNo313">147</label></span>
                            <span><label id="lblData313">${lblDataList[313].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li>R</li>
                    </ul>
                    <ul>
                        <li>S</li>
                        <li></li>
                        <li></li>
                        <li id="Label314" class="bg_y">
                            <span><label id="lblChannelNo314">147</label></span>
                            <span><label id="lblData314">${lblDataList[314].fValue}</label></span>
                        </li>
                        <li id="Label315" class="bg_y">
                            <span><label id="lblChannelNo315">147</label></span>
                            <span><label id="lblData315">${lblDataList[315].fValue}</label></span>
                        </li>
                        <li id="Label316" class="bg_r">
                            <span><label id="lblChannelNo316">147</label></span>
                            <span><label id="lblData316">${lblDataList[316].fValue}</label></span>
                        </li>
                        <li id="Label317" class="bg_r">
                            <span><label id="lblChannelNo317">147</label></span>
                            <span><label id="lblData317">${lblDataList[317].fValue}</label></span>
                        </li>
                        <li id="Label318" class="bg_y">
                            <span><label id="lblChannelNo318">147</label></span>
                            <span><label id="lblData318">${lblDataList[318].fValue}</label></span>
                        </li>
                        <li id="Label319" class="bg_y">
                            <span><label id="lblChannelNo319">147</label></span>
                            <span><label id="lblData319">${lblDataList[319].fValue}</label></span>
                        </li>
                        <li id="Label320" class="bg_y">
                            <span><label id="lblChannelNo320">147</label></span>
                            <span><label id="lblData320">${lblDataList[320].fValue}</label></span>
                        </li>
                        <li id="Label321" class="bg_y">
                            <span><label id="lblChannelNo321">147</label></span>
                            <span><label id="lblData321">${lblDataList[321].fValue}</label></span>
                        </li>
                        <li id="Label322" class="bg_y">
                            <span><label id="lblChannelNo322">147</label></span>
                            <span><label id="lblData322">${lblDataList[322].fValue}</label></span>
                        </li>
                        <li id="Label323" class="bg_y">
                            <span><label id="lblChannelNo323">147</label></span>
                            <span><label id="lblData323">${lblDataList[323].fValue}</label></span>
                        </li>
                        <li id="Label324" class="bg_g">
                            <span><label id="lblChannelNo324">147</label></span>
                            <span><label id="lblData324">${lblDataList[324].fValue}</label></span>
                        </li>
                        <li id="Label325" class="bg_y">
                            <span><label id="lblChannelNo325">147</label></span>
                            <span><label id="lblData325">${lblDataList[325].fValue}</label></span>
                        </li>
                        <li id="Label326" class="bg_y">
                            <span><label id="lblChannelNo326">147</label></span>
                            <span><label id="lblData326">${lblDataList[326].fValue}</label></span>
                        </li>
                        <li id="Label327" class="bg_g">
                            <span><label id="lblChannelNo327">147</label></span>
                            <span><label id="lblData327">${lblDataList[327].fValue}</label></span>
                        </li>
                        <li id="Label328" class="bg_y">
                            <span><label id="lblChannelNo328">147</label></span>
                            <span><label id="lblData328">${lblDataList[328].fValue}</label></span>
                        </li>
                        <li id="Label329" class="bg_r">
                            <span><label id="lblChannelNo329">147</label></span>
                            <span><label id="lblData329">${lblDataList[329].fValue}</label></span>
                        </li>
                        <li id="Label330" class="bg_r">
                            <span><label id="lblChannelNo330">147</label></span>
                            <span><label id="lblData330">${lblDataList[330].fValue}</label></span>
                        </li>
                        <li id="Label331" class="bg_y">
                            <span><label id="lblChannelNo331">147</label></span>
                            <span><label id="lblData331">${lblDataList[331].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li>S</li>
                    </ul>
                    <ul>
                        <li>T</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li id="Label332" class="bg_y">
                            <span><label id="lblChannelNo332">147</label></span>
                            <span><label id="lblData332">${lblDataList[332].fValue}</label></span>
                        </li>
                        <li id="Label333" class="bg_r">
                            <span><label id="lblChannelNo333">147</label></span>
                            <span><label id="lblData333">${lblDataList[333].fValue}</label></span>
                        </li>
                        <li id="Label334" class="bg_y">
                            <span><label id="lblChannelNo334">147</label></span>
                            <span><label id="lblData334">${lblDataList[334].fValue}</label></span>
                        </li>
                        <li id="Label335" class="bg_y">
                            <span><label id="lblChannelNo335">147</label></span>
                            <span><label id="lblData335">${lblDataList[335].fValue}</label></span>
                        </li>
                        <li id="Label336" class="bg_y">
                            <span><label id="lblChannelNo336">147</label></span>
                            <span><label id="lblData336">${lblDataList[336].fValue}</label></span>
                        </li>
                        <li id="Label337" class="bg_r">
                            <span><label id="lblChannelNo337">147</label></span>
                            <span><label id="lblData337">${lblDataList[337].fValue}</label></span>
                        </li>
                        <li id="Label338" class="bg_r">
                            <span><label id="lblChannelNo338">147</label></span>
                            <span><label id="lblData338">${lblDataList[338].fValue}</label></span>
                        </li>
                        <li id="Label339" class="bg_y">
                            <span><label id="lblChannelNo339">147</label></span>
                            <span><label id="lblData339">${lblDataList[339].fValue}</label></span>
                        </li>
                        <li id="Label340" class="bg_y">
                            <span><label id="lblChannelNo340">147</label></span>
                            <span><label id="lblData340">${lblDataList[340].fValue}</label></span>
                        </li>
                        <li id="Label341" class="bg_y">
                            <span><label id="lblChannelNo341">147</label></span>
                            <span><label id="lblData341">${lblDataList[341].fValue}</label></span>
                        </li>
                        <li id="Label342" class="bg_r">
                            <span><label id="lblChannelNo342">147</label></span>
                            <span><label id="lblData342">${lblDataList[342].fValue}</label></span>
                        </li>
                        <li id="Label343" class="bg_r">
                            <span><label id="lblChannelNo343">147</label></span>
                            <span><label id="lblData343">${lblDataList[343].fValue}</label></span>
                        </li>
                        <li id="Label344" class="bg_y">
                            <span><label id="lblChannelNo344">147</label></span>
                            <span><label id="lblData344">${lblDataList[344].fValue}</label></span>
                        </li>
                        <li id="Label345" class="bg_y">
                            <span><label id="lblChannelNo345">147</label></span>
                            <span><label id="lblData345">${lblDataList[345].fValue}</label></span>
                        </li>
                        <li id="Label346" class="bg_y">
                            <span><label id="lblChannelNo346">147</label></span>
                            <span><label id="lblData346">${lblDataList[346].fValue}</label></span>
                        </li>
                        <li id="Label347" class="bg_y">
                            <span><label id="lblChannelNo347">147</label></span>
                            <span><label id="lblData347">${lblDataList[347].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>T</li>
                    </ul>
                    <ul>
                        <li>U</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li id="Label348" class="bg_y">
                            <span><label id="lblChannelNo348">147</label></span>
                            <span><label id="lblData348">${lblDataList[348].fValue}</label></span>
                        </li>
                        <li id="Label349" class="bg_r">
                            <span><label id="lblChannelNo349">147</label></span>
                            <span><label id="lblData349">${lblDataList[349].fValue}</label></span>
                        </li>
                        <li id="Label350" class="bg_y">
                            <span><label id="lblChannelNo350">147</label></span>
                            <span><label id="lblData350">${lblDataList[350].fValue}</label></span>
                        </li>
                        <li id="Label351" class="bg_y">
                            <span><label id="lblChannelNo351">147</label></span>
                            <span><label id="lblData351">${lblDataList[351].fValue}</label></span>
                        </li>
                        <li id="Label352" class="bg_y">
                            <span><label id="lblChannelNo352">147</label></span>
                            <span><label id="lblData352">${lblDataList[352].fValue}</label></span>
                        </li>
                        <li id="Label353" class="bg_y">
                            <span><label id="lblChannelNo353">147</label></span>
                            <span><label id="lblData353">${lblDataList[353].fValue}</label></span>
                        </li>
                        <li id="Label354" class="bg_g">
                            <span><label id="lblChannelNo354">147</label></span>
                            <span><label id="lblData354">${lblDataList[354].fValue}</label></span>
                        </li>
                        <li id="Label355" class="bg_y">
                            <span><label id="lblChannelNo355">147</label></span>
                            <span><label id="lblData355">${lblDataList[355].fValue}</label></span>
                        </li>
                        <li id="Label356" class="bg_y">
                            <span><label id="lblChannelNo356">147</label></span>
                            <span><label id="lblData356">${lblDataList[356].fValue}</label></span>
                        </li>
                        <li id="Label357" class="bg_r">
                            <span><label id="lblChannelNo357">147</label></span>
                            <span><label id="lblData357">${lblDataList[357].fValue}</label></span>
                        </li>
                        <li id="Label358" class="bg_y">
                            <span><label id="lblChannelNo358">147</label></span>
                            <span><label id="lblData358">${lblDataList[358].fValue}</label></span>
                        </li>
                        <li id="Label359" class="bg_r">
                            <span><label id="lblChannelNo359">147</label></span>
                            <span><label id="lblData359">${lblDataList[359].fValue}</label></span>
                        </li>
                        <li id="Label360" class="bg_y">
                            <span><label id="lblChannelNo360">147</label></span>
                            <span><label id="lblData360">${lblDataList[360].fValue}</label></span>
                        </li>
                        <li id="Label361" class="bg_y">
                            <span><label id="lblChannelNo361">147</label></span>
                            <span><label id="lblData361">${lblDataList[361].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>U</li>
                    </ul>
                    <ul>
                        <li>V</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li id="Label362" class="bg_g">
                            <span><label id="lblChannelNo362">147</label></span>
                            <span><label id="lblData362">${lblDataList[362].fValue}</label></span>
                        </li>
                        <li id="Label363" class="bg_y">
                            <span><label id="lblChannelNo363">147</label></span>
                            <span><label id="lblData363">${lblDataList[363].fValue}</label></span>
                        </li>
                        <li id="Label364" class="bg_y">
                            <span><label id="lblChannelNo364">147</label></span>
                            <span><label id="lblData364">${lblDataList[364].fValue}</label></span>
                        </li>
                        <li id="Label365" class="bg_y">
                            <span><label id="lblChannelNo365">147</label></span>
                            <span><label id="lblData365">${lblDataList[365].fValue}</label></span>
                        </li>
                        <li id="Label366" class="bg_y">
                            <span><label id="lblChannelNo366">147</label></span>
                            <span><label id="lblData366">${lblDataList[366].fValue}</label></span>
                        </li>
                        <li id="Label367" class="bg_y">
                            <span><label id="lblChannelNo367">147</label></span>
                            <span><label id="lblData367">${lblDataList[367].fValue}</label></span>
                        </li>
                        <li id="Label368" class="bg_r">
                            <span><label id="lblChannelNo368">147</label></span>
                            <span><label id="lblData368">${lblDataList[368].fValue}</label></span>
                        </li>
                        <li id="Label369" class="bg_r">
                            <span><label id="lblChannelNo369">147</label></span>
                            <span><label id="lblData369">${lblDataList[369].fValue}</label></span>
                        </li>
                        <li id="Label370" class="bg_y">
                            <span><label id="lblChannelNo370">147</label></span>
                            <span><label id="lblData370">${lblDataList[370].fValue}</label></span>
                        </li>
                        <li id="Label371" class="bg_y">
                            <span><label id="lblChannelNo371">147</label></span>
                            <span><label id="lblData371">${lblDataList[371].fValue}</label></span>
                        </li>
                        <li id="Label372" class="bg_y">
                            <span><label id="lblChannelNo372">147</label></span>
                            <span><label id="lblData372">${lblDataList[372].fValue}</label></span>
                        </li>
                        <li id="Label373" class="bg_g">
                            <span><label id="lblChannelNo373">147</label></span>
                            <span><label id="lblData373">${lblDataList[373].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>V</li>
                    </ul>
                    <ul>
                        <li>W</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li id="Label374" class="bg_y">
                            <span><label id="lblChannelNo374">147</label></span>
                            <span><label id="lblData374">${lblDataList[374].fValue}</label></span>
                        </li>
                        <li id="Label375" class="bg_y">
                            <span><label id="lblChannelNo375">147</label></span>
                            <span><label id="lblData375">${lblDataList[375].fValue}</label></span>
                        </li>
                        <li id="Label376" class="bg_y">
                            <span><label id="lblChannelNo376">147</label></span>
                            <span><label id="lblData376">${lblDataList[376].fValue}</label></span>
                        </li>
                        <li id="Label377" class="bg_y">
                            <span><label id="lblChannelNo377">147</label></span>
                            <span><label id="lblData377">${lblDataList[377].fValue}</label></span>
                        </li>
                        <li id="Label378" class="bg_y">
                            <span><label id="lblChannelNo378">147</label></span>
                            <span><label id="lblData378">${lblDataList[378].fValue}</label></span>
                        </li>
                        <li id="Label379" class="bg_y">
                            <span><label id="lblChannelNo379">147</label></span>
                            <span><label id="lblData379">${lblDataList[379].fValue}</label></span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>W</li>
                    </ul>
                    <ul>
                        <li></li>
                        <li>1</li>
                        <li>2</li>
                        <li>3</li>
                        <li>4</li>
                        <li>5</li>
                        <li>6</li>
                        <li>7</li>
                        <li>8</li>
                        <li>9</li>
                        <li>10</li>
                        <li>11</li>
                        <li>12</li>
                        <li>13</li>
                        <li>14</li>
                        <li>15</li>
                        <li>16</li>
                        <li>17</li>
                        <li>18</li>
                        <li>19</li>
                        <li>20</li>
                        <li>21</li>
                        <li>22</li>
                        <li></li>
                    </ul>                    
                </div>
                <!-- //ch_temp_box -->
            </div>
            <!-- //list_wrap -->
		</div>
		<!-- //contents -->
	</div>
			<form id="reloadFrm" type="hidden"></form>
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
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

