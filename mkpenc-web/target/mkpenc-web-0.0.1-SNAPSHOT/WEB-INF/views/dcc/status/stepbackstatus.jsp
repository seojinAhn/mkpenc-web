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
<script type="text/javascript" src="<c:url value="/resources/js/status.js" />" charset="utf-8"></script>

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
				<h3>STEPBACK STATUS</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>STEPBACK STATUS</strong></div>
			</div>
			<!-- //page_title -->
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_1');">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->
				<!-- form_head -->
				<div class="form_head">
					<div class="form_info">
                        <div class="fx_legend">
                            <ul>
                                <li class="title">INDICATOR</li>
                                <li class="no">NO</li>
                                <li class="yes">YES</li>
                                <li class="cond_out">COND-OUT</li>
                            </ul>
                        </div>
                        <div class="fx_legend txt_type">
                            <ul>
                                <li class="title">MCA</li>
                                <li>1) -0.08</li>
                                <li>2) 0.06</li>
                                <li>3) -0.05</li>
                                <li>4) 0.01</li>
                            </ul>
                        </div>
					</div>
				</div>
				<!-- //form_head -->                      
                <!-- form_table -->
                <table class="form_table">
                    <colgroup>
                        <col />
                        <col width="200px" />
                        <col width="100px" />
                        <col width="200px" />
                        <col width="100px" />
                        <col width="200px" />
                        <col width="200px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>PARAMETER</th>
                            <th>SETPOINT</th>
                            <th colspan="4">STATUS</th>
                            <th>END FP</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span class="st_label st_no"></span>
                                    <label>RX TRIP</label>
                                </div>
                            </th>
                            <td class="tc">-----------</td>
                            <th class="tc">SDS #1</th>
                            <td class="tc">NO</td>
                            <th class="tc">SDS #2</th>
                            <td class="tc">NO</td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label class="double">0.0</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span class="st_label st_no"></span>
                                    <label>PHT 1P TRIP</label>
                                </div>
                            </th>
                            <td class="tc">-----------</td>
                            <th class="tc">PHP #1</th>
                            <td class="tc">ON</td>
                            <th class="tc">PHP #2</th>
                            <td class="tc">ON</td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label class="double">0.01</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span class="st_label st_no"></span>
                                    <label>PHT 2P TRIP</label>
                                </div>
                            </th>
                            <td class="tc">-----------</td>
                            <th class="tc">PHP #3</th>
                            <td class="tc">ON</td>
                            <th class="tc">PHP #4</th>
                            <td class="tc">ON</td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label class="double">0.0</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span class="st_label st_no"></span>
                                    <label>MOD LVL LO</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">750</label>
                                    <label class="full">M</label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label class="double flex_end">783.65</label>
                                    <label class="full"></label>
                                </div>   
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label class="double">0.0</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span class="st_label st_no"></span>
                                    <label>LOG RATE HI</label>
                                </div>
                            </th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="full flex_end">0.0342</label>
                                    <label class="full">D/S</label>
                                </div>                                
                            </td>
                            <td class="tc" colspan="4">
                                <div class="fx_form">
                                    <label class="double flex_end">-0.000095</label>
                                    <label class="full"></label>
                                </div>   
                            </td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label class="double">0.0</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2">
                                <div class="fx_form">
                                    <span class="st_label st_yes"></span>
                                    <label>SG LVL LO</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="2">
                                <div class="fx_form">
                                    <label class="full flex_end">1.37</label>
                                    <label class="full">M</label>
                                </div>                                  
                            </td>
                            <th class="tc">SG #1</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">2.015</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">SG #2</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td rowspan="2">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label class="double">0.0005</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">SG #3</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">2.015</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">SG #4</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2">
                                <div class="fx_form">
                                    <span class="st_label st_cond_out"></span>
                                    <label>HT PR HI</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="2">
                                <div class="fx_form">
                                    <label class="full flex_end">10.24</label>
                                    <label class="full">MPA</label>
                                </div>                                  
                            </td>
                            <th class="tc">ROH #1</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">2.015</label>
                                    <label class="full"></label>
                                </div>                                  
                            </td>
                            <th class="tc">ROH #2</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>                                  
                            </td>
                            <td rowspan="2">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label class="double">0.0005</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">ROH #3</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">2.015</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">ROH #4</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="7">
                                <div class="fx_form">
                                    <span class="st_label st_no"></span>
                                    <label>ZONE PWR HI</label>
                                </div>
                            </th>
                            <td class="tc" rowspan="7">
                                <div class="fx_form_column">
                                    <div class="fx_form">
                                        <label class="full flex_end">1.08</label>
                                        <label class="full">MPA</label>
                                    </div>
                                    <div class="fx_form">
                                        <label class="full flex_center">AT LEAST</label>
                                    </div>
                                    <div class="fx_form">
                                        <label class="full flex_center">4 OF 14</label>
                                    </div>
                                </div>
                            </td>
                            <th class="tc">Z #01</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">0.83336</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #08</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <td rowspan="7">
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label class="double">0.0</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #02</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">0.83336</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #09</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #03</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">0.83336</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #10</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #04</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">0.83336</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #11</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #05</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">0.83336</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #12</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #06</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">0.83336</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #13</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="tc bd_l_line">Z #07</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">0.83336</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                            <th class="tc">Z #14</th>
                            <td class="tc">
                                <div class="fx_form">
                                    <label class="double flex_end">1.963</label>
                                    <label class="full"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <div class="fx_form">
                                    <span class="st_label st_no"></span>
                                    <label>TEST</label>
                                </div>
                            </th>
                            <td class="tc"></td>
                            <td class="tc" colspan="4">NO</td>
                            <td>
                                <div class="fx_form">
                                    <label class="full"></label>
                                    <label class="double">0.02</label>
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
<div class="layer_pop_wrap large" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>엑셀로 저장</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">

        <!-- fx_layout -->
        <div class="fx_layout"> 
            <div class="fx_block">        
                <!-- form_wrap -->
                <div class="form_wrap">
                    <div class="form_head">
                        <h4>저장일자</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col width="120px"/>
                            <col />
                        </colgroup>
                        <tr>
                            <th>시작 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>끝 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
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
                    <div class="form_head">
                        <h4>주기</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">0.5초 데이타</label>
                                    <label><input type="radio" name="radio">5분 데이타</label>
                                    <label><input type="radio" name="radio">5초 데이타</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">1시간 데이타</label>
                                    <label><input type="radio" name="radio">1분 데이타</label>
                                    <label><input type="radio" name="radio">직접입력</label>
                                    <input type="text" class="tr fx_none" style="width:60px;">
                                    <label>초</label>
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
        <!-- file_upload -->
        <div class="fx_form file_upload">
            <div class="fx_form">
                <input type="text" />
                <a href="#none" class="btn_list">파일선택</a>
            </div>
        </div>
        <!-- //file_upload -->

	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>s
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

