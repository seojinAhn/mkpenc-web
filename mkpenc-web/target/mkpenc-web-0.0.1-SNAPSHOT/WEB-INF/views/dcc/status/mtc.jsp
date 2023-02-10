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
<script type="text/javascript" src="<c:url value="/resources/js/status.js" />" charset="utf-8"></script>

</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-dcc-header.jspf" %>
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>MTC</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>MTC</strong></div>
			</div>
			<!-- //page_title -->
            <!-- fx_layout -->
            <div class="fx_layout"> 
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_1');">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                    
                <div class="fx_block">        
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <div class="form_head">
                            <h4>MODERATOR TEMP CONTROL STATUS</h4>
                        </div>                            
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>MODERATOR SETPOINTL</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">69.00</label>
                                        <label class="full">℃</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MODERATOR OUTLET TEMP</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">69.00</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HX1 TCV 8</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">69.00</label>
                                        <label class="full">% OPEN</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HX1 TCV 6</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">69.00</label>
                                        <label class="full">% OPEN</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>VALVE TCV 61,62</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">69.00</label>
                                        <label class="full">% OPEN</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>INTEGRAL LIFT</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.043</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HX1 OUTLET TEMP</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">69.00</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>HX2 OUTLET TEMP</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">69.00</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MOD LEVEL LOW SETPOINT</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">750</label>
                                        <label class="full">MM</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>MODERATOR PRESENT LEVEL</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">7841.0</label>
                                        <label class="full">MM</label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                    </div>
                    <!-- //form_wrap -->
                </div>
                <div class="fx_block">        
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <div class="form_head">
                            <h4>PHT PURIFICATION TEMP CONTROL</h4>
                        </div>                            
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>PURIF COOLER OUT SETPOINT</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">50.00</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>PURIF COOLER OUT TEMP</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">50.00</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>PURIF COOLER FLOW</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">22.934</label>
                                        <label class="full">KG/S</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>PURIF INTEGRAL LIFT</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">0.2456</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>VALVE HCV-5 CLOSED IF TEMP</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">85</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>VALVE TCV-44</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">28.68</label>
                                        <label class="full">% OPEN</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>RCW TEMP</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">24.80</label>
                                        <label class="full">DEGC</label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                    </div>
                    <!-- //form_wrap -->
                </div>
            </div>
            <!-- fx_layout -->
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
	    <h3>엑셀로 저장</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">

        <!-- fx_layout -->
        <div class="fx_layout"> 
            <div class="fx_block">        
                <!-- form_wrap -->
                <div class="form_wrap">
                    <div class="form_head">
                        <h4>저장일자</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col width="120px"/>
                            <col />
                        </colgroup>
                        <tr>
                            <th>시작 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>끝 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
                                </div>
                            </td>
                        </tr>
                    </table>
                    <!-- //form_table -->
                </div>
                <!-- //form_wrap -->
            </div>
            <div class="fx_block">        
                <!-- form_wrap -->
                <div class="form_wrap">
                    <div class="form_head">
                        <h4>주기</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">0.5초 데이타</label>
                                    <label><input type="radio" name="radio">5분 데이타</label>
                                    <label><input type="radio" name="radio">5초 데이타</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">1시간 데이타</label>
                                    <label><input type="radio" name="radio">1분 데이타</label>
                                    <label><input type="radio" name="radio">직접입력</label>
                                    <input type="text" class="tr fx_none" style="width:60px;">
                                    <label>초</label>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <!-- //form_table -->
                </div>
                <!-- //form_wrap -->
            </div>
        </div>
        <!-- //fx_layout -->    
        <!-- file_upload -->
        <div class="fx_form file_upload">
            <div class="fx_form">
                <input type="text" />
                <a href="#none" class="btn_list">파일선택</a>
            </div>
        </div>
        <!-- //file_upload -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

