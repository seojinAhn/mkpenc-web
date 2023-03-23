<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/resources/inc/config.jsp" %>
<html>
    <head>
        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
            <meta name="description" content="TDMS">
            <meta name="keywords" content="TDMS">
            <title>${SYSTEM_TITLE_ADMIN}</title>
            <link rel="shortcut icon" type="image/x-icon" href="${CTX_PATH}/resources/images/logo_p.ico" />
        </head>

        <c:import url="/admin/decorator/scriptDecorator" />
    </head>
    <body>
        <div class="wrapper">
            <div class="abs-center wd-xl pt-5" style="height: 100%;">
                <!-- START card-->
                <div class="text-center mb-4">
                    <div class="mb-3">
                        <em class="fa fa-wrench fa-5x text-muted"></em>
                    </div>
                    <div class="text-lg mb-3">500</div>
                    <p class="lead m-0">에러가 발생하였습니다.</p>
                    <%--<p>Don't worry, we're now checking this.</p>--%>
                    <%--<p>In the meantime, please try one of those links below or come back in a moment</p>--%>
                </div>

            </div>
        </div>
    </body>
</html>