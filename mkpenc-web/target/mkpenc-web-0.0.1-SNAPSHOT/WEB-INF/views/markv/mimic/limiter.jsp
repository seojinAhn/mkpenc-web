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
				<h3>LIMITER</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>LIMITER</strong></div>
			</div>
			<!-- //page_title -->

            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>THROTTLE STEAM PRESSURE LIMITER</h4>                    
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>NOT LIMTING</h6>
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:120px;height:180px;">차트</div>
                                                <div class="summary">
                                                    <p>
                                                        <label>0</label>
                                                        <span>bar</span>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="fx_block middle">
                                                <div class="switch_button">
                                                    <input type="radio" id="steam_raise" name="switch_steam" value="" checked/>
                                                    <label class="full" for="steam_raise">RAISE</label>
                                                    <input type="radio" id="steam_lower" name="switch_steam" value="" />
                                                    <label class="full" for="steam_lower">LOWER</label>
                                                    <input type="radio" id="steam_on" name="switch_steam" value="" />
                                                    <label class="full" for="steam_on">ON</label>
                                                    <input type="radio" id="steam_off" name="switch_steam" value="" />
                                                    <label class="full" for="steam_off">OFF</label>
                                                </div>     
                                            </div>                                       
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h6>THROTTLE</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>bar</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>FIRST STAGE</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>bar</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>VALVE POSITION LIMITER</h4>                    
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>NOT LIMTING</h6>
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:120px;height:180px;">차트</div>
                                                <div class="summary">
                                                    <p>
                                                        <label>0</label>
                                                        <span>%</span>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="fx_block middle">
                                                <div class="switch_button">
                                                    <input type="radio" id="valve_raise" name="switch_valve" value="" checked/>
                                                    <label class="full" for="valve_raise">RAISE</label>
                                                    <input type="radio" id="valve_lower" name="switch_valve" value="" />
                                                    <label class="full" for="valve_lower">LOWER</label>
                                                    <input type="radio" id="valve_on" name="switch_valve" value="" />
                                                    <label class="full" for="valve_on">FAST</label>
                                                    <input type="radio" id="valve_off" name="switch_valve" value="" />
                                                    <label class="full" for="valve_off">SLOW</label>
                                                </div>     
                                            </div>                                       
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h6>FLOW DEMAND</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>LOAD REFERENCE</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>SPEED</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>rpm</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h5>VPL SELECTION</h5>
                        </div>
                        <div class="line_table_block">
                            <div class="block_item">
                                <div class="switch_button fx_nowrap">
                                    <input type="radio" id="vpl_cancel" name="switch_vpl" value="" checked/>
                                    <label for="vpl_cancel">CANCEL</label>
                                    <input type="radio" id="vpl_control" name="switch_vpl" value="" />
                                    <label for="vpl_control">CONTROL</label>
                                    <input type="radio" id="vpl_track" name="switch_vpl" value="" />
                                    <label for="vpl_track">TRACK</label>
                                </div>
                            </div>
                        </div>
                    </div>                      
                </div>
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>MEGAWATT LIMITER</h4>                    
                        <div class="chart_wrap_area">
                            <div class="barchart_layout no_line">
                                <div class="barchart_block">
                                    <div class="barchart_item">
                                        <h6>NOT LIMTING</h6>
                                        <div class="fx_layout">
                                            <div class="fx_block">
                                                <div class="barchart" style="width:120px;height:180px;">차트</div>
                                                <div class="summary">
                                                    <p>
                                                        <label>0</label>
                                                        <span>MW</span>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="fx_block middle">
                                                <div class="switch_button">
                                                    <input type="radio" id="megawatt_raise" name="switch_megawatt" value="" checked/>
                                                    <label class="full" for="megawatt_raise">RAISE</label>
                                                    <input type="radio" id="megawatt_lower" name="switch_megawatt" value="" />
                                                    <label class="full" for="megawatt_lower">LOWER</label>
                                                    <input type="radio" id="megawatt_on" name="switch_megawatt" value="" />
                                                    <label class="full" for="megawatt_on">ON</label>
                                                    <input type="radio" id="megawatt_off" name="switch_megawatt" value="" />
                                                    <label class="full" for="megawatt_off">OFF</label>
                                                </div>     
                                            </div>                                       
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h6>LOAD</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>MW</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>MEGAWATT TARGET</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>MW</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //fx_layout -->
                
		</div>
		<!-- //contents -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

