<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
li{
	text-align: left;
}
.type{
	text-align: center;
	width: 20%;
}
td{
	text-align: left;
}
</style>

<div class="container">
    <div class="row">
        <div class="col-xs-6">
        	<table class="table table-bordered" style="text-align: center; height: 47%;">
        		<thead>
        			<tr>
        				<th colspan="2" style="text-align: center;">상세정보</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<th class="type">아이디</th>
        				<td>${info['0'].ID }</td>
        			</tr>
        			<tr>
        				<th class="type">이름</th>
        				<td>${info['0'].NAME }</td>
        			</tr>
        			<tr>
        				<th class="type">성별</th>
        				<td>${info['0'].GENDER }</td>
        			</tr>
        			<tr>
        				<th class="type">생년월일</th>
        				<td>
        					${info['0'].BIRTH['0'] }년
        					${info['0'].BIRTH['1'] }월
        					${info['0'].BIRTH['2'] }일
        				</td>
        			</tr>
        			<tr>
        				<th rowspan="3" class="type">주소</th>
        				<td>${info['0'].ADDRESS['0'] }</td>
        			</tr>
        			<tr>
        				<td>${info['0'].ADDRESS['1'] }</td>
        			</tr>
        			<tr>
        				<td>${info['0'].ADDRESS['2'] }</td>
        			</tr>
        			<tr>
        				<th class="type">이메일</th>
        				<td>${info['0'].EMAIL }</td>
        			</tr>
        			<tr>
        				<th class="type">연락처</th>
        				<td>${info['0'].PHONE }</td>
        			</tr>
        			<tr>
        				<th class="type">가입날짜</th>
        				<td>
        					<fmt:formatDate value="${info['0'].JOINDATE }" pattern="yyyy년MM월dd일" var="i"/>${i }
        				</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
        <div class="col-xs-3">
        	<table class="table table-bordered" style="text-align: center; height: 47%;">
        		<thead>
        			<tr>
        				<th>특이사항</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<td>
        					<textarea id="memo" style="width: 100%; height: 100%; resize: none">${empty info['0'].MEMO ? '' : info['0'].MEMO}</textarea>
        				</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
        <div class="col-xs-3">
        	<table class="table table-bordered" style="text-align: center;">
        		<thead>
        			<tr>
        				<th colspan="2" style="text-align: center;">기타</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<th style="text-align: center; width: 50%;">등급</th>
        				<td style="text-align: center;">
	        				<div style="text-align: center">${grade['0'].GRADE }</div>
        				</td>
        			</tr>
        			<tr>
        				<th style="text-align: center; width: 50%;">구매총액</th>
        				<td>
        					<fmt:formatNumber value="${empty info['0'].BUY_TOTAL ? 0 : info['0'].BUY_TOTAL}" pattern="#,###"/>원
        				</td>
        			</tr>
        			<tr>
        				<th style="text-align: center; width: 50%;">구매건수</th>
        				<td>
        					<fmt:formatNumber value="${empty buyCount ? 0 : buyCount}" pattern="#,###"/>건
        				</td>
        			</tr>
        			<tr>
        				<th style="text-align: center; width: 50%;">포인트</th>
        				<td>
        					<fmt:formatNumber value="${empty info['0'].POINT ? 0 : info['0'].POINT}" pattern="#,###"/>
        				</td>
        			</tr>
        		</tbody>
        	</table>
        	<div>
        		<button type="button" class="btn btn-default" onclick="cancel('/admin/member/member_user/user_list.ja?p=${params.p }&type=${params.type }&value=${params.value}');">목록</button>
        	</div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-6">
        	<table class="table table-bordered" style="text-align: center; height: 30%;">
        		<thead>
        			<tr>
        				<th style="text-align: center;">
        					<ul class="list-inline" style="margin-bottom: 2px;">
        						<li style="text-align: center;">주문</li>
        						<li style="text-align:center; float:right"><a href="/admin/sales/order/order_list.ja?type=user_id&value=${info['0'].ID }" onclick="window.open(this.href, '','width=1400, height=800');return false;">+더보기</a></li>
        					</ul>
						</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<td>
        					<ul>
        						<li>[주문번호] / [상품번호] / [주문일] / [상태] / [가격]</li>
        						<c:forEach items="${order9 }" var="i">
	        						<li>
	        						[<a href="/admin/sales/order/order_detail.ja?order_num=${i.ORDER_NUM }" onclick="window.open(this.href, '','width=1600, height=900');return false;">${i.ORDER_NUM }</a>]
	        						 / [${i.PRO_NUM }]
	        						 / <fmt:formatDate value="${i.ORDER_DATE }" pattern="yyyy년MM월dd일" var="o"/>[${o }]
	        						 / [${i.ST }]
	        						 / [<fmt:formatNumber value="${i.PRICE }" pattern="#,###"/>]
	        						 </li>
        						</c:forEach>
        					</ul>
        				</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
        <div class="col-xs-6">
        	<table class="table table-bordered" style="text-align: center; height: 30%;">
        		<thead>
        			<tr>
        				<th style="text-align: center;">
	        				<ul class="list-inline" style="margin-bottom: 2px;">
	       						<li style="text-align: center;">1:1문의</li>
	       						<li style="text-align:center; float:right"><a href="/admin/management/counsel/counsel_user_list.ja?state=&reply=&sort=&type=user_id&value=${info['0'].ID }" onclick="window.open(this.href, '','width=1400, height=800');return false;">+더보기</a></li>
	       					</ul>
	       				</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<td>
        					<ul>
        						<li>[번호] / [제목] / [상태]</li>
        						<c:forEach items="${counsel9 }" var="i">
	        						<li>[${i.NUM }] / 
	        						[<a	href="/admin/management/counsel/counsel_user_detail.ja?num=${i.NUM }&p=${params.p }&type=${params.type }&value=${params.value}&state=${params.state}&reply=${params.reply}&sort=${params.sort}" onclick="window.open(this.href, '','width=1400, height=800');return false;">${i.TITLE }</a>]
	        						 / [${i.REPLY == 0 ? '미처리' : '답변완료'}]
	        						</li>
        						</c:forEach>
        					</ul>
        				</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
    </div>
</div>

<script>
	$("#memo").on("blur", function(){
		$.ajax({
			'url':"/admin/member/member_user/user_detail_memo_update.ja",
			'data':{
				'id':"${info['0'].ID }",
				'memo':$(this).val()
			}
		}).done(function(rst){
			if(!rst.rst){
				window.alert("오류");
			}
		});
	})
</script>
<script src="<c:url value="/etc.js" />"></script>