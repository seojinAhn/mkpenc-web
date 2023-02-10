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
				<h3>STATOR SLOT(RTD) & BAR(TC) TEMP-2</h3>
				<div class="bc"><span>MARK_V</span><span>Mimic</span><span>AUX</span><strong>STATOR SLOT(RTD) & BAR(TC) TEMP-2</strong></div>
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
                                    <td class="tc">37</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T30</td>
                                    <td class="tc">B44</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">38</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">B45</td>
                                    <td class="tc">B62</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">39</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T32</td>
                                    <td class="tc">T13</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">40</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T33</td>
                                    <td class="tc">B46</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">41</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T34</td>
                                    <td class="tc">B48</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">42</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T35</td>
                                    <td class="tc">B47</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">43</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T36</td>
                                    <td class="tc">B49</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">44</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T67</td>
                                    <td class="tc">B51</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">45</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T38</td>
                                    <td class="tc">B52</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">46</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T39</td>
                                    <td class="tc">B53</td>
                                    <td class="tc">-T5</td>
                                </tr>
                                <tr>
                                    <td class="tc">47</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T40</td>
                                    <td class="tc">B54</td>
                                    <td class="tc">-T2</td>
                                </tr>
                                <tr>
                                    <td class="tc">48</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T41</td>
                                    <td class="tc">B55</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">49</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T42</td>
                                    <td class="tc">B56</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">50</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">B57</td>
                                    <td class="tc">B02</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">51</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T44</td>
                                    <td class="tc">T25</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">52</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T45</td>
                                    <td class="tc">B58</td>
                                    <td class="tc">-T1</td>
                                </tr>
                                <tr>
                                    <td class="tc">53</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T46</td>
                                    <td class="tc">B60</td>
                                    <td class="tc">-T4</td>
                                </tr>
                                <tr>
                                    <td class="tc">54</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T47</td>
                                    <td class="tc">B59</td>
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
                                    <td class="tc">55</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T48</td>
                                    <td class="tc">B61</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">56</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T07</td>
                                    <td class="tc">B63</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">57</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T50</td>
                                    <td class="tc">B64</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">58</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T51</td>
                                    <td class="tc">B65</td>
                                    <td class="tc">-T6</td>
                                </tr>
                                <tr>
                                    <td class="tc">59</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T52</td>
                                    <td class="tc">B66</td>
                                    <td class="tc">-T3</td>
                                </tr>
                                <tr>
                                    <td class="tc">60</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T53</td>
                                    <td class="tc">B67</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">61</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T54</td>
                                    <td class="tc">B68</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">62</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">B69</td>
                                    <td class="tc">B14</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">63</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T56</td>
                                    <td class="tc">T37</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">64</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T57</td>
                                    <td class="tc">B70</td>
                                    <td class="tc">-T2</td>
                                </tr>
                                <tr>
                                    <td class="tc">65</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T58</td>
                                    <td class="tc">B72</td>
                                    <td class="tc">-T5</td>
                                </tr>
                                <tr>
                                    <td class="tc">66</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T59</td>
                                    <td class="tc">B71</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">67</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T60</td>
                                    <td class="tc">B01</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">68</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T19</td>
                                    <td class="tc">B03</td>
                                    <td class="tc">-J</td>
                                </tr>
                                <tr>
                                    <td class="tc">69</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T62</td>
                                    <td class="tc">B04</td>
                                    <td class="tc"></td>
                                </tr>
                                <tr>
                                    <td class="tc">70</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T63</td>
                                    <td class="tc">B05</td>
                                    <td class="tc">-T4</td>
                                </tr>
                                <tr>
                                    <td class="tc">71</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T64</td>
                                    <td class="tc">B06</td>
                                    <td class="tc">-T1</td>
                                </tr>
                                <tr>
                                    <td class="tc">72</td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc"><input type="text" value="0" class="tr" /></td>
                                    <td class="tc">T65</td>
                                    <td class="tc">B07</td>
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

</body>
</html>

