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
				<h3>GEN SYNCHRONIZA</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>GEN SYNCHRONIZA</strong></div>
			</div>
			<!-- //page_title -->

            <div class="gen_list">
                <h4>AUTO PERMISSIVES</h4>
                <ul>
                    <li>GENERATOR BKR SELECTED</li>
                    <li>SYNCH LOCKOUT (L86S)</li>
                    <li>BUS VOLTAGE</li>
                    <li>BUS FREQUENCY</li>
                    <li>GENERATOR VOLTAGE</li>
                    <li>GENERATOR FREQUENCY</li>
                    <li>DIFFERENCE VOLTS</li>
                    <li>DIFFERENCE FREQUENCY</li>
                    <li>SEQUENCING SYNC PERMIT</li>
                    <li>AUTO SYNC PERMIT</li>
                </ul>
            </div>
            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>METERING</h4>
                        <div class="line_table_block">
                            <h6>PHASE ANGEL</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if>
                                    </label>
                                    <span>deg C</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>DIFFERENCE VOLTS</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if>
                                    </label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>SLIP FREQUENCY</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if>
                                    </label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h5 class="double"></h5>
                            <h5>SURF TEMP</h5>
                            <h5>BORE TEMP RATE</h5>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">PRIMARY VOLTS(KV)</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if>
                                    </label>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if>
                                    </label>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">% RATED VOLTS</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if>
                                    </label>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if>
                                    </label>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">FREQUENCY(Hz)</h6>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if>
                                    </label>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>
                                    	<c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if>
                                    </label>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h5 class="double">GENERATOR</h5>
                            <h5>BREAKER</h5>
                        </div>
                        <div class="line_table_block">
                            <div class="block_row double">
                                <div class="block_item_row">
                                    <h6>WAT TS</h6>
                                    <div class="summary">
                                        <p>
                                            <label>
                                            	<c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                				<c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if>
                                            </label>
                                            <span>%</span>
                                        </p>
                                    </div>
                                </div>
                                <div class="block_item_row">
                                    <h6>WAT TS</h6>
                                    <div class="summary">
                                        <p>
                                            <label>
                                            	<c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                				<c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if>
                                            </label>
                                            <span>%</span>
                                        </p>
                                    </div>
                                </div>
                                <div class="block_item_row">
                                    <h6>WAT TS</h6>
                                    <div class="summary">
                                        <p>
                                            <label>
                                            	<c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                				<c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if>
                                            </label>
                                            <span>%</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="summary full">
                                <p>
                                    <img src="../images/background/bkr.svg" style="width:100px;height:60px;">
                                    <label>0</label>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block center">
                    <div class="chart_line_table row">
                        <div class="line_table_block">
                            <h5>SYNCH MODE</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="synch_off" name="switch_synch" value="" checked/>
                                    <label class="full" for="synch_off">OFF</label>
                                    <input type="radio" id="synch_manual" name="switch_synch" value="" />
                                    <label class="full" for="synch_manual">MANUAL</label>
                                    <input type="radio" id="synch_moniter" name="switch_synch" value="" />
                                    <label class="full" for="synch_moniter">MONITER</label>
                                    <input type="radio" id="synch_auto" name="switch_synch" value="" />
                                    <label class="full" for="synch_auto">AUTO</label>
                                </div>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h5>MANUAL MODE</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="manual_raise_spd" name="switch_manual" value="" checked/>
                                    <label class="full" for="manual_raise_spd">RAISE SPD/LD</label>
                                    <input type="radio" id="manual_lower_spd" name="switch_manual" value="" />
                                    <label class="full" for="manual_lower_spd">LOWER SPD/LD</label>
                                    <input type="radio" id="manual_raise_kv" name="switch_manual" value=""/>
                                    <label class="full" for="manual_raise_kv">RAISE KV/VAR</label>
                                    <input type="radio" id="manual_lower_kv" name="switch_manual" value="" />
                                    <label class="full" for="manual_lower_kv">LOWER KV/VAR</label>
                                </div>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h5>VOLT MATCH</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="volt_main" name="switch_volt" value="" checked/>
                                    <label class="full" for="volt_main">MAIN</label>
                                    <input type="radio" id="volt_auto" name="switch_volt" value="" />
                                    <label class="full" for="volt_auto">AUTO</label>
                                </div>
                            </div>
                            <h5>REMOTE</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="checkbox" id="remote" name="switch_remote" value="" checked/>
                                    <label class="full" for="remote">REMOTE</label>
                                </div>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h5>SPEED MATCH</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="speed_manual" name="switch_speed" value="" checked/>
                                    <label class="full" for="speed_manual">MANUAL</label>
                                    <input type="radio" id="speed_auto" name="switch_speed" value="" />
                                    <label class="full" for="speed_auto">AUTO</label>
                                    <input type="radio" id="speed_slip" name="switch_speed" value="" />
                                    <label class="full" for="speed_slip">SLIP</label>
                                </div>
                                <div class="summary">
                                    <p>
                                        <label>
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

