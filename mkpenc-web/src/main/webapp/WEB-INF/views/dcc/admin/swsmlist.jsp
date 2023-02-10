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
		
		$( "#iCreateDate" ).datepicker({			
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
		
		$("#swsmSearch").click(function(){
			 sendPage(1);
		});		
		
		$("#swsmInsert").click(function(){
						
			if(gfn_isEmpty("iLogNo")){
				alert("Log번호를 입력 하세요..!!");
				$("#iLogNo").focus();
				return;
			}
			
			if(gfn_isEmpty("iProNo")){
				alert("변경서 고유번호를 입력 하세요..!!");
				$("#iProNo").focus();
				return;
			}
			
			if(gfn_isEmpty("iProgName")){
				alert("프로그램명를 입력 하세요..!!");
				$("#iProgName").focus();
				return;
			}
			
			if(gfn_isEmpty("iDivide")){
				alert("분류를 입력 하세요..!!");
				$("#iDivide").focus();
				return;
			}			
			
			if(gfn_isEmpty("iHogi")){
				alert("호기를 입력 하세요..!!");
				$("#iHogi").focus();
				return;
			}
			
			var	comSubmit	=	new ComSubmit("swsmInsertForm");
			comSubmit.setUrl("/dcc/admin/swsmInsert");
			comSubmit.submit();
		});		
		
		$("#swsmImport").on('click', function(e){
			
			var fileVal = $("#importExcelFile").val();
			
			if(fileVal == ""){
				alert("등록 파일을 선택하세요..!!!");
				$("#importExcelFile").focus();
				return;
			}

			if( fileVal != "" ){
				var ext = fileVal.split('.').pop().toLowerCase(); //확장자분리

		        //아래 확장자가 있는지 체크
				if($.inArray(ext, ["xls","xlsx"]) == -1) {
					alert("'xlsx,xls' 파일만 업로드 할수 있습니다....!!!");
					return;
		        }
		    }			
			
			if (confirm("선택한 엑셀 파일을 등록 합니다..!!")) {	
		
				var	comSubmit	=	new ComSubmit("swsmImportForm");
				comSubmit.setUrl("/dcc/admin/swsmExcelImport");
				comSubmit.submit();		    
			}else {
				alert("엑셀파일 등록을 취소 합니다...!!");
			}
		});
	});
	
	function sendPage(pageNum){

		var	comSubmit	=	new ComSubmit("swsmForm");
		comSubmit.addParam("pageNum", pageNum);
		comSubmit.setUrl("/dcc/admin/swsmlist");
		comSubmit.submit();
	}
	
	function swsmDetail(seqNo){
	
		var comAjax = new ComAjax("swsmInfoForm");
		comAjax.addParam("seqNo",seqNo);
		comAjax.setUrl("/dcc/admin/swsmDetail");
		comAjax.setCallback("mbr_SwSmEventCallback");
		comAjax.ajax();
		
		openLayer('modal_2');
		
	}
	
	function swsmDownload(seqNo, fileIdx){
		
		if (confirm("선택한 파일을 다운로드 합니다..!!")) {	
		
			var	comSubmit	=	new ComSubmit("swsmForm");
			comSubmit.addParam("seqNo", seqNo);
			comSubmit.addParam("fileIdx", fileIdx);
			comSubmit.setUrl("/dcc/admin/swsmDownload");
			comSubmit.submit();
			
		}else {
			alert("선택한 파일의 다운로드를 취소 합니다..!!");
		}
	}
	
	function excelExport(){
		
		if (confirm("검색 조건으로 파일을 다운로드 합니다..!!")) {	
			
			var	comSubmit	=	new ComSubmit("swsmForm");
			comSubmit.setUrl("/dcc/admin/swsmExcelExport");
			comSubmit.submit();
			
		}else {
			alert("검색 조건의  파일의 다운로드를 취소 합니다..!!");
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
				<h3>S/W 형상관리</h3>
				<div class="bc"><span>DCC</span><span>Admin</span><strong>S/W 형상관리</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
				<form id="swsmForm" name="swsmForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>검색조건</label>
							<div class="fx_form">
								<select class="fx_none" style="width:120px;" id="searchKey" name="searchKey">
										<option value="progName" >프로그램명</option>
										<option value="logNo" >Log번호</option>
										<option value="descr">내용</option>
										<option value="createDate" >일자</option>
								</select>
								<input type="text"  id="searchWord" name="searchWord">
							</div>
						</div>
                        <div class="fx_srch_item"></div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch"  id="swsmSearch" name="swsmSearch">Search</a>
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
						<a class="btn_list" href="javascript:openLayer('modal_1')">등록</a>
						<a class="btn_list excel_up" href="javascript:openLayer('modal_3')">엑셀일괄등록</a>
						<a class="btn_list excel_down" href="javascript:excelExport()"  >엑셀저장</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table" id="swsmListTable" name="swsmListTable">
                    <colgroup>
                        <col width="80px"/>
                        <col width="140px"/>
                        <col width="120px"/>
                        <col width="80px"/>
                        <col />
                        <col width="120px"/>
                        <col width="100px"/>
                        <col width="100px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>Log번호</th>
                            <th>변경서고유번호</th>
                            <th>프로그램명</th>
                            <th>분류</th>
                            <th>내용</th>
                            <th>일자</th>
                            <th>호기</th>
                            <th>첨부파일</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <c:forEach var="SwSmInfo" items="${SwSmInfoList}">
                        <tr onClick="javascript:swsmDetail('${SwSmInfo.seqNo}')">
                            <td class="tc">${SwSmInfo.logNo}</td>
                            <td class="tc">${SwSmInfo.proNo}</td>
                            <td class="tc">${SwSmInfo.progName}</td>
                            <td class="tc">${SwSmInfo.divide}</td>
                            <td>${SwSmInfo.descr}</td>
                            <td class="tc">${SwSmInfo.createDate}</td>
                            <td class="tc">${SwSmInfo.hogi}</td>
                            <td class="tc"> <c:if test="${SwSmInfo.fileName1 ne '' }"> Y </c:if></td>
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
	    <h3>S/W 형상관리 등록</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents" style="max-height:460px;">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="swsmInsertForm" name="swsmInsertForm" enctype="multipart/form-data">
			<!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>Log번호 *</th>
                    <td><input type="text"  id="iLogNo" name="iLogNo"></td>
                </tr>
                <tr>
                    <th>변경서 고유번호 *</th>
                    <td><input type="text" id="iProNo" name = "iProNo"></td>
                </tr>
                <tr>
                    <th>프로그램 명 *</th>
                    <td><input type="text"  id="iProgName" name = "iProgName"></td>
                </tr>                           
                <tr>
                    <th>분류 *</th>
                    <td><input type="text"  id="iDivide" name = "iDivide"></td>
                </tr>
                <tr>
                    <th>내용 </th>
                    <td><textarea style="height:240px;" id="iDescr" name = "iDescr"></textarea></td>
                </tr>
                <tr>
					<th>일자 </th>
                    <td><input type="text"  id="iCreateDate" name = "iCreateDate"></td>
                </tr>
                <tr>
                    <th>호기 *</th>
                    <td> <input type="text"   id="iHogi" name="iHogi"></td>                             
                </tr>
                 <tr>
                    <th>비고 </th>
                    <td> <input type="text"   id="iBigo" name="iBigo"></td>                             
                </tr>      
                <tr>
                    <th>첨부파일1</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
                <tr>
                    <th>첨부파일2</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
                </tr>   
                <tr>
                    <th>첨부파일3</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
                <tr>
                    <th>첨부파일4</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
                </tr>
                <tr>
                    <th>첨부파일5</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
                <tr>
                    <th>첨부파일6</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
                </tr>
                <tr>
                    <th>첨부파일7</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
                <tr>
                    <th>첨부파일8</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
                </tr>
                <tr>
                    <th>첨부파일9</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
                <tr>
                    <th>첨부파일10</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
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
        <a href="#none" class="btn_page"  id="swsmInsert" name="swsmInsert">등록</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->



<!-- layer_pop_wrap -->
<div class="layer_pop_wrap medium" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>S/W 형상관리 상세</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents"  style="max-height:460px;">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="swsmUpdateForm" name="swsmUpdateForm" enctype="multipart/form-data">
			<!-- form_table -->
            <table class="form_table" >
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tbody id="swsmInfo">
                <tr>
                    <th>Log번호 *</th>
                    <td><input type="text"  id="iLogNo" name="iLogNo"></td>
                </tr>
                <tr>
                    <th>변경서 고유번호 *</th>
                    <td><input type="text" id="iProNo" name = "iProNo"></td>
                </tr>
                <tr>
                    <th>프로그램 명 *</th>
                    <td><input type="text"  id="iProgName" name = "iProgName"></td>
                </tr>                           
                <tr>
                    <th>분류 *</th>
                    <td><input type="text"  id="iDivide" name = "iDivide"></td>
                </tr>
                <tr>
                    <th>내용 </th>
                    <td><textarea style="height:240px;" id="iDescr" name = "iDescr"></textarea></td>
                </tr>
                <tr>
					<th>일자 </th>
                    <td><input type="text"  id="iCreateDate" name = "iCreateDate"></td>
                </tr>
                <tr>
                    <th>호기 *</th>
                    <td> <input type="text"   id="iHogi" name="iHogi"></td>                             
                </tr>
                 <tr>
                    <th>비고 </th>
                    <td> <input type="text"   id="iBigo" name="iBigo"></td>                             
                </tr>      
                <tr>
                    <th>첨부파일1</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
               <tr>
                    <th>첨부파일2</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
                </tr>   
                <tr>
                    <th>첨부파일3</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
                <tr>
                    <th>첨부파일4</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
                </tr>
                <tr>
                    <th>첨부파일5</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
                <tr>
                    <th>첨부파일6</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
                </tr>
                <tr>
                    <th>첨부파일7</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
                <tr>
                    <th>첨부파일8</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
                </tr>
                <tr>
                    <th>첨부파일9</th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>  
                <tr>
                    <th>첨부파일10</th>
                    <td><input type="file"  id="fileNames" name = "fileNames" ></td>
                </tr>        
                </tbody>                     
            </table>
			<!-- //form_table -->
		</form>
		</div>
		<!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page"  id="swsmInsert" name="swsmInsert">삭제</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->



<!-- layer_pop_wrap -->
<div class="layer_pop_wrap medium" id="modal_3">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>S/W 형상관리 엑셀등록</h3>
        <a onclick="closeLayer('modal_3');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="swsmImportForm" name="swsmImportForm" enctype="multipart/form-data">
			<!-- form_table -->
            <table class="form_table" >
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tbody id="swsmInfo">
                <tr>
                    <th>등록 엑셀 파일</th>
                    <td><input type="file"  id="importExcelFile" name = "importExcelFile" ></td>
                </tr>
                </tbody>                     
            </table>
			<!-- //form_table -->
		</form>
		</div>
		<!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page"  id="swsmImport" name="swsmImport">등록</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_3');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

</body>
</html>



