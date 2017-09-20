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
	
	
	.wrap small { color:gray; }
	.table a {color:black;}
	
</style>


<div class="wrap">
		<table style="width: 100%; margin-top: 10px; border:2px solid green; height:75px;" align="center" border="1">
			<tr align="center">
				<td colspan="2"><span style="font-size: 13px;">회원등급</span></td>
			</tr>
			<tr align="center">	
				<td style="font-size: 20px;">${sessionScope.grade}</td> 
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
		<div
			style="margin-bottom: 10px; padding: 0px; background-color: #f2f2f2; width: 100%;">
			<p data-toggle="collapse" data-target="#demo" align="center"
				style="font-size: 12px; padding-bottom: 2px; padding-top: 2px; cursor:pointer;">상세정보</p>
		</div>
		<div id="demo" class="collapse in">
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
	
	
	

	<div style="height: 200px; border:1px solid">
		<table class="table table-condensed">
			<thead>
				<tr>
					<th style="border-bottom: 2px solid #595959;"><b style="font-size: 1.4em;">주문현황</b></th>
					<th style="padding-left: 190px; border-bottom: 2px solid #595959;">
					<a href="/seller/order/list.j" style="text-decoration: none; color: #595959;">
						<small>+더보기</small></a></th>
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
	<div style="height: 200px;  border:1px solid">
		<table class="table table-condensed">
			<thead>
				<tr>
					<th style="border-bottom: 2px solid #595959;"><b style="font-size: 1.4em;">상품 Q&A</b></th>  
					<th style="padding-left: 190px; border-bottom: 2px solid #595959;"><a
						href="/seller/counsel/qna/list.j"
						style="text-decoration: none; color: #595959;"><small>+더보기</small></a>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="obj" items="${qlist }">
					<tr>
						<td style="width: 120px;">${obj.CONTENT }</td>
						<td align="center" style="padding-left: 100px; width: 80px;">
						<fmt:formatDate value="${obj.QANDADATE }" pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${qlist.size() eq 0 }">
			등록된 내용이 없습니다.
		</c:if>
	</div>
</div>

