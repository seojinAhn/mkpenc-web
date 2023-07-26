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
<script type="text/javascript" src="<c:url value="/resources/jquery/jquery-3.6.0.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/modal.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/common.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/login.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/admin.js" />" charset="utf-8"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/jquery-ui-base-1.13.2.css" />">
<script type="text/javascript" src="<c:url value="/resources/jquery/jquery-ui-1.13.2.js" />" charset="utf-8"></script>

<script type="text/javascript">
var timerOn = false;
	var masterTypes = [
		'${masterStates[0].type}','${masterStates[1].type}','${masterStates[2].type}','${masterStates[3].type}',
		'${masterStates[4].type}','${masterStates[5].type}','${masterStates[6].type}','${masterStates[7].type}'
	];
	var masterToolTips = [
		'${masterStates[0].toolTip}','${masterStates[1].toolTip}','${masterStates[2].toolTip}','${masterStates[3].toolTip}',
		'${masterStates[4].toolTip}','${masterStates[5].toolTip}','${masterStates[6].toolTip}','${masterStates[7].toolTip}'
	];
	var masterStates = [
		'${masterStates[0].state}','${masterStates[1].state}','${masterStates[2].state}','${masterStates[3].state}',
		'${masterStates[4].state}','${masterStates[5].state}','${masterStates[6].state}','${masterStates[7].state}'
	];
	var slaveTypes = [
		'${slaveStates[0].type}','${slaveStates[1].type}','${slaveStates[2].type}','${slaveStates[3].type}',
		'${slaveStates[4].type}','${slaveStates[5].type}','${slaveStates[6].type}','${slaveStates[7].type}'
	];
	var slaveToolTips = [
		'${slaveStates[0].toolTip}','${slaveStates[1].toolTip}','${slaveStates[2].toolTip}','${slaveStates[3].toolTip}',
		'${slaveStates[4].toolTip}','${slaveStates[5].toolTip}','${slaveStates[6].toolTip}','${slaveStates[7].toolTip}'
	];
	var slaveStates = [
		'${slaveStates[0].state}','${slaveStates[1].state}','${slaveStates[2].state}','${slaveStates[3].state}',
		'${slaveStates[4].state}','${slaveStates[5].state}','${slaveStates[6].state}','${slaveStates[7].state}'
	];
	var masterStatesAjax = {};
	var slaveStatesAjax = {};
	
	$(function() {
		$("#lblDate").text('${ScanTime}');
		setStates(0);
		
		setTimer(5000);
	});
	
	function setTimer(interval) {
		setTimeout(function run() {
			var comAjax = new ComAjax("reloadFrm");
			comAjax.setUrl("/dcc/admin/reloadSysmonitoring");
			comAjax.setCallback("adminCallback");
			comAjax.ajax();
			
			setTimeout(run,interval);
		},interval);
	}
	
	function setDate(time,color) {
		$("#lblDate").text(time);
		$("#lblDate").css("color",color);
	}
	
	function setStates(type) {
		if( type == 0 ) {
			for( var m=0;m<8;m++ ) {
				var mType = masterTypes[m];
				var mToolTip = masterToolTips[m];
				var mState = masterStates[m];
				var sType = slaveTypes[m];
				var sToolTip = slaveToolTips[m];
				var sState = slaveStates[m];
				
				if( typeof mType == 'undefined' ) {
					setImageState('EEE','','OFF','m');
					setImageState('EEE','','OFF','s');
				} else {
					setImageState(mType,mToolTip,mState,'m');
					setImageState(sType,sToolTip,sState,'s');
				}
			}
		} else {
			for( var m=0;m<8;m++ ) {
				var mType = masterStatesAjax[m].type;
				var mToolTip = masterStatesAjax[m].toolTip;
				var mState = masterStatesAjax[m].state;
				var sType = slaveStatesAjax[m].type;
				var sToolTip = slaveStatesAjax[m].toolTip;
				var sState = slaveStatesAjax[m].state;
				
				if( typeof mType == 'undefined' ) {
					setImageState('EEE','','OFF','m');
					setImageState('EEE','','OFF','s');
				} else {
					setImageState(mType,mToolTip,mState,'m');
					setImageState(sType,sToolTip,sState,'s');
				}
			}
		}
	}
	
	function setImageState(id,toolTip,state,type) {
		if( type == 'm' ) {
			if( id == 'D3X' ) {
				if( state == 'ON' ) {
					$("#3xdccM").css("display","");
				} else {
					$("#3xdccM").css("display","none");
				}
				$("#3xdccML").prop("title",toolTip);
			}
			if( id == 'D3Y' ) {
				if( state == 'ON' ) {
					$("#3ydccM").css("display","");
				} else {
					$("#3ydccM").css("display","none");
				}
				$("#3ydccML").prop("title",toolTip);
			}
			if( id == 'D4X' ) {
				if( state == 'ON' ) {
					$("#4xdccM").css("display","");
				} else {
					$("#4xdccM").css("display","none");
				}
				$("#4xdccML").prop("title",toolTip);
			}
			if( id == 'D4Y' ) {
				if( state == 'ON' ) {
					$("#4ydccM").css("display","");
				} else {
					$("#4ydccM").css("display","none");
				}
				$("#4ydccML").prop("title",toolTip);
			}
			if( id == 'M36' ) {
				if( state == 'ON' ) {
					$("#3mvM").css("display","");
				} else {
					$("#3mvM").css("display","none");
				}
				$("#3mvML").prop("title",toolTip);
			}
			if( id == 'M46' ) {
				if( state == 'ON' ) {
					$("#4mvM").css("display","");
				} else {
					$("#4mvM").css("display","none");
				}
				$("#4mvML").prop("title",toolTip);
			}
			if( id == 'A37' ) {
				if( state == 'ON' ) {
					$("#3auxM").css("display","");
				} else {
					$("#3auxM").css("display","none");
				}
				$("#3auxML").prop("title",toolTip);
			}
			if( id == 'A47' ) {
				if( state == 'ON' ) {
					$("#4auxM").css("display","");
				} else {
					$("#4auxM").css("display","none");
				}
				$("#4auxML").prop("title",toolTip);
			}
		} else {
			if( id == 'D3X' ) {
				if( state == 'ON' ) {
					$("#3xdccS").css("display","");
				} else {
					$("#3xdccS").css("display","none");
				}
				$("#3xdccSL").prop("title",toolTip);
			}
			if( id == 'D3Y' ) {
				if( state == 'ON' ) {
					$("#3ydccS").css("display","");
				} else {
					$("#3ydccS").css("display","none");
				}
				$("#3ydccSL").prop("title",toolTip);
			}
			if( id == 'D4X' ) {
				if( state == 'ON' ) {
					$("#4xdccS").css("display","");
				} else {
					$("#4xdccS").css("display","none");
				}
				$("#4xdccSL").prop("title",toolTip);
			}
			if( id == 'D4Y' ) {
				if( state == 'ON' ) {
					$("#4ydccS").css("display","");
				} else {
					$("#4ydccS").css("display","none");
				}
				$("#4ydccSL").prop("title",toolTip);
			}
			if( id == 'M36' ) {
				if( state == 'ON' ) {
					$("#3mvS").css("display","");
				} else {
					$("#3mvS").css("display","none");
				}
				$("#3mvSL").prop("title",toolTip);
			}
			if( id == 'M46' ) {
				if( state == 'ON' ) {
					$("#4mvS").css("display","");
				} else {
					$("#4mvS").css("display","none");
				}
				$("#4mvSL").prop("title",toolTip);
			}
			if( id == 'A37' ) {
				if( state == 'ON' ) {
					$("#3auxS").css("display","");
				} else {
					$("#3auxS").css("display","none");
				}
				$("#3auxSL").prop("title",toolTip);
			}
			if( id == 'A47' ) {
				if( state == 'ON' ) {
					$("#4auxS").css("display","");
				} else {
					$("#4auxS").css("display","none");
				}
				$("#4auxSL").prop("title",toolTip);
			}
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
			<!-- page_title -->
			<div class="page_title">
				<h3>시스템 모니터링</h3>
				<div class="bc"><span>DCC</span><span>Admin</span><strong>시스템 모니터링</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap system_monitering">
                <div class="img_mask"></div>
            </div>
            <div id="masterIcons">
	            <div id="3xdccM" style="position:absolute;top:585px;left:310px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="3ydccM" style="position:absolute;top:600px;left:310px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="4xdccM" style="position:absolute;top:615px;left:310px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="4ydccM" style="position:absolute;top:630px;left:310px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="3mvM" style="position:absolute;top:585px;left:378px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="4mvM" style="position:absolute;top:600px;left:378px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="3auxM" style="position:absolute;top:645px;left:378px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="4auxM" style="position:absolute;top:660px;left:378px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
            </div>
            <div id="masterLabels">
	            <div id="3xdccML" style="position:absolute;top:585px;left:320px;width:45px;height:10px;"></div>
	            <div id="3ydccML" style="position:absolute;top:600px;left:320px;width:45px;height:10px;"></div>
	            <div id="4xdccML" style="position:absolute;top:615px;left:320px;width:45px;height:10px;"></div>
	            <div id="4ydccML" style="position:absolute;top:630px;left:320px;width:45px;height:10px;"></div>
	            <div id="3mvML" style="position:absolute;top:585px;left:388px;width:45px;height:10px;"></div>
	            <div id="4mvML" style="position:absolute;top:600px;left:388px;width:45px;height:10px;"></div>
	            <div id="3auxML" style="position:absolute;top:645px;left:388px;width:45px;height:10px;"></div>
	            <div id="4auxML" style="position:absolute;top:660px;left:388px;width:45px;height:10px;"></div>
            </div>
            <div id="slaveIcons">
	            <div id="3xdccS" style="position:absolute;top:585px;left:928px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="3ydccS" style="position:absolute;top:600px;left:928px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="4xdccS" style="position:absolute;top:615px;left:928px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="4ydccS" style="position:absolute;top:630px;left:928px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="3mvS" style="position:absolute;top:585px;left:996px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="4mvS" style="position:absolute;top:600px;left:996px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="3auxS" style="position:absolute;top:645px;left:996px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
	            <div id="4auxS" style="position:absolute;top:660px;left:996px">
	            	<img src="/resources/images/background/statusOn.png" style="width:10px;height:10px">
	            </div>
            </div>
            <div id="slaveLabels">
	            <div id="3xdccSL" style="position:absolute;top:585px;left:938px;width:45px;height:10px;"></div>
	            <div id="3ydccSL" style="position:absolute;top:600px;left:938px;width:45px;height:10px;"></div>
	            <div id="4xdccSL" style="position:absolute;top:615px;left:938px;width:45px;height:10px;"></div>
	            <div id="4ydccSL" style="position:absolute;top:630px;left:938px;width:45px;height:10px;"></div>
	            <div id="3mvSL" style="position:absolute;top:585px;left:1006px;width:45px;height:10px;"></div>
	            <div id="4mvSL" style="position:absolute;top:600px;left:1006px;width:45px;height:10px;"></div>
	            <div id="3auxSL" style="position:absolute;top:645px;left:1006px;width:45px;height:10px;"></div>
	            <div id="4auxSL" style="position:absolute;top:660px;left:1006px;width:45px;height:10px;"></div>
            </div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
</body>
</html>



