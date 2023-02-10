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
<script type="text/javascript" src="<c:url value="/resources/js/admin.js" />" charset="utf-8"></script>
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
				<h3>I/O LIST</h3>
				<div class="bc"><span>MARK_V</span><span>Admin</span><strong>I/O LIST</strong></div>
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
							<label>장비번호</label>
							<select>
								<option>1번</option>
							</select>
						</div>
						<div class="fx_srch_item">
							<label>I/O형식</label>
							<select>
								<option>SIGN16</option>
							</select>
						</div>
						<div class="fx_srch_item">
							<label>Register</label>
                            <div class="fx_form">
                                <input type="text">
                            </div>
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label class="label_select">
                                <select>
                                    <option>DESCR</option>
                                </select>
                            </label>
                            <input type="text">
						</div>
						<div class="fx_srch_item">
							<label class="label_select">
                                <select>
                                    <option>DESCR</option>
                                </select>
                            </label>
                            <input type="text">
						</div>
						<div class="fx_srch_item">
							<label class="label_select">
                                <select>
                                    <option>DESCR</option>
                                </select>
                            </label>
                            <input type="text">
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
			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>5</strong></label>
					</div>
                    <!-- button -->
                    <div class="button">
                        <a class="btn_list excel_down" href="#none">엑셀다운로드</a>
                    </div>
                    <!-- button -->                      
				</div>
                <!-- //list_head -->
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="60px"/>
                        <col width="90px"/>
                        <col width="60px"/>
                        <col width="100px"/>
                        <col width="60px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col />
                        <col width="60px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>ISEQ</th>
                            <th>REGISTER</th>
                            <th>IOBIT</th>
                            <th>SIGNAL NAME</th>
                            <th>GAIN</th>
                            <th>OFFSET</th>
                            <th>UNIT</th>
                            <th>SIGNAL DESC</th>
                            <th>BSCal</th>
                            <th>D0</th>
                            <th>D1</th>
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
                        <col width="320px" />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>REGISTER</th>
                        <td><input type="text" disabled="disabled"></td>
                        <th>BIT</th>
                        <td><input type="text" disabled="disabled"></td>
                        <th>NAME</th>
                        <td><input type="text"></td>
                        <th>GAIN</th>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <th>OFFSET</th>
                        <td><input type="text"></td>
                        <th>UNIT</th>
                        <td><input type="text"></td>
                        <th>DESC</th>
                        <td><input type="text"></td>
                        <th>BScale</th>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <th colspan="2">DIGITAL 값이 0일 경우 문자표현</th>
                        <td colspan="6"><input type="text"></td>
                    </tr>
                    <tr>
                        <th colspan="2">DIGITAL 값이 0일 경우 문자표현</th>
                        <td colspan="6"><input type="text"></td>
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
</body>
</html>

