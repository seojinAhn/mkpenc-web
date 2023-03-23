<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/resources/inc/config.jsp"%>
<%@ taglib uri="http://onmakers.com/function" prefix="fnc" %>

<script type="text/javascript">
$(document).ready(function(){
	
	//비교차량 등록 수 카운팅 표시
	$('.compare_count').text("("+ count_compare("car_no_") + "/4)");
	
	//팝업 닫기
	$("#closeCompare").on("click",function(e){
		e.preventDefault();
		$("#popup_div").empty();
		$("#popup_div").css("display", "none");
		$("body").css("overflow", "");
	});
	
});
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
	                		<!-- 차량비교 -->
	                		<div class="comparelist">
	                			
	                			<div class="comparelist-title">
	                                <strong>차량비교 <b class="compare_count"></b></strong>
	                                <p>카바타의 차량 비교는 <b>최대4개의 차량 비교</b>가 가능합니다.</p>
	                            </div>
	                            
	                            <div class="comparelist-contents">
	                            	
	                            	<div class="cc-subject">
										<ul>
											<li><div><div>튜닝 갤러리</div></div></li>
										</ul>
										<ul>
											<li><div><div>타이틀</div></div></li>
											<li><div><div>제조사</div></div></li>
											<li><div><div>차종</div></div></li>
										</ul>
										<ul>
											<li><div><div>제동성능</div></div></li>
											<li><div><div>연비</div></div></li>
											<li><div><div>제로백</div></div></li>
											<li><div><div>롤 안정성</div></div></li>
											<li><div><div>미끄럼 안정성</div></div></li>
										</ul>
	                            	</div>

	                            	<c:forEach var="item" items="${data}" varStatus="i">
										<c:set var="fuelef" value="${fn:split(item.fuelefRslt, '|')}"/>
		                            	<div class="cc-item" id="compare_${item.carChk}">
		                            		<ul>
	                                            <li>
	                                                <div class="cci-thumbnail">
														<c:choose>
															<c:when test="${!empty item.imgeFilePath && !empty item.saveImgeNm}">
																<img src="/file/tuning_image?path=${item.imgeFilePath}&amp;name=${item.saveImgeNm}" alt="" />
															</c:when>
															<c:otherwise>
																<img src="/resources/img/sample/sample_rambor.jpg" alt="">
															</c:otherwise>
														</c:choose>
	                                                </div>
	                                            </li>
	                                        </ul>
	                                        <ul>
	                                            <li title="타이틀"><div><div>${item.title}</div></div></li>
	                                            <li title="제조사"><div><div>${item.mdcorpNm}</div></div></li>
	                                            <li title="차량명"><div><div>${item.carNm}</div></div></li>
	                                        </ul>
	                                        <ul>
	                                            <li title="제동성능"><div><div>
													<c:choose>
														<c:when test="${!empty item.brakeRslt}">
															<fmt:formatNumber value="${fnc:emptyCheckReplaceStr(item.brakeRslt / 1000, '0')}" pattern="0.000"/>
														</c:when>
														<c:otherwise>
															-
														</c:otherwise>
													</c:choose>
												</div></div></li>
	                                            <li title="연비"><div><div>
													<c:choose>
														<c:when test="${!empty item.fuelefRslt}">
															<fmt:formatNumber value="${fnc:emptyCheckReplaceStr(fuelef[0], '0')}" pattern="0.000"/>
														</c:when>
														<c:otherwise>
															-
														</c:otherwise>
													</c:choose>
												</div></div></li>
	                                            <li title="제로백"><div><div>
													<c:choose>
														<c:when test="${!empty item.zerobkRslt}">
															<fmt:formatNumber value="${fnc:emptyCheckReplaceStr(item.zerobkRslt, '0')}" pattern="0.000"/>
														</c:when>
														<c:otherwise>
															-
														</c:otherwise>
													</c:choose>
												</div></div></li>
	                                            <li title="롤 안정성"><div><div>
													<c:choose>
														<c:when test="${!empty item.rollSftRslt}">
															<fmt:formatNumber value="${fnc:emptyCheckReplaceStr(item.rollSftRslt, '0')}" pattern="0.000"/>
														</c:when>
														<c:otherwise>
															-
														</c:otherwise>
													</c:choose>
												</div></div></li>
	                                            <li title="미끄럼 안정성"><div><div>
													<c:choose>
														<c:when test="${!empty item.slideSftRslt}">
															<fmt:formatNumber value="${fnc:emptyCheckReplaceStr(item.slideSftRslt, '0')}" pattern="0.000"/>
														</c:when>
														<c:otherwise>
															-
														</c:otherwise>
													</c:choose>
												</div></div></li>
	                                        </ul>
	                                        <a href="javascript:;" class="comparelist-close" onclick="javascript:compare_del('car','${item.carChk}');" title="비교대상에서 삭제">
	                                        	<img src="/resources/img/icon/comparelist-close.png" alt="">
	                                        </a>
		                            	</div>
	                            	</c:forEach>
	                            	
	                            </div>
	                            
	                		</div>
	                		<!-- //차량비교 -->
	                	</div>
	                	<!-- //팝업 실 컨텐츠 -->
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