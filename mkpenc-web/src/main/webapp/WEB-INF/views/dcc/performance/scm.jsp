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
var timerOn = false;

	var lblDataListAjax = {};
	var dccGrpTagListAjax = {};
	var lblSCMAjax = {};
	
	$(function () {
		
		var timer =0;
				
		timer = setInterval(function () {
	 				
			// 화면초기화
			var comAjax = new ComAjax("safeVarSearch");
			comAjax.setUrl("/dcc/performance/reloadScm");
			comAjax.addParam("sHogi",$("input:radio[id='4']").is(":checked") ? '4' : '3');
			comAjax.addParam("sXYGubun",$("input:radio[id='Y']").is(":checked") ? 'Y' : 'X');
			comAjax.addParam("sMenuNo",'44');
			comAjax.addParam("sUGrpNo",'2');
			comAjax.addParam("sGrpID",'mimic');
			comAjax.setCallback("mbr_performanceCallback");
			comAjax.ajax();
			
		}, 5000);
		
		setLblDate('');
		setLblDataAjax(1);
		UserControl_Paint(1);
	 
	});

	function setLblDate(time) {
		if( time == '' ) {
			time = '${SearchTime}';
		}
		$("#lblDate").text(time);
	}
	
	function setLblDataAjax(type) {
		if( type == 0 ) {
			for( var i=0;i<4;i++ ) {
				$("#lblData"+(i*2)).text(lblDataListAjax[i].fValue);
				$("#lblData"+(i*2+1)).text(lblDataListAjax[i+1].fValue);
				$("#lblData"+(i*2)).attr("title",dccGrpTagListAjax[i].toolTip);
				$("#lblData"+(i*2+1)).attr("title",dccGrpTagListAjax[i+1].toolTip);
				$("#lblUnit"+(i*3)).text(dccGrpTagListAjax[i].unit);
				$("#lblUnit"+(i*3+1)).text(dccGrpTagListAjax[i+1].unit);
				$("#lblUnit"+(i*3+2)).text(dccGrpTagListAjax[i+1].unit);
				$("#lblSCM"+(i)).text(lblSCMAjax['idx'+i]);
			}
		}
	}
	
	function UserControl_Paint(type) {
		for(var i=0;i<4;i++ ) {
			var selPressure = $("#lblData"+(i*2)).text()*1;
			var selTemp = $("#lblData"+(i*2+1)).text()*1;
			
			var posTop = Math.round(450-(450*(selPressure/15)));
			var posLeft = Math.round((660*(selTemp/330)));
			
			$("#header"+(i*2)).css("top",posTop);
			$("#header"+(i*2)).css("left",posLeft);
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
				<h3>SCM</h3>
				<div class="bc"><span>DCC</span><span>Performance</span><strong>SCM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap sub_cooling_margin">
                <div class="img_mask"></div>
                <!-- 데이터 표시영역 start : 가로(660px) X 세로(450px) -->
                <div class="data_area" style="top:89px;left:254px;">
                    <span id="header0" class="spot_header_2" style="top:120px;left:550px;width:7px;height:7px"></span>
                    <span id="header2" class="spot_header_4" style="top:130px;left:590px;width:7px;height:7px"></span>
                    <span id="header4" class="spot_header_6" style="top:140px;left:560px;width:7px;height:7px"></span>
                    <span id="header6" class="spot_header_8" style="top:150px;left:520px;width:7px;height:7px"></span>
                </div>
                <!-- //데이터 표시영역 end -->
                <div class="chart_block small wide" style="top:88px;right:240px;">
                    <h4 class="header_2">HEADER #2</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Pressure</span>
                                <span><label id="lblData0">${lblDataList[0].fValue}</label></span>
                                <span><label id="lblUnit0" style="font-size:11px">${DccGrpTagList[0].unit}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Temp</span>
                                <span><label id="lblData1">${lblDataList[1].fValue}</label></span>
                                <span><label id="lblUnit1" style="font-size:11px">${DccGrpTagList[1].unit}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SCM</span>
                                <span><label id="lblSCM0">${lblSCM.idx0}</label></span>
                                <span><label id="lblUnit2" style="font-size:11px">${DccGrpTagList[1].unit}</label></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:204px;right:240px;">
                    <h4 class="header_4">HEADER #4</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Pressure</span>
                                <span><label id="lblData2">${lblDataList[2].fValue}</label></span>
                                <span><label id="lblUnit3" style="font-size:11px">${DccGrpTagList[2].unit}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Temp</span>
                                <span><label id="lblData3">${lblDataList[3].fValue}</label></span>
                                <span><label id="lblUnit4" style="font-size:11px">${DccGrpTagList[3].unit}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SCM</span>
                                <span><label id="lblSCM1">${lblSCM.idx1}</label></span>
                                <span><label id="lblUnit5" style="font-size:11px">${DccGrpTagList[3].unit}</label></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:320px;right:240px;">
                    <h4 class="header_6">HEADER #6</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Pressure</span>
                                <span><label id="lblData4">${lblDataList[4].fValue}</label></span>
                                <span><label id="lblUnit6" style="font-size:11px">${DccGrpTagList[4].unit}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Temp</span>
                                <span><label id="lblData5">${lblDataList[5].fValue}</label></span>
                                <span><label id="lblUnit7" style="font-size:11px">${DccGrpTagList[5].unit}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SCM</span>
                                <span><label id="lblSCM2">${lblSCM.idx2}</label></span>
                                <span><label id="lblUnit8" style="font-size:11px">${DccGrpTagList[5].unit}</label></span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:436px;right:240px;">
                    <h4 class="header_8">HEADER #8</h4>
                    <div class="chart_block_contents">
                        <div class="summary">
                            <p>
                                <span>Pressure</span>
                                <span><label id="lblData6">${lblDataList[6].fValue}</label></span>
                                <span><label id="lblUnit9" style="font-size:11px">${DccGrpTagList[6].unit}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>Temp</span>
                                <span><label id="lblData7">${lblDataList[7].fValue}</label></span>
                                <span><label id="lblUnit10" style="font-size:11px">${DccGrpTagList[7].unit}</label></span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>SCM</span>
                                <span><label id="lblSCM3">${lblSCM.idx3}</label></span>
                                <span><label id="lblUnit11" style="font-size:11px">${DccGrpTagList[7].unit}</label></span>
                            </p>
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
</body>
</html>

