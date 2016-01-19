<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
	// 인증 못하면 광탈하는걸로
	String sessionId = (String)session.getAttribute("sessionId");
	String chk_admin = (String)session.getAttribute("chk_admin");

	boolean isLogin = false;
	boolean isAdmin = false;
	
	if( sessionId != null && !sessionId.equals("") ) {
		isLogin = true;
	}
	if( chk_admin != null && chk_admin.equals("T") ) {
		isAdmin = true;
	}

	if(!isAdmin){%>
		<script> 
		alert("친구~ 여기 구경하고 싶으면 관리자 형아 데려오세요~") 
		location.href="../index.jsp";
		</script>		
<%	}
%>

<div class="row">
	<div class="col-lg-12">
		<!--h1 class="page-header">공지사항</h1-->
		</p> </p>
		<!-- /.panel -->
		<div class="chat-panel panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>
				공지사항
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul id="noticePanel" class="chat">
				</ul>
			</div>
			<!-- /.panel-body -->
			<div class="panel-footer">
				<div class="input-group">
					<input id="btn-input" type="text" maxlength="100" class="form-control input-sm" placeholder="Type new notice here." />
					<span class="input-group-btn">
						<button class="btn btn-warning btn-sm" id="btn-notice">
							등록
						</button>
					</span>
				</div>
			</div>
			<!-- /.panel-footer -->
		</div>
		<!-- /.panel .chat-panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<script>

	function init(){
	
		$.getJSON('../getNotice.jsp', function(data, status) {
			
			for( idx in data.noticeList ) {
				var no 			= data.noticeList[idx].no;
				var content 	= data.noticeList[idx].content;
				var timestamp 	= data.noticeList[idx].timestamp;
				$("#noticePanel").append( makeNoticeFormat(no, timestamp, content) );
			}
			//$(".chat-panel .panel-body").scrollTop(0);
			//$(document).scrollTop($(".chat-panel .panel-body").offset().top);
			
		}).fail(function(d, status, error) {
			console.error("getJSON failed, status: " + status + ", error: "+error)
			var con = '<dd class="Gothic FontLarge"><b>서버</b>와의 연결에 실패하였습니다.</dd>';
			$('#content').append(con);
		});	
		
		// 공지사항 등록버튼  이벤트 등록
		document.getElementById("btn-notice").addEventListener("click", function(e) {
			requestSetNotice( $("#btn-input").val() );
		}, false);
		
		$(document).ready(function() {
			$(".chat-panel .panel-body").animate({scrollTop: 0}, 100); //100ms for example
		});
	}
	
	function makeNoticeFormat(no, time, content) {
		var format = '<li class="right clearfix">' + 
						'<div class="chat-body clearfix">' + 
							'<div class="header">' +
								'<small class=" text-muted">' + 
								'<i class="fa fa-clock-o fa-fw"></i> ' + time + '</small>' + 
							'</div>' +
							'<p>' + 
								content +
							'</p>' + 
						'</div>' +
					'</li>';
		return format;
	}
	
	function requestSetNotice(_content) {
		
		// 서버에 등록 요청
		var requestData = {content:_content};
		$.getJSON('setNotice.jsp', requestData, function(data, status) {
			if( data.result == "true" ) {
				window.location.reload();
				return true;
			} else {
				alert("등록에 실패하였습니다.");
			}
			
		}).fail(function() {
			alert("죄송합니다 서버로의 연결에 실패하였습니다.");
			return false;
		});
	
		return false;
		
	}

</script>