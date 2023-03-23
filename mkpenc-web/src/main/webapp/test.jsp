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
        <script src="/resources/vendor/plotly/dist/plotly.js"></script>
        <script src="/resources/vendor/plotly/dist/plotly-locale-ko.js"></script>
        <script src="<c:url value="/resources/js/common.js" />"></script>

    </head>
    <body>
        <div id="myDiv3" style="width:90%;height:500px;"></div>
        <div id="myDiv" style="width:90%;height:500px;"></div>
        <div id="myDiv2" style="width:90%;height:500px;"></div>
        <img src="" id="testImage" />
    </body>
    <script>


        var data = [ {
            z: [[10, 10.625, 12.5, 15.625, 20],
                [5.625, 6.25, 8.125, 11.25, 15.625],
                [2.5, 3.125, 5.0, 8.125, 12.5],
                [0.625, 1.25, 3.125, 6.25, 10.625],
                [0, 0.625, 2.5, 5.625, 10]],
            type: 'contour'
        }
        ];

        var layout = {
            title: 'Basic Contour Plot'
        }

        Plotly.newPlot('myDiv3', data, layout);



        var trace1 = {
            x: [1, 2, 3],
            y: [4, 5, 6],
            name: 'yaxis1 data',
            type: 'lines'
        };

        var trace2 = {
            x: [2, 3, 4],
            y: [40, 50, 60],
            name: 'yaxis2 data',
            yaxis: 'y2',
            type: 'lines'
        };

        var trace3 = {
            x: [4, 5, 6],
            y: [40000, 50000, 60000],
            name: 'yaxis3 data',
            yaxis: 'y3',
            type: 'lines'
        };

        var trace4 = {
            x: [5, 6, 7],
            y: [400000, 500000, 600000],
            name: 'yaxis4 data',
            yaxis: 'y4',
            type: 'lines'
        };

        var data = [trace1, trace2, trace3, trace4];

        var layout = {
            title: 'multiple y-axes example',
            xaxis: {domain: [0.3, 0.7]},
            yaxis: {
                title: 'yaxis title',
                titlefont: {color: '#1f77b4'},
                tickfont: {color: '#1f77b4'}
            },
            yaxis2: {
                title: 'yaxis2 title',
                titlefont: {color: '#ff7f0e'},
                tickfont: {color: '#ff7f0e'},
                anchor: 'free',
                overlaying: 'y',
                side: 'left',
                position: 0.15
            },
            yaxis3: {
                title: 'yaxis4 title',
                titlefont: {color: '#d62728'},
                tickfont: {color: '#d62728'},
                anchor: 'x',
                overlaying: 'y',
                side: 'right'
            },
            yaxis4: {
                title: 'yaxis5 title',
                titlefont: {color: '#9467bd'},
                tickfont: {color: '#9467bd'},
                anchor: 'free',
                overlaying: 'y',
                side: 'right',
                position: 0.85
            }
        };

        Plotly.newPlot('myDiv', data, layout);

        $.ajax({
            type: "get",
            url: '/resources/testdata.json',
            success: function (result) {
                document.testData = result;

                var layout2 = {
                    showlegend: true,
                    yaxis: {
                        title: 'yaxis title',
                        titlefont: {color: '#1f77b4'},
                        tickfont: {color: '#1f77b4'}
                    },
                    yaxis2: {
                        title: 'yaxis2 title',
                        titlefont: {color: '#ff7f0e'},
                        tickfont: {color: '#ff7f0e'},
                        anchor: 'free',
                        overlaying: 'y',
                        side: 'left',
                        position: 0.15
                    },
                    yaxis3: {
                        title: 'yaxis4 title',
                        titlefont: {color: '#d62728'},
                        tickfont: {color: '#d62728'},
                        anchor: 'x',
                        overlaying: 'y',
                        side: 'right'
                    },
                    yaxis4: {
                        title: 'yaxis5 title',
                        titlefont: {color: '#d62728'},
                        tickfont: {color: '#d62728'},
                        anchor: 'free',
                        overlaying: 'y',
                        side: 'right',
                        position: 0.85
                    },
                    yaxis5: {
                        title: 'yaxis6 title',
                        titlefont: {color: '#ff7f0e'},
                        tickfont: {color: '#ff7f0e'},
                        anchor: 'free',
                        overlaying: 'y',
                        side: 'left',
                        position: 0.3
                    }
                };


                var data2 = [{
                    x: result.TimeSeries,
                    y: result.TORQUE,
                    mode: 'lines',
                    name: 'aaaa',
                }];

                data2.push({
                    x: result.TimeSeries,
                    y: result.SPEED,
                    mode: 'lines',
                    name: 'bbbb',
                    yaxis: 'y2'
                });

                data2.push({
                    x: result.TimeSeries,
                    y: result.VOLT_UV,
                    mode: 'lines',
                    name: 'bbbb',
                    yaxis: 'y3'
                });

                data2.push({
                    x: result.TimeSeries,
                    y: result.VOLT_UV,
                    mode: 'lines',
                    name: 'dddd',
                    yaxis: 'y4'
                });
                data2.push({
                    x: result.TimeSeries,
                    y: result.SPEED,
                    mode: 'lines',
                    name: 'eeee',
                    yaxis: 'y5'
                });




                Plotly.newPlot('myDiv2', data2, layout)

            }
        });

        var imageUrl = function() {
            Plotly.toImage('myDiv', {format:'png',height:400,width:400})
                .then(function(url) {
                    console.log(url);
                    $('#testImage').attr('src', url)
                });
        }
    </script>
</html>
