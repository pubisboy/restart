<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<form id="form" action="/admin/management/cupon/cupon_writeExec.ja" method="post">
	<div align="center">
		<table>
			<tbody>
				<tr>
					<td colspan="2">
						<div>쿠폰 생성</div>
					</td>
				</tr>
				<tr>
					<td>
						<div>할인율</div>
					</td>
					<td>
						<div>
							<select id="r" name="type">
								<c:forEach items="${list }" var="i">
									<c:if test="${i.CUPON_NUM ne 1}">
										<option value="${i.CUPON_NUM }">${i.RATE }</option>
									</c:if>
								</c:forEach>
							</select>%
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div>유효 기간</div>
					</td>
					<td>
						<div>
							<select id="y" class="b" name="year">
								<c:forEach var="i" begin="0" end="9" varStatus="vs">
									<option value="${year + vs.index }">${year + vs.index }</option>
								</c:forEach>
							</select>
							<select id="m" class="b" name="month">
								<c:forEach var="i" begin="1" end="12" varStatus="vs">
									<option value="${i }">${i }</option>
								</c:forEach>
							</select>
								<select id="d" name="day">
							</select>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>
<div align="center">
	<button type="button" id="submit">생성</button>
	<button type="button" id="pre">취소</button>
</div>

<script>
	$("#pre").on("click", function(){
		location.href = "/admin/management/cupon/cupon_list.ja";
	});
	
	$(".b").on("change", function(){
		$.ajax({
			'url':"/admin/management/cupon/calc_day.ja",
			'data':{
				'y':$("#y").val(),
				'm':$("#m").val(),
				'd':'1'
			}
		}).done(function(rst){
			var html = "";
			for(var i = 0; i < rst.length; i++){
				html += rst[i];
			}
			$("#d").html(html);
		});
	});
	
	$("#submit").on("click", function(){
		if($("#r").val() != null &&	$("#y").val() != null && $("#m").val() != null && $("#d").val() != null){
			$("#form").submit();
		}
	})

</script>