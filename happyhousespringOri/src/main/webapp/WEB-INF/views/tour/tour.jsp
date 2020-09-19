<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<c:if test="${userinfo == null}">
   <c:redirect url="/log.do/mvlogin"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>둘러보기</title>
<link rel="stylesheet" href="${root}/style.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBU23uuC5gK4VtUxxsoUqHRmYQoFunRa0s&callback=initMap"></script>

<script type="text/javascript">
$(document).ready(function () {
      $("#citycode").change(function() {
         $.get("${pageContext.request.contextPath}/favorite.do/gugun"
               ,{citycode:$("#citycode").val()}
               ,function(data, status){
                  $("#gucode").empty();
                  $("#gucode").append('<option value="0">선택</option>');
                  $.each(data, function(index, vo) {
                     $("#gucode").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
                  });//each
               }//function
               , "json"
         );//get
      });//change
      $("#gucode").change(function() {
         $.get("${pageContext.request.contextPath}/favorite.do/dong"
               ,{gucode:$("#gucode").val()}
               ,function(data, status){
                  $("#code").empty();
                  $("#code").append('<option value="0">선택</option>');
                  $.each(data, function(index, vo) {
                     $("#code").append("<option value='"+vo.code+"'>"+vo.dong_name+"</option>");
                  });//each
               }//function
               , "json"
         );//get
      });//change
      displayNone();
      $("#storeSearchBtn").click(function(){
    	  pageMove(1)
      });
   });//ready
   
   function addFavorite(){
      if(isSelectAll()){
         document.getElementById("writeform").action = "${root}/favorite.do/addfavorite";
           document.getElementById("writeform").submit();
      }
   }
   function isSelectAll(){
      if($("#citycode").val()==0)   alert('시를 선택해주세요');
      else if($("#gucode").val()==0)   alert('구를 선택해주세요');
      else if($("#code").val()==0)   alert('동을 선택해주세요');
      else   return true;
      return false;
   }
   function displayNone(){
      $("#map").hide();
      $("#storelist").hide();
      $("#environmentlist").hide();
      $("#schoollist").hide();
      $("#subwaylist").hide();
      
   }
      function searchStore() {
         if(isSelectAll()){
            displayNone();
            $("#map").show();
            $("#storelist").show();
            clearMarkers();
            $.post("${root}/tour.do/store"
                 ,{code:$("#code").val(), pg:$("#pg").val(), key:$("#key").val(), word:$("#word").val()}
                 ,function(data, status){
                    $("#store").empty();
                    $("#navigator").empty();
                    if(data.stores.length != 0){
                       $.each(data.stores, function(index, vo) {
                          addMarker(vo.lat.trim().substring(1,vo.lat.trim().length - 1), vo.lng.trim().substring(1,vo.lng.trim().length - 1));
                          $("#store").append("<tr><td>"+vo.shopname+"</td><td>"
                                +vo.codename1+"-"+vo.codename2+"</td><td>"
                                +vo.codename3+"-"+vo.codename4+"</td><td>"
                                +vo.postcode+"</td><td>"+vo.jibunaddress+"</td><td>"+vo.address+"</td></tr>");
                       });//each
                       showMarkers();
                       $("#navigator").append(data.navigation.navigator);
                    }else{
                       $("#store").append("<td colspan='5'>등록된 상권이 없습니다.</td>");
                    }
                    
                 }//function
                 , "json"
           );//get
         }
      }
      function searchEnvironment(){
         if(isSelectAll()){
            displayNone();
            $("#environmentlist").show();
            clearMarkers();
            $.post("${root}/tour.do/environment"
                 ,{code:$("#code").val()}
                 ,function(data, status){
                    $("#environment").empty();
                    if(data !=null){
                       $("#environment").append('<tr><td>미세먼지</td><td style="text-align:center">'+data.pm10+'</td></tr>');
                         $("#environment").append('<tr><td>초미세먼지</td><td style="text-align:center">'+data.pm25+'</td></tr>');
                         $("#environment").append('<tr><td>폐수배출시설</td><td style="text-align:center">'+data.gye+'</td></tr>');
                         $("#environment").append('<tr><td>녹지</td><td style="text-align:center">'+data.gaeso_1+'</td></tr>');
                    }else{
                       $("#environment").append('<tr><td>등록된 환경정보가 없습니다.</td><td>');
                    }
                 }//function
                 , "json"
           );//get
         }
      }
      function searchCctv(){
         if(isSelectAll()){
            displayNone();
            $("#map").show();
            clearMarkers();
            $.post("${root}/tour.do/cctv"
                ,{code:$("#code").val()}
                ,function(data, status){
                	if(data.length != 0){
                        $.each(data, function(index, vo) {
                           addMarker(vo.let.trim(), vo.lng.trim());
                        });//each
                        showMarkers();
                     }
                 }//function
                 , "json"
           );//get
         }
      }
      function searchSchool(){
         if(isSelectAll()){
            displayNone();
            $("#map").show();
            $("#schoollist").show();
            clearMarkers();
            $.post("${root}/tour.do/school"
                ,{code:$("#code").val()}
                ,function(data, status){
                    $("#school").empty();
                    if(data.length != 0){
                       $.each(data, function(index, vo) {
                          $("#school").append('<tr><td>'+vo.name+'</td><td style="text-align:center">'+vo.grade+'</td></tr>');
                    	  addMarker(vo.lat.trim(), vo.lng.trim());
                       });
                    }else{
                       $("#school").append('<tr><td>주변에 학교가 없습니다.</td><td>');
                    }
                    
                 }//function
                 , "json"
           );//get
         }
      }
      function searchSubway(){
         if(isSelectAll()){
            displayNone();
            $("#subwaylist").show();
            clearMarkers();
            $.post("${root}/tour.do/subway"
                 ,{code:$("#code").val()}
                 ,function(data, status){
                    $("#subway").empty();
                    console.log(data.length);
                    if(data.length != 0){
                       $.each(data, function(index, vo) {
                          $("#subway").append('<tr><td>'+vo.name+'</td><td>'+vo.line+'호선</td></tr>');
                       });
                    }else{
                       $("#subway").append('<tr><td>주변에 지하철이 없습니다.</td><td>');
                    }
                 }//function
                 , "json"
           );//get
         }
      }
      function pageMove(pg) { 
         document.getElementById("pg").value=pg;
         searchStore();
      }
      var map;
      var markers=[];
      function initMap() {
          map = new google.maps.Map(document.getElementById('map'), {
             center: {lat: 37.5012743, lng: 127.039585}, zoom: 17
          });
       }
       function addMarker(tmpLat, tmpLng) {
          var marker = new google.maps.Marker({
             position: new google.maps.LatLng(parseFloat(tmpLat),parseFloat(tmpLng)),
             map: map
          });
          markers.push(marker);
          map.setCenter(marker.getPosition());
       }
       function clearMarkers(){
          setMapOnAll(null);
          markers = [];
       }
       function setMapOnAll(map) {
           for (var i = 0; i < markers.length; i++) {
             markers[i].setMap(map);
           }

         }
       function showMarkers() {
           setMapOnAll(map);
       }
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
   <div class="container" align="center">
   
   <h2>주변탐방</h2>
   
   <div class="form-group" style="width:900px;">
      <form id="writeform" method="post" action="">
         <span class="sigungu">시도</span> <select class="custom-select" id="citycode" name="citycode" style="width:200px; display:inline-block;">
            <option value="0">선택</option>
            <option value="11">서울특별시</option>
         <option value="26">부산광역시</option>
         <option value="27">대구광역시</option>
         <option value="28">인천광역시</option>
         <option value="29">광주광역시</option>
         <option value="30">대전광역시</option>
         <option value="31">울산광역시</option>
         <option value="36">세종특별자치시</option>
         <option value="41">경기도</option>
         <option value="42">강원도</option>
         <option value="43">충청북도</option>
         <option value="44">충청남도</option>
         <option value="45">전라북도</option>
         <option value="46">전라남도</option>
         <option value="47">경상북도</option>
         <option value="48">경상남도</option>
         <option value="50">제주특별자치도</option>
         </select>
         <span class="sigungu">구군</span>  <select class="custom-select" id="gucode" name="gucode" style="width:200px; display:inline-block;">
            <option value="0">선택</option>
         </select>
         <span class="sigungu">읍면동</span>  <select class="custom-select" id="code" name="code" style="width:200px; display:inline-block; margin-right:5px">
            <option value="0">선택</option>
         </select>
   
         <button type="button" class="btn btn-primary" onclick="addFavorite();">등록</button>
      </form>
      <button type="button" class="btn btn-primary" onclick="searchStore();">상점</button>
      <button type="button" class="btn btn-primary" onclick="searchEnvironment();">환경</button>
      <button type="button" class="btn btn-primary" onclick="searchCctv();">CCTV</button>
      <button type="button" class="btn btn-primary" onclick="searchSchool();">학군</button>
      <button type="button" class="btn btn-primary" onclick="searchSubway();">교통</button>
   </div>
   
   <div id="map" style="width: 70%;height: 500px; margin: 20px auto; margin-bottom:60px; float:none;"></div>
   <div id="storelist">
   <h3>상권</h3>
   <div style="margin: 10px;" align="right">
     <input type="hidden" name="pg" id="pg" value="1">
        <table style="width:350px;">
        <tr>
	        <td><select class="form-control" style="width: 100%" name="key" id="key">
	           <option value="category">분류</option>
	            <option value="name"  selected="selected">상호명</option>
	        </select></td>
	        <td  style="width: 200px"><input type="text" class="form-control" style="width: 200px" placeholder="검색어 입력" name="word" id="word" onKeypress="javascript:if(event.keyCode==13) {pageMove(1)}"/>
	        </td>
	        <td><button type="button" class="btn btn-primary" id="storeSearchBtn">검색</button></td>
	        </tr>
        </table>
     </div>
   
   <table class="table">
         <thead>
         <tr>
         <th class="tourpage" style="width:20%" scope="col">상호명</th>
         <th class="tourpage" style="width:20%" scope="col">대분류</th>
         <th class="tourpage" style="width:9%" scope="col">소분류</th>
         <th class="tourpage" style="width:6%" scope="col">우편번호</th>
         <th class="tourpage" style="width:20%" scope="col">지번주소</th>
         <th class="tourpage" style="width:25%" scope="col">도로명주소</th>
         </tr>
         </thead>
         <tbody id="store">
         </tbody>
      </table>
      <table style="clear:both">
        <tr>
           <td>
              <div id="navigator">
              </div>
           </td>
        </tr>
   </table>
   </div>
   
   
   
   <div id="environmentlist">
   <h3>환경</h3>
   <table class="table" style="width:300px">
   
         <thead>
         	<tr>
	         <th class="tourpage">환경정보</th>
	         <th class="tourpage">수치</th>
         </thead>
         <tbody id="environment">
         </tbody>
      </table>
   </div>
   
   <div id="schoollist">
   <h3>학군</h3>
   <table class="table" style="width:300px">
         <thead>
         <tr>
         <th class="tourpage" style="width:70%">이름</th>
         <th class="tourpage">구분</th>
         </tr>
         </thead>
         <tbody id="school">
         </tbody>
      </table>
   </div>
   
    <div id="subwaylist">
   <h3>지하철</h3>
   <table class="table" style="width:310px">
         <thead>
         <tr>
         <th class="tourpage">이름</th>
         <th class="tourpage">호선</th>
         </tr>
         </thead>
         <tbody id="subway">
         </tbody>
      </table>
   		</div>
    </div>
	<%@ include file="/WEB-INF/views/menu/footer.jsp" %></body>
</html>