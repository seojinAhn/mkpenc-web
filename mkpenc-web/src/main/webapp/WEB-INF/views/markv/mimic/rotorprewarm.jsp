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
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP INL</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP EXH</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>0</label>
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
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>C/HR</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP INL</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>C/HR</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LP EXH</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>0</label>
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
                                    <label>0</label>
                                    <span>bar</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">MAIN STEAM TEMPERATURE</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">ECCENTRICITY</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
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
                                            <label>0</label>
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
                                            <label>0</label>
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
                                            <label>0</label>
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
                                    <label>0</label>
                                    <span>MSV</span>
                                    <label>0</label>
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
                                        <label>0</label>
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

