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
var timerOn = false;

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
		
		$("#restartCodeInsert").click(function(){
			
			if(!inputVaildationCheck()){
			  return;	
			}
			
			if (confirm("데이터를 등록 합니다..!!")) {	
				var	comSubmit	=	new ComSubmit("restartCodeInsertForm");
				comSubmit.setUrl("/dcc/admin/restartcodeinsert");
				comSubmit.submit();
			}else {
				alert("데이터 등록을 취소 합니다..!!");
			}		
		});	
		
		$("#restartCodeDelete").click(function(){

			if (confirm("데이터를 삭제 합니다..!!")) {	

				var	comSubmit	=	new ComSubmit("restartCodeModifyForm");
				comSubmit.addParam("intSeqNo", $("#seqNo").val());				
				comSubmit.setUrl("/dcc/admin/restartcodedelete");
				comSubmit.submit();
				
			}else {
				alert("데이터 삭제를 취소 합니다..!!");
			}		
		});				

		$("#restartCodeUpdate").click(function(){

			if(!inputVaildationCheck()){
				  return;	
			}

			if (confirm("데이터를 수정 합니다..!!")) {	

				var	comSubmit	=	new ComSubmit("restartCodeModifyForm");
				comSubmit.setUrl("/dcc/admin/restartcodeupdate");
				comSubmit.submit();
				
			}else {
				alert("데이터 수정를 취소 합니다..!!");
			}		
		});	
		
		$("#restartCodeSearch").click(function(){
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
		
		if(gfn_isEmpty("iXYGubun")){
			alert("XY 구분를 입력 하세요..!!");
			$("#iXYGubun").focus();
			return false;
		}
		
		if(gfn_isEmpty("iCreateDate")){
			alert("날짜를 입력 하세요..!!");
			$("#iCreateDate").focus();
			return false;
		}

		if(gfn_isDate("iCreateDate")){
			alert("날짜형식(yyyy-mm-dd)를 입력 하세요..!!");
			$("#iCreateDate").focus();
			return false;
		}		

		if(gfn_isEmpty("iType")){
			alert("형식을 입력 하세요..!!");
			$("#iType").focus();
			return false;
		}
		
		if(gfn_isEmpty("iRestartCode")){
			alert("Restart Code를 입력 하세요..!!");
			$("#iRestartCode").focus();
			return false;
		}
		
		if(gfn_isEmpty("iDescr")){
			alert("내용을 입력 하세요..!!");
			$("#iDescr").focus();
			return false;
		}

		return true;
	}
	
	function restartCodeDownload(seqNo, fileIdx){
		
		if (confirm("선택한 파일을 다운로드 합니다..!!")) {	
		
			var	comSubmit	=	new ComSubmit("restartCodeModifyForm");
			comSubmit.addParam("intSeqNo", seqNo);
			comSubmit.addParam("fileIdx", fileIdx);
			comSubmit.setUrl("/dcc/admin/restartCodeDownload");
			comSubmit.submit();
			
		}else {
			alert("선택한 파일의 다운로드를 취소 합니다..!!");
		}
	}
	
	function restartCodeDetail(seqNo){
		
		$("#seqNo").val(seqNo);
		
		var comAjax = new ComAjax("restartCodeModifyForm");
		comAjax.addParam("intSeqNo", seqNo);
		comAjax.setUrl("/dcc/admin/restartcodedetail");
		comAjax.setCallback("mbr_RestartCodeEventCallback");
		comAjax.ajax();
		
		openLayer('modal_2');
		
	}
	
	function sendPage(pageNum){
		
		var	comSubmit	=	new ComSubmit("restartCodeForm");
		comSubmit.addParam("pageNum", pageNum);
		comSubmit.setUrl("/dcc/admin/restartcodelist");
		comSubmit.submit();
	}
	
</script>

</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-dcc-header.jspf" %>
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>재기동관리</h3>
				<div class="bc"><span>DCC</span><span>Admin</span><strong>재기동관리</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
				<form id="restartCodeForm" name="restartCodeForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>호기</label>
                            <div class="fx_form">
                                <select id="hogi" name="hogi">
                                    <option value="">전체</option>
                                    <option value="3" >3호기</option>
									<option value="4" >4호기</option>
                                </select>
                                <select id="xyGubun" name="xyGubun">
                                	<option value="">전체</option>
                                    <option value="X">X</option>
                                    <option value="Y">Y</option>
                                </select>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>형식</label>
                            <select  id="type" name="type">
                                <option value="">전체</option>
                                <option value="0" >Stall</option>
								<option value="1">Restart</option>
                            </select>
						</div>
						<div class="fx_srch_item">
							<label>Restart Code</label>
                            <select id="restartCode" name="restartCode">
                                <option value="">전체</option>
                                <option value="111111" >Initial Cold Start</option>
								<option value="000503" >Console Interrupt</option>
								<option value="100514" >Power Fail/Up</option>
								<option value="000517" >Memory Parity Error</option>
								<option value="000522" >Watchdog Time-Out</option>
								<option value="011112" >IIIegal Memory Map Violations</option>
                            </select>
						</div>
						<div class="fx_srch_item">
							<label>내용</label>
                            <input type="text"  id="descr" name="descr">
						</div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="restartCodeSearch" name="restartCodeSearch">Search</a>
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
						<a class="btn_list primary" href="javascript:openLayer('modal_1')">등록</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table" id="restartCodeListTable" name="restartCodeListTable">
                    <colgroup>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="120px"/>
                        <col width="120px"/>
                        <col width="240px"/>
                        <col />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>호기</th>
                            <th>형식</th>
                            <th>날짜</th>
                            <th>Type</th>
                            <th>Restart Code</th>
                            <th>내용</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="restartCodeInfo" items="${RestartCodeInfoList}">
                        <tr onClick="javascript:restartCodeDetail('${restartCodeInfo.seqNo}')">
                            <td class="tc">${restartCodeInfo.hogi}</td>
                            <td class="tc">${restartCodeInfo.xyGubun}</td>
                            <td class="tc">${restartCodeInfo.createDate}</td>
                            <td class="tc">
		                            <c:if test="${restartCodeInfo.type eq '0' }"> Stall </c:if>                            
		                            <c:if test="${restartCodeInfo.type eq '1' }"> Restart </c:if>
                            </td>
                            <td>
                            		<c:if test="${restartCodeInfo.restartCode eq '000503' }"> Console Interrupt </c:if>     
                            		<c:if test="${restartCodeInfo.restartCode eq '000517' }"> Memory Parity Error </c:if>
                            		<c:if test="${restartCodeInfo.restartCode eq '000522' }"> Watchdog Time-Out </c:if>
                            		<c:if test="${restartCodeInfo.restartCode eq '011112' }"> IIIegal Memory Map Violations </c:if>
                            		<c:if test="${restartCodeInfo.restartCode eq '100514' }"> Power Fail/Up </c:if>
                            		<c:if test="${restartCodeInfo.restartCode eq '111111' }"> Initail Cold Start </c:if>
							</td>
                            <td>${restartCodeInfo.descr}</td>
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
	    <h3>H/W 형상관리 등록</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="restartCodeInsertForm" name="restartCodeInsertForm"  enctype="multipart/form-data">
			<!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>호기 *</th>
                    <td>   <select id="iHogi" name="iHogi">
                                    <option value="3" >3호기</option>
									<option value="4" >4호기</option>
                                </select>
                                <select id="iXYGubun" name="iXYGubun">
                                    <option value="X">X</option>
                                    <option value="Y">Y</option>
                                </select></td>                             
                </tr>
                <tr>
					<th>일자 * </th>
                    <td><input type="text"  id="iCreateDate" name = "iCreateDate"></td>
                </tr>
                <tr>
					<th>형식 * </th>
                    <td> <select  id="iType" name="iType">
                                <option value="0" >Stall</option>
								<option value="1">Restart</option>
                            </select></td>
                </tr>
                <tr>
					<th>Restart Code * </th>
                    <td> <select id="iRestartCode" name="iRestartCode">
                                <option value="111111" >Initial Cold Start</option>
								<option value="000503" >Console Interrupt</option>
								<option value="100514" >Power Fail/Up</option>
								<option value="000517" >Memory Parity Error</option>
								<option value="000522" >Watchdog Time-Out</option>
								<option value="011112" >IIIegal Memory Map Violations</option>
                            </select></td>
                </tr>
                <tr>
                    <th>내용 *</th>
                    <td><textarea style="height:240px;" id="iDescr"    name = "iDescr"></textarea></td>
                </tr>                
                <tr>
					<th>등록 파일 1  </th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>
                <tr>
					<th>등록 파일 2  </th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>
                <tr>
					<th>등록 파일 3 </th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>
                <tr>
					<th>등록 파일 4 </th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
                </tr>
                <tr>
					<th>등록 파일 5  </th>
                    <td><input type="file"  id="fileNames" name = "fileNames"></td>
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
        <a href="#none" class="btn_page"  id="restartCodeInsert" name="restartCodeInsert">등록</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->


<!-- layer_pop_wrap -->
<div class="layer_pop_wrap medium" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>재기동 관리 상세</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
		<form id="restartCodeModifyForm" name="restartCodeModifyForm" >
		<input type="hidden"  id="seqNo" name="seqNo" />
			<!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <!--  jquery redefine -->
                <tbody id="restartCodeInfo">
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
        <a href="#none" class="btn_page"  id="restartCodeDelete" name="restartCodeDelete">삭제</a>        
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

</body>
</html>

