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

<script type="text/javascript">

$(function () {
	
	
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
			<div class="img_wrap dcc_main">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="#none" class="link_btn link_pht"></a>
                <a href="#none" class="link_btn link_bfp"></a>
                <a href="#none" class="link_btn link_cond"></a>
                <!-- ///range_slider -->              
                <div class="toggle_block" style="top:100px;left:240px;">
                    <h4>PZR</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>METER</p>
                            <p>
                                <span>L</span>
                                <span>8.630</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>MPGA</p>
                                <p>
                                    <span>P</span>
                                    <span>9.667</span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block" style="top:260px;left:140px;">
                    <h4>RX</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>FP</p>
                            <p>
                                <span>PWR</span>
                                <span>0.8584</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>%</p>
                                <p>
                                    <span>ZONE L</span>
                                    <span>50.28</span>
                                </p>
                            </li>
                            <li>
                                <p>FP</p>
                                <p>
                                    <span>PWR E</span>
                                    <span>0.0010</span>
                                </p>
                            </li>
                            <li>
                                <p>DEC/S</p>
                                <p>
                                    <span>LOG R</span>
                                    <span>-0.00128</span>
                                </p>
                            </li>
                            <li>
                                <p>DECADE</p>
                                <p>
                                    <span>PLOG</span>
                                    <span>-0.618</span>
                                </p>
                            </li>
                            <li>
                                <p>FP</p>
                                <p>
                                    <span>PTHM</span>
                                    <span>0.8754</span>
                                </p>
                            </li>
                            <li>
                                <p>H/D P</p>
                                <p>
                                    <span>MPAG</span>
                                    <span>9.865</span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>  
                <div class="toggle_block" style="top:520px;left:560px;">
                    <h4>MOD</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MM</p>
                            <p>
                                <span>L</span>
                                <span>7841.0</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>MPGA</p>
                                <p>
                                    <span>T</span>
                                    <span>69.07</span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>       
                <div class="toggle_block" style="top:80px;left:620px;">
                    <h4>S/G</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>P</span>
                                <span>4.595</span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>#1L</span>
                                    <span>2.369</span>
                                </p>
                            </li>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>#2L</span>
                                    <span>2.369</span>
                                </p>
                            </li>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>#3L</span>
                                    <span>2.369</span>
                                </p>
                            </li>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>#4L</span>
                                    <span>2.369</span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block" style="top:80px;right:190px;">
                    <h4>GE</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MW</p>
                            <p>
                                <span>PWR</span>
                                <span>642.9</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="toggle_block" style="top:260px;right:190px;">
                    <h4>CCW</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <span>17.78</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="toggle_block" style="top:350px;right:190px;">
                    <h4>CCW</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>KPAA</p>
                            <p>
                                <span>VAC</span>
                                <span>4.75</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <span>27.92</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="toggle_block" style="top:490px;right:190px;">
                    <h4>D/A</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MM</p>
                            <p>
                                <span>L</span>
                                <span>3301.5</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <span>122.55</span>
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



