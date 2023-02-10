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
				<h3>PHT PURIFICATION SYSTEM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><strong>PHT PURIFICATION SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap pht_puri">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- //range_slider -->
                <div class="chart_block small" style="top:146px;left:190px;">
                    <h4>HX1 Temp</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>IN</span>
                                <span>263.30</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>RTN</span>
                                <span>206.39</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:40px;right:120px;">
                    <h4>HX2 Out</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span>49.55</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F</span>
                                <span>20.183</span>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:310px;left:680px;">
                    <h4>IX</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>△P</span>
                                <span>0.6232</span>
                                <span>MPAD</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:554px;left:690px;">
                    <h4>FILTER</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>△P</span>
                                <span>0.6232</span>
                                <span>MPAD</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- TCV 44 -->
                <div class="chart_block_s" style="top:102px;right:310px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>27.22</span>
                                <span>%</span>
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
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

