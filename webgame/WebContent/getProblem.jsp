<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="common.jsp" %>
<%!
	String SQL 		= "SELECT * FROM prob LEFT JOIN (SELECT prob_no, count(*) as NumSolvedMember FROM (SELECT * FROM solve) AS solved_sub) AS solved ON prob.no = solved.prob_no";
	String FILE		= "getNotice.jsp\t";
	
%>
<%
	String isManaging= request.getParameter("isManaging");
	String isAdmin = (String)session.getAttribute("isAdmin");
	
	
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
	try {
		Statement stmt =  con.createStatement();
		ResultSet rs = stmt.executeQuery(SQL);
		JSONArray jArray = new JSONArray();
		
		if( isManaging == "1" && isAdmin == "T" ) {
			
			while( rs.next() ) {
				
				JSONObject jObject = new JSONObject();
				jObject.put("no", rs.getString("no"));
				jObject.put("title", rs.getString("title"));				
				jObject.put("score", rs.getString("score"));
				jObject.put("type", rs.getString("prob_type"));
				jObject.put("key", rs.getString("auth_key"));
				jObject.put("numSolved", rs.getString("NumSolvedMember"));
				jArray.add( jObject );
			}
	
		} else {
			
			while( rs.next() ) {
				
				JSONObject jObject = new JSONObject();
				jObject.put("no", rs.getString("no"));
				jObject.put("title", rs.getString("title"));				
				jObject.put("score", rs.getString("score"));
				jObject.put("type", rs.getString("prob_type"));
				jArray.add( jObject );
				
			}
		
		}
		
		jResultObject.put("probList", jArray);
		
	} catch(SQLException e) {
		
		out.print(FILE + "Query error: " + e.getMessage());
		return ;
	} catch(Exception e) {
		out.print(FILE + "JSON creation error: " + e.getMessage());
		return ;
	}	
	
	out.print(jResultObject.toJSONString());
%>