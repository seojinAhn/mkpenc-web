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
<script type="text/javascript" src="<c:url value="/resources/js/trend.js" />" charset="utf-8"></script>
<script type="text/javascript">
var timerOn = true; //true로 변경
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
	
  	$("#sUGrpNo").change(function(){
  		
  		if($("#sUGrpNo option:selected").val() != ""){

  			// 화면초기화
  			var	comSubmit	=	new ComSubmit("trendLogFrm");
			comSubmit.setUrl("/dcc/trend/logsharelist");
			comSubmit.submit();
  		}
  	});
  	
	setTimer(hogiHeader,xyHeader,5000);
	
});


function setTimer(hogiHeader,xyHeader,interval) {
	
	if( interval > 0 ) {
		setTimeout(function() {
			if( timerOn ) {
				var	comSubmit	=	new ComSubmit("trendLogFrm");
				comSubmit.setUrl("/dcc/trend/logsharelist");
				comSubmit.submit();
			}
		},interval);
	} 
}


</script>

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
				<h3>Trend Log(Spare)</h3>
				<div class="bc"><span>DCC</span><span>Trend</span><strong>Trend Log(Spare)</strong></div>
			</div>
			<!-- //page_title -->
			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<form id="trendLogFrm" name="trendLogFrm">
				<input type = "hidden" id="sGrpID" name="sGrpID" value="Trend">
				<input type = "hidden" id="sMenuNo" name="sMenuNo" value = "24">
				<input type = "hidden" id="sDive" name="sDive" value = "D">
				<input type = "hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi }">
				<input type = "hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun }">
				<div class="list_head">
					<div class="list_info">
                         <select style="width:400px;" id="sUGrpNo" name="sUGrpNo">
                            <option  value="">그룹을 선택하세요</option>
                           		<c:forEach var="GroupName" items="${GroupNameList}">
                           			<c:choose>
			                           		 <c:when test="${GroupName.UGrpNo eq BaseSearch.sUGrpNo }">
			                            			<option  value="${GroupName.UGrpNo}" selected>${UserInfo.hogi}-${GroupName.UGrpNo}&nbsp;${GroupName.UGrpName}</option>
			                            	</c:when>
			                            	<c:when test="${GroupName.UGrpNo ne BaseSearch.sUGrpNo }">
			                            			<option  value="${GroupName.UGrpNo}">${UserInfo.hogi}-${GroupName.UGrpNo}&nbsp;${GroupName.UGrpName}</option>
			                            	</c:when>
                                	</c:choose>
                                </c:forEach>
                        </select>
					</div>
				</div>
				</form>
				<!-- //list_head -->
            </div>
            <!-- //list_wrap -->
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- list_table -->
                    <table class="list_table">
                        <colgroup>
                            <col width="60px"/>
                            <col />
                            <col width="60px"/>
                            <col width="80px"/>
                            <col width="240px"/>
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Descrption</th>
                                <th>Type</th>
                                <th>ADDR.</th>
                                <th>Value</th>
                            </tr>
                        </thead>
                        <tbody id="trendLogList" name = "trendLogList">
                   			 <c:forEach var="idx"  varStatus="status"  begin="0" end="24" step="1">
                                <tr>
                                    <td class="tc">${status.count}</td>
                                    <td>${lblDataList[idx].desc}</td>
                                    <td class="tc">${lblDataList[idx].type}</td>
                                    <td class="tc">${lblDataList[idx].address}</td>
                                    <td>
                                        <div class="fx_form">
                                            <label class="full flex_end">${lblDataList[idx].fValue}</label>
                                            <label class="full">${lblDataList[idx].unit}</label>
                                        </div>
                                    </td>
                                </tr>
                                </c:forEach>
                          </tbody>
                    </table>
                    <!-- //list_table -->
                </div>
                <div class="fx_block">
                    <!-- list_table -->
                    <table class="list_table">
                        <colgroup>
                            <col width="60px"/>
                            <col />
                            <col width="60px"/>
                            <col width="80px"/>
                            <col width="240px"/>
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Descrption</th>
                                <th>Type</th>
                                <th>ADDR.</th>
                                <th>Value</th>
                            </tr>
                        </thead>
                        <tbody id="trendLogList" name = "trendLogList">
                            <c:forEach var="idx"  varStatus="status"  begin="25" end="49"  step="1">
                                <tr>
                                    <td class="tc">${status.count + 24}</td>
                                    <td>${lblDataList[idx].desc}</td>
                                    <td class="tc">${lblDataList[idx].type}</td>
                                    <td class="tc">${lblDataList[idx].address}</td>
                                    <td>
                                        <div class="fx_form">
                                            <label class="full flex_end">${lblDataList[idx].fValue}</label>
                                            <label class="full">${lblDataList[idx].unit}</label>
                                        </div>
                                    </td>
                                </tr>
                                </c:forEach>                                
                          </tbody>
                    </table>
                    <!-- //list_table -->
                </div>
            </div>
            <!-- //fx_layout -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<script type="text/javascript" src="<c:url value="/resources/js/footer.js" />" charset="utf-8"></script>
	<!-- //footer -->
</div>
<!--  //wrap  -->

</body>
</html>

