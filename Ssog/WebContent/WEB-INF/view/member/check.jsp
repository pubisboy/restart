<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#dkssud {
	background-color: #e6e6e6;
}
</style>
<body id="dkssud">
	<div align="center">
		<div style="width: 28%;">
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-4">
					<div align="center" style="padding-top: 10px;">
						<h1 style="font-size: 5em; font-weight: bold;">SSOG</h1>
					</div>

					<div class="row"
						style="background-color: white; border: 1px solid #cccccc;">
						<div class="col-sm-3" style="border-bottom: 1px solid #cccccc;">
								<div align="left" style="font-size: 15px; padding-left: 20px; padding-top: 20px;  padding-bottom:20px; width: 100%;"> 
									<b>이용약관, 개인정보 수집 및 이용,<br />프로모션 안내<b style="padding-left: 275px;"><input type="checkbox" style="width: 15px;height: 15px;" id="allchk"/></b><br />
										메일 수신(선택)에 모두 동의 합니다
									</b>
								</div>  
						</div>
						<c:forEach var="i" items="${list }">
							<div class="col-sm-3" align="left"
								style="padding-left: 20px; padding-top: 10px; padding-right:60px; width: 89%;">          
								<b style="font-size: 15px; float: left">${i.TITLE }</b><small
								 	style="color: #2eb82e;">(필수)</small>
								<input type="checkbox" style="width: 15px;height: 15px; float: right" class="onechk"/>
								<div style="width: 428px; height: 88px; padding-top: 10px;">
									<textarea style="width: 389px; resize: none; overflow: auto; font-size: 12px; color: #737373;" 
										class="form-control" rows="5" id="comment1"
										readonly="readonly">${i.CONTENT }</textarea>
								</div>
							</div>
						</c:forEach>
						<div align="left"
							style="padding-left: 20px; padding-top: 15px; padding-bottom: 15px;">
							<b style="font-size: 15px;">이벤트 등 프로모션 알림 메일 수신</b><small
								style="color: #a6a6a6;">(선택)</small><input type="checkbox" />
						</div>
					</div>
				</div>
				<div class="col-sm-4" style="padding-top: 20px;">
					<button style="width: 49%; height: 7%; background-color: white;">비동의</button>
					<button style="width: 49%; height: 7%; background-color: #2eb82e;" id="agree">
						<b style="color: white;">동의</b>
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
$("#allchk").on("change",function(){   
	window.alert("클릭");  
	if ($("#allchk").prop("checked")) {
		$("input[type=checkbox]").prop("checked", true); 
	} else {
		$("input[type=checkbox]").prop("checked", false);
	}
});
$("#agree").on("click",function(){
	if($(".onechk").prop("checked")==false){ 
		window.alert("SSOG 이용약관과 개인정보 수집 및 이용에 대한 안내 모두 동의해주세요.");
	}else{
		location.href="/member/join.j"; 
	}
});
</script>