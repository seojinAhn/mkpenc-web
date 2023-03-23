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
var timerOn = false; //true로 변경
var hogiHeader = '${BaseSearch.hogiHeader}' != "undefined" ? '${BaseSearch.hogiHeader}' : "3";
var xyHeader = '${BaseSearch.xyHeader}' != "undefined" ? '${BaseSearch.xyHeader}' : "X";

$(function () {

	if( $("input:radio[id='4']").is(":checked") ) {
		hogiHeader = "4";
	} else {
		hogiHeader = "3";
	}
	if( $("input:radio[id='Y']").is(":checked") ) {
		xyHeader = "Y";
	} else {
		xyHeader = "X";
	}
	
	var lblDateVal = '${SearchTime}';
	$("#lblDate").text(lblDateVal);
	
	$(document.body).delegate('#3', 'click', function() {
		setTimer('3',xyHeader,0);
	});
	$(document.body).delegate('#4', 'click', function() {
		setTimer('4',xyHeader,0);
	});
	$(document.body).delegate('#X', 'click', function() {
		setTimer(hogiHeader,'X',0);
	});

	setTimer(hogiHeader,xyHeader,5000);

});	

function setTimer(hogiHeader,xyHeader,interval) {
	if( interval > 0 ) {
		setTimeout(function() {
			if( timerOn ) {
				var	comSubmit	=	new ComSubmit("gentcrtd2Frm");
				comSubmit.setUrl("/markv/mimic/gentcrtd2");
				comSubmit.addParam("hogiHeader",hogiHeader);
				comSubmit.addParam("xyHeader",xyHeader);
				comSubmit.submit();
			}
		},interval);
	} else {
		var	comSubmit	=	new ComSubmit("gentcrtd2Frm");
		comSubmit.setUrl("/markv/mimic/gentcrtd2");
		comSubmit.addParam("hogiHeader",hogiHeader);
		comSubmit.addParam("xyHeader",xyHeader);
		comSubmit.submit();
	}
}
</script>
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
				<h3>STATOR SLOT(RTD) & BAR(TC) TEMP-2</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>STATOR SLOT(RTD) & BAR(TC) TEMP-2</strong></div>
			</div>
			<!-- //page_title -->
			<form id="gentcrtd2Frm" style="display:none"></form>
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col />
                                <col width="140px" />
                                <col width="140px" />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>SLOT #</th>
                                    <th>RTD TEMP</th>
                                    <th>TC TEMP</th>
                                    <th>BAR 1</th>
                                    <th>BAR 2</th>
                                    <th>CON RING</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tc">37</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[0].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[0].fValue ne null}"><input type="text" value="${lblDataList[0].fValue}" class="tr" /></c:if>
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[36].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[36].fValue ne null}"><input type="text" value="${lblDataList[36].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T30</td>
                                    <td class="tc">B44</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">38</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[1].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[1].fValue ne null}"><input type="text" value="${lblDataList[1].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[37].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[37].fValue ne null}"><input type="text" value="${lblDataList[37].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">B45</td>
                                    <td class="tc">B62</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">39</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[2].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[2].fValue ne null}"><input type="text" value="${lblDataList[2].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[38].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[38].fValue ne null}"><input type="text" value="${lblDataList[38].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T32</td>
                                    <td class="tc">T13</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">40</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[3].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[3].fValue ne null}"><input type="text" value="${lblDataList[3].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[39].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[39].fValue ne null}"><input type="text" value="${lblDataList[39].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T33</td>
                                    <td class="tc">B46</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">41</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[4].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[4].fValue ne null}"><input type="text" value="${lblDataList[4].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[40].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[40].fValue ne null}"><input type="text" value="${lblDataList[40].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T34</td>
                                    <td class="tc">B48</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">42</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[5].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[5].fValue ne null}"><input type="text" value="${lblDataList[5].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[41].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[41].fValue ne null}"><input type="text" value="${lblDataList[41].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T35</td>
                                    <td class="tc">B47</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">43</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[6].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[6].fValue ne null}"><input type="text" value="${lblDataList[6].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[42].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[42].fValue ne null}"><input type="text" value="${lblDataList[42].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T36</td>
                                    <td class="tc">B49</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">44</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[7].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[7].fValue ne null}"><input type="text" value="${lblDataList[7].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[43].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[43].fValue ne null}"><input type="text" value="${lblDataList[43].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T67</td>
                                    <td class="tc">B51</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">45</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[8].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[8].fValue ne null}"><input type="text" value="${lblDataList[8].fValue}" class="tr" /></c:if>                                                                        
                                    </td><td class="tc">
                                    <c:if test="${lblDataList[44].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[44].fValue ne null}"><input type="text" value="${lblDataList[44].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T38</td>
                                    <td class="tc">B52</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">46</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[9].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[9].fValue ne null}"><input type="text" value="${lblDataList[9].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[45].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[45].fValue ne null}"><input type="text" value="${lblDataList[45].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T39</td>
                                    <td class="tc">B53</td>
                                    <td class="tc">-T5</td>
                                </tr>
                                <tr>
                                    <td class="tc">47</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[10].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[10].fValue ne null}"><input type="text" value="${lblDataList[10].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[46].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[46].fValue ne null}"><input type="text" value="${lblDataList[46].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T40</td>
                                    <td class="tc">B54</td>
                                    <td class="tc">-T2</td>
                                </tr>
                                <tr>
                                    <td class="tc">48</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[11].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[11].fValue ne null}"><input type="text" value="${lblDataList[11].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[47].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[47].fValue ne null}"><input type="text" value="${lblDataList[47].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T41</td>
                                    <td class="tc">B55</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">49</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[12].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[12].fValue ne null}"><input type="text" value="${lblDataList[12].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[48].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[48].fValue ne null}"><input type="text" value="${lblDataList[48].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T42</td>
                                    <td class="tc">B56</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">50</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[13].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[13].fValue ne null}"><input type="text" value="${lblDataList[13].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[49].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[49].fValue ne null}"><input type="text" value="${lblDataList[49].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">B57</td>
                                    <td class="tc">B02</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">51</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[14].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[14].fValue ne null}"><input type="text" value="${lblDataList[14].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[50].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[50].fValue ne null}"><input type="text" value="${lblDataList[50].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T44</td>
                                    <td class="tc">T25</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">52</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[15].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[15].fValue ne null}"><input type="text" value="${lblDataList[15].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[51].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[51].fValue ne null}"><input type="text" value="${lblDataList[51].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T45</td>
                                    <td class="tc">B58</td>
                                    <td class="tc">-T1</td>
                                </tr>
                                <tr>
                                    <td class="tc">53</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[16].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[16].fValue ne null}"><input type="text" value="${lblDataList[16].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[52].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[52].fValue ne null}"><input type="text" value="${lblDataList[52].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T46</td>
                                    <td class="tc">B60</td>
                                    <td class="tc">-T4</td>
                                </tr>
                                <tr>
                                    <td class="tc">54</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[17].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[17].fValue ne null}"><input type="text" value="${lblDataList[17].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[53].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[53].fValue ne null}"><input type="text" value="${lblDataList[53].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T47</td>
                                    <td class="tc">B59</td>
                                    <td class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col />
                                <col width="140px" />
                                <col width="140px" />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>SLOT #</th>
                                    <th>RTD TEMP</th>
                                    <th>TC TEMP</th>
                                    <th>BAR 1</th>
                                    <th>BAR 2</th>
                                    <th>CON RING</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tc">55</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[18].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[18].fValue ne null}"><input type="text" value="${lblDataList[18].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[54].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[54].fValue ne null}"><input type="text" value="${lblDataList[54].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T48</td>
                                    <td class="tc">B61</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">56</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[19].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[19].fValue ne null}"><input type="text" value="${lblDataList[19].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[55].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[55].fValue ne null}"><input type="text" value="${lblDataList[55].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T07</td>
                                    <td class="tc">B63</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">57</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[20].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[20].fValue ne null}"><input type="text" value="${lblDataList[20].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[56].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[56].fValue ne null}"><input type="text" value="${lblDataList[56].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T50</td>
                                    <td class="tc">B64</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">58</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[21].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[21].fValue ne null}"><input type="text" value="${lblDataList[21].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[57].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[57].fValue ne null}"><input type="text" value="${lblDataList[57].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T51</td>
                                    <td class="tc">B65</td>
                                    <td class="tc">-T6</td>
                                </tr>
                                <tr>
                                    <td class="tc">59</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[22].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[22].fValue ne null}"><input type="text" value="${lblDataList[22].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[58].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[58].fValue ne null}"><input type="text" value="${lblDataList[58].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T52</td>
                                    <td class="tc">B66</td>
                                    <td class="tc">-T3</td>
                                </tr>
                                <tr>
                                    <td class="tc">60</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[23].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[23].fValue ne null}"><input type="text" value="${lblDataList[23].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[59].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[59].fValue ne null}"><input type="text" value="${lblDataList[59].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T53</td>
                                    <td class="tc">B67</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">61</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[24].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[24].fValue ne null}"><input type="text" value="${lblDataList[24].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[60].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[60].fValue ne null}"><input type="text" value="${lblDataList[60].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T54</td>
                                    <td class="tc">B68</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">62</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[25].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[25].fValue ne null}"><input type="text" value="${lblDataList[25].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[61].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[61].fValue ne null}"><input type="text" value="${lblDataList[61].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">B69</td>
                                    <td class="tc">B14</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">63</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[26].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[26].fValue ne null}"><input type="text" value="${lblDataList[26].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[62].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[62].fValue ne null}"><input type="text" value="${lblDataList[62].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T56</td>
                                    <td class="tc">T37</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">64</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[27].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[27].fValue ne null}"><input type="text" value="${lblDataList[27].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[63].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[63].fValue ne null}"><input type="text" value="${lblDataList[63].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T57</td>
                                    <td class="tc">B70</td>
                                    <td class="tc">-T2</td>
                                </tr>
                                <tr>
                                    <td class="tc">65</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[28].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[28].fValue ne null}"><input type="text" value="${lblDataList[28].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[64].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[64].fValue ne null}"><input type="text" value="${lblDataList[64].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T58</td>
                                    <td class="tc">B72</td>
                                    <td class="tc">-T5</td>
                                </tr>
                                <tr>
                                    <td class="tc">66</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[29].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[29].fValue ne null}"><input type="text" value="${lblDataList[29].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[65].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[65].fValue ne null}"><input type="text" value="${lblDataList[65].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T59</td>
                                    <td class="tc">B71</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">67</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[30].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[30].fValue ne null}"><input type="text" value="${lblDataList[30].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[66].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[66].fValue ne null}"><input type="text" value="${lblDataList[66].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T60</td>
                                    <td class="tc">B01</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">68</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[31].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[31].fValue ne null}"><input type="text" value="${lblDataList[31].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[67].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[67].fValue ne null}"><input type="text" value="${lblDataList[67].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T19</td>
                                    <td class="tc">B03</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">69</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[32].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[32].fValue ne null}"><input type="text" value="${lblDataList[32].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[68].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[68].fValue ne null}"><input type="text" value="${lblDataList[68].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T62</td>
                                    <td class="tc">B04</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">70</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[33].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[33].fValue ne null}"><input type="text" value="${lblDataList[33].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[69].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[69].fValue ne null}"><input type="text" value="${lblDataList[69].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T63</td>
                                    <td class="tc">B05</td>
                                    <td class="tc">-T4</td>
                                </tr>
                                <tr>
                                    <td class="tc">71</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[34].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[34].fValue ne null}"><input type="text" value="${lblDataList[34].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[70].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[70].fValue ne null}"><input type="text" value="${lblDataList[70].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T64</td>
                                    <td class="tc">B06</td>
                                    <td class="tc">-T1</td>
                                </tr>
                                <tr>
                                    <td class="tc">72</td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[35].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[35].fValue ne null}"><input type="text" value="${lblDataList[35].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">
                                    <c:if test="${lblDataList[71].fValue eq null}"><input type="text" value="0" class="tr" /></c:if>
                                    <c:if test="${lblDataList[71].fValue ne null}"><input type="text" value="${lblDataList[71].fValue}" class="tr" /></c:if>                                                                        
                                    </td>
                                    <td class="tc">T65</td>
                                    <td class="tc">B07</td>
                                    <td class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
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

