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
	var hogiHeader = '${UserInfo.hogi}' != "undefined" || '${UserInfo.hogi}' != ''  ? '${UserInfo.hogi}' : "3";
	var xyHeader = '${UserInfo.xyGubun}' != "undefined" || '${UserInfo.xyGubun}' != '' ? '${UserInfo.xyGubun}' : "X";
	var timerOn = true;
	
	var lblXYListAjax = {};
	
	$(function(){
		var comAjax = new ComAjax("reloadFrm");
		comAjax.setUrl('/dcc/status/reloadReact');
		comAjax.setCallback('statusCallback');
		comAjax.ajax();
		
		$("#lblDate").text('${SearchTime}');
		$("#lblDate").css('color','${ForeColor}');
		
		$(document.body).delegate('#3', 'click', function() {
			$("#data_area").empty();
			var comAjax = new ComAjax("reloadFrm");
			comAjax.setUrl('/dcc/status/reloadReact');
			comAjax.setCallback('statusCallback');
			comAjax.ajax();
		});
		
		$(document.body).delegate('#4', 'click', function() {
			$("#data_area").empty();
			var comAjax = new ComAjax("reloadFrm");
			comAjax.setUrl('/dcc/status/reloadReact');
			comAjax.setCallback('statusCallback');
			comAjax.ajax();
		});
		
		$(document.body).delegate('#X', 'click', function() {
			$("#data_area").empty();
			var comAjax = new ComAjax("reloadFrm");
			comAjax.setUrl('/dcc/status/reloadReact');
			comAjax.setCallback('statusCallback');
			comAjax.ajax();
		});
		
		$(document.body).delegate('#Y', 'click', function() {
			$("#data_area").empty();
			var comAjax = new ComAjax("reloadFrm");
			comAjax.setUrl('/dcc/status/reloadReact');
			comAjax.setCallback('statusCallback');
			comAjax.ajax();
		});
		
		setTimer(5000);
	});
	
	
	function setTimer(interval) {
		if( interval > 0 ) {
			setTimeout(function run() {
				if( timerOn ) {
					//var	comSubmit	=	new ComSubmit("reloadFrm");
					//comSubmit.setUrl("/dcc/status/reactivity");
					//comSubmit.submit();
					var comAjax = new ComAjax("reloadFrm");
					comAjax.setUrl('/dcc/status/reloadReact');
					comAjax.setCallback('statusCallback');
					comAjax.ajax();
				}
				
				setTimeout(run, interval);
			},interval);
		} else {
			//var	comSubmit	=	new ComSubmit("reloadFrm");
			//comSubmit.setUrl("/dcc/status/reactivity");
			//comSubmit.submit();
			var comAjax = new ComAjax("reloadFrm");
			comAjax.setUrl('/dcc/status/reloadReact');
			comAjax.setCallback('statusCallback');
			comAjax.ajax();
		}
	}
	
	function setData() {
		var dataAreaBody = $("#data_area");
		var surfix = ' zero';
		var curSize = dataAreaBody[0].children.length;
		var bodyStr = dataAreaBody.html().trim().split('\n');
		
		var strList = [
			'★','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
		];
		
		var tmp = '<span style="top:'+lblXYListAjax[0].Top+'px;left:'+lblXYListAjax[0].Left+'px;">'+strList[0]+'</span>\n';
		var realStr = tmp;
		var bodyLen = bodyStr.length < 26 ? bodyStr.length : 26;
		for( var j=0;j<bodyLen;j++ ) {
			if( bodyStr[j].trim().length > 0 ) {
				realStr += bodyStr[j].replace(strList[j],strList[j+1])+'\n';
			}
		}
		dataAreaBody.empty();
		dataAreaBody.append(realStr);
		
		var cnt = dataAreaBody[0].children.length;
		
		for( var i=0;i<cnt;i++ ) {
			if( i == 0 ) {
				dataAreaBody[0].children[i].className = "lblxy zero";
			} else if( i == 1 ) {
				dataAreaBody[0].children[i].className = "lblxy a";
			} else if( i == 2 ) {
				dataAreaBody[0].children[i].className = "lblxy b";
			} else if( i == 3 ) {
				dataAreaBody[0].children[i].className = "lblxy c";
			} else if( i == 4 ) {
				dataAreaBody[0].children[i].className = "lblxy d";
			} else {
				dataAreaBody[0].children[i].className = "lblxy";
			}
			dataAreaBody[0].children[i].style.zIndex = 27-i;
		}
	}
	
	function setDate(time,color) {
		$("#lblDate").text(time);
		$("#lblDate").css('color',color);
	}
	
	function toCSV() {
		timerOn = false;
		var comSubmit = new ComSubmit("reloadFrm");
		comSubmit.setUrl('/dcc/status/reactExcelExport');
		comSubmit.addParam("hogi",hogiHeader);
		comSubmit.addParam("xyGubun",xyHeader);
		comSubmit.submit();
		timerOn = true;
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
				<h3>REACTIVITY CONTROL DIAGRAM</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>REACTIVITY CONTROL DIAGRAM</strong></div>
			</div>
			<!-- //page_title -->
			<div class="img_wrap reactivity_control_diagram">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="javascript:toCSV();">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->
                <form id="reloadFrm" style="display:none">
                	<input type="hidden"  name="nCntVisible"  id="" value=" ${BaseSearch.nCntVisible}">
                	<input type="hidden" id="gubun" name="gubun" value="${BaseSearch.gubun}">
					<input type="hidden" id="menuNo" name="menuNo" value="${BaseSearch.menuNo}">
					<input type="hidden" id="grpId" name="grpId" value="${BaseSearch.grpId}">
					<input type="hidden" id="grpNo" name="grpNo" value="${BaseSearch.grpNo}">
                </form>            
                <div class="img_mask"></div>
                <!-- 데이터 표시영역 start : 가로(780px) X 세로(410px) -->
                <!-- 데이터 표시영역 실측 : 가로(770px) X 세로(390px) -->
                <div id="data_area" class="data_area" style="top:124px;left:276px;">
                </div>
                <!-- //데이터 표시영역 end -->
            </div>

		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->
<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>엑셀로 저장</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
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
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

