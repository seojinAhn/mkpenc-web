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
<script type="text/javascript" src="<c:url value="/resources/js/performance.js" />" charset="utf-8"></script>

<script type="text/javascript">

$(function () {
	
		
 	$("#searchXY").click(function(){
 		
 		//alert("asdfasdf=" + $("#sPer").val());
 		
 		
 		if(!$.isNumeric( $("#sPer").val())){
 			alert("숫자형 데이터를 입력하세요.!!");
 			 $("#sPer").focus();
 			 return;
 		} 		
 		
 		// 화면초기화
		var	comSubmit	=	new ComSubmit("compareXYFrm");
		comSubmit.setUrl("/dcc/performance/comparexy");
		comSubmit.submit();
  		
  	});
 
});	


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
				<h3>COMPARE XY</h3>
				<div class="bc"><span>DCC</span><span>Performance</span><strong>COMPARE XY</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
				<form id="compareXYFrm" name="compareXYFrm">
				<input type = "hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi }">
				<input type = "hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun }">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>검색조건</label>
							<div class="fx_form">
								<select class="fx_none" style="width:200px;" id="sIOType" name="sIOType">
			                           		 <c:if test="${BaseSearch.sIOType eq '0' }">
			                            			<option value="0" selected>AI</option>
			                            	</c:if>
			                            	<c:if test="${BaseSearch.sIOType ne '0' }">
			                            			<option value="0" >AI</option>
			                            	</c:if>
			                            	<c:if test="${BaseSearch.sIOType eq '1' }">
			                            			<option value="1" selected>DI</option>
			                            	</c:if>
			                            	<c:if test="${BaseSearch.sIOType ne '1' }">
			                            			<option value="1">DI</option>
			                            	</c:if>
			                            	<c:if test="${BaseSearch.sIOType eq '2' }">
			                            			<option value="2" selected>AI - IRR [ Wiba(IN) ]</option>
			                            	</c:if>
			                            	<c:if test="${BaseSearch.sIOType ne '2' }">
			                            			<option value="2">AI - IRR [ Wiba(IN) ]</option>
			                            	</c:if>
								</select>
								<input type="text" class="fx_none" style="width:80px;" id="sPer" name="sPer" value="2">
                                <label>%</label>
							</div>
						</div>
                        <div class="fx_srch_item"></div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="searchXY" name="searchXY">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->
			<!-- list_wrap -->
			<div class="list_wrap">
                <!-- list_head -->
                <!-- 
                <div class="list_head">
                    <div class="list_info">
                        <div class="fx_form">
                            <select class="fx_none" style="width:100px;" id="pageNum" name="pageNum">
                            	<c:forEach begin="1" end="${PageCnt}" step="1" varStatus="status">
                                <option value="${status.count}">${status.count}</option>
                                </c:forEach>
                            </select>
                            <label>(${PageTotal})</label>
                        </div>
                    </div>
                </div>
                 -->
                <!-- //list_head -->
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="40px" />
                        <col width="80px"/>
                        <col width="160px"/>
                        <col />
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>ADDR</th>
                            <th>LOOPNO</th>
                            <th>DESC</th>
                            <th>Value(X)</th>
                            <th>Value(Y)</th>
                            <th>Wiba(X)</th>
                            <th>Wiba(Y)</th>
                            <th>Unit</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="AryValue" items="${AryValueList}">
                        <tr>
                            <td class="tc">${AryValue.INDEX}</td>
                            <td class="tc">${AryValue.ADDRESS}</td>
                            <td class="tc">${AryValue.LOOPNAME}</td>
                            <td class="tc">${AryValue.DESCR}</td>
                            <td class="tc">${AryValue.xValue}</td>
                            <td class="tc">${AryValue.yValue}</td>
                             <td class="tc">
	                            <c:if test="${AryValue.WIBA eq '1' }">
	                           			IN
	                           	</c:if>
	                           	<c:if test="${AryValue.WIBA eq '0' }">
	                           			OUT
	                           	</c:if>
	                        </td>
                            <td class="tc">
                            	<c:if test="${AryValue.B_WIBA eq '1' }">
	                           			IN
	                           	</c:if>
	                           	<c:if test="${AryValue.B_WIBA eq '0' }">
	                           			OUT
	                           	</c:if>
	                        </td>
                            <td class="tc">${AryValue.UNIT}</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- //list_table -->
            </div>
            <!-- //list_wrap -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->
</body>
</html>

	