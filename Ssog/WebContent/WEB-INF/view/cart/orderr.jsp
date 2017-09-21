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
	<div style="width: 51.5%; padding-top: 30px;">
		<form action="/cart/payment.j" id="confirm"> 
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
								style="font-size: 45px;"></span> <b style="font-size: 26px;">주문/결제</b>
							<span class="glyphicon glyphicon-chevron-right"
								style="font-size: 30px; padding-left: 35px; padding-right: 35px; color: #b3b3b3;"></span>
							<span class="glyphicon glyphicon-gift"
								style="font-size: 30px; color: #b3b3b3;"></span> <b
								style="font-size: 15px; color: #b3b3b3;">주문완료</b>
						</div>
					</div>
					<div class="col-sm-4" style="border-top: 2px solid #ff0066;">
						<div style="height: 86px; padding-top: 35px; padding-left: 28px;"
							align="left">
							<b style="font-size: 18px; color: #4d4d4d;">${memberinfo.NAME }님</b>
							반갑습니다!<br />
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-12"
				style="padding-top: 40px; padding-left: 0px; padding-right: 0px; padding-bottom: 20px;">
				<div align="left">
					<b style="font-size: 17px;">주문상품</b>
				</div>
				<table class="table table-hover">
					<thead>
						<tr
							style="border-top: 2px solid black; background-color: #f2f2f2; height: 40px; font-size: 12.5px;">
							<th></th>
							<th>상품명</th>
							<th>가격</th>
							<th>수량</th>
							<th>할인금액</th>
							<th>구매예정금액</th>
						</tr>
					</thead>
					<tbody>
							<tr style="border-bottom: 1px solid #b3b3b3; font-size: 12.5px;">
								<td>${plist.IMG_UUID }</td> 
								<td>${plist.PRO_NAME }</td>
								<input type="hidden" value="${param.quantity2 }" name="pd1"> 
								<input type="hidden" value="${plist.PRO_NUM}" name="pd2">
								<td>${plist.PRICE }</td>
								<td>${param.quantity2 }</td>   
								<td>
								<c:choose>
								<c:when test="${param.discount ne NaN}"> 
								- 
								</c:when>
								<c:otherwise>
								${(plist.PRICE *param.quantity2)-(param.discount*param.quantity2)}
								</c:otherwise>
								</c:choose>
								</td> 
								<td>
								<c:choose>
								<c:when test="${param.discount ne NaN}">
								${plist.PRICE *param.quantity2}
								<td style="display: none;"id="price" >${plist.PRICE *param.quantity2}</td> 
								</c:when>
								<c:otherwise>
								${param.discount *param.quantity2}
								<td style="display: none;"id="price" >${plist.PRICE *param.quantity2}</td>
								</c:otherwise>
								</c:choose>
								</td> 
								<td style="display: none;"class="price" ></td>
							</tr>
					</tbody>
				</table>
			</div>
			<div class="col-sm-12" style="padding: 0px;">
				<div align="left">
					<b style="font-size: 17px;">고객정보</b>
				</div>
				<table class="table">
					<tbody>
						<tr style="border-top: 2px solid black; font-size: 12px;">
							<td class="active" style="width: 16%;">수령인</td>
							<td><input type="text" id="name" name="receiver"/><input type="checkbox"
								id="equal" />주문자와 동일</td>
						</tr>
						<tr style="font-size: 12px;">
							<td class="active">휴대전화</td>
							<td><select name="phone1" id="phone1"
								style="width: 60px; height: 25px;">
									<c:forTokens var="i" items="010,011,016,017,018,019" delims=",">
										<option value="${i }" ${i eq  phone1 ? 'selected' : ''}>${i }</option>
									</c:forTokens>
							</select> - <input type="text" style="width: 60px; height: 25px;"
								value="${memberinfo.phone2 }" id="phone2" name="phone2"/> - <input
								type="text" style="width: 60px; height: 25px;"
								value="${memberinfo.phone3 }" id="phone3" name="phone3"/><br /></td>
						</tr>
						<tr style="font-size: 12px;">
							<td class="active">주소입력</td>
							<td style="padding-left: 0px;">
								<div class="navbar-form" style="padding-left: 8px;">
									<input type="text" name="postcode" id="postcode"
										style="width: 140px;"> <input type="button"
										onclick="sample6_execDaumPostcode()" value="우편번호 찾기"
										style="width: 100px; font-size: 13px;"><br />
								</div>
								<div class="navbar-form" style="padding-left: 8px;">
									<input type="text" name="address1" id="address1"
										style="width: 240px;"> <input type="text"
										name="address2" id="address2" style="width: 240px;"> <br />
								</div>
							</td>
						</tr>
						<tr style="font-size: 12px;">
							<td class="active" style="width: 16%;">배송시<br />요구사항
							</td>
							<td><textarea style="width: 484px; height: 66px;" id="etc" name="etc"></textarea></td> 
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-sm-12" style="padding: 0px; padding-top: 20px;">
				<div align="left">
					<b style="font-size: 17px;">할인 정보</b>
				</div>
				<div class="row"
					style="border: 1px solid #d9d9d9; border-top: 2px solid black; font-size: 12px; width: 100%;">
					<div class="col-xs-2" style="padding: 0px;">
						<div
							style="background-color: #f1f1f1; height: 43px; padding-top: 10px; padding-left: 20px;"
							align="left">
							<b style="font-size: 14px; color: #666666; letter-spacing: -1px;">상품 합계금액</b>
						</div>
						<div>
							<b style="font-size: 17px; color: #737373;"><span id="amount"></span></b> 
						</div>
					</div>
					<div class="col-xs-8"
						style="padding: 0px; border-right: 1px solid #d9d9d9; border-left: 1px solid #d9d9d9;">
						<div style="background-color: #f1f1f1; height: 43px; padding-top: 10px; padding-left: 20px;" align="left">
							<b style="font-size: 14px; color: #666666; letter-spacing: -1px;">할인 / 적립금 사용 금액</b>
						</div>
						<div style="background-color: #e6e6e6; padding-left: 45px; height: 30px; font-size: 12.5px; padding-top: 7px;"align="left">
							<b style="color: #404040;">할인 금액</b>
							<b style="color: black; padding-left: 430px;"><span id="discountrate1">0원</span></b> 
						</div>
						<div
							style="padding: 10px; border-bottom: 1px solid #d9d9d9; width: 90%; font-size: 11.5px;"
							align="left">
							<b style="color: #737373; padding-right: 60px;">기본할인</b> 이벤트 할인(0)원0원
						</div>
						<div style="padding: 10px; padding-bottom:0px; width: 90%; font-size: 11.5px" align="left">
							<b style="color: #737373; padding-right: 60px;">쿠폰할인</b> <input type="text" 
								id="onecoupon" name="onecoupon"><a href="javascript:popupOpen();"
								style="color: #262626">
								<button type="button" id="couponlist">쿠폰조회 및 적용</button>
							</a> 사용가능한 쿠폰 <b style="color: #ff1a75;">${clist.size() }</b>장 <span id="discount"></span>
								<div style="padding-left: 85px; padding-top: 8px; color: #999999;"> 
								<ul> 
								<li>30%이상 할인된 상품 및 일부 브랜드는 쿠폰적용 기준금액에서 제외됩니다.</li>
								</ul>
								</div>
						</div>
						<div
							style="background-color: #e6e6e6; padding-left: 45px; height: 30px; color: #ff1a75; font-size: 12.5px; padding-top: 7px;"
							align="left">
							<b style="color: #404040; padding-right: 60px; ">적립금 사용 금액</b><small	style="font-size: 12px;">사용가능 적립금${point.POINT}원</small>
							<b style="color: black; padding-left: 200px;"><span id="discountrate2"></span>원</b>
						</div>
						<div align="left" style="width: 90%; padding: 10px;  padding-bottom:0px; border-bottom: 1px solid #d9d9d9; font-size: 11.5px">
							<b style="color: #737373; padding-right: 45px;">상품 적립금</b> 
							<input type="radio"	name="chk_point" value="save" />적립
							<input type="radio"	name="chk_point" value="use" />즉시사용(상품 적립금<span id="point"></span>원)
							<input type="hidden" id="hdpoint" name="hdpoint"/>
								<div style="padding-left: 85px; padding-top: 8px; color: #999999;">  
								<ul>
								<li>일부 브랜드 상품은 구매 시 적립금 즉시 사용 또는 적립이 제한 될 수 있습니다.</li>
								</ul>
								</div>
						</div>
						<div align="left" style="width: 90%; padding: 10px; padding-bottom:0px; font-size: 11.5px">
							<b style="color: #737373; padding-right: 45px;">보유 적립금</b>
							<input type="text" id="consume" value="" name="consume"/>원
							<input type="checkbox" id="application">전액사용(보유적립금<span id="conpoint"></span>원)
							<div style="padding-left: 85px; padding-top: 8px; color: #999999;">   
							<ul>
								<li>각 브랜드 또는 상품 별로 적립금 최대 사용율이 다를 수 있습니다.</li>
								<li>보유 적립금 최대 사용율은 각 상품 상세 페이지에서 확인 하실 수 있습니다.</li>
								<li>일부 브랜드 상품은 적립금 사용이 제한됩니다.</li>
							</ul>
							</div>
						</div>
						<div></div>
					</div>
					<div class="col-xs-2" style="padding: 0px;">
						<div
							style="background-color: #f1f1f1; height: 43px; padding-top: 10px; padding-left: 20px;"
							align="left">
							<b style="font-size: 14px; color: #666666; letter-spacing: -1px;">최종
								결제금액</b>
						</div>
						<div>
						
							<b style="font-size: 20px;"><span id="finishcash"></span>원</b>
							<input type="hidden" id="totalcash" name="totalcash">
						</div>
					</div>
				</div>

			</div>
			<div class="col-sm-12" style="padding: 0px; padding-top: 40px;">
				<div align="left">
					<b style="font-size: 17px;">결제 정보</b>
				</div>
				<div class="row"
					style="border-bottom: 2px solid gray; border-top: 2px solid black; font-size: 12px; width: 100%;">
					<div class="col-xs-2"
						style="background-color: #f2f2f2; height: 80px; padding-top: 10px; padding-left: 20px;"
						align="left">
						<b style="color: #666666;">결제수단 선택</b>
					</div>
					<div class="col-xs-10" align="left" style="padding-top: 15px;">
						<button type="button" class="btn btn-default" style="width: 145px; height: 45px;" id="passbook" name="passbook">무통장입금</button> 
						<button type="button" class="btn btn-default"	style="width: 145px; height: 45px;" id="emailkey" name="emailkey">이메일인증</button>
							<input type="hidden" id="valu" value="none" name = valu> 
					</div>
				</div>
			</div>
			<div class="col-sm-12" style="padding: 0px; padding-top: 40px;"> 
				<div align="left">
					<b style="font-size: 17px;">기타 정보</b>
				</div>
				<div class="row" style="border: 1px solid #d9d9d9; border-top: 2px solid black; width: 100%; font-size: 12px;"> 
					<div class="col-xs-2" style="width: 20%; border-right: 1px solid #d9d9d9; border-bottom: 1px solid #d9d9d9; min-height: 30%">구매 시 유의사항</div> 
					<div class="col-xs-10" style="width: 80%; border-bottom: 1px solid #d9d9d9; min-height: 30%">구매유의사항들어갈곳</div>
					<div class="col-xs-2" style="width: 20%; border-right: 1px solid #d9d9d9; min-height: 4%">주문동의</div> 
					<div class="col-xs-10" style="width: 80%; min-height: 4%">  
					<b style="padding-right: 60px;">주문하실 상품의 상품명, 상품가격, 내용 및 종류를 확인하였으며, 구매에 동의하시겠습니까?</b> 
					<input type="checkbox" id="agree"> 동의합니다.
					</div>
				</div>
			</div>
		</div>
			<div align="center" style="padding-top: 30px;"> 
				<button id="order" class="btn btn-custom" type="button"> 
				<b style="color: white; font-size: 13px;">결제하기</b></button> 
				<button style="width: 130px;height: 50px; font-size: 13px;" class="btn btn-default">주문취소</button> 
			</div>
			</form>
	</div>
