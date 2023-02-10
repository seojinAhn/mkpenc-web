<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://onmakers.com/function" prefix="fnc" %>

<script type="text/javascript">
$(document).ready(function(){
	
	//비교차량 등록 수 카운팅 표시
	$('.compare_count').text("("+ count_compare("partSeq_") + "/4)");
	
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
<div class="layer layer-fixed layer-tr layer-componentcompare">
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
	                		<!-- 부품비교 -->
	                		<div class="comparelist">

	                			<div class="comparelist-title">
	                                <strong>부품비교 <b class="compare_count"></b></strong>
	                                <p>카바타의 부품 비교는 <b>최대4개의 부품 비교</b>가 가능합니다.</p>
	                            </div>

	                            <div class="comparelist-contents">

	                            	<div class="cc-subject">
										<ul>
											<li><div><div>부품 이미지</div></div></li>
										</ul>
										<ul>
											<li><div><div>부품명</div></div></li>
											<li><div><div>전후륜 구분</div></div></li>
											<li><div><div>제조사</div></div></li>
											<li><div><div>무게(kg)</div></div></li>
											<li><div><div>적용 차종</div></div></li>
										</ul>

										<c:if test="${!empty data[0].partAddColumnList}">
										<ul>
											<c:forEach var="item" items="${data[0].partAddColumnList}">
												<li><div><div>${item}</div></div></li>
											</c:forEach>
										</ul>
										</c:if>
	                            	</div>

	                            	<c:forEach var="item" items="${data}" varStatus="i">
		                            	<div class="cc-item" id="compare_${i.index+1}">
		                            		<ul>
	                                            <li>
	                                                <div class="cci-thumbnail">
														<c:choose>
															<c:when test="${!empty item.imgeLink }">
                                                                <img src="${list.imgeLink}" alt="" />
															</c:when>
															<c:when test="${empty item.imgeLink && !empty item.imgeFilePath && !empty item.saveImgeNm}">
																<img src="/file/imageDown?fileGubn=partImg&subPath=${item.imgeFilePath}&amp;fileSaveName=${item.saveImgeNm}" alt="" />
															</c:when>
														</c:choose>
	                                                </div>
	                                            </li>
	                                        </ul>
	                                        <ul>
	                                            <li title="부품명"><div><div>${item.prdtNm}</div></div></li>
	                                            <li title="전후륜 구분">
	                                            	<div>
	                                            		<div>
	                                            			<c:choose>
	                                            				<c:when test="${item.divn1 eq '57' or (!empty item.divn2 and item.divn2 eq '57')}">
	                                            					전륜
	                                            				</c:when>
	                                            				<c:when test="${item.divn1 eq '58' or (!empty item.divn2 and item.divn2 eq '58')}">
	                                            					후륜
	                                            				</c:when>
	                                            				<c:otherwise>
	                                            					-
	                                            				</c:otherwise>
	                                            			</c:choose>
	                                            		</div>
	                                            	</div>
	                                            </li>
	                                            <li title="제조사"><div><div>${item.mdcorpNm}</div></div></li>
                                                <li title="무게(kg)"><div><div>${item.weight}</div></div></li>
                                                <li title="적용 차종"><div><div>
													<c:forEach var="item1" items="${item.carList}" varStatus="i2">
														<c:if test="i2.index > 0 ">
															,
														</c:if>
														${item1.carNm}
													</c:forEach>
														${item1.asscar}
												</div></div></li>
	                                        </ul>
											<c:if test="${!empty item.partAddColumnList}">
											<ul>
												<c:choose>
													<c:when test="${item.catgrSeq eq '1' or item.catgrSeq eq '3'}">
														<li><div><div>${item.sspsSprng.freeLen}</div></div></li>
														<li><div><div>${item.sspsSprng.diam}</div></div></li>
													</c:when>
													<c:when test="${item.catgrSeq eq '5' or item.catgrSeq eq '7'}">
														<li><div><div>${item.sspsDmpr.dmprType}</div></div></li>
														<li><div><div>${item.sspsDmpr.dampingforceCon}</div></div></li>
													</c:when>
													<c:when test="${item.catgrSeq eq '9' or item.catgrSeq eq '10'}">
														<li><div><div>${item.sspsStblizer.sectionType}</div></div></li>
														<li><div><div>${item.sspsStblizer.sectionDiam}</div></div></li>
													</c:when>
													<c:when test="${item.catgrSeq eq '11' or item.catgrSeq eq '13'}">
														<li><div><div>${item.sspsSpace.thickness}</div></div></li>
														<li><div><div>${item.sspsSpace.pcd}</div></div></li>
													</c:when>
													<c:when test="${item.catgrSeq eq '23' or item.catgrSeq eq '25'}">
														<li><div><div>${item.brakeDsk.diam}</div></div></li>
														<li><div><div>${item.brakeDsk.pcd}</div></div></li>
													</c:when>
													<c:when test="${item.catgrSeq eq '15' or item.catgrSeq eq '17'}">
														<li><div><div>${item.brakeClpr.clprType}</div></div></li>
														<li><div><div>${item.brakeClpr.pistonCnt}</div></div></li>
													</c:when>
													<c:when test="${item.catgrSeq eq '19' or item.catgrSeq eq '21'}">
														<li><div><div>${item.brakePad.slot}</div></div></li>
														<li><div><div>${item.brakePad.thickness}</div></div></li>
													</c:when>
													<c:when test="${item.catgrSeq eq '27' or item.catgrSeq eq '29'}">
														<li><div><div>${item.driveWheel.inch}</div></div></li>
														<li><div><div>${item.driveWheel.offset}</div></div></li>
													</c:when>
													<c:when test="${item.catgrSeq eq '31' or item.catgrSeq eq '33'}">
														<li><div><div>${item.driveTire.spec}</div></div></li>
														<li><div><div>${item.driveTire.enrgEfficiencyDgre}</div></div></li>
													</c:when>
												</c:choose>
											</ul>
											</c:if>
	                                        <a href="javascript:;" class="comparelist-close" onclick="javascript:compare_del('part','${i.index+1}');" title="비교대상에서 삭제">
	                                        	<img src="/resources/img/icon/comparelist-close.png" alt="">
	                                        </a>
		                            	</div>
	                            	</c:forEach>

	                            </div>

	                		</div>
	                		<!-- //부품비교 -->
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