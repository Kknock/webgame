<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="common.jsp" %>
<%@ page import="java.security.MessageDigest" %>
<%!
	String SQL 		= "SELECT * FROM prob WHERE auth_key=?";	
	String SQL2		= "INSERT INTO solve(solve_time, mem_no, prob_no) VALUES(now(), ?, ?)";
	String MEM_SCORE	= "SELECT score FROM member WHERE no=?";
	String PROB_SCORE	= "SELECT score FROM prob WHERE no=?";
	String SOLVE_TIME	= "SELECT solve_time FROM solve WHERE mem_no=? AND prob_no=?";
	String UPDATE		= "UPDATE member SET score=?, last_auth=? where no=?";
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
	int prob_score = 0;
	int mem_score = 0;
	int total_score = 0;
	String solve_time = "";
	
	JSONObject jResultObject = new JSONObject();
	
	
	// 받아온 키값에 해당하는 문제 번호와 문제 제목, 로그인한 회원 번호를 변수에 저장
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
			
			// 맞는 키값일 경우 solve 테이블에 업데이트
			PreparedStatement pstmt2;
			pstmt2 = con.prepareStatement(SQL2);
			pstmt2.setInt(1, mem_no);
			pstmt2.setInt(2, prob_no);
			v = pstmt2.executeUpdate();
			
			// 로그인한 회원의 현재 점수를 받아옴
			PreparedStatement pstmt3;
			pstmt3 = con.prepareStatement(MEM_SCORE);
			pstmt3.setInt(1,mem_no);
			rs = pstmt3.executeQuery();
			while(rs.next())
				mem_score = rs.getInt("score");
			
			// 인증한 문제의 점수를 가져옴
			PreparedStatement pstmt4;
			pstmt4 = con.prepareStatement(PROB_SCORE);
			pstmt4.setInt(1,prob_no);
			rs = pstmt4.executeQuery();
			while(rs.next())
				prob_score = rs.getInt("score");
			
			// 현재 점수와 인증한 문제의 점수를 더함
			total_score = mem_score + prob_score;
			
			// 문제 인증 시간을 가져옴
			PreparedStatement pstmt5;
			pstmt5 = con.prepareStatement(SOLVE_TIME);
			pstmt5.setInt(1,mem_no);
			pstmt5.setInt(2,prob_no);
			rs = pstmt5.executeQuery();
			while(rs.next())
				solve_time = rs.getString("solve_time");
			
			// 합쳐진 점수와 문제 인증 시간을 member 테이블에 갱신
			PreparedStatement pstmt6;
			pstmt6 = con.prepareStatement(UPDATE);
			pstmt6.setInt(1,total_score);
			pstmt6.setString(2,solve_time);
			pstmt6.setInt(3,mem_no);
			v = pstmt6.executeUpdate();
			System.out.println(v);
			
			if(v == 1) {
				// 정답을 맞춤
				jResultObject.put("result", "true");
				jResultObject.put("msg", "Congraturation! you have gotten " + title);
			}
			
		} else {
			// 틀림
			jResultObject.put("result", "false");
			jResultObject.put("msg", "Worng :(");
		}
		
		
	} catch(SQLException e) {
		// 이미 인증된 키값 인증시 예외처리
		if(e.getErrorCode()==1062){
			jResultObject.put("result", "false");
			jResultObject.put("msg", "Congraturation! but you got " + title + " already");
			out.print(jResultObject.toJSONString());
		}
		else
			log(FILE + "Query error: " + e.getMessage());
		return ;
	}
	
	out.print(jResultObject.toJSONString());
	
%>