</div>
<script>
	var tot1 = parseInt(parseInt($("#price").html())+parseInt(2500));   
	$("#amount ").html(tot1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원'); 
	$("#finishcash").html(tot1); 
	var conpoint = "${point.POINT}";
	$("#conpoint").html(conpoint);
	var discountrate = 0; 
	$("#discountrate2").html(discountrate);
	var pt = ($("#finishcash").html() * 0.01);
	var temp = pt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	var rst = temp.substring(0, temp.indexOf('.'));
	var num_check=/^[0-9]*$/;
	if(num_check.test(pt) == true) {
		$("#point").html(temp);
		$("#hdpoint").val(temp);
	}else{
		$("#point").html(rst);
		$("#hdpoint").val(rst);  
	}  
	var basic = $("#finishcash").html();
	$("#equal").on("change", function() {
		if ($("#equal").prop("checked")) {
			$("#name").val("${memberinfo.NAME}");
			$("#postcode").val("${postcode}");
			$("#address1").val("${address1}");
			$("#address2").val("${address2}");
			$("#phone2").val("${phone2}");
			$("#phone3").val("${phone3}");
		} else {
			$("#name").val("");
			$("#postcode").val("");
			$("#address1").val("");
			$("#address2").val("");
			$("#phone2").val("");
			$("#phone3").val("");
		}

	});
	
	function popupOpen() {
		$(":input:radio[name=chk_point]").filter('[value=save]').prop(
				'checked', false);
		$(":input:radio[name=chk_point]").filter('[value=use]').prop('checked',
				false);
		var popUrl = "popup_couponlist.j";
		var popOption = "width=500, height=660, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl + "?price=" + tot1, "SSOG", popOption);
	} 

	$(":input:radio[name=chk_point]").on("change", function() {
		var st = $(":input:radio[name=chk_point]:checked").val();
		if (st == "use") {
			var pt = $("#point").html(); 
			var pt2 = pt.replace(/,/gi, '');
			//$("#hdpoint").val(pt2);
			var finicash = $("#finishcash").html();
			window.alert(finicash); 
			window.alert(basic);
			var finalcash = basic - pt2;
			$("#finishcash").html(finalcash);
			basic = finalcash;
		} else {
			$("#finishcash").html(basic);
		}
	});
	$("#application").on("change", function() {
		if ($("#application").prop("checked")) {
			$("#consume").val("${point.POINT }");
			var finicash = $("#finishcash").html();
			var cashsum = finicash - "${point.POINT }"
			$("#finishcash").html(cashsum);
		} else {
			$("#consume").val("");
			var finicash = $("#finishcash").html();
			var cashsum = parseInt(finicash) + parseInt("${point.POINT }");
			$("#finishcash").html(cashsum);
		}
	});
		
		var basicReload = function(){
			basic = $("#finishcash").html();
			}
	$("#consume").on("change", function() { 
		var thissum = $(this).val();
		if (parseInt(thissum) > parseInt("${point.POINT }")) {
			window.alert("적립금사용금액은 보유적립금보다 클 수 없습니다.");
		//}else if(parseInt(thissum)<parseInt($("#finishcash").html())){   
			//window.alert("적립금을 총결제금액보다 많이 사용할수 없습니다.");  	
		}else { 
			window.alert(basic);
			var mifinicash = basic - thissum; 
			var current = conpoint - thissum; 
			$("#finishcash").html(mifinicash);
			$("#conpoint").html(current); 
		}

	});
	
	$("#passbook").on("click",function(){ 
		$("#valu").val("passbook");
	});
	$("#emailkey").on("click",function(){
		$("#valu").val("emailkey");
	});
	
	$("#order").on("click",function(){
		if($("#agree").prop("checked") && $("#valu").val()!='none'){
			if($("#valu").val()=='emailkey'){
				var popUrl = "popup_pay.j"; 
				var popOption = "width=570, height=660, resizable=no, scrollbars=no, status=no;";
				window.open(popUrl + "?price=" + 'rr', "SSOG", popOption);
				$("#totalcash").val($("#finishcash").html()); 
			}
		}else{
			if(!$("#agree").prop("checked")){
				window.alert("주문동의체크확인");
			}else if($("#valu").val()=='none'){
				window.alert("결제방식을 선택해주세요."); 
			}
		}
	});
	
	var submit = function(){
		$("#confirm ").submit();
	}
</script>