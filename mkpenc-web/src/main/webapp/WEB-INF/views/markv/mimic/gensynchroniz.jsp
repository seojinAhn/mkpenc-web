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
				<h3>GEN SYNCHRONIZA</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>CONTROL</span><strong>GEN SYNCHRONIZA</strong></div>
			</div>
			<!-- //page_title -->

            <div class="gen_list">
                <h4>AUTO PERMISSIVES</h4>
                <ul>
                    <li>GENERATOR BKR SELECTED</li>
                    <li>SYNCH LOCKOUT (L86S)</li>
                    <li>BUS VOLTAGE</li>
                    <li>BUS FREQUENCY</li>
                    <li>GENERATOR VOLTAGE</li>
                    <li>GENERATOR FREQUENCY</li>
                    <li>DIFFERENCE VOLTS</li>
                    <li>DIFFERENCE FREQUENCY</li>
                    <li>SEQUENCING SYNC PERMIT</li>
                    <li>AUTO SYNC PERMIT</li>
                </ul>
            </div>
            <!-- fx_layout -->
            <div class="fx_layout w_full">
                <div class="fx_block">
                    <div class="chart_line_table">
                        <h4>METERING</h4>
                        <div class="line_table_block">
                            <h6>PHASE ANGEL</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>deg C</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>DIFFERENCE VOLTS</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6>SLIP FREQUENCY</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                    <span>%</span>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h5 class="double"></h5>
                            <h5>SURF TEMP</h5>
                            <h5>BORE TEMP RATE</h5>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">PRIMARY VOLTS(KV)</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">% RATED VOLTS</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                </p>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h6 class="double">FREQUENCY(Hz)</h6>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                </p>
                            </div>
                            <div class="summary">
                                <p>
                                    <label>0</label>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="chart_line_table">
                        <div class="line_table_block">
                            <h5 class="double">GENERATOR</h5>
                            <h5>BREAKER</h5>
                        </div>
                        <div class="line_table_block">
                            <div class="block_row double">
                                <div class="block_item_row">
                                    <h6>WAT TS</h6>
                                    <div class="summary">
                                        <p>
                                            <label>0</label>
                                            <span>%</span>
                                        </p>
                                    </div>
                                </div>
                                <div class="block_item_row">
                                    <h6>WAT TS</h6>
                                    <div class="summary">
                                        <p>
                                            <label>0</label>
                                            <span>%</span>
                                        </p>
                                    </div>
                                </div>
                                <div class="block_item_row">
                                    <h6>WAT TS</h6>
                                    <div class="summary">
                                        <p>
                                            <label>0</label>
                                            <span>%</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="summary full">
                                <p>
                                    <img src="../images/background/bkr.svg" style="width:100px;height:60px;">
                                    <label>0</label>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="fx_block center">
                    <div class="chart_line_table row">
                        <div class="line_table_block">
                            <h5>SYNCH MODE</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="synch_off" name="switch_synch" value="" checked/>
                                    <label class="full" for="synch_off">OFF</label>
                                    <input type="radio" id="synch_manual" name="switch_synch" value="" />
                                    <label class="full" for="synch_manual">MANUAL</label>
                                    <input type="radio" id="synch_moniter" name="switch_synch" value="" />
                                    <label class="full" for="synch_moniter">MONITER</label>
                                    <input type="radio" id="synch_auto" name="switch_synch" value="" />
                                    <label class="full" for="synch_auto">AUTO</label>
                                </div>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h5>MANUAL MODE</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="manual_raise_spd" name="switch_manual" value="" checked/>
                                    <label class="full" for="manual_raise_spd">RAISE SPD/LD</label>
                                    <input type="radio" id="manual_lower_spd" name="switch_manual" value="" />
                                    <label class="full" for="manual_lower_spd">LOWER SPD/LD</label>
                                    <input type="radio" id="manual_raise_kv" name="switch_manual" value=""/>
                                    <label class="full" for="manual_raise_kv">RAISE KV/VAR</label>
                                    <input type="radio" id="manual_lower_kv" name="switch_manual" value="" />
                                    <label class="full" for="manual_lower_kv">LOWER KV/VAR</label>
                                </div>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h5>VOLT MATCH</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="volt_main" name="switch_volt" value="" checked/>
                                    <label class="full" for="volt_main">MAIN</label>
                                    <input type="radio" id="volt_auto" name="switch_volt" value="" />
                                    <label class="full" for="volt_auto">AUTO</label>
                                </div>
                            </div>
                            <h5>REMOTE</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="checkbox" id="remote" name="switch_remote" value="" checked/>
                                    <label class="full" for="remote">REMOTE</label>
                                </div>
                            </div>
                        </div>
                        <div class="line_table_block">
                            <h5>SPEED MATCH</h5>
                            <div class="block_item">
                                <div class="switch_button">
                                    <input type="radio" id="speed_manual" name="switch_speed" value="" checked/>
                                    <label class="full" for="speed_manual">MANUAL</label>
                                    <input type="radio" id="speed_auto" name="switch_speed" value="" />
                                    <label class="full" for="speed_auto">AUTO</label>
                                    <input type="radio" id="speed_slip" name="switch_speed" value="" />
                                    <label class="full" for="speed_slip">SLIP</label>
                                </div>
                                <div class="summary">
                                    <p>
                                        <label>0</label>
                                    </p>
                                </div>                                 
                            </div>
                        </div>
                    </div>                      
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
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

