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
<script type="text/javascript" src="<c:url value="/resources/js/main.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/login.js" />" charset="utf-8"></script>

<script type="text/javascript">
var hogiHeader = '${UserInfo.hogi}' != "undefined" && '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
var xyHeader = '${UserInfo.xyGubun}' != "undefined" && '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";

var timerOn = true;
var menuVisible = false;
var lblDataListAjax = {};
var DccTagInfoListAjax = {};


$(function () {
	$(document.body).delegate('#3', 'click', function() {
		hogiHeader = '3';
		
		var	comAjax	=	new ComAjax("dashboardFrm");
		comAjax.setUrl("/main/reloadDB");
		comAjax.addParam('sHogi',hogiHeader);
		comAjax.addParam('sXYGubun',xyHeader);
		comAjax.setCallback("mainCallback");
		comAjax.ajax();
		
		reloadData();
	});
	
	$(document.body).delegate('#4', 'click', function() {
		hogiHeader = '4';
		
		var	comAjax	=	new ComAjax("dashboardFrm");
		comAjax.setUrl("/main/reloadDB");
		comAjax.addParam('sHogi',hogiHeader);
		comAjax.addParam('sXYGubun',xyHeader);
		comAjax.setCallback("mainCallback");
		comAjax.ajax();
		
		reloadData();
	});
	
	$(document.body).delegate('#X', 'click', function() {
		xyHeader = 'X';
		
		var	comAjax	=	new ComAjax("dashboardFrm");
		comAjax.setUrl("/main/reloadDB");
		comAjax.addParam('sHogi',hogiHeader);
		comAjax.addParam('sXYGubun',xyHeader);
		comAjax.setCallback("mainCallback");
		comAjax.ajax();
		
		reloadData();
	});
	
	$(document.body).delegate('#Y', 'click', function() {
		xyHeader = 'Y';
		
		var	comAjax	=	new ComAjax("dashboardFrm");
		comAjax.setUrl("/main/reloadDB");
		comAjax.addParam('sHogi',hogiHeader);
		comAjax.addParam('sXYGubun',xyHeader);
		comAjax.setCallback("mainCallback");
		comAjax.ajax();
		
		reloadData();
	});
	
	if( '${BaseSearch.noLogin}' == 'Y' ) {
		if(timerOn) timerOn = false;
		
		openLayer('modal_login');
		$("#userId").focus();
	}
	
	$(document.body).delegate('#lnb_menu','click',function(e) {
		//console.log(e.target.tagName);
		if( e.target.tagName === 'A' ) {
			timerOn = false;
			var userInfo = '${UserInfo.id}';
			if( userInfo == null || userInfo == '' || typeof userInfo == 'undefined' ) {
				//openLayer('modal_login');
			}
		}
	});
	
	$(document.body).delegate('#closeLogin','click',function() {
		if( !timerOn ) timerOn = true;
	});
	
	$(document.body).delegate('#lzc','click',function() {
		closeMenu();
		location.replace('/dcc/mimic/lzc_1');
	});
	$(document.body).delegate('#fuel','click',function() {
		closeMenu();
		location.replace('/dcc/mimic/fuelhandlingmenu');
	});
	$(document.body).delegate('#radmain','click',function() {
		closeMenu();
		location.replace('/dcc/mimic/radmain');
	});
	$(document.body).delegate('#ecc','click',function() {
		closeMenu();
		location.replace('/dcc/mimic/ecc');
	});
	
	window.addEventListener("click", e => {
	  if( e.srcElement.id != 'menuLinks') {
		  closeMenu();
	  }
	});

	$(document.body).delegate('#mainsteam','mouseover',function() {
		$("#sgToggle").prop("class","toggle_block dp_flex");
	});
	$(document.body).delegate('#mainsteam','mouseout',function() {
		$("#sgToggle").prop("class","toggle_block");
	});

	$(document.body).delegate('#moderator','mouseover',function() {
		$("#modToggle").prop("class","toggle_block dp_flex");
	});
	$(document.body).delegate('#moderator','mouseout',function() {
		$("#modToggle").prop("class","toggle_block");
	});

	$(document.body).delegate('#menuLinks','mouseover',function() {
		$("#rxToggle").prop("class","toggle_block dp_flex");
	});
	$(document.body).delegate('#menuLinks','mouseout',function() {
		$("#rxToggle").prop("class","toggle_block");
	});

	$(document.body).delegate('#phtctrl','mouseover',function() {
		$("#pzrToggle").prop("class","toggle_block dp_flex");
	});
	$(document.body).delegate('#phtctrl','mouseout',function() {
		$("#pzrToggle").prop("class","toggle_block");
	});
	
	$(document.body).delegate('#menuLinks','blur',function() {
		if( menuVisible ) {
			//closeMenu();
			//menuVisible = false;
		}
	});
	
	$("#lblDate").text('${SearchTime}');
	$("#lblDate").css('color','${ForeColor}');
	
	//setTimer(10000);	 
		
});	

