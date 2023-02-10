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
				<h3>SG LEVEL CONTROL STATUS</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>SG LEVEL CONTROL STATUS</strong></div>
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
                        <col width="260px" />
                        <col />
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>SG NO</th>
                            <th>1</th>
                            <th>2</th>
                            <th>3</th>
                            <th>4</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>LEVEL (M)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>SETPOINT (M)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>ERROR (M)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>STEAM (PERU)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>COMP. LIFT (%)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>INT. LIFT (%)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>MAS BLNCE (FS)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>SMALL VLV (%)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>LARGE VLV (%)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>STEPBK MARG (M)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>SG LCV TRAIN</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>SG LEVEL HI</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>FD LINE BREAK</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                        <tr>
                            <th>SG PR (MARG)</th>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                            <td class="tr">2.369</td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
                <!-- form_table -->
                <table class="form_table mt_none">
                    <colgroup>
                        <col width="260px" />
                        <col width="60px" />
                        <col />
                        <col width="60px" />
                        <col />
                        <col width="60px" />
                        <col />
                    </colgroup>
                    <tr>
                        <th>RECR. FL (KG/S)</th>
                        <th class="tc">P1</th>
                        <td class="tr">0.00</td>
                        <th class="tc">P2</th>
                        <td class="tr">0.00</td>
                        <th class="tc">P3</th>
                        <td class="tr">0.00</td>
                    </tr>
                    <tr>
                        <th>DISCH. FL (KG/S)</th>
                        <th class="tc">P1</th>
                        <td class="tr">0.00</td>
                        <th class="tc">P2</th>
                        <td class="tr">0.00</td>
                        <th class="tc">P3</th>
                        <td class="tr">0.00</td>
                    </tr>
                </table>
                <!-- //form_table --> 
            </div>
            <!-- //form_wrap -->
            <div class="fx_form full flex_end">
                <label class="title">REACTOR POWER</label>
                <label class="flex_end">0.87000</label>
                <label>FP</label>
            </div>
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

