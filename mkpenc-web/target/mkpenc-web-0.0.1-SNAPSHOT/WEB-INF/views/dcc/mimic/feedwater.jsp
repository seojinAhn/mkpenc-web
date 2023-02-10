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
				<h3>FEED WATER</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>SECONDARY</span><strong>FEED WATER</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap feed_water">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="#none" class="link_txt" style="top:34px;right:170px;">SG Main System<br>Pressure System</a>
                <a href="#none" class="link_txt" style="top:384px;right:170px;">Condensate System</a>
                <!-- ///range_slider -->              
                <div class="chart_block small" style="top:76px;left:256px;">
                    <h4>SG 1</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label>2.357</label>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LE</span>
                                <label>0.000</label>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>INT</span>
                                <label>1.45</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W T</span>
                                <label>181.27</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>FW F</span>
                                <label>218.80</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:76px;left:490px;">
                    <h4>SG 2</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label>2.357</label>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LE</span>
                                <label>0.000</label>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>INT</span>
                                <label>1.45</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W T</span>
                                <label>181.27</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>FW F</span>
                                <label>218.80</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:76px;left:726px;">
                    <h4>SG 3</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label>2.357</label>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LE</span>
                                <label>0.000</label>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>INT</span>
                                <label>1.45</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W T</span>
                                <label>181.27</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>FW F</span>
                                <label>218.80</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:76px;right:256px;">
                    <h4>SG 3</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label>2.357</label>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LE</span>
                                <label>0.000</label>
                                <span>METER</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>INT</span>
                                <label>1.45</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>F/W T</span>
                                <label>181.27</label>
                                <span>DEG C</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>FW F</span>
                                <label>218.80</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block small" style="top:470px;left:214px;">
                    <h4>Pp 101 Flow</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Disch</span>
                                <label>401.88</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REC</span>
                                <label>0.00</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:470px;left:424px;">
                    <h4>Pp 102 Flow</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Disch</span>
                                <label>401.88</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REC</span>
                                <label>0.00</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:470px;left:608px;">
                    <h4>Pp 103 Flow</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Disch</span>
                                <label>401.88</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REC</span>
                                <label>0.00</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:504px;left:808px;">
                    <h4>Pp 104 Flow</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Disch</span>
                                <label>401.88</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>REC</span>
                                <label>0.00</label>
                                <span>KG/S</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:460px;right:168px;">
                    <h4>Deaerator</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <label>401.88</label>
                                <span>MM</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:170px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>40.16</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:240px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>0.06</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:308px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>0.09</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:408px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>39.34</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:476px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>39.34</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:546px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>39.34</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:646px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>39.34</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:716px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>39.34</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:784px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>39.34</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:884px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>39.34</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:956px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>39.34</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:274px;left:1028px;">
                    <div class="chart_block_s_contents only_txt">
                        <div class="summary">
                            <p>
                                <span>39.34</span>
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
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

