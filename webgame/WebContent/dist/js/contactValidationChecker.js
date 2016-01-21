$(function () { 
	
	$("#contact").find("input").jqBootstrapValidation(
		{
		    //preventSubmit: true,
		    submitError: function($form, event, errors) {
		        // Here I do nothing, but you could do something like display 
		    	// the error messages to the user, log, etc.
		    	alert("가입이 실패했습니다.");
		    },
			submitSuccess: function($form, event) {
			    //alert("가입이 완료되었습니다.");
			    //event.preventDefault();
			}
		}
	);
	
});
