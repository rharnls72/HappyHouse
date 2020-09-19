<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:if test="${userinfo == null}">
	<c:redirect url="/log.do/mvlogin"/>
</c:if>
<c:if test="${userinfo.id != 'admin'}">
	<c:redirect url="/index.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>회원정보</title>
		<meta charset="utf-8">
		<link rel="stylesheet" href="${root}/style.css">
		<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
		<script type="text/javascript">

		function searchArticle() {
			if(document.getElementById("word").value == "") {
				alert("모든 목록 조회!!");
			}
			document.getElementById("searchform").action = "${root}/log.do/manage";
			document.getElementById("searchform").submit();
		}
		</script>
 <style type="text/css">
#list{
	width:500px;
}
</style>
	</head>
	<body>	
	<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
	<div class="container" align="center">
	  <h2>회원목록</h2>
	  <form id="searchform" method="post" class="form-inline" action="" >
	  <table class="table table-borderless">
	  	<tr>
	  		<td align="center">
	  		<div>
	  		 <select class="form-control" name="key" id="key">
		  	  	<c:choose>
		  		<c:when test="${key=='name'}">
		  			<option value="id">아이디</option>
			    <option value="name" selected="selected">이름</option>
		  		</c:when>
		  		<c:otherwise>
		  			<option value="id" selected="selected">아이디</option>
			    <option value="name">이름</option>
		  		</c:otherwise>
		  		</c:choose>
			    
			  </select>
			  <input type="text" class="form-control" placeholder="검색어 입력." name="word" id="word" value="${word}">
			  <button type="button" class="btn btn-primary" onclick="javascript:searchArticle();">검색</button>
			
	  		</div>
		  	 </td>
	  	</tr>
	  </table>
	  </form>
	  <c:if test="${articles.size() != 0}">
	  <form id="client_delete" method="post" action="${root}/log.do/deleteids">
	  <table class="table" style="width: 800px">
	  <thead>
	  <tr><th scope="col">아이디</th><th scope="col">비밀번호</th><th scope="col">이름</th><th scope="col">삭제</th></tr>
	  </thead>
	    <tbody>
	  	<c:forEach var="client" items="${articles}">
	      <tr>
	        <td>${client.id}</td>
	        <td>${client.password}</td>
	        <td>${client.name}</td>
	        <td><input type="checkbox" name="deleteid" id="deleteid" value="${client.id}"></td>
	      </tr>
	  	</c:forEach>
	    </tbody>
	  </table>
	  <button type="submit" class="btn btn-primary"  style="margin-bottom:30px;">선택 회원 삭제</button>
	  </form>
	  </c:if>
	  <c:if test="${articles.size() == 0}">
	  	<h5>회원이 0명입니다.</h5>
	  </c:if>
	  </div>
	  <%@ include file="/WEB-INF/views/menu/footer.jsp" %>
	</body>
</html>
