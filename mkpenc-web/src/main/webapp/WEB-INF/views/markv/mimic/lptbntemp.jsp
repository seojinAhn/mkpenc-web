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
				<h3>LP TURBINE DATA(TEMP)</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>Monitor</span><strong>LP TURBINE DATA(TEMP)</strong></div>
			</div>
			<!-- //page_title -->


            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block">
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>INLET BOWL</h6>
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
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
                    </div>
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <div class="title_wrap">
                                            <h6>FIRST STAGE</h6>
                                            <h6>CV CHEST</h6>
                                        </div>
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if>
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
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>9TH STAGE TURBINE END</h6>
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                    	<label class="line">
                                                        	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
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
                    </div>
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>10TH STAGE GENERATOR END</h6>
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                    	<label class="line">
                                                        	<c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[21].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[21].fValue ne null}">${lblDataList[21].fValue}</c:if>
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
                </div>
                <div class="fx_block middle fx_none" style="width:240px;">
                    <div class="chart_line_table">
                        <div class="line_table_block column">
                            <h6>PRESSURE(ABS) HDA</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[22].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[22].fValue ne null}">${lblDataList[22].fValue}</c:if>
                                    </label>
                                    <span>bar</span>
                                </p>
                            </div>
                            <h6>HOOD TEMP HDA</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[23].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[23].fValue ne null}">${lblDataList[23].fValue}</c:if>
                                    </label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <h6>PRESSURE(ABS) HDB</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[24].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[24].fValue ne null}">${lblDataList[24].fValue}</c:if>
                                    </label>
                                    <span>bar</span>
                                </p>
                            </div>
                            <h6>HOOD TEMP HDB</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[25].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[25].fValue ne null}">${lblDataList[25].fValue}</c:if>
                                    </label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <h6>PRESSURE(ABS) HDC</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[26].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[26].fValue ne null}">${lblDataList[26].fValue}</c:if>
                                    </label>
                                    <span>bar</span>
                                </p>
                            </div>
                            <h6>HOOD TEMP HDC</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[27].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[27].fValue ne null}">${lblDataList[27].fValue}</c:if>
                                    </label>
                                    <span>deg C</span>
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

