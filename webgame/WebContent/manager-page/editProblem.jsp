<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="../common.jsp" %>
<%@ page import="java.security.MessageDigest" %>
<%!
	//String SQL 		= "SELECT no FROM prob order by no desc;";	
	//String SQL2		= "INSERT INTO prob(title, content, auth_key, score, prob_type) VALUES(?, ?, ?, ?, ?);";
	String SQL			= "UPDATE prob SET title=?, content=?, auth_key=?, score=?, prob_type=? WHERE no=?";
	String SQL_TIT 		= "SELECT no FROM prob WHERE title=?";
	String SQL_KEY		= "SELECT no FROM prob WHERE auth_key=?";
	String FILE		= "addProblem.jsp\t";
	
%>
<%
	request.setCharacterEncoding("UTF-8");
	int no = Integer.parseInt(request.getParameter("no"));
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
		
		// 제목이나 키값 중 하나라도 수정하지 않고 요청하면 이미 있는 값으로 처리하기 떄문에 문제번호를 비교하여 다른 문제와 중복되는 건지 확인
		if(chk_title != 0 && chk_title != no && chk_key != 0 && chk_key != no){
		%>
			<script>
			alert("동일한 제목과 키값이 존재합니다.");
			history.back();
			</script>
		<%
		}
		else if(chk_title != 0 && chk_title != no){%>
			<script>
			alert("동일한 제목이 존재합니다.");
			history.back();
			</script>
		<%	
		}
		else if(chk_key != 0 && chk_key != no){%>
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
			pstmt.setInt(6,no);
			pstmt.executeUpdate();
		%>
			<script>
			alert("문제 수정 완료");
			location.href="index.jsp#probList";
			</script>
		<%
		}
	} catch(SQLException e) {
		log(FILE + "Query error: " + e.getMessage());
		return ;
	}

	out.print(jResultObject.toJSONString());
	
%>