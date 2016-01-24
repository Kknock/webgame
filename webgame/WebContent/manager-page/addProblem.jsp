<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="../common.jsp" %>
<%@ page import="java.security.MessageDigest" %>
<%!
	String SQL		= "INSERT INTO prob(title, content, auth_key, score, prob_type) VALUES(?, ?, ?, ?, ?);";
	String SQL_TIT 	= "SELECT no FROM prob WHERE title=?";
	String SQL_KEY	= "SELECT no FROM prob WHERE auth_key=?";
	String FILE		= "addProblem.jsp\t";
	
%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String key = request.getParameter("key");
	int score = Integer.parseInt(request.getParameter("score"));
	String prob_type = request.getParameter("type");
		
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
	int chk_title = 0;
	int chk_key = 0;
		
	
	JSONObject jResultObject = new JSONObject();
	try {
		
		pstmt = con.prepareStatement(SQL_TIT);
		pstmt.setString(1,title);
		rs = pstmt.executeQuery();
		
		while(rs.next())
			chk_title = rs.getInt("no");
		
		pstmt = con.prepareStatement(SQL_KEY);
		pstmt.setString(1,key);
		rs = pstmt.executeQuery();
		
		while(rs.next())
			chk_key = rs.getInt("no");
		
		if(chk_title != 0 && chk_key != 0){
		%>
			<script>
			alert("동일한 제목과 키값이 존재합니다.");
			history.back();
			</script>
		<%
		}
		else if(chk_title != 0){%>
			<script>
			alert("동일한 제목이 존재합니다.");
			history.back();
			</script>
		<%	
		}
		else if(chk_key != 0){%>
			<script>
			alert("동일한 키값이 존재합니다.");
			history.back();
			</script>
		<%	
		}
		else{
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, key);
			pstmt.setInt(4, score);
			pstmt.setString(5,prob_type);
			pstmt.executeUpdate();
		%>
			<script>
			alert("문제 추가 완료");
			location.href="index.jsp";
			</script>
		<%
		}
		
	} catch(SQLException e) {
		log(FILE + "Query error: " + e.getMessage());
		return ;
	}
	
	out.print(jResultObject.toJSONString());
	
%>