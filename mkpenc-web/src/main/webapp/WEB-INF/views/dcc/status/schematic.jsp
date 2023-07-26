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

<script type="text/javascript">

	var timerOn = true;
	var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
	var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

	var tDccTagSeq = [
		${DccTagInfoList[0].iSeq},${DccTagInfoList[1].iSeq},${DccTagInfoList[2].iSeq},${DccTagInfoList[3].iSeq},${DccTagInfoList[4].iSeq},
		${DccTagInfoList[5].iSeq},${DccTagInfoList[6].iSeq},${DccTagInfoList[7].iSeq},${DccTagInfoList[8].iSeq},${DccTagInfoList[9].iSeq},
		${DccTagInfoList[10].iSeq},${DccTagInfoList[11].iSeq},${DccTagInfoList[12].iSeq},${DccTagInfoList[13].iSeq},${DccTagInfoList[14].iSeq},
		${DccTagInfoList[15].iSeq},${DccTagInfoList[16].iSeq},${DccTagInfoList[17].iSeq},${DccTagInfoList[18].iSeq},${DccTagInfoList[19].iSeq},
		${DccTagInfoList[20].iSeq},${DccTagInfoList[21].iSeq},${DccTagInfoList[22].iSeq},${DccTagInfoList[23].iSeq},${DccTagInfoList[24].iSeq},
		${DccTagInfoList[25].iSeq},${DccTagInfoList[26].iSeq},${DccTagInfoList[27].iSeq},${DccTagInfoList[28].iSeq}
	];
	
	var tDccTagXy = [
		'${DccTagInfoList[0].XYGubun}','${DccTagInfoList[1].XYGubun}','${DccTagInfoList[2].XYGubun}','${DccTagInfoList[3].XYGubun}','${DccTagInfoList[4].XYGubun}',
		'${DccTagInfoList[5].XYGubun}','${DccTagInfoList[6].XYGubun}','${DccTagInfoList[7].XYGubun}','${DccTagInfoList[8].XYGubun}','${DccTagInfoList[9].XYGubun}',
		'${DccTagInfoList[10].XYGubun}','${DccTagInfoList[11].XYGubun}','${DccTagInfoList[12].XYGubun}','${DccTagInfoList[13].XYGubun}','${DccTagInfoList[14].XYGubun}',
		'${DccTagInfoList[15].XYGubun}','${DccTagInfoList[16].XYGubun}','${DccTagInfoList[17].XYGubun}','${DccTagInfoList[18].XYGubun}','${DccTagInfoList[19].XYGubun}',
		'${DccTagInfoList[20].XYGubun}','${DccTagInfoList[21].XYGubun}','${DccTagInfoList[22].XYGubun}','${DccTagInfoList[23].XYGubun}','${DccTagInfoList[24].XYGubun}',
		'${DccTagInfoList[25].XYGubun}','${DccTagInfoList[26].XYGubun}','${DccTagInfoList[27].XYGubun}','${DccTagInfoList[28].XYGubun}'
	];
	
	var tToolTipText = [
		"${DccTagInfoList[0].toolTip}"		,"${DccTagInfoList[1].toolTip}"		,"${DccTagInfoList[2].toolTip}"		,"${DccTagInfoList[3].toolTip}"		,"${DccTagInfoList[4].toolTip}"
		,"${DccTagInfoList[5].toolTip}"		,"${DccTagInfoList[6].toolTip}"		,"${DccTagInfoList[7].toolTip}"		,"${DccTagInfoList[8].toolTip}"		,"${DccTagInfoList[9].toolTip}"
		,"${DccTagInfoList[10].toolTip}"		,"${DccTagInfoList[11].toolTip}"		,"${DccTagInfoList[12].toolTip}"		,"${DccTagInfoList[13].toolTip}"		,"${DccTagInfoList[14].toolTip}"
		,"${DccTagInfoList[15].toolTip}"		,"${DccTagInfoList[16].toolTip}"		,"${DccTagInfoList[17].toolTip}"		,"${DccTagInfoList[18].toolTip}"		,"${DccTagInfoList[19].toolTip}"
		,"${DccTagInfoList[20].toolTip}"		,"${DccTagInfoList[21].toolTip}"		,"${DccTagInfoList[22].toolTip}"		,"${DccTagInfoList[23].toolTip}"		,"${DccTagInfoList[24].toolTip}"
		,"${DccTagInfoList[25].toolTip}"		,"${DccTagInfoList[26].toolTip}"		,"${DccTagInfoList[27].toolTip}"		,"${DccTagInfoList[28].toolTip}"
	];
	
	var lblDataListAjax = {};
	var DccTagInfoListAjax = {};
	
	var selectTag = [{name:"hogi",value:""},{name:"xyGubun",value:""},{name:"loopName",value:""},{name:"ioType",value:""}
					,{name:"address",value:""},{name:"ioBit",value:""},{name:"descr",value:""}];
		
	
	$(function(){

		$("#lblDate").text('${SearchTime}');
		$("#lblDate").css('color','${ForeColor}');

		setTimer(5000);
	});
		
	function setTimer(interval) {
		if( interval > 0 ) {
			setTimeout(function run() {
				if( timerOn ) {
					//var	comSubmit	=	new ComSubmit("reloadFrm");
					//comSubmit.setUrl("/dcc/status/schematic");
					//comSubmit.submit();
					var comAjax = new ComAjax("reloadFrm");
					comAjax.setUrl('/dcc/status/reloadSchematic');
					//comAjax.addParam("sHogi",hogiHeader);
					//comAjax.addParam("sXYGubun",xyHeader);
					comAjax.setCallback('statusCallback');
					comAjax.ajax();
				}
				
				setTimeout(run, interval);
			},interval);
		} else {
			setTimeout(function run() {
				if( timerOn ) {
					//var	comSubmit	=	new ComSubmit("reloadFrm");
					//comSubmit.setUrl("/dcc/status/schematic");
					//comSubmit.submit();
					var comAjax = new ComAjax("reloadFrm");
					comAjax.setUrl('/dcc/status/reloadSchematic');
					//comAjax.addParam("sHogi",hogiHeader);
					//comAjax.addParam("sXYGubun",xyHeader);
					comAjax.setCallback('statusCallback');
					comAjax.ajax();
				}
				
				setTimeout(run, 5000);
			},5000);
		}
	}

	function setDate(time,color) {
		$("#lblDate").text(time);
		$("#lblDate").css('color',color);
	}

	function setData() {
		for( var i=0;i<lblDataListAjax.length;i++ ) {
			$("#lblData"+i).text(lblDataListAjax[i].fValue);
			$("#lblUnit"+i).text(DccTagInfoListAjax[i].unit);
			$("#lblData"+i).prop('title',DccTagInfoListAjax[i].toolTip);
		}
	}
	
	
	function closeModal() {
		var	comSubmit	=	new ComSubmit("reloadFrm");
		comSubmit.setUrl("/dcc/status/schematic");
		comSubmit.submit();
	}
	
	function toCSV() {
		var	comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl("/dcc/status/schematicExcelExport");
		comSubmit.submit();
	}
