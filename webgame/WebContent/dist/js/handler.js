function handler_auth(_key){

	$.getJSON('auth.jsp', {key:_key}, function(data, status){
		alert(data.msg);
		if(data.result == "true") {
			location.reload(true);
		}
	});
	
	return false;
}