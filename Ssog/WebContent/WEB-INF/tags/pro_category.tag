<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="message" %>
<%
	String str="";
	switch(message){
		case "101" : 
			str="쌈,샐러드";
			break;
		case "102" : 
			str="뿌리채소,버섯";
			break;
		case "103" : 
			str="양파,마늘,파,고추";
			break;
		case "104" : 
			str="콩나물, 나물류";
			break;
		
		case "201" : 
			str="과일";
			break;
		case "202" : 
			str="건과일";
			break;
		case "203" : 
			str="바나나,파인애플,키위";
			break;
			
		case "301" : 
			str="쌀";
			break;
		case "302" : 
			str="잡곡";
			break;
		case "303" : 
			str="가루";
			break;
			
		case "401" : 
			str="소고기";
			break;
		case "402" : 
			str="돼지고기";
			break;
		case "403" : 
			str="닭,오리";
			break;
		case "404" : 
			str="가공육";
			break;
		case "405" : 
			str="계란,알류";
			break;
			
		case "501" : 
			str="생선류";
			break;
		case "502" : 
			str="오징어,낙지";
			break;
		case "503" : 
			str="새우,게";
			break;
		case "504" : 
			str="건어물";
			break;
		case "505" : 
			str="해조류";
			break;
	}
%>
[<%=str%>]