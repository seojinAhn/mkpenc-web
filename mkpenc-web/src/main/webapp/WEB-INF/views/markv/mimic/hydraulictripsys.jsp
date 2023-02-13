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
				<h3>HYDRAULIC TRIP SYSTEM</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>HYDRAULIC TRIP SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap hydraulic_trip">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->
                <div class="chart_block small tiny" style="top:160px;left:720px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:160px;left:866px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:284px;left:370px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:284px;left:950px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:372px;left:288px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:444px;left:370px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:405px;left:690px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:405px;left:834px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:405px;left:978px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:534px;left:288px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:574px;left:710px;">
                    <div class="chart_block_contents only_txt white_txt">
                        <div class="summary">
                            <p>
                                <span class="fx_full">0</span>
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



