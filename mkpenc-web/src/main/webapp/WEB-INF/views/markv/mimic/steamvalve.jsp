<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>월성 3,4 호기 원격감시시스템</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/style.css" />">
<script type="text/javascript" src="<c:url value="/resources/jquery/jquery-1.10.0.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/modal.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/common.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/login.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/mimic.js" />" charset="utf-8"></script>
</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-markv-header.jspf" %>
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>STEAM VALVE STATUS</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>STEAM VALVE STATUS</strong></div>
			</div>
			<!-- //page_title -->


            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block">
                    <div class="chart_line_table line">
                        <div class="img_wrap steam_valve_status">
                            <div class="chart_block_s only_box" style="top:84px;left:74px;">
                            	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                            </div>
                            <div class="chart_block_s only_box" style="top:84px;left:170px;">
                            	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                            </div>
                            <div class="chart_block_s only_box" style="top:250px;left:166px;">
                            	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                            </div>
                            <div class="chart_block_s only_box" style="top:250px;left:244px;">
                            	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                            </div>
                        </div>
                    </div>                        
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h6>SPEED</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                    </label>
                                    <span>rpm</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>CV DEMAND</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                    </label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>IV DEMAND</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                    </label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>SPD/LD STAT</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                                    </label>
                                    <span></span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>MW LOAD</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                    </label>
                                    <span>MW</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>                
                <div class="fx_block">
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if>
                                                        </label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if>
                                                        </label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[21].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[21].fValue ne null}">${lblDataList[21].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[22].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[22].fValue ne null}">${lblDataList[22].fValue}</c:if>
                                                        </label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:450px;height:180px;">차트</div>
                                                <div class="summary" style="padding:0 20px;">
                                                    <p>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[23].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[23].fValue ne null}">${lblDataList[23].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[24].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[24].fValue ne null}">${lblDataList[24].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[25].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[25].fValue ne null}">${lblDataList[25].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[26].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[26].fValue ne null}">${lblDataList[26].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[27].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[27].fValue ne null}">${lblDataList[27].fValue}</c:if>
                                                        </label>
                                                        <label class="line">
                                                        	<c:if test="${lblDataList[28].fValue eq null}">0</c:if>
                                							<c:if test="${lblDataList[28].fValue ne null}">${lblDataList[28].fValue}</c:if>
                                                        </label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //fx_layout -->
                
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태그정보</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>태그번호</th>
                    <td>
                        <div class="fx_form">
                            <input type="text">
                            <a class="btn_list" herf="none" onclick="openLayer('modal_2');">태그찾기</a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>태그명</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>태그설명</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>표현방식</th>
                    <td>
                        <div class="fx_form_multi">
                            <div class="fx_form">
                                <label>
                                    <input type="radio" name="type">
                                    수치표현
                                </label>
                                <label>
                                    <input type="radio" name="type">
                                    문자표현
                                </label>
                                <label>
                                    <input type="radio" name="type">
                                    문자표현(A)
                                </label>
                                <a class="btn_list" herf="none" onclick="openLayer('modal_3');">문자(A) 표현관리</a>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>소수점 자리수</th>
                    <td>
                        <select class="fx_none" style="width:120px;">
                            <option>0000</option>
                        </select>                        
                    </td>
                </tr>
                <tr>
                    <th>0 상태 문자표현(0)</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>1 상태 문자표현(0)</th>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <th>문자표현(A)</th>
                    <td>
                        <div class="fx_form">
                            <select class="fx_none" style="width:260px;">
                                <option>0000</option>
                            </select>
                            <select>
                                <option>0000</option>
                            </select>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
        <a href="#none" class="btn_page">Command1</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태그목록</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        <!-- fx_srch_wrap -->
        <div class="fx_srch_wrap">	
            <div class="fx_srch_form">
                <div class="fx_srch_row">
                    <div class="fx_srch_item">
                        <label>검색옵션</label>
                        <div class="fx_form">
                            <label>
                                <input type="checkbox" name="type">
                                태그명
                            </label>
                            <label>
                                <input type="checkbox" name="type">
                                태그설명
                            </label>
                        </div>
                    </div>
                    <div class="fx_srch_item">
                        <label>검색어</label>
                        <input type="text">
                    </div>
                </div>
            </div>
            <!-- fx_srch_button -->
            <div class="fx_srch_button">
                <a class="btn_srch">Search</a>
            </div>
            <!-- //fx_srch_button -->
        </div>
        <!-- //fx_srch_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table_scroll -->
            <div class="list_table_scroll">                
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>title</th>
                            <th>title</th>
                            <th>title</th>
                            <th>title</th>
                            <th>title</th>
                            <th>title</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                        </tr>
                    </tbody>
                </table>
                <!-- //list_table -->
            </div>
                <!-- //list_table_scroll -->
        </div>
        <!-- //list_wrap -->        
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page">전체리스트</a>
        <a href="#none" class="btn_page primary">선택</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_3">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>Analog 문자표현 그룹관리</h3>
        <a onclick="closeLayer('modal_3');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        
        <!-- layout_table -->
        <table class="layout_table">
            <colgroup>
                <col />
                <col />
            </colgroup>
            <tbody>
                <tr>
                    <td>

                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <h4>그룹목록</h4>
                            </div>
                            <!-- //list_head --> 
                        </div>                
                        <!-- fx_srch_wrap -->
                        <div class="fx_srch_wrap b_type">	
                            <div class="fx_srch_form">
                                <div class="fx_srch_row">
                                    <div class="fx_srch_item">
                                        <label>그룹</label>
                                        <div class="fx_form">
                                            <input type="text" class="fx_none" style="width:50px;">
                                            <input type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //fx_srch_wrap -->                
                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <!-- button -->
                                <div class="button">
                                    <a class="btn_list primary" href="#none">추가</a>
                                    <a class="btn_list" href="#none">수정</a>
                                    <a class="btn_list" href="#none">삭제</a>
                                </div>
                                <!-- button -->
                            </div>
                            <!-- //list_head -->            
                            <!-- list_table_scroll -->
                            <div class="list_table_scroll">
                                <!-- list_table -->
                                <table class="list_table">
                                    <colgroup>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <!-- //list_table -->
                            </div>
                                <!-- //list_table_scroll -->
                        </div>
                        <!-- //list_wrap -->
                        
                    </td>
                    <td>

                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <h4>표현문자목록</h4>
                            </div>
                            <!-- //list_head --> 
                        </div>                
                        <!-- fx_srch_wrap -->
                        <div class="fx_srch_wrap b_type">	
                            <div class="fx_srch_form">
                                <div class="fx_srch_row">
                                    <div class="fx_srch_item">
                                        <label>표현문자</label>
                                        <div class="fx_form">
                                            <input type="text" class="fx_none" style="width:50px;">
                                            <input type="text">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //fx_srch_wrap -->                
                        <!-- list_wrap -->
                        <div class="list_wrap">
                            <!-- list_head -->
                            <div class="list_head">
                                <!-- button -->
                                <div class="button">
                                    <a class="btn_list primary" href="#none">추가</a>
                                    <a class="btn_list" href="#none">수정</a>
                                    <a class="btn_list" href="#none">삭제</a>
                                </div>
                                <!-- button -->
                            </div>
                            <!-- //list_head -->            
                            <!-- list_table_scroll -->
                            <div class="list_table_scroll">                
                                <!-- list_table -->
                                <table class="list_table">
                                    <colgroup>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                        <col width="160px"/>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                            <th>title</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                        <tr>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                            <td class="tc"></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <!-- //list_table -->
                            </div>
                                <!-- //list_table_scroll -->
                        </div>
                        <!-- //list_wrap -->
                        
                    </td>
                </tr>
            </tbody>
        </table>

	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">선택</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_3');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

