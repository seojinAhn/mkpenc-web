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
				<h3>EMERGENCY CORE COOLING SYSTEM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>PRIMARY</span><strong>EMERGENCY CORE COOLING SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap emergency_core_cooling">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->         
                <div class="chart_block small" style="top:290px;left:410px;">
                    <h4>Tank 1</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>M</span>
                                <span>10.074</span>
                                <span>METER</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:370px;left:280px;">
                    <h4>Pp 1 Temp</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>131</span>
                                <span>25.78</span>
                                <span>DEG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:520px;left:280px;">
                    <h4>Pp 2 Temp</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>141</span>
                                <span>30.53</span>
                                <span>DEGC</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:180px;left:680px;">
                    <h4>Tank 3 L</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>K</span>
                                <span>10.097</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span>10.100</span>
                                <span>METER</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:130px;left:890px;">
                    <h4>Dousing Tk L</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>K</span>
                                <span>3.7356</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span>3.7739</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>M</span>
                                <span>3.7578</span>
                                <span>METER</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:130px;left:1060px;">
                    <h4>R/B P</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>K</span>
                                <span>-0.7356</span>
                                <span>KPAD</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span>-0.7739</span>
                                <span>KPAD</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>M</span>
                                <span>-0.7578</span>
                                <span>KPAD</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:270px;left:1080px;">
                    <h4>RD L</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>K</span>
                                <span>0.7356</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>M</span>
                                <span>0.7739</span>
                                <span>METER</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:390px;left:970px;">
                    <h4>RD L</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>K</span>
                                <span>1,203</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>M</span>
                                <span>1,179</span>
                                <span>METER</span>
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

