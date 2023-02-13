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
				<h3>LOGGING DATA</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>SECONDARY</span><strong>LOGGING DATA</strong></div>
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
                                <th>TURBINE LOAD</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">MW</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>TURBINE SPEED</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">rpm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAIN STEAM HEADER PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAIN STEAM HEADER TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV1 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV2 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV3 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV4 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING COND OUT</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">umo/c</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING COND IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">umo/c</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING PRESS IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING FLOW IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">I/min</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING TEMP IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING TEMP OUT</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDROGEN PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDROGEN PURITY</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>COMMON COLD GAS TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BEARING HEADER PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BEARING HEADER TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP1 EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP2 EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP3 EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STEAM SEAL HEADER PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THURST BRG METAL F.TEMP</th>
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
                                <th>THURST BRG METAL R.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THURST BRG DRAIN F.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THURST BRG DRAIN R.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 1X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 2X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 3X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 4X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 5X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 6X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 7X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 8X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 9X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 10X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THUST BRG WEAR</th>
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
                                <th>DIFFERENTIAL EXOANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ECCENTRICITY</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAX BRG VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP FIRST STAGE PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>REHEATER INLET PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP EXHAUST STAGE TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP1 EXHAUST PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP2 EXHAUST PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP3 EXHAUST PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full">mm</label>
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
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

