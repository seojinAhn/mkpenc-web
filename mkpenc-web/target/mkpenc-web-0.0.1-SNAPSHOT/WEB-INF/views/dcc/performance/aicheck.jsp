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
  			var	comSubmit	=	new ComSubmit("dccselfcheckSearch");
			comSubmit.setUrl("/dcc/performance/dccselfcheck");
			//comSubmit.submit();
			
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
				<h3>AI CHECK</h3>
				<div class="bc"><span>DCC</span><span>Perfomance</span><strong>AI CHECK</strong></div>
			</div>
			<!-- //page_title -->
			<form id="aicheckFrm" name="aicheckFrm">	</form>
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_head -->
                <div class="form_head">
                    <div class="button">
                         <div class="fx_legend">
                            <label style="color:${XForeColor}">${XSearchTime}</label>
                         </div>
                     </div>
                </div>
                <!-- //form_head -->
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>S1AB69</th>
                            <th>S1AB76</th>
                            <th>S1AB5</th>
                            <th>S1AB12</th>
                            <th>S1AB19</th>
                            <th>S1AB26</th>
                            <th>S1AB55</th>
                            <th>S1AB62</th>
                            <th>S1AB76</th>
                            <th>S1AB83</th>
                            <th>S1AB12</th>
                            <th>S1AB19</th>
                            <th>S1AB26</th>
                            <th>S1AB33</th>
                            <th>전압(V)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>POT01</th>
                            <td class="tc cell_color_yellow">
                                <div class="fx_form column">
                                    <label class="full flex_center blue">452</label>
                                    <label class="full flex_center" style="color:${shpDataXList[0].BackColor}">${lblDataXList[0].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc cell_color_red">
                                <div class="fx_form column">
                                    <label class="full flex_center blue">2052</label>
                                    <label class="full flex_center" style="color:${shpDataXList[1].BackColor}">${lblDataXList[1].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                                <div class="fx_form column">
                                    <label class="full flex_center blue">3225</label>
                                    <label class="full flex_center" style="color:${shpDataXList[2].BackColor}">${lblDataXList[2].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-4.9</label></th>
                        </tr>
                        <tr>
                            <th>POT02</th>
                            <td class="tc">
                                <div class="fx_form column">
                                    <label class="full flex_center blue">525</label>
                                    <label class="full flex_center" style="color:${shpDataXList[3].BackColor}">${lblDataXList[3].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                                <div class="fx_form column">
                                    <label class="full flex_center blue">1552</label>
                                    <label class="full flex_center" style="color:${shpDataXList[4].BackColor}">${lblDataXList[4].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                                <div class="fx_form column">
                                    <label class="full flex_center blue">3425</label>
                                    <label class="full flex_center" style="color:${shpDataXList[5].BackColor}">${lblDataXList[5].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+4.9</label></th>
                        </tr>
                        <tr>
                            <th>POT03</th>
                            <td class="tc"></th>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">652</label>
                                    <label class="full flex_center" style="color:${shpDataXList[6].BackColor}">${lblDataXList[6].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1152</label>
                                    <label class="full flex_center" style="color:${shpDataXList[7].BackColor}">${lblDataXList[7].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2752</label>
                                    <label class="full flex_center" style="color:${shpDataXList[8].BackColor}">${lblDataXList[8].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT04</th>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">752</label>
                                    <label class="full flex_center" style="color:${shpDataXList[9].BackColor}">${lblDataXList[9].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1424</label>
                                    <label class="full flex_center" style="color:${shpDataXList[10].BackColor}">${lblDataXList[10].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2352</label>
                                    <label class="full flex_center" style="color:${shpDataXList[11].BackColor}">${lblDataXList[11].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT05</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1025</label>
                                    <label class="full flex_center" style="color:${shpDataXList[12].BackColor}">${lblDataXList[12].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2400</label>
                                    <label class="full flex_center" style="color:${shpDataXList[13].BackColor}">${lblDataXList[13].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3107</label>
                                    <label class="full flex_center" style="color:${shpDataXList[14].BackColor}">${lblDataXList[14].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+2.5</label></td>
                        </tr>
                        <tr>
                            <th>POT06</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1205</label>
                                    <label class="full flex_center" style="color:${shpDataXList[15].BackColor}">${lblDataXList[15].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2425</label>
                                    <label class="full flex_center" style="color:${shpDataXList[16].BackColor}">${lblDataXList[16].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3025</label>
                                    <label class="full flex_center" style="color:${shpDataXList[17].BackColor}">${lblDataXList[17].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-4.9</label></td>
                        </tr>
                        <tr>
                            <th>POT07</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>                            
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1300</label>
                                    <label class="full flex_center" style="color:${shpDataXList[18].BackColor}">${lblDataXList[18].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2525</label>
                                    <label class="full flex_center" style="color:${shpDataXList[19].BackColor}">${lblDataXList[19].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3125</label>
                                    <label class="full flex_center" style="color:${shpDataXList[20].BackColor}">${lblDataXList[20].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT08</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>                            
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1225</label>
                                    <label class="full flex_center" style="color:${shpDataXList[21].BackColor}">${lblDataXList[21].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2625</label>
                                    <label class="full flex_center" style="color:${shpDataXList[22].BackColor}">${lblDataXList[22].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3052</label>
                                    <label class="full flex_center" style="color:${shpDataXList[23].BackColor}">${lblDataXList[23].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+4.9</label></td>
                        </tr>
                        <tr>
                            <th>POT09</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1252</label>
                                    <label class="full flex_center" style="color:${shpDataXList[24].BackColor}">${lblDataXList[24].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2477</label>
                                    <label class="full flex_center" style="color:${shpDataXList[25].BackColor}">${lblDataXList[25].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3152</label>
                                    <label class="full flex_center" style="color:${shpDataXList[26].BackColor}">${lblDataXList[26].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-0.5</label></td>
                        </tr>
                        <tr>
                            <th>POT10</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1325</label>
                                    <label class="full flex_center" style="color:${shpDataXList[27].BackColor}">${lblDataXList[27].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2552</label>
                                    <label class="full flex_center" style="color:${shpDataXList[28].BackColor}">${lblDataXList[28].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3070</label>
                                    <label class="full flex_center" style="color:${shpDataXList[29].BackColor}">${lblDataXList[29].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+0.5</label></td>
                        </tr>
                        <tr>
                            <th>POT11</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1377</label>
                                    <label class="full flex_center" style="color:${shpDataXList[30].BackColor}">${lblDataXList[30].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2570</label>
                                    <label class="full flex_center" style="color:${shpDataXList[31].BackColor}">${lblDataXList[31].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3352</label>
                                    <label class="full flex_center" style="color:${shpDataXList[32].BackColor}">${lblDataXList[32].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">-4.9</label></td>
                        </tr>
                        <tr>
                            <th>POT12</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1625</label>
                                    <label class="full flex_center" style="color:${shpDataXList[33].BackColor}">${lblDataXList[33].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2152</label>
                                    <label class="full flex_center" style="color:${shpDataXList[34].BackColor}">${lblDataXList[34].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3552</label>
                                    <label class="full flex_center" style="color:${shpDataXList[35].BackColor}">${lblDataXList[35].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"><label class="fs_double">+1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT13</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1752</label>
                                    <label class="full flex_center" style="color:${shpDataXList[36].BackColor}">${lblDataXList[36].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2225</label>
                                    <label class="full flex_center" style="color:${shpDataXList[37].BackColor}">${lblDataXList[37].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3625</label>
                                    <label class="full flex_center" style="color:${shpDataXList[38].BackColor}">${lblDataXList[38].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"><label class="fs_double">-1.25</label></td>
                        </tr>
                        <tr>
                            <th>POT14</th>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">1177</label>
                                    <label class="full flex_center" style="color:${shpDataXList[39].BackColor}">${lblDataXList[39].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">2637</label>
                                    <label class="full flex_center" style="color:${shpDataXList[04].BackColor}">${lblDataXList[40].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc"></td>
                            <td class="tc">
                            	<div class="fx_form column">
                                    <label class="full flex_center blue">3752</label>
                                    <label class="full flex_center" style="color:${shpDataXList[41].BackColor}">${lblDataXList[41].fValue}</label>
                                </div>
                            </td>
                            <td class="tc"><label class="fs_double">+2.5</label></td>
                        </tr>
                    </tbody>
                </table>
                <!-- //form_table -->
            </div>
            <!-- //form_wrap -->
            <div class="form_info">
				<div class="fx_legend txt_type">
					<label>※ 접압과 편차가 ± 4~5mV 차이 발생 시 해당 쉘 황색, 5mV 발생 시 적색, AI Adress 아래에 현재 값 표시</label>
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

