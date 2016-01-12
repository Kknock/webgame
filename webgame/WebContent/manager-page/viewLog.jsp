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

<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		</p> </p>
		<div class="panel panel-default">
			<div class="panel-heading">
				로그
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
			<a href="#" class="context-menu__link" data-action="Edit"><i class="fa  fa-check"></i> Edit</a>
		</li>
		<li class="context-menu__item">
			<a href="#" class="context-menu__link" data-action="Delete"><i class="fa fa-close"></i> Delete</a>
		</li>
	</ul>
</nav>

<script>

	function init() {
		$.getJSON('getLog.jsp', function(data, status) {
			/*
			 *	서버로부터 유저 데이터를 가져와 dataSet을 작성한다.
			*	가져오는 값은 다음과 같다. 회원번호, 아이디, 이름, 해결한 문제 수, 마지막 인증 시간.
			*/
			dataSet = []; 
			for( idx in data.logList ) {
				var name	 	= data.logList[idx].name;
				var auth		= data.logList[idx].auth;
				var time		= data.logList[idx].time;
				dataSet.push( [name, auth, time] );
			}			
			
			/*
			 *	dataSet을 이용해 DataTable을 작성한다.
			 *	"data" 속성의 값은 [ [td, td, td, ...], [td, td, td, ...], ... ] 형식이다. 
			*	"columns" 속성에서는 thead 값과, 그 속성을 결정한다.
			*/
			$('#dataTable').dataTable( {
		        "data": dataSet,
		        "columns": [
		            { "title": "닉네임" },
		            { "title": "인증값"},
		            { "title": "인증시간"},
		        ]
		    });
	
			
		}).fail(function(d, status, error) {
			console.error("getJSON failed, status: " + status + ", error: "+error)
			alert('서버와의 연결에 실패하였습니다.');
		});
	}	
</script>