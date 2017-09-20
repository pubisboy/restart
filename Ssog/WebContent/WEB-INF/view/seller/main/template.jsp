<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<div class="container" style="margin-left: 0px; padding-left:0px;">
	<div class="row">
		<div class="col-md-2">
			<nav>
				<tiles:insertAttribute name="nav" />
			</nav>
		</div>
		<div class="col-md-10" style="display:table-cell; text-align:center; vertical-align:middle">
			<section style="display:inline-block; margin-top:10px;">
				<tiles:insertAttribute name="section" />
			</section>
		</div>
	</div>
</div>
