var modalIndex = 9999;

/* 레이어 생성
cls : class
cont : 내용
기본 : 숨기기
*/
function layer_pop_crt(id) {
 if(!id) return false;
  $('#'+id).show();
  if(getLayerCnt() < 2){
	$('.mask').show();
  }

 return true;
}

/* 레이어 팝업
oj : 레이어 객체
*/
function layer_pop_center(oj,index) {
 if(!oj || !$(oj).length) return false;
 oj.layer_pop_center_set(index);
}

/* 레이어 팝업 위치 설정 */
$.fn.layer_pop_center_set = function (index) {

 this.css("position", "fixed");
 
// 	console.log("windowHeight:"+$(window).height()+", outerHeight:"+$(this).outerHeight()+", scrollTop:"+$(window).scrollTop());
// 	console.log("windowWidth:"+$(window).width()+", outerWidth:"+$(this).outerWidth()+", scrollLeft:"+$(window).scrollLeft());
 
    //this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    //this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	//this.css("top", (($(window).height() - $(this).height()) / 2) + $(window).scrollTop() + "px");
	//this.css("left",(($(window).width() - $(this).width()) / 2) + $(window).scrollLeft() + "px");
 
 	var layerTop = (($(window).height() - $(this).height()) / 2);
 	var layerLeft = (($(window).width() - $(this).width()) / 2);
 	
 	if($(window).width() < 840){
 		layerTop = 0;
 		layerLeft = 0;
 	}
 	
	this.css("top", layerTop + "px");
	this.css("left", layerLeft + "px");
    this.css("z-index", index);

    return this;
}


 function closeLayer(id){ 
  $('#'+id).hide();
  if(getLayerCnt() < 1){
	$('.mask').hide();
  }
} 

function openLayer(id){
	modalIndex++;
	//console.log("modalIndex:"+modalIndex);
	if(layer_pop_crt(id)) {
	   layer_pop_center($('#'+id),modalIndex);
	   $('#'+id).fadeIn(500);
	  }
}

function getLayerCnt(){
	var layerCnt = 0;
	$('[name^=modal]').each(function(i) {
		if('block' == $(this).css('display')){
			layerCnt++;
		}
	});
	//console.log(layerCnt);
	return layerCnt;
}
/* 화면을 불러온 후 처리 */
$(document).ready(function() {

 $('.mask').click(function () {
	if(getLayerCnt() < 2){
		$(this).hide();
		$('[name^=modal]').each(function(i) {
			$(this).hide();
		});
	}
 });
});

// 브라우저 창 크기 변경에 따른 처리
$(window).resize(function() {
 //$('[name^=modal]').each(function(i) {
  $('[name^=modal]').each(function(i){
	layer_pop_center($(this),9999);
 });
});



$(document).ready(function() {
	$('.list_table tbody tr').click(function () {
		$(this).addClass("highlight");
		$(this).siblings().removeClass("highlight");
	});
});

$(document).ready(function() {
	$('.toggle_block').click(function () {
		$(this).toggleClass("dp_flex");
	});
});


