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
	<%@ include file="/WEB-INF/views/include/include-markv-header.jspf" %>
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>Trend Log</h3>
				<div class="bc"><span>MARK_V</span><span>Trend</span><strong>Trend Log</strong></div>
			</div>
			<!-- //page_title -->
			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
                        <select style="width:400px;">
                            <option>3-001 MAIN STOP VALVE POSITION</option>
                        </select>
					</div>
				</div>
				<!-- //list_head -->
            </div>
            <!-- //list_wrap -->
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
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="60px"/>
                                <col />
                                <col width="60px"/>
                                <col width="80px"/>
                                <col width="240px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Descrption</th>
                                    <th>Type</th>
                                    <th>ADDR.</th>
                                    <th>Value</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tc">1</td>
                                    <td>MSV1POS</td>
                                    <td class="tc">AI</td>
                                    <td class="tc">1-0037</td>
                                    <td>
                                        <div class="fx_form">
                                            <label class="full flex_end"></label>
                                            <label class="full">%</label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tc">2</td>
                                    <td>MSV1POS</td>
                                    <td class="tc">AI</td>
                                    <td class="tc">1-0038</td>
                                    <td>
                                        <div class="fx_form">
                                            <label class="full flex_end"></label>
                                            <label class="full">%</label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tc">3</td>
                                    <td>MSV1POS</td>
                                    <td class="tc">AI</td>
                                    <td class="tc">1-0039</td>
                                    <td>
                                        <div class="fx_form">
                                            <label class="full flex_end"></label>
                                            <label class="full">%</label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tc">4</td>
                                    <td>MSV1POS</td>
                                    <td class="tc">AI</td>
                                    <td class="tc">1-0040</td>
                                    <td>
                                        <div class="fx_form">
                                            <label class="full flex_end"></label>
                                            <label class="full">%</label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tc">5</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">6</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">7</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">8</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">9</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">10</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">11</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">12</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">13</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">14</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">15</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">16</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">17</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">18</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">19</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">20</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">21</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">22</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">23</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">24</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">25</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="60px"/>
                                <col />
                                <col width="60px"/>
                                <col width="80px"/>
                                <col width="240px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Descrption</th>
                                    <th>Type</th>
                                    <th>ADDR.</th>
                                    <th>Value</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tc">26</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">27</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">28</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">29</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">30</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">31</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">32</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">33</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">34</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">35</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">36</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">37</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">38</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">39</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">40</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">41</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">42</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">43</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">44</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">45</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">46</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">47</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">48</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">49</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="tc">50</td>
                                    <td></td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
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

