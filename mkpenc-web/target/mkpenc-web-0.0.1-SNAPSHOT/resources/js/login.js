/**
 * login.js 
 */
 

 $(function () {
		
		$("#userPwd").keyup(function(e){
			 if(e.which == 13){
				 $("#loginCheck").click();
			  }
		});
		
		$("#logoutCheck").click(function(){

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
	   
});
 
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
}


function	mbr_UserLogoutCheckCallback(data){
	
	if(data.ResultType == "3"){
		
		sessionStorage.clear();
		
		var	comSubmit	=	new ComSubmit();
    	comSubmit.setUrl("/main/dashboard");
		comSubmit.submit();
	}

}


