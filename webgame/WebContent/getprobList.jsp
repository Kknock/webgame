<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ page import="java.sql.*" %> 
<%@ page import="org.json.simple.*"%> 
<%@ include file="common.jsp" %> 
<%! 
	String SQL 		= "SELECT no, title, score FROM prob WHERE prob_type=?";
	String SOLVE	= "SELECT prob_no FROM solve WHERE mem_no=(SELECT no FROM member WHERE id=?)";
	String FILE		= "getprobList.jsp\t"; 
	 
%> 
 <% 
 	 
 	String prob_type = "";
 	String session_id = "";
	String solve_chk = "";
	int prob_no = 0;
	int solve_no = 0;
	
 	//getprobList.js 에서 보낸 문제 유형과 세션아이디 받기 
 	try { 
 		// Check the no is number 
 		prob_type = request.getParameter("prob_type");
 		session_id = request.getParameter("sessionId");
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
 	 
 	// get notices from DB connection 
 	JSONObject jResultObject = new JSONObject(); 
 	PreparedStatement pstmt = null; 
 	PreparedStatement pstmt2 = null;
 	ResultSet rs = null; 
 	ResultSet rs2 = null;
 	 
 	try { 
 		 
 		pstmt =  con.prepareStatement(SQL); 
 		pstmt.setString(1,prob_type); 
 		rs = pstmt.executeQuery();
 		
 		// 세션 아이디가 푼 문제번호 가져옴
 		pstmt2 = con.prepareStatement(SOLVE);
 		pstmt2.setString(1,session_id);
 		rs2 = pstmt2.executeQuery();
  
 		JSONArray jArray = new JSONArray(); 
 		 
 		while( rs.next() ) { 
 			JSONObject jObject = new JSONObject();
 			prob_no = rs.getInt("no");
 			solve_chk="T";
 						
 			// 문제 번호가 푼 문제 번호와 같으면 F
 			while( rs2.next() ){
 				solve_no = rs2.getInt("prob_no");
 				if(solve_no == prob_no){
 					solve_chk="F";
 					break;
 				}
 			}
 			
 			rs2.first();
			
 			jObject.put("no", prob_no);
 			jObject.put("solve_chk", solve_chk);
 			jObject.put("title", rs.getString("title")); 
 			jObject.put("score", rs.getInt("score")); 
 			jArray.add(jObject); 
 		} 
 		jResultObject.put("probList", jArray); 
 	} catch(SQLException e) { 
 		log(FILE + "Query error: " + e.getMessage()); 
 		return ; 
 	} catch(Exception e) { 
 		log(FILE + "JSON creation error: " + e.getMessage()); 
 		return ; 
 	} 
 	 
 	out.print(jResultObject.toJSONString()); 
%> 
