<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div style="padding-top: 20px;">
	<h4 style="font-size: 17px; text-align: center;">
		<b style="padding-right: 10px;">비밀번호 변경</b>
	</h4>
</div>

<div align="center">
	<form action="/admin/admin/admin_modify.ja" method="post">
		<table>
			<tbody>
				<tr>
					<td colspan="2">
					</td>
				</tr>
				<tr>
					<td>
						<div>기존 PASS</div>
					</td>
					<td>
						<div><input type="password" name="pass" id="pass"/></div>
					</td>
				</tr>
				<tr>
					<td>
						<div>변경 PASS</div>
					</td>
					<td>
						<div><input type="password" name="newpass" id="newpass"/></div>
					</td>
				</tr>
				<tr>
					<td>
						<div>확인 PASS</div>
					</td>
					<td>
						<div><input type="password" name="newpass2" id="newpass2"/></div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<div align="center">
	<button type="button" id="submit" class="btn btn-default">변경</button>
	<button type="button" id="cancel"class="btn btn-default">취소</button>
</div>

<script>
$("#submit").on("click",function () {
	var passrule = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,20}$/;
	if($("#newpass").val()==$("#newpass2").val()){
	if($("#newpass").val().match(passrule)){
	
	$.ajax({
		url:"/admin/admin/admin_modifyExec.ja",
		method : "post",
		data : {
			"pass" : $("#pass").val(),
			"newpass" : $("#newpass").val()
		}
	}).done(function (result) {
		if(result){
			window.alert("비밀번호 변경 성공");
			location.href = "/admin/logout.ja";
		}else{
			window.alert("비밀번호 변경 실패");
			location.href = "/admin/admin/admin_modify.ja";
		}
	});
	}else{
		window.alert("영문 또는 숫자 조합(8자이상)");
	}
	}else{
		window.alert("확인 비밀번호 불일치");		
	}
});

$("#cancel").on("click",function (){
	location.href = "/admin/admin.ja";
});
</script>