function setTimer(interval) {
	if( interval > 0 ) {
		setTimeout(function() {
			if( timerOn ) {
				//var	comSubmit	=	new ComSubmit("dashboardFrm");
				//comSubmit.setUrl("/main/dashboard");
				//comSubmit.submit();
				var	comAjax	=	new ComAjax("dashboardFrm");
				comAjax.setUrl("/main/reloadDB");
				comAjax.setCallback("mainCallback");
				comAjax.ajax();
				
				reloadData();
				
				setTimeout(function() {
					setTimer(interval);
				});
			}
		},interval);
	} else {
		//var	comSubmit	=	new ComSubmit("dashboardFrm");
		//comSubmit.setUrl("/main/dashboard");
		//comSubmit.submit();
		var	comAjax	=	new ComAjax("dashboardFrm");
		comAjax.setUrl("/main/reloadDB");
		comAjax.setCallback("mainCallback");
		comAjax.ajax();
		
		reloadData();
	}
}

function openMenu() {
	var comX = window.event.clientX + $("#mnuMain").outerWidth() > window.innerWidth ? window.innerWidth - $("#mnuMain").outerWidth() : window.event.clientX;
	var comY = window.event.clientY + $("#mnuMain").outerHeight() > window.innerHeight ? window.innerHeight - $("#mnuMain").outerHeight() : window.event.clientY;

	$("#mnuMain").css("top",comY);
	$("#mnuMain").css("left",comX);
	$("#mnuMain").css("display","block");
	
	menuVisible = true;
}

function closeMenu() {
	$("#mnuMain").css("display","none");
}

