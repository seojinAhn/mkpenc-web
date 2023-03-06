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
				<h3>PRIMARY HEAT TRANSPORT SYSTEM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>PRIMARY</span><strong>PRIMARY HEAT TRANSPORT SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap pht">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- //range_slider -->              
                <a href="#none" class="link_btn link_01"></a>
                <a href="#none" class="link_btn link_02"></a>
                <div class="chart_block" style="top:324px;left:646px;width:auto;">
                    <div class="chart_block_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>RX PWR :</span>
                                <span>0.8593</span>
                                <span class="unit">FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:30px;left:160px;">
                    <h4>Pp Speed</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>1</span>
                                <span>1790.3</span>
                                <span>RPM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>2</span>
                                <span>1790.3</span>
                                <span>RPM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>3</span>
                                <span>1790.3</span>
                                <span>RPM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>4</span>
                                <span>1790.3</span>
                                <span>RPM</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:200px;left:160px;">
                    <h4>Purification</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span>49.65</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F</span>
                                <span>20.183</span>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:420px;left:160px;">
                    <h4>RX △T</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>H 1-4</span>
                                <span>39.92</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>H 2-3</span>
                                <span>39.92</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>H 5-8</span>
                                <span>39.92</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>H 6-7</span>
                                <span>39.92</span>
                                <span>DEG C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small double" style="top:60px;left:560px;">
                    <h4>RX Inlet HD</h4>
                    <div class="chart_block_contents fx_row">
                        <div class="fx_block">
                            <div class="summary">
                                <p>
                                    <span>HD2 T</span>
                                    <span>365.22</span>
                                    <span>DEG C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD4 T</span>
                                    <span>365.22</span>
                                    <span>DEG C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD6 T</span>
                                    <span>365.22</span>
                                    <span>DEG C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD8 T</span>
                                    <span>365.22</span>
                                    <span>DEG C</span>
                                </p>
                            </div>
                        </div>
                        <div class="fx_block">
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span>11.071</span>
                                    <span>MPGA</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span>11.071</span>
                                    <span>MPGA</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span>11.071</span>
                                    <span>MPGA</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span>11.071</span>
                                    <span>MPGA</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart_block small double" style="top:480px;left:560px;">
                    <h4>RX Outlet HD</h4>
                    <div class="chart_block_contents fx_row">
                        <div class="fx_block">
                            <div class="summary">
                                <p>
                                    <span>HD1 T</span>
                                    <span>365.22</span>
                                    <span>DEG C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD3 T</span>
                                    <span>365.22</span>
                                    <span>DEG C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD5 T</span>
                                    <span>365.22</span>
                                    <span>DEG C</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>HD7T</span>
                                    <span>365.22</span>
                                    <span>DEG C</span>
                                </p>
                            </div>
                        </div>
                        <div class="fx_block">
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span>11.071</span>
                                    <span>MPGA</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span>11.071</span>
                                    <span>MPGA</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span>11.071</span>
                                    <span>MPGA</span>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <span>p</span>
                                    <span>11.071</span>
                                    <span>MPGA</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:440px;right:120px;">
                    <h4>PZR</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>p</span>
                                <span>9.662</span>
                                <span>MPGA</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Pe</span>
                                <span>-0.028</span>
                                <span>MPGA</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Ls</span>
                                <span>8.648</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span>8.623</span>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Le</span>
                                <span>-0.030</span>
                                <span>METER</span>
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

