<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="../common.jsp" %>
<%!
	// log와 정답을 맞추었는지 결과를 가져온다.
	// 서브쿼리 내에서 교차 조인을 하기 때문에 성능상 큰 하자가 있음.
	// 코딩 문제에서 소스코드를 이용한 인증 시 로그에 관한 에러사항이 발생할 수 있고, 정답 유무의 효율적인 파악을 위해 log 테이블의 역정규화 필요성이 있을수도 있음.
	//String SQL 		= "SELECT id, auth, time, result from member, (SELECT mem_no, time, auth, auth=prob.auth_key as result FROM log, prob) as sub where member.no = sub.mem_no ORDER BY time DESC LIMIT 100";
	String SQL		= "SELECT member.name, log.auth, log.time FROM log INNER JOIN member ON log.mem_no = member.no";
	String FILE		= "getLog.jsp\t";
	
%>
<%
	
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
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		while( rs.next() ) {
			JSONObject jObject = new JSONObject();
			jObject.put("name", rs.getString("member.name"));
			jObject.put("auth", rs.getString("log.auth"));
			//jObject.put("result", rs.getString("result"));
			jObject.put("time", sdf.format(rs.getTimestamp("log.time")));
			jArray.add(jObject);
		}
		jResultObject.put("logList", jArray);
	} catch(SQLException e) {
		log(FILE + "Query error: " + e.getMessage());
		return ;
	} catch(Exception e) {
		log(FILE + "JSON creation error: " + e.getMessage());
		return ;
	}
	
	out.print(jResultObject.toJSONString());
%>