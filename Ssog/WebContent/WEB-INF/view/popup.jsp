<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.image {
	background-image: url(/admin/popupImg/${params.IMG_UUID});
	background-position: left top;
	background-repeat: no-repeat;
	background-size: 100% 100%;
}
</style>
<input type="hidden" id="num" value="${params['0'].POPUP_NUM }"/>
<c:if test="${!empty params['0'].IMG_UUID }">
	<div class="image" style="width: 100%; height: 95%;">
		<div class="text">
			<c:if test="${!empty params['0'].CONTENT }">
				${params['0'].CONTENT }
			</c:if>
		</div>
		<div style="min-height: 60%;"></div>
		<div class="button" style="bottom: 10px;" align="center">
			<c:if test="${enable}">
				<h3 style="color: green;">${params['0'].RATE}% 할인</h3>
				<button class="btn btn-default" type="button" id="cupon" value="${params['0'].CUPON_BASE}">쿠폰 받기</button>
			</c:if>
		</div>
	</div>
</c:if>
<table>
	<thead>
		<tr>
			<td width="50%;" align="center"><span style="text-align: center; cursor:pointer;" id="deny" onclick="javascript:deny();">오늘 하루 안 보기</span></td>
			<td width="50%;" align="center"><span style="text-align: center; cursor:pointer;" onclick="javascript:self.close();">창 닫기</span></td>
		</tr>
	</thead>
</table>
<script>
	$("#cupon").on("click", function() {
		$.ajax({
			'url':"/createCupon.j",
			'data':{
				'cupon':$("#cupon").val()
			}
		}).done(function(rst){
			if(rst.auth == false){
				window.alert("로그인이 필요합니다.");
				window.close();
			}else{
				if(rst.b){
					window.alert("쿠폰 받았다냥");
					window.close();
				}else{
					window.alert("이미 보유 중인 쿠폰이다냥");
					window.close();
				}
			}
		});
	});
	
	function deny(){
		$.ajax({
			'url':"/deny_popup.j",
			'data':{
				'num':$("#num").val()
			}
		}).done(function(rst){
			if(rst){
				window.close();
			}
		});
	}
	
</script>