/*
 * CONSTANTS & VARIABLES
 * UPDATE:
 * 5.	2019-03-14 YOO TAESHIN		MODIFY:	gfn_renderPaging(params)
 * 4.	2019-02-22 YOO TAESHIN		ADD:	gfn_copyText2Clipboard(text)
 * 3.	2018-11-12 YOO TAESHIN		ADD:	gfn_FileDownload(path, fname)
 * 2.	2018-06-22 YOO TAESHIN		MODIFY:	gfn_isMobile(mobile, show)
 * 1.	2018-03-14 YOO TAESHIN		ADD:	fn_ExceptionCheck(str) 
 */


//MODE CONSTANTS
var	_DEBUG	=	false;	//DEBUG MODE FLAG VALUE:	2017-11-09. YOO TAESHIN
var	_CHANGE	=	"C"
,	_DELETE	=	"D"
,	_EDIT	=	"E"
,	_INSERT	=	"I"
,	_TEST	=	"T"
,	_UPDATE	=	"U"
,	_UPDATE1=	"U1";

//BOARD ID:	2019-02-06. YOO TAESHIN
var	BDI_FAQ		=	"BDI_FAQ"
,	BDI_NOTICE	=	"BDI_NOTICE"
,	BDI_QNA		=	"BDI_QNA";

// BROWSER INFO:	2019-03-02 YOO TAESHIN
var	_BROWSERS	=	["Chrome", "FireFox", "MSIE", "Opera", "Safari", "Trident"];

//FILE DEFINES
var	FILE_IMG_MAXSZ	=	176 * 144
,	FILE_VID_MAXSZ	=	176 * 144 * 256;

var	gfv_pageIndex	=	null;
var gfv_eventName	=	null;

var	_PROD_ID	=	""
,	_MEMBER_ID	=	"";

var	HOME_DIR	=	"/nexwaysddc"
,	RES_DIR		=	"/nexwaysddc"
,	IMG_DIR		=	RES_DIR + "/image";
var	HOME_URL	=	"218.38.15.69" + HOME_DIR;

var	_BtnImages	=	{
	PDEL	:	IMG_DIR + "/ico_btnPdel.png",
	PINS	:	IMG_DIR + "/ico_btnPins.png",
	PGDEL	:	IMG_DIR + "/ico_btnPgDel.png",
	PGINS	:	IMG_DIR + "/ico_btnPgIns.png",
	QDEL	:	IMG_DIR + "/ico_btnQdel.png",
	QINS	:	IMG_DIR + "/ico_btnQins.png",
	RDEL	:	IMG_DIR + "/ico_btnDelete.png",
	RINS	:	IMG_DIR + "/ico_btnInsert.png",
	TDEL	:	IMG_DIR + "/ico_btnTdel.png",
	TINS	:	IMG_DIR + "/ico_btnTins.png",
	VDEL	:	IMG_DIR + "/ico_btnVdel.png",
	VINS	:	IMG_DIR + "/ico_btnVins.png"
};

/*
 * 	ARRAY SUM:	2020-03-09	LEE MOONJU
 */
function	gfn_ArrSum(arr, first, last)	{
	var Arrsum =0;
	for(var t=first; t<=last; t++){
		Arrsum += arr[t];
	}
	return	Arrsum;
}

function	gfn_clearObj(id, type)	{
	if (type == "div")	{
		$("#" + id).empty();
	}
	else if (type == "select")	{
		var	obj	=	document.getElementById(id);
		while (obj.options.length > 0)
			obj.remove(0);
	}
}

/*
 * FUNCTIONS
 */
//PRINT OBJECT PROPERTIES:	2017-11-09. YOO TAESHIN
function	gfn_ObjPrint(obj)	{
	var	str	=	"";
	for (var prop in obj)	{
		var	pVal	=	obj[prop];
		str	+=	prop + ":" + pVal + ", ";
	}
	str	+=	"<br>";
	return	str;
}

function	_movePage(value)	{
    $("#" + gfv_pageIndex).val(value);
    if (typeof(gfv_eventName) == "function")
   	{
        gfv_eventName(value);
   	}
    else{
        eval(gfv_eventName + "(value);");
    }
}

/* ADD IMG ELEMENT TO DIV AND PEVIEW
 * UPDATE:
 * 1.	2019-02-14 YOO TAESHIN	REMARKED	gfn_isFileSizeOk()
 */
