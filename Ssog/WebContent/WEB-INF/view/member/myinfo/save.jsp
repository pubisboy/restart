<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
table, th, td {
	font-size: 13px;
}
</style>
<div style="padding-top: 20px;">
	<h4 style="font-size: 17px; text-align: left;">
		<span class="glyphicon glyphicon-info-sign"
			style="padding-right: 10px;"></span><b style="padding-right: 10px;">적립금</b><small
			style="font-size: 12px;">회원님의 적립금 내역을 확인 할 수 있습니다.</small>
	</h4>
</div>
<div class="row">
	<div class="col-sm-12" style="padding-top: 10px;"> 
	<div 
		style="border-top: 2px solid #595959; border-bottom: 1px solid black; padding-top: 20px; padding-bottom: 20px; ">
		<b>${memberinfo.NAME }</b> 회원님의 현재 총 사용가능 적립금액은<br /> 적립금 0<sub>원</sub>
		입니다
	</div><br/><br/>
		<table class="table table-hover"> 
			<thead>
				<tr style="border-top: 2px solid #595959; ">
					<th>구분</th>
					<th>적립일자</th>
					<th>상세내용</th>
					<th>적립금액(원)</th>
					<th>사용금액(원)</th>
					<th>상세내역</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>적립</td>
					<td>2016-10-12</td>
					<td>매일 매일 행운의 적립금</td>
					<td>1,000</td>
					<td>-</td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="col-sm-12">
		적립금 사용안내
		<div class="well">
			<li>적립금은 사용가능한 적립금만 노출되며, 적립금 프로모션의 성격에 따라 사용이 일부 제한될 수 있습니다.</li>
			<li>자세한 사용안내는 고객센터 내 적립금 안내에서 확인하실 수 있습니다.</li>
		</div>
	</div>
</div>