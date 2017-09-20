<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.btn-custom {
	  background-color: hsl(0, 0%, 16%) !important;
	  background-repeat: repeat-x;
	  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#5b5b5b", endColorstr="#282828");
	  background-image: -khtml-gradient(linear, left top, left bottom, from(#5b5b5b), to(#282828));
	  background-image: -moz-linear-gradient(top, #5b5b5b, #282828);
	  background-image: -ms-linear-gradient(top, #5b5b5b, #282828);
	  background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5b5b), color-stop(100%, #282828));
	  background-image: -webkit-linear-gradient(top, #5b5b5b, #282828);
	  background-image: -o-linear-gradient(top, #5b5b5b, #282828);
	  background-image: linear-gradient(#5b5b5b, #282828);
	  border-color: #282828 #282828 hsl(0, 0%, 11%);
	  color: #fff !important;
	  border-radius: 0px;
	  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.33);
	  -webkit-font-smoothing: antialiased;
	}
	.btn-custom2 {
	  background-color: hsl(0, 0%, 95%) !important;
	  background-repeat: repeat-x;
	  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#10b10b10b", endColorstr="#f2f2f2");
	  background-image: -khtml-gradient(linear, left top, left bottom, from(#10b10b10b), to(#f2f2f2));
	  background-image: -moz-linear-gradient(top, #10b10b10b, #f2f2f2);
	  background-image: -ms-linear-gradient(top, #10b10b10b, #f2f2f2);
	  background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #10b10b10b), color-stop(100%, #f2f2f2));
	  background-image: -webkit-linear-gradient(top, #10b10b10b, #f2f2f2);
	  background-image: -o-linear-gradient(top, #10b10b10b, #f2f2f2);
	  background-image: linear-gradient(#10b10b10b, #f2f2f2);
	  border-color: #f2f2f2 #f2f2f2 hsl(0, 0%, 92.5%);
	  color: #333 !important;
	  border-radius: 0px;
	  text-shadow: 0 1px 1px rgba(255, 255, 255, 0.16);
	  -webkit-font-smoothing: antialiased;
	}
	
	#counsel_table 			{white-space:nowrap; font-size:12px; height:50%;}
	#counsel_table td 		{padding:10px; border-bottom:1px solid #595959; vertical-align: middle;}
	#counsel_table .td_left {border-right:1px solid #595959; background:#f2f2f2;}
	
	.wrap {
		width:80%; margin-left:10%;
	}
	.wrap .table {
		table-layout: fixed;
	}
	.wrap .table td {
	    overflow: hidden;
	    text-overflow:ellipsis; /*overflow: hidden; 속성과 같이 써줘야 말줄임 기능이 적용된다.*/
	    white-space:nowrap; /*<td>보다 내용이 길경우 줄바꿈 되는것을 막아준다.*/
	}
	
</style>

<div class="wrap">
	<p style="padding-bottom: 10px; text-align:left">
		<span class="glyphicon glyphicon-info-sign " style="padding-right: 10px;"></span>
		<b style="padding-right: 10px;">Q&A 답변</b>
	</p>
	
	<div style="border-top: 2px solid #595959;">
		<form action="/seller/counsel/qna/write_ok.j?num=${map.NUM}" enctype="multipart/form-data" method="post">
			<table id="counsel_table" class="table">
				<tr>
					<td class="td_left">문의유형</td>
					<td colspan="3">
						${map.CATEGORY}
					</td>
				</tr>
				<tr>
					<td class="td_left">제목</td>
					<td colspan="3">
						<input type="text" style="width: 100%;" name="title" value="RE:${map.TITLE}">
					</td>
				</tr>
				<tr>
					<td class="td_left">문의 내용</td>
					<td colspan="3">
						<textarea name="content" rows="20" style="width:100%; resize:none; overflow: scroll;">



-------------------------------------------------------------------------
RE:
${map.CONTENT}						
						</textarea><br>
					</td>
				</tr>
			</table>
			<button type="submit" class="btn btn-custom">확인</button> 
			<button type="button" class="btn btn-custom2" onClick="location='/seller/counsel/qna/list.j'">취소하기</button>
		</form>
	</div>
	
</div>
