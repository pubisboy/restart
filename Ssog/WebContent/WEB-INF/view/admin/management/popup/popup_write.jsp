<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row" align="center">
   <h2>팝업 등록</h2>
   <div id="alert"></div>
   <div class="col-xs-0 col-md-1"></div>
   <div class="col-xs-12 col-md-10">
   		<form action="/admin/management/popup/popup_writeExec.ja" method="post" enctype="multipart/form-data">
	         <div class="form-group">
	            <div align="left"><label>제목</label></div>
	            <input type="text" name="title" id="title" class="form-control">
	         </div>
	         <div class="form-group">
	         	<div>
	         		<div>쿠폰적용</div>
	         		<div>적용<input type="radio" name="sw" value="on" id="on" />취소<input type="radio" name="sw" value="off" id="off" checked="checked"/></div>
	         	</div>
	         	<div id="cuponList">
		            <div align="left"><label>쿠폰리스트</label></div>
		            <select class="form-control" name="cupon"  id="cupon">
		            	<c:forEach var="i" items="${cupon }">
		            		<option value="${i.NUM }">할인율 : ${i.RATE }% / 기한 : 
		            		<fmt:formatDate value="${i.END_DATE }" pattern="yyyy-MM-dd hh:mm" var="time"/>${time }
		            		</option>
		            	</c:forEach>
		            </select>
	            </div>
	         </div>
	         <div class="form-group">
	            <div align="left"><label>내용</label></div>
	            <textarea rows="15" class="form-control" name="content" id="content" style="resize: none"></textarea>
	         </div>
	         <div class="form-group">
	         	<input type="file" name="f" />
	         </div>
	         <div class="form-group">
	            <button id="submit" type="submit" class="btn btn-default">작성</button>
	            <button type="button" class="btn btn-default" onclick="cancel('/admin/management/popup/popup_list.ja');">취소</button>
	         </div>
   		</form>
   </div>
   <div class="col-xs-0 col-md-1"></div>
</div>

<script src="/ckeditor/ckeditor.js"></script>

<script>
	CKEDITOR.replace('content', {
		'resize_enabled' : false
	});
	$("#cuponList").hide();
	$("#on").on("click", function(){
		$("#cuponList").show();
	})
	$("#off").on("click", function(){
		$("#cuponList").hide();
	})
</script>
<script src="<c:url value="/etc.js" />"></script>