<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div style="padding-top: 20px;">
	<h4 style="font-size: 17px; text-align: center;">
		<b style="padding-right: 10px;">관리자 생성</b>
	</h4>
</div>

<div align="center">
	<form action="/admin/admin/admin_create.ja" method="post">
		<table>
			<tbody>
				<tr>
					<td colspan="2">
					</td>
				</tr>
				<tr>
					<td>
						<div>ID</div>
					</td>
					<td>
						<div><input type="text" name="id" id="id"/></div>
					</td>
				</tr>
				<tr>
					<td>
						<div>PASS</div>
					</td>
					<td>
						<div><input type="password" name="pass" id="pass"/></div>
					</td>
				</tr>
				<tr>
					<td>
						<div>소유자</div>
					</td>
					<td>
						<div><input type="text" name="owner" id="owner"/></div>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<div align="center">
	<button type="button" id="submit" class="btn btn-default">생성</button>
	<button type="button" id="cancel"class="btn btn-default">취소</button>
</div>

<script>
$("#submit").on("click",function () {
	var passrule = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,20}$/;
	if($("#pass").val().match(passrule)){
		$.ajax({
			url:"/admin/admin/admin_createExec.ja",
			method : "post",
			data : {
				"id" : $("#id").val(),
				"pass" : $("#pass").val(),
				"owner" : $("#owner").val()
			}
		}).done(function (result) {
			if(result){
				window.alert("관리자 계정 생성 성공");
				location.href = "/admin/admin.ja";
			}else{
				window.alert("관리자 계정 생성 실패");
				location.href = "/admin/admin/admin_create.ja";
			}
		});
	}else{
		window.alert("영문 또는 숫자 조합(8자이상)");
	}
});

$("#cancel").on("click",function (){
	location.href = "/admin/admin.ja";
});
</script>
