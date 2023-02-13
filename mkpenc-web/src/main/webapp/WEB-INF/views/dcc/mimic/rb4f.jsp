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
<script type="text/javascript" src="<c:url value="/resources/js/status.js" />" charset="utf-8"></script>

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
				<h3>RB 4F</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>RADIATION</span><strong>RB 4F</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap rb_4f">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- //range_slider -->       
                <div class="toggle_block chart_block small wide" style="top:130px;left:320px;">
                    <h4>RT-16 (R-406)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span>0.8593</span>
                                <span>MGY/HR</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:254px;left:320px;">
                    <h4>RT-34 (R-402)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span>0.8593</span>
                                <span>MGY/HR</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:126px;left:680px;">
                    <h4>RT-09 (R-108)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span>0.8593</span>
                                <span>MGY/HR</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:360px;left:580px;">
                    <h4>RT-14 (R-403)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span>0.8593</span>
                                <span>MGY/HR</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:420px;left:260px;">
                    <h4>RT-23 (R-401)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span>0.8593</span>
                                <span>MGY/HR</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:500px;left:340px;">
                    <h4>RT-15 (R-405)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span>0.8593</span>
                                <span>MGY/HR</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block chart_block small wide" style="top:500px;left:680px;">
                    <h4>RT-07 (R-107)</h4>
                    <div class="toggle_block_contents chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Actual Value</span>
                                <span>0.8593</span>
                                <span>MGY/HR</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>
                                    <span>Alert Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                            <li>
                                <p>
                                    <span>High Alarm</span>
                                    <span>0</span>
                                    <span></span>
                                </p>
                            </li>
                        </ul>
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

