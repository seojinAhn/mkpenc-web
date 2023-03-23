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
				<h3>COMPOSITE DATA</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>MONITOR</span><strong>COMPOSITE DATA</strong></div>
			</div>
			<!-- //page_title -->

            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>TURBINE</h4>
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>VIB</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>ECC</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>TURB TEMP DIFF</h4>
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>WATER</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>METAL</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>DIFF EXPANSION</h4>
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>DIFF</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>JOURNAL BRG TEMP</h4>                    
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>JOURNAL</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>SHELL EXPANSION</h4>                    
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>SHELL</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //fx_layout -->
            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>GEN LIQUID HDR</h4>
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>HOT</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>AVG</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>GEN STAT SLOT</h4>
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>HOT</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>AVG</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>GEN COLD GAS</h4>
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>HOT</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>COMM</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>GEN CORE MON</h4>                    
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>CORE</h6>
                                        <div class="barchart" style="width:120px;height:180px;">차트</div>
                                        <div class="summary">
                                            <p>
                                                <label>0</label>
                                            </p>
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

