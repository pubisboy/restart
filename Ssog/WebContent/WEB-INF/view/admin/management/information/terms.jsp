<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>검색 : ${total }건</div>

<div align="right">
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/information/terms_plus.ja');">약관 생성</button>
</div>
<table class="table table-bordered" style="text-align: center;">
	<thead>
		<tr>
			<th width="15%;" style="text-align: center;">번호</th>
	       	<th style="text-align: center;">제목</th>
	       	<th width="20%;" style="text-align: center;">작성일자</th>
    	</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="i" varStatus="vs">
			<tr>
				<td>${i.NUM }</td>
				<td align="left"><a href="/admin/management/information/terms_detail.ja?num=${i.NUM }">${i.TITLE }</a></td>
				<td>
				<fmt:formatDate value="${i.TERMS_DATE }" pattern="yyyy-MM-dd hh:mm" var="time"/>${time }
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div align="center">
	<c:if test="${paging.startPageNo ne paging.firstPageNo }">
		<a href="/admin/management/information/terms.ja?p=${paging.startPageNo - 1}&value=${params.value}">&lt;</a>
	</c:if>
	
	<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo }" var="i">
		<a href="/admin/management/information/terms.ja?p=${i}&value=${params.value}" ${paging.currentPageNo eq i ? 'style="font-weight:bold"' : '' }>${i }</a>
	</c:forEach>
	
	<c:if test="${paging.endPageNo ne paging.finalPageNo }">
		<a href="/admin/management/information/terms.ja?p=${paging.endPageNo + 1}&value=${params.value}">&gt;</a>
	</c:if>
</div>

<div align="center">
	<form action="/admin/management/information/terms.ja?" method="get">
		<input type="text" name="value" value="${empty params.value ? '' : params.value}" placeholder="제목"/>
	</form>
</div>

<script src="<c:url value="/etc.js" />"></script>