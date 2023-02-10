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
				<h3>SDS #1</h3>
				<div class="bc"><span>DCC</span><span>Tip</span><strong>SDS #1</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>원자로 출력</label>
                            <div class="fx_form">
                                <input type="text" class="fx_none" style="width:140px;">
                                <label><input type="radio" name="radio">%</label>
                                <label><input type="radio" name="radio">V</label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>PHT Pump Mode</label>
                            <div class="fx_form">
                                <select class="fx_none" style="width:140px;">
                                    <option>4</option>
                                </select>
                                <label><input type="radio" name="radio">ODD</label>
                                <label><input type="radio" name="radio">EVEN</label>
                            </div>
						</div>
                    </div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->            
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="300px" />
                        <col width="60px" />
                        <col width="90px" />
                        <col />
                        <col width="280px" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">TRIP PARAMETER</th>
                            <th colspan="3">설정치</th>
                            <th rowspan="2">TRIP SETPOINT</th>
                        </tr>
                        <tr>
                            <th colspan="2" class="bd_l_line">PHT PUMP</th>
                            <th>REACTOR 출력</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>PHT Low Flow</th>
                            <td colspan="2" class="tc">2,4</td>
                            <td class="tc">-</td>
                            <td class="tc">80% NF (2.076V)</td>
                        </tr>
                        <tr>
                            <th rowspan="2">Pressurizer Low Level</th>
                            <td colspan="2" class="tc">2</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇AVEC ＜ 40% FP(1.7V)</label>
                                    <label>◇AVEC ＞＝ 40% FP(1.7V)</label>
                                </div>
                            </td>
                            <td rowspan="2" class="tc">7.26m (2.643V)</td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tc bd_l_line">4</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇AVEC ＜ 40% FP(1.7V)</label>
                                    <label>Linear function of 40% FP(1.7V) ＜ ◇AVEC ＜ 55% FP(2.15V)</label>
                                    <label>55% FP(2.15V) ＜＝ ◇AVEC ＜ 75% FP(2.75V)</label>
                                    <label>Linear function of 75% FP(2.75V) ＜ ◇AVEC ＜＝ 95% FP(3.35V)</label>
                                    <label>◇AVEC ＞ 95% FP(3.35V)</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>S/G Low Level</th>
                            <td colspan="2" class="tc">-</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>Linear function of 0% FP(0.5V) ＜ ◇AVEC ＜ 90% FP(3.2V)</label>
                                    <label>◇AVEC ＞＝ 90% FP(3.2V)</label>
                                </div>
                            </td>
                            <td class="tc">1.74m (3.473V)</td>
                        </tr>
                        <tr>
                            <th>Mod. High Temperature</th>
                            <td colspan="2" class="tc">-</td>
                            <td class="tc">-</td>
                            <td class="tc">87℃ (2.988V)</td>
                        </tr>
                        <tr>
                            <th>PHT High Pr'</th>
                            <td colspan="2" class="tc">2,4</td>
                            <td class="tc">-</td>
                            <td class="tc">10.45MPa (3.802V) *예외</td>
                        </tr>
                        <tr>
                            <th rowspan="3">PHT Low Pr'</th>
                            <td rowspan="2" class="tc">2</td>
                            <td class="tc">ODD</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇LINC ＜＝ 0% FP(0.5V)</label>
                                    <label>Linear function of 0% FP(0.5V) ＜ ◇LINC ＜ 64.9875% FP(2.233V)</label>
                                    <label>◇LINC ＞＝ 64.9875% FP(2.233V)</label>
                                </div>
                            </td>
                            <td rowspan="3" class="tc">8.7MPa (3.015V)</td>
                        </tr>
                        <tr>
                            <td class="tc bd_l_line">EVEN</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇LINC ＜＝ 0% FP(0.5V)</label>
                                    <label>Linear function of 0% FP(0.5V) ＜ ◇LINC ＜ 19.9875% FP(1.566V)</label>
                                    <label>◇LINC ＞＝ 19.9875% FP(1.566V)</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tc bd_l_line">4</td>
                            <td class="tc">
                                <div class="fx_form column center">
                                    <label>◇LINC ＜＝ 0% FP(0.5V)</label>
                                    <label>Linear function of 0% FP(0.5V) ＜ ◇LINC ＜ 94.9875% FP(3.033V)</label>
                                    <label>◇LINC ＞＝ 94.9875% FP(3.033V)</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>S/G Feed Line Low Pr'</th>
                            <td colspan="2" class="tc">-</td>
                            <td class="tc">-</td>
                            <td class="tc">3.90 MPa (3.163V)</td>
                        </tr>                        
                    </tbody>
                </table>
                <!-- //form_table -->
            </div>
            <!-- //form_wrap -->
            <div class="fx_comment">
                <div class="fx_form_multi column">
                    <label class="title">* Conditioning Out 조건</label>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">PHTLF,PHTLP :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 0.0794%FP</label>
                        <label>(2.45V)</label>
                    </div>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">PLL,SGLL :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 0.794%FP</label>
                        <label>(2.95V)</label>
                        <label>AND</label>
                        <label>Ø AVEC ＜ 8.33%FP (0.75V)</label>
                    </div>
                    <div class="fx_form">
                        <label class="fx_none flex_end" style="width:100px;">SGFLP :</label>
                        <label class="fx_none" style="width:120px;">Ø LOG ＜ 7.15%FP</label>
                        <label>(3.427V)</label>
                    </div>
                </div>
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
</body>
</html>
