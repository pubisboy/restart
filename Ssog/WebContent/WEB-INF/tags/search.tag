<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="message" %>
<%
	String str="";
	switch(message){
		case "pro_name":
			str = "상품명";
			break;
		case "pro_num":
			str="상품번호";
			break;
	}
%>
<%=str%>