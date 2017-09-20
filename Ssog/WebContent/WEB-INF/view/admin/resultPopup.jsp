<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<c:when test="${rst }">
		<script>
			window.close();
			window.opener.location.href = "/admin/${t}";
		</script>
	</c:when>
	<c:otherwise>
		<script>
			window.alert("실패");
			window.close();
			window.opener.location.href = "/admin/${f}";
		</script>
	</c:otherwise>
</c:choose>