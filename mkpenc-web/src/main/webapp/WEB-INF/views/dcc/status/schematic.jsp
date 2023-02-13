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
				<h3>PLANT SCHEMATIC DIAGRAM</h3>
				<div class="bc"><span>DCC</span><span>STATUS</span><strong>PLANT SCHEMATIC DIAGRAM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap plant_schematic_diagram">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                   
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->
                <div class="chart_block small wide" style="top:40px;left:180px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>SG P</span>
                                <span>4.596</span>
                                <span>MPAG</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>STM WTR F</span>
                                <span>4.596</span>
                                <span>MPAG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- GENERATOR -->
                <div class="chart_block small" style="top:164px;right:200px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span>4.596</span>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span></span>
                                <span>4.596</span>
                                <span>KV</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- // GENERATOR -->
                <!-- CONDENSER -->
                <div class="chart_block small wide" style="top:296px;right:200px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>VAC</span>
                                <span>4.596</span>
                                <span>KPAA</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span>4.596</span>
                                <span>MM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span>4.596</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:378px;right:200px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>T IN</span>
                                <span>4.596</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T OUT</span>
                                <span>4.596</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- // CONDENSER -->                
                <div class="chart_block small" style="top:154px;left:210px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>1</span>
                                <span>2.351</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>3</span>
                                <span>2.351</span>
                                <span>METER</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:154px;left:390px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>2</span>
                                <span>2.351</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>4</span>
                                <span>2.351</span>
                                <span>METER</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:246px;left:270px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>ROH P</span>
                                <span>9.874</span>
                                <span>MPAG</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PZR LVL (Lc)</span>
                                <span>2.351</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T OUT</span>
                                <span>2.351</span>
                                <span>DFG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T IN</span>
                                <span>2.351</span>
                                <span>DFG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PWR RTE</span>
                                <span>2.351</span>
                                <span>DEC/S</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>RX PWR</span>
                                <span>2.351</span>
                                <span>FP</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ZONE LVL</span>
                                <span>2.351</span>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MOD L</span>
                                <span>2.351</span>
                                <span>MM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MOD T</span>
                                <span>2.351</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="chart_block small wide" style="top:560px;left:180px;">
                <div class="chart_block_contents bd_none">
                    <div class="summary">
                        <p>
                            <span>FEED WTR F</span>
                            <span>4.596</span>
                            <span>KG/S</span>
                        </p>
                    </div>
                    <div class="summary">
                        <p>
                            <span>FEED WTR T</span>
                            <span>4.596</span>
                            <span>DEG C</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="chart_block small" style="top:600px;left:620px;">
                <div class="chart_block_contents bd_none">
                    <div class="summary">
                        <p>
                            <span>P</span>
                            <span>4.596</span>
                            <span>KPAG</span>
                        </p>
                    </div>
                    <div class="summary">
                        <p>
                            <span>L</span>
                            <span>4.596</span>
                            <span>MM</span>
                        </p>
                    </div>
                    <div class="summary">
                        <p>
                            <span>T</span>
                            <span>4.596</span>
                            <span>DEG C</span>
                        </p>
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
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