function	gfn_addImg2Msg(pnl, src, out)	{
	var	input	=	document.getElementById(src);

	if (!input.files || !input.files[0])	return	false;
	// 2019-02-14 YOO TAESHIN:	if (!gfn_isFileSizeOk(input, "I"))			return	false;

	var	szHtml	=	"<img id='" + out + "' name='" + out + "' src=''/>";
	$("#" + pnl).append(szHtml);

	var	fr		=	new FileReader();
	fr.onload	=	function(e)	{
		$("#" + out).attr('src', e.target.result);
	};
	fr.readAsDataURL(input.files[0]);
	return	true;
}

function	gfn_alert(ttl, msg, opt)	{
	var	ttlcolor	=	"";

	opt	=	opt.toUpperCase();
	if (opt == "ERROR")			ttlcolor	=	"#ff0000";
	else if (opt == "INFO")		ttlcolor	=	"#00ff00";
	else if (opt == "WARN")		ttlcolor	=	"#ff4500";
	else if (opt == "NOTICE")	ttlcolor	=	"#ffff00";

	var	alertBox	=	"<div id='alertBox' title='" + ttl + "' style='padding-top:20px;'>" + msg + "</div>";

	$("#alertBox").remove();
	$("body").append(alertBox);

	$(function()	{
		$("#alertBox").dialog({
			modal	:	true,
			my		:	"center",
			at		:	"center",
			of		:	window,
			buttons	:	{
				"확인"	:	function()	{
					$(this).dialog("close");
				},
			},
			closeText:	""
		}).prev(".ui-dialog-titlebar").css({
			"background":	ttlcolor
		});
	});
}

function	gfn_BrowserIs()	{
	for (n=0; n < _BROWSERS.length; n++)	{
		if (navigator.userAgent.indexOf(_BROWSERS[n]) > -1)
			return	(_BROWSERS[n] == "Trident" ? "MSIE" : _BROWSERS[n]);
	}
}

function	gfn_confirm(title, msg)	{
	var	confirmBox	=	"<div id='confirmBox' title='" + title + "' style='padding-top: 20px;'>" + msg + "</div>";
	$("#confirmBox").remove();
	$("body").append(confirmBox);
	$(function()	{
		$("#confirmBox").dialog({
			resizable:	false,
			height:	"auto",
			width:	400,
			modal:	true,
			buttons:	{
				"확인"	:	function()	{
					$(this).dialog("close");
					return	true;
				},
				"취소"	:	function()	{
					$(this).dialog("close");
					return	false;
				}
			}
		});
	});
}

// COPY TEXT TO CLIPBOARD:	2019-02-22 YOO TAESHIN
function	gfn_copyText2Clipboard(text)	{
	if	(window.clipboardData && window.clipboardData.setData)	{
		clipboardData.setData("Text", text );
	}
	else if (document.queryCommandSupported && document.queryCommandSupported("copy"))	{
		var	textarea	=	document.createElement("textarea");
        textarea.textContent	=	text;
        textarea.style.position	=	"fixed";		// Prevent scrolling to bottom of page in MS Edge.
        document.body.appendChild(textarea);
        textarea.select();

        try {
            return document.execCommand("copy");	// Security exception may be thrown by some browsers.
        } catch (ex) {
            console.warn("Copy to clipboard failed.", ex);
            return false;
        } finally {
            document.body.removeChild(textarea);
        }
	}
}

// CHECK THE EXCEPTIONS:	2018-03-14 YOO TAESHIN
function	gfn_ExceptionCheck(str)	{
	if (gfn_isNull(str))	return	false;
	if (str.indexOf("'") > -1 || str.indexOf("\"") > -1 || str.indexOf("&#39;") > -1 || str.indexOf("&quot;") > -1)
		return	true;
	return	false;
}

//DOWNLOAD FILE:	2018-11-12 YOO TAESHIN
function	gfn_FileDownload(path, fname)	{
	var	comSubmit	=	new ComSubmit();
	comSubmit.setUrl("http://" + HOME_URL + "/common/downloadFile.do");
	comSubmit.addParam("PATH",	path);
	comSubmit.addParam("FILE",	fname);
	comSubmit.submit();
}

function	gfn_getCharCnt(src, tgt, msg)	{
	var	nMsgCnt	=	0;
	$(src).keyup(function() {
	    nMsgCnt	=	$(src).val().length;
		$(tgt).html(nMsgCnt + msg);
	});
}

