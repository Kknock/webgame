$(function(){
	
	var save_time = "";
	var content = "";
	
	$.getJSON('getNotice.jsp', function(data, status){
		
		for(idx in data.noticeList){
			save_time = data.noticeList[idx].save_time;
			content = data.noticeList[idx].content;
			
			$("#noticeBody").append(makeNoticeFormat(save_time, content));
		}
		
		//$("#noticeBody").empty(); // 문제를 나갔다 들어가면 이전에 클릭한 문제들이 쌓여서 같이 나오는 것을 막기 위해 비워줌
		//("#noticeBody").append(makeNoticeFormat(save_time, content));
	});
});

function makeNoticeFormat(save_time, content){
	
	var format = "<p> ["+save_time+"] "+content+"</p>";
	
	return format;
}