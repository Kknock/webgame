<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	// 인증 못하면 광탈하는걸로
%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Dashboard</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- 수치 패널  -->
<div class="row">
	<div class="col-lg-4 col-md-2">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<div class="row">
					<div class="col-xs-3">
						<i class="fa fa-users fa-5x"></i>
					</div>
					<div class="col-xs-9 text-right">
						<div id="userHuge" class="huge">1024</div>
						<div>회원 수</div>
					</div>
				</div>
			</div>
			<a href="#oldUsers">
				<div class="panel-footer">
					<span class="pull-left">View Details</span>
					<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
					<div class="clearfix"></div>
				</div>
			</a>
		</div>
	</div>
	<div class="col-lg-4 col-md-2">
		<div class="panel panel-green">
			<div class="panel-heading">
				<div class="row">
					<div class="col-xs-3">
						<i class="fa fa-user-plus fa-5x"></i>
					</div>
					<div class="col-xs-9 text-right">
						<div id="joinHuge" class="huge">2^10</div>
						<div>가입 신청자</div>
					</div>
				</div>
			</div>
			<a href="#newUsers">
				<div class="panel-footer">
					<span class="pull-left">View Details</span>
					<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
					<div class="clearfix"></div>
				</div>
			</a>
		</div>
	</div>
</div>
<!-- /.row -->

<!-- Vertical timeline pannel -->
<div class="row">
	<div class="col-lg-8">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-clock-o fa-fw"></i> Responsive Timeline / 우측은 빠르게 읽고 넘어갈 내용, 좌측은 주의깊게 봐야 할 내용을 배치하자.
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul id="timeline" class="timeline">

				</ul>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-8 -->
</div>
<!-- /.row -->


<!-- 
 --		인증 실패 			- non badge
 --		인증 성공 			- success(green), fa-check
 --		의심되는 인증 결과 	- red, fa-bomb
 --		신규 가입			- info(blue), fa-user-plus
 --		
 -->	
<script>

	function init() {
		$.getJSON('getLog.jsp', function(data, status) {

			for( idx in data.logList ) {
				var id 		= data.logList[idx].id;
				var auth	= data.logList[idx].auth;
				var result	= data.logList[idx].result;
				var time 	= data.logList[idx].time;
				
				$("#timeline").append(
						makeTimelineFormat(id, auth, result, time));
			}			
		
			
		}).fail(function(d, status, error) {
			console.error("getJSON failed, status: " + status + ", error: "+error)
			alert('서버와의 연결에 실패하였습니다.');
		});
		
		
		
		//	상단 유저수, 가입신청자 수 수치를 갱신한다. 데이터베이스에서 가져온 목록의 length를 이용한다. 
		//   -> 서버, 클라이언트 양측에 overhead가 심하기 때문에 따로 수치를 가져오는 페이지를 작성해야 할 듯.
		$.getJSON('../getUserList.jsp', function(data, status) {
			$('#userHuge').text(data.userList.length); 
		}).fail(function(d, status, error) {
			console.error("getJSON failed, status: " + status + ", error: "+error)
			alert('서버와의 연결에 실패하였습니다.');
		});
		
		$.getJSON('../getJoinRequest.jsp', function(data, status) {
			$('#joinHuge').text(data.joinList.length); 
		}).fail(function(d, status, error) {
			console.error("getJSON failed, status: " + status + ", error: "+error)
			alert('서버와의 연결에 실패하였습니다.');
		});
	}

	function makeTimelineFormat(id, auth, result, time) {
		
		if( result == "1") {
			var format = '<li class="timeline-inverted"><div class="timeline-badge success"><i class="fa fa-check"></i></div>'; 
		} else {
			var format = '<li class="timeline-inverted">';
		}
		
		format = format + '<div class="timeline-panel"><div class="timeline-heading">' + 
				'<h4 class="timeline-title"><i>' + id + '</i> attempted to <i>"' + auth + '"</i</h4></div>' +
				'<div class="timeline-body"><p><i class="fa fa-clock-o fa-fw"></i>' + time +'</p></div>' +
				'</div></li>';
		
		return format;
	}


</script>