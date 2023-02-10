<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/resources/inc/config.jsp"%>

<script type="text/javascript">
$(document).ready(function(){

	//로그인 체크
	if("${gList}" == "logOut"){
		alert("로그인 후 사용하실 수 있습니다.");
		$(".mtg_cancel").click();
	}

	//차량 일련번호 체크
	if("${carNo}" == "NotData"){
		alert("잘못된 접근입니다.");
		$(".mtg_cancel").click();
	}

	//팝업 닫기
	$(".mtg_cancel").on("click",function(){
		$("#popup_div").empty();
		$("#popup_div").css("display", "none");
		$("body").css("overflow", "");
	});

	//차량 이동
	$("#moveToMyGarage").on("click", function(){

		//차고 일련번호
		var garageSeq = $("#gList").val();

		//차고 선택 체크
		if(!garageSeq || garageSeq == ""){
			alert("차고를 선택해 주세요.");
			return false;
		}else{
			if(!confirm("해당 차량을 내차고에 저장하시겠습니까?")){
				return false;
			}

			var data = {"carNo":"${carNo}", "garageSeq": garageSeq};

			P.json({
				url : "/gallery/copyToMyGarage",
				data : data,
	          	success : function(result){

	          		// 저장 성공 시
	          		if(result.result == "Y"){
	          			if(confirm("해당 차량이 내 차고에 저장되었습니다.\n내 차고로 이동하시겠습니까?")){
	          				location.replace("/garage/main");
	          			}else{
	          				$(".mtg_cancel").click();
	          			}
	          		}else{
	          			alert("해당 차량을 내 차고에 저장하는데 실패하였습니다.");
	          			return false;
	          		}
	          	}
			});
		}
	});

});
</script>

<!-- 차고 리스트 -->
<div class="moveto_garage">
	<dl>
		<dt>
			<p class="mtg_title">카바타  갤러리 내 차고 등록</p>
			<p class="mtg_notice">선택된 차량을 <span>내 차고로 이동</span>시킵니다.</p>
			<a href="javascript:;" class="mtg_cancel"><img src="/resources/img/icon/icon_tr_detail_close.png" alt="팝업창 닫기" /></a>
		</dt>
		<dd>
		<select id="gList">
			<option value="">차고를 선택해 주세요.</option>
			<c:forEach items="${gList}" var="gList">
				<option value="${gList.garage_seq}">${gList.garage_nm}</option>
			</c:forEach>
		</select>
		<a href="javscript:;" id="moveToMyGarage" class="mtg_btn">이동</a>
		</dd>
	</dl>
</div>
<!-- //차고 리스트 -->