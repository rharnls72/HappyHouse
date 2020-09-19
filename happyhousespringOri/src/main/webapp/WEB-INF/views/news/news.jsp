<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>뉴스</title>
<link rel="stylesheet" href="${root}/style.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
</head>
<body>
	<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
	<div class="container">
	<h2>뉴스</h2>
	<br/>
	<ul>
	<%
        // 파싱할 사이트를 적어준다(해당 사이트에 대한 태그를 다 긁어옴)
 		Document doc2 = Jsoup.connect("https://search.naver.com/search.naver?where=news&sm=tab_jum&query=%EC%A3%BC%ED%83%9D%EA%B4%80%EB%A0%A8%EB%89%B4%EC%8A%A4").get();
        //Elements posts = doc2.body().getElementsByClass("news mynews section _prs_nws");
        Elements posts = doc2.body().getElementsByClass("type01");
        //System.out.println(doc2.getElementsByClass("list"));
        Elements file = posts.select("li");
        for(Element e : file){
        	if(!e.select("dd").eq(1).text().equals("")){

            	out.println("<a style='font-weight:bold; font-size:12pt;'"+ "href='"+e.select("dt a").attr("href")+"'>"+e.select("dt a").attr("title")+"</a>");
            	out.println("<dd>"+e.select("dd").eq(1).text()+"</dd>");
            	out.println("<br/>");
        	}
        	//System.out.println("Title : " + e.select("dt a").attr("title"));
        	//System.out.println("Link : " + e.select("dt a").attr("href"));
        	//System.out.println("Image : " + e.select(".thumb img").attr("src"));
        	//System.out.println("text : " + e.select("dd").eq(1).text());
        	//System.out.println();
    }
	%>
	</ul>
	</div>
	<%@ include file="/WEB-INF/views/menu/footer.jsp" %>
</body>
</html>