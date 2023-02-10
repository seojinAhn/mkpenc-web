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

$(function () {

	$("#sds1Search").click(function(){
		txtReactor_Change();
		
	});
	
	$(document.body).delegate('#lblPHTHP', 'mouseover', function() {
		$('#lblPHTHPExcep' ).css("display", "block");
	});
	$(document.body).delegate('#lblPHTHPExcep', 'click', function() {
		gGraphNo = 0;
		if (gbGraph) {
			
		}
		
	});
	
	$(document.body).delegate('#lblTripPara1', 'mouseover', function() {
		 $('#lblTripPara1' ).css("display", "block");	
	});
	$(document.body).delegate('#lblTripPara2', 'mouseover', function() {
		 $('#lblTripPara2' ).css("display", "block");	
	});
	$(document.body).delegate('#lblTripPara5', 'mouseover', function() {
		 $('#lblTripPara5' ).css("display", "block");	
	});
	
	$(document.body).delegate('#lblTripParaSel', 'click', function(idx) {
		
		if (gbGraph) {
			
		}
		switch (idx) {
    		case 1: gGraphNo = 2;
    				break;
    		case 2: gGraphNo = 1;
    				break;
    		case 5: gGraphNo = 3;
    				break;
    	}    	
		
	});
});

	var gfReactorValue;
	var gbOutput;
	var gbPumpMode;
	var gbOddEven;
	var gfConditionOut;
	var gfPLL4;
	var gfSGLL2;
	var gfPHTLP2O;
	var gfPHTLP2E;
	var gfPHTLP4;
	
	var gGraphNo;
	var gbGraph;
	
	function CalcLinear(fValue, pllMin, pllMax, vMin, vMax, mMin, mMax) {
		var calcLinear = ((mMax - mMin) * (fValue - pllMin) / (pllMax - pllMin) + mMin).toFixed(3) + 'm (';
		calcLinear = calcLinear + ((vMax - vMin) * (fValue - pllMin) / (pllMax - pllMin) + vMin).toFixed(3) + 'V)';
		return calcLinear;
	}
	
	function CalcLinearPress(fValue, pllMin, pllMax, vMin, vMax, mMin, mMax) {
		var calcLinearPress = ((mMax - mMin) * (fValue - pllMin) / (pllMax - pllMin) + mMin).toFixed(3) + 'Mpa (';
		calcLinearPress = calcLinearPress + ((vMax - vMin) * (fValue - pllMin) / (pllMax - pllMin) + vMin).toFixed(3) + 'V)';
		return calcLinearPress;
	}
	
	function getPHTLF(fValue) {
 		
 		var strValue;
 		if (gbPumpMode == 0) {
 			strValue = '48.1% NF (1.325V)';
 		} else {
 			strValue = '80% NF (2.076V)';
 		}
 		
 		//Conditioning Out
 		if (fValue < vgfConditionOut(0, gbOutput)) {
 			strValue = 'Conditioning out';
 		}
 		
 		$('#lblTripset0' ).text(strValue);
 	}
 	
 	function getPLL(fValue) {
 		var strValue;
 		var nState;
 		var i;
 		
 		if (gbPumpMode == 0) {
 			if (fValue < vgfPLL4(0, gbOutput)) {
 				strValue = '2.0m (1.380V)';
            	nState = 0;
 			} else if (fValue >= vgfPLL4(0, gbOutput)) {
 				strValue = '4.0m (1.860V)';
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
 		
 		$('#lblTripset1' ).text(strValue);
 	}
 	
 	function getSGLL(fValue) {
		var strValue;
		var strValueCondition;
		var nState;
		var i;
		
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
		
		$('#lblTripset2' ).text(strValue);
 	}
 	
 	function getPHTLP(fValue) {
 		var strValue;
 		var nState;
 		var i;
 		
 		if (gbPumpMode == 0) {
 			if (gbOddEven = 0) {
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
		if (fValue < vgfConditionOut(1, gbOutput)) {
			strValue = 'Conditioning out';
        	nState = -1;
		}
		
		$('#lblTripset5' ).text(strValue);
 		
 	}

	gfReactorValue = 100;
    gbOutput = 1;
    gbPumpMode = 0;
    gbOddEven = 1;

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
    
    
    gbGraph = false;
	
	
	function cboPumpMode_Click() {

		gbPumpMode = document.getElementById('cboPumpMode').value;
		var fValue = document.getElementById('txtReactor').value;
		
		getPHTLF(fValue);
		getPLL(fValue);
		getSGLL(fValue);
		getPHTLP(fValue);
	}	
 
 	function optOutput_Click(idx) {
 	
 		gbOutput = idx;
 		var fValue = document.getElementById('txtReactor').value;
		
		getPHTLF(fValue);
		getPLL(fValue);
		getSGLL(fValue);
		getPHTLP(fValue);

	}
	
 	function optPumpMode_Click(idx) {
 	
 		gbOddEven = idx;
 		var fValue = document.getElementById('txtReactor').value;
		
		getPHTLF(fValue);
		getPLL(fValue);
		getSGLL(fValue);
		getPHTLP(fValue);

	}
 
	function txtReactor_Change() {
		var fValue = document.getElementById('txtReactor').value;
		
		if(isNaN(fValue)) {
 			alert("숫자를 입력하십시오.");
 		} else {
		
		getPHTLF(fValue);
		getPLL(fValue);
		getSGLL(fValue);
		getPHTLP(fValue);
		}
	}
	
	function userControl_MouseMove() {
		var i;
		for (i=0; i<=6; i++) {
			$('#lblTripPara'+i ).css("display", "none");
		}
		$('#lblPHTHPExcep' ).css("display", "none");
	}
	
	function userControl_Terminate() {
		if (gbGraph) {
		
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
				<h3>SDS #1</h3>
				<div class="bc"><span>DCC</span><span>Tip</span><strong>SDS #1</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>원자로 출력</label>
                            <div class="fx_form">
                                <input type="text" id="txtReactor" name="txtReactor" class="fx_none" style="width:140px;">
                                <label><input type="radio" name="optOutput" value="0" onclick="optOutput_Click(this.value)" checked>%</label>
                                <label><input type="radio" name="optOutput" value="1" onclick="optOutput_Click(this.value)">V</label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>PHT Pump Mode</label>
                            <div class="fx_form">
                                <select class="fx_none" id="cboPumpMode" name="cboPumpMode" style="width:140px;" onchange="cboPumpMode_Click();">
                                    <option value="2">2</option>
                                    <option value="4">4</option>
                                </select>
                                <label><input type="radio" name="optPumpMode" value="0" onclick="optPumpMode_Click(this.value)" checked>ODD</label>
                                <label><input type="radio" name="optPumpMode" value="1" onclick="optPumpMode_Click(this.value)">EVEN</label>
                            </div>
						</div>
                    </div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="sds1Search" name="sds1Search">Search</a>
				</div>
				<!-- //fx_srch_button -->
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
                            <th><div id="lblTripPara0" name="lblTripPara0">PHT Low Flow</div></th>
                            <td colspan="2" class="tc">2,4</td>
                            <td class="tc">-</td>
                            <td class="tc"><div id="lblTripset0" name="lblTripset0"> </div></td>
                        </tr>
                        <tr>
                            <th rowspan="2"><div id="lblTripPara1" name="lblTripPara1">Pressurizer Low Level</div></th>
                            <td colspan="2" class="tc">2</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇AVEC ＜ 40% FP(1.7V)</label>
                                    <label>◇AVEC ＞＝ 40% FP(1.7V)</label>
                                </div>
                            </td>
                            <td rowspan="2" class="tc"><div id="lblTripset1" name="lblTripset1"> </div></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tc bd_l_line">4</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇AVEC ＜ 40% FP(1.7V)</label>
                                    <label>Linear function of 40% FP(1.7V) ＜ ◇AVEC ＜ 55% FP(2.15V)</label>
                                    <label>55% FP(2.15V) ＜＝ ◇AVEC ＜ 75% FP(2.75V)</label>
                                    <label>Linear function of 75% FP(2.75V) ＜ ◇AVEC ＜＝ 95% FP(3.35V)</label>
                                    <label>◇AVEC ＞ 95% FP(3.35V)</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><div id="lblTripPara2" name="lblTripPara2">S/G Low Level</div></th>
                            <td colspan="2" class="tc">-</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>Linear function of 0% FP(0.5V) ＜ ◇AVEC ＜ 90% FP(3.2V)</label>
                                    <label>◇AVEC ＞＝ 90% FP(3.2V)</label>
                                </div>
                            </td>
                            <td class="tc"><div id="lblTripset2" name="lblTripset2"> </div></td>
                        </tr>
                        <tr>
                            <th><div id="lblTripPara3" name="lblTripPara3">Mod. High Temperature</div></th>
                            <td colspan="2" class="tc">-</td>
                            <td class="tc">-</td>
                            <td class="tc"><div id="lblTripset3" name="lblTripset3">87℃ (2.988V)</div></td>
                        </tr>
                        <tr id="lblPHTHP" name="lblPHTHP">
                            <th><div id="lblTripPara4" name="lblTripPara4">PHT High Pr'</div></th>
                            <td colspan="2" class="tc">2,4</td>
                            <td class="tc">-</td>
                            <td class="tc" ><div id="lblTripset4" name="lblTripset4">10.45MPa (3.802V)</div><div id="lblPHTHPExcep" name="lblPHTHPExcep" style="display:none;">*예외</div></td>
                        </tr>
                        <tr>
                            <th rowspan="3"><div id="lblTripPara5" name="lblTripPara5">PHT Low Pr'</div></th>
                            <td rowspan="2" class="tc">2</td>
                            <td class="tc">ODD</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇LINC ＜＝ 0% FP(0.5V)</label>
                                    <label>Linear function of 0% FP(0.5V) ＜ ◇LINC ＜ 64.9875% FP(2.233V)</label>
                                    <label>◇LINC ＞＝ 64.9875% FP(2.233V)</label>
                                </div>
                            </td>
                            <td rowspan="3" class="tc"><div id="lblTripset5" name="lblTripset5"> </div></td>
                        </tr>
                        <tr>
                            <td class="tc bd_l_line">EVEN</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇LINC ＜＝ 0% FP(0.5V)</label>
                                    <label>Linear function of 0% FP(0.5V) ＜ ◇LINC ＜ 19.9875% FP(1.566V)</label>
                                    <label>◇LINC ＞＝ 19.9875% FP(1.566V)</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tc bd_l_line">4</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇LINC ＜＝ 0% FP(0.5V)</label>
                                    <label>Linear function of 0% FP(0.5V) ＜ ◇LINC ＜ 94.9875% FP(3.033V)</label>
                                    <label>◇LINC ＞＝ 94.9875% FP(3.033V)</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><div id="lblTripPara6" name="lblTripPara6">S/G Feed Line Low Pr'<div></th>
                            <td colspan="2" class="tc">-</td>
                            <td class="tc">-</td>
                            <td class="tc"><div id="lblTripset6" name="lblTripset6">3.90 MPa (3.163V)</div></td>
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
                        <label class="fx_none flex_end" style="width:100px;">PHTLF,PHTLP :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 0.0794%FP</label>
                        <label>(2.45V)</label>
                    </div>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">PLL,SGLL :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 0.794%FP</label>
                        <label>(2.95V)</label>
                        <label>AND</label>
                        <label>Ø AVEC ＜ 8.33%FP (0.75V)</label>
                    </div>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">SGFLP :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 7.15%FP</label>
                        <label>(3.427V)</label>
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
</body>
</html>
