<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>회원정보 수정</title>
  <meta charset="utf-8">
<link rel="stylesheet" href="${root}/css/menu.css">
<link rel="stylesheet" href="${root}/css/form.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
<script type="text/javascript">
  function search_pwd() {
	if(document.getElementById("name").value == "") {
		alert("이름 입력!!!!");
		return;
	} else if(document.getElementById("id").value == "") {
		alert("아이디 입력!!!!");
		return;
	} 
	else {
	  	document.getElementById("writeform").action = "${root}/log.do/findpwd";
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
		<h2>비밀번호 찾기</h2>
		<form id="writeform" method="post" action="" style="margin-bottom:100px;">
			<div class="form-group" align="center">
				<label for="name">이름:</label>
				<input type="text" class="form-control" id="name" name="name">
			</div>
			<div class="form-group" align="center">
				<label for="id">아이디:</label>
				<input type="text" class="form-control" id="id" name="id"></input>
			</div>
			<button type="button" class="btn btn-primary" onclick="javascript:search_pwd();"style="margin:20px;">찾기</button>
			<button type="reset" class="btn btn-secondary"style="margin:20px;">초기화</button>
		</form>
		
</div>
<%@ include file="/WEB-INF/views/menu/footer.jsp" %>
</body>
</html>
