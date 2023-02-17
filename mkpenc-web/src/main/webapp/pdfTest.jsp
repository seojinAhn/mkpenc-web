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
        <link href="https://fonts.googleapis.com/css?family=Laila" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
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
            <h1>Tables</h1>
            <table class='table1'>
                <tr>
                    <td>Item</td>
                    <td>Cost</td>
                    <td>Description</td>
                    <td>Available</td>
                </tr>
                <tr>
                    <td>Milk</td>
                    <td>$1.00</td>
                    <td>Hello PDF World</td>
                    <td>Out Of Stock</td>
                </tr>
                <tr>
                    <td>Milk</td>
                    <td>$1.00</td>
                    <td>Hello PDF World</td>
                    <td>Out Of Stock</td>
                </tr>
            </table>
            <table class='table2' style="width: 500px;">
                <tr>
                    <td>Item</td>
                    <td>Cost</td>
                    <td>Description</td>
                    <td>Available</td>
                </tr>
                <tr>
                    <td>Milk</td>
                    <td>$1.00</td>
                    <td>Hello PDF World</td>
                    <td>Out Of Stock</td>
                </tr>
                <tr>
                    <td>Milk</td>
                    <td>$1.00</td>
                    <td>Hello PDF World</td>
                    <td>Out Of Stock</td>
                </tr>
            </table>

            <table class='CSSTableGenerator'>
                <tr>
                    <td>Item</td>
                    <td>Cost</td>
                    <td>Description</td>
                    <td>Available</td>
                </tr>
                <tr>
                    <td>Milk</td>
                    <td>$1.00</td>
                    <td>Hello PDF World</td>
                    <td>Out Of Stock</td>
                </tr>
                <tr>
                    <td style="font-family: 'Nanum Myeongjo', serif; font-style: normal; font-size: 15px;">Milk 정영호</td>
                    <td>$1.00</td>
                    <td>Hello PDF World</td>
                    <td>Available</td>
                </tr>
                <tr>
                    <td colspan="4">
                        <img width="500" src="http://localhost:8080/file/download?div=report&amp;pathType=hdfs&amp;menuId=M010401&amp;seq=399" />
                    </td>
                </tr>
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
    <script src="<c:url value="/resources/vendor/jsPdf/html2canvas.min.js" />" ></script>
    <script src="<c:url value="/resources/vendor/jsPdf/jspdf.debug.js" />" ></script>
    <script src="<c:url value="/resources/vendor/pdfmake/build/vfs_fonts_kr2.js" />" ></script>
    <script src="<c:url value="/resources/js/common.js" />"></script>
    <script>


        var drawImage = function() {
            html2canvas($("#html")[0]).then(function(canvas) {
                var imgData = canvas.toDataURL('image/png');

                document.pdf1 = new jsPDF('p', 'pt', 'a4');
                document.pdf1.addImage(imgData, 'PNG', 0, 0);

                $('#view').attr('src', document.pdf1.output('datauristring'));
            });
        };

        var drawText = function() {
            document.pdf2 = new jsPDF('p', 'pt', 'letter');
            var width = 600;
            document.body.style.width=width + "px";

            document.pdf2.addFileToVFS('NanumMyeongjo-Regular.ttf', pdfMake.vfs["NanumMyeongjo-Regular.ttf"]);
            document.pdf2.addFileToVFS('JosefinSans-Regular.ttf', pdfMake.vfs["JosefinSans-Regular.ttf"]);

            document.pdf2.addFont('JosefinSans-Regular.ttf', 'JosefinSans', 'normal');
            document.pdf2.addFont('NanumMyeongjo-Regular.ttf', 'Nanum Myeongjo', 'serif');


            document.pdf2.html($("#html")[0], {callback: function(pdf) {
                    $('#view').attr('src', document.pdf2.output('datauristring'));
                }
            });

        };

        var drawFontTest = function() {
            document.pdf3 = new jsPDF();
            document.pdf3.addFileToVFS('NanumMyeongjo-Regular.ttf', pdfMake.vfs["NanumMyeongjo-Regular.ttf"]);
            document.pdf3.addFileToVFS('JosefinSans-Regular.ttf', pdfMake.vfs["JosefinSans-Regular.ttf"]);



            document.pdf3.addFont('JosefinSans-Regular.ttf', 'JosefinSans', 'normal');
            document.pdf3.addFont('NanumMyeongjo-Regular.ttf', 'NanumMyeongjo', 'normal');

            document.pdf3.setFont('NanumMyeongjo');
            document.pdf3.setFontSize(50);
            document.pdf3.text("테스트 입니다~~~", 10, 40);

            document.pdf3.setFont('JosefinSans');
            document.pdf3.setFontSize(50);
            document.pdf3.text("테스트 입니다~~~", 10, 80);


            document.pdf3.setFont('JosefinSans');
            document.pdf3.setFontSize(50);
            document.pdf3.text("Test", 10, 120);


            $('#view').attr('src', document.pdf3.output('datauristring'));
        };

        var drawHtmlTest = function() {
            document.pdf4 = new jsPDF('p','in','letter')
                , source = $('#html2')[0]
                , specialElementHandlers = {
                '#bypassme': function(element, renderer){
                    return true
                }
            }

            document.pdf4.fromHTML(
                source // HTML string or DOM elem ref.
                , 0.5 // x coord
                , 0.5 // y coord
                , {
                    'width':7.5 // max width of content on PDF
                    , 'elementHandlers': specialElementHandlers
                }
            )

            $('#view').attr('src', document.pdf4.output('datauristring'));
        }


        var canvasTest = function() {
            html2canvas($("#html")[0]).then(function(canvas) {
                document.body.appendChild(canvas);
            });
        }

        // , {
        //     onrendered: function(canvas){
        //         console.log('aaaaaa');
        //         var imgData = canvas.toDataURL('image/png');
        //         console.log(imgData);
        //
        //         var pdf = new jsPDF('p', 'pt', 'a4');
        //         pdf.addImage(imgData, 'PNG', 0, 0);
        //         pdf.save('aaa.pdf');
        //
        //         // var iframe = document.createElement('iframe');
        //         // iframe.setAttribute('style', 'position:absolute;top:0;right:0;height:100%; width:600px');
        //         // document.body.appendChild(iframe);
        //         // iframe.src = pdf.output('datauristring');
        //     }
        // });
    </script>
</html>
