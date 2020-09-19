<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>공지사항</title>
		<meta charset="utf-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		function movewrite() {
			location.href="${root}/notice.do/mvwrite";
		}
		function searchArticle() {
			if(document.getElementById("word").value == "") {
				alert("모든 목록 조회!!");
			}
			document.getElementById("searchform").action = "${root}/notice.do/list";
			document.getElementById("searchform").submit();
		}
		function pageMove(pg) {
			document.getElementById("pg").value=pg;
			document.getElementById("searchform").action = "${root}/notice.do/list";
			document.getElementById("searchform").submit();
		}
		</script>
		<link rel="stylesheet" href="${root}/style.css">
		<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
	</head>
	<body>
	<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
	<div class="container" align="center" style="width:1000px;">
	  <h2>공지사항</h2>
	  <form id="searchform" method="post" class="form-inline" style="position:relative; float: right;">
		  <input type="hidden" name="act" id="act" value="list">
		  <input type="hidden" name="pg" id="pg" value="1">
	  		<div class="form-group">
				  <select class="custom-select" name="key" id="key" style="margin-right:0px; height:35px;">
				  	<c:choose>
				  		<c:when test="${pageBean.key=='subject'}">
				  			<option value="id">아이디</option>
						    <option value="subject" selected="selected">제목</option>
						    <option value="content">내용</option>
				  		</c:when>
				  		<c:when test="${pageBean.key=='content'}">
				  			<option value="id">아이디</option>
						    <option value="subject">제목</option>
						    <option value="content" selected="selected">내용</option>
				  		</c:when>
				  		<c:otherwise>
				  			<option value="id" selected="selected">아이디</option>
						    <option value="subject">제목</option>
						    <option value="content">내용</option>
				  		</c:otherwise>
				  	</c:choose>
				</select>
				<input type="text" class="form-control" placeholder="검색어 입력" name="word" id="word" value="${pageBean.word}" style="margin-right:5px;">
				<input type="submit" class="btn btn-secondary my-2 my-sm-0" onclick="javascript:searchArticle();" value="검색"></input>
		  	</div>
		  </form>
	  <c:if test="${userinfo.id=='admin'}">
	  <div align="left" style="padding-top:10px;">
	  	<button type="button" class="btn btn-link" onclick="javascript:movewrite();" style="font-size:12pt; font-weight:bold;">작성</button>
	  </div>
	  </c:if>
	  <input type="hidden" id="modal_open" data-toggle="modal" data-target="#myModal"/>
	  <c:if test="${articles.size() != 0}">
	  <table class="table" style="width: 100%">
	  	<thead>
	  		<tr>
	  			<th scope="col" style="width: 10%;">번호</th>
	  			<th scope="col" style="width: 55%;">제목</th>
	  			<th scope="col" style="width: 10%;">작성자</th>
	  			<th scope="col" style="width: 20%;">작성일자</th>
	  			<c:if test="${userinfo.id == 'admin'}" ><th>비고</th></c:if> 
	  		</tr>
	  	</thead>
	    <tbody>
	  	<c:forEach var="article" items="${articles}">
	  	<tr><td scope="row">${article.noticeno}</td>
		  	<td><a href="javascript:detail(${article.noticeno})">${article.subject}</a></td>
		  	<td>${article.id}</td><td>${article.regtime}</td>
			      <c:if test="${userinfo.id == 'admin'}">
				        <td colspan="2">
						<a href="${root}/notice.do/mvmodify?no=${article.noticeno}">수정</a><br>
						<a href="${root}/notice.do/delete?no=${article.noticeno}">삭제</a>
						</td>
			      </c:if>
		</tr>
		</c:forEach>
	    </tbody>
	  	</table>
	  	<table>
	  	<tr>
	  	<td>
	  		${navigation.navigator}
	  	</td>
	  	</tr>
	  	</table>
	  </c:if>
	  <c:if test="${articles.size() == 0}">
	  	<h5>작성된 글이 없습니다.</h5>
	  </c:if>
	  
	  </div>
	  <%@ include file="/WEB-INF/views/menu/footer.jsp" %>
	  	<div class="modal" id="myModal" style="z-index: 2000;">
		<div class="modal-dialog modal-md" style="vertical-align: middle;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">공지사항 조회</h5>
					<button class="close" aria-label="Close" type="button" data-dismiss="modal">
          				<span aria-hidden="true">&times;</span>
       				</button>
				</div>
				<div class="modal-body">
					<table>
						<tr><td><h6>제목	:</h6></td><td></td></tr>
						<tr><td colspan="2"><h6 id="detail_subject"></h6>
						</tr>
						<tr><td><h6>내용	:</h6></td><td></td></tr>
						<tr><td colspan="2"><h6 id="detail_content"></h6>
						</tr>
					</table>
					<input type="hidden" id="hid_brd_no">
				</div>
				<div class="modal-footer">
					<button type="button" id="modalCloseBtn" class="btn btn-primary dataDismiss" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
		
	</div>
	<script>
	function detail(num) {
		$.get(
				"${root}/notice.do/detail"
				, {no: num}
				,function(data,status){
					if(status == "success"){
						if(data != null){
							$("#detail_subject").text(data.subject);
							$("#hid_brd_no").val(data.noticeno);
							$("#detail_content").text(data.content);
							//$("#modal_open").click();
							$('#myModal').modal('show');
						} else {
							alert("조회된 Data가 없습니다.");
						}
					} else {
						alert("시스템 관리자에게 문의 바랍니다.");
					}
				}//function
				, "json"
		);//get
	}//brd_detail
	</script>
	</body>
</html>
