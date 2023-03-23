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
        <link rel="stylesheet" href="<c:url value="/resources/font/font.css" />">
        <link href="https://fonts.googleapis.com/css?family=Nanum+Brush+Script" rel="stylesheet">
        <style>
            table {
                margin-bottom: 1em;
            }

            table td {
                padding: 3px;
            }

            .table1 {
                border: 1px solid red;
            }

            .table2,.table2 td {
                border: 1px solid silver;
                border-collapse: collapse;
            }

            .table2 td:first-child {
                background-color: lightblue;
            }

            .CSSTableGenerator {
                margin: 0px;
                padding: 0px;
                width: 100%;
                box-shadow: 10px 10px 5px #888888;
                border: 1px solid #000000;
                -moz-border-radius-bottomleft: 0px;
                -webkit-border-bottom-left-radius: 0px;
                border-bottom-left-radius: 0px;
                -moz-border-radius-bottomright: 0px;
                -webkit-border-bottom-right-radius: 0px;
                border-bottom-right-radius: 0px;
                -moz-border-radius-topright: 0px;
                -webkit-border-top-right-radius: 0px;
                border-top-right-radius: 0px;
                -moz-border-radius-topleft: 0px;
                -webkit-border-top-left-radius: 0px;
                border-top-left-radius: 0px;
            }

            .CSSTableGenerator table {
                border-collapse: collapse;
                border-spacing: 0;
                width: 100%;
                height: 100%;
                margin: 0px;
                padding: 0px;
            }

            .CSSTableGenerator tr:last-child td:last-child {
                -moz-border-radius-bottomright: 0px;
                -webkit-border-bottom-right-radius: 0px;
                border-bottom-right-radius: 0px;
            }

            .CSSTableGenerator table tr:first-child td:first-child {
                -moz-border-radius-topleft: 0px;
                -webkit-border-top-left-radius: 0px;
                border-top-left-radius: 0px;
            }

            .CSSTableGenerator table tr:first-child td:last-child {
                -moz-border-radius-topright: 0px;
                -webkit-border-top-right-radius: 0px;
                border-top-right-radius: 0px;
            }

            .CSSTableGenerator tr:last-child td:first-child {
                -moz-border-radius-bottomleft: 0px;
                -webkit-border-bottom-left-radius: 0px;
                border-bottom-left-radius: 0px;
            }

            .CSSTableGenerator tr:hover td {

            }

            .CSSTableGenerator tr:nth-child(odd) {
                background-color: #ffaa56;
            }

            .CSSTableGenerator tr:nth-child(even) {
                background-color: #ffffff;
            }

            .CSSTableGenerator td {
                vertical-align: middle;
                border: 1px solid #000000;
                border-width: 0px 1px 1px 0px;
                text-align: left;
                padding: 7px;
                font-size: 10px;
                font-family: Arial;
                font-weight: normal;
                color: #000000;
            }

            .CSSTableGenerator tr:last-child td {
                border-width: 0px 1px 0px 0px;
            }

            .CSSTableGenerator tr td:last-child {
                border-width: 0px 0px 1px 0px;
            }

            .CSSTableGenerator tr:last-child td:last-child {
                border-width: 0px 0px 0px 0px;
            }

            .CSSTableGenerator tr:first-child td {
                background: -o-linear-gradient(bottom, #ff7f00 5%, #bf5f00 100%);
                background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ff7f00), color-stop(1, #bf5f00));
                background: -moz-linear-gradient(center top, #ff7f00 5%, #bf5f00 100%);
                filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#ff7f00", endColorstr="#bf5f00");
                background: -o-linear-gradient(top, #ff7f00, bf5f00);
                background-color: #ff7f00;
                border: 0px solid #000000;
                text-align: center;
                border-width: 0px 0px 1px 1px;
                font-size: 14px;
                font-family: Arial;
                font-weight: bold;
                color: #ffffff;
            }

            .CSSTableGenerator tr:first-child:hover td {
                background: -o-linear-gradient(bottom, #ff7f00 5%, #bf5f00 100%);
                background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ff7f00), color-stop(1, #bf5f00));
                background: -moz-linear-gradient(center top, #ff7f00 5%, #bf5f00 100%);
                filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#ff7f00", endColorstr="#bf5f00");
                background: -o-linear-gradient(top, #ff7f00, bf5f00);
                background-color: #ff7f00;
            }

            .CSSTableGenerator tr:first-child td:first-child {
                border-width: 0px 0px 1px 0px;
            }

            .CSSTableGenerator tr:first-child td:last-child {
                border-width: 0px 0px 1px 1px;
            }
        </style>
    </head>
    <body>
        <div id="html" style='width: 560px;'>
            <table id="editorTitle" style="text-align:center; width:100%">
                <tbody>
                    <tr>
                        <td><span style="font-size:28px"><strong>시험성적서</strong></span></td>
                    </tr>
                </tbody>
            </table>

            <table id="editorRequestInfoTable" style="width:100%">
                <tbody>
                    <tr>
                        <td>
                            <p><span style="font-size:14px; font-family: 'Gungsuh'">- 시험기관 : 자동차부품연구원대구경북본부 </span></p>

                            <p><span style="font-size:14px">- 시료명 : Damper 2차 </span></p>

                            <p><span style="font-size:14px">- 측정장비 : 감쇠특성 측정장비</span></p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div>
            <a href="#drawImage" onclick="drawImage();">
                이미지
            </a>
            &nbsp;
            <a href="#drawText" onclick="drawText();">
                텍스트
            </a>
            &nbsp;
            <a href="#drawText" onclick="drawFontTest();">
                폰트
            </a>
            &nbsp;
            <a href="#drawText" onclick="drawHtmlTest();">
                테스트
            </a>
            &nbsp;
            <a href="#drawText" onclick="canvasTest();">
                cavas 테스
            </a>

        </div>
        <iframe id="view" style="position:absolute;top:0;right:0;height:100%; width:600px"></iframe>
    </body>

    <script src="<c:url value="/resources/vendor/jquery/dist/jquery.js" />" ></script>
    <script src="<c:url value="/resources/vendor/es6-promise/es6-promise.auto.min.js" />" ></script>
    <script src="<c:url value="/resources/vendor/jsPdf/jspdf.min.js" />" ></script>
    <script src="<c:url value="/resources/vendor/html2canvas/html2canvas.min.js" />" ></script>
    <script src="<c:url value="/resources/vendor/html2pdf/html2pdf.min.js" />" ></script>
    <script src="<c:url value="/resources/js/common.js" />"></script>
    <script>
        var drawText = function() {
            var element = document.getElementById('html');
            var opt = {
                margin:       0.5,
                filename:     'myfile.pdf',
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { scale: 2 },
                jsPDF:        { unit: 'in', format: 'a4', orientation: 'portrait' }
            };

            html2pdf().set(opt).from(element).outputPdf('dataurlnewwindow').then(function(pdf) {
                // $('#view').attr('src', pdf);
            });

            html2pdf().set(opt).from(element).outputPdf('datauristring').then(function(pdf) {
                $('#view').attr('src', pdf);
            });
        }
    </script>
</html>
