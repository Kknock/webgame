<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ include file="../common.jsp" %>
<%!
	String SQL 		= "INSERT INTO notice(save_time, content) VALUES(now(), ?)";
	String FILE		= "setNotice.jsp\t";
%>
<%
	request.setCharacterEncoding("UTF-8");
	String content = request.getParameter("content");
	
	// Check is content null or empty
	if(  content == null || (content=content.trim()) == "" ) {
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
	
	// insert notices to DB connection
	JSONObject jResultObject = new JSONObject();
	try {
		PreparedStatement pstmt;
		pstmt = con.prepareStatement(SQL);
		pstmt.setString(1, content);
		pstmt.executeUpdate();
		jResultObject.put("result", "true");
		pstmt.close();
		con.close();
	} catch(SQLException e) {
		log(FILE + "Query error: " + e.getMessage());
		jResultObject.put("result", "false");
		return ;
	} catch(Exception e) {
		log(FILE + "JSON creation error: " + e.getMessage());
		jResultObject.put("result", "false");
		return ;
	}
	
	out.print(jResultObject.toJSONString());
%>