<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>월성 3,4 호기 원격감시시스템</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/style.css" />">
<script type="text/javascript" src="<c:url value="/resources/jquery/jquery-1.10.0.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/modal.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/common.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/login.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/resources/js/tip.js" />" charset="utf-8"></script>

<script type="text/javascript">
	var timerOn = false;
</script>

</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-dcc-header.jspf" %>
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>원자료 출력 환산표</h3>
				<div class="bc"><span>DCC</span><span>Tip</span><strong>원자료 출력 환산표</strong></div>
			</div>
			<!-- //page_title -->
            <!-- fx_layout -->
            <div class="fx_layout">
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>% FP</th>
                                    <th>FP</th>
                                    <th>DECADE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tr">0.00001</td>
                                    <td class="tr">0.0000001</td>
                                    <td class="tr">-7.0000</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.00003</td>
                                    <td class="tr">0.0000003</td>
                                    <td class="tr">-6.5229</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.00005</td>
                                    <td class="tr">0.0000005</td>
                                    <td class="tr">-6.3010</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.00007</td>
                                    <td class="tr">0.0000007</td>
                                    <td class="tr">-6.1549</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.00009</td>
                                    <td class="tr">0.0000009</td>
                                    <td class="tr">-6.0458</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.0001</td>
                                    <td class="tr">0.000001</td>
                                    <td class="tr">-6.0000</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.0002</td>
                                    <td class="tr">0.000002</td>
                                    <td class="tr">-5.6990</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.0003</td>
                                    <td class="tr">0.000003</td>
                                    <td class="tr">-5.5229</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.0004</td>
                                    <td class="tr">0.000004</td>
                                    <td class="tr">-5.3979</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.0005</td>
                                    <td class="tr">0.000005</td>
                                    <td class="tr">-5.3010</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.0006</td>
                                    <td class="tr">0.000006</td>
                                    <td class="tr">-5.2218</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.0007</td>
                                    <td class="tr">0.000007</td>
                                    <td class="tr">-5.1549</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.0008</td>
                                    <td class="tr">0.000008</td>
                                    <td class="tr">-5.0969</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.0009</td>
                                    <td class="tr">0.000009</td>
                                    <td class="tr">-5.0458</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.001</td>
                                    <td class="tr">0.00001</td>
                                    <td class="tr">-5.0000</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.002</td>
                                    <td class="tr">0.00002</td>
                                    <td class="tr">-4.6990</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.003</td>
                                    <td class="tr">0.00003</td>
                                    <td class="tr">-4.5229</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.004</td>
                                    <td class="tr">0.00004</td>
                                    <td class="tr">-4.3979</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.005</td>
                                    <td class="tr">0.00005</td>
                                    <td class="tr">-4.3010</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.006</td>
                                    <td class="tr">0.00006</td>
                                    <td class="tr">-4.2218</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.007</td>
                                    <td class="tr">0.00007</td>
                                    <td class="tr">-4.1549</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.008</td>
                                    <td class="tr">0.00008</td>
                                    <td class="tr">-4.0969</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.009</td>
                                    <td class="tr">0.00009</td>
                                    <td class="tr">-4.0458</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.01</td>
                                    <td class="tr">0.0001</td>
                                    <td class="tr">-4.0000</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.02</td>
                                    <td class="tr">0.0002</td>
                                    <td class="tr">-3.6990</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.03</td>
                                    <td class="tr">0.0003</td>
                                    <td class="tr">-3.5229</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.04</td>
                                    <td class="tr">0.0004</td>
                                    <td class="tr">-3.3979</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.05</td>
                                    <td class="tr">0.0005</td>
                                    <td class="tr">-3.3010</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.06</td>
                                    <td class="tr">0.0006</td>
                                    <td class="tr">-3.2218</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.07</td>
                                    <td class="tr">0.0007</td>
                                    <td class="tr">-3.1549</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>% FP</th>
                                    <th>FP</th>
                                    <th>DECADE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tr">0.08</td>
                                    <td class="tr">0.0008</td>
                                    <td class="tr">-3.0969</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.09</td>
                                    <td class="tr">0.0009</td>
                                    <td class="tr">-3.0458</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.1</td>
                                    <td class="tr">0.001</td>
                                    <td class="tr">-3.0000</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.2</td>
                                    <td class="tr">0.002</td>
                                    <td class="tr">-2.6990</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.3</td>
                                    <td class="tr">0.003</td>
                                    <td class="tr">-2.5229</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.4</td>
                                    <td class="tr">0.004</td>
                                    <td class="tr">-2.3979</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.5</td>
                                    <td class="tr">0.005</td>
                                    <td class="tr">-2.3010</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.6</td>
                                    <td class="tr">0.006</td>
                                    <td class="tr">-2.2218</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.7</td>
                                    <td class="tr">0.007</td>
                                    <td class="tr">-2.1549</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.8</td>
                                    <td class="tr">0.008</td>
                                    <td class="tr">-2.0969</td>
                                </tr>
                                <tr>
                                    <td class="tr">0.9</td>
                                    <td class="tr">0.009</td>
                                    <td class="tr">-2.0458</td>
                                </tr>
                                <tr>
                                    <td class="tr">1.0</td>
                                    <td class="tr">0.010</td>
                                    <td class="tr">-2.0000</td>
                                </tr>
                                <tr>
                                    <td class="tr">1.5</td>
                                    <td class="tr">0.015</td>
                                    <td class="tr">-1.8329</td>
                                </tr>
                                <tr>
                                    <td class="tr">2.0</td>
                                    <td class="tr">0.020</td>
                                    <td class="tr">-1.6990</td>
                                </tr>
                                <tr>
                                    <td class="tr">2.5</td>
                                    <td class="tr">0.025</td>
                                    <td class="tr">-1.6021</td>
                                </tr>
                                <tr>
                                    <td class="tr">3.0</td>
                                    <td class="tr">0.030</td>
                                    <td class="tr">-1.5229</td>
                                </tr>
                                <tr>
                                    <td class="tr">3.5</td>
                                    <td class="tr">0.035</td>
                                    <td class="tr">-1.4559</td>
                                </tr>
                                <tr>
                                    <td class="tr">4.0</td>
                                    <td class="tr">0.040</td>
                                    <td class="tr">-1.3979</td>
                                </tr>
                                <tr>
                                    <td class="tr">4.5</td>
                                    <td class="tr">0.045</td>
                                    <td class="tr">-1.3468</td>
                                </tr>
                                <tr>
                                    <td class="tr">5.0</td>
                                    <td class="tr">0.050</td>
                                    <td class="tr">-1.3010</td>
                                </tr>
                                <tr>
                                    <td class="tr">5.5</td>
                                    <td class="tr">0.055</td>
                                    <td class="tr">-1.2596</td>
                                </tr>
                                <tr>
                                    <td class="tr">6.0</td>
                                    <td class="tr">0.060</td>
                                    <td class="tr">-1.2218</td>
                                </tr>
                                <tr>
                                    <td class="tr">6.5</td>
                                    <td class="tr">0.065</td>
                                    <td class="tr">-1.1871</td>
                                </tr>
                                <tr>
                                    <td class="tr">7.0</td>
                                    <td class="tr">0.070</td>
                                    <td class="tr">-1.1549</td>
                                </tr>
                                <tr>
                                    <td class="tr">7.5</td>
                                    <td class="tr">0.075</td>
                                    <td class="tr">-1.1249</td>
                                </tr>
                                <tr>
                                    <td class="tr">8.0</td>
                                    <td class="tr">0.080</td>
                                    <td class="tr">-1.0969</td>
                                </tr>
                                <tr>
                                    <td class="tr">8.5</td>
                                    <td class="tr">0.085</td>
                                    <td class="tr">-1.0706</td>
                                </tr>
                                <tr>
                                    <td class="tr">9.0</td>
                                    <td class="tr">0.090</td>
                                    <td class="tr">-1.0458</td>
                                </tr>
                                <tr>
                                    <td class="tr">9.5</td>
                                    <td class="tr">0.095</td>
                                    <td class="tr">-1.0223</td>
                                </tr>
                                <tr>
                                    <td class="tr">10.0</td>
                                    <td class="tr">0.10</td>
                                    <td class="tr">-1.0000</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>% FP</th>
                                    <th>FP</th>
                                    <th>DECADE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tr">12</td>
                                    <td class="tr">0.12</td>
                                    <td class="tr">-0.9208</td>
                                </tr>
                                <tr>
                                    <td class="tr">14</td>
                                    <td class="tr">0.14</td>
                                    <td class="tr">-0.8539</td>
                                </tr>
                                <tr>
                                    <td class="tr">16</td>
                                    <td class="tr">0.16</td>
                                    <td class="tr">-0.7959</td>
                                </tr>
                                <tr>
                                    <td class="tr">18</td>
                                    <td class="tr">0.18</td>
                                    <td class="tr">-0.7447</td>
                                </tr>
                                <tr>
                                    <td class="tr">20</td>
                                    <td class="tr">0.20</td>
                                    <td class="tr">-0.6990</td>
                                </tr>
                                <tr>
                                    <td class="tr">22</td>
                                    <td class="tr">0.22</td>
                                    <td class="tr">-0.6576</td>
                                </tr>
                                <tr>
                                    <td class="tr">24</td>
                                    <td class="tr">0.24</td>
                                    <td class="tr">-0.6198</td>
                                </tr>
                                <tr>
                                    <td class="tr">26</td>
                                    <td class="tr">0.26</td>
                                    <td class="tr">-0.5850</td>
                                </tr>
                                <tr>
                                    <td class="tr">28</td>
                                    <td class="tr">0.28</td>
                                    <td class="tr">-0.5528</td>
                                </tr>
                                <tr>
                                    <td class="tr">30</td>
                                    <td class="tr">0.30</td>
                                    <td class="tr">-0.5529</td>
                                </tr>
                                <tr>
                                    <td class="tr">32</td>
                                    <td class="tr">0.32</td>
                                    <td class="tr">-0.4949</td>
                                </tr>
                                <tr>
                                    <td class="tr">34</td>
                                    <td class="tr">0.34</td>
                                    <td class="tr">-0.4685</td>
                                </tr>
                                <tr>
                                    <td class="tr">36</td>
                                    <td class="tr">0.36</td>
                                    <td class="tr">-0.4437</td>
                                </tr>
                                <tr>
                                    <td class="tr">38</td>
                                    <td class="tr">0.38</td>
                                    <td class="tr">-0.4202</td>
                                </tr>
                                <tr>
                                    <td class="tr">40</td>
                                    <td class="tr">0.40</td>
                                    <td class="tr">-0.3979</td>
                                </tr>
                                <tr>
                                    <td class="tr">42</td>
                                    <td class="tr">0.42</td>
                                    <td class="tr">-0.3768</td>
                                </tr>
                                <tr>
                                    <td class="tr">44</td>
                                    <td class="tr">0.44</td>
                                    <td class="tr">-0.3565</td>
                                </tr>
                                <tr>
                                    <td class="tr">46</td>
                                    <td class="tr">0.46</td>
                                    <td class="tr">-0.3372</td>
                                </tr>
                                <tr>
                                    <td class="tr">48</td>
                                    <td class="tr">0.48</td>
                                    <td class="tr">-0.3188</td>
                                </tr>
                                <tr>
                                    <td class="tr">50</td>
                                    <td class="tr">0.50</td>
                                    <td class="tr">-0.3010</td>
                                </tr>
                                <tr>
                                    <td class="tr">52</td>
                                    <td class="tr">0.52</td>
                                    <td class="tr">-0.2840</td>
                                </tr>
                                <tr>
                                    <td class="tr">54</td>
                                    <td class="tr">0.54</td>
                                    <td class="tr">-0.2676</td>
                                </tr>
                                <tr>
                                    <td class="tr">56</td>
                                    <td class="tr">0.56</td>
                                    <td class="tr">-0.2518</td>
                                </tr>
                                <tr>
                                    <td class="tr">58</td>
                                    <td class="tr">0.58</td>
                                    <td class="tr">-0.2366</td>
                                </tr>
                                <tr>
                                    <td class="tr">60</td>
                                    <td class="tr">0.60</td>
                                    <td class="tr">-0.2218</td>
                                </tr>
                                <tr>
                                    <td class="tr">62</td>
                                    <td class="tr">0.62</td>
                                    <td class="tr">-0.2076</td>
                                </tr>
                                <tr>
                                    <td class="tr">64</td>
                                    <td class="tr">0.64</td>
                                    <td class="tr">-0.1938</td>
                                </tr>
                                <tr>
                                    <td class="tr">66</td>
                                    <td class="tr">0.66</td>
                                    <td class="tr">-0.1805</td>
                                </tr>
                                <tr>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                </tr>
                                <tr>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
                <div class="fx_block">
                    <!-- list_wrap -->
                    <div class="list_wrap">
                        <!-- list_table -->
                        <table class="list_table">
                            <colgroup>
                                <col />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>% FP</th>
                                    <th>FP</th>
                                    <th>DECADE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tr">68</td>
                                    <td class="tr">0.68</td>
                                    <td class="tr">-0.1675</td>
                                </tr>
                                <tr>
                                    <td class="tr">70</td>
                                    <td class="tr">0.70</td>
                                    <td class="tr">-0.1549</td>
                                </tr>
                                <tr>
                                    <td class="tr">72</td>
                                    <td class="tr">0.72</td>
                                    <td class="tr">-0.1427</td>
                                </tr>
                                <tr>
                                    <td class="tr">74</td>
                                    <td class="tr">0.74</td>
                                    <td class="tr">-0.1308</td>
                                </tr>
                                <tr>
                                    <td class="tr">76</td>
                                    <td class="tr">0.76</td>
                                    <td class="tr">-0.1192</td>
                                </tr>
                                <tr>
                                    <td class="tr">78</td>
                                    <td class="tr">0.78</td>
                                    <td class="tr">-0.1079</td>
                                </tr>
                                <tr>
                                    <td class="tr">80</td>
                                    <td class="tr">0.80</td>
                                    <td class="tr">-0.0969</td>
                                </tr>
                                <tr>
                                    <td class="tr">82</td>
                                    <td class="tr">0.82</td>
                                    <td class="tr">-0.0862</td>
                                </tr>
                                <tr>
                                    <td class="tr">84</td>
                                    <td class="tr">0.84</td>
                                    <td class="tr">-0.0757</td>
                                </tr>
                                <tr>
                                    <td class="tr">86</td>
                                    <td class="tr">0.86</td>
                                    <td class="tr">-0.0655</td>
                                </tr>
                                <tr>
                                    <td class="tr">88</td>
                                    <td class="tr">0.88</td>
                                    <td class="tr">-0.0555</td>
                                </tr>
                                <tr>
                                    <td class="tr">90</td>
                                    <td class="tr">0.90</td>
                                    <td class="tr">-0.0458</td>
                                </tr>
                                <tr>
                                    <td class="tr">92</td>
                                    <td class="tr">0.92</td>
                                    <td class="tr">-0.0362</td>
                                </tr>
                                <tr>
                                    <td class="tr">94</td>
                                    <td class="tr">0.94</td>
                                    <td class="tr">-0.0269</td>
                                </tr>
                                <tr>
                                    <td class="tr">96</td>
                                    <td class="tr">0.96</td>
                                    <td class="tr">-0.0177</td>
                                </tr>
                                <tr>
                                    <td class="tr">98</td>
                                    <td class="tr">0.98</td>
                                    <td class="tr">-0.0088</td>
                                </tr>
                                <tr>
                                    <td class="tr">100</td>
                                    <td class="tr">1.00</td>
                                    <td class="tr">0.0000</td>
                                </tr>
                                <tr>
                                    <td class="tr">104</td>
                                    <td class="tr">1.04</td>
                                    <td class="tr">0.0170</td>
                                </tr>
                                <tr>
                                    <td class="tr">108</td>
                                    <td class="tr">1.08</td>
                                    <td class="tr">0.0334</td>
                                </tr>
                                <tr>
                                    <td class="tr">112</td>
                                    <td class="tr">1.12</td>
                                    <td class="tr">0.0492</td>
                                </tr>
                                <tr>
                                    <td class="tr">116</td>
                                    <td class="tr">1.16</td>
                                    <td class="tr">0.0645</td>
                                </tr>
                                <tr>
                                    <td class="tr">120</td>
                                    <td class="tr">1.20</td>
                                    <td class="tr">0.0792</td>
                                </tr>
                                <tr>
                                    <td class="tr">124</td>
                                    <td class="tr">1.24</td>
                                    <td class="tr">0.0934</td>
                                </tr>
                                <tr>
                                    <td class="tr">128</td>
                                    <td class="tr">1.28</td>
                                    <td class="tr">0.1072</td>
                                </tr>
                                <tr>
                                    <td class="tr">132</td>
                                    <td class="tr">1.32</td>
                                    <td class="tr">0.1206</td>
                                </tr>
                                <tr>
                                    <td class="tr">136</td>
                                    <td class="tr">1.36</td>
                                    <td class="tr">0.1335</td>
                                </tr>
                                <tr>
                                    <td class="tr">140</td>
                                    <td class="tr">1.40</td>
                                    <td class="tr">0.1461</td>
                                </tr>
                                <tr>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                </tr>
                                <tr>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                </tr>
                                <tr>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                    <td class="tr"></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //list_table -->
                    </div>
                    <!-- //list_wrap -->
                </div>
            </div>
            <!-- //fx_layout -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/include-footer.jspf" %>
	<!-- //footer -->
