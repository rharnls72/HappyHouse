<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="com.ssafy.happyhouse.model.dto.HouseDeal, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매물</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
   function searchSell() {
	  $("#guname").val($("#gugun option:selected").text());
      document.getElementById("searchform").action = "${root}/sell.do/sellsearch";
      document.getElementById("searchform").submit();
   }
   function pageMove(pg) { 
      document.getElementById("pg").value=pg;
      searchSell();
   }
   function changesido(){
	   $.get("${root}/sell.do/gugun"
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
	   $.get("${root}/sell.do/dong"
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
   function heart(no, event){
	  event.stopPropagation();
	  if($('#'+no).attr("src")=="/happyhouse/img/favorite.png"){
		  $.get("${root}/sell.do/deleteSell/"+no,function(data){
			  if(data.favorite){ 
				  $('#'+no).attr("src","/happyhouse/img/heart.png");
				  alert('삭제되었습니다.');
			}else{
				alert('이미 삭제되었습니다.');
			}
		}//function
		, "json"
		);//get
		
	  }else{
		  $.get("${root}/sell.do/addSell/"+no,function(data){
			  if(data.favorite){ 
				  $('#'+no).attr("src","/happyhouse/img/favorite.png");
				  alert('추가되었습니다.');
			}else{
				alert('이미 추가되었습니다.');
			}
		}//function
		, "json"
		);//get
	  }
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
   $("#dong").change(searchSell);//change
});//ready

</script>
<link rel="stylesheet" href="${root}/style.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="/WEB-INF/views/menu/menu.jsp" %>
   <div class="container" align="center">
   <h2>매물 목록</h2>
      <!-- 인코딩필터 -->
      <form id="searchform" method="post" class="form-group" action="">
      
         <input type='hidden' name='act' id='act' value='sellsearch' /> 
         <div style="width: 100%">
         <input type="hidden" name="pg" id="pg" value="1">
         <input type="hidden" name="guname" id="guname" value="">
         시도 : <select class="custom-select" id="sido" name="sido" style="width:200px; display:inline-block; margin:10px">
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
         구군 : <select class="custom-select" id="gugun" name="gugun" style="width:200px; display:inline-block; margin:10px">
         <c:if test="${not empty gugun}">
	        	<option value="${gucode}">${gugun}</option>
	     </c:if>
            <option value="0">선택</option>
         </select>
         읍면동 : <select class="custom-select" id="dong" name="dong" data-options="panelHeight:400px" style="width:200px; display:inline-block; margin:10px">
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
         <button type="button" style="float: right;" class="btn btn-primary" onclick="javascript:searchSell();">검색</button>
         <input type="text" style="width: 150px; float: right;" class="form-control" placeholder="아파트 이름" name="word" id="word" value="${word}">
      </form>
      
      <c:if test="${sells == null}">
         <script> searchSell();</script>
      </c:if>
      <aside class="col-lg-3 order-lg-1" style="width: 30%;float: left;text-align: left;">
         <div class="block">
            <h3>매물</h3>
            <hr>
            <br/>
            <c:choose>
            <c:when test='${not empty sells}'>
            <ul class="list-group" id="sell">
            <c:forEach var="sell" items="${sells}">
            	<li class="list-group-item d-flex justify-content-between align-items-center" onclick="javascript:detail(${sell.no})">
                	<!-- 찜하기 기능 -->
                	<%-- <c:choose>
                		<!-- 로그인 했을 때는 찜하기 db로 들어가게 -->
                		<c:when test='${userinfo != null}'></c:when>
                		<!-- 로그인이 안 되어 있을 때  -->
                		<c:otherwise></c:otherwise>
                	</c:choose> --%>
                	
                	<div style="width:150px;">
                	<h6>${sell.aptName}</h6>
	                	</div>
	                    ${sell.dealAmount} 만 원<br> 
	            		${sell.regYear}.${sell.regMonth}.${sell.regDay}<br>
            		<a onclick="heart(${sell.no}, event)" style="margin:0;">
            		<c:choose>
            		<c:when test="${sell.favorite}">
            			<img src="/happyhouse/img/favorite.png" height="20px" id='${sell.no}'>
            		</c:when>
            		<c:otherwise>
            			<img src="/happyhouse/img/heart.png" height="20px" id='${sell.no}'>
            		</c:otherwise>
            		</c:choose>
            		</a>
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
      <div id="map" style="width: 70%;height: 500px; margin: 20px auto; float: right;"></div>
      <script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
      <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBU23uuC5gK4VtUxxsoUqHRmYQoFunRa0s&callback=initMap"></script>
      <script>
         var multi = {lat: 37.5012743, lng: 127.039585};
         var map;
         function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
               center: multi, zoom: 17
            });
            if(${sells == null}){
               var marker = new google.maps.Marker({position: multi, map: map});
            } else{
               var sell = new Array();
               sell = ${sells};
               $.each(sell, function(index, HouseSell){
                  addMarker(HouseSell.lat, HouseSell.lng, HouseSell.AptName, HouseSell.no);
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
      
   <table style="clear:both">
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
               <h5 class="modal-title">매물 상세정보</h5>
               <button class="close" aria-label="Close" type="button" data-dismiss="modal">
                      <span aria-hidden="true">&times;</span>
                   </button>
            </div>
            <div class="modal-body">
            
         <img id="sell_image" src="" alt="My Image" style="width:465px;" >
         <table class="table table-bordered" id="info">
         <tbody>
         <tr><td>매물 번호</td><td id="sell_no"></td></tr>
         <tr><td>법정동</td><td id="sell_dong"></td></tr>
         <tr><td>지번</td><td id="sell_jibun"></td></tr>
         <tr><td>아파트이름</td><td id="sell_aptName"></td></tr>
         <tr><td>건축연도</td><td id="sell_buildYear"></td></tr>
         <tr><td>전용면적/층</td><td id="sell_area"></td></tr>
         <tr><td>금액</td><td id="sell_dealAmount"></td></tr>
         <tr><td>등록일</td><td id="sell_date"></td></tr>
         <tr><td>매물종류</td><td id="sell_type"></td></tr>
         <tr><td>등록자</td><td id="sell_id"></td></tr>
         <tr><td>연락처</td><td id="sell_phone"></td></tr>
         </tbody>
      </table>
         </div>
      </div>
      
   </div>
   </div>
   <script>
   function detail(num) {
      $.get(
            "${root}/sell.do/detail"
            , {
               no:num
            }
            ,function(data,status){
               if(status == "success"){
                  if(data != null){
                       $("#sell_image").attr("src", "${root}"+data.img);
                        $("#sell_no").text(data.no);
                        $("#sell_dong").text(data.dong);
                        $("#sell_jibun").text(data.jibun);
                        $("#sell_aptName").text(data.aptName);
                        $("#sell_buildYear").text(data.buildYear);
                        $("#sell_area").text(data.area+"/"+data.floor);
                        $("#sell_dealAmount").text(data.dealAmount);
                        $("#sell_date").text(data.regYear+"-"+data.regMonth+"-"+data.regDay);
                        $("#sell_type").text(data.type);
                        $("#sell_id").text(data.seller);
                        $("#sell_phone").text(data.phone);
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