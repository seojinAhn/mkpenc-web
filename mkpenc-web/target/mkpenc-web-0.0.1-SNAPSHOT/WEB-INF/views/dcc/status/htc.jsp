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
				<h3>HEAT TRANSPORT CONTROL STATUS</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>HEAT TRANSPORT CONTROL STATUS</strong></div>
			</div>
			<!-- //page_title -->
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_1');">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>PRESSURIZER</th>
                            <th>LEVEL</th>
                            <th>PRESSURE</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>SETPOINT</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">8.679</label>
                                    <label class="full">METER</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">8.679</label>
                                    <label class="full">METER</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>PRESENT VALUE</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">-8.679</label>
                                    <label class="full">METER</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">8.679</label>
                                    <label class="full">METER</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>DEVIATION</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">8.679</label>
                                    <label class="full">METER</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">-8.679</label>
                                    <label class="full">METER</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>SETPOINT MODE</th>
                            <td class="tc">AUTO</td>
                            <td class="tc">AUTO</td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
                <!-- fx_srch_wrap -->
                <div class="fx_srch_wrap dp_style">	
                    <div class="fx_srch_form">
                        <div class="fx_srch_row">
                            <div class="fx_srch_item double">
                                <label class="full title">PHP PUMP STATUS</label>
                            </div>
                            <div class="fx_srch_item">
                                <label class="full title">LOOP FLOW</label>
                            </div>
                        </div>
                        <div class="fx_srch_row">
                            <div class="fx_srch_item no_label">
                                <div class="fx_form">
                                    <label class="title">P1</label>
                                    <label>ON</label>
                                </div>
                            </div>
                            <div class="fx_srch_item">
                                <div class="fx_form">
                                    <label class="title">P2</label>
                                    <label>ON</label>
                                </div>
                            </div>
                            <div class="fx_srch_item">
                                <label class="full">2144.8 KG/S</label>
                            </div>
                        </div>
                        <div class="fx_srch_row">
                            <div class="fx_srch_item no_label">
                                <div class="fx_form">
                                    <label class="title">P1</label>
                                    <label>ON</label>
                                </div>
                            </div>
                            <div class="fx_srch_item">
                                <div class="fx_form">
                                    <label class="title">P2</label>
                                    <label>ON</label>
                                </div>
                            </div>
                            <div class="fx_srch_item">
                                <label class="full">2144.8 KG/S</label>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //fx_srch_wrap -->          
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>VALVE POSITION</th>
                            <th>NO 1</th>
                            <th>NO 2</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>FEED VALVE</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">33.53</label>
                                    <label class="full">%</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">33.06</label>
                                    <label class="full">%</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>BLEED VALVE</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">0.06</label>
                                    <label class="full">%</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">0.09</label>
                                    <label class="full">%</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>STEAM BLEED</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">0.09</label>
                                    <label class="full">%</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">0.06</label>
                                    <label class="full">%</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>STEAM BLEED</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">99.94</label>
                                    <label class="full">%</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">99.97</label>
                                    <label class="full">%</label>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
                <!-- fx_srch_wrap -->
                <div class="fx_srch_wrap dp_style">	
                    <div class="fx_srch_form">
                        <div class="fx_srch_row">
                            <div class="fx_srch_item no_label">
                                <div class="fx_form">
                                    <label class="full title">STEAM QUALTY (%)</label>
                                </div>
                            </div>
                            <div class="fx_srch_item triple">
                                <div class="fx_form">
                                    <label class="full">0.000 %</label>
                                    <label class="full">0.000 %</label>
                                    <label class="full">0.000 %</label>
                                    <label class="full">0.000 %</label>
                                </div>
                            </div>
                        </div>
                        <div class="fx_srch_row">
                            <div class="fx_srch_item no_label">
                                <div class="fx_form">
                                    <label class="full title">SUB-COOLING MARGIN (DEG C)</label>
                                </div>
                            </div>
                            <div class="fx_srch_item triple">
                                <div class="fx_form">
                                    <label class="full">52.94 DEG C</label>
                                    <label class="full">52.94 DEG C</label>
                                    <label class="full">52.94 DEG C</label>
                                    <label class="full">52.94 DEG C</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //fx_srch_wrap -->          
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <tr>
                        <th>HEATER</th>
                        <td class="tc">
                            <div class="fx_form">
                                <label class="full title">VARIABLE</label>
                                <label class="full flex_end">53.47</label>
                                <label class="full">%</label>
                            </div>
                        </td>
                        <td class="tc">
                            <div class="fx_form">
                                <label class="full title">ON/OFF</label>
                                <label class="full flex_end">OFF</label>
                                <label class="full"></label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>PZR TEMP</th>
                        <td class="tc">
                            <div class="fx_form">
                                <label class="full title">LIQUID</label>
                                <label class="full flex_end">307.75</label>
                                <label class="full">DEG C</label>
                            </div>
                        </td>
                        <td class="tc">
                            <div class="fx_form">
                                <label class="full title">VAPOUR</label>
                                <label class="full flex_end">308.56</label>
                                <label class="full">DEG C</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>D/C</th>
                        <td class="tc">
                            <div class="fx_form">
                                <label class="full title">LEVEL</label>
                                <label class="full flex_end">1,212</label>
                                <label class="full">METER</label>
                            </div>
                        </td>
                        <td class="tc">
                            <div class="fx_form">
                                <label class="full title">PRESSURE</label>
                                <label class="full flex_end">1.068</label>
                                <label class="full">MPAG</label>
                            </div>
                        </td>
                    </tr>
                </table>
                <!-- //form_table -->                
            </div>
            <!-- //form_wrap -->
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

