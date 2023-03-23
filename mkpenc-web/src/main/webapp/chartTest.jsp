<%--
  Created by IntelliJ IDEA.
  User: JYH
  Date: 2019-01-11
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/resources/inc/config.jsp" %>
<html>
    <head>
        <title>Title</title>
        <script src="<c:url value="/resources/vendor/jquery/dist/jquery.js" />" ></script>
        <script src="<c:url value="/resources/vendor/jquery.blockUI/jquery.blockUI.js" />"></script>
        <script src="<c:url value="/resources/vendor/d3/d3.js" />"></script>
        <script src="<c:url value="/resources/vendor/conrec/conrec.js" />"></script>
        <script src="/resources/vendor/plotly/dist/plotly.js"></script>
        <script src="/resources/vendor/plotly/dist/plotly-locale-ko.js"></script>
        <script src="<c:url value="/resources/js/common.js" />"></script>

    </head>
    <body>
        <div id="myDiv" style="width:1000px;height:700px;"></div>
        <div id="myDiv2" style="width:500px;height:500px;"></div>

        <form id="hiddenFrm">
            <input type="hidden" name="menuId" value="M010101"/>
        </form>
    </body>
    <%--<script>--%>
        <%--var min = -20, max = 0;--%>
        <%--var x = [-15, -4.97863321087328];--%>
        <%--var y = [-1586.73831753011, -346.67894244194];--%>
        <%--var m = (y[0] - y[1]) / (x[0] - x[1]);--%>

        <%--var y3 = m * (min-x[0]) + y[0];--%>
        <%--var y4 = m * (max-x[1]) + y[1];--%>

        <%--console.log(y3 - y[0]);--%>
        <%--console.log(y4 - y[1]);--%>

        <%--x.unshift(min);--%>
        <%--x.push(max);--%>
        <%--y.unshift(y3);--%>
        <%--y.push(y4);--%>

        <%--console.log(x, y);--%>

        <%--var data = {--%>
        <%--x: x,--%>
        <%--y: y,--%>
        <%--type: 'lines'--%>
        <%--};--%>

        <%--Plotly.newPlot('myDiv', [data]);--%>

    <%--</script>--%>
    <script>
        var layout = {
            title: 'Test'
        };
        var data = {
            x: [],
            y: [],
            z: [],
            type: 'contour',
            colorscale: 'Jet',
            // autocontour: false,
            contours: {
                start: 0,
                end: 100,
                size: 500
            }
        };

        var getData = function() {
            $.ajax({
                type: "get",
                dataType: 'text',
                url: '/resources/cccc.json',
                success: function(result) {
                    var data = JSON.parse(result.replace(/\bNaN\b/g, "null"));
                    document.testData = data
                    Plotly.newPlot('myDiv', [{
                        z: data.z,
                        x: data.xi.x[0],
                        type: 'contour',
                        colorscale: 'Jet',
                        autocontour: false,
                        contours: {
                            start: 97.33404255,
                            end: 89.24,
                            size: 0.269,
                            type: 'levels',
                            showlines: false
                        },
                        zmin: 89.24,
                        zmax: 97.33404255

                    }], layout);
                },
                error: function(a, b, c) {
                    console.log(a, b, c)
                }
            });
        };
        getData();
    </script>
</html>
