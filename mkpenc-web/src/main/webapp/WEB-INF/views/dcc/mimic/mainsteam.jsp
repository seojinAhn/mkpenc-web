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
				<h3>MAIN STEAM</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>SECONDARY</span><strong>MAIN STEAM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap main_steam">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="#none" class="link_txt" style="top:424px;left:150px;">S/G F/W System</a>
                <a href="#none" class="link_txt" style="top:600px;right:308px;">Condensate System</a>
                <!-- ///range_slider -->              
                <div class="chart_block mini" style="top:200px;left:162px;">
                    <h4>ASDV-PVC1</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <label>0. 0</label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block mini" style="top:200px;left:291px;">
                    <h4>ASDV-PVC2</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <label>0. 0</label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block mini" style="top:200px;left:419px;">
                    <h4>ASDV-PVC3</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <label>0. 0</label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block mini" style="top:200px;left:546px;">
                    <h4>ASDV-PVC4</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <label>0. 0</label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:128px;left:746px;">
                    <h4>ASDV-PVC4</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PWR</span>
                                <label>90.40</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>First P</span>
                                <label>2.7434</label>
                                <span>MPAG</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:220px;right:110px;">
                    <h4>GEN</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PWR</span>
                                <label>633.3</label>
                                <span>MW</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:420px;right:110px;">
                    <h4>COND</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>VAC</span>
                                <label>5.15</label>
                                <span>KPAA</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block" style="top:480px;left:270px;">
                    <h4>SG Press</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>1</span>
                                <label>4.590</label>
                                <span>MPAG</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>2</span>
                                <label>4.590</label>
                                <span>MPAG</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>3</span>
                                <label>4.590</label>
                                <span>MPAG</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>4</span>
                                <label>4.590</label>
                                <span>MPAG</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block double" style="top:508px;left:460px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>S/G Pr</span>
                                <label>4.590</label>
                                <span>MPAG</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ASDVs Opening</span>
                                <label>0.06</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CSDVs Opening</span>
                                <label>0.06</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Total SDVs Opening</span>
                                <label>0.06</label>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:296px;right:408px;">
                    <div class="chart_block_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>CSDV-PVC1</span>
                                <label>0.006</label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:334px;right:408px;">
                    <div class="chart_block_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>CSDV-PVC2</span>
                                <label>0.006</label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:372px;right:408px;">
                    <div class="chart_block_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>CSDV-PVC3</span>
                                <label>0.006</label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:410px;right:408px;">
                    <div class="chart_block_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>CSDV-PVC4</span>
                                <label>0.006</label>
                                <span class="per">%</span>
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
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

