<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 

<body>
	<div>
	<form action="/product/reviewExec.j">
	<input type="hidden" name="seller_id" value="${param.seller_id }">
	<input type="hidden" name="num" value="${param.num }">
	<div>
	<h2>리뷰쓰기</h2>
	</div>
	<table style="border: 1px solid black; width: 100%; height: 150px;;" >
	<tr>
	<td style="width: 5%" align="center" >제 점수는요</td> 
	<td style="width: 20%"> 
	
	<div style="margin-bottom: 4%;"><input type="radio" name="star" value="10" checked>
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	</input></div>
	<div style="margin-bottom: 4%;"><input type="radio" name="star" value="8" >
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	</input></div>
	<div style="margin-bottom: 4%;"><input type="radio" name="star" value="6">
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	</input></div>
	<div style="margin-bottom: 4%;"><input type="radio" name="star" value="4" >
	<span class="fa fa-star"></span>
	<span class="fa fa-star"></span>
	</input></div> 
	<div style="margin-bottom: 4%;"><input type="radio" name="star" value="2">
	<span class="fa fa-star"></span>
	</input></div>
	
	</td>
	<td style="width: 55%">
	<textarea style="height: 100%; width: 100%; resize: none;" required="false" name="contents"></textarea>
	</td> 
	<td style="width: 20%; padding: 10px;">
	<button type="submit" style="width: 100%; height: 100%;">리뷰 작성</button>
	</td>
	</tr>
	</table>
	</form>
	</div>
	
</body>
</html>