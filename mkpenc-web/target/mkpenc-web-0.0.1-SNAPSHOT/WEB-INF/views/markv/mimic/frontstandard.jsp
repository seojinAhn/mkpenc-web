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

var timerOn = false; //true로 변경

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
	

});	


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
				<h3>PROTECTIVE TESTS FRONT STANDARD</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>TESTs</span><strong>PROTECTIVE TESTS FRONT STANDARD</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap" style="min-height:600px;">
                <div class="fx_layout no_mg" style="position:absolute;top:40px;left:170px;width:510px;height:124px;">
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>ACTUAL MECH O/S</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_mech" name="switch_mech" value="" checked/>
                                    <label for="off_mech">STOP</label>
                                    <input type="radio" id="on_mech" name="switch_mech" value="" />
                                    <label for="on_mech">START</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>RESET PEAK SPEED</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <div class="chart_block_contents">
                                <div class="switch_button center">
                                    <input type="radio" id="reset" name="switch_reset" value=""/>
                                    <label for="reset">RESET</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_layout no_mg" style="position:absolute;top:40px;left:700px;width:510px;height:480px;">
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>MECH TRIP SYS</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>1. LOCKOUT</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button center">
                                    <input type="radio" id="off_lock" name="switch_lock" value=""/>
                                    <label for="off_lock">LOCK</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>2. MECH O/S</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_mech_os" name="switch_mech_os" value="" checked/>
                                    <label for="off_mech_os">OFF</label>
                                    <input type="radio" id="on_mech_os" name="switch_mech_os" value="" />
                                    <label for="on_mech_os">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>MECH PISTON TEST 1</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_test1" name="switch_test1" value="" checked/>
                                    <label for="off_test1">OFF</label>
                                    <input type="radio" id="on_test1" name="switch_test1" value="" />
                                    <label for="on_test1">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>MECH PISTON TEST 2</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_test2" name="switch_test2" value="" checked/>
                                    <label for="off_test2">OFF</label>
                                    <input type="radio" id="on_test2" name="switch_test2" value="" />
                                    <label for="on_test2">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>3. UNLOCK</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button center">
                                    <input type="radio" id="off_unlock" name="switch_unlock" value="" checked/>
                                    <label for="off_unlock">UNLOCK</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>ELECT TRIP SYS</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>1. LOCKOUT</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_elect_lock" name="switch_elect_lock" value=""/>
                                    <label for="off_elect_lock">LOCK</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>2. ELECT O/S</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_elect_os" name="switch_elect_os" value="" checked/>
                                    <label for="off_elect_os">OFF</label>
                                    <input type="radio" id="on_elect_os" name="switch_elect_os" value="" />
                                    <label for="on_elect_os">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>ELECT TRIP</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_elect_trip" name="switch_elect_trip" value="" checked/>
                                    <label for="off_elect_trip">OFF</label>
                                    <input type="radio" id="on_elect_trip" name="switch_elect_trip" value="" />
                                    <label for="on_elect_trip">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <div class="chart_block_contents">
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>3. UNLOCK</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_elect_unlock" name="switch_elect_unlock" value="" checked/>
                                    <label for="off_elect_unlock">UNLOCK</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart_block small half" style="top:180px;left:170px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>MECHANICAL TRIP SYSTEM</span>
                                <label>
                                	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span></span>
                                <label>
                                	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ELECTRACAL TRIP SYSTEM</span>
                                <label>
                                	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span></span>
                                <label>
                                	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PROTECTIVE TEST ACTIVE</span>
                                <label>
                                	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CURRENT SPEED</span>
                                <label>
                                	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                </label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>TRIP SPEED SETPOINT</span>
                                <label>
                                	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                </label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PEAK SPEED</span>
                                <label>
                                	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                                </label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LAST OIL TRIP TEST</span>
                                <label>
                                	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                </label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LOAD</span>
                                <label>
                                	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                                </label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CVR</span>
                                <label>
                                	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                </label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>IVR</span>
                                <label>
                                	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MECH O/S MAIN. TEST</span>
                                <label>
                                	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                </label>
                            </p>
                        </div>
                    </div>
                </div>      
                <div class="chart_block small half" style="top:540px;left:700px;">
                    <div class="chart_block_contents only_txt">
                        <div class="msg_warning">
                            <p>!!!!! WARNING !!!!!</p>
                            <p>MANUAL UNLOCK MAY TRIP THE TURBINE</p>
                        </div>
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
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

