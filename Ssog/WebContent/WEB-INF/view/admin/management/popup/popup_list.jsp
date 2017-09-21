<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>검색 : ${total }건</div>
	<div style="float: right; text-align: right; width: 100%;">
		<button type="button" class="btn btn-default" onclick="cancel('/admin/management/popup/popup_write.ja');">팝업생성</button>
	</div>
<div>
	<div style="float: right;">
	<a href="/admin/management/popup/popup_list.ja?p=${params.p}&value=${params.value}&cupon=${empty params.cupon ? 1 : (params.cupon eq 1 ? 0 : '')}&onoff=${params.onoff }&sort=${params.sort}">${empty params.cupon ? '전체' : (params.cupon eq 0 ? '없음' : '있음')}</a></div>
	<div style="float: right; width: 10%;">
	<a href="/admin/management/popup/popup_list.ja?p=${params.p}&value=${params.value}&cupon=${params.cupon}&onoff=${empty params.onoff ? 1 : (params.onoff eq 1 ? 0 : '')}&sort=${params.sort}">${empty params.onoff ? '전체' : (params.onoff eq 0 ? '비활성화' : '활성화')}</a></div>
	<div style="float: right; width: 10%;">
	<a
		href="/admin/management/popup/popup_list.ja?p=${params.p}&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff }&sort=${!empty params.sort and params.sort == 'asc' ? 'desc' : 'asc'}">${!empty params.sort and params.sort == 'asc' ? '오름' : '내림'}</a>
</div>
</div>
<table class="table table-bordered" style="text-align: center;">
	<thead>
		<tr>
			<th width="15%;" style="text-align: center;">번호</th>
	       	<th style="text-align: center;">제목</th>
	       	<th width="10%;" style="text-align: center;">쿠폰여부</th>
	       	<th width="20%;" style="text-align: center;">등록일</th>
	       	<th width="10%;" style="text-align: center;">활성화</th>
    	</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="i" varStatus="vs">
			<tr>
				<td>${i.POPUP_NUM }</td>
				<td align="left"><a href="/admin/management/popup/popup_detail.ja?num=${i.POPUP_NUM }&p=${params.p }&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff }&sort=${params.sort }">${i.TITLE }</a></td>
				<td>
					<c:choose>
						<c:when test="${i.CUPON_BASE gt 0}">
							<span style="color: red;">on</span>
						</c:when>
						<c:otherwise>
							<span style="color: black;">off</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td><fmt:formatDate value="${i.POPUP_DATE }" pattern="yyyy-MM-dd hh:mm" var="time"/>${time }</td>
				<td id="${i.POPUP_NUM }">
				<c:choose>
					<c:when test="${i.ONOFF eq 1}">
						<span style="cursor: pointer;" class="onoff"><b style="color: red;">on</b></span>
					</c:when>
					<c:otherwise>
						<span style="cursor: pointer;" class="onoff"><b style="color: black;">off</b></span>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div align="center">

	<c:if test="${paging.startPageNo ne paging.firstPageNo }">
		<a href="/admin/management/popup/popup_list.ja?p=${paging.firstPageNo}&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff }&sort=${params.sort }">&lt;&lt;</a>
	</c:if>
	
	<c:if test="${paging.startPageNo ne paging.firstPageNo }">
		<a href="/admin/management/popup/popup_list.ja?p=${paging.startPageNo - 1}&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff }&sort=${params.sort }">&lt;</a>
	</c:if>
	
	<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo }" var="i">
		<a href="/admin/management/popup/popup_list.ja?p=${i}&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff }&sort=${params.sort }" ${paging.currentPageNo eq i ? 'style="font-weight:bold"' : '' }>${i }</a>
	</c:forEach>
	
	<c:if test="${paging.endPageNo ne paging.finalPageNo }">
		<a href="/admin/management/popup/popup_list.ja?p=${paging.endPageNo + 1}&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff }&sort=${params.sort }">&gt;</a>
	</c:if>
	
	<c:if test="${paging.endPageNo ne paging.finalPageNo }">
		<a href="/admin/management/popup/popup_list.ja?p=${paging.finalPageNo}&value=${params.value}&cupon=${params.cupon}&onoff=${params.onoff }&sort=${params.sort }">&gt;&gt;</a>
	</c:if>
</div>


<div align="center">
	<form action="/admin/management/popup/popup_list.ja" method="get">
		<input type="hidden" name="cupon" value="${empty params.cupon ? '' : params.cupon}"/>
		<input type="hidden" name="onoff" value="${empty params.onoff ? '' : params.onoff}"/>
		<input type="hidden" name="sort" value="${empty params.sort ? '' : params.sort}"/>
		<input type="text" name="value" value="${empty params.value ? '' : params.value}" placeholder="제목"/>
	</form>
</div>

<script src="<c:url value="/etc.js" />"></script>
<script>
	var init = function(){
		$(".onoff").on("click", function(){
			var onoff = $(this).children().html();
			var now = $(this);
			var num = $(this).parent().attr('id');
			var par = $(this).parent();
			$.ajax({
				'url':'/admin/management/popup/popup_switch.ja',
				'data':{
					'num':num,
					'of':onoff
				}
			}).done(function(rst){
				if(rst.b){
					now.html(rst.rst);
				}
			});
		})		
	}
	init();
</script>