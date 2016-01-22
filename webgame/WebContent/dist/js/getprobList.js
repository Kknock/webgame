$('.caption').click(function(e){
		
	var requestData = {prob_type:$(this).attr('probtype'),sessionId:$(this).attr('sessionId')};
	var no = "";
	var title = "";
	var score = "";
	var solve_chk = "";
	var probtype = $(this).attr('probtype');
	var format = "<h2>"+probtype+"</h2>"+
				"<hr class=\"star-primary\">"+
				"<div class=\"row\">";
	
	$.getJSON('getprobList.jsp', requestData, function(data, status){
		
		for(idx in data.probList){
			no = data.probList[idx].no;
			title = data.probList[idx].title;
			score = data.probList[idx].score;
			solve_chk = data.probList[idx].solve_chk;
			
			// 이미 푼 문제
			if(solve_chk=="F"){
				format += "<div class=\"col-sm-4 challenge-item\">" +
				"<a class=\"challenge-link2\" data-toggle=\"modal\">"+
				"<img src=\"dist/img/solved.png\"> "+
				"</a> </div>";		
			}
			// 풀지 못한 문제
			else{
				format += "<div class=\"col-sm-4 challenge-item\">" + 
				"<a href=\"#challengePage\" class=\"challenge-link2\" data-toggle=\"modal\">" + 
				"<div> " + title +
				"</div>" +
				"<img src=\'dist/img/"+score+".png\'\" class=\"prob\" probNum=\""+no+"\"/>"+
				//"<img src=\"dist/img/"+probtype+"/"+title+".png\" onmouseover=\"this.src=\'dist/img/"+score+".png\'\" onmouseout=\"this.src=\'dist/img/"+probtype+"/"+title+".png\'\" class=\"prob\" probNum=\""+no+"\"/> "+
				"</a> </div>";
			}
		}
		
		$("#challenge-list").empty(); // 문제를 나갔다 들어가면 이전에 클릭한 문제들이 쌓여서 같이 나오는 것을 막기 위해 비워줌
		$("#challenge-list").append(format);
		
	});
});