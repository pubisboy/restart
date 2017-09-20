<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div>
	<div>검색 : ${total }건</div>
</div>

<div>
	<form action="/admin/management/counsel/counsel_seller_list.ja"
		method="get" id="stateForm">
		<input type="hidden" id="stateType" name="type"
			value="${empty params.type ? '' : params.type}" /> <input
			type="hidden" id="stateValue" name="Value"
			value="${empty params.value ? '' : params.value}" /> <input
			type="hidden" name="reply"
			value="${empty params.reply ? '' : params.reply}" /> <input
			type="hidden" name="sort"
			value="${empty params.sort ? '' : params.sort}" /> <select
			id="state" name="state">
			<optgroup label="카테고리">
				<option value="">전체</option>
				<c:forEach items="${state }" var="i" varStatus="vs">
					<option value="${i.NUM }"
						${params.state eq i.NUM ? 'selected' : ''}>${i.CATEGORY }</option>
				</c:forEach>
			</optgroup>
		</select>
	</form>
</div>
<div style="float: right;">
	<a
		href="/admin/management/counsel/counsel_seller_list.ja?p=${params.p}&type=${params.type }&value=${params.value}&state=${params.state}&sort=${params.sort}&reply=${empty params.reply ? 0 : (params.reply eq 0 ? 1 : '')}">${empty params.reply ? '전체' : (params.reply eq 0 ? '답변대기' : '답변완료')}</a>
</div>
<div style="float: right; width: 5%;">
	<a
		href="/admin/management/counsel/counsel_seller_list.ja?p=${params.p}&type=${params.type }&value=${params.value}&state=${params.state}&reply=${params.reply}&sort=${!empty params.sort and params.sort == 'asc' ? 'desc' : 'asc'}">${!empty params.sort and params.sort == 'asc' ? '오름' : '내림'}</a>
</div>
<table class="table table-bordered" style="text-align: center;">
	<thead>
		<tr>
			<th width="10%;" style="text-align: center;">분류</th>
			<th width="10%;" style="text-align: center;">번호</th>
			<th style="text-align: center;">제목</th>
			<th width="12%;" style="text-align: center;">작성자</th>
			<th width="18%;" style="text-align: center;">등록일</th>
			<th width="10%;" style="text-align: center;">상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="i" varStatus="vs">
			<tr>
				<td>${i.CATEGORY }</td>
				<td>${i.NUM }</td>
				<td align="left"><a
					href="/admin/management/counsel/counsel_seller_detail.ja?num=${i.NUM }&p=${params.p }&type=${params.type }&value=${params.value}&state=${params.state}&reply=${params.reply}&sort=${params.sort}">${i.TITLE }</a></td>
				<td>${i.USER_ID }</td>
				<td><fmt:formatDate value="${i.COUNSEL_DATE }"
						pattern="yyyy:MM:dd hh:mm" var="time" />${time }</td>
				<td>${i.REPLY == 0 ? '<b style="color: blue;">답변대기</b>' : '<b style="color: green;">답변완료</b>' }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div align="center">
	<c:if test="${paging.startPageNo ne paging.firstPageNo }">
		<a
			href="/admin/management/counsel/counsel_seller_list.ja?p=${paging.startPageNo - 1}&type=${params.type }&value=${params.value}&state=${params.state}&reply=${params.reply}&sort=${params.sort}">&lt;</a>
	</c:if>

	<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo }"
		var="i">
		<a
			href="/admin/management/counsel/counsel_seller_list.ja?p=${i}&type=${params.type }&value=${params.value}&state=${params.state}&reply=${params.reply}&sort=${params.sort}"
			${paging.currentPageNo eq i ? 'style="font-weight:bold"' : '' }>${i }</a>
	</c:forEach>

	<c:if test="${paging.endPageNo ne paging.finalPageNo }">
		<a
			href="/admin/management/counsel/counsel_seller_list.ja?p=${paging.endPageNo + 1}&type=${params.type }&value=${params.value}&state=${params.state}&reply=${params.reply}&sort=${params.sort}">&gt;</a>
	</c:if>
</div>

<div align="center">
	<form action="/admin/management/counsel/counsel_seller_list.ja"
		method="get">
		<input type="hidden" name="state"
			value="${empty params.state ? '' : params.state}" /> <input
			type="hidden" name="reply"
			value="${empty params.reply ? '' : params.reply}" /> <input
			type="hidden" name="sort"
			value="${empty params.sort ? '' : params.sort}" /> <select
			name="type">
			<c:forEach items="${typesKo }" var="i" varStatus="vs">
				<option value="${typesEn[vs.index] }"
					${params.type eq typesEn[vs.index] ? 'selected' : ''}>${i }</option>
			</c:forEach>
		</select> <input type="text" name="value"
			value="${empty params.value ? '' : params.value}" />
	</form>
</div>

<script>
	$("#state").on("change", function() {
		if ($("#state").val() == '') {
			$("#stateType").val('');
			$("#stateValue").val('');
		}
		$("#stateForm").submit();
	});
</script>