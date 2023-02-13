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
				<h3>LIQUID ZONE CONTROL SYSTEM II</h3>
				<div class="bc"><span>DCC</span><span>Mimic</span><span>PRIMARY</span><strong>LIQUID ZONE CONTROL SYSTEM II</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap lzc_ii">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- //range_slider -->              
                <!-- LCV44 -->
                <div class="chart_block_s" style="top:190px;right:1150px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>50.38</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV443-->
                <div class="chart_block_s" style="top:140px;left:306px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>49.19</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV47 -->
                <div class="chart_block_s" style="top:240px;right:1000px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>46.94</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV46 -->
                <div class="chart_block_s" style="top:190px;left:414px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>50.34</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV45 -->
                <div class="chart_block_s" style="top:140px;left:470px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>54.04</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV49 -->
                <div class="chart_block_s" style="top:190px;right:830px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>42.41</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV48 -->
                <div class="chart_block_s" style="top:142px;left:616px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>50.03</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV56 -->
                <div class="chart_block_s" style="top:186px;right:670px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>52.19</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV55 -->
                <div class="chart_block_s" style="top:136px;left:790px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>49.47</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV54 -->
                <div class="chart_block_s" style="top:240px;right:536px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>46.03</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV53 -->
                <div class="chart_block_s" style="top:186px;right:430px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>42.94</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV52 -->
                <div class="chart_block_s" style="top:136px;left:940px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>55.84</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV51 -->
                <div class="chart_block_s" style="top:200px;right:356px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>42.53</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- LCV50 -->
                <div class="chart_block_s" style="top:136px;left:1100px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span>48.47</span>
                                <span>%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 1 -->
                <div class="chart_block_s" style="top:320px;right:1100px;">
                    <h4>Pt-1A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:320px;left:318px;">
                    <h4>Pt-1C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 2 -->
                <div class="chart_block_s" style="top:430px;right:1100px;">
                    <h4>Pt-2A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:430px;left:318px;">
                    <h4>Pt-2C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 3 -->
                <div class="chart_block_s" style="top:270px;right:938px;">
                    <h4>Pt-3A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:270px;left:478px;">
                    <h4>Pt-3C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 4 -->
                <div class="chart_block_s" style="top:380px;right:938px;">
                    <h4>Pt-4A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:380px;left:478px;">
                    <h4>Pt-4C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 5 -->
                <div class="chart_block_s" style="top:480px;right:938px;">
                    <h4>Pt-5A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:480px;left:478px;">
                    <h4>Pt-5C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 6 -->
                <div class="chart_block_s" style="top:320px;right:792px;">
                    <h4>Pt-6A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:320px;left:624px;">
                    <h4>Pt-6C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 7 -->
                <div class="chart_block_s" style="top:430px;right:792px;">
                    <h4>Pt-7A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:430px;left:624px;">
                    <h4>Pt-7C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 13 -->
                <div class="chart_block_s" style="top:320px;right:621px;">
                    <h4>Pt-13A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:320px;left:795px;">
                    <h4>Pt-13C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 14 -->
                <div class="chart_block_s" style="top:430px;right:621px;">
                    <h4>Pt-14A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:430px;left:795px;">
                    <h4>Pt-14C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 10 -->
                <div class="chart_block_s" style="top:270px;right:470px;">
                    <h4>Pt-10A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:270px;left:946px;">
                    <h4>Pt-10C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 11 -->
                <div class="chart_block_s" style="top:380px;right:470px;">
                    <h4>Pt-11A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:380px;left:946px;">
                    <h4>Pt-11C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 12 -->
                <div class="chart_block_s" style="top:480px;right:470px;">
                    <h4>Pt-12A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:480px;left:946px;">
                    <h4>Pt-12C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 8 -->
                <div class="chart_block_s" style="top:320px;right:310px;">
                    <h4>Pt-8A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:320px;left:1106px;">
                    <h4>Pt-8C</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- ZONE 9 -->
                <div class="chart_block_s" style="top:430px;right:310px;">
                    <h4>Pt-9A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block_s" style="top:430px;left:1106px;">
                    <h4>Pt-9A</h4>
                    <div class="chart_block_s_contents">
                        <div class="summary">
                            <p>
                                <span>0.8513</span>
                                <span>FP</span>
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

