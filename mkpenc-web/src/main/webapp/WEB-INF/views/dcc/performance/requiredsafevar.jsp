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
<script type="text/javascript" src="<c:url value="/resources/js/performance.js" />" charset="utf-8"></script>

<script type="text/javascript">
var timerOn = false;

	var lblDataListAjax = {};
	var dccGrpTagListAjax = {};
	var lblSCMAjax = {};
	
	$(function () {
		
		var timer =0;
				
		timer = setInterval(function () {
	 				
			// 화면초기화
			//var	comSubmit	=	new ComSubmit("safeVarSearch");
			//comSubmit.setUrl("/dcc/performance/requiredsafevar");
			//comSubmit.submit();
			
			var comAjax = new ComAjax("safeVarSearch");
			comAjax.setUrl("/dcc/performance/reloadRsv");
			comAjax.addParam("sHogi",$("input:radio[id='4']").is(":checked") ? '4' : '3');
			comAjax.addParam("sXYGubun",$("input:radio[id='Y']").is(":checked") ? 'Y' : 'X');
			comAjax.setCallback("mbr_performanceCallback");
			comAjax.ajax();
			
		}, 5000); 	 

		setLblDate('');
		setLblDataAjax(1);
	});

	function setLblDate(time) {
		if( time == '' ) {
			time = '${SearchTime}';
		}
		$("#lblDate").text(time);
	}
	
	function setLblDataAjax(type) {
		if( type == 0 ) {
			for( var i=0;i<32;i++ ) {
				$("#lblData"+i).text(lblDataListAjax[i].fValue);
				if( i < 4 ) {
					$("#lblSCM"+i).text('RIH'+(i*2+2)+' : '+lblSCMAjax['idx'+i]);
				}
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
				<h3>필수안전변수</h3>
				<div class="bc"><span>DCC</span><span>Performance</span><strong>필수안전변수</strong></div>
			</div>
			<!-- //page_title -->
			<form id="safeVarSearch" name=safeVarSearch">
			<input type = "hidden" id="sGrpID" name="sGrpID" value="mimic">
			<input type = "hidden" id="sMenuNo" name="sMenuNo" value = "44">
			<input type = "hidden" id="sDive" name="sDive" value = "D">
			<input type = "hidden" id="sUGrpNo" name="sUGrpNo" value = "3">
			<input type = "hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi }">
			<input type = "hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun }">
			</form>
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col width="200px"/>
                                <col />
                                <col width="140px"/>
                                <col width="160px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>DESCRIPTION</th>
                                    <th>SAFETY LIMIT</th>
                                    <th>VALUE</th>
                                    <th>UNIT</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th>LIN POWER</th>
                                    <td class="tc">＜ 2</td>
                                    <td id="lblData0" class="tr">${lblDataList[0].fValue}</td>
                                    <td class="tc">%FP</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td id="lblData1" class="tr">${lblDataList[1].fValue}</td>
                                    <td class="tc" rowspan="4">MPAG</td>
                                </tr>
                                <tr>
                                    <th>RH4 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td id="lblData2" class="tr">${lblDataList[2].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH6 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td id="lblData3" class="tr">${lblDataList[3].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH8 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td id="lblData4" class="tr">${lblDataList[4].fValue}</td>
                                </tr>
                                <tr>
                                    <th>PZR Level 3A</th>
                                    <td class="tc">≥ 4</td>
                                    <td id="lblData5" class="tr">${lblDataList[5].fValue}</td>
                                    <td class="tc" rowspan="3">M</td>
                                </tr>
                                <tr>
                                    <th>PZR Level 3A</th>
                                    <td class="tc">≥ 4</td>
                                    <td id="lblData6" class="tr">${lblDataList[6].fValue}</td>
                                </tr>
                                <tr>
                                    <th>PZR Level 3A</th>
                                    <td class="tc">≥ 4</td>
                                    <td id="lblData7" class="tr">${lblDataList[7].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td id="lblData8" class="tr">${lblDataList[8].fValue}</td>
                                    <td class="tc" rowspan="4">MPAG</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td id="lblData9" class="tr">${lblDataList[9].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td id="lblData10" class="tr">${lblDataList[10].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td id="lblData11" class="tr">${lblDataList[11].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #1 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td id="lblData12" class="tr">${lblDataList[12].fValue}</td>
                                    <td class="tc" rowspan="4">M</td>
                                </tr>
                                <tr>
                                    <th>S/G #2 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td id="lblData13" class="tr">${lblDataList[13].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #3 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td id="lblData14" class="tr">${lblDataList[14].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #4 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td id="lblData15" class="tr">${lblDataList[15].fValue}</td>
                                </tr>                                  
                            </tbody>
                        </table>
                        <!-- //form_table -->
                    </div>
                    <!-- //form_wrap -->
                </div>
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col width="200px"/>
                                <col />
                                <col width="140px"/>
                                <col width="160px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>DESCRIPTION</th>
                                    <th>SAFETY LIMIT</th>
                                    <th>VALUE</th>
                                    <th>UNIT</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th>LOG POWER</th>
                                    <td class="tc">(＜ -1.6990)</td>
                                    <td id="lblData16" class="tr">${lblDataList[16].fValue}</td>
                                    <td class="tc">DECADE</td>
                                </tr>
                                <tr>
                                    <th>RH2 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td id="lblData17" class="tr">${lblDataList[17].fValue}</td>
                                    <td class="tc" rowspan="4">DEGC</td>
                                </tr>
                                <tr>
                                    <th>RH4 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td id="lblData18" class="tr">${lblDataList[18].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH6 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td id="lblData19" class="tr">${lblDataList[19].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH8 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td id="lblData20" class="tr">${lblDataList[20].fValue}</td>
                                </tr>
                                <tr>
                                    <th>R/B Pr CH-K</th>
                                    <td class="tc">＜ 3.45</td>
                                    <td id="lblData21" class="tr">${lblDataList[21].fValue}</td>
                                    <td class="tc" rowspan="3">KPAD</td>
                                </tr>
                                <tr>
                                    <th>R/B Pr CH-L</th>
                                    <td class="tc">＜ 3.45</td>
                                    <td id="lblData22" class="tr">${lblDataList[22].fValue}</td>
                                </tr>
                                <tr>
                                    <th>R/B Pr CH-M</th>
                                    <td class="tc">＜ 3.45</td>
                                    <td id="lblData23" class="tr">${lblDataList[23].fValue}</td>
                                </tr>
                                <tr>
                                    <th>ROH1 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td id="lblData24" class="tr">${lblDataList[24].fValue}</td>
                                    <td class="tc" rowspan="4">DEGC</td>
                                </tr>
                                <tr>
                                    <th>ROH3 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td id="lblData25" class="tr">${lblDataList[25].fValue}</td>
                                </tr>
                                <tr>
                                    <th>ROH5 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td id="lblData26" class="tr">${lblDataList[26].fValue}</td>
                                </tr>
                                <tr>
                                    <th>ROH7Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td id="lblData27" class="tr">${lblDataList[27].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #1 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td id="lblData28" class="tr">${lblDataList[28].fValue}</td>
                                    <td class="tc" rowspan="4">MPAG</td>
                                </tr>
                                <tr>
                                    <th>S/G #2 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td id="lblData29" class="tr">${lblDataList[29].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #3 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td id="lblData30" class="tr">${lblDataList[30].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #4 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td id="lblData31" class="tr">${lblDataList[31].fValue}</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //form_table -->
                    </div>
                    <!-- //form_wrap -->
                </div>
            </div>
            <!-- //fx_layout -->
			<!-- form_wrap -->
			<div class="form_wrap">
				<!-- form_head -->
				<div class="form_head">
                    <h4>SUB COOLING MARGINE</h4>
					<div class="button">
                        <div class="fx_legend txt_type">
                            <label>단위 (DEGC)</label>
                        </div>
					</div>
				</div>
				<!-- //form_head -->
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="200px"/>
                        <col />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>SAFTY LIMIT > 20</th>
                            <td id="lblSCM0">RIH2 : ${lblSCM.idx0}</td>
                            <td id="lblSCM1">RIH4 : ${lblSCM.idx1}</td>
                            <td id="lblSCM2">RIH6 : ${lblSCM.idx2}</td>
                            <td id="lblSCM3">RIH8 : ${lblSCM.idx3}
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
                <div id="popDiv" style="position:absolute;top:762px;left:1170px">
                	<a class="btn_list" id="cmdLimitnBasePopup" name="cmdLimitnBasePopup" href="#" onclick="javascript:openLayer('modal_1')" style="margin-left:25px">필수안전변수 제한치 및 근거보기</a>
                </div>
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
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
<div class="pop_header">
   <h3>필수 안전 변수 제한치 및 근거</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
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
	                        <col width="200px" />
	                        <col width="180px" />
	                        <col width="200px" />
	                        <col />
	                    </colgroup>
						<thead>
							<tr>
								<th>변 수</th>
								<th>제 한 치</th>
								<th>제한치 근거</th>
								<th>근 거 내 용</th>
							</tr>
						</thead>
	
						<tr>
							<td style="padding-left:8px">LIN POWER</td>
							<td style="padding-left:8px"><2%FP</td>
							<td style="padding-left:8px">EOP-001</td>
							<td style="padding-left:8px">냉각재 고갈 방지 및 연료보호</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px">RIH Pressure</td>
							<td style="padding-left:8px">7.2~10MPAG</td>
							<td style="padding-left:8px">EOP-001</td>
							<td style="padding-left:8px">7.2 : ECC 작동(5.42)방지 및 과냉각 보증<br>10 : LRV 설정치(10.24)이하 유지</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px">PZR Level</td>
							<td style="padding-left:8px">≥4M</td>
							<td style="padding-left:8px">EOP-001</td>
							<td style="padding-left:8px">냉각재 Inventory 확보</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px;color:blue">ROH Pr</td>
							<td style="padding-left:8px;color:blue">(7.2~10MPAG)</td>
							<td style="padding-left:8px;color:blue">EOP-005,006,007,009~015</td>
							<td style="padding-left:8px;color:blue">LOCA를 제외한 사고유형별 비상운전절차서에는<br>RIH/ROH 구분없이 냉각재압력으로 사용</td>
						</tr>
	
	
						<tr>
							<td style="padding-left:8px">S/G Level</td>
							<td style="padding-left:8px">-1~2.5M</td>
							<td style="padding-left:8px">EOP-001</td>
							<td style="padding-left:8px">-1 : SDS#1동작 설정치 (-1.55)이상 유지<br>2.5 : 터빈트립 설정치 (2.96)이하 유지</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px">SUB COOLING MARGINE</td>
							<td style="padding-left:8px">>20℃</td>
							<td style="padding-left:8px">EOP-001</td>
							<td style="padding-left:8px">과냉각 여유도 유지하여 냉각재 냉각능력 유지</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px;color:blue">LOG POWER</td>
							<td style="padding-left:8px;color:blue">(<-1.6990)DECADE</td>
							<td style="padding-left:8px;color:blue">LIN POWER 2%FP를<br>Decade값으로 환산</td>
							<td style="padding-left:8px;color:blue">냉각재 고갈 방지 및 연료 보호</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px;color:blue">RIH Temp</td>
							<td style="padding-left:8px;color:blue">(267~297℃)</td>
							<td style="padding-left:8px;color:blue">EOP-001</td>
							<td style="padding-left:8px;color:blue">7~10MPAG 포화증기온도에 과냉각여유도 20℃반영</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px">R/B Pr</td>
							<td style="padding-left:8px"><3.45KPAD</td>
							<td style="padding-left:8px">EOP-001</td>
							<td style="padding-left:8px">원자로 건물 격리 및 방사능 누출 여부 감시</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px;color:blue">ROH Temp</td>
							<td style="padding-left:8px;color:blue">(267~297℃)</td>
							<td style="padding-left:8px;color:blue">과냉각여유 고려</td>
							<td style="padding-left:8px;color:blue">7~10MPAG 포화증기온도에 과냉각여유도 20℃반영</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px">S/G Pr</td>
							<td style="padding-left:8px">>3.9MPAG</td>
							<td style="padding-left:8px">EOP-001</td>
							<td style="padding-left:8px">터빈 트립 설정치 이상 유지</td>
						</tr>
	
						<tr>
							<td style="padding-left:8px" colspan="4">※참조문서 86-03620-OM-001 REV.3 : ABNORMAL OPERATING MANUAL</td>
						</tr>
					</table>
				</td></tr>
			</table>
		</form>    
	</div>
</div>
<!-- pop_contents -->
<!-- //layer_pop_wrap -->
</body>
</html>

