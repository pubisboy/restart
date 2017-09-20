<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach items="${list }" var="i" varStatus="vs">
	<option value="${params. }"
		${params.first eq stateNum[vs.index] ? 'selected' : ''}>${i }</option>
</c:forEach>