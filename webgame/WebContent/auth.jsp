<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="common.jsp" %>
<%@ page import="java.security.MessageDigest" %>
<%!
	String SQL 		= "SELECT * FROM prob WHERE auth_key=?";	
	String SQL2		= "INSERT INTO solve(solve_time, mem_no, prob_no) VALUES(now(), ?, ?)";
	String SQL_LOG	= "INSERT INTO log(time, mem_no, auth) VALUES(now(), ?, ?)";
	String FILE		= "auth.jsp\t";
	
%>
<%
	request.setCharacterEncoding("UTF-8");
	String key = request.getParameter("key");
	
	String chk_admin = "N";
	
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
	int chk = 0;
	int v;
	
	String title = "";
	int prob_no = -1;
	int mem_no = -1;
	
	
	JSONObject jResultObject = new JSONObject();
	try {
		
		pstmt =  con.prepareStatement(SQL);
		pstmt.setString(1, key);
		rs = pstmt.executeQuery();

		while(rs.next()) {
			chk = chk+1;
			prob_no = rs.getInt("no");
			mem_no = (int)session.getAttribute("no");
			title = rs.getString("title");
		}
		
		
		if(chk > 0) {
			
			PreparedStatement pstmt2, pstmt3;
			pstmt2 = con.prepareStatement(SQL2);
			pstmt2.setInt(1, mem_no);
			pstmt2.setInt(2, prob_no);
			v = pstmt2.executeUpdate();
			
			if(v > 0) {
				// 정답을 맞춤
				jResultObject.put("result", "true");
				jResultObject.put("msg", "Congraturation! you have gotten " + title);
			} else {
				// 이미 풀었었음
				jResultObject.put("result", "false");
				jResultObject.put("msg", "Congraturation! but you got " + title + " aleady");
			}
			
		} else {
			// 틀림
			jResultObject.put("result", "false");
			jResultObject.put("msg", "Worng :(");
		}
		
		
	} catch(SQLException e) {
		log(FILE + "Query error: " + e.getMessage());
		return ;
	}
	
	out.print(jResultObject.toJSONString());
	
%>