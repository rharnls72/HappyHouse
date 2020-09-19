<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>비밀번호 찾기 완료</title>
  <meta charset="utf-8">
<link rel="stylesheet" href="${root}/style.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
 <style type="text/css">
#success{
	width:500px;
}
</style>
  </head>
<body>
<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
<div class="container" align="center">
	  <h2>비밀번호 찾기 성공!!!</h2>      
	  <table class="table table-active" id="success">
	  <thead>
	  <tr><th>아이디</th><th>비밀번호</th><th>이름</th></tr>
	  </thead>
	    <tbody>
	      <tr>
	        <td>${cli.id}</td>
	        <td>${cli.password}</td>
	        <td>${cli.name}</td>
	      </tr>
	    </tbody>
	  </table>  
	     <button type="button" class="btn btn-secondary" onclick="location.href='${root}/log.do/mvlogin'">로그인</button>
	    
</div>
<%@ include file="/WEB-INF/views/menu/footer.jsp" %>
</body>
</html>
