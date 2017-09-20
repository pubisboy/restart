<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
table, th, td {
	font-size: 13px;
}
</style>
<div style="padding-top: 20px;">
	<h4 style="font-size: 17px; text-align: left;">
		<span class="glyphicon glyphicon-info-sign"
			style="padding-right: 10px;"></span><b style="padding-right: 10px; font-size: 1.1em; letter-spacing: -1px; color: #404040;">상품 
			Q&A</b><small style="font-size: 12px;">고객센터를 통하여 고객님께서 문의 하여 주신
			문의내역입니다.</small>
	</h4>
</div>
<div align="left">
<b style="font-size: 12px;">고객님께서 신청한 문의 : <b style="color: #ff4d4d; font-size: 13px;">${qlist.size() }</b>건</b>
</div>
<div class="row" style="padding-top: 10px;"> 
	<div class="col-sm-12">
		<table class="table table-hover">
			<thead>
				<tr style="border-top: 3px solid black;">
					<th>제목</th> 
					<th>브랜드</th>
					<th>작성일자</th>
					<th>답변</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="obj" items="${page }">
					<tr>
						<td>${obj.TITLE }</td>
						<td>${obj.CATE }</td>
						<td>${obj.QANDADATE }</td>
						<th></th>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${page.size() eq 0 }">
			등록된 내용이 없습니다. 
		</c:if>
	</div>
<div align="center" style="font-size: 15px;">
	<c:if test="${pg.startPageNo ne pg.firstPageNo}">&le;</c:if>
	<c:forEach var="i" begin="${pg.startPageNo }" end="${pg.endPageNo }">
		<a href="/member/myinfo/qna.j?p=${i }">${i }</a>
	</c:forEach>
	<c:if test="${pg.endPageNo ne pg.finalPageNo}">
		<a href="/member/myinfo/qna.j?p=${pg.endPageNo +1}">&gt;</a>
	</c:if>
</div>
</div>
