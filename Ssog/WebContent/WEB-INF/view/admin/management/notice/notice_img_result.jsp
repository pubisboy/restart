<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${result }">
		<script>
			window.parent.CKEDITOR.tools.callFunction(${funcNum}, "${imageUrl}");
		</script>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
