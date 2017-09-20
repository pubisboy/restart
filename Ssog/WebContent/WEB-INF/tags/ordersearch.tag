<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="message" %>
<%
	String str="";
	switch(message){
		case "receiver":
			str = "받는사람";
			break;
		case "order_num":
			str="주문번호";
			break;
	}
%>
<%=str%>