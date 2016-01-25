
// 회원가입 시 실시간 중복 체크
function check_id_duplication(event) {

	var id = $(event.target).val();
	//alert(id);
	
	if(id.length == 0) {
		$("#duplicate").addClass("hidden");
		return ;
	}
	
	$.get('idDuplicationChecker.jsp', {'id':id}, function(data, status){
		
		if(data.trim() == "true") { //Duplicate
			$("#duplicateId").removeClass("hidden");
		} else {
			$("#duplicateId").addClass("hidden");
		}
		
	}).fail(function(jqxhr, textStatus, error) {
		alert(textStatus + ": " + error);
	});
}

function check_name_duplication(event) {

	var name = $(event.target).val();
	
	if(name.length == 0) {
		$("#duplicateName").addClass("hidden");
		return ;
	}
	
	$.get('nameDuplicationChecker.jsp', {'name':name}, function(data, status){
		
		if(data.trim() == "true") { //Duplicate
			$("#duplicateName").removeClass("hidden");
		} else {
			$("#duplicateName").addClass("hidden");
		}
		
	}).fail(function(jqxhr, textStatus, error) {
		alert(textStatus + ": " + error);
	});
}

$("input#id").on("keyup", check_id_duplication);
$("input#id").on("focucsout", check_id_duplication);

$("input#name").on("keyup", check_name_duplication);
$("input#name").on("focucsout", check_name_duplication);


function handler_auth(_key){

	$.getJSON('auth.jsp', {key:_key}, function(data, status){
		alert(data.msg);
		if(data.result == "true") {
			location.reload(true);
		}
	});
	
	return false;
}