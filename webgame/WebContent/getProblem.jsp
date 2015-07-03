<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="common.jsp" %>
<%!
	String SQL 		= "SELECT title, score, content FROM prob where no=?";
	
	String FILE		= "getProblem.jsp\t";
	
%>
<%
	int no;
	//getProblem.js 에서 보낸 문제 번호 받기
	try {
		// Check the no is number
		no = Integer.parseInt(request.getParameter("no"));
	} catch (NumberFormatException e) {
		JSONObject jResultObject = new JSONObject();
		jResultObject.put("result", "false");
		out.print(jResultObject.toJSONString());
		return ;
	}

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
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		
		pstmt =  con.prepareStatement(SQL);
		pstmt.setInt(1,no);
		rs = pstmt.executeQuery();

		JSONArray jArray = new JSONArray();
		
		while( rs.next() ) {
			JSONObject jObject = new JSONObject();
			jObject.put("title", rs.getString("title"));
			jObject.put("score", rs.getString("score"));
			jObject.put("content", rs.getString("content"));
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