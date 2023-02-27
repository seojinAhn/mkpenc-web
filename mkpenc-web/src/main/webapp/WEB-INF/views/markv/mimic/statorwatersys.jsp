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
				<h3>HYDRAULIC POWER UNIT</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>HYDRAULIC POWER UNIT</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap stator_water_sys">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->
                <div class="chart_block small" style="top:140px;left:290px;">
                    <h4>CONTROL CABINET</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESSURE</span>
                                <span>0</span>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>FLOW</span>
                                <span>0</span>
                                <span>bar</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:260px;left:290px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>SCW PROTECTION</span>
                                <span>0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:340px;left:290px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>DIFF PRESS</span>
                                <span>0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:380px;left:490px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span>0</span>
                                <span>umo/c</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span></span>
                                <span>0</span>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block small wide" style="top:180px;left:650px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>PRESSURE</span>
                                <span>0</span>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>FLOW</span>
                                <span>0</span>
                                <span>bar</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:270px;left:800px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:430px;left:730px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:494px;left:730px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:554px;left:786px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>0</span>
                            </p>
                        </div>
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

