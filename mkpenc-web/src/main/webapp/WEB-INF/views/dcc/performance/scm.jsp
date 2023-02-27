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
<script type="text/javascript" src="<c:url value="/resources/js/performance.js" />" charset="utf-8"></script>

<script type="text/javascript">

$(function () {
	
	var timer =0;
			
	timer = setInterval(function () {
 				
		// 화면초기화
		var	comSubmit	=	new ComSubmit("safeVarSearch");
		comSubmit.setUrl("/dcc/performance/requiredsafevar");
		comSubmit.submit();
		
	}, 5000); 	 
 
});	


</script>

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
				<h3>SCM</h3>
				<div class="bc"><span>DCC</span><span>Performance</span><strong>SCM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap sub_cooling_margin">
                <div class="img_mask"></div>
                <!-- 데이터 표시영역 start : 가로(660px) X 세로(450px) -->
                <div class="data_area" style="top:89px;left:254px;">
                    <span class="spot_header_2" style="top:120px;left:550px;"></span>
                    <span class="spot_header_4" style="top:130px;left:590px;"></span>
                    <span class="spot_header_6" style="top:140px;left:560px;"></span>
                    <span class="spot_header_8" style="top:150px;left:520px;"></span>
                </div>
                <!-- //데이터 표시영역 end -->
                <div class="chart_block small wide" style="top:88px;right:240px;">
                    <h4 class="header_2">HEADER #2</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Pressure</span>
                                <span>11.088</span>
                                <span>Mpa(g)</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Temp</span>
                                <span>11.088</span>
                                <span>Mpa(g)</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SCM</span>
                                <span>11.088</span>
                                <span>SCM(g)</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:204px;right:240px;">
                    <h4 class="header_4">HEADER #4</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Pressure</span>
                                <span>11.088</span>
                                <span>Mpa(g)</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Temp</span>
                                <span>11.088</span>
                                <span>Mpa(g)</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SCM</span>
                                <span>11.088</span>
                                <span>SCM(g)</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:320px;right:240px;">
                    <h4 class="header_6">HEADER #6</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Pressure</span>
                                <span>11.088</span>
                                <span>Mpa(g)</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Temp</span>
                                <span>11.088</span>
                                <span>Mpa(g)</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SCM</span>
                                <span>11.088</span>
                                <span>SCM(g)</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:436px;right:240px;">
                    <h4 class="header_8">HEADER #8</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Pressure</span>
                                <span>11.088</span>
                                <span>Mpa(g)</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Temp</span>
                                <span>11.088</span>
                                <span>Mpa(g)</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SCM</span>
                                <span>11.088</span>
                                <span>SCM(g)</span>
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
</body>
</html>

