<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${rst eq true}">
		<script>
			window.alert("작성한 글이 등록되었습니다.");
			location.href="/seller/counsel/qna/list.j";
		</script>
	</c:when>
	<c:otherwise>
		<script>
			window.alert("글 등록 실패");
			location.href="/seller/counsel/qna/list.j";
		</script>
	</c:otherwise>
</c:choose>

