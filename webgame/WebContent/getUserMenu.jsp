<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.json.simple.*"%>
<%! 
	
	JSONObject jNewMenu(String menu, String url) {
		
		JSONObject jObject = new JSONObject();
			jObject.put("menu", menu);
			jObject.put("url", url);
			
		return jObject;
	}
	
%>
<%
	
	// 로그인 하지 않았을 경우 Zero length data를 반환한다.
	if ((String)session.getAttribute("id") == null) {
		out.print(new JSONObject().toJSONString());	
		return ;
	}	
	
	String isAdmin = (String)session.getAttribute("isAdmin");
	JSONObject jResultObject = new JSONObject();
	JSONArray jArray = new JSONArray();
	

 	// JAVA 7 이전버전에선 문자열에 대한 switch - case를 지원하지 않기에 동작하지 않는다. 
 	switch( isAdmin ) {
 		case "T":
  			jArray.add(jNewMenu("관리자 페이지", "manage.jsp"));
 		case "F":
 		default :
 			jArray.add(jNewMenu("회원정보 변경", "http://www.kknock.org"));
 	}
	// 회원명과 메뉴 리스트 반환.
 	jResultObject.put("name", (String)session.getAttribute("name"));	
 	jResultObject.put("menuList", jArray);
	
	
	out.print(jResultObject.toJSONString());
%>