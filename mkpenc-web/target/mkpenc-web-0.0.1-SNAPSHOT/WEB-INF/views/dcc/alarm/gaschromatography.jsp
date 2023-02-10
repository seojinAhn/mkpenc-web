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
				<h3>가스크로마토그래프</h3>
				<div class="bc"><span>DCC</span><span>Alarm</span><strong>가스크로마토그래프</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap dp_style">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label class="dp_title">현재분석계통</label>
                            <div class="fx_form">
                                <label><strong>N/A</strong></label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label class="dp_title">기체농도</label>
                            <div class="fx_form">
                                <label>[ 수소<strong>-0.006</strong>%] ,</label>
                                <label>[ 수소<strong>0.651</strong>%] ,</label>
                                <label>[ 수소<strong>0.773</strong>%] ,</label>
                                <label>[ 수소<strong>-0.004</strong>%]</label>
                            </div>
						</div>
                    </div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->
            <!-- list_wrap -->
            <div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<h4>직전분석값</h4>
                </div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="140px"/>
                        <col width="180px"/>
                        <col width="180px"/>
                        <col width="180px"/>
                        <col width="180px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>계통</th>
                            <th>수소농도</th>
                            <th>산소농도</th>
                            <th>질소농도</th>
                            <th>중수소농도</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>LZC RU 전단</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                        </tr>
                        <tr>
                            <td>LZC RU 후단</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                        </tr>
                        <tr>
                            <td>MOD RU 전단</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                        </tr>
                        <tr>
                            <td>MOD RU 후단</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                        </tr>
                        <tr>
                            <td>HI COLLECTION</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                        </tr>
                        <tr>
                            <td>HT DST</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                            <td class="tc">0.263</td>
                        </tr>
                    </tbody>
                </table>
                <!-- //list_table -->
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

