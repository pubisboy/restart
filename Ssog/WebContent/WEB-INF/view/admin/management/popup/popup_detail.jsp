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
				<div style="float: left; width: 30%;"><b>번호</b>:${list['0'].POPUP_NUM }</div>
				<div style="float: left; width: 40%;"><b>쿠폰적용</b>:
				<c:choose>
					<c:when test="${list['0'].CUPON_BASE gt 0}">
						${list['0'].RATE}% 적용 중(<fmt:formatDate value="${list['0'].END_DATE }" pattern="yyyy-MM-dd hh:mm" var="time"/>${time })
					</c:when>
					<c:otherwise>
						미적용
					</c:otherwise>
				</c:choose>
				</div>
				<div style="float: right; width: 30%;"><b>작성일자</b>:
				<fmt:formatDate value="${list['0'].POPUP_DATE }" pattern="yyyy-MM-dd hh:mm" var="time"/>${time } 
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
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/popup/popup_modify.ja?num=${list['0'].POPUP_NUM }&p=${params.p }&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff}&sort=${params.sort}');">수정</button>
</div>
<div style="float: left; width: 10%; text-align: left">
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/popup/popup_del.ja?num=${list['0'].POPUP_NUM }&p=${params.p }&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff}&sort=${params.sort}');">삭제</button>
</div>
<div style="float: right; width: 33%; text-align: right">
<button type="button" class="btn btn-default" onclick="cancel('/admin/management/popup/popup_list.ja?num=${list['0'].POPUP_NUM }&p=${params.p }&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff}&sort=${params.sort}');">목록으로</button>
</div>
<script src="<c:url value="/etc.js" />"></script>