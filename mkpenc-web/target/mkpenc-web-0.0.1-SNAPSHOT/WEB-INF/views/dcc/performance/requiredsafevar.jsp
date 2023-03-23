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
 				
		// 화면초기화
		var	comSubmit	=	new ComSubmit("safeVarSearch");
		comSubmit.setUrl("/dcc/performance/requiredsafevar");
		comSubmit.submit();
		
	}, 5000); 	 
 
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
                                    <td class="tr">${lblDataList[0].fValue}</td>
                                    <td class="tc">%FP</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td class="tr">${lblDataList[1].fValue}</td>
                                    <td class="tc" rowspan="4">MPAG</td>
                                </tr>
                                <tr>
                                    <th>RH4 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td class="tr">${lblDataList[2].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH6 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td class="tr">${lblDataList[3].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH8 Pressure</th>
                                    <td class="tc">7.2 ~ 10</td>
                                    <td class="tr">${lblDataList[4].fValue}</td>
                                </tr>
                                <tr>
                                    <th>PZR Level 3A</th>
                                    <td class="tc">≥ 4</td>
                                    <td class="tr">${lblDataList[5].fValue}</td>
                                    <td class="tc" rowspan="3">M</td>
                                </tr>
                                <tr>
                                    <th>PZR Level 3A</th>
                                    <td class="tc">≥ 4</td>
                                    <td class="tr">${lblDataList[6].fValue}</td>
                                </tr>
                                <tr>
                                    <th>PZR Level 3A</th>
                                    <td class="tc">≥ 4</td>
                                    <td class="tr">${lblDataList[7].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td class="tr">${lblDataList[8].fValue}</td>
                                    <td class="tc" rowspan="4">MPAG</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td class="tr">${lblDataList[9].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td class="tr">${lblDataList[10].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH2 Pressure</th>
                                    <td class="tc">(7.2 ~ 10)</td>
                                    <td class="tr">${lblDataList[11].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #1 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td class="tr">${lblDataList[12].fValue}</td>
                                    <td class="tc" rowspan="4">M</td>
                                </tr>
                                <tr>
                                    <th>S/G #2 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td class="tr">${lblDataList[13].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #3 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td class="tr">${lblDataList[14].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #4 LEVEL</th>
                                    <td class="tc">-1 ~ 2.5</td>
                                    <td class="tr">${lblDataList[15].fValue}</td>
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
                                    <td class="tr">${lblDataList[16].fValue}</td>
                                    <td class="tc">DECADE</td>
                                </tr>
                                <tr>
                                    <th>RH2 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">${lblDataList[17].fValue}</td>
                                    <td class="tc" rowspan="4">DEGC</td>
                                </tr>
                                <tr>
                                    <th>RH4 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">${lblDataList[18].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH6 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">${lblDataList[19].fValue}</td>
                                </tr>
                                <tr>
                                    <th>RH8 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">${lblDataList[20].fValue}</td>
                                </tr>
                                <tr>
                                    <th>R/B Pr CH-K</th>
                                    <td class="tc">＜ 3.45</td>
                                    <td class="tr">${lblDataList[21].fValue}</td>
                                    <td class="tc" rowspan="3">KPAD</td>
                                </tr>
                                <tr>
                                    <th>R/B Pr CH-L</th>
                                    <td class="tc">＜ 3.45</td>
                                    <td class="tr">${lblDataList[22].fValue}</td>
                                </tr>
                                <tr>
                                    <th>R/B Pr CH-M</th>
                                    <td class="tc">＜ 3.45</td>
                                    <td class="tr">${lblDataList[23].fValue}</td>
                                </tr>
                                <tr>
                                    <th>ROH1 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">${lblDataList[24].fValue}</td>
                                    <td class="tc" rowspan="4">DEGC</td>
                                </tr>
                                <tr>
                                    <th>ROH3 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">${lblDataList[25].fValue}</td>
                                </tr>
                                <tr>
                                    <th>ROH5 Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">${lblDataList[26].fValue}</td>
                                </tr>
                                <tr>
                                    <th>ROH7Temp</th>
                                    <td class="tc">(267~297)</td>
                                    <td class="tr">${lblDataList[27].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #1 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td class="tr">${lblDataList[28].fValue}</td>
                                    <td class="tc" rowspan="4">MPAG</td>
                                </tr>
                                <tr>
                                    <th>S/G #2 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td class="tr">${lblDataList[29].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #3 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td class="tr">${lblDataList[30].fValue}</td>
                                </tr>
                                <tr>
                                    <th>S/G #4 Pr</th>
                                    <td class="tc">＞ 3.9</td>
                                    <td class="tr">${lblDataList[31].fValue}</td>
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
                            <td>RIH2 : ${lblSCM.idx0}</td>
                            <td>RIH4 : ${lblSCM.idx1}</td>
                            <td>RIH6 : ${lblSCM.idx2}</td>
                            <td>RIH8 : ${lblSCM.idx3}</td>
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

