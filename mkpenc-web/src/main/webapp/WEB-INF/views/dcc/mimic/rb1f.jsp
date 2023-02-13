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
				<h3>RB 1F</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>RADIATION</span><strong>RB 1F</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap rb_1f">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- //range_slider -->       
                <div class="toggle_block chart_block small wide" style="top:156px;left:370px;">
                    <h4>RT-05 (R-104)</h4>
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
                <div class="toggle_block chart_block small wide" style="top:220px;left:150px;">
                    <h4>RT-18 (R-114)</h4>
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
                <div class="toggle_block chart_block small wide" style="top:300px;left:304px;">
                    <h4>RT-01 (R-001)</h4>
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
                <div class="toggle_block chart_block small wide" style="top:400px;left:150px;">
                    <h4>RT-19 (R-115)</h4>
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
                <div class="toggle_block chart_block small wide" style="top:480px;left:370px;">
                    <h4>RT-04 (R-103)</h4>
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
                <div class="toggle_block chart_block small wide" style="top:150px;right:330px;">
                    <h4>RT-08 (R-108)</h4>
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
                <div class="toggle_block chart_block small wide" style="top:314px;right:270px;">
                    <h4>RT-11 (R-112)</h4>
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
                <div class="toggle_block chart_block small wide" style="top:464px;right:330px;">
                    <h4>RT-06</h4>
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

