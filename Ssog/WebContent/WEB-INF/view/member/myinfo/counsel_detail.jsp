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
</style>
<div class="row">
	<div class="col-sm-12">
		<h4 style="font-size: 17px; text-align: left;">
			<div style="padding-bottom: 10px;">
			<span class="glyphicon glyphicon-info-sign"
				style="padding-right: 10px;"></span><b style="padding-right: 10px;">1:1
				문의</b><small>고객님께서 문의하신 내용에 대한 답변은 마이페이지>1:1 문의에서 확인이 가능합니다.</small>
				</div>
			<div style="border-top: 2px solid #595959;">
				<form action="/member/myinfo/counsel_rst.j" enctype="multipart/form-data" method="post"	>
					<div class="row" style="padding-left:15px; padding-right: 15px;">
						<div class="col-xs-4" style="border-right: 1px solid #595959; border-bottom: 1px solid #595959; padding-top: 17.5px; padding-bottom: 17.5px; padding-left: 20px; width: 130px; background-color: #f2f2f2;"><p style="font-size: 13px; margin: 0px;">문의유형</p></div>
						<div class="col-xs-8" style="border-bottom: 1px solid #595959; padding-top: 8px; padding-bottom: 8px; width: 620px;">    
							<select class="form-control" name="cate" id="cate" style="width: 200px;height: 33px;"> 
								<option>---선택---</option>
								<c:forEach var="i" items="${cate }">
									<option value="${i.NUM }">${i.CATEGORY }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row" style="padding-left:15px; padding-right: 15px;">
						<div class="col-xs-4" style="border-right: 1px solid #595959; border-bottom: 1px solid #595959; padding-top: 15px; padding-bottom: 15px; width: 130px; background-color: #f2f2f2;"><p style="font-size: 13px; margin: 0px;">이름</p></div> 
						<div class="col-xs-2" style="border-right: 1px solid #595959; border-bottom: 1px solid #595959; padding-top: 15px; padding-bottom: 15px; width: 160px;"><p style="font-size: 13px; margin: 0px;">${memberinfo.NAME }</p></div>
						<div class="col-xs-3" style="border-right: 1px solid #595959; border-bottom: 1px solid #595959; padding-top: 15px; padding-bottom: 15px; width: 160px;"><p style="font-size: 13px; margin: 0px;">연락가능 전화번호</p></div>
						<div class="col-xs-3"style=" border-bottom: 1px solid #595959; padding-top: 15px; padding-bottom:15px; width: 300"><p style="font-size: 13px; margin: 0px;">${memberinfo.PHONE }</p></div>
					</div>
					<div class="row" style="padding-left:15px; padding-right: 15px;">
						<div class="col-xs-4" style="border-right: 1px solid #595959; border-bottom: 1px solid #595959; padding-top: 15px; padding-bottom: 15px; width: 130px; background-color: #f2f2f2;"><p style="font-size: 13px; margin: 0px;">제목</p></div>
						<div class="col-xs-8" style=" border-bottom: 1px solid #595959; padding-top: 10px; padding-bottom: 10px; width: 620px;"> 
							<input type="text" style="width: 100%;" name="title">
						</div>
					</div>
					<div class="row" style="padding-left:15px; padding-right: 15px;">
						<div class="col-xs-4" style="border-right: 1px solid #595959; border-bottom: 1px solid #595959; padding-top: 60.5px; padding-bottom: 64px; width: 130px; background-color: #f2f2f2;"><p style="font-size: 13px; margin: 0px;">문의 내용</p></div>
						<div class="col-xs-8" style=" border-bottom: 1px solid #595959; padding-top: 12px; padding-bottom: 12px; width: 620px;" align="center"> 
							<textarea style="width: 100%; resize: none; overflow:auto;" class="form-control" rows="4" id="content" name="content"></textarea>
							<p align="left">
							<small style="font-size: 11px;">* 정확하고 빠른 답변을 위하여 질문하시는 내용을 구체적으로 적어주세요. 내용은 500자 이내로 입력하세요.</small>
							</p> 
						</div>
					</div>
					<div class="row" style="padding-left:15px; padding-right: 15px;">
						<div class="col-xs-4" style="border-right: 1px solid #595959; border-bottom: 1px solid #595959; padding-top: 36px; padding-bottom: 36px; width: 130px; background-color: #f2f2f2;"><p style="font-size: 13px; margin: 0px;">이미지첨부</p></div>
						<div class="col-xs-8" style=" border-bottom: 1px solid #595959; padding-top: 5px; padding-bottom: 5px; width: 620px;">  
							<input type="file" name="f" />
							<button type="button">삭제</button><br/>
							<small style="font-size: 11px; padding-right: 60px;">
							*첨부 가능 파일형식 : JPG(JPEG), GIF, PDF<br/>
							* 파일명은 영문/숫자만 가능합니다.
							</small>
						</div>
					</div>
					<div align="center" style="padding-top: 15px;">
					<input type="submit" value="문의하기" class="btn btn-custom"> 
					<button type="button" class="btn btn-custom2">취소하기</button>
					</div>
				</form>
			</div>
		</h4>
	</div>
</div>
