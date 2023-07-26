function mimicCallback(data) {
	var searchTime = data.SearchTime;
	var color = data.ForeColor;
	setDate(searchTime,color);
	
	lblDataListAjax = data.lblDataList;
	DccTagInfoListAjax = data.DccTagInfoList;
	
	setData();
}