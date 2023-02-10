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
	
	$(document.body).delegate('#improveListTable tr', 'click', function() {
		$("#iSeqNo").val($(this).children().eq(6).text());
		$("#iPTitle").val($(this).children().eq(4).text());
		$("#iPContents").val($(this).children().eq(5).text());		      
		$("#iPUser").val($(this).children().eq(2).text());
		
		openLayer('modal_1');
	});
	
	$("#searchKey").change(function(){

		if($("#searchKey option:selected").val() == ""){
			$("#searchWord").val("");
		}
	});		
	
	
	$("#improveSearch").click(function() {
		sendPage(1);
	});	
	
	$("#improveUpdate").click(function() {
		modifyImprove(1);		
	});	
	
	$("#improveDelete").click(function() {
		modifyImprove(2);		
	});	
	
	$("#improveInsert").click(function() {
		
		if(!inputVaildationCheck()){
			return;
		}
		
		if (confirm("개선사항을 등록 합니다..!!")) {
			var	comSubmit	=	new ComSubmit("improveModifyForm");
			comSubmit.setUrl("/dcc/admin/sysimproveInsert");
			comSubmit.submit();
		} else {
			alert("개선사항 등록을 취소합니다.");
		}
	});		
});

	function inputVaildationCheck(){
		
		if(gfn_isEmpty("iPTitle")){
			alert("개선사항 제목을 입력 하세요..!!");
			$("#iPTitle").focus();
			return false;
		}
		
		if(gfn_isEmpty("iPContents")){
			alert("개선사항 내용을 입력 하세요..!!");
			$("#iPContents").focus();
			return false;
		}
		
		if(gfn_isEmpty("iPUser")){
			alert("제안자를 입력 하세요..!!");
			$("#iPUser").focus();
			return false;
		}
		
		return true;
	}

	function sendPage(pageNum){
		
		var	comSubmit	=	new ComSubmit("improveForm");
		comSubmit.addParam("pageNum", pageNum);
		comSubmit.setUrl("/dcc/admin/sysimprovelist");
		comSubmit.submit();
	}
	
	function modifyImprove(type){
		
		var	comSubmit	=	new ComSubmit("improveModifyForm");
		var titleMsg;
		var cancelMsg;
		
		if(type == 1){ //update

			if(!inputVaildationCheck()){
				return;
			}
		
			titleMsg = "개선사항을 수정합니다..!!";
			cancelMsg = "개선사항을 수정을 취소합니다..!!";
			
			comSubmit.setUrl("/dcc/admin/sysimproveupdate");
			
		}else if(type == 2){ // delete
			
			titleMsg = "개선사항을 삭제합니다..!!";
			cancelMsg = "개선사항을 삭제를 취소합니다..!!";
			
			comSubmit.setUrl("/dcc/admin/sysimprovedelete");
			
		}	
		
		if (confirm(titleMsg)) {
			comSubmit.submit();
		} else {
			alert(cancelMsg);
		}
	}


</script>
</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-dcc-header.jspf" %>
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>시스템 개선사항</h3>
				<div class="bc"><span>DCC</span><span>Admin</span><strong>시스템 개선사항</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<form id="improveForm" name="improveForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>검색조건</label>
							<div class="fx_form">
								<select class="fx_none" style="width:90px;" id= "searchKey" name="searchKey">
									<option>전체</option>
									<option value="pTitle">제목</option>
									<option value="pContents">내용</option>
									
								</select>
								<input type="text" id ="searchWord" name="searchWord">
							</div>
						</div>
                        <div class="fx_srch_item"></div>
					</div>
					</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="improveSearch" name="improveSearch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->

			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>${BaseSearch.totalCnt}</strong></label>
					</div>
					<!-- button -->
					<div class="button">
						<a class="btn_list" href="javascript:openLayer('modal_1')">등록</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table" id="improveListTable" name="improveListTable">
                    <colgroup>
                        <col width="60px"/>
                        <col width="180px"/>
                        <col width="120px"/>
                        <col width="200px"/>
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>순번</th>
                            <th>작성일자</th>
                            <th>제안자</th>
                            <th>작성자</th>
                            <th>제목</th>
                            <th>내용</th>
                        </tr>
                    </thead>
                    <tbody>
                   	<c:forEach var="ImproveInfo" items="${ImproveInfoList}">
                        <tr>
                            <td class="tc">${ImproveInfo.rowNum}</td>
                            <td class="tc">${ImproveInfo.pDate}</td>
                            <td class="tc">${ImproveInfo.pUser}</td>
                            <td class="tc">${ImproveInfo.wUser}</td>
                            <td>${ImproveInfo.pTitle}</td>
                            <td>${ImproveInfo.pContents}</td>
                            <td style="display:none;">${ImproveInfo.seqNo}</td>
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
	    <h3>시스템 개선사항 등록</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="improveModifyForm" name="improveModifyForm">
		<input type="hidden"  id="iSeqNo" name="iSeqNo">
			<!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>제목 *</th>
                    <td><input type="text"  id="iPTitle" name="iPTitle"></td>
                </tr>
                <tr>
                    <th>내용 *</th>
                    <td><textarea style="height:240px;" id="iPContents" name = "iPContents"></textarea></td>
                </tr>
                <tr>
                    <th>제안자 *</th>
                    <td><input type="text"  id="iPUser" name = "iPUser"></td>
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
        <a href="#none" class="btn_page"  id="improveInsert" name="improveInsert">등록</a>
        <a href="#none" class="btn_page"  id="improveUpdate" name="improveUpdate">수정</a>
        <a href="#none" class="btn_page"  id="improveDelete" name="improveDelte">삭제</a>        
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->


<!-- layer_pop_wrap -->
<div class="layer_pop_wrap medium" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>시스템 개선사항 수정</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="improveUpdateForm" name="improveUpdateForm">
		<input type="hidden"  id="uSeqNo" name="uSeqNo">
			<!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>제목 *</th>
                    <td><input type="text"  id="uPTitle" name="uPTitle"></td>
                </tr>
                <tr>
                    <th>내용 *</th>
                    <td><textarea style="height:240px;" id="uPContents" name = "uPContents"></textarea></td>
                </tr>
                <tr>
                    <th>제안자 *</th>
                    <td><input type="text"  id="uPUser" name = "uPUser"></td>
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

        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->


</body>
</html>



