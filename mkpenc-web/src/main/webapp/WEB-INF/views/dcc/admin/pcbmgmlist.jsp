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
<script type="text/javascript" src="<c:url value="/resources/js/admin.js" />" charset="utf-8"></script>
<script type="text/javascript" >
var timerOn = false;

	$(function () {
		
		$(document.body).delegate('#equipListTable tr', 'click', function() {
			
			var comAjax = new ComAjax("equipUpdateForm");
			
			comAjax.addParam("intSeqNo",	$(this).children().eq(15).text());
			comAjax.setUrl("/dcc/admin/pcbinfo");
			comAjax.setCallback("mbr_EquipInfoCallback");
			comAjax.ajax();
			
			$("#uSeqNo").val($(this).children().eq(15).text())
			
			openLayer('modal_2')				
		});
		
		$("#equipSearch").click(function(){
			 sendPage(1);
		});		
		
		$("#openPcbInsert").click(function(){
			openLayer('modal_1');	
		});	
		
		$("#equipInsert").click(function(){
			
			if(gfn_isEmpty("iInvnr")){
				alert("관리번호를 입력 하세요..!!");
				$("#iInvnr").focus();
				return;
			}
			
			if(!gfn_isEmpty("iInsDate")){
				if(!gfn_isDate2("iInsDate")){
					alert("날짜형식(yyyymmdd)를 입력 하세요..!!");
					$("#iInsDate").focus();
					return false;
				}				
			}
			
			if (confirm("전자회로기판을 등록 합니다..!!")) {	
				
				var	comSubmit	=	new ComSubmit("equipInsertForm");
				comSubmit.setUrl("/dcc/admin/pcbinsert");
				comSubmit.submit();

			}else {
				alert("전자회로기판 관리 등록을 취소 합니다...!!");
			}			
		});	
		
		$("#equipUpdate").click(function(){
			
			if(gfn_isEmpty("uInvnr")){
				alert("관리번호를 입력 하세요..!!");
				$("#uInvnr").focus();
				return;
			}

			if(!gfn_isDate2("uInsDate")){
				alert("날짜형식(yyyymmdd)를 입력 하세요..!!");
				$("#uInsDate").focus();
				return false;
			}		
			
			if (confirm("전자회로기판을 수정 합니다..!!")) {	
				
				var	comSubmit	=	new ComSubmit("equipUpdateForm");
				comSubmit.addParam("intSeqNo",	$("#uSeqNo").val());
				comSubmit.setUrl("/dcc/admin/pcbupdate");
				comSubmit.submit();

			}else {
				alert("전자회로기판 관리 수정을 취소 합니다...!!");
			}			
		});	
		
		$("#equipDelete").click(function(){
			
			if(gfn_isEmpty("uInvnr")){
				alert("관리번호를 입력 하세요..!!");
				$("#uInvnr").focus();
				return;
			}
			
			if (confirm("전자회로기판을 삭제 합니다..!!")) {	
				
				var	comSubmit	=	new ComSubmit("equipUpdateForm");
				comSubmit.addParam("intSeqNo",	$("#uSeqNo").val());
				comSubmit.setUrl("/dcc/admin/pcbdelete");
				comSubmit.submit();

			}else {
				alert("전자회로기판 관리 삭제을 취소 합니다...!!");
			}			
		});			
		
	});
	
	function sendPage(pageNum){
		
		var	comSubmit	=	new ComSubmit("equipInfoForm");
		comSubmit.addParam("pageNum", pageNum);
		comSubmit.setUrl("/dcc/admin/pcbmgmlist");
		comSubmit.submit();
	}
	
	function excelExport(){
		
		if (confirm("검색 조건으로 파일을 다운로드 합니다..!!")) {	
			
			var	comSubmit	=	new ComSubmit("equipInfoForm");
			comSubmit.setUrl("/dcc/admin/equipExcelExport");
			comSubmit.submit();
			
		}else {
			alert("선택한 파일의 다운로드를 취소 합니다..!!");
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
				<h3>PCB</h3>
				<div class="bc"><span>DCC</span><span>Admin</span><strong>전자회로기판 관리</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
				<form id="equipInfoForm" name="equipInfoForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>관리번호</label>
                            <input type="text" id="invnr" name="invnr">
						</div>
						<div class="fx_srch_item">
							<label>현상태</label>
                            <select id="state" name="state">
                                <option value="">전체</option>
                                <option value="계통사용">계통사용</option>
								<option value="비상대비용" >비상대비용</option>
								<option value="수리중" >수리중</option>
								<option value="폐기" >폐기</option>
                            </select>
						</div>
						<div class="fx_srch_item">
							<label>자재번호</label>
                            <input type="text" id="materialNo" name="materialNo">
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>S/N</label>
                            <input type="text" id="sn" name="sn">
						</div>
						<div class="fx_srch_item double">
							<label>검색조건</label>
                            <div class="fx_form">
                                <select class="fx_none" style="width:120px" id="searchKey" name="searchKey">
                                    <option>계통명</option>
                                    <option value="sysNm">계통명</option>
									<option value="equipNm" >품명</option>
									<option value="rack">위치</option>
                                </select>
                                <input type="text" id="searchWord" name ="searchWord">
                            </div>
						</div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="equipSearch" name="equipSearch">Search</a>
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
						<a class="btn_list" href="#none" id="openPcbInsert">등록</a>
						<a class="btn_list excel_down" href="javascript:excelExport()"  >엑셀저장</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
                <!-- list_table -->
                <table class="list_table"  id="equipListTable" name="equipListTable">
                    <colgroup>
                        <col width="140px"/>
                        <col width="80px"/>
                        <col width="120px"/>
                        <col width="100px"/>
                        <col width="120px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">관리번호</th>
                            <th rowspan="2">계통명</th>
                            <th rowspan="2">품명</th>
                            <th rowspan="2">현상태</th>
                            <th rowspan="2">위치</th>
                            <th rowspan="2">점검방법</th>
                            <th rowspan="2">점검주기</th>
                            <th colspan="4">PCB</th>
                            <th colspan="4">취약부품</th>
                        </tr>
                        <tr>
                            <th>제작일자</th>
                            <th>자재번호</th>
                            <th>설치일자</th>
                            <th>교체주기</th>
                            <th>취약부품명</th>
                            <th>자재번호</th>
                            <th>교체일자</th>
                            <th>교체주기</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="equipInfo" items="${EquipInfoList}">
                        <tr>
                            <td class="tc">${equipInfo.invnr}</td>
                            <td class="tc">${equipInfo.sysNm}</td>
                            <td class="tc">${equipInfo.equipNm}</td>
                            <td class="tc">${equipInfo.state}</td>
                            <td class="tc">${equipInfo.rack}</td>
                            <td class="tc">${equipInfo.chkMeth}</td>
                            <td class="tc">${equipInfo.chkCycle}</td>
                            <td class="tc">${equipInfo.proDate}</td>
                            <td class="tc">${equipInfo.materialNo}</td>
                            <td class="tc">${equipInfo.insDate}</td>
                            <td class="tc">${equipInfo.chkCycle}</td>
                            <td class="tc">${equipInfo.weakPart}</td>
                            <td class="tc">${equipInfo.pmNo}</td>
                            <td class="tc">${equipInfo.pcDate}</td>
                            <td class="tc">${equipInfo.pcCycle}</td>
                            <td style="display:none;">${equipInfo.seqNo}</td>
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
<div class="layer_pop_wrap large" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>전자회로기판 관리 등록</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
			<!-- form_table -->
			<form id="equipInsertForm" name="equipInsertForm">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th colspan="4">Ⅰ. 관리번호</th>
                </tr>  
                <tr>
                    <th>관리번호 * </th>
                    <td><input type="text" id="iInvnr" name="iInvnr"></td>
                    <th>담당자</th>
                    <td><input type="text" id="iUserNm" name="iUserNm"></td>
                </tr>
                <tr>
                    <th>호기</th>
                    <td><input type="text" id="iHogi" name="iHogi"></td>
                    <th>설치장소</th>
                    <td><input type="text" id="iInsLoc" name="iInsLoc"></td>
                </tr>       
                <tr>
                    <th>품명</th>
                    <td><input type="text" id="iEquipNm" name="iEquipNm"></td>
                    <th>태그번호</th>
                    <td><input type="text" id="iTagNo" name="iTagNo"></td>
                </tr>  
                <tr>
                    <th colspan="4">Ⅱ. 사양</th>
                </tr>
                <tr>
                    <th>제작사</th>
                    <td><input type="text" id="iProduct" name="iProduct"></td>
                    <th>계통명</th>
                    <td><input type="text" id="iSysNm" name="iSysNm"></td>
                </tr>  
                <tr>
                    <th>Part No.</th>
                    <td><input type="text" id="iPn" name="iPn"></td>
                    <th>Serial No.</th>
                    <td><input type="text" id="iSn" name="iSn"></td>
                </tr>
                <tr>
                    <th>자재번호</th>
                    <td><input type="text" id="iMaterialNo" name="iMaterialNo"></td>
                    <th>설치위치(RACK)</th>
                    <td><input type="text" id="iRack" name="iRack"></td>
                </tr>
                <tr>
                    <th>제작연도</th>
                    <td><input type="text" id="iProDate" name="iProDate"></td>
                    <th>REV . NO</th>
                    <td><input type="text" id="iRev" name="iRev"></td>
                </tr>
                <tr>
                    <th>취약부품</th>
                    <td><input type="text" id="iWeakPart" name="iWeakPart"></td>
                    <th>설치일자</th>
                    <td><input type="text" id="iInsDate" name="iInsDate"></td>
                </tr>
                <tr>
                    <th>FID</th>
                    <td><input type="text" id="iFid" name="iFid"></td>
                    <th>SPV</th>
                    <td><input type="text" id="iiSpv" name="iiSpv"></td>
                </tr>
                <tr>
                    <th>품질등급</th>
                    <td><input type="text" id="iQGrade" name="iQGrade"></td>
                    <th>저장등급</th>
                    <td><input type="text" id="iSGrade" name=""iSGrade""></td>
                </tr>
                <tr>
                    <th>저장수명</th>
                    <td><input type="text" id="iSYear" name="iSYear"></td>
                    <th>공급자</th>
                    <td><input type="text" id="iSupplier" name="iSupplier"></td>
                </tr>
                <tr>
                    <th>PO</th>
                    <td><input type="text" id="iPo" name="iPo"></td>
                    <th>최종입고일자</th>
                    <td><input type="text" id="iInDate" name="iInDate"></td>
                </tr>
                <tr>
                    <th>최종입고수량</th>
                    <td><input type="text" id="iInCnt" name="iInCnt"></td>
                    <th>현상태</th>
                    <td><input type="text" id="iState" name="iState"></td>
                </tr>
                <tr>
                    <th>취약부품명</th>
                    <td><input type="text" id="iWPartNm" name="iWPartNm"></td>
                    <th>부품자재번호</th>
                    <td><input type="text" id="iPmNo" name="iPmNo"></td>
                </tr>
                <tr>
                    <th>부품교체일자</th>
                    <td><input type="text" id="iPcDate" name="iPcDate"></td>
                    <th>부품교체주기</th>
                    <td><input type="text" id="iPcCycle" name="iPcCycle"></td>
                </tr>
                <tr>
                    <th>ICT주기</th>
                    <td><input type="text" id="iIctCycle" name="iIctCycle"></td>
                    <th>교체주기</th>
                    <td><input type="text" id="iChgCycle" name="iChgCycle"></td>
                </tr>
                <tr>
                    <th>점검방법</th>
                    <td><input type="text" id="iChkMeth" name="iChkMeth"></td>
                    <th>점검주기</th>
                    <td><input type="text" id="iChkCycle" name="iChkCycle"></td>
                </tr>
               </table>
               
                <table class="form_table">
                    <colgroup>
                    <col />
                    <col />
                    <col />
                </colgroup>
				<tr>
                    <th colspan="3" >Ⅲ. 정비이력</th>
                </tr>
                <tr>
                    <th>년 월 일</th>
                    <th>정 비 내 용</th>
                    <th>비         고</th>
                </tr>
                <tr>
                     <td><input type="text" id="iMdate1" name="iMdate1"></td>
                     <td><input type="text" id="iMContent1" name="iMContent1"></td>
                     <td><input type="text" id="iMbigo1" name="iMbigo1"></td>
                </tr>
                 <tr>
                     <td><input type="text" id="iMdate2" name="iMdate2"></td>
                     <td><input type="text" id="iMContent2" name="iMContent2"></td>
                     <td><input type="text" id="iMbigo2" name="iMbigo2"></td>
                </tr>
                 <tr>
                     <td><input type="text" id="iMdate3" name="iMdate3"></td>
                     <td><input type="text" id="iMContent3" name="iMContent3"></td>
                     <td><input type="text" id="iMbigo3" name="iMbigo3"></td>
                </tr>
                 <tr>
                     <td><input type="text" id="iMdate4" name="iMdate4"></td>
                     <td><input type="text" id="iMContent4" name="iMContent4"></td>
                     <td><input type="text" id="iMbigo4" name="iMbigo4"></td>
                </tr>
                <tr>
                    <th colspan="3">Ⅳ. 특이사항</th>
                </tr>
                <tr>
                    <th>년 월 일</th>
                    <th>변 동 사 항</th>
                    <th>비         고</th>
                </tr>
                 <tr>
                     <td><input type="text" id="iEdate1" name="iEdate1"></td>
                     <td><input type="text" id="iEcontent1" name="iEcontent1"></td>
                     <td><input type="text" id="iEbigo1" name="iEbigo1"></td>
                </tr>
                <tr>
                     <td><input type="text" id="iEdate2" name="iEdate2"></td>
                     <td><input type="text" id="iEcontent2" name="iEcontent2"></td>
                     <td><input type="text" id="iEbigo2" name="iEbigo2"></td>
                </tr>
              <tr>
                     <td><input type="text" id="iEdate3" name="iEdate3"></td>
                     <td><input type="text" id="iEcontent3" name="iEcontent3"></td>
                     <td><input type="text" id="iEbigo3" name="iEbigo3"></td>
                </tr>
                <tr>
                     <td><input type="text" id="iEdate4" name="iEdate4"></td>
                     <td><input type="text" id="iEcontent1" name="iEcontent4"></td>
                     <td><input type="text" id="iEbigo4" name="iEbigo4"></td>
                </tr>
            </table>
            </form>
			<!-- //form_table -->
		</div>
		<!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page" id="equipInsert" name="equipInsert">등록</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->


<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>전자회로기판 관리 수정</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
		<!-- form_wrap -->
		<div class="form_wrap">
			<!-- form_table -->
			<form id="equipUpdateForm" name="equipUpdateForm">
			<input type="hidden" id="uSeqNo" name ="uSeqNo">
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
	                    <col />
	                    <col width="120px"/>
	                    <col />
                	</colgroup>
                <tbody  id="equipInfoDetail" name="equipInfoDetail">
                
                </tbody>
               </table>
               
                <table class="form_table" >
                    <colgroup>
	                    <col />
	                    <col />
	                    <col />
               	 </colgroup>
                <tbody id="equipInfoEtc" name="equipInfoEtc">
				
                </tbody>
            </table>
            </form>
			<!-- //form_table -->
		</div>
		<!-- //form_wrap -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page" id="equipUpdate" name="equipUpdate">수정</a>
        <a href="#none" class="btn_page" id="equipDelete" name="equipDelete">삭제</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->






</body>
</html>

