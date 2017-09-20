<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="curve_chart" style="width: 100%; height: 30%;"></div>

<div>검색 : ${total }건</div>

<div>
	<div id="selDetail" style="float: left; width: 60%;">
		<form action="/admin/sales/sales/sales_list.ja" method="get" id="f">
			<input type="hidden" name="term" id="term"/>
			<div style="float: left; width: 40%;" id="begin">
				시작<select name='by' id='by'><optgroup label='년'></optgroup>
					<option value="none" ${empty params.by ? 'selected' : ''}>--</option>
					<c:forEach items="${years }" var="i"  varStatus="vs">
						<option value="${i }" ${params.by ne 'none' and params.by eq i ? 'selected' : ''}>${i }</option>
					</c:forEach>
				</select>
				<select name='bm' id='bm'><optgroup label='월'></optgroup>
					<option value="none" ${empty params.bm ? 'selected' : ''}>--</option>
					<c:forEach begin="1" end="12" var="i"  varStatus="vs">
						<option value="${13 - i }" ${params.bm ne 'none' and params.bm eq (13-i) ? 'selected' : ''}>${13 - i }</option>
					</c:forEach>
				</select>
				<select name='bd' id='bd'><optgroup label='일'></optgroup>
					<option value="none" ${empty params.bd ? 'selected' : ''}>--</option>
				</select>
			</div>
			<div style="float: left; width: 40%;" id="end">
				종료<select name='ey' id='ey'><optgroup label='년'></optgroup>
					<option value="none" ${empty params.ey ? 'selected' : ''}>--</option>
					<c:forEach items="${years }" var="i"  varStatus="vs">
						<option value="${i }" ${params.ey ne 'none' and params.ey eq i ? 'selected' : ''}>${i }</option>
					</c:forEach>
				</select>
				<select name='em' id='em'><optgroup label='월'></optgroup>
					<option value="none" ${empty params.em ? 'selected' : ''}>--</option>
					<c:forEach begin="1" end="12" var="i"  varStatus="vs">
						<option value="${13 - i }" ${params.em ne 'none' and params.em eq (13-i) ? 'selected' : ''}>${13 - i }</option>
					</c:forEach>
				</select>
				<select name='ed' id='ed'><optgroup label='일'></optgroup>
					<option value="none" ${empty params.ed ? 'selected' : ''}>--</option>
				</select>
			</div>
			<div style="float: left; width: 10%;" id="search">
				<button type="button" id="sbt" class="btn btn-default" style="height: 20px; padding-top: 1px;">검색</button>
			</div>
			<div id="alerts" style="float: left; width: 5%; color: red;"></div>
		</form>
	</div>
	<div style="float: right; width: 5%;">
	<a
		href="/admin/sales/sales/sales_list.ja?p=${params.p}&term=${params.term}&by=${params.by}&bm=${params.bm}&bd=${params.bd}&ey=${params.ey}&em=${params.em}&ed=${params.ed}&sort=${!empty params.sort and params.sort == 'asc' ? 'desc' : 'asc'}">${!empty params.sort and params.sort == 'asc' ? '오름' : '내림'}</a>
</div>
</div>

<table class="table table-bordered" style="text-align: center;">
	<thead>
		<tr>
			<th width="30%;" style="text-align: center;">날짜</th>
			<th style="text-align: center;">매출(구매확정기준)</th>
			<th style="text-align: center;">주문건수(구매확정기준)</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="i" varStatus="vs">
			<tr>
				<td>${i.PAY_DATE }</td>
				<td><fmt:formatNumber value="${i.PRICE }" pattern="#,###" />원</td>
				<td><fmt:formatNumber value="${i.COUNT }" pattern="#,###" />개</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div align="center">
	<c:if test="${paging.startPageNo ne paging.firstPageNo }">
		<a
			href="/admin/sales/sales/sales_list.ja?p=${paging.startPageNo - 1}&term=${params.term}&by=${params.by}&bm=${params.bm}&bd=${params.bd}&ey=${params.ey}&em=${params.em}&ed=${params.ed}&sort=${params.sort}">&lt;</a>
	</c:if>

	<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo }"
		var="i">
		<a href="/admin/sales/sales/sales_list.ja?p=${i}&term=${params.term}&by=${params.by}&bm=${params.bm}&bd=${params.bd}&ey=${params.ey}&em=${params.em}&ed=${params.ed}&sort=${params.sort}"
			${paging.currentPageNo eq i ? 'style="font-weight:bold"' : '' }>${i }</a>
	</c:forEach>

	<c:if test="${paging.endPageNo ne paging.finalPageNo }">
		<a
			href="/admin/sales/sales/sales_list.ja?p=${paging.endPageNo + 1}&term=${params.term}&by=${params.by}&bm=${params.bm}&bd=${params.bd}&ey=${params.ey}&em=${params.em}&ed=${params.ed}&sort=${params.sort}">&gt;</a>
	</c:if>
</div>
<div align="right"><button id="excel">Excel 다운로드</button></div>
<script src="<c:url value="/etc.js" />"></script>

