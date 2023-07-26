/**
 * login.js 
 */
 

 $(function () {
		
		$("#userPwd").keyup(function(e){
			 if(e.which == 13){
				 $("#loginCheck").click();
			  }
		});
			/*	
		$(document.body).delegate("#modalLogin","click",function(){
			alert("asdfadf");
			//if(timerOn) timerOn = false;
			
			//openLayer('modal_login');

	    });	
	    */
	    
	    $("#modalLogin").click(function(){
			//alert("asdfadf");
			if(timerOn) timerOn = false;
			
			openLayer('modal_login');
			$("#userId").focus();

	    });	
	    
	    $("#modalMemberIns").click(function(){
			
			if(timerOn) timerOn = false;
			
			openLayer('modal_memberIns');

	    });		
	    
	    $("#modalMemberUpdate").click(function(){
			
			if(timerOn) timerOn = false;
			
			openLayer('modal_memberUpdate');

	    });	
	    
	   		
		$("#logoutCheck").click(function(){
			
			timerOn = false;

			var comAjax = new ComAjax();
			comAjax.setUrl("/dcc/admin/logoutCheck");
			comAjax.setCallback("mbr_UserLogoutCheckCallback");
			comAjax.ajax();

	    });			
		
		$("#loginCheck").click(function(){			

			if(gfn_isEmpty("userId")){
		    	alert("사용자 아이디를 입력하세요!!");
		    	return;
	    	}
			
			if(gfn_isEmpty("userPwd")){
		    	alert("사용자 패스워드를 입력하세요!!");
		    	return;
	    	}
			
			var comAjax = new ComAjax();
			comAjax.addParam("userId",	$("#userId").val());
			comAjax.addParam("userPwd",	$("#userPwd").val());
			comAjax.setUrl("/dcc/admin/loginCheck");
			comAjax.setCallback("mbr_UserLoginCheckCallback");
			comAjax.ajax();

	    });	
	    
	    $("#userSave").click(function(){
			
			if(gfn_isEmpty("iId")){
				alert("사용자 ID를 입력 하세요..!!");
				$("#iId").focus();
				return;
			}
			
			if(gfn_isEmpty("iUserName")){
				alert("사용자 성명를 입력 하세요..!!");
				$("#iUserName").focus();
				return;
			}
			
			if(gfn_isEmpty("iPwd")){
				alert("사용암호를 입력 하세요..!!");
				$("#iPwd").focus();
				return;
			}
			
			if(!gfn_checkPwd($("#iPwd").val(), true)){
				$("#iPwd").focus();
				return;
			}			
			
			if($("#iGroupCode option:selected").val() == ""){
				alert("부서를 선택 하세요..!!");
				$("#iGroupCode").focus();
				return;
			}
			
			if($("#iGrade option:selected").val() == ""){
				alert("권한을 선택 하세요..!!");
				$("#iGrade").focus();
				return;
			}
			
			if($("#iLoginHogi option:selected").val() == ""){
				alert("호기을 선택 하세요..!!");
				$("#iLoginHogi").focus();
				return;
			}
			
			if(gfn_isEmpty("iEmail")){
				alert("사용자 이메일을 입력 하세요..!!");
				$("#iEmail").focus();
				return;
			}
			
			if(!gfn_isEmail($("#iEmail").val(), false)){
				alert("정확한 이메일을 입력 하세요..!!");
				$("#iEmail").focus();
				return;
			}			
			
			alert("사용자를 등록합니다.!!");
			
			var	comSubmit	=	new ComSubmit("memberInsertForm");
			comSubmit.setUrl("/main/memberInsert");
			comSubmit.submit();
		});	
		
		$("#userUpdate").click(function(){
			
			if(gfn_isEmpty("uPwd")){
				alert("사용암호를 입력 하세요..!!");
				$("#uPwd").focus();
				return;
			}
			
			if(!gfn_checkPwd($("#uPwd").val(), true)){
				$("#uPwd").focus();
				return;
			}
			
			if (confirm("사용자 암호를 변경 합니다..!!")) {
				var	comSubmit	=	new ComSubmit("memberUpdateForm");
				comSubmit.setUrl("/main/memberUpdate");
				comSubmit.submit();
			} else {
				alert("사용자 암호 변경을 취소합니다.");
			}
			
		});	
		
	$(document.body).delegate('#3', 'click', function() {		
		var comAjax = new ComAjax();
		comAjax.addParam("hogi",	"3");
		comAjax.setUrl("/main/memberhogi");
		comAjax.setCallback("mbr_UserHogiXyGubunCallback");
		comAjax.ajax();
	});
	
	$(document.body).delegate('#4', 'click', function() {
		var comAjax = new ComAjax();
		comAjax.addParam("hogi",	"4");
		comAjax.setUrl("/main/memberhogi");
		comAjax.setCallback("mbr_UserHogiXyGubunCallback");
		comAjax.ajax();
	});	
	
	$(document.body).delegate('#X', 'click', function() {
		var comAjax = new ComAjax();
		comAjax.addParam("xyGubun",	"X");
		comAjax.setUrl("/main/memberxygubun");
		comAjax.setCallback("mbr_UserHogiXyGubunCallback");
		comAjax.ajax();
	});
	
	$(document.body).delegate('#Y', 'click', function() {
		var comAjax = new ComAjax();
		comAjax.addParam("xyGubun",	"Y");
		comAjax.setUrl("/main/memberxygubun");
		comAjax.setCallback("mbr_UserHogiXyGubunCallback");
		comAjax.ajax();
	});
	   
});

function mbr_UserHogiXyGubunCallback(data){
	
	if(data.ResultType == "1"){
		setTimer(0);
	}else{
		
	}
	
}
 
function	mbr_UserLoginCheckCallback(data){
	
	if(data.ResultType == "1"){
		
		var resultMsg = "Login Succes..!!!";
		
		//alert("mbr_UserLoginCheckCallback"+data.UserInfo);
		//alert("mbr_UserLoginCheckCallback"+data.UserInfo.userName);
		
		sessionStorage.setItem("UserInfo", JSON.stringify(data.UserInfo));
		
		//alert("mbr_UserLoginCheckCallback==" + JSON.parse(sessionStorage.getItem("UserInfo")).userName);
		
		var	comSubmit	=	new ComSubmit();
    	comSubmit.setUrl("/main/dashboard");
		comSubmit.submit();
		
	}else if(data.ResultType == "2"){
	
		var resultMsg = "사용자 ID 또는 패스워드를 확인하세요...!!";
		alert(resultMsg);
	}
	
	if(!timerOn) timerOn = true;
}


function	mbr_UserLogoutCheckCallback(data){
	
	if(data.ResultType == "3"){
		
		sessionStorage.clear();
		
		var	comSubmit	=	new ComSubmit();
    	comSubmit.setUrl("/main/dashboard");
		comSubmit.submit();
	}

}


