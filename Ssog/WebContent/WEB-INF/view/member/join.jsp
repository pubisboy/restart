<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div align="center" class="row">
	<div class="col-xs-0 col-md-3"></div>
	<div class="col-xs-12 col-md-6">
		<h3 style="margin: 0">회원가입</h3>

		<form action="/member/join_rst.j">
			<div class="form-group">
				<br /> <input class="form-control" type="text" placeholder="이름"
					name="name" id="name" required style="width: 90%;" /><br />
				<div class="navbar-form navbar">
					<input class="form-control" type="text"
						placeholder="생년월일(yyyymmdd)" name="birth" id="birth" required
						style="width: 72%;"><span style="padding-right: 20px;"
						class="glyphicon glyphicon-question-sign" data-toggle="tooltip"
						title="생년월일 정보는 신원을 확인하거나 특정 Ssog서비스를 활성화하는데 사용됩니다."></span> <input
						type="radio" name="gender" value="M"
						style="width: 13px; height: 13px; padding-right: 20px;" required="required"><b
						style="padding-right: 8%;">남</b><input type="radio" name="gender" 
						value="W" style="width: 13px; height: 13px; padding-right: 20px;" required="required"><b>여</b>
					<br />
					<hr />
				</div>
				<input class="form-control" type="text" placeholder="아이디" name="id"
					id="id" required style="width: 90%;" />
				<p id="id_chk"></p>
			</div>
			<div class="form-group">
				<input class="form-control" type="password" placeholder="●●●●●"
					name="pass" id="pass" required style="width: 90%;" /><br />
				<hr />
				<div class="navbar-form navbar">
					<input class="form-control" type="text" name="postcode"
						id="postcode" placeholder="우편번호" style="width: 60%;" required="required"> <input
						class="form-control" type="button"
						onclick="sample6_execDaumPostcode()" value="우편번호 찾기"
						style="width: 32%;"><br />
				</div>
				<input class="form-control" type="text" name="address1"
					id="address1" placeholder="주소" style="width: 90%;"required="required"> <input
					class="form-control" type="text" name="address2" id="address2"
					placeholder="상세주소" style="width: 90%;"required="required"> <br />
				<hr />
				<input class="form-control" type="text"
					placeholder="휴대폰번호(-제외, 11자리)" name="phone" id="phone" required
					style="width: 90%;" required="required"/>
				<div align="left" style="padding-left: 41px;">
					<input type="checkbox" name="sms" /><small style="font-size: 11px;">수신동의하고
						특별한 쇼핑정보, 엄청난 혜택 알림을 문자로 받아보세요.</small>
				</div>
			</div>
			<div class="form-group">

				<div class="navbar-form navbar" style="padding-left: 10px;">
					<input style="width: 60%;" class="form-control" type="email"
						placeholder="이메일" name="email" id="email" required
						style="width: 90%;" required="required"/>
					<button class="btn btn-info" type="button" name="emailaccredit"
						id="emailaccredit" style="width: 32%;">인증하기</button>
					<p id="email_chk"></p>
				</div>
				<div class="navbar-form navbar" style="padding-left: 0px;">
					<input class="form-control" style="display: none; width: 60%;"
						type="text" name="contxt" id="contxt" />
					<button class="btn btn-info" style="display: none; width: 32%;"
						type="button" name="confirm" id="confirm">확인</button>
					<div align="left" style="padding-left: 41px;">
						<input type="checkbox" name="emailck" /><small
							style="font-size: 11px;">수신동의하고 특별한 쇼핑정보, 엄청난 혜택 알림을 이메일로
							받아보세요.</small>
					</div>
				</div>
				<div align="left" style="padding-left: 40px;">
					<input type="checkbox" style="width: 15px; height: 15px;"
						name="refresh" /><small style="font-size: 11px;">재입고 알림
						신청서비스를 받습니다. </small>
					<hr />
				</div>
			</div>

			<div class="row">
				<button type="submit" class="btn btn-info" style="width: 40%">가입하기</button>
				<button type="reset" class="btn btn-default" style="width: 40%">초기화</button>
			</div>
		</form>

	</div>
	<div class="col-xs-0 col-md-3"></div>

</div>
<script>
	var joinChk = function() {
		if (this.value.trim().length > 0) {
			var id = this.id;
			var value = this.value;
			var req = new XMLHttpRequest();
			req.onreadystatechange = function() {
				if (this.readyState == 4) {
					var ihtml;
					var rText = this.responseText;
					if (rText.trim() == "false") {
						ihtml = "<b style='color:green;'>훌륭합니다!</b>";
						//document.getElementById("sbt").disabled=false;
					} else {
						ihtml = "<b style='color:red;'>이미 사용중 입니다.</b>";
						//document.getElementById("sbt").disabled=true;
					}
					document.getElementById(id + "_chk").innerHTML = ihtml;
				}
			}
			req.open("get", "/member/joinajax.j?type=" + this.id + "&val="
					+ this.value, true);
			req.send();
		}
	}
	document.getElementById("id").onblur = joinChk;
	document.getElementById("email").onblur = joinChk;

	document.getElementById("emailaccredit").onclick = function() {

		var email = document.getElementById("email").value;
		//window.alert(email);

		var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;

		if (email.match(regExp)) {
			var req = new XMLHttpRequest();
			req.open("get", "/member/emailaccredit.j?email=" + email, true);
			req.send();
			document.getElementById("contxt").style.display = "";
			document.getElementById("confirm").style.display = "";
			req.onreadystatechange = function() {
				if (this.readyState == 4) {
					if (this.responseText == "true") {

					} else {
						document.getElementById("contxt").style.display = "none";
					}
				}
			}
		} else {
			window.alert("이메일 형식이 아닙니다.");
		}
	}
	document.getElementById("confirm").onclick = function() {
		var contxt = document.getElementById("contxt").value;
		var req = new XMLHttpRequest();
		req.open("get", "/member/result.j?contxt=" + contxt, true);
		req.send();
		req.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.responseText == "true") {
					window.alert("성공");
				} else {
					window.alert("실패");
				}
			}
		}
	}
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
	});
</script>


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
</script>