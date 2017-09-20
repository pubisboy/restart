<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="message" %>
<%
	String str="";
	switch(message){
	case "1":
		str="답변완료";
		break;
	case "0":
		str="답변대기";
		break;
	}
%>
<%=str%>