//SET IMAGE BUTTON:	2017-11-29. YOO TAESHIN
function	gfn_ImgBtnSet(imgPath, option)	{
	return	"background:url(\"" + imgPath + "\") " + option + ";"
}

function	gfn_isEmail(email, show)	{
	var regExp=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

	if (regExp.test(email) == false)	{
		if (show)	gfn_alert("이메일정보", "잘못된 이메일 형식입니다!", "WARN");
		return	false;
	}

	return	true;
}

// CHECK IF FILE SIZE IS OK FOR UPLOADING
function	gfn_isFileSizeOk(input, type)	{
	var	maxSz	=	type == "I" ? FILE_IMG_MAXSZ : FILE_VID_MAXSZ;
	if (input.files[0].size > maxSz)	{
		gfn_alert("파일정보", "파일크기가 " + Math.round(maxSz / 1024) + "KB 보다 큽니다!", "WARN");
		input.value	=	"";
		return	false
	}
	return	true;
}

//CHECK IF VALUE OF STRING IS EMPTY
function	gfn_isEmpty(obj, blShow)	{
	if	(document.getElementById(obj) == null)	{	//CHECK MISSPELLING:	2017-06-23. YOO TAESHIN
		if (blShow)	gfn_alert("장애", obj + " - This Element is Not found! Check it, please!", "ERROR");
		return	true;
	}

	if	(document.getElementById(obj).value.length < 1)	return	true;

	return	false;
}

function	gfn_isNull(str)	{
    if (str == null)	return true;
    if (str == "NaN")	return true;
    if (new String(str).valueOf() == "undefined")	return true;

    var	chkStr	=	new String(str);
    if (chkStr.valueOf() == "undefined" )	return true;
    if (chkStr == null)	return true;
    if (chkStr.toString().length == 0)	return true;

    return false;
}


function	gfn_checkPwd(pwd, show)	{

	let number = pwd.search(/[0-9]/g);
	let english = pwd.search(/[a-z]/ig);
	let spece = pwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	//let reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;

	if (pwd.length < 6 || pwd.length > 10) {
		alert("6자리 ~ 10자리 이내로 입력해주세요.");
		return false;
	} else if (number < 0 || english < 0) {
		alert("영문,숫자를 혼합하여 입력해주세요.");
        return false;
	}	
	
	return true;
}

/*
 * UPDATE:
 * 1.	2018-06-22 YOO TAESHIN	ADD:	MOBILE PHONE NUMBER CHECKING
 */
function	gfn_isMobile(mobile, show)	{

	if (gfn_isPhone(mobile, 10, 11, show))	{

		//MOBILE PHONE NUMBER CHECKING:	2018-06-22 YOO TAESHIN
		var	regExp	=	/^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		if	(!regExp.test(mobile))	{
			if (show)	gfn_alert("전화번호", "휴대전화번호를 입력하십시오!", "WARN");
			return	false;
		}
		return	true;
	}
	return	false
}

function	gfn_isPhone(phone, lenMin, lenMax, show)	{
	if (phone == null || phone == '')	{
		if (show)	gfn_alert("전화번호", "전화번호를 입력하십시오!", "WARN");
		return	false;
	}

	var num	=	phone.replace(/-/gi, '');

	if (!gfn_isNumeric(num))	{
		if (show)	gfn_alert("전화번호", "전화번호에 숫자와 '-'만 입력하십시오!", "WARN");
		return	false;
	}

	if (num.length < lenMin || num.length > lenMax)	{
		if (show)	gfn_alert("전화번호", "전화번호 길이가 다릅니다!", "WARN");
		return	false;
	}

	if (num.length > 8)	{
		var	regExp	=	/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		if	(!regExp.test(num))	{
			if (show)	gfn_alert("전화번호", "올바른 전화번호를 입력하십시오!", "WARN");
			return	false;
		}
	}
	return	true;
}

function	gfn_isNumeric(num, show)	{
	var	regExp	=	/^[0-9]*$/;

	if (!regExp.test(num))	{
		if (show)	gfn_alert("경고", "숫자를 입력하십시오!", "NOTICE");
		return	false;
	}

	return	true;
}

function	gfn_isDate(obj, show)	{
	
	var	regExp= /[0-9]{4}-[0-9]{2}-[0-9]{2}/;

	if (!regExp.test(document.getElementById(obj).value))	{
			if (show)	gfn_alert("경고", "날짜를 입력하십시오!", "NOTICE");
			return false
	}
	return	true;
}

