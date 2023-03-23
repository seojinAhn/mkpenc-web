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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STEAM CHEST</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>FIRST STAGE</th>
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
                                <th>REHEAT INLET</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>THROTTLE STEAM</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STEAM SEAL HEADER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                        </label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP HYDRAULIC HEADER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
											<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
										</label>
                                        <label class="full">bar</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>GENERATOR HYDROGEN</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP HYDRAULIC HEADER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>GEN HYDRO AVG HOT</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>GEN HYDRO AVG COLD</th>
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
                                <th>LUBE OIL BEARING HDR</th>
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
                                <th colspan="2" class="title">TURBINE POSITION</th>
                            </tr>
                            <tr>
                                <th>THRUST BRG(ROTR PSN)</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if>
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
                                        	<c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if>
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
                                        	<c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>DIFFRENTIAL EXPANSION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ROTOR ECCENTRICITY</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if>
                                        </label>
                                        <label class="full">mm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAX ROTOR VIBRATION</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ELEC TRIP LOCKOUT VLV</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[21].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[21].fValue ne null}">${lblDataList[21].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[22].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[22].fValue ne null}">${lblDataList[22].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MECH TRIP LOCK VLV</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[23].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[23].fValue ne null}">${lblDataList[23].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[24].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[24].fValue ne null}">${lblDataList[24].fValue}</c:if>
                                        </label>
                                        <label class="full">rpm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LOAD</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[25].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[25].fValue ne null}">${lblDataList[25].fValue}</c:if>
                                        </label>
                                        <label class="full">MW</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>SPEED REFERENCE</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[26].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[26].fValue ne null}">${lblDataList[26].fValue}</c:if>
                                        </label>
                                        <label class="full">rpm</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LOAD TARGET</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[27].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[27].fValue ne null}">${lblDataList[27].fValue}</c:if>
                                        </label>
                                        <label class="full">MW</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LOAD REFERENCCE</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[28].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[28].fValue ne null}">${lblDataList[28].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>SPEED ERROR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[29].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[29].fValue ne null}">${lblDataList[29].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CONTROL VLV REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[30].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[30].fValue ne null}">${lblDataList[30].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>INTERCEPT VLV REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[31].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[31].fValue ne null}">${lblDataList[31].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[32].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[32].fValue ne null}">${lblDataList[32].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV - 1 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[33].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[33].fValue ne null}">${lblDataList[33].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV - 2 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[34].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[34].fValue ne null}">${lblDataList[34].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV - 3 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[35].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[35].fValue ne null}">${lblDataList[35].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV - 4 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[36].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[36].fValue ne null}">${lblDataList[36].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 1 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[37].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[37].fValue ne null}">${lblDataList[37].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 2 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[38].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[38].fValue ne null}">${lblDataList[38].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 3 POSITION REF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[39].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[39].fValue ne null}">${lblDataList[39].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                       		<c:if test="${lblDataList[40].fValue eq null}">0</c:if>
                                       		<c:if test="${lblDataList[40].fValue ne null}">${lblDataList[40].fValue}</c:if>
                                       	</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MSC - 3 TEST SOLD VLV</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[41].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[41].fValue ne null}">${lblDataList[41].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MSC - 4 TEST SOLD VLV</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[42].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[42].fValue ne null}">${lblDataList[42].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 4 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[43].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[43].fValue ne null}">${lblDataList[43].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 5 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[44].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[44].fValue ne null}">${lblDataList[44].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>IV - 6 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[45].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[45].fValue ne null}">${lblDataList[45].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[46].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[46].fValue ne null}">${lblDataList[46].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 2 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[47].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[47].fValue ne null}">${lblDataList[47].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 3 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[48].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[48].fValue ne null}">${lblDataList[48].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 4 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[49].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[49].fValue ne null}">${lblDataList[49].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 5 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[50].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[50].fValue ne null}">${lblDataList[50].fValue}</c:if>
                                        </label>
                                        <label class="full">%</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ISV - 6 POSITION FB</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[51].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[51].fValue ne null}">${lblDataList[51].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[52].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[52].fValue ne null}">${lblDataList[52].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>TURNING GEAR MOTOR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[53].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[53].fValue ne null}">${lblDataList[53].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>TURNING GEAR OIL PUMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[54].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[54].fValue ne null}">${lblDataList[54].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MOTOR SUCTION PUMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[55].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[55].fValue ne null}">${lblDataList[55].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>EMERGENCY OIL PUMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[56].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[56].fValue ne null}">${lblDataList[56].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LUBE OIL VAPOR EXTRTR</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[57].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[57].fValue ne null}">${lblDataList[57].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC PUMP - A</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[58].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[58].fValue ne null}">${lblDataList[58].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HYDRAULIC PUMP - b</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[59].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[59].fValue ne null}">${lblDataList[59].fValue}</c:if>
                                        </label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>STEAM PKG EXH</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[60].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[60].fValue ne null}">${lblDataList[60].fValue}</c:if>
                                        </label>
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
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[61].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[61].fValue ne null}">${lblDataList[61].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CONTROL VALVE IOUTER</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[62].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[62].fValue ne null}">${lblDataList[62].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CONTROL VALVE VE DIFF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[63].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[63].fValue ne null}">${lblDataList[63].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CV ALLOW DIFF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[64].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[64].fValue ne null}">${lblDataList[64].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MAIN STEAM TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[65].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[65].fValue ne null}">${lblDataList[65].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>RHT STEAM TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[66].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[66].fValue ne null}">${lblDataList[66].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP EXHAUST TEMP</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[67].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[67].fValue ne null}">${lblDataList[67].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>LP INNER BOWL</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[68].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[68].fValue ne null}">${lblDataList[68].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HP FIRST STG SURF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[69].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[69].fValue ne null}">${lblDataList[69].fValue}</c:if>
                                        </label>
                                        <label class="full">deg C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>RHT BOWL SURF</th>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">
                                        	<c:if test="${lblDataList[70].fValue eq null}">0</c:if>
                                        	<c:if test="${lblDataList[70].fValue ne null}">${lblDataList[70].fValue}</c:if>
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



