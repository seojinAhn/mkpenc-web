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
                            <span>
                            	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                            </span>
                        </div>
                        <div class="stitle">mm</div>
                    </div>
                    <div class="chart_line_table row no_line">
                        <div class="stitle">YAXIS</div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if>
                            </span>
                        </div>
                        <div class="stitle">mm</div>
                    </div>
                    <div class="bearing_data"></div>
                    <div class="chart_line_table row no_line">
                        <div class="stitle">METAL</div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[21].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[21].fValue ne null}">${lblDataList[21].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[22].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[22].fValue ne null}">${lblDataList[22].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[23].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[23].fValue ne null}">${lblDataList[23].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[24].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[24].fValue ne null}">${lblDataList[24].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[25].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[25].fValue ne null}">${lblDataList[25].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[26].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[26].fValue ne null}">${lblDataList[26].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[27].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[27].fValue ne null}">${lblDataList[27].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[28].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[28].fValue ne null}">${lblDataList[28].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[29].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[29].fValue ne null}">${lblDataList[29].fValue}</c:if>
                            </span>
                        </div>
                        <div class="stitle">mm</div>
                    </div>
                    <div class="chart_line_table row no_line">
                        <div class="stitle">DRAIN</div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[30].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[30].fValue ne null}">${lblDataList[30].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[31].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[31].fValue ne null}">${lblDataList[31].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[32].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[32].fValue ne null}">${lblDataList[32].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[33].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[33].fValue ne null}">${lblDataList[33].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[34].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[34].fValue ne null}">${lblDataList[34].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[35].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[35].fValue ne null}">${lblDataList[35].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[36].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[36].fValue ne null}">${lblDataList[36].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[37].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[37].fValue ne null}">${lblDataList[37].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[38].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[38].fValue ne null}">${lblDataList[38].fValue}</c:if>
                            </span>
                        </div>
                        <div class="box_item">
                            <span>
                            	<c:if test="${lblDataList[39].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[39].fValue ne null}">${lblDataList[39].fValue}</c:if>
                            </span>
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
                                    <label>
                                    	<c:if test="${lblDataList[40].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[40].fValue ne null}">${lblDataList[40].fValue}</c:if>
                                    </label>
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
                                    <label>
                                    	<c:if test="${lblDataList[41].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[41].fValue ne null}">${lblDataList[41].fValue}</c:if>
                                    </label>
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
                                    <label>
                                    	<c:if test="${lblDataList[42].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[42].fValue ne null}">${lblDataList[42].fValue}</c:if>
                                    </label>
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
                                    <label>
                                    	<c:if test="${lblDataList[43].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[43].fValue ne null}">${lblDataList[43].fValue}</c:if>
                                    </label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <h6>MAX TEMP</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[44].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[44].fValue ne null}">${lblDataList[44].fValue}</c:if>
                                    </label>
                                    <span>deg C</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>NORM MAX DIFF</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[45].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[45].fValue ne null}">${lblDataList[45].fValue}</c:if>
                                    </label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <h6>NORM MAX DIFF</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[46].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[46].fValue ne null}">${lblDataList[46].fValue}</c:if>
                                    </label>
                                    <span>deg C</span>
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
                                    <label>
                                    	<c:if test="${lblDataList[47].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[47].fValue ne null}">${lblDataList[47].fValue}</c:if>
                                    </label>
                                    <span>deg C</span>
                                </p>
                            </div>
                            <h6>REAR</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[48].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[48].fValue ne null}">${lblDataList[48].fValue}</c:if>
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

