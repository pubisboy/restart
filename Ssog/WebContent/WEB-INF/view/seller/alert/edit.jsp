<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${rst eq true}">
		<script>
			window.alert("상품이 수정되었습니다.");
			location.href="/seller/product/list.j"
		</script>
	</c:when> 
	<c:otherwise> 
		<script>
			window.alert("상품 수정에 실패했습니다.");
			location.href="/seller/product/list.j"
		</script>
	</c:otherwise>
</c:choose>