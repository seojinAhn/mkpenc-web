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

<script type="text/javascript">
var timerOn = false; //true로 변경
var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

$(function () {

	if( $("input:radio[id='4']").is(":checked") ) {
		hogiHeader = "4";
	} else {
		hogiHeader = "3";
	}
	if( $("input:radio[id='Y']").is(":checked") ) {
		xyHeader = "Y";
	} else {
		xyHeader = "X";
	}
	
	var lblDateVal = '${SearchTime}';
	$("#lblDate").text(lblDateVal);
	
	$(document.body).delegate('#3', 'click', function() {
		setTimer('3',xyHeader,0);
	});
	$(document.body).delegate('#4', 'click', function() {
		setTimer('4',xyHeader,0);
	});
	$(document.body).delegate('#X', 'click', function() {
		setTimer(hogiHeader,'X',0);
	});

	setTimer(hogiHeader,xyHeader,5000);

});	

function setTimer(hogiHeader,xyHeader,interval) {
	if( interval > 0 ) {
		setTimeout(function() {
			if( timerOn ) {
				var	comSubmit	=	new ComSubmit("tbnstemsealsysFrm");
				comSubmit.setUrl("/markv/mimic/tbnstemsealsys");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("tbnstemsealsysFrm");
		comSubmit.setUrl("/markv/mimic/tbnstemsealsys");
		comSubmit.addParam("hogiHeader",hogiHeader);
		comSubmit.addParam("xyHeader",xyHeader);
		comSubmit.submit();
	}
}
</script>

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
				<h3>STEAM SEAL SYSTEM</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>STEAM SEAL SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<form id="tbnstemsealsysFrm" style="display:none"></form>
			<div class="img_wrap tbn_steam_seal">          
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->
                <!-- 4115-MV005 -->
                <div class="chart_block_s" style="top:180px;left:360px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span><c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- 4115-MV003 -->
                <div class="chart_block_s" style="top:180px;right:210px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span><c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- 4115-MV007 -->
                <div class="chart_block_s" style="top:370px;left:254px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span><c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- 64115-PCV1 -->
                <div class="chart_block_s" style="top:370px;left:456px;">
                    <div class="chart_block_s_contents only_box">
                        <div class="summary">
                            <p>
                                <span><c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:420px;left:440px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>SPE WATER LEVEL</span>
                                <span><c:if test="${lblDataList[4].fValue eq null}">0.0572</c:if>
                                <c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPE VACUUM</span>
                                <span><c:if test="${lblDataList[5].fValue eq null}">0.0572</c:if>
                                <c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPE MOTOR A</span>
                                <span><c:if test="${lblDataList[6].fValue eq null}">0.0572</c:if>
                                <c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPE MOTOR B</span>
                                <span><c:if test="${lblDataList[7].fValue eq null}">0.0572</c:if>
                                <c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if></span>
                            </p>
                        </div>                        
                    </div>
                </div>
                <div class="chart_block small double" style="top:420px;left:660px;">
                    <div class="chart_block_contents only_box">

                        <div class="summary">
                            <p>
                                <span>SSH PRESSURE</span>
                                <span><c:if test="${lblDataList[8].fValue eq null}">0.0572</c:if>
                                <c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if></span>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SSH TEMPERATURE</span>
                                <span><c:if test="${lblDataList[9].fValue eq null}">0.0572</c:if>
                                <c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if></span>
                                <span>deg C</span>
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

