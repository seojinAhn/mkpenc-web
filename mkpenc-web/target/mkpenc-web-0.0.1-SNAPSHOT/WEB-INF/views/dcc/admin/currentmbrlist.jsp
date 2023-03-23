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
<script type="text/javascript" src="<c:url value="/resources/js/admin.js" />" charset="utf-8"></script>
<script type="text/javascript">

$(function () {
	
	$(document.body).delegate('#logoutCheck', 'click', function() {

			var total = $("input[name=logoutCheck]").length;
			var checked = $("input[name=logoutCheck]:checked").length;

			if(total != checked) $("#allCheck").prop("checked", false);
			else $("#allCheck").prop("checked", true); 
	});
	
	$("#allCheck").click(function() {
		
		if($("#allCheck").is(":checked")) $("input[name=logoutCheck").prop("checked", true);
		else $("input[name=logoutCheck]").prop("checked", false);
	});

	
	$("#forceLogout").click(function() {
		
		if($("input[name=logoutCheck]:checked").length >0 ){
		
			var logoutUserList = [];
		
			 $("input[name=logoutCheck]:checked").each(function() {
				 logoutUserList.push($(this).val());
			})
			 
			var	comSubmit	=	new ComSubmit("loginMemberForm");
			comSubmit.addParam("logoutUserList", logoutUserList);
			comSubmit.setUrl("/dcc/admin/forceLogout");
			comSubmit.submit();
			
		}else {
			alert("접속종료 사용자를 선택 하세요..!!");
		}
	});	
});

	function sendPage(pageNum){
		
		var	comSubmit	=	new ComSubmit("loginMemberForm");
		comSubmit.addParam("pageNum", pageNum);
		comSubmit.setUrl("/dcc/admin/currentmbrlist");
		comSubmit.submit();
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
				<h3>현재접속현황</h3>
				<div class="bc"><span>DCC</span><span>Admin</span><strong>현재접속현황</strong></div>
			</div>
			<!-- //page_title -->
			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>현재접속자 : <strong>${BaseSearch.totalCnt}</strong>명</label>
						<label>현재일시 : <strong>${BaseSearch.currentTime}</strong></label>
					</div>
					<!-- button -->
					<div class="button">
						<a class="btn_list" href="/dcc/admin/currentmbrlist/">새로고침</a>
						<a class="btn_list" href="#"  id="forceLogout" name="forceLogout">강제접속종료</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <form id="loginMemberForm" name="loginMemberForm"></form>
                <table class="list_table">
                    <colgroup>
                        <col width="40px"/>
                        <col width="60px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="240px"/>
                        <col width="110px"/>
                        <col width="200px"/>
                        <col width="200px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="allCheck" name="allCheck"></th>
                            <th>번호</th>
                            <th>아이디</th>
                            <th>성명</th>
                            <th>소속그룹</th>
                            <th>접속호기</th>
                            <th>아이피</th>
                            <th>접속시간</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="loginMemberInfo" items="${LoginMemberList}">
                        <tr>
                            <td class="tc"><input type="checkbox" id="logoutCheck" name="logoutCheck" value="${loginMemberInfo.id}"></td>
                            <td class="tc">${loginMemberInfo.rowNum}</td>
                            <td class="tc">${loginMemberInfo.id}</td>
                            <td class="tc">${loginMemberInfo.userName}</td>
                            <td class="tc">${loginMemberInfo.groupName}</td>
                            <td class="tc">${loginMemberInfo.loginHogi}호기</td>
                            <td class="tc">${loginMemberInfo.userIp}</td>
                            <td class="tc">${loginMemberInfo.connTime}</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- //list_table -->
                <!-- paginate -->
				<div class="paginate">
					${PageHtml}
				</div>
				<!-- //paginate -->
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

