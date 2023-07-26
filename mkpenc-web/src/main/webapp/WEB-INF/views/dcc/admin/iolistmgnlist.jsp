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
<script type="text/javascript">
var timerOn = false;

$(function () {
		var gIOType = "${BaseSearch.sIOType}";
		var chkIOType;
	
		initViewConfig(gIOType,'main');
		
		/*if (gIOType == null || gIOType == ""){
		
			$("#ioType_0_List").show();
			$("#ioType_0_Input").show();			
		}else {
					switch(gIOType){
				      case "AI" :	
				    	  	$("#ioType_0_List").show();
				    	  	$("#ioType_0_Input").show();
						  break;						 
				      case "AO" :					    	  
				  			$("#ioType_1_List").show();
				  			$("#ioType_1_Input").show();
				    	  break;				                
				      case "CI" :  				    	  
				  			$("#ioType_2_List").show();
				  			$("#ioType_2_Input").show();
				    	  break;				    	
				      case "DI" :  				    	  
				  			$("#ioType_3_List").show();
				  			$("#ioType_3_Input").show();
				    	  break;    				    	
				       case "DO" :				    	   
				  			$("#ioType_4_List").show();
				  			$("#ioType_4_Input").show();
				    	  break
				       case "DT" :     
				  			$("#ioType_5_List").show();
				  			$("#ioType_5_Input").show();;
						  break;	   
					   case "SC":
				  			$("#ioType_6_List").show();
				  			$("#ioType_6_Input").show();
						  break;
					   case "FTAI":
				  			$("#ioType_7_List").show();
				  			$("#ioType_7_Input").show();
				  			$('#history').css("display", "block"); 
						  break;
					   case "FTDT":
				  			$("#ioType_8_List").show();
				  			$("#ioType_8_Input").show();
				  			$('#history').css("display", "block"); 
						  break;								  
					 } // end swith			
		}*/
		
		
		$(document.body).delegate('#ioType_0_List tbody tr', 'click', function() {
			
		
				if($(this).children().eq(32).text() == null || $(this).children().eq(32).text() == "" ||                         // hogi 
						$(this).children().eq(33).text() ==null || $(this).children().eq(33).text() == "" ||                   // iseq
						$(this).children().eq(34).text() ==null || $(this).children().eq(34).text() == "" ||					// iotype
						$(this).children().eq(35).text() == null || $(this).children().eq(35).text()  == ""					// xygubun
					){
						if(chkIOType == null || chkIOType==''){
							//alert("저장할 I/O를 검색하여 주십시요!!!");
							return;
						}
				}			
			
				chkIOType = "AI";
				
				$('#ioType_0_form [name="address"]').val($(this).children().eq(0).text().trim());
				$('#ioType_0_form [name="descr"]').val($(this).children().eq(1).text().trim());
				$('#ioType_0_form [name="message"]').val($(this).children().eq(2).text().trim());
				$('#ioType_0_form [name="rev"]').val($(this).children().eq(3).text().trim());
				$('#ioType_0_form [name="drawing"]').val($(this).children().eq(4).text().trim());
				$('#ioType_0_form [name="loopname"]').val($(this).children().eq(5).text().trim());
				$('#ioType_0_form [name="device"]').val($(this).children().eq(6).text().trim());
				$('#ioType_0_form [name="purpose"]').val($(this).children().eq(7).text().trim());
				$('#ioType_0_form [name="program"]').val($(this).children().eq(8).text().trim());
				$('#ioType_0_form [name="vlow"]').val($(this).children().eq(9).text().trim());
				$('#ioType_0_form [name="vhigh"]').val($(this).children().eq(10).text().trim());
				$('#ioType_0_form [name="elow"]').val($(this).children().eq(11).text().trim());
				$('#ioType_0_form [name="ehigh"]').val($(this).children().eq(12).text().trim());
				$('#ioType_0_form [name="unit"]').val($(this).children().eq(13).text().trim());
				$('#ioType_0_form [name="conv"]').val($(this).children().eq(14).text().trim());
				$('#ioType_0_form [name="rtd"]').val($(this).children().eq(15).text().trim());
				$('#ioType_0_form [name="type"] option:contains("' + $(this).children().eq(16).text().trim() +'")').prop("selected", true);
				$('#ioType_0_form [name="iogroup"] option:contains("' + $(this).children().eq(17).text().trim() +'")').prop("selected", true);
				$('#ioType_0_form [name="window"]').val($(this).children().eq(18).text().trim());
				$('#ioType_0_form [name="priority"] option:contains("' + $(this).children().eq(19).text().trim() +'")').prop("selected", true);
				$('#ioType_0_form [name="cr"] option:contains("' + $(this).children().eq(20).text().trim() +'")').prop("selected", true);
				$('#ioType_0_form [name="limit1"]').val($(this).children().eq(21).text().trim());
				$('#ioType_0_form [name="limit2"]').val($(this).children().eq(22).text().trim());
				$('#ioType_0_form [name="j"]').val($(this).children().eq(23).text().trim());
				$('#ioType_0_form [name="n"] option:contains("' + $(this).children().eq(24).text() .trim()+'")').prop("selected", true);
				$('#ioType_0_form [name="equ"]').val($(this).children().eq(25).text().trim());
				$('#ioType_0_form [name="bascal"]').val($(this).children().eq(26).text().trim());
				$('#ioType_0_form [name="wiba"] option:contains("' + $(this).children().eq(27).text().trim() +'")').prop("selected", true);
				$('#ioType_0_form [name="wb"]').val($(this).children().eq(28).text().trim());
				$('#ioType_0_form [name="ztext1"]').val($(this).children().eq(29).text().trim());
				$('#ioType_0_form [name="ztext2"]').val($(this).children().eq(30).text().trim());
				$('#ioType_0_form [name="ztext3"]').val($(this).children().eq(31).text().trim());
				
				$('#ioType_0_form [name="ihogi"]').val($(this).children().eq(32).text().trim());
         		$('#ioType_0_form [name="iseq"]').val($(this).children().eq(33).text().trim());
         		$('#ioType_0_form [name="iotype"]').val($(this).children().eq(34).text().trim());
         		$('#ioType_0_form [name="xygubun"]').val($(this).children().eq(35).text().trim());

				$('#ioType_0_form [name="reqno"]').val($(this).children().eq(36).text().trim());
				$('#ioType_0_form [name="reqdate"]').val($(this).children().eq(37).text().trim());
				$('#ioType_0_form [name="reqname"]').val($(this).children().eq(38).text().trim());
				$('#ioType_0_form [name="reqdept"]').val($(this).children().eq(39).text().trim());
				$('#ioType_0_form [name="reqbigo"]').val($(this).children().eq(40).text().trim());
				
				/*
				alert($(this).children().eq(32).text());
				alert($(this).children().eq(33).text());
				alert($(this).children().eq(34).text());
				alert($(this).children().eq(35).text());
				*/				
		});
		
		$(document.body).delegate('#ioType_1_List tbody tr', 'click', function() {
			
			chkIOType = "AO";
			
			$('#ioType_1_form [name="address"]').val($(this).children().eq(0).text().trim());
			$('#ioType_1_form [name="rev"]').val($(this).children().eq(1).text().trim());
			$('#ioType_1_form [name="descr"]').val($(this).children().eq(2).text().trim());
			$('#ioType_1_form [name="drawing"]').val($(this).children().eq(3).text().trim());
			$('#ioType_1_form [name="device"]').val($(this).children().eq(4).text().trim());
			$('#ioType_1_form [name="purpose"]').val($(this).children().eq(5).text().trim());
			$('#ioType_1_form [name="ctrlname"]').val($(this).children().eq(6).text().trim());
			$('#ioType_1_form [name="interlock"]').val($(this).children().eq(7).text().trim());
			$('#ioType_1_form [name="feedback"]').val($(this).children().eq(8).text().trim());
			$('#ioType_1_form [name="com1"]').val($(this).children().eq(9).text().trim());
			$('#ioType_1_form [name="com2"]').val($(this).children().eq(10).text().trim());
			$('#ioType_1_form [name="wiba"] option:contains("' + $(this).children().eq(11).text().trim() +'")').prop("selected", true);
			
			$('#ioType_1_form [name="ihogi"]').val($(this).children().eq(12).text().trim());
     		$('#ioType_1_form [name="iseq"]').val($(this).children().eq(13).text().trim());
     		$('#ioType_1_form [name="iotype"]').val($(this).children().eq(14).text().trim());
     		$('#ioType_1_form [name="xygubun"]').val($(this).children().eq(15).text().trim());

			$('#ioType_0_form [name="reqno"]').val($(this).children().eq(16).text().trim());
			$('#ioType_0_form [name="reqdate"]').val($(this).children().eq(17).text().trim());
			$('#ioType_0_form [name="reqname"]').val($(this).children().eq(18).text().trim());
			$('#ioType_0_form [name="reqdept"]').val($(this).children().eq(19).text().trim());
			$('#ioType_0_form [name="reqbigo"]').val($(this).children().eq(20).text().trim());
			
		});
		
		$(document.body).delegate('#ioType_2_List tbody tr', 'click', function() {
			
			chkIOType = "CI";   
			
			$('#ioType_2_form [name="address"]').val($(this).children().eq(0).text().trim());
			$('#ioType_2_form [name="tr"] option:contains("' + $(this).children().eq(1).text().trim() +'")').prop("selected", true);
			$('#ioType_2_form [name="cr"] option:contains("' + $(this).children().eq(2).text().trim() +'")').prop("selected", true);
			$('#ioType_2_form [name="priority"]').val($(this).children().eq(3).text().trim());
			$('#ioType_2_form [name="iogroup"] option:contains("' + $(this).children().eq(4).text().trim() +'")').prop("selected", true);
			$('#ioType_2_form [name="type"] option:contains("' + $(this).children().eq(5).text().trim() +'")').prop("selected", true);
			$('#ioType_2_form [name="message"]').val($(this).children().eq(6).text().trim());
			$('#ioType_2_form [name="drawing"]').val($(this).children().eq(7).text().trim());
			$('#ioType_2_form [name="rev"]').val($(this).children().eq(8).text().trim());
			$('#ioType_2_form [name="device"]').val($(this).children().eq(9).text().trim());
			$('#ioType_2_form [name="condition"]').val($(this).children().eq(10).text().trim());
			$('#ioType_2_form [name="wiba"] option:contains("' + $(this).children().eq(11).text().trim() +'")').prop("selected", true);
			$('#ioType_2_form [name="wb"]').val($(this).children().eq(12).text().trim());
			$('#ioType_2_form [name="ztext1"]').val($(this).children().eq(13).text().trim());
     		$('#ioType_2_form [name="ztext2"]').val($(this).children().eq(14).text().trim());
     		$('#ioType_2_form [name="ztext3"]').val($(this).children().eq(15).text().trim());
			
			$('#ioType_2_form [name="ihogi"]').val($(this).children().eq(16).text().trim());
     		$('#ioType_2_form [name="iseq"]').val($(this).children().eq(17).text().trim());
     		$('#ioType_2_form [name="iotype"]').val($(this).children().eq(18).text().trim());
     		$('#ioType_2_form [name="xygubun"]').val($(this).children().eq(19).text().trim());

			$('#ioType_0_form [name="reqno"]').val($(this).children().eq(20).text().trim());
			$('#ioType_0_form [name="reqdate"]').val($(this).children().eq(21).text().trim());
			$('#ioType_0_form [name="reqname"]').val($(this).children().eq(22).text().trim());
			$('#ioType_0_form [name="reqdept"]').val($(this).children().eq(23).text().trim());
			$('#ioType_0_form [name="reqbigo"]').val($(this).children().eq(24).text().trim());

		});		
		
		$(document.body).delegate('#ioType_3_List tbody tr', 'click', function() {
			
			chkIOType = "DI";    
			
			$('#ioType_3_form [name="address"]').val($(this).children().eq(0).text().trim());
			$('#ioType_3_form [name="bit"]').val($(this).children().eq(1).text().trim());
			$('#ioType_3_form [name="rev"]').val($(this).children().eq(2).text().trim());
			$('#ioType_3_form [name="descr"]').val($(this).children().eq(3).text().trim());
			$('#ioType_3_form [name="drawing"]').val($(this).children().eq(4).text().trim());
			$('#ioType_3_form [name="device"]').val($(this).children().eq(5).text().trim());
			$('#ioType_3_form [name="propose"]').val($(this).children().eq(6).text().trim());
			$('#ioType_3_form [name="ctrlname"]').val($(this).children().eq(7).text().trim());
			$('#ioType_3_form [name="alarmcond"]').val($(this).children().eq(8).text().trim());
			$('#ioType_3_form [name="indicate"]').val($(this).children().eq(9).text().trim());
			$('#ioType_3_form [name="com1"]').val($(this).children().eq(10).text().trim());
			$('#ioType_3_form [name="com2"]').val($(this).children().eq(11).text().trim());
			$('#ioType_3_form [name="wiba"] option:contains("' + $(this).children().eq(12).text().trim() +'")').prop("selected", true);
			
			$('#ioType_3_form [name="ihogi"]').val($(this).children().eq(13).text().trim());
     		$('#ioType_3_form [name="iseq"]').val($(this).children().eq(14).text().trim());
     		$('#ioType_3_form [name="iotype"]').val($(this).children().eq(15).text().trim());
     		$('#ioType_3_form [name="xygubun"]').val($(this).children().eq(16).text().trim());

			$('#ioType_0_form [name="reqno"]').val($(this).children().eq(17).text().trim());
			$('#ioType_0_form [name="reqdate"]').val($(this).children().eq(18).text().trim());
			$('#ioType_0_form [name="reqname"]').val($(this).children().eq(19).text().trim());
			$('#ioType_0_form [name="reqdept"]').val($(this).children().eq(20).text().trim());
			$('#ioType_0_form [name="reqbigo"]').val($(this).children().eq(21).text().trim());
		});	
		
		$(document.body).delegate('#ioType_4_List tbody tr', 'click', function() {
			
			chkIOType = "DO";    
			
			$('#ioType_4_form [name="address"]').val($(this).children().eq(0).text().trim());
			$('#ioType_4_form [name="bit"]').val($(this).children().eq(1).text().trim());
			$('#ioType_4_form [name="rev"]').val($(this).children().eq(2).text().trim());
			$('#ioType_4_form [name="descr"]').val($(this).children().eq(3).text().trim());
			$('#ioType_4_form [name="drawing"]').val($(this).children().eq(4).text().trim());
			$('#ioType_4_form [name="device"]').val($(this).children().eq(5).text().trim());
			$('#ioType_4_form [name="propose"]').val($(this).children().eq(6).text().trim());
			$('#ioType_4_form [name="ctrlname"]').val($(this).children().eq(7).text().trim());
			$('#ioType_4_form [name="interlock"]').val($(this).children().eq(8).text().trim());
			$('#ioType_4_form [name="com1"]').val($(this).children().eq(9).text().trim());
			$('#ioType_4_form [name="com2"]').val($(this).children().eq(10).text().trim());
			$('#ioType_4_form [name="wiba"] option:contains("' + $(this).children().eq(11).text().trim() +'")').prop("selected", true);
			
			$('#ioType_4_form [name="ihogi"]').val($(this).children().eq(12).text().trim());
     		$('#ioType_4_form [name="iseq"]').val($(this).children().eq(13).text().trim());
     		$('#ioType_4_form [name="iotype"]').val($(this).children().eq(14).text().trim());
     		$('#ioType_4_form [name="xygubun"]').val($(this).children().eq(15).text().trim());

			$('#ioType_0_form [name="reqno"]').val($(this).children().eq(16).text().trim());
			$('#ioType_0_form [name="reqdate"]').val($(this).children().eq(17).text().trim());
			$('#ioType_0_form [name="reqname"]').val($(this).children().eq(18).text().trim());
			$('#ioType_0_form [name="reqdept"]').val($(this).children().eq(19).text().trim());
			$('#ioType_0_form [name="reqbigo"]').val($(this).children().eq(20).text().trim());
		});	
		
		$(document.body).delegate('#ioType_5_List tbody tr', 'click', function() {
			
			chkIOType = "DT";    
			
			$('#ioType_5_form [name="address"]').val($(this).children().eq(0).text().trim());
			$('#ioType_5_form [name="program"]').val($(this).children().eq(1).text().trim());
			$('#ioType_5_form [name="descr"]').val($(this).children().eq(2).text().trim());
			$('#ioType_5_form [name="loopname"]').val($(this).children().eq(3).text().trim());
			$('#ioType_5_form [name="bscal"]').val($(this).children().eq(4).text().trim());
			$('#ioType_5_form [name="elow"]').val($(this).children().eq(5).text().trim());
			$('#ioType_5_form [name="ehigh"]').val($(this).children().eq(6).text().trim());
			
			$('#ioType_5_form [name="ihogi"]').val($(this).children().eq(7).text().trim());
     		$('#ioType_5_form [name="iseq"]').val($(this).children().eq(8).text().trim());
     		$('#ioType_5_form [name="iotype"]').val($(this).children().eq(9).text().trim());
     		$('#ioType_5_form [name="xygubun"]').val($(this).children().eq(10).text().trim());

			$('#ioType_0_form [name="reqno"]').val($(this).children().eq(11).text().trim());
			$('#ioType_0_form [name="reqdate"]').val($(this).children().eq(12).text().trim());
			$('#ioType_0_form [name="reqname"]').val($(this).children().eq(13).text().trim());
			$('#ioType_0_form [name="reqdept"]').val($(this).children().eq(14).text().trim());
			$('#ioType_0_form [name="reqbigo"]').val($(this).children().eq(15).text().trim());
		});
		
		$(document.body).delegate('#ioType_6_List tbody tr', 'click', function() {
			
			chkIOType = "SC";       
			
			$('#ioType_6_form [name="address"]').val($(this).children().eq(0).text().trim());
			$('#ioType_6_form [name="bit"]').val($(this).children().eq(1).text().trim());
			$('#ioType_6_form [name="descr"]').val($(this).children().eq(2).text().trim());
			$('#ioType_6_form [name="program"]').val($(this).children().eq(3).text().trim());
			$('#ioType_6_form [name="indicate"]').val($(this).children().eq(4).text().trim());
			$('#ioType_6_form [name="bscal"]').val($(this).children().eq(5).text().trim());
			
			$('#ioType_6_form [name="ihogi"]').val($(this).children().eq(6).text().trim());
     		$('#ioType_6_form [name="iseq"]').val($(this).children().eq(7).text().trim());
     		$('#ioType_6_form [name="iotype"]').val($(this).children().eq(8).text().trim());
     		$('#ioType_6_form [name="xygubun"]').val($(this).children().eq(9).text().trim());
     		
			$('#ioType_0_form [name="reqno"]').val($(this).children().eq(10).text().trim());
			$('#ioType_0_form [name="reqdate"]').val($(this).children().eq(11).text().trim());
			$('#ioType_0_form [name="reqname"]').val($(this).children().eq(12).text().trim());
			$('#ioType_0_form [name="reqdept"]').val($(this).children().eq(13).text().trim());
			$('#ioType_0_form [name="reqbigo"]').val($(this).children().eq(14).text().trim());
		});
		
		$(document.body).delegate('#ioType_7_List tbody tr', 'click', function() {
			
			chkIOType = "FTAI";
	
			$('#ioType_7_form [name="address"]').val($(this).children().eq(0).text().trim());
			$('#ioType_7_form [name="descr"]').val($(this).children().eq(1).text().trim());
			$('#ioType_7_form [name="message"]').val($(this).children().eq(2).text().trim());
			$('#ioType_7_form [name="rev"]').val($(this).children().eq(3).text().trim());
			$('#ioType_7_form [name="drawing"]').val($(this).children().eq(4).text().trim());
			$('#ioType_7_form [name="loopname"]').val($(this).children().eq(5).text().trim());
			$('#ioType_7_form [name="device"]').val($(this).children().eq(6).text().trim());
			$('#ioType_7_form [name="purpose"]').val($(this).children().eq(7).text().trim());
			$('#ioType_7_form [name="program"]').val($(this).children().eq(8).text().trim());
			$('#ioType_7_form [name="vlow"]').val($(this).children().eq(9).text().trim());
			$('#ioType_7_form [name="vhigh"]').val($(this).children().eq(10).text().trim());
			$('#ioType_7_form [name="elow"]').val($(this).children().eq(11).text().trim());
			$('#ioType_7_form [name="ehigh"]').val($(this).children().eq(12).text().trim());
			$('#ioType_7_form [name="unit"]').val($(this).children().eq(13).text().trim());
			$('#ioType_7_form [name="conv"]').val($(this).children().eq(14).text().trim());
			$('#ioType_7_form [name="rtd"]').val($(this).children().eq(15).text().trim());
			$('#ioType_7_form [name="type"] option:contains("' + $(this).children().eq(16).text().trim() +'")').prop("selected", true);
			$('#ioType_7_form [name="iogroup"] option:contains("' + $(this).children().eq(17).text().trim() +'")').prop("selected", true);
			$('#ioType_7_form [name="window"]').val($(this).children().eq(18).text().trim());
			$('#ioType_7_form [name="priority"] option:contains("' + $(this).children().eq(19).text().trim() +'")').prop("selected", true);
			$('#ioType_7_form [name="cr"] option:contains("' + $(this).children().eq(20).text().trim() +'")').prop("selected", true);
			$('#ioType_7_form [name="limit1"]').val($(this).children().eq(21).text().trim());
			$('#ioType_7_form [name="limit2"]').val($(this).children().eq(22).text().trim());
			$('#ioType_7_form [name="j"]').val($(this).children().eq(23).text().trim());
			$('#ioType_7_form [name="n"] option:contains("' + $(this).children().eq(24).text() .trim()+'")').prop("selected", true);
			$('#ioType_7_form [name="equ"]').val($(this).children().eq(25).text().trim());
			$('#ioType_7_form [name="bascal"]').val($(this).children().eq(26).text().trim());
			$('#ioType_7_form [name="wiba"] option:contains("' + $(this).children().eq(27).text().trim() +'")').prop("selected", true);
			$('#ioType_7_form [name="wb"]').val($(this).children().eq(28).text().trim());
			
			$('#ioType_7_form [name="ihogi"]').val($(this).children().eq(29).text().trim());
     		$('#ioType_7_form [name="iseq"]').val($(this).children().eq(30).text().trim());
     		$('#ioType_7_form [name="iotype"]').val($(this).children().eq(31).text().trim());
     		$('#ioType_7_form [name="xygubun"]').val($(this).children().eq(32).text().trim());
     		
			$('#ioType_0_form [name="reqno"]').val($(this).children().eq(33).text().trim());
			$('#ioType_0_form [name="reqdate"]').val($(this).children().eq(34).text().trim());
			$('#ioType_0_form [name="reqname"]').val($(this).children().eq(35).text().trim());
			$('#ioType_0_form [name="reqdept"]').val($(this).children().eq(36).text().trim());
			$('#ioType_0_form [name="reqbigo"]').val($(this).children().eq(37).text().trim());
		});			
		
		$(document.body).delegate('#ioType_8_List tbody tr', 'click', function() {
			
			chkIOType = "FTDT";  
			
			$('#ioType_8_form [name="address"]').val($(this).children().eq(0).text().trim());
			$('#ioType_8_form [name="program"]').val($(this).children().eq(1).text().trim());
			$('#ioType_8_form [name="descr"]').val($(this).children().eq(2).text().trim());
			$('#ioType_8_form [name="loopname"]').val($(this).children().eq(3).text().trim());
			$('#ioType_8_form [name="bscal"]').val($(this).children().eq(4).text().trim());
			$('#ioType_8_form [name="elow"]').val($(this).children().eq(5).text().trim());
			$('#ioType_8_form [name="ehigh"]').val($(this).children().eq(6).text().trim());
			
			$('#ioType_8_form [name="ihogi"]').val($(this).children().eq(7).text().trim());
     		$('#ioType_8_form [name="iseq"]').val($(this).children().eq(8).text().trim());
     		$('#ioType_8_form [name="iotype"]').val($(this).children().eq(9).text().trim());
     		$('#ioType_8_form [name="xygubun"]').val($(this).children().eq(10).text().trim());
     		
			$('#ioType_0_form [name="reqno"]').val($(this).children().eq(11).text().trim());
			$('#ioType_0_form [name="reqdate"]').val($(this).children().eq(12).text().trim());
			$('#ioType_0_form [name="reqname"]').val($(this).children().eq(13).text().trim());
			$('#ioType_0_form [name="reqdept"]').val($(this).children().eq(14).text().trim());
			$('#ioType_0_form [name="reqbigo"]').val($(this).children().eq(15).text().trim());
		});			
		
		$("input[name='sXYGubun']:radio").change(function () {
		
			var chkVal = this.value;
			var sXYGubun = "${BaseSearch.sXYGubun}";
			
			if(chkVal =="X"){
				if(sXYGubun == "7"){
					$("#sIOType").append('<option value="FTAI" selected>Fast AI</option>');
				}else {
					$("#sIOType").append('<option value="FTAI">Fast AI</option>');	
				}
				
				if(sXYGubun == "8"){
					$("#sIOType").append('<option value="FTDT" selected>Fast DT</option>');
				}else {
					$("#sIOType").append('<option value="FTDT">Fast DT</option>');	
				}
				
			}else if(chkVal == "Y"){
				$("#sIOType option[value='FTAI']").remove();
				$("#sIOType option[value='FTDT']").remove();
			}
		});		
		
		$(document.body).delegate("#sIOType","change",function(){
		
			var sIOType = this.value;
			
			if(sIOType != "FTAI" && sIOType != "FTDT"){
				$('#history').css("display", "none"); 
			}else {
				$('#history').css("display", "block"); 
			}

			 $("select[name=searchKeys]").each(function(index, item){
			      //alert($(item).val());
			      //alert(index);
			      //alert(item);
			      
			      $(item).empty();
			      
			      switch(sIOType){
				      case "AI" :	
				      case "FTAI" :
				    	  $(item).append('<option value="0">DESCR</option>');
				    	  $(item).append('<option value="1">MESSAGE</option>');
				    	  $(item).append('<option value="2">REV</option>');
				    	  $(item).append('<option value="3">DRAWING</option>');
				    	  $(item).append('<option value="4">LOOPNAME</option>');
				    	  $(item).append('<option value="5">DEVICE</option>');
				    	  $(item).append('<option value="6">PURPOSE</option>');
				    	  $(item).append('<option value="7">PROGRAM</option>');
				    	  $(item).append('<option value="8">VLOW</option>');
				    	  $(item).append('<option value="9">VHIGH</option>');
				    	  $(item).append('<option value="10">ELOW</option>');
				    	  $(item).append('<option value="11">EHIGH</option>');
				    	  $(item).append('<option value="12">UNIT</option>');
				    	  $(item).append('<option value="13">CONV</option>');
				    	  $(item).append('<option value="14">RTD</option>');
				    	  $(item).append('<option value="15">TYPE</option>');
				    	  $(item).append('<option value="16">GROUP</option>');
				    	  $(item).append('<option value="17">WINDOW</option>');
				    	  $(item).append('<option value="18">PRIORITY</option>');
				    	  $(item).append('<option value="19">CR</option>');
				    	  $(item).append('<option value="20">LIMIT1</option>');
				    	  $(item).append('<option value="21">LIMIT2</option>');
				    	  $(item).append('<option value="22">J</option>');
				    	  $(item).append('<option value="23">N</option>');
				    	  $(item).append('<option value="24">EQU#</option>');
				    	  $(item).append('<option value="25">BSCAL</option>');
				    	  $(item).append('<option value="26">WIBA</option>');
				    	  $(item).append('<option value="27">WB#</option>');
						  break;						 
				      case "AO" :					    	  
				    	  $(item).append('<option value="0">REV</option>');
				    	  $(item).append('<option value="1">DESCR</option>');
				    	  $(item).append('<option value="2">DRAWING</option>');
				    	  $(item).append('<option value="3">DEVICE</option>');
				    	  $(item).append('<option value="4">PURPOSE</option>');
				    	  $(item).append('<option value="5">CTRLNAME</option>');
				    	  $(item).append('<option value="6">INTERLOCK</option>');
				    	  $(item).append('<option value="7">FEEDBACK</option>');
				    	  $(item).append('<option value="8">COM1</option>');
				    	  $(item).append('<option value="9">COM2</option>');
				    	  $(item).append('<option value="10">WIBA</option>');
				    	  break;				                
				      case "CI" :  				    	  
				    	  $(item).append('<option value="0">CR</option>');
				    	  $(item).append('<option value="1">MESSAGE</option>');
				    	  $(item).append('<option value="2">DRAWING</option>');
				    	  $(item).append('<option value="3">REV</option>');
				    	  $(item).append('<option value="4">DEVICE</option>');
				    	  $(item).append('<option value="5">CONDITION</option>');
				    	  $(item).append('<option value="6">WIBA</option>');
				    	  $(item).append('<option value="7">GROUP</option>');
				    	  $(item).append('<option value="8">TR</option>');
				    	  $(item).append('<option value="9">PRIORITY</option>');
				    	  $(item).append('<option value="10">TYPE</option>');
				    	  break;				    	
				      case "DI" :  				    	  
				    	  $(item).append('<option value="0">BIT</option>');
				    	  $(item).append('<option value="1">REV</option>');
				    	  $(item).append('<option value="2">DESCR</option>');
				    	  $(item).append('<option value="3">DRAWING</option>');
				    	  $(item).append('<option value="4">DEVICE</option>');
				    	  $(item).append('<option value="5">PURPOSE</option>');
				    	  $(item).append('<option value="6">CTRLNAME</option>');
				    	  $(item).append('<option value="7">ALARMCOND</option>');
				    	  $(item).append('<option value="8">INDICATE</option>');
				    	  $(item).append('<option value="9">WIBA</option>');
				    	  break;    				    	
				       case "DO" :				    	   
				    	  $(item).append('<option value="0">BIT</option>');
				    	  $(item).append('<option value="1">REV</option>');
				    	  $(item).append('<option value="2">DESCR</option>');
				    	  $(item).append('<option value="3">DRAWING</option>');
				    	  $(item).append('<option value="4">DEVICE</option>');
				    	  $(item).append('<option value="5">PURPOSE</option>');
				    	  $(item).append('<option value="6">CTRLNAME</option>');
				    	  $(item).append('<option value="7">INTERLOCK</option>');
				    	  $(item).append('<option value="8">WIBA</option>');
				    	  break
				       case "DT" :     
				       case "FTDT" :
				    	  $(item).append('<option value="0">PROGRAM</option>');
					      $(item).append('<option value="1">DESCR</option>');
					      $(item).append('<option value="2">LOOPNAME</option>');
					      $(item).append('<option value="3">BSCAL</option>');
					      $(item).append('<option value="4">ELOW</option>');
					      $(item).append('<option value="5">EHIGH</option>');
						  break;	   
					   case "SC":
						  $(item).append('<option value="0">BIT</option>');
						  $(item).append('<option value="1">PROGRAM</option>');
						  $(item).append('<option value="2">DESCR</option>');
						  $(item).append('<option value="3">INDICATE</option>');
						  break;
				 } // end swith
			   }); // end searchKey Control
			   
			  	initViewConfig(sIOType,'change');

			 	/*switch(sIOType){
				      case "AI" :	
				    	  	$("#ioType_0_List").show();
				    	  	$("#ioType_0_Input").show();
						  break;						 
				      case "AO" :					    	  
				  			$("#ioType_1_List").show();
				  			$("#ioType_1_Input").show();
				    	  break;				                
				      case "CI" :  				    	  
				  			$("#ioType_2_List").show();
				  			$("#ioType_2_Input").show();
				    	  break;				    	
				      case "DI" :  				    	  
				  			$("#ioType_3_List").show();
				  			$("#ioType_3_Input").show();
				    	  break;    				    	
				       case "DO" :				    	   
				  			$("#ioType_4_List").show();
				  			$("#ioType_4_Input").show();
				    	  break
				       case "DT" :     
				  			$("#ioType_5_List").show();
				  			$("#ioType_5_Input").show();;
						  break;	   
					   case "SC":
				  			$("#ioType_6_List").show();
				  			$("#ioType_6_Input").show();
						  break;
					   case "FTAI":
				  			$("#ioType_7_List").show();
				  			$("#ioType_7_Input").show();
						  break;
				       case "FTDT" :
				  			$("#ioType_8_List").show();
				  			$("#ioType_8_Input").show();;
						  break;	  
				 } // end swith*/
			   
		});	// end ioType 	change event
		
		$(document.body).delegate("#iolistInfoUpdate","click",function(){
			
			if(chkIOType == null || chkIOType==''){
				alert("목록에서 저장할 I/O를 선택하여 주십시요!!!");
				return;
			}
			
			if (confirm("I/O LIST을 저장 합니다..!!")) {	
			
					 switch(chkIOType){
						     case "AI" :
									var comAjax = new ComAjax("ioType_0_form");
									comAjax.setUrl("/dcc/admin/iolistupdate");
									comAjax.setCallback("mbr_IOListUpdateEventCallback");
									comAjax.ajax();
						  		break;
						     case "AO" :
									var comAjax = new ComAjax("ioType_1_form");
									comAjax.setUrl("/dcc/admin/iolistupdate");
									comAjax.setCallback("mbr_IOListUpdateEventCallback");
									comAjax.ajax();
						  		break;   
						     case "CI" :
									var comAjax = new ComAjax("ioType_2_form");
									comAjax.setUrl("/dcc/admin/iolistupdate");
									comAjax.setCallback("mbr_IOListUpdateEventCallback");
									comAjax.ajax();
						  		break;
						     case "DI" :
									var comAjax = new ComAjax("ioType_3_form");
									comAjax.setUrl("/dcc/admin/iolistupdate");
									comAjax.setCallback("mbr_IOListUpdateEventCallback");
									comAjax.ajax();
						  		break;           
						     case "DO" :
									var comAjax = new ComAjax("ioType_4_form");
									comAjax.setUrl("/dcc/admin/iolistupdate");
									comAjax.setCallback("mbr_IOListUpdateEventCallback");
									comAjax.ajax();
						  		break;
						     case "DT" :
									var comAjax = new ComAjax("ioType_5_form");
									comAjax.setUrl("/dcc/admin/iolistupdate");
									comAjax.setCallback("mbr_IOListUpdateEventCallback");
									comAjax.ajax();
						  		break;
						     case "SC" :
									var comAjax = new ComAjax("ioType_6_form");
									comAjax.setUrl("/dcc/admin/iolistupdate");
									comAjax.setCallback("mbr_IOListUpdateEventCallback");
									comAjax.ajax();
						  		break;
						     case "FTAI" :
									var comAjax = new ComAjax("ioType_7_form");
									comAjax.setUrl("/dcc/admin/iolistupdate");
									comAjax.setCallback("mbr_IOListUpdateEventCallback");
									comAjax.ajax();
						  		break;
						     case "FTDT" :
									var comAjax = new ComAjax("ioType_8_form");
									comAjax.setUrl("/dcc/admin/iolistupdate");
									comAjax.setCallback("mbr_IOListUpdateEventCallback");
									comAjax.ajax();
						  		break;				
					 	}
			}else {
				alert("I/O LIST 저장을 취소 합니다...!!");
			}	
		});		
		
		
		$(document.body).delegate("#ioListSearch","click",function(){
			sendPage(1);
		});		
		
		$(document.body).delegate("#excelExport","click",function(){
			toCSV();
		});		
	
	
});	

	function toCSV() {
		var dataLen =  '${IOListInfoList}'.length;
		
		if( dataLen == 0 || typeof dataLen == 'undefined' ) {
			alert('엑셀파일로 저장할 I/O 데이타를 검색하여 주십시오!');
		} else {
			var selHogi = typeof $("#sIHogi option:selected").val() == 'undefined' ? '3' : $("#sIHogi option:selected").val();
			var selXY = typeof $("#sXYGubun option:selected").val() == 'undefined' ? 'X' : $("#sXYGubun option:selected").val();
			var selType = typeof $("#sIOType option:selected").val() == 'undefined' ? 'AI' : $("#sIOType option:selected").val();

			if ( confirm(selHogi+selXY+' '+selType+'의 I/O데이타를 엑셀파일로 저장하시겠습니까?') ) {	
				
				var	comSubmit	=	new ComSubmit("ioListForm");
				comSubmit.setUrl("/dcc/admin/iolistExcelExport");
				comSubmit.submit();
				
			//}else {
				//alert("검색 조건의  파일의 다운로드를 취소 합니다..!!");
			}
		}
	}
   
    function initViewConfig(type,trigger){
    	
    	if( type == 'AI' || type == '' || type == null ) {
    		if( trigger == 'change' ) {
	    		var clearBodyStr = '';
	    		
	    		for( var i=0;i<10;i++ ) {
	    			clearBodyStr += '<tr>';
	    			for( var j=0;j<32;j++ ) {
	    				clearBodyStr += ' <td class="tc"></td>';
	    			}
	    			clearBodyStr += '</tr>';
	    		}
	    		
	    		$("#ioType_0_List_body").empty();
	    		$("#ioType_0_List_body").append(clearBodyStr);
	    	}
    		
    		$("#ioType_0_List").show();
    		$("#ioType_0_Input").show();
    	} else {
    		$("#ioType_0_List").hide();
    		$("#ioType_0_Input").hide();
    	}
    	if( type == 'AO' ) {
    		if( trigger == 'change' ) {
	    		var clearBodyStr = '';
	    		
	    		for( var i=0;i<10;i++ ) {
	    			clearBodyStr += '<tr>';
	    			for( var j=0;j<12;j++ ) {
	    				clearBodyStr += ' <td class="tc"></td>';
	    			}
	    			clearBodyStr += '</tr>';
	    		}
	    		
	    		$("#ioType_1_List_body").empty();
	    		$("#ioType_1_List_body").append(clearBodyStr);
	    	}
    		
			$("#ioType_1_List").show();
			$("#ioType_1_Input").show();
    	} else {
    		$("#ioType_1_List").hide();
    		$("#ioType_1_Input").hide();
    	}
    	if( type == 'CI' ) {
    		if( trigger == 'change' ) {
	    		var clearBodyStr = '';
	    		
	    		for( var i=0;i<10;i++ ) {
	    			clearBodyStr += '<tr>';
	    			for( var j=0;j<16;j++ ) {
	    				clearBodyStr += ' <td class="tc"></td>';
	    			}
	    			clearBodyStr += '</tr>';
	    		}
	    		
	    		$("#ioType_2_List_body").empty();
	    		$("#ioType_2_List_body").append(clearBodyStr);
	    	}
    		
			$("#ioType_2_List").show();
			$("#ioType_2_Input").show();
    	} else {
    		$("#ioType_2_List").hide();
    		$("#ioType_2_Input").hide();
    	}
    	if( type == 'DI' ) {
    		if( trigger == 'change' ) {
	    		var clearBodyStr = '';
	    		
	    		for( var i=0;i<10;i++ ) {
	    			clearBodyStr += '<tr>';
	    			for( var j=0;j<13;j++ ) {
	    				clearBodyStr += ' <td class="tc"></td>';
	    			}
	    			clearBodyStr += '</tr>';
	    		}
	    		
	    		$("#ioType_3_List_body").empty();
	    		$("#ioType_3_List_body").append(clearBodyStr);
	    	}
    		
			$("#ioType_3_List").show();
			$("#ioType_3_Input").show();
    	} else {
    		$("#ioType_3_List").hide();
    		$("#ioType_3_Input").hide();
    	}
    	if( type == 'DO' ) {
    		if( trigger == 'change' ) {
	    		var clearBodyStr = '';
	    		
	    		for( var i=0;i<10;i++ ) {
	    			clearBodyStr += '<tr>';
	    			for( var j=0;j<12;j++ ) {
	    				clearBodyStr += ' <td class="tc"></td>';
	    			}
	    			clearBodyStr += '</tr>';
	    		}
	    		
	    		$("#ioType_4_List_body").empty();
	    		$("#ioType_4_List_body").append(clearBodyStr);
	    	}
    		
			$("#ioType_4_List").show();
			$("#ioType_4_Input").show();
    	} else {
    		$("#ioType_4_List").hide();
    		$("#ioType_4_Input").hide();
    	}
    	if( type == 'DT' ) {
    		if( trigger == 'change' ) {
	    		var clearBodyStr = '';
	    		
	    		for( var i=0;i<10;i++ ) {
	    			clearBodyStr += '<tr>';
	    			for( var j=0;j<7;j++ ) {
	    				clearBodyStr += ' <td class="tc"></td>';
	    			}
	    			clearBodyStr += '</tr>';
	    		}
	    		
	    		$("#ioType_5_List_body").empty();
	    		$("#ioType_5_List_body").append(clearBodyStr);
	    	}
    		
			$("#ioType_5_List").show();
			$("#ioType_5_Input").show();
    	} else {
    		$("#ioType_5_List").hide();
    		$("#ioType_5_Input").hide();
    	}
    	if( type == 'SC' ) {
    		if( trigger == 'change' ) {
	    		var clearBodyStr = '';
	    		
	    		for( var i=0;i<10;i++ ) {
	    			clearBodyStr += '<tr>';
	    			for( var j=0;j<6;j++ ) {
	    				clearBodyStr += ' <td class="tc"></td>';
	    			}
	    			clearBodyStr += '</tr>';
	    		}
	    		
	    		$("#ioType_6_List_body").empty();
	    		$("#ioType_6_List_body").append(clearBodyStr);
	    	}
    		
			$("#ioType_6_List").show();
			$("#ioType_6_Input").show();
    	} else {
    		$("#ioType_6_List").hide();
    		$("#ioType_6_Input").hide();
    	}
    	if( type == 'FTAI' ) {
    		if( trigger == 'change' ) {
	    		var clearBodyStr = '';
	    		
	    		for( var i=0;i<10;i++ ) {
	    			clearBodyStr += '<tr>';
	    			for( var j=0;j<29;j++ ) {
	    				clearBodyStr += ' <td class="tc"></td>';
	    			}
	    			clearBodyStr += '</tr>';
	    		}
	    		
	    		$("#ioType_7_List_body").empty();
	    		$("#ioType_7_List_body").append(clearBodyStr);
	    	}
    		
			$("#ioType_7_List").show();
			$("#ioType_7_Input").show();
  			$('#history').css("display", "block"); 
    	} else {
    		$("#ioType_7_List").hide();
    		$("#ioType_7_Input").hide();
    		if( type != 'FTDT' ) $('#history').css("display", "none"); 
    	}
    	if( type == 'FTDT' ) {
    		if( trigger == 'change' ) {
	    		var clearBodyStr = '';
	    		
	    		for( var i=0;i<10;i++ ) {
	    			clearBodyStr += '<tr>';
	    			for( var j=0;j<7;j++ ) {
	    				clearBodyStr += ' <td class="tc"></td>';
	    			}
	    			clearBodyStr += '</tr>';
	    		}
	    		
	    		$("#ioType_8_List_body").empty();
	    		$("#ioType_8_List_body").append(clearBodyStr);
	    	}
    		
			$("#ioType_8_List").show();
			$("#ioType_8_Input").show();
  			$('#history').css("display", "block"); 
    	} else {
    		$("#ioType_8_List").hide();
    		$("#ioType_8_Input").hide();
    		if( type != 'FTAI' ) $('#history').css("display", "none"); 
    	}  	
		
		//$('#history').css("display", "none"); 
    }

	function sendPage(pageNum){
	
		if(!$("input[name='sXYGubun']:radio").is(':checked')){
			alert("X, Y 구분을 선택하세요..!!") ;
			return;
		}

		var sk1 = $("#searchKeys1").val();
		var sk2 = $("#searchKeys2").val();
		var sk3 = $("#searchKeys3").val();
		var sw1 = $("#searchWords1").val();
		var sw2 = $("#searchWords2").val();
		var sw3 = $("#searchWords3").val();
		var searchKeyArray = ['','',''];
		var searchWordsArray = ['','',''];
		
		if( sw1 != '' && typeof sw1 != 'undefined' ) {
			searchKeyArray.splice(0,1,sk1);
			searchWordsArray.splice(0,1,sw1);
		}
		if( sw2 != '' && typeof sw2 != 'undefined' ) {
			searchKeyArray.splice(1,1,sk2);
			searchWordsArray.splice(1,1,sw2);
		}
		if( sw3 != '' && typeof sw3 != 'undefined' ) {
			searchKeyArray.splice(2,1,sk3);
			searchWordsArray.splice(2,1,sw3);
		}
		
		var	comSubmit	=	new ComSubmit("ioListForm");
		comSubmit.addParam("pageNum", pageNum);
		comSubmit.addParam("searchKeys",searchKeyArray);
		comSubmit.addParam("searchWords",searchWordsArray);
		comSubmit.setUrl("/dcc/admin/iolistmgnlist");
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
				<h3>I/O LIST</h3>
				<div class="bc"><span>DCC</span><span>Admin</span><strong>I/O LIST</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
				<form id="ioListForm" name="ioListForm">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>호기선택</label>
                            <div class="fx_form_multi">
                                <select style="width:90px" id="sIhogi" name="sIhogi">
                                	<c:if test="${BaseSearch.sIhogi eq '3'}">
                                		<option value="3" selected>3호기</option>
                                	</c:if>
                                	<c:if test="${BaseSearch.sIhogi ne '3'}">
                                		<option value="3" >3호기</option>
                                	</c:if>
                                	<c:if test="${BaseSearch.sIhogi eq '4'}">
                                		<option value="4" selected>4호기</option>
                                	</c:if>
                                	<c:if test="${BaseSearch.sIhogi ne '4'}">
                                		<option value="4" >4호기</option>
                                	</c:if>
                                </select>
                                <div class="fx_form">
                                	<c:if test="${BaseSearch.sXYGubun eq null}">
                                	<label><input type="radio" id="sXYGubun" name="sXYGubun" value="X"  checked>X</label>
                                	</c:if>
                                	<c:if test="${BaseSearch.sXYGubun eq 'X'}">
                                    <label><input type="radio" id="sXYGubun" name="sXYGubun" value="X"  checked>X</label>
                                    </c:if>
                                    <c:if test="${BaseSearch.sXYGubun ne null && BaseSearch.sXYGubun ne 'X'}">
                                    <label><input type="radio" id="sXYGubun" name="sXYGubun" value="X"  >X</label>
                                    </c:if>
                                    <c:if test="${BaseSearch.sXYGubun eq 'Y'}">
                                    <label><input type="radio" id="sXYGubun" name="sXYGubun" value="Y"  checked>Y</label>
                                    </c:if>
                                    <c:if test="${BaseSearch.sXYGubun ne 'Y'}">
                                    <label><input type="radio" id="sXYGubun" name="sXYGubun" value="Y"  >Y</label>
                                    </c:if>
                                </div>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>Acess Field</label>
							<select id="sIOType" name="sIOType">
								<c:if test="${BaseSearch.sIOType eq 'AI'}">
									<option value="AI" selected>Analog Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType ne 'AI'}">
									<option value="AI" >Analog Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType eq 'AO'}">
									<option value="AO" selected>Analog Outputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType ne 'AO'}">
									<option value="AO">Analog Outputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType eq 'CI'}">
									<option value="CI" selected>Contact Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType ne 'CI'}">
									<option value="CI">Contact Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType eq 'DI'}">
									<option value="DI" selected>Digital Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType ne 'DI'}">
									<option value="DI">Digital Inputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType eq 'DO'}">
									<option value="DO" selected>Digital Outputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType ne 'DO'}">
									<option value="DO">Digital Outputs</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType eq 'DT'}">
									<option value="DT" selected>DTAB</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType ne 'DT'}">
									<option value="DT">DTAB</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType eq 'SC'}">
									<option value="SC" selected>SaveCore</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType ne 'SC'}">
									<option value="SC">SaveCore</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType eq 'FTAI'}">
									<option value="FTAI" selected>Fast AI</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType ne 'FTAI'}">
									<option value="FTAI">Fast AI</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType eq 'FTDT'}">
									<option value="FTDT" selected>Fast DT</option>
								</c:if>
								<c:if test="${BaseSearch.sIOType ne 'FTDT'}">
									<option value="FTDT">Fast DT</option>
								</c:if>								
							</select>
						</div>
						<div class="fx_srch_item">
							<label>Address</label>
                            <div class="fx_form">
                                <input type="text" id="sAddress" name="sAddress" value="${BaseSearch.sAddress}">
                                <c:if test="${BaseSearch.addrRange ne null and BaseSearch.addrRange ne ''}">
                                <label>${BaseSearch.addrRange}</label>
                                </c:if>
                                <c:if test="${BaseSearch.addrRange eq null or BaseSearch.addrRange eq ''}">
                                <label>0 - 0</label>
                                </c:if>
                            </div>
						</div>
					</div>
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label class="label_select">
                                <select id="searchKeys1" name="searchKeys1">
                                  <option value="0">DESCR</option>
						    	  <option value="1">MESSAGE</option>
						    	  <option value="2">REV</option>
						    	  <option value="3">DRAWING</option>
						    	  <option value="4">LOOPNAME</option>
						    	  <option value="5">DEVICE</option>
						    	  <option value="6">PURPOSE</option>
						    	  <option value="7">PROGRAM</option>
						    	  <option value="8">VLOW</option>
						    	  <option value="9">VHIGH</option>
						    	  <option value="10">ELOW</option>
						    	  <option value="11">EHIGH</option>
						    	  <option value="12">UNIT</option>
						    	  <option value="13">CONV</option>
						    	  <option value="14">RTD</option>
						    	  <option value="15">TYPE</option>
						    	  <option value="16">GROUP</option>
						    	  <option value="17">WINDOW</option>
						    	  <option value="18">PRIORITY</option>
						    	  <option value="19">CR</option>
						    	  <option value="20">LIMIT1</option>
						    	  <option value="21">LIMIT2</option>
						    	  <option value="22">J</option>
						    	  <option value="23">N</option>
						    	  <option value="24">EQU#</option>
						    	  <option value="25">BSCAL</option>
						    	  <option value="26">WIBA</option>
						    	  <option value="27">WB#</option>
                                </select>
                            </label>
                            <input type="text"  id="searchWords1"  name="searchWords1" value="${BaseSearch.searchWords[0]}">
						</div>
						<div class="fx_srch_item">
							<label class="label_select">
                                <select id="searchKeys2" name="searchKeys2">
                                     <option value="0">DESCR</option>
						    	  <option value="1">MESSAGE</option>
						    	  <option value="2">REV</option>
						    	  <option value="3">DRAWING</option>
						    	  <option value="4">LOOPNAME</option>
						    	  <option value="5">DEVICE</option>
						    	  <option value="6">PURPOSE</option>
						    	  <option value="7">PROGRAM</option>
						    	  <option value="8">VLOW</option>
						    	  <option value="9">VHIGH</option>
						    	  <option value="10">ELOW</option>
						    	  <option value="11">EHIGH</option>
						    	  <option value="12">UNIT</option>
						    	  <option value="13">CONV</option>
						    	  <option value="14">RTD</option>
						    	  <option value="15">TYPE</option>
						    	  <option value="16">GROUP</option>
						    	  <option value="17">WINDOW</option>
						    	  <option value="18">PRIORITY</option>
						    	  <option value="19">CR</option>
						    	  <option value="20">LIMIT1</option>
						    	  <option value="21">LIMIT2</option>
						    	  <option value="22">J</option>
						    	  <option value="23">N</option>
						    	  <option value="24">EQU#</option>
						    	  <option value="25">BSCAL</option>
						    	  <option value="26">WIBA</option>
						    	  <option value="27">WB#</option>
                                </select>
                            </label>
                            <input type="text"  id="searchWords2" name="searchWords2" value="${BaseSearch.searchWords[1]}">
						</div>
						<div class="fx_srch_item">
							<label class="label_select">
                                <select id="searchKeys3" name="searchKeys3">
                                    <option value="0">DESCR</option>
						    	  <option value="1">MESSAGE</option>
						    	  <option value="2">REV</option>
						    	  <option value="3">DRAWING</option>
						    	  <option value="4">LOOPNAME</option>
						    	  <option value="5">DEVICE</option>
						    	  <option value="6">PURPOSE</option>
						    	  <option value="7">PROGRAM</option>
						    	  <option value="8">VLOW</option>
						    	  <option value="9">VHIGH</option>
						    	  <option value="10">ELOW</option>
						    	  <option value="11">EHIGH</option>
						    	  <option value="12">UNIT</option>
						    	  <option value="13">CONV</option>
						    	  <option value="14">RTD</option>
						    	  <option value="15">TYPE</option>
						    	  <option value="16">GROUP</option>
						    	  <option value="17">WINDOW</option>
						    	  <option value="18">PRIORITY</option>
						    	  <option value="19">CR</option>
						    	  <option value="20">LIMIT1</option>
						    	  <option value="21">LIMIT2</option>
						    	  <option value="22">J</option>
						    	  <option value="23">N</option>
						    	  <option value="24">EQU#</option>
						    	  <option value="25">BSCAL</option>
						    	  <option value="26">WIBA</option>
						    	  <option value="27">WB#</option>
                                </select>
                            </label>
                            <input type="text"  id="searchWords3" name="searchWords3" value="${BaseSearch.searchWords[2]}">
						</div>
					</div>
				</form>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a class="btn_srch" id="ioListSearch" name="ioListSearch">Search</a>
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
                     	<a class="btn_list " href="#none" id="history" name="history" style="display:none;">이력조회 및 변경</a>
                        <a class="btn_list " href="#none" id="iolistInfoUpdate" name="iolistInfoUpdate">저장</a>
                        <a class="btn_list excel_up" href="#none">엑셀일괄등록</a>
                        <a class="btn_list excel_down" href="#none" id="excelExport" name="excelExport">엑셀다운로드</a>
                    </div>
                    <!-- button -->                      
				</div>
                <!-- //list_head -->
                <!-- list_table_scroll -->
                <div class="list_table_scroll" style="min-height:331px">
	                <!-- list_table -->
	                <table class="list_table"  id="ioType_0_List"  name="ioType_0_List">
	                    <colgroup>
	                        <col width="70px"/>
	                        <col width="400px"/>
	                        <col width="280px"/>
	                        <col width="60px"/>
	                        <col width="150px"/>
	                        <col width="120px"/>
	                        <col width="150px"/>	                        
	                        <col width="100x"/>
	                        <col width="100px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                        <col width="120px"/>	                        
	                        <col width="90px"/>	                        
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="130px"/>
	                        <col width="80px"/>
	                        <col width="80px"/>	     
	                        <col width="80px"/>
	                        <col width="80px"/>
	                        <col width="200px"/>	     
	                        <col width="200px"/>
	                        <col width="200px"/>	  	                      
	                    </colgroup>
	                    <thead>
	                        <tr>
	                              <th>ADDR</th>
	                              <th>DESCR</th>
	                              <th>MESSAGE</th>
	                              <th>REV</th>
	                              <th>DRAWING</th>
	                              <th>LOOPNAME</th>
	                              <th>DEVICE</th>
	                              <th>PURPOSE</th>
						    	  <th>PROGRAM</th>
						    	  <th>VLOW</th>
						    	  <th>VHIGH</th>
						    	  <th>ELOW</th>
						    	  <th>EHIGH</th>
						    	  <th>UNIT</th>
						    	  <th>CONV</th>
						    	  <th>RTD</th>
						    	  <th>TYPE</th>
						    	  <th>GROUP</th>
						    	  <th>WINDOW</th>
						    	  <th>PRIORITY</th>
						    	  <th>CR</th>
						    	  <th>LIMIT1</th>
						    	  <th>LIMIT2</th>
						    	  <th>J</th>
						    	  <th>N</th>
						    	  <th>EQU#</th>
						    	  <th>BSCAL</th>
						    	  <th>WIBA</th>
						    	  <th>WB#</th>											    	  
						    	  <th>원인</th>
						    	  <th>조치</th>
						    	  <th>관련절차서</th>
	                        </tr>
	                    </thead>
	                    <tbody id="ioType_0_List_body">
	                    <c:if test="${BaseSearch.sIOType eq 'AI' }">
	                    <c:forEach var="IOListInfo" items="${IOListInfoList}">
	                        <tr>
	                             <tr>
	                            <td class="tc">${IOListInfo.address}</td>
	                            <td class="tc">${IOListInfo.descr}</td>
	                            <td class="tc">${IOListInfo.message}</td>
	                            <td class="tc">${IOListInfo.rev}</td>
	                            <td class="tc">${IOListInfo.drawing}</td>
	                            <td class="tc">${IOListInfo.loopname}</td>
	                            <td class="tc">${IOListInfo.device}</td>
	                            <td class="tc">${IOListInfo.purpose}</td>
	                            <td class="tc">${IOListInfo.program}</td>
	                            <td class="tc">${IOListInfo.vlow}</td>
	                            <td class="tc">${IOListInfo.vhigh}</td>
	                            <td class="tc">${IOListInfo.elow}</td>
	                            <td class="tc">${IOListInfo.ehigh}</td>	                            
	                            <td class="tc">${IOListInfo.unit}</td>
	                            <td class="tc">${IOListInfo.conv}</td>
	                            <td class="tc">${IOListInfo.rtd}</td>
	                            <td class="tc">
			                            <c:if test="${IOListInfo.type == 0}">None </c:if>
			                            <c:if test="${IOListInfo.type == 1}">High</c:if>
			                            <c:if test="${IOListInfo.type == 2}">	Low</c:if>
										<c:if test="${IOListInfo.type == 3}">	High/Low</c:if>
										<c:if test="${IOListInfo.type == 4}">	High DTAB</c:if>
										<c:if test="${IOListInfo.type == 5}">	Low DATB</c:if>
										<c:if test="${IOListInfo.type == 6}">	High/Low DTAB</c:if>
										<c:if test="${IOListInfo.type == 7}">	High VH</c:if>
										<c:if test="${IOListInfo.type == 8}"> Low VL</c:if>
										<c:if test="${IOListInfo.type == 9}">	Irrational	</c:if>
								</td>         
	                            <td class="tc">
			                            <c:if test="${IOListInfo.iogroup == 0}">None</c:if>
			                            <c:if test="${IOListInfo.iogroup == 1}">Reactor/PHT</c:if>
			                            <c:if test="${IOListInfo.iogroup == 2}">Turbine and Boilers</c:if>
			                            <c:if test="${IOListInfo.iogroup == 3}">Safety/Low</c:if>
	                            		<c:if test="${IOListInfo.iogroup == 4}">	Electrical</c:if>
	                            		<c:if test="${IOListInfo.iogroup == 8}">Auxiliaries</c:if>
	                            </td>           
	                            <td class="tc"> ${IOListInfo.window}</td>
                                <td class="tc">
			                            <c:if test="${IOListInfo.priority == 0}">Printer Only</c:if>
			                            <c:if test="${IOListInfo.priority == 1}">Minor</c:if>
			                            <c:if test="${IOListInfo.priority == 2}">Safety</c:if>
			                            <c:if test="${IOListInfo.priority == 3}">Major</c:if>
	                            </td>
	                            <td class="tc">
	                            		<c:if test="${IOListInfo.cr == 0}">None</c:if>
			                            <c:if test="${IOListInfo.cr == 1}">Conditioned</c:if>
	                            </td>
	                            <td class="tc">${IOListInfo.limit1}</td>
	                            <td class="tc">${IOListInfo.limit2}</td>
	                            <td class="tc">${IOListInfo.j}</td>
	                            <td class="tc">
		                            		<c:if test="${IOListInfo.n == 0}">commission</c:if>
				                            <c:if test="${IOListInfo.n == 1}">Not commission</c:if>
				                </td>
	                            <td class="tc">${IOListInfo.equ}</td>
	                            <td class="tc">${IOListInfo.bscal}</td>
	                            <td class="tc">
	                            		    <c:if test="${IOListInfo.wiba == 0}">Out</c:if>
				                            <c:if test="${IOListInfo.wiba == 1}">In</c:if>
	                            </td>
	                            <td class="tc">${IOListInfo.wb}</td>
	                            <td class="tc">${IOListInfo.ztext1}</td>
	                            <td class="tc">${IOListInfo.ztext2}</td>
	                            <td class="tc">${IOListInfo.ztext3}</td>
	                            <td style="display:none;">${IOListInfo.ihogi}</td>
	                            <td style="display:none;">${IOListInfo.iseq}</td>
	                            <td style="display:none;">${IOListInfo.iotype}</td>
	                            <td style="display:none;">${IOListInfo.xygubun}</td>
	                            <td style="display:none;">${IOListInfo.reqno}</td>
	                            <td style="display:none;">${IOListInfo.reqdate}</td>
	                            <td style="display:none;">${IOListInfo.reqname}</td>
	                            <td style="display:none;">${IOListInfo.reqdept}</td>
	                            <td style="display:none;">${IOListInfo.reqbigo}</td>
	                        </tr>
	                        </c:forEach>
	                        </c:if>
	                       <c:if test="${BaseSearch.totalCnt < 10}">
	                       <c:forEach var="i" begin="${BaseSearch.totalCnt}" end="9" step="1">
	                        <tr>
	                           <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                        </tr>
	                        </c:forEach>
	                        </c:if>
	                    </tbody>
	                </table>
	                
	                <table class="list_table"  id="ioType_1_List"  name="ioType_1_List">
	                    <colgroup>
	                        <col width="70px"/>
	                        <col width="60px"/>
	                        <col width="600px"/>	                        
	                        <col width="150px"/>
	                        <col width="150px"/>
	                        <col width="150px"/>
	                        <col width="150px"/>	                        
	                        <col width="150x"/>
	                        <col width="150px"/>
	                        <col width="120px"/>	                        	                      
	                        <col width="120px"/>
	                        <col width="75px"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>ADDR</th>
	                            <th>REV</th>
								<th>DESCR</th>
	                            <th>DRAWING</th>
	                            <th>DEVICE</th>
	                            <th>PURPOSE</th>
	                            <th>CTRLNAME</th>
	                            <th>INTERLOCK</th>                      
	                            <th>FEEDBACK</th>
						    	<th>COM1</th>
						    	<th>COM2</th>
						    	<th>WIBA</th>
	                        </tr>
	                    </thead>
	                    <tbody id="ioType_1_List_body">
	                    <c:if test="${BaseSearch.sIOType eq 'AO' }">
	                    <c:forEach var="IOListInfo" items="${IOListInfoList}">
	                        <tr>
	                            <td class="tc">${IOListInfo.address}</td>
	                            <td class="tc">${IOListInfo.rev}</td>
	                            <td class="tc">${IOListInfo.descr}</td>
	                            <td class="tc">${IOListInfo.drawing}</td>
	                            <td class="tc">${IOListInfo.device}</td>
	                            <td class="tc">${IOListInfo.purpose}</td>
	                            <td class="tc">${IOListInfo.ctrlname}</td>
	                            <td class="tc">${IOListInfo.interlock}</td>
	                            <td class="tc">${IOListInfo.feedback}</td>
	                            <td class="tc">${IOListInfo.com1}</td>
	                            <td class="tc">${IOListInfo.com2}</td>
	                            <td class="tc">
	                            			<c:if test="${IOListInfo.wiba == 0}">Out</c:if>
				                            <c:if test="${IOListInfo.wiba == 1}">In</c:if>
				                </td>
	                            <td style="display:none;">${IOListInfo.ihogi}</td>
	                            <td style="display:none;">${IOListInfo.iseq}</td>
	                            <td style="display:none;">${IOListInfo.iotype}</td>
	                            <td style="display:none;">${IOListInfo.xygubun}</td>
	                            <td style="display:none;">${IOListInfo.reqno}</td>
	                            <td style="display:none;">${IOListInfo.reqdate}</td>
	                            <td style="display:none;">${IOListInfo.reqname}</td>
	                            <td style="display:none;">${IOListInfo.reqdept}</td>
	                            <td style="display:none;">${IOListInfo.reqbigo}</td>
	                        </tr>
	                       </c:forEach>
	                       </c:if>
	                       <c:if test="${BaseSearch.totalCnt < 10}">
	                       <c:forEach var="i" begin="${BaseSearch.totalCnt}" end="9" step="1">
	                       	<tr>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>	   	                  	                                      
	                        </tr>
	                       </c:forEach>
	                       </c:if>
	                    </tbody>
	                </table>
	                
	                <table class="list_table"  id="ioType_2_List"  name="ioType_2_List">
	                    <colgroup>
	                        <col width="70px"/>
	                        <col width="100px"/>
	                        <col width="100px"/>
	                        <col width="120px"/>
	                        <col width="120px"/>
	                        <col width="70px"/>
	                        <col width="400px"/>	                        
	                        <col width="150x"/>
	                        <col width="55px"/>
	                        <col width="200px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                        <col width="200px"/>
	                        <col width="200px"/>
	                        <col width="200px"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>ADDR</th>
	                            <th>TR</th>
	                            <th>CR</th>
	                            <th>PRIORITY</th>
	                            <th>GROUP</th>
	                            <th>TYPE</th>
	                            <th>MESSAGE</th>
	                            <th>DRAWING</th>
						    	<th>REV</th>
						    	<th>DEVICE</th>
						    	<th>CONDITION</th>
						    	<th>WIBA</th>
						    	<th>WB#</th>
						    	<th>원인</th>
						    	<th>조치</th>
						    	<th>관련절차서</th>
	                        </tr>
	                    </thead>
	                    <tbody id="ioType_2_List_body">
	                    <c:if test="${BaseSearch.sIOType eq 'CI' }">
	                    <c:forEach var="IOListInfo" items="${IOListInfoList}">
	                        <tr>
	                            <td class="tc">${IOListInfo.address}</td>
	                            <td class="tc">
	                            		<c:if test="${IOListInfo.tr == 0}">Seconds</c:if>
			                            <c:if test="${IOListInfo.tr == 1}">Millisecond</c:if>
			                    </td>
	                            <td class="tc">
	                            	    <c:if test="${IOListInfo.cr == 0}">None</c:if>
			                            <c:if test="${IOListInfo.cr == 1}">Conditioned</c:if>
	                            </td>
	                            <td class="tc">${IOListInfo.priority}</td>
	                            <td class="tc">
	                                    <c:if test="${IOListInfo.iogroup == 0}">None</c:if>
			                            <c:if test="${IOListInfo.iogroup == 1}">Reactor/PHT</c:if>
			                            <c:if test="${IOListInfo.iogroup == 2}">Turbine and Boilers</c:if>
			                            <c:if test="${IOListInfo.iogroup == 3}">Safety/Low</c:if>
	                            		<c:if test="${IOListInfo.iogroup == 4}">	Electrical</c:if>
	                            		<c:if test="${IOListInfo.iogroup == 8}">Auxiliaries</c:if>
	                            </td>
	                            <td class="tc">
	                                    <c:if test="${IOListInfo.type == 0}">None </c:if>
			                            <c:if test="${IOListInfo.type == 1}">High</c:if>
			                            <c:if test="${IOListInfo.type == 2}">	Low</c:if>
										<c:if test="${IOListInfo.type == 3}">	High/Low</c:if>
										<c:if test="${IOListInfo.type == 4}">	High DTAB</c:if>
										<c:if test="${IOListInfo.type == 5}">	Low DATB</c:if>
										<c:if test="${IOListInfo.type == 6}">	High/Low DTAB</c:if>
										<c:if test="${IOListInfo.type == 7}">	High VH</c:if>
										<c:if test="${IOListInfo.type == 8}"> Low VL</c:if>
										<c:if test="${IOListInfo.type == 9}">	Irrational	</c:if>
	                            </td>
	                            <td class="tc">${IOListInfo.message}</td>
	                            <td class="tc">${IOListInfo.drawing}</td>
	                            <td class="tc">${IOListInfo.rev}</td>
	                            <td class="tc">${IOListInfo.device}</td>
	                            <td class="tc">${IOListInfo.condition}</td>
	                            <td class="tc">
	                            			<c:if test="${IOListInfo.wiba == 0}">Out</c:if>
				                            <c:if test="${IOListInfo.wiba == 1}">In</c:if>
	                            </td>
	                            <td class="tc">${IOListInfo.wb}</td>
	                            <td class="tc">${IOListInfo.ztext1}</td>
	                            <td class="tc">${IOListInfo.ztext2}</td>
	                            <td class="tc">${IOListInfo.ztext3}</td>
	                            <td style="display:none;">${IOListInfo.ihogi}</td>
	                            <td style="display:none;">${IOListInfo.iseq}</td>
	                            <td style="display:none;">${IOListInfo.iotype}</td>
	                            <td style="display:none;">${IOListInfo.xygubun}</td>
	                            <td style="display:none;">${IOListInfo.reqno}</td>
	                            <td style="display:none;">${IOListInfo.reqdate}</td>
	                            <td style="display:none;">${IOListInfo.reqname}</td>
	                            <td style="display:none;">${IOListInfo.reqdept}</td>
	                            <td style="display:none;">${IOListInfo.reqbigo}</td>
	                        </tr>
	                    </c:forEach>
	                    </c:if>
	                       <c:if test="${BaseSearch.totalCnt < 10}">
	                       <c:forEach var="i" begin="${BaseSearch.totalCnt}" end="9" step="1">
	                       	<tr>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>	   	                  	                                      
	                        </tr>
	                       </c:forEach>
	                       </c:if>
	                    </tbody>
	                </table>
	                
	                <table class="list_table"  id="ioType_3_List"  name="ioType_3_List">
	                    <colgroup>
	                        <col width="70px"/>
	                        <col width="55px"/>
	                        <col width="55px"/>
	                        <col width="600px"/>
	                        <col width="150px"/>
	                        <col width="200px"/>
	                        <col width="100px"/>	                        
	                        <col width="110x"/>
	                        <col width="120px"/>
	                        <col width="100px"/>
	                        <col width="120px"/>
	                        <col width="120px"/>
	                        <col width="75px"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>ADDR</th>
	                            <th>BIT</th>
	                            <th>REV</th>
								<th>DESCR</th>
	                            <th>DRAWING</th>
	                            <th>DEVICE</th>
	                            <th>PURPOSE</th>
						    	<th>CTRLNAME</th>
						    	<th>ALARMCOND</th>
						    	<th>INDICATE</th>
						    	<th>OPEN상태</th>
						    	<th>CLOSE상태</th>
						    	<th>WIBA</th>
	                        </tr>
	                    </thead>
	                    <tbody id="ioType_3_List_body">
	                    <c:if test="${BaseSearch.sIOType eq 'DI' }">
	                    <c:forEach var="IOListInfo" items="${IOListInfoList}">
	                        <tr>
	                            <td class="tc">${IOListInfo.address}</td>
	                            <td class="tc">${IOListInfo.iobit}</td>
	                            <td class="tc">${IOListInfo.rev}</td>
	                            <td class="tc">${IOListInfo.descr}</td>
	                            <td class="tc">${IOListInfo.drawing}</td>
	                            <td class="tc">${IOListInfo.device}</td>
	                            <td class="tc">${IOListInfo.purpose}</td>
	                            <td class="tc">${IOListInfo.ctrlname}</td>
	                            <td class="tc">${IOListInfo.alarmcond}</td>
	                            <td class="tc">${IOListInfo.indicate}</td>
	                            <td class="tc">${IOListInfo.com1}</td>
	                            <td class="tc">${IOListInfo.com2}</td>
	                            <td class="tc">
	                            			<c:if test="${IOListInfo.wiba == 0}">Out</c:if>
				                            <c:if test="${IOListInfo.wiba == 1}">In</c:if>
	                            </td>
	                            <td style="display:none;">${IOListInfo.ihogi}</td>
	                            <td style="display:none;">${IOListInfo.iseq}</td>
	                            <td style="display:none;">${IOListInfo.iotype}</td>
	                            <td style="display:none;">${IOListInfo.xygubun}</td>
	                            <td style="display:none;">${IOListInfo.reqno}</td>
	                            <td style="display:none;">${IOListInfo.reqdate}</td>
	                            <td style="display:none;">${IOListInfo.reqname}</td>
	                            <td style="display:none;">${IOListInfo.reqdept}</td>
	                            <td style="display:none;">${IOListInfo.reqbigo}</td>
	                        </tr>
	                    </c:forEach>
	                    </c:if>
	                       <c:if test="${BaseSearch.totalCnt < 10}">
	                       <c:forEach var="i" begin="${BaseSearch.totalCnt}" end="9" step="1">
	                       	<tr>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>	   	                  	                                      
	                        </tr>
	                       </c:forEach>
	                       </c:if>
	                    </tbody>
	                </table>
	                
	                <table class="list_table"  id="ioType_4_List"  name="ioType_4_List">
	                    <colgroup>
	                        <col width="70px"/>
	                        <col width="55px"/>
	                        <col width="55px"/>
	                        <col width="600px"/>
	                        <col width="150px"/>
	                        <col width="200px"/>
	                        <col width="100px"/>	                        
	                        <col width="110x"/>
	                        <col width="120px"/>
	                        <col width="120px"/>
	                        <col width="120px"/>
	                        <col width="75px"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>ADDR</th>
	                            <th>BIT</th>
	                            <th>REV</th>
								<th>DESCR</th>
	                            <th>DRAWING</th>
	                            <th>DEVICE</th>
	                            <th>PURPOSE</th>
						    	<th>CTRLNAME</th>
						    	<th>INTERLOCK</th>
						    	<th>OPEN상태</th>
						    	<th>CLOSE상태</th>
						    	<th>WIBA</th>
	                        </tr>
	                    </thead>
	                    <tbody id="ioType_4_List_body">
	                    <c:if test="${BaseSearch.sIOType eq 'DO' }">
	                    <c:forEach var="IOListInfo" items="${IOListInfoList}">
	                        <tr>
	                            <td class="tc">${IOListInfo.address}</td>
	                            <td class="tc">${IOListInfo.iobit}</td>
	                            <td class="tc">${IOListInfo.rev}</td>
	                            <td class="tc">${IOListInfo.descr}</td>
	                            <td class="tc">${IOListInfo.drawing}</td>
	                            <td class="tc">${IOListInfo.device}</td>
	                            <td class="tc">${IOListInfo.purpose}</td>
	                            <td class="tc">${IOListInfo.ctrlname}</td>
	                            <td class="tc">${IOListInfo.interlock}</td>
	                            <td class="tc">${IOListInfo.com1}</td>
	                            <td class="tc">${IOListInfo.com2}</td>
	                            <td class="tc">
	                           				<c:if test="${IOListInfo.wiba == 0}">Out</c:if>
				                            <c:if test="${IOListInfo.wiba == 1}">In</c:if>
	                           	</td>
	                            <td style="display:none;">${IOListInfo.ihogi}</td>
	                            <td style="display:none;">${IOListInfo.iseq}</td>
	                            <td style="display:none;">${IOListInfo.iotype}</td>
	                            <td style="display:none;">${IOListInfo.xygubun}</td>
	                            <td style="display:none;">${IOListInfo.reqno}</td>
	                            <td style="display:none;">${IOListInfo.reqdate}</td>
	                            <td style="display:none;">${IOListInfo.reqname}</td>
	                            <td style="display:none;">${IOListInfo.reqdept}</td>
	                            <td style="display:none;">${IOListInfo.reqbigo}</td>
	                        </tr>
	                    </c:forEach>    
	                    </c:if>
	                       <c:if test="${BaseSearch.totalCnt < 10}">
	                       <c:forEach var="i" begin="${BaseSearch.totalCnt}" end="9" step="1">
	                       	<tr>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>	   	                  	                                      
	                        </tr>
	                       </c:forEach>
	                       </c:if>
	                    </tbody>
	                </table>
	                
	                <table class="list_table"  id="ioType_5_List"  name="ioType_5__8List">
	                    <colgroup>
	                        <col width="70px"/>
	                        <col width="200px"/>
	                        <col width="600px"/>
	                        <col width="150px"/>
	                        <col width="150px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>ADDR</th>
	                            <th>PROGRAM</th>
	                            <th>DESCR</th>
	                            <th>LOOPNAME</th>
	                            <th>BSCAL</th>
	                            <th>ELOW</th>
	                            <th>EHIGH</th>
	                        </tr>
	                    </thead>
	                    <tbody id="ioType_5_List_body">
	                    <c:if test="${BaseSearch.sIOType eq 'DT' || BaseSearch.sIOType eq 'FTDT' }">
	                    <c:forEach var="IOListInfo" items="${IOListInfoList}">
	                        <tr>
	                            <td class="tc">${IOListInfo.address}</td>
	                            <td class="tc">${IOListInfo.program}</td>
	                            <td class="tc">${IOListInfo.descr}</td>
	                            <td class="tc">${IOListInfo.loopname}</td>
	                            <td class="tc">${IOListInfo.bscal}</td>
	                            <td class="tc">${IOListInfo.elow}</td>
	                            <td class="tc">${IOListInfo.ehigh}</td>
	                            <td style="display:none;">${IOListInfo.ihogi}</td>
	                            <td style="display:none;">${IOListInfo.iseq}</td>
	                            <td style="display:none;">${IOListInfo.iotype}</td>
	                            <td style="display:none;">${IOListInfo.xygubun}</td>
	                            <td style="display:none;">${IOListInfo.reqno}</td>
	                            <td style="display:none;">${IOListInfo.reqdate}</td>
	                            <td style="display:none;">${IOListInfo.reqname}</td>
	                            <td style="display:none;">${IOListInfo.reqdept}</td>
	                            <td style="display:none;">${IOListInfo.reqbigo}</td>
	                        </tr>
	                    </c:forEach>
	                    </c:if>
	                       <c:if test="${BaseSearch.totalCnt < 10}">
	                       <c:forEach var="i" begin="${BaseSearch.totalCnt}" end="9" step="1">
	                       	<tr>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>	   	                  	                                      
	                        </tr>
	                       </c:forEach>
	                       </c:if>
	                    </tbody>
	                </table>
	                
	                <table class="list_table"  id="ioType_6_List"  name="ioType_6_List">
	                    <colgroup>
	                        <col width="70px"/>
	                        <col width="55px"/>
	                        <col width="600px"/>
	                        <col width="110px"/>
	                        <col width="110px"/>
	                        <col width="80px"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>ADDR</th>
	                            <th>BIT</th>
	                            <th>DESCR</th>
	                            <th>PROGRAM</th>
	                            <th>INDICATE</th>
	                            <th>BSCAL</th>
	                        </tr>
	                    </thead>
	                    <tbody id="ioType_6_List_body">
	                    <c:if test="${BaseSearch.sIOType eq 'SC'}">
	                    <c:forEach var="IOListInfo" items="${IOListInfoList}">
	                        <tr>
	                            <td class="tc">${IOListInfo.address}</td>
	                            <td class="tc">${IOListInfo.iobit}</td>
	                            <td class="tc">${IOListInfo.descr}</td>
	                            <td class="tc">${IOListInfo.program}</td>
	                            <td class="tc">${IOListInfo.indicate}</td>
	                            <td class="tc">${IOListInfo.bscal}</td>
	                            <td style="display:none;">${IOListInfo.ihogi}</td>
	                            <td style="display:none;">${IOListInfo.iseq}</td>
	                            <td style="display:none;">${IOListInfo.iotype}</td>
	                            <td style="display:none;">${IOListInfo.xygubun}</td>
	                            <td style="display:none;">${IOListInfo.reqno}</td>
	                            <td style="display:none;">${IOListInfo.reqdate}</td>
	                            <td style="display:none;">${IOListInfo.reqname}</td>
	                            <td style="display:none;">${IOListInfo.reqdept}</td>
	                            <td style="display:none;">${IOListInfo.reqbigo}</td>
	                        </tr>
	                    </c:forEach>
	                    </c:if>
	                       <c:if test="${BaseSearch.totalCnt < 10}">
	                       <c:forEach var="i" begin="${BaseSearch.totalCnt}" end="9" step="1">
	                       	<tr>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>	   	                  	                                      
	                        </tr>
	                       </c:forEach>
	                       </c:if>
	                    </tbody>
	                </table>
	                
	                <table class="list_table"  id="ioType_7_List"  name="ioType_7_List">
	                    <colgroup>
	                        <col width="70px"/>
	                        <col width="600px"/>
	                        <col width="380px"/>
	                        <col width="60px"/>
	                        <col width="150px"/>
	                        <col width="120px"/>
	                        <col width="150px"/>	                        
	                        <col width="100x"/>
	                        <col width="100px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                        <col width="120px"/>	                        
	                        <col width="90px"/>	                        
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
	                        <col width="80px"/>
	                        <col width="80px"/>	     
	                        <col width="80px"/>
	                        <col width="80px"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                              <th>ADDR</th>
	                              <th>DESCR</th>
	                              <th>MESSAGE</th>
	                              <th>REV</th>
	                              <th>DRAWING</th>
	                              <th>LOOPNAME</th>
	                              <th>DEVICE</th>
	                              <th>PURPOSE</th>
						    	  <th>PROGRAM</th>
						    	  <th>VLOW</th>
						    	  <th>VHIGH</th>
						    	  <th>ELOW</th>
						    	  <th>EHIGH</th>
						    	  <th>UNIT</th>
						    	  <th>CONV</th>
						    	  <th>RTD</th>
						    	  <th>TYPE</th>
						    	  <th>GROUP</th>
						    	  <th>WINDOW</th>
						    	  <th>PRIORITY</th>
						    	  <th>CR</th>
						    	  <th>LIMIT1</th>
						    	  <th>LIMIT2</th>
						    	  <th>J</th>
						    	  <th>N</th>
						    	  <th>EQU#</th>
						    	  <th>BSCAL</th>
						    	  <th>WIBA</th>
						    	  <th>WB#</th>											    	  
	                        </tr>
	                    </thead>
	                    <tbody id="ioType_7_List_body">
	                    <c:if test="${BaseSearch.sIOType eq 'FTAI'}">
	                    <c:forEach var="IOListInfo" items="${IOListInfoList}">
	                        <tr>
	                            <td class="tc">${IOListInfo.address}</td>
	                            <td class="tc">${IOListInfo.descr}</td>
	                            <td class="tc">${IOListInfo.message}</td>
	                            <td class="tc">${IOListInfo.rev}</td>
	                            <td class="tc">${IOListInfo.drawing}</td>
	                            <td class="tc">${IOListInfo.loopname}</td>
	                            <td class="tc">${IOListInfo.device}</td>
	                            <td class="tc">${IOListInfo.purpose}</td>
	                            <td class="tc">${IOListInfo.program}</td>
	                            <td class="tc">${IOListInfo.vlow}</td>
	                            <td class="tc">${IOListInfo.vhigh}</td>
	                            <td class="tc">${IOListInfo.elow}</td>
	                            <td class="tc">${IOListInfo.ehigh}</td>
	                            <td class="tc">${IOListInfo.unit}</td>
	                            <td class="tc">${IOListInfo.conv}</td>
	                            <td class="tc">${IOListInfo.rtd}</td>
	                            <td class="tc">
	                                    <c:if test="${IOListInfo.type == 0}">None </c:if>
			                            <c:if test="${IOListInfo.type == 1}">High</c:if>
			                            <c:if test="${IOListInfo.type == 2}">	Low</c:if>
										<c:if test="${IOListInfo.type == 3}">	High/Low</c:if>
										<c:if test="${IOListInfo.type == 4}">	High DTAB</c:if>
										<c:if test="${IOListInfo.type == 5}">	Low DATB</c:if>
										<c:if test="${IOListInfo.type == 6}">	High/Low DTAB</c:if>
										<c:if test="${IOListInfo.type == 7}">	High VH</c:if>
										<c:if test="${IOListInfo.type == 8}"> Low VL</c:if>
										<c:if test="${IOListInfo.type == 9}">	Irrational	</c:if>
	                            </td>
	                            <td class="tc">
	                                    <c:if test="${IOListInfo.iogroup == 0}">None</c:if>
			                            <c:if test="${IOListInfo.iogroup == 1}">Reactor/PHT</c:if>
			                            <c:if test="${IOListInfo.iogroup == 2}">Turbine and Boilers</c:if>
			                            <c:if test="${IOListInfo.iogroup == 3}">Safety/Low</c:if>
	                            		<c:if test="${IOListInfo.iogroup == 4}">	Electrical</c:if>
	                            		<c:if test="${IOListInfo.iogroup == 8}">Auxiliaries</c:if>
	                            </td>
	                            <td class="tc">${IOListInfo.window}</td>
	                            <td class="tc">${IOListInfo.priority}</td>
	                            <td class="tc">
	                            	    <c:if test="${IOListInfo.cr == 0}">None</c:if>
			                            <c:if test="${IOListInfo.cr == 1}">Conditioned</c:if>
	                            </td>
	                            <td class="tc">${IOListInfo.limit1}</td>
	                            <td class="tc">${IOListInfo.limit2}</td>
	                            <td class="tc">${IOListInfo.j}</td>
	                            <td class="tc">${IOListInfo.n}</td>
	                            <td class="tc">${IOListInfo.equ}</td>
	                            <td class="tc">${IOListInfo.bscal}</td>
	                            <td class="tc">
	                            			<c:if test="${IOListInfo.wiba == 0}">Out</c:if>
				                            <c:if test="${IOListInfo.wiba == 1}">In</c:if>
	                            </td>
	                            <td class="tc">${IOListInfo.wb}</td>
	                            <td style="display:none;">${IOListInfo.ihogi}</td>
	                            <td style="display:none;">${IOListInfo.iseq}</td>
	                            <td style="display:none;">${IOListInfo.iotype}</td>
	                            <td style="display:none;">${IOListInfo.xygubun}</td>
	                            <td style="display:none;">${IOListInfo.reqno}</td>
	                            <td style="display:none;">${IOListInfo.reqdate}</td>
	                            <td style="display:none;">${IOListInfo.reqname}</td>
	                            <td style="display:none;">${IOListInfo.reqdept}</td>
	                            <td style="display:none;">${IOListInfo.reqbigo}</td>
	                        </tr>
	                    </c:forEach>
	                    </c:if>
	                       <c:if test="${BaseSearch.totalCnt < 10}">
	                       <c:forEach var="i" begin="${BaseSearch.totalCnt}" end="9" step="1">
	                       	<tr>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>	   	                  	                                      
	                        </tr>
	                       </c:forEach>
	                       </c:if>
	                    </tbody>
	                </table>
	                
	                <table class="list_table"  id="ioType_8_List"  name="ioType_5__8List">
	                     <colgroup>
	                        <col width="70px"/>
	                        <col width="200px"/>
	                        <col width="600px"/>
	                        <col width="150px"/>
	                        <col width="150px"/>
	                        <col width="75px"/>
	                        <col width="75px"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>ADDR</th>
	                            <th>PROGRAM</th>
	                            <th>DESCR</th>
	                            <th>LOOPNAME</th>
	                            <th>BSCAL</th>
	                            <th>ELOW</th>
	                            <th>EHIGH</th>
	                        </tr>
	                    </thead>
	                    <tbody id="ioType_8_List_body">
	                    <c:forEach var="IOListInfo" items="${IOListInfoList}">
	                        <tr>
	                            <td class="tc">${IOListInfo.address}</td>
	                            <td class="tc">${IOListInfo.program}</td>
	                            <td class="tc">${IOListInfo.descr}</td>
	                            <td class="tc">${IOListInfo.loopname}</td>
	                            <td class="tc">${IOListInfo.bscal}</td>
	                            <td class="tc">${IOListInfo.elow}</td>
	                            <td class="tc">${IOListInfo.ehigh}</td>
	                            <td style="display:none;">${IOListInfo.ihogi}</td>
	                            <td style="display:none;">${IOListInfo.iseq}</td>
	                            <td style="display:none;">${IOListInfo.iotype}</td>
	                            <td style="display:none;">${IOListInfo.xygubun}</td>
	                            <td style="display:none;">${IOListInfo.reqno}</td>
	                            <td style="display:none;">${IOListInfo.reqdate}</td>
	                            <td style="display:none;">${IOListInfo.reqname}</td>
	                            <td style="display:none;">${IOListInfo.reqdept}</td>
	                            <td style="display:none;">${IOListInfo.reqbigo}</td>
	                        </tr>
	                    </c:forEach>
	                       <c:if test="${BaseSearch.totalCnt < 10}">
	                       <c:forEach var="i" begin="${BaseSearch.totalCnt}" end="9" step="1">
	                       	<tr>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td class="tc"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>
	                            <td style="display:none;"></td>	   	                  	                                      
	                        </tr>
	                       </c:forEach>
	                       </c:if>
	                    </tbody>
	                </table>
	                <!-- //list_table -->
				</div>	                
			</div>
			<!-- //list_wrap -->
            <!-- form_wrap -->
            <div class="form_wrap">
                <!-- form_table -->
                <form id="ioType_0_form"  name="ioType_0_form">
                <input type="hidden"  id ="ihogi" name="ihogi" >
                <input type="hidden"  id ="iseq" name="iseq" >
                <input type="hidden"  id ="xygubun" name="xygubun" >
                <input type="hidden"  id ="iotype" name="iotype" >
                
                <table class="form_table" id="ioType_0_Input" name="ioType_0_Input" >
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text"  id="address" name="address" readonly></td>
                        <th>DSECR</th>
                        <td colspan="3"><input type="text" id="descr" name="descr"></td>
                        <th>MESSAGE</th>
                        <td colspan="3"><input type="text" id="message" name="message"></td>
                    </tr>
                    <tr>
                        <th>REV</th>
                        <td><input type="text" id="rev" name="rev"></td>
                        <th>DRAWNG</th>
                        <td><input type="text" id="drawing" name="drawing"></td>
                        <th>LOOPNAME</th>
                        <td><input type="text" id="loopname" name="loopname"></td>
                        <th>DEVICE</th>
                        <td><input type="text" id="device" name="device"></td>
                        <th>PURPOSE</th>
                        <td><input type="text" id="purpose" name="purpose"></td>
                    </tr>
                    <tr>
                        <th>PROGRAM</th>
                        <td><input type="text" id="program" name="program"></td>
                        <th>VLOW</th>
                        <td><input type="text" id="vlow" name="vlow"></td>
                        <th>VHIGH</th>
                        <td><input type="text" id="vhigh" name="vhigh"></td>
                        <th>ELOW</th>
                        <td><input type="text" id="elow" name="elow"></td>
                        <th>EHIGH</th>
                        <td><input type="text" id="ehigh" name="ehigh"></td>
                    </tr>
                    <tr>
                        <th>UNIT</th>
                        <td><input type="text" id="unit" name="unit"></td>
                        <th>CONV</th>
                        <td><input type="text" id="conv" name="conv"></td>
                        <th>RTD</th>
                        <td><input type="text" id="rtd" name="rtd"></td>
                        <th>TYPE</th>
                        <td>
                            <select id="type" name="type">
                                <option  value="0">None</option>
                                <option  value="1">High</option>
                                <option  value="2">Low</option>
                                <option  value="3">High/Low</option>
                                <option  value="4">High DTAB</option>
                                <option  value="5">Low DATB</option>
                                <option  value="6">High/Low DTAB</option>
                                <option  value="7">High VH</option>
                                <option  value="8">Low VL</option>
                                <option  value="9">Irrational</option>                                
                            </select>
                        </td>
                        <th>IOGROUP</th>
                        <td>
                            <select id="iogroup" name="iogroup">
                                <option value="0">None</option>
                                <option value="1">Reactor/PHT</option>
                                <option value="2">Turbine and Boilers</option>
                                <option value="3">Safety</option>
                                <option value="4">Electrical</option>
                                <option value="8">Auxiliaries</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>WINDOW</th>
                        <td><input type="text" id="window" name="window"></td>
                        <th>PRIORITY</th>
                        <td>
                            <select  id="priority" name="priority">
                                <option value="0">Printer Only</option>
                                <option value="1">Minor</option>
                                <option value="2">Safety</option>
                                <option value="3">Major</option>
                            </select>
                        </td>
                        <th>CR</th>
                        <td>
                            <select id="cr" name="cr">>
                                <option value="0">None</option>
                                <option value="1">Conditioned</option>                                
                            </select>
                        </td>
                        <th>LIMT1</th>
                        <td><input type="text" id="limit1" name="limit1"></td>
                        <th>LIMT2</th>
                        <td><input type="text" id="limit2" name="limit2"></td>
                    </tr>
                    <tr>
                        <th>J</th>
                        <td><input type="text" id="j" name="j"></td>
                        <th>N</th>
                        <td>
                            <select id="n" name="n">>
                                <option value="0">commission</option>
                                <option value="1">Not commission</option>                                
                            </select>
                        </td>
                        <th>EQU#</th>
                        <td><input type="text" id="equ" name="equ"></td>
                        <th>BASCAL</th>
                        <td><input type="text" id="bascal" name="bascal"></td>
                        <th>WIBA</th>
                        <td><select id="wiba" name="wiba">
                                <option value="0">Out</option>
                                <option value="1">In</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>WB#</th>
                        <td><input type="text" id="wb" name="wb"></td>
                        <th>REQ_NO</th>
                        <td><input type="text" id="reqno" name="reqno"></td>
                        <th>REQ_DATE</th>
                        <td><input type="text" id="reqdate" name="reqdate"></td>
                        <th>REQ_NAME</th>
                        <td><input type="text" id="reqname" name="reqname"></td>
                        <th>REQ_DEPT</th>
                        <td><input type="text" id="reqdept" name="reqdept"></td>
                    </tr>
                    <tr>
                        <th>비고</th>
                        <td colspan="5"><input type="text" id="reqbigo" name="reqbigo"></td>
                        <th>관련절차서</th>
                        <td colspan="3"><input type="text" id="ztext1" name="ztext1"></td>
                    </tr>
                    <tr>
                        <th>원인</th>
                        <td colspan="3">
                            <textarea  id="ztext2" name="ztext2"></textarea>
                        </td>
                        <th>조치</th>
                        <td colspan="5">
                            <textarea  id="ztext3" name="ztext3"></textarea>
                        </td>
                    </tr>
                </table>
                </form>
                
                <form id="ioType_1_form"  name="ioType_1_form">
                <input type="hidden"  id ="ihogi" name="ihogi" >
                <input type="hidden"  id ="iseq" name="iseq" >
                <input type="hidden"  id ="xygubun" name="xygubun" >
                <input type="hidden"  id ="iotype" name="iotype" >
                <table class="form_table" id="ioType_1_Input" name="ioType_1_Input" >
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="address" name="address"></td>
                        <th>REV</th>
                        <td><input type="text" id="rev" name="rev"></td>
                         <th>DSECR</th>
                        <td colspan="3"><input type="text" id="descr" name="descr"></td>
                        <th>DRAWING</th>
                        <td><input type="text" id="drawing" name="drawing"></td>
                    </tr>
                    <tr>
                        <th>DEVICE</th>
                        <td><input type="text" id="device" name="device"></td>
                        <th>PURPOSE</th>
                        <td><input type="text" id="purpose" name="purpose"></td>
                        <th>CTRLNAME</th>
                        <td><input type="text" id="ctrlname" name="ctrlname"></td>
                        <th>INTERLOCK</th>
                        <td><input type="text" id="interlock" name="interlock"></td>
                        <th>FEEDBACK</th>
                        <td><input type="text" id="feedback" name="feedback"></td>
                    </tr>
                    <tr>
                        <th>COM1</th>
                        <td><input type="text" id="com1" name="com1"></td>
                        <th>COM2</th>
                        <td><input type="text" id="com2" name="com2"></td>
                        <th>WIBA</th>
                        <td> <select id="wiba" name="wiba">
                                <option value="0">Out</option>
                                <option value="1">In</option>
                            </select>
                        </td>
                         <th>REQ_NO</th>
                        <td><input type="text" id="reqno" name="reqno"></td>
                        <th>REQ_DATE</th>
                        <td><input type="text" id="reqdate" name="reqdate"></td>
                    </tr>
                    <tr>
                    	<th>REQ_NAME</th>
                        <td><input type="text" id="reqname" name="reqname"></td>
                        <th>REQ_DEPT</th>
                        <td><input type="text" id="reqdept" name="reqdept"></td>
                        <th>비고</th>
                        <td colspan="5"><input type="reqbigo" id="descr" name="reqbigo"></td>
                    </tr>
                </table>
                </form>
                
                <form id="ioType_2_form"  name="ioType_2_form">
                <input type="hidden"  id ="ihogi" name="ihogi" >
                <input type="hidden"  id ="iseq" name="iseq" >
                <input type="hidden"  id ="xygubun" name="xygubun" >
                <input type="hidden"  id ="iotype" name="iotype" >
                 <table class="form_table" id="ioType_2_Input" name="ioType_2_Input" >
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                         <th>ADDRESS</th>
                        <td><input type="text" id="address" name="address"></td>
                        <th>TR</th>
                        <td><select id="tr" name="tr">
                        		<option  value="0">Seconds</option>
                        		<option  value="1">Milliseconds</option>
                        		</select>
                        </td>
                        <th>CR</th>
                        <td><select id="cr" name="cr">
                        		<option  value="0">None</option>
                        		<option  value="1">Conditioned</option>
                        	</select>
                        </td>
                        <th>PRIORITY</th>
                        <td><select id="priority" name="priority">
                        		<option  value="0">Undef</option>
                        		<option  value="1">Minor</option>
                        		<option  value="2">Safety</option>
                        		<option  value="3">Major</option>
                        	</select>
                        </td>
                        <th>GROUP</th>
                        <td><select id="iogroup" name="iogroup">
                        			<option value="0"> None </option>
                        			<option value="1"> Reactor/PHT </option>
                        			<option value="2"> SG/Turbine </option>
                        			<option value="3"> Safety </option>
                        			<option value="4"> Electrical </option>
                        			<option value="8"> Auxiliaries </option>
                        		</select>
                        </td>
                    </tr>
                    <tr>
                        <th>TYPE</th>
                        <td><select id="type" name="type">
                        		<option  value="0">Alarm on Opening</option>
                        		<option  value="1">Alarm on Closing</option>
                        	</select>                        
                        </td>
                        <th>MESSAGE</th>
                        <td><input type="text" id="message" name="message"></td>
                        <th>DRAWING</th>
                        <td><input type="text" id="drawing" name="drawing"></td>
                        <th>REV</th>
                        <td><input type="text" id="rev" name="rev"></td>
                        <th>DEVICE</th>
                        <td><input type="text" id="device" name="device"></td>
                    </tr>
                    <tr>
                        <th>CONDITION</th>
                        <td><input type="text" id="condition" name="condition"></td>
                        <th>WIBA</th>
                        <td><select id="wiba" name="wiba">
                                <option  value="0">Out</option>
                                <option  value="1">In</option>
                            </select></td>
                        <th>WB#</th>
                        <td><input type="text" id="wb" name="wb"></td>
                        <th>REQ_NO</th>
                        <td><input type="text" id="reqno" name="reqno"></td>
                        <th>REQ_DATE</th>
                        <td><input type="text" id="reqdate" name="reqdate"></td>
                    </tr>
                    <tr>
                    	<th>REQ_NAME</th>
                        <td><input type="text" id="reqname" name="reqname"></td>
                        <th>REQ_DEPT</th>
                        <td><input type="text" id="reqdept" name="reqdept"></td>
                        <th>비고</th>
                        <td colspan="3"><input type="text" id="reqbigo" name="reqbito"></td>
                        <th>관련 절차서</th>
                        <td><input type="text" id="ztext1" name="ztext1"></td>
                    </tr>
                    <tr>
                        <th>원인</th>
                        <td colspan="4">
                            <textarea id="ztext2" name="ztext2"></textarea>
                        </td>
                        <th>조치</th>
                        <td colspan="4">
                            <textarea id="ztext3" name="ztext3"></textarea>
                        </td>
                    </tr>
                </table>
                </form>
                
                <form id="ioType_3_form"  name="ioType_3_form">
                <input type="hidden"  id ="ihogi" name="ihogi" >
                <input type="hidden"  id ="iseq" name="iseq" >
                <input type="hidden"  id ="xygubun" name="xygubun" >
                <input type="hidden"  id ="iotype" name="iotype" >
                <table class="form_table" id="ioType_3_Input" name="ioType_3_Input" >
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="address" name="address"></td>
                        <th>BIT</th>
                        <td><input type="text" id="iobit" name="iobit"></td>
                        <th>REV</th>
                        <td><input type="text" id="rev" name="rev"></td>
                        <th>DESCR</th>
                        <td colspan="3"><input type="text" id="descr" name="descr"></td>
                    </tr>
                    <tr>
                        <th>DRAWNG</th>
                        <td><input type="text" id="drawing" name="drawing"></td>
                        <th>DEVICE</th>
                        <td><input type="text" id="device" name="device"></td>
                        <th>PURPOSE</th>
                        <td><input type="text" id="purpose" name="purpose"></td>
                        <th>CTRLNAME</th>                        
                        <td><input type="text" id="ctrlname" name="ctrlname"></td>
                        <th>ALARMCOND</th>
                        <td><input type="text" id="alarmcond" name="alarmcond"></td>
                    </tr>
                    <tr>
                        <th>INDICATE</th>
                        <td><input type="text" id="indicate" name="indicate"></td>
                        <th>OPEN상태</th>
                        <td><input type="text" id="com1" name="com1"></td>
                        <th>CLOSE상태</th>
                        <td><input type="text" id="com2" name="com2"></td>
                        <th>WIBA</th>
                        <td><select id="wiba" name="wiba">
                                <option  value="0">Out</option>
                                <option  value="1">In</option>
                            </select></td>
                        <th>REQ_NO</th>
                        <td><input type="text" id="reqno" name="reqno"></td>
                    </tr>
                    <tr>
                        <th>REQ_DATE</th>
                        <td><input type="text" id="reqdate" name="reqdate"></td>
                        <th>REQ_NAME</th>
                        <td><input type="text" id="reqname" name="reqname"></td>
                        <th>REQ_DEPT</th>
                        <td><input type="text" id="reqdept" name="reqdept"></td>
                        <th>비고</th>
                        <td colspan="3"><input type="text" id="reqbigo" name="reqbigo"></td>
                    </tr>
                </table>
                </form>
                
                <form id="ioType_4_form"  name="ioType_4_form">
                <input type="hidden"  id ="ihogi" name="ihogi" >
                <input type="hidden"  id ="iseq" name="iseq" >
                <input type="hidden"  id ="xygubun" name="xygubun" >
                <input type="hidden"  id ="iotype" name="iotype" >
                <table class="form_table" id="ioType_4_Input" name="ioType_4_Input" >
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="address" name="address"></td>
                        <th>REV</th>
                        <td><input type="text" id="rev" name="rev"></td>
                        <th>DSECR</th>
                        <td colspan="3"><input type="text" id="descr" name="descr"></td>
                        <th>DRAWNG</th>
                        <td><input type="text" id="drawing" name="drawing"></td>
                    </tr>
                    <tr>
                    	<th>DEVICE</th>
                        <td><input type="text" id="device" name="device"></td>
                        <th>PURPOSE</th>
                        <td><input type="text" id="purpose" name="purpose"></td>
                        <th>CTRLNAME</th>
                        <td><input type="text" id="ctrlname" name="ctrlname"></td>
                        <th>INTERLOCK</th>
                        <td><input type="text" id="interlock" name="interlock"></td>
                        <th>OPEN상태</th>
                        <td><input type="text" id="com1" name="com1"></td>
                        
                    </tr>
                    <tr>
                        <th>CLOSE상태</th>
                        <td><input type="text" id="com2" name="com2"></td>
                        <th>WIBA</th>
                        <td><select id="wiba" name="wiba">
                                <option  value="0">Out</option>
                                <option  value="1">In</option>
                            </select></td>
                        <th>REQ_NO</th>
                        <td><input type="text" id="reqno" name="reqno"></td>
                        <th>REQ_DATE</th>
                        <td><input type="text" id="reqdate" name="reqdate"></td>
                        <th>REQ_NAME</th>
                        <td><input type="text" id="reqname" name="reqname"></td>
                    </tr>
                    <tr>
                        <th>REQ_DEPT</th>
                        <td><input type="text" id="reqdept" name=""reqdept""></td>
                        <th>비고</th>
                        <td colspan="7"><input type="text" id="reqbigo" name="regbigo"></td>
                    </tr>
                </table>
                </form>
                
                <form id="ioType_5_form"  name="ioType_5_form">
                <input type="hidden"  id ="ihogi" name="ihogi" >
                <input type="hidden"  id ="iseq" name="iseq" >
                <input type="hidden"  id ="xygubun" name="xygubun" >
                <input type="hidden"  id ="iotype" name="iotype" >
                <table class="form_table" id="ioType_5_Input" name="ioType_5_Input" >
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="address" name="address"></td>
                         <th>PROGRAM</th>
                        <td><input type="text" id="program" name="program"></td>
                        <th>DSECR</th>
                        <td colspan="3"><input type="text" id="descr" name="descr"></td>
                        <th>LOOPNAME</th>
                        <td><input type="text" id="loopname" name="loopname"></td>
                      
                    </tr>
                    <tr>
                      	<th>BSCAL</th>
                        <td><input type="text" id="bscal" name="bscal"></td>
                        <th>ELOW</th>
                        <td><input type="text" id="elow" name="elow"></td>
                        <th>EHIGH</th>
                        <td><input type="text" id="ehigh" name="ehigh"></td>
                        <th>REQ_NO</th>
                        <td><input type="text" id="reqno" name="reqno"></td>
                        <th>REQ_DATE</th>
                        <td><input type="text" id="reqdate" name="reqdate"></td>
                       
                    </tr>
                    <tr>
                     <th>REQ_NAME</th>
                        <td><input type="text" id="reqname" name="reqname"></td>
                    	 <th>REQ_DEPT</th>
                        <td><input type="text" id="reqdept" name="reqdept"></td>
                        <th>비고</th>
                        <td colspan="5"><input type="text" id="reqbigo" name="reqbigo"></td>
                    </tr>
                </table>
                </form>
                
                <form id="ioType_6_form"  name="ioType_6_form">
                <input type="hidden"  id ="ihogi" name="ihogi" >
                <input type="hidden"  id ="iseq" name="iseq" >
                <input type="hidden"  id ="xygubun" name="xygubun" >
                <input type="hidden"  id ="iotype" name="iotype" >
                <table class="form_table" id="ioType_6_Input" name="ioType_6_Input" >
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="address" name="address"></td>
                         <th>BIT</th>
                        <td><input type="text" id="iobit" name="iobit"></td>
                        <th>DSECR</th>
                        <td colspan="3"><input type="text" id="descr" name="descr"></td>
                        <th>PROGRAM</th>
                        <td><input type="text" id="program" name="program"></td>
                    </tr>
                    <tr>
                        <th>INDICATE</th>
                        <td><input type="text" id="indicate" name="indicate"></td>
                        <th>BSCAL</th>
                        <td><input type="text" id="bascal" name="bascal"></td>
                        <th>REQ_NO</th>
                        <td><input type="text" id="reqno" name="reqno"></td>
                        <th>REQ_DATE</th>
                        <td><input type="text"  id="reqdate" name="reqdate"></td>
                        <th>REQ_NAME</th>
                        <td><input type="text" id="reqname" name="reqname"></td>
                       
                    </tr>
                    <tr>
                        <th>REQ_DEPT</th>
                        <td><input type="text"  id="reqdept" name="reqdept"></td>
                        <th>비고</th>
                        <td colspan="7"><input type="text"  id="reqbo" name="reqbigo"></td>
                    </tr>
                </table>
                </form>
                
                <form id="ioType_7_form"  name="ioType_7_form">
                <input type="hidden"  id ="ihogi" name="ihogi" >
                <input type="hidden"  id ="iseq" name="iseq" >
                <input type="hidden"  id ="xygubun" name="xygubun" >
                <input type="hidden"  id ="iotype" name="iotype" >
                <table class="form_table" id="ioType_7_Input" name="ioType_7_Input" >
                     <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text"  id="address" name="address"></td>
                        <th>DSECR</th>
                        <td colspan="3"><input type="text" id="descr" name="descr"></td>
                        <th>MESSAGE</th>
                        <td colspan="3"><input type="text" id="message" name="message"></td>
                    </tr>
                    <tr>
                        <th>REV</th>
                        <td><input type="text" id="rev" name="rev"></td>
                        <th>DRAWNG</th>
                        <td><input type="text" id="drawing" name="drawing"></td>
                        <th>LOOPNAME</th>
                        <td><input type="text" id="loopname" name="loopname"></td>
                        <th>DEVICE</th>
                        <td><input type="text" id="device" name="device"></td>
                        <th>PURPOSE</th>
                        <td><input type="text" id="purpose" name="purpose"></td>
                    </tr>
                    <tr>
                        <th>PROGRAM</th>
                        <td><input type="text" id="program" name="program"></td>
                        <th>VLOW</th>
                        <td><input type="text" id="vlow" name="vlow"></td>
                        <th>VHIGH</th>
                        <td><input type="text" id="vhigh" name="vhigh"></td>
                        <th>ELOW</th>
                        <td><input type="text" id="elow" name="elow"></td>
                        <th>EHIGH</th>
                        <td><input type="text" id="ehigh" name="ehigh"></td>
                    </tr>
                    <tr>
                        <th>UNIT</th>
                        <td><input type="text" id="unit" name="unit"></td>
                        <th>CONV</th>
                        <td><input type="text" id="conv" name="conv"></td>
                        <th>RTD</th>
                        <td><input type="text" id="rtd" name="rtd"></td>
                         <th>TYPE</th>
                        <td>
                            <select id="type" name="type">
                                <option  value="0">None</option>
                                <option  value="1">High</option>
                                <option  value="2">Low</option>
                                <option  value="3">High/Low</option>
                                <option  value="4">High DTAB</option>
                                <option  value="5">Low DATB</option>
                                <option  value="6">High/Low DTAB</option>
                                <option  value="7">High VH</option>
                                <option  value="8">Low VL</option>
                                <option  value="9">Irrational</option>                                
                            </select>
                        </td>
                        <th>IOGROUP</th>
                        <td>
                            <select id="iogroup" name="iogroup">
                                <option value="0">None</option>
                                <option value="1">Reactor/PHT</option>
                                <option value="2">Turbine and Boilers</option>
                                <option value="3">Safety</option>
                                <option value="4">Electrical</option>
                                <option value="8">Auxiliaries</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>WINDOW</th>
                        <td><input type="text" id="window" name="window"></td>
                        <th>PRIORITY</th>
                        <td>
                            <select  id="priority" name="priority">
                                <option value="0">Printer Only</option>
                                <option value="1">Minor</option>
                                <option value="2">Safety</option>
                                <option value="3">Major</option>
                            </select>
                        </td>
                        <th>CR</th>
                        <td>
                            <select id="cr" name="cr">>
                                <option value="0">None</option>
                                <option value="1">Conditioned</option>                                
                            </select>
                        </td>
                        <th>LIMT1</th>
                        <td><input type="text" id="limit1" name="limit1"></td>
                        <th>LIMT2</th>
                        <td><input type="text" id="limit2" name="limit2"></td>
                    </tr>
                    <tr>
                        <th>J</th>
                        <td><input type="text" id="j" name="j"></td>
                        <th>N</th>
                        <td>
                            <select id="n" name="n">>
                                <option value="0">commission</option>
                                <option value="1">Not commission</option>                                
                            </select>
                        </td>
                        <th>EQU#</th>
                        <td><input type="text" id="equ" name="equ"></td>
                        <th>BASCAL</th>
                        <td><input type="text" id="bascal" name="bascal"></td>
                        <th>WIBA</th>
                        <td><select id="wiba" name="wiba">
                                <option value="0">Out</option>
                                <option value="1">In</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>WB#</th>
                        <td><input type="text" id="wb" name="wb"></td>
                        <th>REQ_NO</th>
                        <td><input type="text" id="reqno" name="reqno"></td>
                        <th>REQ_DATE</th>
                        <td><input type="text" id="reqdate" name="reqdate"></td>
                        <th>REQ_NAME</th>
                        <td><input type="text" id="reqname" name="reqname"></td>
                        <th>REQ_DEPT</th>
                        <td><input type="text" id="reqdept" name="reqdept"></td>
                    </tr>
                    <tr>
                        <th>비고</th>
                        <td colspan="9"><input type="text" id="reqbigo" name="reqbigo"></td>
                    </tr>
                </table>
                </form>
                
                <form id="ioType_8_form"  name="ioType_8_form">
                <input type="hidden"  id ="ihogi" name="ihogi" >
                <input type="hidden"  id ="iseq" name="iseq" >
                <input type="hidden"  id ="xygubun" name="xygubun" >
                <input type="hidden"  id ="iotype" name="iotype" >
                <table class="form_table" id="ioType_8_Input" name="ioType_8_Input" >
                    <colgroup>
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                        <col width="120px"/>
                        <col />
                    </colgroup>
                    <tr>
                        <th>ADDRESS</th>
                        <td><input type="text" id="address" name="address"></td>
                         <th>PROGRAM</th>
                        <td><input type="text" id="program" name="program"></td>
                        <th>DSECR</th>
                        <td colspan="3"><input type="text" id="descr" name="descr"></td>
                        <th>LOOPNAME</th>
                        <td><input type="text" id="loopname" name="loopname"></td>
                      
                    </tr>
                    <tr>
                      	<th>BSCAL</th>
                        <td><input type="text" id="bscal" name="bscal"></td>
                        <th>ELOW</th>
                        <td><input type="text" id="elow" name="elow"></td>
                        <th>EHIGH</th>
                        <td><input type="text" id="ehigh" name="ehigh"></td>
                        <th>REQ_NO</th>
                        <td><input type="text" id="reqno" name="reqno"></td>
                        <th>REQ_DATE</th>
                        <td><input type="text" id="reqdate" name="reqdate"></td>
                       
                    </tr>
                    <tr>
                     <th>REQ_NAME</th>
                        <td><input type="text" id="reqname" name="reqname"></td>
                    	 <th>REQ_DEPT</th>
                        <td><input type="text" id="reqdept" name="reqdept"></td>
                        <th>비고</th>
                        <td colspan="5"><input type="text" id="reqbigo" name="reqbigo"></td>
                    </tr>
                </table>
                </form>
                <!-- //form_table -->
            </div>
            <!-- //form_wrap -->            
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



