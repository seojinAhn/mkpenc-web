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
<script type="text/javascript" src="<c:url value="/resources/js/tip.js" />" charset="utf-8"></script>
<script type="text/javascript">
var timerOn = false;
	var gfReactorValue = 100;
	var gbOutput = 1;
	var gbPumpMode = 1;
	var gbOddEven = 1;
	var gfConditionOut = 0;
	var gfPHTDP = 0;
	var gfPLL4 = 0;
	var gfSGLL2 = 0;
	var gfPHTLP2O = 0;
	var gfPHTLP2E = 0;
	var gfPHTLP4 = 0;
	
	var gGraphNo = 0;
	var gbGraph = false;

	$(function () {
		$("#txtReactor").val(gfReactorValue);
		if( gbOutput == 1 ) {
			$("#optOutput").prop("checked",true);
		} else {
			$("#optOutput").prop("checked",false);
		}
		$("#cboPumpMode").val(gbPumpMode);
		if( gbOddEven == 0 ) {
			$("#optPumpMode0").prop("checked",true);
			$("#optPumpMode1").prop("checked",false);
		} else {
			$("#optPumpMode0").prop("checked",false);
			$("#optPumpMode1").prop("checked",true);
		}
		
		txtReactor_Change();

		
		$(document.body).delegate('#txtReactor', 'keyup', function() {
			txtReactor_Change();
		});
		
		$(document.body).delegate('#optOutput', 'click', function() {
			$("#optOutput").prop("checked",true);
			optOutput_Click();
		});
		
		$(document.body).delegate('#optPumpMode0', 'click', function() {
			$("#optPumpMode0").prop("checked",true);
			$("#optPumpMode1").prop("checked",false);
			optPumpMode_Click(0);
		});
		
		$(document.body).delegate('#optPumpMode1', 'click', function() {
			$("#optPumpMode0").prop("checked",false);
			$("#optPumpMode1").prop("checked",true);
			optPumpMode_Click(1);
		});
		
		$(document.body).delegate('#cboPumpMode', 'change', function() {
			cboPumpMode_Click();
		});
		
		$(document.body).delegate('#lblTripPara1', 'click', function() {
			openLayer('modal_1');
		});
		
		$(document.body).delegate('#lblTripPara2', 'click', function() {
			openLayer('modal_1');
		});
		
		$(document.body).delegate('#lblTripPara5', 'click', function() {
			//openLayer('modal_1');
		});
	});
	
	function CalcLinear(fValue, pllMin, pllMax, vMin, vMax, mMin, mMax) {
		var calcLinear = ((mMax - mMin) * (fValue - pllMin) / (pllMax - pllMin) + mMin).toFixed(3) + 'm ('
					   + ((vMax - vMin) * (fValue - pllMin) / (pllMax - pllMin) + vMin).toFixed(3) + 'V)';
		return calcLinear;
	}
	
	function CalcLinearPress(fValue, pllMin, pllMax, vMin, vMax, mMin, mMax) {
		var calcLinearPress = ((mMax - mMin) * (fValue - pllMin) / (pllMax - pllMin) + mMin).toFixed(3) + 'Mpa ('
							+ ((vMax - vMin) * (fValue - pllMin) / (pllMax - pllMin) + vMin).toFixed(3) + 'V)';
		return calcLinearPress;
	}
	
	function getPHTDP(fValue) {
		var strValue = '';
		
		if (fValue > vgfPHTDP(gbOutput)) {
			strValue = '950KPa (2.610V) 이하';
			$('#shpReactor11').css("background","#ebf0cf");
		} else {
			strValue = '-';
			$('#shpReactor11').css("background","");
		}
		$('#lblDelay0').text(strValue);
		
		if (gbPumpMode == 0) {
 			strValue = '450KPa (1.710V)';
 		} else {
 			strValue = '*1G, 3G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>'
 					 + '215KPa (1.287V) 이하<br>'
 					 + '<br>'
 					 + '*2G, 4G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>'
 					 + '200KPa (1.260V) 이하';
 		}
 		
 		//Conditioning Out
 		if (fValue < vgfConditionOut(0, gbOutput)) {
 			strValue = 'Conditioning out';
			$('#shpReactor10').css("background","");
 		} else {
			$('#shpReactor10').css("background","#ebf0cf");
 		}

 		$('#lblTripset0').empty();
 		$('#lblTripset0').append(strValue);
	}
	
	function getPLL(fValue) {
 		var strValue = '';
 		var nState = -1;
 		
 		if (gbPumpMode == 0) {
 			if (fValue < vgfPLL4(0, gbOutput)) {
 				strValue = '2.0m (1.380V)';
            	nState = 0;
 			} else if (fValue >= vgfPLL4(0, gbOutput)) {
 				strValue = '1.860V (4.0m)';
            	nState = 1;
 			}
 		} else {
 			if (fValue <= vgfPLL4(0, gbOutput)) {
 				strValue = '2.0m (1.380V)';
            	nState = 2;
 			} else if (fValue > vgfPLL4(0, gbOutput) && fValue < vgfPLL4(1, gbOutput)) {
 				strValue = CalcLinear(fValue, vgfPLL4(0, gbOutput), vgfPLL4(1, gbOutput), 1.38, 1.86, 2, 4);
            	nState = 3;
 			} else if (fValue >= vgfPLL4(1, gbOutput) && fValue <= vgfPLL4(2, gbOutput)) {
 				strValue = '4.0m (1.860V)';
            	nState = 4;
 			} else if (fValue > vgfPLL4(2, gbOutput) && fValue <= vgfPLL4(3, gbOutput)) {
 				strValue = CalcLinear(fValue, vgfPLL4(2, gbOutput), vgfPLL4(3, gbOutput), 1.86, 2.643, 4, 7.26);
            	nState = 5;
 			} else {
 				strValue = '7.26m (2.643V)';
            	nState = 6;
 			} 		
 		}
 		
 		//Conditioning Out
 		if (fValue < vgfConditionOut(1, gbOutput)) {
 			strValue = 'Conditioning out';
        	nState = -1;
 		}
 		
 		$('#lblTripset1').text(strValue);
 		
 		for( var i=0;i<7;i++ ) {
	 		$("#shpReactor2"+i).css("background", "");
 		}
 		
 		if( nState > -1 ) $('#shpReactor2'+nState).css("background", "#ebf0cf");
 	}
	
	function getSGLL(fValue) {
		var strValue = '';
		var strValueCondition = '';
		var nState = 0;
		
		if (fValue >= vgfSGLL2(0, gbOutput) && fValue < vgfSGLL2(1, gbOutput)) {
			strValue = CalcLinear(fValue, vgfSGLL2(0, gbOutput), vgfSGLL2(1, gbOutput), 1.554, 3.473, -1.55, 1.74);
        	strValueCondition = 'Linear function of 0% FP(0.5V)< ΦAVEC < 90% FP(3.2V)';
		} else {
			strValue = '1.74m (3.473V)';
        	strValueCondition = 'ΦAVEC >= 90% FP(3.2V)';
		}
		
		//Conditioning Out
		if (fValue < vgfConditionOut(1, gbOutput)) {
			strValue = 'Conditioning out';
        	nState = -1;
		}
		
		$('#lblTripset2').text(strValue);
 		
 		for( var i=0;i<3;i++ ) {
	 		$("#shpReactor3"+i).css("background", "");
 		}
 		
 		if( nState > -1 ) $('#shpReactor3'+nState).css("background", "#ebf0cf");
 	}
 	
 	function getPHTHP(fValue) {
 		var strValue = '';
 		
 		if (fValue > vgfPHTDP(gbOutput)) {
 			strValue = '950KPa (2.610V) 이하';
			$('#shpReactor41').css("background","#ebf0cf");
 		} else {
 			strValue = '-';
			$('#shpReactor40').css("background","#ebf0cf");
 		}
 		
 		$('#lblDelay1').text(strValue);
 		
 		strValue = '11.62MPa (4.118V)';
 	
 		//Conditioning Out
		if (fValue < vgfConditionOut(0, gbOutput)) {
			strValue = 'Conditioning out';
			$('#shpReactor40').css("background","");
		} else {
			$('#shpReactor40').css("background","#ebf0cf");
		}
		
		$('#lblTripset3').text(strValue); 	
 	}
 	
 	function getPHTLP(fValue) {
 		var strValue = '';
 		var nState = -1;
 		
 		if (gbPumpMode == 0) {
 			if (gbOddEven == 0) {
 				if (fValue <= vgfPHTLP2O(0, gbOutput)) {
 					strValue = '5.9MPa (1.755V)';
                	nState = 0;
 				} else if (fValue > vgfPHTLP2O(0, gbOutput) && fValue < vgfPHTLP2O(1, gbOutput)) {
 					strValue = CalcLinearPress(fValue, vgfPHTLP2O(0, gbOutput), vgfPHTLP2O(1, gbOutput), 1.755, 1.955, 5.9, 6.9);
                	nState = 1;
 				} else if (fValue >= vgfPHTLP2O(1, gbOutput)) {
 					strValue = '7.4MPa (2.43V)';
                	nState = 2;
 				}
 			} else {
 				if (fValue <= vgfPHTLP2E(0, gbOutput)) {
 					strValue = '6.9MPa (2.205V)';
                	nState = 3;
 				} else if (fValue > vgfPHTLP2E(0, gbOutput) && fValue < vgfPHTLP2E(1, gbOutput)) {
 					strValue = CalcLinearPress(fValue, vgfPHTLP2E(0, gbOutput), vgfPHTLP2E(1, gbOutput), 2.205, 2.655, 6.9, 7.9);
                	nState = 4;
 				} else {
 					strValue = '7.9MPa (2.655V)';
                	nState = 5;
 				} 		
 			}			
 		} else {
 			if (fValue <= vgfPHTLP4(0, gbOutput)) {
 				strValue = '6.15MPa (1.868V)';
            	nState = 6;
 			} else if (fValue > vgfPHTLP4(0, gbOutput) && fValue < vgfPHTLP4(1, gbOutput)) {
 				strValue = CalcLinearPress(fValue, vgfPHTLP4(0, gbOutput), vgfPHTLP4(1, gbOutput), 0.5, 3.015, 6.15, 8.7);
            	nState = 7;
 			} else {
 				strValue = '8.7MPa (3.015V)';
            	nState = 8;
 			}
 		}
 		
 		//Conditioning Out
		if (fValue < vgfConditionOut(0, gbOutput)) {
			strValue = 'Conditioning out';
        	nState = -1;
		}
		
		$('#lblTripset4').text(strValue);
 		
 		for( var i=0;i<9;i++ ) {
	 		$("#shpReactor5"+i).css("background", "");
 		}
 		
 		if( nState > -1 ) $('#shpReactor5'+nState).css("background", "#ebf0cf");
 	}

    function vgfConditionOut(int1, int2)  {
    	if (int2 == 0) {
    		switch (int1) {
    			case 0: return 2.45;
    					break;
    			case 1: return 0.75;
    					break;
    			case 2: return 3.427;
    					break;
    		}    	
    	} else if (int2 == 1) {
    		switch (int1) {
    			case 0: return 0.0794;
    					break;
    			case 1: return 8.33;
    					break;
    			case 2: return 7.15;
    					break;
    		}    	
    	}
    }
    
    function vgfPHTDP(int1) {
    	switch (int1) {
    		case 0: return 2.6;
    				break;
    		case 1: return 70;
    				break;
    	}
    }
    
    function vgfPLL4(int1, int2)  {
    	if (int2 == 0) {
    		switch (int1) {
    			case 0: return 1.7;
    					break;
    			case 1: return 2.15;
    					break;
    			case 2: return 2.75;
    					break;
    			case 3: return 3.35;
    					break;
    		}    	
    	} else if (int2 == 1) {
    		switch (int1) {
    			case 0: return 40;
    					break;
    			case 1: return 55;
    					break;
    			case 2: return 75;
    					break;
    			case 3: return 95;
    					break;
    		}    	
    	}
    }
    
    function vgfSGLL2(int1, int2)  {
    	if (int2 == 0) {
    		switch (int1) {
    			case 0: return 0.5;
    					break;
    			case 1: return 3.2;
    					break;
    		}    	
    	} else if (int2 == 1) {
    		switch (int1) {
    			case 0: return 0;
    					break;
    			case 1: return 90;
    					break;
    		}    	
    	}
    }
    
    function vgfPHTLP2O(int1, int2)  {
    	if (int2 == 0) {
    		switch (int1) {
    			case 0: return 0.5;
    					break;
    			case 1: return 2.233;
    					break;
    		}    	
    	} else if (int2 == 1) {
    		switch (int1) {
    			case 0: return 0;
    					break;
    			case 1: return 64.9875;
    					break;
    		}    	
    	}
    }
    
    function vgfPHTLP2E(int1, int2)  {
    	if (int2 == 0) {
    		switch (int1) {
    			case 0: return 0.5;
    					break;
    			case 1: return 1.566;
    					break;
    		}    	
    	} else if (int2 == 1) {
    		switch (int1) {
    			case 0: return 0;
    					break;
    			case 1: return 19.9875;
    					break;
    		}    	
    	}
    }
    
    function vgfPHTLP4(int1, int2)  {
    	if (int2 == 0) {
    		switch (int1) {
    			case 0: return 0.5;
    					break;
    			case 1: return 3.033;
    					break;
    		}    	
    	} else if (int2 == 1) {
    		switch (int1) {
    			case 0: return 0;
    					break;
    			case 1: return 94.9875;
    					break;
    		}    	
    	}
    }
    
    function cboPumpMode_Click() {
		gbPumpMode = $("#cboPumpMode option:selected").val()*1;
		var fValue = $("#txtReactor").val()*1;

		getPHTDP(fValue);
		getPLL(fValue);
		getSGLL(fValue);
		getPHTHP(fValue);
		getPHTLP(fValue);
	}	
 
 	function optOutput_Click() {
 		gbOutput = $("#input:radio[id='optOutput']").is("checked") ? 0 : 1;
		var fValue = $("#txtReactor").val()*1;

		getPHTDP(fValue);
		getPLL(fValue);
		getSGLL(fValue);
		getPHTHP(fValue);
		getPHTLP(fValue);

	}
	
 	function optPumpMode_Click(idx) {
 		gbOddEven = idx;
		var fValue = $("#txtReactor").val()*1;

		getPHTDP(fValue);
		getPLL(fValue);
		getSGLL(fValue);
		getPHTHP(fValue);
		getPHTLP(fValue);

	}
 
	function txtReactor_Change() {
		var fValue = $("#txtReactor").val()*1;
		
		if(isNaN(fValue)) {
 			alert("숫자를 입력하십시오.");
 		} else {
			getPHTDP(fValue);
			getPLL(fValue);
			getSGLL(fValue);
			getPHTHP(fValue);
			getPHTLP(fValue);
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
				<h3>SDS #2</h3>
				<div class="bc"><span>DCC</span><span>Tip</span><strong>SDS #2</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>원자로 출력</label>
                            <div class="fx_form">
                                <input type="text" id="txtReactor" class="fx_none" style="width:140px;">
                                <label><input type="radio" id="optOutput" value="1">%</label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>PHT Pump Mode</label>
                            <div class="fx_form">
                                <select class="fx_none" id="cboPumpMode" style="width:140px;">
                                    <option value="0">2</option>
                                    <option value="1">4</option>
                                </select>
                                <label><input type="radio" id="optPumpMode0" value="0">ODD</label>
                                <label><input type="radio" id="optPumpMode1" value="1">EVEN</label>
                            </div>
						</div>
                    </div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->            
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="300px" />
                        <col width="60px" />
                        <col width="90px" />
                        <col />
                        <col width="280px" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">TRIP PARAMETER</th>
                            <th colspan="3">설정치</th>
                            <th rowspan="2">TRIP SETPOINT</th>
                        </tr>
                        <tr>
                            <th colspan="2" class="bd_l_line">PHT PUMP</th>
                            <th>REACTOR 출력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th rowspan="4"><label id="lblTripPara0">PHT Core Differential Pressure</label></th>
                            <td colspan="2" class="tc">4</td>
                            <td rowspan="3" class="tc"><div id="shpReactor10" style="min-height:105px;min-width:641px;display:flex;flex:1;justify-content:center;align-items:center"><label>즉시 TRIP</label></div></td>
                            <td rowspan="3" class="tc">
                                <div class="fx_form column center">
									<label id="lblTripset0">
										*1G, 3G<br>
					 					215KPa (1.287V) 이하<br>
					 					<br>
					 					*2G, 4G<br>
					 					200KPa (1.260V) 이하
									</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="2" class="tc bd_l_line">2</td>
                            <td class="tc">ODD</td>
                        </tr>
                        <tr>
                            <td class="tc bd_l_line">EVEN</td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tc bd_l_line">-</td>
                            <td class="tc"><div id="shpReactor11" style="min-height:29px;display:flex;flex:1;justify-content:center;align-items:center">지연 TRIP(ΦAVEC ＞ 70% FP)</div></td>
                            <td class="tc"><label id="lblDelay0"> </label></td>
                        </tr>                        
                        <tr>
                            <th rowspan="2"><label id="lblTripPara1"><a href="#" style="color:#6d6d6d">Pressurizer Low Level</a></label></th>
                            <td colspan="2" class="tc">2</td>
                            <td class="tc">
                                <div class="fx_form column center" id="shpReactor20" style="min-height:20px">
                                    <label>ΦAVEC ＜ 40% FP(1.7V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor21" style="min-height:20px;margin-left:0px">
                                    <label>ΦAVEC ＞＝ 40% FP(1.7V)</label>
                                </div>
                            </td>
                            <td rowspan="2" class="tc"><label id="lblTripset1"> </label></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tc bd_l_line">4</td>
                            <td class="tc">
                                <div class="fx_form column center" id="shpReactor22" style="min-height:20px">
                                    <label>ΦAVEC ＜ 40% FP(1.7V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor23" style="min-height:20px;margin-left:0px">
                                    <label>Linear function of 40% FP(1.7V) ＜ ΦAVEC ＜ 55% FP(2.15V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor24" style="min-height:20px;margin-left:0px">
                                    <label>55% FP(2.15V) ＜＝ ΦAVEC ＜ 75% FP(2.75V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor25" style="min-height:20px;margin-left:0px">
                                    <label>Linear function of 75% FP(2.75V) ＜ ΦAVEC ＜＝ 95% FP(3.35V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor26" style="min-height:20px;margin-left:0px">
                                    <label>ΦAVEC ＞ 95% FP(3.35V)</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><label id="lblTripPara2"><a href="#" style="color:#6d6d6d">S/G Low Level</a></label></th>
                            <td colspan="2" class="tc">-</td>
                            <td class="tc">
                                <div class="fx_form column center" id="shpReactor30" style="min-height:20px">
                                    <label>ΦAVEC ＜＝ 0% FP(0.5V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor31" style="min-height:20px;margin-left:0px">
                                    <label>Linear function of 0% FP(0.5V) ＜ ΦAVEC ＜ 90% FP(3.2V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor32" style="min-height:20px;margin-left:0px">
                                    <label>ΦAVEC ＞＝ 90% FP(3.2V)</label>
                                </div>
                            </td>
                            <td class="tc"><label id="lblTripset2"> </label></td>
                        </tr>
                        <tr>
                            <th rowspan="2"><label id="lblTripPara3">PHT High Pr'</label></th>
                            <td rowspan="2" colspan="2" class="tc">-</td>
                            <td class="tc"><div id="shpReactor40" style="min-height:29px;display:flex;flex:1;justify-content:center;align-items:center">즉시 TRIP</div></td>
                            <td class="tc"><label id="lblTripset3"> </label></td>
                        </tr>
                        <tr>
                            <td class="tc bd_l_line"><div id="shpReactor41" style="min-height:29px;display:flex;flex:1;justify-content:center;align-items:center">지연 TRIP(ΦLINC ＞ 70% FP)</div></td>
                            <td class="tc"><label id="lblDelay1"> </label></td>
                        </tr>
                        <tr>
                            <th rowspan="3"><label id="lblTripPara4">PHT Low Pr'</label></th>
                            <td rowspan="2" class="tc">2</td>
                            <td class="tc">ODD</td>
                            <td class="tc">
                                <div class="fx_form column center" id="shpReactor50" style="min-height:20px">
                                    <label>ΦLINC ＜＝ 0% FP(0.5V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor51" style="min-height:20px;margin-left:0px">
                                    <label>Linear function of 0% FP(0.5V) ＜ ΦLINC ＜ 64.9875% FP(2.233V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor52" style="min-height:20px;margin-left:0px">
                                    <label>ΦLINC ＞＝ 64.9875% FP(2.233V)</label>
                                </div>
                            </td>
                            <td rowspan="3" class="tc"><label id="lblTripset4"> </label></td>
                        </tr>
                        <tr>
                            <td class="tc bd_l_line">EVEN</td>
                            <td class="tc">
                                <div class="fx_form column center" id="shpReactor53" style="min-height:20px">
                                    <label>ΦLINC ＜＝ 0% FP(0.5V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor54" style="min-height:20px;margin-left:0px">
                                    <label>Linear function of 0% FP(0.5V) ＜ ΦLINC ＜ 19.9875% FP(1.566V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor55" style="min-height:20px;margin-left:0px">
                                    <label>ΦLINC ＞＝ 19.9875% FP(1.566V)</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tc bd_l_line">4</td>
                            <td class="tc">
                                <div class="fx_form column center" id="shpReactor56" style="min-height:20px">
                                    <label>ΦLINC ＜＝ 0% FP(0.5V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor57" style="min-height:20px;margin-left:0px">
                                    <label>Linear function of 0% FP(0.5V) ＜ ΦLINC ＜ 94.9875% FP(3.033V)</label>
                                </div>
                                <div class="fx_form column center" id="shpReactor58" style="min-height:20px;margin-left:0px">
                                    <label>ΦLINC ＞＝ 94.9875% FP(3.033V)</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><label id="lblTripPara5"><a href="#" style="color:#6d6d6d">S/G Feed Line Low Pr'</a></label></th>
                            <td colspan="2" class="tc">-</td>
                            <td class="tc"><div id="shpReactor60">-</div></td>
                            <td class="tc"><label id="lblTripset5">3.90MPa (3.163V)</label></td>
                        </tr>                        
                    </tbody>
                </table>
                <!-- //form_table -->
            </div>
            <!-- //form_wrap -->
            <div class="fx_comment">
                <div class="fx_form_multi column">
                    <label class="title">* Conditioning Out 조건</label>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">PHTDT :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 5%FP</label>
                    </div>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">PLL :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 1%FP</label>
                        <label>AND</label>
                        <label>Ø AVEC ＜ 10%FP</label>
                    </div>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">SGLL :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 2%FP</label>
                        <label>AND</label>
                        <label>Ø AVEC ＜ 10%FP</label>
                    </div>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">PHTLP :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 0.3%FP</label>
                    </div>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">SGFLP :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 9%FP</label>
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
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
<div class="pop_header">
   <h3>PHT High Pr` 예외</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
</div>
<!-- //header_wrap -->
<!-- pop_contents -->
<div class="pop_contents" style="max-height:500px;">
	<!-- form_wrap -->
	<div class="form_wrap">
 		<!-- form_table -->
		<form id="setbackinfo" name="setbackinfo">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td valign="top" align="center">
					<table class="form_table">
	                    <colgroup>
	                        <col width="180px" />
	                        <col width="90px" />
	                        <col width="180px" />
	                        <col width="180px" />
	                        <col width="180px" />
	                    </colgroup>
						<thead>
							<tr>
								<th rowspan="2">Trip Parameter</th>
								<th rowspan="2">Device Code</th>
								<th colspan="3">Trip Setpoint</th>
							</tr>
							<tr>
								<th class="bd_l_line">4 Pumps</th>
								<th>P1/P3</th>
								<th>P2/P4</th>
							</tr>
						</thead>
						<tbody style="text-align:center">
							<tr>
								<td class="bd_l_line" rowspan="4">PHTHP²<br>(immediate trip)</td>
								<td>68233-PT1D</td>
								<td>3.802V[10.45 Mpa(g)]</td>
								<td>3.802V[10.45 Mpa(g)]</td>
								<td>3.802V[10.45 Mpa(g)]</td>
							</tr>
							<tr>
								<td class="bd_l_line"><font style="color:#ffffff">68233</font>-PT2D</td>
								<td>3.802V[10.45 Mpa(g)]</td>
								<td>3.708V[10.24 Mpa(g)]</td>
								<td>3.802V[10.45 Mpa(g)]</td>
							</tr>
							<tr>
								<td class="bd_l_line"><font style="color:#ffffff">68233</font>-PT3D</td>
								<td>3.802V[10.45 Mpa(g)]</td>
								<td>3.802V[10.45 Mpa(g)]</td>
								<td>3.802V[10.45 Mpa(g)]</td>
							</tr>
							<tr>
								<td class="bd_l_line"><font style="color:#ffffff">68233</font>-PT4D</td>
								<td>3.802V[10.45 Mpa(g)]</td>
								<td>3.708V[10.24 Mpa(g)]</td>
								<td>3.802V[10.45 Mpa(g)]</td>
							</tr>
							<tr>
								<td class="bd_l_line" rowspan="4">PHTHP²<br>(delayed trip)</td>
								<td>68233-PT1D</td>
								<td>3.708V[10.24 Mpa(g)]</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="bd_l_line"><font style="color:#ffffff">68233</font>-PT2D</td>
								<td>3.708V[10.24 Mpa(g)]</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="bd_l_line"><font style="color:#ffffff">68233</font>-PT3D</td>
								<td>3.708V[10.24 Mpa(g)]</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="bd_l_line"><font style="color:#ffffff">68233</font>-PT4D</td>
								<td>3.708V[10.24 Mpa(g)]</td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
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

