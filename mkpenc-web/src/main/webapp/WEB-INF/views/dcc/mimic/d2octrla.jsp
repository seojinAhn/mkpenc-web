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
				<h3>D2O CONTROL SYSTEM (A-SIDE)</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>FUEL</span><strong>D2O CONTROL SYSTEM (A-SIDE)</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap d2o_control_a_side">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->         
                <div class="chart_block small single" style="top:156px;left:276px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>L/S</p>
                            <p>
                                <span>FT22</span>
                                <span>0.7007</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:98px;left:510px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>PT28</span>
                                <span>5.024</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:116px;left:664px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>ML/S</p>
                            <p>
                                <span>FT24</span>
                                <span>80.47</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:116px;left:894px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>ML/S</p>
                            <p>
                                <span>FT25</span>
                                <span>171.88</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:116px;left:1094px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>L/S</p>
                            <p>
                                <span>FT23</span>
                                <span>0.4534</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:256px;left:330px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>L/S</p>
                            <p>
                                <span>FT21</span>
                                <span>1.4534</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:236px;left:490px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>KPAD</p>
                            <p>
                                <span>PT35</span>
                                <span>***IRR</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:226px;left:616px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>PT4A</span>
                                <span>1.492</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:200px;left:796px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>PT48</span>
                                <span>1.492</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:310px;left:690px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>KPAD</p>
                            <p>
                                <span>PT16</span>
                                <span>625.3</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:400px;left:790px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>DEGC</p>
                            <p>
                                <span>TA46B</span>
                                <span>43.02</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:474px;left:490px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>PT1A</span>
                                <span>3.049</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:520px;left:490px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>PT1B</span>
                                <span>3.049</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:570px;left:620px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>DEGC</p>
                            <p>
                                <span>TA46A</span>
                                <span>39.64</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small single" style="top:526px;right:220px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>ML/S</p>
                            <p>
                                <span>FT27</span>
                                <span>0.059</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
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

