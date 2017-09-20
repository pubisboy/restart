<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
				<div style="float: left; width: 33%;"><b>분류</b>:${list['0'].CATEGORY }</div>
				<div style="float: right; width: 33%;"><b>작성일자</b>:
				<fmt:formatDate value="${list['0'].COUNSEL_DATE }" pattern="yyyy-MM-dd hh:mm" var="time"/>${time } 
				</div>
			</td>
		</tr>
		<tr style="height: 100%;">
			<td style="text-align: left">
				${list['0'].CONTENT}
			</td>
		</tr>
		<tr>
			<td>
				<c:choose>
					<c:when test="${empty list['0'].IMAGE_UUID }">
						첨부파일 없음
					</c:when>
					<c:otherwise>
						<button type="button" id="image">첨부파일 확인</button>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</tbody>
</table>

<div style="float: left; width: 10%; text-align: left">
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/counsel/counsel_seller_modify.ja?num=${list['0'].NUM }');">답변</button>
</div>
<div style="float: left; width: 10%; text-align: left">
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/counsel/counsel_seller_del.ja?num=${list['0'].NUM }');">삭제</button>
</div>
<div style="float: right; width: 33%; text-align: right">
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/counsel/counsel_seller_list.ja?p=${params.p }&type=${params.type }&value=${params.value}&state=${params.state}&reply=${params.reply}&sort=${params.sort}');">목록</button>
</div>
<script src="<c:url value="/etc.js" />"></script>
<script>
	$("#image").on("click", function(){
		window.open("/resource/img_counsel/${list['0'].IMAGE_UUID}", "", "width=500, height=500");
	});
</script>