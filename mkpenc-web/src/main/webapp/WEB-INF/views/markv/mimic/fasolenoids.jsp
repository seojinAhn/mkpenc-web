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
				<h3>PROTECTIVE TESTS FA SOLENOIDS</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>TESTs</span><strong>FA SOLENOIDS</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap" style="min-height:580px;">
                <div class="fx_layout no_mg" style="position:absolute;top:60px;left:50%;width:800px;height:366px;margin-left:-400px;">
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>CONTROLLER〈R〉</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>IV TRIGGER</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_r_iv" name="switch_r_iv" value="" checked/>
                                    <label for="off_r_iv">OFF</label>
                                    <input type="radio" id="on_r_iv" name="switch_r_iv" value="" />
                                    <label for="on_r_iv">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>PLU</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_r_plu" name="switch_r_plu" value="" checked/>
                                    <label for="off_r_plu">OFF</label>
                                    <input type="radio" id="on_r_plu" name="switch_r_plu" value="" />
                                    <label for="on_r_plu">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                </div>
                            </div>
                        </div> 
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>CONTROLLER〈R〉</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>IV TRIGGER</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_s_iv" name="switch_s_iv" value="" checked/>
                                    <label for="off_s_iv">OFF</label>
                                    <input type="radio" id="on_s_iv" name="switch_s_iv" value="" />
                                    <label for="on_s_iv">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>PLU</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_s_plu" name="switch_s_plu" value="" checked/>
                                    <label for="off_s_plu">OFF</label>
                                    <input type="radio" id="on_s_plu" name="switch_s_plu" value="" />
                                    <label for="on_s_plu">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                </div>
                            </div>
                        </div> 
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small">
                            <h4>CONTROLLER〈T〉</h4>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>IV TRIGGER</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_t_iv" name="switch_t_iv" value="" checked/>
                                    <label for="off_t_iv">OFF</label>
                                    <input type="radio" id="on_t_iv" name="switch_t_iv" value="" />
                                    <label for="on_t_iv">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h5>PLU</h5>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                    <input type="radio" id="off_t_plu" name="switch_t_plu" value="" checked/>
                                    <label for="off_t_plu">OFF</label>
                                    <input type="radio" id="on_t_plu" name="switch_t_plu" value="" />
                                    <label for="on_t_plu">ON</label>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
                <div class="chart_block small wide" style="top:460px;left:470px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>ACTIVE TEST</span>
                                <span>
                                	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                </span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>BREAKER</span>
                                <span>
                                	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                </span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MODE</span>
                                <span>
                                	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:460px;left:700px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>SPEED</span>
                                <span>
                                	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                </span>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LOAD</span>
                                <span>
                                	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                </span>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CVR</span>
                                <span>
                                	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                </span>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>IVR</span>
                                <span>
                                	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                </span>
                                <span>%</span>
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
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

