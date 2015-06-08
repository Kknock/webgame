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
				Problem database
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



<script>

	$(function(){
		
		$.getJSON('../getUserList.jsp', function(data, status) {
			
			
			
			/*
				서버로부터 유저 데이터를 가져와 dataSet을 작성한다.
				가져오는 값은 다음과 같다. 회원번호, 아이디, 이름, 해결한 문제 수, 마지막 인증 시간.
			*/
			dataSet = []; 
			for( idx in data.userList ) {
				var no 		= data.userList[idx].no;
				var id 		= data.userList[idx].id;
				var name	= data.userList[idx].name;
				var solved	= "undef";
				//var last_auth	= data.userList[idx].last_auth;
				var last_auth	= "그 때 그시절";
				
				dataSet.push( [no, id, name, solved, last_auth] );
			}			
			
			/*
				dataSet을 이용해 DataTable을 작성한다.
				"data" 속성의 값은 [ [td, td, td, ...], [td, td, td, ...], ... ] 형식이다. 
				"columns" 속성에서는 thead 값과, 그 속성을 결정한다.
			*/
			$('#dataTable').dataTable( {
		        "data": dataSet,
		        "columns": [
		            { "title": "#" },
		            { "title": "아이디" },
		            { "title": "닉네임" },
		            { "title": "해결한 문제" },
		            { "title": "마지막 인증", "class": "center" },
		        ]
		    } );
			
		}).fail(function(d, status, error) {
			console.error("getJSON failed, status: " + status + ", error: "+error)
			alert('서버와의 연결에 실패하였습니다.');
		});	
		
	})

</script>