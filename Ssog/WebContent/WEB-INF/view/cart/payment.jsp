<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div align="center">
	<div style="width: 58.5%; padding-top: 30px;">
		<div class="row">
			<div class="col-sm-12"
				style="border-bottom: 2px solid gray; border-left: 1px solid gray; border-right: 1px solid gray;">
				<div class="row">
					<div class="col-sm-8"
						style="border-top: 2px solid black; border-right: 1px solid #b3b3b3; padding: 0px;">
						<div
							style="padding-left: 40px; padding-top: 15px; padding-bottom: 15px; text-align: left;">
							<span class="glyphicon glyphicon-shopping-cart"
								style="font-size: 30px; color: #b3b3b3;"></span> <b
								style="font-size: 15px; color: #b3b3b3;">장바구니</b> <span
								class="glyphicon glyphicon-chevron-right"
								style="font-size: 30px; padding-left: 35px; padding-right: 35px; color: #b3b3b3;"></span>

							<span class="glyphicon glyphicon-credit-card"
								style="font-size: 30px; color: #b3b3b3;"></span> <b
								style="font-size: 15px; color: #b3b3b3;">주문/결제</b> <span
								class="glyphicon glyphicon-chevron-right"
								style="font-size: 30px; padding-left: 35px; padding-right: 35px;"></span>

							<span class="glyphicon glyphicon-gift" style="font-size: 45px;"></span>
							<b style="font-size: 30px;">주문완료</b>
						</div>
					</div>
					<div class="col-sm-4" style="border-top: 2px solid #ff0066;">
						<div style="height: 86px; padding-top: 35px; padding-left: 28px;"
							align="left">
							<b style="font-size: 18px; color: #4d4d4d;">${memberinfo.NAME }님</b>
							감사합니다!<br />
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div align="left">
					<b style="font-size: 17px;">결제정보</b>
				</div>
				<table class="table">
					<tbody>
						<tr style="border-top: 2px solid black; font-size: 12px;">
							<td class="active" style="width: 16%;">주문일자</td>
							<td>(주문일자나오는곳)</td>
						</tr>
						<tr style="font-size: 12px;">
							<td class="active">결제금액</td>
							<td><fmt:formatNumber value="${param.totalcash }"
									pattern="#,###" />원</td>
						</tr>
						<tr style="font-size: 12px;">
							<td class="active">결제방식</td>
							<td>${param.valu eq 'emailkey' ? '이메일결제' : '무통장입금' }</td>
						</tr>
						<tr style="font-size: 12px;">
							<td class="active">배송지</td>
							<td>${map.address }</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-sm-12">
				<div align="left">
					<b style="font-size: 17px;">주문정보</b>
				</div>
				<table class="table table-hover">
					<thead>
						<tr
							style="border-top: 2px solid black; background-color: #f2f2f2; height: 40px; font-size: 12.5px;">
							<th></th>
							<th>상품명</th>
							<th>수량</th>
							<th>할인금액</th>
							<th>결제금액</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="data" items="${map.ar1}" varStatus="vs">
							<tr style="border-bottom: 1px solid #b3b3b3; font-size: 12.5px;">
								<td>상품이미지</td>
								<td class="pd_num">${map.ar2[vs.index]}</td>
								<td>${data}</td>
								<td></td>
								<td></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div>
			<a href="/product/list.j"><button>계속쇼핑</button></a>
			<a href="/"><button>확인</button></a>
			</div>
		</div>
	</div>
</div>
<script>
	window.document.onkeydown = protectKey; 
	function protectKey() { 
		//새로고침을 막는 스크립트.. F5 번키..
		if (event.keyCode == 116) {
			event.keyCode = 0;
			return false;
		}
		//CTRL + N 즉 새로 고침을 막는 스크립트....
		else if ((event.keyCode == 78) && (event.ctrlKey == true)) {
			event.keyCode = 0;
			return false;
		}
	}
	$(".pd_num").each(function(){
		var cName = $(this).html();
		var cValue = "new";
		var d = new Date(); 
		d.setTime(d.getTime() + (0));
		var expires = "expires=" + d.toUTCString();
		cookies = cName + '=' + escape(cValue) + '; path=/ ';
		cookies += ';' + expires + ';';
		document.cookie = cookies;
	})
	
</script>

