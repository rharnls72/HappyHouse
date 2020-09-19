<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="com.ssafy.happyhouse.model.dto.HouseDeal, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래 내역</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
   function searchDeal() {
	  $("#guname").val($("#gugun option:selected").text());
	  console.log($("#guname").val())
      document.getElementById("searchform").action = "${root}/main.do/dealsearch";
      document.getElementById("searchform").submit();
   }
   function pageMove(pg) { 
      document.getElementById("pg").value=pg;
      searchDeal();
   }
   function changesido(){
	   console.log("selectgu")
	   $.get("${root}/main.do/gugun"
		   ,{act:"gugun", sido:$("#sido").val()}
		   ,function(data, status){
		      $("#gugun").empty();
		      $("#gugun").append('<option value="0">선택</option>');
		      $.each(data, function(index, vo) {
		         $("#gugun").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
		      });//each
		   }//function
		   , "json"
	   );//get
   }
   function changegu(){
	   $.get("${root}/main.do/dong"
		   ,{act:"dong", gugun:$("#gugun").val()}
		   ,function(data, status){
		      $("#dong").empty();
		      $("#dong").append('<option value="0">선택</option>');
		      $.each(data, function(index, vo) {
		         $("#dong").append("<option value='"+vo.dong_name+"'>"+vo.dong_name+"</option>");
		      });//each
		   }//function
		   , "json"
	   );//get
   }
