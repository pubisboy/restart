<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${bl eq true}">
		<script>
			window.alert("로그인성공");
		</script>
		로그인 성공(1포인트적립)
	</c:when>
	<c:otherwise>
		<script>
			window.alert("로그인실패");
		</script>
	</c:otherwise>
</c:choose>

<meta http-equiv="refresh" content="0;url=/" />