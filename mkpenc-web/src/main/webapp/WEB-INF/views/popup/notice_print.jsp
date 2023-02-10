<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/resources/inc/config.jsp"%>
<%
	pageContext.setAttribute("cn", "\\n");
	pageContext.setAttribute("br", "<br/>");
%>

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

<!-- 게시글 뷰 -->
<div class="notice_view">

	<!-- 게시글 정보 -->
	<div class="view_head">
		<ul>
			<!-- 제목 -->
			<li class="view_title">${data.titl}</li>
			<!-- 작성일 -->
			<li class="view_date">작성일<span>${data.regDt}</span></li>
		</ul>
	</div>
	<!-- //게시글 정보 -->

	<!-- 게시글 내용 -->
	<div class="view_body">
		<!-- 본문 -->
		<p>${fn:replace(data.cntn, cn, br)}</p>
	</div>
	<!-- //게시글 내용 -->

	<!-- button -->
	<div class="btn_go_list frame_print_btn">
		<div class="comm_btn">
			<ul>
				<li class="comm_btn_ok">
					<a href="" style="height:auto;" id="print">인쇄하기</a>
				</li>
			</ul>
		</div>
	</div>
	<!-- //button -->

</div>
