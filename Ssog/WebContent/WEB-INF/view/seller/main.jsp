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
	
	.wrap {
		width:80%; margin-left:10%;
	}
	.wrap .table {
		table-layout: fixed;
	}
	.wrap .table td {
	    overflow: hidden;
	    text-overflow:ellipsis; /*overflow: hidden; 속성과 같이 써줘야 말줄임 기능이 적용된다.*/
	    white-space:nowrap; /*<td>보다 내용이 길경우 줄바꿈 되는것을 막아준다.*/
	}
	
	.menu {
		background: rgb(69,72,77); /* Old browsers */
		background: -moz-linear-gradient(top, rgba(69,72,77,1) 0%, rgba(0,0,0,1) 100%); /* FF3.6-15 */
		background: -webkit-linear-gradient(top, rgba(69,72,77,1) 0%,rgba(0,0,0,1) 100%); /* Chrome10-25,Safari5.1-6 */
		background: linear-gradient(to bottom, rgba(69,72,77,1) 0%,rgba(0,0,0,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#45484d', endColorstr='#000000',GradientType=0 ); /* IE6-9 */
		cursor:pointer;
		color:white;
	}
	
	.wrap small { color:gray; }
	.table a {color:black;}
	.fa-star, .fa-star-half-empty, .fa-star-o {color:#FFBB00;}
</style>


<div class="wrap">
		<table style="width: 100%; margin-top: 10px; border:1px solid black; height:75px;" align="center">
			<tr align="center">	
				<td>
					<b style="font-size:15px">회원님의 등급은 <font color="orange">${sessionScope.grade}</font>입니다.</b>
				</td> 
				<td>
					<a href="javascript:popupOpen();" style="color: #262626">
						<button style="font-size: 12px; width: 80px; height: 60px">
							회원 등급<br>자세히보기
						</button>
					</a>
				</td>
			</tr>
		</table>
	
	<div>
		<div style="margin-bottom: 10px; padding: 0px; background-color: #f2f2f2; width: 100%;">
			<p class="menu" align="center">상세정보</p>
		</div>
		<div id="sub-menu">
			<b style="padding-left: 10px; padding-right: 383px;">가입일 :
			<fmt:formatDate value="${myinfo.JOINDATE}" pattern="yyyy-MM-dd" /></b> 
			<button onClick="location='/seller/info/info_edit.j'" style="height: 20px; font-size: 12px;">회원정보 수정</button>
			<button onClick="location='/seller/info/pass_edit.j'" style="height: 20px; font-size: 12px;">비밀번호 수정</button>
			
			<ul style="padding-left: 25px; padding-top: 10px; text-align: left; width:100%;">
				<li style="color: grey; font-size: 13px;">회원이름
					<b style="padding-left: 10px; color: #404040">${myinfo.NAME }</b></li>
				<li style="color: grey; font-size: 13px;">브랜드명
					<b style="padding-left: 10px; color: #404040">${myinfo.BRAND }</b></li>
				<li style="color: grey; font-size: 13px;">전화번호 
					<b style="padding-left: 10px; color: #404040">${myinfo.PHONE }</b></li>
				<li style="color: grey; font-size: 13px;">계좌번호
					<b style="padding-left: 10px; color: #404040">(${myinfo.BANK}) ${myinfo.ACCOUNT}</b></li>
			</ul>
		</div>
	</div>
	
	
	
	<!-- 주문현황 -->
	<div style="height: 200px; padding:5% auto; margin-top:5%;">
		<table width="100%">
			<tr>
				<td><b style="font-size: 1.4em;">주문현황</b></td>
				<td align="right" style="padding-right:30px">
					<a href="/seller/order/list.j" style="text-decoration: none; color: #595959;"><small>+더보기</small></a>
				</td>
			</tr>
		</table>
		<table class="table table-condensed">
			<thead>
				<tr  style="border-top: 3px solid black;">
					<th width="10%">주문번호</th>	
					<th width="25%">주문상품</th>	
					<th width="20%">결제금액</th>	
					<th width="25%">주문일자</th>
					<th width="20%">상태</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty order_list}">
					<tr><td colspan="5">주문한 상품이 없습니다.</td></tr>
				</c:if>
				<c:forEach var="i" items="${order_list}">
					<tr>
						<td style="color:gray">[${i.ORDER_NUM}]</td>
						<td><a href="/seller/product/productEdit.j?num=${i.PRO_NUM}">${i.PRO_NAME}</a></td>
						<td><fmt:formatNumber value="${i.PRICE}" type="number"/></td>
						<td><fmt:formatDate value="${i.ORDER_DATE}" pattern="yyyy/MM/dd" /></td>
						<td>${i.ST}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
	<!-- Q&A -->
	<div style="height: 200px; padding:5% auto">
		<table width="100%">
			<tr>
				<td><b style="font-size: 1.4em;">Q&A</b></td>
				<td align="right" style="padding-right:30px">
					<a href="/seller/counsel/qna/list.j" style="text-decoration: none; color: #595959;"><small>+더보기</small></a>
				</td>
			</tr>
		</table>
		<table class="table table-condensed">
			<thead>
				<tr style="border-top: 3px solid black;">
					<th width="10%">상품번호</th>
					<th width="10%">문의유형</th>
					<th width="50%">제목</th>
					<th width="10%">작성자</th>
					<th width="20%">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty qna_list}">
					<tr><td colspan="5" align="center">등록한 글이 없습니다.</td></tr>
				</c:if>
				<c:forEach var="i" items="${qna_list}">
					<tr>
						<td><a href="/seller/product/productEdit.j?num=${i.PRO_NUM}" style="color:gray">[${i.PRO_NUM}]</a></td>
						<td>${i.QNA_CATE}</td>
						<td><a href="/seller/counsel/qna/write.j?num=${i.NUM}">${i.TITLE}</a></td>
						<td>${i.USER_ID}님</td>
						<td><fmt:formatDate value="${i.QANDADATE}" pattern="yyyy/MM/dd"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<!-- 리뷰 -->
	<div style="height: 200px; padding:5% auto;">
		<table width="100%">
			<tr>
				<td><b style="font-size: 1.4em;">REVIEW</b></td>
				<td align="right" style="padding-right:30px">
					<a href="/seller/counsel/review/list.j" style="text-decoration: none; color: #595959;"><small>+더보기</small></a>
				</td>
			</tr>
		</table>
		<table class="table table-condensed">
			<thead>
				<tr style="border-top: 3px solid black;">
					<th width="10%">상품번호</th>
					<th width="50%">리뷰 내용</th>
					<th width="20%">별점</th>
					<th width="10%">작성자</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty review_list}">
					<tr><td colspan="4" align="center">등록한 글이 없습니다.</td></tr>
				</c:if>
				<c:forEach var="i" items="${review_list}">
					<tr>
						<td><a href="/seller/product/productEdit.j?num=${i.PRO_NUM}" style="color:gray">[${i.PRO_NUM}]</a></td>
						<td><a href="#.j?num=${i.NUM}">${i.CONTENT}</a>
							<c:if test="${i.IMAGE_UUID ne null}">
								<span class="glyphicon glyphicon-picture" style="margin-left:5px"></span>
							</c:if>
						</td>
						<td>
							<span style="vertical-align: bottom;">
							<c:forEach var="j"  begin="1" end="${i.STAR%2 eq 0? i.STAR/2 : (i.STAR/2)-0.5}">
								<i class="fa fa-star"></i>
							</c:forEach>
							<c:if test="${i.STAR%2 ne 0 }">
								<i class="fa fa-star-half-empty"></i>
							</c:if>
							<c:forEach var="j"  begin="1" end="${5-i.STAR/2}">
								<i class="fa fa-star-o"></i>
							</c:forEach>
							</span>
						</td>
						<td>${i.USER_ID}님</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<script>
	$(".menu").on("click",function(){
		  var obj = $(this);
		    //obj.next().slideToggle(400);            
		    obj.parent().next().slideToggle(400);
	});
</script>