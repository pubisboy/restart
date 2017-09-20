<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.btn-custom {
  background-color: hsl(0, 0%, 16%) !important;
  background-repeat: repeat-x;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#5b5b5b", endColorstr="#282828");
  background-image: -khtml-gradient(linear, left top, left bottom, from(#5b5b5b), to(#282828));
  background-image: -moz-linear-gradient(top, #5b5b5b, #282828);
  background-image: -ms-linear-gradient(top, #5b5b5b, #282828);
  background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5b5b), color-stop(100%, #282828));
  background-image: -webkit-linear-gradient(top, #5b5b5b, #282828);
  background-image: -o-linear-gradient(top, #5b5b5b, #282828);
  background-image: linear-gradient(#5b5b5b, #282828);
  border-color: #282828 #282828 hsl(0, 0%, 11%);
  color: #fff !important;
  border-radius: 0px;
  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.33);
  -webkit-font-smoothing: antialiased;
}
div.gallery {
   margin: 0%;
   border: 1px solid #ccc;
   float: left;   
   width: 33.3%;
   height: 350px;
} 
 
div.gallery:hover {
   border: 1px solid #777;
}

div.gallery img {
   width: 100%;
   height: 70%;
}

div.desc {
   padding: 15px;
   text-align: center;
}

table, th, td, tr {
   border: 0px solid black;
   text-align: left;
}

li {
   display: inline;
}
</style>
<div class="container" align="center">
   <h2>${page eq 1 ? '어제의 TOP 10' : '평점 TOP 10' }</h2>
   
<!--  상품 목록 보이는 곳    -->

   <c:forEach items="${list }" var="i">
      <div class="gallery">
         <a href="/product/detail.j?productNumber=${i.PRO_NUM }"> 
         <c:choose>
         <c:when test="${empty i.IMG_UUID }">
         <img src="/image/다운로드.jpg"
            alt="Fjords" width="300" height="200">
            </c:when>
            <c:otherwise>
            <img src="/img/pro_img/${i.IMG_UUID }"
            alt="Fjords" width="300" height="200">
            </c:otherwise>
            </c:choose>
         </a>
         <div class="desc">
            <div>${i.PRO_NAME }</div>
            <div>${i.PRO_DATE } // ${i.PRICE } //${i.NAME }</div> 
         </div>
      </div>
   </c:forEach>
</div>