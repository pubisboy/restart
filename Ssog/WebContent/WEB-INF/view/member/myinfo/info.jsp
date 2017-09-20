<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<div class="row" style="padding-top: 20px;">
	<div style="padding-left: 15px; padding-bottom: 20px;">
		<img src="/image/info이미지.jpg" alt="Fjords" width="99%;">
	</div>
	<div class="col-sm-6" style="height: 200px;">
		<table class="table table-condensed">
			<thead>
				<tr>
					<th style="border-bottom: 2px solid #595959;"><b style="font-size: 1.4em;">1:1 문의</b></th>
					<th style="padding-left: 190px; border-bottom: 2px solid #595959;"><a
						href="/member/myinfo/counsel.j"
						style="text-decoration: none; color: #595959;"><small>+
								더보기</small></a></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="obj" items="${clist }">
					<tr>
						<td style="width: 120px;">${obj.CONTENT }</td>
						<td align="center" style="padding-left: 80px; width: 80px;"><fmt:formatDate
								value="${obj.COUNSEL_DATE }" pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${clist.size() eq 0 }">
			등록된 내용이 없습니다.
		</c:if>
	</div>
	<div class="col-sm-6" style="height: 200px;">
		<table class="table table-condensed">
			<thead>
				<tr>
					<th style="border-bottom: 2px solid #595959;"><b style="font-size: 1.4em;">상품 Q&A</b></th>  
					<th style="padding-left: 190px; border-bottom: 2px solid #595959;"><a
						href="/member/myinfo/qna.j"
						style="text-decoration: none; color: #595959;"><small>+
								더보기</small></a>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="obj" items="${qlist }">
					<tr>
						<td style="width: 120px;">${obj.CONTENT }</td>
						<td align="center" style="padding-left: 100px; width: 80px;"><fmt:formatDate
								value="${obj.QANDADATE }" pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${qlist.size() eq 0 }">
			등록된 내용이 없습니다.
		</c:if>
	</div>
	<div class="col-sm-12" style="height: 100px;">
		<div style="padding-bottom: 10px;">
			<h4 style="font-size: 1.45em; text-align: left;">      
				<span class="glyphicon glyphicon-info-sign"
					style="padding-right: 10px;"></span><b
					style="padding-right: 10px; color: #404040; letter-spacing: -1px; font-family: Sans-serif;">최근
					주문현황</b><small style="font-size: 12px;">(최근 2개월 기준)</small>


			</h4>
		</div>
		<div style="border-top: 2px solid #595959; border-bottom: 1px solid #a6a6a6; padding-top: 10px; padding-bottom: 10px;">
			<div class="row">
				<div class="col-xs-10">
					<div class="row">
						<div class="col-xs-3">
							<b style="font-size: 17px;">주문완료</b><br /> <b style="color: #ff1a75; text-decoration: underline; font-size: 25px;">${smap.s }</b>건
							<span class="glyphicon glyphicon-menu-right" style="font-size: 20px;"></span>       
						</div>
						<div class="col-xs-3">
							<b style="font-size: 17px;">상품준비중</b><br /><b style="color: #ff1a75; text-decoration: underline; font-size: 25px;">${smap.ss }</b>건
							<span class="glyphicon glyphicon-menu-right" style="font-size: 20px;"></span>
							</div> 
						<div class="col-xs-3">
							<b style="font-size: 17px;">배송중</b><br /><b style="color: #ff1a75; text-decoration: underline; font-size: 25px;">${smap.sss }</b>건
							<span class="glyphicon glyphicon-menu-right" style="font-size: 20px;"></span>	
						</div>
						<div class="col-xs-3">
							<b style="font-size: 17px;">배송완료</b><br /><b style="color: #ff1a75; text-decoration: underline; font-size: 25px;">${smap.ssss }</b>건
						</div>  
					</div>
				</div>
				<div class="col-xs-2" align="left" style="background-color: #d9d9d9; font-size: 12px;"> 
				취소접수<br/>
				취소처리중<br/> 
				취소완료<b style="color: #ff1a75;">${smap.sssss }</b><br/>  
				</div> 
			</div>
		</div>

	</div>
	<div class="col-sm-12" style="height: 100px; padding-top: 60px;">  
		<div style="padding-bottom: 10px;">
			<h4 style="font-size: 1.45em; text-align: left;">
				<span class="glyphicon glyphicon-info-sign"
					style="padding-right: 10px;"></span><b
					style="padding-right: 10px; color: #404040; letter-spacing: -1px;font-family: Sans-serif; color: #404040;">최근
					주문내역</b><small style="font-size: 12px;">(최근 2개월 기준)</small> <a
					href="/member/myinfo/orderlist.j"><button
						class="btn btn-custom"
						style="width: 120px; height: 22px; font-size: 12px; padding: 0px;">전체
						주문내역 보기</button></a>
			</h4>
		</div>
		<div class="table-responsive">
			<table class="table">
				<thead>
					<tr style="border-top: 2px solid #595959;">  
						<th>주문일자</th>  
						<th>주문번호</th>
						<th>주문상품</th>
						<th>결제금액</th>
						<th>상태</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="obj" items="${page }">
						<tr>
							<td>${obj.ORDER_DATE }</td>
							<td>${obj.ORDER_NUM }</td>
							<td>
							<a href="/product/detail.j?productNumber=${obj.PRO_NUM }">${obj.PRO_NAME}</a></td>
							<td><fmt:formatNumber value="${obj.PRICE }" pattern="#,###"/>원</td>
							<td class="etc">${obj.S }</td> 
							<td align="center">
							<c:choose>
								<c:when test="${obj.S eq '구매확정'}">
									
								</c:when>
								<c:otherwise>
									<button class="set">구매확정</button>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${obj.S eq '주문취소'}"> 
									
								</c:when>
								<c:otherwise>
									<button class="cancel">주문취소</button>
								</c:otherwise>
							</c:choose>
									 
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr />
		</div>
		<div align="center" style="font-size: 15px;">
			<c:if test="${pg.startPageNo ne pg.firstPageNo}">&le;</c:if>
			<c:forEach var="i" begin="${pg.startPageNo }" end="${pg.endPageNo }">
				<a href="/member/myinfo/info.j?p=${i }">${i }</a>
			</c:forEach>
			<c:if test="${pg.endPageNo ne pg.finalPageNo}">
				<a href="/member/myinfo/info.j?p=${pg.endPageNo +1}">&gt;</a>
			</c:if>
		</div>
	</div>
</div>
<script>
	$(".set").on("click", function() {
		if ($(this).parent().prev().html() == '배송완료') {
			$.ajax({
				url : "/member/myinfo/set_rst.j",
				method : "post",
				data : {
					"num" : $(this).parent().prev().prev().prev().prev().html()
				}
			}).done(function(re) {
				if (re == true) {
					window.alert("구매후기쓰면 적립금!");
					location.reload();
				}
			})
		} else {
			window.alert("아직구매확정을 할수 없습니다.");
		}
	})
	$(".cancel").on("click",function(){
		window.alert("클릭"); 
		$.ajax({
			url:"/member/myinfo/cancel_rst.j",
			method:"post",
			data:{
				"num": $(this).parent().prev().prev().prev().prev().html()
			}
		}).done(function(rere){
			if(rere==true){
				window.alert("주문취소가 되었습니다.");
				location.reload();
			}
		})
	})
</script>