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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                        </label>
                                        <label class="full">MW</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>TURBINE SPEED</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                        </label>
                                        <label class="full">rpm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAIN STEAM HEADER PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAIN STEAM HEADER TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV1 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV2 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV3 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV4 POSITION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING COND OUT</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                        </label>
                                        <label class="full">umo/c</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING COND IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                                        </label>
                                        <label class="full">umo/c</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING PRESS IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING FLOW IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                                        </label>
                                        <label class="full">I/min</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING TEMP IN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STATOR COOLING TEMP OUT</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDROGEN PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDROGEN PURITY</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>COMMON COLD GAS TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BEARING HEADER PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BEARING HEADER TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP1 EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[52].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[52].fValue ne null}">${lblDataList[52].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP2 EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[53].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[53].fValue ne null}">${lblDataList[53].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP3 EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                       		<c:if test="${lblDataList[26].fValue eq null}">0</c:if>
                                       		<c:if test="${lblDataList[26].fValue ne null}">${lblDataList[26].fValue}</c:if>
                                       	</label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STEAM SEAL HEADER PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[24].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[24].fValue ne null}">${lblDataList[24].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THURST BRG METAL F.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[25].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[25].fValue ne null}">${lblDataList[25].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[27].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[27].fValue ne null}">${lblDataList[27].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THURST BRG DRAIN F.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[28].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[28].fValue ne null}">${lblDataList[28].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THURST BRG DRAIN R.TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[29].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[29].fValue ne null}">${lblDataList[29].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 1X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[30].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[30].fValue ne null}">${lblDataList[30].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 2X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[31].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[31].fValue ne null}">${lblDataList[31].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 3X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[32].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[32].fValue ne null}">${lblDataList[32].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 4X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[33].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[33].fValue ne null}">${lblDataList[33].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 5X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[34].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[34].fValue ne null}">${lblDataList[34].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 6X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[35].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[35].fValue ne null}">${lblDataList[35].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 7X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[36].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[36].fValue ne null}">${lblDataList[36].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 8X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[37].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[37].fValue ne null}">${lblDataList[37].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 9X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[38].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[38].fValue ne null}">${lblDataList[38].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>BRG 10X VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[39].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[39].fValue ne null}">${lblDataList[39].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THUST BRG WEAR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[40].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[40].fValue ne null}">${lblDataList[40].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ROTOR EXPANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[41].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[41].fValue ne null}">${lblDataList[41].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>SHELL EXPANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[42].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[42].fValue ne null}">${lblDataList[42].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>DIFFERENTIAL EXOANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[43].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[43].fValue ne null}">${lblDataList[43].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ECCENTRICITY</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[44].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[44].fValue ne null}">${lblDataList[44].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAX BRG VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[45].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[45].fValue ne null}">${lblDataList[45].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP FIRST STAGE PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[46].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[46].fValue ne null}">${lblDataList[46].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>REHEATER INLET PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[47].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[47].fValue ne null}">${lblDataList[47].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP EXHAUST STAGE TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[48].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[48].fValue ne null}">${lblDataList[48].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP1 EXHAUST PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[49].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[49].fValue ne null}">${lblDataList[49].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP2 EXHAUST PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[50].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[50].fValue ne null}">${lblDataList[50].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP3 EXHAUST PRESS</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[51].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[51].fValue ne null}">${lblDataList[51].fValue}</c:if>
                                        </label>
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
