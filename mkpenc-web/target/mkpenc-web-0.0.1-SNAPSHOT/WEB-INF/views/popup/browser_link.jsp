<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${ context }/resources/css/popup.css"/>
<script type="text/javascript">

$(document).ready(function(){
		
	//팝업창 닫기
	$(".popup_close").on("click", function(e){
		
		e.preventDefault();
		//window.close();
		$("#popup_div").remove();
		$("body").css("overflow", "inherit");
	});
	
	//오늘하루 그만보기
	$(".today_not").on("click", function(e){
		
		e.preventDefault();
		
		//쿠키 저장
		P.json({
			url : "/popup/setTimeGooglePopupClose",
			success : function(result){
				//window.close();
				$("#popup_div").remove();
				$("body").css("overflow", "inherit");
			}
		});
		
	});
	
	//구글 다운로드
	$("#google_download").on("click", function(e){
		
		e.preventDefault();
		
		$("#popup_div").remove();
		$("body").css("overflow", "inherit");
		window.open("https://www.google.co.kr/chrome/browser/desktop/", "_blank");
		
	});
})

</script>
<!-- 배경 -->
<div class="l-background_tent">
<!-- 팝업 위치 틀 -->
<div class="l-popup_position">
	<!-- 팝업 컨텐츠 틀 -->
	<dl class="l-popup_frame">
		<!-- 팝업 헤더 -->
		<dt class="l-popup_header">
			<h1>카바타 튜닝 서비스를 위한 브라우저 안내</h1>
			<a href="" class="popup_close"><img src="/resources/img/icon/icon_l_popup_close.png" alt="구글 다운로드 팝업창 닫기" /></a>
		</dt>
		<!-- 팝업 헤더 -->
		<!-- 팝업 바디 -->
		<dd class="l-popup_body">
			<div class="l-popup_notice">
				<p>
					안녕하십니까? <br />
					<span class="warning_notice" style="font-family:'NotoSansMedium'; font-size:15px; color:red;">구 버전의 Explorer를 사용하시고 계시는 경우</span> 카바타의 <span class="warning_notice" style="font-family:'NotoSansMedium'; font-size:15px; color:red;">튜닝 서비스에 제한</span>이 있을 수 있습니다.<br/>
					카바타 튜닝서비스를 원활히 이용하기 위해서는  <span class="strong_notice" style="font-family:''; font-size:15px; color:#0066b3;">Google Chrome</span> 사용을 권장해드립니다. <br />
				</p>
			</div>
			<div class="l-popup_contents">
				<div class="popup_btn_module">
					<div class="browser_link">
						<a href="" id="google_download">Google Chrome</a>
					</div>
				</div>
			</div>
		</dd>
		<!-- 팝업 바디 -->
		<div  class="today_not">
			<a href="">[ 오늘하루 그만보기 ]</a>
		</div>
	</dl>
	<!-- 팝업 컨텐츠 틀 -->
</div>
<!-- 팝업 위치 틀 -->
</div>