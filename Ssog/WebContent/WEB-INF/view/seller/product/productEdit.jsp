<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
td {
   padding-left: 10px;
}

img:hover {
   border: 2px solid silver;
}
</style>
<div class="row" style="width: 100%; height: 125%; margin-left: 50px;">
   <p style="text-align: left; margin-top: 20px;">
      <b>이 곳은 상품 수정 페이지 입니다.</b><br /> 쇼핑몰에 상품을 진열하는데 필요한 기본정보를 수정합니다.
      ${map.CUPON_TYPE }
   </p>
   <form action="/seller/product/productEditExec.j" method="post"
      enctype="multipart/form-data" id="editform">
      <input type="hidden" name="num" value="${param.num }">
      <c:if test="${!empty map.IMG_UUID }">
         <input type="hidden" name="uuid" value="${map.IMG_UUID }">
      </c:if>
      <div class="form-group">
         <table style="height: 100%; width: 100%;" border="1">
            <tr style="height: 5%">
               <td style="width: 20%; background-color: #eaeaea;">상품명</td>
               <td colspan="3"><input class="form-control" type="text"
                  style="width: 95%" name="pro_name" required="false"
                  value="${map.PRO_NAME }" /></td>
            </tr>
            <tr style="height: 5%;">
               <td style="background-color: #eaeaea;">판매가격</td>
               <td style="width: 30%;"><div class="navbar-form"
                     style="padding: 0px; margin: 0px;">
                     <input class="form-control" type="text" style="width: 82%"
                        name="price" onkeydown="onlyNumber(this)" required="false"
                        value="${map.PRICE }" /> 원
                  </div></td>
               <td style="width: 20%; background-color: #eaeaea;" rowspan="2">행사 등록</td>
               <td><input type="radio" class="group" value="false" name="radiogroup" ${empty map.CUPON_TYPE?'checked':'' } id="nouseEve" style="margin-left: 10px;"> &nbsp;사용안함 &nbsp;&nbsp;&nbsp;  <input type="radio" ${!empty map.CUPON_TYPE?'checked':'' } class="group" value="true" name="radiogroup" id="useEve">&nbsp;사용&nbsp;</td>   
   </tr>
            </tr>
            <tr style="height: 5%;">
               <td style="background-color: #eaeaea;">판매수량</td>
               <td colspan="1"><div class="navbar-form" 
                     style="padding: 0px; margin: 0px;">
                     <input class="form-control" type="text" style="width: 82%"
                        name="pro_qty" onkeydown="onlyNumber(this)" required="false" 
                        value="${map.PRO_QTY }"> 개
                  </div></td><td colspan="2" style="border-top: 0px;">
   <span id="zoro">    
   </span></td>
            </tr>
            <tr style="height: 5%;">
               <td style="background-color: #eaeaea;">분류</td>
               <td colspan="3">
                  <div class="navbar-form" style="padding: 0px; margin: 0px;">
                     <select class="form-control" style="width: 30%;" id="large_cate"><option>대분류</option>
                        <c:forEach items="${large_cate }" var="i" varStatus="vs">
                           <option value="${i.B_CATE }"
                              ${i.B_CATE eq  map.PARENT ? 'selected' : ''}>${i.NAME }</option>
                        </c:forEach>
                     </select><select class="form-control"
                        style="width: 30%; margin-left: 78px;" id="small_cate"
                        name="category"><option>소분류</option></select> 
                  </div>
               </td>
            </tr>
            <tr style="height: 5%;">
               <td style="background-color: #eaeaea;">생산지</td>
               <td colspan="3"><select class="form-control"
                  style="width: 30%;" required name="origin" id="origin"><option>생산지</option>
                     <c:forEach items="${originlist }" var="i">
                        <option value="${i.NUM }"
                           ${i.NUM eq  map.ORIGIN ? 'selected' : ''}> ${i.NAME }</option>
                     </c:forEach></td>
            </tr>
            <tr style="height: 23%;">
               <td style="background-color: #eaeaea;">대표 이미지</td>
               <td colspan="3"><div class="col-sm-3" style="padding: 0px;">
                     <div align="center">
                        <c:choose>
                           <c:when test="${empty map.IMG_UUID }">
                              <img id="imgbox" ; style="height: 150px; width: 150px;"
                                 src="/image/사진등록기본.png" />
                           </c:when>
                           <c:otherwise>
                              <img id="imgbox" ; style="height: 150px; width: 150px;"
                                 src="/img/pro_img/${map.IMG_UUID }" />
                           </c:otherwise>
                        </c:choose>

                        <input type="file" name="pro_img" style="display: none;"
                           id="img_upload">
                        <button style="margin-top: 5px;" id="img_btn" type="button">사진
                           등록</button>
                     </div>
                  </div>
                  <div class="col-sm-9">
                     <div style="color: blue">- 쇼핑몰에 기본으로 보여지는 상품 이미지를 등록합니다.</div>
                     <div style="color: blue">- 대표 이미지 등록시 목록 이미지에 자동 리사이징 되어
                        들어갑니다.</div>
                     <div style="color: gray;">- 권장 이미지 : 500px * 500px / 5Mb 미만
                        / png,jpg(jpeg)</div>
                  </div></td>
            </tr>
            <tr style="height: 52%;">
               <td style="background-color: #eaeaea;">상품 상세</td>
               <td colspan="3"><textarea id="pro_detail"
                     style="width: 100%; height: 100%; resize: none;"
                     name="pro_detail" required>${map.PRO_DETAIL }</textarea></td>
            </tr>

         </table>
         <div align="right" style="margin-top: 10px;"> 
            <button type="button" id="state">${map.SELL_ON eq 1?'판매 중지':'판매 재개' }</button>
            <button type="button" id="editbtn">상품 수정</button> 
         </div>
   </form>
