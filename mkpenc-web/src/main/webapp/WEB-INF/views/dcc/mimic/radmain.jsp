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
				<h3>RADIATION SYSTEM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>RADIATION</span><strong>RADIATION SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap radiation_system">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none">RB Base</a></li>
                        <li><a href="#none">RB 1F</a></li>
                        <li><a href="#none">RB 2F</a></li>
                        <li><a href="#none">RB 3F</a></li>
                        <li><a href="#none">RB 4F</a></li>
                        <li><a href="#none">RB 5F</a></li>
                        <li><a href="#none">SB Base</a></li>
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
                <div class="chart_block small wide" style="top:140px;left:180px;">
                    <h4>배기중 방사능 농도</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>불활성 기체</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>삼중수소</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block small" style="top:40px;left:550px;">
                    <h4>기체폐기물 배출율</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span>2283.5</span>
                                <span>M3/MIN</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:40px;left:720px;">
                    <h4>금일방사능 배출량</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>입자</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>옥소</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>불활성 기체</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:150px;right:160px;">
                    <h4>금일방사능 배출량</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>입자</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>옥소</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>불활성 기체</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="bottom:160px;right:60px;">
                    <h4>액체배출 유량</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="bottom:60px;right:60px;">
                    <h4>금일 방사능 배출량</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>전베타</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>감마</span>
                                <span>0.0572</span>
                                <span>% DEL</span>
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
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

