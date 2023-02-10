<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${ context }/resources/css/popup.css"/>
<script type="text/javascript">

$(document).ready(function(){

	//뷰포트 높이에 따른 팝업창 높이 조절
	$(window).resize(function(){$(".l-popup_body").css("height",($(window).innerHeight()-201)+"px");})
	$(".l-popup_body").css("height",($(window).innerHeight()-201)+"px");
	$(".l-popup_body").css("max-height","880px");
	
	//설문조차 중복 참여 확인
	var check = "${check}";
	if(check == "Y")
	{
		alert("이미 설문조사에 참여하셨습니다.");
		location.href = "/";
	}
	
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
			url : "/popup/setTimePopupClose",
			success : function(result){
				$("#popup_div").remove();
				$("body").css("overflow", "inherit");
			}
		});
		
	});
	
	//연락처 숫자만 입력하도록
	$(".num_check").focusout(function(event){
		if(!(event.keyCode >= 37 && event.keyCode <= 40)){
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	
	//카바타 이용 후 설문 참여
	$("#ans_5").on("click", function(e){
		
		e.preventDefault();
		
		alert("카바타 사이트를 이용해 보시고 설문에 응해 주시면 감사드리겠습니다.");
		$("#popup_div").remove();
		$("body").css("overflow", "inherit");
		//window.close();
	})
	
	$("#submit").on("click", function(e){
		
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
		
		//중복 체크 답변 정리
		var ans_25 = $("input[name=ans_25_select]");
		var ans_25_var = "";
		var ans_25_value = "";
		for(var i=0; i<$("input[name=ans_25_select]").length; i++)
		{
			if(ans_25[i].checked)
			{
				if(ans_25[i].value == "기타" && $("input[name=ans_25_etc]").val() != "")
				{
					ans_25_var = ans_25[i].value+"("+$("input[name=ans_25_etc]").val()+")";
				}
				else
				{
					ans_25_var = ans_25[i].value; 
				}
				
				ans_25_value += ans_25_var + ", ";
			}
			
			
		}
		ans_25_value = ans_25_value.substring(0, ans_25_value.length-1);
		ans_25_value = ans_25_value.slice(0, -1);
		$("input[name=ans_25]").val(ans_25_value);
		
		//설문조사 체크 확인
		for(var i=1; i<=30; i++)
		{
			if(i != 24 && i != 25 && i != 27 && i != 28 && i != 30)
			{
				if(!$("input[name=ans_"+i+"]").is(":checked"))
				{
					alert("선택하지 않은 항목이 있습니다.");
					$("input[name=ans_"+i+"]").focus();
					return false;
				}
				
			}
		}
		
		//연락처 형식 변경
		if($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != "")
		{
			var tel = $("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val();
			$("#telno").val(tel);
		}
		
		P.save({
			form : "#question_frm",
			action : "/popup/question_insert",
			success : function(result){
				
				if(result.result == 'Y')
				{
					
					//쿠키 저장
					P.json({
						url : "/popup/setTimePopupClose",
						success : function(result){
							$("#popup_div").remove();
							$("body").css("overflow", "inherit");
						}
					});
					
					alert("카바타 웹사이트 이용자 만족도 조사에 참여가 완료되었습니다.\n감사합니다.");
				}
				else
				{
					alert("카바타 웹사이트 이용자 만족도 조사에 참여 도중 오류가 발생하였습니다.\n다시 시도하여 주시기 바랍니다.");
				}
				
				$("#popup_div").remove();
				$("body").css("overflow", "inherit");
				//window.close();
			}
		});
		
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
			<h1>대구튜닝전문지원센터 일반인용 카바타서비스 : 이용자 만족도 조사</h1>
			<a href="" class="popup_close"><img src="/resources/img/icon/icon_l_popup_close.png" alt="만족도 조사 팝업 닫기" /></a>
		</dt>
		<!-- 팝업 헤더 -->
		<!-- 팝업 바디 -->
		<dd class="l-popup_body" style="overflow-y:scroll;">
			<div class="l-popup_notice">
				<p>
				안녕하십니까?
				자동차부품연구원 대구경북본부에서는 2014년부터 산업통상자원부 창의산업거점기관지원사업으로 『대구튜닝전문지원센터』 구축 사업을 진행하고 있습니다.
				 본 사업은 대구시 튜닝산업 밀착형 기업지원 및 소비자 중심의 성숙된 튜닝문화 확산을 위한 전문지원서비스센터 구축을 목표로 튜닝 카바타(CarVatar)* 및 기업지원 서비스를 제공하기 위함입니다.<br />
				 이에 본 사업의 중간성과로 일반인용 카바타서비스(http://i-carvatar.com)를 시범적으로 운영하게 되었습니다.<br />
				  본 조사는 이용자들의 다양한 의견을 수렴하여 보다 나은 카바타서비스 개발에 반영될 예정입니다. <br />
				  바쁘시더라도 잠시 시간을 내시어 설문에 참여해 주시면 감사하겠습니다. 
				</p>
				<br/>
				<p style="text-align:right;">2016년 8월</p>
				<p style="text-align:right;">자동차부품연구원 대구튜닝전문지원센터 연구책임자 드림</p>
				<br/>
				<p>
					<span><span style="font-weight:bold;">주관 :</span> 자동차부품연구원 대구경북본부 / </span>
					<span><span style="font-weight:bold;">참여 :</span> 서울대, 국민대, 경북대, 계명대 / </span>
					<span><span style="font-weight:bold;">수행 :</span> ㈜리서치프로 담당 연구원 변언주 (T.053-243-7736)</span><br/>
				</p>
				<br /><br />
				<p><span style="color:#02599b;">* 카바타(CarVatar)는 차량(Car)과 아바타(Avatar)의 합성어로서, 온라인 가상환경에서 수요자 목적에 맞는 튜닝정보 제공 및 튜닝부품 개발환경 지원 서비스로 정의합니다. 본 시범서비스의 일반인용 카바타서비스는 방대한 튜닝부품의 정보 및 튜닝카 시뮬레이션을 웹서비스를 통해 무료로 제공함으로서 튜닝문화의 전반적 확산을 목표로 하고 있습니다.</span></p>
				<div style="width:100%; box-sizing:border-box; padding:5px; color:#4a4949; border:1px solid #02599b; margin:25px 0 0 0;">
					<p style="font-family:'NotoSansMedium'; font-size:15px;">본 조사는 카바타서비스 웹사이트 <a href="http://i-carvatar.com" target="_blank" style="color:#02599b;" title="카바타 홈페이지로 이동">(http://i-carvatar.com)</a>를 방문하셔서 해당 서비스를 이용해보신 분들을 대상으로 하고 있습니다.  이용해보지 않으셨다면, 이용 후 설문에 응해주시기 바랍니다. </p>
				</div>
			</div>
			<div class="popup_q">
			<form id="question_frm">
				<!-- 웹 브라우저  -->
				<dl>
					<dt>웹 브라우저</dt>
					<dd>
						<ol>
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>1. 귀하가 카바타 웹사이트 이용 시 사용하신 인터넷 브라우저는 다음 중 무엇입니까?</dt>
									<dd>
										<ul class="list_multiple_four">
											<li>
												<label>
													<input type="radio" name="browser_select" value="크롬" title=""/>
													<span>구글 크롬</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="browser_select" value="파이어폭스" title=""/>
													<span>파이어폭스</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="browser_select" value="익스플로러" title=""/>
													<span>인터넷 익스플로러</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="browser_select" value="오페라" title=""/>
													<span>오페라</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="browser_select" value="사파리" title=""/>
													<span>사파리</span>
												</label>
											</li>											
											<li>
												<label>
													<input type="radio" name="browser_select" value="기타" title=""/>
													<span>기타 ( <input type="text" name="browser_etc" value="" style="width:250px; "/> )</span>
												</label>
											</li>
											<input type="hidden" name="browser" value="" data-check="required"/>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
						</ol>
					</dd>
				</dl>
				<!-- //웹 브라우저  -->
				<!-- 응답자 일반사항 -->
				<dl>
					<dt>응답자 일반사항</dt>
					<dd>
						<ol>
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>1. 귀하의 <span>연령</span>은 어떻게 되십니까?</dt>
									<dd>
										<span class="user_age">만 ( <input type="text"  class="num_check" name="age" id="age" data-check="required" maxlength="2" style="width:50px; text-align:center;" /> )세</span>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>2. <span>성별</span>은 어떻게 되십니까?</dt>
									<dd>
										<ul>
											<li>
												<label>
													<input type="radio" name="gender_select" value="남자" title="" />
													<span>남자</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="gender_select" value="여자" title="" />
													<span>여자</span>
												</label>
											</li>
											<input type="hidden" name="gender" value="" data-check="required"/>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>3. 귀하는 <span>현재 어떤 일</span>을 하고 계십니까?</dt>
									<dd>
										<ul class="list_multiple_five">
											<li style="padding-right:25px;">
												<label>
													<input type="radio" name="job_select" value="경영관리자" title="" />
													<span>경영관리자</span>
												</label>
											</li>
											<li style="padding-right:25px;">
												<label >
													<input type="radio" name="job_select" value="전문직" title="" />
													<span>전문직</span>
												</label>
											</li>
											<li style="padding-right:25px;">
												<label>
													<input type="radio" name="job_select" value="사무종사자" title="" />
													<span>사무종사자</span>
												</label>
											</li>
											<li style="padding-right:25px;">
												<label>
													<input type="radio" name="job_select" value="서비스/판매 종사자" title="" />
													<span>서비스/판매 종사자</span>
												</label>
											</li>
											<li style="padding-right:25px;">
												<label>
													<input type="radio" name="job_select" value="연구개발직" title="" />
													<span>연구개발직</span>
												</label>
											</li>
											<li style="padding-right:25px;">
												<label>
													<input type="radio" name="job_select" value="장치,기계조작 및 조립종사자" title="" />
													<span>장치,기계조작 및 조립종사자</span>
												</label>
											</li>
											<li style="padding-right:25px;">
												<label>
													<input type="radio" name="job_select" value="생산관리직" title="" />
													<span>생산관리직</span>
												</label>
											</li>
											<li style="padding-right:25px;">
												<label>
													<input type="radio" name="job_select" value="학생" title="" />
													<span>학생</span>
												</label>
											</li>
											<li style="padding-right:25px;">
												<label>
													<input type="radio" name="job_select" value="주부" title="" />
													<span>주부</span>
												</label>
											</li>
											<li style="padding-right:25px;">
												<label>
													<input type="radio" name="job_select" value="기타" title="" />													
													<span>기타 ( <input type="text" name="job_etc" value="" style="width:250px; "/> )</span>
												</label>
											</li>
											<input type="hidden" name="job" value="" data-check="required"/>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>4. 귀하의 <span>소속 및 소속부서, 직함</span>을 작성해 주십시오. </dt>
									<dd>
										<table class="l-table_col">
											<caption>소속 및 소속부서, 직함 입력테이블</caption>
											<colgroup>
												<col style="width:20%;"/>
												<col style="width:30%;"/>
												<col style="width:20%;"/>
												<col style="width:30%;"/>
											</colgroup>
											<tbody>
												<tr>
													<th>1) 소속 (회사명)</th>
													<td>
														<label></label>
														<input type="text" name="blng" value="" data-check="required" style="width:100%;" />
													</td>
													<th>2) 소속부서</th>
													<td>
														<label></label>
														<input type="text" name="dept" value="" data-check="required" style="width:100%;" />
													</td>
												</tr>
												<tr>
													<th>3) 직함</th>
													<td>
														<label></label>
														<input type="text" name="grad" value="" data-check="required" style="width:100%;" />
													</td>
													<th>4) 휴대폰 번호</th>
													<td>
														<label></label>
														<input type="text" class="num_check" name="tel_1" id="tel_1" maxlength="3" value="" data-check="required" style="width:62px;" />
														<span>-</span>
														<input type="text" class="num_check" name="tel_2" id="tel_2" maxlength="4" value="" data-check="required" style="width:76px;" />
														<span>-</span>
														<input type="text" class="num_check" name="tel_3" id="tel_3" maxlength="4" value="" data-check="required" style="width:76px;" />
														<input type="hidden" name="telno" id="telno" data-check="required" value=""/>
													</td>
												</tr>
											</tbody>
										</table>
										<!-- <p class="refer">※휴대폰 번호 : 모바일 상품권 제공 시 사용</p> -->
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>5. 귀하의 <span>업무는 자동차와 어느 정도 관련성</span>을 가지고 있습니까?</dt>
									<dd>
										<ul class="list_multiple_five">
											<li>
												<label>
													<input type="radio" name="relation_select" value="매우 높은 편" title="" />
													<span>매우 높은 편</span>
												</label>
											</li>
											<li>
												<label >
													<input type="radio" name="relation_select" value="높은 편" title="" />
													<span>높은 편</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="relation_select" value="보통" title="" />
													<span>보통</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="relation_select" value="낮은 편" title="" />
													<span>낮은 편</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="relation_select" value="매우 낮은 편" title="" />
													<span>매우 낮은 편</span>
												</label>
											</li>
											<input type="hidden" name="relation" value="" data-check="required"/>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
						</ol>
						<!-- <p style="font-size:13px; color:red; margin-top:20px; font-size:15px; font-family:'NotoSansMedium';">< 4, 5번은 자동차관련 기업 대상자 조사 시 작성, 일반인 조사에서는 제외></p> -->
						<p style="font-size:13px; color:red; margin-top:20px; font-size:15px; font-family:'NotoSansMedium';">< 웹 브라우저와 응답자 일반사항은 모두 필수 항목 입니다.></p>
					</dd>
				</dl>
				<!-- //응답자 일반사항 -->
				<!-- 자동차 보유 현황 및 관심도 -->
				<dl>
					<dt>자동차 보유 현황 및 관심도</dt>
					<dd>
						<ol>
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>1. 귀하는 <span>운전면허증을 보유</span>하고 계십니까?</dt>
									<dd>
										<ul>
											<li>
												<label>
													<input type="radio" name="ans_1" value="보유" title="" />
													<span>보유</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_1" value="없음" title="" />
													<span>없음</span>
												</label>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>2. 귀하는 현재 <span>본인 소유 차량</span>을보유하고 계십니까?</dt>
									<dd>
										<ul>
											<li>
												<label>
													<input type="radio" name="ans_2" value="보유함" title="" />
													<span>보유함</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_2" value="보유하고 있지 않음" title="" />
													<span>보유하고 있지 않음</span>
												</label>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>3. 귀하는 <span>평소 자동차에 대해 얼마나 알고</span>있다고 생각하십니까?</dt>
									<dd>
										<ul class="list_multiple_five">
											<li>
												<label>
													<input type="radio" name="ans_3" value="매우 잘 알고 있음" title="" />
													<span>매우 잘 알고 있음</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_3" value="잘 알고 있음" title="" />
													<span>잘 알고 있음</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_3" value="보통" title="" />
													<span>보통</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_3" value="잘 모름" title="" />
													<span>잘 모름</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_3" value="전혀 모름" title="" />
													<span>전혀 모름</span>
												</label>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>4. 귀하는 <span>평소 자동차 튜닝에 대해 어느 정도 관심</span>을 가지고 계셨습니까?</dt>
									<dd>
										<ul class="list_multiple_five">
											<li>
												<label>
													<input type="radio" name="ans_4" value="매우 높음" title="" />
													<span>매우 높음</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_4" value="높은 편임" title="" />
													<span>높은 편임</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_4" value="보통" title="" />
													<span>보통</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_4" value="낮은 편임" title="" />
													<span>낮은 편임</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_4" value="매우 낮음" title="" />
													<span>매우 낮음</span>
												</label>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
						</ol>
					</dd>
				</dl>
				<!-- // 자동차 보유 현황 및 관심도 -->
				<!-- 웹사이트 이용자 만족도 -->
				<dl>
					<dt>웹사이트 이용자 만족도</dt>
					<dd>
						<ol>
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>1. 카바타 사이트에서는 이용자가 직접 자동차 튜닝을 가상환경에서 시공해 봄으로써 자동차의 외관과 성능의 변화를 예측할 수 있고, 웹 장터를 통해 다양한 시공정보를 확인할 수 있습니다. 귀하는<span>카바타 사이트</span>를 이용해 보셨습니까?</dt>
									<dd>
										<ul>
											<li>
												<label>
													<input type="radio" name="ans_5" class="ans_5" value="예"  checked title="" />
													<span>예</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_5" id="ans_5" value="아니오" title="" />
													<span>아니오 (설문종료 or 카바타서비스 이용 후 설문 진행)</span>
												</label>
											</li>											
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<p class="essential_notice">※ 다음은 카바타 웹사이트에 대한 평가 질문입니다. 각 질문들에 빠짐없이 답하여주십시오.</p>
								<dl>
									<dt>2. 다음은 카바타 웹사이트의 <span>컨텐츠</span>에 관한 항목입니다. 귀하께서 느끼시는 것과 <br />가장 가까운 것을 한 개만 골라 √표를 해주십시오.</dt>
									<dd>
										<table class="l-table_row">
											<caption>웹사이트 평가 테이블</caption>
											<colgroup>
												<col style="width:48%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:12%" />
											</colgroup>
											<thead>
												<tr>
													<th>구 분</th>
													<th>매우그렇다</th>
													<th>그렇다</th>
													<th>보통</th>
													<th>그렇지 않다</th>
													<th>전혀 그렇지 않다</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>웹사이트에서 제공하는 정보/서비스는 사이트의 목적과 일치한다.</td>
													<td><label><input type="radio" name="ans_6" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_6" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_6" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_6" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_6" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트에서 제공하는 정보는 이해하기 쉽다.</td>
													<td><label><input type="radio" name="ans_7" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_7" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_7" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_7" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_7" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트에서 제공하는 정보/서비스는 흥미롭다.</td>
													<td><label><input type="radio" name="ans_8" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_8" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_8" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_8" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_8" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트는 튜닝과 관련된 다양한 컨텐츠 및 정보를 포함하고 있다.</td>
													<td><label><input type="radio" name="ans_9" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_9" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_9" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_9" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_9" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
											</tbody>
										</table>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>3. 다음은 카바타 웹사이트의 <span>디자인</span>에 관한 항목입니다. 귀하께서 느끼시는 것과 가장 가까운 것을 한 개만 골라 √표를 해주십시오.</dt>
									<dd>
										<table class="l-table_row">
											<caption>웹사이트 평가 테이블</caption>
											<colgroup>
												<col style="width:48%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:12%" />
											</colgroup>
											<thead>
												<tr>
													<th>구 분</th>
													<th>매우그렇다</th>
													<th>그렇다</th>
													<th>보통</th>
													<th>그렇지 않다</th>
													<th>전혀 그렇지 않다</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>웹사이트의 전반적인 디자인은 세련되었다.</td>
													<td><label><input type="radio" name="ans_10" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_10" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_10" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_10" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_10" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트에서는 중요하거나 강조해야 할 내용을 효과적으로 배열했다.</td>
													<td><label><input type="radio" name="ans_11" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_11" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_11" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_11" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_11" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트의 스타일, 색상, 이미지, 그래픽 등은 전반적으로 통일성을 가진다.</td>
													<td><label><input type="radio" name="ans_12" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_12" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_12" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_12" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_12" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
											</tbody>
										</table>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>4. 다음은 카바타 웹사이트의 <span>구성</span>에 관한 항목입니다. 귀하께서 느끼시는 것과 가장 가까운 것을 한 개만 골라 √표를 해주십시오.</dt>
									<dd>
										<table class="l-table_row">
											<caption>웹사이트 평가 테이블</caption>
											<colgroup>
												<col style="width:48%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:12%" />
											</colgroup>
											<thead>
												<tr>
													<th>구 분</th>
													<th>매우그렇다</th>
													<th>그렇다</th>
													<th>보통</th>
													<th>그렇지 않다</th>
													<th>전혀 그렇지 않다</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>메뉴 구성이 간결하며, 원하는 정보에 대한 접근이 용이하다.</td>
													<td><label><input type="radio" name="ans_13" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_13" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_13" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_13" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_13" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트 내에서 현재 자신의 위치 파악이 쉽다.</td>
													<td><label><input type="radio" name="ans_14" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_14" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_14" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_14" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_14" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트 구성을 한눈에 알 수 있다.</td>
													<td><label><input type="radio" name="ans_15" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_15" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_15" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_15" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_15" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
											</tbody>
										</table>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>5. 다음은 카바타 웹사이트의 <span>시스템 성능</span>에 관한 항목입니다. 귀하께서 느끼시는 것과 가장 가까운 것을 한 개만 골라 √표를 해주십시오.</dt>
									<dd>
										<table class="l-table_row">
											<caption>웹사이트 평가 테이블</caption>
											<colgroup>
												<col style="width:48%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:12%" />
											</colgroup>
											<thead>
												<tr>
													<th>구 분</th>
													<th>매우그렇다</th>
													<th>그렇다</th>
													<th>보통</th>
													<th>그렇지 않다</th>
													<th>전혀 그렇지 않다</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>웹사이트는 안정적이다(접속, 오류발생 등).</td>
													<td><label><input type="radio" name="ans_16" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_16" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_16" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_16" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_16" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트 내 사이트 이동은 빠르다.</td>
													<td><label><input type="radio" name="ans_17" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_17" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_17" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_17" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_17" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트 내 컨텐츠(가상튜닝 등) 로딩속도는 빠르다.</td>
													<td><label><input type="radio" name="ans_18" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_18" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_18" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_18" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_18" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
											</tbody>
										</table>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>6. 다음은 카바타 웹사이트의 <span>쇼핑몰</span>에 관한 항목입니다. 귀하께서 느끼시는 것과 가장 가까운 것을 한 개만 골라 √표를 해주십시오.</dt>
									<dd>
										<table class="l-table_row">
											<caption>웹사이트 평가 테이블</caption>
											<colgroup>
												<col style="width:48%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:10%" />
												<col style="width:12%" />
											</colgroup>
											<thead>
												<tr>
													<th>구 분</th>
													<th>매우그렇다</th>
													<th>그렇다</th>
													<th>보통</th>
													<th>그렇지 않다</th>
													<th>전혀 그렇지 않다</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>웹사이트에서 제공하는 정보/서비스는 사이트의 목적과 일치한다.</td>
													<td><label><input type="radio" name="ans_19" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_19" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_19" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_19" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_19" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트에서 제공하는 정보는 이해하기 쉽다.</td>
													<td><label><input type="radio" name="ans_20" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_20" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_20" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_20" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_20" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트에서 제공하는 정보/서비스는 흥미롭다.</td>
													<td><label><input type="radio" name="ans_21" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_21" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_21" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_21" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_21" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
												<tr>
													<td>웹사이트는 튜닝과 관련된 다양한 컨텐츠 및 정보를 포함하고 있다.</td>
													<td><label><input type="radio" name="ans_22" value="매우그렇다"/><span style="display:none;">매우그렇다</span></label></td>
													<td><label><input type="radio" name="ans_22" value="그렇다"/><span style="display:none;">그렇다</span></label></td>
													<td><label><input type="radio" name="ans_22" value="보통"/><span style="display:none;">보통</span></label></td>
													<td><label><input type="radio" name="ans_22" value="그렇지 않다"/><span style="display:none;">그렇지 않다</span></label></td>
													<td><label><input type="radio" name="ans_22" value="전혀 그렇지 않다"/><span style="display:none;">전혀 그렇지 않다</span></label></td>
												</tr>
											</tbody>
										</table>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>7. 카바타 웹사이트에 대한 <span>전반적인 만족도</span>는 어떻습니까?</dt>
									<dd>
										<ul class="list_multiple_five">
											<li>
												<label>
													<input type="radio" name="ans_23" value="매우 만족" title="" />
													<span>매우 만족</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_23" value="만족" title="" />
													<span>만족</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_23" value="보통" title="" />
													<span>보통</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_23" value="불만족" title="" />
													<span>불만족</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_23" value="매우 불만족" title="" />
													<span>매우 불만족</span>
												</label>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>7-1. <span>만족 또는 불만족하신 이유</span>는 무엇입니까?</dt>
									<dd>
										<label style="display:none;">만족 또는 불만족하신 이유</label>
										<textarea name="ans_24" id="ans_24" cols="30" rows="10" maxlength="100" class="input_text" placeholder="100자 이내로 작성하여 주시기 바랍니다."></textarea>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>8. 카바타 웹사이트 내 <span>개선이 가장 시급한 것</span>은 무엇이라고 생각하십니까? 해당사항 <span>모두 선택</span>해 주십시오.</dt>
									<dd>
										<ul class="list_multiple_four">
											<li>
												<label>
													<input type="checkbox" name="ans_25_select" value="다양한 컨텐츠와 정보 제공" title="" />
													<span>다양한 컨텐츠와 정보 제공</span>
												</label>
											</li>
											<li>
												<label>
													<input type="checkbox" name="ans_25_select" value="필요한 정보 접근의 편의성 확보" title="" />
													<span>필요한 정보 접근의 편의성 확보</span>
												</label>
											</li>
											<li>
												<label>
													<input type="checkbox" name="ans_25_select" value="이용자 참여 및 소통 공간 확보" title="" />
													<span>이용자 참여 및 소통 공간 확보</span>
												</label>
											</li>
											<li>
												<label>
													<input type="checkbox" name="ans_25_select" value="입력，조회， 검색 등 기능 추가" title="" />
													<span>입력, 조회, 검색 등 기능 추가</span>
												</label>
											</li>
											<li>
												<label>
													<input type="checkbox" name="ans_25_select" value="시스템 성능，속도 개선" title="" />
													<span>시스템 성능, 속도 개선</span>
												</label>
											</li>
											<li>
												<label>
													<input type="checkbox" name="ans_25_select" value="기타" title="" />
													<span>기타 ( <input type="text" name="ans_25_etc" value="" style="width:250px; "/> )</span>
												</label>
											</li>
											<input type="hidden" name="ans_25" value="" title="" />
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>9. 카바타 사이트가 <span>지속적으로 차종 업데이트, 서비스 개선 등이 이루어진다면,</span> 귀하는 카바타 웹사이트를 향후에도 <span>계속 이용할 의사</span>가 있으십니까?</dt>
									<dd>
										<ul class="list_multiple_four">
											<li>
												<label>
													<input type="radio" name="ans_26" value="있다" title="" />
													<span>있다</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_26" value="없다" title="" />
													<span>없다</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_26" value="잘 모르겠다" title="" />
													<span>잘 모르겠다</span>
												</label>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>9-1. 계속 이용할 의사가 있으시다면, 어떤 차종의 추가를 원하십니까?</dt>
									<dd>
										<label style="display:none;">추가를 원하는 차종</label>
										<textarea name="ans_27" id="ans_27" cols="30" rows="10" maxlength="100" class="input_text" placeholder="100자 이내로 작성하여 주시기 바랍니다."></textarea>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>9-2. 계속 이용할 의사가 있으시다면, 어떤 튜닝부품의 추가를 원하십니까?</dt>
									<dd>
										<label style="display:none;">추가를 원하는 튜닝부품</label>
										<textarea name="ans_28" id="ans_28" cols="30" rows="10" maxlength="100" class="input_text" placeholder="100자 이내로 작성하여 주시기 바랍니다."></textarea>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>10. 귀하는 추후에 카바타 웹사이트를 <span>지인에게 소개하거나 추천하실 의향</span>이 있으십니까?</dt>
									<dd>
										<ul class="list_multiple_four">
											<li>
												<label>
													<input type="radio" name="ans_29" value="있다" title="" />
													<span>있다</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_29" value="없다" title="" />
													<span>없다</span>
												</label>
											</li>
											<li>
												<label>
													<input type="radio" name="ans_29" value="잘 모르겠다" title="" />
													<span>잘 모르겠다</span>
												</label>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
							<!-- 소 질문 -->
							<li>
								<dl>
									<dt>11. 카바타 웹사이트와 관련하여 건의하고 싶으신 내용이 있으시면 자유롭게 작성하여 주십시오.</dt>
									<dd>
										<label style="display:none;">건의하고 싶으신 내용</label>
										<textarea name="ans_30" id="ans_30" cols="30" rows="10" class="input_text" maxlength="100" placeholder="100자 이내로 작성하여 주시기 바랍니다."></textarea>
									</dd>
								</dl>
							</li>
							<!-- 소 질문 -->
						</ol>
						<p class="essential_notice">※ 설문에 응해 주셔서 대단히 감사합니다.</p>
					</dd>
				</dl>
				<!-- // 웹사이트 이용자 만족도 -->
				<div class="popup_btn_module">
					<div>
						<label for="submit" style="display:none;">설문완료버튼</label>
						<input type="button" name="submit" id="submit" value="설문 완료"/>
					</div>
				</div>
			</form>
			</div>
		</dd>
		<!-- 팝업 바디 -->
		<!-- <div class="today_not">
			<a href="" >[ 오늘하루 그만보기 ]</a>
		</div> -->
	</dl>
	<!-- 팝업 컨텐츠 틀 -->
</div>
<!-- 팝업 위치 틀 -->
</div>
<!-- 배경 -->