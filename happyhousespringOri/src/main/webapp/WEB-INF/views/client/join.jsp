<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>SSAFY-회원가입</title>
<meta charset="utf-8">
<link rel="stylesheet" href="${root}/css/menu.css">
<link rel="stylesheet" href="${root}/css/form.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
<script type="text/javascript">
function res() {
	   if(document.getElementById("name").value == "") {
	      alert("이름 입력!!!");
	      return;
	   } else if(document.getElementById("id").value == "") {
	      alert("아이디 입력!!!");
	      return;
	   }else if(document.getElementById("password").value == "") {
	      alert("비밀번호 입력!!!");
	      return;
	   }else if(document.getElementById("password").value != document.getElementById("pwdcheck").value) {
	      alert("비밀번호 확인!!!");
	      return;
	   } else {
	      document.getElementById("memberform").action = "${root}/log.do/register";
	      document.getElementById("memberform").submit();
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
	<h2>회원가입</h2>
		<form id="memberform" method="post" action="" style="margin-bottom:100px;">
			<div class="form-group" align="center">
				<label for="name">이름</label>
				<input type="text" class="form-control" id="name" name="name" placeholder="">
			</div>
			<div class="form-group" align="center">
				<label for="">아이디</label>
				<input type="text" class="form-control" id="id" name="id" placeholder="">
			</div>
			<div class="form-group" align="center">
				<label for="">비밀번호</label>
				<input type="password" class="form-control" id="password" name="password" placeholder="">
			</div>
			<div class="form-group" align="center">
				<label for="">비밀번호재입력</label>
				<input type="password" class="form-control" id="pwdcheck" name="pwdcheck" placeholder="">
			</div>
			<div class="form-group" align="center">
				<button type="button" class="btn btn-primary" onclick="javascript:res();" style="margin:20px;">회원가입</button>
				<button type="reset" class="btn btn-secondary"style="margin:20px;">초기화</button>
			</div>
		</form>
</div>
<%@ include file="/WEB-INF/views/menu/footer.jsp" %>
</body>
</html>