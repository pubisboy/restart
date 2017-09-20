<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>\
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
			style="padding-right: 10px;"></span><b style="padding-right: 10px;">할인쿠폰</b><small>회원님의
			할인쿠폰 내역을 확인할 수 있습니다.</small>
	</h4>
</div>
<ul class="nav nav-tabs">
	<li class="active"><a data-toggle="tab" href="#home">사용가능한쿠폰()</a></li>
	<li><a data-toggle="tab" href="#menu1">지난쿠폰내역()</a></li>
	<div style="padding-left: 600px;">
		<button class="btn btn-custom" style="width: 85px; height: 22px; font-size: 11px; padding: 0px;">쿠폰 다운로드</button>
	</div>
</ul>
<div class="tab-content">
	<div id="home" class="tab-pane fade in active">
		<table class="table table-hover">
			<thead>
				<tr style="border-bottom: 2px solid #595959;">
					<th>쿠폰ID</th>
					<th>쿠폰명</th>
					<th>할인액(율)</th>
					<th>상태</th>
					<th>발급일<br />(유효기간)</th>
					<th>사용조건</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="i" items="${clist }">
				<tr>
					<td>${i.CUPON_LIST_ID }</td>
					<td>${i.RATE }%</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div id="menu1" class="tab-pane fade">
		과거 사용하셨거나 발급 후 유효기간이 종료되어 더 이상 사용이 불가능한 쿠폰 내역입니다.
		<table class="table table-hover">
			<thead>
				<tr>
					<th>쿠폰ID</th>
					<th>쿠폰명</th>
					<th>할인액(율)</th>
					<th>상태</th>
					<th>발급일<br />(유효기간)
					</th>
					<th>사용조건</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1000</td>
					<td>15% 쿠폰</td>
					<td>6,000원</td>
					<td></td>
					<td>2016-10-09<br />~2017-09-01
					</td>
					<td>50만원이상</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