function	gfn_isDate2(obj, show)	{
	
    var	regExp2= /[0-9]{4}[0-9]{2}[0-9]{2}/;

	if (!regExp2.test(document.getElementById(obj).value))	{
			if (show)	gfn_alert("경고", "날짜를 입력하십시오!", "NOTICE");
			return false
	}

	return	true;
}

function	gfn_convert2PhoneNumber(num, hide1, hide2)	{
	if (num.substring(0, 1) != 0)	num	+=	"0" + num;

	num	=	num.replace(/-/gi, "");

	if (!gfn_isNumeric(num) || num.length < 10)	return	num;

	if	(num.length == 10)	{
		num	=	num.substr(0,3)
			+	"-" + (hide1 != null && hide1 != "" ? hide1 : num.substr(3,3))
			+	"-" + (hide2 != null && hide2 != "" ? hide2 : num.substr(6,4));
	}
	else if (num.length === 11)	{
		num	=	num.substr(0,3)
			+	"-" + (hide1 != null && hide1 != "" ? hide1 : num.substr(3,4))
			+	"-" + (hide2 != null && hide2 != "" ? hide2 : num.substr(7,4));
	}

	return	num;
}

//SET NUMBET WITH FORMAT:	2017-11-14. YOO TAESHIN
function	gfn_NumberFormat(num, fmt)	{
	if (fmt == "COMMA")
		return	num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	
}

//SET NUMBER AT ZERO PAD
function	gfn_NumberZeroPad(num, length)	{
	var	str	=	String(num);
	while	(str.length < (size || 2))	{	str	=	"0" + str;	}
	return	str;
}

/* UPDATE:
 * 3.	2019-10-02 YOO TAESHIN	MODIFY:	currentIndex CHECKING
 * 2.	2019-03-14 YOO TAESHIN	CHANGE:	var last
 * 1.	2019-02-12 YOO TAESHIN	ADD:	renderClass
 */
function	gfn_renderPaging(params)	{
	var	divId		=	params.divId;		//페이징이 그려질 div id
	gfv_pageIndex	=	params.pageIndex;	//현재 위치가 저장될 input 태그
	var totalCount	=	params.totalCount;	//전체 조회 건수
	//var currentIndex=	$("#"+params.pageIndex).val();	//현재 위치
	var currentIndex=	params.currentIndex;
	var recordCount =	gfn_isNull(params.recordCount) == true ? 20 : params.recordCount; //페이지당 레코드 수
	var	renderClass	=	gfn_isNull(params.renderClass) == true ? "normal" : params.renderClass;
	var	pg_arrow	=	"pg_arrow";
	var	pg_index	=	"pg_index";
	if (renderClass == "small")	{
		pg_arrow	=	"pg_arrow_s";
		pg_index	=	"pg_index_s";
	}
	
	// 2019-10-02 YOO TAESHIN:	if ($("#"+params.pageIndex).length == 0 || gfn_isNull(currentIndex) == true)
	if (gfn_isNull(currentIndex))
		currentIndex = 1;

	var totalIndexCount = Math.ceil(totalCount / recordCount); // 전체 인덱스 수
	gfv_eventName = params.eventName;

	$("#"+divId).empty();
	var preStr = "";
	var postStr = "";
	var str = "";

	var first = (parseInt((currentIndex-1) / 10) * 10) + 1;
	// 2019-03-14 YOO TAESHIN:	var last = (parseInt(totalIndexCount/10) == parseInt(currentIndex/10)) ? totalIndexCount % 10 : 10;
	var last = (parseInt(totalIndexCount/10) == parseInt(currentIndex/10)) && currentIndex % 10 > 0 ? totalIndexCount % 10 : 10;
	var prev = (parseInt((currentIndex-1)/10)*10) - 9 > 0 ? (parseInt((currentIndex-1)/10)*10) - 9 : 1;
	var next = (parseInt((currentIndex-1)/10)+1) * 10 + 1 < totalIndexCount ? (parseInt((currentIndex-1)/10)+1) * 10 + 1 : totalIndexCount;
	
	if	(totalIndexCount > 10)	{

		//GOTO THE FIRST OR PREVIOUS
		preStr	+=	"<a href='#this' class='" + pg_arrow + "' onclick='_movePage(1)'>◀◀</a>"
				+	"&nbsp;<a href='#this' class='" + pg_arrow + "' onclick='_movePage(" + prev + ")'>◀</a>&nbsp;";

		//GOTO THE LAST OR NEXT
		postStr	+=	"&nbsp;<a href='#this' class='" + pg_arrow + "' onclick='_movePage(" + next + ")'>▶</a>"
				+	"&nbsp;<a href='#this' class='" + pg_arrow + "' onclick='_movePage(" + totalIndexCount + ")'>▶▶</a>";
	}
	else if (totalIndexCount <= 10 && totalIndexCount > 1)	{

		//GOTO THE FIRST
		preStr	+=	"<a href='#this' class='" + pg_arrow + "' onclick='_movePage(1)'>◀◀</a>&nbsp;";

		//GOTO THE LAST
		postStr	+=	"&nbsp;<a href='#this' class='" + pg_arrow + "' onclick='_movePage(" + totalIndexCount + ")'>▶▶</a>";
	}

	for	(var i=first; i < (first + last); i++)	{
		if (i != currentIndex)
			str	+=	"&nbsp;<a href='#this' class='" + pg_index + "' onclick='_movePage(" + i + ")'>"
				+	(renderClass == "small" ? "" : "&nbsp;") + i + (renderClass == "small" ? "" : "&nbsp;") + "</a>";
		else
			str	+=	"&nbsp;<b><a href='#this' class='" + pg_index + "' onclick='_movePage(" + i + ")'>"
				+	(renderClass == "small" ? "" : "&nbsp;") + i + (renderClass == "small" ? "" : "&nbsp;") + "</a></b>";
		str	+=	(renderClass == "small" ? "" : "&nbsp;");
	}
	str	+=	(renderClass == "small" ? "&nbsp;" : "");

	$("#" + divId).append(preStr + str + postStr);

}

