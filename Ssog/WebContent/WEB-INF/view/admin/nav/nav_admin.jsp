<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
li {
	text-align: center;
}
</style>

<nav class="navbar navbar-default" style="margin-bottom: 0px;">
	<div class="container-fluid">
		<ul class="nav nav-stacked nav-pills" style="margin-top: 20px;">
			<c:if test="${!empty sessionScope.admin and sessionScope.admin eq 'admin'}">
				<li style="text-align: center;"><a href="/admin/admin/admin_list.ja">관리자 목록</a></li>
				<li style="text-align: center;"><a href="/admin/admin/admin_create.ja">관리자 생성</a></li>
			</c:if>
			<li style="text-align: center;"><a href="/admin/admin/admin_modify.ja">정보 수정</a></li>
		</ul>
	</div>
</nav>