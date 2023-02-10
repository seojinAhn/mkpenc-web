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
<script type="text/javascript" src="<c:url value="/resources/js/tip.js" />" charset="utf-8"></script>

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
				<h3>I/O LIST</h3>
				<div class="bc"><span>DCC</span><span>Tip</span><strong>I/O LIST</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>호기선택</label>
                            <div class="fx_form_multi">
                                <select style="width:90px">
                                    <option>3호기</option>
                                </select>
                                <div class="fx_form">
                                    <label><input type="radio" name="a">X</label>
                                    <label><input type="radio" name="a">Y</label>
                                </div>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>Acess Field</label>
							<select>
								<option>Analog Inputs</option>
							</select>
						</div>
						<div class="fx_srch_item">
							<label>Address</label>
                            <div class="fx_form">
                                <input type="text">
                                <label>0-0</label>
                            </div>
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label class="label_select">
                                <select>
                                    <option>REV</option>
                                </select>
                            </label>
                            <input type="text">
						</div>
						<div class="fx_srch_item">
							<label class="label_select">
                                <select>
                                    <option>REV</option>
                                </select>
                            </label>
                            <input type="text">
						</div>
						<div class="fx_srch_item">
							<label class="label_select">
                                <select>
                                    <option>REV</option>
                                </select>
                            </label>
                            <input type="text">
						</div>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_reset" title="초기화"></a>
					<a class="btn_srch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->            
			<!-- list_wrap -->
			<div class="list_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_1');">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>5</strong></label>
					</div>
                    <!-- button -->
                    <div class="button">
                        <a class="btn_list primary" href="#none">저장</a>
                        <a class="btn_list excel_up" href="#none">엑셀일괄등록</a>
                        <a class="btn_list excel_down" href="#none">엑셀다운로드</a>
                    </div>
                    <!-- button -->                      
				</div>
                <!-- //list_head -->
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="40px"/>
                        <col width="60px"/>
                        <col width="160px"/>
                        <col width="160px"/>
                        <col width="240px"/>
                        <col width="110px"/>
                        <col width="200px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>ADDR</th>
                            <th>DESCR</th>
                            <th>MESSAGE</th>
                            <th>REV</th>
                            <th>DRAWING</th>
                            <th>LOOPNAME</th>
                            <th>DEVICE</th>
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
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
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
                            <td class="tc"></td>
                        </tr>
                        <tr>
                            <td class="tc"></td>
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
                            <td class="tc"></td>
                        </tr>
                    </tbody>
                </table>
                <!-- //list_table -->
			</div>
			<!-- //list_wrap -->
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text"></td>
                        <th>REV</th>
                        <td><input type="text"></td>
                        <th>TYPE</th>
                        <td><input type="text"></td>
                        <th>EQU#</th>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <th>DESCR</th>
                        <td colspan="3"><input type="text"></td>
                        <th>GROUP</th>
                        <td><input type="text"></td>
                        <th>B-SCAL</th>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <th>MESSAGE</th>
                        <td colspan="3"><input type="text"></td>
                        <th>WINDOWS</th>
                        <td><input type="text"></td>
                        <th>WBA</th>
                        <td><input type="text"></td>
                    </tr>                    
                    <tr>
                        <th>DRAWING</th>
                        <td><input type="text"></td>
                        <th>LOOPNAME</th>
                        <td><input type="text"></td>
                        <th>PRIORITY</th>
                        <td><input type="text"></td>
                        <th>DEVICE</th>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <th>DCC</th>
                        <td><input type="text"></td>
                        <th>UNIT</th>
                        <td><input type="text"></td>
                        <th>LIMIT 1</th>
                        <td><input type="text"></td>
                        <th>PURPOSE</th>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <th>VLOW</th>
                        <td><input type="text"></td>
                        <th>ELOW</th>
                        <td><input type="text"></td>
                        <th>LIMIT 2</th>
                        <td><input type="text"></td>
                        <th>PROGRAM</th>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <th>CONV</th>
                        <td><input type="text"></td>
                        <th>RTD</th>
                        <td><input type="text"></td>
                        <th>J</th>
                        <td><input type="text"></td>
                        <th>관련절차서</th>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <th>원인</th>
                        <td colspan="3">
                            <textarea></textarea>
                        </td>
                        <th>조치</th>
                        <td colspan="3">
                            <textarea></textarea>
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

