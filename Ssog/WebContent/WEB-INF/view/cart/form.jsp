<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.btn-custom {
	background-color: hsl(335, 100%, 64%) !important;
	background-repeat: repeat-x;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#ff4793",
		endColorstr="#ff4793");
	background-image: -khtml-gradient(linear, left top, left bottom, from(#ff4793),
		to(#ff4793));
	background-image: -moz-linear-gradient(top, #ff4793, #ff4793);
	background-image: -ms-linear-gradient(top, #ff4793, #ff4793);
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #ff4793),
		color-stop(100%, #ff4793));
	background-image: -webkit-linear-gradient(top, #ff4793, #ff4793);
	background-image: -o-linear-gradient(top, #ff4793, #ff4793);
	background-image: linear-gradient(#ff4793, #ff4793);
	border-color: #ff4793 #ff4793 hsl(335, 100%, 64%);
	color: #333 !important;
	text-shadow: 0 1px 1px rgba(255, 255, 255, 0.00);
	width: 130px;
	height: 50px;
	-webkit-font-smoothing: antialiased;
}
</style>
<div align="center">
	<div style="width: 61%; padding-top: 30px;">
		<div class="row">
			<div class="col-sm-12"
				style="border-bottom: 2px solid #bfbfbf; border-left: 1px solid #bfbfbf; border-right: 1px solid #bfbfbf;">
				<div class="row">
					<div class="col-sm-8"
						style="border-top: 2px solid black; border-right: 1px solid #b3b3b3; padding: 0px;">
						<div
							style="border-bottom: 2px dotted #b3b3b3; padding-left: 40px; padding-top: 15px; padding-bottom: 15px; text-align: left;">
							<span class="glyphicon glyphicon-shopping-cart"
								style="font-size: 45px;"></span> <b style="font-size: 26px;">장바구니</b>
							<span class="glyphicon glyphicon-chevron-right"
								style="font-size: 30px; padding-left: 35px; padding-right: 35px; color: #b3b3b3;"></span>
							<span class="glyphicon glyphicon-credit-card"
								style="font-size: 30px; color: #b3b3b3;"></span> <b
								style="font-size: 15px; color: #b3b3b3;">주문/결제</b> <span
								class="glyphicon glyphicon-chevron-right"
								style="font-size: 30px; padding-left: 35px; padding-right: 35px; color: #b3b3b3;"></span>
							<span class="glyphicon glyphicon-gift"
								style="font-size: 30px; color: #b3b3b3;"></span> <b
								style="font-size: 15px; color: #b3b3b3;">주문완료</b>
						</div>
						<div style="padding-top: 15px; height: 130px;">
							<ul style="text-align: left; font-size: 12px;">
								<li>장바구니에 담긴 상품은 <b style="color: #ff0066;">3일간</b> 저장됩니다.
									(구매한 상품은 장바구니에서 자동삭제 됩니다)
								</li>
								<li>상품수량 수정은 수정버튼을 클릭해서 수정하시면 됩니다.</li>
								<li>장바구니에 담긴 상품은 재고가 소진될 경우 [주문불가]로 표기됩니다. 구매할 수 없습니다.</li>
								<li>장바구니에 담긴 상품은 판매금액 또는 할인율은 변경될 수 있습니다.</li>
							</ul>
						</div>
					</div>
					<div class="col-sm-4"
						style="border-top: 2px solid #ff0066; padding: 0px; letter-spacing: -1px;">
						<div
							style="border-bottom: 2px dotted #b3b3b3; height: 86px; padding-top: 35px; padding-left: 28px;"
							align="left">
							<b style="font-size: 18px; color: #4d4d4d;">${memberinfo.NAME }님</b>
							반갑습니다!<br />
						</div>
						<div align="left" style="padding-top: 10px; padding-left: 28px;">
							<span class="glyphicon glyphicon-chevron-right"
								style="font-size: 5px; color: #bfbfbf; padding-bottom: 15px;"></span> <b 
								style="font-size: 12.2px; padding-right: 130px;">등급</b><b>${grade.GRADE }회원</b><br />
							<span class="glyphicon glyphicon-chevron-right"
								style="font-size: 5px; color: #bfbfbf; padding-bottom: 15px;"></span> <b
								style="font-size: 12.2px; padding-right: 110px">할인쿠폰</b><b>${clist.size() }장</b><br />
							<span class="glyphicon glyphicon-chevron-right"
								style="font-size: 5px; color: #bfbfbf;"></span> <b 
								style="font-size: 12.2px; padding-right: 120px">적립금</b>
								<b><fmt:formatNumber value="${point.POINT }" pattern="#,###"/>원</b><br />    
						</div>
					</div>
				</div>

			</div>
			<div class="col-sm-12"
				style="padding-top: 40px; padding-left: 0px; padding-right: 0px;">
				<div align="left">
					<b style="font-size: 17px;">장바구니에 담은 상품</b>
				</div>
				<table class="table table-hover" style="font-size: 12.5px;">
					<thead>
						<tr
							style="border-top: 2px solid black; background-color: #f2f2f2; height: 40px;">
							<th><input type="checkbox" id="all" /></th>
							<th></th>
							<th>상품명</th>
							<th>가격</th>
							<th>수량</th>
							<th>혜택</th>
							<th>주문금액</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="c" items="${list }">
							<tr style="border-bottom: 1px solid #b3b3b3;">
								<td><input type="checkbox" class="one"
									value="${c.PRO_NUM }" /></td>
								<td class="pd_num"><a href="/product/detail.j?productNumber=${c.PRO_NUM }">${c.PRO_NUM }</a>
								</td>
								 <td>${c.PRO_NAME }</td>
								<td>${c.PRICE }</td>
								<td>
									<button class="mi">-</button> <input type="text"
									style="width: 40px;" value="${c.number }" class="qu" />
									<button class="pl">+</button>
									<button class="revise">수정</button>
								</td>
								<td>
								<c:choose>
								<c:when test="${c.PRO_NUM ne elist.PRODUT_ID}">
								-
								</c:when>
								<c:otherwise> 
								${elist.RATE } 
								</c:otherwise>
								</c:choose> 
								</td>
								<td class="price">${c.PRICE * c.number }원</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div align="left" style="padding-bottom: 30px;">
					<button id="delete">선택상품 삭제</button>
				</div>
			</div>
			<div class="col-sm-12" style="border: 1px solid #a6a6a6">
				<div>
					<div class="row" align="left">
						<div class="col-sm-4"
							style="border-top: 2px solid black; border-right: 1px solid #a6a6a6; padding: 0px; width: 30%;">
							<div
								style="border-bottom: 1px solid #a6a6a6; background-color: #f7f7f7; height: 40px; padding-top: 10px; padding-left: 20px;">
								<b style="font-size: 13px; color: #404040;">상품합계</b>
							</div>
							<div style="height: 90px; padding-top: 10px;">
								<ul style="padding-left: 38px; font-size: 12px; color: #666666;">
									<li><b style="padding-right: 120px;">상품종류</b>${etc }종</li>
									<li><b style="padding-right: 120px;">상품수량</b><span
										id="volume"></span>개</li>
								</ul>
							</div>
						</div>
						<div class="col-sm-4"
							style="border-top: 2px solid black; border-right: 1px solid #a6a6a6; padding: 0px; letter-spacing: -1px; width: 30%;">
							<div
								style="border-bottom: 1px solid #a6a6a6; background-color: #f7f7f7; height: 40px; padding-top: 10px; padding-left: 20px;">
								<b style="font-size: 13px; color: #404040;"> 할인금액</b>
							</div>
							<div style="height: 90px; padding-top: 10px;">
								<ul style="padding-left: 38px; font-size: 12px; color: #666666;">
									<li><b>회원등급할인</b></li>
									<li><b>이벤트할인</b></li>
								</ul>
							</div>
						</div>
						<div class="col-sm-4"
							style="border-top: 2px solid #ff0066; padding: 0px; letter-spacing: -1px; width: 40%;">
							<div
								style="border-bottom: 1px solid #a6a6a6; background-color: #f7f7f7; height: 40px; padding-top: 4px; padding-left: 20px;">
								<b style="font-size: 15px;">총 구매예상금액</b> <b
									style="font-size: 20px; color: #ff0066; padding-left: 60px;"><span
									id="totalprice"></span></b>
							</div>
							<div style="padding-top: 10px;">
								<ul style="padding-left: 38px; font-size: 12px; color: #666666;">
									<li><b>상품 적립금</b><span id="expoint"
										style="padding-left: 200px;"></span></li>
								</ul>
								<b style="font-size: 12px; padding-left: 25px;">* 쿠폰 사용시
									적용금액은 변동될 수 있습니다.</b>
							</div>
						</div>
					</div>
					<div style="background-color: black;"></div>
				</div>
			</div>
		</div>
		<div align="center" style="padding-top: 30px;">
			<button class="btn btn-custom" id="order">
				<b style="color: white; font-size: 13px;">주문서 작성</b>
			</button>
			<a href="/product/list.j"><button 
					style="width: 130px; height: 50px; font-size: 13px;"
					class="btn btn-default">계속 쇼핑하기</button></a>
		</div>
	</div>
</div>

<script>
	var tot = 0;
	$('.price').each(function() {
		tot += parseInt($(this).html());
	});
	$("#totalprice").html(tot).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	var point = tot * 0.01;
	var temp = point.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	var rst = temp.substring(0, temp.indexOf('.'));
	var num_check=/^[0-9]*$/;
	if(num_check.test(point) == true) {
		$("#expoint").html(temp+'원');
	}else{
		$("#expoint").html(rst+'원');
	}  
	var cnt = 0;
	$(".qu").each(function() {
		cnt += parseInt($(this).val());
	});
	$("#volume").html(cnt); 
	
	$(".mi").on("click", function() {
		if ($(this).next().val() > 1) {
			$(this).next().val(parseInt($(this).next().val()) - 1)
		}
		var c = $(this).next().val() * $(this).parent().prev().html();
		$(this).parent().next().next().html(c);

	});

	$(".pl").on("click", function() {
		$(this).prev().val(parseInt($(this).prev().val()) + 1);
		var c = $(this).prev().val() * $(this).parent().prev().html();
		$(this).parent().next().next().html(c);
	});
	$(".revise").on("click", function() {
		var cName = $(this).parent().prev().prev().html();
		window.alert(cName);
		var cValue = "addcart" + $(this).prev().prev().val();
		var d = new Date();
		d.setTime(d.getTime() + (3 * 24 * 60 * 60 * 1000));
		var expires = "expires=" + d.toUTCString();

		cookies = cName + '=' + escape(cValue) + '; path=/ ';
		if (typeof cDay != 'undefined')
			cookies += ';' + expires + ';';
		document.cookie = cookies;
		location.reload();
	});

	$("#all").on("click", function() {
		if ($("#all").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
 	
	
	$("#delete").on("click",function(){
		$(".one").each(function() {
			if($(this).prop("checked")==true){
				var cName = $(this).val();
				window.alert(cName);
				var cValue = "new";
				window.alert(cValue);
				var d = new Date();
				d.setTime(d.getTime() + (0));
				var expires = "expires=" + d.toUTCString();
				cookies = cName + '=' + escape(cValue) + '; path=/ ';
				cookies += ';' + expires + ';';
				document.cookie = cookies;
				location.reload(); 
			}
		});
	});
	var pd1 = "";
	var pd2 = ""; 
	$("#order").on("click",function(){
		
		if(${empty list}){  
			window.alert("주문할 상품이 없습니다."); 
		}else{
			$(".pd_num").each(function() { 
				pd2 += $(this).html()+"!"; 
				
			});
			$(".qu").each(function() { 
				pd1 += $(this).val()+"!";
			});
			window.alert(pd1);  
			window.alert(pd2);
			$.ajax({
				url:"/cart/ascertain.j", 
				method:"post",
				data:{ 
					"pd1":String(pd1), 
					"pd2":String(pd2) 
				} 
			}).done(function(re){
				if(re==false){
					window.alert("상품재고확인"); 
				}else{
					location.href="/cart/order.j";	
				}
			})
		}
	});
</script>