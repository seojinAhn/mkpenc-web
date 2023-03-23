<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://onmakers.com/function" prefix="fnc" %>

<div class="layer layer-fixed layer-tr"> <!-- layer-ad( 오늘하루그만보기가 있는 광고형 팝업 ), layer-tr( 팝업상단에 아이콘이있는 팝업 (튜닝룸) ) -->
    <!-- relative -->
    <div class="layer-relative">
        <!-- table -->
        <div class="layer-table">
            <!-- cell -->
            <div class="layer-cell">

                <!-- 틀 -->
                <div class="layer-frame">
                    <!-- 팝업 상단 -->
                    <div class="layer-top layer-top2">
                        <strong class="layer-title"></strong>
                    </div>
                    <!-- // 팝업 상단 -->
                    <!-- 팝업 컨텐츠 -->
                    <div class="layer-body">
                        <!-- 팝업 실 컨텐츠 -->
                        <div class="layer-contents">

                            <!-- 튜닝룸 저장 -->
                            <div class="paidservice">
                                <strong>유료 서비스 안내</strong>
                                <p>현재 서비스는 <b>향 후 유료서비스로 제공될 예정</b>입니다.<br/>서비스 이용에 참고하여 주시기 바랍니다.</p>


                            </div>
                            <!-- // 튜닝룸 저장 -->
                        </div>
                        <!-- // 팝업 실 컨텐츠 -->
                        <!-- 팝업 하단 공용버튼 -->
                        <div class="layer-publicbtn"><!-- 버튼이 2개일때 lp-two 더블클래스로 추가 -->
                            <a href="#tempPay" id="goTempPay" class="background-0f94dc">
                                <div>
                                    <div><span>확인</span></div>
                                </div>
                            </a>
                        </div>
                        <!-- // 팝업 하단 공용버튼 -->
                    </div>
                    <!-- // 팝업 컨텐츠 -->
                    <!-- 팝업닫기 -->
                    <a href="javascript:;" title="닫기" class="layer-close"><img src="/resources/img/icon/layer-close.png" alt="레이어 닫기"></a>
                    <!-- // 팝업닫기 -->
                </div>
                <!-- // 틀 -->

            </div>
            <!-- // cell -->
        </div>
        <!-- // table -->
    </div>
    <!-- // relative -->
</div>

<script type="text/javascript">
    $(document).ready(function(){

        //팝업 닫기
        $(".layer-close").on("click",function(e){
            e.preventDefault();
            $("#popup_div").empty();
            $("#popup_div").css("display", "none");
            $("body").css("overflow", "");

            var type = '${param.type}';
        });

        //로그인 하러 가기
        $("#moveToLogin").on("click", function(e){
            e.preventDefault();
            window.location.href="/member/login?menuId=M0201";
        });

        $('#goTempPay').on('click', function(){
            var cate = '${param.cate}';


            if(cate === 'tuning') {

                $(".layer-close").trigger('click');
            } else
                setTempPay();
            // $(".layer-close").trigger('click');
        });
    });
</script>