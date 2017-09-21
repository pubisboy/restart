<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
th{
	text-align: center;
}
td{
	text-align: center;
}
</style>

<table class="table table-bordered" style="width: 50%;">
	<thead>
		<tr>
			<th>분류</th>
			<th>값</th>
			<th>수정</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>적립비율</td>
			<td id="parent"><span id="point" class='upsp'>${rate }%</span></td>
			<td><button id="rate" class="upbtn">수정</button></td>
		</tr>
		<tr>
			<td>배송비</td>
			<td>
				<span id="dhl" class='upsp'><fmt:formatNumber value="${dhl }" pattern="#,###"/>원</span>
			</td>
			<td><button id="charge" class="upbtn">수정</button></td>
		</tr>
	</tbody>
</table>

<script>

var orip = $("#point");
var oric = $("#dhl");
var oriptext = $("#point").html();
var orictext = $("#dhl").html();
var oribtnp = $("#rate");
var oribtnc = $("#charge");

var init = function(){
	$(".upbtn").off("click").on("click", function(){
		var now = $(this);
		var type = $(this).attr('id');
		var ori = $(this).parent().prev().children();
		var html = ori.html();
		var sub;
		var oritext = html.substr(0, html.length - 1);
		if(type == 'rate'){
			sub = "%";
		}else{
			sub = "원";
		}
		ori.html("<input type='text' id='up' class='up' style='width:70px;' value='"+oritext+"'></input>");
		$(this).hide();
		$(document).off("click").on("click", function(e){
			if(!($(e.target).hasClass('up')) && !($(e.target).hasClass('upbtn'))){
				orip.html(oriptext);
				oric.html(orictext);
				oribtnp.show();
				oribtnc.show();
			}
		})
		$(".up").off("keydown").on("keydown", function(key){
			if(key.keyCode == 13){
				var res = /^[0-9]+$/;
				var val = $(this).val();
				if (!res.test(val)){
					window.alert("숫자만 입력하세요.");
				}else{
					$.ajax({
						'url':'/admin/management/etc/updateEtc.ja',
						'data':{
							'type':type,
							'val':val
						}
					}).done(function(rst){
						if(rst.b){
							ori.html("<span id='point' class='uprate'>"+rst.rst+sub+"</span>");
							now.show();
						}
					})
				}
			}
		})
	})
}
init();
</script>