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
 		var	comSubmit	=	new ComSubmit("dccselfcheckFrm");
		comSubmit.setUrl("/dcc/performance/dccselfcheck");
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
				<h3>DCC SELF CHECK</h3>
				<div class="bc"><span>DCC</span><span>Perfomance</span><strong>DCC SELF CHECK</strong></div>
			</div>
			<!-- //page_title -->
			<form id="dccselfcheckFrm" name="dccselfcheckFrm">	</form>
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- form_wrap -->
                    <div class="form_wrap">
                        <!-- form_head -->
                        <div class="form_head">
                            <h4>DDC X</h4>
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
                            </colgroup>
                            <tr>
                                <th>Program Failure</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full"><a href="javascript:openLayer('modal_1')">DO 217B14</a></label>
                                        <label class="full flex_end">${lblDataXList[0].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>Availability Recorder</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">AI 1365</label>
                                        <label class="full flex_end">${lblDataXList[1].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="tc">A0 - AI Self Check</th>
                            </tr>
                            <tr>
                                <td class="tc">AO 335 / AI 1332</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">${lblDataXList[2].fValue}</label>
                                        <label class="full flex_end">${lblDataXList[3].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">AO 342 / AI 2457</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">${lblDataXList[4].fValue}</label>
                                        <label class="full flex_end">${lblDataXList[5].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">AO 364 / AI 3077</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">${lblDataXList[6].fValue}</label>
                                        <label class="full flex_end">${lblDataXList[7].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
                            <colgroup>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th colspan="3" class="tc">D0 - DI Self Check</th>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 200B08</label>
                                        <label class="full flex_end">${lblDataXList[8].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 40B00</label>
                                        <label class="full flex_end">${lblDataXList[9].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 66B15</label>
                                        <label class="full flex_end">${lblDataXList[10].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 212B13</label>
                                        <label class="full flex_end">${lblDataXList[11].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 61B01</label>
                                        <label class="full flex_end">${lblDataXList[12].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 45B05</label>
                                        <label class="full flex_end">${lblDataXList[13].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 221B09</label>
                                        <label class="full flex_end">${lblDataXList[14].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 55B15</label>
                                        <label class="full flex_end">${lblDataXList[15].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 73B11</label>
                                        <label class="full flex_end">${lblDataXList[16].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 233B14</label>
                                        <label class="full flex_end">${lblDataXList[17].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 52B10</label>
                                        <label class="full flex_end">${lblDataXList[18].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 70B14</label>
                                        <label class="full flex_end">${lblDataXList[19].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 242B10</label>
                                        <label class="full flex_end">${lblDataXList[20].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 114B12</label>
                                        <label class="full flex_end">${lblDataXList[21].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 102B02</label>
                                        <label class="full flex_end">${lblDataXList[22].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 247B12</label>
                                        <label class="full flex_end">${lblDataXList[23].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 107B07</label>
                                        <label class="full flex_end">${lblDataXList[24].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 111B13</label>
                                        <label class="full flex_end">${lblDataXList[25].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
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
                            </colgroup>
                            <tr>
                                <th colspan="9" class="tc">AI Reference Voltage</th>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT01 (-4.9)</th>
                                <th colspan="3" class="stitle tc">POT02 (+4.9)</th>
                                <th colspan="3" class="stitle tc">POT03 (-1.25)</th>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataXList[0].BackColor}">${lblDataXList[26].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[1].BackColor}">${lblDataXList[27].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[2].BackColor}">${lblDataXList[28].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[3].BackColor}">${lblDataXList[29].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[4].BackColor}">${lblDataXList[30].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[5].BackColor}">${lblDataXList[31].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[6].BackColor}">${lblDataXList[32].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[7].BackColor}">${lblDataXList[33].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[8].BackColor}">${lblDataXList[34].fValue}</td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT04 (+1.25)</th>
                                <th colspan="3" class="stitle tc">POT05 (+2.5)</th>
                                <th colspan="3" class="stitle tc">POT06 (-4.9)</th>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataXList[9].BackColor}">${lblDataXList[35].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[10].BackColor}">${lblDataXList[36].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[11].BackColor}">${lblDataXList[37].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[12].BackColor}">${lblDataXList[38].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[13].BackColor}">${lblDataXList[39].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[14].BackColor}">${lblDataXList[40].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[15].BackColor}">${lblDataXList[41].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[16].BackColor}">${lblDataXList[42].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[17].BackColor}">${lblDataXList[43].fValue}</td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT07 (+1.25)</th>
                                <th colspan="3" class="stitle tc">POT08 (+4.9)</th>
                                <th colspan="3" class="stitle tc">POT09 (-0.5)</th>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataXList[18].BackColor}">${lblDataXList[44].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[19].BackColor}">${lblDataXList[45].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[20].BackColor}">${lblDataXList[46].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[21].BackColor}">${lblDataXList[47].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[22].BackColor}">${lblDataXList[48].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[23].BackColor}">${lblDataXList[49].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[24].BackColor}">${lblDataXList[50].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[25].BackColor}">${lblDataXList[51].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[26].BackColor}">${lblDataXList[52].fValue}</td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT10 (+0.5)</th>
                                <th colspan="3" class="stitle tc">POT11 (-4.9)</th>
                                <th colspan="3" class="stitle tc">POT12 (+1.25)</th>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataXList[27].BackColor}">${lblDataXList[53].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[28].BackColor}">${lblDataXList[54].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[29].BackColor}">${lblDataXList[55].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[30].BackColor}">${lblDataXList[56].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[31].BackColor}">${lblDataXList[57].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[32].BackColor}">${lblDataXList[58].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[33].BackColor}">${lblDataXList[59].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[34].BackColor}">${lblDataXList[60].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[35].BackColor}">${lblDataXList[61].fValue}</td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT13 (-1.25)</th>
                                <th colspan="3" class="stitle tc">POT14 (+2.5)</th>
                                <td colspan="3"></td>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataXList[36].BackColor}">${lblDataXList[62].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[37].BackColor}">${lblDataXList[63].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[38].BackColor}">${lblDataXList[64].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[39].BackColor}">${lblDataXList[65].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[40].BackColor}">${lblDataXList[66].fValue}</td>
                                <td class="tc" bgcolor="${shpDataXList[41].BackColor}">${lblDataXList[67].fValue}</td>
                                <td colspan="3" class="bd_t_none"></td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>C/S Self Check</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 236B14</label>
                                        <label class="full flex_end">${lblDataXList[68].fValue}</label>
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
                        <!-- form_head -->
                        <div class="form_head">
                            <h4>DDC Y</h4>
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
                            <tr>
                                <th>Program Failure</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 217B14</label>
                                        <label class="full flex_end">${lblDataYList[0].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>Availability Recorder</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">AI 1365</label>
                                        <label class="full flex_end">${lblDataYList[1].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2" class="tc">A0 - AI Self Check</th>
                            </tr>
                            <tr>
                                <td class="tc">A0 335 / AI 1332</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">${lblDataYList[2].fValue}</label>
                                        <label class="full flex_end">${lblDataYList[3].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">AO 342 / AI 2457</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">${lblDataYList[4].fValue}</label>
                                        <label class="full flex_end">${lblDataYList[5].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">AO 364 / AI 3077</td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full flex_end">${lblDataYList[6].fValue}</label>
                                        <label class="full flex_end">${lblDataYList[7].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
                            <colgroup>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th colspan="3" class="tc">D0 - DI Self Check</th>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 200B08</label>
                                        <label class="full flex_end">${lblDataYList[8].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 40B00</label>
                                        <label class="full flex_end">${lblDataYList[9].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 66B15</label>
                                        <label class="full flex_end">${lblDataYList[10].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 212B13</label>
                                        <label class="full flex_end">${lblDataYList[11].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 61B01</label>
                                        <label class="full flex_end">${lblDataYList[12].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 45B05</label>
                                        <label class="full flex_end">${lblDataYList[13].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 221B09</label>
                                        <label class="full flex_end">${lblDataYList[14].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 55B15</label>
                                        <label class="full flex_end">${lblDataYList[15].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 73B11</label>
                                        <label class="full flex_end">${lblDataYList[16].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 233B14</label>
                                        <label class="full flex_end">${lblDataYList[17].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 52B10</label>
                                        <label class="full flex_end">${lblDataYList[18].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 70B14</label>
                                        <label class="full flex_end">${lblDataYList[19].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 242B10</label>
                                        <label class="full flex_end">${lblDataYList[20].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 114B12</label>
                                        <label class="full flex_end">${lblDataYList[21].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 102B02</label>
                                        <label class="full flex_end">${lblDataYList[22].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 247B12</label>
                                        <label class="full flex_end">${lblDataYList[23].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 107B07</label>
                                        <label class="full flex_end">${lblDataYList[24].fValue}</label>
                                    </div>
                                </td>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DI 111B13</label>
                                        <label class="full flex_end">${lblDataYList[25].fValue}</label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
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
                            </colgroup>
                            <tr>
                                <th colspan="9" class="tc">AI Reference Voltage</th>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT01 (-4.9)</th>
                                <th colspan="3" class="stitle tc">POT01 (+4.9)</th>
                                <th colspan="3" class="stitle tc">POT03 (-1.25)</th>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataYList[0].BackColor}">${lblDataYList[26].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[1].BackColor}">${lblDataYList[27].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[2].BackColor}">${lblDataYList[28].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[3].BackColor}">${lblDataYList[29].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[4].BackColor}">${lblDataYList[30].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[5].BackColor}">${lblDataYList[31].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[6].BackColor}">${lblDataYList[32].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[7].BackColor}">${lblDataYList[33].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[8].BackColor}">${lblDataYList[34].fValue}</td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT04 (+1.25)</th>
                                <th colspan="3" class="stitle tc">POT05 (+2.5)</th>
                                <th colspan="3" class="stitle tc">POT06 (-4.9)</th>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataYList[9].BackColor}">${lblDataYList[35].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[10].BackColor}">${lblDataYList[36].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[11].BackColor}">${lblDataYList[37].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[12].BackColor}">${lblDataYList[38].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[13].BackColor}">${lblDataYList[39].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[14].BackColor}">${lblDataYList[40].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[15].BackColor}">${lblDataYList[41].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[16].BackColor}">${lblDataYList[42].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[17].BackColor}">${lblDataYList[43].fValue}</td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT07 (+1.25)</th>
                                <th colspan="3" class="stitle tc">POT08 (+4.9)</th>
                                <th colspan="3" class="stitle tc">POT09 (-0.5)</th>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataYList[19].BackColor}">${lblDataYList[44].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[19].BackColor}">${lblDataYList[45].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[20].BackColor}">${lblDataYList[46].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[21].BackColor}">${lblDataYList[47].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[22].BackColor}">${lblDataYList[48].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[23].BackColor}">${lblDataYList[49].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[24].BackColor}">${lblDataYList[50].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[25].BackColor}">${lblDataYList[51].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[26].BackColor}">${lblDataYList[52].fValue}</td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT10 (+0.5)</th>
                                <th colspan="3" class="stitle tc">PPOT11 (-4.9)</th>
                                <th colspan="3" class="stitle tc">POT12 (+1.25)</th>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataYList[27].BackColor}">${lblDataYList[53].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[28].BackColor}">${lblDataYList[54].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[29].BackColor}">${lblDataYList[55].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[30].BackColor}">${lblDataYList[56].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[31].BackColor}">${lblDataYList[57].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[32].BackColor}">${lblDataYList[58].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[33].BackColor}">${lblDataYList[59].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[34].BackColor}">${lblDataYList[60].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[35].BackColor}">${lblDataYList[61].fValue}</td>
                            </tr>
                            <tr>
                                <th colspan="3" class="stitle tc">POT13 (-1.25)</th>
                                <th colspan="3" class="stitle tc">POT14 (+2.5)</th>
                                <td colspan="3"></td>
                            </tr>                            
                            <tr>
                                <td class="tc" bgcolor="${shpDataYList[36].BackColor} ">${lblDataYList[62].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[37].BackColor}">${lblDataYList[63].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[38].BackColor}">${lblDataYList[64].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[39].BackColor}">${lblDataYList[65].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[40].BackColor}">${lblDataYList[66].fValue}</td>
                                <td class="tc" bgcolor="${shpDataYList[41].BackColor}">${lblDataYList[67].fValue}</td>
                                <td colspan="3" class="bd_t_none"></td>
                            </tr>
                        </table>
                        <!-- //form_table -->
                        <!-- form_table -->
                        <table class="form_table mt_none">
                            <colgroup>
                                <col />
                                <col />
                            </colgroup>
                            <tr>
                                <th>C/S Self Check</th>
                                <td class="tc">
                                    <div class="fx_form">
                                        <label class="full">DO 236B14</label>
                                        <label class="full flex_end">${lblDataYList[68].fValue}</label>
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
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col />
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th colspan="4" class="tc">DCC Available Cross Connection (DCCX ＜ － ＞ DCCY)</th>
                        </tr>
                        <tr>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DO 201B15</label>
                                    <label class="full flex_end">${lblDataXList[69].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DI 52B04</label>
                                    <label class="full flex_end">${lblDataYList[72].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DO 210B15</label>
                                    <label class="full flex_end">${lblDataYList[69].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DI 52B04</label>
                                    <label class="full flex_end">${lblDataXList[72].fValue}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DO 202B12</label>
                                    <label class="full flex_end">${lblDataXList[70].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DI 63B14</label>
                                    <label class="full flex_end">${lblDataYList[73].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DO 202B12</label>
                                    <label class="full flex_end">${lblDataYList[70].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DI 63B14</label>
                                    <label class="full flex_end">${lblDataXList[73].fValue}</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DO 231B09</label>
                                    <label class="full flex_end">${lblDataXList[71].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DI 66B02</label>
                                    <label class="full flex_end">${lblDataYList[74].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCY DO 231B09</label>
                                    <label class="full flex_end">${lblDataYList[71].fValue}</label>
                                </div>
                            </td>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full">DCCX DI 66B02</label>
                                    <label class="full flex_end">${lblDataXList[74].fValue}</label>
                                </div>
                            </td>
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


<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태그정보</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <form id="setIOForm" name="setIOForm">
            <input type ="hidden" id="iSeq" name="iSeq">
            <table class="list_table" id=setVarTable" name="setVarTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>DESCR</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                         <td><input type="text" id="hogi" name="hogi"></td>
                        <td><input type="text" id="xyGubun" name="xyGubun"></td>
                        <td><input type="text" id="descr" name="descr"></td>
                        <td><input type="text" id="ioType" name="ioType"></td>
                        <td><input type="text" id="addresss" name="addresss"></td>
                        <td><input type="text" id="ioBit" name="ioBit"></td>
                    </tr>
                </tbody>
            </table>
            </form>
             <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" onclick="openLayer('modal_2');">Tag Search</a>
				</div>
 				<div class="button">                    
                    <a href="#none" class="btn_page" id="saveVarTable" name="saveVarTable">저장</a>
        			<a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
                </div>
            </div>
            <!-- //list_bottom -->
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->
	</div>
	<!-- pop_contents -->
</div>
<!-- //layer_pop_wrap -->



<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태크목록</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <form id="tagSearchForm" name="tagSearchForm">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>검색어</th>
                    <td>
                        <div class="fx_form">
                          <input type="text" id="findData" name="findData">
                        </div>
                    </td>
                    <td>
	                    <div class="button">
	                    <a class="btn_list" href="#none" id="tagFind" name="tagFind">검색</a>
	                    </div>
                    </td>
                    <th>검색옵션</th>
                    <td>
	                	<div class="fx_form">
                          <input type="checkbox" id="chkOpt1" name="chkOpt1" value="1"> 태그명
                          <input type="checkbox" id="chkOpt2" name="chkOpt2" value="1" checked> 태그설명
                        </div>
                    </td>
                </tr>
            </table>
            </form>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table" id="tagSearchTable" name="tagSearchTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col />
                </colgroup>
                <thead>
                    <tr>
                        <th>UNIT</th>
                        <th>XY</th>
                        <th>LOOG NAME</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>DESCR</th>
                    </tr>
                </thead>
                <tbody id="tagSearchList" name="tagSearchList">
                <tr>
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
             <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" onclick="openLayer('modal_2');">전체리스트</a>
                </div>
                <div class="button">
                     <a href="#none" class="btn_page" id="tagSearchSelect" name="tagSearchSelect">선택</a>
        			 <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
                </div>
            </div>
            <!-- //list_bottom -->
        </div>
        <!-- //list_wrap -->       
	</div>
	<!-- pop_contents -->
</div>
<!-- //layer_pop_wrap -->


</body>
</html>

