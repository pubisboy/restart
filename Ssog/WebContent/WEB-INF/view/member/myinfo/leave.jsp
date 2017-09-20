<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.btn-custom {
	background-color: hsl(0, 0%, 16%) !important;
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
	-webkit-font-smoothing: antialiased;
}

.btn-custom2 {
	background-color: hsl(0, 0%, 95%) !important;
	background-repeat: repeat-x;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#10b10b10b",
		endColorstr="#f2f2f2");
	background-image: -khtml-gradient(linear, left top, left bottom, from(#10b10b10b),
		to(#f2f2f2));
	background-image: -moz-linear-gradient(top, #10b10b10b, #f2f2f2);
	background-image: -ms-linear-gradient(top, #10b10b10b, #f2f2f2);
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%,
		#10b10b10b), color-stop(100%, #f2f2f2));
	background-image: -webkit-linear-gradient(top, #10b10b10b, #f2f2f2);
	background-image: -o-linear-gradient(top, #10b10b10b, #f2f2f2);
	background-image: linear-gradient(#10b10b10b, #f2f2f2);
	border-color: #f2f2f2 #f2f2f2 hsl(0, 0%, 92.5%);
	color: #333 !important;
	border-radius: 0px;
	text-shadow: 0 1px 1px rgba(255, 255, 255, 0.16);
	-webkit-font-smoothing: antialiased;
}
</style>

<div>
	<h4 style="font-size: 17px; text-align: left; padding-top: 20px;">
		<span class="glyphicon glyphicon-info-sign"
			style="padding-right: 10px;"></span><b style="padding-right: 10px;">회원탈퇴</b><small>SSOG인터넷쇼핑몰
			회원탈퇴를 요청합니다</small>
	</h4>
</div>
<hr style="margin-top: 0px;" />

<div class="row">
	<div class="col-sm-12" style="margin-bottom: 30px;">
		<b>회원 탈퇴 안내</b>
		<textarea rows="10px;" cols="100%;"></textarea>
	</div>
	<div class="col-sm-12" style="margin-bottom: 30px;">
		<b style="color: #ff4d4d; font-size: 18px;">※ 주의사항!!</b>
		<hr style="margin-top: 0px;" />
		<li>회원탈퇴가 처리되면 지금까지 축적된 구매실적 및 혜택이 모두 삭제되어 더 이상 회원 혜택을 받으실 수
			없습니다.</li>
	</div>
	<div class="col-sm-12">
		<b>회원 탈퇴 사유</b><small>회원님께서 주신 내용으로 저희 쏙쇼핑몰은 더욱 크게 발전 하겠습니다.</small>
		<hr style="margin-top: 0px;" />
		<select name="reason" id="reason" style="width: 150px;">
			<option value="">선택해 주세요</option>
			<c:forEach var="i" items="${reason }">
				<option value="${i.NUM }">${i.REASON }</option>
			</c:forEach>
			<option value="기타">기타</option>
		</select>
		<div>
			<textarea rows="10px" cols="100%" id="etc_reason"
				style="display: none;"></textarea>
		</div>
	</div>
	<div class="col-sm-12">
		<div align="center" style="padding-top: 15px;">
			<button class="btn btn-custom" id="leave_rst">회원탈퇴 요청</button>
			<button class="btn btn-custom2">취소</button>
		</div>
	</div>
</div>
<script>
	$("#reason").on("click", function() {
		if ($("#reason").val() == "기타") {
			$("#etc_reason").show()
		} else {
			$("#etc_reason").hide()
		}
	});

	$("#leave_rst").on("click", function() {
		window.alert($("#reason").val());
		window.alert($("#etc_reason").val("r"));
		$.ajax({
			"url" : "/member/myinfo/leave_rst.j",
			"method" : "post",
			"data" : {
				"reason" : $("#reason").val(),
				"detail" : $("#etc_reason").val()
			}
		}).done(function(re) {
			if (re == true) {
				window.alert("회원탈퇴완료");
				location.href = "/";
			} else {
				window.alert("실패");
			}
		})
	});
</script>
