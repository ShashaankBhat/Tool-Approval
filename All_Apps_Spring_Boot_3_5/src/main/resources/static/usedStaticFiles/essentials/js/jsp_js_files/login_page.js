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
	$(".emailForSSO").show();
	$(".passwordForSSO").hide();
	$(".passwordButton").hide();
	$(".ssoButton").hide();
	$('.select2').select2({
		theme: 'bootstrap4'
	});
    $("#userLoginId").val($("#emailTemp").val());
    $("#userFirstName").val($("#firstNameTemp").val());
    $("#userLastName").val($("#lastNameTemp").val());
});
$(".nextButton").click(function(e) {
	if(emailValidation() == false) {
		
	} else {
		$('body').addClass('disableClickBody');
		$(".package-loader").show();
		$.ajax({
			url:"checkForDomain",
			type: "GET",
			data:{'userEmailId':$("#email").val().replace(/\s+/g, " ")},
			success: function(result) {
				if(result == "none") {
					$(".passwordForSSO").show();
					$(".nextButton").hide();
					$(".ssoButton").hide();
					$(".passwordButton").show();
					$('body').removeClass('disableClickBody');
					$(".package-loader").hide();
				} else if(result == "error") {
					alert("Something went wrong, try again after sometime.")
					$('body').removeClass('disableClickBody');
					$(".package-loader").hide();
				} else {
					$(".passwordForSSO").hide();
					$(".nextButton").hide();
					$(".ssoButton").show();
					$(".passwordButton").hide();
					$("#singleSignOnButton").attr("onclick", 'window.location=""');
					$("#singleSignOnButton").attr("onclick", 'window.location="'+result+'"');
					$('body').removeClass('disableClickBody');
					$(".package-loader").hide();
				}
			},
			error:function() {
				$('body').removeClass('disableClickBody');
				$(".package-loader").hide();
				alert("Something went wrong, try again later.");
			}
		});
	}
});
$("#singleSignOnButton").click(function(e) {
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
});
$("#loginForm").submit(function(e){
	var submitOrNot = true;
	if(emailValidation() == false) {
		submitOrNot = false;
	}
	if(passwordValidation() == false) {
		submitOrNot = false;
	}
	console.log("submitOrNot : "+submitOrNot);
	if(submitOrNot) {
		return true;
	} else {
		return false;
	}
});
$("#loginFormSignUp").submit(function(e){
	var submitOrNot = true;
	if(emailValidation() == false) {
		submitOrNot = false;
	}
	if(passwordValidation() == false) {
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
function passwordValidation() {
	var passwordCheck_v3 = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,15}$/;
	var password = $("#password").val().replace(/\s+/g, " ");
	$("#passwordError").html("");
	$("#password").removeClass("is-valid");
	$("#password").removeClass("is-invalid");
	if(password != "") {
		return true;
	} else {
		$("#passwordError").html("Enter your password.");
		return false;
	}
}
$("#password").focusout(function() {
	passwordValidation();
});