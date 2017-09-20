<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
table, th, td {
	text-align: center;
	font-size: 12px;
	letter-spacing: -1px;
}

.btn-custom {
	background-color: hsl(0, 0%, 16%) !important;
	background-repeat: repeat-x; filter : progid : 
	DXImageTransform.Microsoft.gradient (  
	 startColorstr = "#5b5b5b", endColorstr = "#282828"); background-image
	: -khtml-gradient( linear, left top, left bottom, from( #5b5b5b), to(
	#282828)); background-image : -moz-linear-gradient( top, #5b5b5b,
	#282828); background-image : -ms-linear-gradient( top, #5b5b5b, #282828
	); background-image : -webkit-gradient( linear, left top, left bottom,
	color-stop( 0%, #5b5b5b), color-stop( 100%, #282828)); background-image
	: -webkit-linear-gradient( top, #5b5b5b, #282828); background-image :
	-o-linear-gradient( top, #5b5b5b, #282828); background-image :
	linear-gradient( #5b5b5b, #282828); border-color : #282828 #282828 hsl(
	0, 0%, 11%); color : #fff !important; border-radius : 0px; text-shadow
	: 0 -1px 0 rgba( 0, 0, 0, 0.33);
	-webkit-font-smoothing: antialiased;
	background-repeat: repeat-x;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#5b5b5b",
		endColorstr="#282828");
	background-image: -khtml-gradient(linear, left top, left bottom, from(#5b5b5b),
		to(#282828));
	background-image: -moz-linear-gradient(top, #5b5b5b, #282828);
	background-image: -ms-linear-gradient(top, #5b5b5b, #282828);
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5b5b),
		color-stop(100%, #282828));
	background-image: -webkit-linear-gradient(top, #5b5b5b, #282828);
	background-image: -o-linear-gradient(top, #5b5b5b, #282828);
	background-image: linear-gradient(#5b5b5b, #282828);
	border-color: #282828 #282828 hsl(0, 0%, 11%);
	color: #fff !important;
	border-radius: 0px;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.33);
	filter: progid: DXImageTransform.Microsoft.gradient(  
	startColorstr= "#5b5b5b", endColorstr= "#282828");
	background-image: -khtml-gradient(linear, left top, left bottom, from(#5b5b5b),
		to(#282828));
	background-image: -moz-linear-gradient(top, #5b5b5b, #282828);
	background-image: -ms-linear-gradient(top, #5b5b5b, #282828);
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5b5b),
		color-stop(100%, #282828));
	background-image: -webkit-linear-gradient(top, #5b5b5b, #282828);
	background-image: -o-linear-gradient(top, #5b5b5b, #282828);
	background-image: linear-gradient(#5b5b5b, #282828);
	border-color: #282828 #282828 hsl(0, 0%, 11%);
	color: #fff !important;
	border-radius: 0px;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.33);
}
</style>
<div class="row">
	<div
		style="background-color: #262626; height: 50px; padding-top: 14px;">
		<b
			style="color: #f9f9f9; font-size: 16px; padding-left: 30px; letter-spacing: -1px;">쿠폰
			조회 및 적용</b>
	</div>
	<div class="col-sm-12" style="padding: 32px;">

		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#home">사용가능한쿠폰</a></li>
			<li><a data-toggle="tab" href="#menu1">다운로드 가능한 쿠폰</a></li>
		</ul>
		<div class="tab-content">
			<div id="home" class="tab-pane fade in active">
				<div
					style="font-size: 12px; padding-top: 30px; padding-bottom: 10px; letter-spacing: -1px; color: #595959;">
					* 적용하실 쿠폰을 선택 후 '적용하기' 버튼을 클릭하시면 할인금액이 자동으로 입력됩니다.</div>
				<table class="table table-hover"
					style="border-bottom: 1px solid #f2f2f2">
					<thead>
						<tr
							style="border-bottom: 1px solid #595959; border-top: 2px solid black; background-color: #f5f5f5;">
							<th>구분</th>
							<th>쿠폰종류</th>
							<th>쿠폰선택</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="i" items="${list }">
							<tr>
								<td>${i.CUPON_LIST_ID }</td>
								<td>${i.RATE }</td>
								<td><button class="couponselect"
										style="height: 20px; font-size: 12px;">쿠폰선택</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<table class="table table-hover">
					<thead>
						<tr
							style="border-bottom: 1px solid #595959; border-top: 2px solid black; background-color: #f5f5f5;">
							<th>상품금액</th>
							<th>선택쿠폰</th>
							<th>쿠폰할인금액</th>
							<th>할인적용금액</th>
						</tr>
					</thead>
					<tbody>
						<tr style="border-bottom: 1px solid #f2f2f2;">
							<td style="border-right: 1px solid #f2f2f2;" id="prtotal"><fmt:formatNumber
									value="${price }" pattern="#,###" />원</td>
							<td style="border-right: 1px solid #f2f2f2;" id="cp"></td>
							<td style="border-right: 1px solid #f2f2f2;" id="dis"></td>
							<td id="finalcash"></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div id="menu1" class="tab-pane fade"></div>
		</div>
		<div align="center">
			<button class="btn-custom" id="okay">적용하기</button>
			<button id="cancle">취소</button>
		</div>
	</div>
</div>
<script>
var tmp = 0;
var sum = 0;
var finaltotal = 0;
	$(".couponselect").on("click",function() {
				var p = $(this).parent().prev().html();
				$("#cp").html(p + '%');
				var discount = ("${price}") * ((p * 0.01));
				var temp = discount.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
				var rst = temp.substring(0, temp.indexOf('.'));
				var num_check=/^[0-9]*$/; 
				if(num_check.test(discount) == true) {
					$("#dis").html(temp + '원'); 
				}else{
					$("#dis").html(rst + '원'); 
				}  
				
				var rst2 = '${price}'.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				if(num_check.test(discount) == true) {
					finaltotal = rst2.replace(/,/gi, '') - temp.replace(/,/gi, ''); 
				}else{
					finaltotal = rst2.replace(/,/gi, '') - rst.replace(/,/gi, ''); 
				}  
				var finaltotal1 = finaltotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				
				var finaltotal2 = (rst2.replace(/,/gi, '') - temp.replace(/,/gi, ''))*0.01; 
				
				var finaltotal3 = finaltotal2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				var temp1 = finaltotal3.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
				var rst1 = temp1.substring(0, temp1.indexOf('.'));
				tmp = rst1;  
				sum = finaltotal;
				$("#finalcash").html(finaltotal1 + '원');
			}); 
	$("#okay").on("click", function() {
		if($("#cp").html()==""){
			window.alert("쿠폰을 선택해주세요");
		}else{
		   opener.document.getElementById("finishcash").innerHTML = sum;  
		   opener.document.getElementById("point").innerHTML = tmp;
		   opener.document.getElementById("onecoupon").value = $("#cp").html();
		   opener.document.getElementById("discountrate1").innerHTML = $("#dis").html();
		   opener.basicReload();
		   window.close(); 
		}
	});
	$("#cancle").on("click", function() {
		window.close(); 
	});
</script>