<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<title>QnA게시판</title>
<meta charset="utf-8">
<!-- <link rel=stylesheet
   href=https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css
   integrity=sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh
   crossorigin=anonymous> -->
<link href="${root}/js/app.fb162e98.js" rel=preload as=script>
<link href="${root}/js/chunk-vendors.5d81c2c4.js" rel=preload as=script>
<link rel="stylesheet" href="${root}/style.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/menu/menu.jsp"%>
   	<div class="container" align="center"> 
		<h2>QnA게시판</h2>
	    <div id=app class=container></div>
	    <script src="${root}/js/chunk-vendors.5d81c2c4.js"></script>
	    <script src="${root}/js/app.fb162e98.js"></script>
   	</div>
   	<%@ include file="/WEB-INF/views/menu/footer.jsp" %>
</body>
</html>