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
	
	.wrap {padding:10px}
	.wrap small {color:gray;}
</style>

<div class="wrap">
	<p style="padding-bottom: 10px; text-align:left">
		<span class="glyphicon glyphicon-info-sign " style="padding-right: 10px;"></span>
		<b style="padding-right: 10px;">1:1 문의</b>
		<small>고객님께서 문의하신 내용에 대한 답변은 상담관리 > 1:1 문의 게시판에서 확인 가능합니다.</small>
	</p>
	
	<div style="border-top: 2px solid #595959;">
		<form action="/seller/counsel/write_ok.j" enctype="multipart/form-data" method="post">
			<table id="counsel_table" class="table">
				<tr>
					<td class="td_left">문의유형</td>
					<td colspan="3">
						<select class="form-control" name="cate" id="cate" style="width: 200px;height: 33px;"> 
							<option>---선택---</option>
							<c:forEach var="i" items="${cate}">
								<option value="${i.NUM }">${i.CATEGORY}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td width="20%" class="td_left">이름</td>
					<td width="30%">${map.NAME}</td>
					<td width="20%" class="td_left" style="border-left:1px solid #595959">연락가능 전화번호</td>
					<td width="30%">${map.PHONE}</td>
				</tr>
				<tr>
					<td class="td_left">제목</td>
					<td colspan="3">
						<input type="text" style="width: 100%;" name="title">
					</td>
				</tr>
				<tr>
					<td class="td_left">문의 내용</td>
					<td colspan="3">
						<textarea name="content" rows="4" style="width:100%; resize:none; overflow: scroll;"></textarea><br>
						<small style="font-size: 11px; padding-right: 60px;">* 정확하고 빠른 답변을 위하여 질문하시는 내용을 구체적으로 적어주세요. 
						내용은 500자 이내로 입력하세요.</small>
					</td>
				</tr>
				<tr>
					<td class="td_left">이미지첨부</td>
					<td colspan="3">  
						<input type="file" name="f">
						<button type="button" onClick="location='#'">삭제</button><br>
						<small style="font-size: 11px; padding-right: 60px;">
							*첨부 가능 파일형식 : JPG(JPEG), GIF, PDF<br/>
							* 파일명은 영문/숫자만 가능합니다.
						</small>
					</td>
				</tr>
			</table>
			<input type="submit" value="문의하기" class="btn btn-custom"> 
			<button type="button" class="btn btn-custom2">취소하기</button>
		</form>
	</div>
	
</div>
