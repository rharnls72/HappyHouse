<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>해피하우스</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&family=Nanum+Gothic&family=Noto+Sans+KR:wght@300&family=Song+Myung&display=swap" rel="stylesheet">
</head>
<body style="overflow-x:hidden">
	<!-- 네비게이션 -->
	<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
	<div class="container" align="center">
		<div class="jumbotron">
			<img id="mainimg" src="${root}/img/indeximg.jpg" style="left: -300px; top: -94px;">
		</div>
		<%@ include file="/WEB-INF/views/menu/footer.jsp" %>
	</div>
</body>
</html>