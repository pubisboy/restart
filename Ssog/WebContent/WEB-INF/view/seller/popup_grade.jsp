<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	table {
	    border-collapse: collapse;
	}
	table, th, td {
	    border: 1px solid black;
	}
	.wrap {width:100%;}
</style>
<div class="wrap">
	<table style="width:100%; height:100%">
	  	 <tr>
		    <th>회원등급</th>
	        <th>자격요건</th>
	        <th>혜택</th>
		 </tr>
	 	 <c:forEach items="${list}" var="i">
	 	 	<tr align="center">
			    <td>${i.GRADE}</td>
		        <td><fmt:formatNumber value="${i.STANDARD}" type="number"/>원 이상 판매</td>
		        <c:choose>
		       		<c:when test="${i.GRADE  eq '실버'}">
		       			<td>수수료 2% 할인</td>
		       		</c:when>
		       		<c:when test="${i.GRADE  eq '골드'}">
		       			<td>수수료 3% 할인</td>
		       		</c:when>
		       		<c:when test="${i.GRADE eq '플래티넘'}">
		       			<td>수수료 5% 할인</td>
		       		</c:when>
		       		<c:when test="${i.GRADE eq '다이아몬드'}">
		       			<td>수수료 10% 할인</td>
		       		</c:when>
		       		<c:otherwise>
		       			<td>없음</td>
		       		</c:otherwise>
		        </c:choose>
		 	</tr>
	 	 </c:forEach>
	</table>
</div>

