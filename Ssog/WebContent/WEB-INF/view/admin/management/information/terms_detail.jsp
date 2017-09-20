<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="table table-bordered" style="text-align: center; min-height: 50%;">
	<tbody>
		<tr>
			<td>
				<h4><b>${list['0'].TITLE}</b></h4>
			</td>
		</tr>
		<tr>
			<td>
				<div style="float: left; width: 33%;"><b>번호</b>:${list['0'].NUM }</div>
				<div style="float: right; width: 33%;"><b>작성일자</b>:
				<fmt:formatDate value="${list['0'].TERMS_DATE }" pattern="yyyy-MM-dd hh:mm" var="time"/>${time } 
				</div>
			</td>
		</tr>
		<tr style="height: 100%;">
			<td style="text-align: left">
				${list['0'].CONTENT}
			</td>
		</tr>
	</tbody>
</table>

<div style="float: left; width: 10%; text-align: left">
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/information/terms_modify.ja?num=${list['0'].NUM }');">수정</button>
</div>
<div style="float: left; width: 10%; text-align: left">
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/information/terms_del.ja?num=${list['0'].NUM }');">삭제</button>
</div>
<div style="float: right; width: 33%; text-align: right">
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/information/terms.ja');">목록</button>
</div>
<script src="<c:url value="/etc.js" />"></script>