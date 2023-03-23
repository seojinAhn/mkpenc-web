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
<script type="text/javascript" src="<c:url value="/resources/js/mimic.js" />" charset="utf-8"></script>
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
				<h3>LOAD CONTROL</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>LOAD CONTROL</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap load_control">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a href="#none" class="link_btn link_01"></a>
                <!-- ///range_slider -->              
                <div class="chart_block small wide" style="top:50px;left:140px;">
                    <h4>MAIN STEAM</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESS</span>
                                <label><c:if test="${lblDataList[0].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[0].fValue ne null}">${lblDataList[0].fValue}</c:if></label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label><c:if test="${lblDataList[1].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[1].fValue ne null}">${lblDataList[1].fValue}</c:if></label>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:136px;left:140px;">
                    <h4>FIRST STAGE</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESS</span>
                                <label><c:if test="${lblDataList[2].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[2].fValue ne null}">${lblDataList[2].fValue}</c:if></label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label><c:if test="${lblDataList[3].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[3].fValue ne null}">${lblDataList[3].fValue}</c:if></label>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:222px;left:140px;">
                    <h4>REHEATERINLET</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>PRESS</span>
                                <label><c:if test="${lblDataList[4].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[4].fValue ne null}">${lblDataList[4].fValue}</c:if></label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACT TEMP</span>
                                <label><c:if test="${lblDataList[5].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[5].fValue ne null}">${lblDataList[5].fValue}</c:if></label>
                                <span>deg C</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:60px;left:560px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>CV DEMAND</span>
                                <label><c:if test="${lblDataList[29].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[29].fValue ne null}">${lblDataList[29].fValue}</c:if></label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:290px;left:560px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>IV DEMAND</span>
                                <label><c:if test="${lblDataList[30].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[30].fValue ne null}">${lblDataList[30].fValue}</c:if></label>
                                <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:130px;left:390px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>1</span>
                                <label><c:if test="${lblDataList[21].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[21].fValue ne null}">${lblDataList[21].fValue}</c:if></label>
                                <span class="per">%</span>
                                <label><c:if test="${lblDataList[25].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[25].fValue ne null}">${lblDataList[25].fValue}</c:if></label>
                                <span class="per">%</span>
                            </p>
                            <p>
                                <span>2</span>
                                <label><c:if test="${lblDataList[22].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[22].fValue ne null}">${lblDataList[22].fValue}</c:if></label>
                                 <span class="per">%</span>
                                <label><c:if test="${lblDataList[26].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[26].fValue ne null}">${lblDataList[26].fValue}</c:if></label>
                                <span class="per">%</span>
                            </p>
                            <p>
                                <span>3</span>
                                <label><c:if test="${lblDataList[23].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[23].fValue ne null}">${lblDataList[23].fValue}</c:if></label>
                                <span class="per">%</span>
                                <label><c:if test="${lblDataList[27].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[27].fValue ne null}">${lblDataList[27].fValue}</c:if></label>
                                 <span class="per">%</span>
                            </p>
                            <p>
                                <span>4</span>
                                <label><c:if test="${lblDataList[24].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[24].fValue ne null}">${lblDataList[24].fValue}</c:if></label>
                                 <span class="per">%</span>
                                <label><c:if test="${lblDataList[28].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[28].fValue ne null}">${lblDataList[28].fValue}</c:if></label>
                                 <span class="per">%</span>
                            </p>
                        </div>
                    </div>
                </div>                
                <div class="chart_block small wide" style="top:50px;left:800px;">
                    <div class="chart_block_contents only_box">
                        <div class="summary">
                            <p>
                                <span>BREAKER</span>
                                <label><c:if test="${lblDataList[31].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[31].fValue ne null}">${lblDataList[31].fValue}</c:if></label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPEED</span>
                                <label><c:if test="${lblDataList[32].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[32].fValue ne null}">${lblDataList[32].fValue}</c:if></label>
                                <span>rpm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MODE</span>
                                <label><c:if test="${lblDataList[33].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[33].fValue ne null}">${lblDataList[33].fValue}</c:if></label>
                                <span></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:50px;right:160px;">
                    <h4>GENERATOR</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[34].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[34].fValue ne null}">${lblDataList[34].fValue}</c:if></label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[35].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[35].fValue ne null}">${lblDataList[35].fValue}</c:if></label>
                                <span>MVAR</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[36].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[36].fValue ne null}">${lblDataList[36].fValue}</c:if></label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[37].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[37].fValue ne null}">${lblDataList[37].fValue}</c:if></label>
                                <span>Hz</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <label><c:if test="${lblDataList[38].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[38].fValue ne null}">${lblDataList[38].fValue}</c:if></label>
                                <span>PF</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small half" style="top:330px;left:140px;">
                    <h4>AUTO TURBINE STARTUP</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>RECOM ACC</span>
                                <label><c:if test="${lblDataList[6].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[6].fValue ne null}">${lblDataList[6].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LOADING RATE</span>
                                <label><c:if test="${lblDataList[7].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[7].fValue ne null}">${lblDataList[7].fValue}</c:if></label>
                                <span>MW/MIN</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MAX STRESS</span>
                                <label><c:if test="${lblDataList[8].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[8].fValue ne null}">${lblDataList[8].fValue}</c:if></label>
                                <span>PCT</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPEED / LOAD HOLD</span>
                                <label><c:if test="${lblDataList[9].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[9].fValue ne null}">${lblDataList[9].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SPEED / LOAD STAT</span>
                                <label><c:if test="${lblDataList[10].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[10].fValue ne null}">${lblDataList[10].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>TURBINE LIMIT STAT</span>
                                <label><c:if test="${lblDataList[11].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[11].fValue ne null}">${lblDataList[11].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>LOAD CONTROL MODE</span>
                                <label><c:if test="${lblDataList[12].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[12].fValue ne null}">${lblDataList[12].fValue}</c:if></label>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>TSPL_P</span>
                                <label><c:if test="${lblDataList[13].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[13].fValue ne null}">${lblDataList[13].fValue}</c:if></label>
                                <span>AT</span>
                                <label><c:if test="${lblDataList[15].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[15].fValue ne null}">${lblDataList[15].fValue}</c:if></label>
                                <span>bar</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MWL</span>
                                <label><c:if test="${lblDataList[14].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[14].fValue ne null}">${lblDataList[14].fValue}</c:if></label>
                                <span>AT</span>
                                <label><c:if test="${lblDataList[16].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[16].fValue ne null}">${lblDataList[16].fValue}</c:if></label>
                                <span>MW</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>VPL</span>
                                <label><c:if test="${lblDataList[17].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[17].fValue ne null}">${lblDataList[17].fValue}</c:if></label>
                                <span>%</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>TRIP SYSTEM STAT</span>
                                <label><c:if test="${lblDataList[18].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[18].fValue ne null}">${lblDataList[18].fValue}</c:if></label>
                                <span></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MAX VIBRATION</span>
                                <label><c:if test="${lblDataList[19].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[19].fValue ne null}">${lblDataList[19].fValue}</c:if></label>
                                <span>mm</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ACCELERATION</span>
                                <label><c:if test="${lblDataList[20].fValue eq null}">0</c:if>
                                <c:if test="${lblDataList[20].fValue ne null}">${lblDataList[20].fValue}</c:if></label>
                                <span>RPM/M</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="fx_layout no_mg" style="position:absolute;top:330px;left:660px;width:560px;height:366px;">
                    <div class="fx_block">
                        <div class="chart_block small fx_full">
                            <h4>VPL</h4>
                            <div class="chart_block_contents">
                                <div class="switch_button">
	                                <c:if test="${lblDataList[43].fValue eq 1}">
	                                    <input type="radio" id="cancel_vpl" name="switch_vpl" value="" checked/>
	                                    <label for="cancel_vpl" title="${MarkTagInfoList[43].toolTip}">CANCEL</label>
	                                </c:if>
	                                <c:if test="${lblDataList[43].fValue ne 1}">
	                                    <input type="radio" id="cancel_vpl" name="switch_vpl" value=""/>
	                                    <label for="cancel_vpl">CANCEL</label>
	                                </c:if>
	                                
	                                <c:if test="${lblDataList[44].fValue eq 1}">
	                                    <input type="radio" id="control_vpl" name="switch_vpl" value="" checked />
	                                    <label for="control_vpl" title="${MarkTagInfoList[43].toolTip}">CONTROL</label>
	                                </c:if>
	                                 <c:if test="${lblDataList[44].fValue ne 1}">
	                                    <input type="radio" id="control_vpl" name="switch_vpl" value="" />
	                                    <label for="control_vpl">CONTROL</label>
	                                </c:if>
	                                   
	                                <c:if test="${lblDataList[45].fValue eq 1}">                                      
	                                    <input type="radio" id="track_vpl" name="switch_vpl" value="" checked/>
	                                    <label for="track_vpl"  title="${MarkTagInfoList[45].toolTip}">TRACK</label>
	                                </c:if>
	                                <c:if test="${lblDataList[45].fValue ne 1}">                                      
	                                    <input type="radio" id="track_vpl" name="switch_vpl" value="" />
	                                    <label for="track_vpl">TRACK</label>
	                                </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h4>GOV. NON-REGUL</h4>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                               		<c:if test="${lblDataList[46].fValue eq null || lblDataList[46].fValue eq 0}">
			                            <input type="radio" id="yes_gov" name="switch_gov" value="" checked/>
	                                    <label for="yes_gov" title="${MarkTagInfoList[46].toolTip}">OFF</label>
	                                    <input type="radio" id="no_gov" name="switch_gov" value="" />
	                                    <label for="no_gov">ON</label>
	                                </c:if>    
	                                <c:if test="${lblDataList[46].fValue ne null && lblDataList[46].fValue eq 1}">
		                                <input type="radio" id="yes_gov" name="switch_gov" value="" />
	                                    <label for="yes_gov" >OFF</label>
	                                    <input type="radio" id="no_gov" name="switch_gov" value="" checked/>
	                                    <label for="no_gov" title="${MarkTagInfoList[46].toolTip}" >ON</label>
	                                </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h4>MOTORING</h4>
                            <div class="chart_block_contents">
                                <div class="summary">
                                    <p>
                                        <label><c:if test="${lblDataList[39].fValue eq null}">0</c:if>
                                		<c:if test="${lblDataList[39].fValue ne null}">${lblDataList[39].fValue}</c:if></label>
                                        <span>MW</span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small fx_full">
                            <h4>LOAD STATUS</h4>
                            <div class="chart_block_contents">
                                <h6>LOAD HOLD</h6>
                                <div class="switch_button">
                                	<c:if test="${lblDataList[47].fValue eq null || lblDataList[47].fValue eq 0}">
			                            <input type="radio" id="yes_load" name="switch_load" value="" checked/>
	                                    <label for="yes_load" title="${MarkTagInfoList[47].toolTip}">OFF</label>
	                                    <input type="radio" id="no_load" name="switch_load" value="" />
	                                    <label for="no_load">ON</label>
	                                </c:if>    
	                                <c:if test="${lblDataList[47].fValue ne null && lblDataList[47].fValue eq 1}">
		                                <input type="radio" id="yes_load" name="switch_load" value="" />
	                                    <label for="yes_load">OFF</label>
	                                    <input type="radio" id="no_load" name="switch_load" value="" checked/>
	                                    <label for="no_load" title="${MarkTagInfoList[47].toolTip}">ON</label>
	                                </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h4>RAPID UN-LOAD</h4>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                <c:if test="${lblDataList[48].fValue eq null || lblDataList[48].fValue eq 0}">
                                    <input type="radio" id="yes_rapid" name="switch_rapid" value="" checked/>
                                    <label for="yes_rapid" title="${MarkTagInfoList[48].toolTip}">OFF</label>
                                    <input type="radio" id="no_rapid" name="switch_rapid" value="" />
                                    <label for="no_rapid">ON</label>
                                </c:if>
                                <c:if test="${lblDataList[48].fValue ne null && lblDataList[48].fValue eq 1}">
                                 	<input type="radio" id="yes_rapid" name="switch_rapid" value="" />
                                    <label for="yes_rapid">OFF</label>
                                    <input type="radio" id="no_rapid" name="switch_rapid" value="" checked/>
                                    <label for="no_rapid"  title="${MarkTagInfoList[48].toolTip}">ON</label>
                                </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="chart_block small fx_full">
                            <h4>M-WATT CONTROL</h4>
                            <div class="chart_block_contents">
                                <div class="switch_button">
                                	<c:if test="${lblDataList[49].fValue eq null || lblDataList[49].fValue eq 0}">
			                            <input type="radio" id="yes_watt" name="switch_watt" value="" checked/>
	                                    <label for="yes_watt" title="${MarkTagInfoList[49].toolTip}">OFF</label>
	                                    <input type="radio" id="no_watt" name="switch_watt" value="" />
	                                    <label for="no_watt">ON</label>
	                                </c:if>    
	                                <c:if test="${lblDataList[49].fValue ne null && lblDataList[49].fValue eq 1}">
		                                <input type="radio" id="yes_watt" name="switch_watt" value="" />
	                                    <label for="yes_watt">OFF</label>
	                                    <input type="radio" id="no_watt" name="switch_watt" value="" checked/>
	                                    <label for="no_watt" title="${MarkTagInfoList[49].toolTip}">ON</label>
	                                </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="fx_block">
                        <div class="chart_block small fx_full">
                            <h4>LOAD CONTROL</h4>
                            <div class="chart_block_contents fx_row" style="padding-top:11px;">
                                <div class="com_block">
                                    <h6>TARGET</h6>
                                    <div class="switch_button">
                                        <input type="radio" id="target" name="switch_target_rate" value="" />
                                        <label class="full" for="target">MW</label>
                                    </div>
                                    <div class="summary" style="height:56px;">
                                        <p>
                                            <label><c:if test="${lblDataList[40].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[40].fValue ne null}">${lblDataList[40].fValue}</c:if></label>
                                        </p>
                                    </div>
                                    <div class="switch_button">
                                    	<c:if test="${lblDataList[50].fValue eq 1}">
		                                    <input type="radio" id="target_raise" name="switch_target" value="" checked/>
                                        	<label class="full" for="target_raise" title="${MarkTagInfoList[50].toolTip}">RAISE</label>
		                                </c:if>
		                                <c:if test="${lblDataList[50].fValue ne 1}">
		                                  	<input type="radio" id="target_raise" name="switch_target" value=""/>
                                        <label class="full" for="target_raise">RAISE</label>
		                                </c:if>   
                                        <span class="ico_transper"></span>
                                        <c:if test="${lblDataList[51].fValue eq 1}">
		                                   	<input type="radio" id="target_lower" name="switch_target" value="" checked/>
                                        <label class="full" for="target_lower" title="${MarkTagInfoList[51].toolTip}">LOWER</label>
		                                </c:if>
		                                <c:if test="${lblDataList[51].fValue ne 1}">
		                                    <input type="radio" id="target_lower" name="switch_target" value="" />
                                        	<label class="full" for="target_lower">LOWER</label>
		                                </c:if>   
                                    </div>                                    
                                </div>
                                <div class="com_block">
                                    <h6>RATE</h6>
                                    <div class="switch_button">
                                        <input type="radio" id="rate" name="switch_target_rate" value="" />
                                        <label class="full" for="rate">MW/mn</label>
                                    </div>
                                    <div class="summary" style="height:56px;">
                                        <p>
                                            <label><c:if test="${lblDataList[41].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[41].fValue ne null}">${lblDataList[41].fValue}</c:if></label>
                                        </p>
                                        <p>
                                            <label><c:if test="${lblDataList[42].fValue eq null}">0</c:if>
                                			<c:if test="${lblDataList[42].fValue ne null}">${lblDataList[42].fValue}</c:if></label>
                                        </p>
                                    </div>
                                    <div class="switch_button">
                                    <c:if test="${lblDataList[52].fValue eq 1}">
		                                    <input type="radio" id="rate_raise" name="switch_rate" value="" checked/>
                                        	<label class="full" for="target_raise" title="${MarkTagInfoList[52].toolTip}">RAISE</label>
		                                </c:if>
		                                <c:if test="${lblDataList[52].fValue ne 1}">
		                                  	<input type="radio" id="rate_raise" name="switch_rate" value=""/>
                                        <label class="full" for="target_raise">RAISE</label>
		                                </c:if>   
                                        <span class="ico_transper"></span>
                                        <c:if test="${lblDataList[53].fValue eq 1}">
		                                   	<input type="radio" id="rate_lower" name="switch_rate" value="" checked/>
                                        <label class="full" for="target_lower" title="${MarkTagInfoList[53].toolTip}">LOWER</label>
		                                </c:if>
		                                <c:if test="${lblDataList[53].fValue ne 1}">
		                                    <input type="radio" id="rate_lower" name="switch_rate" value="" />
                                        	<label class="full" for="rate_lower">LOWER</label>
		                                </c:if> 
                                    </div>                                    
                                </div>
                            </div>
                        </div>
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
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

