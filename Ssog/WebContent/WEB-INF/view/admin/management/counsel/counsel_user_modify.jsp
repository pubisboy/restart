<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row" align="center">
   <h2>1:1문의 답변</h2>
   <div>답변 : ${list['0'].REPLY eq 0 ? '<b style="color: blue;">답변대기</b>' : '<b style="color: green;">답변완료</b>' }</div>
   <div id="alert"></div>
   <div class="col-xs-0 col-md-1"></div>
   <div class="col-xs-12 col-md-10">
   		<form action="/admin/management/counsel/counsel_user_modifyExec.ja" method="post">
         <div class="form-group">
         	<input type="hidden" name="num" value="${list['0'].NUM }"/>
            <div align="left"><label>제목</label></div>
            <input type="text" name="title" id="title" class="form-control" value="${list['0'].TITLE }" readonly="readonly">
         </div>
         <div class="form-group">
            <div align="left"><label>내용</label></div>
            <textarea rows="15" class="form-control" name="content" id="content" style="resize: none">${content }</textarea>
         </div>
         <div class="form-group">
            <button id="submit" type="submit" class="btn btn-default">작성 완료</button>
            <button type="button" class="btn btn-default" onclick="cancel('/admin/management/counsel/counsel_user_list.ja?p=${params.p }&type=${params.type }&value=${params.value}&state=${params.state}&reply=${params.reply}&sort=${params.sort}');">취소</button>
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
</script>
<script src="<c:url value="/etc.js" />"></script>