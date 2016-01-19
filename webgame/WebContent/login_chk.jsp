<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="common.jsp" %>
<%@ page import="java.security.MessageDigest" %>
<%!
	String SQL 		= "SELECT *FROM member WHERE id=? and pw=?";
	
	String FILE		= "login_chk.jsp\t";
	
%>
<%
	// 입력한 아이디와 패스워드를 받은 후, 패스워드 md5
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	String chk_admin = "N";
	String chk_join = "N";
	
	int no = -1;
	
	byte[] digest = MessageDigest.getInstance("MD5").digest(pw.getBytes());

	StringBuffer buffer = new StringBuffer();
	
	for(int i =0; i<digest.length; i++){
		if(((int)digest[i]&0xff)<0x10)
			buffer.append("0");
		
		buffer.append(Long.toString((int)digest[i]&0xff, 16));
	}
	
	pw = buffer.toString();
	
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
	
	try {
		
		pstmt =  con.prepareStatement(SQL);
		pstmt.setString(1,id);
		pstmt.setString(2,pw);
		rs = pstmt.executeQuery();

		while(rs.next()) {
			chk = chk+1;
			chk_admin = rs.getString("chk_admin");
			chk_join = rs.getString("chk_join");
			no = rs.getInt("no");
		}
		
		//if(chk>0 && chk_join=="T"){
		if(chk>0){
			session.setAttribute("sessionId", id);
			session.setAttribute("no", no);
			session.setAttribute("chk_admin", chk_admin);
			session.setAttribute("chk_join", chk_join);
			
			//out.println("로그인 가능");
			
			if(chk_join == "N") {
			%>
				<script>
					alert("가입 대기중입니다."); 
					history.back();
				</script>
			<%
			} else {
				%>
				<script>
					location.replace("index.jsp");
				</script>
			<%
			}
		}
		else {
		%>
			<script>
				alert("아이디 혹은 비밀번호를 확인해주세요"); 
				history.back();
			</script>
		<%
		}
		
		
	} catch(SQLException e) {
		log(FILE + "Query error: " + e.getMessage());
		return ;
	}
%>