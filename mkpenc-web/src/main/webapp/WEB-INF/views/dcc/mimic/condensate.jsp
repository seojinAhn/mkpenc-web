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
				<h3>CONDENSATE</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>SECONDARY</span><strong>CONDENSATE</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap condensate_system">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="#none" class="link_txt" style="top:60px;right:350px;">Main System<br>Pressure System</a>
                <a href="#none" class="link_txt" style="top:166px;left:146px;">S/G F/W System</a>
                <!-- ///range_slider -->              
                <div class="chart_block small" style="top:30px;left:140px;">
                    <h4>Dearator</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <label>122.03</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label>3302.8</label>
                                <span>MM</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:204px;left:140px;">
                    <h4>COND Outlet Temp(℃)</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>CD 1 A</span>
                                <label>29.30</label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CD 1 B</span>
                                <label>29.30</label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CD 2 A</span>
                                <label>29.30</label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CD 2 B</span>
                                <label>29.30</label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CD 3 A</span>
                                <label>29.30</label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CD 3 B</span>
                                <label>29.30</label>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:30px;right:160px;">
                    <h4>COND</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label>536.2</label>
                                <span>MM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>VAC</span>
                                <label>5.12</label>
                                <span>KPAA</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>1T</span>
                                <label>30.75</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>1T</span>
                                <label>30.75</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>1T</span>
                                <label>30.75</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:196px;right:160px;">
                    <h4>CEP Disch</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <label>33.88</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F</span>
                                <label>325.09</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block mini" style="top:116px;left:600px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block mini" style="top:170px;left:600px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block mini" style="top:226px;left:600px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block mini" style="top:116px;left:730px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block mini" style="top:170px;left:730px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block mini" style="top:226px;left:730px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:279px;left:640px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:310px;right:170px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                                <span>MPAG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:400px;left:160px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:456px;left:160px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:474px;left:390px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                                <span>KPAA</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:474px;left:640px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                                <span>KPAA</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:474px;left:880px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <label>103.75</label>
                                <span>KPAA</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:570px;left:140px;">
                    <h4>RFT Level</h4>
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>A</span>
                                <label>103.75</label>
                                <span>MM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>B</span>
                                <label>103.75</label>
                                <span>MM</span>
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

