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
				<h3>GENERAL DATA</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>SECONDARY</span><strong>GENERAL DATA</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap general_data">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="#none" class="link_btn link_01"></a>
                <!-- ///range_slider -->              
                <div class="chart_block small wide" style="top:50px;left:140px;">
                    <h4>MAIN STEAM</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESS</span>
                                <label>0</label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label>0</label>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:136px;left:140px;">
                    <h4>FIRST STAGE</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESS</span>
                                <label>0</label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label>0</label>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:222px;left:140px;">
                    <h4>REHEATERINLET</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESS</span>
                                <label>0</label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label>0</label>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:60px;left:560px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>CV DEMAND</span>
                                <label>0</label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:290px;left:560px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>IV DEMAND</span>
                                <label>0</label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:130px;left:390px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>1</span>
                                <label>0</label>
                                <span class="per">%</span>
                                <label>0</label>
                                 <span class="per">%</span>
                            </p>
                            <p>
                                <span>2</span>
                                <label>0</label>
                                 <span class="per">%</span>
                                <label>0</label>
                                 <span class="per">%</span>
                            </p>
                            <p>
                                <span>3</span>
                                <label>0</label>
                                 <span class="per">%</span>
                                <label>0</label>
                                 <span class="per">%</span>
                            </p>
                            <p>
                                <span>4</span>
                                <label>0</label>
                                 <span class="per">%</span>
                                <label>0</label>
                                 <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block small wide" style="top:50px;left:800px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>BREAKER</span>
                                <label>0</label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPEED</span>
                                <label>0</label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MODE</span>
                                <label>0</label>
                                <span></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:50px;right:160px;">
                    <h4>GENERATOR</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <label>0</label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label>0</label>
                                <span>MVAR</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label>0</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label>0</label>
                                <span>Hz</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label>0</label>
                                <span>PF</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small double" style="top:330px;left:140px;">
                    <h4>STEAM TURBINE</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>MAIN STEAM</span>
                                <label>0</label>
                                <span>deg C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REHEAT STEAM</span>
                                <label>0</label>
                                <span>deg C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>OIL FROM BRG</span>
                                <label>0</label>
                                <span>deg C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PEAK SPEED</span>
                                <label>0</label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPEED</span>
                                <label>0</label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CV REF</span>
                                <label>0</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>OIL TO BRG</span>
                                <label>0</label>
                                <span>deg C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>DC OIL PUMP</span>
                                <label>0</label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>TURNING GEAR</span>
                                <label>0</label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ROTOR</span>
                                <label>0</label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LUBE OIL PRS</span>
                                <label>0</label>
                                <span></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small double" style="top:330px;left:520px;">
                    <h4>GENERATOR</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>LOAD</span>
                                <label>0</label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LOAD</span>
                                <label>0</label>
                                <span>MVAR</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PWR FACTOR</span>
                                <label>0</label>
                                <span>PF</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>FRQUENCY</span>
                                <label>0</label>
                                <span>Hz</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>GEN FIELD</span>
                                <label>0</label>
                                <span>AMPS</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>GEN FIELD</span>
                                <label>0</label>
                                <span>V DC</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>HYD PRESS</span>
                                <label>0</label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>HYD PURITY</span>
                                <label>0</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REG CON MODE</span>
                                <label>0</label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>GEN LINE BKR</span>
                                <label>0</label>
                                <span></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small double" style="top:330px;right:160px;">
                    <h4>GENERATOR VOLTS</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PH (A-B)</span>
                                <label>0</label>
                                <span>KV</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PH (B-C)</span>
                                <label>0</label>
                                <span>KV</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PH (C-A)</span>
                                <label>0</label>
                                <span>KV</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small double" style="top:460px;right:160px;">
                    <h4>GENERATOR AMPS</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PH (A)</span>
                                <label>0</label>
                                <span>AMPS</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PH (B)</span>
                                <label>0</label>
                                <span>AMPS</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PH (C)</span>
                                <label>0</label>
                                <span>AMPS</span>
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

