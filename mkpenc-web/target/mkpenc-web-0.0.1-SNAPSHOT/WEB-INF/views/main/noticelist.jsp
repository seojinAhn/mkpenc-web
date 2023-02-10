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
<script type="text/javascript" src="<c:url value="/resources/js/main.js" />" charset="utf-8"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/jquery-ui-base-1.13.2.css" />">
<script type="text/javascript" src="<c:url value="/resources/jquery/jquery-ui-1.13.2.js" />" charset="utf-8"></script>
<script type="text/javascript">

$(function () {
	
	$(document.body).delegate('#noticeListTable tr', 'click', function() {

			$("#noticeUpdateForm [name='seqNo']").val($(this).children().eq(5).text());
			
			$("#noticeUpdateForm [name='title']").val($(this).children().eq(3).text());
			$("#noticeUpdateForm [name='contents']").val($(this).children().eq(4).text());
			$("#noticeUpdateForm [name='userName']").val($(this).children().eq(2).text());

			openLayer('modal_2');
	});
	
	$("#noticeInsertOpen").click(function(){
		
		$('#noticeInsertForm [name="userName"]').val("${UserInfo.userName}");
		
		openLayer('modal_1');
	
	});		
	
	$("#noticeSearch").click(function(){
		sendPage(1);
	});		
	
	$("#noticeInsert").click(function(){
		
		if(!inputVaildationCheck(1)){
			return;
		}
		
		if (confirm("공지사항을 등록 합니다..!!")) {	
			
			//var	comSubmit	=	new ComSubmit("noticeModifyForm");
			//comSubmit.setUrl("/main/noticeinsert");
			//comSubmit.submit();  
			
			var comAjax = new ComAjax("noticeInsertForm");
			comAjax.setUrl("/main/noticeinsert");
			comAjax.setCallback("mbr_NoticeInsertEventCallback");
			comAjax.ajax();			
			
			
		}else {
			alert("공지사항 등록을 취소 합니다...!!");
		}
		
	});
	
	$("#noticeUpdate").click(function(){
		
		if(!inputVaildationCheck(2)){
			return;
		}
				
		if (confirm("공지사항을 수정 합니다..!!")) {	
			
		//	var	comSubmit	=	new ComSubmit("noticeInsertForm");
		//	comSubmit.addParam("intSeqNo", $("#uSeqNo").val());				
		//	comSubmit.setUrl("/main/noticeupdate");
		//	comSubmit.submit();  
			
			var comAjax = new ComAjax("noticeUpdateForm");
			comAjax.setUrl("/main/noticeupdate");
			comAjax.setCallback("mbr_NoticeUpdateEventCallback");
			comAjax.ajax();			
		}else {
			alert("공지사항 수정을 취소 합니다...!!");
		}
				
	});
	
	$("#noticeDelete").click(function(){
		
		if(!inputVaildationCheck(2)){
			return;
		}
		
		if (confirm("공지사항을 삭제 합니다..!!")) {	
			
			//var	comSubmit	=	new ComSubmit("noticeUpdateForm");
			//comSubmit.addParam("intSeqNo", $("#uSeqNo").val());				
			//comSubmit.setUrl("/main/noticedelete");
			//comSubmit.submit();  
			
			var comAjax = new ComAjax("noticeUpdateForm");
			comAjax.setUrl("/main/noticedelete");
			comAjax.setCallback("mbr_NoticeDeleteEventCallback");
			comAjax.ajax();			
			
		}else {
			alert("공지사항 수정을 취소 합니다...!!");
		}
	});		
});	

	
	function inputVaildationCheck(type){
		
		if(type == 1){
				if($("#noticeInsertForm [name='title']").val() == ""){
					alert("제목를 입력 하세요..!!");
					$("#noticeInsertForm [name='title']").focus();
					return;
				}
				
				if($("#noticeInsertForm [name='contents']").val() == ""){
					alert("내용를 입력 하세요..!!");
					$("#noticeInsertForm [name='contents']").focus();
					return;
				}
				
				if($("#noticeInsertForm [name='pwd']").val() == ""){
					alert("암호를 입력 하세요..!!");
					$("#noticeInsertForm [name='pwd']").focus();
					return;
				}
		}else if(type ==2){ 
			
			if($("#noticeUpdateForm [name='title']").val() == ""){
				alert("제목를 입력 하세요..!!");
				$("#noticeUpdateForm [name='title']").focus();
				return;
			}
			
			if($("#noticeUpdateForm [name='contents']").val() == ""){
				alert("내용를 입력 하세요..!!");
				$("#noticeUpdateForm [name='contents']").focus();
				return;
			}
			
			if($("#noticeUpdateForm [name='pwd']").val() == ""){
				alert("암호를 입력 하세요..!!");
				$("#noticeUpdateForm [name='pwd']").focus();
				return;
			}
		}	
		
		return true;
	}

	function sendPage(pageNum){
		
		var	comSubmit	=	new ComSubmit("noticeForm");
		comSubmit.addParam("pageNum", pageNum);
		comSubmit.setUrl("/main/noticelist");
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
				<h3>공지사항</h3>
				<div class="bc"><span>DCC</span><strong>공지사항</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
				<form id="noticeForm" name="noticeForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>검색조건</label>
							<div class="fx_form">
								<select class="fx_none" style="width:90px;" id="searchKey" name="searchKey">
									<option value="">전체</option>
									<c:if test="${BaseSearch.searchKey eq 'title'}">
										<option value="title" selected>제목</option>
									</c:if>
									<c:if test="${BaseSearch.searchKey ne 'title'}">
										<option value="title">제목</option>
									</c:if>
									<c:if test="${BaseSearch.searchKey eq 'content'}">
										<option value="content" selected>내용</option>
									</c:if>
									<c:if test="${BaseSearch.searchKey ne 'content'}">
										<option value="content">내용</option>
									</c:if>
								</select>
								<input type="text"  id="searchWord" name="searchWord" value="${BaseSearch.searchWord}">
							</div>
						</div>
                        <div class="fx_srch_item"></div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch"  id = "noticeSearch"  name="noticeSearch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->

			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>10</strong></label>
					</div>
					<!-- button -->
					<div class="button">
						<a class="btn_list primary" href="#none" id="noticeInsertOpen" name="noticeInsertOpen">등록</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table" id="noticeListTable" name="noticeListTable">
                    <colgroup>
                        <col width="80px"/>
                        <col width="120px"/>
                        <col width="100px"/>
                        <col width="340px"/>
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>순번</th>
                            <th>작성일자</th>
                            <th>작성자</th>
                            <th>제목</th>
                            <th>내용</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="NoticeInfo" items="${NoticeInfoList}">
                        <tr>
                            <td class="tc">${NoticeInfo.rowNum}</td>
                            <td class="tc">${NoticeInfo.createDate}</td>
                            <td class="tc">${NoticeInfo.userName}</td>
                            <td>${NoticeInfo.title}</td>
                            <td>${NoticeInfo.contents}</td>
                            <td style="display:none;">${NoticeInfo.seqNo}</td>
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
<div class="layer_pop_wrap large" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>공지사항 등록</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
			<!-- form_table -->
			<form id="noticeInsertForm" name="noticeInsertForm">
			<input type="hidden"  id="seqNo"   name = "seqNo">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>제목</th>
                    <td><input type="text" id="title" name="title"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea style="height:240px;" id="contents" name="contents"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td><input type="text" id="userName" name="userName" readonly></td>
                </tr>
                <tr>
                    <th>암호</th>
                    <td>
                        <input type="password" id="pwd" name="pwd">
                    </td>
                </tr>
            </table>
            </form>
			<!-- //form_table -->
		</div>
		<!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page" id="noticeInsert" name="noticeInsert">등록</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->


<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>공지사항 수정</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
			<!-- form_table -->
			<form id="noticeUpdateForm" name="noticeUpdateForm">
			<input type="hidden"  id="seqNo"   name = "seqNo">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>제목</th>
                    <td><input type="text" id="title" name="title"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea style="height:240px;" id="contents" name="contents"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td><input type="text" id="userName" name="userName" readonly></td>
                </tr>
                <tr>
                    <th>암호</th>
                    <td>
                        <input type="password" id="pwd" name="pwd">
                    </td>
                </tr>
            </table>
            </form>
			<!-- //form_table -->
		</div>
		<!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page" id="noticeUpdate" name="noticeUpdate">수정</a>
        <a href="#none" class="btn_page" id="noticeDelete" name="noticeDeleet">삭제</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

</body>
</html>



