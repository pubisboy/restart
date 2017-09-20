<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
      <div class="item active">
        <a href="/product/listAd.j?page=1"><img src="http://68.media.tumblr.com/0f711ca3dffbfe39307036d50c5e52b3/tumblr_nwxy5xItU81spslhyo1_1280.jpg" style="width: 100%; height: 460px;" alt="Image"></a>
        <div class="carousel-caption">
          <h3>어제의 TOP 10</h3>
          <p></p>
        </div>      
      </div> 

      <div class="item">
        <a href="/product/listAd.j?page=2"><img src="http://68.media.tumblr.com/6d6a0b50211b56602813d18bbcc96915/tumblr_nt4cw9pLOu1spslhyo1_1280.jpg" style="width: 100%; height: 460px;" alt="Image"></a>
        <div class="carousel-caption">
          <h3>평점 TOP 10</h3>
        </div>      
      </div>
    </div> 

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
</div>
<div align="center" style="padding-top: 15px;">  
	<div style="padding-top: 20px; font-size: 40px; width: 67%;">
	Recommendation<b>PRODUCT</b> <hr/> 
	<div style="padding-top: 10px;">    
	<img class="img-responsive" src="http://www.hellonature.net/shop/data/skin/renew_C/img/banner/%EC%B6%94%EC%B2%9C%EC%83%81%ED%92%88_%EB%AC%B4%ED%99%94%EA%B3%BC.jpg" width="1275.66" height="300"/>  
	</div>     
	</div>
	<div style="padding-top: 20px; font-size: 40px;">
    <div style="width: 69%; height: 30%;">    
    <div class="col-md-4">
      <div class="thumbnail">
        <a href="" target="_blank">
          <img src="http://www.hellonature.net/shop/data/goods/img/18143/c_o_1497432948589l1.jpg" alt="Lights" style="width:100%">
          <div class="caption" align="left" >
            <p style="font-size: 15px;">친환경 청경채</p><hr/>
            <p style="font-size: 0.6em; text-align: right;" ><b>1,500원</b></p>   
          </div>
        </a>
      </div>
    </div>
    <div class="col-md-4">
      <div class="thumbnail">
        <a href="" target="_blank">
          <img src="http://www.hellonature.net/shop/data/goods/img/18812/c_o_1505746672564l1.jpg" alt="Nature" style="width:100%">
          <div class="caption" align="left">
            <p style="font-size: 15px;">대잎양갱</p><hr/>
            <p style="font-size: 0.6em; text-align: right;" ><b>36,000원</b></p>
          </div>
        </a>
      </div>
    </div>
    <div class="col-md-4">
      <div class="thumbnail">
        <a href="" target="_blank">
          <img src="http://www.hellonature.net/shop/data/goods/img/12720/c_o_1466576446300l1.jpg" alt="Fjords" style="width:100%">
          <div class="caption" align="left">
            <p style="font-size: 15px;">우리콩참두부</p><hr/>
            <p style="font-size: 0.6em; text-align: right;" ><b>3,200원</b></p>  
          </div>
        </a>
      </div>
    </div> 
	<b>BEST</b>of<b>BEST</b> <hr/> 
	<div class="row">
        <div class="col-sm-4">
        <div class="thumbnail">
        <a href="" target="_blank">
          <img src="http://www.hellonature.net/shop/data/goods/img/15542/c_o_1455874501679l1.jpg" alt="Nature" style="width:100%">
          <div class="caption" align="left">
            <p style="font-size: 15px;">무항생제 방사유정란</p><hr/>
            <p style="font-size: 0.6em; text-align: right;" ><b>5,400원</b></p>
            <div class="thumbnail">
        <a href="" target="_blank">
          <img src="http://www.hellonature.net/shop/data/goods/img/17366/c_o_1486452356620l1.jpg" alt="Nature" style="width:100%">
          <div class="caption" align="left">
            <p style="font-size: 15px;">친환경 애호박</p><hr/>
            <p style="font-size: 0.6em; text-align: right;" ><b>3,900원</b></p> 
          </div>
        </a>
      </div>
          </div>
        </a>
      </div>
        </div>
        <div class="col-sm-8" >
        <img class="img-responsive" src="http://www.hellonature.net/shop/data/skin/renew_C/img/banner/%EC%9D%B8%EA%B8%B0%EC%83%81%ED%92%88_%EA%B5%AC%EC%9D%B4%EC%9A%A9%EC%A0%84%EC%96%B4.jpg" style="width: 100%;">      
        </div>
        <div class="col-sm-4">
       
        </div>
    </div>
    <div class="row">
        <div class="col-sm-4"></div>
        <div class="col-sm-4"></div>
        <div class="col-sm-4"></div>
    </div>
	
	
	
	</div>
	
</div> 
 </div>
<c:forEach items="${list }" var="i" varStatus="vs">
	<script>
		window.open("/popup.j?num=${i.POPUP_NUM}", "", "width=400, height=500, left=${vs.index * 50}, top=${vs.index * 50}");
	</script>
</c:forEach> 