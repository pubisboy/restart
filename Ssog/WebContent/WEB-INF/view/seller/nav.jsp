<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.dropdown-submenu { 
   	 position:relative; 
	}
	  
	 
	.dropdown-submenu > a:after {
	  border-color: transparent transparent transparent #333;
	  border-style: solid;
	  border-width: 5px 0 5px 5px;
	  content: " ";
	  display: block;
	  float: right;  
	  height: 0;     
	  margin-right: -10px;
	  margin-top: 5px;
	  width: 0;
	}
	 
	.dropdown-submenu:hover>a:after {
	    border-left-color:#555;
	 }
	
	/* li에 마우스 올렸을때 배경색 */
	.dropdown-menu > li > a:hover, .dropdown-menu > .active > a:hover {
	  text-decoration: none;
	   background: rgba( 40, 40, 40, 0.4 );  
	}   
	  
	@media (max-width: 767px) {
	
	  .navbar-nav  {
	     display: inline;
	  }
	  .navbar-default .navbar-brand {
	    display: inline;
	  }
	  .navbar-default .navbar-toggle .icon-bar {
	    background-color: #fff;
	  }
	  .navbar-default .navbar-nav .dropdown-menu > li > a {
	    color: red;
	    background-color: #ccc;
	    border-radius: 4px;
	    margin-top: 2px;   
	  }
	   .navbar-default .navbar-nav .open .dropdown-menu > li > a {
	     color: #333;
	   }
	   .navbar-default .navbar-nav .open .dropdown-menu > li > a:hover,
	   .navbar-default .navbar-nav .open .dropdown-menu > li > a:focus {
	     background-color: #ccc;
	   }
	
	   .navbar-nav .open .dropdown-menu { 
	     border-bottom: 0px solid white;  
	     border-radius: 0;
	   }
	  .dropdown-menu {
	      padding-left: 10px;
	  }
	  .dropdown-menu .dropdown-menu {
	      padding-left: 20px;
	   }
	   .dropdown-menu .dropdown-menu .dropdown-menu {
	      padding-left: 30px;
	   }
	   li.dropdown.open {
	    border: 0px solid red;
	   }
	
	}
	 
	#sohot > li > a {
	   color: white;
	   padding-left: 20px;
	}
	
	#sohot{
	   height:462px; 
	   width: 80px;
	   background-color: rgba( 120, 120, 120, 0.4 );
	   color :  blue;   
	   box-shadow: 0px 0px 0px #888888;
	   padding-top: 0px;
	   margin: 0px;   
	}
	#socool{
	   width: 160px;
	   background-color: #262626;
	   color : #ffffff;
	}
	 
	@media (min-width: 768px) {
	  ul.nav li:hover > ul.dropdown-menu { 
	    display: block;
	  }
	  ul.ssibal li > ul.dropdown-menu{ 
	    display: block;
	  }
	  #navbar {
	    text-align: center;
	  }

	.row ul {
	    list-style-type: none;
	    margin: 0;
	    padding: 0;
	    width: 200px;
	    background-color: #f1f1f1;
	}
	
	.row li a {
	    display: block;
	    color: #000;
	    padding: 8px 16px;
	    font-size: 12px;
	    color: gray;
	    text-decoration: none;
	    
	}
	
	.row li a.active {
		color: lightgray;
		font-weight:bold;
		font-size: 12px;
		background: rgb(46,61,68); /* Old browsers */
background: -moz-linear-gradient(top, rgba(46,61,68,1) 0%, rgba(43,58,65,1) 50%, rgba(42,53,60,1) 51%, rgba(43,57,71,1) 100%); /* FF3.6-15 */
background: -webkit-linear-gradient(top, rgba(46,61,68,1) 0%,rgba(43,58,65,1) 50%,rgba(42,53,60,1) 51%,rgba(43,57,71,1) 100%); /* Chrome10-25,Safari5.1-6 */
background: linear-gradient(to bottom, rgba(46,61,68,1) 0%,rgba(43,58,65,1) 50%,rgba(42,53,60,1) 51%,rgba(43,57,71,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#2e3d44', endColorstr='#2b3947',GradientType=0 ); /* IE6-9 */
		
	}
	
	.row li a:hover:not(.active) {
	    text-decoration:underline;
	}
	
	.sub-menu { display:none; }
</style>
<div class="wrap">
	<div style="border-top: 2px solid black; height: 100px; width: 200px;">
		<button style="width: 100%; height: 100%; " onClick="location='/seller/main.j'">
			<span class="glyphicon glyphicon-home" style="font-size: 18px;"></span>
				<c:choose>
					<c:when test="${sessionScope.seller_id ne null }">
						<b style="font-size: 20px;">${sessionScope.seller_id}님</b><br>
							<small style="color: #999999;">판매등급 : ${sessionScope.grade}<br /> 
							<b style="font-size: 9px; color: #8c8c8c;">
							고객과 함께하는 쏙쇼핑몰</b>
							</small>
					</c:when>
					<c:otherwise>
						<b style="font-size: 20px;">판매자 페이지</b><br>
							<b style="font-size: 9px;color: #8c8c8c;">
							고객과 함께하는 쏙쇼핑몰</b>
					</c:otherwise>
				</c:choose>
		</button>
	</div>
	
	<ul class="nav nav-stacked"
				style="margin-top: 0px; border-left: 1px solid #d9d9d9; border-right: 1px solid #d9d9d9; border-bottom: 1px solid #d9d9d9; width: 200px; text-align: left;">
		<li class="menu"><a class="active">기본정보 관리</a></li>
		<li class="sub-menu">
				<ul>
					<li><a href="/seller/info/info.j" >회원 정보</a></li>
					<li><a href="/seller/info/info_edit.j">회원 정보 변경</a></li>
					<li><a href="/seller/info/pass_edit.j">비밀번호 변경</a></li>
					<li><a href="/seller/delete.j">회원 탈퇴</a></li>
				</ul>
		</li>
		
		<li class="menu"><a class="active">상품관리</a></li>
		<li class="sub-menu">
			<ul>
				<li><a href="/seller/product/productReg.j">상품등록</a></li>
				<li><a href="/seller/product/list.j">상품 목록</a></li>
			</ul>
		</li>
		
		<li class="menu"><a class="active">주문관리</a></li>
		<li class="sub-menu">
			<ul>
				<li><a href="/seller/order/list.j">주문 현황</a></li>
				<li><a href="/seller/order/sales/list.j">매출 현황 보기</a></li>
			</ul>
		</li>
		
		<li class="menu"><a class="active">상담관리</a></li>
		<li class="sub-menu" >
			<ul>
				<li><a href="/seller/counsel/qna/list.j">상품 Q&A</a></li>
				<li><a href="/seller/counsel/review/list.j">상품 리뷰 보기</a></li>
				<li><a href="/seller/counsel/list.j">관리자에게 1:1 문의</a></li>
			</ul>
		</li>
	</ul>
</div>

<script>
	$(".menu").on("click",function(){
		  var obj = $(this);
		    obj.next().slideToggle(400);            
		    //obj.parent().parent().next().slideToggle(400);
	});
</script>
