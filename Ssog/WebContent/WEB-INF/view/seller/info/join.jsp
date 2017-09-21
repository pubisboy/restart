<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.wrap {
		width:100%; margin-left:10%;
	}
	
	.txt {
		 border-radius:3px;
		 vertical-align: bottom;
		 margin:0 3px;
	}
	
	input[type=text], select{
	    box-sizing: border-box;
	    font-size: 14px;
	    padding: 2px 2px;
	    border-radius:3px;
	    -webkit-transition: width 0.4s ease-in-out;
	    transition: width 0.4s ease-in-out;
	}
</style>
<div class="wrap">
		<h3 style="margin: 0">회원가입</h3>
		<br>
		<form action="/seller/alert/join_rst.j" method="post" style="width:100%">
			<div class="form-group">
				<input class="form-control" type="text" placeholder="아이디" name="id"
					id="id" required/>
				<p id="id_chk"></p>
				<input class="form-control" type="password" placeholder="●●●●●"
					name="pass" id="pass" required/><br/>
			</div>
			<div class="form-group">
				<input class="form-control" type="text" placeholder="이름" name="name"
					id="name" required/><br/>
					<hr/>
					<input class="form-control" type="text" placeholder="휴대폰번호(-제외)" name="phone"
					id="phone" required/><br/>
					<input class="form-control" type="text" placeholder="브랜드명" name="brand"
					id="brand" required/><br/>
					
					<table> 
						<tr><td>
							<select name="bank" style="width:60px;" class="txt">
								<option value="국민">국민</option>
								<option value="NH농협">NH농협</option>
								<option value="신한">신한</option>
								<option value="우리">우리</option>
								<option value="기업">기업</option>
							</select>
						</td>
						<td>
							<input type="text" placeholder="계좌번호(-제외)" name="account" id="account" style="width: 100%;" class="form-control txt" required />
							<p id="account_chk"></p>
						</td></tr>
					</table>
			</div>
			<div class="form-group">
				<button style="display: none" type="button" name="confirm"
					id="confirm">확인</button><hr/>
			</div>
				
			<div class="row">
				<button type="submit" class="btn btn-info" style="width: 40%" id="sbt" disabled>가입하기</button>
				<button type="reset" class="btn btn-default" style="width: 40%">초기화</button>
			</div>
		</form>
</div>
<script>
	var joinChk = function() {
		var id = this.id;
		var value = this.value;
		if (this.value.trim().length > 0) {
			var req = new XMLHttpRequest();
			req.onreadystatechange = function() {
				if (this.readyState == 4) {
					var ihtml;
					var rText = this.responseText;
					var result = JSON.parse(rText);
					if (result.join_check) {
						ihtml = "<b style='color:green;'>사용가능</b>";
						document.getElementById("sbt").disabled=false;
					} else {
						if(id=="id"){
							ihtml = "<b style='color:red;'>이미 있는 아이디 입니다.</b>";
						}
						if(id=="account"){
							ihtml = "<b style='color:red;'>이미 있는 계좌번호 입니다.</b>";	
						}
						document.getElementById("sbt").disabled=true;
					}
					document.getElementById(id + "_chk").innerHTML = ihtml;
				}
			}
			req.open("get", "/seller/info/joinAjax.j?type=" + this.id + "&val=" + this.value, true);
			req.send();
		} else {
			document.getElementById("sbt").disabled=true;
			document.getElementById(id + "_chk").innerHTML = "";
		}
	}
	
	document.getElementById("id").onblur = joinChk;
	document.getElementById("account").onblur = joinChk;
</script>