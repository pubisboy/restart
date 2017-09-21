<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>검색 : ${total }건</div>
<div style="float: left;">
	<form action="/admin/sales/order/order_list.ja" method="get" id="stateForm">
		<input type="hidden" id="stateType" name="type" value="${empty params.type ? '' : params.type}"/>
		<input type="hidden" id="stateValue" name="value" value="${empty params.value ? '' : params.value}"/>
		<input type="hidden" id="stateSort" name="sort" value="${empty params.sort ? '' : params.sort}"/>
		<select id="state" name="state">
			<optgroup label="상태분류">
			<option value="">전체</option>
			<c:forEach items="${stateKo }" var="i" varStatus="vs">
				<option value="${stateNum[vs.index] }" ${params.state eq stateNum[vs.index] ? 'selected' : ''}>${i }</option>
			</c:forEach>
			</optgroup>
		</select>
	</form>
</div>
<div style="float: right; width: 5%;">
	<a
		href="/admin/sales/order/order_list.ja?p=${params.p}&type=${params.type }&value=${params.value}&state=${params.state}&sort=${!empty params.sort and params.sort == 'asc' ? 'desc' : 'asc'}">${!empty params.sort and params.sort == 'asc' ? '오름' : '내림'}</a>
</div>
<table class="table table-bordered" style="text-align: center;">
	<thead>
		<tr>
			<th width="9%;" style="text-align: center;">주문번호</th>
	       	<th width="9%;" style="text-align: center;">상품번호</th>
	       	<th style="text-align: center;">상품이름</th>
	       	<th width="16%;" style="text-align: center;">주문일</th>
	       	<th width="16%;" style="text-align: center;">결제일</th>
	       	<th width="9%;" style="text-align: center;">구매자</th>
	       	<th width="9%;" style="text-align: center;">판매자</th>
	       	<th width="10%;" style="text-align: center;">상태</th>
    	</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="i" varStatus="vs">
			<tr>
				<td><a href="/admin/sales/order/order_detail.ja?order_num=${i.ORDER_NUM }&type=${params.type }&value=${params.value}&state=${params.state}&sort=${params.sort}">${i.ORDER_NUM }</a></td>
				<td>${i.PRO_NUM }</td>
				<td>${i.PRO_NAME }</td>
				<td>
					<fmt:formatDate value="${i.ORDER_DATE }" pattern="yyyy:MM:dd hh:mm" var="time" />${time }
				</td>
				<c:choose>
					<c:when test="${empty i.PAY_DATE }">
						''
					</c:when>
					<c:otherwise>
						<td>
							<fmt:formatDate value="${i.PAY_DATE }" pattern="yyyy:MM:dd hh:mm" var="time" />${time }
						</td>
					</c:otherwise>
				</c:choose>
				<td>${i.USER_ID }</td>
				<td>${i.SELLER_ID }</td>
				<td>${i.ST }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div align="center">

	<c:if test="${paging.startPageNo ne paging.firstPageNo }">
		<a href="/admin/sales/order/order_list.ja?p=${paging.firstPageNo}&type=${params.type }&value=${params.value}&state=${params.state}&sort=${params.sort}">&lt;&lt;</a>
	</c:if>
	
	<c:if test="${paging.startPageNo ne paging.firstPageNo }">
		<a href="/admin/sales/order/order_list.ja?p=${paging.startPageNo - 1}&type=${params.type }&value=${params.value}&state=${params.state}&sort=${params.sort}">&lt;</a>
	</c:if>
	
	<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo }" var="i">
		<a href="/admin/sales/order/order_list.ja?p=${i}&type=${params.type }&value=${params.value}&state=${params.state}&sort=${params.sort}" ${paging.currentPageNo eq i ? 'style="font-weight:bold"' : '' }>${i }</a>
	</c:forEach>
	
	<c:if test="${paging.endPageNo ne paging.finalPageNo }">
		<a href="/admin/sales/order/order_list.ja?p=${paging.endPageNo + 1}&type=${params.type }&value=${params.value}&state=${params.state}&sort=${params.sort}">&gt;</a>
	</c:if>
	
	<c:if test="${paging.endPageNo ne paging.finalPageNo }">
		<a href="/admin/sales/order/order_list.ja?p=${paging.finalPageNo}&type=${params.type }&value=${params.value}&state=${params.state}&sort=${params.sort}">&gt;&gt;</a>
	</c:if>
</div>

<div align="center">
	<form action="/admin/sales/order/order_list.ja" method="get">
		<select name="type">
			<c:forEach items="${typesKo }" var="i" varStatus="vs">
				<option value="${typesEn[vs.index] }" ${params.type eq typesEn[vs.index] ? 'selected' : ''}>${i }</option>
			</c:forEach>
		</select>
		<input type="text" name="value" value="${empty params.value ? '' : params.value}"/>
		<input type="hidden" name="state" value="${empty params.state ? '' : params.state}"/>
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