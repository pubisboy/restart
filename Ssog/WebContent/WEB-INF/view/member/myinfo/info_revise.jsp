<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
table, th, td {
	font-size: 13px;
}
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
</style>
<div style="padding-top: 20px;">
	<h4 style="font-size: 17px; text-align: left;">
		<span class="glyphicon glyphicon-info-sign"
			style="padding-right: 10px;"></span><b style="padding-right: 10px;">회원정보
			수정</b><small>회원님의 개인정보를 수정하실 수 있습니다.</small>
	</h4>
</div>
<hr style="border-top: 3px solid black;" />
<b>웹 회원 필수정보</b>
<div class="row" style="padding-top: 10px;">
	<div class="col-sm-12">
		<table class="table">
			<tbody>
				<tr>
					<td class="active" style="width: 16%;">회원 아이디</td>
					<td>${memberinfo.ID }</td>
				</tr>
				<tr>
					<td class="active">이름</td>
					<td>${memberinfo.NAME }</td>
				</tr>
				<tr>
					<td class="active">생년월일</td>
					<td>${memberinfo.BIRTH }</td>
				</tr>
				<tr>
					<td class="active">성별</td>
					<td>${memberinfo.GENDER }</td>
				</tr>
				<tr>
					<td class="active">휴대전화</td>
					<td><select name="phone1" id="phone1"
						style="width: 60px; height: 25px;">
							<c:forTokens var="i" items="010,011,016,017,018,019" delims=",">
							<option value="${i }"${i eq  memberinfo.phone1 ? 'selected' : ''} >${i }</option>
							</c:forTokens>
					</select>
					 - <input type="text" style="width: 60px; height: 25px;" value="${memberinfo.phone2 }" id="phone2"/> - <input
						type="text" style="width: 60px; height: 25px;" value="${memberinfo.phone3 }"id="phone3" /><br />
						<input type="checkbox" id="sms" ${memberinfo.ck_sms eq 'on' ? 'checked' : '' }/>
						 <small	style="font-size: 11px; padding-bottom: 5px;">수신동의하고 특별한
							쇼핑정보, 엄청난 혜택 알림을 문자로 받아보세요.</small></td>
				</tr>
				<tr>
					<td class="active">이메일</td>
					<td><input type="text" style="width: 160px; height: 25px;"
						value="${memberinfo.email1 }"id="email" /> @ <input type="text"
						style="width: 160px; height: 25px;" value="${memberinfo.email2 }" id="site"/> <select
						style="width: 160px; height: 25px;" id="mail" onChange="test(this.options[this.selectedIndex].value)">
							<option value="">선택해 주세요</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="nate.com">nate.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="직접입력">직접입력</option> 
					</select><br />
					<input type="checkbox" id="emailck" ${memberinfo.ck_email eq 'on' ? 'checked' : '' }/>
					<small style="font-size: 11px; padding-bottom: 5px;">수신동의하고 특별한 쇼핑정보, 엄청난 혜택 알림을 이메일로 받아보세요.</small>
							<br><input type="checkbox" id="refresh" ${memberinfo.ck_refresh eq 'on' ? 'checked' : '' }/> 
							<small style="font-size: 11px; padding-bottom: 5px;">재입고 알림 신청서비스를 받습니다.</small></td> 
				</tr>
				<tr>
					<td class="active">주소입력</td>
					<td style="padding-left: 0px;"> 
						<div class="navbar-form" style="padding-left: 8px;">
							<input type="text" name="postcode" id="postcode"
								value="${memberinfo.postcode}" style="width: 140px;"> <input
								type="button" onclick="sample6_execDaumPostcode()"
								value="우편번호 찾기" style="width: 100px; font-size: 13px;"><br />
						</div>
						<div class="navbar-form" style="padding-left: 8px;">
							<input type="text" name="address1" id="address1" value="${memberinfo.address1 }" style="width: 240px;">
							<input type="text" name="address2" id="address2" value="${memberinfo.address2 }" style="width: 240px;"> <br />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div align="center">
			<button type="submit"  class="btn btn-custom" style="font-size: 12px;" id="user_revise">정보 수정하기</button>
		</div>
	</div>
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = ''; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수

						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							fullAddr = data.roadAddress;

						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							fullAddr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('address1').value = fullAddr;

						// 커서를 상세주소 필드로 이동한다.
						document.getElementById('address2').focus();
					}
				}).open();
	}
	function test(a){
		 $("#site").val(a); 
		 if(a=="직접입력"){
			 $("#site").val("");
		 }
		}
	var phonerule = /(\d{3}).*(\d{4}).*(\d{4})/;
	
	$("#user_revise").on("click",function(){
		var phonerule = /(\d{3}).*(\d{4}).*(\d{4})/;
		$.ajax({
			url:"/member/myinfo/info_revise_rst.j",
			method : "post",
			data:{
				"phone":($("#phone1").val()+"-"+$("#phone2").val()+"-"+$("#phone3").val()),
				"email":($("#email").val()+'@'+$("#site").val()),
				"address":$("#postcode").val()+'!'+$("#address1").val()+'!'+$("#address2").val(),
				"sms":($("#sms").prop("checked") ? 'on':'off'),
				"refresh":($("#refresh").prop("checked") ? 'on':'off'),
				"emailck":($("#emailck").prop("checked")? 'on':'off')
			}
		}).done(function (rere) {
			if(rere==true){
				window.alert("수정완료");
				location.href = "/member/myinfo/info_revise.j";
			}
		})
		
	});
</script>

<!-- 
핸드폰번호 정규식
/(\d{3}).*(\d{3}).*(\d{4})/

 -->