<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/resources/inc/config.jsp"%>

<script type="text/javascript">
$(document).ready(function(){

	//팝업 닫기
	$(document).on("click", "#closeDropoutPopup", function(e){
		e.preventDefault();
		$("#popup_div").empty();
		$("#popup_div").css("display", "none");
		$("body").css("overflow", "");
	});

	//탈퇴사유 글자수 제한
	$("#dropOutReason").keyup(function(){
		var text = $(this).val();
        $('#reasonCnt').text(text.length);
	});

	//회원 탈퇴
	$("#dorpOutbtn").on("click", function(e){
		e.preventDefault();

		P.save({
			form : "#dropOutFrm",
			action : "/mypage/dropOut",
			success : function(result){

				if(result.drop == "notLogin"){
					alert("로그인이 필요합니다.");
					window.location.href="/member/login";
				}else if(result.drop == "Y"){
					alert("회원탈퇴가 정상적으로 처리되었습니다.");
					window.location.href="/";
				}else{
					alert("회원 탈퇴 요청에 실패하였습니다.\n다시 시도하여 주시기 바랍니다.");
					return false;
				}
			}
		});
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

	                		<!-- 회원탈퇴 -->
	                		<div class="memberleave">
	                			<p>
	                				<span>탈퇴</span> 시 등록된 게시물을 포함한 모든 자료가 삭제 처리 되오니 신중하게 결정해 주시길 바랍니다.
                                    <strong><b>정말 탈퇴</b>하시겠습니까?</strong>
	                			</p>
	                			<strong>탈퇴사유</strong>
	                			<div class="textarea">
	                				<form id="dropOutFrm" method="POST">
	                				<div class="textarea-frame">
	                					<textarea name="dropOutReason" id="dropOutReason" maxlength="500"></textarea>
	                				</div>
	                				<div class="textarea-txtcount">
	                					<span><b id="reasonCnt">0</b> / 500</span>
	                				</div>
	                				</form>
	                			</div>
	                		</div>
	                		<!-- //회원탈퇴 -->

	                	</div>
	                	<!-- //팝업 실 컨텐츠 -->

	                	<!-- 팝업 하단 공용버튼 -->
                        <div class="layer-publicbtn lp-two">
                        	<a href="" class="background-0f94dc" id="dorpOutbtn">
                                <div>
                                    <div><span>탈퇴</span></div>
                                </div>
                            </a>
							<a href="" class="lp-basicbtn" id="closeDropoutPopup">
								<div>
									<div><span>취소</span></div>
								</div>
							</a>
                        </div>
                        <!-- // 팝업 하단 공용버튼 -->

	                </div>
	                <!-- //팝업 컨텐츠 -->

	                <!-- 팝업닫기 -->
	                <a href="" id="closeDropoutPopup" title="닫기" class="layer-close"><img src="/resources/img/icon/layer-close.png" alt="레이어 닫기"></a>
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