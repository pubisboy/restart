<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>검색 : ${total }건</div>
<div style="float: left;">
	<form action="/admin/sales/product/product_list.ja" id="form" method="get">
		<input type="hidden" name="value" value="${empty params.value ? '' : params.value}"/>
		<input type="hidden" name="sort"  value="${empty params.sort ? '' : params.sort}"/>
		<input type="hidden" name="on"  value="${empty params.on ? '' : params.on}"/>
		<select id="first" name="first">
			<optgroup label="대소분류">
			<option value="">전체</option>
			<c:forEach items="${stateKo }" var="i" varStatus="vs">
				<option value="${stateNum[vs.index] }" ${params.first eq stateNum[vs.index] ? 'selected' : ''}>${i }</option>
			</c:forEach>
			</optgroup>
		</select>
		<select id="second" name="second">
		</select>
	</form>
</div>
<div style="float: right;">
	<a
		href="/admin/sales/product/product_list.ja?p=${params.p}&type=${params.type }&value=${params.value}&first=${params.first}&second=${params.second}&sort=${params.sort}&on=${empty params.on ? 0 : (params.on eq 0 ? 1 : '')}">${empty params.on ? '전체' : (params.on eq 0 ? '중지' : '판매중')}</a>
</div>
<div style="float: right; width: 5%;">
	<a
		href="/admin/sales/product/product_list.ja?p=${params.p}&type=${params.type }&value=${params.value}&first=${params.first}&second=${params.second}&on=${params.on}&sort=${!empty params.sort and params.sort == 'asc' ? 'desc' : 'asc'}">${!empty params.sort and params.sort == 'asc' ? '오름' : '내림'}</a>
</div>
<table class="table table-bordered" style="text-align: center;">
	<thead>
		<tr>
			<th width="9%;" style="text-align: center;">상품번호</th>
			<th width="9%;" style="text-align: center;">카테(대)</th>
	       	<th width="22%;" style="text-align: center;">카테(소)</th>
	       	<th width="20%;" style="text-align: center;">상품이름</th>
	       	<th width="9%;" style="text-align: center;">판매자</th>
	       	<th width="18%;" style="text-align: center;">등록일</th>
	       	<th width="13%;" style="text-align: center;">상태</th>
    	</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="i" varStatus="vs">
			<tr>
				<td><a href="/admin/sales/product/product_detail.ja?num=${i.PRO_NUM }&p=${params.p}&type=${params.type }&value=${params.value}&first=${params.first}&second=${params.second}&on=${params.on}&sort=${params.sort}">${i.PRO_NUM }</a></td>
				<td>${i.BC }</td>
				<td>${i.SC }</td>
				<td>${i.PRO_NAME }</td>
				<td>${i.SELLER_ID }</td>
				<td>
					<fmt:formatDate value="${i.PRO_DATE }" pattern="yyyy:MM:dd hh:mm" var="time" />${time }
				</td>
				<td>${i.SELL_ON eq 1 ? '<b style=\'color:green\'>판매중</b>':'<b style=\'color:black\'>중지</b>'}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div align="center">
	<c:if test="${paging.startPageNo ne paging.firstPageNo }">
		<a href="/admin/sales/product/product_list.ja?p=${paging.startPageNo - 1}&type=${params.type }&value=${params.value}&first=${params.first}&second=${params.second}&sort=${params.sort}&on=${params.on}">&lt;</a>
	</c:if>
	
	<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo }" var="i">
		<a href="/admin/sales/product/product_list.ja?p=${i}&type=${params.type }&value=${params.value}&first=${params.first}&second=${params.second}&sort=${params.sort}&on=${params.on}" ${paging.currentPageNo eq i ? 'style="font-weight:bold"' : '' }>${i }</a>
	</c:forEach>
	
	<c:if test="${paging.endPageNo ne paging.finalPageNo }">
		<a href="/admin/sales/product/product_list.ja?p=${paging.endPageNo + 1}&type=${params.type }&value=${params.value}&first=${params.first}&second=${params.second}&sort=${params.sort}&on=${params.on}">&gt;</a>
	</c:if>
</div>

<div align="center">
	<form action="/admin/sales/product/product_list.ja" method="get">
		<select name="type" id="type">
			<c:forEach items="${typesKo }" var="i" varStatus="vs">
				<option value="${typesEn[vs.index] }" ${params.type eq typesEn[vs.index] ? 'selected' : ''}>${i }</option>
			</c:forEach>
		</select>
		<input type="text" name="value" value="${empty params.value ? '' : params.value}"/>
		<input type="hidden" name="first" value="${empty params.first ? '' : params.first}"/>
		<input type="hidden" name="second" value="${empty params.second ? '' : params.second}"/>
		<input type="hidden" name="sort"  value="${empty params.sort ? '' : params.sort}"/>
		<input type="hidden" name="on"  value="${empty params.on ? '' : params.on}"/>
	</form>
</div>

<script>
	
	
	/*
		이 부분을 만들었지만, 이해가 잘 안 되 
		역시 문제 점 발견
	*/
	$("#first").on("change", function(){
		$.ajax({
			'url':"/admin/sales/product/product_second.ja",
			'data':{
				'first':$("#first").val()
			}
		}).done(function(rst){
			$("#second").html(rst.html);
		});
	})
	
	function first(){
		if($("#first").val() != null && $("#first").val() != ""){
			$.ajax({
				'url':"/admin/sales/product/product_second.ja",
				'data':{
					'first':$("#first").val()
				}
			}).done(function(rst){
				$("#second").html(rst.html);
				var f = "${params.second}";
				if(f.length > 0){
					$("#"+f+"s").prop("selected", true);
				}
			});
		}else{
			$("#second").html("");
			$("#form").submit();
		}
	}
	if($("#first").val() != null && $("#first").val() != ""){
		first();
	}
	
	$("#first").on("change", function(){
		first();
	});
	
	$("#second").on("change", function(){
		$("#form").submit();
	});
	
</script>