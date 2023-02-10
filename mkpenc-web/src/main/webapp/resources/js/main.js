

function mbr_NoticeInsertEventCallback(data){
	
	if(data.Rtn == 1){
		alert("공지사항 등록을  완료 합니다..!!");
		sendPage(1);
	}else {
		alert("공지사항 등록에 오류가 발생했습니다..!!");
	}
}

function mbr_NoticeUpdateEventCallback(data){
	
	if(data.Rtn == 1){
		alert("공지사항 수정을  완료 합니다..!!");
		sendPage(1);
	}else {
		alert("공지사항 수정에 오류가 발생했습니다..!!");
	}
}


function mbr_NoticeDeleteEventCallback(data){
	
	if(data.Rtn == 1){
		alert("공지사항 삭제을  완료 합니다..!!");
		sendPage(1);
	}else {
		alert("공지사항 삭제에 오류가 발생했습니다..!!");
	}
}
