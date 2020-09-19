<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:if test="${userinfo == null}">
	<c:redirect url="/log.do?act=mvlogin"/>
</c:if>
<c:if test="${userinfo.id != 'admin'}">
	<c:redirect url="/index.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>SSAFY-글작성</title>
  <meta charset="utf-8">
<link rel="stylesheet" href="${root}/style.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
<script type="text/javascript">
  function writeArticle() {
	if(document.getElementById("subject").value == "") {
		alert("제목 입력!!!!");
		return;
	} else if(document.getElementById("content").value == "") {
		alert("내용 입력!!!!");
		return;
	} else {
	  	document.getElementById("writeform").action = "${root}/notice.do/write";
	  	document.getElementById("writeform").submit();
	}
  }
  </script>
  <style type="text/css">
label{
	align:left;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
<div class="container" align="center">
		<h2>공지사항 글쓰기</h2>
		<form id="writeform" method="post" action="">
		<input type="hidden" name="act" id="act" value="write">
			<div class="form-group" align="center" style="width:700px">
				<label for="subject" style="font-weight:bold;">제목:</label>
				<input type="text" class="form-control" id="subject" name="subject" style="margin-left:10px;display:inline-block; width: 650px">
			</div>
			<div class="form-group" align="center" style="width:700px">
				<label for="content" style="position: relative;font-weight:bold; float:left; left: 6px;">내용:</label>
				<textarea class="form-control" rows="15" id="content" name="content" style="margin-left:10px;display:inline-block; width: 650px"></textarea>
			</div>
			<button type="button" class="btn btn-primary" onclick="javascript:writeArticle();" style="margin-bottom:30px;">공지사항 작성</button>
			<button type="reset" class="btn btn-warning" style="margin-bottom:30px;">초기화</button>
		</form>
</div>
<%@ include file="/WEB-INF/views/menu/footer.jsp" %>
</body>
</html>