</script>
</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-dcc-header.jspf" %>
	<!-- header_wrap -->
	<!-- container -->
	<form id="reloadFrm" style="display:none">
	<input type="hidden" id="gubun" name="gubun" value="${BaseSearch.gubun}">
	<input type="hidden" id="menuNo" name="menuNo" value="${BaseSearch.menuNo}">
	<input type="hidden" id="grpId" name="grpId" value="${BaseSearch.grpId}">
	<input type="hidden" id="grpNo" name="grpNo" value="${BaseSearch.grpNo}">
	</form>    
    <form id="dccStatusSchematicForm"> 
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>PLANT SCHEMATIC DIAGRAM</h3>
				<div class="bc"><span>DCC</span><span>STATUS</span><strong>PLANT SCHEMATIC DIAGRAM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap plant_schematic_diagram">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="javascript:toCSV()">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                              
                <!-- range_slider -->
                <div class="range_slider">
                    <input type="range" id="opacity-change" value="100" min="20" max="100">
                    <span>1</span>
                </div>
                <div class="img_mask"></div>
                <!-- ///range_slider -->
                <div class="chart_block small wide" style="top:40px;left:180px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>SG P</span>
                                <span id="lblData0" title="${DccTagInfoList[0].toolTip}">${lblDataList[0].fValue}</span>
                                <span id="lblUnit0">${DccTagInfoList[0].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>STM WTR F</span>
                                <span id="lblData1" title="${DccTagInfoList[1].toolTip}">${lblDataList[1].fValue}</span>
                                <span id="lblUnit1">${DccTagInfoList[1].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- GENERATOR -->
                <div class="chart_block small" style="top:164px;right:200px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span></span>
                                <span id="lblData29" title="${DccTagInfoList[29].toolTip}">${lblDataList[29].fValue}</span>
                                <span id="lblUnit29">${DccTagInfoList[29].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span></span>
                                <span id="lblData30" title="${DccTagInfoList[30].toolTip}">${lblDataList[30].fValue}</span>
                                <span id="lblUnit30">${DccTagInfoList[30].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- // GENERATOR -->
                <!-- CONDENSER -->
                <div class="chart_block small wide" style="top:296px;right:200px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>VAC</span>
                                <span id="lblData16" title="${DccTagInfoList[16].toolTip}">${lblDataList[16].fValue}</span>
                                <span id="lblUnit16">${DccTagInfoList[16].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>L</span>
                                <span id="lblData17" title="${DccTagInfoList[17].toolTip}">${lblDataList[17].fValue}</span>
                                <span id="lblUnit17">${DccTagInfoList[17].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T</span>
                                <span id="lblData18" title="${DccTagInfoList[18].toolTip}">${lblDataList[18].fValue}</span>
                                <span id="lblUnit18">${DccTagInfoList[18].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:378px;right:200px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>T IN</span>
                                <span id="lblData19" title="${DccTagInfoList[19].toolTip}">${lblDataList[19].fValue}</span>
                                <span id="lblUnit19">${DccTagInfoList[19].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T OUT</span>
                                <span id="lblData20" title="${DccTagInfoList[20].toolTip}">${lblDataList[20].fValue}</span>
                                <span id="lblUnit20">${DccTagInfoList[20].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- // CONDENSER -->                
                <div class="chart_block small" style="top:154px;left:210px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>1</span>
                                <span id="lblData4" title="${DccTagInfoList[4].toolTip}">${lblDataList[4].fValue}</span>
                                <span id="lblUnit4">${DccTagInfoList[4].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>3</span>
                                <span id="lblData6" title="${DccTagInfoList[6].toolTip}">${lblDataList[6].fValue}</span>
                                <span id="lblUnit6">${DccTagInfoList[6].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small" style="top:154px;left:390px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>2</span>
                                <span id="lblData5" title="${DccTagInfoList[5].toolTip}">${lblDataList[5].fValue}</span>
                                <span id="lblUnit5">${DccTagInfoList[5].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>4</span>
                                <span id="lblData7" title="${DccTagInfoList[7].toolTip}">${lblDataList[7].fValue}</span>
                                <span id="lblUnit7">${DccTagInfoList[7].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="chart_block small wide" style="top:246px;left:270px;">
                    <div class="chart_block_contents bd_none">
                        <div class="summary">
                            <p>
                                <span>ROH P</span>
                                <span id="lblData8" title="${DccTagInfoList[8].toolTip}">${lblDataList[8].fValue}</span>
                                <span id="lblUnit8">${DccTagInfoList[8].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PZR LVL (Lc)</span>
                                <span id="lblData31" title="${DccTagInfoList[31].toolTip}">${lblDataList[31].fValue}</span>
                                <span id="lblUnit31">${DccTagInfoList[31].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T OUT</span>
                                <span id="lblData9" title="${DccTagInfoList[9].toolTip}">${lblDataList[9].fValue}</span>
                                <span id="lblUnit9">${DccTagInfoList[9].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>T IN</span>
                                <span id="lblData10" title="${DccTagInfoList[10].toolTip}">${lblDataList[10].fValue}</span>
                                <span id="lblUnit10">${DccTagInfoList[10].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>PWR RTE</span>
                                <span id="lblData11" title="${DccTagInfoList[11].toolTip}">${lblDataList[11].fValue}</span>
                                <span id="lblUnit11">${DccTagInfoList[11].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>RX PWR</span>
                                <span id="lblData12" title="${DccTagInfoList[12].toolTip}">${lblDataList[12].fValue}</span>
                                <span id="lblUnit12">${DccTagInfoList[12].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>ZONE LVL</span>
                                <span id="lblData13" title="${DccTagInfoList[13].toolTip}">${lblDataList[13].fValue}</span>
                                <span id="lblUnit13">${DccTagInfoList[13].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MOD L</span>
                                <span id="lblData14" title="${DccTagInfoList[14].toolTip}">${lblDataList[14].fValue}</span>
                                <span id="lblUnit14">${DccTagInfoList[14].unit}</span>
                            </p>
                        </div>
                        <div class="summary">
                            <p>
                                <span>MOD T</span>
                                <span id="lblData15" title="${DccTagInfoList[15].toolTip}">${lblDataList[15].fValue}</span>
                                <span id="lblUnit15">${DccTagInfoList[15].unit}</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>            
            <div class="chart_block small wide" style="top:560px;left:180px;">
                <div class="chart_block_contents bd_none">
                    <div class="summary">
                        <p>
                            <span>FEED WTR F</span>
                            <span id="lblData24" title="${DccTagInfoList[24].toolTip}">${lblDataList[24].fValue}</span>
                            <span id="lblUnit24">${DccTagInfoList[24].unit}</span>
                        </p>
                    </div>
                    <div class="summary">
                        <p>
                            <span>FEED WTR T</span>
                            <span id="lblData25" title="${DccTagInfoList[25].toolTip}">${lblDataList[25].fValue}</span>
                            <span id="lblUnit25">${DccTagInfoList[25].unit}</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="chart_block small" style="top:585px;left:620px;">
                <div class="chart_block_contents bd_none">
                    <div class="summary">
                        <p>
                            <span>P</span>
                            <span id="lblData26" title="${DccTagInfoList[26].toolTip}">${lblDataList[26].fValue}</span>
                            <span id="lblUnit26">${DccTagInfoList[26].unit}</span>
                        </p>
                    </div>
                    <div class="summary">
                        <p>
                            <span>L</span>
                            <span id="lblData27" title="${DccTagInfoList[27].toolTip}">${lblDataList[27].fValue}</span>
                            <span id="lblUnit27">${DccTagInfoList[27].unit}</span>
                        </p>
                    </div>
                    <div class="summary">
                        <p>
                            <span>T</span>
                            <span id="lblData28" title="${DccTagInfoList[28].toolTip}">${lblDataList[28].fValue}</span>
                            <span id="lblUnit28">${DccTagInfoList[28].unit}</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="chart_block small wide" style="top:450px;left:630px;">
                <div class="chart_block_contents bd_none">
                    <div class="summary">
                        <p>
                        	<span></span>
                            <span id="lblData21" title="${DccTagInfoList[21].toolTip}">${lblDataList[21].fValue}</span>
                            <span id="lblUnit21">${DccTagInfoList[21].unit}</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="chart_block small wide" style="top:650px;left:980px;">
                <div class="chart_block_contents bd_none">
                    <div class="summary">
                        <p>
                            <span>HTR 3B T</span>
                            <span id="lblData23" title="${DccTagInfoList[23].toolTip}">${lblDataList[23].fValue}</span>
                            <span id="lblUnit23">${DccTagInfoList[23].unit}</span>
                        </p>
                    </div>
                </div>
            </div>
		</div>
		<!-- //contents -->
	</div>
	</form>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

