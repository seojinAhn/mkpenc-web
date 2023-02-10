<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://onmakers.com/function" prefix="fnc" %>

<script type="text/javascript">
$(document).ready(function(){
	
	//팝업 닫기
	$("#closeCompare").on("click",function(e){
		e.preventDefault();
		$("#popup_div").empty();
		$("#popup_div").css("display", "none");
		$("body").css("overflow", "");
		history.go(-1);
	});
	
	//로그인 하러 가기
	$("#moveToLogin").on("click", function(e){
		e.preventDefault();
		window.location.href="/member/login?menuId=M0201";
	});
	
});
</script>

<!-- fixed -->
<div class="layer layer-fixed customlayer">
	<!-- relative -->
	<div class="layer-relative">
		<!-- table -->
	    <div class="layer-table">
	    	<!-- cell -->
	        <div class="layer-cell">
	        	<!-- 틀 -->
	            <div class="layer-frame">
	            	
	            	<!-- 팝업 상단 -->
	                <div class="layer-top">
	                    <strong class="layer-title"></strong>
	                </div>
	                <!-- // 팝업 상단 -->
	                
	                <!-- 팝업 컨텐츠 -->
	                <div class="layer-body">
	                	<!-- 팝업 실 컨텐츠 -->
	                	<div class="layer-contents">
	                		
	                		<!-- 1:1 문의 안내 -->
							<div class="qna-notice">
								<strong>
									<b>1 : 1문의</b>는 로그인 후 작성할 수 있습니다.
								</strong>
								<p><b>1 : 1문의</b>를 등록하시려면 <br /><b>로그인</b>을 해주세요.</p>
							</div>
							<!-- // 1:1 문의 안내 -->
							
	                	</div>
	                	<!-- //팝업 실 컨텐츠 -->
	                	
	                	<!-- 팝업 하단 버튼 -->
	                	<div class="layer-publicbtn">
	                		<a href="" class="next-step background-0f94dc" id="moveToLogin">
								<div>
									<div><span>로그인하러가기</span></div>
								</div>
							</a>
	                	</div>
	                	<!-- //팝업 하단 버튼 -->
	                </div>
	                <!-- //팝업 컨텐츠 -->
	                
	                <!-- 팝업닫기 -->
	                <a href="" id="closeCompare" title="닫기" class="layer-close"><img src="/resources/img/icon/layer-close.png" alt="레이어 닫기"></a>
	                <!-- // 팝업닫기 -->
	                
	            </div>
	            <!-- //틀 -->
	        </div>
	        <!-- //cell -->
	    </div>
	    <!-- //table -->
	</div>
	<!-- //relative -->
</div>
<!-- //fixed -->