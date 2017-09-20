<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#comment		{ resize:none; vertical-align:bottom;}
	#btn_cmt		{ height:83px; }
	#comment_list	{ width:60%; }
	#mm 			{ text-align:right; }
	#time			{ color:gray; }
</style>

<form action="/seller/counsel/edit.j?num=${map.NUM}&group=${map.FT_GROUP}&step=${map.FT_STEP}" method="post">
	<h3>${map.FT_TITLE}</h3>
	
	<hr>
		<table width="55%" align=center>	
			<tr>
				<td align="right">
				 작성자:${map.USER_ID} |
				 작성일:<fmt:formatDate value="${map.COUNSEL_DATE }" pattern="yyyy-MM-dd HH:mm"/>
				 <%-- c:choose를 이용해서, 몇분전 몇시간전.. 등등--%>
				 <!-- 분 dday*1440(24*60=1440) -->
				 <span id="time">
				 <small>
				 	<c:choose>
				 		<c:when test="${map.DDAY ge 365}"> 
				 			 <fmt:formatNumber value="${map.DDAY/365}" pattern="#,###"/> 년 전
				 		</c:when>
				 		<c:when test="${map.DDAY ge 30}"> 
				 			 <fmt:formatNumber value="${map.DDAY/30}" pattern="#,###"/> 달 전
				 		</c:when>
				 		<c:when test="${map.DDAY ge 1}">
				 			<fmt:formatNumber value="${map.DDAY}" pattern="#,###"/> 일 전
				 		</c:when>
				 		<c:when test="${map.DDAY ge 0.04}">
				 			<fmt:formatNumber value="${map.DDAY/0.08}" pattern="#,###"/> 시간 전
				 		</c:when>
				 		<c:when test="${map.DDAY ge 0.0006}">
				 			<fmt:formatNumber value="${map.DDAY*1440}" pattern="#,###"/> 분 전
				 		</c:when>
				 		<c:otherwise>
				 			<fmt:formatNumber value="${map.DDAY*1440*60}" pattern="#,###"/> 초 전
				 		</c:otherwise>
				 	</c:choose>
				 </small>
				 </span><br><br>
				</td>
			</tr>
			<tr>
				<td><pre>${map.CONTENT}</pre></td>
			</tr>
			<tr>
				<td width="15%" bgcolor="lightgray" align="center">파일명</td>
				<td width="20%" colspan="3">${map.FILEUUID} <a href="/seller/counsel/download.j?num=${map.NUM }">다운로드</a></td>
			</tr>
		</table><br>
	
	
	<br><br>
	<button type="submit" class="btn">수정</button>
	<button type="button" onClick="location='/seller/counsel/list.j'" class="btn">목록</button>
</form>



