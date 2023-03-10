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
<script type="text/javascript" src="<c:url value="/resources/js/mimic.js" />" charset="utf-8"></script>
</head>
<body>
<div class="wrap">
	<!-- header_wrap -->
	<%@ include file="/WEB-INF/views/include/include-markv-header.jspf" %>
	<!-- header_wrap -->
	<!-- container -->
	<div class="container">
		<!-- contents -->
		<div class="contents">
			<!-- page_title -->
			<div class="page_title">
				<h3>STATOR SLOT(RTD) & BAR(TC) TEMP-1</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>STATOR SLOT(RTD) & BAR(TC) TEMP-1</strong></div>
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
                                <col width="140px" />
                                <col width="140px" />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>SLOT #</th>
                                    <th>RTD TEMP</th>
                                    <th>TC TEMP</th>
                                    <th>BAR 1</th>
                                    <th>BAR 2</th>
                                    <th>CON RING</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tc">01</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T66</td>
                                    <td class="tc">B08</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">02</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">B09</td>
                                    <td class="tc">B26</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">03</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T68</td>
                                    <td class="tc">T49</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">04</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T69</td>
                                    <td class="tc">B10</td>
                                    <td class="tc">-T3</td>
                                </tr>
                                <tr>
                                    <td class="tc">05</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T70</td>
                                    <td class="tc">B12</td>
                                    <td class="tc">-T6</td>
                                </tr>
                                <tr>
                                    <td class="tc">06</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T71</td>
                                    <td class="tc">B11</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">07</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T72</td>
                                    <td class="tc">B13</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">08</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T31</td>
                                    <td class="tc">B15</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">09</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T02</td>
                                    <td class="tc">B16</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">10</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T03</td>
                                    <td class="tc">B17</td>
                                    <td class="tc">-T5</td>
                                </tr>
                                <tr>
                                    <td class="tc">11</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T04</td>
                                    <td class="tc">B18</td>
                                    <td class="tc">-T2</td>
                                </tr>
                                <tr>
                                    <td class="tc">12</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T05</td>
                                    <td class="tc">B19</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">13</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T06</td>
                                    <td class="tc">B20</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">14</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">B21</td>
                                    <td class="tc">B38</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">15</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T08</td>
                                    <td class="tc">T61</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">16</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T09</td>
                                    <td class="tc">B22</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">17</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T10</td>
                                    <td class="tc">B24</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">18</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T11</td>
                                    <td class="tc">B23</td>
                                    <td class="tc"></td>
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
                                <col width="140px" />
                                <col width="140px" />
                                <col />
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>SLOT #</th>
                                    <th>RTD TEMP</th>
                                    <th>TC TEMP</th>
                                    <th>BAR 1</th>
                                    <th>BAR 2</th>
                                    <th>CON RING</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="tc">19</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T12</td>
                                    <td class="tc">B25</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">20</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T43</td>
                                    <td class="tc">B27</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">21</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T14</td>
                                    <td class="tc">B28</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">22</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T15</td>
                                    <td class="tc">B29</td>
                                    <td class="tc">-T6</td>
                                </tr>
                                <tr>
                                    <td class="tc">23</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T16</td>
                                    <td class="tc">B30</td>
                                    <td class="tc">-T3</td>
                                </tr>
                                <tr>
                                    <td class="tc">24</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T17</td>
                                    <td class="tc">B31</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">25</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T18</td>
                                    <td class="tc">B32</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">26</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">B33</td>
                                    <td class="tc">B50</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">27</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T20</td>
                                    <td class="tc">T01</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">28</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T21</td>
                                    <td class="tc">B34</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">29</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T22</td>
                                    <td class="tc">B36</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">30</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T23</td>
                                    <td class="tc">B35</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">31</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T24</td>
                                    <td class="tc">B37</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">32</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T55</td>
                                    <td class="tc">B39</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">33</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T26</td>
                                    <td class="tc">B40</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">34</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T27</td>
                                    <td class="tc">B41</td>
                                    <td class="tc">-T4</td>
                                </tr>
                                <tr>
                                    <td class="tc">35</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T28</td>
                                    <td class="tc">B42</td>
                                    <td class="tc">-T1</td>
                                </tr>
                                <tr>
                                    <td class="tc">36</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T29</td>
                                    <td class="tc">B43</td>
                                    <td class="tc"></td>
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
<script type="text/javascript" src="<c:url value="/resources/js/range_control.js" />" charset="utf-8"></script>
</body>
</html>

