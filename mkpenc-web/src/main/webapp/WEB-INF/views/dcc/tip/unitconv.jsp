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
<script type="text/javascript" src="<c:url value="/resources/js/tip.js" />" charset="utf-8"></script>

<script type="text/javascript">
	var idList = ['rad','sv','abs','eq','ncp','area','vol','mass','fr','prs','tem','len'];
	var leftVal = 0;
	var rightVal = 0;
	var selectedItem = '';
	
	var volConv = [0.001,0.001,0.1,1,0.001,1000,1000000000000,4.54609099819429,3.78541110132372,0.0163870650995826,28.3168439631462,764.554635456527,158.987289125222];
	var massConv = [0.000001,0.001,1,1000,1016.04642112889,907.441016333938,0.453592292196897,0.028349524691869];
	var frConv = [0.0000002777778,0.000016666664666667,0.001,0.00786534517552198,0.471920763981515,28.3152516115143,0.002777778,0.0166666646666671,1,0.231482564819798,13.8889538891879,833.337233351273,0.0002477779077783758,0.0166667446670255,1.00000468002153,0.2777778,16.6666746666699,1000.00468002153];
	var prsConv = [10332.27,10197.1576609919,10.1971576609919,13.5950921052632,135.950921052632,345.315337656235,25.3999927233823,10000,1,101.971576609919,101971.576609919,0.101971576609919,703.069212946424];
	var temConv = [1,9/5,-273];
	var lenConv = [0.001,0.01,1,1000,0.0253999991872,0.3047999902464,0.914400249448388,1609.34397989479];
	var areaConv = [0.000001,0.0001,1,1000000,0.000645160041625726,0.0929030435966113,0.836127392369501,2589987.83223716];
	var radConv = [0.000000000001,0.000000001,0.000001,0.001,1,0.000000000000027,0.000000000027,0.000000027,0.000027,0.027,27];
	var svConv = [0.000000001,0.000001,0.001,1,0.000000003876,0.000003876,0.003876,3.876,3876,0.00000000011454753722795,0.00000011454753722795,0.00011454753722795,0.11454753722795,114.54753722795];
	var absConv = [0.001,1,0.0001,0.1,100];
	var eqConv = [0.001,1,0.0001,0.1,100];
	var ncpConv = [0,-1];
	
	function setSelection(curID) {
		leftVal = 0;
		rightVal = 0;
		$("#txtIn").val('1');
		$("#txtOut1").val('1');
		$("#txtOut2").val('1');
		
		for( var i=0;i<12;i++ ) {
			if( curID == idList[i] ) {
				$("#"+curID).css("background","#a8a8a8");
				$("#"+curID+"Table").css("display","");
				$("#itemTitle").text($("#"+curID).text());
				$("#"+curID+"l0").attr("class","highlight");
				$("#"+curID+"r0").attr("class","highlight");
				selectedItem = idList[i];
			} else {
				$("#"+idList[i]).css("background","#fafafa");
				$("#"+idList[i]+"Table").css("display","none");
				$("#"+curID+"l"+i).attr("class","");
				$("#"+curID+"r"+i).attr("class","");
			}
		}
	}
	
	function cal() {
		var inputVal = $("#txtIn").val();
		var finalVal = 0;
		
		if( isNaN(inputVal) ) {
			alert('숫자를 입력하십시오.');
			$("#txtIn").focus();
			return;
		} else {
			if( selectedItem == 'ncp' ) {
				if( leftVal == 0 ) {
					if( rightVal == 0 ) {
						finalVal = inputVal*1;
					} else {
						if( inputVal*1 > 1 ) {
							alert('변환 전의 값은 1보다 작거나 같은 값이어야 합니다.');
							$("#txtIn").focus();
						} else {
							finalVal = 10**(inputVal*1+2);
						}
					}
				} else {
					if( rightVal == 1 ) {
						finalVal = inputVal*1;
					} else {
						if( inputVal*1 <= 0 || inputVal*1 > 120 ) {
							alert('변환 전의 값위 범위는 0 < 입력값 <= 120 입니다.');
							$("#txtIn").focus();
						} else {
							finalVal = getLogVal(inputVal*1)-2;
						}
					}
				}
			} else if( selectedItem == 'tem' ) {
				if( leftVal == 0 ) {
					if( rightVal == 0 ) {
						finalVal = inputVal*1;
					} else if( rightVal == 1 ) {
						finalVal = inputVal*9/5+32;
					} else {
						finalVal = inputVal*1+273;
					}
				} else if( leftVal ==1 ) {
					if( rightVal == 0 ) {
						finalVal = (inputVal*1-32)*5/9;
					} else if( rightVal == 1 ) {
						finalVal = inputVal*1;
					} else {
						finalVal = (inputVal*1-32)*5/9+273;
					}
				} else {
					if( rightVal == 0 ) {
						finalVal = inputVal*1-273;
					} else if( rightVal == 1 ) {
						finalVal = (inputVal*1-273)*9/5+32;
					} else {
						finalVal = inputVal*1;
					}
				}
			} else if( selectedItem == 'rad' ) {
				finalVal = inputVal*radConv[leftVal]/radConv[rightVal];
			} else if( selectedItem == 'sv' ) {
				finalVal = inputVal*svConv[leftVal]/svConv[rightVal];
			} else if( selectedItem == 'abs' ) {
				finalVal = inputVal*absConv[leftVal]/absConv[rightVal];
			} else if( selectedItem == 'eq' ) {
				finalVal = inputVal*eqConv[leftVal]/eqConv[rightVal];
			} else if( selectedItem == 'area' ) {
				finalVal = inputVal*areaConv[leftVal]/areaConv[rightVal];
			} else if( selectedItem == 'mass' ) {
				finalVal = inputVal*massConv[leftVal]/massConv[rightVal];
			} else if( selectedItem == 'fr' ) {
				finalVal = inputVal*frConv[leftVal]/frConv[rightVal];
			} else if( selectedItem == 'prs' ) {
				finalVal = inputVal*prsConv[leftVal]/prsConv[rightVal];
			} else if( selectedItem == 'len' ) {
				finalVal = inputVal*lenConv[leftVal]/lenConv[rightVal];
			} else {
				finalVal = inputVal*volConv[leftVal]/volConv[rightVal];
			}
			$("#txtOut1").val(convFormat(finalVal,0));
			$("#txtOut2").val(convFormat(finalVal,1));
		}
	}
	
	function convFormat(data,type) {
		var convData = data;
		if( type == 0 ) {
			var diff = data - Math.floor(data);
			if( diff != 0 ) {
				var tmp = Math.round(diff*Math.pow(10,15))/Math.pow(10,15);
				convData = Math.floor(data)+tmp;
			}
		} else {
			var diff = data - Math.floor(data);
			if( diff != 0 ) {
				var tmp = Math.round(diff*Math.pow(10,4))/Math.pow(10,4);
				convData = Math.floor(data)+tmp;
			}
		}
		return convData;
	}
	
	function getLogVal(input) {
		return Math.log(input)/Math.log(10);
	}
	
	function getPowerVal(input) {
		return Math.pow(10,input);
	}
	
	$(function() {
		$(document.body).delegate('#itemHeaders th','click',function() {
			var curID = $(this)[0].id;
			setSelection(curID);
		});
		

		$(document.body).delegate('#radLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*radConv[leftVal]/radConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#svLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*svConv[leftVal]/svConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#absLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*absConv[leftVal]/absConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#eqLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*eqConv[leftVal]/eqConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#ncpLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				var finalVal = 0;
				if( leftVal == 0 ) {
					if( rightVal == 0 ) {
						finalVal = inputVal*1;
					} else {
						if( inputVal*1 > 1 ) {
							alert('변환 전의 값은 1보다 작거나 같은 값이어야 합니다.');
							$("#txtIn").focus();
						} else {
							finalVal = 10**(inputVal*1+2);
						}
					}
				} else {
					if( rightVal == 1 ) {
						finalVal = inputVal*1;
					} else {
						if( inputVal*1 <= 0 || inputVal*1 > 120 ) {
							alert('변환 전의 값위 범위는 0 < 입력값 <= 120 입니다.');
							$("#txtIn").focus();
						} else {
							finalVal = getLogVal(inputVal*1)-2;
						}
					}
				}
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#areaLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*areaConv[leftVal]/areaConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#volLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*volConv[leftVal]/volConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#massLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*massConv[leftVal]/massConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});

		$(document.body).delegate('#frLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*frConv[leftVal]/frConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#prsLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*prsConv[leftVal]/prsConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#temLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				if( leftVal == 0 ) {
					if( rightVal == 0 ) {
						finalVal = inputVal*1;
					} else if( rightVal == 1 ) {
						finalVal = inputVal*9/5+32;
					} else {
						finalVal = inputVal*1+273;
					}
				} else if( leftVal ==1 ) {
					if( rightVal == 0 ) {
						finalVal = (inputVal*1-32)*5/9;
					} else if( rightVal == 1 ) {
						finalVal = inputVal*1;
					} else {
						finalVal = (inputVal-32)*5/9+273;
					}
				} else {
					if( rightVal == 0 ) {
						finalVal = inputVal*1-273;
					} else if( rightVal == 1 ) {
						finalVal = (inputVal-273)*9/5+32;
					} else {
						finalVal = inputVal*1;
					}
				}
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#lenLT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			leftVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*lenConv[leftVal]/lenConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#radRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*radConv[leftVal]/radConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#svRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*svConv[leftVal]/svConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#absRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*absConv[leftVal]/absConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#eqRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*eqConv[leftVal]/eqConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#ncpRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				var finalVal = 0;
				if( leftVal == 0 ) {
					if( rightVal == 0 ) {
						finalVal = inputVal*1;
					} else {
						if( inputVal > 1 ) {
							alert('변환 전의 값은 1보다 작거나 같은 값이어야 합니다.');
							$("#txtIn").focus();
						} else {
							finalVal = getPowerVal(inputVal*1+2);
						}
					}
				} else {
					if( rightVal == 1 ) {
						finalVal = inputVal*1;
					} else {
						if( inputVal*1 <= 0 || inputVal*1 > 120 ) {
							alert('변환 전의 값위 범위는 0 < 입력값 <= 120 입니다.');
							$("#txtIn").focus();
						} else {
							finalVal = getLogVal(inputVal*1)-2;
						}
					}
				}
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#areaRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*areaConv[leftVal]/areaConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#volRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*volConv[leftVal]/volConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#massRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*massConv[leftVal]/massConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});

		$(document.body).delegate('#frRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*frConv[leftVal]/frConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#prsRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*prsConv[leftVal]/prsConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#temRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				if( leftVal == 0 ) {
					if( rightVal == 0 ) {
						finalVal = inputVal*1;
					} else if( rightVal == 1 ) {
						finalVal = inputVal*9/5+32;
					} else {
						finalVal = inputVal*1+273;
					}
				} else if( leftVal ==1 ) {
					if( rightVal == 0 ) {
						finalVal = (inputVal*1-32)*5/9;
					} else if( rightVal == 1 ) {
						finalVal = inputVal*1;
					} else {
						finalVal = (inputVal*1-32)*5/9+273;
					}
				} else {
					if( rightVal == 0 ) {
						finalVal = inputVal*1-273;
					} else if( rightVal == 1 ) {
						finalVal = (inputVal*1-273)*9/5+32;
					} else {
						finalVal = inputVal*1;
					}
				}
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
		
		$(document.body).delegate('#lenRT tr','click',function() {
			var idx = $(this)[0].id.substr(-2);
			if( isNaN(idx) ) idx = idx.substr(-1);
			
			rightVal = idx;
			
			var inputVal = $("#txtIn").val();
			var finalVal = 0;
			if( isNaN(inputVal) ) {
				alert('숫자를 입력하십시오.');
				$("#txtIn").focus();
				return;
			} else {
				finalVal = inputVal*lenConv[leftVal]/lenConv[rightVal];
				$("#txtOut1").val(convFormat(finalVal,0));
				$("#txtOut2").val(convFormat(finalVal,1));
			}
		});
	});
</script>
</head>
<body>
<div class="wrap">
<div id="modal_4">
    <!-- header_wrap -->
<div>
    </div>
<!-- //header_wrap -->
<!-- pop_contents -->
<div style="max-height:600px;">
        <!-- form_wrap -->
        <div style="width:500px;float:left">
            <!-- form_table -->
            <div class="list_table" style="max-height:600px">
            <form id="mngGrpForm" name="mngGrpForm">
            <table id="tblUnitConv" class="list_table">
                <colgroup>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="90px"/>
                    <col width="90px"/>
                </colgroup>
               	<thead id="itemHeaders">
	               	<tr>
						<th id="rad" style="height:15px">방사능</th>
						<th id="sv" style="height:15px">방사선량</th>
						<th id="abs" style="height:15px">흡수선량</th>
						<th id="eq" style="height:15px">등가선량</th>
						<th id="ncp" style="height:15px">원자로출력</th>
						<th id="area" style="height:15px">면적</th>
					</tr>
	               	<tr>
						<th id="vol" style="height:15px;background:#a8a8a8">체적</th>
						<th id="mass" style="height:15px">질량</th>
						<th id="fr" style="height:15px">유량</th>
						<th id="prs" style="height:15px">압력</th>
						<th id="tem" style="height:15px">온도</th>
						<th id="len" style="height:15px">길이</th>
					</tr>
				</thead>
			</table>
			<table style="width:500px;background:#ebf0cf;">
                <colgroup>
                    <col width="70px"/>
                    <col width="70px"/>
                    <col width="70px"/>
                    <col width="70px"/>
                    <col width="70px"/>
                    <col width="70px"/>
                    <col />
                </colgroup>
				<tbody id="bodyUnitConv">
	                <tr>
	                	<td colspan="7">
	                		<label id="itemTitle" style="color:magenta;font-size:x-large;height:25px;display:inline-flex;align-items:center">체적</label>
	                	</td>
	                </tr>
					<tr>
						<td colspan="3">
							<label>변환 전의 값 :</label>
							<input id="txtIn" type="text" style="width:220px;height:20px;margin-left:13px" onkeyup="javascript:cal();" value="1">
						</td>
						<td colspan="4">
							<label>변환 후의 값 :</label>
							<input id="txtOut1" type="text" style="width:220px;height:20px;margin-bottom:5px;margin-left:15px;background:#fafafa" value="1" disabled>
							<input id="txtOut2" type="text" style="width:220px;height:20px;margin-left:15px;background:#fafafa" value="1" disabled>
						</td>
					</tr>
				</tbody>
			</table>
			<div id="volTable">
				<table id="volLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="voll0" class="highlight"><td style="height:8px">㏄</td></tr>
					<tr id="voll1"><td style="height:8px">㎖</td></tr>
					<tr id="voll2"><td style="height:8px">㎗</td></tr>
					<tr id="voll3"><td style="height:8px">ℓ</td></tr>
					<tr id="voll4"><td style="height:8px">㎤</td></tr>
					<tr id="voll5"><td style="height:8px">㎥</td></tr>
					<tr id="voll6"><td style="height:8px">㎦</td></tr>
					<tr id="voll7"><td style="height:8px">gal(UK)</td></tr>
					<tr id="voll8"><td style="height:8px">gal(US)</td></tr>
					<tr id="voll9"><td style="height:8px">inch³</td></tr>
					<tr id="voll10"><td style="height:8px">ft³</td></tr>
					<tr id="voll11"><td style="height:8px">yard³</td></tr>
					<tr id="voll12"><td style="height:8px">배럴</td></tr>
				</table>
				<table id="volRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="volr0" class="highlight"><td style="height:8px">㏄</td></tr>
					<tr id="volr1"><td style="height:8px">㎖</td></tr>
					<tr id="volr2"><td style="height:8px">㎗</td></tr>
					<tr id="volr3"><td style="height:8px">ℓ</td></tr>
					<tr id="volr4"><td style="height:8px">㎤</td></tr>
					<tr id="volr5"><td style="height:8px">㎥</td></tr>
					<tr id="volr6"><td style="height:8px">㎦</td></tr>
					<tr id="volr7"><td style="height:8px">gal(UK)</td></tr>
					<tr id="volr8"><td style="height:8px">gal(US)</td></tr>
					<tr id="volr9"><td style="height:8px">inch³</td></tr>
					<tr id="volr10"><td style="height:8px">ft³</td></tr>
					<tr id="volr11"><td style="height:8px">yard³</td></tr>
					<tr id="volr12"><td style="height:8px">배럴</td></tr>
	            </table>
            </div>
			<div id="massTable" style="display:none">
				<table id="massLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="massl0"><td style="height:8px">mg</td></tr>
					<tr id="massl1"><td style="height:8px">g</td></tr>
					<tr id="massl2"><td style="height:8px">kg</td></tr>
					<tr id="massl3"><td style="height:8px">ton</td></tr>
					<tr id="massl4"><td style="height:8px">ton(UK0)</td></tr>
					<tr id="massl5"><td style="height:8px">ton</td></tr>
					<tr id="massl6"><td style="height:8px">파운드</td></tr>
					<tr id="massl7"><td style="height:8px">온스</td></tr>
				</table>
				<table id="massRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="massr0"><td style="height:8px">mg</td></tr>
					<tr id="massr1"><td style="height:8px">g</td></tr>
					<tr id="massr2"><td style="height:8px">kg</td></tr>
					<tr id="massr3"><td style="height:8px">ton</td></tr>
					<tr id="massr4"><td style="height:8px">ton(UK0)</td></tr>
					<tr id="massr5"><td style="height:8px">ton</td></tr>
					<tr id="massr6"><td style="height:8px">파운드</td></tr>
					<tr id="massr7"><td style="height:8px">온스</td></tr>
	            </table>
            </div>
			<div id="frTable" style="display:none">
				<table id="frLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="frl0"><td style="height:8px">㎤/hr</td></tr>
					<tr id="frl1"><td style="height:8px">㎤/min</td></tr>
					<tr id="frl2"><td style="height:8px">㎤/sec</td></tr>
					<tr id="frl3"><td style="height:8px">ft³/hr</td></tr>
					<tr id="frl4"><td style="height:8px">ft³/min</td></tr>
					<tr id="frl5"><td style="height:8px">ft³/sec</td></tr>
					<tr id="frl6"><td style="height:8px">ℓ/hr</td></tr>
					<tr id="frl7"><td style="height:8px">ℓ/min</td></tr>
					<tr id="frl8"><td style="height:8px">ℓ/sec</td></tr>
					<tr id="frl9"><td style="height:8px">㎏/hr(air)</td></tr>
					<tr id="frl10"><td style="height:8px">㎏/min(air)</td></tr>
					<tr id="frl11"><td style="height:8px">㎏/sec(air)</td></tr>
					<tr id="frl12"><td style="height:8px">㎏/hr(water)</td></tr>
					<tr id="frl13"><td style="height:8px">㎏/min(water)</td></tr>
					<tr id="frl14"><td style="height:8px">㎏/sec(water)</td></tr>
					<tr id="frl15"><td style="height:8px">㎥/hr</td></tr>
					<tr id="frl16"><td style="height:8px">㎥/min</td></tr>
					<tr id="frl17"><td style="height:8px">㎥/sec</td></tr>
				</table>
				<table id="frRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="frr0"><td style="height:8px">㎤/hr</td></tr>
					<tr id="frr1"><td style="height:8px">㎤/min</td></tr>
					<tr id="frr2"><td style="height:8px">㎤/sec</td></tr>
					<tr id="frr3"><td style="height:8px">ft³/hr</td></tr>
					<tr id="frr4"><td style="height:8px">ft³/min</td></tr>
					<tr id="frr5"><td style="height:8px">ft³/sec</td></tr>
					<tr id="frr6"><td style="height:8px">ℓ/hr</td></tr>
					<tr id="frr7"><td style="height:8px">ℓ/min</td></tr>
					<tr id="frr8"><td style="height:8px">ℓ/sec</td></tr>
					<tr id="frr9"><td style="height:8px">㎏/hr(air)</td></tr>
					<tr id="frr10"><td style="height:8px">㎏/min(air)</td></tr>
					<tr id="frr11"><td style="height:8px">㎏/sec(air)</td></tr>
					<tr id="frr12"><td style="height:8px">㎏/hr(water)</td></tr>
					<tr id="frr13"><td style="height:8px">㎏/min(water)</td></tr>
					<tr id="frr14"><td style="height:8px">㎏/sec(water)</td></tr>
					<tr id="frr15"><td style="height:8px">㎥/hr</td></tr>
					<tr id="frr16"><td style="height:8px">㎥/min</td></tr>
					<tr id="frr17"><td style="height:8px">㎥/sec</td></tr>
	            </table>
            </div>
			<div id="prsTable" style="display:none">
				<table id="prsLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="prsl0"><td style="height:8px">atm</td></tr>
					<tr id="prsl1"><td style="height:8px">bar</td></tr>
					<tr id="prsl2"><td style="height:8px">mbr</td></tr>
					<tr id="prsl3"><td style="height:8px">mmHg</td></tr>
					<tr id="prsl4"><td style="height:8px">cmHg</td></tr>
					<tr id="prsl5"><td style="height:8px">inchHg</td></tr>
					<tr id="prsl6"><td style="height:8px">inchWTR</td></tr>
					<tr id="prsl7"><td style="height:8px">㎏/㎠</td></tr>
					<tr id="prsl7"><td style="height:8px">㎏/㎡</td></tr>
					<tr id="prsl8"><td style="height:8px">㎪</td></tr>
					<tr id="prsl9"><td style="height:8px">㎫</td></tr>
					<tr id="prsl10"><td style="height:8px">㎩(N/㎡)</td></tr>
					<tr id="prsl11"><td style="height:8px">psi</td></tr>
				</table>
				<table id="prsRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="prsr0"><td style="height:8px">atm</td></tr>
					<tr id="prsr1"><td style="height:8px">bar</td></tr>
					<tr id="prsr2"><td style="height:8px">mbr</td></tr>
					<tr id="prsr3"><td style="height:8px">mmHg</td></tr>
					<tr id="prsr4"><td style="height:8px">cmHg</td></tr>
					<tr id="prsr5"><td style="height:8px">inchHg</td></tr>
					<tr id="prsr6"><td style="height:8px">inchWTR</td></tr>
					<tr id="prsr7"><td style="height:8px">㎏/㎠</td></tr>
					<tr id="prsr7"><td style="height:8px">㎏/㎡</td></tr>
					<tr id="prsr8"><td style="height:8px">㎪</td></tr>
					<tr id="prsr9"><td style="height:8px">㎫</td></tr>
					<tr id="prsr10"><td style="height:8px">㎩(N/㎡)</td></tr>
					<tr id="prsr11"><td style="height:8px">psi</td></tr>
	            </table>
            </div>
			<div id="temTable" style="display:none">
				<table id="temLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="teml0"><td style="height:8px">℃</td></tr>
					<tr id="teml1"><td style="height:8px">℉</td></tr>
					<tr id="teml2"><td style="height:8px">K</td></tr>
				</table>
				<table id="temRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="temr0"><td style="height:8px">℃</td></tr>
					<tr id="temr1"><td style="height:8px">℉</td></tr>
					<tr id="temr2"><td style="height:8px">K</td></tr>
	            </table>
            </div>
			<div id="lenTable" style="display:none">
				<table id="lenLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="lenl0"><td style="height:8px">㎜</td></tr>
					<tr id="lenl1"><td style="height:8px">㎝</td></tr>
					<tr id="lenl2"><td style="height:8px">m</td></tr>
					<tr id="lenl3"><td style="height:8px">㎞</td></tr>
					<tr id="lenl4"><td style="height:8px">inch</td></tr>
					<tr id="lenl5"><td style="height:8px">ft</td></tr>
					<tr id="lenl6"><td style="height:8px">yard</td></tr>
					<tr id="lenl7"><td style="height:8px">mile</td></tr>
				</table>
				<table id="lenRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="lenr0"><td style="height:8px">㎜</td></tr>
					<tr id="lenr1"><td style="height:8px">㎝</td></tr>
					<tr id="lenr2"><td style="height:8px">m</td></tr>
					<tr id="lenr3"><td style="height:8px">㎞</td></tr>
					<tr id="lenr4"><td style="height:8px">inch</td></tr>
					<tr id="lenr5"><td style="height:8px">ft</td></tr>
					<tr id="lenr6"><td style="height:8px">yard</td></tr>
					<tr id="lenr7"><td style="height:8px">mile</td></tr>
	            </table>
            </div>
			<div id="radTable" style="display:none">
				<table id="radLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="radl0"><td style="height:8px">pCi</td></tr>
					<tr id="radl1"><td style="height:8px">nCi</td></tr>
					<tr id="radl2"><td style="height:8px">μCi</td></tr>
					<tr id="radl3"><td style="height:8px">mCi</td></tr>
					<tr id="radl4"><td style="height:8px">Ci</td></tr>
					<tr id="radl5"><td style="height:8px">mBq</td></tr>
					<tr id="radl6"><td style="height:8px">KBq</td></tr>
					<tr id="radl7"><td style="height:8px">MBq</td></tr>
					<tr id="radl8"><td style="height:8px">GBq</td></tr>
					<tr id="radl9"><td style="height:8px">TBq</td></tr>
				</table>
				<table id="radRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="radr0"><td style="height:8px">pCi</td></tr>
					<tr id="radr1"><td style="height:8px">nCi</td></tr>
					<tr id="radr2"><td style="height:8px">μCi</td></tr>
					<tr id="radr3"><td style="height:8px">mCi</td></tr>
					<tr id="radr4"><td style="height:8px">Ci</td></tr>
					<tr id="radr5"><td style="height:8px">mBq</td></tr>
					<tr id="radr6"><td style="height:8px">KBq</td></tr>
					<tr id="radr7"><td style="height:8px">MBq</td></tr>
					<tr id="radr8"><td style="height:8px">GBq</td></tr>
					<tr id="radr9"><td style="height:8px">TBq</td></tr>
	            </table>
            </div>
			<div id="svTable" style="display:none">
				<table id="svLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="svl0"><td style="height:8px">nR</td></tr>
					<tr id="svl1"><td style="height:8px">μR</td></tr>
					<tr id="svl2"><td style="height:8px">mR</td></tr>
					<tr id="svl3"><td style="height:8px">R</td></tr>
					<tr id="svl4"><td style="height:8px">pC/㎏</td></tr>
					<tr id="svl5"><td style="height:8px">nC/㎏</td></tr>
					<tr id="svl6"><td style="height:8px">μC/㎏</td></tr>
					<tr id="svl7"><td style="height:8px">mC/㎏</td></tr>
					<tr id="svl8"><td style="height:8px">C/㎏</td></tr>
					<tr id="svl9"><td style="height:8px">p㏉</td></tr>
					<tr id="svl10"><td style="height:8px">n㏉</td></tr>
					<tr id="svl11"><td style="height:8px">μ㏉</td></tr>
					<tr id="svl12"><td style="height:8px">m㏉</td></tr>
					<tr id="svl13"><td style="height:8px">㏉</td></tr>
				</table>
				<table id="svRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="svr0"><td style="height:8px">nR</td></tr>
					<tr id="svr1"><td style="height:8px">μR</td></tr>
					<tr id="svr2"><td style="height:8px">mR</td></tr>
					<tr id="svr3"><td style="height:8px">R</td></tr>
					<tr id="svr4"><td style="height:8px">pC/㎏</td></tr>
					<tr id="svr5"><td style="height:8px">nC/㎏</td></tr>
					<tr id="svr6"><td style="height:8px">μC/㎏</td></tr>
					<tr id="svr7"><td style="height:8px">mC/㎏</td></tr>
					<tr id="svr8"><td style="height:8px">C/㎏</td></tr>
					<tr id="svr9"><td style="height:8px">p㏉</td></tr>
					<tr id="svr10"><td style="height:8px">n㏉</td></tr>
					<tr id="svr11"><td style="height:8px">μ㏉</td></tr>
					<tr id="svr12"><td style="height:8px">m㏉</td></tr>
					<tr id="svr13"><td style="height:8px">㏉</td></tr>
	            </table>
            </div>
			<div id="absTable" style="display:none">
				<table id="absLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="absl0"><td style="height:8px">mrad</td></tr>
					<tr id="absl1"><td style="height:8px">rad</td></tr>
					<tr id="absl2"><td style="height:8px">μ㏉</td></tr>
					<tr id="absl3"><td style="height:8px">m㏉</td></tr>
					<tr id="absl4"><td style="height:8px">㏉</td></tr>
				</table>
				<table id="absRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="absr0"><td style="height:8px">mrad</td></tr>
					<tr id="absr1"><td style="height:8px">rad</td></tr>
					<tr id="absr2"><td style="height:8px">μ㏉</td></tr>
					<tr id="absr3"><td style="height:8px">m㏉</td></tr>
					<tr id="absr4"><td style="height:8px">㏉</td></tr>
	            </table>
            </div>
			<div id="eqTable" style="display:none">
				<table id="eqLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="eql0"><td style="height:8px">mrem</td></tr>
					<tr id="eql1"><td style="height:8px">rem</td></tr>
					<tr id="eql2"><td style="height:8px">μ㏜</td></tr>
					<tr id="eql3"><td style="height:8px">m㏜</td></tr>
					<tr id="eql4"><td style="height:8px">㏜</td></tr>
				</table>
				<table id="eqRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="eqr0"><td style="height:8px">mrem</td></tr>
					<tr id="eqr1"><td style="height:8px">rem</td></tr>
					<tr id="eqr2"><td style="height:8px">μ㏜</td></tr>
					<tr id="eqr3"><td style="height:8px">m㏜</td></tr>
					<tr id="eqr4"><td style="height:8px">㏜</td></tr>
	            </table>
            </div>
			<div id="ncpTable" style="display:none">
				<table id="ncpLT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="ncpl0"><td style="height:8px">decade</td></tr>
					<tr id="ncpl1"><td style="height:8px">%FP</td></tr>
				</table>
				<table id="ncpRT" style="display:inline-block;flex:1;float:left">
					<colGroup>
						<col width="245px"/>
					</colGroup>
					<tr id="ncpr0"><td style="height:8px">decade</td></tr>
					<tr id="ncpr1"><td style="height:8px">%FP</td></tr>
	            </table>
            </div>
            </form>
            </div>
            <!-- //form_table -->
        </div>
        <!-- //list_wrap -->      
</div>
<!-- pop_contents -->
</div>
</div>
</body>
</html>