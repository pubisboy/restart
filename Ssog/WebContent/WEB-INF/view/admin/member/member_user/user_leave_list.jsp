<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>검색 : ${total }건</div>
<div style="float: left;">
	<form action="/admin/member/member_user/user_leave_list.ja" method="get" id="stateForm">
		<input type="hidden" id="stateValue" name="value" value="${empty params.value ? '' : params.value}"/>
		<input type="hidden" id="stateSort" name="sort" value="${empty params.sort ? '' : params.sort}"/>
		<select id="state" name="cate">
			<optgroup label="상태분류">
			<option value="">전체</option>
			<c:forEach items="${stateKo }" var="i" varStatus="vs">
				<option value="${stateNum[vs.index] }" ${params.cate eq stateNum[vs.index] ? 'selected' : ''}>${i }</option>
			</c:forEach>
			</optgroup>
		</select>
	</form>
</div>
<div style="float: right; width: 5%;">
	<a
		href="/admin/member/member_user/user_leave_list.ja?p=${params.p}&value=${params.value}&cate=${params.cate}&sort=${!empty params.sort and params.sort == 'asc' ? 'desc' : 'asc'}">${!empty params.sort and params.sort == 'asc' ? '오름' : '내림'}</a>
</div>
<table class="table table-bordered" style="text-align: center;">
	<thead>
		<tr>
			<th width="10%;" style="text-align: center;">번호</th>
	       	<th width="30%;" style="text-align: center;">분류</th>
	       	<th width="30%;" style="text-align: center;">기타</th>
	       	<th width="20%;" style="text-align: center;">탈퇴일</th>
    	</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="i" varStatus="vs">
			<tr>
				<td>${i.NUM }</td>
				<td>${i.REASON }</td>
				<td><a href="/admin/member/member_user/user_leave_detail.ja?num=${i.NUM }&value=${params.value}&cate=${params.cate}&sort=${params.sort}">${empty i.DETAIL ? '' : i.DETAIL}</a></td>
				<td>
					<fmt:formatDate value="${i.LEAVEDATE }" pattern="yyyy:MM:dd hh:mm" var="time" />${time }
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div align="center">
	<c:if test="${paging.startPageNo ne paging.firstPageNo }">
		<a href="/admin/member/member_user/user_leave_list.ja?p=${paging.startPageNo - 1}&value=${params.value}&cate=${params.cate}&sort=${params.sort}">&lt;</a>
	</c:if>
	
	<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo }" var="i">
		<a href="/admin/member/member_user/user_leave_list.ja?p=${i}&value=${params.value}&cate=${params.cate}&sort=${params.sort}" ${paging.currentPageNo eq i ? 'style="font-weight:bold"' : '' }>${i }</a>
	</c:forEach>
	
	<c:if test="${paging.endPageNo ne paging.finalPageNo }">
		<a href="/admin/member/member_user/user_leave_list.ja?p=${paging.endPageNo + 1}&value=${params.value}&cate=${params.cate}&sort=${params.sort}">&gt;</a>
	</c:if>
</div>

<div align="center">
	<form action="/admin/member/member_user/user_leave_list.ja" method="get">
		<input type="text" name="value" value="${empty params.value ? '' : params.value}"/>
		<input type="hidden" name="cate" value="${empty params.cate ? '' : params.cate}"/>
		<input type="hidden" name="sort" value="${empty params.sort ? '' : params.sort}"/>
	</form>
</div>

<script>
	$("#state").on("change", function(){
		if($("#state").val() == ''){
			$("#stateType").val('');
			$("#stateValue").val('');
		}
		$("#stateForm").submit();
	})
</script>