function reloadData() {
	for( var i=0;i<21;i++ ) {
		$("#lblData"+i).text(lblDataListAjax[i].fValue);
		$("#lblData"+i).prop("title",DccTagInfoListAjax[i].toolTip);
	}
}

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
		<form id="dashboardFrm" name="dashboardFrm">	</form>
			<div class="img_wrap dcc_main">
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <a id="phtctrl" href="/dcc/mimic/phtctrl" style="position:absolute;top:122px;left:479px;background:rgba(0,0,0,0);z-index:99;width:32px;height:70px"></a>
                <a id="moderator" href="/dcc/mimic/moderator" style="position:absolute;top:474px;left:480px;background:rgba(0,0,0,0);z-index:99;width:60px;height:43px"></a>
                <a id="menuLinks" href="#none" onclick="javascript:openMenu();" style="position:absolute;top:305px;left:373px;background:rgba(0,0,0,0);z-index:99;width:134px;height:113px"></a>
                <a id="mainsteam" href="/dcc/mimic/mainsteam" style="position:absolute;top:100px;left:557px;background:rgba(0,0,0,0);z-index:99;width:55px;height:135px"></a>
                <a id="pht" href="/dcc/mimic/pht" class="link_btn link_pht"></a>
                <a id="feedwater" href="/dcc/mimic/feedwater" class="link_btn link_bfp"></a>
                <a id="condensate" href="/dcc/mimic/condensate" class="link_btn link_cond"></a>
                <!-- ///range_slider -->              
                <div id="pzrToggle" class="toggle_block" style="top:100px;left:240px;">
                    <h4>PZR</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>METER</p>
                            <p>
                                <span>L</span>
                                <span><label id="lblData0" title="${DccTagInfoList[0].toolTip}">${lblDataList[0].fValue}</label></span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>MPGA</p>
                                <p>
                                    <span>P</span>
                                    <span><label id="lblData1" title="${DccTagInfoList[1].toolTip}">${lblDataList[1].fValue}</label></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="rxToggle" class="toggle_block" style="top:260px;left:140px;">
                    <h4>RX</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>FP</p>
                            <p>
                                <span>PWR</span>
                                <span><label id="lblData2" title="${DccTagInfoList[2].toolTip}">${lblDataList[2].fValue}</label></span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>%</p>
                                <p>
                                    <span>ZONE L</span>
                                    <span><label id="lblData3" title="${DccTagInfoList[3].toolTip}">${lblDataList[3].fValue}</label></span>
                                </p>
                            </li>
                            <li>
                                <p>FP</p>
                                <p>
                                    <span>PWR E</span>
                                    <span><label id="lblData4" title="${DccTagInfoList[4].toolTip}">${lblDataList[4].fValue}</label></span>
                                </p>
                            </li>
                            <li>
                                <p>DEC/S</p>
                                <p>
                                    <span>LOG R</span>
                                    <span><label id="lblData5" title="${DccTagInfoList[5].toolTip}">${lblDataList[5].fValue}</label></span>
                                </p>
                            </li>
                            <li>
                                <p>DECADE</p>
                                <p>
                                    <span>PLOG</span>
                                    <span><label id="lblData6" title="${DccTagInfoList[6].toolTip}">${lblDataList[6].fValue}</label></span>
                                </p>
                            </li>
                            <li>
                                <p>FP</p>
                                <p>
                                    <span>PTHM</span>
                                    <span><label id="lblData7" title="${DccTagInfoList[7].toolTip}">${lblDataList[7].fValue}</label></span>
                                </p>
                            </li>
                            <li>
                                <p>H/D P</p>
                                <p>
                                    <span>MPAG</span>
                                    <span><label id="lblData8" title="${DccTagInfoList[8].toolTip}">${lblDataList[8].fValue}</label></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>  
                <div id="modToggle" class="toggle_block" style="top:520px;left:560px;">
                    <h4>MOD</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MM</p>
                            <p>
                                <span>L</span>
                                <span><label id="lblData9" title="${DccTagInfoList[9].toolTip}">${lblDataList[9].fValue}</label></span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>MPGA</p>
                                <p>
                                    <span>T</span>
                                    <span><label id="lblData10" title="${DccTagInfoList[10].toolTip}">${lblDataList[10].fValue}</label></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>       
                <div id="sgToggle" class="toggle_block" style="top:80px;left:620px;">
                    <h4>S/G</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MPAG</p>
                            <p>
                                <span>P</span>
                                <span><label id="lblData11" title="${DccTagInfoList[11].toolTip}">${lblDataList[11].fValue}</label></span>
                            </p>
                        </div>
                        <ul>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>#1L</span>
                                    <span><label id="lblData12" title="${DccTagInfoList[12].toolTip}">${lblDataList[12].fValue}</label></span>
                                </p>
                            </li>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>#2L</span>
                                    <span><label id="lblData13" title="${DccTagInfoList[13].toolTip}">${lblDataList[13].fValue}</label></span>
                                </p>
                            </li>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>#3L</span>
                                    <span><label id="lblData14" title="${DccTagInfoList[14].toolTip}">${lblDataList[14].fValue}</label></span>
                                </p>
                            </li>
                            <li>
                                <p>METER</p>
                                <p>
                                    <span>#4L</span>
                                    <span><label id="lblData15" title="${DccTagInfoList[15].toolTip}">${lblDataList[15].fValue}</label></span>
                                </p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toggle_block" style="top:80px;right:190px;">
                    <h4>GE</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MW</p>
                            <p>
                                <span>PWR</span>
                                <span><label id="lblData16" title="${DccTagInfoList[16].toolTip}">${lblDataList[16].fValue}</label></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="toggle_block" style="top:260px;right:190px;">
                    <h4>CCW</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <span><label id="lblData17" title="${DccTagInfoList[17].toolTip}">${lblDataList[17].fValue}</label></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="toggle_block" style="top:350px;right:190px;">
                    <h4>COND</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>KPAA</p>
                            <p>
                                <span>VAC</span>
                                <span><label id="lblData18" title="${DccTagInfoList[18].toolTip}">${lblDataList[18].fValue}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <span><label id="lblData19" title="${DccTagInfoList[19].toolTip}">${lblDataList[19].fValue}</label></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="toggle_block" style="top:490px;right:190px;">
                    <h4>D/A</h4>
                    <div class="toggle_block_contents">
                        <div class="summary">
                            <p>MM</p>
                            <p>
                                <span>L</span>
                                <span><label id="lblData20" title="${DccTagInfoList[20].toolTip}">${lblDataList[20].fValue}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>DEG C</p>
                            <p>
                                <span>T</span>
                                <span><label id="lblData21" title="${DccTagInfoList[21].toolTip}">${lblDataList[21].fValue}</label></span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
		</div>
		<!-- //contents -->
	</div>
		<div class="context_menu" id="mnuMain" style="display:none;position:absolute;top:0px;left:0px">
			<ul>
				<li id="lzc"><a href="#none">LZC</a></li>
				<li id="fuel"><a href="#none">핵연료</a></li>
				<li id="radmain"><a href="#none">방관부</a></li>
				<li id="ecc"><a href="#none">ECC</a></li>
			</ul>
		</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->





</body>
</html>



