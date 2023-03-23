<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://onmakers.com/function" prefix="fnc"%>

<script type="text/javascript">
$(document).ready(function() {

	//팝업 닫기
	$("#closeCompare").on("click", function(e) {
		e.preventDefault();
		$("#popup_div").empty();
		$("#popup_div").css("display", "none");
		$("body").css("background", "");
		$("body").css("overflow", "");
	});

	//연락처 숫자만 입력하도록
	$(".num_check").focusout(function(event){
		if(!(event.keyCode >= 37 && event.keyCode <= 40)){
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});

	//카바타 이용후 설문 ㅊ마여
	$("#notUseCarvatar").on("click", function(e){
		e.preventDefault();
		alert("카바타 서비스 이용 후 설문에 참여 하여 주시기 바랍니다.");
		$("#closeCompare").click();
	});

	//설문조사 제출하기
	$("#submitSurvey").on("click", function(e){
		e.preventDefault();

		if($(':radio[name="browser_select"]:checked').val() == "기타" && $("input[name=browser_etc]").val() != "")
		{
			var browser = $(':radio[name="browser_select"]:checked').val() + "(" + $("input[name=browser_etc]").val() + ")"
		}
		else
		{
			var browser = $(':radio[name="browser_select"]:checked').val();
		}
		$("input[name=browser]").val(browser);

		if($(':radio[name="job_select"]:checked').val() == "기타" && $("input[name=job_etc]").val() != "")
		{
			var job = $(':radio[name="job_select"]:checked').val() + "(" + $("input[name=job_etc]").val() + ")";
		}
		else
		{
			var job = $(':radio[name="job_select"]:checked').val();
		}
		$("input[name=job]").val(job);

		$("input[name=gender]").val($(':radio[name="gender_select"]:checked').val());
		$("input[name=relation]").val($(':radio[name="relation_select"]:checked').val());

		//연락처 형식 변경
		if($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != "")
		{
			var tel = $("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val();
			$("input[name=telno]").val(tel);
		}

		//중복 체크 답변 정리
		var ans_28_1 = $("input[name=ans_28_1_select]");
		var ans_28_1_var = "";
		var ans_28_1_value = "";
		for(var i=0; i<ans_28_1.length; i++)
		{
			if(ans_28_1[i].checked)
			{
				if(ans_28_1[i].value == "기타" && $("input[name=ans_28_1_etc]").val() != "")
				{
					ans_28_1_var = ans_28_1[i].value+"("+$("input[name=ans_28_1_etc]").val()+")";
				}
				else
				{
					ans_28_1_var = ans_28_1[i].value;
				}

				ans_28_1_value += ans_28_1_var + ", ";
			}


		}
		ans_28_1_value = ans_28_1_value.substring(0, ans_28_1_value.length-1);
		ans_28_1_value = ans_28_1_value.slice(0, -1);
		$("input[name=ans_28_1]").val(ans_28_1_value);

		var ans_28_2 = $("input[name=ans_28_2_select]");
		var ans_28_2_var = "";
		var ans_28_2_value = "";
		for(var i=0; i<ans_28_2.length; i++)
		{
			if(ans_28_2[i].checked)
			{
				if(ans_28_2[i].value == "기타" && $("input[name=ans_28_2_etc]").val() != "")
				{
					ans_28_2_var = ans_28_2[i].value+"("+$("input[name=ans_28_2_etc]").val()+")";
				}
				else
				{
					ans_28_2_var = ans_28_2[i].value;
				}

				ans_28_2_value += ans_28_2_var + ", ";
			}


		}
		ans_28_2_value = ans_28_2_value.substring(0, ans_28_2_value.length-1);
		ans_28_2_value = ans_28_2_value.slice(0, -1);
		$("input[name=ans_28_2]").val(ans_28_2_value);

		//설문조사 체크 확인
		for(var i=1; i<=31; i++)
		{
			if(i != 31 && i != 25 && i != 26 && i != 27)
			{
				if(!$("input[name=ans_"+i+"]").is(":checked"))
				{
					alert("선택하지 않은 항목이 있습니다.");
					$("input[name=ans_"+i+"]").focus();
					return false;
				}
			}
		}


        var opt = {
            url: '/common/json/saveSurvey',
            data: $('#surveyFrm').serialize(),
            contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
            // dataType : 'json',
        };

        P.ajax(opt, function(data) {
            if(data.ins == "Y"){
                localStorage.setItem("chkSurvey", "Y");
                alert("카바타 웹사이트 이용자 만족도 조사에 참여가 완료되었습니다.\n감사합니다.");
            }else{
                alert("카바타 웹사이트 이용자 만족도 조사에 참여 도중 오류가 발생하였습니다.\n다시 시도하여 주시기 바랍니다.");
            }

            $("#closeCompare").click();
        });

		// P.save({
		// 	form : "#surveyFrm",
		// 	action : "/common/saveSurvey",
		// 	success : function(result){
		// 		if(result.ins == "Y"){
		// 			localStorage.setItem("chkSurvey", "Y");
		// 			alert("카바타 웹사이트 이용자 만족도 조사에 참여가 완료되었습니다.\n감사합니다.");
		// 		}else{
		// 			alert("카바타 웹사이트 이용자 만족도 조사에 참여 도중 오류가 발생하였습니다.\n다시 시도하여 주시기 바랍니다.");
		// 		}
		//
		// 		$("#closeCompare").click();
		// 	}
		// });

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
				<div class="layer-frame" style="padding-top:20px; padding-bottom:10px;">
					<!-- 팝업 상단 -->
					<div class="layer-top">
						<strong class="layer-title"></strong>
					</div>
					<!-- // 팝업 상단 -->
					<!-- 팝업 컨텐츠 -->
					<div class="layer-body">
						<!-- 팝업 실 컨텐츠 -->
						<div class="layer-contents">

							<!-- 설문조사 -->
							<div class="online-survey">
								<!-- 제목 -->
								<h1 class="osv-title">
									대구튜닝전문지원센터 카바타(CarVatar) 서비스<br>이용자 만족도 조사
								</h1>
								<!-- // 제목 -->
								<!-- 서문 -->
								<div class="osv-preface">
									<!-- 서문 - 인사말 -->
									<div class="osvp-greeting">
										<p>
											안녕하십니까? 자동차부품연구원 대구경북본부에서는 2014년부터 산업통상자원부 창의산 업거점기관지원사업으로 『대구튜닝전문지원센터』 구축 사업을 진행하고 있습 니다.
											본 사업은 대구시 튜닝산업 밀착형 기업지원 및 소비자 중심의 성숙된 튜닝문화 확산을 위한 전문지원서비스센터 구축을 목표로 튜닝 카바타 (CarVatar)* 및 기업지원 서비스를 제공하기 위함입니다.
											<br> 이에 본 사업의 중간성과로 일반인/전문가용 카바타서비스 및 튜닝 O2O 쇼핑몰서비스(http://carvatar.co.kr)를 시범적으로 운영하게 되었습니다.
											본 조사는 이용자들의 다양한 의견을 수렴하여 보다 나은 카바타서비스 개발에 반영될 예정입니다. 바쁘시더라도 잠시 시간을 내시어 설문에 참여해 주시면 감사하겠습니다.
										</p>
										<span>2018년 8월</span> <strong>자동차부품연구원 대구튜닝전문지원센터 연구책임자 드림</strong>
									</div>
									<!-- 서문 - 주관 참여 수행 -->
									<div class="osvp-host">
										<p><span>주관 : </span>자동차부품연구원 대구경북본부</p>
										<p><span>참여 : </span>서울대, 국민대, 경북대, 계명대, 지능형자동차부품진흥원</p>
										<p><span>수행 : </span>㈜리서치프로 담당 연구원 조경민 (T.053-243-7736)</p>
									</div>
									<!-- 서문 - 카바타란? -->
									<p class="osvp-reference">
										* 카바타(CarVatar)는 차량(Car)과 아바타(Avatar)의 합성어로서, 온라인 가상환경에서 수요자 목 적에 맞는 튜닝정보 제공 및 튜닝부품 개발환경 지원 서비스로 정의합니다.
										본 시범서비스의 일반인 및 전문가용 시뮬레이션을 웹서비 스를 통해 무료로 제공함으로서 튜닝문화의 전반적 확산을 목표로 하고 있습니다.
									</p>
								</div>
								<!-- // 서문 -->
								<!-- 알림 -->
								<div class="osv-notice">
									<p>
										본 조사는 카바타서비스 웹사이트 ( <a href="http://carvatar.co.kr" target="_blank" title="(구)카바타 홈페이지">http://carvatar.co.kr</a> ) 를 방문하셔서
										해당 서비스 를 이용해보신 분들을 대상으로 하고 있습니다 . 이용해보지 않으셨다면 , 이용 후 설문에 응해주시기 바랍니다 .
									</p>
								</div>

								<!-- 설문 -->
								<div class="osv-doc">
									<form id="surveyFrm">
										<input type="hidden" name="browser" value="" data-check="required"/>
										<input type="hidden" name="job" value="" data-check="required"/>
										<input type="hidden" name="gender" value="" data-check="required"/>
										<input type="hidden" name="telno" value="" data-check="required"/>
										<input type="hidden" name="relation" value="" data-check="required"/>
										<input type="hidden" name="ans_28_1" value=""/>
										<input type="hidden" name="ans_28_2" value=""/>
										<!-- 분류 -->
										<h2 class="osvd-value">□ 웹 브라우저</h2>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">1. 귀하가 카바타 웹사이트 이용 시 사용하신 인터넷 브라우저는 다음 중 무엇입니까?</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="browser_select01" class="radio"><input type="radio" id="browser_select01" name="browser_select" value="구글 크롬"><span>구글 크롬</span></label></li>
												<li><label for="browser_select02" class="radio"><input type="radio" id="browser_select02" name="browser_select" value="파이어폭스"><span>파이어폭스</span></label></li>
												<li><label for="browser_select03" class="radio"><input type="radio" id="browser_select03" name="browser_select" value="인터넷 익스플로러"><span>인터넷 익스플로러</span></label></li>
												<li><label for="browser_select04" class="radio"><input type="radio" id="browser_select04" name="browser_select" value="오페라"><span>오페라</span></label></li>
												<li><label for="browser_select05" class="radio"><input type="radio" id="browser_select05" name="browser_select" value="사파리"><span>사파리</span></label></li>
												<li style="width: 30%;">
													<label for="browser_select06" class="radio">
														<input type="radio" id="browser_select06" name="browser_select" value="기타"><span>기타</span>
													</label>
													<label for="browser_etc" class="etc">
														( <input type="text" id="browser_etc" name="browser_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
													</label>
												</li>
											</ul>
										</div>

										<!-- 분류 -->
										<h2 class="osvd-value">□ 응답자 일반사항</h2>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">1. <b>연령대</b>는 어떻게 되십니까?</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="age_select01" class="radio"><input id="age_select01" name="age_select" value="10" type="radio"><span>10대</span></label></li>
												<li><label for="age_select02" class="radio"><input id="age_select02" name="age_select" value="20" type="radio"><span>20대</span></label></li>
												<li><label for="age_select03" class="radio"><input id="age_select03" name="age_select" value="30" type="radio"><span>30대</span></label></li>
												<li><label for="age_select04" class="radio"><input id="age_select04" name="age_select" value="40" type="radio"><span>40대</span></label></li>
												<li><label for="age_select05" class="radio"><input id="age_select05" name="age_select" value="50" type="radio"><span>50대</span></label></li>
												<li><label for="age_select06" class="radio"><input id="age_select06" name="age_select" value="60대 이상" type="radio"><span>60대 이상</span></label></li>
											</ul>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												2. <b>성별</b>은 어떻게 되십니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="gender_select01" class="radio"><input type="radio" id="gender_select01" name="gender_select" value="M"><span>남</span></label></li>
												<li><label for="gender_select02" class="radio"><input type="radio" id="gender_select02" name="gender_select" value="F"><span>여</span></label></li>
											</ul>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												3. 귀하는 <b>현재 어떤 일</b>을 하고 계십니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="job_select01" class="radio"><input type="radio" id="job_select01" name="job_select" value="경영관리자"><span>경영관리자</span></label></li>
												<li><label for="job_select02" class="radio"><input type="radio" id="job_select02" name="job_select" value="전문직"><span>전문직</span></label></li>
												<li><label for="job_select03" class="radio"><input type="radio" id="job_select03" name="job_select" value="사무종사자"><span>사무종사자</span></label></li>
												<li><label for="job_select04" class="radio"><input type="radio" id="job_select04" name="job_select" value="서비스/판매 종사자"><span>서비스/판매 종사자</span></label></li>
												<li><label for="job_select05" class="radio"><input type="radio" id="job_select05" name="job_select" value="연구개발직"><span>연구개발직</span></label></li>
												<li><label for="job_select06" class="radio"><input type="radio" id="job_select06" name="job_select" value="장치,기계조작 및 조립종사자"><span>장치,기계조작 및 <br>조립종사자</span></label></li>
												<li><label for="job_select07" class="radio"><input type="radio" id="job_select07" name="job_select" value="생산관리직"><span>생산관리직</span></label></li>
												<li><label for="job_select08" class="radio"><input type="radio" id="job_select08" name="job_select" value="IT관련 종사자"><span>IT관련 종사자</span></label></li>
												<li><label for="job_select09" class="radio"><input type="radio" id="job_select09" name="job_select" value="학생"><span>학생</span></label></li>
												<li><label for="job_select10" class="radio"><input type="radio" id="job_select10" name="job_select" value="주부"><span>주부</span></label></li>
												<li style="width: 30%;">
													<label for="job_select11" class="radio">
														<input type="radio" id="job_select11" name="job_select" value="기타"><span>기타</span>
													</label>
													<label for="job_etc" class="etc">
														( <input type="text" id="job_etc" name="job_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
													</label>
												</li>
											</ul>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												4. 귀하의 <b>소속 및 소속부서, 직함</b>을 작성해 주십시오
											</div>
											<table border="1">
												<caption>
													<colgroup>
														<col style="width: 20%;">
														<col style="width: 80%;">
													</colgroup>
												</caption>
												<tbody>
													<tr>
														<th>1) 소속(회사명)</th>
														<td>
															<label for="blng"></label>
															<input type="text" id="blng" name="blng" value="" data-check="required" style="width: 100%; border: none;" placeholder="소속(회사명)을 작성해주세요.">
														</td>
													</tr>
													<tr>
														<th>2) 소속부서</th>
														<td>
															<label for="dept"></label>
															<input type="text" id="dept" name="dept" value="" data-check="required" style="width: 100%; border: none;" placeholder="소속부서를 작성해주세요.">
														</td>
													</tr>
													<tr>
														<th>3) 직함</th>
														<td>
															<label for="grad"></label>
															<input type="text" id="grad" name="grad" value="" data-check="required" style="width: 100%; border: none;" placeholder="직함을 작성해주세요.">
														</td>
													</tr>
													<tr>
														<th>4) 휴대폰 번호</th>
														<td style="text-align:left; padding-left:12px;">
															<label></label>
															<input type="text" class="num_check" name="tel_1" id="tel_1" maxlength="3" value="" data-check="required" style="width:62px;" />
															<span>-</span>
															<input type="text" class="num_check" name="tel_2" id="tel_2" maxlength="4" value="" data-check="required" style="width:76px;" />
															<span>-</span>
															<input type="text" class="num_check" name="tel_3" id="tel_3" maxlength="4" value="" data-check="required" style="width:76px;" />
														</td>
													</tr>
												</tbody>
											</table>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												5. 귀하의 <b>업무는 자동차와 어느 정도 관련성</b>을 가지고 있습니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="relation_select01" class="radio"><input type="radio" id="relation_select01" name="relation_select" value="매우 높은 편"><span>매우 높은 편</span></label></li>
												<li><label for="relation_select02" class="radio"><input type="radio" id="relation_select02" name="relation_select" value="높은 편"><span>높은 편</span></label></li>
												<li><label for="relation_select03" class="radio"><input type="radio" id="relation_select03" name="relation_select" value="보통"><span>보통</span></label></li>
												<li><label for="relation_select04" class="radio"><input type="radio" id="relation_select04" name="relation_select" value="낮은 편"><span>낮은 편</span></label></li>
												<li><label for="relation_select05" class="radio"><input type="radio" id="relation_select05" name="relation_select" value="매우 낮은 편"><span>매우 낮은 편</span></label></li>
											</ul>

											<div class="osvdb-question-depths">5-1. 자동차와 관련 있는 직종이시면, 해당 업무에 대하여 기술해주세요.</div>
											<!-- 주관식 -->
											<label for="relation_etc" class="etc-depths"><input type="text" id="relation_etc" name="relation_etc" value="" placeholder="여기에 작성"></label>
										</div>


										<!-- 분류 -->
										<h2 class="osvd-value">□ 자동차 보유 현황 및 관심도</h2>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												1. 귀하는 <b>운전면허증</b>을 보유하고 계십니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_1_01" class="radio"><input type="radio" id="ans_1_01" name="ans_1" value="보유"><span>보유</span></label></li>
												<li><label for="ans_1_02" class="radio"><input type="radio" id="ans_1_02" name="ans_1" value="없음"><span>없음</span></label></li>
											</ul>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												2. 귀하는 현재 <b>본인 소유 차량</b>을 보유하고 계십니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_2_01" class="radio"><input type="radio" id="ans_2_01" name="ans_2" value="보유함"><span>보유함</span></label></li>
												<li><label for="ans_2_02" class="radio"><input type="radio" id="ans_2_02" name="ans_2" value="보유하고 있지 않음"><span>보유하고 있지 않음</span></label></li>
											</ul>

											<div class="osvdb-question-depths">2-1. 소유하고 계신 차종 및 차명 기입해주세요.</div>
											<!-- 주관식 -->
											<label for="ans_2_1" class="etc-depths"><input type="text" id="ans_2_1" name="ans_2_1" value="" placeholder="여기에 작성"></label>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												3. 귀하는 <b>평소 자동차에 대해 얼마나 알고</b> 있다고 생각하십니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_3_01" class="radio"><input type="radio" id="ans_3_01" name="ans_3" value="매우 잘 알고 있음"><span>매우 잘 알고있음</span></label></li>
												<li><label for="ans_3_02" class="radio"><input type="radio" id="ans_3_02" name="ans_3" value="잘 알고 있음"><span>잘 알고 있음</span></label></li>
												<li><label for="ans_3_03" class="radio"><input type="radio" id="ans_3_03" name="ans_3" value="보통"><span>보통</span></label></li>
												<li><label for="ans_3_04" class="radio"><input type="radio" id="ans_3_04" name="ans_3" value="잘 모름"><span>잘 모름</span></label></li>
												<li><label for="ans_3_05" class="radio"><input type="radio" id="ans_3_05" name="ans_3" value="전혀 모름"><span>전혀 모름</span></label></li>
											</ul>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												4. 귀하는 <b>평소 자동차 튜닝에 대해 어느 정도 관심</b>을 가지고 계셨습니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_4_01" class="radio"><input type="radio" id="ans_4_01" name="ans_4" value="매우 높음"><span>매우 높음</span></label></li>
												<li><label for="ans_4_02" class="radio"><input type="radio" id="ans_4_02" name="ans_4" value="높은 편임"><span>높은 편임</span></label></li>
												<li><label for="ans_4_03" class="radio"><input type="radio" id="ans_4_03" name="ans_4" value="보통"><span>보통</span></label></li>
												<li><label for="ans_4_04" class="radio"><input type="radio" id="ans_4_04" name="ans_4" value="낮은 편임"><span>낮은 편임</span></label></li>
												<li><label for="ans_4_05" class="radio"><input type="radio" id="ans_4_05" name="ans_4" value="매우 낮음"><span>매우 낮음</span></label></li>
											</ul>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												5. 실제 <b>자동차 튜닝</b>을 해본 경험이 있으십니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_5_01" class="radio"><input type="radio" id="ans_5_01" name="ans_5" value="예"><span>예</span></label></li>
												<li><label for="ans_5_02" class="radio"><input type="radio" id="ans_5_02" name="ans_5" value="아니오"><span>아니오</span></label></li>
											</ul>

											<div class="osvdb-question-depths">5-1. 경험이 있다면, 어떤 부분에 대하여 튜닝을 하였습니까?</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_5_1_01" class="radio"><input type="radio" id="ans_5_1_01" name="ans_5_1" value="성능(퍼포먼스업)"><span>성능(퍼포먼스업)</span></label></li>
												<li><label for="ans_5_1_02" class="radio"><input type="radio" id="ans_5_1_02" name="ans_5_1" value="외관(드레스업)"><span>외관(드레스업)</span></label></li>
												<li><label for="ans_5_1_03" class="radio"><input type="radio" id="ans_5_1_03" name="ans_5_1" value="출력(파워업)"><span>출력(파워업)</span></label></li>
												<li style="width: 30%;">
													<label for="ans_5_1_04" class="radio">
														<input type="radio" id="ans_5_1_04" name="ans_5_1" value="기타"><span>기타</span>
													</label>
													<label for="ans_5_1_etc" class="etc">
														( <input type="text" id="ans_5_1_etc" name="ans_5_1_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
													</label>
												</li>
											</ul>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												6. 튜닝을 시도해 본다면, <b>어떤 부분</b>에 대하여 튜닝을 해보고 싶으십니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_6_01" class="radio"><input type="radio" id="ans_6_01" name="ans_6" value="성능(퍼포먼스업)"><span>성능(퍼포먼스업)</span></label></li>
												<li><label for="ans_6_02" class="radio"><input type="radio" id="ans_6_02" name="ans_6" value="외관(드레스업)"><span>외관(드레스업)</span></label></li>
												<li><label for="ans_6_03" class="radio"><input type="radio" id="ans_6_03" name="ans_6" value="출력(파워업)"><span>출력(파워업)</span></label></li>
												<li style="width: 30%;">
													<label for="ans_6_04" class="radio">
														<input type="radio" id="ans_6_04" name="ans_6" value="기타"><span>기타</span>
													</label>
													<label for="ans_6_etc" class="etc">
														( <input type="text" id="ans_6_etc" name="ans_6_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
													</label>
												</li>
											</ul>
										</div>

										<!-- 분류 -->
										<h2 class="osvd-value">□ 웹사이트 이용자 만족도</h2>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												1. 카바타 사이트에서는 이용자가 직접 자동차 튜닝을 가상환경에서 시공해 봄으 로써 자동차의 외관과 성능의 변화를 예측할 수 있고, 웹 장터를 통해 다양한 시공정보를 확인할 수 있습니다. 귀하는 <b>카바타 사이트</b>를 이용해 보셨습니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_7_01" class="radio"><input type="radio" id="ans_7_01" name="ans_7" value="예"><span>예</span></label></li>
												<li><label for="ans_7_02" class="radio" id="notUseCarvatar"><input type="radio" id="ans_7_02" name="ans_7" value="아니오"><span>아니오</span></label></li>
											</ul>

											<div class="osvdb-question-depths">1-1. 사용해본 경험이 있다면, 얼마나 자주 방문하였습니까?</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_7_1_01" class="radio"><input type="radio" id="ans_7_1_01" name="ans_7_1" value="1회 사용"><span>1회 사용</span></label></li>
												<li><label for="ans_7_1_02" class="radio"><input type="radio" id="ans_7_1_02" name="ans_7_1" value="2회 ~ 3회"><span>2회 ~ 3회</span></label></li>
												<li><label for="ans_7_1_03" class="radio"><input type="radio" id="ans_7_1_03" name="ans_7_1" value="3회 ~ 5회 이상"><span>3회 ~ 5회 이상</span></label></li>
												<li><label for="ans_7_1_04" class="radio"><input type="radio" id="ans_7_1_04" name="ans_7_1" value="5회 ~ 10회 이상"><span>5회 ~ 10회 이상</span></label></li>
												<li style="width: 30%;">
													<label for="ans_7_1_05" class="radio">
														<input type="radio" id="ans_7_1_05" name="ans_7_1" value="기타"><span>기타</span>
													</label>
													<label for="ans_7_1_etc" class="etc">
														( <input type="text" id="ans_7_1_etc" name="ans_7_1_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
													</label>
												</li>
											</ul>
										</div>

										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												2. <b>어떤 경로</b>를 통해 카바타 서비스를 이용하였습니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_8_01" class="radio"><input type="radio" id="ans_8_01" name="ans_8" value="검색"><span>검색</span></label></li>
												<li><label for="ans_8_02" class="radio"><input type="radio" id="ans_8_02" name="ans_8" value="SNS(페이스북 등)"><span>SNS(페이스북 등)</span></label></li>
												<li><label for="ans_8_03" class="radio"><input type="radio" id="ans_8_03" name="ans_8" value="뉴스 등 기사"><span>뉴스 등 기사</span></label></li>
												<li><label for="ans_8_04" class="radio"><input type="radio" id="ans_8_04" name="ans_8" value="지인의 추천"><span>지인의 추천</span></label></li>
												<li style="clear: both; width: 30%;">
													<label for="ans_8_05" class="radio">
														<input type="radio" id="ans_8_05" name="ans_8" value="기타"><span>기타</span>
													</label>
													<label for="ans_8_etc" class="etc">
														( <input type="text" id="ans_8_etc" name="ans_8_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
													</label>
												</li>
											</ul>
										</div>

										<span class="osv-endcomment">※ 다음은 카바타 웹사이트에 대한 평가 질문입니다. 각 질문들에 빠짐없이 답하여주십시오.</span>

										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												3. <b>컨텐츠/기능 측면</b>
											</div>
											<div style="border: 1px solid #0f94dc; padding: 15px; margin-top: 15px;">
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">1) 카바타 서비스는 튜닝과 관련된 컨텐츠를 충분히 제공하고 있습니까?</div>
													<!-- 객관식 -->
													<ul>
														<li><label for="ans_9_01" class="radio"><input type="radio" id="ans_9_01" name="ans_9" value="매우 그렇다"><span>매우 그렇다</span></label></li>
														<li><label for="ans_9_02" class="radio"><input type="radio" id="ans_9_02" name="ans_9" value="그렇다"><span>그렇다</span></label></li>
														<li><label for="ans_9_03" class="radio"><input type="radio" id="ans_9_03" name="ans_9" value="보통"><span>보통</span></label></li>
														<li><label for="ans_9_04" class="radio"><input type="radio" id="ans_9_04" name="ans_9" value="그렇지 않다"><span>그렇지 않다</span></label></li>
														<li><label for="ans_9_05" class="radio"><input type="radio" id="ans_9_05" name="ans_9" value="전혀 그렇지 않다"><span>전혀 그렇지 않다</span></label></li>
													</ul>
												</div>
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">2) 카바타 서비스를 통해 튜닝에 대하여 흥미를 느낄 수 있습니까?</div>
													<!-- 객관식 -->
													<ul>
														<li><label for="ans_10_01" class="radio"><input type="radio" id="ans_10_01" name="ans_10" value="매우 그렇다"><span>매우 그렇다</span></label></li>
														<li><label for="ans_10_02" class="radio"><input type="radio" id="ans_10_02" name="ans_10" value="그렇다"><span>그렇다</span></label></li>
														<li><label for="ans_10_03" class="radio"><input type="radio" id="ans_10_03" name="ans_10" value="보통"><span>보통</span></label></li>
														<li><label for="ans_10_04" class="radio"><input type="radio" id="ans_10_04" name="ans_10" value="그렇지 않다"><span>그렇지 않다</span></label></li>
														<li><label for="ans_10_05" class="radio"><input type="radio" id="ans_10_05" name="ans_10" value="전혀 그렇지 않다"><span>전혀 그렇지 않다</span></label></li>
													</ul>
												</div>

												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">3) 카바타 서비스는 이해하기 쉽고 충분히 유용합니까?</div>
													<!-- 객관식 -->
													<ul>
														<li><label for="ans_11_01" class="radio"><input type="radio" id="ans_11_01" name="ans_11" value="매우 그렇다"><span>매우 그렇다</span></label></li>
														<li><label for="ans_11_02" class="radio"><input type="radio" id="ans_11_02" name="ans_11" value="그렇다"><span>그렇다</span></label></li>
														<li><label for="ans_11_03" class="radio"><input type="radio" id="ans_11_03" name="ans_11" value="보통"><span>보통</span></label></li>
														<li><label for="ans_11_04" class="radio"><input type="radio" id="ans_11_04" name="ans_11" value="그렇지 않다"><span>그렇지 않다</span></label></li>
														<li><label for="ans_11_05" class="radio"><input type="radio" id="ans_11_05" name="ans_11" value="전혀 그렇지 않다"><span>전혀 그렇지 않다</span></label></li>
													</ul>

													<div class="osvdb-question-depths">3-1) 그렇지 않다면 (④, ⑤번 선택), 이유는 무엇입니까?</div>
													<!-- 주관식 -->
													<label for="ans_11_1" class="etc-depths">
														<input type="text" id="ans_11_1" name="ans_11_1" value="" placeholder="여기에 작성">
													</label>
												</div>
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">4) 카바타 서비스 화면/기능 중 가장 선호하는(유용한) 메뉴는 무엇입니까?</div>
													<!-- 객관식 -->
													<ul>
														<li><label for="ans_12_01" class="radio"><input type="radio" id="ans_12_01" name="ans_12" value="가상튜닝"><span>가상튜닝</span></label></li>
														<li><label for="ans_12_02" class="radio"><input type="radio" id="ans_12_02" name="ans_12" value="튜닝O2O/쇼핑몰"><span>튜닝O2O/쇼핑몰</span></label></li>
														<li><label for="ans_12_03" class="radio"><input type="radio" id="ans_12_03" name="ans_12" value="부품정보"><span>부품정보</span></label></li>
														<li><label for="ans_12_04" class="radio"><input type="radio" id="ans_12_04" name="ans_12" value="커뮤니티"><span>커뮤니티</span></label></li>
														<li><label for="ans_12_05" class="radio"><input type="radio" id="ans_12_05" name="ans_12" value="데이터마켓"><span>데이터마켓</span></label></li>
														<li><label for="ans_12_07" class="radio"><input type="radio" id="ans_12_07" name="ans_12" value="교육안내"><span>교육안내</span></label></li>
														<li style="clear: both; width: 30%;">
															<label for="ans_12_06" class="radio">
																<input type="radio" id="ans_12_06" name="ans_12" value="기타"><span>기타</span>
															</label>
															<label for="ans_12_etc" class="etc">
																( <input type="text" id="ans_12_etc" name="ans_12_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
															</label>
														</li>
													</ul>

													<div class="osvdb-question-depths">
														4-1) 위 기능을 선호하는 이유는 무엇입니까?</div>
													<!-- 주관식 -->
													<label for="ans_12_1" class="etc-depths">
														<input type="text" id="ans_12_1" name="ans_12_1" value="" placeholder="여기에 작성">
													</label>
												</div>
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">5) 카바타 서비스 화면/기능 중 가장 선호하지 않는(유용하지 못한) 메뉴는 무엇입니까?</div>
													<!-- 객관식 -->
													<ul>
														<li><label for="ans_13_01" class="radio"><input type="radio" id="ans_13_01" name="ans_13" value="가상튜닝"><span>가상튜닝</span></label></li>
														<li><label for="ans_13_02" class="radio"><input type="radio" id="ans_13_02" name="ans_13" value="튜닝O2O/쇼핑몰"><span>튜닝O2O/쇼핑몰</span></label></li>
														<li><label for="ans_13_03" class="radio"><input type="radio" id="ans_13_03" name="ans_13" value="부품정보"><span>부품정보</span></label></li>
														<li><label for="ans_13_04" class="radio"><input type="radio" id="ans_13_04" name="ans_13" value="커뮤니티"><span>커뮤니티</span></label></li>
														<li><label for="ans_13_05" class="radio"><input type="radio" id="ans_13_05" name="ans_13" value="데이터마켓"><span>데이터마켓</span></label></li>
														<li><label for="ans_13_07" class="radio"><input type="radio" id="ans_13_07" name="ans_13" value="교육안내"><span>교육안내</span></label></li>
														<li style="clear: both; width: 30%;">
															<label for="ans_13_06" class="radio">
																<input type="radio" id="ans_13_06" name="ans_13" value="기타"><span>기타</span>
															</label>
															<label for="ans_13_etc" class="etc">
																( <input type="text" id="ans_13_etc" name="ans_13_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
															</label>
														</li>
													</ul>

													<div class="osvdb-question-depths">
														5-1) 위 기능을 선호하지 않는 이유는 무엇입니까?</div>
													<!-- 주관식 -->
													<label for="ans_13_1" class="etc-depths">
														<input type="text" id="ans_13_1" name="ans_13_1" value="" placeholder="여기에 작성">
													</label>
												</div>
											</div>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												4. <b>구성/디자인 측면</b>
											</div>
											<!-- 테이블형식 설문 -->
											<table border="1">
												<caption>설문 테이블</caption>
												<colgroup>
													<col style="width: 40%;">
													<col style="width: 12%;">
													<col style="width: 12%;">
													<col style="width: 12%;">
													<col style="width: 12%;">
													<col style="width: 12%;">
												</colgroup>
												<thead>
													<tr>
														<th>구분</th>
														<th>매우<br>그렇다
														</th>
														<th>그렇다</th>
														<th>보통</th>
														<th>그렇지 않다</th>
														<th>전혀<br>그렇지 않다
														</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>1) 카바타 웹서비스의 기능은 사용하기 쉽게 구성되어 있습니까?</td>
														<td><label for="ans_14_01" class="radio"><input type="radio" id="ans_14_01" name="ans_14" value="매우 그렇다"><span></span></label></td>
														<td><label for="ans_14_02" class="radio"><input type="radio" id="ans_14_02" name="ans_14" value="그렇다"><span></span></label></td>
														<td><label for="ans_14_03" class="radio"><input type="radio" id="ans_14_03" name="ans_14" value="보통"><span></span></label></td>
														<td><label for="ans_14_04" class="radio"><input type="radio" id="ans_14_04" name="ans_14" value="그렇지 않다"><span></span></label></td>
														<td><label for="ans_14_05" class="radio"><input type="radio" id="ans_14_05" name="ans_14" value="전혀 그렇지 않다"><span></span></label></td>
													</tr>
													<tr>
														<td>2) 웹사이트 메뉴 구성은 간결하며 화면배열이 파악하기 쉽습니까?</td>
														<td><label for="ans_15_01" class="radio"><input type="radio" id="ans_15_01" name="ans_15" value="매우 그렇다"><span></span></label></td>
														<td><label for="ans_15_02" class="radio"><input type="radio" id="ans_15_02" name="ans_15" value="그렇다"><span></span></label></td>
														<td><label for="ans_15_03" class="radio"><input type="radio" id="ans_15_03" name="ans_15" value="보통"><span></span></label></td>
														<td><label for="ans_15_04" class="radio"><input type="radio" id="ans_15_04" name="ans_15" value="그렇지 않다"><span></span></label></td>
														<td><label for="ans_15_05" class="radio"><input type="radio" id="ans_15_05" name="ans_15" value="전혀 그렇지 않다"><span></span></label></td>
													</tr>
													<tr>
														<td>3) 웹사이트 내 원하는 정보에 대한 접근 및 검색이 용이합니까?</td>
														<td><label for="ans_16_01" class="radio"><input type="radio" id="ans_16_01" name="ans_16" value="매우 그렇다"><span></span></label></td>
														<td><label for="ans_16_02" class="radio"><input type="radio" id="ans_16_02" name="ans_16" value="그렇다"><span></span></label></td>
														<td><label for="ans_16_03" class="radio"><input type="radio" id="ans_16_03" name="ans_16" value="보통"><span></span></label></td>
														<td><label for="ans_16_04" class="radio"><input type="radio" id="ans_16_04" name="ans_16" value="그렇지 않다"><span></span></label></td>
														<td><label for="ans_16_05" class="radio"><input type="radio" id="ans_16_05" name="ans_16" value="전혀 그렇지 않다"><span></span></label></td>
													</tr>
													<tr>
														<td>4) 웹사이트의 디자인은 세련되었습니까?</td>
														<td><label for="ans_17_01" class="radio"><input type="radio" id="ans_17_01" name="ans_17" value="매우 그렇다"><span></span></label></td>
														<td><label for="ans_17_02" class="radio"><input type="radio" id="ans_17_02" name="ans_17" value="그렇다"><span></span></label></td>
														<td><label for="ans_17_03" class="radio"><input type="radio" id="ans_17_03" name="ans_17" value="보통"><span></span></label></td>
														<td><label for="ans_17_04" class="radio"><input type="radio" id="ans_17_04" name="ans_17" value="그렇지 않다"><span></span></label></td>
														<td><label for="ans_17_05" class="radio"><input type="radio" id="ans_17_05" name="ans_17" value="전혀 그렇지 않다"><span></span></label></td>
													</tr>
													<tr>
														<td>5) 웹사이트의 스타일, 색상, 이미지 그래픽 등이 전반적으로 통일성을 가지고 있습니까?</td>
														<td><label for="ans_18_01" class="radio"><input type="radio" id="ans_18_01" name="ans_18" value="매우 그렇다"><span></span></label></td>
														<td><label for="ans_18_02" class="radio"><input type="radio" id="ans_18_02" name="ans_18" value="그렇다"><span></span></label></td>
														<td><label for="ans_18_03" class="radio"><input type="radio" id="ans_18_03" name="ans_18" value="보통"><span></span></label></td>
														<td><label for="ans_18_04" class="radio"><input type="radio" id="ans_18_04" name="ans_18" value="그렇지 않다"><span></span></label></td>
														<td><label for="ans_18_05" class="radio"><input type="radio" id="ans_18_05" name="ans_18" value="전혀 그렇지 않다"><span></span></label></td>
													</tr>
												</tbody>
											</table>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												5.  <b>시스템 성능 측면</b>
											</div>
											<!-- 테이블형식 설문 -->
											<table border="1">
												<caption>설문 테이블</caption>
												<colgroup>
													<col style="width: 40%;">
													<col style="width: 12%;">
													<col style="width: 12%;">
													<col style="width: 12%;">
													<col style="width: 12%;">
													<col style="width: 12%;">
												</colgroup>
												<thead>
													<tr>
														<th>구분</th>
														<th>매우<br>그렇다
														</th>
														<th>그렇다</th>
														<th>보통</th>
														<th>그렇지 않다</th>
														<th>전혀<br>그렇지 않다
														</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>1) 웹사이트는 안정적(접속, 오류발생 등)으로 사용 가능합니까?</td>
														<td><label for="ans_19_01" class="radio"><input type="radio" id="ans_19_01" name="ans_19" value="매우 그렇다"><span></span></label></td>
														<td><label for="ans_19_02" class="radio"><input type="radio" id="ans_19_02" name="ans_19" value="그렇다"><span></span></label></td>
														<td><label for="ans_19_03" class="radio"><input type="radio" id="ans_19_03" name="ans_19" value="보통"><span></span></label></td>
														<td><label for="ans_19_04" class="radio"><input type="radio" id="ans_19_04" name="ans_19" value="그렇지 않다"><span></span></label></td>
														<td><label for="ans_19_05" class="radio"><input type="radio" id="ans_19_05" name="ans_19" value="전혀 그렇지 않다"><span></span></label></td>
													</tr>
													<tr>
														<td>2) 웹사이트 내 사이트 이동 속도는 적절합니까?</td>
														<td><label for="ans_20_01" class="radio"><input type="radio" id="ans_20_01" name="ans_20" value="매우 그렇다"><span></span></label></td>
														<td><label for="ans_20_02" class="radio"><input type="radio" id="ans_20_02" name="ans_20" value="그렇다"><span></span></label></td>
														<td><label for="ans_20_03" class="radio"><input type="radio" id="ans_20_03" name="ans_20" value="보통"><span></span></label></td>
														<td><label for="ans_20_04" class="radio"><input type="radio" id="ans_20_04" name="ans_20" value="그렇지 않다"><span></span></label></td>
														<td><label for="ans_20_05" class="radio"><input type="radio" id="ans_20_05" name="ans_20" value="전혀 그렇지 않다"><span></span></label></td>
													</tr>
													<tr>
														<td>3) 웹사이트 내 컨텐츠(가상튜닝 등) 로딩시간은 적절합니까?</td>
														<td><label for="ans_21_01" class="radio"><input type="radio" id="ans_21_01" name="ans_21" value="매우 그렇다"><span></span></label></td>
														<td><label for="ans_21_02" class="radio"><input type="radio" id="ans_21_02" name="ans_21" value="그렇다"><span></span></label></td>
														<td><label for="ans_21_03" class="radio"><input type="radio" id="ans_21_03" name="ans_21" value="보통"><span></span></label></td>
														<td><label for="ans_21_04" class="radio"><input type="radio" id="ans_21_04" name="ans_21" value="그렇지 않다"><span></span></label></td>
														<td><label for="ans_21_05" class="radio"><input type="radio" id="ans_21_05" name="ans_21" value="전혀 그렇지 않다"><span></span></label></td>
													</tr>
												</tbody>
											</table>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												6.  <b>서비스 개선 측면</b>
											</div>
											<div style="border: 1px solid #0f94dc; padding: 15px; margin-top: 15px;">
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">1) 현재 카바타는 7개 튜닝성능(가속/제동/핸들링/연비/승차감/진동/내구)에 대한 가상튜닝 작업 및 결과 확인이 가능합니다. 데이터 마켓에서는 튜닝부품의 다양한 시험데이터, 가상튜닝 결과 데이터, 부품해석 의뢰 서비스 제공이 가능합니다. 데이터 마켓 정보가 유용하다고 생각하십니까?</div>
													<!-- 객관식 -->
													<ul>
														<li><label for="ans_22_01" class="radio"><input type="radio" id="ans_22_01" name="ans_22" value="예"><span>예</span></label></li>
														<li><label for="ans_22_02" class="radio"><input type="radio" id="ans_22_02" name="ans_22" value="아니오"><span>아니오</span></label></li>
													</ul>

													<div class="osvdb-question-depths">1-1) 해당 기능이 유료로 제공될 경우, 유료 서비스를 사용할 의향이 있으십니까?</div>
													<ul>
														<li><label for="ans_22_1_01" class="radio"><input type="radio" id="ans_22_1_01" name="ans_22_1" value="예"><span>예</span></label></li>
														<li><label for="ans_22_1_02" class="radio"><input type="radio" id="ans_22_1_02" name="ans_22_1" value="아니오"><span>아니오</span></label></li>
													</ul>
													<div class="osvdb-question-depths">1-2) 해당 기능이 유료로 제공될 경우, 선호하는 유료 서비스 결제 방법은 무엇입니까?</div>
													<ul style="height: 60px;">
														<li><label for="ans_22_2_01" class="radio"><input type="radio" id="ans_22_2_01" name="ans_22_2" value="유료 데이터 건별 결재"><span>유료 데이터 건별 결제</span></label></li>
														<li style="width:30%;"><label for="ans_22_2_02" class="radio"><input type="radio" id="ans_22_2_02" name="ans_22_2" value="유료 등급별 회원제(일정기간 동안 회원등급별 데이터 차등 제공)"><span>유료 등급별 회원제(일정기간 동안 회원등급별 데이터 차등 제공)</span></label></li>
														<li style="width:30%;"><label for="ans_22_2_03" class="radio"><input type="radio" id="ans_22_2_03" name="ans_22_2" value="유료 포인트 회원제(일정기간 동안 결제한 포인트 만큼 선택 데이터 제공)"><span>유료 포인트 회원제(일정기간 동안 결제한 포인트 만큼 선택 데이터 제공)</span></label></li>
														<li><label for="ans_22_2_04" class="radio"><input type="radio" id="ans_22_2_04" name="ans_22_2" value="기타"><span>기타</span></label></li>
													</ul>
												</div>
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">2) 가상 튜닝에 적용 혹은 조회한 부품에 대하여 가격 정보를 제공하고 튜닝 쇼핑몰 및 O2O 플랫폼 사이트로 연계한다면, 해당 정보가 유용하다고 생각하십니까?</div>
													<!-- 객관식 -->
													<ul>
														<li><label for="ans_23_01" class="radio"><input type="radio" id="ans_23_01" name="ans_23" value="예"><span>예</span></label></li>
														<li><label for="ans_23_02" class="radio"><input type="radio" id="ans_23_02" name="ans_23" value="아니오"><span>아니오</span></label></li>
													</ul>

													<div class="osvdb-question-depths">2-1) 연계된 쇼핑몰에서 부품을 구매할 의향이 있습니까?</div>
													<ul>
														<li><label for="ans_23_1_01" class="radio"><input type="radio" id="ans_23_1_01" name="ans_23_1" value="예"><span>예</span></label></li>
														<li><label for="ans_23_1_02" class="radio"><input type="radio" id="ans_23_1_02" name="ans_23_1" value="아니오"><span>아니오</span></label></li>
													</ul>

													<div class="osvdb-question-depths">2-2) 구매 의향이 없다면 이유는 무엇입니까?</div>
													<!-- 주관식 -->
													<label for="ans_23_2" class="etc-depths">
														<input type="text" id="ans_23_2" name="ans_23_2" value="" placeholder="여기에 작성">
													</label>
												</div>
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">3) 사용자의 가상튜닝 작업과 관련하여 실제 시공 가능한 업체를 추천한다면, 해당 정보가 유용하다고 생각하십니까?</div>
													<!-- 객관식 -->
													<ul>
														<li><label for="ans_24_01" class="radio"><input type="radio" id="ans_24_01" name="ans_24" value="예"><span>예</span></label></li>
														<li><label for="ans_24_02" class="radio"><input type="radio" id="ans_24_02" name="ans_24" value="아니오"><span>아니오</span></label></li>
													</ul>

													<div class="osvdb-question-depths">3-1) 추천한 시공 업체에 연락하여 시공할 의향이 있습니까?</div>
													<ul>
														<li><label for="ans_24_1_01" class="radio"><input type="radio" id="ans_24_1_01" name="ans_24_1" value="예"><span>예</span></label></li>
														<li><label for="ans_24_1_02" class="radio"><input type="radio" id="ans_24_1_02" name="ans_24_1" value="아니오"><span>아니오</span></label></li>
													</ul>

													<div class="osvdb-question-depths">3-2) 시공 의향이 없다면 이유는 무엇입니까?</div>
													<!-- 주관식 -->
													<label for="ans_24_2" class="etc-depths">
														<input type="text" id="ans_24_2" name="ans_24_2" value="" placeholder="여기에 작성">
													</label>
												</div>
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">4) 현재 카바타는 8개 차종(K7, 아반떼, 쏘나타, 쏘렌토, G80, 레이, 스파크, RS7)에 대한 가상튜닝 작업이 가능합니다. 추가되기를 희망하는 차종이 있다면 무엇입니까?</div>
													<label for="ans_25" class="etc-depths">
														<input type="text" id="ans_25" name="ans_25" value="" placeholder="여기에 작성">
													</label>
												</div>
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">5) 현재 카바타는 6개 항목(현가계, 제동계, 구동계, 차체, 에어로파츠, 등화장치)와 관련된 부품 정보를 제공하고 있습니다. 추가되기를 희망하는 부품이 있다면 무엇입니까?</div>
													<label for="ans_26" class="etc-depths">
														<input type="text" id="ans_26" name="ans_26" value="" placeholder="여기에 작성">
													</label>
												</div>
												<!-- 설문상자 -->
												<div class="osvd-box">
													<!-- 질문 -->
													<div class="osvdb-question">6) 이와 개선 되었으면 하는 기능이 있다면 자유롭게 기술해주세요.</div>
													<label for="ans_27" class="etc-depths">
														<input type="text" id="ans_27" name="ans_27" value="" placeholder="여기에 작성">
													</label>
												</div>
											</div>
										</div>
										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												7. 카바타 웹사이트에 대한 <b>전반적인 만족도</b>는 어떻습니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_28_01" class="radio"><input type="radio" id="ans_28_01" name="ans_28" value="매우 만족"><span>매우 만족</span></label></li>
												<li><label for="ans_28_02" class="radio"><input type="radio" id="ans_28_02" name="ans_28" value="만족"><span>만족</span></label></li>
												<li><label for="ans_28_03" class="radio"><input type="radio" id="ans_28_03" name="ans_28" value="보통"><span>보통</span></label></li>
												<li><label for="ans_28_04" class="radio"><input type="radio" id="ans_28_04" name="ans_28" value="불만족"><span>불만족</span></label></li>
												<li><label for="ans_28_05" class="radio"><input type="radio" id="ans_28_05" name="ans_28" value="매우 불만족"><span>매우 불만족</span></label></li>
											</ul>

											<div class="osvdb-question-depths">7-1. 만족하신다면 이유는 무엇입니까?(복수선택 가능)</div>
											<ul>
												<li style="width: 50%;"><label for="ans_28_1_01"><input type="checkbox" id="ans_28_1_01" name="ans_28_1_select" value="다양한 컨텐츠와 정보 제공"><span>다양한 컨텐츠와 정보 제공</span></label></li>
												<li style="width: 50%;"><label for="ans_28_1_02"><input type="checkbox" id="ans_28_1_02" name="ans_28_1_select" value="사용 편의성"><span>사용 편의성</span></label></li>
												<li style="width: 50%;"><label for="ans_28_1_03"><input type="checkbox" id="ans_28_1_03" name="ans_28_1_select" value="필요한 정보 접근 및 공유 편의성"><span>필요한 정보 접근 및 공유 편의성</span></label></li>
												<li style="width: 50%;"><label for="ans_28_1_04"><input type="checkbox" id="ans_28_1_04" name="ans_28_1_select" value="디자인 및 화면구성 "><span>디자인 및 화면구성 </span></label></li>
												<li style="width: 50%;">
													<label for="ans_28_1_05">
														<input type="checkbox" id="ans_28_1_05" name="ans_28_1_select" value="기타"><span>기타</span>
													</label>
													<label for="ans_28_1_etc" class="etc">
														( <input type="text" id="ans_28_1_etc" name="ans_28_1_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
													</label>
												</li>
											</ul>

											<br> <br>

											<div class="osvdb-question-depths">7-2. 만족하지 않으신다면, 이유는 무엇입니까?(복수선택 가능)</div>
											<ul>
												<li style="width: 50%;"><label for="ans_28_2_01"><input type="checkbox" id="ans_28_2_01" name="ans_28_2_select" value="다양한 컨텐츠와 정보 제공"><span>컨텐츠 부족</span></label></li>
												<li style="width: 50%;"><label for="ans_28_2_02"><input type="checkbox" id="ans_28_2_02" name="ans_28_2_select" value="사용 편의성"><span>사용 편의성</span></label></li>
												<li style="width: 50%;"><label for="ans_28_2_03"><input type="checkbox" id="ans_28_2_03" name="ans_28_2_select" value="필요한 정보 접근 및 공유 편의성"><span>필요한 정보 접근 및 공유의 어려움</span></label></li>
												<li style="width: 50%;"><label for="ans_28_2_04"><input type="checkbox" id="ans_28_2_04" name="ans_28_2_select" value="디자인 및 화면구성 "><span>디자인 및 화면구성</span></label></li>
												<li style="width: 50%;"><label for="ans_28_2_05"><input type="checkbox" id="ans_28_2_05" name="ans_28_2_select" value="디자인 및 화면구성 "><span>시스템 성능 및 속도 개선</span></label></li>
												<li style="width: 50%;">
													<label for="ans_28_2_06">
														<input type="checkbox" id="ans_28_2_06" name="ans_28_2_select" value="기타"><span>기타</span>
													</label>
													<label for="ans_28_2_etc" class="etc">
														( <input type="text" id="ans_28_2_etc" name="ans_28_2_etc" value="" placeholder="여기에 작성" style="width: 150px; text-align: center;"> )
													</label>
												</li>
											</ul>
										</div>

										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												8. 카바타 사이트를 <b>재방문할 의향</b>이 있으십니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_29_01" class="radio"><input type="radio" id="ans_29_01" name="ans_29" value="예"><span>예</span></label></li>
												<li><label for="ans_29_02" class="radio"><input type="radio" id="ans_29_02" name="ans_29" value="아니오"><span>아니오</span></label></li>
											</ul>

											<div class="osvdb-question-depths">8-1. 사이트를 재방문하지 않는다면 이유는 무엇입니까?</div>
											<label for="ans_29_1" class="etc-depths">
												<input type="text" id="ans_29_1" name="ans_29_1" value="" placeholder="여기에 작성">
											</label>
										</div>

										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">
												9. 카바타 사이트를 주변 지인에게 <b>소개하거나 추천</b>하실 의향이 있으십니까?
											</div>
											<!-- 객관식 -->
											<ul>
												<li><label for="ans_30_01" class="radio"><input type="radio" id="ans_30_01" name="ans_30" value="예"><span>예</span></label></li>
												<li><label for="ans_30_02" class="radio"><input type="radio" id="ans_30_02" name="ans_30" value="아니오"><span>아니오</span></label></li>
											</ul>
										</div>

										<!-- 설문상자 -->
										<div class="osvd-box">
											<!-- 질문 -->
											<div class="osvdb-question">10. <b>건의사항</b>을 자유롭게 기술해 주세요.</div>
											<textarea id="ans_31" name="ans_31"></textarea>
										</div>
									</form>
								</div>
								<!-- // 설문 -->
								<span class="osv-endcomment">※ 설문에 응해 주셔서 대단히 감사합니다.</span>
							</div>
							<!-- // 설문조사 -->

						</div>
						<!-- // 팝업 실 컨텐츠 -->
						<!-- 팝업 하단 공용버튼 -->
						<div class="layer-publicbtn">
							<!-- 버튼이 2개일때 lp-two 더블클래스로 추가 -->

							<a href="" id="submitSurvey" class="background-0f94dc">
								<div>
									<div>
										<span>제출하기</span>
									</div>
								</div>
							</a>

						</div>
						<!-- // 팝업 하단 공용버튼 -->
					</div>
					<!-- // 팝업 컨텐츠 -->

					<!-- 팝업닫기 -->
					<a href="" id="closeCompare" title="닫기" class="layer-close" style="top:3px; z-index:1;"><img
						src="/resources/img/icon/layer-close.png" alt="레이어 닫기"></a>
					<!-- // 팝업닫기 -->

				</div>
				<!-- // 틀 -->

			</div>
			<!-- // cell -->
		</div>
		<!-- // table -->
	</div>
	<!-- // relative -->
</div>
<!-- // fixed -->