<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${root}/style.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
<script type="text/javascript">
  function writeClient() {
	if(document.getElementById("name").value == "") {
		alert("이름 입력!!!!");
		return;
	} else if(document.getElementById("password").value == "") {
		alert("비밀번호 입력!!!!");
		return;
	}else {
	  	document.getElementById("writeform").action = "${root}/log.do/modify";
	  	document.getElementById("writeform").submit();
	}
  }
  </script>
  <style type="text/css">
input[type=text], input[type=password]{
width:300px;
}
label{
text-align:left;
width:290px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
<div class="container" align="center">
	<h2>회원 정보</h2>
	<form id="writeform" method="post" action="">
			<div class="form-group" align="center">
				<label for="name">이름:</label>
				<input type="text" class="form-control" id="name" name="name" value="${client.name}">
			</div>
			<div class="form-group" align="center">
				<label for="id">아이디:</label>
				<input readonly="readonly" type="text"  class="form-control" id="id" name="id" value="${client.id}">
			</div>
			<div class="form-group" align="center">
				<label for="password">비밀번호:</label>
				<input type="text"  class="form-control" id="password" name="password" value="${client.password}">
			</div>
			<button type="button" class="btn btn-primary" onclick="javascript:writeClient();">수정</button>
			<button type="button" class="btn btn-secondary" onclick="location.href='${root}/log.do/delete/${client.id}'">탈퇴</button>
		</form>
		
</div>
<%@ include file="/WEB-INF/views/menu/footer.jsp" %>
</body>
</html>