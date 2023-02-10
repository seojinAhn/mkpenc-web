<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="cFn" uri="http://onmakers.com/function" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- System title --%>
<c:set var="SYSTEM_TITLE" value="MKPENC  Monitoring" />
<c:set var="SYSTEM_TITLE_OPER" value="MKPENC  Monitoring" />
<c:set var="SYSTEM_TITLE_ADMIN" value="MKPENC  Monitoring" />

<%-- ROOT directory --%>
<c:set var="CTX_PATH" value="${pageContext.request.contextPath}" />
<c:set var="CUR_PAGE" value="${pageContext.request.requestURI}" />

<%-- Resources directory --%>
<c:set var="IMG_PATH" value="${CTX_PATH}/resources/images" />
<c:set var="ADMIN_IMG_PATH" value="${CTX_PATH}/resources/images/admin" />

<%-- Admin name --%>
<c:set var="ADMIN_WRITER" value="관리자" />

<%-- User name --%>
<c:set var="USER_WRITER" value="월성 3, 4호기 담당자" />

<%-- <jsp:useBean id="now" class="java.util.Date" /> --%>