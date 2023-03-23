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
				<h3>STEP BACK</h3>
				<div class="bc"><span>DCC</span><span>Tip</span><strong>STEP BACK</strong></div>
			</div>
			<!-- //page_title -->   
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="240px" />
                        <col width="280px" />
                        <col width="280px" />
                        <col width="140px" />
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">ITEM</th>
                            <th colspan="2">CONDITION</th>
                            <th rowspan="2">ENDPOINT<br>(%FP)</th>
                            <th rowspan="2">REFERENCE</th>
                        </tr>
                        <tr>
                            <th class="bd_l_line">INITIATE</th>
                            <th>CLEAR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>HT Pump Trip</th>
                            <td>
                                1 Pump Tripped in Any Loop or<br>
                                2 Pumps Tripped In Any Loop
                            </td>
                            <td>
                                run 4 pumps or (Piu)log ＜ 2% FP
                            </td>
                            <td class="tc">
                                1 (2 Pump Trip)<br>
                                0 (1 Pump Trip)
                            </td>
                            <td>
                                Pump Tripped: DI 66-06, 66-07, 66-08, 66-09 (Open)<br>
                                (Piu)Log : AI 1223, 2405, 3067 Ion Chamber Log Power
                            </td>
                        </tr>
                        <tr>
                            <th>Low Moderator Level</th>
                            <td>L ＜ 7550 mm</td>
                            <td>L ＞ 7630 mm or (Piu)log ＜ 2 %FP </td>
                            <td class="tc">0.5</td>
                            <td>L : Moderator Level AI 1306, 2427, 3075</td>
                        </tr>
                        <tr>
                            <th>Reactor Trip</th>
                            <td>
                                SDS1 Tripped or<br>
                                SDS2 Tripped
                            </td>
                            <td>Not Trip SDS1, SDS2</td>
                            <td class="tc">0</td>
                            <td>
                                SDS1 Tripped : DI 64-06, 52-07, 67-04(Open)<br>
                                SDS1 Tripped : DI 64-02, 53-03, 70-15(Open)
                            </td>
                        </tr>
                        <tr>
                            <th>Stepback Test</th>
                            <td>
                                63732-PB4(X) or<br>
                                63732-PB4(Y)                               
                            </td>
                            <td></td>
                            <td class="tc">0</td>
                            <td>
                                63732-PB4(X) : DI 42-13(Close)<br>
                                63732-PB4(Y) : DI 42-13(Close)
                            </td>
                        </tr>
                        <tr>
                            <th>High Neutron Power</th>
                            <td>Pi ＞ 1.08 FP for 4 or more zone</td>
                            <td>Pi ＞ 1.08 FP for Less than 4 zone</td>
                            <td class="tc">0</td>
                            <td>Pi : Pt Detector Signal Uncalibrated Zone Power</td>
                        </tr>
                        <tr>
                            <th>High Log Rate</th>
                            <td>Log Rate ＞ + 0.0334 dec/sec</td>
                            <td>Log Rate ＜ 0 or Irrational</td>
                            <td class="tc">0</td>
                            <td>Log Rate : AI 1222, 2404, 3066</td>
                        </tr>
                        <tr>
                            <th>High PHT Pressure</th>
                            <td>
                                P ≥ 10.24 MPa(g) or<br>
                                The all Mediam of Outlet Press is Bad
                            </td>
                            <td>P ＜ 10.24MPa(g)</td>
                            <td class="tc">0.5</td>
                            <td>
                                P : The Highest Value of 4 Median<br>
                                ROH #1 Pr AI 1231, 2412, 3104<br>
                                ROH #3 Pr AI 1232, 2413, 3105<br>
                                ROH #5 Pr AI 1233, 2414, 3106<br>
                                ROH #7 Pr AI 1234, 2415, 3110
                            </td>
                        </tr>
                        <tr>
                            <th>Low S/G Level</th>
                            <td>LEVi ＜ LSTEP</td>
                            <td>LEVi ＜ LSTEP or (Piu)log ＜ 1% FP</td>
                            <td class="tc">0.5</td>
                            <td>
                                LEVi : Each S/G Level<br>
                                LSTEP : Stepback Level<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 3.0PF - 1.33, IF PF ≤ 0.9<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 1.37&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IF PF ≤ 0.9<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PF : Average flux power (filtered)
                            </td>
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

