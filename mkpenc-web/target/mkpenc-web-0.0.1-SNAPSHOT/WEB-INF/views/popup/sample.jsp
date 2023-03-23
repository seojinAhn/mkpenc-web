<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
	<head>
		<script>
			$(document).ready(function(){
				$("#btn_checked").on("click", function(){
					var checked_ids = "";
					var checked_names = "";
					$(".chk_sample").each(function(){
						if($(this).is(":checked")){
							checked_ids = checked_ids + ($(this).data("id")) + ",";
							checked_names = checked_names +  ($(this).data("name")) + ",";
						} 
					});
					$("${param.base}").closePopup({checked_ids : checked_ids , checked_names : checked_names});
				});
				
				
				$(".close").on("click", function(){
					
					$("${param.base}").closePopup({});
				});
				
				
			});
		</script>
	</head>

	<body>
		<div class="pop_add" style="max-width:250px;">
			<div class="inner" >
				<ul style="height:250px;">
				<c:forEach var="item" items="${list}" varStatus="status">
					<li><input type="checkbox" class="chk_sample" data-id="${ item.id }" data-name="${ item.title }"/> <label>${ item.title }</label></li>
				</c:forEach>
				</ul>
				<div class="btnArea center">
					<button type="button" id="btn_checked" class="btn">선택완료</button>
				</div>
			</div>
		</div>
	</body>
</html>