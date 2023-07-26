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
<script type="text/javascript" src="<c:url value="/resources/js/alarm.js" />" charset="utf-8"></script>

<script type="text/javascript">

	var timerOn = true //true로 변경
	
	var lblTitleAjax = '';
	var lblDataListAjax = {};
	var TagDccInfoListAjax = {};
	var lblH2Ajax = {};
	var lblO2Ajax = {};
	var lblN2Ajax = {};
	var lblD2Ajax = {};
	
	$(function() {
		$("#lblDate").text('${SearchTime}');
		$("#lblDate").css('color','${ForeColor}');		
		
		setTimer(5000);
	});
	
	function setTimer(interval) {
		if( interval > 0 ) {
			setTimeout(function run() {
				if( timerOn ) {
					//var	comSubmit	=	new ComSubmit("reloadForm");
					//comSubmit.setUrl("/dcc/alarm//gaschromatography");
					//comSubmit.submit();
					var comAjax = new ComAjax("reloadForm");
					comAjax.setUrl('/dcc/alarm/reloadGaschromatography');
					//comAjax.addParam("sHogi",hogiHeader);
					//comAjax.addParam("sXYGubun",xyHeader);
					comAjax.setCallback('alarmCallback');
					comAjax.ajax();
				}
				
				setTimeout(run, interval);
			},interval);
		} else {
			//var	comSubmit	=	new ComSubmit("reloadForm");
			//comSubmit.setUrl("/dcc/alarm//gaschromatography");
			//comSubmit.submit();
			var comAjax = new ComAjax("reloadForm");
			comAjax.setUrl('/dcc/alarm/reloadGaschromatography');
			//comAjax.addParam("sHogi",hogiHeader);
			//comAjax.addParam("sXYGubun",xyHeader);
			comAjax.setCallback('alarmCallback');
			comAjax.ajax();
		}
	}
	
	function setData() {
		$("#lblTitle").text(lblTitleAjax);
		for( var i=0;i<lblDataListAjax.length;i++ ) {
			$("#lblData"+i).text(lblDataListAjax[i].fValue);
			$("#lblData"+i).attr('title',TagDccInfoListAjax[i].toolTip);
		}
		for( var j=0;i<lblH2Ajax.length;j++ ) {
			$("#lblH2"+i).text(lblH2Ajax[i]['idx'+i]);
			$("#lblO2"+i).text(lblO2Ajax[i]['idx'+i]);
			$("#lblN2"+i).text(lblN2Ajax[i]['idx'+i]);
			$("#lblD2"+i).text(lblD2Ajax[i]['idx'+i]);
		}
	}
	/*
	function setTimer2(num){
		var uGrpName = $("#cboUGrpName option:selected").val();
		reloadAjax(0);
	}
	
	function reloadAjax(type) {
		var comAjax = new ComAjax("reloadForm");
		comAjax.setUrl("/dcc/alarm/runtimerGC");
		comAjax.setCallback("mbr_RuntimerGCCallback");
		if( type == 0 ) {
			comAjax.ajax();
		}
	}
	*/
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
				<h3>가스크로마토그래프</h3>
				<div class="bc"><span>DCC</span><span>Alarm</span><strong>가스크로마토그래프</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap dp_style">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label class="dp_title">현재분석계통</label>
                            <div class="fx_form">
                                <label id="lblTitle" style="color:blue"><strong>${LblTitle}</strong></label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label class="dp_title">기체농도</label>
                            <div id="gasSummary" class="fx_form">
                                [ 수소<strong><label id="lblData0" title="${TagDccInfoList[0].toolTip}" style="margin-left:6px;color:blue">${lblDataList[0].fValue}</label></strong>%] ,
                                [ 산소<strong><label id="lblData1" title="${TagDccInfoList[1].toolTip}" style="margin-left:6px;color:blue">${lblDataList[1].fValue}</label></strong>%] ,
                                [ 질소<strong><label id="lblData2" title="${TagDccInfoList[2].toolTip}" style="margin-left:6px;color:blue">${lblDataList[2].fValue}</label></strong>%] ,
                                [ 중수소<strong><label id="lblData3" title="${TagDccInfoList[3].toolTip}" style="margin-left:6px;color:blue">${lblDataList[3].fValue}</label></strong>%]
                            </div>
						</div>
                    </div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->
            <!-- list_wrap -->
            <div class="list_wrap">
            <form id="reloadForm">
			<input type = "hidden" id="sUGrpNo" name="sUGrpNo" value="1">
			<input type = "hidden" id="sMenuNo" name="sMenuNo" value = "12">
			<input type = "hidden" id="sDive" name="sDive" value = "D">
			<input type = "hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi}">
			<input type = "hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun}">
			</form>
				<!-- list_head -->
				<div class="list_head">
					<h4>직전분석값</h4>
                </div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table">
                    <colgroup>
                        <col width="140px"/>
                        <col width="180px"/>
                        <col width="180px"/>
                        <col width="180px"/>
                        <col width="180px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>계통</th>
                            <th>수소농도</th>
                            <th>산소농도</th>
                            <th>질소농도</th>
                            <th>중수소농도</th>
                        </tr>
                    </thead>
                    <tbody id="gasDensityBody">
                        <tr>
                            <td>LZC RU 전단</td>
                            <td class="tc"><label id="lblH20">${LblH2.idx0}</label></td>
                            <td class="tc"><label id="lblO20">${LblO2.idx0}</label></td>
                            <td class="tc"><label id="lblN20">${LblN2.idx0}</label></td>
                            <td class="tc"><label id="lblD20">${LblD2.idx0}</label></td>
                        </tr>
                        <tr>
                            <td>LZC RU 후단</td>
                            <td class="tc"><label id="lblH21">${LblH2.idx1}</label></td>
                            <td class="tc"><label id="lblO21">${LblO2.idx1}</label></td>
                            <td class="tc"><label id="lblN21">${LblN2.idx1}</label></td>
                            <td class="tc"><label id="lblD21">${LblD2.idx1}</label></td>
                        </tr>
                        <tr>
                            <td>MOD RU 전단</td>
                            <td class="tc"><label id="lblH22">${LblH2.idx2}</label></td>
                            <td class="tc"><label id="lblO22">${LblO2.idx2}</label></td>
                            <td class="tc"><label id="lblN22">${LblN2.idx2}</label></td>
                            <td class="tc"><label id="lblD22">${LblD2.idx2}</label></td>
                        </tr>
                        <tr>
                            <td>MOD RU 후단</td>
                            <td class="tc"><label id="lblH23">${LblH2.idx3}</label></td>
                            <td class="tc"><label id="lblO23">${LblO2.idx3}</label></td>
                            <td class="tc"><label id="lblN23">${LblN2.idx3}</label></td>
                            <td class="tc"><label id="lblD23">${LblD2.idx3}</label></td>
                        </tr>
                        <tr>
                            <td>HI COLLECTION</td>
                            <td class="tc"><label id="lblH24">${LblH2.idx4}</label></td>
                            <td class="tc"><label id="lblO24">${LblO2.idx4}</label></td>
                            <td class="tc"><label id="lblN24">${LblN2.idx4}</label></td>
                            <td class="tc"><label id="lblD24">${LblD2.idx4}</label></td>
                        </tr>
                        <tr>
                            <td>HT DST</td>
                            <td class="tc"><label id="lblH25">${LblH2.idx5}</label></td>
                            <td class="tc"><label id="lblO25">${LblO2.idx5}</label></td>
                            <td class="tc"><label id="lblN25">${LblN2.idx5}</label></td>
                            <td class="tc"><label id="lblD25">${LblD2.idx5}</label></td>
                        </tr>
                    </tbody>
                </table>
                <!-- //list_table -->
            </div>
            <!-- //list_wrap -->
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

