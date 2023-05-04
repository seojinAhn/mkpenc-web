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

$(function () {
	
	var timer =0;
	
 	$("#sUGrpNo").change(function(){
 		
  		if($("#sUGrpNo option:selected").val() != ""){
  			
  			timer = setInterval(function () {
  				
  				var comAjax = new ComAjax("compare34Frm");
  				comAjax.setUrl("/markv/performance/runtimer34");
  				comAjax.setCallback("mbr_RuntimerEventCallback");
  				//comAjax.ajax();		
  				
  				 }, 500); 	  
					  
  		}else {
  			clearInterval(timer);
  		}
  	});
 
});	


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
				<h3>3,4호기 운전변수 비교</h3>
				<div class="bc"><span>MARK_V</span><span>Performance</span><strong>3,4호기 운전변수 비교</strong></div>
			</div>
			<!-- //page_title -->
			<!-- list_wrap -->
			<div class="list_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                      <li><a href="#none" id="setVar" name="setVar">변수설정</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->
                <!-- list_head -->
                <div class="list_head">
                    <div class="list_info">
	                    <form id="compare34Frm" name=compare34Frm">
						<input type = "hidden" id="sGrpID" name="sGrpID" value="${UserInfo.id }">
						<input type = "hidden" id="sMenuNo" name="sMenuNo" value = "43">
						<input type = "hidden" id="sDive" name="sDive" value = "D">
						<input type = "hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi }">
						<input type = "hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun }">
					
                        <select style="width:400px;" id="sUGrpNo" name="sUGrpNo">
                           		<c:forEach var="GroupName" items="${GroupNameList}">
                           			<c:choose>
			                           		 <c:when test="${GroupName.uGrpNo eq BaseSearch.sUGrpNo }">
			                            			<option  value="${GroupName.uGrpNo}" selected>${UserInfo.hogi } - ${GroupName.uGrpNo} ${GroupName.uGrpName}</option>
			                            	</c:when>
			                            	<c:when test="${GroupName.uGrpNo ne BaseSearch.sUGrpNo }">
			                            			<option  value="${GroupName.uGrpNo}">${UserInfo.hogi } - ${GroupName.uGrpNo} ${GroupName.uGrpName}</option>
			                            	</c:when>
                                	</c:choose>
                                </c:forEach>
                            </select>
                         </form>
                    </div>
                    <div class="button">
                        <a href="#none" class="btn_list">새로고침</a>
                    </div>
                </div>
                <!-- //list_head -->
                <!-- list_table_scroll -->
                <div class="list_table_scroll" >
	                <!-- list_table -->
	                <table class="list_table">
	                    <colgroup>
	                        <col width="40px" />
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="160px"/>
	                        <col />
	                        <col width="100px"/>
	                        <col width="100px"/>
	                        <col width="100px"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>NO</th>
	                            <th>TYPE</th>
	                            <th>ADDR</th>
	                            <th>LOOPNO</th>
	                            <th>DESC</th>
	                            <th>Value(3호기)</th>
	                            <th>Value(4호기)</th>
	                            <th>Unit</th>
	                        </tr>
	                    </thead>
	                    <tbody id="tagDccInfoList" name="tagDccInfoList">
	                      <c:forEach var="tagDccInfo" items="${TagDccInfoList}" varStatus="status">
	                        <tr>
	                            <td class="tc">${status.count}</td>
	                            <td class="tc">${tagDccInfo.IOTYPE}</td>
	                            <c:choose>
	                            	<c:when test="${tagDccInfo.IOTYPE eq 'DI' or tagDccInfo.IOTYPE eq 'DO' }">
		                            	<td class="tc">${tagDccInfo.ADDRESS} - ${tagDccInfo.IOBIT}</td>
		                            </c:when>
		                            <c:otherwise>
                            			<td class="tc">${tagDccInfo.ADDRESS}</td>
                            		</c:otherwise>
	                            </c:choose>
	                            <td class="tc">${tagDccInfo.DataLoop}</td>
	                            <td class="tc">${tagDccInfo.Descr}</td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc">${tagDccInfo.Unit}</td>
	                        </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
	                <!-- //list_table -->
				</div>	  
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