</div>
<!--  //wrap  -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap big" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>변수설정</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">
        <!-- form_wrap -->
        <div class="form_wrap">
            <!-- form_table -->
            <table class="form_table">
                <colgroup>
                    <col width="120px"/>
                    <col />
                </colgroup>
                <tr>
                    <th>Title</th>
                    <td>
                        <div class="fx_form">
                            <input type="text">
                            <a class="btn_list" herf="none">그룹추가</a>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //form_table -->
        </div>
        <!-- //form_wrap -->        
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                    <tr>
                        <td class="tc">3</td>
                        <td class="tc">X</td>
                        <td>DMAND.....</td>
                        <td class="tc">SC</td>
                        <td class="tc">3140</td>
                        <td class="tc">1</td>
                        <td class="tr">0</td>
                        <td class="tr">0</td>
                        <td class="tc">SC</td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
        </div>
        <!-- //list_wrap -->       
        <!-- list_wrap -->
        <div class="list_wrap">
            <!-- list_table -->
            <table class="list_table">
                <colgroup>
                    <col width="60px"/>
                    <col width="60px"/>
                    <col />
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                    <col width="80px"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>HOGI</th>
                        <th>XY</th>
                        <th>사용자지정이름</th>
                        <th>TYPE</th>
                        <th>ADDR</th>
                        <th>BIT</th>
                        <th>MIN</th>
                        <th>MAX</th>
                        <th>SCBIT</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <select>
                                <option>3</option>
                            </select>                        
                        </td>
                        <td>
                            <select>
                                <option>X</option>
                            </select>                        
                        </td>
                        <td><input type="text"></td>
                        <td>
                            <select>
                                <option>AI</option>
                            </select>                        
                        </td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td class="tc"><input type="checkbox"></td>
                    </tr>
                </tbody>
            </table>
            <!-- //list_table -->
            <!-- list_bottom -->
            <div class="list_bottom">
                <div class="button">
                    <a class="btn_list" href="#none">Tag Search</a>
                </div>
                <div class="button">
                    <a class="btn_list" href="#none">추가</a>
                    <a class="btn_list" href="#none">수정</a>
                    <a class="btn_list" href="#none">삭제</a>
                    <a class="btn_list" href="#none">위</a>
                    <a class="btn_list" href="#none">아래</a>
                </div>
            </div>
            <!-- //list_bottom -->            
        </div>
        <!-- //list_wrap -->              
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->

