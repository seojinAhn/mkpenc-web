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
<script type="text/javascript" src="<c:url value="/resources/js/performance.js" />" charset="utf-8"></script>

<script type="text/javascript">

$(function () {
	
	var timer =0;
			
	timer = setInterval(function () {
 				
		var comAjax = new ComAjax("safeVarSearch");
			 comAjax.setUrl("/dcc/performance/runtimer");
	 		 comAjax.setCallback("mbr_RuntimerEventCallback");
	 	}, 500); 	  
				  
 
});	


</script>

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
				<h3>필수안전변수</h3>
				<div class="bc"><span>DCC</span><span>Performance</span><strong>필수안전변수</strong></div>
			</div>
			<!-- //page_title -->
			<form id="safeVarSearch" name=safeVarSearch">
			<input type = "hidden" id="sGrpID" name="sGrpID" value="mimic">
			<input type = "hidden" id="sMenuNo" name="sMenuNo" value = "44">
			<input type = "hidden" id="sDive" name="sDive" value = "D">
			<input type = "hidden" id="sUGrpNo" name="sUGrpNo" value = "3">
			<input type = "hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi }">
			<input type = "hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun }">
			</form>
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col width="200px"/>
                                <col />
                                <col width="140px"/>
                                <col width="160px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>DESCRIPTION</th>
                                    <th>SAFETY LIMIT</th>
                                    <th>VALUE</th>
                                    <th>UNIT</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th>LIN POWER</th>
                                    <td class="tc">＜ 2</td>
                                    <td class="tr">0.8581</td>
                                    <td class="tc">%FP</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td class="tr">11.127</td>
                                    <td class="tc" rowspan="4">MPAG</td>
                                </tr>
                                <tr>
                                    <th>RH4 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>RH6 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>RH8 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>PZR Level 3A</th>
                                    <td class="tc">≥ 4</td>
                                    <td class="tr">8.000</td>
                                    <td class="tc" rowspan="3">M</td>
                                </tr>
                                <tr>
                                    <th>PZR Level 3A</th>
                                    <td class="tc">≥ 4</td>
                                    <td class="tr">8.000</td>
                                </tr>
                                <tr>
                                    <th>PZR Level 3A</th>
                                    <td class="tc">≥ 4</td>
                                    <td class="tr">8.000</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td class="tr">11.127</td>
                                    <td class="tc" rowspan="4">MPAG</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>S/G #1 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td class="tr">11.127</td>
                                    <td class="tc" rowspan="4">M</td>
                                </tr>
                                <tr>
                                    <th>S/G #2 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>S/G #3 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>S/G #4 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td class="tr">11.127</td>
                                </tr>                                  
                            </tbody>
                        </table>
                        <!-- //form_table -->
                    </div>
                    <!-- //form_wrap -->
                </div>
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col width="200px"/>
                                <col />
                                <col width="140px"/>
                                <col width="160px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>DESCRIPTION</th>
                                    <th>SAFETY LIMIT</th>
                                    <th>VALUE</th>
                                    <th>UNIT</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th>LOG POWER</th>
                                    <td class="tc">(＜ -1.6990)</td>
                                    <td class="tr">0.8581</td>
                                    <td class="tc">DECADE</td>
                                </tr>
                                <tr>
                                    <th>RH2 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">11.127</td>
                                    <td class="tc" rowspan="4">DEGC</td>
                                </tr>
                                <tr>
                                    <th>RH4 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>RH6 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>RH8 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>R/B Pr CH-K</th>
                                    <td class="tc">＜ 3.45</td>
                                    <td class="tr">8.000</td>
                                    <td class="tc" rowspan="3">KPAD</td>
                                </tr>
                                <tr>
                                    <th>R/B Pr CH-L</th>
                                    <td class="tc">＜ 3.45</td>
                                    <td class="tr">8.000</td>
                                </tr>
                                <tr>
                                    <th>R/B Pr CH-M</th>
                                    <td class="tc">＜ 3.45</td>
                                    <td class="tr">8.000</td>
                                </tr>
                                <tr>
                                    <th>ROH1 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">11.127</td>
                                    <td class="tc" rowspan="4">DEGC</td>
                                </tr>
                                <tr>
                                    <th>ROH3 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>ROH5 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>ROH7Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>S/G #1 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td class="tr">11.127</td>
                                    <td class="tc" rowspan="4">KPAD</td>
                                </tr>
                                <tr>
                                    <th>S/G #2 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>S/G #3 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td class="tr">11.127</td>
                                </tr>
                                <tr>
                                    <th>S/G #4 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td class="tr">11.127</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //form_table -->
                    </div>
                    <!-- //form_wrap -->
                </div>
            </div>
            <!-- //fx_layout -->
			<!-- form_wrap -->
			<div class="form_wrap">
				<!-- form_head -->
				<div class="form_head">
                    <h4>SUB COOLING MARGINE</h4>
					<div class="button">
                        <div class="fx_legend txt_type">
                            <label>단위 (DEGC)</label>
                        </div>
					</div>
				</div>
				<!-- //form_head -->
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col width="200px"/>
                        <col />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>SAFTY LIMIT > 20</th>
                            <td></td>
                        </tr>
                    </tbody>
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

