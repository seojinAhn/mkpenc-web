<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function(){
	
	//일반 닫기
	$("#closeCompare").on("click",function(e){
		/* e.preventDefault();
		$("#popup_div").empty();
		$("#popup_div").css("display", "none");
		$("body").css("background", "");
		$("body").css("overflow", ""); */
		var carId = "${param.car_id}";
		var url = "";
		
		if(carId == "1" || carId == "2"){	//쏘렌토, 쏘나타
			url = "/tuning/main?car_id="+carId;
			url = encodeURI(url);
			window.location.href=url;
		}else if(carId == "3" || carId == "4"){
			if(carId == "3"){	
				url = "http://carvatar.co.kr:8888/tuning/main?car_id=2";
			}else if(carId == "4"){	
				url = "http://carvatar.co.kr:8888/tuning/main?car_id=1";
			}
			
			url = encodeURI(url);
			window.open(url);
		}
	});
	
	/* //쿠키닫기
	$(".modal_today_close").on("click",function(e){
	
		e.preventDefault();
		
		//쿠키 저장
		P.json({
			url : "/popup/setTimePopupClose",
			data : {key : "chkbrowser"},
			success : function(result){
				
				$("#popup_div").empty();
				$(".modal_today_close").parents(".modal_popup").css("display","none");
				$("body").css("overflow", "");
				
			}
		});
		
	}); */
	

	
	//브라우저 체크
	var agent = navigator.userAgent.toLowerCase();
	var name = navigator.appName;
	var browser;
	var version;
	//MS
	if(name == 'Microsoft Internet Explorer' || agent.indexOf('trident') > -1 || agent.indexOf('edge/') > -1){
		
		browser = '인터넷 익스플로러';
		
		if(name == 'Microsoft Internet Explorer'){ //익스플로러 10버전 이하
			agent = /msie ([0-9]{1,}[\.0-9]{0,})/.exec(agent);
			version = parseInt(agent[1]);
		}else{
			if(agent.indexOf('trident') > -1){ // 11
				version = 11;
			}else if(agent.indexOf('edge/') > -1){	// Edge
				version = 'edge';
			}
		}
		
	}else if(agent.indexOf('safari') > -1) { // Chrome or Safari
		
        if(agent.indexOf('opr') > -1) { // Opera
            browser = '오페라';
        } else if(agent.indexOf('chrome') > -1) { // Chrome
            browser = '크롬';
        } else { // Safari
            browser = '사파리';
        }
    } else if(agent.indexOf('firefox') > -1) { // Firefox
        browser = '파이어폭스';
    }
	
	$("#bro_gubn").text(browser+" 브라우저");
	
	if("${param.chk}" == 'Y'){
		$("#bro_version").text(version);	
	}
})
</script>
<!-- fixed -->
<div class="layer layer-fixed layer-tr layer-carcompare">
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
							
							<!-- 광고형 팝업 (최상단모달레이어에 더블클래스 추가) -->
							<div>
								<div class="adpopup_img">
									<%-- <div style=" width:603px; height:502px; background:url(${context}/resources/img/bg/browser_bg.jpg) ; position:relative;">
									   <div style="position:absolute; margin:237px 0 0 40px; font-size:13px; line-height:200%; width: 525px; height: 125px;">
									     	한국연구재단 홈페이지를 방문해 주셔서 감사합니다. <br />
									     	귀하께서 사용하시는 익스플로러 버전 정보는 <span style="font-size:17px; font-weight:bold; color:#FF3300;">${param.v} </span>이며, <br />
									     	원활한 홈페이지 이용을 위해서는 익스플로러 11버전 이상이나 <br />
									     	Chrome 브라우저를 이용해 주시기 바랍니다.
									   </div>
									   <div style="position:absolute; margin:380px 0 0 35px; float:left; text-align:center; width: 525px; height: 87px;">
									      	<p>
										       	<a href="https://support.microsoft.com/ko-kr/help/17621/internet-explorer-downloads" target="_blank">
										       		<img src="${context}/resources/img/icon/but_01.png">
										       	</a>&nbsp;&nbsp;&nbsp;
										       	<a href="https://www.google.com/chrome/browser/desktop/index.html " target="_blank">
										       		<img src="${context}/resources/img/icon/but_02.png" >
										       	</a>
									   		</p>
									   </div>  
									</div> --%>
									<div style="width: 603px; height: 502px; background: url(/resources/img/other/bg.jpg); position: relative;">
										<div style="position: absolute; margin: 242px 0 0 40px; font-size: 14px; line-height: 240%; text-align: center; width: 525px; height: 125px;">
											귀하께서 사용하시는 브라우저 종류는 <br /> 
											<c:choose>
												<c:when test="${param.chk eq 'Y'}">
													<span id="bro_gubn" style="margin: 0 4px; display: inline-block; padding: 0 5px; background: #f05000; font-size: 16px; font-weight: bold; color: #fff; letter-spacing: -1px;"></span>이며, 버전 정보는 
													<span id="bro_version" style="margin: 0 4px; display: inline-block; padding: 0 5px; background: #f05000; font-size: 16px; letter-spacing: -1px; font-weight: bold; color: #fff;"></span>입니다.
												</c:when>
												<c:otherwise>
													<span id="bro_gubn" style="margin: 0 4px; display: inline-block; padding: 0 5px; background: #f05000; font-size: 16px; font-weight: bold; color: #fff; letter-spacing: -1px;"></span>입니다.
												</c:otherwise>
											</c:choose>
											<br /> 원활한 홈페이지 이용을 위해서는 익스플로러 11버전 이상이나 Chrome 브라우저를 이용해 주시기 바랍니다.
										</div>
										<div style="position: absolute; margin: 400px 0 0 35px; float: left; text-align: center; width: 525px;">
											<p>
												<a href="https://support.microsoft.com/ko-kr/help/17621/internet-explorer-downloads" target="_blank">
													<img src="/resources/img/other/but_01.png">
												</a>&nbsp;&nbsp;&nbsp;
												<a href="https://www.google.com/chrome/browser/desktop/index.html" target="_blank">
													<img src="/resources/img/other/but_02.png">
												</a>
											</p>
										</div>
									</div>
								</div>										
							</div>
							<!-- //광고형 팝업 -->

						</div>
	                	<!-- //팝업 실 컨텐츠 -->
	                </div>
	                <!-- //팝업 컨텐츠 -->
	                
	                <!-- 팝업닫기 -->
	                <a href="javascript:;" id="closeCompare" title="닫기" class="layer-close"><img src="/resources/img/icon/layer-close.png" alt="레이어 닫기"></a>
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