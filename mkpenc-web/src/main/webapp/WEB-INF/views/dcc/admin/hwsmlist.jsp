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

<script type="text/javascript" >

	$(function () {
		
			$( "#iDate" ).datepicker({			
				dateFormat: 'yy-mm-dd' //달력 날짜 형태
	           , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	           , showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
	           , changeYear: true //option값 년 선택 가능
	           , changeMonth: true //option값  월 선택 가능                
	           , buttonImage: "/resources/images/common/calendar.gif" //버튼 이미지 경로
	           , buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
	           , buttonText: "선택" //버튼 호버 텍스트              
	           , monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
	           , monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
	           , dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	           , dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
	           , minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	           , maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
	       });
			
			$(document.body).delegate('#hwsmListTable tr', 'click', function() {

				$("#iHogi").val($(this).children().eq(0).text());
				$("#iType").val($(this).children().eq(1).text());
				$("#iDate").val($(this).children().eq(2).text());		      
				$("#iFailure").val($(this).children().eq(3).text());
				$("#iRepair").val($(this).children().eq(4).text());
				$("#iSeqNo").val($(this).children().eq(5).text());

				openLayer('modal_1');
			});
			
			$("#openhwsmInsert").click(function(){
				$("#iHogi").val("");
				$("#iType").val("");
				$("#iDate").val("");		      
				$("#iFailure").val("");
				$("#iRepair").val("");
				$("#iSeqNo").val("");
				
				openLayer('modal_1')	
			});	
			
			$("#hwsmInsert").click(function(){
			
				if(!inputVaildationCheck()){
				  return;	
				}
				
				if (confirm("데이터를 등록 합니다..!!")) {	
					var	comSubmit	=	new ComSubmit("hwsmModifyForm");
					comSubmit.setUrl("/dcc/admin/hwsminsert");
					comSubmit.submit();
				}else {
					alert("데이터 등록을 취소 합니다..!!");
				}		
			});	
		
		
			$("#hwsmDelete").click(function(){
			
				if (confirm("데이터를 삭제 합니다..!!")) {	

					var	comSubmit	=	new ComSubmit("hwsmModifyForm");
					comSubmit.setUrl("/dcc/admin/hwsmdelete");
					comSubmit.submit();
					
				}else {
					alert("데이터 삭제를 취소 합니다..!!");
				}		
			});

			$("#hwsmUpdate").click(function(){
	
				if(!inputVaildationCheck()){
					  return;	
				}

				if (confirm("데이터를 수정 합니다..!!")) {	

					var	comSubmit	=	new ComSubmit("hwsmModifyForm");
					comSubmit.setUrl("/dcc/admin/hwsmupdate");
					comSubmit.submit();
					
				}else {
					alert("데이터 수정를 취소 합니다..!!");
				}		
			});				
		
			$("#hwsmSearch").click(function(){
				sendPage(1);
			});		
	});
	
	function inputVaildationCheck(){
		
		if(gfn_isEmpty("iHogi")){
			alert("호기를 입력 하세요..!!");
			$("#iHogi").focus();
			return false;
		}

		if(gfn_isNumeric("iHogi")){
			alert("숫자를 입력하십시오!!!");
			$("#iHogi").focus();
			return false;
		}				

		if(gfn_isEmpty("iType")){
			alert("형식을 입력 하세요..!!");
			$("#iType").focus();
			return false;
		}

		if(gfn_isEmpty("iDate")){
			alert("날짜를 입력 하세요..!!");
			$("#iDate").focus();
			return false;
		}

		if(!gfn_isDate("iDate")){
			alert("날짜형식(yyyy-mm-dd)를 입력 하세요..!!");
			$("#iDate").focus();
			return false;
		}				

		if(gfn_isEmpty("iFailure")){
			alert("고장원인을 입력 하세요..!!");
			$("#iFailure").focus();
			return false;
		}

		if(gfn_isEmpty("iRepair")){
			alert("정비내용을 입력 하세요..!!");
			$("#iRepair").focus();
			return false;
		}		
		
		return true;
	}
	
	function sendPage(pageNum){
		
		var	comSubmit	=	new ComSubmit("hwsmForm");
		comSubmit.addParam("pageNum", pageNum);
		comSubmit.setUrl("/dcc/admin/hwsmlist");
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
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>S/W 형상관리</h3>
				<div class="bc"><span>DCC</span><span>Admin</span><strong>H/W 형상관리</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
				<form id="hwsmForm" name="hwsmForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>호기</label>
                            <div class="fx_form">
                                <select id="hogi" name="hogi">
                                    <option value="3" >3호기</option>
									<option value="4" >4호기</option>
                                </select>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>전산기</label>
                            <select  id="type" name="type">
                                <option>전체</option>
                              	<option value="X" >X</option>
								<option value="Y" >Y</option>
								<option value="Z" >Z</option>
								<option value="SDS#1" >SDS#1</option>
								<option value="SDS#2" >SDS#2</option>
								<option value="0" >공용</option>
                            </select>
						</div>
						<div class="fx_srch_item">
							<label>Restart Code</label>
                            <select id="searchKey" name="searchKey" class="fx_none" style="width:190px;">
                                <option>전체</option>
                                <option value="failure">failure</option>
								<option value="repair">repair</option>
                            </select>
                            <input type="text" id="searchWord" name="searchWord">
						</div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="hwSmSearch" name="hwSmSearch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->

			<!-- list_wrap -->
			<div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<div class="list_info">
						<label>Total : <strong>${BaseSearch.totalCnt}</strong></label>
					</div>
					<!-- button -->
					<div class="button">
						<a class="btn_list" href="#none" id="openhwsmInsert">등록</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table"  id="hwsmListTable" name="hwsmListTable">
                    <colgroup>
                        <col width="80px"/>
                        <col width="140px"/>
                        <col width="120px"/>
                        <col />
                        <col />

                    </colgroup>
                    <thead>
                        <tr>
                            <th>호기</th>
                            <th>형식</th>
                            <th>날짜</th>
                            <th>고장원인</th>
                            <th>정비내용</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="HwSmInfo" items="${HwSmInfoList}">
                        <tr>
                            <td class="tc">${HwSmInfo.hogi}</td>
                            <td class="tc">${HwSmInfo.type}</td>
                            <td class="tc">${HwSmInfo.date}</td>
                            <td>${HwSmInfo.failure}</td>
                            <td>${HwSmInfo.repair}</td>
                            <td style="display:none;">${HwSmInfo.seqNo}</td>                           
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- //list_table -->	
                <!-- paginate -->
				<div class="paginate">
					${PageHtml}
				</div>
				<!-- //paginate -->
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
<div class="layer_pop_wrap medium" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>H/W 형상관리 관리</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="hwsmModifyForm" name="hwsmModifyForm">
		<input type="hidden"  id="iSeqNo" name="iSeqNo" />
			<!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>호기 *</th>
                    <td> <input type="text"   id="iHogi" name="iHogi"></td>                             
                </tr>
                <tr>
                    <th>형식 *</th>
                    <td><input type="text" id="iType" name = "iType"></td>
                </tr>
                <tr>
					<th>일자 </th>
                    <td><input type="text"  id="iDate" name = "iDate"></td>
                </tr>
                <tr>
                    <th>고장원인 *</th>
                    <td><textarea style="height:240px;" id="iFailure"    name = "iFailure"></textarea></td>
                </tr>
                 <tr>
                    <th>정비내용 </th>
                     <td><textarea style="height:240px;" id="iRepair"   name = "iRepair"></textarea></td>                             
                </tr>      
            </table>
			<!-- //form_table -->
		</form>
		</div>
		<!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page"  id="hwsmInsert" name="hwsmInsert">등록</a>
        <a href="#none" class="btn_page"  id="hwsmUpdate" name="hwsmUpdate">수정</a>
        <a href="#none" class="btn_page"  id="hwsmDelete" name="hwsmDelete">삭제</a>        
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->



</body>
</html>



