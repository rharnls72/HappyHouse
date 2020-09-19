<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:if test="${cookie.ssafy_id.value ne null}">
	<c:set var="saveid" value="${cookie.ssafy_id.value}"/>
	<c:set var="idck" value=" checked=\"checked\""/>
</c:if>
<%-- <link rel="stylesheet" href="${root}/css/common.css"> --%>
<link rel="stylesheet" href="${root}/style.css"> 
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
<script type="text/javascript">
function login() {
	if(document.getElementById("id").value == "") {
		alert("아이디 입력!!!");
		return;
	} else if(document.getElementById("password").value == "") {
		alert("비밀번호 입력!!!");
		return;
	} else {
		document.getElementById("loginform").action = "${root}/log.do/login";
		document.getElementById("loginform").submit();
	}
}
	 
function moveJoin() {
	document.location.href = "${root}/log.do/mvjoin"; //회원가입
}

function search_pwd() {
	document.location.href = "${root}/log.do/mvfindpwd"; 
}	
</script>
<style type="text/css">
input[type=text], input[type=password]{
width:250px;
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
	<h2>로그인</h2>
		<form id="loginform" method="post" action="">
		<input type="hidden" name="act" id="act" value="login">
			<div class="form-group" align="center">
				<!-- 아이디 -->
				<input type="text" class="form-control" id="id" name="id" placeholder="아이디" value="${saveid}">
			</div>
			<div class="form-group" align="center">
				<!-- 비밀번호 -->
				<input type="password" style="font-family:initial" class="form-control" id="password" name="password" placeholder="비밀번호" onkeydown="javascript:if(event.keyCode == 13) {login();}">
			</div>
			<div class="custom-control custom-checkbox" style="display:inline-block; margin:10px">
			<input type="checkbox" class="custom-control-input" id="customCheck4"  id="idsave" name="idsave" value="saveok" checked="${idck}">
      		<label class="custom-control-label" for="customCheck4"> 아이디저장</label>
			</div>
			
			<div class="form-group" align="center">
				<button type="button" class="btn btn-primary" onclick="javascript:login();" style="margin:20px; width:300px;">로그인</button>
				<br/>
				<a onclick="javascript:moveJoin();" style="margin:30px;">회원가입</a>
				<a onclick="javascript:search_pwd();" style="margin:30px;">비밀번호찾기</a>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/views/menu/footer.jsp" %>
</body>
