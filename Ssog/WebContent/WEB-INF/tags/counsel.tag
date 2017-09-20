<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="message" %>
<%
	String str="";
	switch(message){
	case "1":
		str="정산";
		break;
	case "2":
		str="기타";
		break;
	}
%>
<%=str%>