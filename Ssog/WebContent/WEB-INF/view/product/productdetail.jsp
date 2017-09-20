<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
<style>
table, th {
   font-size: 20px;
}

body {
   position: relative;
}

#section1 {
   padding-top: 50px;
   height: 500px;
   color: #fff;
   background-color: #1E88E5;
}

#section2 {
   padding-top: 50px;
   height: 1000px;
   color: #fff;
   background-color: white;
}

#section3 {
   padding-top: 50px;
   height: 500px;
   color: #fff;
   background-color: #ff9800;
}

#section41 {
   padding-top: 50px;
   height: 500px;
   color: #fff;
   background-color: #00bcd4;
}

#section42 {
   padding-top: 50px;
   height: 500px;
   color: #fff;
   background-color: #009688;
}
</style>
<div class="row" align="center">
   <div style="width: 62%;">
      <div class="col-sm-12" style="border: 1px solid #8c8c8c;"> 
         <div class="row">
            <div class="col-sm-7" style="padding-left: 20px; padding-top: 25px;">
                   <div class="thumbnail">
                   <c:if test="${empty map.IMG_UUID }">
                   <img src="/image/이미지기본.jpg"
                     style="height: 37%; width: 100%;">  
                   </c:if>
                   <c:if test="${!empty map.IMG_UUID }">
                  <img src="/img/pro_img/${map.IMG_UUID }"
                     style="height: 37%; width: 100%;">  
                     </c:if>
                     </div>   
               <div align="right">
                  <b>상품만족도</b>
               </div>
            </div>
            <div class="col-sm-5" style="border-left: 1px solid #8c8c8c;">
               <div
                  style="border-bottom: 2px solid black; padding-top: 15px; padding-bottom: 15px;">
                  <b style="font-size: 25px;">${map.PRO_NAME }</b>
               </div>
               <div align="left" style="height: 425px;">
                  <table style="margin-left: 0px;">
                     <tbody>
                        <tr>
                           <th><p style="padding-top: 15px; font-size: 18px;">판매가</p></th>
                           <th style="padding-left: 60px;"><b><fmt:formatNumber
                                    value="${map.PRICE }" pattern="#,###" />원</b></th>
                        </tr>
                           
                        <tr>
                           <th><p style="padding-top: 15px; font-size: 18px;">행사할인가</p></th>
                           <th style="padding-left: 60px;"><c:choose>
                                 <c:when test="${empty elist }">-</c:when>
                                 <c:otherwise>
                                    <b style="color: #ff1a75;"><fmt:formatNumber
                                          value="${map.PRICE-((elist.RATE*0.01) *map.PRICE) }"
                                          pattern="#,###" />원</b>
                                          <input type="hidden" id="hd_discount">
                                 </c:otherwise>
                              </c:choose></th>
                        </tr>
                        <tr>
                           <th><p style="padding-top: 15px; font-size: 18px;">적립금</p></th>
                           <th style="padding-left: 60px;"><c:choose>
                                 <c:when test="${empty elist }">
                                    <fmt:formatNumber value="${map.PRICE*0.1 }" pattern="#,###" />원</c:when>
                                 <c:otherwise>
                                    <fmt:formatNumber
                                       value="${(map.PRICE-((elist.RATE*0.01) *map.PRICE))*0.1 }"
                                       pattern="#,###" />원
                              </c:otherwise>
                              </c:choose></th>
                        </tr>
                        <tr>
                           <th><p style="padding-top: 15px; font-size: 18px;">생산지</p></th>
                           <th style="padding-left: 60px;">${map.ORIGIN_NAME }</th>
                        </tr>
                        <tr>
                           <th><p style="padding-top: 15px; font-size: 18px;">판매자</p></th>
                           <th style="padding-left: 60px;">${map.SELLER_ID }</th>
                        </tr>
                        <tr>
                           <th><p
                                 style="padding-top: 15px; padding-bottom: 10px; font-size: 18px;">
                                 수량<small>(잔여수량<span id="qty">${map.PRO_QTY }</span>)
                              </p> </small></th>
                           <th style="padding-left: 60px;">
                              <div>
                                 <button id="minus">-</button>
                                 <input value="1" style="width: 40px;" id="quantity" />
                                 <button id="plus">+</button>
                              </div>
                           </th>
                        </tr>
                     </tbody>
                  </table>
                  <div style="border-top: 1px solid #8c8c8c;" align="left">
                     <b>합계금액</b><b style="padding-left: 125px; font-size: 28px;">
                        <c:choose>
                           <c:when test="${empty elist }">
                              <span id="total" style="color: #ff1a75;"><fmt:formatNumber
                                    value="${map.PRICE }" pattern="#,###" /> </span>원
                        </c:when>
                           <c:otherwise>
                              <b style="color: #ff1a75;"><span id="total"><fmt:formatNumber
                                    value="${map.PRICE-((elist.RATE*0.01) *map.PRICE) }"
                                    pattern="#,###" />원</span></b>
                              <input type="hidden" id="hd_event"
                                 value="${map.PRICE-((elist.RATE*0.01) *map.PRICE) }">
                           </c:otherwise>
                        </c:choose>
                     </b><br />
                     <div align="center">
                     <form action="/cart/orderr.j">
                     <input type="hidden" id="origin" value="${map.PRICE}" name="origin"/>
                     <input type="hidden" id="num" value="${map.PRO_NUM}" name="num"/>
                     <input type="hidden" id="total" value="" name="total"/>
                     <input type="hidden" id="quantity2" value="" name="quantity2"/>
                     <input type="hidden" id="discount" value="" name="discount"/> 
                        <button id="cartadd" style="width: 49%; height: 54;" type="button">장바구니</button>
                        <button id="order" style="background-color: #ff0066; color: white; width: 49%; height: 54;"
                           class="btn" type="submit">주문하기</button>
                           </form>
                     </div>
                  </div>
               </div>
            </div>
         </div>

      </div>
      <div class="col-sm-12" style="padding: 0px;">
         <div data-spy="scroll" data-target=".navbar" data-offset="50">
            <nav class="navbar navbar-inverse navbar-fixed" style="margin: 0px;">
               <div class="container-fluid">
                  <div class="navbar-header">
                     <button type="button" class="navbar-toggle"
                        data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                           class="icon-bar"></span>
                     </button>
                  </div>
                  <div>
                     <div class="collapse navbar-collapse" id="myNavbar">
                        <ul class="nav navbar-nav">
                           <li><a href="#section1">상품상세정보</a></li>
                           <li><a href="#section2">배송정보</a></li>
                           <li><a href="#section3">구매후기</a></li>
                           <li><a href="#section3">상품문의</a></li>
                        </ul>
                     </div>
                  </div>
               </div>
            </nav>

            <div id="section1" class="container-fluid">
               <h1>상품상제정보</h1>
               ${map.PRO_DETAIL }
            </div>
            <div id="section2" class="container-fluid">
               <img src="/image/배송정보.jpg" width="100%;" height="100%;">
            </div>
            <div id="section3" class="container-fluid">
               <div align="left">
                  <b style="font-size: 19px;">구매후기<b>
               </div>
               <div>
                  <table class="table table-hover" style="font-size: 14px;">
                     <thead>
                        <tr>
                           <th>번호</th>
                           <th>만족도</th>
                           <th>내용</th>
                           <th>작성자</th>
                        </tr>
                     </thead>
                     <tbody id="reviewBody">
                     <c:forEach items="${list }" var="i">
                        <tr>
                           <td>${i.NUM }</td>
                           <td>
                           <c:forEach begin="1" end="${i.STAR /2 }">
							<span class="fa fa-star" style="color: yellow;"></span>
                           </c:forEach>
                           </td>
                           <td>${i.CONTENT }</td>
                           <td>${i.USER_ID }</td>
                        </tr>
					</c:forEach>
                     </tbody>
                  </table>
                  <div align="right">
                  <c:if test="${exist }">
                     <button class="btn btn" style="width: 182px;; height: 42px;" id="reviewbtn">
                        <span class="glyphicon glyphicon-comment" />구매후기쓰기
                     </button>
                  </c:if>   
                  </div>
               </div>
               <div style="margin-top: 20px;" align="center">
   <ul class="pager">

      <ul class="pagination pagination-lg">
          <c:if test="${paging.startPageNo ne paging.firstPageNo }">
            <li><a 
               href="/product/detail.j?&page=${paging.startPageNo-1}&productNumber=${param.productNumber}">&lt;</a></li> 
         </c:if>
         <c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo }"
            var="i"> 
            <li><a
               href="/product/detail.j?page=${i eq 0?'1':i}&productNumber=${param.productNumber}">${i eq 0?'1':i }</a></li>
         </c:forEach>
         <c:if test="${paging.endPageNo ne paging.finalPageNo }">
            <li><a
               href="/product/detail.j?page=${paging.endPageNo+1}&productNumber=${param.productNumber}">&gt;</a></li>
         </c:if>
      </ul>
   </ul>
