<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<div class="container">
 	<h1>등급 : ${grade}</h1>
 	총 매출금액 : ${sum_price}
	
	<div id="curve_chart" style="width:80%"></div>
 	
 	
 </div>
 
 
 
 
  
 <script type="text/javascript">
     google.charts.load('current', {'packages':['corechart']});
     google.charts.setOnLoadCallback(drawChart);

     function drawChart() {
       var data = google.visualization.arrayToDataTable([
         ['pronum', 'price'],
         <c:forEach items="${list}" var="i"  varStatus="vs">
			["${i.PRONUM}" , ${i.PRICE} ]
			<c:if test="${!vs.last }"> , </c:if>
	  	</c:forEach>
       ]);

       var options = {
         title: '상품별 매출현황',
         curveType: 'function',
         legend: { position: 'bottom' }
       };

       var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

       chart.draw(data, options);
     }
</script>