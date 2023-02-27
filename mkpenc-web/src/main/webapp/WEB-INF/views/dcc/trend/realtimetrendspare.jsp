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
<script type="text/javascript" src="<c:url value="/resources/js/trend.js" />" charset="utf-8"></script>

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
				<h3>REALTIME TRAND</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>REALTIME TRAND</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
                            <label>구분</label>
                            <div class="fx_form">
							    <label>
                                    <input type="radio" name="type">
                                    실시간
                                </label>
							    <label>
                                    <input type="radio" name="type">
                                    과거검색
                                </label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>주기</label>
                            <select class="fx_none" style="width:90px;">
                                <option>5초</option>
                            </select>
						</div>
						<div class="fx_srch_item"></div>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap b_type">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item no_label">
                            <div class="fx_form">
                                <select>
                                    <option>3-000 CALANDRIA OUTLET TEMPERATURE</option>
                                </select>
                                <a href="#none" class="btn_list">새창으로</a>
                                <a href="#none" class="btn_list">Range 저장</a>
                                <label>
                                    <input type="checkbox">
                                    십자선
                                </label>
                            </div>
						</div>
						<div class="fx_srch_item fx_end">
                            <a href="#none" class="btn_list">그룹관리</a>
                        </div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_1"><!-- color : #801517 -->
                                <input type="checkbox" checked>
                                <span>3X MOD. TEMP</span>
                                <span>68.74</span>
                                <span>DEG C</span>
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_2"><!-- color : #B9529F -->
                                <input type="checkbox" checked>
                                <span>3X MOD. TEMP</span>
                                <span>68.74</span>
                                <span>DEG C</span>
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_3"><!-- color : #1EBCBE -->
                                <input type="checkbox" checked>
                                <span>3X MOD. TEMP</span>
                                <span>68.74</span>
                                <span>DEG C</span>
                            </div>
						</div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_4"><!-- color : #282A73 -->
                                <input type="checkbox" checked>
                                <span>3X MOD. TEMP</span>
                                <span>68.74</span>
                                <span>DEG C</span>
                            </div>
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_5"><!-- color : #ED1E24 -->
                            </div>
                        </div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_6"><!-- color : #7A57A4 -->
                            </div>
                        </div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_7"><!-- color : #70CBD1 -->
                            </div>
                        </div>
						<div class="fx_srch_item line">
                            <div class="fx_form chart_sum color_8"><!-- color : #364CA0 -->
                            </div>
                        </div>
					</div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->         
			<!-- chart_wrap_area -->
			<div class="chart_wrap_area">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_1');">변수설정</a></li>
                        <li><a href="#none" onclick="openLayer('modal_2');">엑셀로 저장</a></li>
                    </ul>
                    <ul>
                        <li class="check active"><a href="#none">X축 격자</a></li>
                        <li class="check active"><a href="#none">Y축 격자</a></li>
                        <li class="check"><a href="#none">선 굵게</a></li>
                    </ul>
                    <ul>
                        <li><a href="#none">그래프 인쇄</a></li>
                        <li><a href="#none">그래프 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                
                차트영역 (최종본 라인 제거)
            </div>
            <!-- //chart_wrap_area -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<script type="text/javascript" src="<c:url value="/resources/js/footer.js" />" charset="utf-8"></script>
	<!-- //footer -->
</div>
<!--  //wrap  -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>변수설정</h3>
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
                    <th>Title</th>
                    <td>
                        <div class="fx_form">
                            <input type="text">
                            <a class="btn_list" herf="none">그룹추가</a>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <select>
                                <option>3</option>
                            </select>
                        </td>
                        <td>
                            <select>
                                <option>X</option>
                            </select>
                        </td>
                        <td><input type="text"></td>
                        <td>
                            <select>
                                <option>AI</option>
                            </select>
                        </td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td class="tc"><input type="checkbox"></td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
            <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none">Tag Search</a>
                </div>
                <div class="button">
                    <a class="btn_list" href="#none">추가</a>
                    <a class="btn_list" href="#none">수정</a>
                    <a class="btn_list" href="#none">삭제</a>
                    <a class="btn_list" href="#none">위</a>
                    <a class="btn_list" href="#none">아래</a>
                </div>
            </div>
            <!-- //list_bottom -->
        </div>
        <!-- //list_wrap -->
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

