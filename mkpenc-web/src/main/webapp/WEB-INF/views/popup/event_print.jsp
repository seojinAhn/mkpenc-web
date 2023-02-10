<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://onmakers.com/function" prefix="fnc" %>

<!-- jquery -->
<script src="/resources/js/jquery/jquery-1.11.3.min.js"></script> 
<script src="/resources/js/jquery/jquery-migrate-1.2.1.min.js"></script>
<script src="/resources/js/jquery/jquery.easing.1.3.js"></script>
<script src="/resources/js/jquery/jquery.mousewheel.min.js"></script>

<script src="/resources/js/jquery/jquery-ui.min.js"></script>
<script src="/resources/js/jquery/jquery.form.js"></script>
<script src="/resources/js/jquery/jquery.alerts.js"></script>
<script src="/resources/js/jquery/jquery.blockUI.js"></script>
<script src="/resources/js/jquery/printThis.js"></script>
<script src="/resources/js/jquery/plupload.full.min.js"></script>

<!-- css -->
<link type="text/css" href="/resources/css/jquery/jquery-ui.min.css" rel="stylesheet" />
<link type="text/css" href="/resources/css/jquery/jquery.tools.css" rel="stylesheet" />
<link type="text/css" href="/resources/css/jquery/jquery.alerts.css" rel="stylesheet" />

<!-- pub -->
<link rel="stylesheet" href="/resources/css/import.css"/>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#print").on("click", function(e){
		
		e.preventDefault();
		
		$(".frame_print_btn").css("display", "none");
		
		window.print();
		setTimeout("window.close()", 500);
	});
	
});
</script>

<!--뷰페이지-->
<div class="notice_view">

	<!-- 머릿글 -->
	<div class="view_head">
		<ul>
			<li class="view_title">${data.titl}</li>
			<li class="view_date">작성일<span>${data.regDt}</span></li>
		</ul>
	</div>
	<!-- //머릿글 -->
	
	<!-- 본문 -->
	<div class="view_body">${data.event_cntn}</div>
	<!-- //본문 -->
	
	<!--목록으로 버튼-->
	<div class="btn_go_list frame_print_btn">
		<div class="comm_btn">
			<ul>
				<li class="comm_btn_ok">
					<a href="" id="print">인쇄하기</a>
				</li>
			</ul>
		</div>
	</div>
	<!--//목록으로 버튼-->
	
</div>