/*
 * DO SLEEP WHILE DELAY TIME:	2017-12-15. YOO TAESHIN
 */
function	gfn_sleep(delay){
	var start = new Date().getTime();
	while (new Date().getTime() < start + delay);
}

// CLEAR SELECT TAG OPTIONS:	2017-12-18. YOO TAESHIN
function	gfn_SelectClear(id)	{
	var	obj	=	document.getElementById(id);
	while (obj.options.length > 0)	obj.remove(0);
}

var	gfv_ajaxCallback	=	"";
function	ComAjax(opt_formId)	{
    this.url	=	"";
    this.formId	=	gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
    this.param	=	"";

    if (this.formId == "commonForm")	{
        var	frm	=	$("#commonForm");
        if (frm.length > 0){
            frm.remove();
        }
        var str = "<form id='commonForm' name='commonForm'></form>";
        $('body').append(str);
    }
     
    this.setUrl			=	function setUrl(url)	{	this.url = url;	};
    this.setCallback	=	function setCallback(callBack)	{	fv_ajaxCallback = callBack;	};
    this.addParam		=	function addParam(key,value)	{	this.param	=	this.param + "&" + key + "=" + value;	};

    this.ajax	=	function ajax()	{
    	if (this.formId != "commonForm")
            this.param	+=	"&" + $("#" + this.formId).serialize();
        $.ajax({
            url : this.url,
            type : "POST",
            data : this.param,
            async : false,
            beforeSend : function(xmlHttpRequest){
			      xmlHttpRequest.setRequestHeader("AJAX","true");
			},
            success : function(data, status) {
				if (typeof(fv_ajaxCallback) == "function")
				    fv_ajaxCallback(data);
				else
				    eval(fv_ajaxCallback + "(data);");
            }
        });
    };
}

function	ComSubmit(opt_formId) {
	this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
	this.url = "";
	
	if(this.formId == "commonForm"){
		$("#commonForm")[0].reset();
		$("#commonForm").empty();
	}

	this.setUrl		=	function	setUrl(url){
		this.url = url;
	};

	this.addParam	=	function	addParam(key, value)	{
		if($("#"+key) != null) 	$("#"+key).remove();
		$("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
	};

	this.submit = function submit(){
		var frm = $("#"+this.formId)[0];
		frm.action	=	this.url;
		frm.method	=	"post";
		frm.submit();
	}
	
	this.tsubmit = function tsubmit(){
		var frm = $("#"+this.formId)[0];
		frm.action = this.url;
		frm.target = opener.window.name;
		frm.method = "post";
		frm.submit();
	}
}
