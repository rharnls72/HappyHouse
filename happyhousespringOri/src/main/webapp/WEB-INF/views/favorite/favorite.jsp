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
<title>마이홈</title>
<link rel="stylesheet" href="${root}/style.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Text&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
</style>
<script  type="text/javascript">
$(document).ready(function(){
   $("#sido").change(function() {
      changesido();
   });//change 
   $("#gugun").change(function() {
      changegu();
   });//change
});
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
   
   var label1='';
   var label2='';
   var data1=[];
   var data2=[];
   function allowDrop(event) {
     event.preventDefault();
   }
   function drag(event) {
      event.dataTransfer.setData("text", event.target.id);
   }

    function drop(event) {
         event.preventDefault();
         var id = event.dataTransfer.getData('text');
         var data = $('#'+id).text();
         console.log(data);
         $(event.target).text(data);
         if(event.target.id=='select1') select1(id, data);
         else if (event.target.id=='select2')   select2(id, data);
         else if (event.target.id=='select3')   select3(id, data);
         else if (event.target.id=='select4')   select4(id, data);
      }
      function select1(code, dong, name){
         console.log(code+" "+dong);
         $.post("${root}/favorite.do/tour"
                   ,{code:code}
                   ,function(data, status){
                      if(data !=null){
                         $("#store1").html('전체: '+data.cntStore+'<br/>편의점 및 마트: '+data.cntMart+'<br/>카페: '+data.cntCafe);
                         $("#environment1").html(data.env+'점');
                         $("#cctv1").html(data.cntCctv);
                         $("#school1").html('초등학교: '+data.cntElementary+'<br/>중학교: '+data.cntMiddle+'<br/>고등학교: '+data.cntHigh);
                         $("#subway1").html('역: '+data.cntStation+'<br/>호선: '+data.line);
                         if(name==null)   label1 = dong;
                         else            label1 = name;
                         data1=[];
                         data1.push((data.cntMart+data.cntCafe/3)*5);
                         data1.push(data.env/1.5);
                         data1.push(data.cntCctv*15);
                         data1.push((data.cntElementary+data.cntMiddle+data.cntHigh)*20);
                         data1.push(data.cntStation*20);
                         drawCanvas();
                      }
                   }//function
                   , "json"
             );//get
      }
      function select2(code, dong, name){
         $.post("${root}/favorite.do/tour"
                   ,{code:code}
                   ,function(data, status){
                      if(data !=null){
                         $("#store2").html('전체: '+data.cntStore+'<br/>편의점 및 마트: '+data.cntMart+'<br/>카페: '+data.cntCafe);
                         $("#environment2").html(data.env+'점');
                         $("#cctv2").html(data.cntCctv);
                         $("#school2").html('초등학교: '+data.cntElementary+'<br/>중학교: '+data.cntMiddle+'<br/>고등학교: '+data.cntHigh);
                         $("#subway2").html('역: '+data.cntStation+'<br/>호선: '+data.line);
                         if(name==null)   label2 = dong;
                         else            label2 = name;
                         data2=[];
                         data2.push((data.cntMart+data.cntCafe/3)*5);
                         data2.push(data.env/1.5);
                         data2.push(data.cntCctv*15);
                         data2.push((data.cntElementary+data.cntMiddle+data.cntHigh)*20);
                         data2.push(data.cntStation*20);
                         drawCanvas();
                      }
                   }//function
                   , "json"
             );//get
      }
      function drawCanvas(){
         var ctx = document.getElementById('myChart');
         var myRadarChart = new Chart(ctx, {
             type: 'radar',
             data: {
                labels: ['상점', '환경', 'CCTV', '학교', '교통'],
                datasets: [{
                   label:label1,
                    data: data1,
                    backgroundColor:'rgba(255, 99, 132, 0.2)',
                    borderColor:'rgba(255, 99, 132, 1)'
                },
                {
                   label:label2,
                    data: data2,
                    backgroundColor:'rgba(54, 162, 235, 0.2)',
                    borderColor:'rgba(54, 162, 235, 1)'
                }]
            },
             options: {
                scale: {
                   gridLines:{
                      color: '#D8D8D8'
                   },
                    angleLines: {
                        display: false
                    },
                    ticks: {
                        suggestedMin: 50,
                        suggestedMax: 100,
                        stepSize:20
                    }
                }
            }
         });
      }
      function select3(no, name){
         $.get("${root}/favorite.do/jjim/"+no
                   ,function(data, status){
                      if(data.house !=null){
                         $("#dong1").html(data.house.dong);
                         $("#buildYear1").html(data.house.buildYear);
                         $("#area1").html(data.house.area+'m²/'+data.house.floor);
                         $("#dealAmount1").html(data.house.dealAmount+"만 원");
                         $("#type1").html(data.house.type);
                         select5(data.code, data.house.dong, name, data.house.lat, data.house.lng);
                      }
                   }//function
                   , "json"
             );//get
      }
      function select4(no, name){
         $.get("${root}/favorite.do/jjim/"+no
                   ,function(data, status){
                      if(data.house !=null){
                         $("#dong2").html(data.house.dong);
                         $("#buildYear2").html(data.house.buildYear);
                         $("#area2").html(data.house.area+'m²/'+data.house.floor);
                         $("#dealAmount2").html(data.house.dealAmount+"만 원");
                         $("#type2").html(data.house.type);
                         select6(data.code, data.house.dong, name, data.house.lat, data.house.lng);
                      }
                   }//function
                   , "json"
             );//get
      }
      function select5(code, dong, name, lat, lng){
            console.log(code+" "+dong);
            $.post("${root}/favorite.do/tour/apt"
                      ,{code:code, aptName:name, lat:lat, lng:lng}
                      ,function(data, status){
                         if(data !=null){
                            if(name==null)   label1 = dong;
                            else            label1 = name;
                            // 학교 이름 세팅
                            var school = "";
                            if(data.elementary != null){
                               school += "<li>"+data.elementary+": "+data.elementaryDis+"km</li>";
                            }
                            if(data.middle != null){
                               school += "<li>"+data.middle+": "+data.middleDis+"km</li>";
                            }
                            if(data.high != null){
                               school += "<li>"+data.high+": "+data.highDis+"km</li>";
                            }
                            $("#school1").html(school);
                            // 지하철 이름 세팅
                            if(data.subwayName != null){
                               if(data.line !=null){
                                  $("#subway1").html(data.line+"호선 "+data.subwayName + "역: " + data.subwayDis+"km");
                               }else{
                                  $("#subway1").html(data.subwayName + "역: " + data.subwayDis+"km");
                               }
                            }else{
                               $("#subway1").html("");
                            }
                            data1=[];
                            if(data.cntMart+data.cntCafe > 300){
                               data1.push(500);
                            }else{
                               data1.push((data.cntMart+data.cntCafe/3)*5);
                            }
                            data1.push(data.env/1.5);
                            data1.push(data.cntCctv*15);
                            data1.push((data.cntSchool)*10);
                            data1.push(data.cntSubway*10);
                            drawCanvas();
                         }
                      }//function
                      , "json"
                );//get
         }
         function select6(code, dong, name, lat, lng){
            $.post("${root}/favorite.do/tour/apt"
                    ,{code:code, aptName:name, lat:lat, lng:lng}
                      ,function(data, status){
                         if(data !=null){
                            if(name==null)   label2 = dong;
                            else            label2 = name;
                            var school = "";
                            if(data.elementary != null){
                               school += "<li>"+data.elementary+": "+data.elementaryDis+"km</li>";
                            }
                            if(data.middle != null){
                               school += "<li>"+data.middle+": "+data.middleDis+"km</li>";
                            }
                            if(data.high != null){
                               school += "<li>"+data.high+": "+data.highDis+"km</li>";
                            }
                            $("#school2").html(school);
                            if(data.subwayName != null){
                               if(data.line !=null){
                                  $("#subway2").html(data.line+"호선 "+data.subwayName + "역: " + data.subwayDis+"km");
                               }else{
                                  $("#subway2").html(data.subwayName + "역: " + data.subwayDis+"km");
                               }
                            } else{
                               $("#subway2").html("");
                            }
                            data2=[];
                            if(data.cntMart+data.cntCafe > 300){
                               data2.push(500);
                            }else{
                               data2.push((data.cntMart+data.cntCafe/3)*5);
                            }
                            data2.push(data.env/1.5);
                            data2.push(data.cntCctv*15);
                            data2.push((data.cntSchool)*10);
                            data2.push(data.cntSubway*10);
                            drawCanvas();
                         }
                      }//function
                      , "json"
                );//get
         }
      
      function openModal(){
         $('#myModal').modal('show');
      }
   </script>

