<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div style="width: 70%;">
	<div>검색 : ${total }건</div>
	<div style="float: right; text-align: right; width: 100%;">
		<button type="button" class="btn btn-default" onclick="cancel('/admin/management/cupon/cupon_write.ja');">쿠폰 생성</button>
	</div>
	<div>
		<div style="float: right;">
			<a
				href="/admin/management/cupon/cupon_list.ja?p=${params.p}&value=${params.value}&sort=${!empty params.sort and params.sort == 'asc' ? 'desc' : 'asc'}">오름/내림정렬</a>
		</div>
	</div>
	<table class="table table-bordered" style="text-align: center;">
		<thead>
			<tr>
				<th width="10%;" style="text-align: center;">번호</th>
				<th width="20%;" style="text-align: center;">할인율</th>
				<th width="30%;" style="text-align: center;">기한</th>
				<th width="10%;" style="text-align: center;">수정</th>
				<th width="10%;" style="text-align: center;">삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="i" varStatus="vs">
				<tr>
					<td>${i.NUM }</td>
					<td><span>${i.RATE }</span>%</td>
					<td><fmt:formatDate value="${i.END_DATE }"
							pattern="yyyy-MM-dd" var="time" />${time }</td>
					<td>
						<c:if test="${i.UU eq 0 and i.U eq 0}">
							<span id="${i.NUM }m" class="modify" style="cursor:pointer">o</span>
						</c:if>
						<a class="submit" id="${i.NUM }ms" style="cursor:pointer">o</a>
					</td>
					<td>
						<c:if test="${i.UU eq 0 and i.U eq 0}">
							<span id="${i.NUM }d" class="del" style="cursor:pointer">o</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div align="right"><button type="button" class="btn" id="delCom">강제 삭제</button></div>
	<div align="center">
	
		<c:if test="${paging.startPageNo ne paging.firstPageNo }">
			<a
				href="/admin/management/cupon/cupon_list.ja?p=${paging.firstPageNo}&value=${params.value}&sort=${params.sort}">&lt;&lt;</a>
		</c:if>
		
		<c:if test="${paging.startPageNo ne paging.firstPageNo }">
			<a
				href="/admin/management/cupon/cupon_list.ja?p=${paging.startPageNo - 1}&value=${params.value}&sort=${params.sort}">&lt;</a>
		</c:if>

		<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo }"
			var="i">
			<a
				href="/admin/management/cupon/cupon_list.ja?p=${i}&value=${params.value}&sort=${params.sort}"
				${paging.currentPageNo eq i ? 'style="font-weight:bold"' : '' }>${i }</a>
		</c:forEach>

		<c:if test="${paging.endPageNo ne paging.finalPageNo }">
			<a
				href="/admin/management/cupon/cupon_list.ja?p=${paging.endPageNo + 1}&value=${params.value}&sort=${params.sort}">&gt;</a>
		</c:if>
		
		<c:if test="${paging.endPageNo ne paging.finalPageNo }">
			<a
				href="/admin/management/cupon/cupon_list.ja?p=${paging.finalPageNo}&value=${params.value}&sort=${params.sort}">&gt;&gt;</a>
		</c:if>
	</div>


	<div align="center">
		<form action="/admin/management/cupon/cupon_list.ja" method="get">
			<input type="hidden" name="sort"
				value="${empty params.sort ? '' : params.sort}" /> <input
				type="text" name="value"
				value="${empty params.value ? '' : params.value}" placeholder="할인율" />
		</form>
	</div>
</div>

<script>
	var tmp;
	
	$(".submit").hide();
	$(".modify").on("click", function(){
		tmp = $(this);
		var id = $(this).attr('id');
		var rate = $(this).parent().prev().prev().children().html();
		var date = $(this).parent().prev().html();
		var htmlr = "<input type'text' id='"+id+"srate' size='1px;' style='height: 22;' value='"+rate+"'/>";
		var htmld = "<input type'text' id='"+id+"sdate' size='8px;' style='height: 22;' value='"+date+"'/>";
		$(this).parent().prev().prev().html(htmlr);
		$(this).parent().prev().html(htmld);
		$(this).hide();
		$("#"+id+"s").show();
	});
	
	$(".submit").on("click", function(){
		$(this).hide();
		var id = $(this).attr('id');
		var num = $(this).parent().prev().prev().prev().html();
		var rate = $(this).parent().prev().prev();
		var date = $(this).parent().prev();
		$.ajax({
			'url':"/admin/management/cupon/cupon_modify.ja",
			'data':{
				'num':num,
				'rate':$("#"+id+"rate").val(),
				'date':$("#"+id+"date").val(),
				'type':'post'
			}
		}).done(function(rst){
			if(rst != null){
				rate.html("<span>"+rst.RATE+"</span>%");
				date.html(rst.END_DATE);
				tmp.show();
			}
		});
	});
	
	$(".del").on("click", function(){
		var num = $(this).parent().prev().prev().prev().prev().html();
		$(this).parent().parent().remove();
		$.ajax({
			'url':"/admin/management/cupon/cupon_del.ja",
			'data':{
				'num':num,
				'type':'post'
			}
		}).done(function(rst){
			if(!rst.b){
				window.alert("삭제 실패");
			}
		});
	});
	
	$("#delCom").on("click", function(){
		window.open("/admin/management/cupon/cupon_delCom.ja", "popup", "width=300, height=100");
	});
	
</script>

<script src="<c:url value="/etc.js" />"></script>