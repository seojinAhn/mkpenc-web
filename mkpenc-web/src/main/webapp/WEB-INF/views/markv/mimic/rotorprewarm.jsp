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
<script type="text/javascript" src="<c:url value="/resources/js/mimic.js" />" charset="utf-8"></script>
<script type="text/javascript">
var timerOn = true; //true로 변경
var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

$(function () {

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
	
	var lblDateVal = '${SearchTime}';
	$("#lblDate").text(lblDateVal);
	
	$(document.body).delegate('#3', 'click', function() {
		setTimer('3',xyHeader,0);
	});
	$(document.body).delegate('#4', 'click', function() {
		setTimer('4',xyHeader,0);
	});
	$(document.body).delegate('#X', 'click', function() {
		setTimer(hogiHeader,'X',0);
	});

	setTimer(hogiHeader,xyHeader,5000);

});	

function setTimer(hogiHeader,xyHeader,interval) {
	if( interval > 0 ) {
		setTimeout(function() {
			if( timerOn ) {
				var	comSubmit	=	new ComSubmit("rotorprewarmFrm");
				comSubmit.setUrl("/markv/mimic/rotorprewarm");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("rotorprewarmFrm");
		comSubmit.setUrl("/markv/mimic/rotorprewarm");
		comSubmit.addParam("hogiHeader",hogiHeader);
		comSubmit.addParam("xyHeader",xyHeader);
		comSubmit.submit();
	}
}
</script>

</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-markv-header.jspf" %>
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>ROTOR PREWARMING</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>ROTOR PREWARMING</strong></div>
			</div>
			<!-- //page_title -->

            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>ROTOR BORE TEMPERATURE</h4>
                        <div class="line_table_block">
                            <h5></h5>
                            <h5>AVTUAL</h5>
                            <h5>DESIRED</h5>
                        </div>
                        <div class="line_table_block">
                            <h6>HP</h6>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if></label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP INL</h6>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if></label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP EXH</h6>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if></label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h5>ROTOR</h5>
                            <h5>SURF TEMP</h5>
                            <h5>BORE TEMP RATE</h5>
                        </div>
                        <div class="line_table_block">
                            <h6>HP</h6>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if></label>
                                    <span>C/HR</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP INL</h6>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if></label>
                                    <span>C/HR</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP EXH</h6>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if></label>
                                    <span>C/HR</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h6 class="double">MAIN STEAM PRESSURE</h6>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if></label>
                                    <span>bar</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">MAIN STEAM TEMPERATURE</h6>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if></label>
                                    <span>deg C</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">ECCENTRICITY</h6>
                            <div class="summary">
                                <p>
                                    <label><c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if></label>
                                    <span>mm</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block center">
                    <div class="chart_wrap_area line" style="height:284px;">
                        <div class="barchart_layout no_line">
                            <div class="barchart_block">
                                <div class="barchart_item">
                                    <h6>CHEST PRESS</h6>
                                    <div class="barchart" style="width:120px;height:180px;">차트</div>
                                    <div class="summary">
                                        <p>
                                            <label><c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                    		<c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if></label>
                                            <span>bar</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="barchart_gap">
                            </div>
                            <div class="barchart_block">
                                <div class="barchart_item">
                                    <h6>HP EXH PRESS</h6>
                                    <div class="barchart" style="width:120px;height:180px;">차트</div>
                                    <div class="summary">
                                        <p>
                                            <label><c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                    		<c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if></label>
                                            <span>bar</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="barchart_gap">
                            </div>
                            <div class="barchart_block">
                                <div class="barchart_item">
                                    <h6>SPEED</h6>
                                    <div class="barchart" style="width:120px;height:180px;">차트</div> 
                                    <div class="summary">
                                        <p>
                                            <label><c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                    		<c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if></label>
                                            <span>rpm</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table" style="width:280px;">
                        <div class="line_table_block">
                            <h5>ROTOR PREWARMING</h5>
                        </div>
                        <div class="line_table_block">
                            <div class="summary">
                                <p class="side">
                                    <label><c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if></label>
                                    <span>MSV</span>
                                    <label><c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if></label>
                                    <label><c:if test="${lblDataList[21].fValue eq null}">0</c:if>
                                    <c:if test="${lblDataList[21].fValue ne null}">${lblDataList[21].fValue}</c:if></label>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="rotor_off" name="switch_onoff" value="" checked/>
                                    <label class="full" for="rotor_off">OFF</label>
                                    <input type="radio" id="rotor_on" name="switch_onoff" value="" />
                                    <label class="full" for="rotor_on">ON</label>
                                </div>
                            </div>
                            <div class="block_item">
                                <div class="summary">
                                    <p>
                                        <label><c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                        <c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if></label>
                                        <span class="fx_none">%</span>
                                    </p>
                                </div>
                                <div class="switch_button">
                                    <input type="radio" id="rotor_raise" name="switch_rl" value="" checked/>
                                    <label class="full" for="rotor_raise">RAISE</label>
                                    <input type="radio" id="rotor_lower" name="switch_rl" value="" />
                                    <label class="full" for="rotor_lower">LOWER</label>
                                </div>
                            </div>
                        </div>
                    </div>                      
                </div>
            </div>
            <!-- //fx_layout -->
                
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

