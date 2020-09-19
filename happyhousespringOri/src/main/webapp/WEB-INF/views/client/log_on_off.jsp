<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
    
<div class="my-2 my-lg-0" align="right">
<c:choose>
	<c:when test="${userinfo == null}">
		<a href="${root}/log.do/mvlogin" class="loginfo">로그인</a><span class="loginfo"> / </span>
		<a href="${root}/log.do/mvjoin" class="loginfo">회원가입</a>
	</c:when>
	<c:otherwise>
		<span class="loginfo"><span class="logname">${userinfo.name}</span>님 환영합니다. </span>
		<c:choose>
			<c:when test="${userinfo.id == 'admin'}">
				<a href="${root}/log.do/manage" class="loginfo">회원관리</a><span class="loginfo"> / </span>
			</c:when>
			<c:otherwise>
				<a href="${root}/log.do/mypage" class="loginfo">마이페이지</a>  /
			</c:otherwise>
		</c:choose>
		<a href="${root}/log.do/logout" class="loginfo">로그아웃</a>
	</c:otherwise>
</c:choose>

</div>
</body>
</html>
