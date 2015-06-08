<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	// 인증 못하면 광탈하는걸로
%>

<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		</p> </p>
		<div class="panel panel-default">
			<div class="panel-heading">
				다음과 같은 가입 신청이 있습니다.
				<ul class="nav" style="float:right !important">
					<li>
						<a style="padding:0px">모두 수락</a>
					</li>
				</ul>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="dataTable_wrapper">
					<table class="table table-striped table-bordered table-hover" id="dataTable">
						<!-- thead>
							<tr>
								<th>#</th>
								<th>아이디</th>
								<th>닉네임</th>
								<th>해결한 문제</th>
								<th>마지막 인증</th>
							</tr>
						</thead>
						<tbody>

						</tbody-->
					</table>
				</div>
				<!-- /.table-responsive -->
				<!-- div class="well">
					<h4>DataTables Usage Information</h4>
					<p>DataTables is a very flexible, advanced tables plugin for jQuery. In SB Admin, we are using a specialized version of DataTables built for Bootstrap 3. We have also customized the table headings to use Font Awesome icons in place of images. For complete documentation on DataTables, visit their website at <a target="_blank" href="https://datatables.net/">https://datatables.net/</a>.</p>
					<a class="btn btn-default btn-lg btn-block" target="_blank" href="https://datatables.net/">View DataTables Documentation</a>
				</div-->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->


<!-- 우클릭시 사용되는 ContextMenu  -->
<nav id="context-menu" class="context-menu">
	<ul class="context-menu__items">
		<li class="context-menu__item">
			<a href="#" class="context-menu__link" data-action="Accept"><i class="fa  fa-check"></i> Accept</a>
		</li>
		<li class="context-menu__item">
			<a href="#" class="context-menu__link" data-action="Decline"><i class="fa fa-close"></i> Decline</a>
		</li>
	</ul>
</nav>

<script>

	function init() {
		$.getJSON('../getJoinRequest.jsp', function(data, status) {
			/*
			 *	서버로부터 유저 데이터를 가져와 dataSet을 작성한다.
			*	가져오는 값은 다음과 같다. 회원번호, 아이디, 이름, 해결한 문제 수, 마지막 인증 시간.
			*/
			dataSet = []; 
			for( idx in data.joinList ) {
				var no 		= data.joinList[idx].no;
				var id 		= data.joinList[idx].id;
				var name	= data.joinList[idx].name;
				dataSet.push( [no, id, name] );
			}			
			
			/*
			 *	dataSet을 이용해 DataTable을 작성한다.
			 *	"data" 속성의 값은 [ [td, td, td, ...], [td, td, td, ...], ... ] 형식이다. 
			*	"columns" 속성에서는 thead 값과, 그 속성을 결정한다.
			*/
			$('#dataTable').dataTable( {
		        "data": dataSet,
		        "columns": [
		            { "title": "#" },
		            { "title": "아이디" },
		            { "title": "닉네임"},
		        ]
		    });
			
			var rows = $('#dataTable').dataTable().api().rows().nodes();
			// for( idx in rows ) 형태로 변경하면 rows length는 3이나 그 이상 넘어가버리는 버그 있음.
			for( idx=0; idx<rows.length; idx++) {
				$(rows[idx]).addClass("task").attr("data-id", $(rows[idx]).children().first().text() );
			}
		
			
		}).fail(function(d, status, error) {
			console.error("getJSON failed, status: " + status + ", error: "+error)
			alert('서버와의 연결에 실패하였습니다.');
		});
	}
	
	function contextCallback(no, action) {
			if(action == "Accept") {
				requestAcceptJoin(no);
			} else {
				alert("you declined.");
			}
	}
	
	
	function requestAcceptJoin(_no) {		
		var requestData = {no:_no};
		$.getJSON('acceptJoin.jsp', requestData, function(data, status) {
			if( data.result == "true" ) {
				window.location.reload();
				return true;
			} else {
				alert("요청에 실패하였습니다.");
			}
			
		}).fail(function() {
			alert("죄송합니다 서버로의 연결에 실패하였습니다.");
			return false;
		});
		return false;
	}
	
	function requestDeclineJoin(_no) {
		var requestData = {no:_no};
		$.getJSON('declineJoin.jsp', requestData, function(data, status) {
			if( data.result == "true" ) {
				window.location.reload();
				return true;
			} else {
				alert("요청에 실패하였습니다.");
			}
			
		}).fail(function() {
			alert("죄송합니다 서버로의 연결에 실패하였습니다.");
			return false;
		});
		return false;
	}

	
</script>