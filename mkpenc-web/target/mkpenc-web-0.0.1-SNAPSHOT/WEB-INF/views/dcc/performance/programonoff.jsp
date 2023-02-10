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
  			var	comSubmit	=	new ComSubmit("programonoffFrm");
			comSubmit.setUrl("/dcc/performance/programonoff");
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
				<h3>PROGRAM ON/OFF</h3>
				<div class="bc"><span>DCC</span><span>Perfomance</span><strong>PROGRAM ON/OFF</strong></div>
			</div>
			<!-- //page_title -->
			<form id="programonoffFrm" name="programonoffFrm">	</form>
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_head -->
                        <div class="form_head">
                        	<div class="button">
                                <div class="fx_legend">
                                </div>
                            </div>
							<div class="button">
                                <div class="fx_legend">
                                </div>
                            </div>
							<div class="button">
                                <div class="fx_legend">
                                   <label style="color:${XForeColor}">${XSearchTime}</label>
                                </div>
                            </div>
							<div class="button">
                                <div class="fx_legend">
                                    <label style="color:${YForeColor}">${YSearchTime}</label>
                                </div>
                            </div>
                        </div>
                        <!-- //form_head -->                        
                        <!-- form_table -->
                        <table class="form_table">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>H/S No / DI</th>
                                    <th>Programe</th>
                                    <th>DCC X</th>
                                    <th>DCC Y</th>
                                </tr>
                            </thead>                            
                            <tbody>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-1 / DI 56B00</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[0].fValue}</label>
                                                <label>${lblDataYList[0].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>01 STP</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[1].fValue}</label>
                                                <label>${lblDataYList[1].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[2].fValue}</label>
                                                <label>${lblDataYList[2].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[3].fValue}</label>
                                                <label>${lblDataYList[3].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[4].fValue}</label>
                                                <label>${lblDataYList[4].fValue}</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc">DO 200B15, 232B09, 201B10, 233B08</td>
                                    <td class="tc">DO 200B15, 232B09, 201B10, 233B08</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-4 / DI 56B03</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[5].fValue}</label>
                                                <label>${lblDataYList[5].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>04 FLOG(DCCX) / FDR(DCCY)</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-5 / DI 56B04</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[6].fValue}</label>
                                                <label>${lblDataYList[6].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>11 RRS</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[7].fValue}</label>
                                                <label>${lblDataYList[7].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[8].fValue}</label>
                                                <label>${lblDataYList[8].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[9].fValue}</label>
                                                <label>${lblDataYList[9].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[10].fValue}</label>
                                                <label>${lblDataYList[10].fValue}</label>
                                            </div>
                                        </div>
                                    </td>
                                      <td class="tc">DO 200B13, 232B14, 201B08, 233B09</td>
                                      <td class="tc">DO 200B13, 232B14, 201B08, 233B09</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-6 / DI 56B05</label>
                                            </div>
                                            <div class="fx_form column">
                                               	<label>${lblDataXList[11].fValue}</label>
                                                <label>${lblDataYList[11].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>12 SGL</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[12].fValue}</label>
                                                <label>${lblDataYList[12].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[13].fValue}</label>
                                                <label>${lblDataYList[13].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[14].fValue}</label>
                                                <label>${lblDataYList[15].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[15].fValue}</label>
                                                <label>${lblDataYList[15].fValue}</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc">DO 201B11, 232B10, 202B08, 233B12</td>
                                    <td class="tc">DO 201B11, 232B10, 202B08, 233B12</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-7 / DI 56B06</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[16].fValue}</label>
                                                <label>${lblDataYList[16].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>13 HTC</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[17].fValue}</label>
                                                <label>${lblDataYList[17].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[18].fValue}</label>
                                                <label>${lblDataYList[18].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[19].fValue}</label>
                                                <label>${lblDataYList[19].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[20].fValue}</label>
                                                <label>${lblDataYList[20].fValue}</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc">DO 201B13, 232B12, 202B10, 233B11</td>
                                    <td class="tc">DO 201B13, 232B12, 202B10, 233B11</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-8 / DI 56B07</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[21].fValue}</label>
                                                <label>${lblDataYList[21].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>14 SGP</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[22].fValue}</label>
                                                <label>${lblDataYList[22].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[23].fValue}</label>
                                                <label>${lblDataYList[23].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[24].fValue}</label>
                                                <label>${lblDataYList[24].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[25].fValue}</label>
                                                <label>${lblDataYList[25].fValue}</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc">DO 201B12, 232B11, 202B09, 233B13</td>
                                    <td class="tc">DO 201B12, 232B11, 202B09, 233B13</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-9 / DI 56B08</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[26].fValue}</label>
                                                <label>${lblDataYList[26].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>15 FLX</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-13 / DI 56B12</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[27].fValue}</label>
                                                <label>${lblDataYList[27].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>21 MAS</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-14 / DI 56B13</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[28].fValue}</label>
                                                <label>${lblDataYList[28].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>22 AAS</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-15 / DI 56B14</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[29].fValue}</label>
                                                <label>${lblDataYList[29].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>23 CAS</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-16 / DI 56B15</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[30].fValue}</label>
                                                <label>${lblDataYList[30].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>24 MAS1</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-17 / DI 57B00</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[31].fValue}</label>
                                                <label>${lblDataYList[31].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>25 HDS</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-19 / DI 57B02</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[32].fValue}</label>
                                                <label>${lblDataYList[32].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>27 PARC</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>                                    
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-21 / DI 57B04</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[33].fValue}</label>
                                                <label>${lblDataYList[33].fValue}</label>
                                            </div>
                                        </div>                                        
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>31 EDC</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-22 / DI 57B05</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[34].fValue}</label>
                                                <label>${lblDataYList[34].fValue}</label>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>32 MTC</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[35].fValue}</label>
                                                <label>${lblDataYList[35].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[36].fValue}</label>
                                                <label>${lblDataYList[36].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[37].fValue}</label>
                                                <label>${lblDataYList[37].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[38].fValue}</label>
                                                <label>${lblDataYList[38].fValue}</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc">DO 200B14, 232B08, 201B09, 233B10</td>
                                    <td class="tc">DO 200B14, 232B08, 201B09, 233B10</td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-23 / DI 57B06</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[39].fValue}</label>
                                                <label>${lblDataYList[39].fValue}</label>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>33 XEN</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-24 / DI 57B07</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[40].fValue}</label>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>34 TPM(DCCX)</label>
                                            </div>
                                             <div class="fx_form column">
                                                 <label>${lblDataYList[40].fValue}</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-25 / DI 57B08</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[41].fValue}</label>
                                                <label>${lblDataYList[41].fValue}</label>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>35 DUMY(DCCX) / FHSUP(DCCY)</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc"></td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <th>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>HS-28 / DI 57B11</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[42].fValue}</label>
                                                <label>${lblDataYList[42].fValue}</label>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <div class="fx_form_multi">
                                            <div class="fx_form full">
                                                <label>40 HTT</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[43].fValue}</label>
                                                <label>${lblDataYList[43].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[44].fValue}</label>
                                                <label>${lblDataYList[44].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                                <label>${lblDataXList[45].fValue}</label>
                                                <label>${lblDataYList[45].fValue}</label>
                                            </div>
                                            <div class="fx_form column">
                                               <label>${lblDataXList[46].fValue}</label>
                                               <label>${lblDataYList[46].fValue}</label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tc">DO 203B15, 230B13, 205B13, 231B13</td>
                                    <td class="tc">DO 203B15, 230B13, 205B13, 231B13</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //form_table -->
                    </div>
                    <!-- //form_wrap -->
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
</body>
</html>

