<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="common.jsp" %>
<%@ page import="java.security.MessageDigest" %>
<%!
	//String SQL 		= "SELECT no FROM prob order by no desc;";	
	//String SQL2		= "INSERT INTO prob(title, content, auth_key, score, prob_type) VALUES(?, ?, ?, ?, ?);";
	String SQL2		= "UPDATE prob SET title=?, content=?, auth_key=?, score=?, prob_type=? WHERE no=?";
	String FILE		= "addProblem.jsp\t";
	
%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String key = request.getParameter("key");
	int score = Integer.parseInt(request.getParameter("score"));
	String prob_type = request.getParameter("type");
	
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
		
		pstmt = con.prepareStatement(SQL2);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, key);
		pstmt.setInt(4, score);
		pstmt.setString(5,prob_type);
		pstmt.setString(6,no);
		pstmt.executeUpdate();
		
		
	} catch(SQLException e) {
		log(FILE + "Query error: " + e.getMessage());
		return ;
	}
%>
	<script>
		alert("문제 수정 완료");
		location.href="manager-page/index.jsp#probList";
	</script>
<%	
	out.print(jResultObject.toJSONString());
	
%>