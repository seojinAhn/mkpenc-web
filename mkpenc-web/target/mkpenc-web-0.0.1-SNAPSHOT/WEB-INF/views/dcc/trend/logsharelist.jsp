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
				<h3>Trend Log(Share)</h3>
				<div class="bc"><span>DCC</span><span>Trend</span><strong>Trend Log(Share)</strong></div>
			</div>
			<!-- //page_title -->
			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
                        <select style="width:400px;">
                            <option>3-000 General Sytem Log</option>
                        </select>
					</div>
				</div>
				<!-- //list_head -->
            </div>
            <!-- //list_wrap -->
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
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
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">25</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- //list_table -->
                </div>
                <div class="fx_block">
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
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">0</label>
                                        <label class="full"></label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">1</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">50</td>
                                <td></td>
                                <td class="tc">SC</td>
                                <td class="tc">000000</td>
                                <td>
                                    <div class="fx_form">
                                        <label class="full flex_end">-0.7890789DEC</label>
                                        <label class="full">DEG C</label>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- //list_table -->
                </div>
            </div>
            <!-- //fx_layout -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<script type="text/javascript" src="<c:url value="/resources/js/footer.js" />" charset="utf-8"></script>
	<!-- //footer -->
</div>
<!--  //wrap  -->

</body>
</html>