<script>
	$("#bm").on("change", function(){
		if($("#by").val() == 'none'){
			window.alert("연도를 선택 하세요.");
		}else if($("#bm").val() != 'none'){
			$.ajax({
				'url':"/admin/sales/sales/calc_day.ja",
				'data':{
					'y':$("#by").val(),
					'm':$("#bm").val(),
					'd':'1',
					'be':'b'
				}
			}).done(function(rst){
				$("#bd").html(rst);
			});
		}else{
			$("#bd").html("");
		}
	});
	$("#em").on("change", function(){
		if($("#ey").val() == 'none'){
			window.alert("연도를 선택 하세요.");
		}else if($("#em").val() != 'none'){
			$.ajax({
				'url':"/admin/sales/sales/calc_day.ja",
				'data':{
					'y':$("#ey").val(),
					'm':$("#em").val(),
					'd':'1',
					'be':'e'
				}
			}).done(function(rst){
				$("#ed").html(rst);
			});
		}else{
			$("#ed").html("");
		}
	});
	function initB(){
		if($("#bm").val() != 'none'){
			$.ajax({
				'url':"/admin/sales/sales/calc_day.ja",
				'data':{
					'y':$("#by").val(),
					'm':$("#bm").val(),
					'd':'1',
					'be':'b'
				}
			}).done(function(rst){
				$("#bd").html(rst);
				var f = "${params.bd}";
				if(f.length > 0){
					$("#"+f+"bd").prop("selected", true);
				}
			});
		}
	}
	function initE(){
		if($("#em").val() != 'none'){
			$.ajax({
				'url':"/admin/sales/sales/calc_day.ja",
				'data':{
					'y':$("#ey").val(),
					'm':$("#em").val(),
					'd':'1',
					'be':'e'
				}
			}).done(function(rst){
				$("#ed").html(rst);
				var f = "${params.ed}";
				if(f.length > 0){
					$("#"+f+"ed").prop("selected", true);
				}
			});
		}
	}
	initB();
	initE();
	
	
	$("#sbt").on("click", function(){
		if($("#by").val() != 'none' && $("#ey").val() != 'none' && $("#bm").val() == 'none' && $("#em").val() == 'none' && $("#bd").val() == 'none' && $("#ed").val() == 'none'){
			window.alert("년도만 선택");
			if($("#by").val() <= $("#ey").val()){
				$("#term").val("yy");
				$("#f").submit();
			}else{
				$("#alerts").html("기간 설정 오류1");
			}
		}else if($("#by").val() != 'none' && $("#ey").val() != 'none' && $("#bm").val() != 'none' && $("#em").val() != 'none' && $("#bd").val() == 'none' && $("#ed").val() == 'none'){
			window.alert("년도/월 선택");
			if($("#by").val() < $("#ey").val()){
				$("#term").val("yy/MM");
				$("#f").submit();
			}else if($("#by").val() == $("#ey").val() && $("#bm").val() <= $("#em").val()){
				$("#term").val("yy/MM");
				$("#f").submit();
			}else{
				$("#alerts").html("기간 설정 오류2");
			}
		}else if($("#by").val() != 'none' && $("#ey").val() != 'none' && $("#bm").val() != 'none' && $("#em").val() != 'none' && $("#bd").val() != 'none' && $("#ed").val() != 'none'){
			window.alert("년도/월/일 선택");
			if($("#by").val() < $("#ey").val()){
				$("#term").val("yy/MM/dd");
				$("#f").submit();
			}else if($("#by").val() == $("#ey").val() && $("#bm").val() < $("#em").val()){
				$("#term").val("yy/MM/dd");
				$("#f").submit();
			}else if($("#by").val() == $("#ey").val() && $("#bm").val() == $("#em").val()){
				if($("#bd").val() < $("#ed").val()){
					$("#term").val("yy/MM/dd");
					$("#f").submit();
				}else{
					$("#alerts").html("기간 설정 오류3");
				}
			}else{
				$("#alerts").html("기간 설정 오류4");
			}
		}else{
			$("#alerts").html("기간 설정 오류");
		}
	})
	
	$("#excel").on("click", function(){
		location.href="/admin/sales/sales/sales_excel.ja?term=${params.term}&by=${params.by}&bm=${params.bm}&bd=${params.bd}&ey=${params.ey}&em=${params.em}&ed=${params.ed}";
	})
</script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
var test2 = ${days.size()};
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
	['day', 'sales'],
		<c:choose>
			<c:when test="${days.size() lt 8}">
				<c:forEach var="i" items="${days}" varStatus="vs">
					["${i.day}", ${i.price}]
					<c:if test="${!vs.last}">,</c:if>
				</c:forEach>
			</c:when>
			<c:otherwise>
			<c:forEach var="i" items="${days}" varStatus="vs">
				["", ${i.price}]
				<c:if test="${!vs.last}">,</c:if>
			</c:forEach>
			</c:otherwise>
		</c:choose>
	]);

  var options = {
    title: '기간 매출',
    curveType: 'none',
    legend: { position: 'bottom' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

  chart.draw(data, options);
}
</script>