</head>
<body>
   <%@ include file="/WEB-INF/views/menu/menu.jsp" %>
   <h2 id="title">마이홈</h2>
   <div class="container" align="center">
   <aside class="col-lg-3 order-lg-1" style="width:250px">
         <div>
             <h3>메뉴</h3>
            <hr>
            <a href="${root}/favorite.do/list" style="padding-left:20px; line-height: 2.0; display:block; color:black; font-weight:bold;">관심지역</a>
            <a href="${root}/favorite.do/jjimlist" style="padding-left:20px; line-height: 2.0; display:block; color:black; font-weight:bold;">찜</a>
            <a href="${root}/favorite.do/sellList" style="padding-left:20px; line-height: 2.0; display:block; color:black; font-weight:bold;">우리집내놓기</a>
         </div>
      </aside>   
      <div id="favoriteArea">
           <c:if test="${favorites != null}">
            <c:choose>
            <c:when test='${not empty favorites}'>
            <div style="float:right; width: 45%; margin-top: 53px;">
               <ul class="list-group" style="width:50%;">
                  <c:forEach var="favorite" items="${favorites}">
                     <li class="list-group-item d-flex justify-content-between align-items-center">
                        <div draggable="true" ondragstart="drag(event)" id="${favorite.code}" >
                           <h6 style="text-align:left;">${favorite.dong}</h6>
                           <div>
                           (${favorite.city} ${favorite.gugun})<br>
                           </div>
                        </div>
                        <button onclick="location.href='${root}/favorite.do/deletefavorite/${favorite.no}'" class="btn btn-primary" style="padding:8px;">삭제</button>
                     </li>
                  </c:forEach>
               </ul>
            
         
         </div>
               <table class="table table-bordered" style="width:550px; float:left; margin-top: 56px;">
               <tr>
               <td></td>
               <td ondragover="allowDrop(event);" ondrop="drop(event);" id="select1" style="text-align:center; font-weight:bold">선택해주세요</td>
               <td ondragover="allowDrop(event);" ondrop="drop(event);" id="select2" style="text-align:center; font-weight:bold">선택해주세요</td>
               </tr>
               <tr>
               <th>상점</th>
               <td id="store1"></td>
               <td id="store2"></td>
               </tr>
               <tr>
               <th>환경</th>
               <td id="environment1"></td>
               <td id="environment2"></td>
               </tr>
               <tr>
               <th>CCTV</th>
               <td id="cctv1"></td>
               <td id="cctv2"></td>
               </tr>
               <tr>
               <th>학교</th>
               <td id="school1"></td>
               <td id="school2"></td>
               </tr>
               <tr>
               <th>교통</th>
               <td id="subway1"></td>
               <td id="subway2"></td>
               </tr>
               </table>
               <div style="float: left; width:600px; height:500px; margin-top:20px;">
                  <canvas id="myChart"></canvas>
              </div>
            
         </c:when>
            <c:otherwise>
               <h6>관심지역이 없습니다.</h6>
            </c:otherwise>
         </c:choose>
         </c:if>
   </div>
      
   <div id="jjim">
      <c:if test="${jjims != null}">
         <c:choose>
         <c:when test='${not empty jjims}'>
         <div style="float:right; width: 40%; margin-top: 53px;">
               <ul class="list-group" style="width:50%;">
                  <c:forEach var="jjim" items="${jjims}">
                     <li class="list-group-item d-flex justify-content-between align-items-center">
                     <div style="text-align:left;">
                           <h6 draggable="true" ondragstart="drag(event)" id="${jjim.no}" code="${jjim.code}">${jjim.aptName}</h6>
                           <div>
                          ${jjim.dealAmount} 만 원<br> 
                          ${jjim.regYear}.${jjim.regMonth}.${jjim.regDay}
                          </div>
                         </div> 
                  <button onclick="location.href='${root}/favorite.do/deleteJjim/${jjim.no}'" class="btn btn-primary" style="padding:8px;">삭제</button>
                     </li>
                 </c:forEach>
              </ul>
            </div>
            <table class="table table-bordered" style="width:550px; float:left; margin-top: 56px;">
            <tr>
            <td></td>
            <td ondragover="allowDrop(event);" ondrop="drop(event);" id="select3" style="text-align:center; font-weight:bold">선택해주세요</td>
            <td ondragover="allowDrop(event);" ondrop="drop(event);" id="select4" style="text-align:center; font-weight:bold">선택해주세요</td>
            </tr>
            <tr>
            <th>법정동</th>
            <td id="dong1"></td>
            <td id="dong2"></td>
            </tr>
            <tr>
            <th>건축연도</th>
            <td id="buildYear1"></td>
            <td id="buildYear2"></td>
            </tr>
            <tr>
            <th>전용면적/층</th>
            <td id="area1"></td>
            <td id="area2"></td>
            </tr>
            <tr>
            <th>금액</th>
            <td id="dealAmount1"></td>
            <td id="dealAmount2"></td>
            </tr>
            <tr>
            <th>매물종류</th>
            <td id="type1"></td>
            <td id="type2"></td>
            </tr>
            <tr>
            <th>학교</th>
            <td><ul id="school1" style="list-style-type:none; padding:0px; margin:0"></ul></td>
            <td><ul id="school2" style="list-style-type:none; padding:0px; margin:0"></ul></td>
            </tr>
            <tr>
            <th>지하철</th>
            <td id="subway1"></td>
            <td id="subway2"></td>
            </tr>
            </table>
            
            <div style="float: left; width:600px; height:500px; margin-top:20px;margin-left:16%;">
         <canvas id="myChart"></canvas>
         </div>
      </c:when>
         <c:otherwise>
            <h6>찜이 없습니다.</h6>
         </c:otherwise>
      </c:choose>
      </c:if>
      </div>

      
      <div id="houseSell" style="width:500px">
      <c:if test="${houseSells != null}">
      <div class="text-right">
               <button class="btn btn-primary" onclick="javascript:openModal()">등록</button>
      </div>
      <c:choose>
      <c:when test='${not empty houseSells}'>
         <table class="table">
               <thead>
                  <tr><th style="width:40%">아파트 이름</th><th>층</th><th>금액</th><th>등록일</th><th>삭제</th></tr>
               </thead>
               <tbody id="sellList">
               <c:forEach var="houseSell" items="${houseSells}">
                     <tr><td><a onclick="detail(${houseSell.no})">${houseSell.aptName}</a></td>
                     <td>${houseSell.floor}</td><td>${houseSell.dealAmount}</td>
                     <td>${houseSell.regYear}.${houseSell.regMonth}.${houseSell.regDay}</td>
                     <td><button onclick="location.href='${root}/favorite.do/deletehouseSell/${houseSell.no}'" class="btn btn-primary" style="padding:8px;">삭제</button></td></tr>
                  </c:forEach>
               </tbody>
         </table>
      </c:when>
      <c:otherwise>
            <h6>우리집 매물이 없습니다.</h6>
      </c:otherwise>
      </c:choose>
      </c:if>
         
      </div>
   </div>
   <%@ include file="/WEB-INF/views/menu/footer.jsp" %>
   <div class="modal" id="myModal" style="z-index: 2000;">
   <div class="modal-dialog modal-md" style="vertical-align: middle;">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title">매물 등록하기</h5>
            <button class="close" aria-label="Close" type="button" data-dismiss="modal">
                     <span aria-hidden="true">&times;</span>
               </button>
         </div>
         <div class="modal-body">
            <form id="sellform" method="post" action="${root}/favorite.do/sellReg">
               <table class="table table-bordered" id="info">
                    <tbody>
                       <tr><td colspan="2">주소</td></tr>
                       <tr><td colspan="2">
                       <select class="form-control" id="sido" name="sido" style="width:25%; display:inline-block; margin:10px">
                        <option value="0" >선택</option>
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
                        <select class="form-control" id="gugun" name="gugun" style="width:25%; display:inline-block; margin:10px">
                           <option value="0">선택</option>
                        </select>
                        <select class="form-control" id="dong" name="dong" style="width:25%; display:inline-block; margin:10px">
                           <option value="0">선택</option>
                        </select>
                       <input type="text" id="jibun" name="jibun" class="form-control" style="margin: 0 0 0 10px; width:85%" placeholder="지번을 입력해주세요."></td></tr>
                       <tr><td>아파트이름</td><td><input type="text" id="aptName" name="aptName" class="form-control"></td></tr>
                       <tr><td>건축연도</td><td><input type="text" id="buildYear" name="buildYear" class="form-control"></td></tr>
                       <tr><td>전용면적</td><td><input type="text" id="area" name="area" class="form-control"></td></tr>
                       <tr><td>층</td><td><input type="text" id="floor" name="floor" class="form-control"></td></tr>
                       <tr><td>금액</td><td><input type="text" id="dealAmount" name="dealAmount" class="form-control"></td></tr>
                       <tr><td>매물종류</td>
                       <td><select class="form-control" id="type" name="type">
                           <option value="1">아파트 매매</option>
                           <option value="2">아파트 전월세</option>
                          <option value="3">연립, 주택 매매</option>
                          <option value="4">연립, 주택 전월세</option></select></td></tr>
                       <tr><td>연락처</td><td><input type="text" id="phone" name="phone" class="form-control"></td></tr>
                       <tr><td>등록자</td><td><input type="text" class="form-control" id="seller" name="seller" value="${userinfo.id}" readonly="readonly"></td></tr>
                    </tbody>
                  </table>
               <button type="reset" class="btn btn-primary" style="margin:5px">초기화</button>
               <button type="submit"class="btn btn-primary">등록</button>
               <button type="button" id="modalCloseBtn" class="btn btn-primary dataDismiss" data-dismiss="modal">취소</button>
            </form>
         </div>
      </div>
   </div>
</div>

<div class="modal" id="mySell" style="z-index: 2000;">
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
                        $('#mySell').modal('show');
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