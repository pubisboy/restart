<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<div class="row">
	<div class="col-xs-12">
		<div style="background-color: #262626; height: 43px; padding-top: 10px; padding-left: 20px;" align="left">
			<b style="font-size: 14px; color: #666666; letter-spacing: -1px;">이메일인증결제</b>
		</div>
			<table class="table">
				<tbody>
					<tr style="border-top: 2px solid black; font-size: 12px;">
						<td class="active" style="width: 16%;">상품명</td>
						<td>(상품명나오는곳)</td>
					</tr>
					<tr style="font-size: 12px;">
						<td class="active">상품금액</td>
						<td>(총상품금액나오는곳)</td>
					</tr>
				</tbody>
			</table>
	</div>
	<div class="col-xs-12"> 
		<div style="background-color: #262626; height: 43px; padding-top: 10px; padding-left: 20px;" align="left">
			<b style="font-size: 14px; color: #666666; letter-spacing: -1px;">결제하기</b>
		</div>  
		<div style="border-top: 2px solid black; padding-top: 20px;" align="center">
		<table><tr><td>
			<input type="text" id="email" style="width: 140px;"class="form-control">
			</td><td style="padding-left: 10px;padding-right: 10px;">@</td><td>
			<input type="text" id="site" style="width: 140px;"class="form-control">			
			</td><td style="padding-left: 10px;">
			<select	class="form-control" style="width: 160px;" id="mail" onChange="test(this.options[this.selectedIndex].value)"> 
				<option value="">선택해 주세요</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="nate.com">nate.com</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="직접입력">직접입력</option> 
			</select>
			</td></tr>
		</table>
		<br />
			<div align="center" style="padding-top: 5px; padding-bottom: 10px;">
				<button class="btn btn-defalut" style="width: 86%;"id="accredit">인증하기</button> 
			</div>
			<div style="padding-top: 10px;">
				<table>
				<tr><td><b style="padding-right: 10px;">인증번호</b></td><td>
				<input type="text" class="form-control" style="width: 170px;" id="key">
				</td><td style="padding-left: 10px;">
				<button class="btn btn-success" style="width: 235px;"id="confirm">인증</button>    
				</td></tr>
				</table>
				<span></span>
			</div>
			<div align="center" style="padding-top: 200px;"> 
			<button>결제</button>
			<button>취소</button>
			</div>
		</div>
	</div>
</div>
<script>
	function test(a){
		$("#site").val(a); 
			if(a=="직접입력"){
				$("#site").val("");
			}
	}
	$("#accredit").on("click",function(){
		window.alert("인증번호가 전송됬습니다.");
		$.ajax({
			url:"/cart/emailaccredit.j",
			method:"post",
			data:{
				"email":$("#email").val()+"@"+$("#site").val()
			}
		}).done(function(rere){
			if(rere==true){
				window.alert("인증되었습니다.");
			}
		})
	});
	$("#confirm").on("click",function(){
		$.ajax({
			url:"/cart/keyaccredit.j",
			method:"post",
			data:{
				"key":$("#key").val()
			}
		}).done(function(re){
			console.log(re);
			console.log(typeof re); 
			if(re==true){ 
				window.alert("결제완료");
				window.close(); 
				window.opener.submit();
			}
		})
	});
	
</script>
