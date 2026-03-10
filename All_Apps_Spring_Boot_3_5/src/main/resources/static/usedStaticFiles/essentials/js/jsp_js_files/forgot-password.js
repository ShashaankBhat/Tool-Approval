$(function() {
	var width = $( document ).width();
	if(width < 750) {
		width = width - 40
	} else {
		width = 400;
	}
	$("#loginPageDiv").width(width);
	clearInterval(myVar);
	$(".package-loader").hide();
});
$("#forgotPasswordForm").submit(function(e){
	var submitOrNot = true;
	if(emailValidation() == false) {
		submitOrNot = false;
	}
	console.log("submitOrNot : "+submitOrNot);
	if(submitOrNot) {
		return true;
	} else {
		return false;
	}
});
function emailValidation() {
	var email = $("#email").val().replace(/\s+/g, " ");
	$("#emailError").html("");
	$("#email").removeClass("is-valid");
	$("#email").removeClass("is-invalid");
	var validMailIdFormat = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
	var stringCheck = /^[a-z0-9_ ]*$/;
	if(email != "") {
		/*if(validMailIdFormat.test(email) == false) {*/
		/*if(stringCheck.test(email) == false) {
			$("#emailError").html("Username can be only lower-case alphabets only");
			return false;
		} else {
			return true;
		}*/
		return true;
	} else {
		$("#emailError").html("Enter your email id");
		return false;
	}
}
$("#email").focusout(function() {
	emailValidation();
});