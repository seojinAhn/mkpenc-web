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
				<h3>REACTIVITY CONTROL DIAGRAM</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>REACTIVITY CONTROL DIAGRAM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap reactivity_control_diagram">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_2');">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                    
                <div class="img_mask"></div>
                <!-- 데이터 표시영역 start : 가로(780px) X 세로(410px) -->
                <div class="data_area" style="top:124px;left:276px;">
                    <span class="lblxy zero" style="top:140px;left:100px;">★</span>
                    <span class="lblxy a" style="top:140px;left:120px;">A</span>
                    <span class="lblxy b" style="top:140px;left:140px;">B</span>
                    <span class="lblxy c" style="top:140px;left:160px;">C</span>
                    <span class="lblxy d" style="top:140px;left:180px;">D</span>
                    <span class="lblxy e" style="top:140px;left:200px;">E</span>
                    <span class="lblxy f" style="top:140px;left:220px;">F</span>
                    <span class="lblxy g" style="top:140px;left:240px;">G</span>
                    <span class="lblxy h" style="top:140px;left:260px;">H</span>
                    <span class="lblxy i" style="top:160px;left:120px;">I</span>
                    <span class="lblxy j" style="top:160px;left:140px;">J</span>
                    <span class="lblxy k" style="top:160px;left:160px;">K</span>
                    <span class="lblxy l" style="top:160px;left:180px;">L</span>
                    <span class="lblxy m" style="top:160px;left:200px;">M</span>
                    <span class="lblxy n" style="top:160px;left:220px;">N</span>
                    <span class="lblxy o" style="top:160px;left:240px;">O</span>
                    <span class="lblxy p" style="top:180px;left:120px;">P</span>
                    <span class="lblxy q" style="top:180px;left:140px;">Q</span>
                    <span class="lblxy r" style="top:180px;left:160px;">R</span>
                    <span class="lblxy s" style="top:180px;left:180px;">S</span>
                    <span class="lblxy t" style="top:180px;left:200px;">T</span>
                    <span class="lblxy u" style="top:180px;left:220px;">U</span>
                    <span class="lblxy v" style="top:180px;left:240px;">V</span>
                    <span class="lblxy w" style="top:180px;left:260px;">W</span>
                    <span class="lblxy x" style="top:180px;left:280px;">X</span>
                    <span class="lblxy y" style="top:180px;left:300px;">Y</span>
                    <span class="lblxy z" style="top:180px;left:320px;">Z</span>
                </div>
                <!-- //데이터 표시영역 end -->
            </div>

		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->
<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>엑셀로 저장</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
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
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