</script>
<style type="text/css">
.checkbox-inline { margin-bottom: 20px;}
#deal li:hover{
   background-color:rgba(0, 0, 0, 0.075);
}
</style>
<script>
let colorArr = ['table-primary','table-success','table-danger'];
$(document).ready(function(){
   $("#sido").change(function() {
	   console.log("sido")
	   changesido();
   });//change 
   $("#gugun").mouseover(function(){
	   if($("#gugun option").length == 2){
		   changesido();
	   }
   });
   $("#gugun").change(function() {
	   changegu();
   });//change
   $("#dong").mouseover(function(){
	   if($("#dong option").length == 2){
		   changegu();
	   }
   });
   $("#dong").change(searchDeal);//change
});//ready
</script>
<link rel="stylesheet" href="${root}/style.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
</head>
<body>
	<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
   <div class="container" align="center">
   <h2>거래내역 조회</h2>
      <!-- 인코딩필터 -->
      <form id="searchform" method="post" class="form-group" action="">
         <input type='hidden' name='act' id='act' value='dealsearch' /> 
         <div style="width: 100%">
         <input type="hidden" name="pg" id="pg" value="1">
         <input type="hidden" name="guname" id="guname" value="">
         <span class="sigungu">시도 :</span> <select class="custom-select" id="sido" name="sido">
         <option value="0" <c:if test='${empty sido}'>selected="selected"</c:if>>선택</option>
         <option value="11" <c:if test="${sido == '11'}">selected="selected"</c:if>>서울특별시</option>
         <option value="26" <c:if test="${sido == '26'}">selected="selected"</c:if>>부산광역시</option>
         <option value="27" <c:if test="${sido == '27'}">selected="selected"</c:if>>대구광역시</option>
         <option value="28" <c:if test="${sido == '28'}">selected="selected"</c:if>>인천광역시</option>
         <option value="29" <c:if test="${sido == '29'}">selected="selected"</c:if>>광주광역시</option>
         <option value="30" <c:if test="${sido == '30'}">selected="selected"</c:if>>대전광역시</option>
         <option value="31" <c:if test="${sido == '31'}">selected="selected"</c:if>>울산광역시</option>
         <option value="36" <c:if test="${sido == '36'}">selected="selected"</c:if>>세종특별자치시</option>
         <option value="41" <c:if test="${sido == '41'}">selected="selected"</c:if>>경기도</option>
         <option value="42" <c:if test="${sido == '42'}">selected="selected"</c:if>>강원도</option>
         <option value="43" <c:if test="${sido == '43'}">selected="selected"</c:if>>충청북도</option>
         <option value="44" <c:if test="${sido == '44'}">selected="selected"</c:if>>충청남도</option>
         <option value="45" <c:if test="${sido == '45'}">selected="selected"</c:if>>전라북도</option>
         <option value="46" <c:if test="${sido == '46'}">selected="selected"</c:if>>전라남도</option>
         <option value="47" <c:if test="${sido == '47'}">selected="selected"</c:if>>경상북도</option>
         <option value="48" <c:if test="${sido == '48'}">selected="selected"</c:if>>경상남도</option>
         <option value="50" <c:if test="${sido == '50'}">selected="selected"</c:if>>제주특별자치도</option>
         </select>
         <span class="sigungu">구군 : </span><select class="custom-select" id="gugun" name="gugun">
         <c:if test="${not empty gugun}">
	        	<option value="${gucode}">${gugun}</option>
	     </c:if>
            <option value="0">선택</option>
         </select>
         <span class="sigungu">읍면동 : </span><select class="custom-select" id="dong" name="dong" data-options="panelHeight:400px">
         	<c:if test="${not empty dong and dong != '0'}">
         		<option value="${dong}">${dong}</option>
         	</c:if>
            <option value="0">선택</option>
         </select>
         </div>
         <br>
         <div class="custom-control custom-checkbox" style="display:inline-block; margin:10px">
         <input type="checkbox" class="custom-control-input" id="customCheck1" checked="" name="type" value="APT_DEAL" checked="">
            <label class="custom-control-label" for="customCheck1"> 아파트 매매</label>
         </div>
         <div class="custom-control custom-checkbox" style="display:inline-block; margin:10px">
         <input type="checkbox" class="custom-control-input" id="customCheck2" checked="" name="type" value="APT_RENT" checked="">
            <label class="custom-control-label" for="customCheck2"> 아파트 전월세</label>
         </div>
         <div class="custom-control custom-checkbox" style="display:inline-block; margin:10px">
         <input type="checkbox" class="custom-control-input" id="customCheck3" checked="" name="type" value="HOUSE_DEAL" checked="">
            <label class="custom-control-label" for="customCheck3"> 연립,주택 매매</label>
         </div>
         <div class="custom-control custom-checkbox" style="display:inline-block; margin:10px">
         <input type="checkbox" class="custom-control-input" id="customCheck4" checked="" name="type" value="HOUSE_RENT" checked="">
            <label class="custom-control-label" for="customCheck4"> 연립,주택 전월세</label>
         </div>
         
         <br/>
         <div>
         	<button type="button" style="float: right;" class="btn btn-primary" onclick="javascript:searchDeal();">검색</button>
         	<input type="text" style="width: 250px; float: right;" class="searchbox" placeholder="아파트 이름" name="word" id="word" value="${word}">
         </div>
         
      </form>

      <c:if test="${deals == null}">
         <script> searchDeal();</script>
      </c:if>
    <!--  <aside class="col-lg-3 order-lg-1" style="width: 30%;float: left;text-align: left;"> -->
     <aside class="col-lg-3 order-lg-1" style="width: 30%;float: left;text-align: left;">
      <!-- <aside class="dealtable"> -->
	      <div class="block">
	            <h3>거래내역</h3>
	            <hr>
	            <br/>
	            <c:choose>
	            <c:when test='${not empty deals}'>
	            <ul class="list-group" id="deal">
	            <c:forEach var="deal" items="${deals}">
	            	<li class="list-group-item d-flex justify-content-between align-items-center" onclick="javascript:detail(${deal.no})">
	                	<div class="deallist">
	                	<h6>${deal.aptName}</h6>
	                	</div>
	                    ${deal.dealAmount} 만 원<br> 
	            		${deal.dealYear}.${deal.dealMonth}.${deal.dealDay}<br>
	            	</li>
	            </c:forEach>
	            </ul>
	            </c:when>
	            <c:otherwise>
	            <div>거래 내역이 없습니다.</div>
	            </c:otherwise>
	            </c:choose>
	      </div>	
      </aside>
      <div id="map"></div>
	      <script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
	      <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBU23uuC5gK4VtUxxsoUqHRmYQoFunRa0s&callback=initMap"></script>
	      <script>
	         var multi = {lat: 37.5012743, lng: 127.039585};
	         var map;
	         function initMap() {
	            map = new google.maps.Map(document.getElementById('map'), {
	               center: multi, zoom: 17
	            });
	            if(${deals == null}){
	               var marker = new google.maps.Marker({position: multi, map: map});
	            } else{
	               var deal = new Array();
	               deal = ${deals};
	               $.each(deal, function(index, HouseDeal){
	                  addMarker(HouseDeal.lat, HouseDeal.lng, HouseDeal.AptName, HouseDeal.no);
	               })
	            }
	         }
	         function addMarker(tmpLat, tmpLng, aptName, no) {
	            var marker = new google.maps.Marker({
	               position: new google.maps.LatLng(parseFloat(tmpLat),parseFloat(tmpLng)),
	               title: aptName,
	               no: no
	            });
	            marker.setMap(map);
	            map.setZoom(14);
	            map.setCenter(marker.getPosition());
	            marker.addListener('click', function() {
	                detail(this.no)
	            });
	         }
	      </script>
      
	   <table class="pagenation" style="clear:both">
	        <tr>
	           <td>
	              <div>
	              ${navigation.navigator}
	              </div>
	           </td>
	        </tr>
	   </table>
   </div>
   <%@ include file="/WEB-INF/views/menu/footer.jsp" %>
   <div class="modal" id="myModal" style="z-index: 2000;">
      <div class="modal-dialog modal-md" style="vertical-align: middle;">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title">주택 실거래가 상세정보</h5>
               <button class="close" aria-label="Close" type="button" data-dismiss="modal">
                      <span aria-hidden="true">&times;</span>
                   </button>
            </div>
            <div class="modal-body">
            
         <img id="deal_image" src="" alt="My Image" style="width:465px;" >
         <table class="table table-bordered" id="info">
         <tbody>
         <tr><td>거래번호</td><td id="deal_no"></td></tr>
         <tr><td>법정동</td><td id="deal_dong"></td></tr>
         <tr><td>지번</td><td id="deal_jibun"></td></tr>
         <tr><td>아파트이름</td><td id="deal_aptName"></td></tr>
         <tr><td>건축연도</td><td id="deal_buildYear"></td></tr>
         <tr><td>전용면적/층</td><td id="deal_area"></td></tr>
         <tr><td>거래금액</td><td id="deal_dealAmount"></td></tr>
         <tr><td>거래날짜</td><td id="deal_date"></td></tr>
         <tr><td>거래종류</td><td id="deal_type"></td></tr>
         </tbody>
      </table>
         </div>
      </div>
      
   </div>
   </div>
   <script>
   function detail(num) {
      $.get(
            "${root}/main.do/detail"
            , {
               act:'dealinfo', no:num
            }
            ,function(data,status){
               if(status == "success"){
                  if(data != null){
                       $("#deal_image").attr("src", "${root}"+data.img);
                        $("#deal_no").text(data.no);
                        $("#deal_dong").text(data.dong);
                        $("#deal_jibun").text(data.jibun);
                        $("#deal_aptName").text(data.aptName);
                        $("#deal_buildYear").text(data.buildYear);
                        $("#deal_area").text(data.area+"/"+data.floor);
                        $("#deal_dealAmount").text(data.dealAmount);
                        $("#deal_date").text(data.dealYear+"-"+data.dealMonth+"-"+data.dealDay);
                        $("#deal_type").text(data.type);
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
   }
   </script>
   
</body>
</html>