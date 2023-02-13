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
				<h3>FUEL HANDLING SYSTEM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>FUEL</span><strong>FUEL HANDLING SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap fuel_handling">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="" class="link_txt" style="top:150px;left:540px;">F/M (A)</a>
                <a href="" class="link_txt" style="top:150px;right:490px;">F/M (C)</a>
                <!-- ///range_slider -->         
                <div class="chart_block small wide" style="top:180px;left:140px;">
                    <h4>Control Pressure (A side)</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Mag.Pr.</span>
                                <span>0.422</span>
                                <span>MPa</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>C-Ram Pr.</span>
                                <span>0.000</span>
                                <span>MPa</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:180px;right:100px;">
                    <h4>Control Pressure (C side)</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Mag.Pr.</span>
                                <span>0.422</span>
                                <span>MPa</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>C-Ram Pr.</span>
                                <span>0.000</span>
                                <span>MPa</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block small wide" style="top:230px;left:420px;">
                    <h4>Ram Position (A side)</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>B-Ram Position</span>
                                <span>-0.9</span>
                                <span>CM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>C-Ram Position</span>
                                <span>0.5</span>
                                <span>CM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L-Ram Position</span>
                                <span>-0.990</span>
                                <span>CM</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:230px;right:370px;">
                    <h4>Ram Position (C side)</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>B-Ram Position</span>
                                <span>-0.3</span>
                                <span>CM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>C-Ram Position</span>
                                <span>2.5</span>
                                <span>CM</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L-Ram Position</span>
                                <span>-0.854</span>
                                <span>CM</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="bottom:110px;right:250px;">
                    <h4>D2O Supply Pressure</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Common Pr.</span>
                                <span>0.457</span>
                                <span>MPa</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>A-Side Pr.</span>
                                <span>0.393</span>
                                <span>MPa</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>C-Side Pr.</span>
                                <span>0.403</span>
                                <span>MPa</span>
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

