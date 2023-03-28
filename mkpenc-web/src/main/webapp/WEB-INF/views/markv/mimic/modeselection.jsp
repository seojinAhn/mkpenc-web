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
				<h3>MODE SELECTION</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>MODE SELECTION</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap mode_selection">
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
                                <label>
                                	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                </label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label>
                                	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                </label>
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
                                <label>
                                	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                                </label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label>
                                	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                </label>
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
                                <label>
                                	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                </label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label>
                                	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                </label>
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
                                <label>
                                	<c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if>
                                </label>
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
                                <label>
                                	<c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if>
                                </label>
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
                                <label>
                                	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                </label>
                                <span class="per">%</span>
                                <label>
                                	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                </label>
                                 <span class="per">%</span>
                            </p>
                            <p>
                                <span>2</span>
                                <label>
                                	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                                </label>
                                 <span class="per">%</span>
                                <label>
                                	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                                </label>
                                 <span class="per">%</span>
                            </p>
                            <p>
                                <span>3</span>
                                <label>
                                	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                </label>
                                 <span class="per">%</span>
                                <label>
                                	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                </label>
                                 <span class="per">%</span>
                            </p>
                            <p>
                                <span>4</span>
                                <label>
                                	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                                </label>
                                 <span class="per">%</span>
                                <label>
                                	<c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if>
                                </label>
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
                                <label>
                                	<c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if>
                                </label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPEED</span>
                                <label>
                                	<c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if>
                                </label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MODE</span>
                                <label>
                                	<c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if>
                                </label>
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
                                <label>
                                	<c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if>
                                </label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label>
                                	<c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if>
                                </label>
                                <span>MVAR</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label>
                                	<c:if test="${lblDataList[21].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[21].fValue ne null}">${lblDataList[21].fValue}</c:if>
                                </label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label>
                                	<c:if test="${lblDataList[22].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[22].fValue ne null}">${lblDataList[22].fValue}</c:if>
                                </label>
                                <span>Hz</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label>
                                	<c:if test="${lblDataList[23].fValue eq null}">0</c:if>
                                	<c:if test="${lblDataList[23].fValue ne null}">${lblDataList[23].fValue}</c:if>
                                </label>
                                <span>PF</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="fx_layout column no_mg" style="position:absolute;top:360px;left:400px;width:300px;height:157px;">
                    <div class="chart_block small fx_full">
                        <h4>TURBINE MODE SELECTION</h4>
                        <div class="chart_block_contents">
                            <div class="switch_button">
                                <input type="radio" id="yes_gov" name="switch_gov" value="" checked/>
                                <label for="yes_gov">Yes</label>
                                <input type="radio" id="no_gov" name="switch_gov" value="" />
                                <label for="no_gov">No</label>
                            </div>
                        </div>
                    </div>                        
                    <div class="chart_block small fx_full">
                        <h4>LOAD CONTROL MODE</h4>
                        <div class="chart_block_contents">
                            <div class="switch_button fx_nowrap">
                                <input type="radio" id="load_local" name="switch_load" value="" checked/>
                                <label for="load_local">LOCAL</label>
                                <input type="radio" id="load_remote" name="switch_load" value="" />
                                <label for="load_remote">REMOTE</label>
                                <input type="radio" id="load_umc" name="switch_load" value="" />
                                <label for="load_umc">UMC</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:360px;right:460px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>SPEED</span>
                                <label>0</label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LOAD</span>
                                <label>0</label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>CVR</span>
                                <label>0</label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>IVR</span>
                                <label>0</label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>BREAKER</span>
                                <label>0</label>
                                <span></span>
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
            </div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
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

