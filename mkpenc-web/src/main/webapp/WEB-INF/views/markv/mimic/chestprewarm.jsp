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
				<h3>CHEST PREWARMING</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>CHEST PREWARMING</strong></div>
			</div>
			<!-- //page_title -->

            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block triple">

                    <div class="chart_line_table">
                        <h4>CONTROL VALVE METAL TEMPERATURE</h4>
                        <div class="chart_wrap_area" style="height:284px;">
                            차트
                        </div>
                    </div>       

                    <div class="chart_line_table">
                        <h4>STEAM TO METAL TEMPERATURE</h4>
                        <div class="chart_wrap_area" style="height:284px;">
                            차트
                        </div>
                    </div>    

                </div>
                <div class="fx_block double center">

                    <div class="chart_line_table">
                        <h4>STEAM PRESSURE</h4>
                        <div class="chart_wrap_area" style="height:284px;">
                            차트
                        </div>
                    </div> 

                    <div class="chart_line_table line" style="width:240px;">
                        <div class="summary">
                            <p>
                                <span>PRESS RATIO</span>
                                <label>
                                	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                </label>
                                <span class="fx_none">%</span>
                            </p>
                        </div>
                    </div>
                    <div class="chart_line_table" style="width:240px;">
                        <div class="line_table_block">
                            <h5>CHEST WARMING</h5>
                        </div>
                        <div class="line_table_block">
                            <div class="summary">
                                <p class="side">
                                    <label>0</label>
                                    <span>MSV</span>
                                    <label>
                                    	<c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if>
                                    </label>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="rotor_off" name="switch_onoff" value="" checked/>
                                    <label for="rotor_off">OFF</label>
                                    <input type="radio" id="rotor_on" name="switch_onoff" value="" />
                                    <label for="rotor_on">ON</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block center">
                    <div class="chart_line_table">
                        <h4>SPEED</h4>
                        <div class="chart_wrap_area" style="height:284px;">
                            차트
                        </div>
                    </div> 

                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h5>MSV2</h5>
                        </div>
                        <div class="line_table_block">
                            <div class="block_item">
                                <div class="summary">
                                    <p>
                                        <label>
                                        	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                        </label>
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