</div>
</div>
<script src="/ckeditor/ckeditor.js"></script>
<script> 
   CKEDITOR.replace('pro_detail',{
         width : '95%',  // 입력창의 넓이, 넓이는 config.js 에서 % 로 제어
         height : '330px',  // 입력창의 높이          
        resize_enabled : false
       });
    $("#img_btn").on("click",function(){
       $("#img_upload").click();
    })
    $("#img_upload").on("change",function(){
       var reader = new FileReader();
       reader.onload = function(e) { 
       document.getElementById("imgbox").src=e.target.result;
       }
       reader.readAsDataURL(this.files[0]);
    })
</script>
<script>
 
 var t=function(){
    $.ajax({
          url : "/seller/product/smallcate.j",
          method: "get",
          data : { 
                "large_cate" : $("#large_cate").val(),
          }
       }).done(function(obj){ 
          var setTag = "";
          for(var i=0; i<obj.list.length; i++){
            if(obj.list[i].S_CATE == ${map.CATE}) {
                   setTag += "<option value=\""+ obj.list[i].S_CATE +"\" selected>" + obj.list[i].NAME + "</option>";
            }else {
               setTag += "<option value=\""+ obj.list[i].S_CATE +"\">" + obj.list[i].NAME + "</option>"; 
            }
            
          }
          $("#small_cate").html(setTag);  
       }); 
 }
 t();
 
    
$("#large_cate").change("click",function(){
    $.ajax({
       url : "/seller/product/smallcate.j",
       method: "get",
       data : { 
             "large_cate" : $("#large_cate").val(),
       }
    }).done(function(obj){ 
       var setTag = "";
       for(var i=0; i<obj.list.length; i++){
          
          setTag += "<option value=\""+ obj.list[i].S_CATE+"\" >" + obj.list[i].NAME + "</option>";
       }
       $("#small_cate").html(setTag);  
    });
 });
if(${!empty map.CUPON_TYPE  }){
    $.ajax({
         url : "/seller/product/useEve.j",
         method: "get",
         data:{
            "event" : $("#useEve").val()
         } 
       }).done(function(result){
         var select="<select name=\"event\" class=\"form-control\" style=\"width:70%;\">";
         for (var i = 0; i < result.list.length; i++) {
            var test = result.list[i].CUPON_NUM; 
            if("${map.CUPON_TYPE}" == test ){
            select+="<option value=\"" + result.list[i].CUPON_NUM + "\" selected >" + result.list[i].RATE + "</option>";
            }else{
               select+="<option value=\"" + result.list[i].CUPON_NUM + "\"  >" + result.list[i].RATE + "</option>";
            } 
         }      
         select+="</select>";   
         $("#zoro").html(select);  
   });
}
$("#useEve").on("click",function(){ 
    $.ajax({
      url : "/seller/product/useEve.j",
      method: "get",
      data:{
         "event" : $("#useEve").val()
      }
    }).done(function(result){
      var select="<select name=\"event\" class=\"form-control\" style=\"width:70%;\">";
      for (var i = 0; i < result.list.length; i++) {
         select+="<option value=\"" + result.list[i].CUPON_NUM + "\">" + result.list[i].RATE + "</option>";
      }      
      select+="</select>"; 
      $("#zoro").html(select); 
    })    
})
$("#nouseEve").on("click",function(){
    $("#zoro").html("");
})
$("#state").on("click",function(){ 
    $.ajax({
      url : "/seller/product/sellstate.j",
      method: "get", 
      data:{
         "num" : ${map.PRO_NUM },
         "sell_state" : ${map.SELL_ON }
      }
    }).done(function(result){
      if(${map.SELL_ON}==1){
         window.alert("판매가 중지되었습니다.");
      }else{
         window.alert("판매가 재개되었습니다.");
      }
      location.reload();
    })     
}) 
$("#editbtn").on("click",function(){
	var lcate=$("#large_cate").val();
	var scate=$("#small_cate").val();
	var origin=$("#origin").val();
	if(lcate != '대분류'){
		if(scate != '소분류'){
			if(origin != '생산지'){
	$("#editform").submit();					
			}else{
				window.alert("생산지를 선택해주세요");
			}
		}else{
			window.alert("소분류를 선택해주세요");
		}
	}else{
		window.alert("대분류를  선택해주세요.");
	}
})
</script>
<script>
function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
}
   </script>