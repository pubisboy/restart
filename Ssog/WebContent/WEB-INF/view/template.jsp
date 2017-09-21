<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><tiles:getAsString name="title" /></title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
.affix {
	top: 0px !important;
	width: 100%;
	z-index:9999;
}

.affix+.ttt {
	padding-top: 70px;
}
</style>
</head>
<body>
	<div>
		<div style="min-height: 8%; background-color: #F44336; color: #fff;"
			id="banner">
			<h1 style="margin: 0px;">GRAND OPEN</h1>
			<!-- 
			<img class="img-responsive" src="/image/banner1.jpg" alt="메인이미지1" />
			-->
			<button id="close"
				style="position: absolute; top: 20px; right: 240px;">X</button>
		</div>
		<header style="width: 100%; min-height: 12%;">
			<tiles:insertAttribute name="header" />
		</header> 
		<nav class="navbar navbar-default" data-spy="affix"  
			data-offset-top="165" style="margin-bottom: 0;" id="ssibal"> 
			<tiles:insertAttribute name="nav" />
		</nav>
		<section style="min-height: 220%;" class="ttt">   
			<tiles:insertAttribute name="section" />
		</section>
		<footer style="padding-top: 50px;">
			<tiles:insertAttribute name="footer"/>
		</footer>
	</div>
</body>
</html>
<script>
	$("#close").on("click", function() {
		$("#banner").hide();
	});
</script>