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
				var	comSubmit	=	new ComSubmit("sealoilsysFrm");
				comSubmit.setUrl("/markv/mimic/sealoilsys");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("sealoilsysFrm");
		comSubmit.setUrl("/markv/mimic/sealoilsys");
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
				<h3>GENERATOR SEAL OIL SYSTEM</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>GENERATOR SEAL OIL SYSTEM</strong></div>
			</div>
			<!-- //page_title -->
			<form id="sealoilsysFrm" style="display:none"></form>
			<div class="img_wrap seal_oil_sys">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->
                <div class="chart_block small tiny" style="top:470px;left:464px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:596px;left:410px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:570px;left:857px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:120px;right:560px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:150px;right:560px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:380px;right:560px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:100px;right:200px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:130px;right:200px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:250px;right:200px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small tiny" style="top:280px;right:200px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span class="fx_full"><c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if></span>
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



