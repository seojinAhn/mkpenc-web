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
				<h3>LIQUID ZONE CONTROL SYSTEM I</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>PRIMARY</span><strong>LIQUID ZONE CONTROL SYSTEM I</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap lzc_i">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="#none" class="link_btn link_01"></a>
                <!-- ///range_slider -->              
                <div class="chart_block" style="top:20px;left:150px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>MPGA</p>
                            <p>
                                <span>P</span>
                                <span>0.7224</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:200px;left:270px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>MPAD</p>
                            <p>
                                <span>P</span>
                                <span>0.7224</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="bottom:120px;left:320px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <span>49.63</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="bottom:120px;left:320px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>USIE/M</p>
                            <p>
                                <span>C</span>
                                <span>18.46</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:30px;right:540px;">
                    <h4>R.U</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>In T</span>
                                <span>107.19</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>Out T</span>
                                <span>50.09</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:320px;left:425px;">
                    <h4>Delay Tank</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>METER</p>
                            <p>
                                <span>L</span>
                                <span>107.19</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>P</span>
                                <span>0.16183</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:150px;right:250px;">
                    <h4>He Tank</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>P</span>
                                <span>0.8694</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>METER</p>
                            <p>
                                <span>L</span>
                                <span>0.13559</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:450px;right:150px;">
                    <h4>H2O Pp Disch</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>Pr. A</span>
                                <span>1.2798</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>B</span>
                                <span>1.2736</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>C</span>
                                <span>1.2728</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <span>28.16</span>
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

