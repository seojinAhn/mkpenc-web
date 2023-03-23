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
<script type="text/javascript" src="<c:url value="/resources/js/mimic.js" />" charset="utf-8"></script>
</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-markv-header.jspf" %>
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>STEAM VALVE STATUS</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>STEAM VALVE STATUS</strong></div>
			</div>
			<!-- //page_title -->


            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block">
                    <div class="chart_line_table line">
                        <div class="img_wrap steam_valve_status">
                            <div class="chart_block_s only_box" style="top:84px;left:74px;">0</div>
                            <div class="chart_block_s only_box" style="top:84px;left:170px;">0</div>
                            <div class="chart_block_s only_box" style="top:250px;left:166px;">0</div>
                            <div class="chart_block_s only_box" style="top:250px;left:244px;">0</div>
                        </div>
                    </div>                        
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h6>SPEED</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>rpm</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>CV DEMAND</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>IV DEMAND</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>SPD/LD STAT</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span></span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>MW LOAD</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>MW</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>                
                <div class="fx_block">
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                        <label class="line">0</label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //fx_layout -->
                
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

