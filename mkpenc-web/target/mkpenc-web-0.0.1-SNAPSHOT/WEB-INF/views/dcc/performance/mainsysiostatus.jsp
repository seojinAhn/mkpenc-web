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
<script type="text/javascript" src="<c:url value="/resources/js/performance.js" />" charset="utf-8"></script>
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
				<h3>중요 계통 I/O 상태</h3>
				<div class="bc"><span>DCC</span><span>Perfomance</span><strong>주요 계통 I/O 상태</strong></div>
			</div>
			<!-- //page_title -->
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_head -->
                        <div class="form_head">
                            <div class="button">
                                <div class="fx_legend">
                                      <label style="color:${XForeColor}">${XSearchTime}</label>
                                </div>
                            </div>
                        </div>
                        <!-- //form_head -->
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col width="60px"/>
                                <col width="160px"/>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">구분</th>
                                    <th>DCCX</th>
                                    <th>DCCY</th>
                                    <th>I/O</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th rowspan="8">MAC<br>Driver<br>DO</th>
                                    <th>CA1 OUT DRIVER</th>
                                    <td class="tc">${lblDataXList[0].fValue}</td>
                                    <td class="tc">${lblDataYList[0].fValue}</td>
                                    <td class="tc">DO 226B08</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 IN DRIVER</th>
                                    <td class="tc">${lblDataXList[1].fValue}</td>
                                    <td class="tc">${lblDataYList[1].fValue}</td>
                                    <td class="tc">DO 226B09</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 OUT DRIVER</th>
                                    <td class="tc">${lblDataXList[2].fValue}</td>
                                    <td class="tc">${lblDataYList[2].fValue}</td>
                                    <td class="tc">DO 226B10</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 IN DRIVER</th>
                                    <td class="tc">${lblDataXList[3].fValue}</td>
                                    <td class="tc">${lblDataYList[3].fValue}</td>
                                    <td class="tc">DO 226B12</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 OUT DRIVER</th>
                                    <td class="tc">${lblDataXList[4].fValue}</td>
                                    <td class="tc">${lblDataYList[4].fValue}</td>
                                    <td class="tc">DO 227B08</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 IN DRIVER</th>
                                    <td class="tc">${lblDataXList[5].fValue}</td>
                                    <td class="tc">${lblDataYList[5].fValue}</td>
                                    <td class="tc">DO 227B09</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 OUT DRIVER</th>
                                    <td class="tc">${lblDataXList[6].fValue}</td>
                                    <td class="tc">${lblDataYList[6].fValue}</td>
                                    <td class="tc">DO 227B10</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA1 IN DRIVER</th>
                                    <td class="tc">${lblDataXList[7].fValue}</td>
                                    <td class="tc">${lblDataYList[7].fValue}</td>
                                    <td class="tc">DO 227B11</td>
                                </tr>
                                <tr>
                                    <th rowspan="4">MAC<br>Driver<br>DO</th>
                                    <th>CA1 Clutch</th>
                                    <td class="tc">${lblDataXList[8].fValue}</td>
                                    <td class="tc">${lblDataYList[8].fValue}</td>
                                    <td class="tc">DO 230B11</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA2 Clutch</th>
                                    <td class="tc">${lblDataXList[9].fValue}</td>
                                    <td class="tc">${lblDataYList[9].fValue}</td>
                                    <td class="tc">DO 230B10</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA3 Clutch</th>
                                    <td class="tc">${lblDataXList[10].fValue}</td>
                                    <td class="tc">${lblDataYList[10].fValue}</td>
                                    <td class="tc">DO 227B09</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CA4 Clutch</th>
                                    <td class="tc">${lblDataXList[11].fValue}</td>
                                    <td class="tc">${lblDataYList[11].fValue}</td>
                                    <td class="tc">DO 230B08</td>
                                </tr>
                                <tr>
                                    <th colspan="2">Self-Back Initiate Alarm</th>
                                    <td class="tc">${lblDataXList[12].fValue}</td>
                                    <td class="tc">${lblDataYList[12].fValue}</td>
                                    <td class="tc">DO 235B10</td>
                                </tr>
                                <tr>
                                    <th colspan="2">Control Power Fall</th>
                                   	<td class="tc">${lblDataXList[13].fValue}</td>
                                    <td class="tc">${lblDataYList[13].fValue}</td>
                                    <td class="tc">DO 227B14</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //form_table -->
                    </div>
                    <!-- //form_wrap -->
                </div>
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_head -->
                        <div class="form_head">
                            <div class="button">
                                <div class="fx_legend">
                                      <label style="color:${YForeColor}">${YSearchTime}</label>
                                </div>
                            </div>
                        </div>
                        <!-- //form_head -->                        
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col width="60px"/>
                                <col width="160px"/>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">구분</th>
                                    <th>DCCX</th>
                                    <th>DCCY</th>
                                    <th>I/O</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th rowspan="3">SDS #1<br>Trip DI</th>
                                    <th>CH D</th>
                                    <td class="tc">${lblDataXList[14].fValue}</td>
                                    <td class="tc">${lblDataYList[14].fValue}</td>
                                    <td class="tc">DI 64B06</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH E</th>
                                    <td class="tc">${lblDataXList[15].fValue}</td>
                                    <td class="tc">${lblDataYList[15].fValue}</td>
                                    <td class="tc">DI 52B07</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH F</th>
                                    <td class="tc">${lblDataXList[16].fValue}</td>
                                    <td class="tc">${lblDataYList[16].fValue}</td>
                                    <td class="tc">DI 67B04</td>
                                </tr>
                                <tr>
                                    <th rowspan="3">SDS #2<br>Trip DI</th>
                                    <th>CH G</th>
                                    <td class="tc">${lblDataXList[17].fValue}</td>
                                    <td class="tc">${lblDataYList[17].fValue}</td>
                                    <td class="tc">DI 65B02</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH E</th>
                                    <td class="tc">${lblDataXList[18].fValue}</td>
                                    <td class="tc">${lblDataYList[18].fValue}</td>
                                    <td class="tc">DI 53B03</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH J</th>
                                    <td class="tc">${lblDataXList[19].fValue}</td>
                                    <td class="tc">${lblDataYList[19].fValue}</td>
                                    <td class="tc">DI 70B15</td>
                                </tr>
                                <tr>
                                    <th rowspan="3">TBN<br>Trip DI</th>
                                    <th>CH A</th>
                                    <td class="tc">${lblDataXList[20].fValue}</td>
                                    <td class="tc">${lblDataYList[20].fValue}</td>
                                    <td class="tc">DI 40B13</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH B</th>
                                    <td class="tc">${lblDataXList[21].fValue}</td>
                                    <td class="tc">${lblDataYList[21].fValue}</td>
                                    <td class="tc">DI DI 40B14</td>
                                </tr>
                                <tr>
                                    <th class="bd_l_line">CH C</th>
                                    <td class="tc">${lblDataXList[22].fValue}</td>
                                    <td class="tc">${lblDataYList[22].fValue}</td>
                                    <td class="tc">DI DI 40B15</td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th colspan="2">Power Load Unbalance</th>
                                    <td class="tc">${lblDataXList[23].fValue}</td>
                                    <td class="tc">${lblDataYList[23].fValue}</td>
                                    <td class="tc">DI 41B00</td>
                                </tr>
                                <tr>
                                    <th colspan="2">Loss of Line</th>
                                    <td class="tc">${lblDataXList[24].fValue}</td>
                                    <td class="tc">${lblDataYList[24].fValue}</td>
                                    <td class="tc">DI 41B01</td>
                                </tr>
                            </tbody>
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

