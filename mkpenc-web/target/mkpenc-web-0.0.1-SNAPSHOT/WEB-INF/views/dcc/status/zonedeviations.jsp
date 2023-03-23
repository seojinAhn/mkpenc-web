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
				<h3>ZONE DEVIATIONS</h3>
				<div class="bc"><span>MARK_V</span><span>Status</span><strong>ZONE DEVIATIONS</strong></div>
			</div>
			<!-- //page_title -->

            <!-- barchart_layout -->
            <div class="barchart_layout">
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>1 & 8</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                    <div class="barchart_item">
                        <h6>2 & 9</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                </div>
                <div class="barchart_block">
                    <h5>
                        <span>LEVEL AVG</span>
                        <strong>50.74</strong>
                    </h5>
                    <div class="barchart_item">
                        <h6>3 & 10</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                    <div class="barchart_item">
                        <h6>4 & 11</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                    <div class="barchart_item">
                        <h6>5 & 12</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                </div>
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>6 & 13</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                    <div class="barchart_item">
                        <h6>7 & 14</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                </div>
                <div class="barchart_gap">
                </div>
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>1 & 8</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                    <div class="barchart_item">
                        <h6>2 & 9</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                </div>
                <div class="barchart_block">
                    <h5>
                        <span>FLUX AVG</span>
                        <strong>50.74</strong>
                    </h5>
                    <div class="barchart_item">
                        <h6>3 & 10</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                    <div class="barchart_item">
                        <h6>4 & 11</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                    <div class="barchart_item">
                        <h6>5 & 12</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                </div>
                <div class="barchart_block">
                    <div class="barchart_item">
                        <h6>6 & 13</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                    <div class="barchart_item">
                        <h6>7 & 14</h6>
                        <div class="barchart" style="width:120px;height:160px;">차트</div>                        
                    </div>
                </div>
            </div>
            <!-- //barchart_layout -->
                
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

