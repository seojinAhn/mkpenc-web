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
<script type="text/javascript" src="<c:url value="/resources/js/alarm.js" />" charset="utf-8"></script>
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
				<h3>SUMMARY</h3>
				<div class="bc"><span>DCC</span><span>Alarm</span><strong>Summary</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item double">
							<label>검색기간 A</label>
                            <div class="fx_form_multi">
                                <div class="fx_form_date">
                                    <input type="text">
                                    <a href="#none"></a>
                                </div>
                                <div class="fx_form">
                                    <select class="fx_none" style="width:60px;">
                                        <option>11</option>
                                    </select>
                                    <label>:</label>
                                    <select class="fx_none" style="width:60px;">
                                        <option>51</option>
                                    </select>
                                </div>
                            </div>
						</div>
                        <div class="fx_srch_item"></div>
					</div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch">Search</a>
					<a class="btn_list primary" href="#none">조건검색</a>
					<a class="btn_list primary" href="#none">알람저장</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->

			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>10</strong></label>
					</div>
					<!-- button -->
					<div class="button">						
						<a class="btn_list primary" href="#none">이동</a>prompt()
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="60px"/>
                        <col width="180px"/>
                        <col width="120px"/>
                        <col width="200px"/>
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>알람구분</th>
                            <th>알람시간</th>
                            <th>알람코드</th>
                            <th>알람주소</th>
                            <th>내용</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="tc">1</td>
                            <td class="tc">2022-00-00</td>
                            <td class="tc">관리자</td>
                            <td>마크파이브 경보 정상화</td>
                            <td>내용입니다.</td>
                        </tr>
                    </tbody>
                </table>
                <!-- //list_table -->							
				<!-- paginate -->
				<div class="paginate">
					<a class="first" href="#none" alt="첫페이지" title="첫페이지"></a>
					<a class="pre" href="#none" alt="이전페이지"  title="이전페이지"></a>
					<a href="#none">1</a>
					<strong>2</strong>
					<a href="#none">3</a>
					<a href="#none">4</a>
					<a href="#none">5</a>
					<a href="#none">6</a>
					<a href="#none">7</a>
					<a href="#none">8</a>
					<a href="#none">9</a>
					<a href="#none">10</a>
					<a class="next" href="#none" alt="다음페이지" title="다음페이지"></a>
					<a class="last" href="#none" alt="마지막페이지" title="마지막페이지"></a>
				</div>
				<!-- //paginate -->
			</div>
			<!-- //list_wrap -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->
</body>
</html>