<!-- layer_pop_wrap -->
<div class="layer_pop_wrap large" id="modal_2">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>엑셀로 저장</h3>
        <a onclick="closeLayer('modal_2');" title="Close"></a>
    </div>
	<!-- //header_wrap -->
	<!-- pop_contents -->
	<div class="pop_contents">

        <!-- fx_layout -->
        <div class="fx_layout"> 
            <div class="fx_block">        
                <!-- form_wrap -->
                <div class="form_wrap">
                    <div class="form_head">
                        <h4>저장일자</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col width="120px"/>
                            <col />
                        </colgroup>
                        <tr>
                            <th>시작 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>끝 시간</th>
                            <td>
                                <div class="fx_form_multi">
                                    <div class="fx_form_date">
                                        <input type="text">
                                        <a href="#none"></a>
                                    </div>                                    
                                    <input type="text" value="13:17:42">
                                </div>
                            </td>
                        </tr>
                    </table>
                    <!-- //form_table -->
                </div>
                <!-- //form_wrap -->
            </div>
            <div class="fx_block">        
                <!-- form_wrap -->
                <div class="form_wrap">
                    <div class="form_head">
                        <h4>주기</h4>
                    </div>
                    <!-- form_table -->
                    <table class="form_table">
                        <colgroup>
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">0.5초 데이타</label>
                                    <label><input type="radio" name="radio">5분 데이타</label>
                                    <label><input type="radio" name="radio">5초 데이타</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fx_form">
                                    <label><input type="radio" name="radio">1시간 데이타</label>
                                    <label><input type="radio" name="radio">1분 데이타</label>
                                    <label><input type="radio" name="radio">직접입력</label>
                                    <input type="text" class="tr fx_none" style="width:60px;">
                                    <label>초</label>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <!-- //form_table -->
                </div>
                <!-- //form_wrap -->
            </div>
        </div>
        <!-- //fx_layout -->    
        <!-- file_upload -->
        <div class="fx_form file_upload">
            <div class="fx_form">
                <input type="text" />
                <a href="#none" class="btn_list">파일선택</a>
            </div>
        </div>
        <!-- //file_upload -->
	</div>
	<!-- pop_contents -->
    <!-- pop_footer -->
    <div class="pop_footer">
        <a href="#none" class="btn_page primary">저장</a>
        <a href="#none" class="btn_page" onclick="closeLayer('modal_2');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->
</body>
</html>

