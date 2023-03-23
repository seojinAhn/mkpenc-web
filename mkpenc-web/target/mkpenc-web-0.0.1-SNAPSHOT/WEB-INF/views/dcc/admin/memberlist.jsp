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
<script type="text/javascript" >

	$(function () {
		
		$(document.body).delegate('#groupListTable tr', 'click', function() {
			$("#usrGroupCode").val($(this).children().eq(0).text());
			$("#usrGroupName").val($(this).children().eq(1).text());		      
		});
		
		$(document.body).delegate('#userInfoTable tr', 'click', function() {
			
			$("#uId").val($(this).children().eq(0).text());
			$("#uUserName").val($(this).children().eq(1).text());		      
			$("#uPwd").val("");
			$("select[name='uGroupCode'] option:contains('"+$(this).children().eq(3).text() +"')").attr("selected", "selected")
			$("select[name='uGrade'] option:contains('"+$(this).children().eq(4).text() +"')").attr("selected", "selected")
			$("select[name='uLoginHogi'] option:contains('"+$(this).children().eq(5).text() +"')").attr("selected", "selected")
			$("select[name='uUseYN'] option:contains('"+$(this).children().eq(8).text() +"')").attr("selected", "selected")
			$("#uEmail").val($(this).children().eq(9).text());
		});
	
		$("#memberSearch").click(function(){
			 sendPage(1);
		});		 
		
		$("#usrGroupSearch").click(function(){
			usrGrpSendPage(1);
		});		
		
		$("#searchKey").change(function(){

			if($("#searchKey option:selected").val() == ""){
				$("#searchWord").val("");
			}
		});		
		
		$("#userSave").click(function(){
			
			if(gfn_isEmpty("iId")){
				alert("사용자 ID를 입력 하세요..!!");
				$("#iId").focus();
				return;
			}
			
			if(gfn_isEmpty("iUserName")){
				alert("사용자 성명를 입력 하세요..!!");
				$("#iUserName").focus();
				return;
			}
			
			if(gfn_isEmpty("iPwd")){
				alert("사용암호를 입력 하세요..!!");
				$("#iPwd").focus();
				return;
			}
			
			if(!gfn_checkPwd($("#iPwd").val(), true)){
				$("#iPwd").focus();
				return;
			}			
			
			if($("#iGroupCode option:selected").val() == ""){
				alert("부서를 선택 하세요..!!");
				$("#iGroupCode").focus();
				return;
			}
			
			if($("#iGrade option:selected").val() == ""){
				alert("권한을 선택 하세요..!!");
				$("#iGrade").focus();
				return;
			}
			
			if($("#iLoginHogi option:selected").val() == ""){
				alert("호기을 선택 하세요..!!");
				$("#iLoginHogi").focus();
				return;
			}
			
			if(gfn_isEmpty("iEmail")){
				alert("사용자 이메일을 입력 하세요..!!");
				$("#iEmail").focus();
				return;
			}
			
			if(!gfn_isEmail($("#iEmail").val(), false)){
				alert("정확한 이메일을 입력 하세요..!!");
				$("#iEmail").focus();
				return;
			}
			
			if($("#iUseYN option:selected").val() == ""){
				alert("승인유무를 선택 하세요..!!");
				$("#iUseYN").focus();
				return;
			}
			
			alert("사용자를 등록합니다.!!");
			
			var	comSubmit	=	new ComSubmit("memberInsertForm");
			comSubmit.setUrl("/dcc/admin/memberInsert");
			comSubmit.submit();
		});	
		
		$("#userGroupInsert").click(function(){
			usrGrpEvent(1);
		});	
		
		$("#userGroupDelete").click(function(){
			usrGrpEvent(2);
		});			
		
		$("#userUpdate").click(function(){
			
			if(gfn_isEmpty("uPwd")){
				alert("사용암호를 입력 하세요..!!");
				$("#uPwd").focus();
				return;
			}
			
			if(!gfn_checkPwd($("#uPwd").val(), true)){
				$("#uPwd").focus();
				return;
			}
			
			if (confirm("사용자 암호를 변경 합니다..!!")) {
				var	comSubmit	=	new ComSubmit("memberUpdateForm");
				comSubmit.setUrl("/dcc/admin/memberUpdate");
				comSubmit.submit();
			} else {
				alert("사용자 암호 변경을 취소합니다.");
			}
			
		});	
		
		$("#userDelete").click(function(){
			
			if(confirm("사용자 정보를 삭제 합니다.")){
				var	comSubmit	=	new ComSubmit("memberUpdateForm");
				comSubmit.setUrl("/dcc/admin/memberDelete");
				comSubmit.submit();
			} else {
				alert("사용자 정보 삭제를 취소합니다.");
			}
		});		
		
	});
	
	
	function sendPage(pageNum){
		
		var	comSubmit	=	new ComSubmit("memberForm");
		comSubmit.addParam("pageNum", pageNum);
		comSubmit.setUrl("/dcc/admin/memberlist");
		comSubmit.submit();
	}
	
	function usrGrpEvent(eventIdx){
		var comAjax = new ComAjax("usrGrpForm");
		
		if(gfn_isEmpty("usrGroupCode")){
			alert("그룹코드를 입력 하세요..!!");
			$("#usrGroupCode").focus();
			return;
		}
		
		if($("#usrGroupCode").val().length > 10){
			alert("그룹코드를 길이는 10자리 이내로 하세요..!!");
			$("#usrGroupCode").focus();
			return;
		}
		
		if(gfn_isEmpty("usrGroupName")){
			alert("그룹명을 입력 하세요..!!");
			$("#usrGroupName").focus();
			return;
		}
		
		comAjax.addParam("groupCode",	$("#usrGroupCode").val());
		comAjax.addParam("groupName",	$("#usrGroupName").val());
		
		if(eventIdx ==1) {
			comAjax.setUrl("/dcc/admin/userGroupInsert");
		}else if(eventIdx ==2) {
			comAjax.setUrl("/dcc/admin/userGroupDelete");
		}
		comAjax.setCallback("mbr_UserGroupEventCallback");
		comAjax.ajax();		
	}
	
	function usrGrpSendPage(grpPageNum){

		var comAjax = new ComAjax("usrGrpForm");
		
		if(!gfn_isEmpty("usrGroupCode")){
			comAjax.addParam("groupCode",	$("#usrGroupCode").val());
		}
		if(!gfn_isEmpty("usrGroupName")){
			comAjax.addParam("groupName",	$("#usrGroupName").val());
		}

		comAjax.addParam("grpPageNum",	grpPageNum);
		comAjax.setUrl("/dcc/admin/userGroup");
		comAjax.setCallback("mbr_UserGroupCallback");
		comAjax.ajax();
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
				<h3>사용자관리</h3>
				<div class="bc"><span>DCC</span><span>Admin</span><strong>사용자관리</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
				<form id="memberForm" name="memberForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>부서</label>
							<select id="groupCode" name="groupCode">
								<option value="">전체</option>
								<c:forEach var="groupComboInfo" items="${GroupComboList}">
								    <c:if test="${DccSearchAdmin.groupCode eq groupComboInfo.groupCode }"> 
										<option value="${groupComboInfo.groupCode}" selected>${groupComboInfo.groupName}</option>
									</c:if>
									<c:if test="${DccSearchAdmin.groupCode ne groupComboInfo.groupCode }"> 
										<option value="${groupComboInfo.groupCode}"> ${groupComboInfo.groupName}</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<div class="fx_srch_item">
							<label>승인여부</label>
							<select id="useYn" name="useYN" >
								<option value="">전체</option>
								 <c:if test="${DccSearchAdmin.useYN eq 'Y' }"> 
									<option value="Y" selected>승인</option>
								</c:if>
								<c:if test="${DccSearchAdmin.useYN ne 'Y' }"> 
									<option value="Y" >승인</option>
								</c:if>
								<c:if test="${DccSearchAdmin.useYN eq 'N' }"> 
									<option value="N" selected>미승인</option>
								</c:if>
								<c:if test="${DccSearchAdmin.useYN ne 'N' }"> 
									<option value="N" >미승인</option>
								</c:if>					        									
							</select>
						</div>
						<div class="fx_srch_item">
							<label>검색조건</label>
							<div class="fx_form">
								<select id="searchKey" name="searchKey" class="fx_none" style="width:90px;">
									<option value="">전체</option>
									<c:if test="${DccSearchAdmin.searchKey eq 'userId' }"> 
										<option value="userId" selected>아이디</option>
									</c:if>
									<c:if test="${DccSearchAdmin.searchKey ne 'userId' }"> 
										<option value="userId" >아이디</option>
									</c:if>
									<c:if test="${DccSearchAdmin.searchKey eq 'userName' }">
					        			<option value="userName" selected>이름</option>
					        		</c:if>
					        		<c:if test="${DccSearchAdmin.searchKey ne 'userName' }">
					        			<option value="userName">이름</option>
					        		</c:if>					        		
								</select>
								<input type="text" id="searchWord" name="searchWord" value="${DccSearchAdmin.searchWord}">
							</div>
						</div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="memberSearch">Search</a>
				</div>
				<!-- //fx_srch_button -->
						
			</div>
			<!-- //fx_srch_wrap -->

			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>${DccSearchAdmin.totalCnt}</strong></label>
					</div>
					<!-- button -->
					<div class="button">
						<a class="btn_list " href="#none" onclick="openLayer('modal_1');">등록</a>
						<a class="btn_list" href="#none" onclick="openLayer('modal_2');">부서관리</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table" id="userInfoTable" name="userInfoTable">
                    <colgroup>
                        <col width="120px"/>
                        <col width="120px"/>
                        <col width="120px"/>
                        <col width="140px"/>
                        <col width="100px"/>
                        <col width="90px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="90px"/>
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>아이디</th>
                            <th>성명</th>
                            <th>암호</th>
                            <th>부서</th>
                            <th>권한</th>
                            <th>호기</th>
                            <th>최종접속일자</th>
                            <th>암호변경일자</th>
                            <th>승인</th>
                            <th>이메일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="memberInfo" items="${MemberList}">
                        <tr>
                            <td class="tc">${memberInfo.id}</td>
                            <td class="tc"><a href="javascript:openLayer('modal_3')">${memberInfo.userName}</a></td>
                            <td class="tc">${memberInfo.pwd}</td>
                            <td class="tc">${memberInfo.groupName}</td>
                            <c:choose>
							      <c:when test="${memberInfo.grade eq 1 }"> 
							      		<td class="tc">슈퍼관리자</td>
							      </c:when> 
							      <c:when test="${memberInfo.grade eq 2 }">
							      		<td class="tc">DCC 관리자</td>
							      </c:when> 
							      <c:when test="${memberInfo.grade eq 3 }">
							      		<td class="tc">Mark-V 관리자</td>
							      </c:when> 
							      <c:when test="${memberInfo.grade eq 4 }">
							      		<td class="tc">Aux PLC 관리자</td>
							      </c:when> 
							      <c:otherwise>
							      		<td class="tc">일반사용자</td>
							      </c:otherwise> 
							</c:choose>                            
                            <td class="tc">${memberInfo.loginHogi}</td>
                            <td class="tc">${memberInfo.connTime}</td>
                            <td class="tc">${memberInfo.pwChTime}</td>
                            <c:choose>
							      <c:when test="${memberInfo.useYn eq 'Y' }"> 
							      		<td class="tc">승인</td>
							      </c:when>
							      <c:when test="${memberInfo.useYn eq 'N' }"> 
							      		<td class="tc">미승인</td>
							      </c:when>  
							</c:choose>                            
                            <td class="tc">${memberInfo.email}</td>
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

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap medium" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>사용자 등록</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="memberInsertForm" name="memberInsertForm">
			<!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>아이디 *</th>
                    <td><input type="text"  id="iId" name="iId"></td>
                </tr>
                <tr>
                    <th>성명 *</th>
                    <td><input type="text"  id="iUserName" name="iUserName"></td>
                </tr>
                <tr>
                    <th>암호 *</th>
                    <td>
                        <div class="fx_form">
                            <input type="password" class="fx_none" style="width:140px;"  id="iPwd" name="iPwd">
                            <label class="description">* 영문/숫자 혼용 6자리 ~ 10자리 이내</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>부서 *</th>
                    <td>
                        <select id="iGroupCode" name="iGroupCode">
                            <option value="">없음</option>
                            <c:forEach var="groupComboInfo" items="${GroupComboList}">
									<option value="${groupComboInfo.groupCode}"> ${groupComboInfo.groupName}</option>
							</c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>권한 *</th>
                    <td>
                        <select id="iGrade" name="iGrade">
                            <option value="1">슈퍼관리자</option>
                            <option value="2">DCC관리자</option>
                            <option value="3">MARK-V관리자</option>
                            <option value="9">일반사용자</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>호기 *</th>
                    <td>
                        <select id="iLoginHogi" name="iLoginHogi">
                            <option  value="3">3호기</option>
                            <option  value="4">4호기</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>이메일 *</th>
                    <td><input type="text"  id="iEmail" name="iEmail"></td>
                </tr>
                <tr>
                    <th>참조복사</th>
                    <td>
                        <div class="fx_form">
                            <label class="stitle">3호기 :</label>
                            <select>
                                <option>N/A</option>
                            </select>
                            <label class="stitle">4호기 :</label>
                            <select>
                                <option>N/A</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>승인유무 *</th>
                    <td>
                        <select  id="iUseYN" name="iUseYN">
                            <option value="Y">승인</option>
                            <option value="N">미승인</option>
                        </select>
                    </td>
                </tr>
            </table>
			<!-- //form_table -->
		</form>
		</div>
		<!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary"  id="userSave" name="userSave">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>부서관리</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">

        <!-- fx_srch_wrap -->
        <div class="fx_srch_wrap">	
            <div class="fx_srch_form">
            <form id="usrGrpForm" name="usrGrpForm"></form> 
                <div class="fx_srch_row">
                    <div class="fx_srch_item">
                        <label>부서코드</label>
                        <input type="text" id="usrGroupCode" name="usrGroupCode">
                    </div>
                    <div class="fx_srch_item">
                        <label>부서명</label>
                        <input type="text"id="usrGroupName" name="usrGroupName">
                    </div>
                </div>
            </div>
            <!-- fx_srch_button -->
            <div class="fx_srch_button">
                <a class="btn_srch" id="usrGroupSearch" name="usrGroupSearch">Search</a>
            </div>
            <!-- //fx_srch_button -->
        </div>
        <!-- //fx_srch_wrap -->

        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table" id="groupListTable">
                <colgroup>
                    <col width="200px"/>
                    <col />
                </colgroup>
                <thead>
                    <tr>
                        <th>부서코드</th>
                        <th>부서명</th>
                    </tr>
                </thead>
                <tbody id="groupList">
                 <c:forEach var="grouprInfo" items="${GroupList}">
                    <tr>
                        <td class="tc">${grouprInfo.groupCode}</td>
                        <td  class="tc">${grouprInfo.groupName}</td>
                    </tr>
                    </c:forEach>                    
                </tbody>
            </table>
            <!-- //list_table -->
            <!-- paginate -->
            <div class="paginate" id="userPaginate">
               ${UserGroupPageHtml}
            </div>
            <!-- //paginate -->
        </div>
        <!-- //list_wrap -->    
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page" id="userGroupInsert">저장</a>
        <a href="#none" class="btn_page" id="userGroupDelete">삭제</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->


<!-- layer_pop_wrap -->
<div class="layer_pop_wrap medium" id="modal_3">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>사용자 수정</h3>
        <a onclick="closeLayer('modal_3');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="memberUpdateForm" name="memberUpdateForm">
			<!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>아이디 *</th>
                    <td><input type="text"  id="uId" name="uId" readonly></td>
                </tr>
                <tr>
                    <th>성명 *</th>
                    <td><input type="text"  id="uUserName" name="uUserName"  disabled></td>
                </tr>
                <tr>
                    <th>암호 *</th>
                    <td>
                        <div class="fx_form">
                            <input type="password" class="fx_none" style="width:140px;"  id="uPwd" name="uPwd">
                            <label class="description">* 영문/숫자 혼용 6자리 ~ 10자리 이내</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>부서 *</th>
                    <td>
                        <select id="uGroupCode" name="uGroupCode" disabled>
                            <option value="">없음</option>
                            <c:forEach var="groupComboInfo" items="${GroupComboList}">
									<option value="${groupComboInfo.groupCode}"> ${groupComboInfo.groupName}</option>
							</c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>권한 *</th>
                    <td>
                        <select id="uGrade" name="uGrade" disabled>
                            <option value="1">슈퍼관리자</option>
                            <option value="2">DCC관리자</option>
                            <option value="3">MARK-V관리자</option>
                            <option value="9">일반사용자</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>호기 *</th>
                    <td>
                        <select id="uLoginHogi" name="uLoginHogi" disabled>
                            <option  value="3">3호기</option>
                            <option  value="4">4호기</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>이메일 *</th>
                    <td><input type="text"  id="uEmail" name="uEmail" disabled></td>
                </tr>
                <tr>
                    <th>참조복사</th>
                    <td>
                        <div class="fx_form">
                            <label class="stitle">3호기 :</label>
                            <select>
                                <option>N/A</option>
                            </select>
                            <label class="stitle">4호기 :</label>
                            <select>
                                <option>N/A</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>승인유무 *</th>
                    <td>
                        <select  id="uUseYN" name="uUseYN" disabled>
                            <option value="Y">승인</option>
                            <option value="N">미승인</option>
                        </select>
                    </td>
                </tr>
            </table>
			<!-- //form_table -->
		</form>
		</div>
		<!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page"  id="userUpdate" name="userSave">수정</a>
        <a href="#none" class="btn_page"  id="userDelete"  name="userDelete">삭제</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_3');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

</body>
</html>