</div>
            </div>
            <div id="section41" class="container-fluid">
               <div align="left">
                  <b style="font-size: 19px;">상품문의<b>
               </div>
               <div align="right">
                  <form>
                     <div class="form-group">
                        <textarea class="form-control" rows="5" id="comment"></textarea>
                     </div>
                     <button class="btn btn" style="width: 182px; height: 42px;" type="button" id="QnAbtn">
                        <span class="glyphicon glyphicon-comment" />문의하기
                     </button>
                  </form>
               </div>
               <p style="font-size: 14px;" align="left">* 교환/환불/배송관련 문의는 고객센터
                  1:1문의에 남겨주시기 바랍니다. (상품문의 게시판에서는 제 때에 원활한 처리가 이뤄지지 않을 수 있습니다.)</p>
               <p style="font-size: 14px;" align="left">* 상품과 관련없는 광고성, 욕설,
                  비방, 허위정보, 도배 등은 예고없이 삭제될 수 있습니다.</p>
               <p style="font-size: 14px;" align="left">* 고객센터 근무시간(평일
                  오전10시~오후6시) 이 외의 시간에는 답변이 다소 지연될 수 있습니다.</p>
            </div>


         </div>
      </div>
   </div>
</div>
<script>
   var hid = $("#hd_event").val();
   var hid2 = Math.floor(hid);
   var total = $("#total").val($("#total").html());
   var quantity = $("#quantity2").val($("#quantity").val()); 
   var discount = $("#discount").val(hid2);
   $("#minus").on("click", function() {
      if(${empty elist}){
      if ($("#quantity").val() > 1) {
         $("#quantity").val(parseInt($("#quantity").val()) - 1)
         $("#total").html($("#quantity").val() * "${map.PRICE}")
      }
      }else{
         if ($("#quantity").val() > 1) {
            $("#quantity").val(parseInt($("#quantity").val()) - 1)
            $("#total").html($("#quantity").val() * hid2) 
         }
      } 
   });
   $("#plus").on("click", function() {
      if(${empty elist}){
      $("#quantity").val(1 + parseInt($("#quantity").val()))
      window.alert($("#total").html()); 
      $("#total").html($("#quantity").val() * "${map.PRICE}")
      if (parseInt($("#qty").html()) < parseInt($("#quantity").val())) {
         window.alert("재고가 부족합니다.");
         $("#quantity").val(parseInt($("#quantity").val()) - 1)
      }
      }else{ 
         $("#quantity").val(1 + parseInt($("#quantity").val()))
         $("#total").html($("#quantity").val() * hid2);
      }
   });
   $("#cartadd").on("click", function() {
      var cName = "${map.PRO_NUM}";
      var cValue = "addcart" + $("#quantity").val();
      var d = new Date(); 
      d.setTime(d.getTime() + (3 * 24 * 60 * 60 * 1000));
      var expires = "expires=" + d.toUTCString();
      cookies = cName + '=' + escape(cValue) + '; path=/ ';
      cookies += ';' + expires + ';';
      document.cookie = cookies;
      if (confirm("상품이 장바구니에 담겼습니다.\n바로 확인 하시겠습니까?") == true){
    	    location.href="/cart/form.j";  
    	}else{   //취소
    	    return;
    	}  
   }); 
    
   $("#reviewbtn").on("click",function(){
	   window.open('/product/review.j?seller_id=${map.SELLER_ID }&num=${map.PRO_NUM }', '리뷰쓰기', 'width=800, height=230, menubar=no, status=no, toolbar=no ,left=350 ,top = 250',' resizable=no ','location=no' );   
   })
   
   $("#QnAbtn").on("click",function(){
	   $.ajax({
			url : "/product/QnA.j",
			method: "get",
			data:{
				"comment" : $("#comment").val(),
				"num" :${param.productNumber }
			}
		 }).done(function(result){
			 window.alert(result.result);
		 })
	   
	   
   })
	
   
</script>