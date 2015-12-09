<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="common.jsp" %>
<%@ page import="java.security.MessageDigest" %>
<%!
	String SQL 		= "SELECT no FROM prob order by desc;";	
	String SQL2		= "INSERT INTO prob(no, title, content, score, auth_key, file) VALUES(?, ?, ?, ?, ?);";
	String FILE		= "addProblem.jsp\t";
	
%>
<%
	request.setCharacterEncoding("UTF-8");
	int no = 0;
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int score = Integer.parseInt(request.getParameter("score"));
	String key = request.getParameter("key");
	
	String chk_admin = "Y";
	
	// get notices from DB connection
	Connection con = null;
	try {
		Class.forName(dbDriver);
		con = DriverManager.getConnection(jdbcURL,dbID,dbPW);
	} catch(SQLException e) {
		log(FILE + "Connection error: " + e.getMessage());
		return ;
	}
	
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	int chk = 0;
	int v;
		
	
	JSONObject jResultObject = new JSONObject();
	try {
		
		pstmt2 = con.prepareStatement(SQL);
		rs = pstmt2.executeQuery();
		no = rs.getInt("no")+1;
		rs = null;
		pstmt = con.prepareStatement(SQL2);
		pstmt.setInt(1, no);
		pstmt.setString(2, title);
		pstmt.setString(3, content);
		pstmt.setInt(4, score);
		pstmt.setString(5, key);
		//pstmt.setString(6, file);
		pstmt.executeUpdate();
		
		
	} catch(SQLException e) {
		log(FILE + "Query error: " + e.getMessage());
		return ;
	}
	
	out.print(jResultObject.toJSONString());
	
%>