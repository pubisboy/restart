<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
table, th, td {
	font-size: 13px;
}
.btn-custom {
  background-color: hsl(0, 0%, 16%) !important;
  background-repeat: repeat-x;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#5b5b5b", endColorstr="#282828");
  background-image: -khtml-gradient(linear, left top, left bottom, from(#5b5b5b), to(#282828));
  background-image: -moz-linear-gradient(top, #5b5b5b, #282828);
  background-image: -ms-linear-gradient(top, #5b5b5b, #282828);
  background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5b5b), color-stop(100%, #282828));
  background-image: -webkit-linear-gradient(top, #5b5b5b, #282828);
  background-image: -o-linear-gradient(top, #5b5b5b, #282828);
  background-image: linear-gradient(#5b5b5b, #282828);
  border-color: #282828 #282828 hsl(0, 0%, 11%);
  color: #fff !important;
  border-radius: 0px;
  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.33);
  -webkit-font-smoothing: antialiased;
}
</style>
<div style="padding-top: 20px;">
	<h4 style="font-size: 17px; text-align: left;">
		<span class="glyphicon glyphicon-info-sign"
			style="padding-right: 10px;"></span><b style="padding-right: 10px;">주문내역</b>
	</h4>
</div>
  <div class="row">
        <div class="col-sm-12" style="background-color: red;">상세검색section</div> 
        <div class="col-sm-12">
        <table class="table table-hover">
			<thead>
				<tr style="border-top: 3px solid black;">
					<th>주문일자</th>
					<th>주문번호</th>
					<th>주문상품</th>
					<th>결제금액</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="obj" items="${llist }">
					<tr>
						<td>${obj.ORDER_DATE }</td>
						<td>${obj.ORDER_NUM }</td>
						<td>${obj.PRO_NAME }</td>
						<th>${obj.PRICE }</th>
						<td>${obj.S }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${llist.size() eq 0 }">
			등록된 내용이 없습니다.
		</c:if>
        </div>
        <div class="col-sm-12"></div>
    </div>