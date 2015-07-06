<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="common.jsp" %>
<%@ page import="java.security.MessageDigest" %>
<%!
	String SQL_chk 		= "SELECT *FROM member WHERE id=? or name=?";
	String SQL_join			= "INSERT INTO member(id,name,pw) VALUES(?,?,md5(?))";
	String FILE		= "contact_chk.jsp\t";
	
%>
<%
	//입력한 아이디, 닉네임, 패스워드 받음
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	String pw_chk = request.getParameter("pw_chk");
		
	Connection con = null;
	try {
		Class.forName(dbDriver);
		con = DriverManager.getConnection(jdbcURL,dbID,dbPW);
	} catch(SQLException e) {
		log(FILE + "Connection error: " + e.getMessage());
		return ;
	}
	
	if(id.equals("")){
%>
		<script>
			alert("아이디를 입력해주세요.");
			location.href="index.html";
		</script>	
<%	}
	else if(name.equals("")){
%>
		<script>
			alert("닉네임을 입력해주세요");
			location.href="index.html";
		</script>
<%
	}
	else if(pw.equals("")){
%>
		<script>
			alert("패스워드를 입력해주세요");
			location.href="index.html";
		</script>
<%
	}
	else if(pw_chk.equals("")){
%>
		<script>
			alert("패스워드를 입력해주세요");
			location.href="index.html";
		</script>
<%
	}
	else{	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int chk = 0;
	
		try {
		
			pstmt =  con.prepareStatement(SQL_chk);
			pstmt.setString(1,id);
			pstmt.setString(2,name);
			rs = pstmt.executeQuery();
	
			while(rs.next())
				chk = chk+1;
			
			if(chk==0){
				if(pw.equals(pw_chk)){
				//out.println("회원가입 완료");
				pstmt = con.prepareStatement(SQL_join);
				pstmt.setString(1,id);
				pstmt.setString(2,name);
				pstmt.setString(3,pw);
				pstmt.executeUpdate();
%>
				<script>
					alert("회원가입 완료");
					//location.href="index.html";
					location.href="index.html";
				</script>
<%				}
				else{
%>
				<script>
					alert("입력한 두 패스워드가 일치하지 않습니다.");
					location.href="index.html";
				</script>
<%				}
			}
			else{
%>
				<script>
					alert("이미 존재하는 아이디 또는 닉네임 입니다.");
					location.href="index.html";
				</script>
<%			}
		
		} catch(SQLException e) {
			log(FILE + "Query error: " + e.getMessage());
			return ;
		}
	}
%>