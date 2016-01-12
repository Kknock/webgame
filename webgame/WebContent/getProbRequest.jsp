<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="common.jsp" %>
<%! 
	String SQL 		= " Select no, title, content, prob_type, score, auth_key FROM prob ";
	
	String FILE		= "getProbRequest.jsp\t";
%>
<%
	
	// Connect to database by jdbc
	Connection con = null;
	try {
		Class.forName(dbDriver);
		con = DriverManager.getConnection(jdbcURL,dbID,dbPW);
	} catch(SQLException e) {
		log(FILE + "Connection error: " + e.getMessage());
		return ;
	}
	
	// get notices from DB connection
	JSONObject jResultObject = new JSONObject();
	try {
		Statement stmt =  con.createStatement();
		ResultSet rs = stmt.executeQuery(SQL);
		JSONArray jArray = new JSONArray();
		while( rs.next() ) {
			JSONObject jObject = new JSONObject();
			jObject.put("no", rs.getString("no"));
			jObject.put("title", rs.getString("title"));
			jObject.put("content", rs.getString("content"));
			jObject.put("prob_type", rs.getString("prob_type"));
			jObject.put("score", rs.getString("score"));
			jObject.put("auth_key", rs.getString("auth_key"));
			jArray.add(jObject);
		}
		jResultObject.put("probList", jArray);
	} catch(SQLException e) {
		log(FILE + "Query error: " + e.getMessage());
		return ;
	} catch(Exception e) {
		log(FILE + "JSON creation error: " + e.getMessage());
		return ;
	}
	
	out.print(jResultObject.toJSONString());

%>