<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>변수설정</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <form id = "ioGrpNameForm" name ="ioGrpNameForm" >
            	<input type ="hidden" id="sGrpID" name="sGrpID" value="${UserInfo.id}">
				<input type ="hidden" id="sMenuNo" name="sMenuNo" value = "43">
				<input type ="hidden" id="sDive" name="sDive" value = "D">
				<input type ="hidden" id="sHogi" name="sHogi" value="${UserInfo.hogi}">
				<input type ="hidden" id="sXYGubun" name="sXYGubun" value="${UserInfo.xyGubun}">
				<input type ="hidden" id="ioUGrpNo" name="ioUGrpNo">
				<input type ="hidden" id="bGroupFlag" name="bGroupFlag">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>Title</th>
                    <td>
                        <div class="fx_form">
                            <input type="text" id="uGrpName" name="uGrpName" >
                            <a class="btn_list" herf="none" id="addUGrpName" name="addUGrpName">그룹추가</a>
                        </div>
                    </td>
                </tr>
            </table>
            </form>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table" id="uGrpTagTable" name="uGrpTagTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody id="uGrpTagList" name="uGrpTagList">
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <form id="setIOForm" name="setIOForm">
            <input type ="hidden" id="iSeq" name="iSeq">
            <table class="list_table" id=setVarTable" name="setVarTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                         <td>
                            <select id="hogi" name="hogi" readonly
				                            style="background-color:#ababab" 
									        onFocus="this.initialSelect = this.selectedIndex;" 
									        onChange="this.selectedIndex = this.initialSelect;">
                             	<c:if test="${UserInfo ne null &&  UserInfo.hogi eq '3' }">    
                                	<option value="3" selected>3</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.hogi ne '3' }">
                                	<option value="3" >3</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.hogi eq '4' }">        
                                	<option value="4" selected>4</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.hogi ne '4' }">
                                	<option value="4" >4</option>    
                                </c:if>
                            </select>
                        </td>
                        <td>
                            <select id="xyGubun" name="xyGubun"  readonly
				                            style="background-color:#ababab" 
									        onFocus="this.initialSelect = this.selectedIndex;" 
									        onChange="this.selectedIndex = this.initialSelect;">
                            <c:if test="${UserInfo ne null &&  UserInfo.xyGubun eq 'X' }">    
                                	<option value="X" selected>X</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.xyGubun ne 'X' }">
                                	<option value="X" >X</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.xyGubun eq 'Y' }">        
                                	<option value="Y" selected>Y</option>
                                </c:if>
                                <c:if test="${UserInfo ne null &&  UserInfo.xyGubun ne 'Y' }">
                                	<option value="Y" >Y</option>    
                                </c:if>
                            </select>
                        </td>
                        <td><input type="text" id="loopName" name="loopName"></td>
                        <td>
                            <select id="IOType" name="IOType">
                                <option value="AI" selected>AI</option>
                                <option value="AO">AO</option>
                                <option value="DI">DI</option>
                                <option value="DO">DO</option>
                                <option value="SC">SC</option>
                                <option value="DT">DT</option>
                            </select>
                        </td>
                        <td><input type="text" id="addresss" name="addresss"></td>
                        <td><input type="text" id="ioBit" name="ioBit"></td>
                        <td><input type="text" id="minVal" name="minVal"></td>
                        <td><input type="text" id="maxVal" name="maxVal"></td>
                        <td class="tc"><input type="checkbox" id="saveCore" name="saveCore"></td>
                    </tr>
                </tbody>
            </table>
            </form>
            <!-- //list_table -->
            <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none" onclick="openLayer('modal_2');">Tag Search</a>
                </div>
                <c:if test="${UserInfo.grade eq 1 or UserInfo.grade eq 2 }">
                <div class="button">
                    <a class="btn_list" href="#none" id="addVarTable" name="addVarTable">추가</a>
                    <a class="btn_list" href="#none" id="modVarTable" name="modVarTable">수정</a>
                    <a class="btn_list" href="#none"  id="delVarTable" name="delVarTable">삭제</a>
                    <a class="btn_list" href="#none" id="rowUp" name="rowUp">위</a>
                    <a class="btn_list" href="#none" id="rowDown" name="rowDown">아래</a>
                </div>
                </c:if>
            </div>
            <!-- //list_bottom -->
        </div>
        <!-- //list_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary" id="saveVarTable" name="saveVarTable">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>태크검색</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <form id="tagSearchForm" name="tagSearchForm">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>호기</th>
                    <td>
                        <div class="fx_form">
                          <select  id="sHogi" name="sHogi"> 
                          	<option value="3"> 3</option>
                          	<option value="4"> 4</option>
                          </select>
                           <select  id="sIOType" name="sIOType"> 
                          	<option value="">전체</option>
                          	<option value="AI"> AI</option>
                          	<option value="AO">AO</option>
                          	<option value="DI"> DI</option>
                          	<option value="DO">DO</option>
                          	<option value="SC">SC</option>
                          	<option value="DT">DT</option>
                          </select>
                        </div>
                    </td>
                    <th>검색어</th>
                    <td>
                        <div class="fx_form">
                          <input type="text" id="findData" name="findData">
                        </div>
                    </td>
                    <td>
	                    <div class="button">
	                    <a class="btn_list" href="#none" id="tagFind" name="tagFind">검색</a>
	                    <a class="btn_list" href="#none"  id="fastIoFind" name="fastIoFind">Fast All</a>
	                    </div>
                    </td>
                    <td>
	                	<div class="fx_form">
                          <input type="checkbox" id="chkOpt1" name="chkOpt1" value="1"> 태그명
                          <input type="checkbox" id="chkOpt2" name="chkOpt2" value="1" checked> 태그설명
                        </div>
                    </td>
                </tr>
            </table>
            </form>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table" id="tagSearchTable" name="tagSearchTable">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col width="60px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>LOOG NAME</th>
                        <th>DESCR</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody id="tagSearchList" name="tagSearchList">
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary" id="tagSearchSelect" name="tagSearchSelect">선택</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

