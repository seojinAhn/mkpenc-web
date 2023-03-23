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
                                                <label>
                                                	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if>
                                                </label>
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
                                                <label>
                                                	<c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                					<c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if>
                                                </label>
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

