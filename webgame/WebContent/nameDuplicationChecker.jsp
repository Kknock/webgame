<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="common.jsp" %>
<%!
	String SQL 		= "SELECT count(*) FROM member WHERE name=?";
	String FILE		= "duplicationChecker.jsp\t";
%>
<%
	// 입력한 아이디와 패스워드를 받은 후, 패스워드 md5
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	
	// Referer 검증해야함
	//
	//
	//
	//
	
	int no = -1;
	
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
	ResultSet rs = null;
	
	try {
		
		pstmt =  con.prepareStatement(SQL);
		pstmt.setString(1,name);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			no = rs.getInt("count(*)");
		}
		
		if(no > 0) {
			out.print("true");
		} else {
			out.print("false");
		}
			
	} catch(SQLException e) {
		out.println("false");
		log(FILE + "Query error: " + e.getMessage());
		return ;
	}
%>