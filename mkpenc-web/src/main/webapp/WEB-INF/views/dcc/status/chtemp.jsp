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
<script type="text/javascript" src="<c:url value="/resources/js/status.js" />" charset="utf-8"></script>
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
				<h3>REACTOR CHANNEL TEMPERATURE MONITORING</h3>
				<div class="bc"><span>DCC</span><span>Status</span><strong>REACTOR CHANNEL TEMPERATURE MONITORING</strong></div>
			</div>
			<!-- //page_title -->
			<!-- fx_srch_wrap -->
			<div class="fx_srch_wrap">	
				<div class="fx_srch_form">
					<div class="fx_srch_row">
						<div class="fx_srch_item">
							<label>AVG</label>
                            <div class="fx_form">
                                <label>300.7248</label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>MODE</label>
                            <div class="fx_form">
                                <label>
                                    <input type="radio" name="mode" checked>
                                    Auto
                                </label>
                                <label>
                                    <input type="radio" name="mode">
                                    Manual
                                </label>
                            </div>
						</div>
						<div class="fx_srch_item">
							<label>VIEW</label>
                            <div class="fx_form">
                                <label>
                                    <input type="radio" name="view" checked>
                                    AI
                                </label>
                                <label>
                                    <input type="radio" name="view">
                                    Instrumant
                                </label>
                            </div>
						</div>
                    </div>
				</div>
			</div>
			<!-- //fx_srch_wrap -->
            <!-- list_wrap -->
            <div class="list_wrap">
                <!-- 마우스 우클릭 메뉴 -->
                <div class="context_menu" id="mouse_area">
                    <ul>
                        <li><a href="#none" onclick="openLayer('modal_1');">엑셀로 저장</a></li>
                    </ul>
                </div>
                <!-- //마우스 우클릭 메뉴 -->                     
                <!-- ch_temp_box -->
                <div class="ch_temp_box">
                    <ul>
                        <li></li>
                        <li>1</li>
                        <li>2</li>
                        <li>3</li>
                        <li>4</li>
                        <li>5</li>
                        <li>6</li>
                        <li>7</li>
                        <li>8</li>
                        <li>9</li>
                        <li>10</li>
                        <li>11</li>
                        <li>12</li>
                        <li>13</li>
                        <li>14</li>
                        <li>15</li>
                        <li>16</li>
                        <li>17</li>
                        <li>18</li>
                        <li>19</li>
                        <li>20</li>
                        <li>21</li>
                        <li>22</li>
                        <li></li>
                    </ul>
                    <ul>
                        <li>A</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>A</li>
                    </ul>
                    <ul>
                        <li>B</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>B</li>
                    </ul>
                    <ul>
                        <li>C</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>C</li>
                    </ul>
                    <ul>
                        <li>D</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>D</li>
                    </ul>
                    <ul>
                        <li>E</li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li>E</li>
                    </ul>
                    <ul>
                        <li>F</li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li>F</li>
                    </ul>
                    <ul>
                        <li>G</li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li>G</li>
                    </ul>
                    <ul>
                        <li>H</li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li>H</li>
                    </ul>
                    <ul>
                        <li>J</li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li>J</li>
                    </ul>
                    <ul>
                        <li>K</li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li>J</li>
                    </ul>
                    <ul>
                        <li>L</li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li>L</li>
                    </ul>
                    <ul>
                        <li>M</li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li>M</li>
                    </ul>
                    <ul>
                        <li>N</li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li>N</li>
                    </ul>
                    <ul>
                        <li>o</li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li>o</li>
                    </ul>
                    <ul>
                        <li>P</li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li>P</li>
                    </ul>
                    <ul>
                        <li>Q</li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li>Q</li>
                    </ul>
                    <ul>
                        <li>R</li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li>R</li>
                    </ul>
                    <ul>
                        <li>S</li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li>S</li>
                    </ul>
                    <ul>
                        <li>T</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>T</li>
                    </ul>
                    <ul>
                        <li>U</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>U</li>
                    </ul>
                    <ul>
                        <li>V</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_r">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_g">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>V</li>
                    </ul>
                    <ul>
                        <li>W</li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li class="bg_y">
                            <span>147</span>
                            <span>302.50</span>
                        </li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li>W</li>
                    </ul>
                    <ul>
                        <li></li>
                        <li>1</li>
                        <li>2</li>
                        <li>3</li>
                        <li>4</li>
                        <li>5</li>
                        <li>6</li>
                        <li>7</li>
                        <li>8</li>
                        <li>9</li>
                        <li>10</li>
                        <li>11</li>
                        <li>12</li>
                        <li>13</li>
                        <li>14</li>
                        <li>15</li>
                        <li>16</li>
                        <li>17</li>
                        <li>18</li>
                        <li>19</li>
                        <li>20</li>
                        <li>21</li>
                        <li>22</li>
                        <li></li>
                    </ul>                    
                </div>
                <!-- //ch_temp_box -->
            </div>
            <!-- //list_wrap -->
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
<div class="layer_pop_wrap large" id="modal_1">
    <!-- header_wrap -->
	<div class="pop_header">
	    <h3>엑셀로 저장</h3>
        <a onclick="closeLayer('modal_1');" title="Close"></a>
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
        <a href="#none" class="btn_page" onclick="closeLayer('modal_1');">닫기</a>
    </div>
    <!-- //pop_footer -->
</div>
<!-- //layer_pop_wrap -->
<script type="text/javascript" src="<c:url value="/resources/js/context_menu.js" />" charset="utf-8"></script>
</body>
</html>

