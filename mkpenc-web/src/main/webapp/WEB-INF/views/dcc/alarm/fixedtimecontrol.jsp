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

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/datetimepicker/jquery.datetimepicker.css" />">
<script type="text/javascript" src="<c:url value="/resources/datetimepicker/jquery.datetimepicker.full.min.js" />" charset="utf-8"></script>

<script src="/resources/html2canvas/html2canvas.min.js"></script>

<script type="text/javascript">
	var timerOn = false;

	var lblCI003Set = [
		'0083','0081','0562','0084','0086','0128','0099','0097','0101','0100','0102','0129','0114','0112','0116','0115','0117','0130',
		'0083','0081','0562','0084','0086','0119','0099','0097','0101','0100','0102','0122','0114','0112','0116','0115','0117','0125'
	];
	
	var lblCI032Set = ['0001','0045','0001','0524','0007','0054','0007','0525','0013','0064','0013','0526'];
	
	var lblCI114Set = [
		'0268','0269','0198','0272','0273','0202','0276','0277','0206','0280','0281','0197','0284','0285','0201','0288','0736','0205',
		'0739','0740','0200','0743','0744','0204','0747','0748','0208','0751','0752','0199','0755','0756','0203','0759','0760','0207'
	];
	
	var lblVal114Set = ['2','6','10','1','5','9','4','8','12','3','7','11'];

	var lblCI118Set = [
		'0223','0224','0225','0220','0221','0222','0231','0232','0233','0234','0235','0236','0237','0238','0239','0240','0241','0242',
		'0243','0244','0245','0246','0247','0248','0249','0250','0251','0252','0253','0254','0255','0256','0257','0258','0259','0260',
		'0261','0262','0577','0578','0579','0580','0581','0582','0583','0584','0585','0847','0848','0849','0861','0862','0890','0864',
		'0865','0866','0867','0868','0869','0870','0871','0872','0873','0874','0875','0876','0877','0878','0879','0880','0881','0882',
		'1482','1496','1690','1692','1499','1500','1787','1791','1551','1678','1830','1839'
	];

	var lblTitle118Set = [
		'-','-','-','-','-','-','1','2','3','4','5','6','7','8','9','10','11','12',
		'13','14','15','16','17','18','19','20','21','22','24','29','30','31','32','33','34','35',
		'36','37','38','39','40','41','42','43','44','45','46','47','48','49','54','55','56','57',
		'58','59','60','61','62','63','64','65','66','67','68','69','70','71','72','73','74','75',
		'81','82','83','84','85','86','87','88','91','92','93','94'
	];
	
	var lblBigo118Const = ['CH N Actv HI','CH P Actv HI','CH Q Actv HI','CH N Prs HI','CH P Prs HI','CH Q Prs HI'];
	
	var lblTitle276Set = ['2','6','10','1','5','9','4','8','12','3','7','11'];
	
	var lblCI276Set = [
		'0268','0198','0272','0202','0276','0206','0280','0197','0284','0201','0288','0205',
		'0739','0200','0743','0204','0747','0208','0751','0199','0755','0203','0759','0207'
	];
	
	var lblLoopSet = [
		'LOOP#1 (#4/1)','LOOP#2 (#2/3)','LOOP#3 (#8/5)','LOOP#4 (#6/7)','LOOP#1 (#4/1)','LOOP#2 (#2/3)',
		'LOOP#3 (#8/5)','LOOP#4 (#6/7)','LOOP#1 (#4/1)','LOOP#2 (#2/3)','LOOP#3 (#8/5)','LOOP#4 (#6/7)'
	];
	
	var lblCIChSet = [
		'2118','0491','2119','0491','2120','0491','2121','0491','2159','0503','2160','0503',
		'2161','0503','2162','0503','2200','0561','2201','0561','2202','0561','2203','0561'
	];
	
	var lblMOISet = ['2418','2419','2420'];
	var lblLRFSet = ['2421','2422','2423','2424','2425','2426'];
	//var lblRelay3Set = ['설비번호:10368812','설비번호:10368814','설비번호:10368805','설비번호:10368807','설비번호:10368813','설비번호:10368815'];
	//var lblRelay4Set = ['설비번호:10419230','설비번호:10419232','설비번호:10419223','설비번호:10419225','설비번호:10419231','설비번호:10419233'];
	var lblRelay3Set = ['63432-RL-514K','63432-RL-515K','63432-RL-511L','63432-RL-512L','63432-RL-514M','63432-RL-515M'];
	var lblRelay4Set = ['63432-RL-514K','63432-RL-515K','63432-RL-511L','63432-RL-512L','63432-RL-514M','63432-RL-515M'];
	
	var lblTitle550Set = [];
	var mValue = [];
	
	function setConst(list) {
		var type = list.split(',');
		
		for( var i=0;i<type.length;i++ ) {
			if( type[i] == '003' ) {
				for( var ti=0;ti<36;ti++ ) {
					$("#"+ti+"lblCI003").text("CI "+lblCI003Set[ti]);
					if( ti%6 == 5 ) $("#"+ti+"lblCI003").css("color","red");
				}
			} else if( type[i] == '032' ) {
				for( var ti=0;ti<12;ti++ ) {
					$("#"+ti+"lblCI032").text("CI "+lblCI032Set[ti]);
				}
			} else if( type[i] == '114' ) {
				for( var ti=0;ti<12;ti++ ) {
					$("#"+ti+"lblVal").text("3431-PV"+lblVal114Set[ti]);
				}
				
				for( var ti=0;ti<36;ti++ ) {
					$("#"+ti+"lblCI").text("CI "+lblCI114Set[ti]);
				}
			} else if( type[i] == '118' ) {
				for( var ti=0;ti<72;ti++ ) {
					if( ti < 6 ) {
						$("#"+ti+"lblTitle118").text(lblTitle118Set[ti]);
					} else {
						$("#"+ti+"lblTitle118").text("7314-PV "+lblTitle118Set[ti]);
					}
				}
				for( var ti=72;ti<84;ti++ ) {
					$("#"+ti+"lblTitle118").text("SV"+lblTitle118Set[ti]);
				}

				for( var ti=0;ti<84;ti++ ) {
					$("#"+ti+"lblCI118").text("CI "+lblCI118Set[ti]);
				}

				for( var ti=0;ti<6;ti++ ) {
					$("#"+ti+"lblBigo118").text(lblBigo118Const[ti]);
				}
			} else if( type[i] == '276' ) {
				for( var ti=0;ti<12;ti++ ) {
					$("#"+ti+"lblTitle276").text("3431-PV"+lblTitle276Set[ti]);
				}

				for( var ti=0;ti<24;ti++ ) {
					$("#"+ti+"lblCI276").text("CI "+lblCI276Set[ti]);
				}
			} else if( type[i] == '550' ) {
				for( var ti=0;ti<10;ti++ ) {
					$("#"+ti+"lblTitle550").text(lblTitle550Set[ti]);
				}
			} else if( type[i] == 'cor' ) {
				for( var ti=0;ti<12;ti++ ) {
					$("#"+ti+"lblLoop").text(lblLoopSet[ti]);
					$("#"+ti+"lblLoopDescr").text(lblLoopSet[ti].substring(0,6)+" 노심 저차압 지연시간");
				}

				for( var ti=0;ti<24;ti++ ) {
					$("#"+ti+"lblCICh").text("CI "+lblCIChSet[ti]);
				}
			} else if( type[i] == '285' ) {
				for( var ti=0;ti<6;ti++ ) {
					if( ti%2 == 0 ) $("#"+ti/2+"lblMOI").text("CI "+lblMOISet[ti/2]);
					$("#"+ti+"lblLRF").text("CI "+lblLRFSet[ti]);
					
					if( $("input:radio[id='4']").is(":checked") ) {
						$("#"+ti+"lblRelay").text(lblRelay4Set[ti]);
					} else {
						$("#"+ti+"lblRelay").text(lblRelay3Set[ti]);
					}
				}
			} else {
				// do nothing
			}
		}
	}
	
	function setValveVal(valVal) {
		lblTitle550Set.length = 0;
		mValue.length = 0;
		
		if( valVal == '3431-PV1' ) {
			lblTitle550Set.splice(0,0,'197(A)','281(A)','280(A)','281(A)','280(N)','197(N)','CI 280(A) 발생시간','CI 281(A) 발생시간','CI 280(N) 발생시간','CI 197(N) 발생시간');
			mValue.splice(0,0,'A-197','A-281','A-280','A-281','N-280','N-197');
		} else if( valVal == '3431-PV2' ) {
    		lblTitle550Set.splice(0,0,'198(A)','269(A)','268(A)','269(A)','268(N)','198(A)','CI 268(A) 발생시간','CI 269(A) 발생시간','CI 268(N) 발생시간','CI 198(N) 발생시간');
	        mValue.splice(0,0,'A-198','A-269','A-268','A-269','N-268','N-198');
		} else if( valVal == '3431-PV3' ) {
			lblTitle550Set.splice(0,0,'199(A)','752(A)','751(A)','752(A)','751(N)','199(N)','CI 751(A) 발생시간','CI 752(A) 발생시간','CI 751(N) 발생시간','CI 199(N) 발생시간');
			mValue.splice(0,0,'A-199','A-752','A-751','A-752','N-751','N-199');
		} else if( valVal == '3431-PV4' ) {
			lblTitle550Set.splice(0,0,'200(A)','740(A)','739(A)','740(A)','739(N)','200(N)','CI 739(A) 발생시간','CI 740(A) 발생시간','CI 739(N) 발생시간','CI 200(N) 발생시간');
			mValue.splice(0,0,'A-200','A-740','A-739','A-740','N-739','N-200');
		} else if( valVal == '3431-PV5' ) {
			lblTitle550Set.splice(0,0,'201(A)','285(A)','284(A)','285(A)','284(N)','201(N)','CI 284(A) 발생시간','CI 285(A) 발생시간','CI 284(N) 발생시간','CI 201(N) 발생시간');
			mValue.splice(0,0,'A-201','A-285','A-284','A-285','N-284','N-201');
		} else if( valVal == '3431-PV6' ) {
			lblTitle550Set.splice(0,0,'202(A)','273(A)','272(A)','273(A)','272(N)','202(N)','CI 272(A) 발생시간','CI 273(A) 발생시간','CI 272(N) 발생시간','CI 202(N) 발생시간');
			mValue.splice(0,0,'A-202','A-273','A-272','A-273','N-272','N-202');
		} else if( valVal == '3431-PV7' ) {
			lblTitle550Set.splice(0,0,'203(A)','756(A)','755(A)','756(A)','755(N)','204(N)','CI 755(A) 발생시간','CI 756(A) 발생시간','CI 755(N) 발생시간','CI 203(N) 발생시간');
			mValue.splice(0,0,'A-203','A-756','A-755','A-756','N-755','N-203');
		} else if( valVal == '3431-PV8' ) {
			lblTitle550Set.splice(0,0,'204(A)','744(A)','743(A)','744(A)','743(N)','204(N)','CI 743(A) 발생시간','CI 744(A) 발생시간','CI 743(N) 발생시간','CI 204(N) 발생시간');
			mValue.splice(0,0,'A-204','A-744','A-743','A-744','N-743','N-204');
		} else if( valVal == '3431-PV9' ) {
			lblTitle550Set.splice(0,0,'205(A)','736(A)','288(A)','736(A)','288(N)','205(N)','CI 288(A) 발생시간','CI 736(A) 발생시간','CI 288(N) 발생시간','CI 205(N) 발생시간');
			mValue.splice(0,0,'A-205','A-736','A-288','A-736','N-288','N-205');
		} else if( valVal == '3431-PV10' ) {
			lblTitle550Set.splice(0,0,'206(A)','277(A)','276(A)','277(A)','276(N)','206(N)','CI 276(A) 발생시간','CI 277(A) 발생시간','CI 276(N) 발생시간','CI 206(N) 발생시간');
			mValue.splice(0,0,'A-206','A-277','A-276','A-277','N-276','N-206');
		} else if( valVal == '3431-PV11' ) {
			lblTitle550Set.splice(0,0,'207(A)','760(A)','759(A)','760(A)','759(N)','207(N)','CI 759(A) 발생시간','CI 760(A) 발생시간','CI 759(N) 발생시간','CI 207(N) 발생시간');
			mValue.splice(0,0,'A-207','A-760','A-759','A-760','N-759','N-207');
		} else if( valVal == '3431-PV12' ) {
			lblTitle550Set.splice(0,0,'208(A)','748(A)','747(A)','748(A)','747(N)','208(N)','CI 747(A) 발생시간','CI 748(A) 발생시간','CI 747(N) 발생시간','CI 208(N) 발생시간');
			mValue.splice(0,0,'A-208','A-748','A-747','A-748','N-747','N-208');
		}
	}
	
	$(function() {
		
		$("#lblDate").text('${UserInfo.hogi} ' + ' ${UserInfo.xyGubun}' + ' ${BaseSearch.endDate}' );
		var diff = new Date().getTime() - new Date('${BaseSearch.endDate}').getTime();
		if( diff / 1800000 > 1 ) {
			$("#lblDate").css('color','#e85516');
		} else {
			$("#lblDate").css('color','#05c8be');
		}
		
		var sDtm,eDtm,eDate,eHour,eMin;
		if( isNull('${BaseSearch.startDate}') && !isNull('${BaseSearch.endDate}') ) {
			eDate = '${BaseSearch.endDate}'.split(' ')[0];
			eHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			eMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			eDtm = new Date(eDate.split('-')[0]*1, eDate.split('-')[1]*1, eDate.split('-')[2]*1);
			sDtm = new Date(eDtm.setDate(eDtm.getDate()-3));
			$("#selectSDate").val(sDtm.getFullYear()+'-'+convNum(sDtm.getMonth()+1,2)+'-'+convNum(sDtm.getDate(),3)+' '+convNum(eHour,0)+':'+convNum(eMin,1));
			$("#selectEDate").val(eDate+' '+convNum(eHour,0)+':'+convNum(eMin,1));
		} else if( !isNull('${BaseSearch.startDate}') && isNull('${BaseSearch.endDate}') ) {
			sDate = '${BaseSearch.endDate}'.split(' ')[0];
			sHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			sMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			sDtm = new Date(eDate.split('-')[0]*1, eDate.split('-')[1]*1, eDate.split('-')[2]*1);
			eDtm = new Date(sDtm.setDate(sDtm.getDate()+3));
			$("#selectSDate").val(sDate+' '+convNum(sHour,0)+':'+convNum(sMin,1));
			$("#selectEDate").val(eDtm.getFullYear()+'-'+convNum(eDtm.getMonth()+1,2)+'-'+convNum(eDtm.getDate(),3)+' '+convNum(eHour,0)+':'+convNum(eMin,1));
			$("#selectEHour").val(convNum(sHour,0));
			$("#selectEMinute").val(convNum(sMin,1));
		} else if( !isNull('${BaseSearch.startDate}') && !isNull('${BaseSearch.endDate}') ) {
			sDate = '${BaseSearch.startDate}'.split(' ')[0];
			sHour = '${BaseSearch.startDate}'.split(' ')[1].split(':')[0];
			sMin = '${BaseSearch.startDate}'.split(' ')[1].split(':')[1];
			eDate = '${BaseSearch.endDate}'.split(' ')[0];
			eHour = '${BaseSearch.endDate}'.split(' ')[1].split(':')[0];
			eMin = '${BaseSearch.endDate}'.split(' ')[1].split(':')[1];
			$("#selectSDate").val(sDate+' '+convNum(sHour,0)+':'+convNum(sMin,1));
			$("#selectEDate").val(eDate+' '+convNum(eHour,0)+':'+convNum(eMin,1));
		} else {
			var eDtm = new Date();
			var sDtm = new Date();
			sDtm = new Date(sDtm.setDate(sDtm.getDate()-3));
			$("#selectSDate").val(sDtm.getFullYear()+'-'+convNum(sDtm.getMonth()+1,2)+'-'+convNum(sDtm.getDate(),3)+' '+convNum(sDtm.getHours(),0)+':'+convNum(sDtm.getMinutes(),1));
			$("#selectEDate").val(eDtm.getFullYear()+'-'+convNum(eDtm.getMonth()+1,2)+'-'+convNum(eDtm.getDate(),3)+' '+convNum(eDtm.getHours(),0)+':'+convNum(eDtm.getMinutes(),1));
		}
		
		$("#cboUGrpName").val('0');
		
		setConst('003,032,114,118,276,550,cor,285');
		setValveVal(typeof $("#selectValveOpt option:selected").val() == 'undefined' ? "3431-PV2" : $("#selectValveOpt option:selected").val());

		jQuery.datetimepicker.setLocale('ko');
		
		$('#selectSDate').datetimepicker(DatetimepickerDefaults({}));
		$('#selectEDate').datetimepicker(DatetimepickerDefaults({}));
		
		$(document.body).delegate('#fixedSearch', 'click', function() {
			for( var i=1;i<21;i++ ) {
				$("#loading"+i).css("backgroundColor","rgb(255, 255, 255)");
			}
			openModal('modal_loading');
			
			sleep(100).then(() => callBody($("#cboUGrpName option:selected").val()));
		});
		
		$(document.body).delegate('#fixedSearch', 'blur', function() {
			//closeModal('modal_loading');
			//callBody($("#cboUGrpName option:selected").val());
		});
		
		$("#selectValveOpt").change(function() {
			var valVal = $("#selectValveOpt option:selected").val();
			
			setValveVal(valVal);
			setConst('550');
		});
		
		$("#cboUGrpName").change(function () {
			//alert($("#cboUGrpName option:selected").val());
			
			var uGrpName = $("#cboUGrpName option:selected").val();
			
			if( uGrpName == '0' ) {
				$("#jung003").css("display","");
				$("#jung032").css("display","none");
				$("#jung114").css("display","none");
				$("#jung118").css("display","none");
				$("#jung276").css("display","none");
				$("#jung550").css("display","none");
				$("#jungCore").css("display","none");
				$("#jung28500").css("display","none");
				$("#selectValveOpt").css("display","none");
				$("#selectValveOptBuffer").css("display","");
			} else if( uGrpName == '1' ) {
				$("#jung003").css("display","none");
				$("#jung032").css("display","");
				$("#jung114").css("display","none");
				$("#jung118").css("display","none");
				$("#jung276").css("display","none");
				$("#jung550").css("display","none");
				$("#jungCore").css("display","none");
				$("#jung28500").css("display","none");
				$("#selectValveOpt").css("display","none");
				$("#selectValveOptBuffer").css("display","");
			} else if( uGrpName == '2' ) {
				$("#jung003").css("display","none");
				$("#jung032").css("display","none");
				$("#jung114").css("display","");
				$("#jung118").css("display","none");
				$("#jung276").css("display","none");
				$("#jung550").css("display","none");
				$("#jungCore").css("display","none");
				$("#jung28500").css("display","none");
				$("#selectValveOpt").css("display","none");
				$("#selectValveOptBuffer").css("display","");
			} else if( uGrpName == '3' ) {
				$("#jung003").css("display","none");
				$("#jung032").css("display","none");
				$("#jung114").css("display","none");
				$("#jung118").css("display","");
				$("#jung276").css("display","none");
				$("#jung550").css("display","none");
				$("#jungCore").css("display","none");
				$("#jung28500").css("display","none");
				$("#selectValveOpt").css("display","none");
				$("#selectValveOptBuffer").css("display","");
			} else if( uGrpName == '4' ) {
				$("#jung003").css("display","none");
				$("#jung032").css("display","none");
				$("#jung114").css("display","none");
				$("#jung118").css("display","none");
				$("#jung276").css("display","");
				$("#jung550").css("display","none");
				$("#jungCore").css("display","none");
				$("#jung28500").css("display","none");
				$("#selectValveOpt").css("display","none");
				$("#selectValveOptBuffer").css("display","");
			} else if( uGrpName == '5' ) {
				$("#jung003").css("display","none");
				$("#jung032").css("display","none");
				$("#jung114").css("display","none");
				$("#jung118").css("display","none");
				$("#jung276").css("display","none");
				$("#jung550").css("display","");
				$("#jungCore").css("display","none");
				$("#jung28500").css("display","none");
				$("#selectValveOpt").css("display","");
				$("#selectValveOptBuffer").css("display","none");
				
				if( typeof $("#selectValveOpt option:selected").val() == 'undefined' ) $("#selectValveOpt").val("3431-PV2");
				
				setValveVal($("#selectValveOpt option:selected").val());
				setConst('550');
			} else if( uGrpName == '6' ) {
				$("#jung003").css("display","none");
				$("#jung032").css("display","none");
				$("#jung114").css("display","none");
				$("#jung118").css("display","none");
				$("#jung276").css("display","none");
				$("#jung550").css("display","none");
				$("#jungCore").css("display","");
				$("#jung28500").css("display","none");
				$("#selectValveOpt").css("display","none");
				$("#selectValveOptBuffer").css("display","");
			} else if( uGrpName == '7' ) {
				$("#jung003").css("display","none");
				$("#jung032").css("display","none");
				$("#jung114").css("display","none");
				$("#jung118").css("display","none");
				$("#jung276").css("display","none");
				$("#jung550").css("display","none");
				$("#jungCore").css("display","none");
				$("#jung28500").css("display","");
				$("#selectValveOpt").css("display","none");
				$("#selectValveOptBuffer").css("display","");
			}
		});

	});
	
	function setTimer(num){
		var uGrpName = $("#cboUGrpName option:selected").val();
		
		callBody(typeof uGrpName == 'undefined' ? '0' : uGrpName);
	}
	

	function DatetimepickerDefaults(opts) {
	    return $.extend({},{
	    format:'Y-m-d H:i:00',
		formatTime:'H:i:00',
	    formatDate:'Y-m-d',
		step : 1,
		monthChangeSpinner:true,
	    sideBySide: true
	    
	    }, opts);
	}
	
	function convNum(num,type) {
		var tmp = num*1;
		if( type == 0 ) {
			if( tmp > 23 ) tmp = tmp - 24;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		} else if( type == 1 ) {
			if( tmp > 59 ) tmp = tmp - 60;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		} else if( type == 2 ) {
			if( tmp > 12 ) tmp = tmp - 12;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		} else if( type == 3 ) {
			if( tmp > 31 ) tmp = tmp - 31;
			if( tmp < 10 ) {
				num = '0'+tmp;
			}
		}
		return num;
	}
	
	function isNull(str) {
		if( str == null || str == '' || str == 'undefined' ) {
			return true;
		} else {
			return false;
		}
	}
	
	function callBody(uGrpName) {
		$("#reloadForm").empty();
//alert(uGrpName);

		function callPart() {
			return new Promise(function(resolve,reject) {
				var startDate = $("#selectSDate").val()+':00.000';
				var endDate = $("#selectEDate").val()+':00.000';
				
				var pType = '';
				var address = '';
				var alarmGubun = '';
				var title = '';
				
				var comAjax = new ComAjax("reloadForm");
				comAjax.setUrl("/dcc/alarm/reloadFTC");
				comAjax.addParam("startDate", startDate);
				comAjax.addParam("endDate", endDate);
				
				if( uGrpName == '0' ) {
					pType = '003';
					
					for( var oi=0;oi<36;oi++ ) {
						if( oi == 0 ) {
							address += $.trim($("#"+oi+"lblCI003").text().substr(-3));
						} else {
							address = address+','+$.trim($("#"+oi+"lblCI003").text().substr(-3));
						}
					}
				} else if( uGrpName == '1' ) {
					pType = '032';
					
					for( var tti=0;tti<12;tti++ ) {
						if( tti == 0 ) {
							address += $.trim($("#"+tti+"lblCI032").text().substr(-3));
						} else {
							address = address+','+$.trim($("#"+tti+"lblCI032").text().substr(-3));
						}
					}
				} else if( uGrpName == '2' ) {
					pType = '114';
		
					for( var fi=0;fi<36;fi++ ) {
						if( fi == 0 ) {
							address += $.trim($("#"+fi+"lblCI").text().substr(-3));
						} else {
							address = address+','+$.trim($("#"+fi+"lblCI").text().substr(-3));
						}
					}
				} else if( uGrpName == '3' ) {
					pType = '118';
					
					for( var ei=0;ei<84;ei++ ) {
						if( ei == 0 ) {
							title += $.trim($("#"+ei+"lblTitle118").text());
							address += $.trim($("#"+ei+"lblCI118").text().substr(-3));
						} else if( ei < 72 ) {
							title = title+','+$.trim($("#"+ei+"lblTitle118").text());
							address = address+','+$.trim($("#"+ei+"lblCI118").text().substr(-3));
						} else {
							title = title+','+$.trim($("#"+ei+"lblTitle118").text());
							address = address+','+$.trim($("#"+ei+"lblCI118").text().substr(-4));
						}
					}
					comAjax.addParam("title", title);
				} else if( uGrpName == '4' ) {
					pType = '276';
		
					for( var ai=0;ai<24;ai++ ) {
						if( ai == 0 ) {
							address += $.trim($("#"+ai+"lblCI276").text().substr(-3));
						} else {
							address = address+','+$.trim($("#"+ai+"lblCI276").text().substr(-3));
						}
					}
				} else if( uGrpName == '5' ) {
					pType = '550';
					
					for( var m=0;m<mValue.length;m++ ) {
						if( m == 0 ) {
							alarmGubun += $.trim(mValue[m].split('-')[0]);
							address += $.trim(mValue[m].split('-')[1]);
						} else {
							alarmGubun = alarmGubun+','+$.trim(mValue[m].split('-')[0]);
							address = address+','+$.trim(mValue[m].split('-')[1]);
						}
					}
					comAjax.addParam("alarmGubun", alarmGubun);
				} else if( uGrpName == '6' ) {
					pType = 'cor';
		
					for( var si=0;si<24;si++ ) {
						if( si == 0 ) {
							address += $.trim($("#"+si+"lblCICh").text().substr(-4));
						} else {
							address = address+','+$.trim($("#"+si+"lblCICh").text().substr(-4));
						}
					}
				} else if( uGrpName == '7' ) {
					pType = '285';
					
					var moi = ''
					var lrf = '';
					for( var ssi=0;ssi<3;ssi++ ) {
						moi += $("#"+ssi+"lblMOI").text().substr(-4);
						if( ssi < 2 ) moi += ',';
					}
					for( var l=0;l<6;l++ ) {
						lrf += $("#"+l+"lblLRF").text().substr(-4);
						if( l < 5 ) lrf += ',';
					}
					
					address = moi+"|"+lrf;
				}
				comAjax.addParam("address", address);
				comAjax.addParam("pType", pType);
				comAjax.setCallback("mbr_FixedTimeControlCallback");
				comAjax.ajax();
				
				setConst(pType);
				
				setTimeout(function() {
					resolve();
				},500);
			});
		}
		
		callPart().then(function() {
			closeModal('modal_loading');
		});
	}
	
	function toCSV() {
		$("#reloadForm").empty();
		var uGrpName = $("#cboUGrpName option:selected").val();
		if( typeof uGrpName == 'undefined' ) uGrpName = '0';
		
		var startDate = $("#selectSDate").val()+':00.000';
		var endDate = $("#selectEDate").val()+':00.000';
		
		var pType = '';
		var address = '';
		var alarmGubun = '';
		var title = '';
		var loop = '';
		var ci = '';
		
		var comSubmit = new ComSubmit("reloadForm");
		comSubmit.setUrl("/dcc/alarm/fixedExcelExport");
		comSubmit.addParam("startDate", startDate);
		comSubmit.addParam("endDate", endDate);
		
		if( uGrpName == '0' ) {
			pType = '003';
			
			for( var oi=0;oi<36;oi++ ) {
				if( oi == 0 ) {
					title += $.trim($("#"+(oi/6)+"lblTitle003").text());
					address += $.trim($("#"+oi+"lblCI003").text().substr(-3));
					ci += $.trim($("#"+oi+"lblCI003").text());
				} else {
					if( oi%6 == 0 ) {
						title = title+','+$.trim($("#"+(oi/6)+"lblTitle003").text());
					}
					address = address+','+$.trim($("#"+oi+"lblCI003").text().substr(-3));
					ci = ci+','+$.trim($("#"+oi+"lblCI003").text());
				}
			}
		} else if( uGrpName == '1' ) {
			pType = '032';
			
			for( var tti=0;tti<12;tti++ ) {
				if( tti == 0 ) {
					title += $.trim($("#"+(tti/4)+"lblTitle032").text());
					address += $.trim($("#"+tti+"lblCI032").text().substr(-3));
					ci += $.trim($("#"+tti+"lblCI032").text());
				} else {
					if( tti%4 == 0 ) {
						title = title+','+$.trim($("#"+(tti/4)+"lblTitle032").text());
					}
					address = address+','+$.trim($("#"+tti+"lblCI032").text().substr(-3));
					ci = ci+','+$.trim($("#"+tti+"lblCI032").text());
				}
			}
		} else if( uGrpName == '2' ) {
			pType = '114';

			for( var fi=0;fi<36;fi++ ) {
				if( fi == 0 ) {
					title += $.trim($("#"+(fi/3)+"lblVal").text());
					address += $.trim($("#"+fi+"lblCI").text().substr(-3));
					ci += $.trim($("#"+fi+"lblCI").text());
				} else {
					if( fi%3 == 0 ) {
						title = title+','+$.trim($("#"+(fi/3)+"lblVal").text());
					}
					address = address+','+$.trim($("#"+fi+"lblCI").text().substr(-3));
					ci = ci+','+$.trim($("#"+fi+"lblCI").text());
				}
			}
		} else if( uGrpName == '3' ) {
			pType = '118';
			
			for( var ei=0;ei<84;ei++ ) {
				if( ei == 0 ) {
					title += $.trim($("#"+ei+"lblTitle118").text());
					address += $.trim($("#"+ei+"lblCI118").text().substr(-3));
					ci += $.trim($("#"+ei+"lblCI118").text());
				} else if( ei < 72 ) {
					title = title+','+$.trim($("#"+ei+"lblTitle118").text());
					address = address+','+$.trim($("#"+ei+"lblCI118").text().substr(-3));
					ci = ci+','+$.trim($("#"+ei+"lblCI118").text());
				} else {
					title = title+','+$.trim($("#"+ei+"lblTitle118").text());
					address = address+','+$.trim($("#"+ei+"lblCI118").text().substr(-4));
					ci = ci+','+$.trim($("#"+ei+"lblCI118").text());
				}
			}
		} else if( uGrpName == '4' ) {
			pType = '276';

			for( var ai=0;ai<24;ai++ ) {
				if( ai == 0 ) {
					title += $.trim($("#"+(ai/2)+"lblTitle276").text());
					address += $.trim($("#"+ai+"lblCI276").text().substr(-3));
					ci += $.trim($("#"+ai+"lblCI276").text());
				} else {
					if( ai%2 == 0) {
						title = title+','+$.trim($("#"+(ai/2)+"lblTitle276").text());
					}
					address = address+','+$.trim($("#"+ai+"lblCI276").text().substr(-3));
					ci = ci+','+$.trim($("#"+ai+"lblCI276").text());
				}
			}
		} else if( uGrpName == '5' ) {
			// 550 do nothing
		} else if( uGrpName == '6' ) {
			pType = 'cor';

			for( var si=0;si<24;si++ ) {
				if( si == 0 ) {
					title += $.trim($("#"+(si/8)+"lblTitleCha").text());
					loop += $.trim($("#"+(si/2)+"lblLoop").text())+'|'+$.trim($("#"+(si/2)+"lblLoopDescr").text());
					address += $.trim($("#"+si+"lblCICh").text().substr(-4));
					ci += $.trim($("#"+si+"lblCICh").text());
				} else {
					if( si%8 == 0 ) {
						title = title+','+$.trim($("#"+(si/8)+"lblTitleCha").text());
					}
					if( si%2 == 0 ) {
						loop = loop+','+$.trim($("#"+(si/2)+"lblLoop").text())+'|'+$.trim($("#"+(si/2)+"lblLoopDescr").text());
					}
					address = address+','+$.trim($("#"+si+"lblCICh").text().substr(-4));
					ci = ci+','+$.trim($("#"+si+"lblCICh").text());
				}
			}

			comSubmit.addParam("loop", loop);
		} else if( uGrpName == '7' ) {
			// 28500F do nothing
		}
		comSubmit.addParam("address", address);
		comSubmit.addParam("title", title);
		comSubmit.addParam("ci", ci);
		comSubmit.addParam("pType", pType);
		if( uGrpName != '5' && uGrpName != '7' ) {
			comSubmit.submit();
		} else {
			//alert($("#cboUGrpName option:selected").text()+' 은(는) 엑셀 다운로드를 지원하지 않습니다.');
		}
	}
	
	function toIMG() {
	 	//timerOn = false;
		
		function doModal() {
			return new Promise(function(resolve,reject) {
				openModal('modal_loading');
				closeLayer('mouse_area');
				
				setTimeout(function() {
					resolve();
				},500);
			});
		}
		
		var filename = '정주기시험보조자료 ('+$("#cboUGrpName option:selected").text()+').jpg';
		
		doModal().then(function() {
			html2canvas($("#captureArea")[0]).then(canvas => {
				//saveAs(canvas.toDataURL('image/jpg'),"lime.jpg"); //다운로드 되는 이미지 파일 이름 지정
				saveAs(canvas.toDataURL(),filename); //다운로드 되는 이미지 파일 이름 지정
			});
			//timerOn = true;
		});
	}
	
	function saveAs(uri, filename) {
		// 캡처된 파일을 이미지 파일로 내보냄
		var link = document.createElement('a');
		if (typeof link.download === 'string') {
			link.href = uri;
			link.download = filename;
			document.body.appendChild(link);
			link.click();
			document.body.removeChild(link);
			closeModal('modal_loading');
		} else {
			window.open(uri);
		}
	}
	
	function openModal(str) {
		//if( str == 'modal_loading' ) {
			/*openLayer(str);
			
			progressPos = Math.floor(Math.random()*3)+6;
			//sleep(200).then(function() {
				fillProgress(1,progressPos);
			//});
			sleep(100).then(() => fillProgress(progressPos,progressPos+4));
			sleep(100).then(() => fillProgress(progressPos+4,progressPos+7));
			sleep(100).then(() => fillProgress(progressPos+7,21));*/
			$("#modal_loading").css("display","");
		//}
	}
	
	function closeModal(str) {
		$("#"+str).css("display","none");
	}
	
	function sleep(ms) {
		return new Promise((r) => setTimeout(r,ms));
	}
	
	function fillProgress(i,limit) {
		while( i < limit ) {
			$("#loading"+i).css("background-color","#2e5ce0");
			i++;
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
		<div id="captureArea" class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>정주기 시험 보조자료</h3>
				<div class="bc"><span>DCC</span><span>Alarm</span><strong>정주기 시험 보조자료</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">
			<form id="reloadForm"></form>
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>구분</label>
							<select id="cboUGrpName">
								<option value="0">정기-003</option>
								<option value="1">정기-032</option>
								<option value="2">정기-114</option>
								<option value="3">정기-118</option>
								<option value="4">정기-276</option>
								<option value="5">주기-550</option>
								<option value="6">노심저차압</option>
								<option value="7">정기-28500F</option>
							</select>
						</div>
						<div id="selectValveOpt" class="fx_srch_item" style="display:none">
							<label>관련밸브</label>
							<select id="cboValve">			
								<option value="3431-PV1">3431-PV1</option>
								<option value="3431-PV2" selected>3431-PV2</option>
								<option value="3431-PV3">3431-PV3</option>
								<option value="3431-PV4">3431-PV4</option>
								<option value="3431-PV5">3431-PV5</option>
								<option value="3431-PV6">3431-PV6</option>
								<option value="3431-PV7">3431-PV7</option>
								<option value="3431-PV8">3431-PV8</option>
								<option value="3431-PV9">3431-PV9</option>
								<option value="3431-PV10">3431-PV10</option>
								<option value="3431-PV11">3431-PV11</option>
								<option value="3431-PV12">3431-PV12</option>
							</select>
						</div>
						<div id="selectValveOptBuffer" class="fx_srch_item"></div>
						<div class="fx_srch_item">
							<label>검색기간</label>
                            <div class="fx_form_multi">
                                <div class="fx_form">
                                    <input type="text" id="selectSDate" name="selectSDate" readonly>
                                	<label>~</label>
                                    <input type="text" id="selectEDate" name="selectEDate" readonly>
                                </div>
                            </div>
						</div>
						<div class="fx_srch_item"></div>
                    </div>
				</div>
				<!-- fx_srch_button -->
				<div class="fx_srch_button">
					<a id="fixedSearch" class="btn_srch">Search</a>
				</div>
				<!-- //fx_srch_button -->
			</div>
			<!-- //fx_srch_wrap -->
            <!-- list_wrap -->
            <div class="list_wrap">
				<!-- list_head -->
				<div class="list_head">
					<!-- button -->
					<div class="button">
						<a class="btn_list primary" href="#none" onclick="javascript:toCSV();">저장</a>
						<a class="btn_list" href="#none" onclick="javascript:toIMG();">화면저장</a>
					</div>
					<!-- button -->
				</div>
				<!-- //list_head -->
            </div>
             <!-- //list_wrap -->
            <!-- fx_layout -->
            <div id="jung003" class="fx_layout">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>소거시간</th>
                                    <th>값</th>
                                </tr>
                            </thead>
                            <tbody id="003Body1">
                                <tr>
                                    <td id="0lblTitle003" class="tc" rowspan="6">채널 "G"</td>
                                    <td id="0lblCI003" class="tc"></td>
                                    <td id="0lblStart003" class="tc"></td>
                                    <td id="0lblEnd003" class="tc"></td>
                                    <td id="0lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblCI003" class="tc"></td>
                                    <td id="1lblStart003" class="tc"></td>
                                    <td id="1lblEnd003" class="tc"></td>
                                    <td id="1lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="2lblCI003" class="tc"></td>
                                    <td id="2lblStart003" class="tc"></td>
                                    <td id="2lblEnd003" class="tc"></td>
                                    <td id="2lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="3lblCI003" class="tc"></td>
                                    <td id="3lblStart003" class="tc"></td>
                                    <td id="3lblEnd003" class="tc"></td>
                                    <td id="3lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="4lblCI003" class="tc"></td>
                                    <td id="4lblStart003" class="tc"></td>
                                    <td id="4lblEnd003" class="tc"></td>
                                    <td id="4lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblCI003" class="tc"></td>
                                    <td id="5lblStart003" class="tc"></td>
                                    <td id="5lblEnd003" class="tc"></td>
                                    <td id="5lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblTitle003" class="tc" rowspan="6">채널 "H"</td>
                                    <td id="6lblCI003" class="tc"></td>
                                    <td id="6lblStart003" class="tc"></td>
                                    <td id="6lblEnd003" class="tc"></td>
                                    <td id="6lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="7lblCI003" class="tc"></td>
                                    <td id="7lblStart003" class="tc"></td>
                                    <td id="7lblEnd003" class="tc"></td>
                                    <td id="7lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="8lblCI003" class="tc"></td>
                                    <td id="8lblStart003" class="tc"></td>
                                    <td id="8lblEnd003" class="tc"></td>
                                    <td id="8lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="9lblCI003" class="tc"></td>
                                    <td id="9lblStart003" class="tc"></td>
                                    <td id="9lblEnd003" class="tc"></td>
                                    <td id="9lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="10lblCI003" class="tc"></td>
                                    <td id="10lblStart003" class="tc"></td>
                                    <td id="10lblEnd003" class="tc"></td>
                                    <td id="10lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="11lblCI003" class="tc"></td>
                                    <td id="11lblStart003" class="tc"></td>
                                    <td id="11lblEnd003" class="tc"></td>
                                    <td id="11lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="2lblTitle003" class="tc" rowspan="6">채널 "J"</td>
                                    <td id="12lblCI003" class="tc"></td>
                                    <td id="12lblStart003" class="tc"></td>
                                    <td id="12lblEnd003" class="tc"></td>
                                    <td id="12lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="13lblCI003" class="tc"></td>
                                    <td id="13lblStart003" class="tc"></td>
                                    <td id="13lblEnd003" class="tc"></td>
                                    <td id="13lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="14lblCI003" class="tc"></td>
                                    <td id="14lblStart003" class="tc"></td>
                                    <td id="14lblEnd003" class="tc"></td>
                                    <td id="14lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="15lblCI003" class="tc"></td>
                                    <td id="15lblStart003" class="tc"></td>
                                    <td id="15lblEnd003" class="tc"></td>
                                    <td id="15lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="16lblCI003" class="tc"></td>
                                    <td id="16lblStart003" class="tc"></td>
                                    <td id="16lblEnd003" class="tc"></td>
                                    <td id="16lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="17lblCI003" class="tc"></td>
                                    <td id="17lblStart003" class="tc"></td>
                                    <td id="17lblEnd003" class="tc"></td>
                                    <td id="17lblCha003" class="tc"></td>
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
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>소거시간</th>
                                    <th>값</th>
                                </tr>
                            </thead>
                            <tbody id="003Body2">
                                <tr>
                                    <td id="3lblTitle003" class="tc" rowspan="6">채널 "G"</td>
                                    <td id="18lblCI003" class="tc"></td>
                                    <td id="18lblStart003" class="tc"></td>
                                    <td id="18lblEnd003" class="tc"></td>
                                    <td id="18lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="19lblCI003" class="tc"></td>
                                    <td id="19lblStart003" class="tc"></td>
                                    <td id="19lblEnd003" class="tc"></td>
                                    <td id="19lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="20lblCI003" class="tc"></td>
                                    <td id="20lblStart003" class="tc"></td>
                                    <td id="20lblEnd003" class="tc"></td>
                                    <td id="20lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="21lblCI003" class="tc"></td>
                                    <td id="21lblStart003" class="tc"></td>
                                    <td id="21lblEnd003" class="tc"></td>
                                    <td id="21lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="22lblCI003" class="tc"></td>
                                    <td id="22lblStart003" class="tc"></td>
                                    <td id="22lblEnd003" class="tc"></td>
                                    <td id="22lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="23lblCI003" class="tc"></td>
                                    <td id="23lblStart003" class="tc"></td>
                                    <td id="23lblEnd003" class="tc"></td>
                                    <td id="23lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="4lblTitle003" class="tc" rowspan="6">채널 "H"</td>
                                    <td id="24lblCI003" class="tc"></td>
                                    <td id="24lblStart003" class="tc"></td>
                                    <td id="24lblEnd003" class="tc"></td>
                                    <td id="24lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="25lblCI003" class="tc"></td>
                                    <td id="25lblStart003" class="tc"></td>
                                    <td id="25lblEnd003" class="tc"></td>
                                    <td id="25lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="26lblCI003" class="tc"></td>
                                    <td id="26lblStart003" class="tc"></td>
                                    <td id="26lblEnd003" class="tc"></td>
                                    <td id="26lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="27lblCI003" class="tc"></td>
                                    <td id="27lblStart003" class="tc"></td>
                                    <td id="27lblEnd003" class="tc"></td>
                                    <td id="27lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="28lblCI003" class="tc"></td>
                                    <td id="28lblStart003" class="tc"></td>
                                    <td id="28lblEnd003" class="tc"></td>
                                    <td id="28lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="29lblCI003" class="tc"></td>
                                    <td id="29lblStart003" class="tc"></td>
                                    <td id="29lblEnd003" class="tc"></td>
                                    <td id="29lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblTitle003" class="tc" rowspan="6">채널 "J"</td>
                                    <td id="30lblCI003" class="tc"></td>
                                    <td id="30lblStart003" class="tc"></td>
                                    <td id="30lblEnd003" class="tc"></td>
                                    <td id="30lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="31lblCI003" class="tc"></td>
                                    <td id="31lblStart003" class="tc"></td>
                                    <td id="31lblEnd003" class="tc"></td>
                                    <td id="31lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="32lblCI003" class="tc"></td>
                                    <td id="32lblStart003" class="tc"></td>
                                    <td id="32lblEnd003" class="tc"></td>
                                    <td id="32lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="33lblCI003" class="tc"></td>
                                    <td id="33lblStart003" class="tc"></td>
                                    <td id="33lblEnd003" class="tc"></td>
                                    <td id="33lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="34lblCI003" class="tc"></td>
                                    <td id="34lblStart003" class="tc"></td>
                                    <td id="34lblEnd003" class="tc"></td>
                                    <td id="34lblCha003" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="35lblCI003" class="tc"></td>
                                    <td id="35lblStart003" class="tc"></td>
                                    <td id="35lblEnd003" class="tc"></td>
                                    <td id="35lblCha003" class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
            </div>
            <div id="jung032" class="fx_layout" style="display:none">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>소거시간</th>
                                    <th>값</th>
                                </tr>
                            </thead>
                            <tbody id="032Body">
                                <tr>
                                    <td id="0lblTitle032" class="tc" rowspan="4">채널 "D"</td>
                                    <td id="0lblCI032" class="tc"></td>
                                    <td id="0lblStart032" class="tc"></td>
                                    <td id="0lblEnd032" class="tc"></td>
                                    <td id="0lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblCI032" class="tc"></td>
                                    <td id="1lblStart032" class="tc"></td>
                                    <td id="1lblEnd032" class="tc"></td>
                                    <td id="1lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="2lblCI032" class="tc"></td>
                                    <td id="2lblStart032" class="tc"></td>
                                    <td id="2lblEnd032" class="tc"></td>
                                    <td id="2lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="3lblCI032" class="tc"></td>
                                    <td id="3lblStart032" class="tc"></td>
                                    <td id="3lblEnd032" class="tc"></td>
                                    <td id="3lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblTitle032" class="tc" rowspan="4">채널 "E"</td>
                                    <td id="4lblCI032" class="tc"></td>
                                    <td id="4lblStart032" class="tc"></td>
                                    <td id="4lblEnd032" class="tc"></td>
                                    <td id="4lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblCI032" class="tc"></td>
                                    <td id="5lblStart032" class="tc"></td>
                                    <td id="5lblEnd032" class="tc"></td>
                                    <td id="5lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="6lblCI032" class="tc"></td>
                                    <td id="6lblStart032" class="tc"></td>
                                    <td id="6lblEnd032" class="tc"></td>
                                    <td id="6lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="7lblCI032" class="tc"></td>
                                    <td id="7lblStart032" class="tc"></td>
                                    <td id="7lblEnd032" class="tc"></td>
                                    <td id="7lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="2lblTitle032" class="tc" rowspan="4">채널 "F"</td>
                                    <td id="8lblCI032" class="tc"></td>
                                    <td id="8lblStart032" class="tc"></td>
                                    <td id="8lblEnd032" class="tc"></td>
                                    <td id="8lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="9lblCI032" class="tc"></td>
                                    <td id="9lblStart032" class="tc"></td>
                                    <td id="9lblEnd032" class="tc"></td>
                                    <td id="9lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="10lblCI032" class="tc"></td>
                                    <td id="10lblStart032" class="tc"></td>
                                    <td id="10lblEnd032" class="tc"></td>
                                    <td id="10lblCha032" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="11lblCI032" class="tc"></td>
                                    <td id="11lblStart032" class="tc"></td>
                                    <td id="11lblEnd032" class="tc"></td>
                                    <td id="11lblCha032" class="tc"></td>
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
                        <table class="list_table"></table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
            </div>
            <div id="jung114" class="fx_layout" style="display:none">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>소거시간</th>
                                    <th>값</th>
                                </tr>
                            </thead>
                            <tbody id="114Body1">
                                <tr>
                                    <td id="0lblVal" class="tc" rowspan="3"></td>
                                    <td id="0lblCI" class="tc"></td>
                                    <td id="0lblStart" class="tc"></td>
                                    <td id="0lblEnd" class="tc"></td>
                                    <td id="0lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblCI" class="tc"></td>
                                    <td id="1lblStart" class="tc"></td>
                                    <td id="1lblEnd" class="tc"></td>
                                    <td id="1lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="2lblCI" class="tc"></td>
                                    <td id="2lblStart" class="tc"></td>
                                    <td id="2lblEnd" class="tc"></td>
                                    <td id="2lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblVal" class="tc" rowspan="3"></td>
                                    <td id="3lblCI" class="tc"></td>
                                    <td id="3lblStart" class="tc"></td>
                                    <td id="3lblEnd" class="tc"></td>
                                    <td id="3lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="4lblCI" class="tc"></td>
                                    <td id="4lblStart" class="tc"></td>
                                    <td id="4lblEnd" class="tc"></td>
                                    <td id="4lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblCI" class="tc"></td>
                                    <td id="5lblStart" class="tc"></td>
                                    <td id="5lblEnd" class="tc"></td>
                                    <td id="5lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="2lblVal" class="tc" rowspan="3"></td>
                                    <td id="6lblCI" class="tc"></td>
                                    <td id="6lblStart" class="tc"></td>
                                    <td id="6lblEnd" class="tc"></td>
                                    <td id="6lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="7lblCI" class="tc"></td>
                                    <td id="7lblStart" class="tc"></td>
                                    <td id="7lblEnd" class="tc"></td>
                                    <td id="7lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="8lblCI" class="tc"></td>
                                    <td id="8lblStart" class="tc"></td>
                                    <td id="8lblEnd" class="tc"></td>
                                    <td id="8lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="3lblVal" class="tc" rowspan="3"></td>
                                    <td id="9lblCI" class="tc"></td>
                                    <td id="9lblStart" class="tc"></td>
                                    <td id="9lblEnd" class="tc"></td>
                                    <td id="9lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="10lblCI" class="tc"></td>
                                    <td id="10lblStart" class="tc"></td>
                                    <td id="10lblEnd" class="tc"></td>
                                    <td id="10lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="11lblCI" class="tc"></td>
                                    <td id="11lblStart" class="tc"></td>
                                    <td id="11lblEnd" class="tc"></td>
                                    <td id="11lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="4lblVal" class="tc" rowspan="3"></td>
                                    <td id="12lblCI" class="tc"></td>
                                    <td id="12lblStart" class="tc"></td>
                                    <td id="12lblEnd" class="tc"></td>
                                    <td id="12lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="13lblCI" class="tc"></td>
                                    <td id="13lblStart" class="tc"></td>
                                    <td id="13lblEnd" class="tc"></td>
                                    <td id="13lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="14lblCI" class="tc"></td>
                                    <td id="14lblStart" class="tc"></td>
                                    <td id="14lblEnd" class="tc"></td>
                                    <td id="14lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblVal" class="tc" rowspan="3"></td>
                                    <td id="15lblCI" class="tc"></td>
                                    <td id="15lblStart" class="tc"></td>
                                    <td id="15lblEnd" class="tc"></td>
                                    <td id="15lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="16lblCI" class="tc"></td>
                                    <td id="16lblStart" class="tc"></td>
                                    <td id="16lblEnd" class="tc"></td>
                                    <td id="16lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="17lblCI" class="tc"></td>
                                    <td id="17blStart" class="tc"></td>
                                    <td id="17lblEnd" class="tc"></td>
                                    <td id="17lblCha" class="tc"></td>
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
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>소거시간</th>
                                    <th>값</th>
                                </tr>
                            </thead>
                            <tbody id="114Body2">
                                <tr>
                                    <td id="6lblVal" class="tc" rowspan="3"></td>
                                    <td id="18lblCI" class="tc"></td>
                                    <td id="18blStart" class="tc"></td>
                                    <td id="18lblEnd" class="tc"></td>
                                    <td id="18lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="19lblCI" class="tc"></td>
                                    <td id="19blStart" class="tc"></td>
                                    <td id="19lblEnd" class="tc"></td>
                                    <td id="19lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="20lblCI" class="tc"></td>
                                    <td id="20blStart" class="tc"></td>
                                    <td id="20lblEnd" class="tc"></td>
                                    <td id="20lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="7lblVal" class="tc" rowspan="3"></td>
                                    <td id="21lblCI" class="tc"></td>
                                    <td id="21lblStart" class="tc"></td>
                                    <td id="21lblEnd" class="tc"></td>
                                    <td id="21lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="22lblCI" class="tc"></td>
                                    <td id="22lblStart" class="tc"></td>
                                    <td id="22lblEnd" class="tc"></td>
                                    <td id="22lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="23lblCI" class="tc"></td>
                                    <td id="23lblStart" class="tc"></td>
                                    <td id="23lblEnd" class="tc"></td>
                                    <td id="23lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="8lblVal" class="tc" rowspan="3"></td>
                                    <td id="24lblCI" class="tc"></td>
                                    <td id="24lblStart" class="tc"></td>
                                    <td id="24lblEnd" class="tc"></td>
                                    <td id="24lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="25lblCI" class="tc"></td>
                                    <td id="25lblStart" class="tc"></td>
                                    <td id="25lblEnd" class="tc"></td>
                                    <td id="25lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="26lblCI" class="tc"></td>
                                    <td id="26lblStart" class="tc"></td>
                                    <td id="26lblEnd" class="tc"></td>
                                    <td id="26lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="9lblVal" class="tc" rowspan="3"></td>
                                    <td id="27lblCI" class="tc"></td>
                                    <td id="27lblStart" class="tc"></td>
                                    <td id="27lblEnd" class="tc"></td>
                                    <td id="27lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="28lblCI" class="tc"></td>
                                    <td id="28lblStart" class="tc"></td>
                                    <td id="28lblEnd" class="tc"></td>
                                    <td id="28lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="29lblCI" class="tc"></td>
                                    <td id="29lblStart" class="tc"></td>
                                    <td id="29lblEnd" class="tc"></td>
                                    <td id="29lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="10lblVal" class="tc" rowspan="3"></td>
                                    <td id="30lblCI" class="tc"></td>
                                    <td id="30lblStart" class="tc"></td>
                                    <td id="30lblEnd" class="tc"></td>
                                    <td id="30lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="31lblCI" class="tc"></td>
                                    <td id="31lblStart" class="tc"></td>
                                    <td id="31lblEnd" class="tc"></td>
                                    <td id="31lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="32lblCI" class="tc"></td>
                                    <td id="32lblStart" class="tc"></td>
                                    <td id="32lblEnd" class="tc"></td>
                                    <td id="32lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="11lblVal" class="tc" rowspan="3"></td>
                                    <td id="33lblCI" class="tc"></td>
                                    <td id="33lblStart" class="tc"></td>
                                    <td id="33lblEnd" class="tc"></td>
                                    <td id="33lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="34lblCI" class="tc"></td>
                                    <td id="34lblStart" class="tc"></td>
                                    <td id="34lblEnd" class="tc"></td>
                                    <td id="34lblCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="35lblCI" class="tc"></td>
                                    <td id="35lblStart" class="tc"></td>
                                    <td id="35lblEnd" class="tc"></td>
                                    <td id="35lblCha" class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
            </div>
            <div id="jung118" class="fx_layout" style="display:none">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>비고</th>
                                </tr>
                            </thead>
                            <tbody id="118Body1">
                                <tr>
                                    <td id="0lblTitle118" class="tc"></td>
                                    <td id="0lblCI118" class="tc"></td>
                                    <td id="0lblStart118" class="tc"></td>
                                    <td id="0lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblTitle118" class="tc"></td>
                                    <td id="1lblCI118" class="tc"></td>
                                    <td id="1lblStart118" class="tc"></td>
                                    <td id="1lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="2lblTitle118" class="tc"></td>
                                    <td id="2lblCI118" class="tc"></td>
                                    <td id="2lblStart118" class="tc"></td>
                                    <td id="2lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="3lblTitle118" class="tc"></td>
                                    <td id="3lblCI118" class="tc"></td>
                                    <td id="3lblStart118" class="tc"></td>
                                    <td id="3lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="4lblTitle118" class="tc"></td>
                                    <td id="4lblCI118" class="tc"></td>
                                    <td id="4lblStart118" class="tc"></td>
                                    <td id="4lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblTitle118" class="tc"></td>
                                    <td id="5lblCI118" class="tc"></td>
                                    <td id="5lblStart118" class="tc"></td>
                                    <td id="5lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="6lblTitle118" class="tc"></td>
                                    <td id="6lblCI118" class="tc"></td>
                                    <td id="6lblStart118" class="tc"></td>
                                    <td id="6lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="7lblTitle118" class="tc"></td>
                                    <td id="7lblCI118" class="tc"></td>
                                    <td id="7lblStart118" class="tc"></td>
                                    <td id="7lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="8lblTitle118" class="tc"></td>
                                    <td id="8lblCI118" class="tc"></td>
                                    <td id="8lblStart118" class="tc"></td>
                                    <td id="8lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="9lblTitle118" class="tc"></td>
                                    <td id="9lblCI118" class="tc"></td>
                                    <td id="9lblStart118" class="tc"></td>
                                    <td id="9lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="10lblTitle118" class="tc"></td>
                                    <td id="10lblCI118" class="tc"></td>
                                    <td id="10lblStart118" class="tc"></td>
                                    <td id="10lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="11lblTitle118" class="tc"></td>
                                    <td id="11lblCI118" class="tc"></td>
                                    <td id="11lblStart118" class="tc"></td>
                                    <td id="11lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="12lblTitle118" class="tc"></td>
                                    <td id="12lblCI118" class="tc"></td>
                                    <td id="12lblStart118" class="tc"></td>
                                    <td id="12lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="13lblTitle118" class="tc"></td>
                                    <td id="13lblCI118" class="tc"></td>
                                    <td id="13lblStart118" class="tc"></td>
                                    <td id="13lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="14lblTitle118" class="tc"></td>
                                    <td id="14lblCI118" class="tc"></td>
                                    <td id="14lblStart118" class="tc"></td>
                                    <td id="14lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="15lblTitle118" class="tc"></td>
                                    <td id="15lblCI118" class="tc"></td>
                                    <td id="15lblStart118" class="tc"></td>
                                    <td id="15lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="16lblTitle118" class="tc"></td>
                                    <td id="16lblCI118" class="tc"></td>
                                    <td id="16lblStart118" class="tc"></td>
                                    <td id="16lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="17lblTitle118" class="tc"></td>
                                    <td id="17lblCI118" class="tc"></td>
                                    <td id="17lblStart118" class="tc"></td>
                                    <td id="17lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="18lblTitle118" class="tc"></td>
                                    <td id="18lblCI118" class="tc"></td>
                                    <td id="18lblStart118" class="tc"></td>
                                    <td id="18lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="19lblTitle118" class="tc"></td>
                                    <td id="19lblCI118" class="tc"></td>
                                    <td id="19lblStart118" class="tc"></td>
                                    <td id="19lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="20lblTitle118" class="tc"></td>
                                    <td id="20lblCI118" class="tc"></td>
                                    <td id="20lblStart118" class="tc"></td>
                                    <td id="20lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="21lblTitle118" class="tc"></td>
                                    <td id="21lblCI118" class="tc"></td>
                                    <td id="21lblStart118" class="tc"></td>
                                    <td id="21lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="22lblTitle118" class="tc"></td>
                                    <td id="22lblCI118" class="tc"></td>
                                    <td id="22lblStart118" class="tc"></td>
                                    <td id="22lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="23lblTitle118" class="tc"></td>
                                    <td id="23lblCI118" class="tc"></td>
                                    <td id="23lblStart118" class="tc"></td>
                                    <td id="23lblBigo118" class="tc"></td>
                                </tr>
                            </tbody>
                            <tbody id="118Body4">
                                <tr>
                                    <td id="72lblTitle118" class="tc"></td>
                                    <td id="72lblCI118" class="tc"></td>
                                    <td id="72lblStart118" class="tc"></td>
                                    <td id="72lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="73lblTitle118" class="tc"></td>
                                    <td id="73lblCI118" class="tc"></td>
                                    <td id="73lblStart118" class="tc"></td>
                                    <td id="73lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="74lblTitle118" class="tc"></td>
                                    <td id="74lblCI118" class="tc"></td>
                                    <td id="74lblStart118" class="tc"></td>
                                    <td id="74lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="75lblTitle118" class="tc"></td>
                                    <td id="75lblCI118" class="tc"></td>
                                    <td id="75lblStart118" class="tc"></td>
                                    <td id="75lblBigo118" class="tc"></td>
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
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>비고</th>
                                </tr>
                            </thead>
                            <tbody id="118Body2">
                                <tr>
                                    <td id="24lblTitle118" class="tc"></td>
                                    <td id="24lblCI118" class="tc"></td>
                                    <td id="24lblStart118" class="tc"></td>
                                    <td id="24lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="25lblTitle118" class="tc"></td>
                                    <td id="25lblCI118" class="tc"></td>
                                    <td id="25lblStart118" class="tc"></td>
                                    <td id="25lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="26lblTitle118" class="tc"></td>
                                    <td id="26lblCI118" class="tc"></td>
                                    <td id="26lblStart118" class="tc"></td>
                                    <td id="26lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="27lblTitle118" class="tc"></td>
                                    <td id="27lblCI118" class="tc"></td>
                                    <td id="27lblStart118" class="tc"></td>
                                    <td id="27lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="28lblTitle118" class="tc"></td>
                                    <td id="28lblCI118" class="tc"></td>
                                    <td id="28lblStart118" class="tc"></td>
                                    <td id="28lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="29lblTitle118" class="tc"></td>
                                    <td id="29lblCI118" class="tc"></td>
                                    <td id="29lblStart118" class="tc"></td>
                                    <td id="29lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="30lblTitle118" class="tc"></td>
                                    <td id="30lblCI118" class="tc"></td>
                                    <td id="30lblStart118" class="tc"></td>
                                    <td id="30lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="31lblTitle118" class="tc"></td>
                                    <td id="31lblCI118" class="tc"></td>
                                    <td id="31lblStart118" class="tc"></td>
                                    <td id="31lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="32lblTitle118" class="tc"></td>
                                    <td id="32lblCI118" class="tc"></td>
                                    <td id="32lblStart118" class="tc"></td>
                                    <td id="32lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="33lblTitle118" class="tc"></td>
                                    <td id="33lblCI118" class="tc"></td>
                                    <td id="33lblStart118" class="tc"></td>
                                    <td id="33lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="34lblTitle118" class="tc"></td>
                                    <td id="34lblCI118" class="tc"></td>
                                    <td id="34lblStart118" class="tc"></td>
                                    <td id="34lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="35lblTitle118" class="tc"></td>
                                    <td id="35lblCI118" class="tc"></td>
                                    <td id="35lblStart118" class="tc"></td>
                                    <td id="35lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="36lblTitle118" class="tc"></td>
                                    <td id="36lblCI118" class="tc"></td>
                                    <td id="36lblStart118" class="tc"></td>
                                    <td id="36lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="37lblTitle118" class="tc"></td>
                                    <td id="37lblCI118" class="tc"></td>
                                    <td id="37lblStart118" class="tc"></td>
                                    <td id="37lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="38lblTitle118" class="tc"></td>
                                    <td id="38lblCI118" class="tc"></td>
                                    <td id="38lblStart118" class="tc"></td>
                                    <td id="38lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="39lblTitle118" class="tc"></td>
                                    <td id="39lblCI118" class="tc"></td>
                                    <td id="39lblStart118" class="tc"></td>
                                    <td id="39lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="40lblTitle118" class="tc"></td>
                                    <td id="40lblCI118" class="tc"></td>
                                    <td id="40lblStart118" class="tc"></td>
                                    <td id="40lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="41lblTitle118" class="tc"></td>
                                    <td id="41lblCI118" class="tc"></td>
                                    <td id="41lblStart118" class="tc"></td>
                                    <td id="41lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="42lblTitle118" class="tc"></td>
                                    <td id="42lblCI118" class="tc"></td>
                                    <td id="42lblStart118" class="tc"></td>
                                    <td id="42lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="43lblTitle118" class="tc"></td>
                                    <td id="43lblCI118" class="tc"></td>
                                    <td id="43lblStart118" class="tc"></td>
                                    <td id="43lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="44lblTitle118" class="tc"></td>
                                    <td id="44lblCI118" class="tc"></td>
                                    <td id="44lblStart118" class="tc"></td>
                                    <td id="44lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="45lblTitle118" class="tc"></td>
                                    <td id="45lblCI118" class="tc"></td>
                                    <td id="45lblStart118" class="tc"></td>
                                    <td id="45lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="46lblTitle118" class="tc"></td>
                                    <td id="46lblCI118" class="tc"></td>
                                    <td id="46lblStart118" class="tc"></td>
                                    <td id="46lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="47lblTitle118" class="tc"></td>
                                    <td id="47lblCI118" class="tc"></td>
                                    <td id="47lblStart118" class="tc"></td>
                                    <td id="47lblBigo118" class="tc"></td>
                                </tr>
                            </tbody>
                            <tbody id="118Body5">
                                <tr>
                                    <td id="76lblTitle118" class="tc"></td>
                                    <td id="76lblCI118" class="tc"></td>
                                    <td id="76lblStart118" class="tc"></td>
                                    <td id="76lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="77lblTitle118" class="tc"></td>
                                    <td id="77lblCI118" class="tc"></td>
                                    <td id="77lblStart118" class="tc"></td>
                                    <td id="77lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="78lblTitle118" class="tc"></td>
                                    <td id="78lblCI118" class="tc"></td>
                                    <td id="78lblStart118" class="tc"></td>
                                    <td id="78lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="79lblTitle118" class="tc"></td>
                                    <td id="79lblCI118" class="tc"></td>
                                    <td id="79lblStart118" class="tc"></td>
                                    <td id="79lblBigo118" class="tc"></td>
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
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>비고</th>
                                </tr>
                            </thead>
                            <tbody id="118Body3">
                                <tr>
                                    <td id="48lblTitle118" class="tc"></td>
                                    <td id="48lblCI118" class="tc"></td>
                                    <td id="48lblStart118" class="tc"></td>
                                    <td id="48lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="49lblTitle118" class="tc"></td>
                                    <td id="49lblCI118" class="tc"></td>
                                    <td id="49lblStart118" class="tc"></td>
                                    <td id="49lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="50lblTitle118" class="tc"></td>
                                    <td id="50lblCI118" class="tc"></td>
                                    <td id="50lblStart118" class="tc"></td>
                                    <td id="50lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="51lblTitle118" class="tc"></td>
                                    <td id="51lblCI118" class="tc"></td>
                                    <td id="51lblStart118" class="tc"></td>
                                    <td id="51lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="52lblTitle118" class="tc"></td>
                                    <td id="52lblCI118" class="tc"></td>
                                    <td id="52lblStart118" class="tc"></td>
                                    <td id="52lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="53lblTitle118" class="tc"></td>
                                    <td id="53lblCI118" class="tc"></td>
                                    <td id="53lblStart118" class="tc"></td>
                                    <td id="53lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="54lblTitle118" class="tc"></td>
                                    <td id="54lblCI118" class="tc"></td>
                                    <td id="54lblStart118" class="tc"></td>
                                    <td id="54lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="55lblTitle118" class="tc"></td>
                                    <td id="55lblCI118" class="tc"></td>
                                    <td id="55lblStart118" class="tc"></td>
                                    <td id="55lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="56lblTitle118" class="tc"></td>
                                    <td id="56lblCI118" class="tc"></td>
                                    <td id="56lblStart118" class="tc"></td>
                                    <td id="56lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="57lblTitle118" class="tc"></td>
                                    <td id="57lblCI118" class="tc"></td>
                                    <td id="57lblStart118" class="tc"></td>
                                    <td id="57lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="58lblTitle118" class="tc"></td>
                                    <td id="58lblCI118" class="tc"></td>
                                    <td id="58lblStart118" class="tc"></td>
                                    <td id="58lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="59lblTitle118" class="tc"></td>
                                    <td id="59lblCI118" class="tc"></td>
                                    <td id="59lblStart118" class="tc"></td>
                                    <td id="59lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="60lblTitle118" class="tc"></td>
                                    <td id="60lblCI118" class="tc"></td>
                                    <td id="60lblStart118" class="tc"></td>
                                    <td id="60lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="61lblTitle118" class="tc"></td>
                                    <td id="61lblCI118" class="tc"></td>
                                    <td id="61lblStart118" class="tc"></td>
                                    <td id="61lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="62lblTitle118" class="tc"></td>
                                    <td id="62lblCI118" class="tc"></td>
                                    <td id="62lblStart118" class="tc"></td>
                                    <td id="62lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="63lblTitle118" class="tc"></td>
                                    <td id="63lblCI118" class="tc"></td>
                                    <td id="63lblStart118" class="tc"></td>
                                    <td id="63lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="64lblTitle118" class="tc"></td>
                                    <td id="64lblCI118" class="tc"></td>
                                    <td id="64lblStart118" class="tc"></td>
                                    <td id="64lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="65lblTitle118" class="tc"></td>
                                    <td id="65lblCI118" class="tc"></td>
                                    <td id="65lblStart118" class="tc"></td>
                                    <td id="65lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="66lblTitle118" class="tc"></td>
                                    <td id="66lblCI118" class="tc"></td>
                                    <td id="66lblStart118" class="tc"></td>
                                    <td id="66lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="67lblTitle118" class="tc"></td>
                                    <td id="67lblCI118" class="tc"></td>
                                    <td id="67lblStart118" class="tc"></td>
                                    <td id="67lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="68lblTitle118" class="tc"></td>
                                    <td id="68lblCI118" class="tc"></td>
                                    <td id="68lblStart118" class="tc"></td>
                                    <td id="68lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="69lblTitle118" class="tc"></td>
                                    <td id="69lblCI118" class="tc"></td>
                                    <td id="69lblStart118" class="tc"></td>
                                    <td id="69lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="70lblTitle118" class="tc"></td>
                                    <td id="70lblCI118" class="tc"></td>
                                    <td id="70lblStart118" class="tc"></td>
                                    <td id="70lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="71lblTitle118" class="tc"></td>
                                    <td id="71lblCI118" class="tc"></td>
                                    <td id="71lblStart118" class="tc"></td>
                                    <td id="71lblBigo118" class="tc"></td>
                                </tr>
                            </tbody>
                            <tbody id="118Body6">
                                <tr>
                                    <td id="80lblTitle118" class="tc"></td>
                                    <td id="80lblCI118" class="tc"></td>
                                    <td id="80lblStart118" class="tc"></td>
                                    <td id="80lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="81lblTitle118" class="tc"></td>
                                    <td id="81lblCI118" class="tc"></td>
                                    <td id="81lblStart118" class="tc"></td>
                                    <td id="81lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="82lblTitle118" class="tc"></td>
                                    <td id="82lblCI118" class="tc"></td>
                                    <td id="82lblStart118" class="tc"></td>
                                    <td id="82lblBigo118" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="83lblTitle118" class="tc"></td>
                                    <td id="83lblCI118" class="tc"></td>
                                    <td id="83lblStart118" class="tc"></td>
                                    <td id="83lblBigo118" class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
            </div>
            <div id="jung276" class="fx_layout" style="display:none">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>소거시간</th>
                                    <th>값</th>
                                </tr>
                            </thead>
                            <tbody id="276Body1">
                                <tr>
                                    <td id="0lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="0lblCI276" class="tc"></td>
                                    <td id="0lblStart276" class="tc"></td>
                                    <td id="0lblEnd276" class="tc"></td>
                                    <td id="0lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblCI276" class="tc"></td>
                                    <td id="1lblStart276" class="tc"></td>
                                    <td id="1lblEnd276" class="tc"></td>
                                    <td id="1lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="2lblCI276" class="tc"></td>
                                    <td id="2lblStart276" class="tc"></td>
                                    <td id="2lblEnd276" class="tc"></td>
                                    <td id="2lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="3lblCI276" class="tc"></td>
                                    <td id="3lblStart276" class="tc"></td>
                                    <td id="3lblEnd276" class="tc"></td>
                                    <td id="3lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="2lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="4lblCI276" class="tc"></td>
                                    <td id="4lblStart276" class="tc"></td>
                                    <td id="4lblEnd276" class="tc"></td>
                                    <td id="4lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblCI276" class="tc"></td>
                                    <td id="5lblStart276" class="tc"></td>
                                    <td id="5lblEnd276" class="tc"></td>
                                    <td id="5lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="3lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="6lblCI276" class="tc"></td>
                                    <td id="6lblStart276" class="tc"></td>
                                    <td id="6lblEnd276" class="tc"></td>
                                    <td id="6lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="7lblCI276" class="tc"></td>
                                    <td id="7lblStart276" class="tc"></td>
                                    <td id="7lblEnd276" class="tc"></td>
                                    <td id="7lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="4lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="8lblCI276" class="tc"></td>
                                    <td id="8lblStart276" class="tc"></td>
                                    <td id="8lblEnd276" class="tc"></td>
                                    <td id="8lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="9lblCI276" class="tc"></td>
                                    <td id="9lblStart276" class="tc"></td>
                                    <td id="9lblEnd276" class="tc"></td>
                                    <td id="9lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="10lblCI276" class="tc"></td>
                                    <td id="10lblStart276" class="tc"></td>
                                    <td id="10lblEnd276" class="tc"></td>
                                    <td id="10lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="11lblCI276" class="tc"></td>
                                    <td id="11lblStart276" class="tc"></td>
                                    <td id="11lblEnd276" class="tc"></td>
                                    <td id="11lblCha276" class="tc"></td>
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
                                <col width="80px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>소거시간</th>
                                    <th>값</th>
                                </tr>
                            </thead>
                            <tbody id="276Body2">
                                <tr>
                                    <td id="6lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="12lblCI276" class="tc"></td>
                                    <td id="12lblStart276" class="tc"></td>
                                    <td id="12lblEnd276" class="tc"></td>
                                    <td id="12lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="13lblCI276" class="tc"></td>
                                    <td id="13lblStart276" class="tc"></td>
                                    <td id="13lblEnd276" class="tc"></td>
                                    <td id="13lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="7lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="14lblCI276" class="tc"></td>
                                    <td id="14lblStart276" class="tc"></td>
                                    <td id="14lblEnd276" class="tc"></td>
                                    <td id="14lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="15lblCI276" class="tc"></td>
                                    <td id="15lblStart276" class="tc"></td>
                                    <td id="15lblEnd276" class="tc"></td>
                                    <td id="15lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="8lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="16lblCI276" class="tc"></td>
                                    <td id="16lblStart276" class="tc"></td>
                                    <td id="16lblEnd276" class="tc"></td>
                                    <td id="16lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="17lblCI276" class="tc"></td>
                                    <td id="17lblStart276" class="tc"></td>
                                    <td id="17lblEnd276" class="tc"></td>
                                    <td id="17lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="9lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="18lblCI276" class="tc"></td>
                                    <td id="18lblStart276" class="tc"></td>
                                    <td id="18lblEnd276" class="tc"></td>
                                    <td id="18lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="19lblCI276" class="tc"></td>
                                    <td id="19lblStart276" class="tc"></td>
                                    <td id="19lblEnd276" class="tc"></td>
                                    <td id="19lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="10lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="20lblCI276" class="tc"></td>
                                    <td id="20lblStart276" class="tc"></td>
                                    <td id="20lblEnd276" class="tc"></td>
                                    <td id="20lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="21lblCI276" class="tc"></td>
                                    <td id="21lblStart276" class="tc"></td>
                                    <td id="21lblEnd276" class="tc"></td>
                                    <td id="21lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="11lblTitle276" class="tc" rowspan="2"></td>
                                    <td id="22lblCI276" class="tc"></td>
                                    <td id="22lblStart276" class="tc"></td>
                                    <td id="22lblEnd276" class="tc"></td>
                                    <td id="22lblCha276" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="23lblCI276" class="tc"></td>
                                    <td id="23lblStart276" class="tc"></td>
                                    <td id="23lblEnd276" class="tc"></td>
                                    <td id="23lblCha276" class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
            </div>
            <div id="jung550" class="fx_layout" style="display:none">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>횟수</th>
                                    <th>측정부분</th>
                                    <th>CI No.</th>
                                    <th>발생시간</th>
                                    <th>측정값</th>
                                    <th>기준값</th>
                                </tr>
                            </thead>
                            <tbody id="550Body1">
                                <tr>
                                    <td class="tc" rowspan="6">1회</td>
                                    <td class="tc" rowspan="2">기계적 구동시간</td>
                                    <td id="0lblTitle550" class="tc"></td>
                                    <td id="0lblStartS550" class="tc"></td>
                                    <td id="0lblChaS550" class="tc" rowspan="2"></td>
                                    <td class="tc" rowspan="2">≤ 2.25</td>
                                </tr>
                                <tr>
                                    <td id="1lblTitle550" class="tc"></td>
                                    <td id="0lblEndS550" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc" rowspan="2">밸브 열림시간<br>(루프응답시간 포함)</td>
                                    <td id="2lblTitle550" class="tc"></td>
                                    <td id="0lblStartA550" class="tc"></td>
                                    <td id="0lblChaA550" class="tc" rowspan="2"></td>
                                    <td class="tc" rowspan="2">≤ 4.75</td>
                                </tr>
                                <tr>
                                    <td id="3lblTitle550" class="tc"></td>
                                    <td id="0lblEndA550" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc" rowspan="2">밸브 닫힘시간</td>
                                    <td id="4lblTitle550" class="tc"></td>
                                    <td id="0lblStartB550" class="tc"></td>
                                    <td id="0lblChaB550" class="tc" rowspan="2"></td>
                                    <td class="tc" rowspan="2">7~15</td>
                                </tr>
                                <tr>
                                    <td id="5lblTitle550" class="tc"></td>
                                    <td id="0lblEndB550" class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <br>
                        <table class="list_table">
                            <colgroup>
                                <col width="80px"/>
                                <col width="220px"/>
                                <col width="220px"/>
                                <col width="80px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th rowspan="2">횟수</th>
                                    <th id="6lblTitle550" rowspan="2"></th>
                                    <th id="7lblTitle550" rowspan="2"></th>
                                    <th colspan="2">밸브 열림시간</th>
                                </tr>
                                <tr>
                                    <th>측정값</th>
                                    <th>기준값</th>
                                </tr>
                            </thead>
                            <tbody id="550Body2">
                                <tr>
                                    <td class="tc">2회</td>
                                    <td id="1lblStartA550" class="tc"></td>
                                    <td id="1lblEndA550" class="tc"></td>
                                    <td id="1lblChaA550" class="tc"></td>
                                    <td class="tc">≤ 7</td>
                                </tr>
                                <tr>
                                    <td class="tc">3회</td>
                                    <td id="2lblStartA550" class="tc"></td>
                                    <td id="2lblEndA550" class="tc"></td>
                                    <td id="2lblChaA550" class="tc"></td>
                                    <td class="tc">≤ 7</td>
                                </tr>
                                <tr>
                                    <td class="tc">4회</td>
                                    <td id="3lblStartA550" class="tc"></td>
                                    <td id="3lblEndA550" class="tc"></td>
                                    <td id="3lblChaA550" class="tc"></td>
                                    <td class="tc">≤ 7</td>
                                </tr>
                                <tr>
                                    <td class="tc">5회</td>
                                    <td id="4lblStartA550" class="tc"></td>
                                    <td id="4lblEndA550" class="tc"></td>
                                    <td id="4lblChaA550" class="tc"></td>
                                    <td class="tc">≤ 7</td>
                                </tr>
                                <tr>
                                    <td class="tc">6회</td>
                                    <td id="5lblStartA550" class="tc"></td>
                                    <td id="5lblEndA550" class="tc"></td>
                                    <td id="5lblChaA550" class="tc"></td>
                                    <td class="tc">≤ 7</td>
                                </tr>
                                <tr>
                                    <td class="tc">7회</td>
                                    <td id="6lblStartA550" class="tc"></td>
                                    <td id="6lblEndA550" class="tc"></td>
                                    <td id="6lblChaA550" class="tc"></td>
                                    <td class="tc">≤ 7</td>
                                </tr>
                                <tr>
                                    <td class="tc">8회</td>
                                    <td id="7lblStartA550" class="tc"></td>
                                    <td id="7lblEndA550" class="tc"></td>
                                    <td id="7lblChaA550" class="tc"></td>
                                    <td class="tc">≤ 7</td>
                                </tr>
                                <tr>
                                    <td class="tc">9회</td>
                                    <td id="8lblStartA550" class="tc"></td>
                                    <td id="8lblEndA550" class="tc"></td>
                                    <td id="8lblChaA550" class="tc"></td>
                                    <td class="tc">≤ 7</td>
                                </tr>
                                <tr>
                                    <td class="tc">10회</td>
                                    <td id="9lblStartA550" class="tc"></td>
                                    <td id="9lblEndA550" class="tc"></td>
                                    <td id="9lblChaA550" class="tc"></td>
                                    <td class="tc">≤ 7</td>
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
                        <table class="list_table" style="border:0px">
                            <colgroup>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                                <col width="180px"/>
                                <col width="80px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th style="border:0px;background:#FFF"></th>
                                    <th style="border:0px;background:#FFF"></th>
                                    <th style="border:0px;background:#FFF"></th>
                                    <th style="border:0px;background:#FFF"></th>
                                    <th style="border:0px;background:#FFF"></th>
                                    <th style="border:0px;background:#FFF"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                </tr>
                                <tr>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                </tr>
                                <tr>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                </tr>
                                <tr>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                </tr>
                                <tr>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                </tr>
                                <tr>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                    <td style="border:0px;background:#FFF"></td>
                                </tr>
                            </tbody>
                        </table>
                        <br>
                        <table class="list_table">
                            <colgroup>
                                <col width="80px"/>
                                <col width="220px"/>
                                <col width="220px"/>
                                <col width="80px"/>
                                <col width="80px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th rowspan="2">횟수</th>
                                    <th id="8lblTitle550" rowspan="2"></th>
                                    <th id="9lblTitle550" rowspan="2"></th>
                                    <th colspan="2">밸브 열림시간</th>
                                </tr>
                                <tr>
                                    <th>측정값</th>
                                    <th>기준값</th>
                                </tr>
                            </thead>
                            <tbody id="550Body3">
                                <tr>
                                    <td class="tc">2회</td>
                                    <td id="1lblStartB550" class="tc"></td>
                                    <td id="1lblEndB550" class="tc"></td>
                                    <td id="1lblChaB550" class="tc"></td>
                                    <td class="tc">7~15</td>
                                </tr>
                                <tr>
                                    <td class="tc">3회</td>
                                    <td id="2lblStartB550" class="tc"></td>
                                    <td id="2lblEndB550" class="tc"></td>
                                    <td id="2lblChaB550" class="tc"></td>
                                    <td class="tc">7~15</td>
                                </tr>
                                <tr>
                                    <td class="tc">4회</td>
                                    <td id="3lblStartB550" class="tc"></td>
                                    <td id="3lblEndB550" class="tc"></td>
                                    <td id="3lblChaB550" class="tc"></td>
                                    <td class="tc">7~15</td>
                                </tr>
                                <tr>
                                    <td class="tc">5회</td>
                                    <td id="4lblStartB550" class="tc"></td>
                                    <td id="4lblEndB550" class="tc"></td>
                                    <td id="4lblChaB550" class="tc"></td>
                                    <td class="tc">7~15</td>
                                </tr>
                                <tr>
                                    <td class="tc">6회</td>
                                    <td id="5lblStartB550" class="tc"></td>
                                    <td id="5lblEndB550" class="tc"></td>
                                    <td id="5lblChaB550" class="tc"></td>
                                    <td class="tc">7~15</td>
                                </tr>
                                <tr>
                                    <td class="tc">7회</td>
                                    <td id="6lblStartB550" class="tc"></td>
                                    <td id="6lblEndB550" class="tc"></td>
                                    <td id="6lblChaB550" class="tc"></td>
                                    <td class="tc">7~15</td>
                                </tr>
                                <tr>
                                    <td class="tc">8회</td>
                                    <td id="7lblStartB550" class="tc"></td>
                                    <td id="7lblEndB550" class="tc"></td>
                                    <td id="7lblChaB550" class="tc"></td>
                                    <td class="tc">7~15</td>
                                </tr>
                                <tr>
                                    <td class="tc">9회</td>
                                    <td id="8lblStartB550" class="tc"></td>
                                    <td id="8lblEndB550" class="tc"></td>
                                    <td id="8lblChaB550" class="tc"></td>
                                    <td class="tc">7~15</td>
                                </tr>
                                <tr>
                                    <td class="tc">10회</td>
                                    <td id="9lblStartB550" class="tc"></td>
                                    <td id="9lblEndB550" class="tc"></td>
                                    <td id="9lblChaB550" class="tc"></td>
                                    <td class="tc">7~15</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
            
            </div>
            <div id="jungCore" class="fx_layout" style="display:none">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="40px"/>
                                <col width="100px"/>
                                <col width="70px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="70px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>소거시간</th>
                                    <th>값</th>
                                </tr>
                            </thead>
                            <tbody id="coreBody1">
                                <tr>
                                    <td id="0lblTitleCha" class="tc" rowspan="12">채널 "G"</td>
                                    <td id="0lblLoop" class="tc" rowspan="3"></td>
                                    <td id="0lblCICh" class="tc"></td>
                                    <td id="0lblStartCha" class="tc"></td>
                                    <td id="0lblEndCha" class="tc"></td>
                                    <td id="0lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblCICh" class="tc"></td>
                                    <td id="1lblStartCha" class="tc"></td>
                                    <td id="1lblEndCha" class="tc"></td>
                                    <td id="1lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="0lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="0lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblLoop" class="tc" rowspan="3"></td>
                                    <td id="2lblCICh" class="tc"></td>
                                    <td id="2lblStartCha" class="tc"></td>
                                    <td id="2lblEndCha" class="tc"></td>
                                    <td id="2lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="3lblCICh" class="tc"></td>
                                    <td id="3lblStartCha" class="tc"></td>
                                    <td id="3lblEndCha" class="tc"></td>
                                    <td id="3lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="1lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="1lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="2lblLoop" class="tc" rowspan="3"></td>
                                    <td id="4lblCICh" class="tc"></td>
                                    <td id="4lblStartCha" class="tc"></td>
                                    <td id="4lblEndCha" class="tc"></td>
                                    <td id="4lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblCICh" class="tc"></td>
                                    <td id="5lblStartCha" class="tc"></td>
                                    <td id="5lblEndCha" class="tc"></td>
                                    <td id="5lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="2lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="2lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="3lblLoop" class="tc" rowspan="3"></td>
                                    <td id="6lblCICh" class="tc"></td>
                                    <td id="6lblStartCha" class="tc"></td>
                                    <td id="6lblEndCha" class="tc"></td>
                                    <td id="6lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="7lblCICh" class="tc"></td>
                                    <td id="7lblStartCha" class="tc"></td>
                                    <td id="7lblEndCha" class="tc"></td>
                                    <td id="7lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="3lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="3lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="1lblTitleCha" class="tc" rowspan="12">채널 "H"</td>
                                    <td id="4lblLoop" class="tc" rowspan="3"></td>
                                    <td id="8lblCICh" class="tc"></td>
                                    <td id="8lblStartCha" class="tc"></td>
                                    <td id="8lblEndCha" class="tc"></td>
                                    <td id="8lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="9lblCICh" class="tc"></td>
                                    <td id="9lblStartCha" class="tc"></td>
                                    <td id="9lblEndCha" class="tc"></td>
                                    <td id="9lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="4lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="4lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="5lblLoop" class="tc" rowspan="3"></td>
                                    <td id="10lblCICh" class="tc"></td>
                                    <td id="10lblStartCha" class="tc"></td>
                                    <td id="10lblEndCha" class="tc"></td>
                                    <td id="10lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="11lblCICh" class="tc"></td>
                                    <td id="11lblStartCha" class="tc"></td>
                                    <td id="11lblEndCha" class="tc"></td>
                                    <td id="11lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="5lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="5lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="6lblLoop" class="tc" rowspan="3"></td>
                                    <td id="12lblCICh" class="tc"></td>
                                    <td id="12lblStartCha" class="tc"></td>
                                    <td id="12lblEndCha" class="tc"></td>
                                    <td id="12lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="13lblCICh" class="tc"></td>
                                    <td id="13lblStartCha" class="tc"></td>
                                    <td id="13lblEndCha" class="tc"></td>
                                    <td id="13lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="6lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="6lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="7lblLoop" class="tc" rowspan="3"></td>
                                    <td id="14lblCICh" class="tc"></td>
                                    <td id="14lblStartCha" class="tc"></td>
                                    <td id="14lblEndCha" class="tc"></td>
                                    <td id="14lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="15lblCICh" class="tc"></td>
                                    <td id="15lblStartCha" class="tc"></td>
                                    <td id="15lblEndCha" class="tc"></td>
                                    <td id="15lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="7lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="7lblValChaCha" class="tc"></td>
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
                                <col width="40px"/>
                                <col width="100px"/>
                                <col width="70px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="70px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">관련밸브</th>
                                    <th>경보</th>
                                    <th>발생시간</th>
                                    <th>소거시간</th>
                                    <th>값</th>
                                </tr>
                            </thead>
                            <tbody id="coreBody2">
                                <tr>
                                    <td id="2lblTitleCha" class="tc" rowspan="12">채널 "J"</td>
                                    <td id="8lblLoop" class="tc" rowspan="3"></td>
                                    <td id="16lblCICh" class="tc"></td>
                                    <td id="16lblStartCha" class="tc"></td>
                                    <td id="16lblEndCha" class="tc"></td>
                                    <td id="16lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="17lblCICh" class="tc"></td>
                                    <td id="17lblStartCha" class="tc"></td>
                                    <td id="17lblEndCha" class="tc"></td>
                                    <td id="17lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="8lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="8lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="9lblLoop" class="tc" rowspan="3"></td>
                                    <td id="18lblCICh" class="tc"></td>
                                    <td id="18lblStartCha" class="tc"></td>
                                    <td id="18lblEndCha" class="tc"></td>
                                    <td id="18lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="19lblCICh" class="tc"></td>
                                    <td id="19lblStartCha" class="tc"></td>
                                    <td id="19lblEndCha" class="tc"></td>
                                    <td id="19lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="9lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="9lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="10lblLoop" class="tc" rowspan="3"></td>
                                    <td id="20lblCICh" class="tc"></td>
                                    <td id="20lblStartCha" class="tc"></td>
                                    <td id="20lblEndCha" class="tc"></td>
                                    <td id="20lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="21lblCICh" class="tc"></td>
                                    <td id="21lblStartCha" class="tc"></td>
                                    <td id="21lblEndCha" class="tc"></td>
                                    <td id="21lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="10lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="10lblValChaCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="11lblLoop" class="tc" rowspan="3"></td>
                                    <td id="22lblCICh" class="tc"></td>
                                    <td id="22lblStartCha" class="tc"></td>
                                    <td id="22lblEndCha" class="tc"></td>
                                    <td id="22lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td id="23lblCICh" class="tc"></td>
                                    <td id="23lblStartCha" class="tc"></td>
                                    <td id="23lblEndCha" class="tc"></td>
                                    <td id="23lblValCha" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc"></td>
                                    <td id="11lblLoopDescr" class="tc" colspan="2"></td>
                                    <td id="11lblValChaCha" class="tc"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
            </div>
            <div id="jung28500" class="fx_layout" style="display:none">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col width="80px"/>
                                <col width="120px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="120px"/>
                                <col width="180px"/>
                                <col width="180px"/>
                                <col width="120px"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>채널</th>
                                    <th>해당 MSSV</th>
                                    <th>MSSV OPEN IMPENDING</th>
                                    <th>발생시간</th>
                                    <th>해당릴레이</th>
                                    <th>LOGIC RELAY FUNCTIONAL</th>
                                    <th>발생시간</th>
                                    <th>시간차(판정)</th>
                                </tr>
                            </thead>
                            <tbody id="285Body">
                                <tr>
                                    <td class="tc" rowspan="2">K</td>
                                    <td class="tc">5#1, 6#1, 7#1</td>
                                    <td id="0lblMOI" class="tc" rowspan="2"></td>
                                    <td id="0lblMOIDate" class="tc" rowspan="2"></td>
                                    <td id="0lblRelay" class="tc"></td>
                                    <td id="0lblLRF" class="tc"></td>
                                    <td id="0lblLRFDate" class="tc"></td>
                                    <td id="0lblResult" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">5#4, 6#4, 8#4</td>
                                    <td id="1lblRelay" class="tc"></td>
                                    <td id="1lblLRF" class="tc"></td>
                                    <td id="1lblLRFDate" class="tc"></td>
                                    <td id="1lblResult" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc" rowspan="2">L</td>
                                    <td class="tc">7#4, 8#2</td>
                                    <td id="1lblMOI" class="tc" rowspan="2"></td>
                                    <td id="1lblMOIDate" class="tc" rowspan="2"></td>
                                    <td id="2lblRelay" class="tc"></td>
                                    <td id="2lblLRF" class="tc"></td>
                                    <td id="2lblLRFDate" class="tc"></td>
                                    <td id="2lblResult" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">5#2, 7#2, 6#2</td>
                                    <td id="3lblRelay" class="tc"></td>
                                    <td id="3lblLRF" class="tc"></td>
                                    <td id="3lblLRFDate" class="tc"></td>
                                    <td id="3lblResult" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc" rowspan="2">M</td>
                                    <td class="tc">6#3, 7#3, 8#3</td>
                                    <td id="2lblMOI" class="tc" rowspan="2"></td>
                                    <td id="2lblMOIDate" class="tc" rowspan="2"></td>
                                    <td id="4lblRelay" class="tc"></td>
                                    <td id="4lblLRF" class="tc"></td>
                                    <td id="4lblLRFDate" class="tc"></td>
                                    <td id="4lblResult" class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">8#4, 5#3</td>
                                    <td id="5lblRelay" class="tc"></td>
                                    <td id="5lblLRF" class="tc"></td>
                                    <td id="5lblLRFDate" class="tc"></td>
                                    <td id="5lblResult" class="tc"></td>
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
                <!-- Loading -->
                <div class="loader_wrap" id="modal_loading" style="display:none">
                	<div class="loader_circle"></div>
                	<div class="loader_line_mask">
                		<div class="loader_line"></div>
                	</div>
               	</div>
               	<!-- //Loading -->
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
	<div class="pop_contents">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>Title</th>
                    <td>
                        <div class="fx_form">
                            <input type="text">
                            <a class="btn_list" href="#none">그룹추가</a>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->        
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
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
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
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
                            <select>
                                <option>3</option>
                            </select>                        
                        </td>
                        <td>
                            <select>
                                <option>X</option>
                            </select>                        
                        </td>
                        <td><input type="text"></td>
                        <td>
                            <select>
                                <option>AI</option>
                            </select>                        
                        </td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td class="tc"><input type="checkbox"></td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
            <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none">Tag Search</a>
                </div>
                <div class="button">
                    <a class="btn_list" href="#none">추가</a>
                    <a class="btn_list" href="#none">수정</a>
                    <a class="btn_list" href="#none">삭제</a>
                    <a class="btn_list" href="#none">위</a>
                    <a class="btn_list" href="#none">아래</a>
                </div>
            </div>
            <!-- //list_bottom -->            
        </div>
        <!-- //list_wrap -->              
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

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

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_loading2" align="center">
<!-- pop_contents -->
<div class="pop_contents" style="max-height:460px;max-width:800px;">
<table style="display:table;width:100%;table-layout:fixed;border:1px solid rgba(0,0,0,0.1);height:50px">
	<tbody>
		<tr>
		<c:forEach var="i" begin="1" end="20" step="1">
			<td id="loading${i}" style="border:1px solid rgba(0,0,0,0.1);background-color:#ffffff;display:table-cell"></td>
		</c:forEach>
		</tr>
	</tbody>
</table>
</div>
<!-- pop_contents -->
</div>
<!-- //layer_pop_wrap -->

<!-- script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script-->
</body>
</html>

