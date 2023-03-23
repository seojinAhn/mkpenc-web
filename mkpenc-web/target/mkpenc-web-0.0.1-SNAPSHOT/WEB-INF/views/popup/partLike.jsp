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
	});
	
});
</script>

<!-- fixed -->
<div class="layer layer-fixed layer-tr layer-like">
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
	                		<!-- 좋아요리스트 -->
							<div class="likelist">
							
								<!-- title -->
								<div class="likelist-title">
                                    <strong>좋아요 목록<b>(${cnt})</b></strong>
                                    <p>현재 부품에 대해 <b>관심을 갖고 있는 사람들</b>입니다.</p>
                                </div>
                                <!-- //title -->
                                
								<!-- list -->
								<div class="likelist-list">
									<ul>
										<c:forEach var="list" items="${data}">
											<li>
												<div>
													<div class="lll-img">
														<c:choose>
															<c:when test="${!empty list.imgeFilePath && !empty list.imgeSaveFileNm}">
                                                                <img src="/file/fileDown?subPath=${list.imgeFilePath}&fileSaveName=${list.imgeSaveFileNm}&fileGubn=member" alt="" />
															</c:when>
															<c:otherwise>
																<img src="" alt="" />
															</c:otherwise>
														</c:choose>
													</div>
													<strong>${list.nicknm}</strong>
													<span>${list.likeDtm}</span>
												</div>
											</li>
										</c:forEach>
									</ul>
								</div>
								<!-- //list -->
								                                
							</div>
							<!-- //좋아요리스트 -->
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