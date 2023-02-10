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
				<h3>TURBINE OVERVIEW</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>SECONDARY</span><strong>TURBINE OVERVIEW</strong></div>
			</div>
			<!-- //page_title -->
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th colspan="2" class="title">SATEM PRESSURE</th>
                            </tr>
                            <tr>
                                <th>MAIN STEAM HEADER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STEAM CHEST</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>FIRST STAGE</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>REHEAT INLET</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THROTTLE STEAM</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="title">SYSTEM PRESSURE</th>
                            </tr>
                            <tr>
                                <th>LUBE OIL BEARING HDR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STEAM SEAL HEADER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP HYDRAULIC HEADER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>GENERATOR HYDROGEN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="title">SYSTEM TEMPERATURE</th>
                            </tr>
                            <tr>
                                <th>STEAM SEAL HEADER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP HYDRAULIC HEADER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>GEN HYDRO AVG HOT</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>GEN HYDRO AVG COLD</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LUBE OIL BEARING HDR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="title">TURBINE POSITION</th>
                            </tr>
                            <tr>
                                <th>THRUST BRG(ROTR PSN)</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ROTOR EXPANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>SHELL EXPANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>DIFFRENTIAL EXPANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ROTOR ECCENTRICITY</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAX ROTOR VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="title">TRIP SYSTEM STATUS</th>
                            </tr>
                            <tr>
                                <th>ELECTRICAL TRIP VALUE</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ELEC TRIP LOCKOUT VLV</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
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
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>MECHANICAL TRIP VALVE</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MECH TRIP LOCK VLV</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="title">SPEED LOAD CONTROL DETAIL</th>
                            </tr>
                            <tr>
                                <th>SPEED</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">rpm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LOAD</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">MW</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>SPEED REFERENCE</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">rpm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LOAD TARGET</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">MW</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LOAD REFERENCCE</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>SPEED ERROR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CONTROL VLV REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>INTERCEPT VLV REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="title">STEAM VALVE CONTROL DETAIL</th>
                            </tr>
                            <tr>
                                <th>MSV - 2 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV - 1 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV - 2 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV - 3 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV - 4 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 1 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 2 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 3 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="title">NON-SERVO CONTROL LED VALVE DETAIL</th>
                            </tr>
                            <tr>
                                <th>MSC - 1 TEST SOLD VLV</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MSC - 3 TEST SOLD VLV</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MSC - 4 TEST SOLD VLV</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 4 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 5 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 6 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
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
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>ISV - 1 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 2 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 3 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 4 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 5 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 6 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="title">SYSTEM STATUS</th>
                            </tr>
                            <tr>
                                <th>TURNING GEAR ENG</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>TURNING GEAR MOTOR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>TURNING GEAR OIL PUMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MOTOR SUCTION PUMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>EMERGENCY OIL PUMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LUBE OIL VAPOR EXTRTR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC PUMP - A</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC PUMP - b</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STEAM PKG EXH</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="title">TURBINE TEMPERATURE</th>
                            </tr>
                            <tr>
                                <th>CONTROL VALVE INNER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CONTROL VALVE IOUTER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CONTROL VALVE VE DIFF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV ALLOW DIFF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAIN STEAM TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>RHT STEAM TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP INNER BOWL</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP FIRST STG SURF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>RHT BOWL SURF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
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



