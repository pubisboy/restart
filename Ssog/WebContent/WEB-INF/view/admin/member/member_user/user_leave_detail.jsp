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
	<div class="col-xs-10">
	  	<table class="table table-bordered" style="text-align: center; min-height: 50%;">
	  		<thead>
	  			<tr>
	  				<th style="text-align: center;">기타 상세</th>
	  			</tr>
	  		</thead>
	  		<tbody>
	  			<tr>
	  				<td style="text-align: center;">${list[0].DETAIL }</td>
	  			</tr>
	  		</tbody>
	  	</table>
	  	<div style="float: left; width: 10%; text-align: left">
			<button type="button" class="btn btn-default" onclick="cancel('/admin/member/member_user/user_leave_del.ja?num=${i.NUM }&value=${params.value}&cate=${params.cate}&sort=${params.sort}');">삭제</button>
		</div>
	  	<div style="float: right; width: 33%; text-align: right">
	  		<button type="button" class="btn btn-default" onclick="cancel('/admin/member/member_user/user_leave_list.ja?p=${params.p }&cate=${params.cate }&value=${params.value}&sort=${params.sort }');">목록</button>
	  	</div>
  	</div>
</div>

<script src="<c:url value="/etc.js" />"></script>