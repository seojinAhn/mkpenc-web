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
				<h3>BEARING DATA</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>MONITOR</span><strong>BEARING DATA</strong></div>
			</div>
			<!-- //page_title -->

            <!-- fx_layout -->
            <div class="fx_layout w_full" style="padding:0 180px;">
                <div class="fx_block">
                    <div class="chart_line_table row no_line">
                        <div class="stitle">XAXIS</div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="stitle">mm</div>
                    </div>
                    <div class="chart_line_table row no_line">
                        <div class="stitle">YAXIS</div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="stitle">mm</div>
                    </div>
                    <div class="bearing_data"></div>
                    <div class="chart_line_table row no_line">
                        <div class="stitle">METAL</div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="stitle">mm</div>
                    </div>
                    <div class="chart_line_table row no_line">
                        <div class="stitle">DRAIN</div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="box_item">
                            <span>0</span>
                        </div>
                        <div class="stitle">mm</div>
                    </div>
                </div>
            </div>
            <!-- //fx_layout -->
            <!-- fx_layout -->
            <div class="fx_layout w_full" style="padding:0 248px;">
                <div class="fx_block">
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h6>OIL TO BRG</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
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
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h6>LOAD</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>MW</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //fx_layout -->
            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block center">
                    <div class="chart_line_table" style="width:700px;">
                        <h4>THRUST BEARING PLATE TEMPERATURE</h4>
                        <div class="line_table_block">
                            <h5>TURBINE SIDE</h5>
                            <h5>GENERATURE</h5>
                        </div>
                        <div class="line_table_block">
                            <h6>MAX TEMP</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <h6>MAX TEMP</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>MAX TEMP</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <h6>MAX TEMP</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>℃</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table" style="width:700px;">
                        <h4>THRUST BEARING DRAIN TEMPERATURE</h4>
                        <div class="line_table_block">
                            <h6>FRONT</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <h6>REAR</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>℃</span>
                                </p>
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

