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
				<h3>SET BACK</h3>
				<div class="bc"><span>DCC</span><span>Tip</span><strong>SET BACK</strong></div>
			</div>
			<!-- //page_title -->   
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="200px" />
                        <col width="220px" />
                        <col width="220px" />
                        <col width="100px" />
                        <col width="100px" />
                        <col width="100px" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">ITEM</th>
                            <th colspan="2">CONDITION</th>
                            <th colspan="2">RATE</th>
                            <th rowspan="2">ENDPOINT<br>(%FP)</th>
                        </tr>
                        <tr>
                            <th class="bd_l_line">INITIATE</th>
                            <th>CLEAR</th>
                            <th>dec / sec</th>
                            <th>% / sec</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>High Local Neutron</th>
                            <td>R x PLIN ＞ 1.1</td>
                            <td>R x PLIN ＜ 1.05</td>
                            <td>-0.00043</td>
                            <td class="tc">0.1</td>
                            <td class="tc">60</td>
                        </tr>
                        <tr>
                            <th>Zone Control Failure</th>
                            <td>Pw ＜ 827 KPa(g)</td>
                            <td>Pw ＞ 900 KPa(g)</td>
                            <td>-0.00346</td>
                            <td class="tc">0.8</td>
                            <td class="tc">2</td>
                        </tr>
                        <tr>
                            <th>Spatial Control</th>
                            <td>Pic ＞ 1.1 or TILT max ＞ 0.2</td>
                            <td>Pic ＜ 1.05 or TILT max ＜ 0.15</td>
                            <td>-0.00043</td>
                            <td class="tc">0.1</td>
                            <td class="tc">60</td>
                        </tr>
                        <tr>
                            <th>Low Deaerator Level</th>
                            <td>L ＜ 2.44m</td>
                            <td>L ＞ 2.56m</td>
                            <td>-0.0021</td>
                            <td class="tc">0.5</td>
                            <td class="tc">2</td>
                        </tr>
                        <tr>
                            <th>High S/G Pressure</th>
                            <td>P ＞ 4.83 MPaG</td>
                            <td>P ＜ 4.66 MPaG</td>
                            <td>-0.0021</td>
                            <td class="tc">0.5</td>
                            <td class="tc">8</td>
                        </tr>
                        <tr>
                            <th>
                                High Moderator<br>
                                Temperature
                            </th>
                            <td>T ＞ 79 ℃</td>
                            <td>T ＜ 74 ℃</td>
                            <td>-0.0043</td>
                            <td class="tc">1.0</td>
                            <td class="tc">2</td>
                        </tr>
                        <tr>
                            <th>
                                Low Differential Pressure<br>
                                across Moderator Pumps
                            </th>
                            <td>
                                2/3 Contacts Open<br>
                                ( Diff P ＜ 280 KPa(g) )
                            </td>
                            <td>
                                2/3 Contacts Close<br>
                                ( Diff P ≥ 280 KPa(g) )
                            </td>
                            <td>-0.0043</td>
                            <td class="tc">1.0</td>
                            <td class="tc">2</td>
                        </tr>
                        <tr>
                            <th>Manual</th>
                            <td>Handswitch(63700-HS1)</td>
                            <td></td>
                            <td>-0.0021</td>
                            <td class="tc">0.5</td>
                            <td class="tc">2</td>
                        </tr>
                        <tr>
                            <th>Turbine Trip</th>
                            <td>
                                Turbine Trip, or<br>
                                Power Load Unbalance
                            </td>
                            <td></td>
                            <td>-0.0043</td>
                            <td class="tc">1.0</td>
                            <td class="tc">60</td>
                        </tr>
                        <tr>
                            <th>Low Endshield Level</th>
                            <td>
                                L1 ≤ 109.71 m, L2 ≤ 111.0 m or<br>
                                L1 ≤ 111.0 m, L2 ≤ 111.0 m and<br>
                                 the other two are irrational or<br>
                                L1 ≤ 111.0 m and<br>
                                 the other three are irrational<br>
                            </td>
                            <td>Otherwise</td>
                            <td>-0.0021</td>
                            <td class="tc">0.5</td>
                            <td class="tc">2</td>
                        </tr>
                        <tr>
                            <th>
                                High Degasser Condenser<br>
                                Pressure
                            </th>
                            <td>Pdc ≥ 3.9 MPa(g)</td>
                            <td>Pdc ＜ 3.4 MPa(g)</td>
                            <td>-0.00043</td>
                            <td class="tc">0.1</td>
                            <td class="tc">2</td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
            </div>
            <!-- //form_wrap -->
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

