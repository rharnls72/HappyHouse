<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="${root}/css/menu.css">
<body>
   <!--네비게이션 부트스트랩-->
   <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="${root}/"><img src="/happyhouse/img/logo.png" height="70px"></a>
   <div class="collapse navbar-collapse">
       <ul class="navbar-nav mr-auto">
         <li class="nav-item">
           <a class="nav-link" href="${root}/notice.do/list?pg=1&key=&word=">공지사항</a>
         </li>
         <li class="nav-item">
           <a class="nav-link" href="${root}/news.do/newslist">뉴스</a>
         </li>
         <li class="nav-item">
           <a class="nav-link" href="${root}/main.do/deal">거래내역</a>
         </li>
         
         <c:if test="${userinfo != null}">
         <li class="nav-item">
           <a class="nav-link" href="${root}/sell.do/list">매물</a>
         </li>
            <li class="nav-item">
              <a class="nav-link" href="${root}/tour.do">둘러보기</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${root}/qna.do">QnA</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${root}/favorite.do/list">마이홈</a>
            </li>
         </c:if>
       </ul>
       <%@ include file="/WEB-INF/views/client/log_on_off.jsp" %>
   </div>
   <img src="/happyhouse/img/line.png" class="line" style="width:2000px; height:2px;">
   </nav>
</body>
</html>