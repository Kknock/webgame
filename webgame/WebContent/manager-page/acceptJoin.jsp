<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ include file="../common.jsp" %>
<%!
	String SQL 		= "UPDATE member SET chk_join='T' WHERE no=?";
	String FILE		= "acceptJoin.jsp\t";
%>
<%
	request.setCharacterEncoding("UTF-8");
	int no = -1;
	
	try {
		// Check the no is number
		no = Integer.parseInt( request.getParameter("no") );
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
	
	// insert notices to DB connection
	JSONObject jResultObject = new JSONObject();
	try {
		PreparedStatement pstmt;
		pstmt = con.prepareStatement(SQL);
		pstmt.setInt(1, no);
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