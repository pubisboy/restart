
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<link href="http://fonts.googleapis.com/css?family=Bitter&subset=latin" rel="stylesheet" type="text/css">

<style> 
li{
   list-style: none;
}
.dropdown-menu > li.kopie > a {
    padding-left:5px;
}  

/* 하위 메뉴 */
#sohot > .wonder > .girls {
   display: none;
   position: absolute; 
   top:0; 
   left:100%;
   background: #ffffff; /* Old browsers */
   background: -moz-linear-gradient(top, #ffffff 0%, #e5e5e5 100%); /* FF3.6-15 */
   background: -webkit-linear-gradient(top, #ffffff 0%,#e5e5e5 100%); /* Chrome10-25,Safari5.1-6 */
   background: linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
   filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#e5e5e5',GradientType=0 ); /* IE6-9 */
   
}
  
/* 하위 메뉴에 마우스 올렸을 때 */
#sohot > .wonder > .girls a:hover {
   background: rgba(40,40,40,0.05);
}


 li.drop{
    position: absolute; 
    left: -300px;
 }
 
.dropdown-submenu { 
    position:relative; 
}
.dropdown-submenu>.dropdown-menu {
   top:0;left:100%;
   margin-top:-6px;margin-left:-1px;
   -webkit-border-radius:0 6px 6px 6px;-moz-border-radius:0 6px 6px 6px;border-radius:0 6px 6px 6px;
 }
  
 #ssipal .byungsin{
    position: absolute;
    left: -288%;
    width: 800px; 
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
}  
  
</style>    
<div align="center" > 
<div id="navbar" style="width: 67%; height: 7%">    
  <div class="navbar navbar-static-top" role="navigation" style="height:100%; margin-bottom: 0px;"> 
            <div class="navbar-header" style="height: 100%;">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span> 
                    <span class="icon-bar"></span>
                </button>  
                <ul class="nav ssibal navbar-nav" style="height: 100%;" >  
                   <li class="dropdown" style="height: 100%;"> 
                    <a class="navbar-brand" class="ropdown-toggle"  href="#" id="socool" style="font-size: 16px; height: 100%;"><span class="glyphicon glyphicon-menu-hamburger" style="height: 100%;"></span>카테고리<b class="caret"></b></a>   
                    <!-- sohot (메뉴)-->
                    <ul class="nav dropdown-menu sohott" id="sohot" style="border-top: 0px;">
                    <li><a href="/product/list.j">상품 전체</a></li>
                          <li class="dropdown wonder"><a href="#" class="dropdown-toggle" data-toggle="dropdown">채소</a>
                              <ul class="dropdown-menu girls">
                                 <!-- <li class="kopie"><a href="#">전체보기</a></li> --> 
                                 <li style="padding-bottom: 10px; border-bottom: 1px solid black;">채소</li>
                                 <li style=""><a href="/product/list.j?category=101">쌈,샐러드</a></li>
                                 <li><a href="/product/list.j?category=102">뿌리채소,버섯</a></li>
                                 <li><a href="/product/list.j?category=103">양파,마늘,파,고추</a></li>
                                 <li><a href="/product/list.j?category=104">콩나물,나물류</a></li>
                              </ul>
                           </li>
                             
                           <li class="dropdown wonder"><a href="#" class="dropdown-toggle" data-toggle="dropdown">과일</a>
                              <ul class="dropdown-menu girls">
                                 <!-- <li class="kopie"><a href="#">전체보기</a></li> -->
                                 <li style="padding-bottom: 10px; border-bottom: 1px solid black;">과일</li>
                                 <li><a href="/product/list.j?category=201">과일</a></li>
                                 <li><a href="/product/list.j?category=202">건과일</a></li>
                                 <li><a href="/product/list.j?category=203">바나나,파인애플,키위</a></li>
                              </ul>
                           </li>
                           
                           <li class="dropdown wonder"><a href="#" class="dropdown-toggle" data-toggle="dropdown">양곡</a>
                              <ul class="dropdown-menu girls">
                                 <!-- <li class="kopie"><a href="#">전체보기</a></li> -->
                                 <li style="padding-bottom: 10px; border-bottom: 1px solid black;">양곡</li>
                                 <li><a href="/product/list.j?category=301">쌀</a></li>
                                 <li><a href="/product/list.j?category=302">잡곡</a></li>
                                 <li><a href="/product/list.j?category=303">가루</a></li>
                              </ul>
                           </li>
                           
                           <li class="dropdown wonder"><a href="#" class="dropdown-toggle" data-toggle="dropdown">정육</a>
                              <ul class="dropdown-menu girls">
                                 <!-- <li class="kopie"><a href="#">전체보기</a></li> -->
                                 <li style="padding-bottom: 10px; border-bottom: 1px solid black;">정육</li>
                                 <li><a href="/product/list.j?category=401">소고기</a></li>
                                 <li><a href="/product/list.j?category=402">돼지고기</a></li>
                                 <li><a href="/product/list.j?category=403">닭,오리</a></li>
                                 <li><a href="/product/list.j?category=404">가공육</a></li>
                                 <li><a href="/product/list.j?category=405">계란,알류</a></li>
                              </ul>
                           </li>
                           
                           <li class="dropdown wonder"><a href="#" class="dropdown-toggle" data-toggle="dropdown">수산물</a>
                              <ul class="dropdown-menu girls">
                                 <!-- <li class="kopie"><a href="#">전체보기</a></li> -->
                                 <li style="padding-bottom: 10px; border-bottom: 1px solid black;">수산물</li>
                                 <li><a href="/product/list.j?category=501">생선류</a></li>
                                 <li><a href="/product/list.j?category=502">오징어,낙지</a></li>
                                 <li><a href="/product/list.j?category=503">새우,게</a></li>
                                 <li><a href="/product/list.j?category=504">건어물</a></li>
                                 <li><a href="/product/list.j?category=505">해조류</a></li>
                              </ul>
                           </li>
                           
                     </ul><!-- sohot close -->
                 </li>
              </ul>
            </div>
              
         
        </div>
</div>
</div>
<script>
if(location.pathname != "/" ){ 
	$("#sohot").hide();
	$("#socool").on("click",function(){
		$("#sohot").show();
	})
	$(window).scroll(function(event){
		   var si = $("#ssibal").attr("class"); 
		   console.log(si);
		   var a=si.split(" ");
		   if(a[2]== "affix" ){ 
			   $(window).scroll(function(event){
				   var si = $("#ssibal").attr("class"); 
				   console.log(si);
				   var a=si.split(" ");
				   if(a[2]== "affix" ){ 
				      $("#sohot").hide();
				   }
				});
		   }
		});
}else{
$(window).scroll(function(event){
   var si = $("#ssibal").attr("class"); 
   console.log(si);
   var a=si.split(" ");
   if(a[2]== "affix" ){ 
      $("#sohot").hide();
   }else{
      $("#sohot").show();
   }
});
}

$('.wonder > .girls').parent().hover(function() {
     var submenu = $(this).children('.girls');
     var parent = $(this);
     if ( $(submenu).is(':hidden') ) {
       $(submenu).slideDown(5);
       $(parent).css("background", "rgba( 40, 40, 40, 0.4 )");
     } else {
       $(submenu).slideUp(5);
       $(parent).css("background", "none");
     }
   });
  
</script>
