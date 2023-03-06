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
				<h3>MODERATOR SYSTEM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>PRIMARY</span><strong>MODERATOR SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap moderator">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- //range_slider -->
                <div class="chart_block small" style="top:60px;left:130px;">
                    <h4>Tank Level</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Gd</span>
                                <span>700.1</span>
                                <span>MM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>B</span>
                                <span>807.4</span>
                                <span>MM</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:90px;left:486px;">
                    <h4>MOD</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span>7886.5</span>
                                <span>MM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span>68.52</span>
                                <span>DEG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:200px;left:828px;">
                    <h4>Head Tank</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>P</span>
                                <span>21.19</span>
                                <span>KPAG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:50px;right:196px;">
                    <h4>MOD Pp △P</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>A</span>
                                <span>0.48965</span>
                                <span>MPAD</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>B</span>
                                <span>0.48965</span>
                                <span>MPAD</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>C</span>
                                <span>0.48965</span>
                                <span>MPAD</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>D</span>
                                <span>0.48965</span>
                                <span>MPAD</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:370px;left:340px;">
                    <h4>Pp 1 Brg</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>VIB</span>
                                <span>2.839</span>
                                <span>MM/S</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span>48.47</span>
                                <span>DEG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:370px;right:300px;">
                    <h4>Pp 2 Brg</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>VIB</span>
                                <span>2.839</span>
                                <span>MM/S</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span>48.47</span>
                                <span>DEG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:500px;left:660px;">
                    <h4>PURI</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span>49.02</span>
                                <span>DEG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- left -->
                <div class="chart_block_s" style="top:280px;left:240px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>46.94</span>
                                <span>DEG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- right -->
                <div class="chart_block_s" style="top:280px;right:230px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>46.63</span>
                                <span>DEG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- bottom left -->
                <div class="chart_block_s" style="top:550px;left:280px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>46.94</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- bottom right -->
                <div class="chart_block_s" style="top:550px;right:270px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>46.63</span>
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
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

