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
				<h3>PHT PRESSURE & INVENTORY CONTROLSYSTEM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><strong>PHT PRESSURE & INVENTORY CONTROLSYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap pht_control">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- //range_slider -->
                <div class="chart_block small mini" style="top:340px;left:280px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span>30.10</span>
                                <span>DEGC</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small mini" style="top:434px;left:310px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>P</span>
                                <span>185.81</span>
                                <span>KPGA</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small mini" style="top:520px;left:310px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>P</span>
                                <span>183.16</span>
                                <span>KPGA</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small mini" style="top:468px;left:510px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>P</span>
                                <span>13.274</span>
                                <span>MPGA</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small mini" style="top:512px;left:510px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>P</span>
                                <span>0.178</span>
                                <span>MPGA</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- PCV 5 -->
                <div class="chart_block_s" style="top:146px;left:786px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>0.06</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- PCV 6 -->
                <div class="chart_block_s" style="top:254px;left:786px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>0.03</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- FCV 26 -->
                <div class="chart_block_s" style="top:360px;left:796px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>0.06</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- FCV 8 -->
                <div class="chart_block_s" style="top:462px;left:796px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>0.03</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV 12 -->
                <div class="chart_block_s" style="top:446px;left:980px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>33.03</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV 11 -->
                <div class="chart_block_s" style="top:490px;left:980px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>33.19</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV 14 -->
                <div class="chart_block_s" style="top:538px;left:980px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>33.03</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV 15 -->
                <div class="chart_block_s" style="top:590px;left:980px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>33.19</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small mini" style="top:446px;right:170px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>P</span>
                                <span>13.274</span>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small mini" style="top:544px;right:170px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>P</span>
                                <span>13.274</span>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="toggle_block small" style="top:200px;left:386px;">
                    <h4>DC</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MPGA</p>
                            <p>
                                <span>P</span>
                                <span>1.069</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>L</span>
                                    <span>1.212</span>
                                </p>
                            </li>
                            <li>
                                <p>DEG C</p>
                                <p>
                                    <span>LIQ. T</span>
                                    <span>180.78</span>
                                </p>
                            </li>
                            <li>
                                <p>DEG C</p>
                                <p>
                                    <span>STM. T</span>
                                    <span>183.38</span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block small" style="top:200px;left:950px;">
                    <h4>PZR</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MPGA</p>
                            <p>
                                <span>PZR P</span>
                                <span>9.669</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>MPGA</p>
                                <p>
                                    <span>PROH</span>
                                    <span>9.685</span>
                                </p>
                            </li>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>L</span>
                                    <span>8.628</span>
                                </p>
                            </li>
                            <li>
                                <p>DEG C</p>
                                <p>
                                    <span>STM T</span>
                                    <span>308.41</span>
                                </p>
                            </li>
                            <li>
                                <p>DEG C</p>
                                <p>
                                    <span>BLUK T</span>
                                    <span>308.41</span>
                                </p>
                            </li>
                            <li>
                                <p>%</p>
                                <p>
                                    <span>VAR HTR</span>
                                    <span>68.84</span>
                                </p>
                            </li>
                            <li>
                                <p></p>
                                <p>
                                    <span>HTR</span>
                                    <span>OFF</span>
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
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

