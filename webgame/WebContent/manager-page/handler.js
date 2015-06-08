$(function(){

	$(document).ready(init);
	$(window).on('hashchange', function() {
		hashChange();
		// on 메소드의 두번째 인자로 함수명 전달시 
		// onload와 동일하게 동작하므로 일단 이렇게 해둠.
	});
	$(window).on('load', function() {
		$(window).scrollTop(0);
		
		// 이벤트 등록
//		$('#formLogin').on('valid.fndtn.abide', login);
//		$('#formJoin').on('valid.fndtn.abide', join);
		
		hashChange("onLoad");
	});
	
})

function init() {

//  Initialize management menu


	/*
	$('#notice').empty().load("manager_page/notice_manage.html");
	$('#prob').empty().load("manager_page/problem_manage.html");
	$('#user').empty().load("manager_page/user_manage.html", function() {

		$.getScript("contextHandler.js").fail(function(jqxhr, settings, exception) {
			console.log(jqxhr, settings, exception);
		});
		
	});
	$('#hall').empty().load("hall_manage.html");
	*/
	
	/*document.getElementById("btn-notice").addEventListener("click", function(e) {
		alert(0);
	}, false);

	*/
 
 
}

function hashChange(caller) {
	
	
	var tag = window.location.hash.substr(1, window.location.hash.length);

	if( tag=="" && caller=="onLoad") {
		window.location.hash = "dashboard"
		window.location.reload();
		return ;
	}
	
	if( tag=="" ) {
		return ;
	}

	$('#page-wrapper').empty().load(tag + ".jsp", function() {
		
		// JAVA 7 이전버전에선 문자열에 대한 switch - case를 지원하지 않기에 동작하지 않는다.
		switch(tag) {
			case "dashboard":
				// Load Morris Charts JavaScript
				$.getScript("../bower_components/raphael/raphael-min.js");
				$.getScript("../bower_components/morrisjs/morris.min.js");
				$.getScript("../dist/js/morris-data.js");
				break;
			case "newUsers":
		    	$.getScript("../dist/js/contextHandler.js");
			case "oldUsers":
				
				//<!-- DataTables JavaScript -->
				//$.getScript("../bower_components/datatables/media/js/jquery.dataTables.min.js");
				//$.getScript("../bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js");
				// Page-Level Demo Scripts - Tables - Use for reference
				$('#dataTables-example').DataTable({
							responsive: true
				});
				break;
			default:
				break;
		}
		
	});	//web.xml을 통해 다른 이름으로 매핑하자.

}


function getProblemList() {
	$.getJSON('getProblem.jsp', function(data, status) {
		return data;
	}).fail(function() {
		return false;
	});	
}
	
function setProblemList(data) {

	for( idx in data.system ) {
		console.log(data.system[idx].con);
		
		var content = "";
		
		if( data.system[idx].solved == "y")
			content = '<li><a href="#" class="button success radius" num=';
		else 
			content = '<li><a href="#" class="button secondary radius" num=';
		
		content +=  data.system[idx].num + 
		'>'+ data.system[idx].con + '<br/>' + data.system[idx].point + '</a></li>'
		$("#SystemGrid").append(content);
		
		console.log(content);		
	}

}