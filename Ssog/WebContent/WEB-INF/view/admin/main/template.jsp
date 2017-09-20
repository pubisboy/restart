<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<style>
.container {
	margin-left: 10px;
}
</style>
<div class="container">
	<div class="row">
		<div class="col-md-2">
			<nav>
				<tiles:insertAttribute name="nav" />
			</nav>
		</div>
		<div class="col-md-10" style="margin-top: 30px;">
			<section>
				<tiles:insertAttribute name="section"/>
			</section>
		</div>
	</div>
</div>