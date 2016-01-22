$(document).on("click",".prob",function(){
	
	var requestData = {no:$(this).attr('probNum')};
	var title = "";
	var score = "";
	var content = "";

	$.getJSON('getProblem.jsp', requestData, function(data, status){
		
		for(idx in data.probList){
			title = data.probList[idx].title;
			score = data.probList[idx].score;
			content = data.probList[idx].content;
		}
		$("#challengeBody").empty(); // 문제를 나갔다 들어가면 이전에 클릭한 문제들이 쌓여서 같이 나오는 것을 막기 위해 비워줌
		$("#challengeBody").append(makeChallengeFormat(title, score, content));
	});
});

function makeChallengeFormat(title, score, content){
	
	var format = "<h2><center>"+title+" - "+score+"</center></h2>" +
			 "<hr class=\"star-primary\">" +
			 "<p><center>"+content+"</center></p>";
	
	return format;
}